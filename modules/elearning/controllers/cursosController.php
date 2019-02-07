<?php

use App\Formulario;
use App\FormularioUsuarioRespuestas;
use App\Leccion;
use Dompdf\Dompdf;

/**
 * Description of loginController
 * @author ROLORO
 */
class cursosController extends elearningController {

  public function __construct($lang, $url) {
    parent::__construct($lang, $url);
  }

  public function respuestas_formulario($curso_id, $respuesta_id = 0) {
    $this->validarUrlIdioma();
    $lang = $this->_view->getLenguaje(['elearning_cursos', 'elearning_formulario_responder'], false, true);
    $mod_curso = $this->loadModel("curso");
    $curso = $mod_curso::find($curso_id);
    $frm = $curso->getFormularioActivo();

    $data['curso'] = $curso;
    $this->_view->setTemplate(LAYOUT_FRONTEND);
    if (is_numeric($respuesta_id) && $respuesta_id != 0) {
      $respuesta = FormularioUsuarioRespuestas::find($respuesta_id);
      if ($respuesta) {

        $this->_view->addViews('modules' . DS . 'elearning' . DS . 'views' . DS . 'formulario');
        $data['alumno'] = $respuesta->usuario;
        $data['respuesta'] = $respuesta;
        $data['titulo'] = $curso['Cur_Titulo'] . ' - ' . $lang->get('elearning_cursos_ver_formulario');
        $data['formulario'] = $frm;
        $tpl = 'ver_respuestas';
      } else {
        $this->redireccionar('elearning/cursos/curso/' . $curso['Cur_IdCurso']);
      }
    } else {
      $data['respuestas'] = $frm->respuestas;
      $data['titulo'] = $curso['Cur_Titulo'] . ' - ' . $lang->get('str_respuestas');
      $tpl = 'respuestas';
    }
    $this->_view->assign($data);
    $this->_view->render($tpl);

  }

  public function index() {
    $this->redireccionar("elearning/");
  }

  public function ficha($id = "") {
    $this->validarUrlIdioma();
    if (strlen($id) == "" || !is_numeric($id)) {$this->redireccionar("elearning/");}
    $model = $this->loadModel("curso");

    $this->_view->getLenguaje(['elearning_cursos']);

    $curso = $model->getCursoID($id);
    if (!isset($curso) || count($curso) == 0 || $curso == null) {$this->redireccionar("elearning/");}
    $usuario = $model->getUsuarioCurso($id);
    if (!isset($usuario) || count($usuario) == 0 || $usuario == null) {$this->redireccionar("elearning/");}
    $cursos = $model->getCursosUsuario($usuario[0]["Usu_IdUsuario"]);

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->setCss(array("jp-datos-docente"));
    $this->_view->assign("ficha", 1);
    $this->_view->assign("curso", $curso[0]);
    $this->_view->assign("cursos", $cursos);
    $this->_view->assign("usuario", $usuario[0]);
    $this->_view->renderizar('ficha');
  }

  //Jhon Martinez
  public function cursos() {
    $this->validarUrlIdioma();
    $model = $this->loadModel("curso");
    $lang = $this->_view->getLenguaje('elearning_cursos', false, true);
    // $mConstante = $this->loadModel("constante");
    $_tipo_curso = $this->getInt('_tipo_curso');
    $_mis_cursos = $this->getInt('_mis_cursos');
    $busqueda = $this->getTexto("busqueda");
    $pagina = $this->getInt('pagina');

    $busqueda = $this->filtrarTexto($busqueda);
    if (Session::get("autenticado")) {
      $Usu_IdUsuario = Session::get("id_usuario");
    } else {
      $Usu_IdUsuario = false;
    }
    //Filtro por Activos/Eliminados
    $condicion = " WHERE cr.Cur_Estado = 1 ";
    $soloActivos = 0;
    if (!$this->_acl->permiso('ver_eliminados')) {
      $soloActivos = 1;
      $condicion .= " AND cr.Row_Estado = $soloActivos ";
    }
    //Filtro por Activos/Eliminados

    // $condicion = "";
    if ($busqueda != "") {
      $condicion .= " AND cr.Cur_Titulo LIKE '%" . $busqueda . "%' AND cr.Cur_Descripcion LIKE '%" . $busqueda . "%' ";
      // if (Session::get("id_usuario")) {
      //     $Usu_IdUsuario = Session::get("id_usuario");
      //     // $cursos = $model->getCursos($Usu_IdUsuario,$busqueda);
      //     // $cursos = $model->getCursosPaginado($pagina,CANT_REG_PAG,$condicion,$Usu_IdUsuario);
      // } else {
      //     // $cursos = $model->getCursos(false,$busqueda);
      //     // $cursos = $model->getCursosPaginado($pagina,CANT_REG_PAG,$condicion,false);
      // }
    }
    if ($_mis_cursos == 1) {
      $condicion .= " AND mt.Usu_IdUsuario = " . Session::get("id_usuario");
    }
    if ($_mis_cursos == 2) {
      $condicion .= " AND cr.Usu_IdUsuario = " . Session::get("id_usuario");
    }

    if ($_tipo_curso > 0) {
      $condicion .= " AND cr.Moa_IdModalidad =  $_tipo_curso";
    }

    if ($soloActivos == 0) {
      $condicion .= " GROUP BY cr.Cur_IdCurso ORDER BY cr.Row_Estado DESC ";
    } else {
      $condicion .= " GROUP BY cr.Cur_IdCurso ";
    }

    $paginador = new Paginador();
    $arrayRowCount = $model->getCursosRowCount($condicion);
    $totalRegistros = $arrayRowCount['CantidadRegistros'];
    $cursos = $model->getCursosPaginado($pagina, CANT_REG_PAG, $condicion, $Usu_IdUsuario, Cookie::lenguaje());
    $paginador->paginar($totalRegistros, "listarCursos", "", $pagina, CANT_REG_PAG, true);

    $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
    $this->_view->assign('paginacion', $paginador->getView('paginacion_ajax_s_filas'));

    // print_r($cursos);exit;
    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->setJs(array("inicio"));
    $this->_view->setCss(array("modulo", "index", "jp-index", "jp-detalle-lateral"));
    $this->_view->assign("busqueda", $busqueda);
    $this->_view->assign("titulo", $lang->get('str_cursos'));
    $this->_view->assign("cursos", $cursos);
    $this->_view->assign("_mis_cursos", $_mis_cursos);
    $this->_view->assign("_tipo_curso", $_tipo_curso);
    $this->_view->assign("modalidades", $model->getConstante(1000));
    $this->_view->assign("c", 0);
    $this->_view->renderizar('inicio');
  }

  public function miscursos() {
    $this->validarUrlIdioma();
    if (!Session::get("autenticado")) {$this->redireccionar("elearning/");}
    $model = $this->loadModel("curso");
    $mConstante = $this->loadModel("constante");
    $cursos = $model->getCursoUsuario(Session::get("id_usuario"));
    // print_r($curso);

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->setCss(array("index", "jp-index", "jp-detalle-lateral2"));
    $this->_view->assign("busqueda", "");
    $this->_view->assign("usu_curso", Session::get("usuario"));
    $this->_view->assign("cursos", $cursos);
    $this->_view->assign("c", 1);
    $this->_view->renderizar('inicio');
  }

  public function miscursos_docente() {
    $this->validarUrlIdioma();
    if (!Session::get("autenticado")) {$this->redireccionar("elearning/");}
    $model = $this->loadModel("curso");
    $mConstante = $this->loadModel("constante");
    $cursos = $model->getCursoDocente(Session::get("id_usuario"));

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->setCss(array("index"));
    $this->_view->assign("busqueda", "");
    $this->_view->assign("usu_curso", Session::get("usuario"));
    $this->_view->assign("cursos", $cursos);
    $this->_view->renderizar('inicio');
  }

  public function curso($id = "") {
    $this->validarUrlIdioma();
    $lang = $this->_view->getLenguaje('elearning_cursos', false, true);
    if ($id == "" || !is_numeric($id)) {$this->redireccionar("elearning/");}
    $model = $this->loadModel("curso");
    $mObj = $this->loadModel("objetivos");
    $mModulo = $this->loadModel("modulo");
    $mInsc = $this->loadModel("inscripcion");
    $mCert = $this->loadModel("certificado");

    $curso = $model->getCursoID($id, Cookie::lenguaje())[0];
    // print_r($curso);exit;
    if ($curso["Moa_IdModalidad"] == 2) {$this->redireccionar("elearning/cursos/curso_dirigido/" . $curso["Cur_IdCurso"]);}
    $inscritos = $mInsc->getInscritos($id);
    if (Session::get("autenticado")) {
      $progreso = $model->getProgresoCurso($id, Session::get("id_usuario"));
      $this->_view->assign("progreso", $progreso);
    }
    // $modulo = $mModulo->getModulosCurso($id, Session::get("id_usuario"), Cookie::lenguaje());
    $modulo = $mModulo->getModulosCursoLMS($id, Session::get("id_usuario"), Cookie::lenguaje());
    // dd($modulo);
    $duracion = $model->getDuracionCurso($id);
    $certificado = $mCert->getCertificadoUsuarioCurso(Session::get("id_usuario"), $id);

    $plantilla = $mCert->getPlantillaCertificado($id, Cookie::lenguaje());

    if ($plantilla) {
      $this->_view->assign("plantilla", $plantilla);
    }
    $respuesta_completada = false;
    $frm = Formulario::getActivoByCursoId($curso['Cur_IdCurso']);
    if ($frm) {
      //verificar si llenó formulario
      $respuesta = $frm->getRespuestaByUsuario(Session::get('id_usuario'));
      if ($respuesta) {
        $respuesta_completada = $respuesta->Fur_Completado == 1;
      }

    }
    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->setCss(array("index", "curso", "jp-curso"));
    // $this->_view->setCss(array("modulo", "index", "jp-index", "jp-detalle-lateral"));
    $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "curso"));
    $this->_view->assign("inscritos", $inscritos);
    $this->_view->assign("respuesta_completada", $respuesta_completada);
    $this->_view->assign("curso", $curso);
    $this->_view->assign("objetivos", $mObj->getObjs($id));
    $this->_view->assign("modulo", $modulo);
    $this->_view->assign("titulo", $curso['Cur_Titulo']);
    $this->_view->assign("certificado", $certificado);
    $this->_view->assign("duracion", $duracion["Total"] . " " . $lang->get('elearning_cursos_cant_lecciones'));
    $this->_view->assign("detalle", $model->getDetalleCurso($curso["Cur_IdCurso"]));
    // print_r($model->getDetalleCurso($curso["Cur_IdCurso"]));exit;
    $this->_view->assign("inscripcion", $mInsc->getInscripcion(Session::get("id_usuario"), $id));
    // print_r($mInsc->getInscripcion(Session::get("id_usuario"), $id));
    $this->_view->assign("session", Session::get("autenticado"));
    $this->_view->renderizar('curso');
  }

  public function curso_dirigido($id = "") {
    $this->validarUrlIdioma();
    if ($id == "" || !is_numeric($id)) {$this->redireccionar("elearning/");}

    $lang = $this->_view->getLenguaje('elearning_cursos', false, true);
    $model = $this->loadModel("curso");
    $mObj = $this->loadModel("objetivos");
    $mModulo = $this->loadModel("modulo");
    $mLeccion = $this->loadModel("leccion");
    $mInsc = $this->loadModel("inscripcion");
    $mCert = $this->loadModel("certificado");

    $curso = $model->getCursoID($id, Cookie::lenguaje())[0];
    if ($curso["Moa_IdModalidad"] == 1) {$this->redireccionar("elearning/cursos/curso/" . $curso["Cur_IdCurso"]);}
    $inscripcion = $mInsc->getInscripcion(Session::get("id_usuario"), $id);

    if (Session::get("autenticado") && count($inscripcion) > 0 && $inscripcion[0]["Mat_Valor"]) {
      $progreso = $model->getProgresoCurso($id, Session::get("id_usuario"));
      $this->_view->assign("progreso", $progreso);
    }

    $inscritos = $mInsc->getInscritos($id);
    $lecciones = $mLeccion->getLeccionesLMS($id, Cookie::lenguaje());
    $duracion = $model->getDuracionCurso($id);
    $certificado = $mCert->getCertificadoUsuarioCurso(Session::get("id_usuario"), $id);
    // $modulo = $mModulo->getModulosCurso($id, Session::get("id_usuario"));
    // dd($modulo);

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->setCss(array("curso", "cursolms", "jp-curso"));
    $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "curso"));
    $this->_view->assign("curso", $curso);
    $this->_view->assign("detalle", $model->getDetalleCurso($curso["Cur_IdCurso"], Cookie::lenguaje()));
    $this->_view->assign("inscritos", $inscritos);
    $this->_view->assign("titulo", $curso['Cur_Titulo']);
    $this->_view->assign("certificado", $certificado);
    $this->_view->assign("duracion", $duracion["Total"]);
    // dd($mModulo->getModulosCursoLMS($id, Session::get("id_usuario")));
    $this->_view->assign("modulo", $mModulo->getModulosCursoLMS($id, Session::get("id_usuario"), Cookie::lenguaje()));
    $this->_view->assign("session", Session::get("autenticado"));
    $this->_view->assign("now", date_create('now')->format('Y-m-d H:i:s'));
    $this->_view->assign("inscripcion", $inscripcion);
    $this->_view->render('curso_dirigido');
  }

  public function modulo($curso = "", $modulo = "", $leccion = false, $idexamen = false) {

    $this->_acl->autenticado();
    $this->validarUrlIdioma();

    $Mmodel = $this->loadModel("modulo");
    $Lmodel = $this->loadModel("leccion");
    $Cmodel = $this->loadModel("curso");
    $Emodel = $this->loadModel("examen");
    // $curs = $Cmodel->getCursoID($curso)[0];
    // print_r($curs);exit;
    $obj_curso = null;
    if (strlen($curso) == 0 || strlen($modulo) == 0 || $this->filtrarInt($curso) == 0 || $this->filtrarInt($modulo) == 0 ) {
      $this->redireccionar("elearning/");
    }
    if (!Session::get("autenticado")) {
      $this->redireccionar("elearning/");
    }
    if (!is_numeric($curso) || !is_numeric($modulo)) {
      $this->redireccionar("elearning/");
    }
    
    if (!$Mmodel->validarCursoModulo($curso, $modulo)) {
      echo "string";exit;
      $this->redireccionar("elearning/cursos");
    }
    if (!$Mmodel->validarModuloUsuario($modulo, Session::get("id_usuario"))) {
      echo "string";exit;
      $this->redireccionar("elearning/cursos");
    }

    if ($leccion) {
      if(!$Lmodel->validarLeccion($leccion, $modulo, Session::get("id_usuario"))){ 
      echo "string";exit;
        $this->redireccionar("elearning/cursos"); }
    }

    $obj_curso = $Cmodel::find($curso);

    $lecciones = $Lmodel->getLecciones($modulo, Session::get("id_usuario"));
    // $examenes= $Emodel->getExamensModulo($modulo);

    // $datos_modulo = $Mmodel->getModuloDatos($OLeccion["Moc_IdModuloCurso"]);

    $datos_modulo = $Mmodel->getModuloDatos($modulo);

    // if($OLeccion==null){
    //   $this->redireccionar("elearning/cursos");
    // }

    $lang = $this->_view->getLenguaje(['elearning_cursos'], false, true);

    $Tmodel = $this->loadModel("trabajo");
    $TTmodel = $this->loadModel("tarea");

    // if($tareas != null && count($tareas)>0){
    //   for($i=0; $i<count($tareas);$i++){
    //     $tareas[$i]["Archivos"] = $Tmodel->getArchivos($tareas[$i]["Tra_IdTrabajo"]);
    //   }
    // }

    if ($leccion) {
      // echo $modulo; echo $leccion;
      $OLeccion = $Lmodel->getLeccion($leccion, $modulo, Session::get("id_usuario"));
      // print_r($OLeccion);exit;
      if (isset($OLeccion) && count($OLeccion)) {
        $clave = array_search($OLeccion["Lec_IdLeccion"], array_column($lecciones, "Lec_IdLeccion"));
        // print($lecciones);
        $tmp = $lecciones[$clave];
        $indice_leccion = $clave + 1;
        $final = count($lecciones) == $indice_leccion ? true : false;

        $tareas = $Tmodel->getTrabajoXLeccion($OLeccion["Lec_IdLeccion"]);
      } else {
        $this->redireccionar("elearning/");
      }
    }

    if (isset($OLeccion) && isset($OLeccion["Lec_Tipo"])) {
      if ($OLeccion["Lec_Tipo"] == 1 || $OLeccion["Lec_Tipo"] == 6) {
        //$Lmodel->RegistrarProgreso($OLeccion["Lec_IdLeccion"], Session::get("id_usuario"));
        $html = $Lmodel->getContenido($OLeccion["Lec_IdLeccion"]);
        $this->_view->assign("cont_html", $html);
      } else if ($OLeccion["Lec_Tipo"] == 2) {
        //$Lmodel->RegistrarProgreso($OLeccion["Lec_IdLeccion"], Session::get("id_usuario"));
        $html = $Lmodel->getContenido($OLeccion["Lec_IdLeccion"]);
        $this->_view->assign("html", $html[0]);
      } else if ($OLeccion["Lec_Tipo"] == 3) {
        $examen = $Emodel->getExamenxLeccion($OLeccion["Lec_IdLeccion"]);

        if ($idexamen && $idexamen == $examen["Exa_IdExamen"]) {
          // $this->_view->setTemplate(LAYOUT_FRONTEND);
          // $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "index"));

          // echo $intento[0]; exit;
          // print_r($examen);
          // echo Session::get("preguntas")[0]["Exa_IdExamen"];
          // echo $idexamen;
          $peso = $Emodel->getExamenPeso($idexamen);
          if (Session::get("intento") < 1 || Session::get("preguntas")[0]["Exa_IdExamen"] != $idexamen) {
            $preguntas = $Emodel->getPreguntas($idexamen);
            Session::set("preguntas", $preguntas);
            Session::set("intento", 1);
          }
          if ($this->botonPress("terminar")) {

            $intento = $Emodel->insertExamenAlumno($idexamen, Session::get("id_usuario"));
            Session::set("idintento", $intento[0]);

            $puntos = 0;
            $preguntas = Session::get("preguntas");
            // print_r($preguntas);
            for ($i = 0; $i < count($preguntas); $i++) {
              $tipo = $this->getSql('tipo_preg' . $i);
              // echo $i.":::tipo:::". $tipo . "\n";
              // JM --> Listo (Pregunta tipo respuesta Unica)
              // echo $puntos."::::".$i."\n";
              if ($tipo == 1) {
                $alt = $preguntas[$i]['Alt'];
                // echo "Unico::::"; print_r($alt); echo "///. \n";
                $puntosrpta = 0;
                foreach ($alt as $k) {
                  if ($k['Alt_Valor'] == $preguntas[$i]['Pre_Valor']) {
                    if ($this->getInt('rpta_alt' . $i) == $k['Alt_IdAlternativa']) {
                      // echo "P1_Rapt-alt:".$this->getInt('rpta_alt'.$i);
                      $puntosrpta = $preguntas[$i]['Pre_Puntos'];
                      $puntos = $puntos + $puntosrpta;
                      // echo "P1:".$puntosrpta;
                    }
                  }

                }
                $Emodel->insertRespuesta($this->getInt('id_preg' . $i), Session::get("idintento"), $this->getInt('rpta_alt' . $i), null, null, $puntosrpta);

              } else if ($tipo == 2) {
                // JM --> Listo (Pregunta con respuesta Multiple)
                $alt = $preguntas[$i]['Alt'];
                // echo "Multiple::::"; print_r($alt);
                for ($j = 0; $j < count($alt); $j++) {
                  $puntosrpta = 0;
                  if ($this->getSql('rpta2_alt' . $i . '_index' . $j)) {
                    // echo "true(".$this->getSql('rpta2_alt'.$i.'_index'.$j).")";
                    foreach ($alt as $k) {
                      // if($k['Alt_Check'])
                      if ($this->getInt('rpta2_alt' . $i . '_index' . $j) == $k['Alt_IdAlternativa'] && $k['Alt_Check'] == 1) {
                        $puntosrpta = $k['Alt_Puntos'];
                        $puntos = $puntos + $puntosrpta;
                      }
                    }
                    // echo "P2:".$puntosrpta;
                    $Emodel->insertRespuesta($this->getInt('id_preg' . $i), Session::get("idintento"), $this->getInt('rpta2_alt' . $i . '_index' . $j), null, null, $puntosrpta);
                  } else {
                    // echo "cero(".$this->getSql('rpta2_alt'.$i.'_index'.$j.'_hd').")";
                    foreach ($alt as $k) {
                      // if($k['Alt_Check'])
                      if ($this->getInt('rpta2_alt' . $i . '_index' . $j . '_hd') == $k['Alt_IdAlternativa'] && $k['Alt_Check'] == 0) {
                        $puntosrpta = $k['Alt_Puntos'];
                        $puntos = $puntos + $puntosrpta;
                      }
                    }
                    // echo "P2:".$puntosrpta;
                    $Emodel->insertRespuesta($this->getInt('id_preg' . $i), Session::get("idintento"), $this->getInt('rpta2_alt' . $i . '_index' . $j . '_hd'), null, null, $puntosrpta);
                  }
                }
              } else if ($tipo == 3) {
                // JM --> Listo (Pregunta con respuesta en Blanco)
                $alt = $preguntas[$i]['Alt'];
                // echo "EnBLanco::::"; print_r($alt);
                for ($j = 0; $j < count($alt); $j++) {
                  $puntosrpta = 0;
                  if (strtolower($this->getSql('rpta3_' . $i . '_index_' . $j)) == strtolower($alt[$j]['Alt_Etiqueta'])) {
                    $puntosrpta = $alt[$j]['Alt_Puntos'];
                    $puntos = $puntos + $puntosrpta;
                  }
                  // echo "P3:".$puntosrpta;
                  $Emodel->insertRespuesta($this->getInt('id_preg' . $i), Session::get("idintento"), null, null, $this->getSql('rpta3_' . $i . '_index_' . $j), $puntosrpta);
                }
              } else if ($tipo == 4) {
                // JM --> Listo (Pregunta con respuesta relacionar)
                $alt = $preguntas[$i]['Alt'];
                for ($j = 0; $j < count($alt); $j = $j + 2) {
                  $puntosrpta = 0;
                  if ($this->getInt('rpta4_' . $i . '_index_' . $j) == $alt[$j]['Alt_IdAlternativa'] && $this->getInt('rpta4_alt' . $i . '_index_' . $j) == $alt[$j]['Alt_Relacion']) {
                    $puntosrpta = $alt[$j]['Alt_Puntos'];
                    $puntos = $puntos + $puntosrpta;
                  }
                  // echo "P4:".$puntosrpta;
                  $Emodel->insertRespuesta($this->getInt('id_preg' . $i), Session::get("idintento"), $this->getInt('rpta4_' . $i . '_index_' . $j), $this->getInt('rpta4_alt' . $i . '_index_' . $j), NULL, $puntosrpta);
                }
              } else if ($tipo == 5) {
                // echo "string";
                // print_r($preguntas[$i]["Pre_Puntos"]);
                $puntosrpta = 0;
                if ($this->getSql('rpta_alt' . $i) && strlen(trim($this->getSql('rpta_alt' . $i), " ")) > 0) {
                  $puntosrpta = $preguntas[$i]["Pre_Puntos"];
                  $puntos = $puntos + $puntosrpta;
                }

                $Emodel->insertRespuesta($this->getInt('id_preg' . $i), Session::get("idintento"), NULL, NULL, $this->getSql('rpta_alt' . $i), $puntosrpta);
              } else {
                $cont2 = 0;
                // print_r($preguntas[$i]['Alt']);
                for ($j = 0; $j < count($preguntas[$i]['Alt']); $j++) {

                  if ($this->getSql('rpta7_alt' . $i . '_index' . $j)) {

                    $alt = $preguntas[$i]['Alt'];
                    $cont = 0;
                    $puntosrpta = 0;

                    foreach ($alt as $k) {
                      if ($k['Alt_Check']) {
                        if ($this->getInt('rpta7_alt' . $i . '_index' . $j) == $k['Alt_IdAlternativa']) {
                          $cont2++;
                        }

                        $cont++;
                      }
                    }
                    if ($cont == $cont2) {
                      $puntosrpta = $preguntas[$i]['Pre_Puntos'];
                      $puntos = $puntos + $puntosrpta;
                    }
                    // echo "P7:".$puntosrpta;
                    $Emodel->insertRespuesta($this->getInt('id_preg' . $i), Session::get("idintento"), $this->getInt('rpta7_alt' . $i . '_index' . $j), null, null, $puntosrpta);
                  }
                }
              }
            }
            // echo round($puntos, 0)."Finallllllll".$puntos;
            $PuntosGuardados = $Emodel->updateNotaExamen(Session::get("idintento"), round($puntos, 0));

            $examen = $Emodel->getExamen($idexamen);
            $parametrosCurso = $Cmodel->getParametroCurso($curso);
            // echo "string"; print_r($parametrosCurso);

            $Emodel->updateProgreso(Session::get("id_usuario"), $examen['Lec_IdLeccion']);
            if ($puntos / $peso["Exa_Peso"] > $parametrosCurso[0]["Par_NotaMinima"] / $parametrosCurso[0]["Par_NotaMaxima"]) {
              // echo "string"; print_r($parametrosCurso);
              $Emodel->insertProgreso(Session::get("id_usuario"), $examen['Lec_IdLeccion']);
            }

            // exit;
            Session::set("intento", 0);
            $this->redireccionar("elearning/cursos/modulo/" . $examen['Cur_IdCurso'] . '/' . $examen['Moc_IdModulo'] . '/' . $examen['Lec_IdLeccion']);
          }

          $this->_view->assign('preguntas', Session::get("preguntas"));

        } else {

          // echo $examen["Exa_IdExamen"]. Session::get("id_usuario"); exit;
          $ultimoexamen = $Emodel->getUltimoExamen($examen["Exa_IdExamen"], Session::get("id_usuario"));

          // echo $ultimoexamen[0]; exit;
          $intentos = $Emodel->getIntentos($examen["Exa_IdExamen"], Session::get("id_usuario"));

          if ($tmp["Progreso"] == 1 || $intentos > 0) {
            // $resultados = $Cmodel->getResultadoExamen($examen["Exa_IdExamen"], Session::get("id_usuario"));
            if ($ultimoexamen) {

              $parametrosCurso = $Cmodel->getParametroCurso($curso);

              $angulo_ok = $ultimoexamen['Exl_Nota'] * 360 / $examen['Exa_Peso'];
              $ang_1 = $angulo_ok > 180 ? 180 : $angulo_ok;
              $ang_2 = $angulo_ok > 180 ? $angulo_ok - $ang_1 : 0;
              $this->_view->assign("ang_1", $ang_1);
              $this->_view->assign("ang_2", $ang_2);
              // $this->_view->assign("next_mod", $Mmodel->getNextModulo($modulo));
              $this->_view->assign("ultimoexamen", $ultimoexamen);
              $this->_view->assign("parametrosCurso", $parametrosCurso[0]);

            }
            // $this->_view->assign("resultados", $resultados);
            //$this->redireccionar("elearning/cursos/modulo/" . $curso. "/" . $tmp["Moc_IdModuloCurso"] . "/" .
            //$lecciones[0]["Lec_IdLeccion"]);
          }
          $OLeccion["Progreso"] = $tmp["Progreso"];

          if ($examen == null) {
            // echo "stringssss";exit;
            $this->redireccionar("elearning/");
          }

          if ($this->botonPress("comenzar")) {

            $this->redireccionar('elearning/cursos/modulo/' . $curso . "/" . $modulo . "/" . $leccion . "/" . $examen['Exa_IdExamen']);
          }

          $this->_view->assign("intentos", $intentos);
          $this->_view->assign("restantes", $examen['Exa_Intentos'] - $intentos['intentos']);
          $this->_view->assign("examen", $examen);
        }
      } else if ($OLeccion["Lec_Tipo"] == 4) {

        $this->redireccionar("elearning/clase/clase/" . $curso . "/" . $modulo . "/" . $OLeccion["Lec_IdLeccion"]);
        exit;
      } else if ($OLeccion["Lec_Tipo"] == 5) {
        $this->redireccionar("elearning/clase/examen/" . $curso . "/" . $modulo . "/" . $OLeccion["Lec_IdLeccion"]);
        exit;
      } else if ($OLeccion['Lec_Tipo'] == 10) {
        $temp_leccion = Leccion::find($OLeccion['Lec_IdLeccion']);
        $data['formulario'] = $frm = $temp_leccion->leccion_formulario->formulario;
        $data['respuesta'] = $frm->getRespuestaByUsuario(Session::get('id_usuario'));
        $data['curso'] = $data['obj_curso'] = $obj_curso;
        $data['redireccion'] = 'elearning/cursos/modulo/' . $curso . '/' . $modulo . '/' . $OLeccion['Lec_IdLeccion'];
        // dd($data['formulario']->preguntas);
        $this->_view->assign($data);
        // $formulario = $
      }
    } 

    // print_r($Mmodel->getModulosCursoLMS($curso, Session::get("id_usuario"))[$datos_modulo['INDEX']-1]);
    $obj_modulo = $Mmodel->getModulo($modulo);
    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->assign("mod_datos", $datos_modulo);
    // $this->_view->assign("modulo", $obj_modulo);
    $this->_view->assign("modulo", $Mmodel->getModulosCursoLMS($curso, Session::get("id_usuario"))[$datos_modulo['INDEX'] - 1]);
    $this->_view->assign("lecciones", $lecciones);
    // $this->_view->assign("examenes", $examenes);
    if (isset($OLeccion) && isset($OLeccion["Lec_IdLeccion"])) {
      $this->_view->assign("leccion", $OLeccion);
      $this->_view->assign("referencias", $Lmodel->getReferencias($OLeccion["Lec_IdLeccion"]));
      $this->_view->assign("materiales", $Lmodel->getMateriales($OLeccion["Lec_IdLeccion"]));
      $this->_view->assign("tareas", $tareas);
    }

    if ($curso != 0) {
      $this->_view->assign("titulo", $lang->get('str_modulo') . ': ' . $obj_modulo['Moc_Titulo']);
    } 

    $this->_view->assign("curso", $curso);
    $this->_view->assign("curso_datos", $Cmodel->getCursoID($curso)[0]);
    $this->_view->setCss(array('modulo', 'jp-modulo'));
    $this->_view->setJs(array( //array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'),
      'modulo'));
    $this->_view->render('modulo');
  }

  public function calendario_curso($id = "") {
    $this->validarUrlIdioma();
    if (strlen($id) == 0) {$this->redireccionar("elearning/");}
    if (!Session::get("autenticado")) {$this->redireccionar("elearning/");}
    if (!is_numeric($id)) {$this->redireccionar("elearning/");}

    $model = $this->loadModel("curso");
    $curso = $model->getCursoID($id);
    if (count($curso) == 0) {$this->redireccionar("elearning/");}

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->assign("curso", $curso[0]);
    $this->_view->renderizar('curso_calendario');
  }

  public function calendario_curso_data() {
    $anio = $this->getTexto("anio");
    $mes = $this->getTexto("mes");
    $curso = $this->getTexto("curso");
    $model = $this->loadModel("curso");
    $ini_cursos = $model->calendario_curso_id($curso, $anio, $mes);
    $resultado = array();

    foreach ($ini_cursos as $item) {
      $evento1 = array("ID" => $item["ID"], "D" => $item["DIA"], "M" => $mes, "A" => $anio
        , "H" => $item["HORA"], "DET" => $item["DET"], "ESTADO" => $item["ESTADO"]
        , "FECHA" => $item["FECHA"]);
      array_push($resultado, $evento1);
    }

    echo json_encode($resultado);
  }

  public function _inscripcion($mod = "", $curso = "") {
    if ($mod == "" || $curso == "" || !is_numeric($mod) || !is_numeric($mod)) {
      $this->redireccionar("elearning/");
    }
    if (!Session::get("autenticado")) {$this->redireccionar("elearning/");}

    $model = $this->loadModel("inscripcion");
    $inscrito = false;
    if ($mod == 1) {
      $inscrito = $model->insertarInscripcion(Session::get("id_usuario"), $curso, 1);
    } else {
      if ($mod == 3) {
        $inscrito = $model->insertarInscripcion(Session::get("id_usuario"), $curso, 1);
      } else {
        $inscrito = $model->insertarInscripcion(Session::get("id_usuario"), $curso, 2);
      }

    }

    if ($inscrito && $inscrito > 0) {
      $modelUsuario = $this->loadModel("usuario", "usuarios");
      $rolAlumno = $modelUsuario->replaceRolUsuario(Session::get("id_usuario"), 6);
    }

    $Cmodel = $this->loadModel("_gestionCurso");
    $anuncios = $Cmodel->getAnuncios($curso);

    foreach ($anuncios as $a) {
      $Cmodel->registrarAnuncioUsuario($a['Anc_IdAnuncioCurso'], Session::get("id_usuario"));
    }
    if ($mod == 1 || $mod = 2) {
      $this->redireccionar("elearning/cursos/curso/" . $curso);
    }

    if ($mod == 3) {
      $this->redireccionar("elearning/formulario/responder/" . $curso);
    }

  }

  public function _previous_leccion() {
    $this->validarUrlIdioma();
    if (!Session::get("autenticado")) {$this->redireccionar("elearning/");}
    $leccion = $this->getTexto("leccion");
    $curso = $this->getTexto("curso");

    $model = $this->loadModel("leccion");
    $objeto = $model->getLeccion($leccion);
    $lecciones = $model->getLecciones($objeto["Moc_IdModuloCurso"], Session::get("id_usuario"));

    $clave = array_search($objeto["Lec_IdLeccion"], array_column($lecciones, "Lec_IdLeccion"));
    if ($clave == 0) {
      $this->redireccionar("elearning/cursos/curso/" . $curso);exit;
    }
    $prevLeccion = $lecciones[$clave - 1];

    if ($prevLeccion["Progreso"] == 1 && $prevLeccion["Lec_Tipo"] == 3) {
      if ($clave >= 2) {
        $posibleSiguiente = $lecciones[$clave - 2];
        $this->redireccionar("elearning/cursos/modulo/" . $curso . "/" . $objeto["Moc_IdModuloCurso"] . "/" . $posibleSiguiente["Lec_IdLeccion"]);
      } else {
        $this->redireccionar("elearning/cursos/curso/" . $curso);
      }
    } else {
      $this->redireccionar("elearning/cursos/modulo/" . $curso . "/" . $objeto["Moc_IdModuloCurso"] . "/" . $prevLeccion["Lec_IdLeccion"]);
    }
  }

  public function _next_leccion() {
    $this->validarUrlIdioma();
    if (!Session::get("autenticado")) {$this->redireccionar("elearning/");}
    $leccion = $this->getInt("leccion");
    $curso = $this->getInt("curso");

    $model = $this->loadModel("leccion");
    $Emodel = $this->loadModel("examen");
    $objeto = $model->getLeccion($leccion);

    if ($objeto["Lec_Tipo"] == 1 || $objeto["Lec_Tipo"] == 2 || $objeto["Lec_Tipo"] == 3 || $objeto["Lec_Tipo"] == 4 || $objeto["Lec_Tipo"] == 6 || $objeto["Lec_Tipo"] == 10) {
      $Emodel->updateProgreso(Session::get("id_usuario"), $leccion);
      $model->RegistrarProgreso($leccion, Session::get("id_usuario"));
    }
    // lecciones
    $lecciones = $model->getLecciones($objeto["Moc_IdModuloCurso"], Session::get("id_usuario"));

    $clave = array_search($objeto["Lec_IdLeccion"], array_column($lecciones, "Lec_IdLeccion"));

    // echo $clave; print_r($objeto);print_r($nextLeccion);print_r($lecciones); exit;

    // if(($nextLeccion["Progreso"] == 0 && $nextLeccion["Lec_Tipo"] == 3)|| $nextLeccion["Lec_Tipo"] != 3){

    // echo $clave;exit;
    if (count($lecciones) > $clave + 1) {
      // $nextLeccion = $lecciones[$clave+1];

      $posibleSiguiente = $lecciones[$clave + 1];
      // echo  "elearning/cursos/modulo/" . $curso . "/" . $objeto["Moc_IdModuloCurso"] . "/" . $posibleSiguiente["Lec_IdLeccion"]."////////////////".$curso.$posibleSiguiente["Lec_IdLeccion"].$objeto["Moc_IdModuloCurso"] .$clave.count($lecciones);exit;
      $this->redireccionar("elearning/cursos/modulo/" . $curso . "/" . $objeto["Moc_IdModuloCurso"] . "/" . $posibleSiguiente["Lec_IdLeccion"]);
    } else {
      // modulos
      $modulos_ = $model->getModulosClave($curso, Session::get("id_usuario"));
      $claveModulos = array_search($objeto["Moc_IdModuloCurso"], array_column($modulos_, "Moc_IdModuloCurso"));
      // $nextModulo = $modulos_[$claveModulos+1];

      if (count($modulos_) > $claveModulos + 1) {
        $posibleSiguienteMod = $modulos_[$claveModulos + 1];

        // lecciones me quede aqui
        $primeraLeccion = $model->getLeccionUno($posibleSiguienteMod["Moc_IdModuloCurso"]);

        if (strtotime($primeraLeccion[0]["Lec_FechaDesde"]) <= strtotime(date("d-m-Y H:i:00", time())) && strtotime($primeraLeccion[0]["Lec_FechaHasta"]) >= strtotime(date("d-m-Y H:i:00", time()))) {
          # code...

          $this->redireccionar("elearning/cursos/modulo/" . $curso . "/" . $posibleSiguienteMod["Moc_IdModuloCurso"]);
        } else {
          # code...
          $this->redireccionar("elearning/cursos/modulo/" . $curso . "/" . $posibleSiguienteMod["Moc_IdModuloCurso"]);
          // $this->redireccionar("elearning/cursos/curso/" . $curso);
        }

      } else {
        // echo $curso ;exit;
        $this->redireccionar("elearning/cursos/curso/" . $curso);
      }
    }
  }

  public function _send_examen() {
    $this->getLibrary("ServiceResult");
    $json = new ServiceResult();
    if (!Session::get("autenticado")) {
      $json->Error("");
      $json->Send();exit;}

    $preguntas = json_decode(html_entity_decode($this->getTexto("data")));
    $examen = $this->getTexto("examen");

    $model = $this->loadModel("examen");
    $Lmodel = $this->loadModel("leccion");

    $OBJ_EXAMEN = $model->getExamenID($examen);
    $OBJ_PREGS = $model->getExamen($OBJ_EXAMEN["Exa_IdExamen"]);
    $intentos = $model->getIntentos($OBJ_EXAMEN["Exa_IdExamen"], Session::get("id_usuario"));

    if ($OBJ_EXAMEN["Exa_Intentos"] != 0 && $intentos >= $OBJ_EXAMEN["Exa_Intentos"]) {
      $json->Error("No tiene mas intentos por realizar");
      $json->Send();exit;
    }
    if ($OBJ_EXAMEN["Exa_NroPreguntas"] == null || strlen($OBJ_EXAMEN["Exa_NroPreguntas"]) == 0) {
      $json->Error("Aun no se finalizó la configuración de este examen, intentelo mas tarde");
      $json->Send();exit;
    }

    $RESPUESTAS = array();
    $CORRECTAS = 0;
    $PUNTO_X_PREGUNTA = 20 / $OBJ_EXAMEN["Exa_NroPreguntas"];
    $NOTA = 0;

    foreach ($preguntas as $p) {
      $preg = $model->getPregunta($p->IdPregunta);
      $preg = $preg[0];

      if ($preg["Pre_Valor"] != $p->Respuesta) {
        $preg["ESTADO"] = 0;
      } else {
        $preg["ESTADO"] = 1;
        $NOTA += $PUNTO_X_PREGUNTA;
        $CORRECTAS++;
      }
      $preg["USUARIO"] = $p->Respuesta;
      $preg["ALTERNATIVAS"] = $model->getAlternativas($preg["Pre_IdPregunta"]);

      array_push($RESPUESTAS, $preg);
      $model->insertRespuesta(Session::get("id_usuario"), $p->IdPregunta, $p->Respuesta, $intentos);
    }
    if ($NOTA > 20) {$NOTA = 20;}
    $porcentaje = $OBJ_EXAMEN["Exa_Porcentaje"];
    $preguntas_totales = $OBJ_EXAMEN["Exa_NroPreguntas"];
    $proporcion = $CORRECTAS == 0 ? 0 : (($CORRECTAS * 100) / $preguntas_totales);

    $ESTADO_FINAL = 0;
    if ($proporcion >= $porcentaje) {
      $ESTADO_FINAL = 1;
      $Lmodel->RegistrarProgreso($OBJ_EXAMEN["Lec_IdLeccion"], Session::get("id_usuario"));
    }
    $resultado = array(
      "RESPUESTAS" => $RESPUESTAS,
      "Porcentaje" => $proporcion,
      "Nota" => $NOTA,
      "ESTADO" => $ESTADO_FINAL,
    );

    $json->Populate($resultado);
    $json->Success("Exito al registrar el examen");
    $json->Send();
  }

  public function obtenerCertificado($id = 0) {
    $model = $this->loadModel("curso");
    $mModulo = $this->loadModel("modulo");
    $mCert = $this->loadModel("certificado");

    $certificado = $mCert->getCertificado_Id($id);
    $plantilla = array();
    $plantilla = $mCert->getPlantillaCertificado($certificado[0]["Cur_IdCurso"]);

    if (!$plantilla) {
      $plantilla['Plc_UrlImg'] = "modules/elearning/views/certificado/img/pric.png";
      $plantilla['Plc_StyleNombre'] = "position: absolute; top: 248px; left: 150px; transform: translate(0%, 0%); font-size: 30px; z-index: 1000; border: 2px solid black; text-align: center; width: 80%;";
      $plantilla['Plc_StyleCurso'] = "position: absolute; top: 356px; left: 156px; transform: translate(0%, 0%); font-size: 30px; z-index: 1000; border: 2px solid black; text-align: center; width: 80%;";
      $plantilla['Plc_StyleHora'] = "position: absolute; top: 404px; left: 316px; transform: translate(0%, 0%); font-size: 26px; z-index: 1000; border: 2px solid black; text-align: center; width: 5%;";
      $plantilla['Plc_StyleFecha'] = "position: absolute; top: 562px; left: 741px; transform: translate(0%, 0%); font-size: 22px; z-index: 1000; border: 2px solid black; text-align: center; width: 30%;";
      $plantilla['Plc_StyleCodigo'] = "position: absolute; top: 700px; left: 130px; transform: translate(0%, 0%); font-size: 18px; z-index: 1000; border: 2px solid black; text-align: center; width: 20%;";

    }

    $modulo = $mModulo->getModulosCurso_Id($certificado[0]["Cur_IdCurso"]);

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->setCss(array("curso", "jp-curso"));
    $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "curso"));

    // if ($this->botonPress("export_data_pdf")) {
    $b = "";
    $c = "";
    $d = "";
    $cuerpo = "";
    $img = BASE_URL . $plantilla['Plc_UrlImg'];
    $a = "
              <head>
                  <link href='views/layout/frontend/css/bootstrap.min.css' rel='stylesheet' type='text/css'>
                  <STYLE type='text/css'>
                  @page {
                              margin: 0;
                          }
                   </STYLE>
              </head>
              <body>
                <div class='col-lg-12 col-xs-12' style='position: relative; display: inline-block; text-align:center; height:100%; padding:0px;'>
                    <img src='" . $img . "' style='width:100%; height:21cm'>
                    <div class='' style=' " . $plantilla['Plc_StyleNombre'] . "border:0; '><b>" . $certificado[0]['Usu_Nombre'] . " " . $certificado[0]['Usu_Apellidos'] . "</b></div>
                    <div class='col-lg-12 hidden-xs' style='" . $plantilla['Plc_StyleCurso'] . "border:0; '><b>" . $certificado[0]['Cur_Titulo'] . "</b></div>
                    <div class='col-lg-12 hidden-xs' style='" . $plantilla['Plc_StyleFecha'] . "border:0; '>" . $certificado[0]['Fecha_completa'] . "<br/></div>
                    <div class='col-lg-12 hidden-xs' style='" . $plantilla['Plc_StyleHora'] . "border:0; '>" . $certificado[0]['Cur_Duracion'] . "</div>
                    <div class='col-lg-12 hidden-xs'  style='". $plantilla['Plc_StyleCodigo'] . "border:0; '>" . "<span >Certificación de aprobación online</span><br/><span >Código:" . $certificado[0]['Cer_Codigo'] . "</span></div>
                    </div>
              <script type='text/javascript' src='views/layout/frontend/js/bootstrap.min.js' ></script>
          </body>";

    // $a = "
    // <html>
    //     <head>
    //         <link href='views/layout/frontend/css/bootstrap.min.css' rel='stylesheet' type='text/css'>
    //     </head>
    //     <body style='width:100vw'>
    //       <div class='col-lg-12 col-xs-12' style='background-image: url(".$img."); background-size: contain; width: 100%; height:100%; position: fixed;  background-repeat:no-repeat; background-position:center center;'>
    //           <div class='' style=' ".$plantilla['Plc_StyleNombre']."border:0; '><b>".$certificado[0]['Usu_Nombre']." ".$certificado[0]['Usu_Apellidos']."</b><br/></div>
    //           <div class='' style='".$plantilla['Plc_StyleCurso']."border:0; '><span style='font-size:30px'><b>".$certificado[0]['Cur_Titulo']."</b></span><br/></div>
    //           <div class='' style='".$plantilla['Plc_StyleFecha']."border:0; '><span style='font-size:20px'>".$certificado[0]['Fecha_completa']."</span><br/></div>
    //           <div class='' style='position: absolute; bottom:0; left: 5%;'><span style='font-size:13px'>Certificación de aprobación online</span><br/><span style='font-size:12px'>Código:".$certificado[0]['Cer_Codigo']."</span></div>
    //           </div>
    //     <script type='text/javascript' src='views/layout/frontend/js/bootstrap.min.js' ></script>
    //     </body></html>";
    // echo $a.$cuerpo.$e; exit;

    require_once "libs/autoload.inc.php";
    $dompdf = new Dompdf(array('enable_remote' => true));
    $dompdf->set_paper('A4', 'landscape'); //esta es una forma de ponerlo horizontal
    $dompdf->set_option('isHtml5ParserEnabled', true);
    $dompdf->loadHtml("$a.$cuerpo");
    $dompdf->render();
    $dompdf->stream("'" . APP_NAME . '-OTCA_Descargas.pdf');
    // }

    // $this->_view->assign("modulo", $modulo);
    // $this->_view->assign("certificado", $certificado);
    // $this->_view->assign("plantilla", $plantilla);
    // // $this->_view->assign("detalle", $model->getDetalleCurso($curso["Cur_IdCurso"]));
    // $this->_view->assign("session",Session::get("autenticado"));
    // $this->_view->renderizar('certificado_curso');
  }

  public function verCertificado($id = 0) {
    $model = $this->loadModel("curso");
    $mModulo = $this->loadModel("modulo");
    $mCert = $this->loadModel("certificado");

    $certificado = $mCert->getCertificado_Id($id);
    // dd($certificado);
    $plantilla = $mCert->getPlantillaCertificado($certificado[0]["Cur_IdCurso"]);

    if (!$plantilla) {
      $plantilla['Plc_UrlImg'] = "modules/elearning/views/certificado/img/pric.png";
      $plantilla['Plc_StyleNombre'] = "position: absolute; top: 248px; left: 150px; transform: translate(0%, -50%); font-size: 30px; z-index: 1000; border: 2px solid black; text-align: center; width: 80%;";
      $plantilla['Plc_StyleCurso'] = "position: absolute; top: 356px; left: 156px; transform: translate(0%, -50%); font-size: 30px; z-index: 1000; border: 2px solid black; text-align: center; width: 80%;";
      $plantilla['Plc_StyleHora'] = "position: absolute; top: 404px; left: 316px; transform: translate(0%, -50%); font-size: 26px; z-index: 1000; border: 2px solid black; text-align: center; width: 5%;";
      $plantilla['Plc_StyleFecha'] = "position: absolute; top: 562px; left: 741px; transform: translate(0%, -50%); font-size: 22px; z-index: 1000; border: 2px solid black; text-align: center; width: 30%;";

    }

    $modulo = $mModulo->getModulosCurso_Id($certificado[0]["Cur_IdCurso"]);

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->setCss(array("curso", "jp-curso"));
    $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "curso"));

    if ($this->botonPress("export_data_pdf")) {
      $b = "";
      $c = "";
      $d = "";
      $cuerpo = "";
      $img = BASE_URL . $plantilla['Plc_UrlImg'];
      $a = "
              <head>
                  <link href='views/layout/frontend/css/bootstrap.min.css' rel='stylesheet' type='text/css'>
                  <STYLE type='text/css'>
                  @page {
                              margin: 0;
                          }
                   </STYLE>
              </head>
              <body>
                <div class='col-lg-12 col-xs-12' style='position: relative; display: inline-block; text-align:center; height:100%; padding:0px;'>
                    <img src='" . $img . "' style='width:100%; height:21cm'>
                    <div class='' style=' " . $plantilla['Plc_StyleNombre'] . "border:0; '><b>" . $certificado[0]['Usu_Nombre'] . " " . $certificado[0]['Usu_Apellidos'] . "</b></div>
                    <div class='col-lg-12 hidden-xs' style='" . $plantilla['Plc_StyleCurso'] . "border:0; '><b>" . $certificado[0]['Cur_Titulo'] . "</b></div>
                    <div class='col-lg-12 hidden-xs' style='" . $plantilla['Plc_StyleFecha'] . "border:0; '>" . $certificado[0]['Fecha_completa'] . "<br/></div>
                     <div class='col-lg-12 hidden-xs' style='" . $plantilla['Plc_StyleHora'] . "border:0; '>" . $certificado[0]['Cur_Duracion'] . "</div>
                    <div class='col-lg-12 col-xs-12' style='position: absolute; bottom:0; left: 5%;'><span style='font-size:13px'>Certificación de aprobación online</span><br/><span style='font-size:12px'>Código:" . $certificado[0]['Cer_Codigo'] . "</span></div>
                    </div>
              <script type='text/javascript' src='views/layout/frontend/js/bootstrap.min.js' ></script>
          </body>";

      // $a = "
      // <html>
      //     <head>
      //         <link href='views/layout/frontend/css/bootstrap.min.css' rel='stylesheet' type='text/css'>
      //     </head>
      //     <body style='width:100vw'>
      //       <div class='col-lg-12 col-xs-12' style='background-image: url(".$img."); background-size: contain; width: 100%; height:100%; position: fixed;  background-repeat:no-repeat; background-position:center center;'>
      //           <div class='' style=' ".$plantilla['Plc_StyleNombre']."border:0; '><b>".$certificado[0]['Usu_Nombre']." ".$certificado[0]['Usu_Apellidos']."</b><br/></div>
      //           <div class='' style='".$plantilla['Plc_StyleCurso']."border:0; '><span style='font-size:30px'><b>".$certificado[0]['Cur_Titulo']."</b></span><br/></div>
      //           <div class='' style='".$plantilla['Plc_StyleFecha']."border:0; '><span style='font-size:20px'>".$certificado[0]['Fecha_completa']."</span><br/></div>
      //           <div class='' style='position: absolute; bottom:0; left: 5%;'><span style='font-size:13px'>Certificación de aprobación online</span><br/><span style='font-size:12px'>Código:".$certificado[0]['Cer_Codigo']."</span></div>
      //           </div>
      //     <script type='text/javascript' src='views/layout/frontend/js/bootstrap.min.js' ></script>
      //     </body></html>";
      // echo $a.$cuerpo.$e; exit;

      require_once "libs/autoload.inc.php";
      $dompdf = new Dompdf(array('enable_remote' => true));
      $dompdf->set_paper('A4', 'landscape'); //esta es una forma de ponerlo horizontal
      $dompdf->set_option('isHtml5ParserEnabled', true);
      $dompdf->loadHtml("$a.$cuerpo");
      $dompdf->render();
      $dompdf->stream("'" . APP_NAME . '-OTCA_Descargas.pdf');
    }

    $this->_view->assign("modulo", $modulo);
    $this->_view->assign("certificado", $certificado);
    $this->_view->assign("plantilla", $plantilla);
    // $this->_view->assign("detalle", $model->getDetalleCurso($curso["Cur_IdCurso"]));
    $this->_view->assign("session", Session::get("autenticado"));
    if ($this->getTexto('view') == 'app') {

      $this->_view->render('certificado_curso');
    } else {
      $this->_view->renderizar('certificado_curso');
    }

  }
}
