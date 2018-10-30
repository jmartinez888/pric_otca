<?php

use App\ODifusion;
use App\ODifusionBanners;
use App\ODifusionLinkInteres;

class indexController extends Controller
{
    //private $_inicio;
    private $_pagina;
    private $_dublinModel;
    private $_foroModel;
    private $_recursoModel;
    private $_jsonBusqueda;

    public function __construct($lang, $url)
    {
        parent::__construct($lang, $url);
        // $this->_pagina = $this->loadModel('index', 'arquitectura');
    }

    public function index($idPagina = 5)
    {
        if ($idPagina == 5)
        {
            // $this->_view->getLenguaje("template_frontend");
            // Cookie::set('idioma', 1);
            // dd(ODifusion::eventos_interes()->get());
            // $data['interes_evento'] = ODifusion::eventos_interes()->limit(5)->get();
            // $data['interes_datos'] = ODifusion::datos_interes()->limit(5)->get();
            $data['banners'] = ODifusionBanners::all()->map(function($item) {
                return [
                    'backgroundImage' => BASE_URL.'files/difusion/banner/'.$item->ODib_IdDifBanner.'/'.$item->ODib_Banner,
                    'thumbnail' => BASE_URL.'files/difusion/banner/'.$item->ODib_IdDifBanner.'/'.$item->ODib_Banner,
                    'credit' => $item->ODib_Descripcion,
                    'categoria' => $item->difusion->tipo->ODit_Tipo,
                    'headline' => $item->ODib_Descripcion,
                    'href' => BASE_URL.Cookie::lenguaje().'/difusion/contenido/'.$item->difusion->ODif_IdDifusion,
                    'storyTitle' => $item->ODib_Titulo
                ];
                // return $item;
            })->toJson();
            // $data['links_interes'] = ODifusionLinkInteres::activos()->limit(5)->get();
            $this->_view->setTemplate(LAYOUT_FRONTEND);
            // $this->_view->setJs(array(
            //       "js", array('https://maps.googleapis.com/maps/api/js?key=AIzaSyBM7aMHbWEPvofhwPQuKPnijDmQ0_AAkrI', true)   ));
            $this->_view->addViews('modules'.DS.'difusion'.DS.'views'.DS.'contenido'.DS);
            $this->_view->assign('titulo', 'Bienvenido a la PRIC');
            $this->_view->assign($data);
            // $this->_view->renderizar('inicio', 'inicio');
            $this->_view->render('iniciotemp');
        }
        else
        {
            // $this->_acl->autenticado();
            $this->validarUrlIdioma();
            $this->_view->setTemplate(LAYOUT_FRONTEND);
            $this->_view->getLenguaje("index_inicio");
            $this->_view->setJs(array('index'));
            $condicion1 = '';
            $id = $this->filtrarInt($idPagina);
// echo Cookie::lenguaje();
            $condicion1 .= " WHERE pa.Pag_Estado = 1 AND pa.Pag_IdPagina = $id ";
            $datos = $this->_pagina->getPaginaTraducida($condicion1, Cookie::lenguaje());


            //MenuRaiz
            if ($id>1)
            {
                $padre = "";
                $arbolRaiz = $this->_pagina->getMenusRaiz($datos['Pag_TipoPagina'],$id);
                if(!empty($arbolRaiz) && count($arbolRaiz)){
                    if (!empty($arbolRaiz[0])) {
                        $padre = $this->getRaizPadre($arbolRaiz);
                    }
                }
                $arrayRaiz = array_reverse(explode("::", $padre));
                $arrayRaiz = array_chunk($arrayRaiz, 1);
                $this->_view->assign('menuRaiz', $arrayRaiz);
            }
            //FIn Menu Raiz

            $this->_view->assign('datos', $datos);
            $this->_view->assign('titulo', $datos['Pag_Nombre']);
            $this->_view->renderizar('index');
        }
    }
    public function getRaizPadre($arbolRaiz,$padreI = true)
    {
        $padre = "";
        //print_r($arbolRaiz);
        $href = $arbolRaiz[0]['Pag_IdPagina'];
        $Pag_Nombre = $arbolRaiz[0]['Pag_Nombre'];
        if ($padreI)
        {
            $raiz = " <li>/</li><li> <a class='actual'>".$Pag_Nombre." </a> </li> :: ";
            $padre .= $raiz;
        }
        else
        {
            $raiz = " <li>/</li><li> <a href='".BASE_URL."index/index/".$href."'>".$Pag_Nombre." </a> </li> :: ";
            $padre .= $raiz;
        }

        //echo $padre."0000000000000000000000000000000";
        for ($i = 0; $i < count($arbolRaiz); $i++)
        {
            if (!empty($arbolRaiz[$i]["padre"]))
            {
                $raizPadre = $arbolRaiz[$i]["padre"];
                $temph = $this->getRaizPadre($raizPadre,false);
                $padre .= $temph;
            }
        }
        return $padre;
    }

    public function _loadLang($lang)
    {
        Cookie::setLenguaje($lang);
        if (isset($_SERVER['HTTP_REFERER']))
        {
            $ruta_anterior = $_SERVER['HTTP_REFERER'];
            $antLang = Cookie::antlenguaje();
            $ok = FALSE;
            $ruta = "";
            $ruta_anterior = explode('/', $ruta_anterior);

            foreach ($ruta_anterior as $value)
            {
                if ($ok)
                {
                    $ruta = $ruta . $value . "/";
                }
                if ($value == $antLang)
                {
                    $ok = true;
                }
            }

            $ruta = substr($ruta, 0, strlen($ruta) - 1);
            //echo $ruta;
            $this->redireccionar($ruta);
        }
        else
            $this->redireccionar();
    }

    public function buscarPalabra($palabraBuscada = false, $tipoRegistro = false, $pais = "all", $json = false)
    {
        // $this->_acl->autenticado();
        //$pais="";
        //$pais = $this->getPostParam('pais');
        if (!$json )
        {
            $this->validarUrlIdioma();
            $this->_view->setTemplate(LAYOUT_FRONTEND);
            $this->_view->setJs(array('index'));
            $this->_view->setCss(array('buscar', 'jp-buscar'));
            //$palabraBuscada=$palabra;}
        }

        $this->_view->getLenguaje("index_inicio");
        $this->_view->getLenguaje("index_buscador");

        $tipoRegistro = $this->filtrarInt($tipoRegistro);
        $this->_dublinModel = $this->loadModel('documentos', 'dublincore');
        $this->_foroModel = $this->loadModel('index', 'foro');
        $this->_cursoModel = $this->loadModel('curso', 'elearning');
        $this->_recursoModel = $this->loadModel('bdrecursos');
        $filtroTipo = "all";

        if ($palabraBuscada=='all')
        {
            $palabra = 'all';
            $palabraBuscada = '';
        }
        else
        {
            $palabra = $palabraBuscada;
        }

        $ip = $_SERVER['REMOTE_ADDR'];
        $r = $this->_recursoModel->registrarBusqueda($palabra, $ip, '');
        //CUENTA EL NUMERO DE PALABRAS
        $trozosPalabra = explode(" ",$palabraBuscada);
        $numero = count($trozosPalabra);

        if($pais=='all')
        {
            $condicionDublinPais = "";
            if ($numero == 1) {
                //SI SOLO HAY UNA PALABRA DE BUSQUEDA SE ESTABLECE UNA INSTRUCION CON LIKE
                $listaCurso = $this->_cursoModel->getCursoBusqueda($palabraBuscada);
                $condicionDublin = " WHERE Dub_Estado = 1 AND (Dub_Titulo LIKE '%".$palabraBuscada."%' OR Dub_Descripcion LIKE '%".$palabraBuscada."%' OR Dub_PalabraClave LIKE '%".$palabraBuscada."%' OR Aut_Nombre LIKE '%".$palabraBuscada."%')";
                $condicionForo = " WHERE f.For_Titulo LIKE '%".$palabraBuscada."%' OR f.For_Resumen LIKE '%".$palabraBuscada."%' OR f.For_Descripcion LIKE '%".$palabraBuscada."%' OR f.For_PalabrasClaves LIKE '%".$palabraBuscada."%' ";

                // $condicionLegal = " WHERE Mal_Estado = 1 AND (Mal_Titulo LIKE '%$palabraBuscada%' OR Mal_PalabraClave LIKE '%$palabraBuscada%' OR Mal_ResumenLegislacion LIKE '%$palabraBuscada%' OR Mal_Entidad LIKE '%$palabraBuscada%') ";
                $OrderByDublin = " ORDER BY dub.Dub_Titulo ";
                $OrderByForo = " ORDER BY f.For_Titulo ASC ";
                // $OrderByForo = " ORDER BY MATCH(Mal_Titulo, Mal_PalabraClave, Mal_ResumenLegislacion, Mal_Entidad) AGAINST ('%".$palabraBuscada."%' IN BOOLEAN MODE) DESC ";
            } elseif ($numero > 1) {
                //SI HAY UNA FRASE SE UTILIZA EL ALGORTIMO DE BUSQUEDA AVANZADO DE MATCH AGAINST
                //busqueda de frases con mas de una palabra y un algoritmo especializado


                $listaCurso = $this->_cursoModel->getCursoBusquedaMath($palabraBuscada);

                $condicionDublin = " WHERE Dub_Estado = 1 AND (MATCH(Dub_Titulo, Dub_Descripcion, Dub_PalabraClave) AGAINST ('%".$palabraBuscada."%' IN BOOLEAN MODE) OR MATCH(Aut_Nombre) AGAINST ('%".$palabraBuscada."%' IN BOOLEAN MODE)) ";
                $condicionForo = " WHERE MATCH(f.For_Titulo, f.For_Resumen, f.For_Descripcion, f.For_PalabrasClaves) AGAINST ('%".$palabraBuscada."%' IN BOOLEAN MODE) ";
                // $condicionLegal = " WHERE Mal_Estado = 1 AND (MATCH(Mal_Titulo, Mal_PalabraClave, Mal_ResumenLegislacion, Mal_Entidad) AGAINST ('%".$palabraBuscada."%' IN BOOLEAN MODE)) ";
                $OrderByDublin = " ORDER BY MATCH(Dub_Titulo, Dub_Descripcion, Dub_PalabraClave) AGAINST ('%".$palabraBuscada."%' IN BOOLEAN MODE) OR MATCH(Aut_Nombre) AGAINST ('%".$palabraBuscada."%' IN BOOLEAN MODE) DESC";
                $OrderByForo = " ORDER BY  MATCH(f.For_Titulo, f.For_Resumen, f.For_Descripcion, f.For_PalabrasClaves) AGAINST ('%".$palabraBuscada."%' IN BOOLEAN MODE) DESC ";
            }
            //$condicionDublin = " WHERE Dub_Estado = 1 AND (Dub_Titulo LIKE '%$palabraBuscada%' OR Dub_Descripcion LIKE '%$palabraBuscada%' OR Dub_PalabraClave LIKE '%$palabraBuscada%' OR Aut_Nombre LIKE '%$palabraBuscada%')";
            //$MatchDublin = ", MATCH(Dub_Titulo, Dub_Descripcion, Dub_PalabraClave, Aut_Nombre) AGAINST ('".$palabraBuscada."') AS Criterio ";
        }
        else
        {
            $condicionDublinPais = " WHERE d.Pai_Nombre = '$pais' ";
            if ($numero == 1) {
                //SI SOLO HAY UNA PALABRA DE BUSQUEDA SE ESTABLECE UNA INSTRUCION CON LIKE
                $condicionPagina = " WHERE pa.Pag_Estado = 1 AND (pa.Pag_Nombre LIKE '%$palabraBuscada%' OR pa.Pag_Descripcion LIKE '%$palabraBuscada%' OR pa.Pag_Contenido LIKE '%$palabraBuscada%' )";
                $condicionDublin = " WHERE Pai_Nombre = '$pais' AND Dub_Estado = 1 AND (Dub_Titulo LIKE '%$palabraBuscada%' OR Dub_Descripcion LIKE '%$palabraBuscada%' OR Dub_PalabraClave LIKE '%$palabraBuscada%' OR Aut_Nombre LIKE '%$palabraBuscada%')";
                $condicionLegal = " WHERE Pai_Nombre = '$pais' AND Mal_Estado = 1 AND (Mal_Titulo LIKE '%$palabraBuscada%' OR Mal_PalabraClave LIKE '%$palabraBuscada%' OR Mal_ResumenLegislacion LIKE '%$palabraBuscada%' OR Mal_Entidad LIKE '%$palabraBuscada%') ";
            } elseif ($numero > 1) {
                //SI HAY UNA FRASE SE UTILIZA EL ALGORTIMO DE BUSQUEDA AVANZADO DE MATCH AGAINST
                //busqueda de frases con mas de una palabra y un algoritmo especializado
                $condicionPagina = " WHERE pa.Pag_Estado = 1 AND (MATCH(pa.Pag_Nombre, pa.Pag_Descripcion, pa.Pag_Contenido) AGAINST ('%".$palabraBuscada."%' IN BOOLEAN MODE)) ";
                $condicionDublin = " WHERE Pai_Nombre = '$pais' AND Dub_Estado = 1 AND (MATCH(Dub_Titulo, Dub_Descripcion, Dub_PalabraClave) AGAINST ('%".$palabraBuscada."%' IN BOOLEAN MODE) OR MATCH(Aut_Nombre) AGAINST ('".$palabraBuscada."' IN BOOLEAN MODE)) ";
                $condicionLegal = " WHERE Pai_Nombre = '$pais' AND Mal_Estado = 1 AND (MATCH(Mal_Titulo, Mal_PalabraClave, Mal_ResumenLegislacion, Mal_Entidad) AGAINST ('%".$palabraBuscada."%' IN BOOLEAN MODE)) ";
                $OrderByDublin = " ORDER BY MATCH(Dub_Titulo, Dub_Descripcion, Dub_PalabraClave) AGAINST ('%".$palabraBuscada."%' IN BOOLEAN MODE) OR MATCH(Aut_Nombre) AGAINST ('%".$palabraBuscada."%' IN BOOLEAN MODE) DESC";
                $OrderByForo = " ORDER BY MATCH(Mal_Titulo, Mal_PalabraClave, Mal_ResumenLegislacion, Mal_Entidad) AGAINST ('%".$palabraBuscada."%' IN BOOLEAN MODE) DESC ";

            }
            //echo $pais."/".$palabra;
        }

        $idioma = Cookie::lenguaje();

        $listaDublin = $this->_dublinModel->getDocumentosPaises($condicionDublin, $idioma, $OrderByDublin);
        $listaForo = $this->_foroModel->getForosSearch($condicionForo.$OrderByForo);
        $listaRecurso = $this->_recursoModel->getRecursoBusquedaTraducido($palabraBuscada, $idioma);
        //print_r($listaForoPaises);exit;

        //Paises
        // $listaDublinPaises = $this->_dublinModel->getCantDocumentosPaises($condicionDublin,$idioma);
        // $listaForoPaises = $this->_foroModel->getCantidadLegislacionPaisV2($condicionLegal,$idioma);
        //$listaForoPaises = $this->_foroModel->getCantLegislacionesPais($condicionLegal,$idioma);
        //$listaForoPaises = $this->_recursoModel->getCantidadDocumentosPaises($condicionDublin);
       /* echo count($listaForoPaises);
        print_r($listaForoPaises);
        print_r($listaDublinPaises);*/

        // $listaPaisTotales = array();

        // for ($i = 0; $i <= count($listaDublinPaises); $i++)
        // {
        //    // echo $i;echo $listaDublinPaises[$i]['cantidad'];
        //     for ($j = 0; $j <= count($listaForoPaises); $j++)
        //     {
        //       //  echo $j;
        //         if(isset($listaDublinPaises[$i]) && isset($listaForoPaises[$j]) )
        //         {
        //             if($listaDublinPaises[$i]['Pai_Nombre'] == $listaForoPaises[$j]['Pai_Nombre'] )
        //             {
        //                 $listaPaisTotales[$i]['cantidad'] = $listaDublinPaises[$i]['cantidad'] + $listaForoPaises[$j]['cantidad'];
        //                 $listaPaisTotales[$i]['Pai_Nombre'] = $listaDublinPaises[$i]['Pai_Nombre'];
        //            // echo $listaPaisTotales[$i]['cantidad'];

        //             }
        //         }

        //     }
        // }

        //Fin Paises

        $cantPagina = count($listaCurso);
        $cantDublin = count($listaDublin);
        $cantForo = count($listaForo);
        $cantRecurso = count($listaRecurso);
        $listaBusqueda = array();
        $listaBus = array();

        if (!$tipoRegistro)
        {
            if (!$json)
            {
                foreach ($listaCurso as $arra1)
                {
                    // echo $arra['Pag_Nombre'];   exit;
                    array_push($listaBusqueda, $arra1['Cur_IdCurso'], $arra1['Cur_Titulo'], substr($arra1['Cur_Descripcion'], 0, 200), 'elearning/cursos/curso/', 1, '', '', '', $arra1['Idi_IdIdioma']);
                    array_push($listaBus, $listaBusqueda);
                    $listaBusqueda = array();
                }
            }

            foreach ($listaDublin as $arra2)
            {
                // echo $arra['Pag_Nombre'];   exit;
                array_push($listaBusqueda, $arra2['Dub_IdDublinCore'], $arra2['Dub_Titulo'], substr($arra2['Dub_Descripcion'], 0, 200), 'dublincore/documentos/metadata/', 2, $arra2['Arf_PosicionFisica'], $arra2['Arf_IdArchivoFisico'], $arra2['Taf_Descripcion'], $arra2['Idi_IdIdioma']);
                array_push($listaBus, $listaBusqueda);
                $listaBusqueda = array();
            }
            foreach ($listaForo as $arra3)
            {
                // echo $arra['Pag_Nombre'];   exit;
                array_push($listaBusqueda, $arra3['For_IdForo'], $arra3['For_Titulo'], substr($arra3['For_Resumen'], 0, 200), 'foro/index/ficha/', 3, '', '', '', $arra3['Idi_IdIdioma']);
                array_push($listaBus, $listaBusqueda);
                $listaBusqueda = array();
            }
            foreach ($listaRecurso as $arra4)
            {
                // echo $arra['Pag_Nombre'];   exit;
                array_push($listaBusqueda, $arra4['Rec_IdRecurso'], $arra4['Rec_Nombre'], substr($arra4['Rec_Descripcion'], 0, 200), 'bdrecursos/metadata/index/', 4, '', '', '', $arra4['Idi_IdIdioma']);
                array_push($listaBus, $listaBusqueda);
                $listaBusqueda = array();
            }
        }
        else
        {
            if ($tipoRegistro == 1)
            {
                foreach ($listaCurso as $arra1)
                {
                    // echo $arra['Pag_Nombre'];   exit;
                    array_push($listaBusqueda, $arra1['Cur_IdCurso'], $arra1['Cur_Titulo'], substr($arra1['Cur_Descripcion'], 0, 200), 'elearning/cursos/curso/', 1, '', '', '', $arra1['Idi_IdIdioma']);
                    array_push($listaBus, $listaBusqueda);
                    $listaBusqueda = array();
                }

                $filtroTipo = 'Base de Datos Cursos';
                // for ($j = 0; $j <= count($listaPaisTotales); $j++)
                // {
                //   //  echo $j;
                //     if(isset($listaPaisTotales[$j]))
                //     {
                //         $listaPaisTotales[$j]['cantidad'] = 0;
                //     }
                // }
            }
            else
            {
                if ($tipoRegistro == 2)
                {
                    foreach ($listaDublin as $arra2)
                    {
                        // echo $arra['Pag_Nombre'];   exit;
                        array_push($listaBusqueda, $arra2['Dub_IdDublinCore'], $arra2['Dub_Titulo'], substr($arra2['Dub_Descripcion'], 0, 200), 'dublincore/documentos/metadata/', 2, $arra2['Arf_PosicionFisica'], $arra2['Arf_IdArchivoFisico'], $arra2['Taf_Descripcion'], $arra2['Idi_IdIdioma']);
                        array_push($listaBus, $listaBusqueda);
                        $listaBusqueda = array();
                    }

                    $filtroTipo = 'Base de Datos de Documentos';
                    // $listaPaisTotales = $listaDublinPaises;
                }
                else
                {
                    if ($tipoRegistro == 3)
                    {
                        foreach ($listaForo as $arra3)
                        {
                            // echo $arra['Pag_Nombre'];   exit;
                            array_push($listaBusqueda, $arra3['For_IdForo'], $arra3['For_Titulo'], substr($arra3['For_Resumen'], 0, 200), 'foro/index/ficha/', 3, '', '', '', $arra3['Idi_IdIdioma']);
                            array_push($listaBus, $listaBusqueda);
                            $listaBusqueda = array();
                        }

                        $filtroTipo = 'Base de Datos Foro';
                        // $listaPaisTotales = $listaForoPaises;
                    }
                    else
                    {
                        if ($tipoRegistro == 4)
                        {
                            foreach ($listaRecurso as $arra4)
                            {
                                // echo $arra['Pag_Nombre'];   exit;
                                array_push($listaBusqueda, $arra4['Rec_IdRecurso'], $arra4['Rec_Nombre'], substr($arra4['Rec_Descripcion'], 0, 200), 'bdrecursos/metadata/index/', 4, '', '', '', $arra4['Idi_IdIdioma']);
                                array_push($listaBus, $listaBusqueda);
                                $listaBusqueda = array();
                            }

                            $filtroTipo = 'Base de Datos de Recursos';
                            // for ($j = 0; $j <= count($listaPaisTotales); $j++)
                            // {
                            //   //  echo $j;
                            //     if(isset($listaPaisTotales[$j]))
                            //     {
                            //         $listaPaisTotales[$j]['cantidad'] = 0;
                            //     }
                            // }
                        } else {
                            $filtroTipo = 'all';
                        }
                    }
                }
            }
        }

        $idiomas = $this->_dublinModel->getIdiomas();
        //echo $listaBus[0][0].'////55555555';
        // print_r($listaBus);  // exit;
        $cantTotal = count($listaBus);
        $registros = $this->getInt('registros');
        $_SESSION['resultado'] = $listaBus;
        if ($json == 1) {
            //print_r($listaBus);
            return $listaBus;
        }
        //$this->_jsonBusqueda = $listaBus;
        unset($listaBus);
        $paginador = new Paginador();
        $this->_view->assign('resultadoBusqueda', $paginador->paginar($_SESSION['resultado'], "ResultadoBusqueda", "", false, CANT_REG_PAG));
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('cantidadporpagina', $registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax'));
        $this->_view->assign('cantTotal', $cantTotal);
        $this->_view->assign('palabra1', $palabra);
        $this->_view->assign('palabra', $palabraBuscada);
        $this->_view->assign('tipoRegistro', $tipoRegistro);

        if ($palabraBuscada != 'all') {
            $this->_view->assign('palabrabuscada', $palabraBuscada);
        }
        if ($filtroTipo != 'all') {
            $this->_view->assign('filtroTipo', $filtroTipo);
        }
        if ($pais != 'all') {
            $this->_view->assign('filtroPais', $pais);
        }

        // $this->_view->assign('paises', $listaPaisTotales );
        $this->_view->assign('idiomas', $idiomas);
        $this->_view->assign('cantPagina', $cantPagina);
        $this->_view->assign('cantDublin', $cantDublin);
        $this->_view->assign('cantForo', $cantForo);
        $this->_view->assign('cantRecurso', $cantRecurso);
        $this->_view->assign('titulo', 'Resultado de Búsqueda');

        $this->_view->renderizar('buscar');

        //$this->_view->renderizar('ajax/ResultadoBusqueda', false, true);

    }
    /*
    public function _buscarPorPais() {
        $palabra = $this->getSql('palabra');
        $variables = $this->getSql('variables');

        $paginador = new Paginador();

        $this->_view->setJs(array('documentos'));

        $this->_view->assign('documentos', $paginador->paginar($this->_documentos->getDocumentosPaises($condicion,$idioma),"paginar","", $pagina,$registro));
        $paginador = new Paginador();
        $this->_view->assign('resultadoBusqueda', $paginador->paginar($_SESSION['resultado'], "ResultadoBusqueda", "", false, 25));
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('cantidadporpagina', $registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax'));
        $this->_view->assign('cantTotal', $cantTotal);
        $this->_view->assign('palabra1', $palabra);
        $this->_view->assign('palabra', $palabraBuscada);
        $this->_view->assign('tipoRegistro', $tipoRegistro);
        $this->_view->assign('idiomas', $idiomas);
        $this->_view->assign('cantPagina', $cantPagina);
        $this->_view->assign('cantDublin', $cantDublin);
        $this->_view->assign('cantLegal', $cantForo);
        $this->_view->assign('cantRecurso', $cantRecurso);
        $this->_view->assign('titulo', 'Resultado de Búsqueda');
        $this->_view->renderizar('buscar');
    }*/

    public function _paginacion_ResultadoBusqueda()
    {
        $paginador = new Paginador();
        $this->_dublinModel = $this->loadModel('documentos', 'dublincore');
        $this->_view->getLenguaje("index_inicio");
        $this->_view->getLenguaje("index_buscador");
        $registros = $this->getInt('registros');
        $pagina = $this->getPostParam('pagina');
        $idiomas = $this->_dublinModel->getIdiomas();
        //echo $pagina;
        $this->_view->assign('resultadoBusqueda', $paginador->paginar($_SESSION['resultado'], "ResultadoBusqueda", "", $pagina, CANT_REG_PAG));
        $this->_view->assign('idiomas', $idiomas);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('cantidadporpagina', $registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax'));
        $this->_view->renderizar('ajax/ResultadoBusqueda', false, true);
    }

    public function _getJsonResultadoBusqueda($palabraBuscada = false, $tipoRegistro = false)
    {
        header('content-type: application/json; charset=utf-8');
        header("access-control-allow-origin: *");
        $resultado = $this->buscarPalabra($palabraBuscada, $tipoRegistro, 1);
        //$resultado = $this->_jsonBusqueda;
        //print_r($resultado);
        echo json_encode($this->utf8_converter_array($resultado));
    }
    public function _getJsonIdiomas()
    {
        header('content-type: application/json; charset=utf-8');
        header("access-control-allow-origin: *");
        $idiomas = $this->_dublinModel->getIdiomas();
        //$resultado = $this->_jsonBusqueda;

        echo json_encode($this->utf8_converter_array($idiomas));
    }

    public function _getLang()
    {
        echo Cookie::lenguaje();
    }

}

?>