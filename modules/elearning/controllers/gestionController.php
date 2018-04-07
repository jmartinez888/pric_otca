<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class gestionController extends elearningController {

  protected $_link;
  protected $service;

  public function __construct($lang,$url)
  {
    parent::__construct($lang,$url);
    $this->_view->assign('_url', BASE_URL . "modules/" . $this->_request->getModulo() . "/views/");
    $this->getLibrary("ServiceResult");
    $this->service = new ServiceResult();
  }

  public function index()
  {
      if (!Session::get('autenticado')){ $this->redireccionar(); }

      $this->_view->setJs(array('framework/lodash', 'core/util','core/controller', 'core/view', 'index'));
      $this->_view->setCss(array('principal'));

      if( count(Session::get("learn_url_tmp")) ){
        $this->_view->assign('learn_url_tmp', Session::get("learn_url_tmp"));
      } else {
        $this->_view->assign('learn_url_tmp', "");
      }

      $this->_view->setTemplate(LAYOUT_FRONTEND);

      $this->_view->setJs(array(//array(BASE_URL . 'public/ckeditor/ckeditor.js'), 
        array(BASE_URL . 'public/ckeditor/adapters/jquery.js')));
      $this->_view->assign('learn_usuario', Session::get("login_usuario"));
      $this->_view->assign('learn_lenguaje', $this->_lenguaje ? $this->_lenguaje : "es");
      $this->_view->assign('learn_url', BASE_URL . $this->_request->getLenguaje() . "/" . $this->_request->getModulo() . "/");
      $this->_view->renderizar('index');
  }

  public function _inicio()
  {
    Session::set("learn_url_tmp", "gcurso/_view_mis_cursos");
    $this->redireccionar("elearning/gestion/");
  }

  public function matriculados($id =""){
    if(!Session::get("autenticado")){ $this->redireccionar("elearning/"); }
    if($id == "" || !is_numeric($id) ){ $this->redireccionar("elearning/"); }
    $model = $this->loadModel("curso");
    $_model = $this->loadModel("_gestionCurso");
    if(!$_model->validarDocenteCurso($id, Session::get("id_usuario"))){ $this->redireccionar("elearning/"); }

    $curso = $model->getCursoID($id);
    $matriculados = $_model->getMatriculados($id);

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->assign("curso", $curso[0]);
    $this->_view->assign("matriculados", $matriculados);
    $this->_view->renderizar("matricula");
  }

  public function matricular($curso = "", $alumno = "", $estado = ""){
    if($curso=="" || $alumno=="" || $estado == ""){ $this->redireccionar("elearning/"); }

    $estado = ($estado=="Si" ? 1 : 0);
    $_model = $this->loadModel("_gestionCurso");
    $_model->updateMatricula($curso, $alumno, $estado);
    $this->redireccionar("elearning/gestion/matriculados/" . $curso);
  }
}
