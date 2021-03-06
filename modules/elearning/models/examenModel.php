<?php

use App\Pregunta;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Capsule\Manager as DB;

class examenModel extends Model {
    
    protected $table = 'examen';
    protected $primaryKey = 'Exa_IdExamen';
    public $timestamps = false;

    public function scopeAyuda ($query) {
        return $query->where('Exa_Peso', 20);
    }
    
    protected static function boot() {
        parent::boot();
        // exit;
        static::addGlobalScope('translate', function (Builder $builder) {
          $builder->select(
            '*',
            DB::raw("fn_TraducirContenido('examen','Exa_Titulo',examen.Exa_IdExamen,'".self::getCurrentLang()."',examen.Exa_Titulo)  Exa_Titulo")
            // DB::raw("fn_TraducirContenido('ora_indicadores','OInd_Descripcion',ora_indicadores.OInd_IdIndicadores,'".\Cookie::lenguaje()."',ora_indicadores.OInd_Descripcion)  OInd_Descripcion")
  
          );
  
        });
        // return self;
    }
    public function __construct() {
        parent::__construct();
        self::boot();
    }

    // public function getExamen($leccion){
    //   $sql = "SELECT * FROM examen WHERE Lec_IdLeccion = {$leccion}
    //           AND Exa_Estado = 1 AND Row_Estado = 1";
    //   $examen = $this->getArray($sql);
    //   if($examen!=null && count($examen)>0){
    //     $examen = $examen[0];
    //     $examen["PREGUNTAS"] = $this->getPreguntas($examen["Exa_IdExamen"], $examen["Exa_NroPreguntas"]);
    //     return $examen;
    //   }
    //   return null;
    // }

    public function getExamenID($examen, $Idi_IdIdioma="es"){
      $sql = "SELECT Exa_IdExamen,
      Cur_IdCurso,
      Moc_IdModulo,
      fn_TraducirContenido('examen','Exa_Titulo', Exa_IdExamen,'$Idi_IdIdioma', Exa_Titulo) Exa_Titulo,
      Exa_Intentos,
      Exa_Restrictivo,
      Exa_Peso,
      Exa_NroPreguntas,
      Exa_FechaDesde,
      Exa_FechaHasta,
      Exa_Porcentaje,
      Exa_FechaReg,
      Lec_IdLeccion,
      Exa_Estado,
      Row_Estado,
      fn_devolverIdioma('examen', Exa_IdExamen,'$Idi_IdIdioma', Idi_IdIdioma) Idi_IdIdioma 
      FROM examen WHERE Exa_IdExamen = {$examen}";
      $examen = $this->getArray($sql);
      return $examen[0];
    }

    public function getPregunta($pregunta){
      $sql = "SELECT * FROM pregunta WHERE Pre_IdPregunta = {$pregunta}
              AND Pre_Estado = 1 AND Row_Estado = 1";
      return $this->getArray($sql);
    }

    public function getExamenxLeccion($Lec_IdLeccion, $Idi_IdIdioma="es")
    {
        try{
            $sql = " SELECT e.Exa_IdExamen,
            e.Cur_IdCurso,
            e.Moc_IdModulo,
            fn_TraducirContenido('examen','Exa_Titulo',e.Exa_IdExamen,'$Idi_IdIdioma',e.Exa_Titulo) Exa_Titulo,
            e.Exa_Intentos,
            e.Exa_Restrictivo,
            e.Exa_Peso,
            e.Exa_NroPreguntas,
            e.Exa_FechaDesde,
            e.Exa_FechaHasta,
            e.Exa_Porcentaje,
            e.Exa_FechaReg,
            e.Lec_IdLeccion,
            e.Exa_Estado,
            e.Row_Estado,
            fn_devolverIdioma('examen',e.Exa_IdExamen,'$Idi_IdIdioma',e.Idi_IdIdioma) Idi_IdIdioma 
            FROM examen e WHERE e.Lec_IdLeccion = $Lec_IdLeccion AND e.Exa_Estado = 1 AND e.Row_Estado = 1 ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getExamenxLeccion", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getExamen($id, $Idi_IdIdioma="es")
    {
        try{
            $sql = " SELECT Exa_IdExamen,
            Cur_IdCurso,
            Moc_IdModulo,
            fn_TraducirContenido('examen','Exa_Titulo', Exa_IdExamen,'$Idi_IdIdioma', Exa_Titulo) Exa_Titulo,
            Exa_Intentos,
            Exa_Restrictivo,
            Exa_Peso,
            Exa_NroPreguntas,
            Exa_FechaDesde,
            Exa_FechaHasta,
            Exa_Porcentaje,
            Exa_FechaReg,
            Lec_IdLeccion,
            Exa_Estado,
            Row_Estado,
            fn_devolverIdioma('examen', Exa_IdExamen,'$Idi_IdIdioma', Idi_IdIdioma) Idi_IdIdioma 
            FROM examen WHERE Exa_IdExamen=$id ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getExamen", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
        
    }
    
    public function getExamenAlumnos($Exa_IdExamen = 0)
    {
        try{
            $sql = " SELECT * FROM examen_alumno WHERE Exa_IdExamen = $Exa_IdExamen ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getExamenAlumnos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getTituloCurso($id, $Idi_IdIdioma = "es")
    {
        try{
            $sql = " SELECT fn_TraducirContenido('curso','Cur_Titulo', Cur_IdCurso,'$Idi_IdIdioma', Cur_Titulo) Cur_Titulo,
            fn_devolverIdioma('curso', Cur_IdCurso,'$Idi_IdIdioma', Idi_IdIdioma) Idi_IdIdioma
            FROM curso WHERE Cur_IdCurso=$id ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getTituloCurso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getExamenesPorcentaje($Cur_IdCurso = 0)
    {
        try{
            $sql = " SELECT SUM(e.Exa_Porcentaje) as Exa_PorcentajeTotal FROM examen e WHERE e.Cur_IdCurso = $Cur_IdCurso AND e.Exa_Estado = 1 AND e.Row_Estado = 1  ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getExamenesPorcentaje", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getTrabajosPorcentaje($Cur_IdCurso = 0)
    {
        try{
            $sql = " SELECT SUM(tra.Tra_Porcentaje) AS Tra_PorcentajeTotal FROM trabajo_leccion tra 
                INNER JOIN leccion lec ON tra.Lec_IdLeccion = lec.Lec_IdLeccion 
                INNER JOIN modulo_curso moc ON lec.Moc_IdModuloCurso = moc.Moc_IdModuloCurso 
                INNER JOIN curso cur ON moc.Cur_IdCurso = cur.Cur_IdCurso 
                WHERE cur.Cur_IdCurso = $Cur_IdCurso AND tra.Tra_Estado = 1 AND tra.Row_Estado = 1 ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getTrabajosPorcentaje", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function insertProgreso($idusu, $idleccion)
    {
        try{
            $sql = " INSERT INTO progreso_curso (Usu_IdUsuario,Lec_IdLeccion,Pro_Valor) VALUES($idusu,$idleccion,1) ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "insertProgreso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function updateProgreso($idusu, $idleccion)
    {
        try{
            $sql = " DELETE FROM progreso_curso WHERE Usu_IdUsuario = $idusu AND Lec_IdLeccion = $idleccion ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "updateProgreso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getUltimoExamen($id, $idusuario)
    {
        try{
            $sql = " SELECT * FROM examen_alumno WHERE Exa_IdExamen = $id AND Usu_IdUsuario = $idusuario ORDER BY Exl_IdExamenAlumno DESC LIMIT 1 ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getUltimoExamen", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getIdExamen($id)
    {
        try{
            $sql = " SELECT Exa_IdExamen FROM examen WHERE Lec_IdLeccion=$id ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getIdExamen", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getExamensPorcentaje($id)
    {
        try{
            $sql = " SELECT SUM(e.Exa_Porcentaje) as Porcentaje FROM examen e WHERE e.Cur_IdCurso = $id AND e.Exa_Estado = 1 AND e.Row_Estado= 1 ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getExamensPorcentaje", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    // jm
    public function getLeccionXId($Lec_IdLeccion){
        try{
            $sql = " SELECT * FROM leccion WHERE Lec_IdLeccion = $Lec_IdLeccion AND Row_Estado = 1 AND Lec_Tipo = 3 ORDER BY Lec_IdLeccion ASC ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getLeccionXId", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getLecciones($id){
        try{
            $sql = " SELECT * FROM leccion WHERE Moc_IdModuloCurso = $id AND Row_Estado = 1 AND Lec_Tipo=3 ORDER BY Lec_IdLeccion ASC ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getLecciones", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getModulos($id, $Idi_IdIdioma = "es"){
        try{
            $sql = " SELECT Moc_IdModuloCurso, 
            fn_TraducirContenido('modulo_curso','Moc_Titulo', Moc_IdModuloCurso,'$Idi_IdIdioma', Moc_Titulo) Moc_Titulo,
            fn_devolverIdioma('modulo_curso', Moc_IdModuloCurso,'$Idi_IdIdioma',Idi_IdIdioma) Idi_IdIdioma
            FROM modulo_curso WHERE Cur_IdCurso=$id AND Moc_Estado=1 AND Row_Estado=1 ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getModulos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function updateExamen($id)
    {
        try{           
            $sql = "UPDATE examen SET
              Exa_Estado = 1
            WHERE Exa_IdExamen = $id";
            $result = $this->_db->prepare($sql);

            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "updateExamen", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getExamenPeso($id)
    {
        try{
            $sql = " SELECT Exa_Peso, Exa_Estado FROM examen WHERE Exa_IdExamen = $id ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getExamenPeso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getPuntosPregunta($id)
    {
        try{
             $sql = " SELECT SUM(Pre_Puntos) AS puntos_pregunta FROM pregunta WHERE Exa_IdExamen=$id AND Pre_Estado=1 AND Row_Estado=1 ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getPuntosPregunta", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getExamensRowCount($condicion = "")
    {
        try{
            $sql = " SELECT COUNT(e.Exa_IdExamen) AS CantidadRegistros, SUM(e.Exa_Porcentaje) as Suma_Porcentaje FROM examen e $condicion ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getExamensRowCount", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getExamensAlumnoRowCount($condicion = "")
    {
        try{
            $sql = " SELECT COUNT(ea.Exa_IdExamen) AS CantidadRegistros, u.Usu_Nombre, u.Usu_Apellidos, e.*, ea.* FROM examen_alumno ea 
                INNER JOIN examen e ON ea.Exa_IdExamen = e.Exa_IdExamen
                INNER JOIN usuario u ON ea.Usu_IdUsuario = u.Usu_IdUsuario $condicion ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getExamensAlumnoRowCount", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getExamensAlumnoCondicion($pagina,$registrosXPagina,$condicion = "")
    {
        try{
            $registroInicio = 0;
            if ($pagina > 0) {
                $registroInicio = ($pagina - 1) * $registrosXPagina;                
            }
            $sql = " SELECT u.Usu_Nombre, u.Usu_Apellidos, e.*, ea.* FROM examen_alumno ea 
                INNER JOIN examen e ON ea.Exa_IdExamen = e.Exa_IdExamen
                INNER JOIN usuario u ON ea.Usu_IdUsuario = u.Usu_IdUsuario $condicion 
                LIMIT $registroInicio, $registrosXPagina ";
            $result = $this->_db->query($sql);
            // echo $sql;
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            dump($exception);
            $this->registrarBitacora("elearning(examenModel)", "getExamensAlumnoCondicion", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getExamensCondicion($pagina,$registrosXPagina,$condicion = "")
    {
        try{
            $registroInicio = 0;
            if ($pagina > 0) {
                $registroInicio = ($pagina - 1) * $registrosXPagina;                
            }
            $sql = " SELECT e.*,(SELECT COUNT(ea.Exa_IdExamen) FROM examen_alumno ea WHERE ea.Exa_IdExamen=e.Exa_IdExamen LIMIT 1) AS Emitido FROM examen e $condicion 
                LIMIT $registroInicio, $registrosXPagina ";
                
            $result = $this->_db->query($sql);
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getExamensCondicion", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getExamensModulo($id)
    {
        try{
            $sql = " SELECT * FROM EXAMEN WHERE Moc_IdModulo=$id AND Lec_IdLeccion IS NOT NULL AND ROW_ESTADO=1 AND EXA_ESTADO=1 ";
            $result = $this->_db->query($sql);
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getExamensModulo", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function cambiarEstadoexamens($Rol_IdRol, $Rol_Estado)
    {
        try{
            if($Rol_Estado==0)
            {
                $sql = "call s_u_cambiar_estado_examen(?,1)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Rol_IdRol, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);                
            }
            if($Rol_Estado==1)
            {
                $sql = "call s_u_cambiar_estado_examen(?,0)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Rol_IdRol, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);
            }
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "cambiarEstadoexamens", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function insertExamen($iCur_IdCurso, $iIdi_IdIdioma, $iMoc_IdModulo, $iExa_Titulo, $iExa_Porcentaje, $iExa_Peso, $iExa_Intentos, $iLec_IdLeccion){
        try {             
            $sql = "call s_i_examen(?,?,?,?,?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iCur_IdCurso, PDO::PARAM_INT);
            $result->bindParam(2, $iMoc_IdModulo, PDO::PARAM_INT);
            $result->bindParam(3, $iExa_Titulo, PDO::PARAM_STR);
            $result->bindParam(4, $iExa_Porcentaje, PDO::PARAM_INT); 
            $result->bindParam(5, $iExa_Peso, PDO::PARAM_INT); 
            $result->bindParam(6, $iExa_Intentos, PDO::PARAM_INT);
            $result->bindParam(7, $iLec_IdLeccion, PDO::PARAM_INT);
            $result->bindParam(8, $iIdi_IdIdioma, PDO::PARAM_STR);
                                
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "inserteExamen", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function editExamen($iCur_IdCurso,$iMoc_IdModulo, $iExa_Titulo, $iExa_Porcentaje, $iExa_Peso, $iExa_Intentos,$iLec_IdLeccion, $iExa_IdExamen){
        
        try {             
            $sql = "call s_u_examen(?,?,?,?,?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iCur_IdCurso, PDO::PARAM_INT);
            $result->bindParam(2, $iMoc_IdModulo, PDO::PARAM_INT);
            $result->bindParam(3, $iExa_Titulo, PDO::PARAM_STR);
            $result->bindParam(4, $iExa_Porcentaje, PDO::PARAM_INT); 
            $result->bindParam(5, $iExa_Peso, PDO::PARAM_INT); 
            $result->bindParam(6, $iExa_Intentos, PDO::PARAM_INT); 
            $result->bindParam(7, $iLec_IdLeccion, PDO::PARAM_INT);                    
            $result->bindParam(8, $iExa_IdExamen, PDO::PARAM_INT);
            $result->execute();
            return $result->rowCount();
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "inserteExamen", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getPreguntasAll($pagina = 1, $registrosXPagina = 1, $activos = 1)
    {
        try{
            $sql = "call s_s_listar_preguntas_All(?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $pagina, PDO::PARAM_INT);
            $result->bindParam(2, $registrosXPagina, PDO::PARAM_INT);
            $result->bindParam(3, $activos, PDO::PARAM_INT);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getPreguntasAll", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function getPreguntasRowCount($condicion = "")
    {
        try{
            $sql = " SELECT COUNT(Pre_IdPregunta) AS CantidadRegistros FROM pregunta $condicion ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getPreguntasRowCount", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getExamenesRowCount($condicion = "")
    {
        try{
            $sql = " SELECT COUNT(e.Exa_IdExamen) AS CantidadRegistros FROM examen e $condicion ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getExamenesRowCount", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getPreguntasCondicion($pagina,$registrosXPagina,$condicion = "", $Idi_IdIdioma = "es")
    {
        try{
            $registroInicio = 0;
            if ($pagina > 0) {
                $registroInicio = ($pagina - 1) * $registrosXPagina;                
            }
            $sql = " SELECT p.Pre_IdPregunta,
            p.Exa_IdExamen,
            fn_TraducirContenido('pregunta','Pre_Descripcion', p.Pre_IdPregunta,'$Idi_IdIdioma', p.Pre_Descripcion) Pre_Descripcion,
            fn_TraducirContenido('pregunta','Pre_Descripcion2', p.Pre_IdPregunta,'$Idi_IdIdioma', p.Pre_Descripcion2) Pre_Descripcion2,
            p.Pre_FechaReg,
            p.Pre_Valor,
            p.Pre_Tipo,
            p.Pre_Puntos,
            p.Pre_Estado,
            p.Row_Estado,
            fn_devolverIdioma('pregunta', p.Pre_IdPregunta,'$Idi_IdIdioma', p.Idi_IdIdioma) Idi_IdIdioma
            FROM pregunta p $condicion 
                LIMIT $registroInicio, $registrosXPagina ";
            $result = $this->_db->query($sql);
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getPreguntasCondicion", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getPreguntas($examen, $Idi_IdIdioma = "es")
    {
        try{
            $sql = "  SELECT p.Pre_IdPregunta,
            p.Exa_IdExamen,
            fn_TraducirContenido('pregunta','Pre_Descripcion', p.Pre_IdPregunta,'$Idi_IdIdioma', p.Pre_Descripcion) Pre_Descripcion,
            fn_TraducirContenido('pregunta','Pre_Descripcion2', p.Pre_IdPregunta,'$Idi_IdIdioma', p.Pre_Descripcion2) Pre_Descripcion2,
            p.Pre_FechaReg,
            p.Pre_Valor,
            p.Pre_Tipo,
            p.Pre_Puntos,
            p.Pre_Estado,
            p.Row_Estado,
            fn_devolverIdioma('pregunta', p.Pre_IdPregunta,'$Idi_IdIdioma', p.Idi_IdIdioma) Idi_IdIdioma
            FROM pregunta p WHERE p.Exa_IdExamen=$examen AND p.Pre_Estado=1 AND p.Row_Estado=1 order by rand()";
            $result = $this->_db->query($sql);
            $preguntas = $result->fetchAll(PDO::FETCH_ASSOC);    
            
            $resultado = array();
            $indice = 1;

            foreach ($preguntas as $i) {
                if($i["Pre_Tipo"]==1||$i["Pre_Tipo"]==2||$i["Pre_Tipo"]==3||$i["Pre_Tipo"]==4||$i["Pre_Tipo"]==7){
                    try{
                        $i["Alt"] = $this->getAlternativas($i["Pre_IdPregunta"]);

                    } catch (PDOException $exception) {
                    $this->registrarBitacora("elearning(examenModel)", "getAlternativas", "Error Model", $exception);
                    return $exception->getTraceAsString();}
                }

                $i["INDEX"] = $indice; $indice++;
                array_push($resultado, $i);       
            }

            return $resultado;

        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getPreguntas", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    // public function getPreguntas($examen, $nro){
    //   $sql = "SELECT * FROM pregunta 
    //           WHERE Exa_IdExamen = {$examen}
    //           AND Pre_Estado = 1 AND Row_Estado = 1 ORDER BY RAND() LIMIT {$nro}";
    //   $preguntas = $this->getArray($sql);
    //   $resultado = array();
    //   $indice = 1;
    //   foreach ($preguntas as $i) {
    //     if($i["TP_IdTpoPregunta"]==1){
    //       $i["ALTERNATIVAS"] = $this->getAlternativas($i["Pre_IdPregunta"]);
    //     }
    //     $i["INDEX"] = $indice; $indice++;
    //     array_push($resultado, $i);
    //   }
    //   return $resultado;
    // }

    public function cambiarEstadopreguntas($Pre_IdPregunta, $Pre_Estado)
    {
        try{
            if($Pre_Estado==0)
            {
                $sql = "call s_u_cambiar_estado_pregunta(?,1)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Pre_IdPregunta, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);                
            }
            if($Pre_Estado==1)
            {
                $sql = "call s_u_cambiar_estado_pregunta(?,0)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Pre_IdPregunta, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);
            }
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "cambiarEstadopreguntas", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function cambiarEstadoExamen($Exa_IdExamen, $Exa_Estado)
    {
        try{
            if($Exa_Estado == 0)
            {
                $sql = "call s_u_cambiar_estado_examen(?,1)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Exa_IdExamen, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);                
            }
            if($Exa_Estado == 1)
            {
                $sql = "call s_u_cambiar_estado_examen(?,0)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Exa_IdExamen, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);
            }
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "cambiarEstadoExamen", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function eliminarHabilitarexamen($iMod_Idpregunta = 0, $iRow_Estado = 0)
    {
        // echo $iMod_Idpregunta."fdffff".$iRow_Estado;
        try{
            $sql = "call s_u_habilitar_deshabilitar_examen(?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iMod_Idpregunta, PDO::PARAM_INT);
            $result->bindParam(2, $iRow_Estado, PDO::PARAM_INT);
            $result->execute();
            
            return $result->rowCount(PDO::FETCH_ASSOC); 

        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "eliminarHabilitarexamen", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function eliminarHabilitarpregunta($iMod_Idpregunta = 0, $iRow_Estado = 0)
    {
        try{
            $sql = "call s_u_habilitar_deshabilitar_pregunta(?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iMod_Idpregunta, PDO::PARAM_INT);
            $result->bindParam(2, $iRow_Estado, PDO::PARAM_INT);
            $result->execute();
            
            return $result->rowCount(PDO::FETCH_ASSOC); 

        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "eliminarHabilitarpregunta", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function insertPregunta($examen, $descripcion, $valor, $tipo, $descripcion2='', $puntos, $idioma){
        try {             
            $sql = "call s_i_pregunta(?,?,?,?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $examen, PDO::PARAM_INT);
            $result->bindParam(2, $descripcion, PDO::PARAM_STR);
            $result->bindParam(3, $valor, PDO::PARAM_STR); 
            $result->bindParam(4, $tipo, PDO::PARAM_INT); 
            $result->bindParam(5, $descripcion2, PDO::PARAM_STR);
            $result->bindParam(6, $puntos, PDO::PARAM_INT);                    
            $result->bindParam(7, $idioma, PDO::PARAM_STR);
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "insertPregunta", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function updatePregunta($pregunta, $descripcion, $valor, $puntos){
        try {             
            $sql = " UPDATE pregunta  SET
              Pre_Descripcion = '$descripcion',
              Pre_Valor = '$valor',
              Pre_Puntos = $puntos,
              Pre_FechaReg = NOW()
            WHERE Pre_IdPregunta = $pregunta";
            $result = $this->_db->prepare($sql);                
            $result->execute();
            return $result->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "updatePregunta", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function updatePregunta2($pregunta, $descripcion, $descripcion2, $valor, $puntos){
        try {             
            $sql = "UPDATE pregunta SET
              Pre_Descripcion = '$descripcion',
              Pre_Descripcion2 = '$descripcion2',
              Pre_Valor = '$valor',
              Pre_Puntos = $puntos,
              Pre_FechaReg = NOW()
            WHERE Pre_IdPregunta = $pregunta";
            $result = $this->_db->prepare($sql);                
            $result->execute();
            return $result->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "updatePregunta2", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function insertAlternativa($pregunta, $valor, $descripcion, $relacion=0, $check=0, $puntos=0, $idioma = false){
        $idioma = $idioma ?: Cookie::lenguaje();
        try {             
            $sql = "call s_i_alternativa(?,?,?,?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $pregunta, PDO::PARAM_STR);
            $result->bindParam(2, $valor, PDO::PARAM_INT);
            $result->bindParam(3, $descripcion, PDO::PARAM_STR); 
            $result->bindParam(4, $relacion, PDO::PARAM_INT); 
            $result->bindParam(5, $check, PDO::PARAM_INT);   
            $result->bindParam(6, $puntos, PDO::PARAM_STR);                 
            $result->bindParam(7, $idioma, PDO::PARAM_STR);                 
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "insertAlternativa", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function updateRelacionAlternativa($pregunta, $descripcion){
        try {             
            $sql = "UPDATE alternativa SET
              Alt_Relacion = $descripcion
            WHERE Alt_IdAlternativa = $pregunta";
            $result = $this->_db->prepare($sql);                
            $result->execute();
            return $result->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "updateRelacionAlternativa", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function getAlternativas($pregunta = "", $Idi_IdIdioma = "es")
    {
        try{
            $sql = " SELECT Alt_IdAlternativa,
            Pre_IdPregunta,
            fn_TraducirContenido('alternativa','Alt_Etiqueta',Alt_IdAlternativa,'$Idi_IdIdioma',Alt_Etiqueta) Alt_Etiqueta,
            Alt_Valor,
            Alt_FechaReg,
            Alt_Relacion,
            Alt_Check,
            Alt_Puntos,
            Alt_Estado,
            Row_Estado,
            fn_devolverIdioma('alternativa',Alt_IdAlternativa,'$Idi_IdIdioma',Idi_IdIdioma) Idi_IdIdioma
            FROM alternativa WHERE Pre_IdPregunta = $pregunta ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getAlternativas", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function deleteAlternativa($pregunta = "")
    {
        try{
            $sql = " DELETE FROM alternativa WHERE Pre_IdPregunta = $pregunta ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "deleteAlternativa", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function getValorPregunta($pregunta = "", $idioma_id = false)
    {
        try{
            // $sql = "
            // SELECT 
            // *
            // FROM pregunta WHERE Pre_IdPregunta = $pregunta 
            // ";
            if ($idioma_id) {
                Pregunta::setForceLang($idioma_id);
            }
            $pre = Pregunta::find($pregunta);
            // $result = $this->_db->prepare($sql);
            // $result->execute();
            // return $result->fetch(PDO::FETCH_ASSOC);
            return $pre != null ? $pre->toArray() : [];
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getValorPregunta", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function getMaxIntentos($idexamen)
    {
        try{
            $sql = " SELECT Exa_Intentos FROM examen WHERE Exa_IdExamen=$idexamen ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getMaxIntentos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    // Intentos y Respuestas
    public function getIntentos($idexamen, $idusuario)
    {
        try{
            $sql = " SELECT COUNT(ea.Exa_IdExamen) as intentos FROM examen_alumno ea WHERE ea.Exa_IdExamen=$idexamen AND ea.Usu_IdUsuario=$idusuario ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getIntentos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function cambiarEstadoExamenAlumno($Exl_IdExamenAlumno, $Exa_Estado)
    {
        try{
            if($Exa_Estado == 0)
            {
                $sql = "call s_u_cambiar_estado_examen_alumno(?,1)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Exl_IdExamenAlumno, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);                
            }
            if($Exa_Estado == 1)
            {
                $sql = "call s_u_cambiar_estado_examen_alumno(?,0)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Exl_IdExamenAlumno, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);
            }
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "cambiarEstadoExamenAlumno", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    public function insertExamenAlumno($iExa_IdExamen, $iUsu_IdUsuario){
        try {             
            $sql = "call s_i_examen_alumno(?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $iExa_IdExamen, PDO::PARAM_INT);
            $result->bindParam(2, $iUsu_IdUsuario, PDO::PARAM_INT);            
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "insertExamenAlumno", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function insertRespuesta($Pre_IdPregunta=0, $Exl_IdExamenAlumno=0, $Alt_IdAlternativa=0,$iAlt_IdAlternativa_Relacion=0, $Res_Respuesta="", $puntos=0){
        try {
            $sql = "call s_i_respuesta(?,?,?,?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $Pre_IdPregunta, PDO::PARAM_INT);
            $result->bindParam(2, $Exl_IdExamenAlumno, PDO::PARAM_INT);
            $result->bindParam(3, $Alt_IdAlternativa, PDO::PARAM_INT); 
            $result->bindParam(4, $iAlt_IdAlternativa_Relacion, PDO::PARAM_INT); 
            $result->bindParam(5, $Res_Respuesta, PDO::PARAM_STR);
            $result->bindParam(6, $puntos, PDO::PARAM_STR);                   
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "insertRespuesta", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getRespuestas($id)
    {
        try{
            $sql = "SELECT p.Pre_IdPregunta, p.Pre_Descripcion,p.Pre_Descripcion2, p.Pre_Tipo, p.Pre_Puntos, r.Res_IdRespuesta  FROM respuesta r INNER JOIN pregunta p ON r.Pre_IdPregunta=p.Pre_IdPregunta WHERE Exl_IdExamenAlumno=$id GROUP BY p.Pre_IdPregunta";
            $result = $this->_db->query($sql);
            $preguntas = $result->fetchAll(PDO::FETCH_ASSOC);    
            
            $resultado = array();
            $indice = 1;

            foreach ($preguntas as $i) {
                if($i["Pre_Tipo"]==1||$i["Pre_Tipo"]==2||$i["Pre_Tipo"]==7){
                    try{
                        $i["Rpta"] = $this->getRespuestasTipos127($id, $i["Pre_IdPregunta"]);

                    } catch (PDOException $exception) {
                    $this->registrarBitacora("elearning(examenModel)", "getAlternativas", "Error Model", $exception);
                    return $exception->getTraceAsString();}
                }

                else if($i["Pre_Tipo"]==3||$i["Pre_Tipo"]==5){
                    try{
                        $i["Rpta"] = $this->getRespuestasTipos35($id, $i["Pre_IdPregunta"]);

                    } catch (PDOException $exception) {
                    $this->registrarBitacora("elearning(examenModel)", "getAlternativas", "Error Model", $exception);
                    return $exception->getTraceAsString();}
                }

                 else {
                    try{
                        $i["Rpta"] = $this->getRespuestasTipos4($id, $i["Pre_IdPregunta"]);

                    } catch (PDOException $exception) {
                    $this->registrarBitacora("elearning(examenModel)", "getAlternativas", "Error Model", $exception);
                    return $exception->getTraceAsString();}
                }
                $i["INDEX"] = $indice; $indice++;
                array_push($resultado, $i);       
            }

            return $resultado;

        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getPreguntas", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function getRespuestasTipos127($idexamen, $idpregunta)
    {
        try{
            $sql = " SELECT r.*,a.Alt_Etiqueta FROM respuesta r INNER JOIN alternativa a ON a.Alt_IdAlternativa=r.Alt_IdAlternativa WHERE Exl_IdExamenAlumno=$idexamen AND r.Pre_IdPregunta=$idpregunta ";
            $result = $this->_db->query($sql);
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getRespuestasTipos127", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function getRespuestasTipos4($idexamen, $idpregunta)
    {
        try{
            $sql = " SELECT r.*,a.Alt_Etiqueta rpta, ar.Alt_Etiqueta rpta2 FROM respuesta r INNER JOIN alternativa a ON a.Alt_IdAlternativa=r.Alt_IdAlternativa 
INNER JOIN alternativa ar ON ar.Alt_IdAlternativa=r.Alt_IdAlternativa_Relacion
WHERE Exl_IdExamenAlumno=$idexamen AND r.Pre_IdPregunta= $idpregunta";
            $result = $this->_db->query($sql);
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getRespuestasTipos4", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function getRespuestasTipos35($idexamen, $idpregunta)
    {
        try{
            $sql = " SELECT r.* FROM respuesta r WHERE Exl_IdExamenAlumno=$idexamen AND r.Pre_IdPregunta=$idpregunta ";
            $result = $this->_db->query($sql);
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "getRespuestasTipos35", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function updatePuntosRespuestaAbierta($pregunta, $descripcion){
        try {             
            $sql = "UPDATE respuesta SET
              Res_Puntos = $descripcion
            WHERE Res_IdRespuesta = $pregunta";
            $result = $this->_db->prepare($sql);                
            $result->execute();
            return $result->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "updatePuntosRespuestaAbierta", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function updateNotaExamen($pregunta, $descripcion){
        try {             
            $sql = " UPDATE examen_alumno SET
              Exl_Nota = $descripcion
            WHERE Exl_IdExamenAlumno = $pregunta";
            $result = $this->_db->prepare($sql);                
            $result->execute();
            return $result->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(examenModel)", "updateNotaExamen", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    // public function insertRespuesta($usuario, $pregunta, $respuesta, $intentos){
    //   if($intentos > 0){
    //     $nuevo = $intentos + 1;
    //     $sql = "INSERT INTO respuesta(Pre_IdPregunta, Usu_IdUsuario, Res_Descripcion, Res_Intento, Res_Estado)
    //     VALUES({$pregunta}, {$usuario}, '{$respuesta}', {$nuevo}, 1)";
    //   }else{
    //     $sql = "INSERT INTO respuesta(Pre_IdPregunta, Usu_IdUsuario, Res_Descripcion, Res_Intento, Res_Estado)
    //     VALUES({$pregunta}, {$usuario}, '{$respuesta}', 1, 1)";
    //   }
    //   $this->execQuery($sql);
    // }

    // public function getIntentos($examen, $usuario){
    //   $sql = "SELECT ifnull( MAX(R.Res_Intento), 0) INTENTOS FROM respuesta R
    //           INNER JOIN pregunta P ON R.Pre_IdPregunta = P.Pre_IdPregunta
    //           INNER JOIN examen E ON P.Exa_IdExamen = E.Exa_IdExamen
    //           WHERE E.Exa_IdExamen = {$examen} AND R.Usu_IdUsuario = {$usuario}
    //             AND E.Exa_Estado = 1 AND E.Row_Estado = 1 
    //             AND P.Pre_Estado = 1 AND P.Row_Estado = 1 
    //             AND R.Row_Estado = 1";
    //   $data = $this->getArray($sql);

    //   if($data != null && count($data) > 0 ){
    //     return $data[0]["INTENTOS"];
    //   }else{
    //     return 0;
    //   }
    // }

    // public function getRespuestas($usuario){
    //   $sql = "SELECT * FROM alternativa WHERE Pre_IdPregunta = {$pregunta}
    //           AND Alt_Estado = 1 AND Row_Estado = 1 ORDER BY RAND()";
    //   return $this->getArray($sql);
    // }
}
