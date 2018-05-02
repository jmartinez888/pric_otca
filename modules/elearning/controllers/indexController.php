<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class indexController extends elearningController {

  public function __construct($lang,$url)
  {
    parent::__construct($lang,$url);
  }

  public function index(){
    $this->redireccionar("elearning/cursos/cursos");
  }

  public function _busqueda_curso(){
    $busqueda = $this->getTexto("busqueda");
    $busqueda = str_replace(" ", "_", $busqueda);
    $this->redireccionar("elearning/cursos/cursos/" . $busqueda);
  }
}
