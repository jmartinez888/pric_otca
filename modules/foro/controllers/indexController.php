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
         $this->_view->setCss(array("index"));


        $lenguaje = Session::get("fileLenguaje");
        $this->_view->assign('titulo', $lenguaje["foro_index_titulo"]);

        $lista_foros = $this->_model->getForos();
        $this->_view->assign('lista_foros', $lista_foros);
        $this->_view->renderizar('index');
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
        
        
        for ($index = 0; $index < count($foro["For_Comentarios"]); $index++) {
            $foro["For_Comentarios"][$index]["Hijo_Comentarios"] = $this->_model->getComentarios_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);            
            $foro["For_Comentarios"][$index]["Archivos"]=$this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);
            for($j = 0; $j < count($foro["For_Comentarios"][$index]["Hijo_Comentarios"]); $j++){
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Archivos"]=$this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"]);
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
          
        $aFim_Files=  json_decode($iFim_Files,true);
        
        
        $result = $this->_model->registrarComentario($iFor_IdForo, $iUsu_IdUsuario, $iCom_Descripcion, $iCom_IdPadre);
        foreach ($aFim_Files as $key => $value) {
           $result_e=$this->_model->insertarFileComentario($value["name"],$value["type"],$value["size"],$result[0],0); 
        }
               
        
         $foro = $this->_model->getForo_x_idforo($iFor_IdForo);
       
        $foro["Archivos"] = $this->_model->getArchivos_x_idforo($iFor_IdForo);
        $foro["For_Comentarios"] = $this->_model->getComentarios_x_idforo($iFor_IdForo);
        
        
        for ($index = 0; $index < count($foro["For_Comentarios"]); $index++) {
            $foro["For_Comentarios"][$index]["Hijo_Comentarios"] = $this->_model->getComentarios_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);            
            $foro["For_Comentarios"][$index]["Archivos"]=$this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Com_IdComentario"]);
            for($j = 0; $j < count($foro["For_Comentarios"][$index]["Hijo_Comentarios"]); $j++){
                $foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Archivos"]=$this->_model->getArchivos_x_idcomentario($foro["For_Comentarios"][$index]["Hijo_Comentarios"][$j]["Com_IdComentario"]);
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
            mkdir($src, 0777);
        
        $result = array();
        foreach ($file as $key => $value) {            
            if ($file && move_uploaded_file($value['tmp_name'], $src . $value["name"])) {              
                $result[$key]= ["id"=>$key,"name"=>$value["name"],"type"=>$value["type"],"size"=>$value["size"],"url"=>$src . $value["name"]];
            } else {
                $result[$key]= false;
            }            
        }
       
        echo json_encode($result);
        //comprobamos si existe un directorio para subir el archivo
    }

}

?>