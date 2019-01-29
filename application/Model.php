
<?php
use Illuminate\Database\Eloquent\Model as Eloquent;
class Model extends Eloquent{

    private $_registry;
    protected $_db;
    protected $_request;
    protected $_acl;

    public function __construct() {
        $this->_registry = Registry::getInstancia();
        $this->_request = $this->_registry->_request;
        $this->_acl = $this->_registry->_acl;
        $this->_db = $this->_registry->_db;
        $this->_db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }

    protected function loadModel($modelo, $modulo = false) {
        $modelo = $modelo . 'Model';
        $rutaModelo = ROOT . 'models' . DS . $modelo . '.php';

        if (!$modulo) {
            $modulo = $this->_request->getModulo();
        }

        if ($modulo) {
            if ($modulo != 'default') {
                $rutaModelo = ROOT . 'modules' . DS . $modulo . DS . 'models' . DS . $modelo . '.php';
            }
        }

        if (is_readable($rutaModelo)) {
            require_once $rutaModelo;
            $modelo = new $modelo;
            return $modelo;
        } else {
            throw new Exception('Error de modelo - Clase Model -'.$rutaModelo);
        }
    }
  //Inserta en tabla bitacora y evento
    public function insertarBitacora($iEve_Descripcion,$iEve_Tipo,$iBit_UserName,$iBit_NombrePagina, $iBit_NombreMetodo,$iBit_Descripcion,$iBit_Estado)
    {
         try {

            $id_registro = "";
            $sql = "call s_i_bitacora(?,?,?,?,?,?,?)";

            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iEve_Descripcion, PDO::PARAM_STR);
            $result->bindParam(2, $iEve_Tipo, PDO::PARAM_STR);
            $result->bindParam(3, $iBit_UserName, PDO::PARAM_STR);
            $result->bindParam(4, $iBit_NombrePagina, PDO::PARAM_STR);
            $result->bindParam(5, $iBit_NombreMetodo, PDO::PARAM_STR);
            $result->bindParam(6, $iBit_Descripcion, PDO::PARAM_STR);
            $result->bindParam(7, $iBit_Estado, PDO::PARAM_STR);
            $result->execute();
            return $result->fetch();
        } catch (Exception $exc) {

            return $exc->getTraceAsString();

        }
    }
    //Registro de Errores
     public function registrarBitacora($bit_NombrePagina, $bit_NombreMetodo,$eve_tipo, Exception $ex){
        $bit_Descripcion="";
        $eve_descripcion="";
        $bit_Descripcion= "Code :". $ex ->getCode();
        $bit_Descripcion .= " ;Message : ".$ex->getMessage();
        $bit_Descripcion .= " ;TraceAsString : ".$ex->getTraceAsString();
        $eve_descripcion .= $ex->getMessage();
        $this->insertarBitacora(
                               $eve_descripcion,$eve_tipo,
                               Session::get('usuario'), $bit_NombrePagina,$bit_NombreMetodo,
                               $bit_Descripcion,1);
        return true;
      }


    public function insertarVisita($iVis_Explorador,$iVis_PaginaVisita,$iVis_PaginaAnterior,$iVis_SistemaOperativo,$iVis_Idioma,$iVis_Ip/*,$iVis_Pais,$iVis_Fuente*/){
        $sql = "call s_i_estadistica_visita(?,?,?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iVis_Explorador, PDO::PARAM_STR);
            $result->bindParam(2, $iVis_PaginaVisita, PDO::PARAM_STR);
            $result->bindParam(3, $iVis_PaginaAnterior, PDO::PARAM_STR);
            $result->bindParam(4, $iVis_SistemaOperativo, PDO::PARAM_STR);
            $result->bindParam(5, $iVis_Idioma, PDO::PARAM_STR);
            $result->bindParam(6, $iVis_Ip, PDO::PARAM_STR);/*
            $result->bindParam(7, $iVis_Pais, PDO::PARAM_STR);
            $result->bindParam(8, $iVis_Fuente, PDO::PARAM_STR);*/
            $result->execute();
    }

    //Util Rodrigo Elearning
    public function getArray($query){
        $data = $this->_db->query($query);
        return $data->fetchAll(PDO::FETCH_ASSOC);
    }

    public function execQuery($query, $get_id = false){
      $this->_db->query($query);
      if ($get_id)
        return $this->_db->lastInsertId();
    }

    public function getContTrad($Cot_Tabla = "", $Cot_IdRegistro = "", $Idi_IdIdioma = "") {
        try{
            $sql = $this->_db->query(
                  " SELECT * FROM contenido_traducido WHERE Cot_Tabla = '$Cot_Tabla' AND Cot_IdRegistro =  '$Cot_IdRegistro' AND Idi_IdIdioma = '$Idi_IdIdioma' "
            );
            return $sql->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("arquitectura(indexModel)", "getContTradCurso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

}

?>
