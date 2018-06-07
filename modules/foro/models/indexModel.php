<?php

class indexModel extends Model {

    public function __construct() {
        parent::__construct();
    }

    public function getForos($iFor_Funcion) {
        try {
            $post = $this->_db->query(
                    "SELECT f.*,(SELECT COUNT(Com_IdComentario) FROM comentarios c WHERE c.For_IdForo=f.For_IdForo) as For_TComentarios  FROM foro f WHERE f.For_Funcion LIKE '%$iFor_Funcion%' AND Row_Estado=1 ORDER BY f.For_FechaCreacion DESC");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getForos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getForosRecientes($iFor_Funcion) {
        try {
            $post = $this->_db->query(
                    "SELECT f.*,(SELECT COUNT(Com_IdComentario) FROM comentarios c WHERE c.For_IdForo=f.For_IdForo) AS For_TComentarios,(SELECT COUNT(*) FROM usuario_foro uf WHERE uf.For_IdForo=f.For_IdForo AND uf.Row_Estado=1) as For_TParticipantes  FROM foro f WHERE f.For_Funcion LIKE '%$iFor_Funcion%' AND Row_Estado=1
                    ORDER BY f.For_FechaCreacion DESC 
                    LIMIT 4");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getForos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getForo_x_idforo($iFor_IdForo) {
        try {
            $post = $this->_db->query(
                    "SELECT f.*,(SELECT COUNT(Com_IdComentario) FROM comentarios c WHERE c.For_IdForo=f.For_IdForo) as For_TComentarios, (SELECT COUNT(*) FROM usuario_foro uf WHERE uf.For_IdForo=f.For_IdForo AND uf.Row_Estado=1) as For_TParticipantes FROM foro f where f.For_IdForo={$iFor_IdForo}");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getForos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getSubForo_x_idforo($iFor_IdForo) {
        try {
            $post = $this->_db->query(
                    "SELECT f.*,(SELECT COUNT(Com_IdComentario) FROM comentarios c WHERE c.For_IdForo=f.For_IdForo) as For_TComentarios  FROM foro f where f.For_IdPadre={$iFor_IdForo}");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getForos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getComentarios_x_idforo($iFor_IdForo) {
        try {
            $post = $this->_db->query(
                    "SELECT c.Com_IdComentario,c.Com_Descripcion,c.Com_Fecha,c.Com_Estado,c.For_IdForo,c.Idi_IdIdioma,c.Row_Estado,u.Usu_Nombre,u.Usu_Apellidos FROM comentarios c INNER JOIN usuario u ON u.Usu_IdUsuario=c.Usu_IdUsuario WHERE c.For_IdForo={$iFor_IdForo} and Com_IdPadre IS NULL ORDER BY c.Com_Fecha DESC");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getComentarios_x_idforo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getComentarios_x_idcomentario($iCom_IdComentario) {
        try {
            $post = $this->_db->query(
                    "SELECT c.Com_IdComentario,c.Com_Descripcion,c.Com_Fecha,c.Com_Estado,c.For_IdForo,c.Idi_IdIdioma,c.Row_Estado,u.Usu_Nombre,u.Usu_Apellidos FROM comentarios c INNER JOIN usuario u ON u.Usu_IdUsuario=c.Usu_IdUsuario WHERE c.Com_IdPadre={$iCom_IdComentario} ORDER BY c.Com_Fecha DESC");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getComentarios_x_idcomentario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getArchivos_x_idcomentario($iCom_IdComentario) {
        try {
            $post = $this->_db->query(
                    "SELECT * FROM file_comentario WHERE Com_IdComentario = $iCom_IdComentario");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getArchivos_x_idcomentario", "Error Model", $exception);
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
            $result->bindParam(3, $iCom_Descripcion, PDO::PARAM_STR);
            $result->bindParam(4, $iCom_IdPadre, PDO::PARAM_NULL | PDO::PARAM_INT);

            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {

            $this->registrarBitacora("consejeria(adminModel)", "registrarComentario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getRolForo($iUsu_IdUsuario, $iFor_IdForo) {
        try {
            $post = $this->_db->query(
                    "SELECT * FROM usuario_foro WHERE Usu_IdUsuario = {$iUsu_IdUsuario} AND For_IdForo = {$iFor_IdForo}");
            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getRolForo", "Error Model", $exception);
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

    public function getFacilitadores($iFor_IdForo) {
        try {
            $sql = "select u.Usu_Nombre,u.Usu_Apellidos,u.Usu_InstitucionLaboral,r.Rol_IdRol,r.Rol_Nombre from usuario_foro uf
                    inner join usuario u on u.Usu_IdUsuario=uf.Usu_IdUsuario
                    inner join rol r on r.Rol_IdRol=uf.Rol_IdRol
                    where uf.For_IdForo= $iFor_IdForo and (r.Rol_Ckey = 'lider_foro' or r.Rol_Ckey = 'moderador_foro' or r.Rol_Ckey = 'facilitador_foro') order by r.Rol_Nombre desc";
            $result = $this->_db->query($sql);
            return $result->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getFacilitadores", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getArchivos_x_idforo($iFor_IdForo) {
        try {
            $post = $this->_db->query(
                    "SELECT * FROM file_foro WHERE For_IdForo = $iFor_IdForo");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getArchivos_x_idforo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getAgendaIndex() {
        try {
            $post = $this->_db->query(
                    "SELECT * FROM (
                    (SELECT f.For_IdForo,f.For_Titulo,f.For_FechaCreacion,f.For_Funcion,f.For_Estado FROM foro f 
                    WHERE f.For_Estado=1 AND f.Row_Estado=1 ORDER BY f.For_FechaCreacion DESC LIMIT 5)
                    UNION ALL
                    (SELECT af.Acf_IdActividadForo,af.Acf_Titulo,Act_FechaInicio,'activity',af.Act_Estado FROM actividad_foro af 
                    WHERE af.Act_Estado AND af.Row_Estado=1 ORDER BY Act_FechaInicio DESC LIMIT 5)) AS Agenda 
                    ORDER BY For_FechaCreacion DESC LIMIT 5");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getAgendaIndex", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getAgenda() {
        try {
            $post = $this->_db->query(
                    "SELECT a.For_IdForo id, a.For_Titulo title, a.For_FechaCreacion 'start',a.For_FechaCierre 'end',a.For_Funcion, a.For_Estado FROM (
                    (SELECT f.For_IdForo,f.For_Titulo,f.For_FechaCreacion,IFNULL(f.For_FechaCierre,f.For_FechaCreacion) For_FechaCierre,f.For_Funcion,f.For_Estado FROM foro f 
                    WHERE f.For_Estado=1 AND f.Row_Estado=1 ORDER BY f.For_FechaCreacion DESC)
                    UNION ALL
                    (SELECT af.Acf_IdActividadForo,af.Acf_Titulo,Act_FechaInicio,Act_FechaFin,'activity',af.Act_Estado FROM actividad_foro af 
                    WHERE af.Act_Estado AND af.Row_Estado=1 ORDER BY Act_FechaInicio DESC)) AS a
                    ORDER BY For_FechaCreacion DESC");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getAgenda", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getHistorico() {
        try {
            $post = $this->_db->query(
                    "SELECT f.For_IdForo,f.For_Titulo, f.For_FechaCreacion, f.For_FechaCierre, f.For_Funcion, u.Usu_Nombre, u.Usu_Apellidos, 
                    (SELECT COUNT(Com_IdComentario) FROM comentarios c WHERE c.For_IdForo=f.For_IdForo) AS For_TComentarios,
                    (SELECT COUNT(*) FROM usuario_foro uf WHERE uf.For_IdForo=f.For_IdForo) AS For_TParticipantes
                    FROM foro f 
                    INNER JOIN usuario u ON u.Usu_IdUsuario = f.Usu_IdUsuario 
                    WHERE f.For_FechaCierre < TIMESTAMP(NOW()) AND f.For_Estado=2 AND f.Row_Estado=1 
                    ORDER BY f.For_FechaCierre DESC ");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "getHistorico", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

}

?>
