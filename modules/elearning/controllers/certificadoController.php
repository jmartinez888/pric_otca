<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class certificadoController extends elearningController {

    protected $certificado;
    protected $service;

    public function __construct($lang,$url)
    {
        parent::__construct($lang,$url);
        $this->getLibrary("ServiceResult");
        $this->service = new ServiceResult();
        $this->certificado = $this->loadModel("certificado");
    }

    public function index(){  }

    public function registrar(){
        $usuario = Session::get("id_usuario");
        $curso = $this->getTexto("curso");
        
        $tmpUser = "0000" . $usuario;
        $tmpCurso = "0000" . $curso;

        $codigo = substr($tmpCurso, strlen($tmpCurso)-5, strlen($tmpCurso));
        $codigo .= substr($tmpUser, strlen($tmpUser)-5, strlen($tmpUser));
        $codigo = date('Ymd'). $codigo;

        $this->certificado->insertCertificado($codigo, $usuario, $curso);

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

    public function menu(){
        $codigo = $this->getTexto("certificado");
        
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->assign("certificado", $codigo);
        $this->_view->assign("resultados", $this->certificado->getCertificado($codigo));
        $this->_view->renderizar("menu");
    }
}