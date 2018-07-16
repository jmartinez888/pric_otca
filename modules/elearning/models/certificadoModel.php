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
        $sql = "SELECT * FROM certificado_curso
                WHERE Usu_IdUsuario = '{$usuario}' AND Cur_IdCurso = {$curso}";
        return $this->getArray($sql);
    }
}
