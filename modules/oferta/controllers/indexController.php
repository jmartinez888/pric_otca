<?php

class indexController extends ofertaController
{
    private $_inst;
	
	public function __construct($lang, $url) {
        parent::__construct($lang, $url);
        $this->_inst=$this->loadModel('instituciones');
    }

    public function index() {
    	$this->validarUrlIdioma();
        $this->_view->getLenguaje("oferta_index");
        $this->_view->setCss(array("jp-index"));
        $this->_view->setJs(array('index'));
        $idioma = Cookie::lenguaje();

        $nombre = $this->getSql('nombre');
        $pagina = $this->getInt('pagina');
        $paginador = new Paginador();

        $arrayRowCount = $this->_inst->getInstitucionesRowCount();
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        $this->_view->assign('paises', $this->_inst->getPaises($idioma));
        $this->_view->assign('numeracion', 0);
        $this->_view->assign('totalRegistros', 0);
        $this->_view->assign('cantidad', $totalRegistros);
        $lista=$this->_inst->getInstitucionesConCantOferta(0,CANT_REG_PAG);
        $lista2=$this->_inst->getInstitucionesConCantInv(0,CANT_REG_PAG);
        
        $paginador->paginar( $totalRegistros,"listarInstituciones", "", $pagina, CANT_REG_PAG, true);
        $resumen1 = $this->_inst->getResumenInstituciones('',$idioma);

        $resumen2 = $this->_inst->getResumenProyectos('','',$idioma);
        $resumen3 = $this->_inst->getResumenOfertas('','',$idioma);
        $rowcount2a = $this->_inst->getResumenProyectosRowCount();
        $rowcount2 = $rowcount2a['CantidadRegistros'];
        $rowcount3a = $this->_inst->getResumenOfertasRowCount();
        $rowcount3 = $rowcount3a['CantidadRegistros'];
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->assign('resumen1', $resumen1);
        $this->_view->assign('resumen2', $resumen2);
        $this->_view->assign('resumen3', $resumen3);
        $this->_view->assign('rowcount2', $rowcount2);
        $this->_view->assign('rowcount3', $rowcount3);
        $this->_view->assign('listaIns', $lista);
        $this->_view->assign('lista2', $lista2);
        $this->_view->assign('titulo', 'Instituciones');
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->renderizar('index');
    }
    public function _paginacion_listarInstituciones($txtBuscar = false) 
    {
     
        $this->_view->getLenguaje("oferta_index");
        $idioma = Cookie::lenguaje();
        
        if($txtBuscar=="all"){$txtBuscar="";}
        //Variables de Ajax_JavaScript
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        $totalRegistros = $this->getInt('total_registros');
        $paginador = new Paginador();
        if (!$filas) {
            $filas = CANT_REG_PAG;
        } 
        if($pagina==0){
            $numeracion=0;
        }else{
            $numeracion=($pagina-1)*$filas;    
        }

        $this->_view->setJs(array('index'));
        $paginador->paginar( $totalRegistros,"listarInstituciones", "$txtBuscar", $pagina, $filas, true);
        $this->_view->assign('numeracion', $numeracion);
        // $paginador->paginar( $totalRegistros,"listarInstituciones", "$txtBuscar", $pagina, CANT_REG_PAG, true);
        $this->_view->assign('listaIns', $this->_inst->getBusquedaGeneral($pagina,$filas,$txtBuscar,$idioma));
        $listaO=$this->_inst->getInstitucionesConCantOfertaSinPaginar();
        $this->_view->assign('listaO', $listaO);
        $this->_view->assign('busqueda', 'Si');
        $this->_view->assign('palabra_buscada', $txtBuscar);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('titulo', 'Instituciones');
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarInstituciones', false, true);
    }
    public function buscarporpalabras($dato = '')
    {
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("oferta_index");
        $idioma = Cookie::lenguaje();
        if($dato=="all"){$dato="";}
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        // $this->_view->assign('paises', $this->_inst->getPaises($idioma));
        $arrayRowCount = $this->_inst->getBusquedaGeneralRowCount($dato);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];  
        $this->_view->assign('cantidadResultados', $totalRegistros);
        $this->_view->setJs(array('index'));
        $paginador = new Paginador();
            if($pagina==0){
                $numeracion=0;
            }else{
                $numeracion=($pagina-1)*CANT_REG_PAG;    
            }
        $this->_view->assign('titulo', 'Instituciones');
        $paginador->paginar( $totalRegistros,"listarInstituciones", "$dato", $pagina, CANT_REG_PAG, true);
        $this->_view->assign('listaIns', $this->_inst->getBusquedaGeneral($pagina,CANT_REG_PAG,$dato,$idioma));
        $listaO=$this->_inst->getInstitucionesConCantOfertaSinPaginar();
        $this->_view->assign('listaO', $listaO);
        $this->_view->assign('numeracion', $numeracion);
        $this->_view->assign('busqueda', 'Si');
        $this->_view->assign('palabra_buscada', $dato);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $condicion1 = " INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
    INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais
    WHERE i.Ins_Nombre LIKE '%".$dato."%'
    OR p.Pai_Nombre LIKE '%".$dato."%'
    OR u.Ubi_Sede LIKE '%".$dato."%'
    OR i.Ins_Tipo LIKE '%".$dato."%'";
    $condicion2 = " INNER JOIN institucion i ON i.Ins_IdInstitucion = o.Ins_IdInstitucion INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
    INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais ";
    $condicion3 = " AND  i.Ins_Nombre LIKE '%".$dato."%' 
    OR o.TipoRecurso='Investigacion' AND p.Pai_Nombre LIKE '%".$dato."%' 
    OR o.TipoRecurso='Investigacion' AND u.Ubi_Sede LIKE '%".$dato."%' 
    OR o.TipoRecurso='Investigacion' AND i.Ins_Tipo LIKE '%".$dato."%' ";
    $rowcount2a = $this->_inst->getResumenProyectosRowCount($condicion2,$condicion3);
        $rowcount2 = $rowcount2a['CantidadRegistros'];

        $condicion4 = " AND  i.Ins_Nombre LIKE '%".$dato."%' 
    OR o.TipoRecurso='Oferta' AND p.Pai_Nombre LIKE '%".$dato."%' 
    OR o.TipoRecurso='Oferta' AND u.Ubi_Sede LIKE '%".$dato."%' 
    OR o.TipoRecurso='Oferta' AND i.Ins_Tipo LIKE '%".$dato."%' ";

        $rowcount3a = $this->_inst->getResumenOfertasRowCount($condicion2,$condicion4);
        $rowcount3 = $rowcount3a['CantidadRegistros'];

        $resumen2 = $this->_inst->getResumenProyectos($condicion2,$condicion3,$idioma);
        $resumen1 = $this->_inst->getResumenInstituciones($condicion1,$idioma);
        $resumen3 = $this->_inst->getResumenOfertas($condicion2,$condicion4,$idioma);
        $this->_view->assign('resumen1', $resumen1);
        $this->_view->assign('resumen2', $resumen2);
        $this->_view->assign('resumen3', $resumen3);
        $this->_view->assign('rowcount2', $rowcount2);
        $this->_view->assign('rowcount3', $rowcount3);
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->setCss(array("jp-index"));
        $this->_view->renderizar('index','index');
    }
    public function buscarportematica($dato = '')
    {
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("oferta_index");
        $idioma = Cookie::lenguaje();
        if($dato=="all"){$dato="";}
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        // $this->_view->assign('paises', $this->_inst->getPaises($idioma));
        $arrayRowCount = $this->_inst->getBusquedaTematicaRowCount($dato);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];  
        $this->_view->assign('cantidadResultados', $totalRegistros);
        $this->_view->setJs(array('index'));
        $this->_view->setCss(array("jp-index"));
        $paginador = new Paginador();
            if($pagina==0){
                $numeracion=0;
            }else{
                $numeracion=($pagina-1)*10;    
            }
        $this->_view->assign('titulo', 'Instituciones');
        $paginador->paginar( $totalRegistros,"listarInstituciones", "$dato", $pagina, CANT_REG_PAG, true);
        $this->_view->assign('listaIns', $this->_inst->getBusquedaTematica($pagina,CANT_REG_PAG,$dato));
        $listaO=$this->_inst->getInstitucionesConCantOfertaSinPaginar();
        $this->_view->assign('listaO', $listaO);
        $this->_view->assign('numeracion', $numeracion);
        $this->_view->assign('busqueda', 'Si');
        $this->_view->assign('palabra_buscada', $dato);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('index','index');
    }
    public function ficha($id=false) {
        $this->validarUrlIdioma();
        
        $this->_view->setJs(array('index'));

        $lista=$this->_inst->getInstitucionPorId($id);
        
        $this->_view->assign('listaIns', $lista);
        $this->_view->assign('titulo', 'Ficha Institucion');
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->renderizar('ficha','instituciones');

    }

    public function busquedaAvanzada($selectPais='',$datos = '',$proyectos='',$ofertas='',$esp='',$mae='',$doc='')
    {
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("oferta_index");
        $idioma = Cookie::lenguaje();
     //   $contador_final=0;
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        // $this->_view->assign('paises', $this->_inst->getPaises($idioma));
        
        if($selectPais=="all"){$selectPais="";}
        if($datos=="all"){$datos="";}
        if($proyectos=="all"){$proyectos="";}
        if($ofertas=="all"){$ofertas="";}
        
        $caso_Especial = '';


        if($datos!==''){
        
        $innerjoinDatos=" INNER JOIN institucion_otros_datos iod ON iod.Ins_IdInstitucion = i.Ins_IdInstitucion ";
        $whereDatos = " iod.Atributo LIKE '%".$datos."%' ";
        
        }else{
        $innerjoinDatos="";
        $whereDatos = "";    
        }

        if($ofertas!==''){
            
            
            if($whereDatos==''){
            $whereOferta = " o.TipoRecurso= 'Oferta' AND o.Ofe_Nombre LIKE '%".$ofertas."%' ";
            }else{
            $whereOferta = " AND o.TipoRecurso= 'Oferta' AND o.Ofe_Nombre LIKE '%".$ofertas."%' ";
            }

        }else{
            $whereOferta="";
        }

        if($proyectos!==''){
            
        

            if($whereDatos=='' && $whereOferta ==''){
                $whereProyectos = " o.TipoRecurso= 'Investigacion' AND o.Ofe_Nombre LIKE '%".$proyectos."%' ";    
            }else{
                $whereProyectos = " AND o.TipoRecurso= 'Investigacion' AND o.Ofe_Nombre LIKE '%".$proyectos."%' ";    
            }
        }else{
            $whereProyectos="";
        }
        
        if($selectPais!==''){
            if($whereDatos=='' && $whereOferta =='' && $whereProyectos==''){
            $wherePais = " p.Pai_Nombre= '".$selectPais."' ";
            }else{
                $wherePais = " AND p.Pai_Nombre= '".$selectPais."' ";
            }
        }else{
            $wherePais="";
        }

        if($esp=='especializaciones'){
            if($whereDatos=='' && $whereOferta =='' && $whereProyectos=='' && $selectPais==''){
            $whereEsp = " o.Ofe_Tipo = 'ESPECIALIZACION' ";    
            }else{
                $whereEsp = " AND o.Ofe_Tipo = 'ESPECIALIZACION' ";
            }
            
        }else{
            $whereEsp = "";
        }
        if($mae=='maestrias'){
            if($whereDatos=='' && $whereOferta =='' && $whereProyectos=='' && $selectPais=='' && $whereEsp==''){
            $whereMae = " o.Ofe_Tipo = 'MAESTRIA' ";
            }else if($whereEsp!==""){
                if($whereDatos=='' && $whereOferta =='' && $whereProyectos=='' && $selectPais==''){
                $whereMae = "  o.Ofe_Tipo = 'MAESTRIA' ";    
                }else{
                $whereMae = " AND o.Ofe_Tipo = 'MAESTRIA' ";    
                }
                
                $caso_Especial="esp, mae";
            }else{
                if($whereDatos=='' && $whereOferta =='' && $whereProyectos=='' && $selectPais==''){
                    $whereMae = "  o.Ofe_Tipo = 'MAESTRIA' ";
                }else{
                    $whereMae = " AND o.Ofe_Tipo = 'MAESTRIA' ";
                }
            }
        }else{
            $whereMae = "";
        }
        if($doc=='doctorados'){
            if($whereDatos=='' && $whereOferta =='' && $whereProyectos=='' && $selectPais=='' && $whereEsp=='' && $whereMae==''){
            $whereDoc = " o.Ofe_Tipo = 'DOCTORADO' ";
            }else if($whereEsp=='' && $whereMae==''){
                $whereDoc = " AND o.Ofe_Tipo = 'DOCTORADO' ";
                }
            else if($whereEsp==''){
                if($whereDatos=='' && $whereOferta =='' && $whereProyectos=='' && $selectPais==''){
                $whereDoc = "  o.Ofe_Tipo = 'DOCTORADO' ";    
            }else{
                $whereDoc = " AND o.Ofe_Tipo = 'DOCTORADO' ";
            }
                
                $caso_Especial="mae, doc";
            }else if($whereMae==''){
                if($whereDatos=='' && $whereOferta =='' && $whereProyectos=='' && $selectPais==''){
                    $whereDoc = "  o.Ofe_Tipo = 'DOCTORADO' ";
                }else{
                    $whereDoc = " AND o.Ofe_Tipo = 'DOCTORADO' ";
                }
                $caso_Especial="esp, doc";
            }else{
                $whereDoc = "  o.Ofe_Tipo = 'DOCTORADO' ";
                $caso_Especial="esp,mae, doc";
            }
        }else{
            $whereDoc = "";
        }

        if($proyectos=='' && $ofertas=='' && $whereEsp=='' && $whereMae=='' && $whereDoc==''){
            $innerjoinOfertaProyectos="";
        }else{
            $innerjoinOfertaProyectos = " INNER JOIN oferta o ON o.Ins_IdInstitucion = i.Ins_IdInstitucion ";            
        }



        $selectGeneral = "SELECT p.Pai_Nombre, u.Ubi_Sede,i.* FROM institucion i 
        INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
        INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais" . $innerjoinDatos . $innerjoinOfertaProyectos;
        

        if($caso_Especial==''){
            $WhereGeneral = " WHERE " . $whereDatos . $whereOferta . $whereProyectos.$wherePais . $whereEsp . $whereMae . $whereDoc;    
        }else if($caso_Especial=='esp, mae'){
            $WhereGeneral = " WHERE " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereEsp . " OR " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereMae;
        }else if($caso_Especial=='mae, doc'){
            $WhereGeneral = " WHERE " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereMae . " OR " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereDoc;
        }else if($caso_Especial=='esp, doc'){
            $WhereGeneral = " WHERE " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereEsp . " OR " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereDoc;
        }else if($caso_Especial='esp,mae, doc'){
            $WhereGeneral = " WHERE " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereEsp . " OR " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereDoc . " OR " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereMae;
        }

        
        $group_by = "GROUP BY p.Pai_Nombre, u.Ubi_Sede,i.Ins_CorreoPagina,i.Ins_Direccion,i.Ins_IdInstitucion,i.Ins_IdPadre,i.Ins_img,
        i.Ins_Nombre,i.Ins_Representante,i.Ins_Telefono,i.Ins_Tipo,i.row_estado,i.Ubi_IdUbigeo";
        
        $listaFinal = $this->_inst->getBusquedaAvanzada($selectGeneral, $WhereGeneral,$group_by,$pagina,CANT_REG_PAG);

        $totalRegistros = count($this->_inst->getBusquedaAvanzadaT($selectGeneral, $WhereGeneral,$group_by));
        //resumen
        $consultaResumen =" SELECT i.Ins_Tipo AS Ins_Tipo, COUNT(i.Ins_IdInstitucion) AS CantidadRegistros FROM institucion i 
        INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
        INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais " . $innerjoinDatos . $innerjoinOfertaProyectos. $WhereGeneral. " GROUP BY i.Ins_Tipo ";
        
        $resumen1 = $this->_inst->getResumen1($consultaResumen);
        $this->_view->assign('resumen1', $resumen1);

        if($innerjoinOfertaProyectos==''){
            $consultaResumen2 = "SELECT t.Tem_Nombre, COUNT(o.Ofe_IdOferta) AS CantidadRegistros FROM institucion i 
        INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
        INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais ". $innerjoinDatos . " INNER JOIN oferta o ON o.Ins_IdInstitucion=i.Ins_IdInstitucion INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica ". $WhereGeneral. " AND o.TipoRecurso='Investigacion' GROUP BY t.Tem_Nombre";        
            $consultaResumen2RC = "SELECT COUNT(o.Ofe_IdOferta) AS CantidadRegistros FROM institucion i 
        INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
        INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais ". $innerjoinDatos . " INNER JOIN oferta o ON o.Ins_IdInstitucion=i.Ins_IdInstitucion INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica ". $WhereGeneral. " AND o.TipoRecurso='Investigacion'";
        $consultaResumen3 = "SELECT o.Ofe_Tipo AS Tipo, COUNT(o.Ofe_IdOferta) AS CantidadRegistros FROM institucion i 
        INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
        INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais ". $innerjoinDatos . " INNER JOIN oferta o ON o.Ins_IdInstitucion=i.Ins_IdInstitucion INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica ". $WhereGeneral. " AND o.TipoRecurso='Oferta' GROUP BY o.Ofe_Tipo";
        $consultaResumen3RC = "SELECT COUNT(o.Ofe_IdOferta) AS CantidadRegistros FROM institucion i 
        INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
        INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais ". $innerjoinDatos . " INNER JOIN oferta o ON o.Ins_IdInstitucion=i.Ins_IdInstitucion INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica ". $WhereGeneral. " AND o.TipoRecurso='Oferta'";
        }else{
            $consultaResumen2 = "SELECT t.Tem_Nombre, COUNT(o.Ofe_IdOferta) AS CantidadRegistros FROM institucion i 
        INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
        INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais ". $innerjoinDatos . $innerjoinOfertaProyectos." INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica ".$WhereGeneral. " AND o.TipoRecurso='Investigacion' GROUP BY t.Tem_Nombre";
        $consultaResumen2RC = "SELECT COUNT(o.Ofe_IdOferta) AS CantidadRegistros FROM institucion i 
        INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
        INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais ". $innerjoinDatos . $innerjoinOfertaProyectos. $WhereGeneral. " AND o.TipoRecurso='Investigacion'";
        $consultaResumen3 = "SELECT o.Ofe_Tipo AS Tipo, COUNT(o.Ofe_IdOferta) AS CantidadRegistros FROM institucion i 
        INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
        INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais ". $innerjoinDatos . $innerjoinOfertaProyectos. $WhereGeneral. " AND o.TipoRecurso='Oferta' GROUP BY o.Ofe_Tipo";
        $consultaResumen3RC = "SELECT COUNT(o.Ofe_IdOferta) AS CantidadRegistros FROM institucion i 
        INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
        INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais ". $innerjoinDatos . $innerjoinOfertaProyectos. $WhereGeneral. " AND o.TipoRecurso='Oferta'";
        }

        

        $resumen2 = $this->_inst->getResumen1($consultaResumen2);
        $resumen2RCa = $this->_inst->getResumen1($consultaResumen2RC);
        $rowcount2 = $resumen2RCa[0]['CantidadRegistros'];
        $resumen3RCa = $this->_inst->getResumen1($consultaResumen3RC);
        $rowcount3 = $resumen3RCa[0]['CantidadRegistros'];
        $resumen3 = $this->_inst->getResumen1($consultaResumen3);
        $this->_view->assign('resumen2', $resumen2);
        $this->_view->assign('resumen3', $resumen3);
        $this->_view->assign('rowcount2', $rowcount2);
        $this->_view->assign('rowcount3', $rowcount3);
        //fin resumen        
        $this->_view->setJs(array('index'));
        $this->_view->setCss(array("jp-index"));
        $paginador = new Paginador();
        if($pagina==0){
        $numeracion=0;
        }else{
        $numeracion=($pagina-1)*CANT_REG_PAG;    
        }
        $this->_view->assign('titulo', 'Instituciones');
        $paginador->paginar( $totalRegistros,"busquedaAvanzada","", $pagina, CANT_REG_PAG, true);
        $this->_view->assign('listaIns', $listaFinal);
        $listaO=$this->_inst->getInstitucionesConCantOfertaSinPaginar();
        $this->_view->assign('listaO', $listaO);
        $this->_view->assign('numeracion', $numeracion);
        $this->_view->assign('busquedaAvanzada', 'si');
        $this->_view->assign('cantidadResultados', $totalRegistros);

        if($selectPais!==''){
            $this->_view->assign('pais_buscado', $selectPais);            
        }
        if($datos!==''){
            $this->_view->assign('datos_buscado',  $datos);            
        }
        if($proyectos!==''){
            $this->_view->assign('proyectos_buscado', $proyectos);            
        }
        if($ofertas!==''){
            $this->_view->assign('ofertas_buscado',  $ofertas);            
        }
        if($esp=='especializaciones'){
            $this->_view->assign('esp_buscado', 'Considerar Especializaciones');            
        }
        if($mae=='maestrias'){
            $this->_view->assign('mae_buscado', 'Considerar Maestrias');            
        }
        if($doc=='doctorados'){
            $this->_view->assign('doc_buscado', 'Considerar Doctorados');            
        }

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('index','index');
    }
     public function _paginacion_busquedaAvanzada($selectPais='',$datos = '',$proyectos='',$ofertas='',$esp='',$mae='',$doc='')
    {
     //   $contador_final=0;

        $this->_view->getLenguaje("oferta_index");
        $idioma = Cookie::lenguaje();
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');        
        $this->_view->assign('paises', $this->_inst->getPaises($idioma));
        //
            if($selectPais=="all"){$selectPais="";}
            if($datos=="all"){$datos="";}
            if($proyectos=="all"){$proyectos="";}
            if($ofertas=="all"){$ofertas="";}
            
            $caso_Especial = '';
        //
        //
            if($datos!==''){
                $innerjoinDatos=" INNER JOIN institucion_otros_datos iod ON iod.Ins_IdInstitucion = i.Ins_IdInstitucion ";
                $whereDatos = " iod.Atributo LIKE '%".$datos."%' ";
                }else{
                $innerjoinDatos="";
                $whereDatos = "";    
            }

            if($ofertas!==''){
                
                
                if($whereDatos==''){
                $whereOferta = " o.TipoRecurso= 'Oferta' AND o.Ofe_Nombre LIKE '%".$ofertas."%' ";
                }else{
                $whereOferta = " AND o.TipoRecurso= 'Oferta' AND o.Ofe_Nombre LIKE '%".$ofertas."%' ";
                }

            }else{
                $whereOferta="";
            }

            if($proyectos!==''){
                
            

                if($whereDatos=='' && $whereOferta ==''){
                    $whereProyectos = " o.TipoRecurso= 'Investigacion' AND o.Ofe_Nombre LIKE '%".$proyectos."%' ";    
                }else{
                    $whereProyectos = " AND o.TipoRecurso= 'Investigacion' AND o.Ofe_Nombre LIKE '%".$proyectos."%' ";    
                }
            }else{
                $whereProyectos="";
            }
            
            if($selectPais!==''){
                if($whereDatos=='' && $whereOferta =='' && $whereProyectos==''){
                $wherePais = " p.Pai_Nombre= '".$selectPais."' ";
                }else{
                    $wherePais = " AND p.Pai_Nombre= '".$selectPais."' ";
                }
            }else{
                $wherePais="";
            }

            if($esp=='especializaciones'){
                if($whereDatos=='' && $whereOferta =='' && $whereProyectos=='' && $selectPais==''){
                $whereEsp = " o.Ofe_Tipo = 'ESPECIALIZACION' ";    
                }else{
                    $whereEsp = " AND o.Ofe_Tipo = 'ESPECIALIZACION' ";
                }
                
            }else{
                $whereEsp = "";
            }
            if($mae=='maestrias'){
                if($whereDatos=='' && $whereOferta =='' && $whereProyectos=='' && $selectPais=='' && $whereEsp==''){
                $whereMae = " o.Ofe_Tipo = 'MAESTRIA' ";
                }else if($whereEsp!==""){
                    if($whereDatos=='' && $whereOferta =='' && $whereProyectos=='' && $selectPais==''){
                    $whereMae = "  o.Ofe_Tipo = 'MAESTRIA' ";    
                    }else{
                    $whereMae = " AND o.Ofe_Tipo = 'MAESTRIA' ";    
                    }
                    
                    $caso_Especial="esp, mae";
                }else{
                    if($whereDatos=='' && $whereOferta =='' && $whereProyectos=='' && $selectPais==''){
                        $whereMae = "  o.Ofe_Tipo = 'MAESTRIA' ";
                    }else{
                        $whereMae = " AND o.Ofe_Tipo = 'MAESTRIA' ";
                    }
                }
            }else{
                $whereMae = "";
            }
            if($doc=='doctorados'){
                if($whereDatos=='' && $whereOferta =='' && $whereProyectos=='' && $selectPais=='' && $whereEsp=='' && $whereMae==''){
                $whereDoc = " o.Ofe_Tipo = 'DOCTORADO' ";
                }else if($whereEsp=='' && $whereMae==''){
                    $whereDoc = " AND o.Ofe_Tipo = 'DOCTORADO' ";
                    }
                else if($whereEsp==''){
                    if($whereDatos=='' && $whereOferta =='' && $whereProyectos=='' && $selectPais==''){
                    $whereDoc = "  o.Ofe_Tipo = 'DOCTORADO' ";    
                }else{
                    $whereDoc = " AND o.Ofe_Tipo = 'DOCTORADO' ";
                }
                    
                    $caso_Especial="mae, doc";
                }else if($whereMae==''){
                    if($whereDatos=='' && $whereOferta =='' && $whereProyectos=='' && $selectPais==''){
                        $whereDoc = "  o.Ofe_Tipo = 'DOCTORADO' ";
                    }else{
                        $whereDoc = " AND o.Ofe_Tipo = 'DOCTORADO' ";
                    }
                    $caso_Especial="esp, doc";
                }else{
                    $whereDoc = "  o.Ofe_Tipo = 'DOCTORADO' ";
                    $caso_Especial="esp,mae, doc";
                }
            }else{
                $whereDoc = "";
            }

            if($proyectos=='' && $ofertas=='' && $whereEsp=='' && $whereMae=='' && $whereDoc==''){
                $innerjoinOfertaProyectos="";
            }else{
                $innerjoinOfertaProyectos = " INNER JOIN oferta o ON o.Ins_IdInstitucion = i.Ins_IdInstitucion ";            
            }
        //
        $selectGeneral = "SELECT p.Pai_Nombre, u.Ubi_Sede,i.* FROM institucion i 
        INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
        INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais" . $innerjoinDatos . $innerjoinOfertaProyectos;        

        if($caso_Especial==''){
            $WhereGeneral = " WHERE " . $whereDatos . $whereOferta . $whereProyectos.$wherePais . $whereEsp . $whereMae . $whereDoc;    
            }else if($caso_Especial=='esp, mae'){
                $WhereGeneral = " WHERE " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereEsp . " OR " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereMae;
            }else if($caso_Especial=='mae, doc'){
                $WhereGeneral = " WHERE " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereMae . " OR " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereDoc;
            }else if($caso_Especial=='esp, doc'){
                $WhereGeneral = " WHERE " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereEsp . " OR " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereDoc;
            }else if($caso_Especial='esp,mae, doc'){
                $WhereGeneral = " WHERE " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereEsp . " OR " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereDoc . " OR " . $whereDatos . $whereOferta . $whereProyectos.$wherePais .$whereMae;
        }
        if (!$filas) {
            $filas = CANT_REG_PAG;
        } 

        $group_by = "GROUP BY p.Pai_Nombre, u.Ubi_Sede,i.Ins_CorreoPagina,i.Ins_Direccion,i.Ins_IdInstitucion,i.Ins_IdPadre,i.Ins_img,
        i.Ins_Nombre,i.Ins_Representante,i.Ins_Telefono,i.Ins_Tipo,i.row_estado,i.Ubi_IdUbigeo";
        
        $listaFinal = $this->_inst->getBusquedaAvanzada($selectGeneral, $WhereGeneral,$group_by,$pagina,$filas);

        $totalRegistros = count($this->_inst->getBusquedaAvanzadaT($selectGeneral, $WhereGeneral,$group_by));
                
        $this->_view->setJs(array('index'));
        $paginador = new Paginador();
        if($pagina==0){
        $numeracion=0;
        }else{
        $numeracion=($pagina-1)*$filas;    
        }
        $this->_view->assign('titulo', 'Instituciones');
        $paginador->paginar( $totalRegistros,"busquedaAvanzada", "", $pagina, $filas, true);
        $this->_view->assign('listaIns', $listaFinal);
        $listaO=$this->_inst->getInstitucionesConCantOfertaSinPaginar();
        $this->_view->assign('listaO', $listaO);
        $this->_view->assign('numeracion', $numeracion);
        $this->_view->assign('busquedaAvanzada', 'si');
        $this->_view->assign('cantidadResultados', $totalRegistros);
        //if
            if($selectPais!==''){
                $this->_view->assign('pais_buscado', $selectPais);            
            }
            if($datos!==''){
                $this->_view->assign('datos_buscado',  $datos);            
            }
            if($proyectos!==''){
                $this->_view->assign('proyectos_buscado', $proyectos);            
            }
            if($ofertas!==''){
                $this->_view->assign('ofertas_buscado',  $ofertas);            
            }
            if($esp=='especializaciones'){
                $this->_view->assign('esp_buscado', 'Considerar Especializaciones');            
            }
            if($mae=='maestrias'){
                $this->_view->assign('mae_buscado', 'Considerar Maestrias');            
            }
            if($doc=='doctorados'){
                $this->_view->assign('doc_buscado', 'Considerar Doctorados');            
            }
        //end if
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarInstituciones', false, true);
    }

}
?>