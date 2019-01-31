<?php

use App\PizarraLeccion;

/**
 * Description of loginController
 * @author ROLORO
 */
class pizarraController extends elearningController {

  protected $service;

  public function __construct($lang,$url)
  {
    parent::__construct($lang,$url);
    $this->getLibrary("ServiceResult");
    $this->service = new ServiceResult();
  }

  public function index(){
    $this->redireccionar("elearning/cursos/cursos");
  }

  public function _registrar_pizarra(){
    // dd($_FILES)
;    $leccion = $this->getTexto("leccion");
    // $url = $this->getTexto("url");
    // $url = $this->getTexto("dataUrl");
    $x = round((float)$this->getTexto("x"));
    $y = round((float)$this->getTexto("y"));
    $width = $this->getTexto("width");
    $height = $this->getTexto("height");

    if ($this->has(['leccion'])) {
      $ruta = ROOT . 'files'.DS.'elearning'.DS.'_pizarra'.DS;
      $resultados = array();
      if ($this->getTexto('modo') == 'noimage') {
        $model = $this->loadModel("pizarra");
        $idPizarra = $model->insertPizarra($leccion, 1, "", "", '', $width, $height, $x, $y, true);
        $objPizarra = PizarraLeccion::find($idPizarra);
        if ($objPizarra)
          $resultados = array_merge($resultados, ['data_pizarra' => $objPizarra]);
      } else {
        if (isset($_FILES['dataUrl'])) {
          $name = str_replace(" ", "", trim($_FILES["dataUrl"]["name"]));
          $type = $_FILES["dataUrl"]["type"];
          $tmp_name = $_FILES["dataUrl"]["tmp_name"];
          $ext = pathinfo($name, PATHINFO_EXTENSION);
          $pre_name = $url = date("Ymdhis")."-".'file'."-".md5($name).'.'.$ext;
          $tmp_ruta_archivo = $ruta . $pre_name;
          // $tmp_name_archivo = $this->Prefijo() . "-" . $pre . "-" . $name;
    
    
          if(move_uploaded_file($tmp_name, $tmp_ruta_archivo)) {
            array_push($resultados, array( "estado" => 1, "url" => $pre_name, "name_file" => $name  ));
            //registrar en DB
            $model = $this->loadModel("pizarra");
            $model->insertPizarra($leccion, 1, "", "", $url, $width, $height, $x, $y);
          } else {
            array_push($resultados, array( "estado" => 0, "url" => $pre_name, "name_file" => $name  ));
          }
        }
      }
  
      $this->service->Populate($resultados);
      $this->service->Success("Se insertó la pizarra");
    }
    $this->service->Send();
  }

  public function _eliminar_pizarra(){
    $id = $this->getTexto("id");
    $model = $this->loadModel("pizarra");
    $model->deletePizarra($id);

    $this->service->Success("Se eliminó la pizarra");
    $this->service->Send();
  }
}
