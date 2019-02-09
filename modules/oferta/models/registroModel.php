<?php
class registroModel extends Model {
public function __construct()
    {
        parent::__construct();
    }
    public function getPaises($Idi_IdIdioma = "es")
    {
        try{
            $sql = "SELECT p.Pai_IdPais, 
	    fn_TraducirContenido('pais','Pai_Nombre',p.Pai_IdPais,'$Idi_IdIdioma', p.Pai_Nombre) Pai_Nombre,
            fn_devolverIdioma('pais',p.Pai_IdPais,'$Idi_IdIdioma',p.$Idi_IdIdioma)Idi_IdIdioma                
	    from pais p ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            $lista= $result->fetchAll(PDO::FETCH_ASSOC);
            if(!empty($lista[0]['Pai_IdPais'])){
            	for ($i=0; $i < count($lista); $i++) { 
            		$lista[$i]['Ciudades']=$this->getCiudadesPorIdPai($lista[$i]['Pai_IdPais']);
            	}
                    
                }
            
            return $lista;

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getTipos()
    {
        try{
            $sql = "SELECT DISTINCT i.Ins_Tipo AS Tipo from institucion i ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getIns($Idi_IdIdioma = "es")
    {
        try{
            $sql = "SELECT i.Ins_IdInstitucion AS Id, 
	    
	    fn_TraducirContenido('institucion','Ins_Nombre',i.Ins_IdInstitucion,'$Idi_IdIdioma',i.Ins_Nombre)Ins_Nombre,
            i.Row_Estado,
            fn_devolverIdioma('institucion','Ins_Nombre','$Idi_IdIdioma',i.Idi_IdIoma)Idi_IdIdioma,
	    
	    from institucion i ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getCiudadesPorIdPai($id=false)
    {
        try{
            $sql = "call s_s_listar_ciudad_por_id(?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $id, PDO::PARAM_INT);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function insertarIns($idubigeo,$idpadre,$nombre,$descripcion,$email,$representante,$tel,$direccion,$tipo,$img,$website,$latX,$latY)
    {
        try{
            $guardar = $this->_db->prepare("INSERT INTO institucion(Ins_IdInstitucion,Ubi_IdUbigeo,Ins_IdPadre,Ins_Nombre,Ins_Descripcion,Ins_CorreoPagina,Ins_Representante,Ins_Telefono,Ins_Direccion,Ins_Tipo,Ins_img,row_estado,Ins_WebSite,Ins_latX,Ins_lngY) VALUES (null,:idubigeo,:idpadre,:nombre,:descripcion,:email,:representante,:tel,:direccion,:tipo,:img,1,:website,:latX,:latY)")->execute(array(
				':idubigeo' => $idubigeo,
				':idpadre' => $idpadre,
				':nombre' => $nombre,
                ':descripcion' => $descripcion,
				':email' => $email,
				':representante' => $representante,
				':tel' => $tel,
				':direccion' => $direccion,
				':tipo' => $tipo,
				':img' => $img,
				':website' => $website,
                ':latX' => $latX,
                ':latY' => $latY
            	));
            if($guardar){
            	return true;
            }else{
            	return false;
            }
            
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function insertar_traduccion($tabla,$id,$columna,$idioma,$traduccion)
    {
        try{
            $guardar = $this->_db->prepare("INSERT INTO contenido_traducido(Cot_IdContenidoTraducido,Cot_Tabla,Cot_IdRegistro,Cot_Columna,Idi_IdIdioma,Cot_Traduccion) VALUES (null,:tabla,:id,:columna,:idioma,:traduccion)")->execute(array(
                ':tabla' => $tabla,
                ':id' => $id,
                ':columna' => $columna,
                ':idioma' => $idioma,
                ':traduccion' => $traduccion
                ));
            if($guardar){
                return true;
            }else{
                return false;
            }
            
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function registar_inst_usuario($id_inst,$id_usuario)
    {
        try{
            $guardar = $this->_db->prepare("INSERT INTO institucion_usuario(InU_IdInstitucion_Usuario,Ins_IdInstitucion,Usu_IdUsuario) VALUES (null,:id_inst,:id_usuario)")->execute(array(
                ':id_inst' => $id_inst,
                ':id_usuario' => $id_usuario
                ));
            if($guardar){
                return true;
            }else{
                return false;
            }
            
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function insertarotrosdatos($id,$a,$v)
    {
        try{
            $guardar = $this->_db->prepare("INSERT INTO institucion_otros_datos(Ins_IdInstitucion_otros_datos,Ins_IdInstitucion,Atributo,Valor) VALUES (null,:id,:a,:v)")->execute(array(
				':id' => $id,
				':a' => $a,
				':v' => $v
            	));
            if($guardar){
            	return true;
            }else{
            	return false;
            }
            
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function obtenerultimoid()
    {
        try{
            $sql = "call s_s_listar_ultimo_id";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function obtenerotrosdatos($id,$idioma=false)
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
    public function getInstitucionPorId($id=false)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT p.Pai_Nombre, u.Ubi_Sede,i.* FROM institucion i 
            INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
            INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais
            WHERE i.Ins_IdInstitucion = ".$id);
            return $listaInstituciones->fetch();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getTiposOferta()
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT DISTINCT(o.Ofe_Tipo) AS Nombre FROM oferta o WHERE o.TipoRecurso='Oferta'");
            return $listaInstituciones->fetchAll(PDO::FETCH_ASSOC);

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getTematicas()
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT t.Tem_IdTematica AS Id,t.Tem_Nombre as Nombre FROM tematica t");
            return $listaInstituciones->fetchAll(PDO::FETCH_ASSOC);

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getIdiomas($idioma)
    {
        try{
            $lista_final=array();
            $listaInstituciones = $this->_db->query("SELECT * FROM idioma");
            $listaInstituciones=$listaInstituciones->fetchAll(PDO::FETCH_ASSOC);
            if(count($listaInstituciones)){
                for ($i=0; $i <count($listaInstituciones) ; $i++) { 
                    if($listaInstituciones[$i]['Idi_IdIdioma']!==$idioma){
                        $lista_final[]=$listaInstituciones[$i];
                    }
                }
            }
            return $lista_final;
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getOfertasPorId($id=false)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT o.Ofe_IdOferta,o.Ofe_Tipo AS Tipo, o.Ofe_Nombre AS Nombre, o.Ofe_Descripcion AS Descripcion, t.Tem_Nombre AS Tematica,o.Contacto AS Contacto FROM institucion i 
            INNER JOIN oferta o ON i.Ins_IdInstitucion= o.Ins_IdInstitucion 
            INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica
            WHERE i.Ins_IdInstitucion = ".$id." AND o.TipoRecurso= 'Oferta' ");
            return $listaInstituciones->fetchAll();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getInvPorId($id=false)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT o.Ofe_IdOferta, o.Ofe_Tipo AS Tipo, o.Ofe_Nombre AS Nombre, o.Ofe_Descripcion AS Descripcion, t.Tem_Nombre AS Tematica,o.Contacto AS Contacto FROM institucion i 
            INNER JOIN oferta o ON i.Ins_IdInstitucion= o.Ins_IdInstitucion 
            INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica
            WHERE i.Ins_IdInstitucion = ".$id." AND o.TipoRecurso= 'Investigacion' ");
            return $listaInstituciones->fetchAll();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getInvPorIdInv($id=false)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT o.Ofe_Tipo AS Tipo, o.Ofe_Nombre AS Nombre, o.Ofe_Descripcion AS Descripcion, t.Tem_Nombre AS Tematica,o.Contacto AS Contacto FROM institucion i 
            INNER JOIN oferta o ON i.Ins_IdInstitucion= o.Ins_IdInstitucion 
            INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica
            WHERE o.Ofe_IdOferta = ".$id." AND o.TipoRecurso= 'Investigacion' ");
            return $listaInstituciones->fetch();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getDifPorId($id=false)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT d.Dif_IdDifusion, d.Dif_Nombre AS Nombre,d.Dif_Descripcion AS Descripcion, d.Dif_Link AS Enlace FROM difusion d WHERE d.Ins_IdInstitucion = ".$id);
            return $listaInstituciones->fetchAll();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getDifPorIdDif($id=false)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT d.Dif_Nombre AS Nombre,d.Dif_Descripcion AS Descripcion, d.Dif_Link AS Enlace FROM difusion d WHERE d.Dif_IdDifusion = ".$id);
            return $listaInstituciones->fetch();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function insertarOferta($id,$t,$n,$d,$tipo,$c)
    {
        try{
            $guardar = $this->_db->prepare("INSERT INTO oferta(Ofe_IdOferta,Ins_IdInstitucion,Tem_IdTematica,TipoRecurso,Ofe_Nombre,Ofe_Descripcion,Ofe_Tipo,Contacto,row_estado) VALUES (null,:id,:t,'Oferta',:n,:d,:tipo,:c,1)")->execute(array(
				':id' => $id,
				':t' => $t,
				':n' => $n,
				':d' => $d,
				':tipo' => $tipo,
				':c' => $c
            	));
            if($guardar){
            	return true;
            }else{
            	return false;
            }
            
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function insertarInv($id,$t,$n,$d,$tipo,$c)
    {
        try{
            $guardar = $this->_db->prepare("INSERT INTO oferta(Ofe_IdOferta,Ins_IdInstitucion,Tem_IdTematica,TipoRecurso,Ofe_Nombre,Ofe_Descripcion,Ofe_Tipo,Contacto,row_estado) VALUES (null,:id,:t,'Investigacion',:n,:d,:tipo,:c,1)")->execute(array(
                ':id' => $id,
                ':t' => $t,
                ':n' => $n,
                ':d' => $d,
                ':tipo' => $tipo,
                ':c' => $c
                ));
            if($guardar){
                return true;
            }else{
                return false;
            }
            
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function insertarDif($id,$d,$descripcion,$enlace)
    {
        try{
            $guardar = $this->_db->prepare("INSERT INTO difusion(Dif_IdDifusion,Ins_IdInstitucion,Dif_Nombre,Dif_Descripcion,Dif_Link) VALUES (null,:id,:d,:descripcion,:enlace)")->execute(array(
                ':id' => $id,
                ':d' => $d,
                ':descripcion' => $descripcion,
                ':enlace' => $enlace,
                ));
            if($guardar){
                return true;
            }else{
                return false;
            }
            
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function existe_nombre_Institucion($id=false)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT i.Ins_IdInstitucion FROM institucion i WHERE i.Ins_Nombre = '".$id."'");
            
            return $listaInstituciones->fetchAll();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();

        }
    }
    public function existe_img_Institucion($img=false)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT i.Ins_IdInstitucion AS ID FROM institucion i WHERE i.Ins_img = '".$img."'");
            return $listaInstituciones->fetchAll();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
}
