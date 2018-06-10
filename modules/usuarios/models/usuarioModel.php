<?php

class usuarioModel extends Model
{
    public function __construct()
    {
        parent::__construct();
    }
    //Util Jhon Martinez
    public function getUsuariosPaginado($condicion = '')
    {
        try{
            $listaUsuarios = $this->_db->query(
                " SELECT u.* from usuario u $condicion "
            );           
            $listaUsuarios = $listaUsuarios->fetchAll();

            for ($i = 0; $i < count($listaUsuarios); $i++) 
            {
                if (!empty($listaUsuarios[$i]['Usu_IdUsuario'])) 
                {
                    $listaUsuarios[$i]['Roles'] = $this->getUsuariosRoles($listaUsuarios[$i]['Usu_IdUsuario']);
                }
            }

            return $listaUsuarios;            
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "getUsuariosPaginado", "Error Model", $exception);
            return $exception->getTraceAsString();
        } 
    }
    //Util Jhon Martinez
    public function getUsuariosRowCount($condicion = '')
    {
        try{
            $usuarios = $this->_db->query(
                " SELECT COUNT(u.Usu_IdUsuario) AS CantidadRegistros from usuario u $condicion "
            );           
            return $usuarios->fetch(PDO::FETCH_ASSOC);            
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "getUsuariosRowCount", "Error Model", $exception);
            return $exception->getTraceAsString();
        }        
    }
    //Util Jhon Martinez
    public function getUsuariosRoles($Usu_IdUsuario = '')
    {
        try{
            $rol = $this->_db->query(
                " SELECT r.* from usuario_rol ur, rol r WHERE ur.Rol_IdRol = r.Rol_IdRol AND ur.Usu_IdUsuario = $Usu_IdUsuario "
            );           
            return $rol->fetchAll();            
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "getUsuariosRoles", "Error Model", $exception);
            return $exception->getTraceAsString();
        }        
    }

    public function getRolesxUsuario($Usu_IdUsuario = '')
    {
        try{
            $rol = $this->_db->query(
                " SELECT Rol_IdRol FROM usuario_rol WHERE Usu_IdUsuario= $Usu_IdUsuario"
            );           
            return $rol->fetchAll();            
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "getUsuariosRoles", "Error Model", $exception);
            return $exception->getTraceAsString();
        }        
    }


    public function getUsuarios($condicion = '')
    {
        try{
            $usuarios = $this->_db->query(
                "select u.*,r.Rol_Nombre from usuario u,usuario_rol ur, rol r".
                " where u.Usu_IdUsuario = ur.Usu_IdUsuario and ur.Rol_IdRol = r.Rol_IdRol $condicion"
            );           
            return $usuarios->fetchAll();            
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "getUsuarios", "Error Model", $exception);
            return $exception->getTraceAsString();
        }        
    }

    public function getUsuariosCondicion($pagina, $registrosXPagina, $condicion = "")
    {
        try{
            $registroInicio = 0;
            if ($pagina > 0) {
                $registroInicio = ($pagina - 1) * $registrosXPagina;                
            }

            $listaUsuarios = $this->_db->query(
                " SELECT u.* from usuario u $condicion  LIMIT $registroInicio, $registrosXPagina"
            );           
            $listaUsuarios = $listaUsuarios->fetchAll(PDO::FETCH_ASSOC);

            for ($i = 0; $i < count($listaUsuarios); $i++) 
            {

                if (!empty($listaUsuarios[$i]['Usu_IdUsuario'])) 
                {
                    $listaUsuarios[$i]['Roles'] = $this->getUsuariosRoles($listaUsuarios[$i]['Usu_IdUsuario']);
                }
            }

            return $listaUsuarios;

        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getRolesCondicion", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    //util JM
    public function getUsuario($usuarioID)
    {
        try{
            $usuarios = $this->_db->query(
                " SELECT u.* FROM usuario u  WHERE u.Usu_IdUsuario = $usuarioID"
            );
            return $usuarios->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "getUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function eliminarHabilitarUsuario($Usu_IdUsuario = 0,$Row_Estado = 0)
    {
        try{

            $permiso = $this->_db->query(
                " UPDATE usuario SET Row_Estado = $Row_Estado WHERE Usu_IdUsuario = $Usu_IdUsuario "               
                );
            return $permiso->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "eliminarHabilitarUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getRoles()
    {
        try{
            $roles = $this->_db->query(
                " SELECT * FROM rol WHERE Rol_Estado = 1 AND Row_Estado = 1" );
            return $roles->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "getRoles", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    
    //Util JM
    public function getPermisosUsuario($usuarioID)
    {
        $acl = new  ACL($usuarioID);
        return $acl->getPermisos();
    }
    //Util JM
    public function getPermisosRoles($usuarioID)
    {
        $acl = new ACL($usuarioID);
        return $acl->getPermisosRoles();
    }
    
    //Util JM
    public function replaceRolUsuario($Usu_IdUsuario, $Rol_IdRol)
    {
        try{
            $usu = $this->_db->query(
                " REPLACE usuario_rol SET Usu_IdUsuario = $Usu_IdUsuario, Rol_IdRol = $Rol_IdRol, Usr_Valor = 1 "              
            );
            return $usu->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "replaceRolUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util JM
    public function eliminarPermiso($usuarioID, $permisoID)
    {
        try{
            $per = $this->_db->query(
                " DELETE FROM permisos_usuario WHERE Usu_IdUsuario = $usuarioID AND Per_IdPermiso = $permisoID "
            );
            return $per->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "eliminarPermiso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util JM
    public function editarPermiso($usuarioID, $permisoID, $valor)
    {
        try{
            $per = $this->_db->query(
                " REPLACE INTO permisos_usuario SET Usu_IdUsuario = $usuarioID, Per_IdPermiso = $permisoID, Peu_Valor = '$valor'"
            );
            return $per->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "editarPermiso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    
    public function verificarUsuario($usuario)
    {
        try{
            $id = $this->_db->query(
                    "select Usu_IdUsuario, Usu_Codigo from usuario where Usu_Usuario = '$usuario'"
                    );
            return $id->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "verificarUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    
    public function verificarEmail($email)
    {
        try{
            $id = $this->_db->query(
                    "select Usu_IdUsuario, Usu_Codigo, Usu_Usuario, Usu_Email from usuario where Usu_Email = '$email'"
                    );        
            return $id->fetch(PDO::FETCH_ASSOC);            
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "verificarUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function verificarEmailCodigo($email,$codigo)
    {
        try{
            $id = $this->_db->query(
                    "select Usu_IdUsuario, Usu_Codigo, Usu_Email, Usu_Usuario, Usu_RecuperarPass from usuario where Usu_Email = '$email' and Usu_Codigo = '$codigo' "
                    );        
            return $id->fetch(PDO::FETCH_ASSOC);            
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "verificarEmailCodigo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    
    public function registrarUsuario( $iUsu_Nombre = "", $iUsu_Apellidos = "", $iUsu_DocumentoIdentidad = 0, $iUsu_Direccion = "", $iUsu_Telefono = "", $iUsu_InstitucionLaboral = "", $iUsu_Cargo = "", $iUsu_Usuario = "", $iUsu_Password = "", $iUsu_Email = "", $iUsu_Estado = 0, $iUsu_Codigo = 0 )
    {              
        $iUsu_Password = Hash::getHash('sha1', $iUsu_Password, HASH_KEY);
        try {            
            $sql = "call s_i_usuario(?,?,?,?,?,?,?,?,?,?,now(),now(),?,?,1)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iUsu_Nombre, PDO::PARAM_STR);
            $result->bindParam(2, $iUsu_Apellidos, PDO::PARAM_STR);
            $result->bindParam(3, $iUsu_DocumentoIdentidad, PDO::PARAM_INT);
            $result->bindParam(4, $iUsu_Direccion, PDO::PARAM_STR);
            $result->bindParam(5, $iUsu_Telefono, PDO::PARAM_STR);
            $result->bindParam(6, $iUsu_InstitucionLaboral, PDO::PARAM_STR);
            $result->bindParam(7, $iUsu_Cargo, PDO::PARAM_STR);
            $result->bindParam(8, $iUsu_Usuario, PDO::PARAM_STR);
            $result->bindParam(9, $iUsu_Password, PDO::PARAM_STR);
            $result->bindParam(10, $iUsu_Email, PDO::PARAM_STR);
            // $result->bindParam(11, $iRol_IdRol, PDO::PARAM_INT);
//            $result->bindParam(12, $iUsu_Fecha, PDO::PARAM_STR);
            $result->bindParam(11, $iUsu_Estado, PDO::PARAM_STR);
            $result->bindParam(12, $iUsu_Codigo, PDO::PARAM_STR);
           
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "registrarUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }        
    }
    public function insertarUsuarioLogin( $iUsu_Nombre = "", $iUsu_Apellidos = "", $iUsu_Usuario = "", $iUsu_Password = "", $iUsu_Email = "", $iRol_Ckey = "", $iUsu_Estado = 0, $iUsu_Codigo = 0 )
    {     
        if ($iUsu_Password == "") {
            // echo("arg1");
            try {            
                $sql = " call s_i_usuario_login_gmail(?,?,?,?,now(),now(),1,?,1) ";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $iUsu_Nombre, PDO::PARAM_STR);
                $result->bindParam(2, $iUsu_Apellidos, PDO::PARAM_STR);
                $result->bindParam(3, $iUsu_Usuario, PDO::PARAM_STR);
                // $result->bindParam(4, $iUsu_Password, PDO::PARAM_STR);
                $result->bindParam(4, $iUsu_Email, PDO::PARAM_STR);
                // $result->bindParam(11, $iRol_IdRol, PDO::PARAM_INT);
    //            $result->bindParam(12, $iUsu_Fecha, PDO::PARAM_STR);
                // $result->bindParam(5, $iUsu_Estado, PDO::PARAM_INT);
                $result->bindParam(5, $iUsu_Codigo, PDO::PARAM_STR);
               
                $result->execute();

                $result = $result->fetch();
                // return $result;
                // print_r($result);exit;

            } catch (PDOException $exception) {
                $this->registrarBitacora("usuario(indexModel)", "insertarUsuarioLogin1", "Error Model", $exception);
                return $exception->getTraceAsString();
            }    
        } else {
                          
            $iUsu_Password = Hash::getHash('sha1', $iUsu_Password, HASH_KEY);
            // echo($iUsu_Password.$iUsu_Nombre.$iUsu_Apellidos.$iUsu_Usuario.$iUsu_Password.$iUsu_Email.$iRol_Ckey.$iUsu_Estado.$iUsu_Codigo);
            try {            
                $sql = " call s_i_usuario_login(?,?,?,?,?,now(),now(),?,?,1) ";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $iUsu_Nombre, PDO::PARAM_STR);
                $result->bindParam(2, $iUsu_Apellidos, PDO::PARAM_STR);
                $result->bindParam(3, $iUsu_Usuario, PDO::PARAM_STR);
                $result->bindParam(4, $iUsu_Password, PDO::PARAM_STR);
                $result->bindParam(5, $iUsu_Email, PDO::PARAM_STR);
                // $result->bindParam(11, $iRol_IdRol, PDO::PARAM_INT);
    //            $result->bindParam(12, $iUsu_Fecha, PDO::PARAM_STR);
                $result->bindParam(6, $iUsu_Estado, PDO::PARAM_INT);
                $result->bindParam(7, $iUsu_Codigo, PDO::PARAM_STR);
               
                $result->execute();

                $result = $result->fetch();
                // return $result;
                // print_r($result);exit;

            } catch (PDOException $exception) {
                $this->registrarBitacora("usuario(indexModel)", "insertarUsuarioLogin2", "Error Model", $exception);
                return $exception->getTraceAsString();
            }        
        }


        if ($iRol_Ckey == "" || !$iRol_Ckey) {
            return $result;
        } else {
            $condicionRol = " WHERE Rol_Ckey = '$iRol_Ckey' ";

            $Rol = $this->getIdRolCondicion($condicionRol);

            if (is_array($Rol) && $Rol["Rol_IdRol"] > 0 ) {
                $rowCount = $this->replaceRolUsuario($result[0],$Rol["Rol_IdRol"]);

                if ($rowCount > 0) {
                    return $result;
                } else {
                    return $rowCount;
                }
            } else {
                return $Rol;
            }  
        }
             
    }
    //Util_Rol Jhon Martinez
    public function getIdRolCondicion($Condicion = "")
    {
        try{        
            $rol = $this->_db->query(" SELECT Rol_IdRol FROM rol $Condicion ");
            return $rol->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(usuarioModel)", "getIdRolCondicion", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function editarUsuario($iUsu_Nombre, $iUsu_Apellidos, $iUsu_DocumentoIdentidad, $iUsu_Direccion, $iUsu_Telefono, $iUsu_InstitucionLaboral, $iUsu_Cargo, $iUsu_Email, $iUsu_IdUsuario )
    {
        try {            
            $sql = "UPDATE usuario u SET u.Usu_Nombre=:iUsu_Nombre,u.Usu_Apellidos=:iUsu_Apellidos,u.Usu_DocumentoIdentidad=:iUsu_DocumentoIdentidad,u.Usu_Direccion=:iUsu_Direccion,u.Usu_Telefono=:iUsu_Telefono,u.Usu_InstitucionLaboral=:iUsu_InstitucionLaboral,u.Usu_Cargo=:iUsu_Cargo,u.Usu_Email=:iUsu_Email WHERE u.Usu_IdUsuario=:iUsu_IdUsuario";
            $result = $this->_db->prepare($sql);
            $result->bindParam(':iUsu_Nombre', $iUsu_Nombre, PDO::PARAM_STR);
            $result->bindParam(':iUsu_Apellidos', $iUsu_Apellidos, PDO::PARAM_STR);
            $result->bindParam(':iUsu_DocumentoIdentidad', $iUsu_DocumentoIdentidad, PDO::PARAM_INT);
            $result->bindParam(':iUsu_Direccion', $iUsu_Direccion, PDO::PARAM_STR); 
            $result->bindParam(':iUsu_Telefono', $iUsu_Telefono, PDO::PARAM_STR);
            $result->bindParam(':iUsu_InstitucionLaboral', $iUsu_InstitucionLaboral, PDO::PARAM_STR);
            $result->bindParam(':iUsu_Cargo', $iUsu_Cargo, PDO::PARAM_STR);
            $result->bindParam(':iUsu_Email', $iUsu_Email, PDO::PARAM_STR);
            $result->bindParam(':iUsu_IdUsuario', $iUsu_IdUsuario, PDO::PARAM_INT);
            
            $result->execute();
            return $result->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "editarUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }         
    }

    public function eliminarRol_usuario($usuarioID)
    {
        try{
            $per = $this->_db->query(
                " DELETE FROM usuario_rol WHERE Usu_IdUsuario = $usuarioID"
            );
            return $per->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "eliminarPermiso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    
    public function editarUsuarioClave($Usu_Password, $Usu_IdUsuario)
    {
        $Usu_Password = Hash::getHash('sha1', $Usu_Password, HASH_KEY);
        try {
            $result = $this->_db->query(
                            "update usuario set Usu_Password = '$Usu_Password' " .
                            "where Usu_IdUsuario = $Usu_IdUsuario "
                            );
            return $result->rowCount();
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(indexModel)", "editarUsuarioClave", "Error Model", $exception);
            return $exception->getTraceAsString();
        }            
    }
   
    public function cambiarEstadoUsuario($idUsuario, $estado)
    {
        if($estado==0)
        {
            $usuarios = $this->_db->query(
            "UPDATE usuario SET Usu_Estado = 1 where Usu_IdUsuario = $idUsuario"
            );
        }
        if($estado==1)
        {
            $usuarios = $this->_db->query(
            "UPDATE usuario SET Usu_Estado = 0 where Usu_IdUsuario = $idUsuario"
            );
        }
        if($estado==3)
        {
            $usuarios = $this->_db->query(
            "UPDATE usuario SET Usu_Estado = 1 where Usu_IdUsuario = $idUsuario"
            );
        }
        return $usuarios->rowCount(PDO::FETCH_ASSOC);
    }
    
    public function recuperarPass($idUsuario,$estadoLink)
    {        
        $usuarios = $this->_db->query(
        "UPDATE usuario SET Usu_RecuperarPass = $estadoLink where Usu_IdUsuario = $idUsuario"
        );
        return $usuarios->rowCount(PDO::FETCH_ASSOC);
    }

    public function getUsuario1($id, $codigo)
    {
        $usuario = $this->_db->query(
                "select * from usuario where Usu_IdUsuario = $id and Usu_Codigo = '$codigo'"
                );
        return $usuario->fetch();
    }
    
    public function insertarRol($iRol_role, $iIdi_IdIdioma="es", $iRol_Estado=1)
    {
        try {            
            $sql = "call s_i_rol(?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iRol_role, PDO::PARAM_STR);
            $result->bindParam(2, $iIdi_IdIdioma, PDO::PARAM_STR);
            $result->bindParam(3, $iRol_Estado, PDO::PARAM_INT);
            $result->execute();
            return $result->fetch();
        } catch (Exception $exc) {
            return $exc->getTraceAsString();
        }
    }

    public function insertarRol_Usuario($Usu_IdUsuario, $Rol_IdRol="")
    {
        try {            
            $sql = "INSERT INTO usuario_rol VALUES(:Usu_IdUsuario,:Rol_IdRol,1)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(':Usu_IdUsuario', $Usu_IdUsuario, PDO::PARAM_STR);
            $result->bindParam(':Rol_IdRol', $Rol_IdRol, PDO::PARAM_STR);
            $result->execute();
            return $result->rowCount(PDO::FETCH_ASSOC);
        } catch (Exception $exc) {
            return $exc->getTraceAsString();
        }
    }
    
    public function activarUsuario($id, $codigo)
    {
            $this->_db->query(
                            "update usuario set Usu_Estado = 1 " .
                            "where Usu_IdUsuario = $id and Usu_Codigo = '$codigo'"
                            );
    }
}

?>
