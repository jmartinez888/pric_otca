<?php

use App\ForoComentariosEtiqueta;
use App\ForoTematica;
use App\Usuario;

class indexController extends foroController {

    private $_model;

    public function __construct($lang, $url) {
        parent::__construct($lang, $url);
        $this->_model = $this->loadModel('index');
    }

    public function index() {
        $idUsuario = Session::get('id_usuario');

        if(!empty($idUsuario)){
            $Rol_Ckey = $this->_model->getRol_Ckey(Session::get('id_usuario'));
            if(empty($Rol_Ckey)){
                $Rol_Ckey["Rol_Ckey"] = "sin_rol";
            }
        }else{
            $idUsuario = "";
            $Rol_Ckey["Rol_Ckey"]="";
        }

        $this->validarUrlIdioma();
        $this->_view->setTemplate(LAYOUT_FRONTEND);

        $this->_view->getLenguaje("foro_index_index");
        $this->_view->setCss(array("index", "jp-index"));
        $this->_view->setJs(array('index'));

        $lenguaje = Session::get("fileLenguaje");
        $this->_view->assign('titulo', $lenguaje["foro_index_titulo"]);

        $lista_foros = $this->_model->getForosRecientes("%");
        for ($i=0; $i < count($lista_foros); $i++) {
            $lista_foros[$i]["tiempo"]= $lista_foros[$i]["For_FechaCreacion"];
            $votos = $this->_model->getNvaloraciones($lista_foros[$i]["For_IdForo"],'forum');
            $lista_foros[$i]["votos"]= $votos["Nvaloraciones"];
        }

        $lista_tematica = $this->_model->getResumenLineTematica();
        $lista_agenda = $this->_model->getAgendaIndex();
     
        $this->_view->assign('lista_foros', $lista_foros);
        $this->_view->assign('Rol_Ckey', $Rol_Ckey["Rol_Ckey"]);
        $this->_view->assign('lista_tematica', $lista_tematica);
        $this->_view->assign('lista_agenda', $lista_agenda);
        $this->_view->renderizar('index');
    }
    public function searchForo($filtro = "") {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $filtro = $this->filtrarTexto($filtro);
        $this->_view->setJs(array('index'));
        $this->_view->setCss(array("index", "jp-index"));
        $paginador = new Paginador();

        $lista_foros = $this->_model->getForosPaginado($filtro);
        $totalRegistros = $this->_model->getRowForos($filtro);

        $paginador->paginar($totalRegistros["For_NRow"], "listarForo", $filtro, $pagina = 0, CANT_REG_PAG, true);

        $this->_view->assign('lista_foros', $lista_foros);

        $this->_view->assign('palabrabuscada', $filtro);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('searchForo');
    }

    public function forum() {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->assign('titulo', "Discusiones");
        $this->_view->setCss(array("jp-index"));
        $this->_view->setJs(array('buscar_foro'));
        $lista_foros = $this->_model->getForos("forum");
        for ($i=0; $i < count($lista_foros); $i++) {
            $Nvaloraciones_foro = $this->_model->getNvaloraciones($lista_foros[$i]["For_IdForo"],'forum');
            $lista_foros[$i]["Nvaloraciones_foro"]=$Nvaloraciones_foro["Nvaloraciones"];
            $lista_foros[$i]["tiempo"]= $lista_foros[$i]["For_FechaCreacion"];

        }
        $this->_view->assign('lista_foros', $lista_foros);
        $this->_view->renderizar('discussions');
    }

    public function query() {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->assign('titulo', "Consultas");
        $this->_view->setCss(array("jp-index"));
        $this->_view->setJs(array('buscar_foro'));
        $lista_foros = $this->_model->getForos("query");
        for ($i=0; $i < count($lista_foros); $i++) {
            $Nvaloraciones_foro = $this->_model->getNvaloraciones($lista_foros[$i]["For_IdForo"],'forum');
            $lista_foros[$i]["Nvaloraciones_foro"]=$Nvaloraciones_foro["Nvaloraciones"];
            $lista_foros[$i]["tiempo"]= $lista_foros[$i]["For_FechaCreacion"];
        }
        $this->_view->assign('lista_foros', $lista_foros);
        $this->_view->renderizar('query');
    }

    public function webinar() {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setCss(array("jp-index"));
        $this->_view->setJs(array('buscar_foro'));
        $lista_foros = $this->_model->getForos("webinar");
        for ($i=0; $i < count($lista_foros); $i++) {
            $Nvaloraciones_foro = $this->_model->getNvaloraciones($lista_foros[$i]["For_IdForo"],'forum');
            $lista_foros[$i]["Nvaloraciones_foro"]=$Nvaloraciones_foro["Nvaloraciones"];
            $lista_foros[$i]["tiempo"]= $lista_foros[$i]["For_FechaCreacion"];
        }
        $this->_view->assign('lista_foros', $lista_foros);
        $this->_view->renderizar('webinar');
    }

    public function workshop() {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->assign('titulo', "Workshop");
        $this->_view->setCss(array("jp-index"));
        $this->_view->setJs(array('buscar_foro'));
        $lista_foros = $this->_model->getForos("workshop");
        for ($i=0; $i < count($lista_foros); $i++) {
            $Nvaloraciones_foro = $this->_model->getNvaloraciones($lista_foros[$i]["For_IdForo"],'forum');
            $lista_foros[$i]["Nvaloraciones_foro"]=$Nvaloraciones_foro["Nvaloraciones"];
            $lista_foros[$i]["tiempo"]= $lista_foros[$i]["For_FechaCreacion"];
        }
        $this->_view->assign('lista_foros', $lista_foros);
        $this->_view->renderizar('workshop');
    }

    public function _buscarForo($text_busqueda = false, $for_funcion=false, $ajax=false) {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $text_busqueda = $this->getTexto('text_busqueda');
        $for_funcion = $this->getTexto('for_funcion');
        $ajax = $this->getTexto('ajax');

        $this->_view->setJs(array('buscar_foro'));
        // $this->_view->setCss(array("index"));
        // $paginador = new Paginador();

        $lista_foros = $this->_model->getForosPaginado($text_busqueda, $for_funcion);
        for ($i=0; $i < count($lista_foros); $i++) {
            $Nvaloraciones_foro = $this->_model->getNvaloraciones($lista_foros[$i]["For_IdForo"],'forum');
            $lista_foros[$i]["Nvaloraciones_foro"]=$Nvaloraciones_foro["Nvaloraciones"];
            $lista_foros[$i]["tiempo"]= $lista_foros[$i]["For_FechaCreacion"];
        }
        // $totalRegistros = $this->_model->getRowForos($filtro);

        //$paginador->paginar($totalRegistros["For_NRow"], "listarForo", $filtro, $pagina = 0, CANT_REG_PAG, true);

        $this->_view->assign('lista_foros', $lista_foros);

        //$this->_view->assign('palabrabuscada', $text_busqueda);
        //$this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        //$this->_view->assign('cantidadporpagina',$registros);
        //$this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/'.$ajax, false, true);
    }

    public function agenda() {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array('agenda', array(BASE_URL . 'public/js/fullcalendar/moment.min.js'), array(BASE_URL . 'public/js/fullcalendar/fullcalendar.min.js'), array(BASE_URL . 'public/js/fullcalendar/locale/es.js')));
        $this->_view->setCss(array('agenda', 'jp-agenda', array(BASE_URL . "public/css/fullcalendar/fullcalendar.min.css")));
        $this->_view->assign('titulo', "Agenda");
        $this->_view->assign('agenda',json_encode($this->utf8_converter_array($this->_model->getAgenda())));
        $this->_view->renderizar('agenda');
    }
    public function historico() {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->assign('titulo', "Historico");
        $this->_view->setCss(array("historico", "jp-historico"));
        $foro = $this->_model->getHistorico();
        for ($index = 0; $index < count($foro); $index++) {
                $foro[$index]["Archivos"] = $this->_model->getArchivos_x_idforo($foro[$index]["For_IdForo"]);
        }
        $this->_view->assign('lista_foros', $foro);
        $this->_view->renderizar('historico');
    }
    public function statistics() {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setCss(array(
            array('//github.com/downloads/lafeber/world-flags-sprite/flags32.css',true),
            "statistics", "jp-statistics"));
        $this->_view->setJs(array(
           //array('http://code.highcharts.com/highcharts.js', false), //agregado
           //array('http://code.highcharts.com/modules/exporting.js', false), //agregado
           //array('http://code.highcharts.com/modules/export-data.js', false), //agregado
            array('http://code.highcharts.com/maps/highmaps.js', false), //agregado
            array('http://code.highcharts.com/maps/modules/data.js', false), //agregado
            array('http://code.highcharts.com/maps/modules/offline-exporting.js', false), //agregado
            array('http://code.highcharts.com/mapdata/custom/world.js', false), //agregado
            "statistics"
        ));
        $this->_view->assign('titulo', "Estadisticas Foro");

        //$this->_view->assign('StdGeneral', $this->_model->getEstadistcaGeneral());
        $tematicas = ForoTematica::visibles()->get();
        $this->_view->assign('StdTematicas', $tematicas);
        $this->_view->assign('StdCharComentarios',json_encode($this->_model->getComentario_x_Mes()));
        $this->_view->assign('StdActividades',$this->_model->getCantidaFuncionForo());
        $this->_view->assign('StdMapsMembers',json_encode($this->_model->getMiembrosPais()));
        $this->_view->renderizar('statistics');
    }

    public function ficha($iFor_IdForo=0) {

        //Verifica parametro 
        $iFor_IdForo=$this->filtrarInt($iFor_IdForo);

        if ($iFor_IdForo==0) {
            $this->redireccionar("foro");
        }
        $foro = $this->_model->getForo_x_idforo($iFor_IdForo);
        if (empty($foro)) {
            $this->redireccionar("foro");
        }
        $this->validarUrlIdioma();
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->getLenguaje("foro_index_ficha");
        $this->_view->setCss([
            [BASE_URL.'public/vendors/jquery_mentions/css/jquery.mentionsInput.css'],
            "ficha_foro", "jp-ficha_foro"
        ]);
        $this->_view->setJs([
            [BASE_URL.'public/vendors/underscore/underscore-min.js'],
            [BASE_URL.'public/vendors/autosize/autosize.min.js'],
            [BASE_URL.'public/vendors/jquery/js/jquery.elastic.js'],
            [BASE_URL.'public/vendors/jquery/js/jquery.events.input.js'],
            [BASE_URL.'public/vendors/jquery_mentions/js/jquery.mentionsInput.js'],
            "ficha_foro"
        ]);  
        $lenguaje = Session::get("fileLenguaje");

         //Obtener Rol de usuario
        $idUsuario = Session::get('id_usuario');
        if(!empty($idUsuario)){
            $Rol_Ckey = $this->_model->getRolForo($idUsuario, $iFor_IdForo);
            if(empty($Rol_Ckey)){
                $Rol_Ckey = $this->_model->getRol_Ckey($idUsuario);
            }
             $this->_view->assign('Rol_Ckey', $Rol_Ckey["Rol_Ckey"]);
             $this->_view->assign('id_usuario', $idUsuario);
                // echo $Rol_Ckey["Rol_Ckey"]; exit;
        }else{
            $Rol_Ckey["Rol_Ckey"]="";
            $this->_view->assign('Rol_Ckey', "sin permiso");
            $this->_view->assign('id_usuario', 0);
         }
        
        $linea_tematica = $this->_model->getLineaTematica($foro["Lit_IdLineaTematica"]);
        // dd($linea_tematica);
        // echo $linea_tematica["Lit_Nombre"];exit;
        $this->_view->assign('titulo', $lenguaje["foro_ficha_titulo"] . " " . $foro["For_Titulo"]);
        $foro["Archivos"] = $this->_model->getArchivos_x_idforo($iFor_IdForo);
        $foro["For_Comentarios"] = $this->_model->getComentarios_x_idforo($iFor_IdForo);

        if ($foro["For_Funcion"] == "forum") {
            $foro["Sub_Foros"] = $this->_model->getSubForo_x_idforo($iFor_IdForo);
        } else {
            $foro["Sub_Foros"] = array();
        }

        $foro1 = $foro["For_Comentarios"];
        $foro["For_Comentarios"] = array();
        for ($index = 0; $index < count($foro1); $index++) {
            if ($index < CANT_REG_PAG) {
                $foro["For_Comentarios"][$index] = $foro1[$index];
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"] = $this->_model->getComentarios_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);
                $foro["For_Comentarios"][$index]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);

                $valoracion_comentario = $this->_model->getValoracion_personal($idUsuario, $foro["For_Comentarios"][$index]["Com_IdComentario"],'comment');

                $foro["For_Comentarios"][$index]["valoracion_comentario"] = $valoracion_comentario["Nvaloracion_personal"];


                $Nvaloraciones_comentario = $this->_model->getNvaloraciones($foro["For_Comentarios"][$index]["Com_IdComentario"],'comment');

                $foro["For_Comentarios"][$index]["Nvaloraciones_comentario"] = $Nvaloraciones_comentario["Nvaloraciones"];


                $foro2 = $foro["For_Comentarios"][$index]["Hijo_Comentarios"];
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"] = array();

                for ($j = 0; $j < count($foro2); $j++) {

                    if ($j < CANT_REG_PAG) {
                        $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j] = $foro2[$j];

                        $valoracion_comentario = $this->_model->getValoracion_personal($idUsuario, $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"],'comment');
                        $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["valoracion_comentario"] = $valoracion_comentario["Nvaloracion_personal"];

                        $Nvaloraciones_comentario = $this->_model->getNvaloraciones($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"],'comment');
                        $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Nvaloraciones_comentario"] = $Nvaloraciones_comentario["Nvaloraciones"];


                        $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"]);
                    } else {
                        // print_r($foro); exit;
                        break;
                    }
                }
            } else {
                // print_r($foro["For_Comentarios"]); exit;
                break;
            }
        }
        //para mostrar los datos detalles de los subforos
        for ($i=0; $i<count($foro["Sub_Foros"]); $i++) {
            $Nombre_propietario_subforo = $this->_model->getPropietario_foro($foro["Sub_Foros"][$i]["Usu_IdUsuario"]);
            $foro["Sub_Foros"][$i]["Usu_Usuario"] = $Nombre_propietario_subforo["Usu_Nombre"];
            $foro["Sub_Foros"][$i]["tiempo"] = $foro["Sub_Foros"][$i]["For_FechaCreacion"];
            $Nvaloraciones_subforo = $this->_model->getNvaloraciones($foro["Sub_Foros"][$i]["For_IdForo"],'forum');
            $foro["Sub_Foros"][$i]["votos"] = $Nvaloraciones_subforo["Nvaloraciones"];
            $Numero_participantes_subforo = $this->_model->getNumero_participantes_x_idForo($foro["Sub_Foros"][$i]["For_IdForo"]);
            $foro["Sub_Foros"][$i]["For_TParticipantes"] = $Numero_participantes_subforo["numero_participantes"];
            $Numero_comentarios_x_idsubForo = $this->_model->getNumero_comentarios_x_idForo($foro["Sub_Foros"][$i]["For_IdForo"]);
            $foro["Sub_Foros"][$i]["For_TComentarios"] = $Numero_comentarios_x_idsubForo["Numero_comentarios"];
        }

        $Nombre_propietario = $this->_model->getPropietario_foro($foro["Usu_IdUsuario"]);
        $Numero_comentarios_x_idForo = $this->_model->getNumero_comentarios_x_idForo($iFor_IdForo);

        $Numero_participantes_x_idForo = $this->_model->getNumero_participantes_x_idForo($iFor_IdForo);
        $tiempo = $foro["For_FechaCreacion"];
        $Nvaloraciones_foro = $this->_model->getNvaloraciones($iFor_IdForo,'forum');
        $valoracion_foro = $this->_model->getValoracion_personal($idUsuario, $iFor_IdForo,'forum');
       

        //Actvidades
        if ($foro["For_Funcion"] != "query") {
            $_model_admin = $this->loadModel('admin');
            $this->_view->assign('actvidades', $_model_admin->listarActividadForo($iFor_IdForo));
        }
         $this->_view->assign('id_usuario', $idUsuario);
        $this->_view->assign('valoracion_foro', $valoracion_foro["Nvaloracion_personal"]);
        $this->_view->assign('Nvaloraciones_foro',$Nvaloraciones_foro["Nvaloraciones"]);
        $this->_view->assign('Numero_participantes_x_idForo', $Numero_participantes_x_idForo["numero_participantes"]);
        $this->_view->assign('Numero_comentarios_x_idForo', $Numero_comentarios_x_idForo["Numero_comentarios"]);
        $this->_view->assign('nombre_usuario', $Nombre_propietario["Usu_Usuario"]);
        $this->_view->assign('tiempo', $tiempo);
        $this->_view->assign('Rol_Ckey', $Rol_Ckey["Rol_Ckey"]);
        $this->_view->assign('linea_tematica', $linea_tematica["Lit_Nombre"]);
        $this->_view->assign('linea_tematica_url', BASE_URL.Cookie::lenguaje().'/foro/tematica/detalles/'.$linea_tematica["Lit_IdLineaTematica"]);
        $this->_view->assign('facilitadores', $this->_model->getFacilitadores($iFor_IdForo));
        $this->_view->assign('comentar_foro', $this->_permiso($iFor_IdForo, "comentar_foro"));

        $this->_view->assign('foro', $foro);
        $this->_view->renderizar('ficha_foro');
    }

    public function _paginacion_listarComentarios()
    {
        $pagina         = $this->getInt('pagina');
        $filas          = $this->getInt('filas');
        $totalRegistros = $this->getInt('total_registros');
        //Variables de Ajax_JavaScript
        $this->validarUrlIdioma();

        $idUsuario = Session::get('id_usuario');
        if(!empty($idUsuario)){
            $Rol_Ckey = $this->_model->getRolForo(Session::get('id_usuario'), $iFor_IdForo);
            if(empty($Rol_Ckey)){
                $Rol_Ckey = $this->_model->getRol_Ckey(Session::get('id_usuario'));
                if(empty($Rol_Ckey)){
                    $Rol_Ckey["Rol_Ckey"] = "sin_rol";
                }
            }
            $valoracion_foro = $this->_model->getValoracion_personal($idUsuario, $iFor_IdForo,'forum');
            $this->_view->assign('valoracion_foro', $valoracion_foro["Nvaloracion_personal"]);
        }else{
            $idUsuario = "";
            $Rol_Ckey["Rol_Ckey"]="";

        }
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->getLenguaje("foro_index_ficha");
        $this->_view->setCss(array("ficha_foro", "jp-ficha_foro"));
        $this->_view->setJs(array("ficha_foro"));

        $lenguaje = Session::get("fileLenguaje");

        $paginador = new Paginador();
        $paginador->paginar($totalRegistros, "listarComentarios", "", $pagina, $filas, true);

        $foro = $this->_model->getForo_x_idforo($iFor_IdForo);
        $linea_tematica = $this->_model->getLineaTematica($foro["Lit_IdLineaTematica"]);
        // echo $linea_tematica["Lit_Nombre"];exit;
        $this->_view->assign('titulo', $lenguaje["foro_ficha_titulo"] . " " . $foro["For_Titulo"]);
        $foro["Archivos"] = $this->_model->getArchivos_x_idforo($iFor_IdForo);
        $foro["For_Comentarios"] = $this->_model->getComentarios_x_idforo($iFor_IdForo, $pagina, $filas);

        if ($foro["For_Funcion"] == "forum") {
            $foro["Sub_Foros"] = $this->_model->getSubForo_x_idforo($iFor_IdForo);
        } else {
            $foro["Sub_Foros"] = array();
        }

        for ($index = 0; $index < count($foro["For_Comentarios"]); $index++) {
            $foro["For_Comentarios"][$index]["Hijo_Comentarios"] = $this->_model->getComentarios_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);
            $foro["For_Comentarios"][$index]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);

            $valoracion_comentario = $this->_model->getValoracion_personal($idUsuario, $foro["For_Comentarios"][$index]["Com_IdComentario"],'comment');
            $foro["For_Comentarios"][$index]["valoracion_comentario"] = $valoracion_comentario["Nvaloracion_personal"];

            $Nvaloraciones_comentario = $this->_model->getNvaloraciones($foro["For_Comentarios"][$index]["Com_IdComentario"],'comment');
            $foro["For_Comentarios"][$index]["Nvaloraciones_comentario"] = $Nvaloraciones_comentario["Nvaloraciones"];

            for ($j = 0; $j < count($foro["For_Comentarios"][$index]["Hijo_Comentarios"]); $j++) {

                $valoracion_comentario = $this->_model->getValoracion_personal($idUsuario, $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"],'comment');
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["valoracion_comentario"] = $valoracion_comentario["Nvaloracion_personal"];

                $Nvaloraciones_comentario = $this->_model->getNvaloraciones($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"],'comment');
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Nvaloraciones_comentario"] = $Nvaloraciones_comentario["Nvaloraciones"];


                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"]);
            }
        }

        $Nombre_propietario = $this->_model->getPropietario_foro($foro["Usu_IdUsuario"]);
        $Numero_comentarios_x_idForo = $this->_model->getNumero_comentarios_x_idForo($iFor_IdForo);
        $Numero_participantes_x_idForo = $this->_model->getNumero_participantes_x_idForo($iFor_IdForo);

        $tiempo = $foro["For_FechaCreacion"];

        $Nvaloraciones_foro = $this->_model->getNvaloraciones($iFor_IdForo,'forum');

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));

        $this->_view->assign('Nvaloraciones_foro', $Nvaloraciones_foro["Nvaloraciones"]);
        $this->_view->assign('Numero_participantes_x_idForo', $Numero_participantes_x_idForo["numero_participantes"]);
        $this->_view->assign('Numero_comentarios_x_idForo', $Numero_comentarios_x_idForo["Numero_comentarios"]);
        $this->_view->assign('nombre_usuario', $Nombre_propietario["Usu_Nombre"]);
        $this->_view->assign('tiempo', $tiempo);
        $this->_view->assign('Rol_Ckey', $Rol_Ckey["Rol_Ckey"]);
        $this->_view->assign('linea_tematica', $linea_tematica["Lit_Nombre"]);
        $this->_view->assign('facilitadores', $this->_model->getFacilitadores($iFor_IdForo));
        $this->_view->assign('comentar_foro', $this->_permiso($iFor_IdForo, "comentar_foro"));

        $this->_view->assign('foro', $foro);
        $this->_view->renderizar('ficha_foro');
    }

    public function ValorarForo()
    {
        $id_foro = $this->getInt('id_foro');
        $id_usuario = $this->getInt('id_usuario');
        $objeto = $this->getTexto('objeto');
        $valor = $this->getInt('valor');

        $result = $this->_model->registrarValoracion_Comentario_Foro($id_usuario,$id_foro,$objeto,$valor);
        
        $Nvaloraciones_foro = $this->_model->getNvaloraciones($id_foro,$objeto);


        $valoracion_foro = $this->_model->getValoracion_personal($id_usuario,$id_foro,$objeto);
        
        $this->_view->assign('valoracion_foro', $valoracion_foro["Nvaloracion_personal"]);
        
        $foro=["For_IdForo"=>$id_foro];
        $this->_view->assign('foro', $foro);
        $this->_view->assign('id_usuario', $id_usuario);
        $this->_view->assign('Nvaloraciones_foro', $Nvaloraciones_foro["Nvaloraciones"]);
        $this->_view->renderizar('ajax/valoraciones_foro', false, true);

    }

    public function registrarValoracion_Comentario_Foro()
    {
        $id_usuario = $this->getInt('id_usuario');
        $ID = $this->getInt('ID');
        $objeto = $this->getTexto('objeto');
        $valor = $this->getInt('valor');
        $ajaxtpl = $this->getTexto('ajaxtpl');


        //echo "idUsuario:".$id_usuario . " idregistro: " . $ID . " valor: ". $valor . " ajax: " . $ajaxtpl." objeto: ".$objeto; exit;

        $result = $this->_model->registrarValoracion_Comentario_Foro($id_usuario, $ID,$objeto, $valor);//inserta el me gusta
       
        $Nvaloraciones = $this->_model->getNvaloraciones($ID,'comment');
   
        $valoracion = $this->_model->getValoracion_personal($id_usuario,$ID,$objeto);

       // $this->_view->assign('valoracion_comentario', $valoracion_comentario["Nvaloraciones_x_comentario"]);
        // $foro=["For_IdForo"=>$id_comentario];
        // $this->_view->assign('foro', $foro);
        $comentarios=["Nvaloraciones_comentario"=>$Nvaloraciones["Nvaloraciones"],
                    "Com_IdComentario"=>$ID,
                    "objeto"=>"comment",
                    "valoracion_comentario"=>$valoracion["Nvaloracion_personal"]];

        $foro=["For_IdForo"=>$ID];
        $this->_view->assign('foro', $foro);
        $this->_view->assign('id_usuario', $id_usuario);
        $this->_view->assign('valoracion_foro', $valoracion["Nvaloracion_personal"]);
        $this->_view->assign('Nvaloraciones_foro',$Nvaloraciones["Nvaloraciones"]);

        $this->_view->assign('comment_like', $comentarios);

        // $this->_view->assign('Nvaloraciones_comentario', $Nvaloraciones_comentario["Nvaloraciones_comentario"]);
        $this->_view->renderizar('ajax/'.$ajaxtpl, false, true);

    }

    
    public function ficha_comentario_completo($iFor_IdForo=0, $iCom_IdComentario=0) {

        //Verifica parametro 
        $iFor_IdForo=$this->filtrarInt($iFor_IdForo);
        $iCom_IdComentario=$this->filtrarInt($iCom_IdComentario);

        if ($iFor_IdForo==0 || $iCom_IdComentario==00) {
            $this->redireccionar("foro");
        }
        $foro = $this->_model->getForo_x_idforo($iFor_IdForo);
        if (empty($foro)) {
            $this->redireccionar("foro");
        }

        $this->validarUrlIdioma();

         $idUsuario = Session::get('id_usuario');
        if(!empty($idUsuario)){
            $Rol_Ckey = $this->_model->getRolForo($idUsuario, $iFor_IdForo);
            if(empty($Rol_Ckey)){
                $Rol_Ckey = $this->_model->getRol_Ckey($idUsuario);
                if(empty($Rol_Ckey)){
                    $Rol_Ckey["Rol_Ckey"] = "sin_rol";
                }
            }
             $this->_view->assign('Rol_Ckey', $Rol_Ckey["Rol_Ckey"]);
             $this->_view->assign('id_usuario', $idUsuario);
                // echo $Rol_Ckey["Rol_Ckey"]; exit;
        }else{
            $Rol_Ckey["Rol_Ckey"]="";
            $this->_view->assign('Rol_Ckey', "");
            $this->_view->assign('id_usuario', 0);
         }

       
        //print_r($usuario_foro);
        // echo $Rol_Ckey["Rol_Ckey"]; exit;
        // exit;
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->getLenguaje("foro_index_ficha");
        $this->_view->setCss([
            [BASE_URL.'public/vendors/jquery_mentions/css/jquery.mentionsInput.css'],
            "ficha_foro", "jp-ficha_foro"
        ]);
        $this->_view->setJs([
            [BASE_URL.'public/vendors/underscore/underscore-min.js'],
            [BASE_URL.'public/vendors/autosize/autosize.min.js'],
            [BASE_URL.'public/vendors/jquery/js/jquery.elastic.js'],
            [BASE_URL.'public/vendors/jquery/js/jquery.events.input.js'],
            [BASE_URL.'public/vendors/jquery_mentions/js/jquery.mentionsInput.js'],
            "ficha_foro"
        ]);         

        $lenguaje = Session::get("fileLenguaje");
        
        $this->_view->assign('titulo', $lenguaje["foro_ficha_titulo"] . " " . $foro["For_Titulo"]);
        $foro["Archivos"] = $this->_model->getArchivos_x_idforo($iFor_IdForo);
        $foro["For_Comentarios"] = array($this->_model->getComentario_x_idforo($iFor_IdForo,$iCom_IdComentario));

            $foro["For_Comentarios"][0]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][0]["Com_IdComentario"]);

            $valoracion_comentario = $this->_model->getValoracion_personal($idUsuario, $foro["For_Comentarios"][0]["Com_IdComentario"],'comment');

            $foro["For_Comentarios"][0]["valoracion_comentario"] = $valoracion_comentario["Nvaloracion_personal"];


            $Nvaloraciones_comentario = $this->_model->getNvaloraciones($foro["For_Comentarios"][0]["Com_IdComentario"],'comment');

            $foro["For_Comentarios"][0]["Nvaloraciones_comentario"] = $Nvaloraciones_comentario["Nvaloraciones"];
           
            $foro["For_Comentarios"][0]["Hijo_Comentarios"] = array();   
          

        
        $nombre_usuario=$this->_model->getPropietario_foro($foro["Usu_IdUsuario"]);
        $Numero_participantes_x_idForo = $this->_model->getNumero_participantes_x_idForo($iFor_IdForo);

        $this->_view->assign('Numero_participantes_x_idForo', $Numero_participantes_x_idForo["numero_participantes"]);
        $this->_view->assign('nombre_usuario', $nombre_usuario["Usu_Usuario"]);
        $this->_view->assign('iCom_IdComentario', $iCom_IdComentario);
        $this->_view->assign('Rol_Ckey', $Rol_Ckey["Rol_Ckey"]);
        $this->_view->assign('facilitadores', $this->_model->getFacilitadores($iFor_IdForo));
        $this->_view->assign('comentar_foro', $this->_permiso($iFor_IdForo, "comentar_foro"));

        $this->_view->assign('foro', $foro);
        $this->_view->renderizar('comentario_completo');
    }

    public function ReportarComentario()
    {
        header("access-control-allow-origin: *");
        // echo $mensaje; exit;
        $iFor_IdForo = $this->getInt('id_foro');
        $iCom_IdComentario = $this->getTexto('iCom_IdComentario');
        $mensaje = $this->getTexto('mensaje');
        $Emails = $this->_model->getEmails_usuarios_x_foro($iFor_IdForo);

        $idUsuario = Session::get('id_usuario');
        if(!empty($idUsuario)){
            $Rol_Ckey = $this->_model->getRolForo(Session::get('id_usuario'), $iFor_IdForo);
            if(empty($Rol_Ckey)){
                $Rol_Ckey = $this->_model->getRol_Ckey(Session::get('id_usuario'));
                if(empty($Rol_Ckey)){
                    $Rol_Ckey["Rol_Ckey"] = "sin_rol";
                }
            }
        }else{
            $Rol_Ckey["Rol_Ckey"]="";
        }
        // echo $Emails[0][0];
        // echo $Emails[1][0];
        // echo $Emails[2][0]; exit;

        $obj = new Request();
        $Correo = new Correo();
        // echo $obj->getModulo();exit;
        // echo count($Emails); exit;

        $url = BASE_URL.$obj->getModulo().'/'.$obj->getControlador().'/ficha_comentario_completo/'.$iFor_IdForo.'/'.$iCom_IdComentario;
        //$email = $Email[0];
        //echo $email; exit;
        $Subject = 'REPORTE DE COMENTARIO';
        $contenido = 'Un usuario a reportado un comentario con el siquiente mensaje: '.$mensaje. '. Le recomendamos verificarlo en el siguiente enlace: '. "<a href=" . $url .">" .$url. "</a>";
        $fromName = '¡PRIC - Un usuario a reportado un comentario!';

        for ($i=0; $i < count($Emails); $i++) {
            $SendCorreo = $Correo->enviar($Emails[$i][0], "", $Subject, $contenido, $fromName);
        }
        //$this->_view->assign('url', $url);

        $foro = $this->_model->getForo_x_idforo($iFor_IdForo);

        $foro["Archivos"] = $this->_model->getArchivos_x_idforo($iFor_IdForo);
        $foro["For_Comentarios"] = $this->_model->getComentarios_x_idforo($iFor_IdForo);


        for ($index = 0; $index < count($foro["For_Comentarios"]); $index++) {
            $foro["For_Comentarios"][$index]["Hijo_Comentarios"] = $this->_model->getComentarios_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);
            $foro["For_Comentarios"][$index]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);

            $valoracion_comentario = $this->_model->getValoracion_personal($idUsuario, $foro["For_Comentarios"][$index]["Com_IdComentario"],'comment');
            $foro["For_Comentarios"][$index]["valoracion_comentario"] = $valoracion_comentario["Nvaloracion_personal"];

            $Nvaloraciones_comentario = $this->_model->getNvaloraciones($foro["For_Comentarios"][$index]["Com_IdComentario"],'comment');
            $foro["For_Comentarios"][$index]["Nvaloraciones_comentario"] = $Nvaloraciones_comentario["Nvaloraciones"];

            for ($j = 0; $j < count($foro["For_Comentarios"][$index]["Hijo_Comentarios"]); $j++) {

                $valoracion_comentario = $this->_model->getValoracion_personal($idUsuario, $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"],'comment');
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["valoracion_comentario"] = $valoracion_comentario["Nvaloracion_personal"];

                $Nvaloraciones_comentario = $this->_model->getNvaloraciones($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"],'comment');
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Nvaloraciones_comentario"] = $Nvaloraciones_comentario["Nvaloraciones"];


                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"]);
            }
        }
        $Nvaloraciones_foro = $this->_model->getNvaloraciones($iFor_IdForo,'forum');

        $this->_view->assign('Nvaloraciones_foro', $Nvaloraciones_foro["Nvaloraciones"]);
        $this->_view->assign('Rol_Ckey', $Rol_Ckey["Rol_Ckey"]);
        $this->_view->assign('comentar_foro', $this->_permiso($iFor_IdForo, "comentar_foro"));
        $this->_view->assign('foro', $foro);
        $this->_view->renderizar('ajax/lista_comentarios', false, true);
    }
    public function _mencionar_usuario () {
        header("access-control-allow-origin: *");
        $usuarios = [];
        if ($this->has('q') && ($query = trim($this->getTexto('q'))) != ''){

            $usuarios = Usuario::buscar($query)->para_mencion()->get()->map(function($item) {

                return [
                    'id' => $item->Usu_IdUsuario,
                    'name' => $item->Usu_Nombre.' '.$item->Usu_Apellidos,
                    'avatar' => 'http://cdn0.4dots.com/i/customavatars/avatar7112_1.gif',
                    'type' => 'contact'
                ];
            })->toArray();
        }
        $this->_view->responseJson($usuarios);
    }
    public function _registro_comentario() {
        // dd($_POST);
        header("access-control-allow-origin: *");
        #$this->_acl->acceso('registro_actividad_tarea');
        $iFor_IdForo = $this->getInt('id_foro');
        $iUsu_IdUsuario = $this->getInt('id_usuario');
        $iCom_Descripcion = $this->getTexto('descripcion');
        $iCom_IdPadre = $this->getInt('id_padre');
        $idUsuario = Session::get('id_usuario');
        if(!empty($idUsuario)){
            $Rol_Ckey = $this->_model->getRolForo(Session::get('id_usuario'), $iFor_IdForo);
            if(empty($Rol_Ckey)){
                $Rol_Ckey = $this->_model->getRol_Ckey(Session::get('id_usuario'));
                if(empty($Rol_Ckey)){
                    $Rol_Ckey["Rol_Ckey"] = "sin_rol";
                }
            }
            $valoracion_foro = $this->_model->getValoracion_personal($idUsuario, $iFor_IdForo,'forum');
            $this->_view->assign('valoracion_foro', $valoracion_foro["Nvaloracion_personal"]);
        }else{
            $Rol_Ckey["Rol_Ckey"]="";
        }
        $iFim_Files = html_entity_decode($this->getTexto('att_files'));

        $aFim_Files = json_decode($iFim_Files, true);



        $result = $this->_model->registrarComentario($iFor_IdForo, $iUsu_IdUsuario, $iCom_Descripcion, $iCom_IdPadre);

        $comentario_id = $result[0];


        if ($this->has('tag_usuarios')) {
            if (is_array($_POST['tag_usuarios'])) {
                foreach ($_POST['tag_usuarios'] as $value) {
                    ForoComentariosEtiqueta::insertar($comentario_id, $value);
                }
            }
        }

        // foreach ($variable as $key => $value) {
        //     # code...
        // }

        // print_r($result); exit;
        // echo $result[0]; exit;
        foreach ($aFim_Files as $key => $value) {
            $result_e = $this->_model->insertarFileComentario($value["name"], $value["type"], $value["size"], $result[0], 0);
        }


        $foro = $this->_model->getForo_x_idforo($iFor_IdForo);

        $foro["Archivos"] = $this->_model->getArchivos_x_idforo($iFor_IdForo);
        $foro["For_Comentarios"] = $this->_model->getComentarios_x_idforo($iFor_IdForo);


        for ($index = 0; $index < count($foro["For_Comentarios"]); $index++) {
            $foro["For_Comentarios"][$index]["Hijo_Comentarios"] = $this->_model->getComentarios_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);
            $foro["For_Comentarios"][$index]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);

            $valoracion_comentario = $this->_model->getValoracion_personal($idUsuario, $foro["For_Comentarios"][$index]["Com_IdComentario"],'comment');
            $foro["For_Comentarios"][$index]["valoracion_comentario"] = $valoracion_comentario["Nvaloracion_personal"];

            $Nvaloraciones_comentario = $this->_model->getNvaloraciones($foro["For_Comentarios"][$index]["Com_IdComentario"],'comment');
            $foro["For_Comentarios"][$index]["Nvaloraciones_comentario"] = $Nvaloraciones_comentario["Nvaloraciones"];

            for ($j = 0; $j < count($foro["For_Comentarios"][$index]["Hijo_Comentarios"]); $j++) {

                $valoracion_comentario = $this->_model->getValoracion_personal($idUsuario, $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"],'comment');
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["valoracion_comentario"] = $valoracion_comentario["Nvaloracion_personal"];

                $Nvaloraciones_comentario = $this->_model->getNvaloraciones($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"],'comment');
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Nvaloraciones_comentario"] = $Nvaloraciones_comentario["Nvaloraciones"];


                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"]);
            }
        }
        $Nvaloraciones_foro = $this->_model->getNvaloraciones($iFor_IdForo,'forum');

        $this->_view->assign('Nvaloraciones_foro', $Nvaloraciones_foro["Nvaloraciones"]);
        $this->_view->assign('Rol_Ckey', $Rol_Ckey["Rol_Ckey"]);
        $this->_view->assign('comentar_foro', $this->_permiso($iFor_IdForo, "comentar_foro"));
        $this->_view->assign('foro', $foro);
        $this->_view->renderizar('ajax/lista_comentarios', false, true);
    }

    public function _eliminar_comentario()
    {
        // echo "hola"; exit;
        $iFor_IdForo = $this->getInt('id_foro');
        $iCom_IdComentario = $this->getInt('id_comentario');
        $tpl = $this->getTexto('tpl');
        //echo $iCom_IdComentario."hola"; exit;
        $this->_model->eliminarComentario($iCom_IdComentario, 0);
        // echo $iFor_IdForo. " " .$iCom_IdComentario; exit;
        $idUsuario = Session::get('id_usuario');
        if(!empty($idUsuario)){
            $Rol_Ckey = $this->_model->getRolForo(Session::get('id_usuario'), $iFor_IdForo);
            if(empty($Rol_Ckey)){
                $Rol_Ckey = $this->_model->getRol_Ckey(Session::get('id_usuario'));
                if(empty($Rol_Ckey)){
                    $Rol_Ckey["Rol_Ckey"] = "sin_rol";
                }
            }
            $valoracion_foro = $this->_model->getValoracion_personal($idUsuario, $iFor_IdForo,'forum');
            $this->_view->assign('valoracion_foro', $valoracion_foro["Nvaloracion_personal"]);
        }else{
            $Rol_Ckey["Rol_Ckey"]="";
        }
        //print_r($usuario_foro);
        // echo $Rol_Ckey["Rol_Ckey"]; exit;
        // exit;
        $foro = $this->_model->getForo_x_idforo($iFor_IdForo);

        $foro["Archivos"] = $this->_model->getArchivos_x_idforo($iFor_IdForo);
        $foro["For_Comentarios"] = $this->_model->getComentarios_x_idforo($iFor_IdForo);


        for ($index = 0; $index < count($foro["For_Comentarios"]); $index++) {
            $foro["For_Comentarios"][$index]["Hijo_Comentarios"] = $this->_model->getComentarios_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);
            $foro["For_Comentarios"][$index]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);

            $valoracion_comentario = $this->_model->getValoracion_personal($idUsuario, $foro["For_Comentarios"][$index]["Com_IdComentario"],'comment');
            $foro["For_Comentarios"][$index]["valoracion_comentario"] = $valoracion_comentario["Nvaloracion_personal"];

            $Nvaloraciones_comentario = $this->_model->getNvaloraciones($foro["For_Comentarios"][$index]["Com_IdComentario"],'comment');
            $foro["For_Comentarios"][$index]["Nvaloraciones_comentario"] = $Nvaloraciones_comentario["Nvaloraciones"];

            for ($j = 0; $j < count($foro["For_Comentarios"][$index]["Hijo_Comentarios"]); $j++) {

                $valoracion_comentario = $this->_model->getValoracion_personal($idUsuario, $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"],'comment');
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["valoracion_comentario"] = $valoracion_comentario["Nvaloracion_personal"];

                $Nvaloraciones_comentario = $this->_model->getNvaloraciones($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"],'comment');
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Nvaloraciones_comentario"] = $Nvaloraciones_comentario["Nvaloraciones"];


                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"]);
            }
        }

        $Nvaloraciones_foro = $this->_model->getNvaloraciones($iFor_IdForo,'forum');

        $this->_view->assign('Nvaloraciones_foro', $Nvaloraciones_foro["Nvaloraciones"]);
        $this->_view->assign('Rol_Ckey', $Rol_Ckey["Rol_Ckey"]);
        $this->_view->assign('comentar_foro', $this->_permiso($iFor_IdForo, "comentar_foro"));
        $this->_view->assign('foro', $foro);
        if($tpl == "ficha_foro"){
            $this->_view->renderizar('ajax/lista_comentarios', false, true);
        }
    }

    public function _editar_comentario() {

        header("access-control-allow-origin: *");
        #$this->_acl->acceso('registro_actividad_tarea');
        $iFor_IdForo = $this->getInt('id_foro');
        $iUsu_IdUsuario = $this->getInt('id_usuario');
        $iCom_Descripcion = $this->getTexto('descripcion');
        $iCom_IdPadre = $this->getInt('id_padre');
        $iCom_IdComentario = $this->getInt('iCom_IdComentario');
        $iFim_Files = html_entity_decode($this->getTexto('att_files'));
        $tpl = $this->getTexto('tpl');
        $Fim_IdForo = explode(",", $this->getTexto('Fim_IdForo'));

        $aFim_Files = json_decode($iFim_Files, true);

        $idUsuario = Session::get('id_usuario');
        if(!empty($idUsuario)){
            $Rol_Ckey = $this->_model->getRolForo(Session::get('id_usuario'), $iFor_IdForo);
            if(empty($Rol_Ckey)){
                $Rol_Ckey = $this->_model->getRol_Ckey(Session::get('id_usuario'));
                if(empty($Rol_Ckey)){
                    $Rol_Ckey["Rol_Ckey"] = "sin_rol";
                }
            }
            $valoracion_foro = $this->_model->getValoracion_personal($idUsuario, $iFor_IdForo,'forum');
            $this->_view->assign('valoracion_foro', $valoracion_foro["Nvaloracion_personal"]);
        }else{
            $Rol_Ckey["Rol_Ckey"]="";
        }

        //print_r($Fim_IdForo); exit;
        //print_r($usuario_foro);
        // echo $Rol_Ckey["Rol_Ckey"]; exit;
        // exit;

        $result = $this->_model->editarComentario($iCom_IdComentario, $iCom_Descripcion);
        // echo $result[0]; exit;

        for ($i=0; $i < count($Fim_IdForo); $i++) {
            $result_a = $this->_model->eliminar_archivos_comentario($Fim_IdForo[$i]);
        }

        foreach ($aFim_Files as $key => $value) {
            $result_e = $this->_model->insertarFileComentario($value["name"], $value["type"], $value["size"], $iCom_IdComentario, 0);
        }

        $foro = $this->_model->getForo_x_idforo($iFor_IdForo);

        $foro["Archivos"] = $this->_model->getArchivos_x_idforo($iFor_IdForo);
        $foro["For_Comentarios"] = $this->_model->getComentarios_x_idforo($iFor_IdForo);


        for ($index = 0; $index < count($foro["For_Comentarios"]); $index++) {
            $foro["For_Comentarios"][$index]["Hijo_Comentarios"] = $this->_model->getComentarios_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);
            $foro["For_Comentarios"][$index]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);

            $valoracion_comentario = $this->_model->getValoracion_personal($idUsuario, $foro["For_Comentarios"][$index]["Com_IdComentario"],'comment');
            $foro["For_Comentarios"][$index]["valoracion_comentario"] = $valoracion_comentario["Nvaloracion_personal"];

            $Nvaloraciones_comentario = $this->_model->getNvaloraciones($foro["For_Comentarios"][$index]["Com_IdComentario"],'comment');
            $foro["For_Comentarios"][$index]["Nvaloraciones_comentario"] = $Nvaloraciones_comentario["Nvaloraciones"];

            for ($j = 0; $j < count($foro["For_Comentarios"][$index]["Hijo_Comentarios"]); $j++) {

                $valoracion_comentario = $this->_model->getValoracion_personal($idUsuario, $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"],'comment');
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["valoracion_comentario"] = $valoracion_comentario["Nvaloracion_personal"];

                $Nvaloraciones_comentario = $this->_model->getNvaloraciones($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"],'comment');
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Nvaloraciones_comentario"] = $Nvaloraciones_comentario["Nvaloraciones"];


                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"]);
            }
        }
        $Nvaloraciones_foro = $this->_model->getNvaloraciones($iFor_IdForo,'forum');

        $this->_view->assign('Nvaloraciones_foro', $Nvaloraciones_foro["Nvaloraciones"]);
        $this->_view->assign('Rol_Ckey', $Rol_Ckey["Rol_Ckey"]);
        $this->_view->assign('comentar_foro', $this->_permiso($iFor_IdForo, "comentar_foro"));
        $this->_view->assign('foro', $foro);
        // echo "hola"; exit;
        if($tpl == "ficha_foro"){
            $this->_view->renderizar('ajax/lista_comentarios', false, true);
        }
        //   else{
        //     if ($tpl == "comentario_completo") {
        //         $this->redireccionar("foro/index/ficha_comentario_completo/".$iFor_IdForo."/".$iCom_IdComentario);
        //     }
        // }
    }

    public function _inscribir_participante_foro() {
        $iFor_IdForo = $this->getInt('id_foro');
        $iUsu_IdUsuario = Session::get('id_usuario');
        $iRol_IdRol = $this->_acl->getIdRol_x_ckey("participante_foro");
        if (!$this->_acl->rol($iRol_IdRol["Rol_IdRol"])) {
            $model_usuario = $this->loadModel('usuario', 'usuarios');
            $model_usuario->replaceRolUsuario($iUsu_IdUsuario, $iRol_IdRol["Rol_IdRol"]);
        }
        $result = $this->_model->inscribir_participante_foro($iFor_IdForo, $iUsu_IdUsuario, $iRol_IdRol["Rol_IdRol"], 1);
        echo json_encode(["id_foro" => $iFor_IdForo, "url" => $this->_url], true);
    }



    public function _load_file_coment() {
        $file = $_FILES;
        $src = ROOT_ARCHIVO_FISICO;
        if (!is_dir($src))
            mkdir($src, 0777,true);

        $result = array();
        foreach ($file as $key => $value) {
            if ($file && move_uploaded_file($value['tmp_name'], $src . $value["name"])) {
                $result[$key] = ["id" => $key, "name" => $value["name"], "type" => $value["type"], "size" => $value["size"], "url" => $src . $value["name"]];
            } else {
                $result[$key] = false;
            }
        }

        echo json_encode($result);
        //comprobamos si existe un directorio para subir el archivo
    }

    public function _getEstadistcaGeneral(){
        $sdt=$this->_model->getEstadistcaGeneral();

        echo json_encode($sdt);
    }
}

?>