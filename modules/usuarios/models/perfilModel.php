<?php

class perfilModel extends Model
{
    public function __construct()
    {
        parent::__construct();
    }    
    public function getUsuarioPass($idusuario, $password)
    {
        try{
            $datos = $this->_db->query(
                    "select * from usuario " .
                    "where Usu_IdUsuario = $idusuario " .
                    "and Usu_Password = '" . Hash::getHash('sha1', $password, HASH_KEY) ."'"
                    );
            return $datos->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(loginModel)", "getUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        } 
    }
    public function getUsuarios($condicion = '')
    {
        try{
            $usuarios = $this->_db->query(
                "select u.*,r.Rol_role from usuario u, rol r ".
                "where u.Rol_IdRol = r.Rol_IdRol $condicion"
            );
            if(!$condicion)
            {
                return $usuarios->fetchAll();
            }  else {
                return $usuarios->fetch();
            }
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(perfilModel)", "getUsuarios", "Error Model", $exception);
            return $exception->getTraceAsString();
        }        
    }
    
    public function getUsuario($usuarioID)
    {
        try{
            $usuarios = $this->_db->query(
                " SELECT u.* FROM usuario u  WHERE u.Usu_IdUsuario = $usuarioID"
            );
            return $usuarios->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("usuario(perfilModel)", "getUsuario", "Error Model", $exception);
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
    
    public function editarUsuarioPerfil($iUsu_Nombre, $iUsu_Apellidos, $iUsu_DocumentoIdentidad, $iUsu_Direccion, $iUsu_Telefono, $iUsu_InstitucionLaboral, $iUsu_Cargo, $iUsu_Usuario, $iUsu_Email, $iUsu_IdUsuario
           )
    {
            //$iUsu_Password = Hash::getHash('sha1', $iUsu_Password, HASH_KEY);
            try {            
                $sql = "call s_u_usuarioPerfil(?,?,?,?,?,?,?,?,?,?)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $iUsu_Nombre, PDO::PARAM_STR);
                $result->bindParam(2, $iUsu_Apellidos, PDO::PARAM_STR);
                $result->bindParam(3, $iUsu_DocumentoIdentidad, PDO::PARAM_STR);
                $result->bindParam(4, $iUsu_Direccion, PDO::PARAM_STR);
                $result->bindParam(5, $iUsu_Telefono, PDO::PARAM_STR);
                $result->bindParam(6, $iUsu_InstitucionLaboral, PDO::PARAM_STR);
                $result->bindParam(7, $iUsu_Cargo, PDO::PARAM_STR);
                $result->bindParam(8, $iUsu_Usuario, PDO::PARAM_STR);
                $result->bindParam(9, $iUsu_Email, PDO::PARAM_STR);
                $result->bindParam(10, $iUsu_IdUsuario, PDO::PARAM_INT);

                $result->execute();
                return $result->rowCount(PDO::FETCH_ASSOC);
            } catch (PDOException $exception) {
                $this->registrarBitacora("usuario(perfilModel)", "editarUsuario(1)", "Error Model", $exception);
                return $exception->getTraceAsString();
            }         
        
    }   
    // Jhon Martinez
      public function getMisCursos($Usu_IdUsuario = 0, $Busqueda = "")
      {
        try{
            $sql = "  SELECT cursi.*,COUNT(vc.Usu_IdUsuario) AS Valoraciones, CAST((CASE WHEN AVG(vc.Val_Valor) > 0 THEN AVG(vc.Val_Valor) ELSE    0 END) AS DECIMAL(2,1)) AS Valor FROM (
                  SELECT cr.Cur_IdCurso, cr.Cur_Estado, cr.Cur_UrlBanner, cr.Cur_Titulo, cr.Cur_Descripcion, cr.Usu_IdUsuario, cr.Cur_Vacantes, cr.Cur_FechaDesde, cr.Moa_IdModalidad, CONCAT(u.Usu_Nombre,' ',u.Usu_Apellidos) AS Docente, cc.Con_Descripcion AS Modalidad,
                    SUM(CASE WHEN mt.Mat_Valor = 1 THEN 1 ELSE 0 END) AS Matriculados, (CASE WHEN cu_m.Matriculado = 1 THEN 1 ELSE 0 END) AS Inscrito FROM 
                                  (SELECT cur.Cur_IdCurso, 1 AS Matriculado FROM curso cur
                                  INNER JOIN matricula_curso mat ON cur.Cur_IdCurso = mat.Cur_IdCurso
                                  WHERE cur.Cur_Estado = 1 AND cur.Row_Estado = 1 AND mat.Mat_Valor = 1 AND mat.Usu_IdUsuario = $Usu_IdUsuario ) cu_m
                              RIGHT JOIN curso cr ON cu_m.Cur_IdCurso = cr.Cur_IdCurso
                              INNER JOIN constante cc ON cr.Moa_IdModalidad = cc.Con_Valor AND cc.Con_Codigo = 1000
                              INNER JOIN usuario u ON cr.Usu_IdUsuario = u.Usu_IdUsuario 
                              LEFT JOIN matricula_curso mt ON cr.Cur_IdCurso = mt.Cur_IdCurso
                              WHERE cr.Row_Estado = 1 
                              GROUP BY cr.Cur_IdCurso )cursi
                  LEFT JOIN valoracion_curso vc ON cursi.Cur_IdCurso = vc.Cur_IdCurso 
                  WHERE (cursi.Inscrito = 1 OR cursi.Usu_IdUsuario = $Usu_IdUsuario) ";
            if( strlen($Busqueda) ){
              $sql .=" AND cursi.Cur_Titulo like '%" . $Busqueda . "%' OR cursi.Cur_Descripcion like '%{$Busqueda}%' ";
            }
            $sql .= " GROUP BY cursi.Cur_IdCurso ORDER BY cursi.Inscrito ";

            $result = $this->_db->query($sql);
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(_gestionCursoModel)", "getMisCursos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
      }
}

?>
