<?php
/*Modificado por Jhon Martinez*/
class ACL
{
    private $_registry;
    private $_db;
    private $_Usu_IdUsuario;
    private $_roles;
    private $_permisos;
    
    public function __construct($idUsuario = false)
    {
        if($idUsuario)
        {
            $this->_Usu_IdUsuario = (int) $idUsuario;
        }
        else
        {
            if(Session::get('id_usuario'))
            {
                $this->_Usu_IdUsuario = Session::get('id_usuario');
            }
            else
            {
                $this->_Usu_IdUsuario = 0;
            }
        }
                
        $this->_registry = Registry::getInstancia();
        $this->_db = $this->_registry->_db;
        $this->_roles = $this->getRolesUsuario();
        $this->_permisos = $this->getPermisosRoles();
        $this->compilarAcl();
    }
    
    public function compilarAcl()
    {
        $this->_permisos = array_merge($this->_permisos, $this->getPermisosUsuario());
        // print_r($this->_permisos);exit;
    }
    
    public function getRolesUsuario()
    { 
        try{
            $sql = "call s_s_listar_roles_x_id_usuario(?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $this->_Usu_IdUsuario, PDO::PARAM_INT);
            $result->execute();
            $roles = $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            // $this->registrarBitacora("acl(indexModel)", "getPermisos", "Error Model", $exception);
            $exception->getTraceAsString();
        }


        if(count($roles) > 0)
        {          
            // print_r($roles);
            return $roles;
        }
        else 
            return 0;                
    }
    
    public function getPermisosRoles()
    {    
        $data = array();
        $RolesArray = $this->_roles;
        // $pdo = $this->_db;

        if($RolesArray && count($RolesArray) > 0){
            for($i = 0; $i < count($RolesArray); $i++)
            {
                try{

                    // $permisosArray = $this->_db->query("select * from permisos_rol where Rol_IdRol = {$RolesArray[$i]['Rol_IdRol']}"
                    //         );   
                    // $permisosArray = $permisosArray->fetchAll(PDO::FETCH_ASSOC);

                    $sql = "call s_s_listar_permisos_rol_x_id_rol(?)";
                    $permisosArray = $this->_db->prepare($sql);
                    $permisosArray->bindParam(1, $RolesArray[$i]['Rol_IdRol'], PDO::PARAM_INT);
                    $permisosArray->execute();
                    $permisosArray = $permisosArray->fetchAll(PDO::FETCH_ASSOC);

                } catch (PDOException $exception) {
                    // $this->registrarBitacora("acl(indexModel)", "getPermisos", "Error Model", $exception);
                    $exception->getTraceAsString();
                }                
                // print_r($this->getPermisoKey($permisosArray[0]['Per_IdPermiso']));
                for($j = 0; $j < count($permisosArray); $j++)
                {
                    $key = $this->getPermisoKey($permisosArray[$j]['Per_IdPermiso']);
                    if($key == ''){continue;}
                    
                    if($permisosArray[$j]['Per_Valor'] == 1)
                    {
                        $v = true;
                    }
                    else
                    {
                        $v = false; 
                    }
                    
                    $data[$key] = array(
                        'key' => $key,
                        'permiso' => $this->getPermisoNombre($permisosArray[$j]['Per_IdPermiso']),
                        'rol' => $RolesArray[$i]['Rol_Nombre'],
                        'valor' => $v,
                        'heredado' => true,
                        'id' => $permisosArray[$j]['Per_IdPermiso']
                    );
                } 
            }
        }

        return $data;
    }

    public function getPermisosUsuario()
    {
        $data = array();

        try{
            $sql = " call s_s_listar_permisos_usuario_x_id_usuario(?) ";
            $permisosUsuarios = $this->_db->prepare($sql);
            $permisosUsuarios->bindParam(1, $this->_Usu_IdUsuario, PDO::PARAM_INT);
            $permisosUsuarios->execute();
            $permisosUsuarios = $permisosUsuarios->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            // $this->registrarBitacora("acl(indexModel)", "getPermisos", "Error Model", $exception);
            $exception->getTraceAsString();
        }

        for($i = 0; $i < count($permisosUsuarios); $i++)
        {
            $key = $this->getPermisoKey($permisosUsuarios[$i]['Per_IdPermiso']);
            if($key == '')
            {
                continue;
            }
            
            if($permisosUsuarios[$i]['Peu_Valor'] == 1)
            {
                $v = true;
            } else {
                $v = false;
            }
            
            $data[$key] = array(
                'key' => $key,
                'permiso' => $this->getPermisoNombre($permisosUsuarios[$i]['Per_IdPermiso']),
                'rol' => " - ",
                'valor' => $v,
                'heredado' => false,
                'id' => $permisosUsuarios[$i]['Per_IdPermiso']
            );
        }

        $idPermisos = $this->getPermisosRolesIds();

        if($idPermisos && count($idPermisos) > 0)
        {
            try{

                    $permisos = $this->_db->query(
                    " SELECT peu.*, r.Rol_Nombre FROM permisos_usuario peu " .
                    " INNER JOIN permisos_rol per ON peu.Per_IdPermiso = per.Per_IdPermiso " . 
                    " INNER JOIN rol r ON per.Rol_IdRol = r.Rol_IdRol " .
                    " WHERE peu.Usu_IdUsuario = {$this->_Usu_IdUsuario} " .
                    " AND peu.Per_IdPermiso IN (" . implode(",", $idPermisos) . ")"
                    );
                    $permisos = $permisos->fetchAll(PDO::FETCH_ASSOC);

            // try{
            //     $sql = " call s_s_listar_permisos_usuario_x_id_usuario(?,?) ";
            //     $idPermisos = implode(",", $idPermisos);
            //     echo($idPermisos);
            //     $result = $this->_db->prepare($sql);
            //     $result->bindParam(1, $this->_Usu_IdUsuario, PDO::PARAM_INT);
            //     $result->bindParam(2, $idPermisos, PDO::PARAM_STR);
            //     $result->execute();
            //     $permisos = $result->fetchAll(PDO::FETCH_ASSOC);
            } catch (PDOException $exception) {
                // $this->registrarBitacora("acl(indexModel)", "getPermisos", "Error Model", $exception);
                $exception->getTraceAsString();
            }

        }
        else
        {
            $permisos = array();
        }

        
        // print_r($permisos);exit;
        for($i = 0; $i < count($permisos); $i++)
        {
            $key = $this->getPermisoKey($permisos[$i]['Per_IdPermiso']);
            if($key == '')
            {
                continue;
            }
            
            if($permisos[$i]['Peu_Valor'] == 1)
            {
                $v = true;
            }
            else
            {
                $v = false;
            }
            
            $data[$key] = array(
                'key' => $key,
                'permiso' => $this->getPermisoNombre($permisos[$i]['Per_IdPermiso']),
                'rol' => $permisos[$i]['Rol_Nombre'],
                'valor' => $v,
                'heredado' => false,
                'id' => $permisos[$i]['Per_IdPermiso']
            );
        }

        return $data;
    }

    public function getPermisosRolesIds()
    {
        $idPermisosArray = array();
        $RolesArray = $this->_roles;

        if($RolesArray && count($RolesArray) > 0){
            for($i = 0; $i < count($RolesArray); $i++)
            {                
                try{
                    $sql = "call s_s_listar_ids_permisos_x_id_rol(?)";
                    $idPermisos = $this->_db->prepare($sql);
                    $idPermisos->bindParam(1, $RolesArray[$i]['Rol_IdRol'], PDO::PARAM_INT);
                    $idPermisos->execute();
                    $idPermisos = $idPermisos->fetchAll(PDO::FETCH_ASSOC);
                } catch (PDOException $exception) {
                    // $this->registrarBitacora("acl(indexModel)", "getPermisos", "Error Model", $exception);
                    $exception->getTraceAsString();
                }
                
                for($j = 0; $j < count($idPermisos); $j++){
                    $idPermisosArray[] = $idPermisos[$j]['Per_IdPermiso'];

                    
                }
            }
        }
        return $idPermisosArray;
    }   
    
    
    public function getPermisoKey($permisoID)
    {
        $permisoID = (int) $permisoID;
        // echo "///////////////".$permisoID."////////////////";
        // $key = $this->_db->query(
        //         "select Per_Ckey as `key` from permisos " .
        //         "where Per_IdPermiso = {$permisoID}"
        //         );
        // $key = $key->fetch();

        // $pdo = new PDO('mysql:host=' . DB_HOST .
        //         ';dbname=' . DB_NAME,
        //         DB_USER, 
        //         DB_PASS);
        // $pdo = $this->_db;
        try{                
                // $key = $this->_db->query(
                //         "select Per_Ckey as `key` from permisos " .
                //         "where Per_IdPermiso = {$permisoID}"
                //         );
                        
                // $key = $key->fetch();

                $sql = " call s_s_obtener_ckey_permiso_x_id(?) ";
                $key = $this->_db->prepare($sql);
                $key->bindParam(1, $permisoID, PDO::PARAM_INT);
                $key->execute();
                $key = $key->fetch(PDO::FETCH_ASSOC);

                // echo "x";
                // var_dump($key);
        } catch (PDOException $exception) {
            // $this->registrarBitacora("acl(indexModel)", "getPermisos", "Error Model", $exception);
            // var_dump($exception);
            $exception->getTraceAsString();
        }
            // print_r($key);
        
        // var_dump($key);
            // echo $key['key'];
        return $key['key'];
    }
    
    public function getPermisoNombre($permisoID)
    {
        $permisoID = (int) $permisoID;
        // $pdo = new PDO('mysql:host=' . DB_HOST .
        //         ';dbname=' . DB_NAME,
        //         DB_USER, 
        //         DB_PASS);
        try{
        
                // $key = $this->_db->query(
                //         "select Per_Nombre from permisos " .
                //         "where Per_IdPermiso = {$permisoID}"
                //         );
                        
                // $key = $key->fetch();

                $sql = "call s_s_obtener_nombre_permiso_x_id(?)";
                $_Per_Nombre = $this->_db->prepare($sql);
                $_Per_Nombre->bindParam(1, $permisoID, PDO::PARAM_INT);
                $_Per_Nombre->execute();
                $_Per_Nombre = $_Per_Nombre->fetch(PDO::FETCH_ASSOC);

            } catch (PDOException $exception) {
                // $this->registrarBitacora("acl(indexModel)", "getPermisos", "Error Model", $exception);
                $exception->getTraceAsString();
            }

        // return $key['Per_Nombre'];
        return $_Per_Nombre['Per_Nombre'];
    }

    public function getRolNombre($rolID)
    {
        $rolID = (int) $rolID;
        try{
                $sql = "call s_s_obtener_nombre_rol_x_id(?)";
                $_Rol_Nombre = $this->_db->prepare($sql);
                $_Rol_Nombre->bindParam(1, $permisoID, PDO::PARAM_INT);
                $_Rol_Nombre->execute();
                $_Rol_Nombre = $_Rol_Nombre->fetch(PDO::FETCH_ASSOC);
            } catch (PDOException $exception) {
                // $this->registrarBitacora("acl(indexModel)", "getPermisos", "Error Model", $exception);
                $exception->getTraceAsString();
            }

        return $_Rol_Nombre['Rol_Nombre'];
    }
    
    #creador por rcardenas
    public function getIdRol_x_ckey($iRol_Ckey)
    {       
        try{
                $rol = $this->_db->query(
                        "SELECT Rol_IdRol,Rol_Nombre FROM rol WHERE Rol_Ckey = '$iRol_Ckey'");
                return $rol->fetch();
            } catch (PDOException $exception) {
                $this->registrarBitacora("acl(indexModel)", "getIdRol_x_ckey", "Error Model", $exception);
                return $exception->getTraceAsString();
            }

        
    }
    


    //NUevo creado por Vigo 
    public function rol($iRol_IdRol) {
       if (is_array($this->_roles) || is_object($this->_roles)) {
           foreach ($this->_roles as $item_rol) {
               if ($item_rol["Rol_IdRol"] == $iRol_IdRol) {
                   return true;
               }
           }
       } else {
           return false;
       }
    }
    
        
    public function getPermisos()
    {
        if(isset($this->_permisos) && count($this->_permisos))
            // print_r($this->_permisos);exit;
            return $this->_permisos;
    }
    
    public function Usu_IdUsuario()
    {        
        return $this->_Usu_IdUsuario;
    }
    public function getAutenticado()
    {
        if(Session::get('autenticado'))
        {
            return true;
        } else{
            return false;
        }
    }

    public function permiso($key)
    {
        if(array_key_exists($key, $this->_permisos)){

            if($this->_permisos[$key]['valor'] == true || $this->_permisos[$key]['valor'] == 1)
            {
                return true;
            }
        }
        
        return false;
    }
    
    public function acceso($key)
    {   
        if($this->permiso($key))
        {
            Session::tiempo();
            return;
        }
        $url = str_replace("/","*",$this->_registry->_request->getUrl());
        //$url=$_SERVER['HTTP_REFERER'];    
//        if(isset($url)&&!empty($url))
//        {
//           $url="/"+$url;
//        }
//        else
//        {
//          $url="";  
//        }
        if(Session::get('autenticado'))
        {
           header("location:" . BASE_URL .Cookie::lenguaje()."/error/access/5050/$url");
            return;
        }else{
            header("location:" . BASE_URL . Cookie::lenguaje(). "/usuarios/login/index/$url");
        }
        exit;
    }
    public function autenticado()
    {
        if(Session::get('autenticado'))
        {
            Session::tiempo();
            return;
        }
        $url = str_replace("/","*",$this->_registry->_request->getUrl());
        //$url=$_SERVER['HTTP_REFERER'];
        //if(isset($url)&&!empty($url))
        //{
          //  $url="/"+$url;
        //}
        //else
        //{
         // $url="";  
        //}
        
        header("location:" . BASE_URL . "usuarios/login/index/$url");
        exit;
    }
}

?>
