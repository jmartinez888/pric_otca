<?php
class editarModel extends Model {
public function __construct()
    {
        parent::__construct();
    }
    public function getPaises()
    {
        try{
            $sql = "SELECT p.Pai_Nombre AS Nombre,p.Pai_IdPais from pais p ";
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
    public function getIns()
    {
        try{
            $sql = "SELECT i.Ins_IdInstitucion AS Id, i.Ins_Nombre AS Nombre from institucion i ";
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
    public function editarIns($id,$idubigeo,$idpadre,$nombre,$email,$representante,$tel,$direccion,$tipo,$img,$website,$latX,$latY)
    {
        try{
            $sql =" UPDATE institucion SET Ubi_IdUbigeo='$idubigeo',Ins_IdPadre='$idpadre',Ins_Nombre='$nombre',Ins_CorreoPagina='$email',Ins_Representante='$representante',Ins_Telefono='$tel',Ins_Direccion='$direccion',Ins_Tipo='$tipo',Ins_img='$img',Ins_WebSite='$website',Ins_latX='$latX',Ins_lngY='$latY' WHERE Ins_IdInstitucion='$id' ";
            $result = $this->_db->prepare($sql);

            $result->execute();
            return $result->rowCount();
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function editarotrosdatos($id_od,$id,$Atributo,$Valor)
    {
        try{
            $sql =" UPDATE institucion_otros_datos SET Atributo='$Atributo',Valor='$Valor' WHERE Ins_IdInstitucion_otros_datos='$id_od' ";
            $result = $this->_db->prepare($sql);

            $result->execute();
            return $result->rowCount();
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
    public function obtenerotrosdatos($id)
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
    public function getInstitucionPorId($id=false)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT p.Pai_IdPais, p.Pai_Nombre, u.Ubi_Sede,i.* FROM institucion i 
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
    public function getOfertasPorId($id=false)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT i.Ins_IdInstitucion, o.Ofe_IdOferta, o.Ofe_Tipo AS Tipo, o.Ofe_Nombre AS Nombre, o.Ofe_Descripcion AS Descripcion, t.Tem_Nombre AS Tematica,o.Contacto AS Contacto FROM institucion i 
            INNER JOIN oferta o ON i.Ins_IdInstitucion= o.Ins_IdInstitucion 
            INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica
            WHERE i.Ins_IdInstitucion = ".$id." AND o.TipoRecurso='Oferta' ");
            return $listaInstituciones->fetchAll();

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
    public function editarOferta($id_oferta,$t,$n,$d,$tipo,$c)
    {
        try{
            $sql =" UPDATE oferta SET Tem_IdTematica = '$t',Ofe_Nombre='$n',Ofe_Descripcion='$d',Ofe_Tipo='$tipo',Contacto='$c' WHERE Ofe_IdOferta='$id_oferta' ";
            $result = $this->_db->prepare($sql);

            $result->execute();
            return $result->rowCount();
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function editar_inv($id_oferta,$t,$n,$d,$tipo,$c)
    {
        try{
            $sql =" UPDATE oferta SET Tem_IdTematica = '$t',Ofe_Nombre='$n',Ofe_Descripcion='$d',Ofe_Tipo='$tipo',Contacto='$c' WHERE Ofe_IdOferta='$id_oferta' ";
            $result = $this->_db->prepare($sql);

            $result->execute();
            return $result->rowCount();
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function editar_dif($id_oferta,$n,$d,$l)
    {
        try{
            $sql =" UPDATE difusion SET Dif_Nombre = '$n',Dif_Descripcion='$d',Dif_Link='$l' WHERE Dif_IdDifusion='$id_oferta' ";
            $result = $this->_db->prepare($sql);

            $result->execute();
            return $result->rowCount();
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function obtenerOD($id=false)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT i.* FROM institucion_otros_datos i 
            WHERE i.Ins_IdInstitucion_otros_datos = ".$id);
            return $listaInstituciones->fetch();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getDetOfertasPorId($id=false)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT i.Ins_IdInstitucion, o.Ofe_IdOferta, o.Ofe_Tipo, o.Ofe_Nombre, o.Ofe_Descripcion, t.Tem_Nombre,o.Contacto FROM institucion i 
            INNER JOIN oferta o ON i.Ins_IdInstitucion= o.Ins_IdInstitucion 
            INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica
            WHERE o.Ofe_IdOferta = ".$id);
            return $listaInstituciones->fetch();

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
    public function getDifPorId($id=false)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT d.Dif_IdDifusion, d.Dif_Nombre AS Nombre,d.Dif_Descripcion AS Descripcion, d.Dif_Link AS Enlace FROM difusion d WHERE d.Ins_IdInstitucion = ".$id);
            return $listaInstituciones->fetchAll();

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
    public function insertarDif($id,$d,$descripcion,$enlace)
    {
        try{
            $guardar = $this->_db->prepare("INSERT INTO difusion(Dif_IdDifusion,Ins_IdInstitucion,Dif_Nombre,Dif_Descripcion,Dif_Link) VALUES (null,:id,:d,:descripcion,:enlace)")->execute(array(
                ':id' => $id,
                ':d' => $d,
                ':descripcion' => $descripcion,
                ':enlace' => $enlace
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
    public function getDifPorIdDif($id=false)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT d.Dif_IdDifusion, d.Dif_Nombre AS Nombre,d.Dif_Descripcion AS Descripcion, d.Dif_Link AS Enlace FROM difusion d WHERE d.Dif_IdDifusion = ".$id);
            return $listaInstituciones->fetch();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getEliminarOD($id)
    {
        try{
            $guardar = $this->_db->prepare("DELETE FROM institucion_otros_datos WHERE Ins_IdInstitucion_otros_datos = '$id' ")->execute();
            if($guardar){
                return true;
            }else{
                return false;
            }
            
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getEliminarOA($id)
    {
        try{
            $guardar = $this->_db->prepare("DELETE FROM oferta WHERE Ofe_IdOferta = '$id' ")->execute();
            if($guardar){
                return true;
            }else{
                return false;
            }
            
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getEliminarDif($id)
    {
        try{
            $guardar = $this->_db->prepare("DELETE FROM difusion WHERE Dif_IdDifusion = '$id' ")->execute();
            if($guardar){
                return true;
            }else{
                return false;
            }
            
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }

}