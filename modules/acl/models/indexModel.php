<?php

class indexModel extends Model
{
    public function __construct()
    {
        parent::__construct();
    }

    //-----------------------------*Presmisos*-----------------------------------------
    //Util_Permiso Jhon Martinez
    public function getPermisos($pagina = 1, $registrosXPagina = 1, $activos = 1)
    {
        try{
            $sql = "call s_s_listar_permisos_con_modulo(?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $pagina, PDO::PARAM_INT);
            $result->bindParam(2, $registrosXPagina, PDO::PARAM_INT);
            $result->bindParam(3, $activos, PDO::PARAM_INT);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getPermisos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    
    //Util_Permiso Jhon Martinez
    public function getPermisosRowCount($condicion = "")
    {
        try{
            $sql = " SELECT COUNT(p.Per_IdPermiso) AS CantidadRegistros FROM permisos p LEFT JOIN modulo m ON p.Mod_IdModulo = m.Mod_IdModulo  $condicion ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getPermisosRowCount", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Permiso Jhon Martinez
    public function getPermisosCondicion($pagina,$registrosXPagina,$condicion = "")
    {
        try{
            $registroInicio = 0;
            if ($pagina > 0) {
                $registroInicio = ($pagina - 1) * $registrosXPagina;                
            }
            $sql = " SELECT p.*, m.Mod_Nombre FROM permisos p
                LEFT JOIN modulo m ON p.Mod_IdModulo = m.Mod_IdModulo  $condicion 
                LIMIT $registroInicio, $registrosXPagina ";
            $result = $this->_db->query($sql);
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getPermisosCondicion", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Permiso Jhon Martinez
    public function cambiarEstadoPermisos($Per_IdPermiso, $Per_Estado)
    {
        try{
            if($Per_Estado==0)
            {

                $sql = "call s_u_cambiar_estado_permiso(?,1)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Per_IdPermiso, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);                
            }
            if($Per_Estado==1)
            {

                $sql = "call s_u_cambiar_estado_permiso(?,0)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Per_IdPermiso, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);
            }

        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "cambiarEstadoPermisos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Permiso Jhon Martinez
    public function editarPermiso($Per_IdPermiso, $Per_Nombre, $Per_Ckey, $Mod_IdModulo) {
        try{
            $permiso = $this->_db->query(
                " UPDATE permisos SET Per_Nombre = '$Per_Nombre', Per_Ckey = '$Per_Ckey', Mod_IdModulo = '$Mod_IdModulo' WHERE Per_IdPermiso = $Per_IdPermiso"
            );
            return $permiso->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "editarPermiso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Permiso Jhon Martinez
    public function getModulos(){
        try{
            $sql = "call s_s_listar_modulos()";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getModulos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Permiso Jhon Martinez
    public function verificarPermiso($permiso)
    {
        try{
            $permiso = $this->_db->query("SELECT * FROM permisos WHERE Per_Nombre = '$permiso'");
            return $permiso->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "verificarPermiso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Permiso_Rol Jhon Martinez
    public function verificarPermisoRol($Per_IdPermiso)
    {
        try{
            $permiso = $this->_db->query("SELECT * FROM permisos_rol WHERE Per_IdPermiso = '$Per_IdPermiso' and Per_Valor = 1");
            return $permiso->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "verificarPermisoRol", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Permiso_Usuario Jhon Martinez
    public function verificarPermisoUsuario($Per_IdPermiso)
    {
        try{
            $permiso = $this->_db->query("SELECT * FROM permisos_usuario WHERE Per_IdPermiso = '$Per_IdPermiso' and Peu_Valor = 1");
            return $permiso->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "verificarPermisoUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Permiso Jhon Martinez
    public function verificarKey($ckey)
    {
        try{
            $ckey = $this->_db->query(" SELECT * FROM permisos WHERE Per_Ckey = '$ckey' ");
            return $ckey->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "verificarKey", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Permiso_Rol Jhon Martinez
    public function verificarRol($Rol_Nombre)
    {
        try{
            $rol = $this->_db->query("SELECT * FROM rol WHERE Rol_Nombre = '$Rol_Nombre' ");
            return $rol->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "verificarRol", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Permiso Jhon Martinez
    public function eliminarHabilitarPermiso($Per_IdPermiso = 0,$Row_Estado = 0)
    {
        try{

            $permiso = $this->_db->query(
                " UPDATE permisos SET Row_Estado = $Row_Estado WHERE Per_IdPermiso = $Per_IdPermiso "               
                );
            return $permiso->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "eliminarHabilitarPermiso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    //Util_Permiso Jhon Martinez
    public function getPermisosRol($Rol_IdRol)
    {
        $data = array();
        try{
            $permisos = $this->_db->query(
                    " SELECT * FROM permisos_rol WHERE Rol_IdRol = {$Rol_IdRol} "
                    );

            $permisos = $permisos->fetchAll(PDO::FETCH_ASSOC);

            for($i = 0; $i < count($permisos); $i++){
                $key = $this->getPermisoKey($permisos[$i]['Per_IdPermiso']);

                if($key == ''){continue;}
                if($permisos[$i]['Per_Valor'] == 1){
                    $v = true;
                }
                else{
                    $v = false;
                }

                $data[$key] = array(
                    'key' => $key,
                    'valor' => $v,
                    'nombre' => $this->getPermisoNombre($permisos[$i]['Per_IdPermiso']),
                    'id' => $permisos[$i]['Per_IdPermiso']
                );
            }

            $todos = $this->getPermisosAll();
            $data = array_merge($todos, $data);
        
            return $data;
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getPermisosRol", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    //Util_Permiso Jhon Martinez
    public function getPermisoNombre($Per_IdPermiso)
    {
        $Per_IdPermiso = (int) $Per_IdPermiso;
        try{
            $key = $this->_db->query(
                    " SELECT Per_Nombre FROM permisos WHERE Per_IdPermiso = $Per_IdPermiso "
                    );

            $key = $key->fetch();
            return $key['Per_Nombre'];
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getPermisoNombre", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Permiso Jhon Martinez
    public function insertarPermiso($iPer_Nombre = "", $iPer_Ckey = "", $iMod_Modulo = "", $iIdi_IdIdioma="")
    {
        // echo " iPer_Nombre:" . $iPer_Nombre ." iPer_Ckey:". $iPer_Ckey . "iMod_Modulo:" . $iMod_Modulo . "iIdi_IdIdioma:" . $iIdi_IdIdioma;
        try {             
            $sql = "call s_i_permisos(?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iPer_Nombre, PDO::PARAM_STR);
            $result->bindParam(2, $iPer_Ckey, PDO::PARAM_STR);
            $result->bindParam(3, $iMod_Modulo,  PDO::PARAM_INT);            
            $result->bindParam(4, $iIdi_IdIdioma,  PDO::PARAM_STR);
           
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "insertarPermiso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    //Util_Permiso_Rol Jhon Martinez
    // public function eliminarPermisosRol($permisoID)
    // {
    //     try{
    //         $permiso = $this->_db->query(
    //             " UPDATE permisos_rol SET Rol_Valor = 0  WHERE Per_IdPermiso = {$permisoID} "
    //             );
    //         return $permiso->rowCount(PDO::FETCH_ASSOC);
    //     } catch (PDOException $exception) {
    //         $this->registrarBitacora("acl(indexModel)", "eliminarPermisosRol", "Error Model", $exception);
    //         return $exception->getTraceAsString();
    //     }
    // }


    /*----------------------------------------*Roles*------------------------------------*/    

    //Util_Rol Jhon Martinez
    public function getRolesCompleto( $condicion = "")
    {
        try{
            $permiso = $this->_db->query(
                " SELECT r.* FROM rol r $condicion "               
                );
            $permiso->execute();
            return $permiso->fetchAll(PDO::FETCH_ASSOC);

            // $sql = "call s_s_listar_roles_completo()";
            // $result = $this->_db->prepare($sql);
            // $result->execute();
            // return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getRolesCompleto", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function getRolesPaginado($pagina = 1, $registrosXPagina = 1, $activos = 1)
    {        
        try{
            $sql = "call s_s_listar_roles_con_modulo(?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $pagina, PDO::PARAM_INT);
            $result->bindParam(2, $registrosXPagina, PDO::PARAM_INT);
            $result->bindParam(3, $activos, PDO::PARAM_INT);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getRolesPaginado", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Rol Jhon Martinez
    public function getRolesRowCount($condicion = "")
    {
        try{
            $sql = " SELECT COUNT(r.Rol_IdRol) AS CantidadRegistros FROM rol r 
                    LEFT JOIN modulo m ON r.Mod_IdModulo = m.Mod_IdModulo  $condicion ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getRolesRowCount", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Rol Jhon Martinez
    public function getRolesCondicion($pagina, $registrosXPagina, $condicion = "")
    {
        try{
            $registroInicio = 0;
            if ($pagina > 0) {
                $registroInicio = ($pagina - 1) * $registrosXPagina;                
            }
            $sql = " SELECT r.*, m.Mod_Nombre FROM rol r
                LEFT JOIN modulo m ON r.Mod_IdModulo = m.Mod_IdModulo  $condicion 
                LIMIT $registroInicio, $registrosXPagina ";
            $result = $this->_db->query($sql);
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getRolesCondicion", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Rol Jhon Martinez
    public function cambiarEstadoRol($Rol_IdRol, $Rol_Estado)
    {
        try{
            if($Rol_Estado==0)
            {
                $sql = "call s_u_cambiar_estado_rol(?,1)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Rol_IdRol, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);                
            }
            if($Rol_Estado==1)
            {
                $sql = "call s_u_cambiar_estado_rol(?,0)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Rol_IdRol, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);
            }
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "cambiarEstadoRol", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Rol Jhon Martinez
    public function editarRol($Rol_IdRol, $Rol_Nombre,$iRol_Ckey,$iMod_IdModulo) {
        try{
            $sql = "call s_u_cambiar_nombre_rol(?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $Rol_IdRol, PDO::PARAM_INT);
            $result->bindParam(2, $Rol_Nombre, PDO::PARAM_STR);
            $result->bindParam(3, $iRol_Ckey, PDO::PARAM_STR);
            $result->bindParam(4, $iMod_IdModulo, PDO::PARAM_STR);
            $result->execute();

            return $result->rowCount(PDO::FETCH_ASSOC);  
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "editarRol", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Rol Jhon Martinez
    public function eliminarPermisoRol($Rol_IdRol = 0, $Per_IdPermiso = 0)
    {
        try{
            $sql = "call s_d_eliminar_permisos_rol(?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $Rol_IdRol, PDO::PARAM_INT);
            $result->bindParam(2, $Per_IdPermiso, PDO::PARAM_INT);
            $result->execute();
            // return $result->rowCount(PDO::FETCH_ASSOC);  
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "eliminarPermisoRol", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Rol Jhon Martinez
    public function editarPermisoRol($Rol_IdRol = 0, $Per_IdPermiso = 0, $valor = 0)
    {
        // echo $Rol_IdRol.$Per_IdPermiso.$valor; 
        try{
            $sql = "call s_u_reemplazar_todo_permisos_rol(?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $Rol_IdRol, PDO::PARAM_INT);
            $result->bindParam(2, $Per_IdPermiso, PDO::PARAM_INT);
            $result->bindParam(3, $valor, PDO::PARAM_INT);
            $result->execute();
            // return $result->rowCount(PDO::FETCH_ASSOC);  
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "editarPermisoRol", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Rol Jhon Martinez
    public function eliminarHabilitarRol($iRol_IdRol = 0, $iRow_Estado = 0)
    {
        try{
            $sql = "call s_u_habilitar_deshabilitar_rol(?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iRol_IdRol, PDO::PARAM_INT);
            $result->bindParam(2, $iRow_Estado, PDO::PARAM_INT);
            $result->execute();
            
            return $result->rowCount(PDO::FETCH_ASSOC); 

        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "eliminarHabilitarRol", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Rol Jhon Martinez
    public function getUsuarioRol($Rol_IdRol) {
        try{
            $roles = $this->_db->query(" SELECT ur.* FROM ( SELECT DISTINCT(Rol_IdRol) FROM usuario_rol ) ur WHERE ur.Rol_IdRol = $Rol_IdRol ");        
            return $roles->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getUsuarioRol", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Util_Rol Jhon Martinez
    public function getRol($Rol_IdRol)
    {
        try{
            $Rol_IdRol = (int) $Rol_IdRol;        
            $rol = $this->_db->query(" SELECT * FROM rol WHERE Rol_IdRol = {$Rol_IdRol}");
            return $rol->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getRol", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    



    public function getRolTraducido($Rol_IdRol,$Idi_IdIdioma)
    {
        try{
            $Rol_IdRol = (int) $Rol_IdRol;        
            $role = $this->_db->query(
                    "SELECT "
                    . "Rol_IdRol,"
                    . "fn_TraducirContenido('rol','Rol_Nombre',Rol_IdRol,'$Idi_IdIdioma',Rol_Nombre) Rol_Nombre,"
                    . "fn_devolverIdioma('rol',Rol_IdRol,'$Idi_IdIdioma',Idi_IdIdioma) Idi_IdIdioma"
                    . " FROM rol WHERE Rol_IdRol = {$Rol_IdRol}");
            return $role->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getRolTraducido", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    
    
    public function editarTraduccion($Rol_IdRol, $Rol_Nombre, $Idi_IdIdioma) {

        $ContTradNombre = $this->buscarCampoTraducido('rol', $Rol_IdRol, 'Rol_Nombre', $Idi_IdIdioma);
       
        $idContTradNombre = $ContTradNombre['Cot_IdContenidoTraducido'];
        
        if (isset($idContTradNombre)) {
            try{
                $rol = $this->_db->query(
                    "UPDATE contenido_traducido SET Cot_Traduccion = '$Rol_Nombre' WHERE Cot_IdContenidoTraducido = $idContTradNombre"
                );
                return $rol->rowCount();
            } catch (PDOException $exception) {
                $this->registrarBitacora("acl(indexModel)", "editarTraduccion", "Error Model", $exception);
                return $exception->getTraceAsString();
            }
        } else {
            try{
                $rol = $this->_db->prepare(
                        "INSERT INTO contenido_traducido VALUES (null, 'rol', :Cot_IdRegistro, 'Rol_Nombre' , :Idi_IdIdioma, :Cot_Traduccion)"
                    )
                    ->execute(array(
                        ':Cot_IdRegistro' => $Rol_IdRol,
                        ':Idi_IdIdioma' => $Idi_IdIdioma,
                        ':Cot_Traduccion' => $Rol_Nombre
                ));
                return $rol->rowCount();
            } catch (PDOException $exception) {
                $this->registrarBitacora("acl(indexModel)", "editarTraduccion", "Error Model", $exception);
                return $exception->getTraceAsString();
            }            
        }
    }
    
    public function buscarCampoTraducido($tabla, $Rol_IdRol, $columna, $Idi_IdIdioma) {
        try{
            $post = $this->_db->query(
                    "SELECT * FROM contenido_traducido WHERE Cot_Tabla = '$tabla' AND Cot_IdRegistro =  $Rol_IdRol AND  Cot_Columna = '$columna' AND Idi_IdIdioma= '$Idi_IdIdioma'");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "buscarCampoTraducido", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    
    public function getPermisosUsuario()
    {
        try{
            $permisos = $this->_db->query(" SELECT * FROM permisos_usuario ");        
            return $permisos->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getPermisosUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    


    public function getPermiso($Per_IdPermiso)
    {
        try{
            $Per_IdPermiso = (int) $Per_IdPermiso;
            $key = $this->_db->query(
                    "SELECT * FROM permisos WHERE Per_IdPermiso = $Per_IdPermiso"
                    );
            return $key->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getPermiso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function getPermisoKey($Per_IdPermiso)
    {
        $Per_IdPermiso = (int) $Per_IdPermiso;
        try{
            $key = $this->_db->query(
                    "SELECT Per_Ckey as 'key' FROM permisos WHERE Per_IdPermiso = $Per_IdPermiso"
                    );

            $key = $key->fetch();
            return $key['key'];
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getPermisoKey", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    
    
    public function getPermisosAll()
    {
        try{
            $permisos = $this->_db->query(
                    "SELECT * FROM permisos"
                    );

            $permisos = $permisos->fetchAll(PDO::FETCH_ASSOC);

            for($i = 0; $i < count($permisos); $i++){
                $data[$permisos[$i]['Per_Ckey']] = array(
                    'key' => $permisos[$i]['Per_Ckey'],
                    'valor' => 'x',
                    'nombre' => $permisos[$i]['Per_Nombre'],
                    'id' => $permisos[$i]['Per_IdPermiso']
                );
            }

            return $data;
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getPermisosAll", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    
    public function insertarRol($iRol_Nombre,$iRol_Ckey,$iMod_IdModulo, $iIdi_IdIdioma="", $iRol_Estado=1)
    {
        try {            
            $sql = "call s_i_rol(?,?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iRol_Nombre, PDO::PARAM_STR);
            $result->bindParam(2, $iRol_Ckey, PDO::PARAM_STR);
            $result->bindParam(3, $iMod_IdModulo, PDO::PARAM_STR);
            $result->bindParam(4, $iIdi_IdIdioma, PDO::PARAM_STR);
            $result->bindParam(5, $iRol_Estado, PDO::PARAM_INT);
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "insertarRol", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    


    public function eliminarPermisosUsuario($permisoID)
    {
        try{
            $permiso = $this->_db->query(
                "DELETE FROM permisos_usuario " . 
                "WHERE Per_IdPermiso = {$permisoID} " .
                "AND Usu_Valor = 0 "               
                );
            return $permiso->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "eliminarPermisosUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function eliminarRole($roleID)
    {
        try{
            $this->_db->query(
                " DELETE FROM rol WHERE Rol_IdRol = $roleID "               
                );
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "eliminarRole", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }    
    
    public function getIdiomas() {
        try {
            $idiomas = $this->_db->query("
            SELECT 
            *,
            fn_TraducirContenido('idioma','Idi_Idioma',idioma.Idi_CharCode,'".self::getCurrentLang()."',idioma.Idi_Idioma)  Idi_Idioma
            FROM idioma");
            return $idiomas->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getIdiomas", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function getModulosAll($pagina = 1, $registrosXPagina = 1, $activos = 1)
    {
        try{
            $sql = "call s_s_listar_modulos_All(?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $pagina, PDO::PARAM_INT);
            $result->bindParam(2, $registrosXPagina, PDO::PARAM_INT);
            $result->bindParam(3, $activos, PDO::PARAM_INT);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getModulosAll", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function getModulosRowCount($condicion = "")
    {
        try{
            $sql = " SELECT COUNT(Mod_IdModulo) AS CantidadRegistros FROM modulo $condicion ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getModulosRowCount", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function getModulosCondicion($pagina,$registrosXPagina,$condicion = "")
    {
        try{
            $registroInicio = 0;
            if ($pagina > 0) {
                $registroInicio = ($pagina - 1) * $registrosXPagina;                
            }
            $sql = " SELECT * FROM modulo m $condicion 
                LIMIT $registroInicio, $registrosXPagina ";
            $result = $this->_db->query($sql);
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getModulosCondicion", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function verificarModulo($modulo)
    {
        try{
            $permiso = $this->_db->query("SELECT * FROM modulo WHERE Mod_Nombre = '$modulo'");
            return $permiso->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "verificarModulo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function insertarModulo($Mod_Nombre = "", $Mod_Codigo = "", $Mod_Descripcion = "",$Mod_Estado=1)
    {
        try{
            $sql = "call s_i_modulos(?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $Mod_Nombre, PDO::PARAM_STR);
            $result->bindParam(2, $Mod_Codigo, PDO::PARAM_STR);
            $result->bindParam(3, $Mod_Descripcion, PDO::PARAM_STR);
            $result->bindParam(4, $Mod_Estado, PDO::PARAM_INT);
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "insertarModulo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    //Util_Permiso Jhon Martinez
    public function cambiarEstadomodulos($Mod_IdModulo, $Mod_Estado)
    {
        try{
            if($Mod_Estado==0)
            {

                $sql = "call s_u_cambiar_estado_modulo(?,1)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Mod_IdModulo, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);                
            }
            if($Mod_Estado==1)
            {

                $sql = "call s_u_cambiar_estado_modulo(?,0)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Mod_IdModulo, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);
            }

        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "cambiarEstadomodulos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

     public function getModulo($Mod_IdModulo)
    {
        try{
            $Mod_IdModulo = (int) $Mod_IdModulo;
            $key = $this->_db->query(
                    "SELECT * FROM modulo WHERE Mod_IdModulo = $Mod_IdModulo"
                    );
            return $key->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "getModulo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


     public function editarModulo($Mod_Nombre = "", $Mod_Codigo = "", $Mod_Descripcion = "", $Mod_IdModulo) {
        try{
            $permiso = $this->_db->query(
                " UPDATE modulo SET Mod_Nombre = '$Mod_Nombre', Mod_Codigo = '$Mod_Codigo', Mod_Descripcion = '$Mod_Descripcion' WHERE Mod_IdModulo = $Mod_IdModulo"
            );
            return $permiso->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "editarModulo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function verificarmoduloPermiso($Mod_IdModulo)
    {
        try{
            $permiso = $this->_db->query("SELECT * FROM permisos WHERE Mod_IdModulo = $Mod_IdModulo");
            return $permiso->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "verificarmoduloPermiso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function verificarmoduloRol($Mod_IdModulo)
    {
        try{
            $permiso = $this->_db->query("SELECT * FROM rol WHERE Mod_IdModulo = $Mod_IdModulo");
            return $permiso->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "verificarmoduloRol", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function eliminarHabilitarModulo($iMod_IdModulo = 0, $iRow_Estado = 0)
    {
        try{
            $sql = "call s_u_habilitar_deshabilitar_modulo(?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iMod_IdModulo, PDO::PARAM_INT);
            $result->bindParam(2, $iRow_Estado, PDO::PARAM_INT);
            $result->execute();
            
            return $result->rowCount(PDO::FETCH_ASSOC); 

        } catch (PDOException $exception) {
            $this->registrarBitacora("acl(indexModel)", "eliminarHabilitarRol", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
}

?>
