<?php

class _gestionModel extends Model {

  public function __construct() { parent::__construct(); }

  public function getAnuncio($anuncioID)
    {
        try{
            $anuncio = $this->_db->query(
                " SELECT * FROM anuncio_curso
                WHERE Anc_IdAnuncioCurso = $anuncioID"
            );
            return $anuncio->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(_gestionCursoModel)", "getAnuncio", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getEmailMatriculadosCurso($curso)
    {
        try{
            $alumnos = $this->_db->query(
                " SELECT U.* FROM usuario U
            INNER JOIN matricula_curso MC ON U.Usu_IdUsuario = MC.Usu_IdUsuario
            WHERE Cur_IdCurso = $curso "
            );           
            return $alumnos->fetchAll(PDO::FETCH_ASSOC);            
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(_gestionCursoModel)", "getMatriculadosCurso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }        
    }

    public function getCursoXid($curso)
    {
        try{
            $alumnos = $this->_db->query(
                " SELECT * FROM curso
            WHERE Cur_IdCurso = $curso "
            );           
            return $alumnos->fetchAll(PDO::FETCH_ASSOC);            
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(_gestionCursoModel)", "getCursoXid", "Error Model", $exception);
            return $exception->getTraceAsString();
        }        
    }
}
