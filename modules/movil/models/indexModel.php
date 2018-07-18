<?php
class indexModel extends Model {
    public function __construct() {
        parent::__construct();
    }
    /*
    public function getCursos($Mod_IdModCurso){
        $sql = $this->_db->query(
                "SELECT Cur_IdCurso,Cur_UrlBanner,Cur_Titulo FROM curso WHERE Mod_IdModCurso=$Mod_IdModCurso"
        );              
        return $sql->fetchAll();
    }
    */
    public function getCursos(){
        $sql = $this->_db->query("SELECT Cur_IdCurso,Cur_UrlBanner,Cur_Titulo FROM curso WHERE Cur_Estado=1");              
        return $sql->fetchAll();
    }
    public function getContenidoLeccion($Lec_IdLeccion){
        $sql = $this->_db->query(
                "SELECT CL_Descripcion  FROM contenido_leccion WHERE Lec_IdLeccion=$Lec_IdLeccion"
        );              
        return $sql->fetchAll();
    }
    /*
    public function getCursosUsuario($Mod_IdModCurso,$Usu_IdUsuario){
        $sql = $this->_db->query(
                "SELECT cur.Cur_IdCurso,cur.Cur_UrlBanner,cur.Cur_Titulo FROM curso cur
                INNER JOIN usuario_curso usc ON cur.Cur_IdCurso=usc.Cur_IdCurso
                WHERE Mod_IdModCurso=$Mod_IdModCurso AND usc.Usu_IdUsuario=$Usu_IdUsuario"
        );              
        return $sql->fetchAll();
    }
    */
    
    public function getForos() {
        $sql = $this->_db->query(
                "SELECT f.*,(SELECT COUNT(Com_IdComentario) FROM comentarios c WHERE c.For_IdForo=f.For_IdForo) as For_TComentarios  FROM foro f WHERE f.For_Funcion LIKE '%forum%' AND Row_Estado=1 ORDER BY f.For_FechaCreacion DESC"
        );              
        return $sql->fetchAll();        
    }
    public function getLecciones($Mod_IdModulo){
        $sql = $this->_db->query(
                "SELECT * FROM leccion WHERE Mod_IdModulo=$Mod_IdModulo"
        );              
        return $sql->fetchAll();
    }
    public function getModulos($Cur_IdCurso){
        $sql = $this->_db->query(
                "SELECT Mod_IdModulo,Mod_Titulo FROM modulo_curso WHERE Cur_IdCurso=$Cur_IdCurso"
        );              
        return $sql->fetchAll();
    }
    public function getUsuariosCursos($Usu_IdUsuario){
        $sql = $this->_db->query(
                "SELECT usc.* FROM curso cur INNER JOIN usuario_curso usc ON 
                cur.Cur_IdCurso=usc.Cur_IdCurso WHERE usc.Usu_IdUsuario=$Usu_IdUsuario 
                AND cur.Estado=1"
        );              
        return $sql->fetchAll();
    }
    public function getUsuarioPorId($Usu_IdUsuario){        
        $sql = $this->_db->query(
                "SELECT * FROM usuario WHERE  Usu_IdUsuario=$Usu_IdUsuario"
        );              
        return $sql->fetchAll();                
    } 
    public function getUsuarioPorUsuarioDni($Usu_Usuario,$Usu_DocumentoIdentidad){        
        $sql = $this->_db->query(
                "SELECT * FROM usuario WHERE  Usu_Usuario='$Usu_Usuario' OR Usu_DocumentoIdentidad = $Usu_DocumentoIdentidad "
        );              
        return $sql->fetchAll();                
    } 
    public function getUsuarioPorUsuarioPassword($Usu_Usuario,$Usu_Password){        
        $sql = $this->_db->query(
                "SELECT * FROM usuario WHERE  Usu_Usuario='$Usu_Usuario' AND Usu_Password = '$Usu_Password' "
        );              
        return $sql->fetchAll();         
    }
    public function insertarUsuario($Usu_Nombre,$Usu_Apellidos,$Usu_DocumentoIdentidad,$Usu_Usuario,$Usu_Password){        
        try {                                        
            $sql = "INSERT INTO usuario(Usu_Nombre,$Usu_Apellidos,Usu_DocumentoIdentidad, Usu_Usuario,Usu_Password) VALUES($Usu_Nombre,$Usu_Apellidos,$Usu_DocumentoIdentidad, $Usu_Usuario,$Usu_Password)";                         
            $result = $this->_db->prepare($sql);                                                   
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("movil(indexModel)", "insertarUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }        
    }
    public function insertarUsuarioGoogle($Usu_Usuario,$Usu_Password){        
        try {              
            $sql = "call s_i_usuario_google(?,?)";                                                                                 
            $result = $this->_db->prepare($sql);               
            $result->bindParam(1, $Usu_Usuario, PDO::PARAM_STR);                
            $result->bindParam(2, $Usu_Password, PDO::PARAM_STR);                                        
            $result->execute();                        
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("movil(indexModel)", "insertarUsuarioGoogle", "Error Model", $exception);
            return $exception->getTraceAsString();
        }        
    }  

}

?>
