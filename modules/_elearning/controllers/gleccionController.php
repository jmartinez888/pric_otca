<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class gleccionController extends elearningController {

  protected $_link;
  protected $service;

  public function __construct($lang,$url)
  {
    parent::__construct($lang,$url);
    $this->_view->assign('_url', BASE_URL . "modules/" . $this->_request->getModulo() . "/views/");
    $this->getLibrary("ServiceResult");
    $this->service = new ServiceResult();
  }

  public function _view_lecciones_modulo(){
    $curso = $this->getTexto("curso");
    $modulo = $this->getTexto("modulo");

    if(strlen($curso)==0){ $curso = Session::get("learn_param_curso"); }
    if(strlen($modulo)==0){ $modulo = Session::get("learn_param_modulo"); }
    if(strlen($curso)==0 || strlen($modulo)==0){ exit; }

    Session::set("learn_param_curso", $curso);
    Session::set("learn_param_modulo", $modulo);

    $Lmodel = $this->loadModel("_gestionLeccion");
    $Cmodel = $this->loadModel("_gestionCurso");
    $Mmodel = $this->loadModel("modulo");

    $curso = $Cmodel->getCursoXId($curso);
    $tipo = $Lmodel->getTipoLecccion( $curso["Mod_IdModCurso"]==2? " ": "" );
    $lecciones = $Lmodel->getLecciones($modulo);
    $modulo = $Mmodel->getModulo($modulo);

    Session::set("learn_url_tmp", "gleccion/_view_lecciones_modulo");
    $this->_view->assign("tipo", $tipo);
    $this->_view->assign("lecciones", $lecciones);
    $this->_view->assign("modulo", $modulo);
    $this->_view->renderizar("ajax/_view_lecciones_modulo", false, true);
  }

  public function _registrar_leccion(){
    $id = $this->getTexto("id");
    $tipo = $this->getTexto("tipo");
    $titulo = $this->getTexto("titulo");
    $descripcion = $this->getTexto("descripcion");

    $Mmodel = $this->loadModel("_gestionLeccion");
    $Mmodel->insertLeccion($id, $tipo, $titulo, $descripcion);

    $this->service->Success("Se resgistó el módulo con exito");
    $this->service->Send();
  }

  public function _estado_leccion(){
    $id = $this->getTexto("id");
    $estado = $this->getTexto("estado");
    $model = $this->loadModel("_gestionLeccion");
    $model->updateEstadoLeccion($id, $estado);

    $this->service->Success($estado);
    $this->service->Send();
  }

  public function _eliminar_leccion(){
    $id = $this->getTexto("id");
    $model = $this->loadModel("_gestionLeccion");
    $model->deleteLeccion($id);

    $this->service->Success($estado);
    $this->service->Send();
  }

  public function _eliminar_referencia(){
    $id = $this->getTexto("id");
    $model = $this->loadModel("_gestionLeccion");
    $model->deleteReferencia($id);

    $this->service->Success($estado);
    $this->service->Send();
  }

  public function _view_leccion(){
    $curso = $this->getTexto("curso");
    $modulo = $this->getTexto("modulo");
    $leccion = $this->getTexto("leccion");

    if(strlen($curso)==0){ $curso = Session::get("learn_param_curso"); }
    if(strlen($modulo)==0){ $modulo = Session::get("learn_param_modulo"); }
    if(strlen($leccion)==0){ $leccion = Session::get("learn_param_leccion"); }
    if(strlen($curso)==0 || strlen($modulo)==0 || strlen($leccion)==0){ exit; }

    Session::set("learn_param_curso", $curso);
    Session::set("learn_param_modulo", $modulo);
    Session::set("learn_param_leccion", $leccion);
    Session::set("learn_url_tmp", "gleccion/_view_leccion");

    $model = $this->loadModel("_gestionLeccion");
    $leccion = $model->getLeccionId($leccion);
    $referencias = $model->getReferenciaLeccion($leccion["Lec_IdLeccion"]);

    $view = "";
    $this->_view->assign("leccion", $leccion);
    $this->_view->assign("referencias", $referencias);
    switch ($leccion["Lec_Tipo"]) {
      case 1:
        $contenido = $model->getContenidoLeccion($leccion["Lec_IdLeccion"]);
        $this->_view->assign("contenido", $contenido);
        $view = "ajax/_view_1";
        break;
    }
    $this->_view->renderizar($view, false, true);
  }

  public function _registrar_contenido(){
    $leccion = $this->getTexto("leccion");
    $titulo = $this->getTexto("titulo");
    $contenido = $this->getTexto("contenido");

    $contenido = str_replace("<script>", "", $contenido);
    $contenido = str_replace("</script>", "", $contenido);
    $contenido = str_replace("<script type=\"text/javascript\">", "", $contenido);
    $contenido = str_replace("<script", "", $contenido);

    $model = $this->loadModel("_gestionLeccion");
    $model->insertContenido($leccion, $titulo, $contenido);

    $this->service->Success("Se resgistó el contenido con exito");
    $this->service->Send();
  }

  public function _registrar_referencia(){
    $leccion = $this->getTexto("leccion");
    $titulo = $this->getTexto("titulo");
    $descripcion = $this->getTexto("descripcion");

    $model = $this->loadModel("_gestionLeccion");
    $model->insertReferencia($leccion, $titulo, $descripcion);

    $this->service->Success("Se resgistó el contenido con exito");
    $this->service->Send();
  }
}
