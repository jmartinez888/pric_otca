<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class claseController extends elearningController {

  public function __construct($lang,$url)
  {
    parent::__construct($lang,$url);
      if(!Session::get("autenticado")){ $this->redireccionar("elearning/"); }
  }

  public function index(){
    $this->redireccionar("elearning/");
  }

  public function clase($curso="", $modulo="", $leccion=""){
    if($curso == "" || !is_numeric($curso)
    || $modulo == "" || !is_numeric($modulo)
      || $leccion == "" || !is_numeric($leccion) ){
      $this->redireccionar("elearning/");
    }
    $Cmodel = $this->loadModel("curso");
    $Mmodel = $this->loadModel("modulo");
    $Lmodel = $this->loadModel("leccion");
    $chmodel = $this->loadModel("chat");
    $Gmodel = $this->loadModel("_gestionCurso");

    if(!$Mmodel->validarCursoModulo($curso, $modulo)){ $this->redireccionar("elearning/cursos"); }
    if(!$Mmodel->validarModuloUsuario($modulo, Session::get("id_usuario"))){ $this->redireccionar("elearning/cursos"); };

    $OLeccion = $Lmodel->getLeccion($leccion, $modulo, Session::get("id_usuario"));
    if($OLeccion["Lec_Tipo"]!=4){ $this->redireccionar("elearning/cursos/modulo/" . $curso . "/" .$modulo  . "/" . $OLeccion["Lec_IdLeccion"]); exit; }

    $lecciones = $Lmodel->getLecciones($modulo, Session::get("id_usuario"));
    $ocurso = $Cmodel->getCursoID($curso);
    if($ocurso==null && count($ocurso)==0){ $this->redireccionar("elearning/cursos"); }
    if($lecciones==null && count($lecciones)==0){ $this->redireccionar("elearning/cursos"); }
    $ocurso = $ocurso[0];
    $alumnos = $Gmodel->getAlumnos($ocurso["Cur_IdCurso"]);

    //VALIDACION FECHA
    //date_default_timezone_set('America/Tegucigalpa');
    //date_default_timezone_set('America/New_York');
    $DT_ACTUAL = (new DateTime("now"))->format('Y-m-d');;
    $DT_DESDE = (new DateTime($OLeccion["Lec_FechaDesde"]))->format('Y-m-d');;
    $DT_HASTA = (new DateTime($OLeccion["Lec_FechaHasta"]))->format('Y-m-d');;

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->assign("curso", $curso);
    $this->_view->assign("modulo", $Mmodel->getModulo($modulo));
    $this->_view->assign("lecciones", $lecciones);
    $this->_view->assign("ocurso", $ocurso);
    $this->_view->assign("usuario", Session::get("id_usuario"));
    $this->_view->assign("leccion", $OLeccion);
    $this->_view->setCss(array("colorPicker", "modulo", "pizarra", "chat"));

    if($DT_ACTUAL < $DT_DESDE){
      $this->_view->renderizar("clase_falta");
      exit;
    }else if (($DT_ACTUAL > $DT_HASTA) || $OLeccion["Lec_LMSEstado"]==2){
      $this->_view->renderizar("clase_pasada");
      exit;
    }
    if($OLeccion["Lec_LMSEstado"]==0){
      $this->_view->renderizar("clase_espera");
      exit;
    }
    $mensajes = $chmodel->ListarChat($ocurso["Cur_IdCurso"], $OLeccion["Lec_IdLeccion"]);

    $this->_view->assign("chat", $mensajes);
    $this->_view->assign("alumnos", $alumnos);

    $this->_view->assign("referencias", $Lmodel->getReferencias($OLeccion["Lec_IdLeccion"]));
    $this->_view->assign("materiales", $Lmodel->getMateriales($OLeccion["Lec_IdLeccion"]));
    $this->_view->setJs(array("colorPicker", "pizarra/herramientas", "pizarra/events", "pizarra/base", "chat"));
    $this->_view->renderizar("clase");
  }

  public function _registrar_mensaje(){
    $usuario = $this->getTexto("usuario");
    $curso = $this->getTexto("curso");
    $leccion = $this->getTexto("leccion");
    $mensaje = $this->getTexto("mensaje");

    $this->getLibrary("ServiceResult");
    $json = new ServiceResult();

    if(strlen($usuario)==0 || strlen($curso)==0 || strlen($leccion)==0 || strlen($mensaje)==0){
      $json->Error(""); $json->Send(); exit;
    }
    if(!is_numeric($usuario) || !is_numeric($leccion) || !is_numeric($curso)){ $json->Error(""); $json->Send(); exit; }

    $model = $this->loadModel("chat");
    $model->RegistrarMensaje($usuario, $curso, $leccion, $mensaje);
    $json->Success("Exito");
    $json->Send();
  }

  public function iniciar($curso, $modulo, $leccion){
    $model = $this->loadModel("leccion");
    $model->EstadoLeccionLMS($leccion, 1);
    $this->redireccionar("elearning/clase/clase/" . $curso . "/" . $modulo . "/" . $leccion);
  }

  public function finalizar($curso, $modulo, $leccion){
    $model = $this->loadModel("leccion");
    $model->EstadoLeccionLMS($leccion, 2);
    $this->redireccionar("elearning/clase/clase/" . $curso . "/" . $modulo . "/" . $leccion);
  }
}
