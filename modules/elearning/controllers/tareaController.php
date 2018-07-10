<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class tareaController extends elearningController {

  protected $service;
  protected $usuario;
  protected $tarea;

  public function __construct($lang,$url)
  {
    parent::__construct($lang,$url);
    if(!Session::get("autenticado")){ $this->redireccionar("elearning/"); }
    $this->getLibrary("ServiceResult");
    $this->service = new ServiceResult();
    $this->usuario = Session::get("id_usuario");
    $this->tarea = $this->loadModel("tarea");
  }

  public function resolver(){
    $id = $this->getTexto("id");
    $obj = $this->tarea->getTareaXTrabajoXUsuario($id, $this->usuario);
    if($obj==null || count($obj)==0){
      $this->tarea->insertTarea($id, $this->usuario, "", "");
      $obj = $this->tarea->getTareaXTrabajoXUsuario($id, $this->usuario);
    }
    for($i = 0 ; $i < count($obj); $i++){
      $obj[$i]["Archivos"] = $this->tarea->getArchivos($obj[$i]["Tar_IdTarea"]);
    }
    $this->service->Success("exito");
    $this->service->Populate($obj);
    $this->service->Send();
  }

  public function _resolver(){
    $id = $this->getInt("id");
    $titulo = $this->getTexto("titulo");
    $descripcion = $this->getTexto("descripcion");

    $this->tarea->updateTarea($id, $titulo, $descripcion);
    $this->service->Success("exito");
    $this->service->Send();
  }

  public function _archivos(){
    $id = $this->getInt("id");
    $archivos = json_decode(html_entity_decode($this->getTexto("files")));

    foreach ($archivos as $file) {
      $this->tarea->insertArchivo($id, "", $file->url);
    }

    $this->service->Success("exito");
    $this->service->Send();
  }

  public function _deletefile(){
    $id = $this->getInt("id");
    $this->tarea->deleteArchivo($id);

    $this->service->Success("exito");
    $this->service->Send();
  }
}
