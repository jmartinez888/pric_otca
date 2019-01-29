<?php

use App\Leccion;

class messageController extends elearningController {

    private $message;
    private $service;

    public function __construct($lang,$url){
        parent::__construct($lang,$url);
        $this->getLibrary("ServiceResult");
        $this->service = new ServiceResult();
        $this->message = $this->loadModel("message");
    }

		

    public function solicitar_activos () {
        if ($this->has(['leccion_id', 'chat_modo', 'hash_online', 'usuario_id'])) {
					
        }
    }

    public function index(){
        $this->redireccionar("elearning/message/message");
    }

    public function message(){
        if(!Session::get("autenticado")){ $this->redireccionar("elearning/"); }
        $mis_chats = $this->message->MisChats(Session::get("id_usuario"));

        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setJs(array("view", "chat",
                    array(BASE_URL . 'modules/elearning/views/gestion/js/core/controller.js'),
                    array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js')));
        $this->_view->setCss(array("main"));
        $this->_view->assign("chats", $mis_chats);
        $this->_view->assign('_url', BASE_URL . "modules/" . $this->_request->getModulo() . "/views/");
        $this->_view->assign('learn_url', BASE_URL . $this->_request->getLenguaje() . "/" . $this->_request->getModulo() . "/");
        $this->_view->renderizar("index");
    }

    public function CargarChat(){
        if(!Session::get("autenticado")){
            $service->Error("Sesión expirada");
            $service->Send(); exit;
        }

        $usuario = Session::get("id_usuario");
        $id1 = $this->getTexto("id1");
        $id2 = $this->getTexto("id2");
        $tipo = $this->getTexto("tipo");
        $index1 = $this->getInt("index1");
        $index2 = $this->getInt("index2");

        if($tipo==1){
            $model = $this->loadModel("chat");
            $data = $model->ListarChat2($usuario, $id1, $id2, $index1, $index2);
        }else{
            $model = $this->loadModel("message");
            $data = $model->ListarChat($usuario, $id1, $index1, $index2);
        }
        $this->service->Populate($data);
        $this->service->Success("Chat cargado con éxito");
        $this->service->Send();
    }

    function _chat_item_me(){
        if(!Session::get("autenticado")){ $this->redireccionar("elearning/"); }
          $this->itemView();
    }

    function _chat_item_others(){
        if(!Session::get("autenticado")){ $this->redireccionar("elearning/"); }
          $this->itemView();
    }

    function _usuario(){
        $busqueda = $this->getTexto("usuario");
        $usuario = $this->loadModel("usuario");
        $usuarios = $usuario->getBusqueda($busqueda);

        $this->service->Success("exito");
        $this->service->populate($usuarios);
        $this->service->Send();
    }

    function _mis_chats(){
        if(!Session::get("autenticado")){ $this->redireccionar("elearning/"); }
        $mis_chats = $this->message->MisChats(Session::get("id_usuario"));

        $this->service->Success("exito");
        $this->service->Populate($mis_chats);
        $this->service->Send();
    }

    function save(){
        if(!Session::get("autenticado")){
            $this->service->Error("Sesión expirada");
            $this->service->Send(); exit;
        }
        $usuario = Session::get("id_usuario");
        $id1 = $this->getTexto("id1");
        $id2 = $this->getTexto("id2");
        $tipo = $this->getInt("tipo");
        $mensaje = $this->getTexto("mensaje");

        if($tipo==1){
            $model = $this->loadModel("chat");
            $data = $model->registrarMensaje($usuario, $id1, $id2, $mensaje);
        }else{
            $model = $this->loadModel("message");
            $data = $model->registrarMensaje($usuario, $id1, $mensaje);
        }

        $this->service->Success("Exito");
        $this->service->Send();
    }

    function delete(){
        if(!Session::get("autenticado")){
            $this->service->Error("Sesión expirada");
            $this->service->Send(); exit;
        }
        $usuario = Session::get("id_usuario");
        $idmensaje = $this->getInt("id");
        $tipo = $this->getInt("tipo");

        $this->message->EliminarChat($usuario, $tipo, $idmensaje);

        $this->service->Success("Exito");
        $this->service->Send();
    }
}


/*
CREATE TABLE `Conversacion` (
  `Con_IdConversacion` int(11) NOT NULL AUTO_INCREMENT,
  `Usu_IdUsuEnvia` int(11) NOT NULL,
  `Usu_IdUsuRecibe` int(11) NOT NULL,
  `Con_Mensaje` varchar(400) NOT NULL,
  `Con_FechaReg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Con_Visto` tinyint(1) DEFAULT '0',
  `Con_Estado` tinyint(1) DEFAULT '1',
  `Row_Estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`Con_IdConversacion`),
  KEY `FK_curso_envia` (`Usu_IdUsuEnvia`),
  KEY `FK_usuario_recibe` (`Usu_IdUsuRecibe`),
  CONSTRAINT `FK_curso_envia` FOREIGN KEY (`Usu_IdUsuEnvia`) REFERENCES `Usuario` (`Usu_IdUsuario`),
  CONSTRAINT `FK_usuario_recibe` FOREIGN KEY (`Usu_IdUsuRecibe`) REFERENCES `Usuario` (`Usu_IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
*/
