<?php
class institucionesModel extends Model {
public function __construct()
    {
        parent::__construct();
    }
    public function getInstituciones($pagina = 1, $registrosXPagina = 1)
    {
        try{
            $sql = "call s_s_listar_instituciones(?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $pagina, PDO::PARAM_INT);
            $result->bindParam(2, $registrosXPagina, PDO::PARAM_INT);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getInstitucionesRowCount()
    {
        try{
            $sql = " SELECT COUNT(i.Ins_IdInstitucion) AS CantidadRegistros FROM institucion i";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getInstitucionesBusqueda($pagina = 1, $registrosXPagina = 1,$dato="")
    {
        try{
            $sql = "call s_s_listar_instituciones_busqueda(?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $pagina, PDO::PARAM_INT);
            $result->bindParam(2, $registrosXPagina, PDO::PARAM_INT);
            $result->bindParam(3, $dato, PDO::PARAM_STR);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }

}
?>