<?php

class indexModel extends Model
{
    public function __construct()
    {
        parent::__construct();
    }
    
    public function getForos(){
        try{
            $post = $this->_db->query(
                    "SELECT f.*,(SELECT COUNT(Com_IdComentario) FROM comentarios c WHERE c.For_IdForo=f.For_IdForo) as For_TComentarios  FROM foro f");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getForos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    
    public function getForo_x_idforo($iFor_IdForo){
        try{
            $post = $this->_db->query(
                    "SELECT f.*,(SELECT COUNT(Com_IdComentario) FROM comentarios c WHERE c.For_IdForo=f.For_IdForo) as For_TComentarios  FROM foro f where f.For_IdForo={$iFor_IdForo}");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getForos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function getComentarios_x_idforo($iFor_IdForo){
        try{
            $post = $this->_db->query(
                    "SELECT c.Com_IdComentario,c.Com_Descripcion,c.Com_Fecha,c.Com_Estado,c.For_IdForo,c.Idi_IdIdioma,c.Row_Estado,u.Usu_Nombre,u.Usu_Apellidos FROM comentarios c INNER JOIN Usuario u ON u.Usu_IdUsuario=c.Usu_IdUsuario WHERE c.For_IdForo={$iFor_IdForo} and Com_IdPadre IS NULL ORDER BY c.Com_Fecha DESC");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getComentarios_x_idforo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function getComentarios_x_idcomentario($iCom_IdComentario){
        try{
            $post = $this->_db->query(
                    "SELECT c.Com_IdComentario,c.Com_Descripcion,c.Com_Fecha,c.Com_Estado,c.For_IdForo,c.Idi_IdIdioma,c.Row_Estado,u.Usu_Nombre,u.Usu_Apellidos FROM comentarios c INNER JOIN Usuario u ON u.Usu_IdUsuario=c.Usu_IdUsuario WHERE c.Com_IdPadre={$iCom_IdComentario} ORDER BY c.Com_Fecha DESC");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getComentarios_x_idcomentario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    
     public function registrarComentario($iFor_IdForo,$iUsu_IdUsuario,$iCom_Descripcion,$iCom_IdPadre)
    {
        try{           
            $iCom_IdPadre=empty($iCom_IdPadre) ? null : $iCom_IdPadre;
            $sql = "call s_i_comentario(?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iFor_IdForo, PDO::PARAM_INT);
            $result->bindParam(2, $iUsu_IdUsuario, PDO::PARAM_INT);
            $result->bindParam(3, $iCom_Descripcion, PDO::PARAM_STR);
            $result->bindParam(4,$iCom_IdPadre, PDO::PARAM_NULL | PDO::PARAM_INT);
            
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
           
            $this->registrarBitacora("consejeria(adminModel)", "registrarComentario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function getRolForo($iUsu_IdUsuario,$iFor_IdForo){
        try{
            $post = $this->_db->query(
                    "SELECT * FROM usuario_foro WHERE Usu_IdUsuario = {$iUsu_IdUsuario} AND For_IdForo = {$iFor_IdForo}");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getRolForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function getPermisos_desh_Foro($iUsu_IdUsuario,$iFor_IdForo,$iPer_Ckey){
        try{
            $post = $this->_db->query(
                    "SELECT ufp.Per_IdPermiso,p.Per_Ckey FROM usuario_foro_permiso ufp INNER JOIN permisos p ON p.Per_IdPermiso =ufp.Per_IdPermiso  WHERE ufp.Usu_IdUsuario = {$iUsu_IdUsuario} AND ufp.For_IdForo = {$iFor_IdForo} AND p.Per_Ckey = '{$iPer_Ckey}' AND ufp.Ufp_Estado=0");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getPermisos_desh_Foro", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    
    public function inscribir_participante_foro($iFor_IdForo,$iUsu_IdUsuario,$iRol_IdRol,$iUsf_Estado)
    {
        try{           
            
            $sql = "call s_i_inscribir_participante_foro(?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iFor_IdForo, PDO::PARAM_INT);
            $result->bindParam(2, $iUsu_IdUsuario, PDO::PARAM_INT);
            $result->bindParam(3, $iRol_IdRol, PDO::PARAM_INT);
            $result->bindParam(4, $iUsf_Estado, PDO::PARAM_INT);         
            
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
           
            $this->registrarBitacora("foro(indexModel)", "inscribir_participante_foro", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    
    public function insertarFileComentario($Fim_NombreFile,$Fim_TipoFile,$Fim_SizeFile,$Com_IdComentario,$Rec_IdComentario){
        try{           
            
            $sql = "call s_i_insertar_file_comentario(?,?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $Fim_NombreFile, PDO::PARAM_STR);
            $result->bindParam(2, $Fim_TipoFile, PDO::PARAM_STR);
            $result->bindParam(3, $Fim_SizeFile, PDO::PARAM_INT);            
            $result->bindParam(4, $Com_IdComentario, PDO::PARAM_INT);
            $result->bindParam(5, $Rec_IdComentario, PDO::PARAM_INT);         
            
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
           
            $this->registrarBitacora("foro(indexModel)", "insertarFileComentario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    
    
}


?>
