<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class gcursoController extends elearningController {

  private $curso;
  protected $_link;
  protected $service;

  public function __construct($lang,$url)
  {
    parent::__construct($lang,$url);
    $this->curso = $this->loadModel("_gestionCurso");
    $this->_view->assign('_url', BASE_URL . "modules/" . $this->_request->getModulo() . "/views/");
    $this->getLibrary("ServiceResult");
    $this->service = new ServiceResult();
  }

  public function index(){ }

  public function _view_mis_cursos()
  {
    $id = Session::get("id_usuario");
    $busqueda = $this->getTexto('busqueda');
    $cursos = $this->curso->getCursoXDocente($id, $busqueda);
    
    //print_r($cursos); exit;
    Session::set("learn_url_tmp", "gcurso/_view_mis_cursos");
    $this->_view->getLenguaje("learn");
    $this->_view->assign('cursos', $cursos);
    $this->_view->assign('busqueda', $busqueda);
    $this->_view->assign('curso', $this->getTexto("id"));
    $this->_view->renderizar('ajax/_view_mis_cursos', false, true);
  }

  public function _view_registrar()
  {
    Session::set("learn_url_tmp", "gcurso/_view_registrar");
    $modalidad = $this->curso->getModalidadCurso();
    $this->_view->getLenguaje("learn");
    $this->_view->assign('modalidad', $modalidad);
    $this->_view->renderizar('ajax/_view_registrar', false, true);
  }

  public function _view_finalizar_registro()
  {
    $id = $this->getTexto("id");
    if(!is_numeric($id) && strlen($id)==0){ $id = Session::get("learn_param_curso"); }
    if(strlen($id)==0){ exit; }
    $datos = $this->curso->getCursoXId($id);

    Session::set("learn_param_curso", $id);
    Session::set("learn_url_tmp", "gcurso/_view_finalizar_registro");

    $this->_view->assign('curso', $datos);
    $this->_view->renderizar('ajax/_view_finalizar_registro', false, true);
  }

  public function _registrar_curso()
  {
    $id = Session::get("id_usuario");
    $modalidad = $this->getTexto("modalidad");
    $titulo = $this->getTexto("curso_titulo");
    $descripcion = $this->getTexto("curso_descripcion");

    $this->curso->saveCurso($id, $modalidad, $titulo, $descripcion);
    $curso = $this->curso->getCursoXRegistro($id);

    $this->service->Success($curso);
    $this->service->Send();
  }

  public function _registrar_obj_especifico(){
    $id = $this->getTexto("id");
    $obj = $this->getTexto("obj");
    $this->curso->saveObjEspecifico($id, $obj);

    $this->service->Success("Se registró el objetivo");
    $this->service->Send();
  }

  public function _registrar_detalle_curso(){
    $id = $this->getTexto("id");
    $titulo = $this->getTexto("titulo");
    $descripcion = $this->getTexto("descripcion");
    $this->curso->saveDetCurso($id, $titulo, $descripcion);

    $this->service->Success("Se registró el objetivo");
    $this->service->Send();
  }

  public function _modificar_curso(){
    $id = $this->getTexto('id');
    $titulo = $this->getTexto('titulo');
    $descripcion = $this->getTexto('descripcion');
    $objgeneral = $this->getTexto('objgeneral');
    $publico = $this->getTexto('publico');
    $software = $this->getTexto('software');
    $hardware = $this->getTexto('hardware');
    $metodologia = $this->getTexto('metodologia');
    $vacantes = $this->getTexto('vacantes');
    $contacto = $this->getTexto('contacto');

    $model = $this->loadModel('_gestionCurso');
    $model->updateCurso($id, $titulo, $descripcion, $objgeneral, $publico, $software, $hardware, $metodologia, $vacantes, $contacto);

    $this->service->Success("Se actualizó la información del curso");
    $this->service->Send();
  }

  public function _eliminar_curso(){
    $id = $this->getTexto("id");
    $this->curso->deleteCurso($id);

    $this->service->Success("Se registró el objetivo");
    $this->service->Send();
  }

  public function _estado_curso(){
    $id = $this->getTexto("id");
    $estado = $this->getTexto("estado");
    $this->curso->updateEstadoCurso($id, $estado);

    $this->service->Success($estado);
    $this->service->Send();
  }

  public function _eliminar_obj_especifico(){
    $obj = $this->getTexto("obj");
    $this->curso->deleteObjEspecifico($obj);

    $this->service->Success("Se eliminó el objetivo");
    $this->service->Send();
  }

  public function _eliminar_det_curso(){
    $obj = $this->getTexto("obj");
    $this->curso->deleteDetCurso($obj);

    $this->service->Success("Se eliminó el objetivo");
    $this->service->Send();
  }

  public function _partial_objetivos_especificos(){
    $id = $this->getTexto("id");
    $objetivos = $this->curso->getObjetivosXCurso($id, 0);

    $this->_view->assign('objetivos', $objetivos);
    $this->_view->renderizar('ajax/_partial_objetivos_especificos', false, true);
  }

  public function _partial_detalle_curso(){
    $id = $this->getTexto("id");
    $detalle = $this->curso->getDetalleXCurso($id);

    $this->_view->assign('detalles', $detalle);
    $this->_view->renderizar('ajax/_partial_detalle_curso', false, true);
  }

  public function _actualizar_img(){
    $curso = $this->getTexto("curso");
    $img = $this->getTexto("img");


    $this->curso->updateBannerCurso($curso, $img);

    $this->service->Success("Se actualizó el banner");
    $this->service->Send();
  }
}
