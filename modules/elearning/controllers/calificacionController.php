<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class calificacionController extends elearningController {

    protected $calificar;
    protected $service;

    public function __construct($lang,$url)
    {
        parent::__construct($lang,$url);
        $this->getLibrary("ServiceResult");
        $this->service = new ServiceResult();
        $this->calificar = $this->loadModel("calificar");
    }

    public function index(){  }

    public function registrar(){
        $usuario = $this->getTexto("usuario");
        $curso = $this->getTexto("curso");
        $calificacion = $this->getTexto("calificacion");
        $comentario = $this->getTexto("comentario");
        
        $this->calificar->insertCalificacion($usuario, $curso, $calificacion, $comentario);

        $this->service->Success("Se registró la calificación");
        $this->service->Send();
    }

    public function get(){
        $curso = $this->getTexto("curso");
        $calif = $this->calificar->getCalificacion($curso);

        $this->service->Populate($calif);
        $this->service->Success("Se registró la calificación");
        $this->service->Send();        
    }
}