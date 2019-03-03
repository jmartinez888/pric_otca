<?php

class documentosController extends Controller{

    private $_documentos;

    public function __construct($lang, $url) {
        parent::__construct($lang, $url);
        $this->_documentos = $this->loadModel('documentos');
    }

    public function index($pagina = false)
    {
        //Modal Registrar Recurso
        // if ($this->botonPress("bt_registrar"))
        // {
        //     $this->registrarRecurso();
        // }

    	// $this->_acl->autenticado();
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("bd_documentos");

        //Para modal Adjuntar archivo
        $this->_view->getLenguaje("bdrecursos_index");
        $this->_view->assign('tipoServicio', 'individual');
        $this->_view->assign('idioma', Cookie::lenguaje());
        $this->_view->assign('idiomas',$this->_documentos->getIdiomas());
        $this->_view->assign('estandares', $this->_documentos->getEstandar());
        //Para modal Adjuntar archivo

        $paginador = new Paginador();
        $this->_view->setJs(array('documentos', "jp-index"));
		$this->_view->setCss(array('listadocumentos', "jp-index"));

        $condicion = " WHERE Dub_Estado = 1 ";

		$idioma = Cookie::lenguaje();

		$orderBy = " ORDER BY dub.Dub_Titulo ASC LIMIT 0," . CANT_REG_PAG;

        //Filtro Para usuarios logueados
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        if (!Session::get('autenticado')) {

        } else {
            $condicion = " WHERE (Dub_Estado = 0 OR Dub_Estado = 1 OR Dub_Estado = 2) ";
            // $condicion .= " AND Usu_IdUsuario = " . Session::get('id_usuario');
            // $this->_view->assign('filtrousuario',1);
            // $this->_view->assign('usuario',Session::get('usuario'));
            // $this->_view->assign('documentos', $this->_documentos->getDocumentosPaises($condicion, $idioma, $orderBy));
        }

		$rowCount = $this->_documentos->getDocumentosRowCount($condicion);
		// print_r($rowCount);
        $totalRegistros = $rowCount["CantidadRegistros"];
        $paginador->paginar( $totalRegistros,"resultados", "", $pagina, CANT_REG_PAG, true);



		$this->_view->assign('paises', $this->_documentos->getCantDocumentosPaises($condicion,$idioma));

		$this->_view->assign('totaldocumentos', $this->_documentos->getTotalDocumentos($condicion,$idioma));
        $this->_view->assign('temadocumento', $this->_documentos->getCantidadTemasDocumentos($condicion,$idioma));
		$this->_view->assign('tipodocumento', $this->_documentos->getCantidadTiposDocumentos($condicion,$idioma));
        $this->_view->assign('autores', $this->_documentos->getCantidadAutoresDocumentos($condicion,$idioma));
        $this->_view->assign('formatos', $this->_documentos->getCantidadFormatosDocumentos($condicion,$idioma));

        // $this->_view->assign('inicio',1);
        $this->_view->assign('documentos',array());
        $this->_view->assign('resumen',1);

		$this->_view->assign('numeropagina',$this->getInt('pagina'));
		$this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
		$this->_view->assign('numeropagina', $paginador->getNumeroPagina());
		$this->_view->assign('titulo', 'Base de Datos de Documentos');
		$this->_view->renderizar('index','documentos');
    }

    public function busqueda($palabra = '', $temadocumento = '', $tipodocumento = '',  $autordocumento = '',  $formatodocumento = '', $pais = '', $usuariodocumento = false, $letra = '')
    {
    	// echo $palabra."/".$temadocumento."/".$tipodocumento."/".$pais;
    	// $this->_acl->autenticado();
        // $this->_view->setTemplate(LAYOUT_FRONTEND);
        //Modal Registrar Recurso
        // if ($this->botonPress("bt_registrar"))
        // {
        //     $this->registrarRecurso();
        // }
   $this->validarUrlIdioma();
   $this->_view->getLenguaje("bd_documentos");
    $this->_view->getLenguaje("bdrecursos_registros");
    $this->_view->getLenguaje("bdrecursos_index");
    $this->_view->getLenguaje("bdlegal");
		$this->_view->setCss(array('listadocumentos', "jp-index"));
        $this->_view->setJs(array('documentos'));
		$pagina = $this->getInt('pagina');
        //$palabra = $this->getSql('palabra');
		$idioma = Cookie::lenguaje();
        // $registro = 25;
        if ($pagina > 0) {
        	$inicioRegistro = ($pagina - 1) * CANT_REG_PAG;
        } else {
        	$inicioRegistro = 0;
        }
        $condicion = "";
        $condicionPalabra = "";
		$condicionTema = "";
		$condicionTipo = "";
		$condicionAutor = "";
        $condicionFormato = "";
		$condicionPais = "";
        $condicionLetra = "";

		$palabra = $this->filtrarTexto($palabra);
		$temadocumento = $this->filtrarTexto($temadocumento);
		$tipodocumento = $this->filtrarTexto($tipodocumento);
		$autordocumento = $this->filtrarTexto($autordocumento);
        $formatodocumento = $this->filtrarTexto($formatodocumento);
		$pais = $this->filtrarTexto($pais);
        $letra = $this->filtrarTexto($letra);

        if($palabra == 'all')
        {
        	$palabra = '';
        }

        $trozosPalabra = explode(" ",$palabra);
        $numero = count($trozosPalabra);
        if($numero==1){
        	$condicionPalabra .= " and (fn_TraducirContenido('dublincore','Dub_Titulo',dub.Dub_IdDublinCore,'$idioma',dub.Dub_Titulo) LIKE '%$palabra%' OR fn_TraducirContenido('dublincore','Dub_PalabraClave',dub.Dub_IdDublinCore,'$idioma',dub.Dub_PalabraClave) LIKE '%$palabra%' OR fn_TraducirContenido('dublincore','Dub_Descripcion',dub.Dub_IdDublinCore,'$idioma',dub.Dub_Descripcion) LIKE '%$palabra%' OR Aut_Nombre LIKE '%$palabra%') ";
        }
        if($numero>1){
            $condicionPalabra = " AND (MATCH(Dub_Titulo, Dub_Descripcion, Dub_PalabraClave) AGAINST ('%".$palabra."%' IN BOOLEAN MODE) OR MATCH(Aut_Nombre) AGAINST ('%".$palabra."%' IN BOOLEAN MODE)) ";
        }

        if($temadocumento != 'all' && $temadocumento != '')
        {
        	$condicionTema .= " AND  fn_TraducirContenido('tema_dublin','Ted_Descripcion',ted.Ted_IdTemaDublin,'$idioma',ted.Ted_Descripcion) = '$temadocumento'";
        }
        if($tipodocumento != 'all' && $tipodocumento != '')
        {
        	$condicionTipo .= " AND   fn_TraducirContenido('tipo_dublin','Tid_Descripcion',tid.Tid_IdTipoDublin,'$idioma',tid.Tid_Descripcion) = '$tipodocumento'";
        }
        if($autordocumento != 'all' && $autordocumento != '')
        {
            $condicionAutor .= " AND aut.Aut_Nombre = '$autordocumento' " ;

        }
        if($formatodocumento != 'all' && $formatodocumento != '')
        {
            $condicionFormato .= " AND taf.Taf_Descripcion = '$formatodocumento' " ;

        }
        if($pais != 'all' && $pais != '')
        {
            $condicionPais .= " AND pai.Pai_Nombre = '$pais' " ;
        }
        if($letra != 'all' && $letra != '')
        {
            $condicionLetra .= " AND dub.Dub_Titulo LIKE '$letra%' " ;
        }

        //Filtro Para usuarios logueados
        $condicionUsuario = " ";
        $condicionEstado = " WHERE Dub_Estado = 1 ";
            $this->_view->setTemplate(LAYOUT_FRONTEND);
        if (!Session::get('autenticado')) {

        } else {
            $condicionEstado = " WHERE (Dub_Estado = 0 OR Dub_Estado = 1 OR Dub_Estado = 2 ) ";
            if ($usuariodocumento && $usuariodocumento != "all") {
                $condicionUsuario = " AND Usu_IdUsuario = " . Session::get('id_usuario');
                $this->_view->assign('filtrousuario',1);
                $this->_view->assign('usuario',Session::get('usuario'));
            }
            // if ($usuariodocumento == "all") {
            //     $condicionEstado = " WHERE (Dub_Estado = 0 OR Dub_Estado = 1 OR Dub_Estado = 2 ) ";
            // }
        }

 		$condicion .= $condicionEstado.$condicionPalabra.$condicionTema.$condicionTipo.$condicionAutor.$condicionFormato.$condicionPais.$condicionLetra.$condicionUsuario;

 		// $condicionPaginar = $condicion . " LIMIT " . $inicioRegistro . "," . CANT_REG_PAG;

		$orderBy = " ORDER BY dub.Dub_Titulo ASC LIMIT " . $inicioRegistro . "," . CANT_REG_PAG;

        if ($palabra != 'all' && $palabra != '') {
        	$this->_view->assign('palabrabuscada', $palabra);
            $this->_view->assign('resultPalabra', ' del texto <b>"' . $palabra . '"</b>');
        }
        if ($temadocumento != 'all' && $temadocumento != '') {
        	$this->_view->assign('filtroTema', $temadocumento);
        }
	    if ($tipodocumento != 'all' && $tipodocumento != '') {
	    	$this->_view->assign('filtroTipo', $tipodocumento);
	    }
	    if ($autordocumento != 'all' && $autordocumento != '') {
	    	$this->_view->assign('filtroAutor', $autordocumento);
	    }
        if ($formatodocumento != 'all' && $formatodocumento != '') {
            $this->_view->assign('filtroFormato', $formatodocumento);
        }
	    if ($pais != 'all' && $pais != '') {
	    	$this->_view->assign('filtroPais', $pais);
	    }
        if ($letra != 'all' && $letra != '') {
            $this->_view->assign('filtroLetra', $letra);
        }


        $paginador = new Paginador();
        $this->_view->setJs(array('documentos'));
        //$this->_view->assign('documentos', $paginador->paginar($this->_documentos->getDocumentosTraducido($condicion, $idioma ),"paginar","", $pagina,$registro));
		//$this->_view->assign('totaldocumentos', $this->_documentos->getTotalDocumentos($condicion,$idioma));

        $rowCount = $this->_documentos->getDocumentosRowCount($condicion);
        $totalRegistros = $rowCount["CantidadRegistros"];
        $paginador->paginar( $totalRegistros,"resultados", "$palabra", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('documentos', $this->_documentos->getDocumentosPaises($condicion,$idioma, $orderBy));

		$this->_view->assign('paises', $this->_documentos->getCantDocumentosPaises($condicion,$idioma));
		$this->_view->assign('totaldocumentos', $this->_documentos->getTotalDocumentos($condicion,$idioma));
        $this->_view->assign('temadocumento', $this->_documentos->getCantidadTemasDocumentos($condicion,$idioma));
		$this->_view->assign('tipodocumento', $this->_documentos->getCantidadTiposDocumentos($condicion,$idioma));
		$this->_view->assign('autores', $this->_documentos->getCantidadAutoresDocumentos($condicion,$idioma));
        $this->_view->assign('formatos', $this->_documentos->getCantidadFormatosDocumentos($condicion,$idioma));

        $this->_view->assign('titulo', 'Buscador - Base de Datos de Documentos');
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
		$this->_view->assign('numeropagina', $paginador->getNumeroPagina());
		$this->_view->renderizar('busqueda','documentos');
    }

    public function _paginacion_resultados($palabra = "")
    {
        //$this->_view->setTemplate(LAYOUT_FRONTEND);
		$this->_view->getLenguaje("bd_documentos");
    $this->_view->getLenguaje("bdrecursos_registros");
		$this->_view->setCss(array('listadocumentos'));
		$pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');

        if (!$filas) {
         	$filas = CANT_REG_PAG;
        }
		// echo $filas;
        // $palabra = $this->getSql('palabra');
        $temadocumento = $this->getSql('tema');
        $tipodocumento = $this->getSql('tipo');
        $autordocumento = $this->getSql('autor');
        $formatodocumento = $this->getSql('formato');
        $letra = $this->getSql('letra');
        $usuariodocumento = $this->getSql('usuario');
        $pais = $this->getSql('pais');

		$idioma = Cookie::lenguaje();

        if ($pagina > 0) {
        	$inicioRegistro = ($pagina - 1) * $filas;
        } else {
        	$inicioRegistro = 0;
        }

        $condicion = "";
        $condicionPalabra = "";
		$condicionTema = "";
		$condicionTipo = "";
		$condicionAutor = "";
        $condicionFormato = "";
		$condicionPais = "";
        $condicionLetra = "";

        if($palabra == 'all')
        {
        	$palabra = '';
        }

        $trozosPalabra = explode(" ",$palabra);
        $numero = count($trozosPalabra);
        if($numero==1){
        	$condicionPalabra .= " and (fn_TraducirContenido('dublincore','Dub_Titulo',dub.Dub_IdDublinCore,'$idioma',dub.Dub_Titulo) LIKE '%$palabra%' OR fn_TraducirContenido('dublincore','Dub_PalabraClave',dub.Dub_IdDublinCore,'$idioma',dub.Dub_PalabraClave) LIKE '%$palabra%' OR fn_TraducirContenido('dublincore','Dub_Descripcion',dub.Dub_IdDublinCore,'$idioma',dub.Dub_Descripcion) LIKE '%$palabra%' OR Aut_Nombre LIKE '%$palabra%') ";
        }
        if($numero>1){
            $condicionPalabra = " AND (MATCH(Dub_Titulo, Dub_Descripcion, Dub_PalabraClave) AGAINST ('%".$palabra."%' IN BOOLEAN MODE) OR MATCH(Aut_Nombre) AGAINST ('%".$palabra."%' IN BOOLEAN MODE)) ";
        }

        if($temadocumento != 'all' && $temadocumento != '')
        {
        	$condicionTema .= " AND  fn_TraducirContenido('tema_dublin','Ted_Descripcion',ted.Ted_IdTemaDublin,'$idioma',ted.Ted_Descripcion) = '$temadocumento'";
        }
        if($tipodocumento != 'all' && $tipodocumento != '')
        {
        	$condicionTipo .= " AND   fn_TraducirContenido('tipo_dublin','Tid_Descripcion',tid.Tid_IdTipoDublin,'$idioma',tid.Tid_Descripcion) = '$tipodocumento'";
        }
        if($autordocumento != 'all' && $autordocumento != '')
        {
            $condicionAutor .= " AND aut.Aut_Nombre = '$autordocumento' " ;

        }
        if($formatodocumento != 'all' && $formatodocumento != '')
        {
            $condicionFormato .= " AND taf.Taf_Descripcion = '$formatodocumento' " ;

        }
        if($pais != 'all' && $pais != '')
        {
            $condicionPais .= " AND pai.Pai_Nombre = '$pais' " ;
        }
        if($letra != 'all' && $letra != '')
        {
            $condicionLetra .= " AND dub.Dub_Titulo LIKE '$letra%' " ;
        }

        //Filtro Para usuarios logueados
        $condicionUsuario = " ";
        $condicionEstado = " WHERE Dub_Estado = 1 ";
            $this->_view->setTemplate(LAYOUT_FRONTEND);
        if (!Session::get('autenticado')) {

        } else {
            $condicionEstado = " WHERE (Dub_Estado = 0 OR Dub_Estado = 1 OR Dub_Estado = 2 ) ";
            if ($usuariodocumento && $usuariodocumento != "all") {
                $condicionUsuario = " AND Usu_IdUsuario = " . Session::get('id_usuario');
                $this->_view->assign('filtrousuario',1);
                $this->_view->assign('usuario',Session::get('usuario'));
            }
            // if ($usuariodocumento == "all") {
            //     $condicionEstado = " WHERE (Dub_Estado = 0 OR Dub_Estado = 1 OR Dub_Estado = 2 ) ";
            // }
        }


        //Union de todas las condiciones
 		$condicion .= $condicionEstado.$condicionPalabra.$condicionTema.$condicionTipo.$condicionAutor.$condicionFormato.$condicionPais.$condicionLetra.$condicionUsuario;

 		// $condicionPaginar = $condicion . " LIMIT " . $inicioRegistro . "," . CANT_REG_PAG;
 		$orderBy = " ORDER BY dub.Dub_Titulo ASC LIMIT " . $inicioRegistro . "," . $filas;

        if ($palabra != 'all' && $palabra != '') {
        	$this->_view->assign('palabrabuscada', $palabra);
            $this->_view->assign('resultPalabra', ' del texto <b>"' . $palabra . '"</b>');
        }
        if ($temadocumento != 'all' && $temadocumento != '') {
        	$this->_view->assign('filtroTema', $temadocumento);
        }
	    if ($tipodocumento != 'all' && $tipodocumento != '') {
	    	$this->_view->assign('filtroTipo', $tipodocumento);
	    }
	    if ($autordocumento != 'all' && $autordocumento != '') {
	    	$this->_view->assign('filtroAutor', $autordocumento);
	    }
        if ($formatodocumento != 'all' && $formatodocumento != '') {
            $this->_view->assign('filtroFormato', $formatodocumento);
        }
	    if ($pais != 'all' && $pais != '') {
	    	$this->_view->assign('filtroPais', $pais);
	    }
        if ($letra != 'all' && $letra != '') {
            $this->_view->assign('filtroLetra', $letra);
        }

	    $paginador = new Paginador();
        $this->_view->setJs(array('documentos'));

        $rowCount = $this->_documentos->getDocumentosRowCount($condicion);
        $totalRegistros = $rowCount["CantidadRegistros"];
        $paginador->paginar( $totalRegistros,"resultados", "$palabra", $pagina, $filas, true);

        $this->_view->assign('documentos', $this->_documentos->getDocumentosPaises($condicion,$idioma, $orderBy));

		$this->_view->assign('paises', $this->_documentos->getCantDocumentosPaises($condicion,$idioma));
		$this->_view->assign('totaldocumentos', $this->_documentos->getTotalDocumentos($condicion,$idioma));
        $this->_view->assign('temadocumento', $this->_documentos->getCantidadTemasDocumentos($condicion,$idioma));
		$this->_view->assign('tipodocumento', $this->_documentos->getCantidadTiposDocumentos($condicion,$idioma));
		$this->_view->assign('autores', $this->_documentos->getCantidadAutoresDocumentos($condicion,$idioma));
        $this->_view->assign('formatos', $this->_documentos->getCantidadFormatosDocumentos($condicion,$idioma));

        $this->_view->assign('titulo', 'Buscador - Base de Datos de Documentos');
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
		$this->_view->assign('numeropagina', $paginador->getNumeroPagina());
		$this->_view->renderizar('ajax/resultados', false, true);
    }

    //Metodo para registrar Recurso
    public function registrarRecurso(){
        // echo "aca";
        if ($this->getTexto("tb_nombre_recurso") && $this->getTexto("tb_fuente_recurso") &&
            $this->getTexto("tb_origen_recurso") && $this->getTexto("sl_estandar_recurso"))
        {

            $this->_registros = $this->loadModel('registros','estandar');
            $this->_bdrecursos = $this->loadModel('indexbd','bdrecursos');

            $id_estandar = $this->getTexto("sl_estandar_recurso");
            $estandar_recurso = $this->_registros->getEstandar_recurso("WHERE Esr_IdEstandarRecurso=".$id_estandar."");
            $tipoEstandarRecurso = $estandar_recurso[0]['Esr_Tipo'];

            $recursos = $this->_bdrecursos->getRecursosIndex();

            $a=0;
            // print_r($recursos);
            for ($i=0; $i < count($recursos); $i++)
            {
                if(strtolower($this->getTexto('tb_nombre_recurso')) == strtolower($recursos[$i]['Rec_Nombre']))
                {
                    $this->_view->assign('_error', 'El nombre <b style="font-size: 1.15em;">' . $this->getTexto('tb_nombre_recurso') . '</b> no pudo ser registrado, nombre existente');
                    $a=1;
                }
            }

            if($a==0)
            {
                $nombre_tabla = '';

                if($tipoEstandarRecurso == 2)
                {
                    //Para crear la tabla data (x cada recurso)

                    $fichaEstandar = $this->_registros->getFichaEstandar($id_estandar);

                    $nombre_tabla = 'data_'.$fichaEstandar[0]['Fie_NombreTabla'];

                    $tabla_data_x_recurso = $this->_bdrecursos->getTablaData($nombre_tabla);

                    if(!empty($tabla_data_x_recurso))
                    {
                        $i=str_replace('data_'.$fichaEstandar[0]['Fie_NombreTabla'].'_', '', $tabla_data_x_recurso[0]);

                        $i = $this->filtrarInt($i[0]);

                        $ii = $i+1;
                        $nombre_tabla = 'data_'.$fichaEstandar[0]['Fie_NombreTabla'].'_'.$ii;
                    }
                    else
                    {
                        $nombre_tabla = 'data_'.$fichaEstandar[0]['Fie_NombreTabla'].'_1';
                    }
                }
                // echo "'".$this->getTexto("tb_nombre_recurso")."','".
                // $this->getTexto("tb_fuente_recurso") ."','". $this->getTexto("hd_tipo_recurso")."','".
                // $this->getTexto("sl_estandar_recurso")."','".$this->getTexto("tb_origen_recurso")."','".$nombre_tabla."','".'es'."'"; exit;

                $idrecurrso = $this->_bdrecursos->insertarRecurso($this->getTexto("tb_nombre_recurso"),
                $this->getTexto("tb_fuente_recurso"), $this->getTexto("hd_tipo_recurso"), 0,
                $this->getTexto("sl_estandar_recurso"), $this->getTexto("tb_origen_recurso"), $nombre_tabla, 'es');

                // print_r($idrecurrso);exit;
                if ($idrecurrso[0] > 0)
                {

                    // $this->_view->assign('id_recurso', $idrecurrso[0]);
                    $this->adjuntarArchivo($idrecurrso[0]);
                    // $this->_view->renderizar('ajax/gestion_idiomas', false, true);
                    // $this->redireccionar("bdrecursos/registrar/index/" . $idrecurrso[0]);
                }
                else
                {
                    $this->_view->assign('_error', 'No se pudo registrar el recurso: ' . $idrecurrso);
                    $this->_view->renderizar('ajax/adjuntarArchivo', false, true);
                }
            }
        }
        else
        {
            $this->_view->assign('_error', 'Debe Ingresar los Campos Obligatorios (*)');
        }
    }

    //Metodo para adjuntar archivo
    public function adjuntarArchivo($recurso = false) {
        // $this->_acl->acceso('registro_individual');
        // $this->validarUrlIdioma();
        $this->_dublincore = $this->loadModel('registrar');
        //$this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->getLenguaje("bdrecursos_metadata");
        $this->_view->setJs(array('dublincore'));
        if (empty($this->getSql('Idi_IdIdioma'))) {
            $idioma = Cookie::lenguaje();
        } else {
            $idioma = $this->getSql('Idi_IdIdioma');
        }
        $e = $this->loadModel('bdrecursos', true);
        // echo "acacacaca";
        $_SESSION['recurso'] = $recurso;
        $metadatarecurso = $e->getRecursoCompletoXid($_SESSION['recurso']);
        $idestandar = $this->_dublincore->getEstandarRecurso($this->filtrarInt($recurso));
        // echo $idestandar[0][0];
        $this->_view->assign('recurso', $metadatarecurso);
        $this->_view->assign('ficha', $this->_dublincore->getFichaLegislacion($idestandar[0][0], $idioma));

        $this->_view->assign('idiomas', $this->_dublincore->getIdiomas());
        $this->_view->assign('autores', $this->_dublincore->getAutores());
        $this->_view->assign('idioma', $idioma);
        $this->_view->assign('palabraclave', $this->_dublincore->getPalabrasClaves($idioma));
        $this->_view->assign('tipodublin', $this->_dublincore->getTiposDublin($idioma));
        $this->_view->assign('temadublin', $this->_dublincore->getTemasDublin($idioma));
        $this->_view->assign('formatos_archivos', $this->_dublincore->getFormatoArchivo());
        $this->_view->assign('titulo', 'Formulario de Registro');


        if ($this->getInt('registrar') == 1) {
            // echo "acaca";
            $pais_no_encontrado = array();
            $pais_encontrado = array();
            if (!empty($this->getSql('Arf_IdArchivoFisico'))) {
                $nombre_archivo = $this->getSql('Arf_IdArchivoFisico');
            } else {
                $nombre_archivo = 'no llega';
            }
            echo($nombre_archivo);exit;
            if (!empty($this->getSql('Arf_URL'))) {
                $url_archivo = $this->getSql('Arf_URL');
            } else {
                $url_archivo = '';
            }

            $archivo_fisico = $this->_dublincore->getArchivoFisico($nombre_archivo);

            if (empty($archivo_fisico) or ! empty($url_archivo)) {


                $formato = $this->_dublincore->getFormatosArchivos($this->getSql('Dub_Formato'));

                if (empty($formato)) {
                    $formato = $this->_dublincore->registrarFormatoArchivo($this->getSql('Dub_Formato'));
                }

                $archivo_fisico = $this->_dublincore->registrarArchivoFisico(
                        $this->getSql('Dub_Titulo'), $formato[0], $_FILES['Arf_IdArchivoFisico']['type'], $_FILES['Arf_IdArchivoFisico']['size'], $nombre_archivo, $this->getSql('Dub_FechaDocumento'), $url_archivo, 1, $this->getSql('Dub_Idioma')
                );

                $autor = $this->_dublincore->getAutor($this->getSql('Aut_IdAutor'));

                if (empty($autor)) {
                    $autor = $this->_dublincore->registrarAutor($this->getSql('Aut_IdAutor'));
                }

                $tipo_dublin = $this->_dublincore->getTipoDublin($this->getSql('Tid_IdTipoDublin'), $this->getSql('Idi_IdIdioma'));

                if (empty($tipo_dublin)) {
                    $tipo_dublin = $this->_dublincore->registrarTipoDublin($this->getSql('Tid_IdTipoDublin'), $this->getSql('Idi_IdIdioma'));
                }

                $tema_dublin = $this->_dublincore->getTemaDublin($this->getSql('Ted_IdTemaDublin'), $this->getSql('Idi_IdIdioma'));

                if (empty($tema_dublin)) {
                    $tema_dublin = $this->_dublincore->registrarTemaDublin($this->getSql('Ted_IdTemaDublin'), $this->getSql('Idi_IdIdioma'));
                }

                if ($archivo_fisico) {
                    if (!empty($nombre_archivo)) {
                        $destino = ROOT_ARCHIVO_FISICO . $nombre_archivo;
                        copy($_FILES['Arf_IdArchivoFisico']['tmp_name'], $destino);
                    }

                    $dublin = $this->_dublincore->registrarDublinCore(
                            $this->getSql('Dub_Titulo'), $this->getSql('Dub_Descripcion'), $this->getSql('Dub_Editor'), $this->getSql('Dub_Colabrorador'), $this->getSql('Dub_FechaDocumento'), $this->getSql('Dub_Formato'), $this->getSql('Dub_Identificador'), $this->getSql('Dub_Fuente'), $this->getSql('Dub_Idioma'), $this->getSql('Dub_Relacion'), $this->getSql('Dub_Cobertura'), $this->getSql('Dub_Derechos'), $this->getSql('Dub_PalabraClave'), $tipo_dublin[0], $archivo_fisico[0], $this->getSql('Idi_IdIdioma'), $tema_dublin[0], $this->filtrarInt($recurso));

                    if ($dublin) {
                        $dublin_autor = $this->_dublincore->getDublinAutor($dublin[0], $autor[0]);

                        if (empty($dublin_autor)) {
                            $dublin_autor = $this->_dublincore->registrarDublinAutor($dublin[0], $autor[0]);
                        }
                    }
                }

                //Para Registro de paises
                $paises = explode(",", $this->getSql('Pai_IdPais'));
                foreach ($paises as $paises) {
                    $paises = trim($paises);
                    $pais = $this->_dublincore->getPais($paises);
                    if (!empty($pais)) {
                        if ($dublin) {
                            if (isset($dublin)) {
                                $documentorelacionado = $this->_dublincore->registrarDocumentosRelacionados($dublin[0], $pais[0]);
                                // print_r($documentorelacionado);
                            }
                            array_push($pais_encontrado, $paises);
                        }
                    } else {
                        array_push($pais_no_encontrado, $paises);
                    }
                }
                $mensaje_registrados = '';
                $mensaje_no_registrados = '';
                if (isset($pais_encontrado) && count($pais_encontrado)) {
                    $mensaje_registrados = 'Los Datos fueron registrados correctamente de ';
                    foreach ($pais_encontrado as $item1) {
                        $mensaje_registrados = $mensaje_registrados . ' - ' . $item1;
                    }
                }
                if (isset($pais_no_encontrado) && count($pais_no_encontrado)) {
                    $mensaje_no_registrados = 'Los siguientes Datos no fueron registrados ';
                    foreach ($pais_no_encontrado as $item2) {
                        $mensaje_no_registrados = $mensaje_no_registrados . ' - ' . $item2;
                    }
                }

                // $this->_view->setJs(array('modal'));
                $this->_view->assign('mensaje', $mensaje_registrados . '.');
                $this->_view->assign('error', $mensaje_no_registrados . '.');
                $this->_view->renderizar('ajax/adjuntarArchivo', false, true);
                // exit;
            } else {
                // $this->_view->setJs(array('modal'));
                $this->_view->assign('error', 'Archivo Existente, verifique el nombre del archivo a registrar.');
                $this->_view->renderizar('ajax/adjuntarArchivo', false, true);
                // exit;
            }
        }
        echo "final";
        $this->_view->renderizar('ajax/adjuntarArchivo', false, true);
    }






    public function embed_dublincore()
    {
        //$this->_view->setTemplate(LAYOUT_FRONTEND);
		$this->_view->getLenguaje("bd_documentos");
		$this->_view->setCss(array('listadocumentos'));
		$palabra = $this->getSql('palabra');
        $temadocumento = $palabra;
        $tipodocumento = $palabra;
		//echo $palabra;
		$idioma = Cookie::lenguaje();

        $condicion = "";
        $condicionPalabra = "";
		$condicionTema = "";
		$condicionTipo = "";

        $condicionPalabra .= " WHERE Dub_Estado = 1 and (fn_TraducirContenido('dublincore','Dub_Titulo',dub.Dub_IdDublinCore,'$idioma',dub.Dub_Titulo) LIKE '%$palabra%'
        	OR fn_TraducirContenido('dublincore','Dub_PalabraClave',dub.Dub_IdDublinCore,'$idioma',dub.Dub_PalabraClave) LIKE '%$palabra%'
        	OR fn_TraducirContenido('dublincore','Dub_Descripcion',dub.Dub_IdDublinCore,'$idioma',dub.Dub_Descripcion) LIKE '%$palabra%'
        	OR Aut_Nombre LIKE '%$palabra%') ";
        $condicionTema .= " OR  fn_TraducirContenido('tema_dublin','Ted_Descripcion',ted.Ted_IdTemaDublin,'$idioma',ted.Ted_Descripcion) = '$temadocumento'";
        $condicionTipo .= " OR  fn_TraducirContenido('tipo_dublin','Tid_Descripcion',tid.Tid_IdTipoDublin,'$idioma',tid.Tid_Descripcion) = '$tipodocumento'";
		$condicion = $condicionPalabra.$condicionTema.$condicionTipo;

        $this->_view->assign('documentos',$this->_documentos->getDocumentosPaises($condicion,$idioma));

		$this->_view->renderizar('ajax/embed_dublincore', false, true);
    }

   /*
    public function buscarportemadocumento()
    {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
		$this->_view->getLenguaje("bd_documentos");
		$pagina = $this->getInt('pagina');
        $palabra = $this->getSql('palabra');
		$idioma = Cookie::lenguaje();
        $registro = 25;
        $condicion = "";
        if($palabra)
        {
            $condicion .= " WHERE Dub_Estado = 1 and  fn_TraducirContenido('tema_dublin','Ted_Descripcion',ted.Ted_IdTemaDublin,'$idioma',ted.Ted_Descripcion) = '$palabra'";
        }

		$paginador = new Paginador();

		$this->_view->setJs(array('documentos'));

		$this->_view->assign('documentos', $paginador->paginar($this->_documentos->getDocumentosTraducido($condicion,$idioma),"paginar","", $pagina,$registro));

		$this->_view->assign('totaldocumentos', $this->_documentos->getTotalDocumentos($condicion,$idioma));

		$this->_view->assign('palabrabuscada', '');

		$this->_view->assign('paises', $this->_documentos->getCantidadDocumentosPaises());

		$this->_view->assign('numeropagina', $paginador->getNumeroPagina());

		$this->_view->assign('paginacion', $paginador->getView('paginacion_ajax'));

		$this->_view->renderizar('ajax/resultados', false, true);
    }

	public function buscarportipodocumento()
    {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
		$this->_view->getLenguaje("bd_documentos");
		$pagina = $this->getInt('pagina');
        $palabra = $this->getSql('palabra');
		$idioma = Cookie::lenguaje();
        $registro = 25;
        $condicion = "";
        if($palabra)
        {
            $condicion .= " WHERE Dub_Estado = 1 and  fn_TraducirContenido('tipo_dublin','Tid_Descripcion',tid.Tid_IdTipoDublin,'$idioma',tid.Tid_Descripcion) = '$palabra'";
        }

		$paginador = new Paginador();

		$this->_view->setJs(array('documentos'));

		$this->_view->assign('documentos', $paginador->paginar($this->_documentos->getDocumentosTraducido($condicion,$idioma),"paginar","", $pagina,$registro));

		$this->_view->assign('totaldocumentos', $this->_documentos->getTotalDocumentos($condicion,$idioma));

		$this->_view->assign('palabrabuscada', '');

		$this->_view->assign('paises', $this->_documentos->getCantidadDocumentosPaises());

		$this->_view->assign('numeropagina', $paginador->getNumeroPagina());

		$this->_view->assign('paginacion', $paginador->getView('paginacion_ajax'));

		$this->_view->renderizar('ajax/resultados', false, true);
    }

    public function buscarporpais()
    {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
		$this->_view->getLenguaje("bd_documentos");
		$pagina = $this->getInt('pagina');
        $palabra = $this->getSql('palabra');
        $variables = $this->getSql('variables');
        $tipo_archivo = $this->getSql('pais');
        $registros  = $this->getInt('registros');
        $paginas = $this->getInt('paginas');
		$idioma = Cookie::lenguaje();
        $condicion = "";
        $condicionPais = "";
        $registro = 25;

        if($palabra)
        {
            $condicion .= " WHERE Dub_Estado = 1 ";
            $condicionPais .= " WHERE d.Pai_Nombre = '$palabra' ";
        }

        $paginador = new Paginador();

		$this->_view->setJs(array('documentos'));
		$this->_view->assign('documentos', $paginador->paginar($this->_documentos->getDocumentosPaises($condicion,$idioma),"paginar","", $pagina,$registro));
		$this->_view->assign('totaldocumentos', $this->_documentos->getCantDocumentosPaises($condicion,$idioma,$condicionPais));
		$this->_view->assign('paises', $this->_documentos->getCantidadDocumentosPaises());
		$this->_view->assign('palabrabuscada', '');
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax'));
		$this->_view->assign('numeropagina', $paginador->getNumeroPagina());
		$this->_view->renderizar('ajax/resultados', false, true);
    }
    */
    public function metadata($Dub_IdDublinCore)
    {
    	// $this->_acl->autenticado();
    $this->_view->getLenguaje("bd_documentos");
    $this->_view->getLenguaje("bdrecursos_metadata");
    $this->_view->getLenguaje("bdrecursos_index");
    $this->_view->getLenguaje("bdlegal");
    $this->_view->getLenguaje("index_buscador");
    $this->validarUrlIdioma();
    $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setCss(array("jp-index"));
		$idioma = Cookie::lenguaje();
		$e = $this->loadModel('bdrecursos', true);
        $condicion = "";
		$Dub_IdDublinCore = $this->filtrarInt($Dub_IdDublinCore);
		$condicion .= " where dub.Dub_Estado = 1 and dub.Dub_IdDublinCore = $Dub_IdDublinCore ";
		$metadatadublin = $this->_documentos->getDocumentosTraducido($condicion,$idioma);
		$metadatarecurso = $e->getRecursoCompletoXid($metadatadublin[0]['Rec_IdRecurso']);
    $this->_view->assign('recurso', $metadatarecurso);

        $this->_view->assign('detalle', $metadatadublin);

		$this->_view->assign('titulo', 'Documento - '.$metadatadublin[0]['Dub_Titulo'] );

		$this->_view->renderizar('metadata', 'documentos');
    }

	public function editar($registros)
    {
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("bd_documentos");
		$this->_view->setTemplate(LAYOUT_FRONTEND);

        $condicion = "";
		$registross = $this->filtrarInt($registros);
		$condicion .= " where Dub_Estado = 1 and dub.Dub_IdDublinCore = $registross ";

		if($this->getInt('actualizar')==1){
			$this->_documentos->actualizarDublinCore($this->getSql('Dub_Titulo'),$this->getSql('Dub_Descripcion'),$this->getSql('Dub_FechaDocumento'),$this->getSql('Dub_PalabraClave'),$this->filtrarInt($registros));
			$this->_view->assign('_error', 'Datos Actualizados Correctamente');
		}


        $this->_view->assign('detalle', $this->_documentos->getDocumentos($condicion));
		$this->_view->assign('titulo', 'Base de Datos de Documentos');
        $this->_view->renderizar('editar', 'documentos');
    }

    public function _cambiarEstadoDublin()
    {
        $valor_estado = $this->getInt('valor_estado');
        $id_dublin = $this->getInt('id_dublin');

        $pagina = $this->getInt('pagina');
        $palabra = $this->getSql('palabra');
        // $id_recurso = $this->getInt('id_recurso');

        $this->_view->getLenguaje("bd_documentos");
        $this->_view->getLenguaje("bdrecursos_registros");

        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');

        if (!$filas) {
            $filas = CANT_REG_PAG;
        }
        // echo $filas;
        // $palabra = $this->getSql('palabra');
        $temadocumento = $this->getSql('tema');
        $tipodocumento = $this->getSql('tipo');
        $autordocumento = $this->getSql('autor');
        $formatodocumento = $this->getSql('formato');
        $letra = $this->getSql('letra');
        $usuariodocumento = $this->getSql('usuario');
        $pais = $this->getSql('pais');

        $idioma = Cookie::lenguaje();

        if ($pagina > 0) {
            $inicioRegistro = ($pagina - 1) * $filas;
        } else {
            $inicioRegistro = 0;
        }

        $condicion = "";
        $condicionPalabra = "";
        $condicionTema = "";
        $condicionTipo = "";
        $condicionAutor = "";
        $condicionFormato = "";
        $condicionPais = "";
        $condicionLetra = "";

        if($palabra == 'all')
        {
            $palabra = '';
        }

        $trozosPalabra = explode(" ",$palabra);
        $numero = count($trozosPalabra);
        if($numero==1){
            $condicionPalabra .= " and (fn_TraducirContenido('dublincore','Dub_Titulo',dub.Dub_IdDublinCore,'$idioma',dub.Dub_Titulo) LIKE '%$palabra%' OR fn_TraducirContenido('dublincore','Dub_PalabraClave',dub.Dub_IdDublinCore,'$idioma',dub.Dub_PalabraClave) LIKE '%$palabra%' OR fn_TraducirContenido('dublincore','Dub_Descripcion',dub.Dub_IdDublinCore,'$idioma',dub.Dub_Descripcion) LIKE '%$palabra%' OR Aut_Nombre LIKE '%$palabra%') ";
        }
        if($numero>1){
            $condicionPalabra = " AND (MATCH(Dub_Titulo, Dub_Descripcion, Dub_PalabraClave) AGAINST ('%".$palabra."%' IN BOOLEAN MODE) OR MATCH(Aut_Nombre) AGAINST ('%".$palabra."%' IN BOOLEAN MODE)) ";
        }

        if($temadocumento != 'all' && $temadocumento != '')
        {
            $condicionTema .= " AND  fn_TraducirContenido('tema_dublin','Ted_Descripcion',ted.Ted_IdTemaDublin,'$idioma',ted.Ted_Descripcion) = '$temadocumento'";
        }
        if($tipodocumento != 'all' && $tipodocumento != '')
        {
            $condicionTipo .= " AND   fn_TraducirContenido('tipo_dublin','Tid_Descripcion',tid.Tid_IdTipoDublin,'$idioma',tid.Tid_Descripcion) = '$tipodocumento'";
        }
        if($autordocumento != 'all' && $autordocumento != '')
        {
            $condicionAutor .= " AND aut.Aut_Nombre = '$autordocumento' " ;

        }
        if($formatodocumento != 'all' && $formatodocumento != '')
        {
            $condicionFormato .= " AND taf.Taf_Descripcion = '$formatodocumento' " ;

        }
        if($pais != 'all' && $pais != '')
        {
            $condicionPais .= " AND pai.Pai_Nombre = '$pais' " ;
        }
        if($letra != 'all' && $letra != '')
        {
            $condicionLetra .= " AND dub.Dub_Titulo LIKE '$letra%' " ;
        }

        //Filtro Para usuarios logueados
        $condicionUsuario = " ";
        $condicionEstado = " WHERE Dub_Estado = 1 ";
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        if (!Session::get('autenticado')) {

        } else {
            $condicionEstado = " WHERE (Dub_Estado = 0 OR Dub_Estado = 1 OR Dub_Estado = 2 ) ";
            if ($usuariodocumento && $usuariodocumento != "all") {
                // $condicionEstado = " WHERE (Dub_Estado = 0 OR Dub_Estado = 1 )";
                $condicionUsuario = " AND Usu_IdUsuario = " . Session::get('id_usuario');
                $this->_view->assign('filtrousuario',1);
                $this->_view->assign('usuario',Session::get('usuario'));
            }
            // if ($usuariodocumento == "all") {
            //     $condicionEstado = " WHERE (Dub_Estado = 0 OR Dub_Estado = 1 OR Dub_Estado = 2 ) ";
            // }
        }


        //Union de todas las condiciones
        $condicion .= $condicionEstado.$condicionPalabra.$condicionTema.$condicionTipo.$condicionAutor.$condicionFormato.$condicionPais.$condicionLetra.$condicionUsuario;

        // $condicionPaginar = $condicion . " LIMIT " . $inicioRegistro . "," . CANT_REG_PAG;
        $orderBy = " ORDER BY dub.Dub_Titulo ASC LIMIT " . $inicioRegistro . "," . $filas;

        if ($palabra != 'all' && $palabra != '') {
            $this->_view->assign('palabrabuscada', $palabra);
            $this->_view->assign('resultPalabra', ' del texto <b>"' . $palabra . '"</b>');
        }
        if ($temadocumento != 'all' && $temadocumento != '') {
            $this->_view->assign('filtroTema', $temadocumento);
        }
        if ($tipodocumento != 'all' && $tipodocumento != '') {
            $this->_view->assign('filtroTipo', $tipodocumento);
        }
        if ($autordocumento != 'all' && $autordocumento != '') {
            $this->_view->assign('filtroAutor', $autordocumento);
        }
        if ($formatodocumento != 'all' && $formatodocumento != '') {
            $this->_view->assign('filtroFormato', $formatodocumento);
        }
        if ($pais != 'all' && $pais != '') {
            $this->_view->assign('filtroPais', $pais);
        }
        if ($letra != 'all' && $letra != '') {
            $this->_view->assign('filtroLetra', $letra);
        }


        $paginador = new Paginador();

        $idioma = Cookie::lenguaje();

        $bddublin_index = $this->loadModel('dublin', 'dublincore');
        $bddublin_index->_cambiarEstadoDublin($id_dublin, $valor_estado);

        // $bddublin = $this->loadModel('documentos', 'dublincore');
        // $condicion = " where  Rec_IdRecurso = " . $id_recurso . " and (fn_TraducirContenido('dublincore','Dub_Titulo',dub.Dub_IdDublinCore,'$idioma',dub.Dub_Titulo) LIKE '%$palabra%' OR fn_TraducirContenido('dublincore','Dub_PalabraClave',dub.Dub_IdDublinCore,'$idioma',dub.Dub_PalabraClave) LIKE '%$palabra%' OR fn_TraducirContenido('dublincore','Dub_Descripcion',dub.Dub_IdDublinCore,'$idioma',dub.Dub_Descripcion) LIKE '%$palabra%' OR Aut_Nombre LIKE '%$palabra%')";


        $paginador = new Paginador();
        $this->_view->setJs(array('documentos'));

        $rowCount = $this->_documentos->getDocumentosRowCount($condicion);
        $totalRegistros = $rowCount["CantidadRegistros"];
        $paginador->paginar( $totalRegistros,"resultados", "$palabra", $pagina, $filas, true);

        $this->_view->assign('documentos', $this->_documentos->getDocumentosPaises($condicion,$idioma, $orderBy));

        $this->_view->assign('paises', $this->_documentos->getCantDocumentosPaises($condicion,$idioma));
        $this->_view->assign('totaldocumentos', $this->_documentos->getTotalDocumentos($condicion,$idioma));
        $this->_view->assign('temadocumento', $this->_documentos->getCantidadTemasDocumentos($condicion,$idioma));
        $this->_view->assign('tipodocumento', $this->_documentos->getCantidadTiposDocumentos($condicion,$idioma));
        $this->_view->assign('autores', $this->_documentos->getCantidadAutoresDocumentos($condicion,$idioma));
        $this->_view->assign('formatos', $this->_documentos->getCantidadFormatosDocumentos($condicion,$idioma));

        $this->_view->assign('titulo', 'Buscador - Base de Datos de Documentos');
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->renderizar('ajax/resultados', false, true);
    }
    public function _eliminarDublin()
    {
        $valor_estado = $this->getInt('_Row_Estado');
        $id_dublin = $this->getInt('_Dub_IdDublincore');
        // echo "string"; echo $id_dublin;
        // $pagina = $this->getInt('pagina');
        $palabra = $this->getSql('palabra');
        // $id_recurso = $this->getInt('id_recurso');

        $this->_view->getLenguaje("bd_documentos");
        $this->_view->getLenguaje("bdrecursos_registros");

        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');

        if (!$filas) {
            $filas = CANT_REG_PAG;
        }
        // echo $filas;
        // $palabra = $this->getSql('palabra');
        $temadocumento = $this->getSql('tema');
        $tipodocumento = $this->getSql('tipo');
        $autordocumento = $this->getSql('autor');
        $formatodocumento = $this->getSql('formato');
        $letra = $this->getSql('letra');
        $usuariodocumento = $this->getSql('usuario');
        $pais = $this->getSql('pais');

        $idioma = Cookie::lenguaje();

        if ($pagina > 0) {
            $inicioRegistro = ($pagina - 1) * $filas;
        } else {
            $inicioRegistro = 0;
        }

        $condicion = "";
        $condicionPalabra = "";
        $condicionTema = "";
        $condicionTipo = "";
        $condicionAutor = "";
        $condicionFormato = "";
        $condicionPais = "";
        $condicionLetra = "";

        if($palabra == 'all')
        {
            $palabra = '';
        }

        $trozosPalabra = explode(" ",$palabra);
        $numero = count($trozosPalabra);
        if($numero==1){
            $condicionPalabra .= " and (fn_TraducirContenido('dublincore','Dub_Titulo',dub.Dub_IdDublinCore,'$idioma',dub.Dub_Titulo) LIKE '%$palabra%' OR fn_TraducirContenido('dublincore','Dub_PalabraClave',dub.Dub_IdDublinCore,'$idioma',dub.Dub_PalabraClave) LIKE '%$palabra%' OR fn_TraducirContenido('dublincore','Dub_Descripcion',dub.Dub_IdDublinCore,'$idioma',dub.Dub_Descripcion) LIKE '%$palabra%' OR Aut_Nombre LIKE '%$palabra%') ";
        }
        if($numero>1){
            $condicionPalabra = " AND (MATCH(Dub_Titulo, Dub_Descripcion, Dub_PalabraClave) AGAINST ('%".$palabra."%' IN BOOLEAN MODE) OR MATCH(Aut_Nombre) AGAINST ('%".$palabra."%' IN BOOLEAN MODE)) ";
        }

        if($temadocumento != 'all' && $temadocumento != '')
        {
            $condicionTema .= " AND  fn_TraducirContenido('tema_dublin','Ted_Descripcion',ted.Ted_IdTemaDublin,'$idioma',ted.Ted_Descripcion) = '$temadocumento'";
        }
        if($tipodocumento != 'all' && $tipodocumento != '')
        {
            $condicionTipo .= " AND   fn_TraducirContenido('tipo_dublin','Tid_Descripcion',tid.Tid_IdTipoDublin,'$idioma',tid.Tid_Descripcion) = '$tipodocumento'";
        }
        if($autordocumento != 'all' && $autordocumento != '')
        {
            $condicionAutor .= " AND aut.Aut_Nombre = '$autordocumento' " ;

        }
        if($formatodocumento != 'all' && $formatodocumento != '')
        {
            $condicionFormato .= " AND taf.Taf_Descripcion = '$formatodocumento' " ;

        }
        if($pais != 'all' && $pais != '')
        {
            $condicionPais .= " AND pai.Pai_Nombre = '$pais' " ;
        }
        if($letra != 'all' && $letra != '')
        {
            $condicionLetra .= " AND dub.Dub_Titulo LIKE '$letra%' " ;
        }

        //Filtro Para usuarios logueados
        $condicionUsuario = " ";
        $condicionEstado = " WHERE Dub_Estado = 1 ";
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        if (!Session::get('autenticado')) {

        } else {
            $condicionEstado = " WHERE (Dub_Estado = 0 OR Dub_Estado = 1 OR Dub_Estado = 2 ) ";
            if ($usuariodocumento && $usuariodocumento != "all") {
                // $condicionEstado = " WHERE (Dub_Estado = 0 OR Dub_Estado = 1 )";
                $condicionUsuario = " AND Usu_IdUsuario = " . Session::get('id_usuario');
                $this->_view->assign('filtrousuario',1);
                $this->_view->assign('usuario',Session::get('usuario'));
            }
            // if ($usuariodocumento == "all") {
            //     $condicionEstado = " WHERE (Dub_Estado = 0 OR Dub_Estado = 1 OR Dub_Estado = 2 ) ";
            // }
        }


        //Union de todas las condiciones
        $condicion .= $condicionEstado.$condicionPalabra.$condicionTema.$condicionTipo.$condicionAutor.$condicionFormato.$condicionPais.$condicionLetra.$condicionUsuario;

        // $condicionPaginar = $condicion . " LIMIT " . $inicioRegistro . "," . CANT_REG_PAG;
        $orderBy = " ORDER BY dub.Dub_Titulo ASC LIMIT " . $inicioRegistro . "," . $filas;

        if ($palabra != 'all' && $palabra != '') {
            $this->_view->assign('palabrabuscada', $palabra);
            $this->_view->assign('resultPalabra', ' del texto <b>"' . $palabra . '"</b>');
        }
        if ($temadocumento != 'all' && $temadocumento != '') {
            $this->_view->assign('filtroTema', $temadocumento);
        }
        if ($tipodocumento != 'all' && $tipodocumento != '') {
            $this->_view->assign('filtroTipo', $tipodocumento);
        }
        if ($autordocumento != 'all' && $autordocumento != '') {
            $this->_view->assign('filtroAutor', $autordocumento);
        }
        if ($formatodocumento != 'all' && $formatodocumento != '') {
            $this->_view->assign('filtroFormato', $formatodocumento);
        }
        if ($pais != 'all' && $pais != '') {
            $this->_view->assign('filtroPais', $pais);
        }
        if ($letra != 'all' && $letra != '') {
            $this->_view->assign('filtroLetra', $letra);
        }


        $paginador = new Paginador();

        $idioma = Cookie::lenguaje();

        $bddublin_index = $this->loadModel('dublin', 'dublincore');
        $bddublin_index->_RowEstadoDublinCore($id_dublin, $valor_estado);

        // $bddublin = $this->loadModel('documentos', 'dublincore');
        // $condicion = " where  Rec_IdRecurso = " . $id_recurso . " and (fn_TraducirContenido('dublincore','Dub_Titulo',dub.Dub_IdDublinCore,'$idioma',dub.Dub_Titulo) LIKE '%$palabra%' OR fn_TraducirContenido('dublincore','Dub_PalabraClave',dub.Dub_IdDublinCore,'$idioma',dub.Dub_PalabraClave) LIKE '%$palabra%' OR fn_TraducirContenido('dublincore','Dub_Descripcion',dub.Dub_IdDublinCore,'$idioma',dub.Dub_Descripcion) LIKE '%$palabra%' OR Aut_Nombre LIKE '%$palabra%')";


        $paginador = new Paginador();
        $this->_view->setJs(array('documentos'));

        $rowCount = $this->_documentos->getDocumentosRowCount($condicion);
        $totalRegistros = $rowCount["CantidadRegistros"];
        $paginador->paginar( $totalRegistros,"resultados", "$palabra", $pagina, $filas, true);

        $this->_view->assign('documentos', $this->_documentos->getDocumentosPaises($condicion,$idioma, $orderBy));

        $this->_view->assign('paises', $this->_documentos->getCantDocumentosPaises($condicion,$idioma));
        $this->_view->assign('totaldocumentos', $this->_documentos->getTotalDocumentos($condicion,$idioma));
        $this->_view->assign('temadocumento', $this->_documentos->getCantidadTemasDocumentos($condicion,$idioma));
        $this->_view->assign('tipodocumento', $this->_documentos->getCantidadTiposDocumentos($condicion,$idioma));
        $this->_view->assign('autores', $this->_documentos->getCantidadAutoresDocumentos($condicion,$idioma));
        $this->_view->assign('formatos', $this->_documentos->getCantidadFormatosDocumentos($condicion,$idioma));

        $this->_view->assign('titulo', 'Buscador - Base de Datos de Documentos');
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->renderizar('ajax/resultados', false, true);
    }
    public function descargar($archivo='',$idArchivo)
	{
		// $this->_acl->autenticado();
        $fichero = ROOT_ARCHIVO_FISICO."documentos/".$archivo;
        if (is_readable($fichero)){

            $registro = $this->_documentos->registrarDescarga($this->filtrarTexto($_SERVER['REMOTE_ADDR']),  $this->filtrarInt($idArchivo));

            if (is_array($registro)) {
                if ($registro  [0] > 0) {
                    if (file_exists($fichero)) {
                        header('Content-Description: File Transfer');
                        header('Content-Type: application/octet-stream');
                        header('Content-Disposition: attachment; filename="'.basename($fichero).'"');
                        readfile($fichero);
                        exit;
                    }
                }
            } else {
                $this->_view->assign('_error', $registro );
            }
        }
        $this->redireccionar("error");
    }
}
