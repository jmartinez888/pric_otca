<?php
class editarModel extends Model {
    public function __construct()
    {
        parent::__construct();
    }
    public function getPaises($Idi_IdIdioma = "es")
    {
        try{
            $sql = "SELECT p.Pai_IdPais,
            fn_TraducirContenido('pais','Pai_Nombre',p.Pai_IdPais,'$Idi_IdIdioma', p.Pai_Nombre) Pai_Nombre,
            fn_devolverIdioma('pais',p.Pai_IdPais,'$Idi_IdIdioma',p.Idi_IdIdioma)Idi_IdIdioma
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
     public function getIdiomas($idioma)
    {
        try{
            $lista_final=array();
            $listaInstituciones = $this->_db->query("
            SELECT *, fn_TraducirContenido('idioma','Idi_Idioma',idioma.Idi_CharCode,'".self::getCurrentLang()."',idioma.Idi_Idioma) Idi_Idioma  FROM idioma");
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
    public function getIns($Idi_IdIdioma="es")
    {
        try{
            $sql = "SELECT i.Ins_IdInstitucion AS Id,
            fn_TraducirContenido('institucion','Ins_Nombre',i.Ins_IdInstitucion,'$Idi_IdIdioma',i.Ins_Nombre)Ins_Nombre,
            i.Row_Estado,
            fn_devolverIdioma('institucion',i.Ins_IdInstitucion,'$Idi_IdIdioma',i.Idi_IdIdioma)Idi_IdIdioma,
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
    public function getInstitucionPorId($id=false, $Idi_IdIdioma="es")
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT p.Pai_IdPais, 
            
            fn_TraducirContenido('pais','Pai_Nombre',p.Pai_IdPais,'$Idi_IdIdioma', p.Pai_Nombre) Pai_Nombre,
            u.Ubi_Sede,
            i.Ins_IdInstitucion, 
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
            fn_devolverIdioma('institucion',i.Ins_IdInstitucion,'$Idi_IdIdioma',i.Idi_IdIdioma)Idi_IdIdioma
            
            FROM institucion i 
            INNER JOIN ubigeo u ON i.Ubi_IdUbigeo=u.Ubi_IdUbigeo 
            INNER JOIN pais p ON p.Pai_IdPais=u.Pai_IdPais
            WHERE i.Ins_IdInstitucion = ".$id);
            return $listaInstituciones->fetch();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getInstitucionPorIdTraducido($tabla,$id,$columna,$idioma)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT fn_TraducirContenido('$tabla','$columna','$id','$idioma',c.Cot_Traduccion) Cot_Traduccion FROM contenido_traducido c ");
            return $listaInstituciones->fetch();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getIdTraducido($tabla,$id,$columna,$idioma)
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT c.Cot_IdContenidoTraducido FROM contenido_traducido c WHERE c.Cot_Tabla = '$tabla' and c.Cot_Columna = '$columna' and c.Cot_IdRegistro =  '$id' and c.Idi_IdIdioma = '$idioma' ");
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
    public function getTematicas($Idi_IdIdioma="es")
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT t.Tem_IdTematica AS Id,
            
            fn_TraducirContenido('tematica','Tem_Nombre',t.Tem_IdTematica,'$Idi_IdIdioma', t.Tem_Nombre)Tem_Nombre,
            fn_devolverIdioma('tematica',t.Tem_IdTematica,'$Idi_IdIdioma',t.Idi_IdIdioma)Idi_IdIdioma
            FROM tematica t");
            
            return $listaInstituciones->fetchAll(PDO::FETCH_ASSOC);

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getOfertasPorId($id=false, $Idi_IdIdioma="es")
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT i.Ins_IdInstitucion, o.Ofe_IdOferta, t.Tem_IdTematica,
            
            fn_TraducirContenido('oferta','Ofe_Tipo',o.Ofe_IdOferta,'$Idi_IdIdioma',o.Ofe_Tipo)Ofe_Tipo,                        
            fn_TraducirContenido('oferta','Ofe_Nombre',o.Ofe_IdOferta,'$Idi_IdIdioma',o.Ofe_Nombre)Ofe_Nombre,
            fn_TraducirContenido('oferta','Ofe_Descripcion',o.Ofe_IdOferta,'$Idi_IdIdioma',o.Ofe_Descripcion)Ofe_Descripcion, 
            fn_TraducirContenido('tematica','Tem_Nombre',t.Tem_IdTematica,'$Idi_IdIdioma', t.Tem_Nombre)Tem_Nombre,
            i.row_estado,
            fn_devolverIdioma('institucion',i.Ins_IdInstitucion,'$Idi_IdIdioma',i.Idi_IdIdioma)Idi_IdIdioma,
            o.Contacto AS Contacto 
            FROM institucion i 
            INNER JOIN oferta o ON i.Ins_IdInstitucion= o.Ins_IdInstitucion 
            INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica
            WHERE i.Ins_IdInstitucion = ".$id." AND o.TipoRecurso='Oferta' ");
            return $listaInstituciones->fetchAll();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getOfertasPorIdTraducido($id=false,$idioma='')
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT i.Ins_IdInstitucion, o.Ofe_IdOferta, o.Ofe_Tipo AS Tipo, 
                fn_TraducirContenido('oferta','Ofe_Nombre',o.Ofe_IdOferta,'$idioma', o.Ofe_Nombre) Ofe_Nombre, 
                fn_TraducirContenido('oferta', 'Ofe_Descripcion',o.Ofe_IdOferta,'$idioma', o.Ofe_Descripcion) Ofe_Descripcion, t.Tem_Nombre AS Tematica,o.Contacto AS Contacto,
                fn_devolverIdioma('oferta',o.Ofe_IdOferta,'$idioma','$idioma')Idioma
                FROM institucion i 
            INNER JOIN oferta o ON i.Ins_IdInstitucion= o.Ins_IdInstitucion 
            INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica
            WHERE i.Ins_IdInstitucion = ".$id." AND o.TipoRecurso='Oferta' ");
            return $listaInstituciones->fetchAll();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getInvPorIdTraducido($id=false,$idioma='')
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT i.Ins_IdInstitucion, o.Ofe_IdOferta, o.Ofe_Tipo AS Tipo, 
                fn_TraducirContenido('oferta','Ofe_Nombre',o.Ofe_IdOferta,'$idioma', o.Ofe_Nombre) Ofe_Nombre, 
                fn_TraducirContenido('oferta', 'Ofe_Descripcion',o.Ofe_IdOferta,'$idioma', o.Ofe_Descripcion) Ofe_Descripcion, t.Tem_Nombre AS Tematica,o.Contacto AS Contacto,
                fn_devolverIdioma('oferta',o.Ofe_IdOferta,'$idioma','$idioma') Idioma
                FROM institucion i 
            INNER JOIN oferta o ON i.Ins_IdInstitucion= o.Ins_IdInstitucion 
            INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica
            WHERE i.Ins_IdInstitucion = ".$id." AND o.TipoRecurso='Investigacion' ");
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
    public function actualizar_traduccion($id,$c)
    {
        try{
            $sql =" UPDATE contenido_traducido SET Cot_Traduccion = '$c' WHERE Cot_IdContenidoTraducido='$id' ";
            $result = $this->_db->prepare($sql);

            $result->execute();
            return $result->rowCount();
        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
     public function actualizar_traduccion_param($tabla,$columna,$c,$id,$idioma)
    {
        try{
            $sql =" UPDATE contenido_traducido SET Cot_Traduccion = '$c' WHERE Cot_IdRegistro='$id' and Cot_Tabla= '$tabla' and Cot_Columna = '$columna' and Idi_IdIdioma = '$idioma' ";
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
    public function getDetOfertasPorId($id=false, $Idi_IdIdioma="es")
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT i.Ins_IdInstitucion, o.Ofe_IdOferta,t.Tem_IdTematica, 
            
            fn_TraducirContenido('oferta','Ofe_Tipo',o.Ofe_IdOferta,'$Idi_IdIdioma',o.Ofe_Tipo)Ofe_Tipo,                        
            fn_TraducirContenido('oferta','Ofe_Nombre',o.Ofe_IdOferta,'$Idi_IdIdioma',o.Ofe_Nombre)Ofe_Nombre,
            fn_TraducirContenido('oferta','Ofe_Descripcion',o.Ofe_IdOferta,'$Idi_IdIdioma',o.Ofe_Descripcion)Ofe_Descripcion, 
            fn_TraducirContenido('tematica','Tem_Nombre',t.Tem_IdTematica,'$Idi_IdIdioma', t.Tem_Nombre)Tem_Nombre,
            i.row_estado,
            fn_devolverIdioma('institucion',i.Ins_IdInstitucion,'$Idi_IdIdioma',i.Idi_IdIdioma)Idi_IdIdioma,
            
            o.Contacto 
            FROM institucion i 
            INNER JOIN oferta o ON i.Ins_IdInstitucion= o.Ins_IdInstitucion 
            INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica
            WHERE o.Ofe_IdOferta = ".$id);
            return $listaInstituciones->fetch();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getInvPorId($id=false, $Idi_IdIdioma="es")
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT o.Ofe_IdOferta,i.Ins_IdInstitucion,t.Tem_IdTematica, 
            
            fn_TraducirContenido('oferta','Ofe_Tipo',o.Ofe_IdOferta,'$Idi_IdIdioma',o.Ofe_Tipo)Ofe_Tipo,                        
            fn_TraducirContenido('oferta','Ofe_Nombre',o.Ofe_IdOferta,'$Idi_IdIdioma',o.Ofe_Nombre)Ofe_Nombre,
            fn_TraducirContenido('oferta','Ofe_Descripcion',o.Ofe_IdOferta,'$Idi_IdIdioma',o.Ofe_Descripcion)Ofe_Descripcion, 
            fn_TraducirContenido('tematica','Tem_Nombre',t.Tem_IdTematica,'$Idi_IdIdioma', t.Tem_Nombre)Tem_Nombre,
            i.row_estado,
            fn_devolverIdioma('institucion',i.Ins_IdInstitucion,'$Idi_IdIdioma',i.Idi_IdIdioma)Idi_IdIdioma,
                       
            o.Contacto AS Contacto 
                       
            FROM institucion i 
            INNER JOIN oferta o ON i.Ins_IdInstitucion= o.Ins_IdInstitucion 
            INNER JOIN tematica t ON t.Tem_IdTematica=o.Tem_IdTematica
            WHERE i.Ins_IdInstitucion = ".$id." AND o.TipoRecurso= 'Investigacion' ");
            return $listaInstituciones->fetchAll();

        } catch (PDOException $exception) {
            return $exception->getTraceAsString();
        }
    }
    public function getDifPorId($id=false, $Idi_IdIdioma="es")
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT d.Dif_IdDifusion, 
            
            fn_TraducirContenido('difusion','Dif_Nombre',d.Dif_IdDifusion,'$Idi_IdIdioma',d.Dif_Nombre)Dif_Nombre,
            fn_TraducirContenido('difusion','Dif_Descripcion',D.Dif_IdDifusion,'$Idi_IdIdioma',d.Dif_Descripcion)Dif_Descripcion, 
            fn_devolverIdioma('difusion',d.Dif_IdDifusion,'$Idi_IdIdioma',d.Idi_IdIdioma)Idi_IdIdioma,
                                  
            d.Dif_Link AS Enlace 
            FROM difusion d WHERE d.Ins_IdInstitucion = ".$id);
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
    public function getInvPorIdInv($id=false, $Idi_IdIdioma="es")
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT o.Ofe_IdOferta,i.Ins_IdInstitucion,t.Tem_IdTematica,
            
            fn_TraducirContenido('oferta','Ofe_Tipo',o.Ofe_IdOferta,'$Idi_IdIdioma',o.Ofe_Tipo)Ofe_Tipo,                        
            fn_TraducirContenido('oferta','Ofe_Nombre',o.Ofe_IdOferta,'$Idi_IdIdioma',o.Ofe_Nombre)Ofe_Nombre,
            fn_TraducirContenido('oferta','Ofe_Descripcion',o.Ofe_IdOferta,'$Idi_IdIdioma',o.Ofe_Descripcion)Ofe_Descripcion, 
            fn_TraducirContenido('tematica','Tem_Nombre',t.Tem_IdTematica,'$Idi_IdIdioma', t.Tem_Nombre)Tem_Nombre,
            i.row_estado,
            fn_devolverIdioma('institucion',i.Ins_IdInstitucion,'$Idi_IdIdioma',i.Idi_IdIdioma)Idi_IdIdioma,
            
            o.Contacto AS Contacto 
            
            FROM institucion i 
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
    public function getDifPorIdDif($id=false, $Idi_IdIdioma="es")
    {
        try{
            $listaInstituciones = $this->_db->query("SELECT d.Dif_IdDifusion, 
            
            fn_TraducirContenido('difusion','Dif_Nombre',d.Dif_IdDifusion,'$Idi_IdIdioma',d.Dif_Nombre)Dif_Nombre,
            fn_TraducirContenido('difusion','Dif_Descripcion',D.Dif_IdDifusion,'$Idi_IdIdioma',d.Dif_Descripcion)Dif_Descripcion, 
            fn_devolverIdioma('difusion',d.Dif_IdDifusion,'$Idi_IdIdioma',d.Idi_IdIdioma)Idi_IdIdioma,
            
            d.Dif_Link AS Enlace 
            FROM difusion d WHERE d.Dif_IdDifusion = ".$id);
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
