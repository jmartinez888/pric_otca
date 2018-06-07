<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class gtrabajoController extends elearningController {

  	private $trabajo;
	protected $service;

	public function __construct($lang,$url){
		parent::__construct($lang,$url);
    	$this->_view->assign('_url', BASE_URL . "modules/" . $this->_request->getModulo() . "/views/");
		$this->getLibrary("ServiceResult");
		$this->service = new ServiceResult();
    	$this->trabajo = $this->loadModel("trabajo");
	}

  	public function index(){ }

  	public function _get_trabajo(){  		
		$id = $this->getTexto("id");
	    $obj = $this->trabajo->getTrabajo($id);
	    if($obj!=null){
	    	$obj["Archivos"] = array();
	    	$obj["Archivos"] = $this->trabajo->getArchivos($id);
	    	$obj["Tra_FechaDesde"] = date('d/m/Y H:i',strtotime($obj["Tra_FechaDesde"]));
	    	$obj["Tra_FechaHasta"] = date('d/m/Y H:i',strtotime($obj["Tra_FechaHasta"]));
	    	$this->service->Populate($obj);
	    	$this->service->Success("Data");	
	    }else{
	    	$this->service->Error("Not work");
	    }	    
	    $this->service->Send();
  	}

	public function _registrar_trabajo(){
		$id = $this->getTexto("leccion");
		$tipo = $this->getTexto("tipo");
	    $titulo = $this->getTexto("titulo");
	    $descripcion = $this->getTexto("descripcion");
	    $desde = $this->getPostParam("desde");
	    $hasta = $this->getPostParam("hasta");
	    $obj = $this->trabajo->insertTrabajo($id, $tipo, $titulo, $descripcion, $desde, $hasta);

	    $this->service->Populate($obj);
	    $this->service->Success("Se registró el trabajo");
	    $this->service->Send();
	}

	public function _actualizar_trabajo(){
		$id = $this->getPostParam("trabajo");
		$tipo = $this->getPostParam("tipo");
	    $titulo = $this->getTexto("titulo");
	    $descripcion = $this->getTexto("descripcion");
	    $desde = $this->getTexto("desde");
	    $hasta = $this->getTexto("hasta");
	    $this->trabajo->updateTrabajo($id, $tipo, $titulo, $descripcion, $desde, $hasta);

	    $this->service->Success("Se actualizó el trabajo");
	    $this->service->Send();
	}

	public function _actualizar_estado_trabajo(){
		$id = $this->getTexto("id");
		$estado = $this->getPostParam("estado");
	    $this->trabajo->updateEstadoTrabajo($id, $estado);

	    $this->service->Success("Se cambió el estado del trabajo");
	    $this->service->Send();
	}

	public function _eliminar_trabajo(){
		$id = $this->getTexto("id");
	    $this->trabajo->deleteTrabajo($id);

	    $this->service->Success("Se cambió el estado del trabajo");
	    $this->service->Send();
	}

	public function _registrar_archivo(){
		$id = $this->getTexto("id");
		$archivos = json_decode(html_entity_decode($this->getPostParam("archivos")));

		if($archivos!=null && count($archivos)>0){
			foreach ($archivos as $item) {
				echo "prueba";
				if($item->estado){
					$this->trabajo->insertArchivo($id, "", $item->url);
				}
			}
			echo "finalizó";
		}
	    $this->service->Success("Se registraron los Archivos");
	    $this->service->Send();
	}

	public function _eliminar_archivo(){
		$id = $this->getTexto("id");
	    $this->trabajo->deleteArchivo($id);

	    $this->service->Success("Se cambió el estado del trabajo");
	    $this->service->Send();
	}
}