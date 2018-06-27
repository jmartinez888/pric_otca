f<?php

class adminModel extends Model
{

    public function __construct()
    {
        parent::__construct();
    }

    public function insertarForo($iFor_Titulo, $iFor_Resumen, $iFor_Descripcion, $iFor_Palabras, $iFor_FechaCreacion, $iFor_FechaCierre, $iFor_Funcion, $iFor_Tipo, $iFor_Estado, $iFor_IdPadre, $iLit_IdLineaTematica, $iUsu_IdUsuario, $iEnt_IdEntidad, $iRec_IdRecurso, $iIdi_IdIdioma)
    {
        try {
            if (trim($iFor_FechaCreacion) == "") {
                $iFor_FechaCreacion = date('Y-m-d H:m');
            } else {
                $iFor_FechaCreacion = date('Y-m-d H:m', strtotime($iFor_FechaCreacion));
            }

            if (trim($iFor_FechaCierre) != "") {
                $iFor_FechaCierre = date('Y-m-d H:m', strtotime($iFor_FechaCierre));
            } else {
                $iFor_FechaCierre = null;
            }

            if ($iFor_IdPadre == 0) {
                $iFor_IdPadre = null;
            }

            $sql    = " call s_i_foro(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iFor_Titulo, PDO::PARAM_STR);
            $result->bindParam(2, $iFor_Resumen, PDO::PARAM_STR);
            $result->bindParam(3, $iFor_Descripcion, PDO::PARAM_STR);
            $result->bindParam(4, $iFor_Palabras, PDO::PARAM_STR);
            $result->bindParam(5, $iFor_FechaCreacion, PDO::PARAM_STR);
            $result->bindParam(6, $iFor_FechaCierre, PDO::PARAM_NULL | PDO::PARAM_STR);
            $result->bindParam(7, $iFor_Funcion, PDO::PARAM_STR);
            $result->bindParam(8, $iFor_Tipo, PDO::PARAM_INT);
            $result->bindParam(9, $iFor_Estado, PDO::PARAM_INT);
            $result->bindParam(10, $iFor_IdPadre, PDO::PARAM_NULL | PDO::PARAM_INT);
            $result->bindParam(11, $iLit_IdLineaTematica, PDO::PARAM_INT);
            $result->bindParam(12, $iUsu_IdUsuario, PDO::PARAM_INT);
            $result->bindParam(13, $iEnt_IdEntidad, PDO::PARAM_INT);
            $result->bindParam(14, $iRec_IdRecurso, PDO::PARAM_INT);
            $result->bindParam(15, $iIdi_IdIdioma, PDO::PARAM_STR);

            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "insertarForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function actualizarForo($iFor_IdForo, $iFor_Titulo, $iFor_Resumen, $iFor_Descripcion, $iFor_Palabras, $iFor_FechaCreacion, $iFor_FechaCierre, $iFor_Funcion, $iFor_Tipo, $iFor_Estado, $iFor_IdPadre, $iLit_IdLineaTematica, $iUsu_IdUsuario, $iEnt_IdEntidad, $iRec_IdRecurso, $iIdi_IdIdioma)
    {
        try {
            if (trim($iFor_FechaCreacion) == "") {
                $iFor_FechaCreacion = date('Y-m-d H:m');
            } else {
                $iFor_FechaCreacion = date('Y-m-d H:m', strtotime($iFor_FechaCreacion));
            }

            if (trim($iFor_FechaCierre) != "") {
                $iFor_FechaCierre = date('Y-m-d H:m', strtotime($iFor_FechaCierre));
            } else {
                $iFor_FechaCierre = null;
            }

            if ($iFor_IdPadre == 0) {
                $iFor_IdPadre = null;
            }

            $sql    = "call s_u_foro(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iFor_IdForo, PDO::PARAM_INT);
            $result->bindParam(2, $iFor_Titulo, PDO::PARAM_STR);
            $result->bindParam(3, $iFor_Resumen, PDO::PARAM_STR);
            $result->bindParam(4, $iFor_Descripcion, PDO::PARAM_STR);
            $result->bindParam(5, $iFor_Palabras, PDO::PARAM_STR);
            $result->bindParam(6, $iFor_FechaCreacion, PDO::PARAM_STR);
            $result->bindParam(7, $iFor_FechaCierre, PDO::PARAM_NULL | PDO::PARAM_STR);
            $result->bindParam(8, $iFor_Funcion, PDO::PARAM_STR);
            $result->bindParam(9, $iFor_Tipo, PDO::PARAM_INT);
            $result->bindParam(10, $iFor_Estado, PDO::PARAM_INT);
            $result->bindParam(11, $iFor_IdPadre, PDO::PARAM_NULL | PDO::PARAM_INT);
            $result->bindParam(12, $iLit_IdLineaTematica, PDO::PARAM_INT);
            $result->bindParam(13, $iUsu_IdUsuario, PDO::PARAM_INT);
            $result->bindParam(14, $iEnt_IdEntidad, PDO::PARAM_INT);
            $result->bindParam(15, $iRec_IdRecurso, PDO::PARAM_INT);
            $result->bindParam(16, $iIdi_IdIdioma, PDO::PARAM_STR);

            $result->execute();
            return $result->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "actualizarForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getForos($iFor_Filtros = "", $iFor_Filtros2 = "", $iPagina = 1, $iRegistrosXPagina = CANT_REG_PAG)
    {
        try {
            $sql    = " call s_s_foro_admin(?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iFor_Filtros, PDO::PARAM_STR);   
            $result->bindParam(2, $iFor_Filtros2, PDO::PARAM_STR);         
            $result->bindParam(3, $iPagina, PDO::PARAM_INT);
            $result->bindParam(4, $iRegistrosXPagina, PDO::PARAM_INT);

            $result->execute();
            return $result->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "getForos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getForosTipos()
    {
        try {
            $post = $this->_db->query(
                "SELECT DISTINCT(f.For_Funcion) FROM foro f");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "getForosTipos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getRowForos($iFor_Filtros = "")
    {
        try {
            $post = $this->_db->query(
                "SELECT COUNT(*) as For_NRow from foro f WHERE f.For_Titulo LIKE '%$iFor_Filtros%' OR f.For_Resumen LIKE '%$iFor_Filtros%' OR f.For_Descripcion LIKE '%$iFor_Filtros%' OR f.For_PalabrasClaves LIKE '%$iFor_Filtros%'");

            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "getRowForos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getForos_x_Id($iFor_IdForo)
    {
        try {
            $sql    = " call s_s_foro_admin_x_id(?)";
            $result = $this->_db->prepare($sql);

            $result->bindParam(1, $iFor_IdForo, PDO::PARAM_INT);

            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "getForos_x_Id", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function getForosComplit_x_Id($iFor_IdForo)
    {
        try {
            $sql    = " call s_s_foro_complit_x_id(?)";
            $result = $this->_db->prepare($sql);

            $result->bindParam(1, $iFor_IdForo, PDO::PARAM_INT);

            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "getForosComplit_x_Id", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function cambiarEstadoForo($iFor_IdForo, $iFor_Estado)
    {
        try {
            if ($iFor_Estado == 0) {
                $foro = $this->_db->query(
                    "UPDATE foro SET For_Estado = 1 where For_IdForo = $iFor_IdForo"
                );
            }
            if ($iFor_Estado == 1) {
                $foro = $this->_db->query(
                    "UPDATE foro SET For_Estado = 0 where For_IdForo = $iFor_IdForo"
                );
            }

            return $foro->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "cambiarEstadoForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function updestadoRowForo($iFor_IdForo, $iRow_Estado)
    {
        try {

            $foro = $this->_db->query(
                "UPDATE foro SET Row_Estado = $iRow_Estado where For_IdForo = $iFor_IdForo"
            );

            return $foro->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "estadoRowForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function cerrarForo($iFor_IdForo)
    {
        try {

            $foro = $this->_db->query(
                "UPDATE foro SET For_FechaCierre = NOW(),For_Estado=2 where For_IdForo = $iFor_IdForo"
            );

            return $foro->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "cerrarForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getMembers_x_Foro($iFor_IdForo, $iRol_Ckey, $iPagina = 1, $iRegistrosXPagina = CANT_REG_PAG)
    {
        try {
            $registroInicio = ($iPagina - 1) * $iRegistrosXPagina;
            $post           = $this->_db->query(
                "SELECT uf.Usu_IdUsuario,uf.For_IdForo,uf.Rol_IdRol,us.Usu_Usuario,us.Usu_Nombre,us.Usu_Apellidos,uf.Usf_FechaRegistro,r.Rol_Nombre,uf.Usf_Estado,uf.Row_Estado FROM usuario_foro uf INNER JOIN usuario us ON us.Usu_IdUsuario = uf.Usu_IdUsuario INNER JOIN rol r ON r.Rol_IdRol = uf.Rol_IdRol WHERE uf.For_IdForo = $iFor_IdForo  AND r.Rol_Ckey='$iRol_Ckey' and uf.Row_Estado=1 order by us.Usu_Nombre LIMIT $registroInicio,$iRegistrosXPagina;"
            );

            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "getMembers_x_Foro", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getRowMembers_x_Foro($iFor_IdForo, $iRol_Ckey)
    {
        try {
            $post = $this->_db->query(
                "SELECT COUNT(*) as Usf_RowMembers FROM usuario_foro uf INNER JOIN rol r ON r.Rol_IdRol = uf.Rol_IdRol WHERE uf.For_IdForo = $iFor_IdForo AND r.Rol_Ckey='$iRol_Ckey' AND uf.Row_Estado=1"
            );

            return $post->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "getRowMembers_x_Foro", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function cambiarEstadoMember($iUsu_Usuario, $iFor_IdForo, $iFor_Estado)
    {
        try {
            if ($iFor_Estado == 0) {
                $foro = $this->_db->query(
                    "UPDATE usuario_foro SET Usf_Estado =1  WHERE Usu_IdUsuario=$iUsu_Usuario AND For_IdForo = $iFor_IdForo"
                );
            }
            if ($iFor_Estado == 1) {
                $foro = $this->_db->query(
                    "UPDATE usuario_foro SET Usf_Estado =0  WHERE Usu_IdUsuario=$iUsu_Usuario AND For_IdForo = $iFor_IdForo"
                );
            }

            return $foro->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "cambiarEstadoMember", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function updestadoRowMember($iUsu_Usuario, $iFor_IdForo, $iRow_Estado)
    {
        try {

            $foro = $this->_db->query(
                "UPDATE usuario_foro SET Row_Estado = $iRow_Estado where Usu_IdUsuario=$iUsu_Usuario AND For_IdForo = $iFor_IdForo"
            );

            return $foro->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "estadoRowForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getRolForo()
    {
        try {
            $post = $this->_db->query(
                "SELECT r.* FROM rol r INNER JOIN modulo m ON m.Mod_IdModulo=r.Mod_IdModulo WHERE m.Mod_Codigo='foro' ORDER BY r.Rol_Nombre"
            );

            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "getRolForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getUserRolForo($iRol_IdRol, $iFor_IdForo, $Busqueda)
    {
        try {
            $post = $this->_db->query(
                "SELECT u.Usu_IdUsuario,u.Usu_Nombre,u.Usu_Apellidos,u.Usu_InstitucionLaboral FROM usuario u INNER JOIN usuario_rol ur ON ur.Usu_IdUsuario=u.Usu_IdUsuario WHERE ur.Rol_IdRol=$iRol_IdRol AND (u.Usu_Nombre LIKE '%$Busqueda%' OR u.Usu_Apellidos LIKE '%$Busqueda%') AND NOT EXISTS (SELECT * FROM usuario_foro uf WHERE uf.Usu_IdUsuario = u.Usu_IdUsuario AND uf.For_IdForo=$iFor_IdForo AND uf.Row_Estado=1) AND u.Usu_Estado=1 AND ur.Usr_Valor=1;"
            );
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "getRolForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getPermisosMember($iFor_IdForo, $iUsu_IdUsuario, $iRol_IdRol)
    {
        try {
            $post = $this->_db->query(
                "SELECT $iFor_IdForo as For_IdForo,ur.Usu_IdUsuario,p.*,pr.Per_Valor,
                    (SELECT ufp.Ufp_Estado FROM usuario_foro_permiso ufp WHERE ufp.Per_IdPermiso=p.Per_IdPermiso AND ufp.Usu_IdUsuario=$iUsu_IdUsuario AND ufp.For_IdForo=$iFor_IdForo) AS Ufp_Estado
                    FROM permisos p
                    INNER JOIN permisos_rol pr ON pr.Per_IdPermiso=p.Per_IdPermiso
                    INNER JOIN usuario_rol ur ON ur.Rol_IdRol=pr.Rol_IdRol
                    WHERE pr.Rol_IdRol=$iRol_IdRol AND ur.Usu_IdUsuario=$iUsu_IdUsuario AND p.Per_Estado=1 AND p.Row_Estado=1 ;"
            );
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "getPermisosMember", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function updPermisoMember($iUsu_Usuario, $iFor_IdForo, $Per_IdPermiso, $Ufp_Estado)
    {
        try {

            $sql    = "call s_i_actualizar_permiso_participante_foro(?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iUsu_Usuario, PDO::PARAM_INT);
            $result->bindParam(2, $iFor_IdForo, PDO::PARAM_INT);
            $result->bindParam(3, $Per_IdPermiso, PDO::PARAM_INT);
            $result->bindParam(4, $Ufp_Estado, PDO::PARAM_INT);

            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "updPermisoMember", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function insertarFileForo($iFif_NombreFile, $iFif_TipoFile, $iFif_SizeFile, $iFor_IdForo, $iRec_IdComentario)
    {
        try {

            $sql    = "call s_i_insertar_file_foro(?,?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iFif_NombreFile, PDO::PARAM_STR);
            $result->bindParam(2, $iFif_TipoFile, PDO::PARAM_STR);
            $result->bindParam(3, $iFif_SizeFile, PDO::PARAM_INT);
            $result->bindParam(4, $iFor_IdForo, PDO::PARAM_INT);
            $result->bindParam(5, $iRec_IdComentario, PDO::PARAM_INT);

            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {

            $this->registrarBitacora("foro(indexModel)", "insertarFileForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function deleteFileForo($iFor_IdForo)
    {
        try {

            $sql    = "call s_d_file_foro_x_id(?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iFor_IdForo, PDO::PARAM_INT);
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(indexModel)", "deleteFileForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function actualizarActividadForo($Acf_IdActividadForo, $iAcf_Titulo, $iAct_Resumen, $iAct_FechaInicio, $iAct_FechaFin, $iFor_IdForo, $iAct_Estado, $iIdi_Idioma)
    {
        try {
            $iAct_FechaInicio = date('Y-m-d H:m', strtotime($iAct_FechaInicio));
            $iAct_FechaFin    = date('Y-m-d H:m', strtotime($iAct_FechaFin));

            $sql    = " call s_u_actividad_foro(?,?,?,?,?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $Acf_IdActividadForo, PDO::PARAM_INT);
            $result->bindParam(2, $iAcf_Titulo, PDO::PARAM_STR);
            $result->bindParam(3, $iAct_Resumen, PDO::PARAM_STR);
            $result->bindParam(4, $iAct_FechaInicio, PDO::PARAM_STR);
            $result->bindParam(5, $iAct_FechaFin, PDO::PARAM_STR);
            $result->bindParam(6, $iFor_IdForo, PDO::PARAM_INT);
            $result->bindParam(7, $iAct_Estado, PDO::PARAM_INT);
            $result->bindParam(8, $iIdi_Idioma, PDO::PARAM_STR);

            $result->execute();
            return $result->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "actualizarActividadForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function insertarActividadForo($iAcf_Titulo, $iAct_Resumen, $iAct_FechaInicio, $iAct_FechaFin, $iFor_IdForo, $iAct_Estado, $iIdi_Idioma)
    {
        try {
            $iAct_FechaInicio = date('Y-m-d H:m', strtotime($iAct_FechaInicio));
            $iAct_FechaFin    = date('Y-m-d H:m', strtotime($iAct_FechaFin));

            $sql    = " call s_i_actividad_foro(?,?,?,?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iAcf_Titulo, PDO::PARAM_STR);
            $result->bindParam(2, $iAct_Resumen, PDO::PARAM_STR);
            $result->bindParam(3, $iAct_FechaInicio, PDO::PARAM_STR);
            $result->bindParam(4, $iAct_FechaFin, PDO::PARAM_STR);
            $result->bindParam(5, $iFor_IdForo, PDO::PARAM_INT);
            $result->bindParam(6, $iAct_Estado, PDO::PARAM_INT);
            $result->bindParam(7, $iIdi_Idioma, PDO::PARAM_STR);

            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "insertarActividadForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function listarActividadForo($iFor_IdForo)
    {
        try {
            $post = $this->_db->query(
                "SELECT af.Acf_IdActividadForo AS id, af.Acf_Titulo AS title, af.Act_Resumen AS resumen, af.Act_FechaInicio AS 'start', af.Act_FechaFin AS 'end', af.For_IdForo, af.Act_Estado,af.Idi_IdIdioma FROM actividad_foro af WHERE For_IdForo=$iFor_IdForo AND Row_Estado=1"
            );
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "listarActividadForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function updestadoRowActividadForo($iAcf_IdActividadForo, $iRow_Estado)
    {
        try {

            $foro = $this->_db->query(
                "UPDATE actividad_foro SET Row_Estado = $iRow_Estado where Acf_IdActividadForo=$iAcf_IdActividadForo"
            );

            return $foro->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("foro(adminModel)", "estadoRowForo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

}
