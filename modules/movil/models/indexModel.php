<?php
class indexModel extends Model {
    public function __construct() {
        parent::__construct();
    }    
    public function getCertificados($Usu_IdUsuario){
        try{             
            $sql = $this->_db->query(
                "SELECT v.Cer_Codigo,  c.Cur_Titulo FROM certificado_curso v 
                INNER JOIN usuario u ON u.Usu_IdUsuario = v.Usu_IdUsuario
                INNER JOIN curso c ON c.Cur_IdCurso = v.Cur_IdCurso WHERE u.Usu_IdUsuario=$Usu_IdUsuario"
            );  
        } catch (PDOException $exception) {
           $this->registrarBitacora("acl(indexModel)", "getCertificados", "Error Model", $exception);
        }
    }
    public function getContenidoLeccion($Lec_IdLeccion){
        $sql = $this->_db->query(
                "SELECT CL_Descripcion  FROM contenido_leccion WHERE Lec_IdLeccion=$Lec_IdLeccion"
        );              
        return $sql->fetchAll();
    }   
    public function getCursos($Usu_IdUsuario,$Con_Descripcion,$Cur_Titulo){      
        $sql = $this->_db->query(
            "SELECT cur.Cur_IdCurso,cur.Cur_UrlBanner,cur.Cur_Titulo, CC.Con_Descripcion as Modalidad,
            (CASE WHEN  mat.Usu_IdUsuario=$Usu_IdUsuario THEN 1 ELSE 0 END) AS Inscrito,AVG(val.Val_Valor) as Valoracion
            FROM curso cur
            INNER JOIN constante CC ON CC.Con_Valor = cur.Moa_IdModalidad AND CC.Con_Codigo = 1000
            INNER JOIN matricula_curso mat ON cur.Cur_IdCurso=mat.Cur_IdCurso
            INNER JOIN valoracion_curso val oN cur.Cur_IdCurso=val.Cur_IdCurso
            WHERE cur.Cur_Estado = 1 AND cur.Row_Estado = 1 AND mat.Usu_IdUsuario=$Usu_IdUsuario     
            AND CC.Con_Descripcion LIKE '%$Con_Descripcion%' AND cur.Cur_Titulo LIKE '%$Cur_Titulo%'
            GROUP BY val.Cur_IdCurso
            UNION
            SELECT cur.Cur_IdCurso,cur.Cur_UrlBanner,cur.Cur_Titulo, CC.Con_Descripcion as Modalidad,0 AS Inscrito,AVG(val.Val_Valor) as Valoracion
            FROM curso cur
            INNER JOIN constante CC ON CC.Con_Valor = cur.Moa_IdModalidad AND CC.Con_Codigo = 1000
            INNER JOIN valoracion_curso val ON cur.Cur_IdCurso=val.Cur_IdCurso
            WHERE cur.Cur_Estado = 1 AND cur.Row_Estado = 1 and cur.Cur_IdCurso NOT IN(SELECT cur.Cur_IdCurso
            FROM curso cur
            INNER JOIN constante CC ON CC.Con_Valor = cur.Moa_IdModalidad AND CC.Con_Codigo = 1000
            INNER JOIN matricula_curso mat ON cur.Cur_IdCurso=mat.Cur_IdCurso
            WHERE cur.Cur_Estado = 1 AND cur.Row_Estado = 1 AND mat.Usu_IdUsuario=$Usu_IdUsuario)
            AND CC.Con_Descripcion LIKE '%$Con_Descripcion%' AND cur.Cur_Titulo LIKE '%$Cur_Titulo%'
            GROUP BY val.Cur_IdCurso
            "
        );            
        return $sql->fetchAll();
    }    
    public function getCursosPaginado($pagina = 1, $registrosXPagina = 10, $condicionActivos = "", $Usu_IdUsuario = false){
        $registroInicio = 0;
        if ($pagina > 0) {
            $registroInicio = ($pagina - 1) * $registrosXPagina;               
        }
        if ($Usu_IdUsuario) {
            $andUsuario = " AND mat.Usu_IdUsuario = " . $Usu_IdUsuario;
        } else {
            $andUsuario = " AND mat.Usu_IdUsuario = 0 ";
        }
        try{
            $sql = " SELECT cur_so.*, COUNT(vc.Usu_IdUsuario) AS Valoraciones, 
                    CAST((CASE WHEN AVG(vc.Val_Valor) > 0 THEN AVG(vc.Val_Valor) ELSE 0 END) AS DECIMAL(2,1)) AS Valor FROM 
                    (SELECT cr.Cur_IdCurso, IFNULL(cr.Cur_UrlBanner,'default.jpg') AS Cur_UrlBanner, cr.Cur_Titulo, cr.Cur_Descripcion, cr.Usu_IdUsuario, cr.Cur_Vacantes, cr.Cur_FechaDesde, cr.Moa_IdModalidad, CONCAT(u.Usu_Nombre,' ',u.Usu_Apellidos) AS Docente, cc.Con_Descripcion AS Modalidad, SUM(CASE WHEN mt.Mat_Valor = 1 THEN 1 ELSE 0 END) AS Matriculados, (CASE WHEN cu_m.Matriculado = 1 THEN 1 ELSE 0 END) AS Inscrito FROM 
                            ( SELECT cur.Cur_IdCurso, 1 AS Matriculado FROM curso cur
                              INNER JOIN matricula_curso mat ON cur.Cur_IdCurso = mat.Cur_IdCurso
                              WHERE cur.Cur_Estado = 1 AND cur.Row_Estado = 1 AND mat.Mat_Valor = 1 $andUsuario ) cu_m 
                        RIGHT JOIN curso cr ON cu_m.Cur_IdCurso = cr.Cur_IdCurso
                        LEFT JOIN matricula_curso mt ON cr.Cur_IdCurso = mt.Cur_IdCurso
                        INNER JOIN constante cc ON cr.Moa_IdModalidad = cc.Con_Valor AND cc.Con_Codigo = 1000
                        INNER JOIN usuario u ON cr.Usu_IdUsuario = u.Usu_IdUsuario $condicionActivos ) cur_so 
                    LEFT JOIN valoracion_curso vc ON cur_so.Cur_IdCurso = vc.Cur_IdCurso 
                    GROUP BY cur_so.Cur_IdCurso 
                    LIMIT $registroInicio, $registrosXPagina " ;

            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(cursoModel)", "getCursosPaginado", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function getCursosDocente($Usu_IdUsuario,$Cur_IdCurso){          
        $sql = $this->_db->query(
            "SELECT Cur_Titulo FROM curso WHERE Cur_Estado = 1 AND Row_Estado = 1 AND Usu_IdUsuario = $Usu_IdUsuario AND
            Cur_IdCurso NOT IN($Cur_IdCurso)"
        );              
        return $sql->fetchAll();
    } 
    public function getCursosUsuario($Usu_IdUsuario,$Con_Descripcion,$Cur_Titulo){
        $sql = $this->_db->query(
                "SELECT (CASE WHEN Y.Lecciones = Y.Completos THEN 1 ELSE 0 END) as Completo,
                ROUND((Y.Completos*100/Y.Lecciones),1) as Porcentaje,Y.Cur_IdCurso,Y.Moa_IdModalidad,Y.Cur_UrlBanner,Y.Cur_Titulo,Y.Cur_Descripcion,Y.Con_Descripcion as Modalidad  FROM
               (SELECT  COUNT(CASE WHEN PC1.Pro_IdProgreso IS NULL THEN 0 ELSE PC1.Pro_Valor END) AS Lecciones,SUM(CASE WHEN PC1.Pro_IdProgreso IS NULL THEN 0 ELSE PC1.Pro_Valor END) as Completos,cur.Cur_IdCurso,cur.Moa_IdModalidad,cur.Cur_UrlBanner,cur.Cur_Titulo,cur.Cur_Descripcion,CC.Con_Descripcion
                  FROM leccion L1
                LEFT JOIN progreso_curso PC1 ON PC1.Lec_IdLeccion = L1.Lec_IdLeccion
                  AND PC1.Usu_IdUsuario = $Usu_IdUsuario
                INNER JOIN modulo_curso MC ON L1.Moc_IdModuloCurso = MC.Moc_IdModuloCurso
                inner join curso cur ON MC.Cur_IdCurso=cur.Cur_IdCurso
                INNER JOIN constante CC ON CC.Con_Valor=cur.Moa_IdModalidad AND CC.Con_Codigo=1000
                INNER JOIN matricula_curso mat ON cur.Cur_IdCurso = mat.Cur_IdCurso
                WHERE cur.Cur_Estado=1 AND cur.Row_Estado=1 AND
                L1.Lec_Estado = 1 AND L1.Row_Estado = 1
                AND MC.Moc_Estado = 1 AND MC.Row_Estado = 1 AND mat.Mat_Valor = 1 AND  mat.Usu_IdUsuario=$Usu_IdUsuario
                AND CC.Con_Descripcion LIKE '%$Con_Descripcion%' AND cur.Cur_Titulo LIKE '%$Cur_Titulo%'
                GROUP by MC.Cur_IdCurso
            )Y "
        );              
        return $sql->fetchAll();
    }
    public function getCursoDetalle($Cur_IdCurso){          
        $sql = $this->_db->query(
            "SELECT cur.Cur_Titulo,cur.Cur_Descripcion,cur.Cur_PublicoObjetivo,cur.Cur_ObjetivoGeneral,cur.Cur_Metodologia,cur.Cur_Contacto,cur.Cur_UrlImgPresentacion,cur.Cur_UrlVideoPresentacion, COUNT(DISTINCT mac.Mat_IdMatricula) AS NMatriculados, COUNT(DISTINCT lec.Lec_IdLeccion) AS NLecciones, CAST((CASE WHEN AVG(val.Val_Valor) > 0 THEN AVG(val.Val_Valor) ELSE 0 END) AS DECIMAL(2,1)) AS Valoracion  FROM 
            curso cur LEFT JOIN matricula_curso mac ON cur.Cur_IdCurso=mac.Cur_IdCurso INNER JOIN modulo_curso moc ON cur.Cur_IdCurso=moc.Cur_IdCurso 
            INNER JOIN leccion lec ON moc.Moc_IdModuloCurso=lec.Moc_IdModuloCurso LEFT JOIN valoracion_curso val ON cur.Cur_IdCurso=val.Cur_IdCurso
            WHERE cur.Cur_Estado=1 AND cur.Row_Estado AND lec.Lec_Estado=1 AND lec.Row_Estado =1 
            AND cur.Cur_IdCurso=$Cur_IdCurso GROUP BY cur.Cur_IdCurso,val.Cur_IdCurso"
        );              
        return $sql->fetchAll();
    } 
    public function getDocenteCurso($Usu_IdUsuario){          
        $sql = $this->_db->query(
            "SELECT Usu_IdUsuario,Usu_Nombre,Usu_Apellidos,Usu_URLImage,Usu_GradoAcademico,Usu_Especialidad,Usu_Perfil,Usu_InstitucionLaboral,Usu_Cargo FROM usuario WHERE Usu_Estado = 1 AND Row_Estado = 1
              AND Usu_IdUsuario = (SELECT Usu_IdUsuario FROM curso WHERE Cur_IdCurso = $Usu_IdUsuario AND Row_Estado = 1 AND Cur_Estado = 1)"
        );              
        return $sql->fetchAll();
    } 
    public function getForos() {
        $sql = $this->_db->query(
                "SELECT f.*,(SELECT COUNT(Com_IdComentario) FROM comentarios c WHERE c.For_IdForo=f.For_IdForo) as For_TComentarios  FROM foro f WHERE f.For_Funcion LIKE '%forum%' AND Row_Estado=1 ORDER BY f.For_FechaCreacion DESC"
        );              
        return $sql->fetchAll();        
    }
    public function getHora_Servidor() {
        try {
            $sql = $this->_db->query(
                    "SELECT NOW() AS hora_servidor");
            return $sql->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("movil(indexModel)", "getHora_Servidor", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function getInscripcion($Usu_IdUsuario, $Cur_IdCurso){
        return $this->getArray("SELECT * FROM matricula_curso
          WHERE Usu_IdUsuario = $Usu_IdUsuario
            AND Cur_IdCurso = $Cur_IdCurso ");
    }
    
    public function getLecciones($Moc_IdModuloCurso,$Usu_IdUsuario){
        $sql = $this->_db->query(
                "SELECT lec.Lec_IdLeccion,lec.Lec_Titulo,lec.Lec_Tipo,col.CL_Descripcion,(CASE WHEN prc.Pro_IdProgreso IS NULL THEN 0  ELSE prc.Pro_Valor END) as Completo
                 FROM leccion lec LEFT JOIN progreso_curso prc ON lec.Lec_IdLeccion=prc.Lec_IdLeccion
                 LEFT JOIN contenido_leccion col ON lec.Lec_IdLeccion=col.Lec_IdLeccion
                WHERE Moc_IdModuloCurso=$Moc_IdModuloCurso
                AND lec.Lec_Estado=1 AND lec.Row_Estado=1 AND prc.Usu_IdUsuario=$Usu_IdUsuario"
        );              
        return $sql->fetchAll();
    }
    public function getMateriales($Lec_IdLeccion){
        $sql = $this->_db->query(
                "SELECT Mat_Enlace FROM material_leccion WHERE Lec_IdLeccion=$Lec_IdLeccion AND Mat_Estado=1 AND Row_Estado=1"
        );              
        return $sql->fetchAll();
    }
    public function getModulos($Cur_IdCurso,$Usu_IdUsuario){
        $sql = $this->_db->query(
                "SELECT Y.Moc_IdModuloCurso, Y.Moc_Titulo,(CASE WHEN Y.Lecciones = Y.Completos THEN 1 ELSE 0 END) as Completo,
                ROUND((Y.Completos*100/Y.Lecciones),1) as Porcentaje FROM
              (SELECT moc.Moc_IdModuloCurso,moc.Moc_Titulo,COUNT(CASE WHEN PC1.Pro_IdProgreso IS NULL THEN 0 ELSE PC1.Pro_Valor END) as Lecciones, 
              SUM(CASE WHEN PC1.Pro_IdProgreso IS NULL THEN 0  ELSE PC1.Pro_Valor END) as Completos FROM leccion L1
                LEFT JOIN progreso_curso PC1 ON PC1.Lec_IdLeccion = L1.Lec_IdLeccion AND PC1.Usu_IdUsuario = $Usu_IdUsuario
                INNER JOIN modulo_curso moc ON moc.Moc_IdModuloCurso=L1.Moc_IdModuloCurso
                WHERE  L1.Lec_Estado = 1 AND L1.Row_Estado = 1 AND moc.Cur_IdCurso=$Cur_IdCurso
              GROUP BY L1.Moc_IdModuloCurso)Y"
        );              
        return $sql->fetchAll();
    }
    public function getUsuarioPorEmail($Usu_Email){        
        $sql = $this->_db->query(
                "SELECT * FROM usuario WHERE  Usu_Email='$Usu_Email'"
        );              
        return $sql->fetchAll();                
    }
    public function getUsuarioPorId($Usu_IdUsuario){        
        $sql = $this->_db->query(
                "SELECT * FROM usuario WHERE  Usu_IdUsuario=$Usu_IdUsuario"
        );              
        return $sql->fetchAll();                
    } 
    public function getUsuarioExistente($Usu_Usuario,$Usu_Email){        
        $sql = $this->_db->query(
                "SELECT * FROM usuario WHERE  Usu_Usuario='$Usu_Usuario' OR Usu_Email = '$Usu_Email' "
        );              
        return $sql->fetchAll();                
    } 
    public function getUsuarioPorUsuarioPassword($Usu_Usuario,$Usu_Password){          
        try{
            $datos = $this->_db->query(
                    "SELECT Usu_IdUsuario,Usu_Nombre,Usu_Apellidos,Usu_URLImage,Usu_GradoAcademico,Usu_Especialidad,Usu_Perfil,
          Usu_DocumentoIdentidad,Usu_InstitucionLaboral,Usu_Cargo,Usu_Usuario,Usu_Password 
            FROM usuario WHERE Usu_Usuario = '$Usu_Usuario' AND Usu_Password = '" . Hash::getHash('sha1', $Usu_Password, HASH_KEY) ."'" );
            return $datos->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("movil(indexModel)", "getUsuarioPorUsuarioPassword", "Error Model", $exception);
            return $exception->getTraceAsString();
        }          
    }
    public function getValoraciones($Cur_IdCurso){          
        $sql = $this->_db->query(
            "SELECT usu.Usu_Usuario,val.Val_Valor,val.Val_Comentario,val.Val_FechaReg FROM valoracion_curso val 
            INNER JOIN usuario usu ON val.Usu_IdUsuario=usu.Usu_IdUsuario WHERE val.Cur_IdCurso=$Cur_IdCurso 
            AND val.Row_Estado=1
              "
        );              
        return $sql->fetchAll();
    } 
    public function insertarInscripcion($Usu_IdUsuario, $Cur_IdCurso){
        try {                                        
            $pre = $this->getInscripcion($Usu_IdUsuario, $Cur_IdCurso);
            if($pre==null || count($pre)==0){
                $sql = "INSERT INTO matricula_curso(Usu_IdUsuario, Cur_IdCurso, Mat_Valor)
                          VALUES($Usu_IdUsuario, $Cur_IdCurso, 1)";                         
                $result = $this->_db->prepare($sql);                                                   
                $result->execute();
                return $result->fetch();
            }
        } catch (PDOException $exception) {
            $this->registrarBitacora("movil(indexModel)", "insertarInscripcion", "Error Model", $exception);
            return $exception->getTraceAsString();
        }  
        
    }
    public function insertarUsuario___($Usu_Nombre,$Usu_Apellidos,$Usu_Email,$Usu_Usuario,$Usu_Password){        
        try {                                        
            $Usu_Password = Hash::getHash('sha1', $Usu_Password, HASH_KEY);
            $sql = "INSERT INTO usuario(Usu_Nombre,Usu_Apellidos,Usu_Email, Usu_Usuario,Usu_Password) VALUES('$Usu_Nombre','$Usu_Apellidos','$Usu_Email', '$Usu_Usuario','$Usu_Password')";                         
            $result = $this->_db->prepare($sql);                                                   
            $result->execute();
            return $result->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("movil(indexModel)", "insertarUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }        
    }
    public function insertarUsuarioGoogle($Usu_Email){        
        try {              
            $sql = "call s_i_usuario_google(?)";                                                                                 
            $result = $this->_db->prepare($sql);               
            $result->bindParam(1, $Usu_Email, PDO::PARAM_STR);                                                    
            $result->execute();                        
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("movil(indexModel)", "insertarUsuarioGoogle", "Error Model", $exception);
            return $exception->getTraceAsString();
        }        
    }  

    //Jhon Martinez
    public function insertarUsuario($iUsu_Nombre = "", $iUsu_Apellidos = "", $iUsu_Email = "", $iUsu_Usuario = "", $iUsu_Password = "", $iUsu_Codigo = 0, $iRol_Ckey = "alumno", $iUsu_Estado = 3 )
    {
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

            return $result->fetch();
            // return $result;
            // print_r($result);exit;

        } catch (PDOException $exception) {
            $this->registrarBitacora("movil(indexModel)", "insertarUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }       
    }
    //Jhon martinez
    public function verificarUsuario($usuario)
    {
        try{
            $id = $this->_db->query(
                    " SELECT * FROM usuario WHERE Usu_Usuario = '$usuario' "
                    );
            return $id->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("movil(indexModel)", "verificarUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    //Jhon Martinez
    public function verificarEmail($email)
    {
        try{
            $id = $this->_db->query(
                    "select Usu_IdUsuario, Usu_Codigo, Usu_Usuario, Usu_Email from usuario where Usu_Email = '$email'"
                    );        
            return $id->fetch(PDO::FETCH_ASSOC);            
        } catch (PDOException $exception) {
            $this->registrarBitacora("movil(indexModel)", "verificarEmail", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }





    public function insertarValoracion($Cur_IdCurso,$Usu_IdUsuario,$Val_Comentario,$Val_Valor){        
        try {                                        
            $sql = "INSERT INTO valoracion_curso(Cur_IdCurso,Usu_IdUsuario,Val_Comentario,Val_Valor,Val_FechaReg) VALUES($Cur_IdCurso,$Usu_IdUsuario,'$Val_Comentario',$Val_Valor,NOW())";                         
            $result = $this->_db->prepare($sql);                                                   
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("movil(indexModel)", "insertarValoracion", "Error Model", $exception);
            return $exception->getTraceAsString();
        }        
    }

}

?>
