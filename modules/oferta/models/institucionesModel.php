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

    public function getResumenInstituciones($condicion = '',$Idi_IdIdioma="es")
    {
        try{
            $sql = " SELECT i.Ins_IdInstitucion, 
            fn_TraducirContenido('institucion','Ins_Tipo',i.Ins_IdInstitucion,'$Idi_IdIdioma',i.Ins_Tipo) Ins_Tipo,
            i.row_estado,
            fn_devolverIdioma('institucion','Ins_IdInstitucion','$Idi_IdIdioma',i.Idi_IdIdioma)Idi_IdIdioma,
            COUNT(i.Ins_IdInstitucion) AS CantidadRegistros         
            FROM institucion i $condicion GROUP BY i.Ins_Tipo";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getResumenProyectos($condicion='',$condicion2='',$Idi_IdIdioma="es")
    {
        try{
            $sql = "SELECT o.Ofe_IdOferta, t.Tem_IdTematica,
            
            fn_TraducirContenido('tematica','Tem_Nombre',t.Tem_IdTematica,'$Idi_IdIdioma', t.Tem_Nombre)Tem_Nombre, 
            o.row_estado,
            fn_devolverIdioma('oferta',o.Ofe_IdOferta,'$Idi_IdIdioma',o.Idi_IdIdioma)Idi_IdIdioma,
            COUNT(o.Ofe_IdOferta) AS CantidadRegistros 
            FROM oferta o
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
    public function getResumenOfertas($condicion='',$condicion2='',$Idi_IdIdioma="es")
    {
        try{
            $sql = "SELECT DISTINCT 
            
            fn_TraducirContenido('oferta','Ofe_Tipo',o.Ofe_IdOferta,'$Idi_IdIdioma', o.Ofe_Tipo)Ofe_Tipo, 
            o.row_estado,
            fn_devolverIdioma('oferta',o.Ofe_IdOferta,'$Idi_IdIdioma',o.Idi_IdIdioma)Idi_IdIdioma,
            COUNT(o.Ofe_IdOferta) AS CantidadRegistros 
            
            FROM oferta o $condicion
            WHERE o.TipoRecurso='Oferta' $condicion2
            GROUP BY o.Ofe_Tipo";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function tiene_traduccion($id)
    {
        try{
            $sql = "SELECT *  FROM contenido_traducido c WHERE c.Cot_Tabla = 'institucion' AND c.Cot_IdRegistro = ".$id;
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
    public function getInstitucionesBusquedaRowCount($dato,$pais,$Idi_IdIdioma="es")
    {
        try{
            $sql = " SELECT i.Ins_IdInstitucion, p.Pai_IdPais,
            
            fn_TraducirContenido('pais','Pai_Nombre',p.Pai_IdPais,'$Idi_IdIdioma', p.Pai_Nombre) Pai_Nombre,
            i.row_estado,
            fn_devolverIdioma('Institucion',i.Ins_IdInstitucion,'$Idi_IdIdioma',i.Idi_IdIdioma)Idi_IdIdioma,
            u.Ubi_Sede, 
            
            COUNT(i.Ins_Nombre) AS CantidadRegistros 
                        
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
    public function getInstitucionPorId($id=false,$idioma='')
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT p.Pai_Nombre, u.Ubi_Sede,i.Ins_IdInstitucion, i.Ins_IdPadre, 
            fn_TraducirContenido('institucion','Ins_Nombre',i.Ins_IdInstitucion,'$idioma', i.Ins_Nombre) Ins_Nombre, 
            fn_TraducirContenido('institucion','Ins_Descripcion',i.Ins_IdInstitucion,'$idioma', i.Ins_Descripcion) Ins_Descripcion,
            i.Ins_CorreoPagina, i.Ins_Representante, i.Ins_Telefono, i.Ins_Direccion, 
            fn_TraducirContenido('institucion','Ins_Tipo',i.Ins_IdInstitucion,'$idioma', i.Ins_Tipo) Ins_Tipo,
            i.Ins_img, row_estado, i.Ins_WebSite, i.Ins_latX, i.Ins_lngY 
            FROM institucion i 
            INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
            INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais
            WHERE i.Ins_IdInstitucion = ".$id);
            $listaInstituciones=$listaInstituciones->fetch();

            
                if(!empty($listaInstituciones['Ins_IdInstitucion'])){
                    $listaInstituciones['Otros_Datos']=$this->getOtrosDatosPorIdIns($listaInstituciones['Ins_IdInstitucion'],$idioma);
                    $listaInstituciones['Maestrias']=$this->getOfertaPorIdInsSegunTipo($listaInstituciones['Ins_IdInstitucion'],'MAESTRIA',$idioma);
                    $listaInstituciones['Doctorados']=$this->getOfertaPorIdInsSegunTipo($listaInstituciones['Ins_IdInstitucion'],'DOCTORADO',$idioma);
                    $listaInstituciones['Especializaciones']=$this->getOfertaPorIdInsSegunTipo($listaInstituciones['Ins_IdInstitucion'],'ESPECIALIZACION',$idioma);
                    $listaInstituciones['ProyectosInv']=$this->getProyectosInvPorIdIns($listaInstituciones['Ins_IdInstitucion'],$idioma);
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
            
            $listaInstituciones = $this->_db->query("SELECT p.Pai_IdPais,i.Ins_IdInstitucion,
            
            fn_TraducirContenido('pais','Pai_Nombre',p.Pai_IdPais,'$Idi_IdIdioma', p.Pai_Nombre) Pai_Nombre,            
            i.Ubi_IdUbigeo, 
            i.Ins_IdPadre, 
            fn_TraducirContenido('institucion','Ins_Nombre',i.Ins_IdInstitucion,'$Idi_IdIdioma',i.Ins_Nombre)Ins_Nombre,
            fn_TraducirContenido('institucion','Ins_Descripcion',i.Ins_IdInstitucion,'$Idi_IdIdioma',i.Ins_Descripcion)Ins_Descripcion,
            i.Row_Estado,
            i.Ins_CorreoPagina, 
            i.Ins_Representante,
            i.Ins_Telefono, 
            i.Ins_Direccion,
            fn_TraducirContenido('institucion','Ins_Tipo',i.Ins_IdInstitucion,'$Idi_IdIdioma',i.Ins_Tipo)Ins_Tipo,             
            i.Ins_img, 
            i.Ins_WebSite, 
            i.Ins_latX, 
            i.Ins_lngY,
            fn_devolverIdioma('institucion','Ins_IdInstitucion','$Idi_IdIdioma',i.Idi_IdIdioma)Idi_IdIdioma, 
            u.Ubi_Sede
            FROM institucion i 
            INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
            INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais
            WHERE i.Ins_IdInstitucion = ".$id);
            $listaInstituciones=$listaInstituciones->fetch();            
            return $listaInstituciones;

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getOfertaPorIdInsSegunTipo($id=false,$tipo,$idioma)
    {
        try{
            $sql = "call s_s_listar_oferta_por_id_segun_tipo(?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $id, PDO::PARAM_INT);
            $result->bindParam(2, $tipo, PDO::PARAM_STR);
            $result->bindParam(3, $idioma, PDO::PARAM_STR);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getProyectosInvPorIdIns($id=false,$idioma=false)
    {
        try{
            $sql = "call s_s_listar_proy_inv_por_id(?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $id, PDO::PARAM_INT);
            $result->bindParam(2, $idioma, PDO::PARAM_STR);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getOtrosDatosPorIdIns($id=false,$idioma=false)
    {
        try{
            $sql = "call s_s_listar_otros_datos_por_id(?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $id, PDO::PARAM_INT);
            $result->bindParam(2, $idioma, PDO::PARAM_STR);
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

    public function getPaises($Idi_IdIdioma="es")
    {
        try{
            $sql = "SELECT u.Ubi_IdUbigeo, p.Pai_IdPais, 
            fn_TraducirContenido('pais','Pai_Nombre',p.Pai_IdPais,'$Idi_IdIdioma', p.Pai_Nombre)Nombre,
            fn_devolverIdioma('pais',p.Pai_IdPais,'$Idi_IdIdioma',p.Idi_IdIdioma)Idi_IdIdioma, 
            
            COUNT(i.Ins_Nombre) AS Conteo from ubigeo u INNER JOIN institucion i on u.Ubi_IdUbigeo=i.Ubi_IdUbigeo INNER JOIN pais p on p.Pai_IdPais=u.Pai_IdPais GROUP BY p.Pai_Nombre";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }    
    public function getBusquedaGeneral($pagina = 1, $registrosXPagina = 1,$dato,$idioma=false)
    {
        try{
            $sql = "call s_s_listar_instituciones_busqueda_general(?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $pagina, PDO::PARAM_INT);
            $result->bindParam(2, $registrosXPagina, PDO::PARAM_INT);
            $result->bindParam(3, $dato, PDO::PARAM_STR);
            $result->bindParam(4, $idioma, PDO::PARAM_STR);
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
