<?php

class ServiceResult {

  private $_result;

  public function __construct() {
    $this->_result = array();
    $this->_result["estado"] = 0;
    $this->_result["mensaje"] = "";
    $this->_result["data"] = array();
  }

  public function Error($mensaje){
    $this->_result["estado"] = 0;
    $this->_result["mensaje"] = $mensaje;
  }

  public function Success($mensaje){
    $this->_result["estado"] = 1;
    $this->_result["mensaje"] = $mensaje;
  }

  public function Populate($data){
    $this->_result["data"] = $data;
  }

  public function Send(){
    echo json_encode($this->_result);
  }
}
