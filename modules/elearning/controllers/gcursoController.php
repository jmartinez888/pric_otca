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
    $parametros = $this->curso->getParametros($id);

    Session::set("learn_param_curso", $id);
    Session::set("learn_url_tmp", "gcurso/_view_finalizar_registro");

    $this->_view->assign('curso', $datos);
    $this->_view->assign('parametros', $parametros);
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

  //Jhon Martinez
  public function _actualizar_video(){
    $curso = $this->getTexto("curso");
    $video = $this->getTexto("video");

    // $codigo = $_POST['texto']; // aqui pones el codigo en un campo de texto 
    $cadena='watch?v=';  
    $pos=strpos($video,$cadena);  
    $pos= $pos + strlen($cadena);  
    $video=substr($video,$pos,100);  
    // $_POST['video'] = $cadena;


    $this->curso->updateVideoCurso($curso, $video);

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
