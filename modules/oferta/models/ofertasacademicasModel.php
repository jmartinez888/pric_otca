<?php
class ofertasacademicasModel extends Model {
public function __construct()
    {
        parent::__construct();
    }
    public function getOfertas($pagina = 1, $registrosXPagina = 1)
    {
        try{
            $sql = "call s_s_listar_ofertas(?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $pagina, PDO::PARAM_INT);
            $result->bindParam(2, $registrosXPagina, PDO::PARAM_INT);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getOfertasRowCount()
    {
        try{
            $sql = " SELECT COUNT(o.Ofe_IdOferta) AS CantidadRegistros FROM oferta o";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getInstitucionesBusquedaRowCount($dato,$pais, $Idi_IdIdioma = "es")
    {
        try{
            $sql = " SELECT i.Ins_IdInstitucion, p.Pai_IdPais,
            
            fn_TraducirContenido('pais','Pai_Nombre',Pai_IdPais,'$Idi_IdIdioma',p.Pai_Nombre) Pai_Nombre,
            i.row_estado,
            fn_devolverIdioma('institucion',i.Ins_IdInstitucion,'$Idi_IdIdioma',p.$Idi_IdIdioma)Idi_IdIdioma,
                            
            u.Ubi_Sede, ,COUNT(i.Ins_Nombre) AS CantidadRegistros 
            FROM institucion i INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
            INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais
            WHERE i.Ins_Nombre LIKE '%". $dato."%' AND p.Pai_Nombre LIKE '%".$pais."%' GROUP BY p.Pai_Nombre, u.Ubi_Sede, i.Ins_IdInstitucion ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getInstitucionesBusqueda($pagina = 1, $registrosXPagina = 1,$dato="",$pais="")
    {
        try{
            $sql = "call s_s_listar_instituciones_busqueda(?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $pagina, PDO::PARAM_INT);
            $result->bindParam(2, $registrosXPagina, PDO::PARAM_INT);
            $result->bindParam(3, $dato, PDO::PARAM_STR);
            $result->bindParam(4, $pais, PDO::PARAM_STR);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getInstitucionPorId($id=false)
    {
        try{
            $sql = "call s_s_listar_institucion_por_id(?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $id, PDO::PARAM_INT);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getPaises($Idi_IdIdioma = "es")
    {
        try{
            $sql = "SELECT  u.Ubi.IdUbigeo, p.Pai.Id_Pais,
            
            fn_TraducirContenido('pais','Pai_Nombre',Pai_IdPais,'$Idi_IdIdioma',p.Pai_Nombre) Pai_Nombre,
            fn_devolverIdioma('ubigeo',u.Ubi_IdUbigeo,'$Idi_IdIdioma',p.$Idi_IdIdioma)Idi_IdIdioma,
            COUNT(i.Ins_Nombre) AS Conteo from ubigeo u INNER JOIN institucion i on u.Ubi_IdUbigeo=i.Ubi_IdUbigeo INNER JOIN pais p on p.Pai_IdPais=u.Pai_IdPais GROUP BY p.Pai_Nombre";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getOfertasBusqueda($pagina = 1, $registrosXPagina = 1,$dato="")
    {
        try{
            $sql = "call s_s_listar_ofertas_busqueda(?,?,?)";
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
    public function getOfertasBusquedaRowCount($dato)
    {
        try{
            $sql = " SELECT COUNT(o.Ofe_IdOferta) AS CantidadRegistros,i.Ins_Nombre,t.Tem_Nombre FROM oferta o 
            INNER JOIN institucion i ON o.Ins_IdInstitucion = i.Ins_IdInstitucion 
            INNER JOIN tematica t ON o.Tem_IdTematica=t.Tem_IdTematica
            WHERE i.Ins_Nombre LIKE '%".$dato."%'
            OR o.Ofe_Nombre LIKE '%".$dato."%'
            OR o.Ofe_Tipo LIKE '%".$dato."%'
            OR t.Tem_Nombre LIKE '%".$dato."%' GROUP BY i.Ins_Nombre,t.Tem_Nombre ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getOfertaPorId($id=false)
    {
        try{
            $sql = "call s_s_listar_oferta_por_id(?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $id, PDO::PARAM_INT);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }

}
?>
