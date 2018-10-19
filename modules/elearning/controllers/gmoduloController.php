<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class gmoduloController extends elearningController {

  public function __construct($lang,$url)
  {
    parent::__construct($lang,$url);
    $this->curso = $this->loadModel("_gestionCurso");
    $this->_view->assign('_url', BASE_URL . "modules/" . $this->_request->getModulo() . "/views/");
    $this->getLibrary("ServiceResult");
    $this->service = new ServiceResult();
  }

  public function _view_modulos_curso($idcurso = 0){
    // $idcurso = $this->getTexto("id");
    $this->_view->setTemplate(LAYOUT_FRONTEND);
    if(!is_numeric($idcurso) && strlen($idcurso)==0){ $idcurso = Session::get("learn_param_curso"); }
    if(strlen($idcurso)==0){ exit; }
    $Cmodel = $this->loadModel("_gestionCurso");
    $Mmodel = $this->loadModel("_gestionModulo");

    $curso = $Cmodel->getCursoXId($idcurso);
    $modulos = $Mmodel->getModulos($idcurso);

    Session::set("learn_param_curso", $idcurso);
    Session::set("learn_url_tmp", "gmodulo/_view_modulos_curso");

    $this->_view->assign('menu', 'curso');
    $this->_view->assign("curso", $curso);
    // $this->_view->assign('idcurso', $idcurso);
    $this->_view->assign("modulos", $modulos);
    $this->_view->render('ajax/_view_modulos_curso');
  }

  public function _view_tareas_curso(){
    $id = $this->getTexto("id");
    if(strlen($id)==0){ $id = Session::get("learn_param_curso"); }
    if(strlen($id)==0){ exit; }
    $Cmodel = $this->loadModel("_gestionCurso");
    $Mmodel = $this->loadModel("_gestionModulo");
    $Tmodel = $this->loadModel("trabajo");

    $curso = $Cmodel->getCursoXId($id);
    $modulos = $Mmodel->getModulos($id);

    for ($i = 0; $i < count($modulos); $i++) {
      $modulos[$i]["TAREAS"] = $Tmodel->getTrabajoXModulo($modulos[$i]["Moc_IdModuloCurso"]);
    }

    Session::set("learn_url_tmp", "gmodulo/_view_tareas_curso");
    Session::set("learn_param_curso", $id);

    $this->_view->assign("curso", $curso);
    $this->_view->assign("modulos", $modulos);
    $this->_view->renderizar('ajax/_view_tareas_cursos', false, true);
  }

  public function _registrar_modulo(){
    $id = $this->getTexto("id");
    $titulo = $this->getTexto("titulo");
    $descripcion = $this->getTexto("descripcion");

    $Mmodel = $this->loadModel("_gestionModulo");
    $Mmodel->insertModulo($id, $titulo, $descripcion);

    $this->service->Success("Se resgistó el módulo con exito");
    $this->service->Send();
  }

  public function _estado_modulo(){
    $id = $this->getTexto("id");
    $estado = $this->getTexto("estado");
    $model = $this->loadModel("_gestionModulo");
    $model->updateEstadoModulo($id, $estado);

    $this->service->Success($estado);
    $this->service->Send();
  }

  public function _eliminar_modulo(){
    $id = $this->getTexto("id");
    $model = $this->loadModel("_gestionModulo");
    $model->deleteModulo($id);

    $this->service->Success("Se eliminó el módulo");
    $this->service->Send();
  }

  public function _actualizar_modulo(){
    $id = $this->getTexto("id");
    $titulo = $this->getTexto("titulo");
    $descripcion = $this->getTexto("descripcion");

    $model = $this->loadModel("_gestionModulo");
    $model->updateModulo($id, $titulo, $descripcion);

    $this->service->Success("Datos actualizados");
    $this->service->Send();
  }
}
