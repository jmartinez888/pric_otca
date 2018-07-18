<?php

class messageModel extends Model {

    public function __construct() { parent::__construct(); }

    public function MisChats($usuario){
        $sqlGrupos = "SELECT
                        XX.ID1, XX.NOVISTO, XX.ID2,XX.TITULO, XX.SUBTITULO, XX.IMG, XX.TIPO,
                        (CASE WHEN DATE(XX.FECHA) < DATE(NOW()) THEN DATE(XX.FECHA) ELSE SUBSTRING(XX.FECHA, 12, 5) END) as FECHA
                      FROM(

                          SELECT
                              C.Cur_IdCurso ID1,
                              0 as NOVISTO,
                              L.Lec_IdLeccion ID2,
                              C.Cur_Titulo TITULO,
                              L.Lec_Titulo SUBTITULO,
                              C.Cur_UrlBanner as IMG,
                              1 as TIPO,
                              (SELECT MAX(Men_Fecha) FROM mensaje
                              WHERE Cur_IdCurso = C.Cur_IdCurso
                                  AND Lec_IdLeccion = L.Lec_IdLeccion
                                  AND Row_Estado = 1) as FECHA
                          FROM (
                              SELECT Cur_IdCurso, Lec_IdLeccion FROM mensaje
                              WHERE Usu_IdUsuario = {$usuario} AND Row_Estado = 1
                                AND Men_IdMensaje NOT IN (SELECT Men_Codigo FROM mensaje_reciclado
                                  WHERE Usu_IdUsuario = {$usuario} AND Men_Tipo = 1) /*MENSAJE ELIMINADOS*/
                              GROUP BY Cur_IdCurso, Lec_IdLeccion
                          )X INNER JOIN curso C ON C.Cur_IdCurso = X.Cur_IdCurso
                          INNER JOIN leccion L ON L.Lec_IdLeccion = X.Lec_IdLeccion

                          UNION

                          SELECT
                              U.Usu_IdUsuario ID1,
                              (SELECT COUNT(Con_IdConversacion) FROM conversacion
                              WHERE Usu_IdUsuRecibe = {$usuario} AND Usu_IdUsuEnvia = Y.Usuario
                                AND Con_Visto = 0 AND Con_Estado = 1 AND Row_Estado = 1) as NOVISTO,
                              0 as ID2,
                              CONCAT(U.Usu_Nombre, ' ', U.Usu_Apellidos) TITULO,
                              '' as SUBTITULO,
                              U.Usu_URLImage IMG,
                              2 as TIPO,
                              (SELECT MAX(Con_FechaReg) FROM conversacion
                              WHERE ((Usu_IdUsuEnvia = {$usuario} AND Usu_IdUsuRecibe = Y.Usuario)
                                OR (Usu_IdUsuEnvia = Y.Usuario AND Usu_IdUsuRecibe = {$usuario}))
                                AND Con_Estado = 1 AND Row_Estado = 1) as FECHA
                          FROM(
                              SELECT
                                CONCAT(
                                (CASE WHEN X.Usu_IdUsuEnvia = {$usuario} THEN '' ELSE X.Usu_IdUsuEnvia END),
                                (CASE WHEN X.Usu_IdUsuRecibe = {$usuario} THEN '' ELSE X.Usu_IdUsuRecibe END)) as Usuario
                              FROM (
                                  SELECT Usu_IdUsuEnvia, Usu_IdUsuRecibe FROM conversacion
                                  WHERE Usu_IdUsuEnvia = {$usuario} OR Usu_IdUsuRecibe = {$usuario}
                                      AND Con_Estado = 1 AND Row_Estado = 1
                                      AND Con_IdConversacion NOT IN (SELECT Men_Codigo FROM mensaje_reciclado
                                        WHERE Usu_IdUsuario = {$usuario} AND Men_Tipo = 2) /*MENSAJE ELIMINADOS*/
                                  GROUP BY Usu_IdUsuEnvia, Usu_IdUsuRecibe
                              )X
                          )Y INNER JOIN usuario U ON U.Usu_IdUsuario = Y.Usuario

                      )XX ORDER BY XX.FECHA DESC";
        $resultado = $this->getArray($sqlGrupos);

        $final = array();
        if($resultado!=null && count($resultado)>0){
          foreach ($resultado as $i) {
            array_push($final, $i);
          }
        }
        return $final;
    }

    public function ListarChat($usuario, $id, $i1, $i2){
        $sql = "UPDATE conversacion SET Con_Visto = 1
                WHERE ( (Usu_IdUsuEnvia = {$usuario} AND Usu_IdUsuRecibe = {$id})
                    OR (Usu_IdUsuEnvia = {$id} AND Usu_IdUsuRecibe = {$usuario}) )";
        $this->execQuery($sql);

        $sql = "SELECT
                    X.ID,
                    (CASE WHEN X.ID1 = {$usuario} THEN 1 ELSE 2 END) as CONDICION,
                    X.NOMBRE1,
                    X.NOMBRE2,
                    X.MENSAJE,
                    X.VISTO,
                    (CASE WHEN DATE(X.FECHA) < DATE(NOW()) THEN DATE(X.FECHA) ELSE SUBSTRING(X.FECHA, 12, 5) END) as FECHA
                FROM (
                    SELECT
                        C.Con_IdConversacion as ID,
                        C.Usu_IdUsuEnvia as ID1,
                        CONCAT(U1.Usu_Nombre, ' ',U1.Usu_Apellidos) as NOMBRE1,
                        CONCAT(U2.Usu_Nombre, ' ',U2.Usu_Apellidos) as NOMBRE2,
                        C.Con_Mensaje as MENSAJE,
                        C.Con_VISTO as VISTO,
                        C.Con_FechaReg as FECHA
                    from conversacion C
                    INNER JOIN Usuario U1 ON U1.Usu_IdUsuario = C.Usu_IdUsuEnvia
                    INNER JOIN Usuario U2 ON U2.Usu_IdUsuario = C.Usu_IdUsuRecibe
                    WHERE ( (Usu_IdUsuEnvia = {$usuario} AND Usu_IdUsuRecibe = {$id})
                        OR (Usu_IdUsuEnvia = {$id} AND Usu_IdUsuRecibe = {$usuario}) )
                        AND Con_IdConversacion NOT IN (SELECT Men_Codigo FROM mensaje_reciclado
                            WHERE Usu_IdUsuario = {$usuario} AND Men_Tipo = 2) /*MENSAJE ELIMINADOS*/
                    ORDER BY Con_FechaReg DESC
                    LIMIT $i1, $i2
                )X ORDER BY X.FECHA ASC";

        return $this->getArray($sql);
    }

    public function registrarMensaje($usuario, $id1, $mensaje){
        $sql = "INSERT INTO conversacion(Usu_IdUsuEnvia, Usu_IdUsuRecibe, Con_Mensaje)
                VALUES({$usuario}, {$id1}, '{$mensaje}')";
        $this->execQuery($sql);
    }

    public function EliminarChat($usuario, $tipo, $idmensaje){
        $sql = "INSERT INTO mensaje_reciclado(Men_Codigo, Men_Tipo, Usu_IdUsuario)
                VALUES({$idmensaje}, {$tipo}, {$usuario})";
        $this->execQuery($sql);
    }
}
