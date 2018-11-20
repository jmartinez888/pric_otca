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

    public function _view_lecciones_modulo($id_curso = 0, $id_modulo = 0){
        // $curso = $this->getTexto("curso");
        // $modulo = $this->getTexto("modulo");

        $this->_view->setTemplate(LAYOUT_FRONTEND);
        if(strlen($id_curso)==0){ $id_curso = Session::get("learn_param_curso"); }
        if(strlen($id_modulo)==0){ $id_modulo = Session::get("learn_param_modulo"); }
        if(strlen($id_curso)==0 || strlen($id_modulo)==0){ exit; }

        Session::set("learn_param_curso", $id_curso);
        Session::set("learn_param_modulo", $id_modulo);

        $Lmodel = $this->loadModel("_gestionLeccion");
        $Cmodel = $this->loadModel("_gestionCurso");
        $Mmodel = $this->loadModel("_gestionModulo");

        $curso = $Cmodel->getCursoXId($id_curso);
        $tipo = $Lmodel->getTipoLecccion( $curso["Moa_IdModalidad"]==2? " ": "" );
        $lecciones = $Lmodel->getLecciones($id_modulo);
        $modulo = $Mmodel->getModuloId($id_modulo);

        Session::set("learn_url_tmp", "gleccion/_view_lecciones_modulo");
        $this->_view->assign("tipo", $tipo);
        $this->_view->assign('menu', 'curso');
        $this->_view->assign("lecciones", $lecciones);
        $this->_view->assign("modulo", $modulo);
        $this->_view->assign("curso", $curso);
        $this->_view->render("ajax/_view_lecciones_modulo");
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
                // echo "a";exit;
                $this->service->error($mensaje);
                $this->service->Send();
            }else{
                $model->updateEstadoLeccion($id, $estado);
                 // echo "aca";exit;
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

    public function _view_leccion($curso = 0, $modulo = 0, $leccion = 0){
        // $curso = $this->getTexto("curso");
        // $modulo = $this->getTexto("modulo");
        // $leccion = $this->getTexto("leccion");
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        if(strlen($curso)==0){ $curso = Session::get("learn_param_curso"); }
        if(strlen($modulo)==0){ $modulo = Session::get("learn_param_modulo"); }
        if(strlen($leccion)==0){ $leccion = Session::get("learn_param_leccion"); }
        if(strlen($curso)==0 || strlen($modulo)==0 || strlen($leccion)==0){ exit; }

        Session::set("learn_param_curso", $curso);
        Session::set("learn_param_modulo", $modulo);
        Session::set("learn_param_leccion", $leccion);
        Session::set("learn_url_tmp", "gleccion/_view_leccion");

        $Tmodel = $this->loadModel("trabajo"); //RODRIGO 20180605
        $Cmodel = $this->loadModel("_gestionCurso");
        $Mmodel = $this->loadModel("_gestionModulo");
        $model = $this->loadModel("_gestionLeccion");
        $examen = $this->loadModel("examen");

        $Exa_Porcentaje = $examen->getExamenesPorcentaje($curso);
        $Tra_Porcentaje = $examen->getTrabajosPorcentaje($curso);
        $Porcentaje = 100 - $Exa_Porcentaje['Exa_PorcentajeTotal'] - $Tra_Porcentaje['Tra_PorcentajeTotal'];

        $curso = $Cmodel->getCursoXId($curso);
        $modulo = $Mmodel->getModuloId($modulo);
        $leccion = $model->getLeccionId($leccion);
        $referencias = $model->getReferenciaLeccion($leccion["Lec_IdLeccion"]);
        $material = $model->getMaterialLeccion($leccion["Lec_IdLeccion"]);
        $trabajo = $Tmodel->getTrabajoUsuario($leccion["Lec_IdLeccion"]); //RODRIGO 20180605
        $tipo_trabajo = $Tmodel->getConstanteTrabajo(); //RODRIGO 20180605

        $view = "";
        $this->_view->assign('porcentaje', $Porcentaje);
        $this->_view->assign('menu', 'curso');
        $this->_view->assign("curso", $curso);
        $this->_view->assign("modulo", $modulo);
        $this->_view->assign("leccion", $leccion);
        $this->_view->assign("referencias", $referencias);
        $this->_view->assign("material", $material);
        $this->_view->assign("trabajo", $trabajo); //RODRIGO 20180605
        $this->_view->assign("tipo_trabajo", $tipo_trabajo); //RODRIGO 20180605
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
            $ExaModel = $this->loadModel("examen");
            // $examen = $ExaModel->getExamenxLeccion($leccion["Lec_IdLeccion"]);

            $this->_view->assign('examens',  $ExaModel->getExamensCondicion(0,CANT_REG_PAG, " WHERE e.Lec_IdLeccion = ".$leccion["Lec_IdLeccion"]));

            // if ($examen && count($examen) > 0) {
            // // print_r($examen);exit;
            //     $this->redireccionar("elearning/examen/editarexamen/".$examen["Cur_IdCurso"]."/".$examen["Exa_IdExamen"]);
            // } else {
            //     $this->redireccionar("/elearning/examen/nuevoexamen/".$curso["Cur_IdCurso"]);
            // }

            
            // $examen = $model->insertExamenLeccion($leccion["Lec_IdLeccion"], "", 0, 0, 0);
            // $preguntas = $model->getPreguntas($examen[0]["Exa_IdExamen"]);
            // $this->_view->assign("examen", $examen);
            // $this->_view->assign("preguntas", $preguntas); 
            $view = "ajax/_view_3";
            
            break;
          case 4:
            $piz = $this->loadModel("pizarra");
            $pizarras = $piz->getPizarrasLeccion($leccion["Lec_IdLeccion"]);
            $this->_view->assign("pizarras", $pizarras);
            $view = "ajax/_view_4";
            break;
        }
        $this->_view->render($view);
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
        $id = $this->getTexto("id_leccion");
        $titulo = $this->getTexto("titulo");
        $descripcion = $this->getTexto("descripcion");

        $model = $this->loadModel("_gestionLeccion");
        $model->updateLeccion($id, $titulo, $descripcion);

        $this->service->Success("Se resgistó el contenido con exito");
        $this->service->Send();
    }

    public function _registrar_referencia(){
        $leccion = $this->getTexto("leccion");
        $titulo = $this->getTexto("titulo");
        $descripcion = $this->getTexto("descripcionRef");

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

    // Video YouTube
    $cadena='watch?v=';
    $pos=strpos($link,$cadena);
    $pos= $pos + strlen($cadena);
    $link=substr($link,$pos,100);

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
            $model->insertMaterial($leccion, $i["url"], 2, $descripcion);
          }
        }else{
          $model->insertMaterial($leccion, $url, 1, $descripcion);
        }
        $this->service->Success("Se insertó los materiales");
        $this->service->Send();
    }

  public function _registrar_pregunta(){
    $leccion = $this->getTexto("leccion");
    $tipo = $this->getTexto("tipo");

    if($tipo==1){
        $pregunta = $this->getTexto("pregunta");
        $valor = $this->getTexto("valor");
        $alt1 = $this->getTexto("alt1");
        $alt2 = $this->getTexto("alt2");
        $alt3 = $this->getTexto("alt3");
        $alt4 = $this->getTexto("alt4");
        $alt5 = $this->getTexto("alt5");

        $model = $this->loadModel("_gestionLeccion");
        $pregunta = $model->insertPregunta($leccion, $pregunta, $valor, $tipo);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 1, $alt1);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 2, $alt2);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 3, $alt3);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 4, $alt4);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 5, $alt5);
    }

    else if($tipo==2){
        $pregunta = $this->getTexto("pregunta");
        $valor = $this->getTexto("valor");
        $alt1 = $this->getTexto("alt1");
        $alt2 = $this->getTexto("alt2");
        $alt3 = $this->getTexto("alt3");
        $alt4 = $this->getTexto("alt4");
        $alt5 = $this->getTexto("alt5");

        $model = $this->loadModel("_gestionLeccion");
        $pregunta = $model->insertPregunta($leccion, $pregunta, $valor,$tipo);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 1, $alt1);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 2, $alt2);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 3, $alt3);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 4, $alt4);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 5, $alt5);
    }

    else if($tipo==3){
        $pregunta = $this->getTexto("pregunta");
        $pregunta2 = $this->getTexto("pregunta2");
        $valor = $this->getTexto("valor");
        $model = $this->loadModel("_gestionLeccion");
        $pregunta = $model->insertPregunta($leccion, $pregunta, $valor,$tipo,$pregunta2);
    }

    else if($tipo==4){
        $pregunta = $this->getTexto("pregunta");
        $valor = $this->getTexto("valor");
        $alt1 = $this->getTexto("alt1");
        $alt2 = $this->getTexto("alt2");
        $alt3 = $this->getTexto("alt3");
        $alt4 = $this->getTexto("alt4");
        $alt5 = $this->getTexto("alt5");
        $rpta1 = $this->getTexto("rpta1");
        $rpta2 = $this->getTexto("rpta2");
        $rpta3 = $this->getTexto("rpta3");
        $rpta4 = $this->getTexto("rpta4");
        $rpta5 = $this->getTexto("rpta5");

        $model = $this->loadModel("_gestionLeccion");
        $pregunta = $model->insertPregunta($leccion, $pregunta, $valor, $tipo);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 1, $alt1);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 2, $alt2);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 3, $alt3);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 4, $alt4);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 5, $alt5);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 1, $rpta1,1);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 2, $rpta2,2);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 3, $rpta3,3);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 4, $rpta4,4);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 5, $rpta5,5);
    }

     else if($tipo==5){
        $pregunta = $this->getTexto("pregunta");
        $valor = $this->getTexto("valor");

        $model = $this->loadModel("_gestionLeccion");
        $pregunta = $model->insertPregunta($leccion, $pregunta, $valor, $tipo);
    }

        $this->service->Success("Se insertó la pregunta");
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
