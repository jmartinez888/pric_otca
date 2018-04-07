<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class calendarioController extends elearningController {

  public function __construct($lang,$url)
  {
    parent::__construct($lang,$url);
  }

  public function index(){  }

  //FORMATO PARA ENVIAR DATOS A CALENDARIO
  public function datos(){
    $anio = $this->getTexto("anio");
    $mes = $this->getTexto("mes");
    $usuario = $this->getTexto("usuario");

    $resultado = array();
    $evento1 = array("ID" => 1, "D" => "01", "M" => $mes, "A" => $anio
    , "H" => "16", "DET" => "Este es el primer eventillo que agregamos");
    array_push($resultado, $evento3);
    echo json_encode($resultado);
  }

  public function defaults(){
    echo "";
  }

  public function calendario(){
    $anio = $this->getTexto("anio");
    $mes = $this->getTexto("mes");
    $evento = html_entity_decode($this->getTexto("eventos"));
    $fecha = $anio.$mes.'01';
    $titulo = $this->NombreMes($mes) . " del " . $anio;

    $calendario = $this->MesCalendario($anio, $mes);
    $calendario = $this->AddEventos($calendario, $evento);

    $this->_view->assign("anterior", $this->MesAnterior($fecha));
    $this->_view->assign("siguiente", $this->MesSiguiente($fecha));
    $this->_view->assign("calendario", $calendario);
    $this->_view->assign("titulo", $titulo);
    $this->_view->renderizar('calendario', false, true);
  }

  public function AddEventos($calendario, $evento){
    if(strlen($evento)==0){ return $calendario; }
    try {
      $evento = json_decode($evento, true);
      $resultado = array();

      foreach ($calendario as $semana) {
        $tmp_semana = array();
        foreach ($semana as $dia) {
          $dia["eventos"] = array();

          foreach ($evento as $ev) {
            if (intval($ev["D"]) == intval($dia["D"]) && intval($ev["M"]) == intval($dia["M"])){
              array_push($dia["eventos"], $ev);
              //ELIMINAR EV
            }
          }
          array_push($tmp_semana, $dia);
        }
        array_push($resultado, $tmp_semana);
      }
      return $resultado;
    }catch(Exception $e){
      echo "holi";
      return $calendario;
    }
  }

  public function MesCalendario($anio, $mes){
    setlocale(LC_ALL,"es_ES");
    $cal = array();
    $mes = strlen($mes) ==1 ? '0' . $mes : $mes;
    for($i = 1; $i <= $this->UltimoDiaMes($anio."-".$mes."-01"); $i++){
      $dia = $i < 10 ? '0' . $i : $i;
      array_push($cal, $this->DiaCalendario($anio. $mes . $dia));
    }
    $PRIMER_DIA = intval($cal[0]["N"]);
    $ULTIMO_DIA = intval($cal[count($cal)-1]["N"]);

    if($PRIMER_DIA>1){
      $ANTERIOR = $this->MesAnterior($anio . $mes . "01");

      $index = $this->UltimoDiaMes($ANTERIOR["ANIO"]."-".$ANTERIOR["MES"]."-01");
      for($i = ($PRIMER_DIA-1); $i > 0; $i--){
        $dia = $index < 10 ? '0' . $index : $index;
        array_unshift($cal, $this->DiaCalendario($ANTERIOR["ANIO"]. $ANTERIOR["MES"] . $dia, true));
        $index--;
      }
    }
    if($ULTIMO_DIA<7){
      $SIGUIENTE = $this->MesSiguiente($anio . $mes . "01");

      $index = 1;
      for($i = ($ULTIMO_DIA+1); $i < 8; $i++){
        $dia = $index < 10 ? '0' . $index : $index;
        array_push($cal, $this->DiaCalendario($SIGUIENTE["ANIO"]. $SIGUIENTE["MES"] . $dia, true));
        $index++;
      }
    }
    $calendario = array();
    $index = 1;
    $semana = array();
    foreach ($cal as $c) {
      array_push($semana, $c);
      $index++;
      if($index>7){
        array_push($calendario, $semana);
        unset($semana); $semana = array();
        $index = 1;
      }
    }
    return $calendario;
  }

  public function DiaCalendario($fecha, $value = false){
    $n = date("N", strtotime($fecha));
    $d = date("d", strtotime($fecha));
    $m = date("m", strtotime($fecha));
    $y = date("Y", strtotime($fecha));
    $t = 1;
    if($value){ $t = 0; }
    return array("T" => $t,"N" => $n, "D" => $d, "M" => $m, "A" => $y);
  }

  public function MesAnterior($fecha){
    $m = date("m", strtotime($fecha));
    $y = date("Y", strtotime($fecha));

    if(intval($m) == 1){
      $y = intval($y) - 1;
      $m = "12";
    }else{
      $m = intval($m) - 1;
      $m = $m < 10 ? '0' . $m : $m ;
    }
    return array("MES" => $m, "ANIO" => $y);
  }

  public function MesSiguiente($fecha){
    $m = date("m", strtotime($fecha));
    $y = date("Y", strtotime($fecha));

    if(intval($m) == 12){
      $y = intval($y) + 1;
      $m = "01";
    }else{
      $m = intval($m) + 1;
      $m = $m < 10 ? '0' . $m : $m ;
    }
    return array("MES" => $m, "ANIO" => $y);
  }

  public function UltimoDiaMes($fecha){
    $f = new DateTime($fecha);
    $f->modify('last day of this month');
    return intval($f->format('d'));
  }

  public function NombreMes($mes){
    $mes = intval($mes);
    $texto = "";
    switch ($mes) {
      case 1: $texto = "Enero"; break;
      case 2: $texto = "Febrero"; break;
      case 3: $texto = "Marzo"; break;
      case 4: $texto = "Abril"; break;
      case 5: $texto = "Mayo"; break;
      case 6: $texto = "Junio"; break;
      case 7: $texto = "Julio"; break;
      case 8: $texto = "Agosto"; break;
      case 9: $texto = "Setiembre"; break;
      case 10: $texto = "Octubre"; break;
      case 11: $texto = "Noviembre"; break;
      case 12: $texto = "Diciembre"; break;
    }
    return $texto;
  }
}
