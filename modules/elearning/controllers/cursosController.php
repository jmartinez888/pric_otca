<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class cursosController extends elearningController {

  public function __construct($lang,$url)
  {
    parent::__construct($lang,$url);
  }

  public function index(){
    $this->redireccionar("elearning/");
  }

  public function ficha($id = ""){
    if( strlen($id) == "" || !is_numeric($id) ){ $this->redireccionar("elearning/"); }
    $model = $this->loadModel("curso");

    $curso = $model->getCursoID($id);
    if( !isset($curso) || count($curso) == 0 || $curso == null ){ $this->redireccionar("elearning/"); }
    $usuario = $model->getUsuarioCurso($id);
    if( !isset($usuario) || count($usuario) == 0 || $usuario == null ){ $this->redireccionar("elearning/"); }
    $cursos = $model->getCursosUsuario($usuario[0]["Usu_IdUsuario"]);

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->setCss(array("jp-datos-docente"));
    $this->_view->assign("curso",$curso[0]);
    $this->_view->assign("cursos",$cursos);
    $this->_view->assign("usuario",$usuario[0]);
    $this->_view->renderizar('ficha');
  }

  public function cursos($busqueda = ""){
    $model = $this->loadModel("curso");
    $mConstante = $this->loadModel("constante");

    if($busqueda==""){
      $cursos = $model->getCurso();
    }else{
      $busqueda = str_replace("_", " ", $busqueda);
      $cursos = $model->getCursoBusqueda($busqueda);
    }
    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->setCss(array("modulo", "index", "jp-index", "jp-detalle-lateral"));
    $this->_view->assign("busqueda",$busqueda);
    $this->_view->assign("curso",$cursos);
    $this->_view->renderizar('inicio');
  }

  public function miscursos(){
    if(!Session::get("autenticado")){ $this->redireccionar("elearning/"); }
    $model = $this->loadModel("curso");
    $mConstante = $this->loadModel("constante");
    $cursos = $model->getCursoUsuario(Session::get("id_usuario"));

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->setCss(array("index","jp-index", "jp-detalle-lateral2"));
    $this->_view->assign("busqueda","");
    $this->_view->assign("usu_curso",Session::get("usuario"));
    $this->_view->assign("curso",$cursos);
    $this->_view->renderizar('inicio');
  }

  public function miscursos_docente(){
    if(!Session::get("autenticado")){ $this->redireccionar("elearning/"); }
    $model = $this->loadModel("curso");
    $mConstante = $this->loadModel("constante");
    $cursos = $model->getCursoDocente(Session::get("id_usuario"));

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->setCss(array("index"));
    $this->_view->assign("busqueda","");
    $this->_view->assign("usu_curso",Session::get("usuario"));
    $this->_view->assign("curso",$cursos);
    $this->_view->renderizar('inicio');
  }

  public function curso($id=""){
    if($id == "" || !is_numeric($id) ){ $this->redireccionar("elearning/"); }
    $model = $this->loadModel("curso");
    $mObj = $this->loadModel("objetivos");
    $mModulo = $this->loadModel("modulo");
    $mInsc = $this->loadModel("inscripcion");
    $mCert = $this->loadModel("certificado");

    $curso = $model->getCursoID($id)[0];
    if($curso["Mod_IdModCurso"]==2){ $this->redireccionar("elearning/cursos/curso_dirigido/" . $curso["Cur_IdCurso"]); }
    $inscritos = $mInsc->getInscritos($id);
    if(Session::get("autenticado")){
      $progreso = $model->getProgresoCurso($id, Session::get("id_usuario"));
      $this->_view->assign("progreso", $progreso);
    }
    $modulo = $mModulo->getModulosCurso($id, Session::get("id_usuario"));
    $duracion = $model->getDuracionCurso($id);
    $certificado = $mCert->getCertificadoUsuarioCurso(Session::get("id_usuario"), $id);

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->setCss(array("curso", "jp-curso"));
    $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "curso"));
    $this->_view->assign("inscritos", $inscritos);
    $this->_view->assign("curso", $curso);
    $this->_view->assign("objetivos", $mObj->getObjs($id));
    $this->_view->assign("modulo", $modulo);
    $this->_view->assign("certificado", $certificado);
    $this->_view->assign("duracion", $duracion["Total"] . " Lecciones");
    $this->_view->assign("detalle", $model->getDetalleCurso($curso["Cur_IdCurso"]));
    $this->_view->assign("inscripcion",$mInsc->getInscripcion(Session::get("id_usuario"), $id));
    $this->_view->assign("session",Session::get("autenticado"));
    $this->_view->renderizar('curso');
  }

  public function curso_dirigido($id = ""){
    if($id == "" || !is_numeric($id) ){ $this->redireccionar("elearning/"); }
    $model = $this->loadModel("curso");
    $mObj = $this->loadModel("objetivos");
    $mModulo = $this->loadModel("modulo");
    $mLeccion = $this->loadModel("leccion");
    $mInsc = $this->loadModel("inscripcion");
    $mCert = $this->loadModel("certificado");

    $curso = $model->getCursoID($id)[0];
    if($curso["Mod_IdModCurso"]==1){ $this->redireccionar("elearning/cursos/curso/" . $curso["Cur_IdCurso"]); }
    $inscripcion = $mInsc->getInscripcion(Session::get("id_usuario"), $id);

    if(Session::get("autenticado") && count($inscripcion)>0 && $inscripcion[0]["Mat_Valor"]){
      $progreso = $model->getProgresoCurso($id, Session::get("id_usuario"));
      $this->_view->assign("progreso", $progreso);
    }

    $inscritos = $mInsc->getInscritos($id);
    $lecciones = $mLeccion->getLeccionesLMS($id);
    $duracion = $model->getDuracionCurso($id);
    $certificado = $mCert->getCertificadoUsuarioCurso(Session::get("id_usuario"), $id);

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->setCss(array("curso", "cursolms", "jp-curso"));
    $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "curso"));
    $this->_view->assign("curso", $curso);
    $this->_view->assign("inscritos", $inscritos);
    $this->_view->assign("certificado", $certificado);
    $this->_view->assign("duracion", $duracion["Total"] . " Lecciones");
    $this->_view->assign("modulo", $mModulo->getModulosCursoLMS($id, Session::get("id_usuario")));
    $this->_view->assign("session", Session::get("autenticado"));
    $this->_view->assign("inscripcion", $inscripcion);
    $this->_view->renderizar('curso_dirigido');
  }

  public function modulo($curso= "", $modulo = "", $leccion = ""){
    $Mmodel = $this->loadModel("modulo");
    $Lmodel = $this->loadModel("leccion");
    $Cmodel = $this->loadModel("curso");

    if(strlen($curso)==0 || strlen($modulo)==0){ $this->redireccionar("elearning/"); }
    if(!Session::get("autenticado")){ $this->redireccionar("elearning/"); }
    if(!is_numeric($curso) || !is_numeric($modulo)){ $this->redireccionar("elearning/"); }
    if(!$Mmodel->validarCursoModulo($curso, $modulo)){ $this->redireccionar("elearning/cursos"); }
    if(!$Mmodel->validarModuloUsuario($modulo, Session::get("id_usuario"))){ $this->redireccionar("elearning/cursos"); }
    //if(!$Lmodel->validarLeccion($leccion, $modulo, Session::get("id_usuario"))){ $this->redireccionar("elearning/cursos"); }
    
    $OLeccion = $Lmodel->getLeccion($leccion, $modulo, Session::get("id_usuario"));
    $lecciones = $Lmodel->getLecciones($modulo, Session::get("id_usuario"));
    $clave = array_search($OLeccion["Lec_IdLeccion"], array_column($lecciones, "Lec_IdLeccion"));
// print($lecciones);
    $tmp = $lecciones[$clave];
    $datos_modulo = $Mmodel->getModuloDatos($OLeccion["Mod_IdModulo"]);

    $indice_leccion = $clave + 1;
    $final = count($lecciones) == $indice_leccion ? true : false;

    if($OLeccion==null){ $this->redireccionar("elearning/cursos"); }
    if($OLeccion["Lec_Tipo"] == 1){
        //$Lmodel->RegistrarProgreso($OLeccion["Lec_IdLeccion"], Session::get("id_usuario"));
        $html = $Lmodel->getContenido($OLeccion["Lec_IdLeccion"]);
        $this->_view->assign("cont_html", $html);
        
    }else if($OLeccion["Lec_Tipo"] == 2){     
        //$Lmodel->RegistrarProgreso($OLeccion["Lec_IdLeccion"], Session::get("id_usuario"));
        $html = $Lmodel->getContenido($OLeccion["Lec_IdLeccion"]);
        $this->_view->assign("html", $html[0]);
    }else if($OLeccion["Lec_Tipo"] == 3){
        $Emodel = $this->loadModel("examen");
        $examen = $Emodel->getExamen($OLeccion["Lec_IdLeccion"]);
        $intentos = $Emodel->getIntentos($examen["Exa_IdExamen"], Session::get("id_usuario"));

        if($tmp["Progreso"]==1 || $intentos > 0){
          $resultados = $Cmodel->getResultadoExamen($examen["Exa_IdExamen"], Session::get("id_usuario"));
          if($resultados != null){
            $angulo_ok = $resultados["CORRECTAS"] * 360 / ($resultados["CORRECTAS"] + $resultados["INCORRECTAS"]);
            $ang_1 = $angulo_ok > 180 ? 180 : $angulo_ok;
            $ang_2 = $angulo_ok > 180 ? $angulo_ok - $ang_1 : 0;
            $this->_view->assign("ang_1", $ang_1);
            $this->_view->assign("ang_2", $ang_2);
            $this->_view->assign("next_mod", $Mmodel->getNextModulo($modulo));
          }
          $this->_view->assign("resultados", $resultados);
          //$this->redireccionar("elearning/cursos/modulo/" . $curso. "/" . $tmp["Mod_IdModulo"] . "/" . 
            //$lecciones[0]["Lec_IdLeccion"]);
        }
        $OLeccion["Progreso"]=$tmp["Progreso"];

        if($examen==null){ $this->redireccionar("elearning/"); }
        $this->_view->assign("intentos", $intentos);
        $this->_view->assign("examen", $examen);
    }else if ($OLeccion["Lec_Tipo"] == 4){
      $this->redireccionar("elearning/clase/clase/" . $curso . "/" .$modulo  . "/" . $OLeccion["Lec_IdLeccion"]);
      exit;
    }
    else if ($OLeccion["Lec_Tipo"] == 5){
      $this->redireccionar("elearning/clase/examen/" . $curso . "/" .$modulo  . "/" . $OLeccion["Lec_IdLeccion"]);
      exit;
    }

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->assign("mod_datos", $datos_modulo);
    $this->_view->assign("modulo", $Mmodel->getModulo($modulo));
    $this->_view->assign("lecciones", $lecciones);
    $this->_view->assign("leccion", $OLeccion);
    $this->_view->assign("referencias", $Lmodel->getReferencias($OLeccion["Lec_IdLeccion"]));
    $this->_view->assign("materiales", $Lmodel->getMateriales($OLeccion["Lec_IdLeccion"]));
    $this->_view->assign("curso", $curso);
    $this->_view->setCss(array('modulo', 'jp-modulo'));
    $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), 'modulo'));
    $this->_view->renderizar('modulo');
  }

  public function _inscripcion($mod = "", $curso = ""){
    if ($mod=="" || $curso=="" || !is_numeric($mod) || !is_numeric($mod)){ $this->redireccionar("elearning/"); }
    if (!Session::get("autenticado")){ $this->redireccionar("elearning/"); }

    $model = $this->loadModel("inscripcion");
    if($mod==1){
      $model->insertarInscripcion(Session::get("id_usuario"), $curso, 1);
    }else{
      $model->insertarInscripcion(Session::get("id_usuario"), $curso, 2);
    }
    $this->redireccionar("elearning/cursos/curso/" . $curso);
  }

  public function _previous_leccion(){
    if(!Session::get("autenticado")){ $this->redireccionar("elearning/"); }
    $leccion = $this->getTexto("leccion");
    $curso = $this->getTexto("curso");

    $model = $this->loadModel("leccion");
    $objeto = $model->getLeccion($leccion);
    $lecciones = $model->getLecciones($objeto["Mod_IdModulo"], Session::get("id_usuario"));

    $clave = array_search($objeto["Lec_IdLeccion"], array_column($lecciones, "Lec_IdLeccion"));
    if($clave==0){
      $this->redireccionar("elearning/cursos/curso/" . $curso); exit;
    }
    $prevLeccion = $lecciones[$clave-1];

    if($prevLeccion["Progreso"]==1 && $prevLeccion["Lec_Tipo"]==3){
      if($clave >= 2){
        $posibleSiguiente = $lecciones[$clave-2];
        $this->redireccionar("elearning/cursos/modulo/" . $curso . "/" . $objeto["Mod_IdModulo"] . "/" . $posibleSiguiente["Lec_IdLeccion"]);
      }else{
        $this->redireccionar("elearning/cursos/curso/" . $curso);
      }
    }else{
      $this->redireccionar("elearning/cursos/modulo/" . $curso . "/" . $objeto["Mod_IdModulo"] . "/" . $prevLeccion["Lec_IdLeccion"]);
    }
  }

  public function _next_leccion(){
    if(!Session::get("autenticado")){ $this->redireccionar("elearning/"); }
    $leccion = $this->getTexto("leccion");
    $curso = $this->getTexto("curso");

    $model = $this->loadModel("leccion");
    $objeto = $model->getLeccion($leccion);

    if($objeto["Lec_Tipo"] == 1 || $objeto["Lec_Tipo"] == 2){
      $model->RegistrarProgreso($leccion, Session::get("id_usuario"));
    }

    $lecciones = $model->getLecciones($objeto["Mod_IdModulo"], Session::get("id_usuario"));

    $clave = array_search($objeto["Lec_IdLeccion"], array_column($lecciones, "Lec_IdLeccion"));
    $nextLeccion = $lecciones[$clave+1];

    if($nextLeccion["Progreso"]==1 && $nextLeccion["Lec_Tipo"]==3){

      if(count($lecciones) > $clave+2){
        $posibleSiguiente = $lecciones[$clave+2];
        $this->redireccionar("elearning/cursos/modulo/" . $curso . "/" . $objeto["Mod_IdModulo"] . "/" . $posibleSiguiente["Lec_IdLeccion"]);
      }else{
        $this->redireccionar("elearning/cursos/curso/" . $curso);
      }
    }else{
      $this->redireccionar("elearning/cursos/modulo/" . $curso . "/" . $objeto["Mod_IdModulo"] . "/" . $nextLeccion["Lec_IdLeccion"]);
    }
  }

  public function _send_examen(){
    $this->getLibrary("ServiceResult");
    $json = new ServiceResult();
    if(!Session::get("autenticado")){ $json->Error(""); $json->Send(); exit; }

    $preguntas = json_decode(html_entity_decode($this->getTexto("data")));
    $examen = $this->getTexto("examen");

    $model = $this->loadModel("examen");
    $Lmodel = $this->loadModel("leccion");

    $OBJ_EXAMEN = $model->getExamenID($examen);
    $OBJ_PREGS = $model->getExamen($OBJ_EXAMEN["Exa_IdExamen"]);
    $intentos = $model->getIntentos($OBJ_EXAMEN["Exa_IdExamen"], Session::get("id_usuario"));

    if($OBJ_EXAMEN["Exa_Intentos"] != 0 && $intentos >= $OBJ_EXAMEN["Exa_Intentos"]){
        $json->Error("No tiene mas intentos por realizar"); $json->Send(); exit;
    }
    if ($OBJ_EXAMEN["Exa_NroPreguntas"] == null || strlen($OBJ_EXAMEN["Exa_NroPreguntas"])==0 ){
        $json->Error("Aun no se finalizó la configuración de este examen, intentelo mas tarde"); $json->Send(); exit;
    }

    $RESPUESTAS = array();
    $CORRECTAS = 0;
    $PUNTO_X_PREGUNTA = 20/$OBJ_EXAMEN["Exa_NroPreguntas"];
    $NOTA = 0;

    foreach ($preguntas as $p) {
      $preg = $model->getPregunta($p->IdPregunta);
      $preg = $preg[0];

      if ($preg["Pre_Valor"] != $p->Respuesta){
        $preg["ESTADO"] = 0;
      }else{
        $preg["ESTADO"] = 1;
        $NOTA += $PUNTO_X_PREGUNTA;
        $CORRECTAS ++;
      }
      $preg["USUARIO"] = $p->Respuesta;
      $preg["ALTERNATIVAS"] = $model->getAlternativas($preg["Pre_IdPregunta"]);

      array_push($RESPUESTAS, $preg);
      $model->insertRespuesta(Session::get("id_usuario"), $p->IdPregunta, $p->Respuesta, $intentos);
    }
    if( $NOTA > 20 ) { $NOTA = 20; }
    $porcentaje = $OBJ_EXAMEN["Exa_Porcentaje"];
    $preguntas_totales = $OBJ_EXAMEN["Exa_NroPreguntas"];
    $proporcion = $CORRECTAS==0 ? 0 : ( ($CORRECTAS * 100) / $preguntas_totales);

    $ESTADO_FINAL = 0;
    if( $proporcion >= $porcentaje){
      $ESTADO_FINAL = 1;
      $Lmodel->RegistrarProgreso($OBJ_EXAMEN["Lec_IdLeccion"], Session::get("id_usuario"));
    }
    $resultado = array( 
      "RESPUESTAS" => $RESPUESTAS, 
      "Porcentaje" => $proporcion, 
      "Nota" => $NOTA, 
      "ESTADO" => $ESTADO_FINAL
    );

    $json->Populate($resultado);
    $json->Success("Exito al registrar el examen");
    $json->Send();
  }

  public function obtenerCertificado($id=0){
    $model = $this->loadModel("curso");
    $mModulo = $this->loadModel("modulo");
    $mCert = $this->loadModel("certificado");

// array taller hpc
// $certificado = array(" CARLOS ALBERTO PAREDES ROJAS  ",
// " ANTHONY WILL SOLSOL SOPLIN ",
// " JOEL HURTADO HUERTAS ",
// " JOSE MARTIN NAVARRO FASANADO ",
// " BRAYAN KENYI SAAVEDRA VARGAS ",
// " ELDER ORLANDO CULQUI GUZMAN ",
// " ROMELIA JOSEFINA GARCIA RIOS ",
// " JAIR AGAPITO AREVALO ",
// " JHONY FERNANDEZ GOMEZ ",
// " PEDRO ANTONIO GONZALES SANCHEZ ",
// " ROYER ANDINO RIOS VALERA ",
// " ERICK CRISTOFER GUEVARA ROJAS  ",
// " JUAN CARLOS GARCIA CASTRO  ",
// " CHRISTIAN JUNIOR ZAVALETA TANGOA  ",
// " LINCOLN FERNANDO RIOS PALERMO  ",
// " RYAN ALI RUIZ VILLANUEVA  ",
// " VICTOR JUNIOR GARCIA MONTALVAN  ",
// " CARLOS ARMANDO RIOS LOPEZ  ",
// " MARI ISABEL CUJE TUITAY  ",
// " AARON NIKOLAY VASQUEZ TAFUR  ",
// " CARLOS ALBERTOLOPEZ RIBEIRO  ",
// " MARIA GABRIELA PINEDO CHUNG  ",
// " MICHEL ALONSO PALACIOS MORENO  ",
// " TATIANA MILDRED UCAÑAY AYLLON  ");


// $certificado = array(
// " Erick  Gómez Nieto ",
// " Jorge  Poco Medina ");

// $certificado = array(
// " Dr. JUAN JOSE JIMENEZ GARAVITO",
// " Dr. EDGAR LEONARDO PEÑA CASAS ",
// " MBA PACO MARQUEZ URBINA ",
// " Ing. M. Sc. PEDRO ANTONIO GONZALES SÁNCHEZ ");

// taller manati
//     $certificado = array(" JUAN CARLOS GARCIA CASTRO ",
// " CARLOS ARMANDO RIOS ",
// " TATIANA MALDRID UCAÑAY AYLLON ");


//taller data
// $certificado = array(" ANTHONY WILL SOLSOL SOPLIN ",
// " BRAYAN KENYI SAAVEDRA VARAS ",
// " CARLOS ALBERTO PAREDES ROJAS ",
// " ELDER ORLANDO CULQUI GUZMAN ",
// " JAIR AGAPITO AREVALO ",
// " JERSON ALEJANDRO SOLSOL SAAVEDRA ",
// " JOEL HURTADO HUERTAS ",
// " JOSE MARTIN NAVARRO FASANANDO ",
// " ROMELIA JOSEFINA GARCIA RIOS ",
// " ROYER ANDINO RIOS VALERA ",
// " JUAN CARLOS GARCIA CASTRO "
// );


//asistentes faltantes
// $certificado = array(
//" JORGE ANTONIO BAUTISTA SOTELO ",
//" JOAO VALENTINNO PINHEIRO RODRIGUEZ ",
//" ELISBAN FLORES QUENAYA ",
//" ANIBAL FERNANDO FLORES GARCIA ",
//" ERWIN PABLO PEÑA CASAS ",
//" ENRIQUE MENDOZA CABALLERO ",
//" PEDRO ANTONIO GONZALES SANCHEZ ",
//" CARLOS ARMANDO RIOS LOPEZ "
//);

//tallercmas
// $certificado = array(
//" GONZALO MAURICIO DA SILVA TORRES ",
//" JHOSELIN PIERINA LAULATE LAVINTO ",
//" DALIA ESTHER RENGIFO PÉREZ ",
//" ALEXIS YAICATE VELA ",
//" JOSÉ CARLOS GONZÁLES PÉREZ",
//" WILMAR ALEJANDRO CHU GONZALES ",
//" PABLO LÓPEZ RAMÍREZ ",
//" PATRICE RADEK ANTONY SIFUENTES RAMOS",
//" DÁMASO CÉSAR DEL AGUILA VARGAS ",
//" MIGUEL GUSTAVO CARMEN GUEVARA ",
//" JERUSALÉN MILAGROS ZÁRATE ALBA ",
//" ADHEMIR HAROLDO NASCIMENTO ESPINOZA "
//);


//tallergestiondatos
// $certificado = array(
//" RUBI MARISELA AHUANARI FERNÁNDEZ ",
//" GIAN PIERRE PINEDO LINARES",
//" JORGE ANTONIO BAUTISTA SOTELO "
//);


//tallerarduino
// $certificado = array(
// " LÍA IYNÉS ESMERALDA MARTÍNEZ TAPULLIMA ",
// " EDUARDO OTONIEL MELENA RAMÍREZ ",
// " ORLANDO ULISES AMIAS DAHUA ",
// " ROY MARCELO SAQUIRAY BOCANEGRA",
// );
    $certificado =$mCert->getCertificado_Id($id);
    $modulo = $mModulo->getModulosCurso_Id($certificado[0]["Cur_IdCurso"]);

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $this->_view->setCss(array("curso", "jp-curso"));
    $this->_view->setJs(array(array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'), "curso"));
    $this->_view->assign("modulo", $modulo);
    $this->_view->assign("certificado", $certificado);
    // $this->_view->assign("detalle", $model->getDetalleCurso($curso["Cur_IdCurso"]));
    $this->_view->assign("session",Session::get("autenticado"));
    $this->_view->renderizar('certificado_curso');
  }

}
