<?php

class indexModel extends Model {

    public function __construct() {
        parent::__construct();
    }

    public function getForos($iFor_Funcion) {
        try {
            // $post = $this->_db->query(
            //         "SELECT f.*,(SELECT COUNT(Com_IdComentario) FROM comentarios c WHERE c.For_IdForo=f.For_IdForo) as For_TComentarios  FROM foro f WHERE f.For_Funcion LIKE '%$iFor_Funcion%' AND Row_Estado=1 ORDER BY f.For_FechaCreacion DESC");
            $post = $this->_db->query(
                    "SELECT  fn_TraducirContenido('foro', 'For_Titulo', f.For_IdForo, '$Idi_IdIdioma', f.For_Titulo) For_Titulo,
                             fn_TraducirContenido('foro', 'For_Resumen', f.For_IdForo, '$Idi_IdIdioma', f.For_Resumen) For_Resumen, 
                             fn_TraducirContenido('foro', 'For_Descripcion', f.For_IdForo, '$Idi_IdIdioma', f.For_Descripcion) For_Descripcion, 
                             fn_TraducirContenido('foro', 'For_PalabrasClaves', f.For_IdForo, '$Idi_IdIdioma', f.For_PalabrasClaves) For_PalabrasClaves, f.Row_Estado,
                             fn_devolverIdioma('foro', f.For_IdForo, '$Idi_IdIdioma', f.Idi_IdIdioma) Idi_IdIdioma,
                             f.For_FechaCreacion, f.For_FechaCierre, f.For_Update, f.For_Funcion, f.For_Tipo, f.For_Estado, f.For_IdPadre, f.Lit_IdLineaTematica, f.Usu_IdUsuario, f.Ent_Id_Entidad,
                             f.Idi_IdIdioma, f.Rec_IdRecurso, f.Row_Estado,
                     (SELECT COUNT(Com_IdComentario) FROM comentarios c
                                WHERE c.For_IdForo=f.For_IdForo) AS For_NComentarios, u.Usu_Usuario
                    FROM foro f INNER JOIN usuario u ON u.Usu_IdUsuario=f.Usu_IdUsuario
                    WHERE f.For_Funcion LIKE '%$iFor_Funcion%' ORDER BY f.For_FechaCreacion DESC");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getForos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getForosSearch($Condicion = "", $Idi_IdIdioma="es" ) {
        try {
            $post = $this->_db->query(
                    "SELECT f.For_IdForo, 
                            fn_TraducirContenido('foro', 'For_Titulo', f.For_IdForo, '$Idi_IdIdioma', f.For_Titulo) For_Titulo, 
                            fn_TraducirContenido('foro', 'For_Resumen', f.For_IdForo, '$Idi_IdIdioma', f.For_Resumen) For_Resumen, f.Row_Estado,
                            fn_devolverIdioma('foro', f.For_IdForo, '$Idi_IdIdioma', f.Idi_IdIdioma) Idi_IdIdioma,
                            f.For_Funcion,f.For_FechaCreacion,f.For_FechaCierre,f.For_Update,
                    (SELECT COUNT(*) FROM comentarios c WHERE c.For_IdForo =f.For_IdForo and c.Com_Estado=1 and c.Row_Estado=1) AS For_NComentarios,
                    (SELECT COUNT(uf.Usu_IdUsuario) FROM usuario_foro uf WHERE uf.For_IdForo = f.For_IdForo AND Usf_Estado=1 AND Row_Estado=1) AS For_NParticipantes, u.Usu_Usuario, u.Usu_Nombre, u.Usu_Apellidos, f.Idi_IdIdioma, f.For_Estado
                    FROM foro f
                    INNER JOIN usuario u ON u.Usu_IdUsuario = f.Usu_IdUsuario $Condicion ");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getForos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getForosPaginado($iFor_Filtros = "", $iFor_Filtros2 = "", $iPagina = 1, $iRegistrosXPagina = CANT_REG_PAG, $Idi_IdIdioma="es" )
    {
        try {

            $Inicio =($iPagina - 1) * $iRegistrosXPagina;
            if($Inicio<1)
                $Inicio=0;

            //$sql = "call s_s_foro_admin(?,?,?,?)";
            $sql="SELECT f.For_IdForo,
                         fn_TraducirContenido('foro', 'For_Titulo', f.For_IdForo, '$Idi_IdIdioma', f.For_Titulo) For_Titulo,
                         fn_TraducirContenido('foro', 'For_Resumen', f.For_IdForo, '$Idi_IdIdioma', f.For_Resumen) For_Resumen, f.Row_Estado,
                         fn_devolverIdioma('foro', f.For_IdForo, '$Idi_IdIdioma', f.Idi_IdIdioma) Idi_IdIdioma,
                         f.For_Funcion,f.For_FechaCreacion,f.For_FechaCierre, 
                         f.For_Estado,f.For_Update,
                 (SELECT COUNT(*) FROM comentarios c WHERE c.For_IdForo =f.For_IdForo AND c.Com_Estado=1 AND c.Row_Estado=1) AS For_NComentarios ,
                 (SELECT COUNT(uf.Usu_IdUsuario) FROM usuario_foro uf WHERE uf.For_IdForo = f.For_IdForo AND Usf_Estado=1 AND Row_Estado=1) AS For_NParticipantes,
                u.Usu_Usuario, f.Row_Estado, lit.Lit_Nombre, f.For_Tipo, f.Rec_IdRecurso 
                FROM foro f 
                INNER JOIN usuario u ON u.Usu_IdUsuario = f.Usu_IdUsuario
                INNER JOIN linea_tematica lit ON f.Lit_IdLineaTematica = lit.Lit_IdLineaTematica
                WHERE ";

            $where=" (f.For_Titulo LIKE CONCAT('%',:iFor_Filtros,'%') 
                    OR f.For_Resumen LIKE CONCAT('%',:iFor_Filtros,'%') 
                    OR f.For_Descripcion LIKE CONCAT('%',:iFor_Filtros,'%') 
                    OR f.For_PalabrasClaves LIKE CONCAT('%',:iFor_Filtros,'%')
                    OR lit.Lit_Nombre LIKE CONCAT('%',:iFor_Filtros,'%'))
                    AND f.For_Funcion LIKE CONCAT('%',:iFor_Filtros2,'%')
                    ORDER BY f.Row_Estado DESC, f.For_FechaCreacion DESC 
                    LIMIT :Inicio,:iRegistrosXPagina";

             if ($this->_acl->rolckey("administrador")  ||  $this->_acl->rolckey("administrador_foro"))
             {
                
                $sql=$sql.$where;

             }else if($this->_acl->rolckey("lider_foro")  ||  $this->_acl->rolckey("moderador_foro")){
               
                 
                 $sql=$sql." f.Row_Estado=1 and ". $where;                

             }else{

                
                 $sql=$sql." f.For_Estado!=0 and f.Row_Estado=1 and ". $where;
             }

            $result = $this->_db->prepare($sql);
            $result->bindParam(':iFor_Filtros', $iFor_Filtros, PDO::PARAM_STR);
            $result->bindParam(':iFor_Filtros2', $iFor_Filtros2, PDO::PARAM_STR);
            $result->bindParam(':Inicio', $Inicio, PDO::PARAM_INT);
            $result->bindParam(':iRegistrosXPagina', $iRegistrosXPagina, PDO::PARAM_INT);

            $result->execute();
            return $result->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "getForosPaginado", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function getRowForos($iFor_Filtros = "", $iFor_Filtros2 = "") {
        try {

            $sql="SELECT COUNT(*) as For_NRow from foro f WHERE ";

            $where=" (f.For_Titulo LIKE CONCAT('%','$iFor_Filtros','%') OR f.For_Resumen LIKE CONCAT('%','$iFor_Filtros','%')
                    OR f.For_Descripcion LIKE CONCAT('%','$iFor_Filtros','%')
                    OR f.For_PalabrasClaves LIKE CONCAT('%','$iFor_Filtros','%'))
                    AND f.For_Funcion LIKE CONCAT('%','$iFor_Filtros2','%') ORDER BY f.For_FechaCreacion DESC";

             if ($this->_acl->rolckey("administrador")  ||  $this->_acl->rolckey("administrador_foro"))
             {
                
                $sql=$sql.$where;

             }else if($this->_acl->rolckey("lider_foro")  ||  $this->_acl->rolckey("moderador_foro")){
               
                 
                 $sql=$sql." f.Row_Estado=1 and ". $where;                

             }else{

                
                 $sql=$sql." f.For_Estado!=0 and f.Row_Estado=1 and ". $where;
             }          

            $post = $this->_db->query($sql);

            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "getRowForos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function getRowForoHistorico($iFor_Filtro = "") {
        try {
            $sql="SELECT COUNT(*) as For_NRow from foro f
                    INNER JOIN usuario u ON u.Usu_IdUsuario = f.Usu_IdUsuario
                    WHERE f.For_FechaCierre < TIMESTAMP(NOW()) AND f.For_Estado=2 AND f.Row_Estado=1 AND (f.For_Titulo LIKE CONCAT('%','$iFor_Filtro','%')
                     OR f.For_Resumen LIKE CONCAT('%','$iFor_Filtro','%') 
                     OR f.For_Descripcion LIKE CONCAT('%','$iFor_Filtro','%') 
                     OR f.For_PalabrasClaves LIKE CONCAT('%','$iFor_Filtro','%')
                     OR u.Usu_Usuario LIKE CONCAT('%','$iFor_Filtro','%')
                     OR f.For_Funcion LIKE CONCAT('%','$iFor_Filtro','%'))";   
                             
            $post = $this->_db->query($sql);

            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "getRowForos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getForosRecientes($iFor_Funcion, $Idi_IdIdioma="es") {
        try {
            $post = $this->_db->query(
                    "SELECT f.For_IdForo,
                            fn_TraducirContenido('foro', 'For_Titulo', f.For_IdForo, '$Idi_IdIdioma', f.For_Titulo) For_Titulo,
                            fn_TraducirContenido('foro', 'For_Resumen', f.For_IdForo, '$Idi_IdIdioma', f.For_Resumen) For_Resumen, 
                            fn_TraducirContenido('foro', 'For_Descripcion', f.For_IdForo, '$Idi_IdIdioma', f.For_Descripcion) For_Descripcion, 
                            fn_TraducirContenido('foro', 'For_PalabrasClaves', f.For_IdForo, '$Idi_IdIdioma', f.For_PalabrasClaves) For_PalabrasClaves, f.Row_Estado,
                            fn_devolverIdioma('foro', f.For_IdForo, '$Idi_IdIdioma', f.Idi_IdIdioma) Idi_IdIdioma,
                            f.For_FechaCreacion, f.For_FechaCierre, f.For_Update, f.For_Funcion, f.For_Tipo, f.For_Estado, f.For_IdPadre, f.Lit_IdLineaTematica, f.Usu_IdUsuario, f.Ent_Id_Entidad,
                            f.Idi_IdIdioma, f.Rec_IdRecurso, f.Row_Estado,u.Usu_Usuario,(SELECT COUNT(Com_IdComentario) 
                    FROM comentarios c WHERE c.For_IdForo=f.For_IdForo) AS For_TComentarios,
                    (SELECT COUNT(*) FROM usuario_foro uf WHERE uf.For_IdForo=f.For_IdForo AND uf.Row_Estado=1) AS For_TParticipantes
                    FROM foro f 
                    INNER JOIN usuario u ON u.Usu_IdUsuario=f.Usu_IdUsuario WHERE f.For_Funcion LIKE '%$iFor_Funcion%' and f.For_Estado=1 AND f.Row_Estado=1 
                    ORDER BY f.For_FechaCreacion DESC
                    LIMIT 5");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getForos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getForo_x_idforo($iFor_IdForo, $Idi_IdIdioma="es") {
        try {
            $sql= "SELECT f.For_IdForo,
                          fn_TraducirContenido('foro', 'For_Titulo', f.For_IdForo, '$Idi_IdIdioma', f.For_Titulo) For_Titulo,
                          fn_TraducirContenido('foro', 'For_Resumen', f.For_IdForo, '$Idi_IdIdioma', f.For_Resumen) For_Resumen, 
                          fn_TraducirContenido('foro', 'For_Descripcion', f.For_IdForo, '$Idi_IdIdioma', f.For_Descripcion) For_Descripcion, 
                          fn_TraducirContenido('foro', 'For_PalabrasClaves', f.For_IdForo, '$Idi_IdIdioma', f.For_PalabrasClaves) For_PalabrasClaves, f.Row_Estado,
                          fn_devolverIdioma('foro', f.For_IdForo, '$Idi_IdIdioma', f.Idi_IdIdioma) Idi_IdIdioma,
                          f.For_FechaCreacion, f.For_FechaCierre, f.For_Update, f.For_Funcion, f.For_Tipo, f.For_Estado, f.For_IdPadre, f.Lit_IdLineaTematica, 
                          f.Usu_IdUsuario, f.Ent_Id_Entidad, f.Rec_IdRecurso, 
                   (SELECT COUNT(Com_IdComentario) FROM comentarios c WHERE c.For_IdForo=f.For_IdForo) as For_TComentarios, 
                   (SELECT COUNT(*) FROM usuario_foro uf WHERE uf.For_IdForo=f.For_IdForo AND uf.Row_Estado=1) as For_TParticipantes 
                   FROM foro f where f.For_IdForo={$iFor_IdForo}";

          

            if ($this->_acl->rolckey("administrador")  ||  $this->_acl->rolckey("administrador_foro"))
             {
                
                $sql=$sql;

             }else if($this->_acl->rolckey("lider_foro")  ||  $this->_acl->rolckey("moderador_foro")){
               
                 
                 $sql=$sql." and f.Row_Estado=1  ";                

             }else{

                
                 $sql=$sql." and f.For_Estado!=0 and f.Row_Estado=1 ";
             }       

            $post = $this->_db->query($sql);
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getForos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getHora_Servidor() {
        try {
            $post = $this->_db->query(
                    "SELECT NOW() AS hora_servidor");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getHora_Servidor", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getPropietario_foro($Usu_IdUsuario) {
        try {
            $post = $this->_db->query(
                    "SELECT Usu_Usuario,Usu_Nombre FROM usuario
                    WHERE Usu_IdUsuario = {$Usu_IdUsuario}");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getPropietario_foro", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getLineaTematica($Lit_IdLineaTematica) {
        try {
            $post = $this->_db->query(
                    "SELECT  Lit_IdLineaTematica,Lit_Nombre FROM linea_tematica
                    WHERE Lit_IdLineaTematica = {$Lit_IdLineaTematica}");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getLineaTematica", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getNumero_comentarios_x_idForo($For_IdForo) {
        try {
            $post = $this->_db->query(
                    "SELECT COUNT(*) AS Numero_comentarios FROM comentarios
                        WHERE For_IdForo = {$For_IdForo} AND Row_Estado = 1");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getNumero_comentarios_x_idForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getNumero_participantes_x_idForo($For_IdForo) {
        try {
            $post = $this->_db->query(
                    "SELECT COUNT(*) AS numero_participantes FROM usuario_foro usr INNER JOIN rol r
                        ON usr.Rol_IdRol = r.Rol_IdRol
                        WHERE usr.For_IdForo = {$For_IdForo} AND usr.Row_Estado = 1");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getNumero_comentarios_x_idForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getSubForo_x_idforo($iFor_IdForo, $Idi_IdIdioma="es") {
        try {
            $post = $this->_db->query(
                    "SELECT f.For_IdForo,
                            fn_TraducirContenido('foro', 'For_Titulo', f.For_IdForo, '$Idi_IdIdioma', f.For_Titulo) For_Titulo,
                            fn_TraducirContenido('foro', 'For_Resumen', f.For_IdForo, '$Idi_IdIdioma', f.For_Resumen) For_Resumen, 
                            fn_TraducirContenido('foro', 'For_Descripcion', f.For_IdForo, '$Idi_IdIdioma', f.For_Descripcion) For_Descripcion, 
                            fn_TraducirContenido('foro', 'For_PalabrasClaves', f.For_IdForo, '$Idi_IdIdioma', f.For_PalabrasClaves) For_PalabrasClaves, f.Row_Estado,
                            fn_devolverIdioma('foro', f.For_IdForo, '$Idi_IdIdioma',f.Idi_IdIdioma) Idi_IdIdioma,
                            f.For_FechaCreacion, f.For_FechaCierre, f.For_Update, f.For_Funcion, f.For_Tipo, f.For_Estado, f.For_IdPadre, f.Lit_IdLineaTematica, f.Usu_IdUsuario, f.Ent_Id_Entidad,
                            f.Idi_IdIdioma, f.Rec_IdRecurso,
                            (SELECT COUNT(Com_IdComentario) FROM comentarios c WHERE c.For_IdForo=f.For_IdForo) as For_TComentarios  FROM foro f where f.For_IdPadre={$iFor_IdForo}");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getForos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getComentarios_x_idforo($iFor_IdForo, $iPagina = 1, $iRegistrosXPagina = CANT_REG_PAG, $Idi_IdIdioma="es") {
        try {
            // $registroInicio = 0;
            // if ($iPagina > 0) {
            //     $registroInicio = ($iPagina - 1) * $iRegistrosXPagina;
            // }
            // $post = $this->_db->query(
            //         "SELECT c.Com_IdComentario,c.Com_Descripcion,c.Com_Fecha,c.Com_Estado,c.For_IdForo,c.Idi_IdIdioma,c.Row_Estado,u.Usu_Nombre,u.Usu_Apellidos, u.Usu_IdUsuario FROM comentarios c INNER JOIN usuario u ON u.Usu_IdUsuario=c.Usu_IdUsuario WHERE c.For_IdForo={$iFor_IdForo} AND c.Row_Estado = 1 and Com_IdPadre IS NULL ORDER BY c.Com_Fecha DESC
            //         LIMIT registroInicio, iRegistrosXPagina");
            $post = $this->_db->query(
                    "SELECT c.Com_IdComentario,
                            fn_TraducirContenido('comentarios', 'Com_Descripcion', c.Com_IdComentario, '$Idi_IdIdioma', c.Com_Descripcion) Com_Descripcion, c.Row_Estado,
                            fn_devolverIdioma('comentarios', c.Com_IdComentario, '$Idi_IdIdioma', c.Idi_IdIdioma) Idi_IdIdioma,
                            c.Com_Fecha,c.Com_Estado,c.For_IdForo,c.Idi_IdIdioma,
                            u.Usu_Nombre,u.Usu_Apellidos, u.Usu_IdUsuario 
                   FROM comentarios c INNER JOIN usuario u ON u.Usu_IdUsuario=c.Usu_IdUsuario WHERE c.For_IdForo={$iFor_IdForo} AND c.Row_Estado = 1 and Com_IdPadre IS NULL ORDER BY c.Com_Fecha DESC");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getComentarios_x_idforo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function getComentario_x_idforo($iFor_IdForo, $iCom_IdComentario, $Idi_IdIdioma="es") {
        try {
            $post = $this->_db->query(
                    "SELECT c.Com_IdComentario,c.Com_IdPadre,
                            fn_TraducirContenido('comentarios', 'Com_Descripcion', c.Com_IdComentario, '$Idi_IdIdioma', c.Com_Descripcion) Com_Descripcion, c.Row_Estado,
                            fn_devolverIdioma('comentarios', c.Com_IdComentario, '$Idi_IdIdioma', c.Idi_IdIdioma) Idi_IdIdioma,
                            c.Com_Fecha,c.Com_Estado,c.For_IdForo,c.Idi_IdIdioma,
                            u.Usu_Nombre,u.Usu_Apellidos, u.Usu_IdUsuario 
                    FROM comentarios c INNER JOIN usuario u ON u.Usu_IdUsuario=c.Usu_IdUsuario WHERE c.For_IdForo={$iFor_IdForo} AND c.Row_Estado = 1 AND c.Com_IdComentario = {$iCom_IdComentario}");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getComentario_x_idforo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getComentarios_x_idcomentario($iCom_IdComentario, $Idi_IdIdioma) {
        try {
            $post = $this->_db->query(
                    "SELECT c.Com_IdComentario,
                            fn_TraducirContenido('comentarios', 'Com_Descripcion', c.Com_IdComentario, '$Idi_IdIdioma', c.Com_Descripcion) Com_Descripcion, c.Row_Estado,
                            fn_devolverIdioma('comentarios', c.Com_IdComentario, '$Idi_IdIdioma', c.Idi_IdIdioma) Idi_IdIdioma,
                            c.Com_Fecha,c.Com_Estado,c.For_IdForo,c.Idi_IdIdioma,u.Usu_IdUsuario, 
                            u.Usu_Nombre,u.Usu_Apellidos 
                    FROM comentarios c INNER JOIN usuario u ON u.Usu_IdUsuario=c.Usu_IdUsuario WHERE c.Com_IdPadre={$iCom_IdComentario} AND c.Row_Estado = 1 ORDER BY c.Com_Fecha DESC");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getComentarios_x_idcomentario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getArchivos_x_idcomentario($iCom_IdComentario, $Idi_IdIdioma="es") {
        try {
            $post = $this->_db->query(
                    "SELECT * FROM file_comentario 
                            WHERE Com_IdComentario = $iCom_IdComentario");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getArchivos_x_idcomentario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function eliminar_archivos_comentario($Fim_IdForo)
    {
        try{
            $permiso = $this->_db->query(
                " DELETE FROM file_comentario WHERE Fim_IdForo = {$Fim_IdForo}"
                );
            return $permiso->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "eliminar_archivos_comentario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function registrarComentario($iFor_IdForo, $iUsu_IdUsuario, $iCom_Descripcion, $iCom_IdPadre) {
        try {
            $iCom_IdPadre = empty($iCom_IdPadre) ? null : $iCom_IdPadre;
            $sql = "call s_i_comentario(?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iFor_IdForo, PDO::PARAM_INT);
            $result->bindParam(2, $iUsu_IdUsuario, PDO::PARAM_INT);
            $result->bindParam(3, $iCom_Descripcion, PDO::PARAM_LOB);
            $result->bindParam(4, $iCom_IdPadre, PDO::PARAM_NULL | PDO::PARAM_INT);

            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {

            $this->registrarBitacora("foro(indexModel)", "registrarComentario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

     public function editarComentario($iCom_IdComentario, $iCom_Descripcion)
    {
        try {
            // echo $iCom_Descripcion; exit;
            $sql    = " call s_u_comentario(?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iCom_IdComentario, PDO::PARAM_INT);
            $result->bindParam(2, $iCom_Descripcion, PDO::PARAM_LOB);

            $result->execute();
            return $result->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "editarComentario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function eliminarComentario($iCom_IdComentario = 0, $Row_Estado = 0)
    {
        try{
            $permiso = $this->_db->query(
                " UPDATE comentarios SET Row_Estado = $Row_Estado WHERE Com_IdComentario = $iCom_IdComentario "
                );
            // $permiso = $this->_db->query(
            //     " DELETE FROM comentarios WHERE Com_IdComentario = $iCom_IdComentario "
            //     );
            return $permiso->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "eliminarComentario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getRolForo($iUsu_IdUsuario, $iFor_IdForo) {
        try {
            $post = $this->_db->query(
                    "SELECT uf.*, r.Rol_Ckey FROM usuario_foro uf
                    INNER JOIN rol r ON uf.Rol_IdRol = r.Rol_IdRol
                    WHERE uf.Usu_IdUsuario = {$iUsu_IdUsuario} AND uf.For_IdForo = {$iFor_IdForo} AND uf.Row_Estado = 1");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getRolForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getValorarForo_x_IdUsuario($iUsu_IdUsuario, $iFor_IdForo) {
        try {
            $post = $this->_db->query(
                    "SELECT * FROM usuario_foro WHERE Usu_IdUsuario = {$iUsu_IdUsuario} AND For_IdForo = {$iFor_IdForo}");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getValorarForo_x_UsuIdUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getValoraciones_x_IdForo($iFor_IdForo) {
         try {
             $post = $this->_db->query(
                     "SELECT COUNT(For_Valorar) AS Nvaloraciones_foro FROM usuario_foro
                         WHERE For_IdForo = {$iFor_IdForo} AND For_Valorar = 1");
             return $post->fetch();
         } catch (PDOException $exception) {
             $this->registrarBitacora("foro(indexModel)", "getValoraciones_x_For_IdForo", "Error Model", $exception);
             return $exception->getTraceAsString();
         }
     }

    // public function Valorar_Foro($iFor_IdForo, $iUsu_IdUsuario, $For_Valorar)
    // {
    //     try {
    //         if ($For_Valorar == 0) {
    //             $foro = $this->_db->query(
    //                 "UPDATE usuario_foro SET For_Valorar = 1 where Usu_IdUsuario = '$iUsu_IdUsuario'  and For_IdForo = {$iFor_IdForo}"
    //             );
    //         }
    //         if ($For_Valorar == 1) {
    //             $foro = $this->_db->query(
    //                 "UPDATE usuario_foro SET For_Valorar = 0 where Usu_IdUsuario = '$iUsu_IdUsuario'  and For_IdForo = {$iFor_IdForo}"
    //             );
    //         }

    //         return $foro->rowCount(PDO::FETCH_ASSOC);
    //     } catch (PDOException $exception) {
    //         $this->registrarBitacora("foro(indexModel)", "Valorar_Foro", "Error Model", $exception);
    //         return $exception->getTraceAsString();
    //     }
    // }

    public function getValoracion_personal($iUsu_IdUsuario, $iID,$objeto) {
        try {
            $post = $this->_db->query(
                    "SELECT COUNT(*) AS Nvaloracion_personal
                        FROM like_foro_comentario
                        WHERE Usu_IdUsuario = '$iUsu_IdUsuario' AND Lfc_IdObjeto = {$iID} and Lfc_Objeto='$objeto'");          
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getValoracion_personal", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getNvaloraciones($iID,$objeto) {
        try {
            $post = $this->_db->query(
                    "SELECT COUNT(*) AS Nvaloraciones
                        FROM like_foro_comentario
                        WHERE Lfc_IdObjeto = $iID and Lfc_Objeto ='$objeto'");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getNvaloraciones", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function registrarValoracion_Comentario_Foro($iUsu_IdUsuario, $iLfc_IdObjeto,$iLfc_Objeto, $Valor) {
        try {
            $result = $this->_db->query(
                        "DELETE FROM like_foro_comentario WHERE Usu_IdUsuario = $iUsu_IdUsuario AND Lfc_IdObjeto = $iLfc_IdObjeto  and Lfc_Objeto ='$iLfc_Objeto'");
             $rest= $result->rowCount();
          
            if ($Valor == 0) {                

                $sql = "call s_i_like_comentario_foro(?,?,?)";

                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $iUsu_IdUsuario, PDO::PARAM_INT);
                $result->bindParam(2, $iLfc_IdObjeto, PDO::PARAM_INT);
                $result->bindParam(3, $iLfc_Objeto, PDO::PARAM_STR);

                $result->execute();
                return $result->fetch();
            }
            return $rest;
        } catch (PDOException $exception) {

            $this->registrarBitacora("foro(indexModel)", "registrarValoracion_Comentario_Foro", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getRol_Ckey($iUsu_IdUsuario) {
        try {
            $post = $this->_db->query(
                    "SELECT r.Rol_Ckey FROM usuario_rol usr INNER JOIN usuario usu ON usr.Usu_IdUsuario = usu.Usu_IdUsuario
                     INNER JOIN rol r ON r.Rol_IdRol = usr.Rol_IdRol WHERE usu.Usu_IdUsuario = $iUsu_IdUsuario AND (r.Rol_Ckey = 'administrador_foro' OR r.Rol_Ckey = 'administrador') AND r.Row_Estado = 1");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getRol_Ckey", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getPermisos_desh_Foro($iUsu_IdUsuario, $iFor_IdForo, $iPer_Ckey) {
        try {
            $post = $this->_db->query(
                    "SELECT ufp.Per_IdPermiso,p.Per_Ckey FROM usuario_foro_permiso ufp INNER JOIN permisos p ON p.Per_IdPermiso =ufp.Per_IdPermiso  WHERE ufp.Usu_IdUsuario = {$iUsu_IdUsuario} AND ufp.For_IdForo = {$iFor_IdForo} AND p.Per_Ckey = '{$iPer_Ckey}' AND ufp.Ufp_Estado=0");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getPermisos_desh_Foro", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function inscribir_participante_foro($iFor_IdForo, $iUsu_IdUsuario, $iRol_IdRol, $iUsf_Estado) {
        try {

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

    public function getEmail_Usuario($IdUsuario)
    {
        try {
            $post = $this->_db->query(
                "SELECT usu_email FROM usuario usu
                  WHERE usu.Usu_IdUsuario = '$IdUsuario'");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getEmail_Usuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getEmails_usuarios_x_foro($For_IdForo)
    {
        try {
            $post = $this->_db->query(
                "SELECT usu.Usu_Email FROM usuario usu
                INNER JOIN (SELECT usf.Usu_IdUsuario
                    FROM usuario_foro usf INNER JOIN usuario usu
                    ON usf.Usu_IdUsuario = usu.Usu_IdUsuario INNER JOIN rol r ON usf.Rol_IdRol = r.Rol_IdRol
                    WHERE usf.For_IdForo = {$For_IdForo} AND (r.Rol_Ckey = 'lider_foro' OR r.Rol_Ckey = 'moderador_foro'
                    OR r.Rol_Ckey = 'facilitador_foro')) usuarios_foro
                ON usu.Usu_IdUsuario = usuarios_foro.Usu_IdUsuario");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getEmails_usuarios_x_foro", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function insertarFileComentario($Fim_NombreFile, $Fim_TipoFile, $Fim_SizeFile, $Com_IdComentario, $Rec_IdComentario) {
        try {

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

    public function getFacilitadores($iFor_IdForo, $Idi_IdIdioma="es") {
        try {
            $sql = "select u.Usu_IdUsuario,u.Usu_Nombre,u.Usu_Apellidos,u.Usu_URLImage, u.Usu_InstitucionLaboral,
                    r.Rol_IdRol,r.Rol_Nombre from usuario_foro uf
                    inner join usuario u on u.Usu_IdUsuario=uf.Usu_IdUsuario
                    inner join rol r on r.Rol_IdRol=uf.Rol_IdRol
                    where uf.For_IdForo= $iFor_IdForo and (r.Rol_Ckey = 'lider_foro' or r.Rol_Ckey = 'moderador_foro' or r.Rol_Ckey = 'facilitador_foro') AND uf.Row_Estado = 1 order by r.Rol_Nombre desc";
            $result = $this->_db->query($sql);
            return $result->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getFacilitadores", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getArchivos_x_idforo($iFor_IdForo, $Idi_IdIdioma="es") {
        try {
            $post = $this->_db->query(
                    "SELECT ffo.Fif_IdFileForo, 
                            fn_TraducirContenido('file_foro', 'Fif_Titulo', ffo.Fif_IdFileForo, '$Idi_IdIdioma', ffo.Fif_Titulo) Fif_Titulo, 
                            fn_TraducirContenido('file_foro', 'Fif_Resumen', ffo.Fif_IdFileForo, '$Idi_IdIdioma', ffo.Fif_Resumen) Fif_Resumen, 
                            fn_TraducirContenido('file_foro', 'Fif_NombreFile', ffo.Fif_IdFileForo, '$Idi_IdIdioma', ffo.Fif_NombreFile) Fif_NombreFile,
                            fn_devolverIdioma('file_foro', ffo.Fif_IdFileForo,'$Idi_IdIdioma', ffo.Idi_IdIdioma) Idi_IdIdioma,
                            ffo.Fif_TipoFile, ffo.Fif_SizeFile, ffo.For_IdForo, ffo.For_IdForo, ffo.Dub_IdDublinCore, ffo.Fif_EsOutForo FROM file_foro ffo WHERE For_IdForo = $iFor_IdForo");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getArchivos_x_idforo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getAgendaIndex($Idi_IdIdioma="es") {
        try {
            $post = $this->_db->query(
                    "SELECT * FROM (
                    (SELECT f.For_IdForo,0,
                            fn_TraducirContenido('foro', 'For_Titulo', f.For_IdForo, '$Idi_IdIdioma', f.For_Titulo) For_Titulo, f.Row_Estado,
                            fn_devolverIdioma('foro', f.For_IdForo, '$Idi_IdIdioma', f.Idi_IdIdioma) Idi_IdIdioma,
                            f.For_FechaCreacion,f.For_Funcion,f.For_Estado FROM foro f
                    WHERE f.For_Estado=1 AND f.Row_Estado=1 ORDER BY f.For_FechaCreacion DESC LIMIT 5)
                    UNION ALL
                    (SELECT af.For_IdForo,af.Acf_IdActividadForo,
                            fn_TraducirContenido('actividad_foro', 'Act_Titulo', af.Acf_IdActividadForo, '$Idi_IdIdioma', af.Acf_Titulo) Acf_Titulo, af.Row_Estado,
                            fn_devolverIdioma('actividad_foro', af.Acf_IdActividadForo, '$Idi_IdIdioma', af.Idi_IdIdioma) Idi_IdIdioma,
                            Act_FechaInicio,'activity',af.Act_Estado FROM actividad_foro af
                    WHERE af.Act_Estado AND af.Row_Estado=1 ORDER BY Act_FechaInicio DESC LIMIT 5)) AS Agenda
                    ORDER BY For_FechaCreacion DESC LIMIT 5");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getAgendaIndex", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getAgenda($Idi_IdIdioma="es") {
        try {
            $post = $this->_db->query(
                    "SELECT a.For_IdForo id, a.For_Titulo title, a.For_FechaCreacion 'start',a.For_FechaCierre 'end',a.For_Funcion, a.For_Estado FROM (
                    (SELECT f.For_IdForo,
                            fn_TraducirContenido('foro', 'For_Titulo', f.For_IdForo, '$Idi_IdIdioma', f.For_Titulo) For_Titulo, f.Row_Estado
                            fn_devolverIdioma('foro', f.For_IdForo, '$Idi_IdIdioma', f.Idi_IdIdioma) Idi_IdIdioma,
                            f.For_FechaCreacion,IFNULL(f.For_FechaCierre,f.For_FechaCreacion) For_FechaCierre,f.For_Funcion,f.For_Estado FROM foro f
                    WHERE f.For_Estado=1 AND f.Row_Estado=1 ORDER BY f.For_FechaCreacion DESC)
                    UNION ALL
                    (SELECT af.Acf_IdActividadForo,
                            fn_TraducirContenido('actividad_foro', 'Act_Titulo', af.Acf_IdActividadForo, '$Idi_IdIdioma', af.Acf_Titulo) Acf_Titulo, af.Row_Estado,
                            fn_devolverIdioma('actividad_foro', af.Acf_IdActividadForo, '$Idi_IdIdioma', af.Idi_IdIdioma) Idi_IdIdioma,
                            Act_FechaInicio,Act_FechaFin,'activity',af.Act_Estado FROM actividad_foro af
                    WHERE af.Act_Estado AND af.Row_Estado=1 ORDER BY Act_FechaInicio DESC)) AS a
                    ORDER BY For_FechaCreacion DESC");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getAgenda", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getHistorico($iFor_Filtro = "", $iPagina = 1, $iRegistrosXPagina = CANT_REG_PAG, $Idi_IdIdioma="es") {
        try {
            $Inicio =($iPagina - 1) * $iRegistrosXPagina;
            if($Inicio<1)
                $Inicio=0;

            $sql="SELECT f.For_IdForo,
                         fn_TraducirContenido('foro', 'For_Titulo', f.For_IdForo, '$Idi_IdIdioma', f.For_Titulo) For_Titulo, f.Row_Estado,
                         fn_devolverIdioma('foro', f.For_IdForo, '$Idi_IdIdioma', f.Idi_IdIdioma) Idi_IdIdioma, 
                         f.For_FechaCreacion,f.For_FechaCreacion, f.For_FechaCierre, f.For_Funcion,u.Usu_Usuario, u.Usu_Nombre, u.Usu_Apellidos,
                    (SELECT COUNT(Com_IdComentario) FROM comentarios c WHERE c.For_IdForo=f.For_IdForo and c.Com_Estado=1 and c.Row_Estado=1) AS For_NComentarios,
                    (SELECT COUNT(*) FROM usuario_foro uf WHERE uf.For_IdForo=f.For_IdForo AND uf.Usf_Estado=1 AND uf.Row_Estado=1) AS For_NParticipantes
                    FROM foro f
                    INNER JOIN usuario u ON u.Usu_IdUsuario = f.Usu_IdUsuario
                    WHERE f.For_FechaCierre < TIMESTAMP(NOW()) AND f.For_Estado=2 AND f.Row_Estado=1 AND 
                    (f.For_Titulo LIKE CONCAT('%','$iFor_Filtro','%')
                     OR f.For_Resumen LIKE CONCAT('%','$iFor_Filtro','%') 
                     OR f.For_Descripcion LIKE CONCAT('%','$iFor_Filtro','%') 
                     OR f.For_PalabrasClaves LIKE CONCAT('%','$iFor_Filtro','%')
                     OR u.Usu_Usuario LIKE CONCAT('%','$iFor_Filtro','%')
                     OR f.For_Funcion LIKE CONCAT('%','$iFor_Filtro','%')
                    )                    
                    ORDER BY f.For_FechaCierre DESC 
                    LIMIT $Inicio,$iRegistrosXPagina";
                    
            $post = $this->_db->query($sql);

            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getHistorico", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getEstadistcaGeneral(){
        try {

            $sql = "call s_s_foro_estadisticas_general()";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {

            $this->registrarBitacora("foro(indexModel)", "getEstadistcaGeneral", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

     public function getComentario_x_Mes() {
        try {
            $post = $this->_db->query(
                    "SELECT CONCAT(YEAR(Com_Fecha),MONTH(Com_Fecha),'-',MONTHNAME(Com_Fecha)) AS Com_FechaM,COUNT(Com_IdComentario) Com_CantidadComentario FROM comentarios
                        WHERE Com_Estado=1 AND Row_Estado=1
                        GROUP BY Com_FechaM
                        ORDER BY Com_FechaM
                        ");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getComentario_x_Mes", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getCantidaFuncionForo() {
        try {
            $post = $this->_db->query(
                    "SELECT For_Funcion,COUNT(For_IdForo) For_CantidadForo FROM foro
                        WHERE For_Estado!=0 AND Row_Estado=1
                        GROUP BY For_Funcion
                        ORDER BY For_Funcion
                        ");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getCantidaFuncionForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getMiembrosPais($Idi_IdIdioma="es") {
        try {
            $post = $this->_db->query(
                    "SELECT p.Pai_Siglas,
                            fn_TraducirContenido('pais', 'Pai_Nombre', p.Pai_IdPais, '$Idi_IdIdioma', p.Pai_Nombre) Pai_Nombre,
                            fn_devolverIdioma('pais', p.Pai_IdPais, '$Idi_IdIdioma', p.Idi_IdIdioma) Idi_IdIdioma,
                            COUNT(DISTINCT(u.Usu_IdUsuario)) Pai_CantidadUsuarios FROM usuario_foro uf
                        INNER JOIN usuario u ON u.Usu_IdUsuario = uf.Usu_IdUsuario
                        INNER JOIN pais p ON p.Pai_IdPais = u.Pai_IdPais
                        WHERE Usf_Estado = 1 AND uf.Row_Estado=1 AND u.Row_Estado=1
                        GROUP BY p.Pai_Nombre
                        ");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getCantidaFuncionForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getResumenLineTematica($Idi_IdIdioma="es") {
        try {
            $post = $this->_db->query(
                    "SELECT lt.Lit_IdLineaTematica,
                            lt.Lit_Nombre,
(SELECT COUNT(For_IdForo)
FROM foro f
WHERE f.For_Funcion = 'forum' AND Lit_IdLineaTematica =lt.Lit_IdLineaTematica AND f.For_Estado!=0 AND f.Row_Estado=1
GROUP BY f.For_Funcion) Lit_Discussions,
(SELECT COUNT(For_IdForo)
FROM foro f
WHERE f.For_Funcion = 'query' AND Lit_IdLineaTematica =lt.Lit_IdLineaTematica AND f.For_Estado!=0 AND f.Row_Estado=1
GROUP BY f.For_Funcion) Lit_Query,
(SELECT COUNT(For_IdForo)
FROM foro f
WHERE f.For_Funcion = 'webinar' AND Lit_IdLineaTematica =lt.Lit_IdLineaTematica AND f.For_Estado!=0 AND f.Row_Estado=1
GROUP BY f.For_Funcion) Lit_Webinar,
(SELECT COUNT(For_IdForo)
FROM foro f
WHERE f.For_Funcion = 'workshop' AND Lit_IdLineaTematica =lt.Lit_IdLineaTematica AND f.For_Estado!=0 AND f.Row_Estado=1
GROUP BY f.For_Funcion) Lit_Workshop,
(SELECT COUNT(DISTINCT(uf.Usu_IdUsuario)) FROM usuario_foro uf
INNER JOIN foro f ON f.Usu_IdUsuario = uf.Usu_IdUsuario
WHERE f.Lit_IdLineaTematica=lt.Lit_IdLineaTematica AND uf.Usf_Estado = 1 AND uf.Row_Estado=1 AND f.For_Estado!=0 AND f.Row_Estado=1
GROUP BY f.Lit_IdLineaTematica) Lit_Members,
(SELECT COUNT(c.Com_IdComentario) FROM  comentarios c
INNER JOIN foro f ON f.For_IdForo = c.For_IdForo
WHERE f.Lit_IdLineaTematica=lt.Lit_IdLineaTematica AND c.Com_Estado=1 AND c.Row_Estado=1 AND f.For_Estado!=0 AND f.Row_Estado=1
GROUP BY f.Lit_IdLineaTematica) Lit_Comentarios
FROM linea_tematica lt
WHERE lt.Lit_Estado =1 AND lt.Row_Estado = 1");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getLineTematica", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }



}

?>
