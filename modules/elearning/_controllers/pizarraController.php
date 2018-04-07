<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class pizarraController extends elearningController {

  protected $service;

  public function __construct($lang,$url)
  {
    parent::__construct($lang,$url);
    $this->getLibrary("ServiceResult");
    $this->service = new ServiceResult();
  }

  public function index(){
    $this->redireccionar("elearning/cursos/cursos");
  }

  public function _registrar_pizarra(){
    $leccion = $this->getTexto("leccion");
    $url = $this->getTexto("url");
    $x = round((float)$this->getTexto("x"));
    $y = round((float)$this->getTexto("y"));
    $width = $this->getTexto("width");
    $height = $this->getTexto("height");

    $model = $this->loadModel("pizarra");
    $model->insertPizarra($leccion, 1, "", "", $url, $width, $height, $x, $y);

    $this->service->Success("Se insertó la pizarra");
    $this->service->Send();
  }

  public function _eliminar_pizarra(){
    $id = $this->getTexto("id");
    $model = $this->loadModel("pizarra");
    $model->deletePizarra($id);

    $this->service->Success("Se eliminó la pizarra");
    $this->service->Send();
  }
}
