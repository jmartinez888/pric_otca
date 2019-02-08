<?php

class certificadoModel extends Model {

    public function __construct() { parent::__construct(); }

    


    public function insertCertificado($codigo, $usuario, $curso){
        $sql = "INSERT INTO certificado_curso(Cer_Codigo, Cur_IdCurso, Usu_IdUsuario)
                VALUES('{$codigo}', {$curso}, {$usuario})";
        $this->execQuery($sql);
    }


    public function getCertificado($codigo){
        $sql = "SELECT v.*, u.Usu_Nombre, u.Usu_Apellidos, c.Cur_Titulo FROM certificado_curso v 
        		INNER JOIN usuario u ON u.Usu_IdUsuario = v.Usu_IdUsuario
                INNER JOIN curso c ON c.Cur_IdCurso = v.Cur_IdCurso                
        		WHERE v.Cer_Codigo = '{$codigo}' ";
        return $this->getArray($sql);
    }


    public function getCertificadoRowCount($condicion = ""){
        $sql = " SELECT count(v.Cer_IdCertificado) as CantidadRegistros FROM certificado_curso v 
                INNER JOIN usuario u ON u.Usu_IdUsuario = v.Usu_IdUsuario
                INNER JOIN curso c ON c.Cur_IdCurso = v.Cur_IdCurso
                $condicion ";
        return $this->getArray($sql);
    }


    public function getCertificadosCondicion($pagina,$registrosXPagina,$condicion = "")
    {
        try{
            $registroInicio = 0;
            if ($pagina > 0) {
                $registroInicio = ($pagina - 1) * $registrosXPagina;                
            }
            $sql = " SELECT v.*, u.Usu_Nombre, u.Usu_Apellidos, c.Cur_Titulo FROM certificado_curso v 
                INNER JOIN usuario u ON u.Usu_IdUsuario = v.Usu_IdUsuario
                INNER JOIN curso c ON c.Cur_IdCurso = v.Cur_IdCurso
                $condicion                
                LIMIT $registroInicio, $registrosXPagina ";
            return $this->getArray($sql);
        } catch (PDOException $exception) {
            // $this->registrarBitacora("acl(indexModel)", "getCertificadosCondicion", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function getCertificadoCodigo($codigo)
    {
          
        try {
            $sql = "SELECT v.*, u.Usu_Nombre, u.Usu_Apellidos, c.Cur_Titulo,c.Cur_FechaDesde,c.Cur_FechaHasta FROM certificado_curso v 
                INNER JOIN usuario u ON u.Usu_IdUsuario = v.Usu_IdUsuario
                INNER JOIN curso c ON c.Cur_IdCurso = v.Cur_IdCurso
                 WHERE v.Cer_Codigo like '$codigo'";
            $post = $this->_db->query($sql);
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(certificadoModel)", "getCertificadoCodigo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function getCertificado_Id($codigo){
        $sql = "SELECT v.*, u.Usu_Nombre, u.Usu_Apellidos, c.*, 
 CONCAT (
    DATE_FORMAT(v.Cer_FechaReg, '%d'), ' de ',
    CASE MONTH(v.Cer_FechaReg)
     WHEN 1 THEN 'Enero'
     WHEN 2 THEN 'Febrero'
     WHEN 3 THEN 'Marzo'
     WHEN 4 THEN 'Abril'
     WHEN 5 THEN 'Mayo'
     WHEN 6 THEN 'Junio'
     WHEN 7 THEN 'Julio'
     WHEN 8 THEN 'Agosto'
     WHEN 9 THEN 'Septiembre'
     WHEN 10 THEN 'Octubre'
     WHEN 11 THEN 'Noviembre'
     WHEN 12 THEN 'Diciembre'
     END, ' de ', DATE_FORMAT(v.Cer_FechaReg, '%Y')) Fecha_completa FROM certificado_curso v 
                INNER JOIN usuario u ON u.Usu_IdUsuario = v.Usu_IdUsuario
                INNER JOIN curso c ON c.Cur_IdCurso = v.Cur_IdCurso                
                WHERE v.Cer_IdCertificado = '{$codigo}' ";
        return $this->getArray($sql);
    }


    public function getCertificadoUsuario($usuario){
        $sql = "SELECT * FROM certificado_curso
                WHERE Usu_IdUsuario = '{$usuario}' ";
        return $this->getArray($sql);
    }
    public function getCertificadoUsuarioCurso($usuario, $curso){
        $sql = "SELECT * FROM certificado_curso c
                WHERE c.Usu_IdUsuario = '{$usuario}' AND c.Cur_IdCurso = {$curso}";
        return $this->getArray($sql);
    }

     public function registrarPlantillaCertificado($iPlc_UrlImg, $iPlc_StyleNombre, $iPlc_StyleCurso, $iPlc_StyleHoras, $iPlc_StyleFecha,$iCur_IdCurso){
        try {             
            $sql = "call s_i_plantilla_certificado(?,?,?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iPlc_UrlImg, PDO::PARAM_STR);
            $result->bindParam(2, $iPlc_StyleNombre, PDO::PARAM_STR);
            $result->bindParam(3, $iPlc_StyleCurso, PDO::PARAM_STR); 
            $result->bindParam(4, $iPlc_StyleHoras, PDO::PARAM_STR); 
            $result->bindParam(5, $iPlc_StyleFecha, PDO::PARAM_STR);        
            $result->bindParam(6, $iCur_IdCurso, PDO::PARAM_STR);              
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(certificadoModel)", "registrarPlantillaCertificado", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getAllPlantillaCertificado($idCurso)
    {
        try{
            $sql = " SELECT * FROM plantilla_certificado WHERE cur_idcurso= $idCurso";
            $result = $this->_db->query($sql);
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(certificadoModel)", "getAllPlantillaCertificado", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

public function getPlantillaCertificado($idCurso, $Idi_IdIdioma="es")
    {
        try{
            $sql = " SELECT * FROM plantilla_certificado WHERE Cur_IdCurso= $idCurso and Plc_Seleccionado=1";
            $result = $this->_db->query($sql);
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(certificadoModel)", "getPlantillaCertificado", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getPlantillaCertificadoxId($id)
    {
        try{
            $sql = " SELECT * FROM plantilla_certificado WHERE Plc_IdPlantillaCertificado = $id";
            $result = $this->_db->query($sql);
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(certificadoModel)", "getPlantillaCertificadoxId", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

     public function cambiarSelectedPlantilla($Per_IdPermiso, $Per_Estado)
    {
        try{
            if($Per_Estado==0)
            {

                $sql = "call s_u_cambiar_selected_plantilla(?,1)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Per_IdPermiso, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);                
            }
            if($Per_Estado==1)
            {

                $sql = "call s_u_cambiar_selected_plantilla(?,0)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Per_IdPermiso, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);
            }

        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(certificadoModel)", "cambiarSelectedPlantilla", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function editarPlantilla($iPlc_UrlImg, $iPlc_StyleNombre, $iPlc_StyleCurso, $iPlc_StyleHora, $iPlc_StyleFecha,$iPlc_StyleCodigo,$iPlc_IdPlantillaCertificado) {
        try{
            $permiso = $this->_db->query(
                " UPDATE plantilla_certificado SET Plc_UrlImg = '$iPlc_UrlImg', Plc_StyleNombre = '$iPlc_StyleNombre', Plc_StyleCurso = '$iPlc_StyleCurso', Plc_StyleHora = '$iPlc_StyleHora', Plc_StyleFecha = '$iPlc_StyleFecha', Plc_StyleCodigo = '$iPlc_StyleCodigo' WHERE Plc_IdPlantillaCertificado = $iPlc_IdPlantillaCertificado"
            );
            return $permiso->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(certificadoModel)", "editarPlantilla", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

      public function eliminarPlantilla($iPlc_IdPlantillaCertificado) {
        try{
            $permiso = $this->_db->query(
                " DELETE FROM plantilla_certificado WHERE Plc_IdPlantillaCertificado = $iPlc_IdPlantillaCertificado"
            );
            return $permiso->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(certificadoModel)", "eliminarPlantilla", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
}
