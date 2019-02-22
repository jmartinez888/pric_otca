<?php

use App\Formulario;

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
  public function formulario ($curso_id) {

    $this->validarUrlIdioma();
    $this->_acl->autenticado();
    //verificar que el rol sea de docente o permiso de editar formulario
    if ($this->_acl->tienePermisos('crear_formulario')) {
      $lang = $this->_view->getLenguaje(['elearning_gcurso', 'elearning_formulario_responder'], false, true);

      $data['titulo'] = $lang->get('elearning_gcurso_gestion_formulario');
      $this->_view->setTemplate(LAYOUT_FRONTEND);
      $curso = $this->curso->getCursoXId($curso_id);
      if ($curso['Moa_IdModalidad'] == 3) {
        $formulario = Formulario::getByCurso($curso['Cur_IdCurso']);
        $formulario = $formulario->count() > 0 ? $formulario[0] : null;
        $data['respuestas'] = [];
        if ($formulario) {
          $data['respuestas'] = $formulario->respuestas;

        }
        // dd($formulario);
        // $data_vue = [
        //   'formulario_id' => $formulario != null ? $formulario : null
        // ];
        $data['menu'] = 'curso';
        $data['curso'] = $curso;
        $data['titulo'] = $curso['Cur_Titulo'].' - '.$data['titulo'];
        $data['formulario'] = $formulario;
        // $data['data_frm'] = $data_vue;
        $this->_view->assign($data);
        $this->_view->render('formulario');
      } else {
        $this->redireccionar('elearning/gestion');
      }
    } else {
      $this->redireccionar('elearning/gestion');
    }
  }
  public function index(){ }

  public function _view_mis_cursos()
  {

    $this->validarUrlIdioma();
    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $id = Session::get("id_usuario");
    $busqueda = $this->getTexto('busqueda');
    // $cursos = $this->curso->getCursoXDocente($id, $busqueda);

    $soloActivos = 1;//0
    if (!$this->_acl->permiso('ver_eliminados')) {
      $soloActivos = 1;
      // $sql .= " AND cur.Row_Estado = $soloActivos ";
    }
    $cursos = $this->curso->getMisCursos($id, $busqueda, $soloActivos);

    //print_r($cursos); exit;
    // $this->_view->setCss(array("jm-mis-cursos"));
    // Session::set("learn_url_tmp", "gcurso/_view_mis_cursos");
    // $this->_view->getLenguaje("learn");
    $lang = $this->_view->getLenguaje(['elearning_gcurso', 'elearning_cursos'], false, true);
    
    $this->_view->assign('titulo', $lang->get('str_mis_cursos'));
    $this->_view->assign('menu', 'docente');
    $this->_view->assign('cursos', $cursos);
    $this->_view->assign('busqueda', $busqueda);
    $this->_view->assign('curso', $this->getTexto("id"));
    $this->_view->render('ajax/_view_mis_cursos');
  }

  public function _view_registrar()
  {

    $this->validarUrlIdioma();
    // Session::set("learn_url_tmp", "gcurso/_view_registrar");
    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $modalidad = $this->curso->getModalidadCurso();

    // $this->_view->getLenguaje("learn");
    $lang = $this->_view->getLenguaje(['elearning_gcurso','learn','idioma_index', 'elearning_cursos'], false, true);
    
    $_arquitectura = $this->loadModel('index','arquitectura');
    $this->_view->assign('idiomas',$_arquitectura->getIdiomas());
    $this->_view->assign('menu', 'docente');
    $this->_view->assign('idiomaCookie', Cookie::lenguaje());
    $this->_view->assign('modalidad', $modalidad);
    $this->_view->render('ajax/_view_registrar');
  }

  public function _view_finalizar_registro($idcurso = 0)
  {
    
    $this->validarUrlIdioma();
    // $id = $this->getTexto("id");
    // $idcurso = 1;    
    $_arquitectura = $this->loadModel('index','arquitectura');

    $this->_view->setTemplate(LAYOUT_FRONTEND);
    $lang = $this->_view->getLenguaje(['elearning_gcurso', 'elearning_cursos'], false, true);
    if(!is_numeric($idcurso) && strlen($idcurso)==0){ $idcurso = Session::get("learn_param_curso"); }
    if(strlen($idcurso)==0){ exit; }
    
    $datos = $this->curso->getCursoById($idcurso, Cookie::lenguaje());
    $parametros = $this->curso->getParametros($idcurso);
    // print_r($datos); 
    Session::set("learn_param_curso", $idcurso);
    Session::set("learn_url_tmp", "gcurso/_view_finalizar_registro");

    $this->_view->assign('idiomas',$_arquitectura->getIdiomas());

    $this->_view->assign('modalidad', $datos["Moa_IdModalidad"]);
    $this->_view->assign('curso', $datos);
    $this->_view->assign('menu', 'curso');
    $this->_view->assign('titulo', $lang->get('elearning_gcurso_ficha_curso').' - '.str_limit($datos['Cur_Titulo'], 20));
    // $this->_view->assign('active', 'ficha_curso');
    $this->_view->assign('idcurso', $idcurso);
    $this->_view->assign('active', 'ficha_curso');
    $this->_view->assign('parametros', $parametros);
    $this->_view->assign('IdiomaOriginal',$datos["Idi_IdIdioma"]);
    $this->_view->render('ajax/_view_finalizar_registro');
  }
  //JM-Ya
  public function gestion_idiomas() {
      $this->_view->getLenguaje(['elearning_gcurso', 'elearning_cursos'], false, true);   
      $_arquitectura = $this->loadModel('index','arquitectura');
      $condicion1 = '';
      $idIdiomaOriginal = $this->getPostParam('idIdiomaOriginal');  
      $Idi_IdIdioma = $this->getPostParam('idIdioma');      
      $Cur_IdCurso = $this->getPostParam('Cur_IdCurso');
      
      $condicion1 .= " WHERE c.Cur_IdCurso = $Cur_IdCurso ";            
      // $datos = $this->_arquitectura->getPaginaTraducida($condicion1,$Idi_IdIdioma);
      // echo $condicion1;
      $datos = $this->curso->getCursoById($Cur_IdCurso, Cookie::lenguaje());
      $parametros = $this->curso->getParametros($Cur_IdCurso);
      // print_r($datos); echo $datos["Idi_IdIdioma"];
      // echo $Idi_IdIdioma;
      $this->_view->assign('idiomas',$_arquitectura->getIdiomas());

      if ($idIdiomaOriginal != $Idi_IdIdioma) { 
          $Cur_Vacantes = $datos["Cur_Vacantes"];
          $datos = array();
          $datos["Cur_IdCurso"]=$Cur_IdCurso;
          $datos["Cur_UrlBanner"]="";
          $datos["Cur_UrlImgPresentacion"]="";
          $datos["Cur_UrlVideoPresentacion"]="";
          $datos["Cur_Titulo"]="";
          $datos["Cur_Descripcion"]="";
          $datos["Cur_PublicoObjetivo"]="";
          $datos["Cur_ObjetivoGeneral"]="";
          $datos["Cur_Metodologia"]="";
          $datos["Cur_ReqHardware"]="";
          $datos["Cur_ReqSoftware"]="";
          $datos["Cur_Vacantes"] = $Cur_Vacantes;
          $datos["Cur_Contacto"]="";
          $datos["Idi_IdIdioma"]=$Idi_IdIdioma;

          $contTrad = $this->curso->getContTradCurso("curso", $Cur_IdCurso, $Idi_IdIdioma);

          for ($i=0; $i < count($contTrad); $i++) { 
              $datos[$contTrad[$i]["Cot_Columna"]] = $contTrad[$i]["Cot_Traduccion"];
          }
          // print_r($datos);
      }

      $this->_view->assign('curso',$datos);  

      $this->_view->assign('IdiomaOriginal',$this->getPostParam('idIdiomaOriginal'));
      $this->_view->assign('parametros', $parametros);
      // echo Cookie::lenguaje();
      $this->_view->renderizar('ajax/gestion_idiomas', false, true);
  }

  public function _registrar_curso()
  {
    $id = Session::get("id_usuario");
    $Idi_IdIdioma = $this->getTexto("idiomaRadio");
    $modalidad = $this->getTexto("modalidad");
    $titulo = $this->getTexto("curso_titulo");
    $descripcion = $this->getPostParam("curso_descripcion");

    $this->curso->saveCurso($id, $modalidad, $titulo, $descripcion, $Idi_IdIdioma);
    $curso = $this->curso->getCursoXRegistro($id);

    $this->service->Success($curso);
    $this->service->Send();
  }

  public function _modificar_curso(){
    $Cur_IdCurso = $this->getTexto('id');
    $Cur_Titulo = $this->getTexto('titulo');
    $Cur_Descripcion = $this->getPostParam('descripcion');
    $Cur_ObjetivoGeneral = $this->getTexto('objgeneral');
    $Cur_PublicoObjetivo = $this->getTexto('publico');
    $Cur_ReqSoftware = $this->getPostParam('software');
    $Cur_ReqHardware = $this->getPostParam('hardware');
    $Cur_Metodologia = $this->getPostParam('metodologia');
    $Cur_Vacantes = $this->getTexto('vacantes');
    $Cur_Contacto = $this->getPostParam('contacto');

    $idiomaTradu = $this->getTexto("idiomaTradu");
    $IdiomaOriginal = $this->getTexto("IdiomaOriginal");
    // $rowCount = "00000";

    if ($idiomaTradu == $IdiomaOriginal) {
      $model = $this->loadModel('_gestionCurso');
      $model->updateCurso($Cur_IdCurso, $Cur_Titulo, $Cur_Descripcion, $Cur_ObjetivoGeneral, $Cur_PublicoObjetivo, $Cur_ReqSoftware, $Cur_ReqHardware, $Cur_Metodologia, $Cur_Vacantes, $Cur_Contacto);

    } else {
      // $rowCount = "11111111";
      $_arquitectura = $this->loadModel('index','arquitectura');
      
      $rowCount1 = $_arquitectura->editarRegistroTraducido("curso", $Cur_IdCurso, "Cur_Titulo", $idiomaTradu, $Cur_Titulo);
      $rowCount2 = $_arquitectura->editarRegistroTraducido("curso", $Cur_IdCurso, "Cur_Descripcion", $idiomaTradu, $Cur_Descripcion);
      $rowCount3 = $_arquitectura->editarRegistroTraducido("curso", $Cur_IdCurso, "Cur_ObjetivoGeneral", $idiomaTradu, $Cur_ObjetivoGeneral);
      $rowCount4 = $_arquitectura->editarRegistroTraducido("curso", $Cur_IdCurso, "Cur_PublicoObjetivo", $idiomaTradu, $Cur_PublicoObjetivo);
      $rowCount5 = $_arquitectura->editarRegistroTraducido("curso", $Cur_IdCurso, "Cur_ReqSoftware", $idiomaTradu, $Cur_ReqSoftware);
      $rowCount6 = $_arquitectura->editarRegistroTraducido("curso", $Cur_IdCurso, "Cur_ReqHardware", $idiomaTradu, $Cur_ReqHardware);
      $rowCount7 = $_arquitectura->editarRegistroTraducido("curso", $Cur_IdCurso, "Cur_Metodologia", $idiomaTradu, $Cur_Metodologia);
      $rowCount8 = $_arquitectura->editarRegistroTraducido("curso", $Cur_IdCurso, "Cur_Contacto", $idiomaTradu, $Cur_Contacto);

      

    }

    $this->service->Success("Se actualizó la información del curso ".$idiomaTradu.$IdiomaOriginal);
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
    $descripcion = $this->getPostParam("descripcion");
    $this->curso->saveDetCurso($id, $titulo, $descripcion);

    $this->service->Success("Se registró el objetivo");
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
    $c=$this->curso->updateEstadoCurso($id, $estado);

    // if(count($c)>0 && $estado=='1'){
      // $correos =$this->curso->getEmail_Usuario();

      // for($i=0;$i<count($correos);$i++)
      //   $this->sendEmail($correos[$i]);
    // }

    $this->service->Success($estado);
    $this->service->Send();
  }

   public function sendEmail($Email)
    {
        $mail = "Prueba de mensaje";

        $Subject = 'INVITACION';
        $contenido = 'mensaje de prueba';
        $fromName = 'PRIC - Anuncio de Curso';
        // Parametro ($forEmail, $forName, $Subject, $contenido, $fromName = "Proyecto PRIC")
        $Correo = new Correo();
        $SendCorreo = $Correo->enviar($Email, "NAME", $Subject, $contenido, $fromName);
        $SendCorreo = $Correo->enviar("c24super@gmail.com", "NAME", $Subject, $contenido, $fromName);
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
    $Idi_IdIdioma = $this->getTexto("idiomaTradu");
    if (!isset($Idi_IdIdioma) || empty($Idi_IdIdioma)) {
       $Idi_IdIdioma = Cookie::lenguaje();
       // echo $Idi_IdIdioma;
    }
    // echo $id;
    $objetivos = $this->curso->getObjetivosXCurso($id, $Idi_IdIdioma, 0);

    

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
    $Cur_IdCurso = $this->getTexto("curso");
    $Cur_UrlBanner = $this->getTexto("img");
    $idiomaTradu = $this->getTexto("idiomaTradu");
    $IdiomaOriginal = $this->getTexto("IdiomaOriginal");

    if ($idiomaTradu == $IdiomaOriginal) {
      $this->curso->updateBannerCurso($Cur_IdCurso, $Cur_UrlBanner);
    } else {

      $_arquitectura = $this->loadModel('index','arquitectura');
      $rowCount = $_arquitectura->editarRegistroTraducido("curso", $Cur_IdCurso, "Cur_UrlBanner", $idiomaTradu, $Cur_UrlBanner);
    }
    
    $resultados = array();
    array_push($resultados, array( "estado" => 1, "url" => $img ));
    $this->service->Populate($resultados);
    $this->service->Success("Se actualizó el banner");
    $this->service->Send();
  }

  //Jhon Martinez
  public function _actualizar_video(){
    $Cur_IdCurso = $this->getTexto("curso");
    $video = $this->getTexto("video");
    $idiomaTradu = $this->getTexto("idiomaTradu");
    $IdiomaOriginal = $this->getTexto("IdiomaOriginal");

    // $codigo = $_POST['texto']; // aqui pones el codigo en un campo de texto
    $cadena = 'watch?v=';
    $pos = strpos($video,$cadena);
    $pos = $pos + strlen($cadena);
    $Cur_UrlVideoPresentacion = substr($video,$pos,100);
    // $_POST['video'] = $cadena;

    if ($idiomaTradu == $IdiomaOriginal) {      
        $this->curso->updateVideoCurso($Cur_IdCurso, $Cur_UrlVideoPresentacion);
    } else {
        $_arquitectura = $this->loadModel('index','arquitectura');
        $rowCount = $_arquitectura->editarRegistroTraducido("curso", $Cur_IdCurso, "Cur_UrlVideoPresentacion", $idiomaTradu, $Cur_UrlVideoPresentacion);
    }

    $resultados = array();
    array_push($resultados, array( "estado" => 1, "url" => $video ));
    $this->service->Populate($resultados);

    $this->service->Success("Se actualizó el Video de Presentación");
    $this->service->Send();
  }

  public function _reg_parametros(){
    $curso = $this->getInt("curso");
    $min = $this->getInt("min");
    $max = $this->getInt("max");

    $this->curso->insertParametros($curso, $min, $max);

    $this->service->Success("exito");
    $this->service->Send();
  }

}
