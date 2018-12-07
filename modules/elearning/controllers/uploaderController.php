
<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class uploaderController extends elearningController {

  public function __construct($lang,$url)
  {
    parent::__construct($lang,$url);
  }

  public function index(){
    $this->_view->setCss(array("index"));
    $this->_view->renderizar("index");
  }

  public function post(){

    // echo "string".$this->getTexto("route").$this->getTexto("pre");exit;
    $this->getLibrary("ServiceResult");
    $service = new ServiceResult();
    $ruta = $this->Route($this->getTexto("route"));
    $pre = $this->getTexto("pre");
    $pre = strlen($pre) > 0 ? $pre : "file";
    $ruta = ROOT . $ruta;
    $resultados = array();

    for ($i = 0; $i < count($_FILES["files"]["name"]); $i++) {
      $name = str_replace(" ", "", trim($_FILES["files"]["name"][$i]));
      $type = $_FILES["files"]["type"][$i];
      $tmp_name = $_FILES["files"]["tmp_name"][$i];
      $ext = pathinfo($name, PATHINFO_EXTENSION);
      $pre_name = $this->Prefijo() . "-" . $pre . "-" . md5($name).'.'.$ext;
      $tmp_ruta_archivo = $ruta . $pre_name;
      // $tmp_name_archivo = $this->Prefijo() . "-" . $pre . "-" . $name;


      if(move_uploaded_file($tmp_name, $tmp_ruta_archivo)) {
        array_push($resultados, array( "estado" => 1, "url" => $pre_name, "name_file" => $name  ));
			} else {
        array_push($resultados, array( "estado" => 0, "url" => $pre_name, "name_file" => $name  ));
			}
    }

    $service->Populate($resultados);
    $service->Success("Se subieron los archivos con exito");
    $service->Send();
  }

  public function Prefijo(){
    return date("Ymdhis");
  }

  public function Route($ruta){
    $ruta = explode('/', $ruta);
    $ruta = array_filter($ruta);

    $result = "";
    foreach ($ruta as $r) {
      $result .= $r . DS;
    };
    return $result;
  }
}
