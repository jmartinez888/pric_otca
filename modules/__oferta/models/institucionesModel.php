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
    public function getInstitucionesConCantOferta($pagina = 1, $registrosXPagina = 1)
    {
        try{
            $sql = "call s_s_listar_instituciones_con_cant_oferta(?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $pagina, PDO::PARAM_INT);
            $result->bindParam(2, $registrosXPagina, PDO::PARAM_INT);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getInstitucionesConCantOfertaSinPaginar()
    {
        try{
            $sql = "call s_s_listar_instituciones_con_cant_oferta_sin_paginar()";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getInstitucionesConCantOfertaPorId($id)
    {
        try{
            $sql = "call s_s_listar_instituciones_con_cant_oferta_por_id(?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $id, PDO::PARAM_INT);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getInstitucionesConCantInv($pagina = 1, $registrosXPagina = 1)
    {
        try{
            $sql = "call s_s_listar_instituciones_con_cant_inv(?,?)";
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

    public function getResumenInstituciones($condicion = '')
    {
        try{
            $sql = " SELECT i.Ins_Tipo AS Tipo, COUNT(i.Ins_IdInstitucion) AS CantidadRegistros FROM institucion i $condicion GROUP BY i.Ins_Tipo";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getResumenProyectos($condicion='',$condicion2='')
    {
        try{
            $sql = "SELECT t.Tem_Nombre AS Tipo, COUNT(o.Ofe_IdOferta) AS CantidadRegistros FROM oferta o
INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica $condicion
WHERE o.TipoRecurso='Investigacion' $condicion2
GROUP BY t.Tem_Nombre";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getResumenOfertas($condicion='',$condicion2='')
    {
        try{
            $sql = "SELECT o.Ofe_Tipo AS Tipo, COUNT(o.Ofe_IdOferta) AS CantidadRegistros FROM oferta o $condicion
WHERE o.TipoRecurso='Oferta' $condicion2
GROUP BY o.Ofe_Tipo";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getResumenProyectosRowCount($condicion='',$condicion2='')
    {
        try{
            $sql = " SELECT COUNT(o.Ofe_IdOferta) AS CantidadRegistros FROM oferta o $condicion WHERE o.TipoRecurso='Investigacion' $condicion2 ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getResumenOfertasRowCount($condicion='',$condicion2='')
    {
        try{
            $sql = " SELECT COUNT(o.Ofe_IdOferta) AS CantidadRegistros FROM oferta o $condicion WHERE o.TipoRecurso='Oferta' $condicion2";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getInstitucionesBusquedaRowCount($dato,$pais)
    {
        try{
            $sql = " SELECT p.Pai_Nombre, u.Ubi_Sede, i.Ins_IdInstitucion,COUNT(i.Ins_Nombre) AS CantidadRegistros 
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
            /*$sql = "call s_s_listar_institucion_por_id(?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $id, PDO::PARAM_INT);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);*/
            $listaInstituciones = $this->_db->query("SELECT p.Pai_Nombre, u.Ubi_Sede,i.* FROM institucion i 
            INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
            INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais
            WHERE i.Ins_IdInstitucion = ".$id);
            $listaInstituciones=$listaInstituciones->fetch();

            
                if(!empty($listaInstituciones['Ins_IdInstitucion'])){
                    $listaInstituciones['Otros_Datos']=$this->getOtrosDatosPorIdIns($listaInstituciones['Ins_IdInstitucion']);
                    $listaInstituciones['Maestrias']=$this->getOfertaPorIdInsSegunTipo($listaInstituciones['Ins_IdInstitucion'],'MAESTRIA');
                    $listaInstituciones['Doctorados']=$this->getOfertaPorIdInsSegunTipo($listaInstituciones['Ins_IdInstitucion'],'DOCTORADO');
                    $listaInstituciones['Especializaciones']=$this->getOfertaPorIdInsSegunTipo($listaInstituciones['Ins_IdInstitucion'],'ESPECIALIZACION');
                    $listaInstituciones['ProyectosInv']=$this->getProyectosInvPorIdIns($listaInstituciones['Ins_IdInstitucion']);
                    $listaInstituciones['Difusion']=$this->getDifusionPorIdIns($listaInstituciones['Ins_IdInstitucion']);
                    if($listaInstituciones['Ins_IdPadre']!==0){
                        $listaInstituciones['Padre']=$this->getPadrePorIdIns($listaInstituciones['Ins_IdPadre']);    
                    }
                    $listaInstituciones['Hijos']=$this->getHijosPorIdIns($listaInstituciones['Ins_IdInstitucion']);
                }
            
            return $listaInstituciones;

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getInstitucionPorIdBusqueda($id=false)
    {
        try{
            
            $listaInstituciones = $this->_db->query("SELECT p.Pai_Nombre, u.Ubi_Sede,i.* FROM institucion i 
            INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
            INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais
            WHERE i.Ins_IdInstitucion = ".$id);
            $listaInstituciones=$listaInstituciones->fetch();            
            return $listaInstituciones;

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getOfertaPorIdInsSegunTipo($id=false,$tipo)
    {
        try{
            $sql = "call s_s_listar_oferta_por_id_segun_tipo(?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $id, PDO::PARAM_INT);
            $result->bindParam(2, $tipo, PDO::PARAM_STR);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getProyectosInvPorIdIns($id=false)
    {
        try{
            $sql = "call s_s_listar_proy_inv_por_id(?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $id, PDO::PARAM_INT);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getOtrosDatosPorIdIns($id=false)
    {
        try{
            $sql = "call s_s_listar_otros_datos_por_id(?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $id, PDO::PARAM_INT);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getDifusionPorIdIns($id=false)
    {
        try{
            $sql = "call s_s_listar_difusion_por_id(?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $id, PDO::PARAM_INT);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getPadrePorIdIns($id=false)
    {
        try{
            $sql = "call s_s_listar_padre_por_id(?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $id, PDO::PARAM_INT);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getHijosPorIdIns($id=false)
    {
        try{
            $sql = "call s_s_listar_hijos_por_id(?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $id, PDO::PARAM_INT);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }

    public function getPaises()
    {
        try{
            $sql = "SELECT p.Pai_Nombre AS Nombre, COUNT(i.Ins_Nombre) AS Conteo from ubigeo u INNER JOIN institucion i on u.Ubi_IdUbigeo=i.Ubi_IdUbigeo INNER JOIN pais p on p.Pai_IdPais=u.Pai_IdPais GROUP BY p.Pai_Nombre";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }    
    public function getBusquedaGeneral($pagina = 1, $registrosXPagina = 1,$dato)
    {
        try{
            $sql = "call s_s_listar_instituciones_busqueda_general(?,?,?)";
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
    public function getBusquedaTematica($pagina = 1, $registrosXPagina = 1,$dato)
    {
        try{
            $sql = "call s_s_listar_instituciones_busqueda_tematica(?,?,?)";
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
    public function getBusquedaGeneralRowCount($dato){
        $sql="SELECT COUNT(i.Ins_Nombre) AS CantidadRegistros 
            FROM institucion i INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
            INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais
            WHERE i.Ins_Nombre LIKE '%".$dato."%'
            OR p.Pai_Nombre LIKE '%".$dato."%'
            OR u.Ubi_Sede LIKE '%".$dato."%'
            OR i.Ins_Tipo LIKE '%".$dato."%'";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
    }
    public function getBusquedaTematicaRowCount($dato){
        $sql="SELECT COUNT(i.Ins_Nombre) AS CantidadRegistros 
            FROM institucion i INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
            INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais
            INNER JOIN oferta o ON o.Ins_IdInstitucion=i.Ins_IdInstitucion
            INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica
    WHERE o.TipoRecurso='Investigacion' AND t.Tem_Nombre LIKE '%".$dato."%' ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
    }
/*
public function getBusquedaAvanzadaPais($pais){
        $sql="SELECT i.Ins_IdInstitucion FROM institucion i INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
            INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais
            WHERE p.Pai_Nombre LIKE '%".$pais."%'";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
    }


public function getBusquedaAvanzadaDatos($datos){
        $sql="SELECT i.Ins_IdInstitucion FROM institucion i 
        INNER JOIN institucion_otros_datos iod ON iod.Ins_IdInstitucion=i.Ins_IdInstitucion 
            WHERE iod.Atributo LIKE '%".$datos."%'";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
    }

public function getBusquedaAvanzadaProyectos($datos){
        $sql="SELECT i.Ins_IdInstitucion FROM institucion i 
        INNER JOIN oferta o ON o.Ins_IdInstitucion=i.Ins_IdInstitucion 
            WHERE o.TipoRecurso='Investigacion' AND o.Ofe_Nombre LIKE '%".$datos."%'";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getBusquedaAvanzadaOfertas($datos){
        $sql="SELECT i.Ins_IdInstitucion FROM institucion i 
        INNER JOIN oferta o ON o.Ins_IdInstitucion=i.Ins_IdInstitucion 
            WHERE o.TipoRecurso='Oferta' AND o.Ofe_Nombre LIKE '%".$datos."%'";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getBusquedaAvanzadaEsp($datos){
        $sql="SELECT i.Ins_IdInstitucion FROM institucion i 
        INNER JOIN oferta o ON o.Ins_IdInstitucion=i.Ins_IdInstitucion 
            WHERE o.TipoRecurso='Oferta' AND o.Ofe_Tipo='ESPECIALIZACION' ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
    }
    public function getBusquedaAvanzadaMae($datos){
        $sql="SELECT i.Ins_IdInstitucion FROM institucion i 
        INNER JOIN oferta o ON o.Ins_IdInstitucion=i.Ins_IdInstitucion 
            WHERE o.TipoRecurso='Oferta' AND o.Ofe_Tipo='MAESTRIA' ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
    }
    public function getBusquedaAvanzadaDoc($datos){
        $sql="SELECT i.Ins_IdInstitucion FROM institucion i 
        INNER JOIN oferta o ON o.Ins_IdInstitucion=i.Ins_IdInstitucion 
            WHERE o.TipoRecurso='Oferta' AND o.Ofe_Tipo='DOCTORADO' ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
    }
    public function soloDuplicados($array){
        $duplicados = array();
        foreach ($array as $key => $values) {
            foreach ($values as $key => $value) {
               if(isset($duplicados[$value])){
                $duplicados[$value]+=1; 
            }else{
                $duplicados[$value]=1;
            }
            }
            
        }
        return $duplicados;
    }
*/
    public function getBusquedaAvanzada($select, $where,$group,$pagina = 1, $registrosXPagina = 1){
        if($pagina>0){
            $registroInicio = ($pagina - 1) * $registrosXPagina;
            $sql= $select . $where . $group. " LIMIT ".$registroInicio . ", ".$registrosXPagina;
        }else{
            $sql= $select . $where . $group. " LIMIT 0" . ", ".$registrosXPagina;
        }
        
        $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
    }
    public function getBusquedaAvanzadaT($select, $where,$group){
        
            $sql= $select . $where . $group;
        
        $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
    }
    public function getResumen1($consulta){
        $sql= $consulta;
        $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
    }
    public function getInstitucionUsuario($id,$id_usuario){
        $sql= "SELECT * FROM institucion_usuario where Ins_IdInstitucion='$id' and Usu_IdUsuario='$id_usuario' ";
        $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
    }

}
?>