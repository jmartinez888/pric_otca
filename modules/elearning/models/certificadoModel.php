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
