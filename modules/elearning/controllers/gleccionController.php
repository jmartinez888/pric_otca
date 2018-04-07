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
    $Mmodel = $this->loadModel("_gestionModulo");

    $curso = $Cmodel->getCursoXId($curso);
    $tipo = $Lmodel->getTipoLecccion( $curso["Mod_IdModCurso"]==2? " ": "" );
    $lecciones = $Lmodel->getLecciones($modulo);
    $modulo = $Mmodel->getModuloId($modulo);

    Session::set("learn_url_tmp", "gleccion/_view_lecciones_modulo");
    $this->_view->assign("tipo", $tipo);
    $this->_view->assign("lecciones", $lecciones);
    $this->_view->assign("modulo", $modulo);
    $this->_view->assign("curso", $curso);
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

    $leccion = $model->getLeccionId($id);
    if ($leccion["Lec_Tipo"]==3 && $estado == 1){
        $mensaje = $model->ValidarPreguntasExamen($id);
        if(strlen($mensaje)!=0){
            $this->service->error($mensaje);
            $this->service->Send();
        }else{
            $model->updateEstadoLeccion($id, $estado);
            $this->service->Success($estado);
            $this->service->Send();
        }
    }else{
        $model->updateEstadoLeccion($id, $estado);
        $this->service->Success($estado);
        $this->service->Send();
    }
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

  public function _eliminar_material(){
    $id = $this->getTexto("id");
    $model = $this->loadModel("_gestionLeccion");
    $model->deleteMaterial($id);

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

    $Cmodel = $this->loadModel("_gestionCurso");
    $Mmodel = $this->loadModel("_gestionModulo");
    $model = $this->loadModel("_gestionLeccion");

    $curso = $Cmodel->getCursoXId($curso);
    $modulo = $Mmodel->getModuloId($modulo);
    $leccion = $model->getLeccionId($leccion);
    $referencias = $model->getReferenciaLeccion($leccion["Lec_IdLeccion"]);
    $material = $model->getMaterialLeccion($leccion["Lec_IdLeccion"]);

    $view = "";
    $this->_view->assign("curso", $curso);
    $this->_view->assign("modulo", $modulo);
    $this->_view->assign("leccion", $leccion);
    $this->_view->assign("referencias", $referencias);
    $this->_view->assign("material", $material);
    switch ($leccion["Lec_Tipo"]) {
      case 1:
        $contenido = $model->getContenidoLeccion($leccion["Lec_IdLeccion"]);
        $this->_view->assign("contenido", $contenido);
        $view = "ajax/_view_1";
        break;
      case 2:
        $contenido = $model->getDetalleLeccion2($leccion["Lec_IdLeccion"]);
        $this->_view->assign("contenido", $contenido);
        $view = "ajax/_view_2";
        break;
      case 3:
        $examen = $model->insertExamenLeccion($leccion["Lec_IdLeccion"], "", 0, 0, 0);
        $preguntas = $model->getPreguntas($examen[0]["Exa_IdExamen"]);
        $this->_view->assign("examen", $examen[0]);
        $this->_view->assign("preguntas", $preguntas);
        $view = "ajax/_view_3";
        break;
      case 4:
        $piz = $this->loadModel("pizarra");
        $pizarras = $piz->getPizarrasLeccion($leccion["Lec_IdLeccion"]);
        $this->_view->assign("pizarras", $pizarras);
        $view = "ajax/_view_4";
        break;
    }
    $this->_view->renderizar($view, false, true);
  }

  public function _modificar_contenido(){
    $id = $this->getTexto("id");
    $titulo = $this->getTexto("titulo");
    $contenido = $this->getTexto("contenido");

    $model = $this->loadModel("_gestionLeccion");
    $model->updateContenido($id, $titulo, $contenido);

    $this->service->Success("Se resgistó el contenido con exito");
    $this->service->Send();
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


  public function _actualizar_leccion(){
    $id = $this->getTexto("id");
    $titulo = $this->getTexto("titulo");

    $model = $this->loadModel("_gestionLeccion");
    $model->updateLeccion($id, $titulo);

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

  public function _fechas_leccion(){
    $anio = $this->getTexto("anio");
    $mes = $this->getTexto("mes");
    $modulo = $this->getTexto("modulo");

    $model = $this->loadModel("_gestionLeccion");
    $data = $model->getLeccionesCalendario($mes, $anio, $modulo);

    echo json_encode($data);
  }

  public function _actualizar_fecha(){
    $dia = $this->getTexto("dia");
    $mes = $this->getTexto("mes");
    $anio = $this->getTexto("anio");
    $leccion = $this->getTexto("leccion");

    $fecha = $anio . "-" . $mes . "-" . $dia;
    $model = $this->loadModel("_gestionLeccion");
    $data = $model->updateFechaLección($leccion, $fecha);

    $this->service->Success("Se actualizó la fecha con exito");
    $this->service->Send();
  }

  public function _actualizar_video(){
    $id = $this->getTexto("id");
    $link = $this->getTexto("link");
    $descripcion = $this->getTexto("descripcion");

    $model = $this->loadModel("_gestionLeccion");
    $model->updateVideoLeccion($id, $link, $descripcion);

    $this->service->Success("Se actualizó la fecha con exito");
    $this->service->Send();
  }

  public function _registrar_material(){
    $tipo = $this->getTexto("tipo");
    $leccion = $this->getTexto("leccion");
    $url = $this->getTexto("url");
    $descripcion = $this->getTexto("descripcion");

    $model = $this->loadModel("_gestionLeccion");

    if($tipo==2){
      $url = html_entity_decode($url);
      $url = json_decode($url, true);

      foreach ($url as $i) {
        $model->insertMaterial($leccion, $i["url"], $descripcion);
      }
    }else{
      $model->insertMaterial($leccion, $url, $descripcion);
    }
    $this->service->Success("Se insertó los materiales");
    $this->service->Send();
  }

  public function _registrar_pregunta(){
    $leccion = $this->getTexto("leccion");
    $pregunta = $this->getTexto("pregunta");
    $valor = $this->getTexto("valor");
    $alt1 = $this->getTexto("alt1");
    $alt2 = $this->getTexto("alt2");
    $alt3 = $this->getTexto("alt3");
    $alt4 = $this->getTexto("alt4");
    $alt5 = $this->getTexto("alt5");

    $model = $this->loadModel("_gestionLeccion");
    $pregunta = $model->insertPregunta($leccion, $pregunta, $valor);
    $model->insertAlternativa($pregunta["Pre_IdPregunta"], 1, $alt1);
    $model->insertAlternativa($pregunta["Pre_IdPregunta"], 2, $alt2);
    $model->insertAlternativa($pregunta["Pre_IdPregunta"], 3, $alt3);
    $model->insertAlternativa($pregunta["Pre_IdPregunta"], 4, $alt4);
    $model->insertAlternativa($pregunta["Pre_IdPregunta"], 5, $alt5);

    $this->service->Success("Se insertó los materiales");
    $this->service->Send();
  }

  public function _actualizar_examen(){
    $id = $this->getTexto("id");
    $intentos = $this->getTexto("intentos");
    $porcentaje = $this->getTexto("porcentaje");
    $descripcion = $this->getTexto("descripcion");
    $peso = $this->getTexto("peso");
    $nro_preguntas = $this->getTexto("nro_preguntas");

    $model = $this->loadModel("_gestionLeccion");
    $model->updateExamen($id, $intentos, $porcentaje, $descripcion, $peso, $nro_preguntas);

    $this->service->Success("Se insertó los materiales");
    $this->service->Send();
  }

  public function _eliminar_pregunta(){
    $id = $this->getTexto("id");

    $model = $this->loadModel("_gestionLeccion");
    $model->deletePregunta($id);

    $this->service->Success("Se insertó los materiales");
    $this->service->Send();
  }

  public function _estado_pregunta(){
    $id = $this->getTexto("id");
    $estado = $this->getTexto("estado");
    $estado = strlen($estado) == 0 ? "0": "1";

    $model = $this->loadModel("_gestionLeccion");
    $model->updateEstadoPregunta($id, $estado);

    $this->service->Success("Se insertó los materiales");
    $this->service->Send();
  }

  public function _modificar_pregunta(){
    $pregunta = $this->getTexto("pregunta");
    $descripcion = $this->getTexto("descripcion");
    $valor = $this->getTexto("valor");
    $alt1 = $this->getTexto("alt1");
    $alt2 = $this->getTexto("alt2");
    $alt3 = $this->getTexto("alt3");
    $alt4 = $this->getTexto("alt4");
    $alt5 = $this->getTexto("alt5");
    $id_alt1 = $this->getTexto("id_alt1");
    $id_alt2 = $this->getTexto("id_alt2");
    $id_alt3 = $this->getTexto("id_alt3");
    $id_alt4 = $this->getTexto("id_alt4");
    $id_alt5 = $this->getTexto("id_alt5");

    $model = $this->loadModel("_gestionLeccion");
    $model->updatePregunta($pregunta, $descripcion, $valor);

    $model->updateAlternativa($id_alt1, $alt1);
    $model->updateAlternativa($id_alt2, $alt2);
    $model->updateAlternativa($id_alt3, $alt3);
    $model->updateAlternativa($id_alt4, $alt4);
    $model->updateAlternativa($id_alt5, $alt5);

    $this->service->Success("Se insertó los materiales");
    $this->service->Send();
  }
}
