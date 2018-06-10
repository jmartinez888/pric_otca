<?php

class indexController extends foroController {

    private $_model;

    public function __construct($lang, $url) {
        parent::__construct($lang, $url);
        $this->_model = $this->loadModel('index');
    }

    public function index() {
        $this->validarUrlIdioma();
        $this->_view->setTemplate(LAYOUT_FRONTEND);

        $this->_view->getLenguaje("foro_index_index");
        $this->_view->setCss(array("index", "jp-index"));


        $lenguaje = Session::get("fileLenguaje");
        $this->_view->assign('titulo', $lenguaje["foro_index_titulo"]);

        $lista_foros = $this->_model->getForosRecientes("%");
        $lista_tematica = $this->_model->getResumenLineTematica();
        $lista_agenda = $this->_model->getAgendaIndex();
        $this->_view->assign('lista_foros', $lista_foros);      
        $this->_view->assign('lista_tematica', $lista_tematica);  
        $this->_view->assign('lista_agenda', $lista_agenda);
        
        
        $this->_view->renderizar('index');
    }

    public function discussions() {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setCss(array("jp-index"));
        $this->_view->assign('lista_foros', $this->_model->getForos("forum"));
        $this->_view->renderizar('discussions');
    }

    public function query() {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setCss(array("jp-index"));
        $this->_view->assign('lista_foros', $this->_model->getForos("query"));
        $this->_view->renderizar('query');
    }

    public function webinar() {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setCss(array("jp-index"));
        $this->_view->assign('lista_foros', $this->_model->getForos("webinar"));
        $this->_view->renderizar('webinar');
    }

    public function workshop() {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setCss(array("jp-index"));
        $this->_view->assign('lista_foros', $this->_model->getForos("workshop"));
        $this->_view->renderizar('workshop');
    }

    public function agenda() {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array('agenda', array(BASE_URL . 'public/js/fullcalendar/moment.min.js'), array(BASE_URL . 'public/js/fullcalendar/fullcalendar.min.js'), array(BASE_URL . 'public/js/fullcalendar/locale/es.js')));
        $this->_view->setCss(array('agenda', 'jp-agenda', array(BASE_URL . "public/css/fullcalendar/fullcalendar.min.css")));

        $this->_view->assign('agenda',json_encode($this->_model->getAgenda()));
        $this->_view->renderizar('agenda');
    }
    public function historico() {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setCss(array("historico"));
        $this->_view->assign('lista_foros', $this->_model->getHistorico());
        $this->_view->renderizar('historico');
    }
    public function statistics() {
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setCss(array(
            array('//github.com/downloads/lafeber/world-flags-sprite/flags32.css',true),
            "statistics"));
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
        
        $this->_view->assign('StdGeneral', $this->_model->getEstadistcaGeneral());
        $this->_view->assign('StdCharComentarios',json_encode($this->_model->getComentario_x_Mes()));
        $this->_view->assign('StdActividades',$this->_model->getCantidaFuncionForo());
        $this->_view->assign('StdMapsMembers',json_encode($this->_model->getMiembrosPais()));
        $this->_view->renderizar('statistics');
    }

    public function ficha($iFor_IdForo) {

        $this->validarUrlIdioma();

        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->getLenguaje("foro_index_ficha");
        $this->_view->setCss(array("ficha_foro"));
        $this->_view->setJs(array("ficha_foro"));

        $lenguaje = Session::get("fileLenguaje");
        $foro = $this->_model->getForo_x_idforo($iFor_IdForo);
        $this->_view->assign('titulo', $lenguaje["foro_ficha_titulo"] . " " . $foro["For_Titulo"]);
        $foro["Archivos"] = $this->_model->getArchivos_x_idforo($iFor_IdForo);
        $foro["For_Comentarios"] = $this->_model->getComentarios_x_idforo($iFor_IdForo);
       
        if ($foro["For_Funcion"] == "forum") {
            $foro["Sub_Foros"] = $this->_model->getSubForo_x_idforo($iFor_IdForo);            
        } else {
            $foro["Sub_Foros"] = array();           
        }

        for ($index = 0; $index < count($foro["For_Comentarios"]); $index++) {
            $foro["For_Comentarios"][$index]["Hijo_Comentarios"] = $this->_model->getComentarios_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);
            $foro["For_Comentarios"][$index]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);
            for ($j = 0; $j < count($foro["For_Comentarios"][$index]["Hijo_Comentarios"]); $j++) {
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"]);
            }
        }
        $this->_view->assign('facilitadores', $this->_model->getFacilitadores($iFor_IdForo));
        $this->_view->assign('comentar_foro', $this->_permiso($iFor_IdForo, "comentar_foro"));
               
        $this->_view->assign('foro', $foro);
        $this->_view->renderizar('ficha_foro');
    }

    public function _registro_comentario() {
        header("access-control-allow-origin: *");
        #$this->_acl->acceso('registro_actividad_tarea');            
        $iFor_IdForo = $this->getInt('id_foro');
        $iUsu_IdUsuario = $this->getInt('id_usuario');
        $iCom_Descripcion = $this->getTexto('descripcion');
        $iCom_IdPadre = $this->getInt('id_padre');
        $iFim_Files = html_entity_decode($this->getTexto('att_files'));

        $aFim_Files = json_decode($iFim_Files, true);


        $result = $this->_model->registrarComentario($iFor_IdForo, $iUsu_IdUsuario, $iCom_Descripcion, $iCom_IdPadre);
        foreach ($aFim_Files as $key => $value) {
            $result_e = $this->_model->insertarFileComentario($value["name"], $value["type"], $value["size"], $result[0], 0);
        }


        $foro = $this->_model->getForo_x_idforo($iFor_IdForo);

        $foro["Archivos"] = $this->_model->getArchivos_x_idforo($iFor_IdForo);
        $foro["For_Comentarios"] = $this->_model->getComentarios_x_idforo($iFor_IdForo);


        for ($index = 0; $index < count($foro["For_Comentarios"]); $index++) {
            $foro["For_Comentarios"][$index]["Hijo_Comentarios"] = $this->_model->getComentarios_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);
            $foro["For_Comentarios"][$index]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);
            for ($j = 0; $j < count($foro["For_Comentarios"][$index]["Hijo_Comentarios"]); $j++) {
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Archivos"] = $this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"]);
            }
        }

        $this->_view->assign('comentar_foro', $this->_permiso($iFor_IdForo, "comentar_foro"));
        $this->_view->assign('foro', $foro);
        $this->_view->renderizar('ajax/lista_comentarios', false, true);
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
    

}

?>