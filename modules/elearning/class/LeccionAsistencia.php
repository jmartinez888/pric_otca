<?php

namespace App;
use App\LeccionSession;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class LeccionAsistencia extends Eloquent
{
  protected $table = 'leccion_asistencia';
  protected $primaryKey = 'Lea_IdLeccAsis';
  const CREATED_AT = 'Lea_CreatedAt';
  const UPDATED_AT = 'Lea_UpdatedAt';
  
  public const ASISTENCIA_FALTA = 0;
  public const ASISTENCIA_CONFIRMADA = 1;

  public static function byLeccionAndAlumno ($leccion_id, $alumno_id) {
    return self::where('Lec_IdLeccion', $leccion_id)
      ->where('Usu_IdUsuario', $alumno_id)
      ->first();
  }

  public  function leccion () {
    return $this->belongsTo('App\Leccion', 'Lec_IdLeccion');
  }

  public function detalles () {
    return $this->hasMany('App\LeccionAsistenciaDetalles', 'Lea_IdLeccAsis');
  }

  public  function usuario () {
    return $this->belongsTo('App\Usuario', 'Usu_IdUsuario');
  }

  public function scopeGetByUsuarioAndLeccion ($query, $usuario_id, $leccion_id) {
    return $query->where('Usu_IdUsuario', $usuario_id)
      ->where('Lec_IdLeccion', $leccion_id);
  }

  public function scopeSelectParaAsistencia ($query, $leccion_id, $docente_id) {
    return $query->addSelect(
      'leccion_asistencia.*',
      DB::raw("MAX(Lea_Asistencia) as confirma_asistencia"),
      DB::raw("CONCAT(usuario.Usu_Nombre, ' ', usuario.Usu_Apellidos) as nombre_completo")
    )->join('usuario', 'usuario.Usu_IdUsuario', 'leccion_asistencia.Usu_IdUsuario')
    ->where('leccion_asistencia.Lec_IdLeccion', $leccion_id)
    ->whereNotIn('leccion_asistencia.Usu_IdUsuario', [$docente_id])
    ->groupBy('leccion_asistencia.Usu_IdUsuario');
    
  }
  public function scopeHhhh ($query) {
    return $query->join('usuario', 'usuario.Usu_IdUsuario', 'leccion_asistencia.Usu_IdUsuario')
    ->where('leccion_asistencia.Lec_IdLeccion', $leccion_id)
    ->whereNotIn('leccion_asistencia.Usu_IdUsuario', [$docente_id])
    ->groupBy('leccion_asistencia.Usu_IdUsuario');
  }
  public function scopeSelectParaAsistenciaComplemento ($query) {
    return $query->addSelect('usuario.Usu_IdUsuario',
      'usuario.Usu_Nombre',
      'usuario.Usu_Apellidos',
      DB::raw("(SELECT MIN(Lead_Ingreso) from leccion_asistencia_detalles lad WHERE lad.Lea_IdLeccAsis = leccion_asistencia.Lea_IdLeccAsis limit 1) as fecha_min"),
      DB::raw("(SELECT MAX(Lead_Salida) from leccion_asistencia_detalles lad WHERE lad.Lea_IdLeccAsis = leccion_asistencia.Lea_IdLeccAsis limit 1) as fecha_max"),
      // DB::raw("CONCAT(usuario.Usu_Nombre, ' ', usuario.Usu_Apellidos) as nombre_completo"),
      DB::raw("GROUP_CONCAT(Les_IdLeccSess SEPARATOR '-') as str_sessiones"),
      DB::raw('COUNT(Lea_IdLeccAsis) as total_sessiones')
    );
  }
  public function getByUsuario ($usuario_id) {
    return self::where('Usu_IdUsuario', $usuario_id)
      ->first();
  }
  
  public function formatToArray ($exclude = []) {
    return [
      'id'      => $this->Lea_IdLeccAsis,
      'usuario_id' => $this->Usu_IdUsuario,
      'leccion_id' => $this->Lec_IdLeccion,
      'leccion_session_id' => $this->Les_IdLeccSess,
      'tiempo'  => $this->Lea_Tiempo,
      'inicio'  => $this->Lea_Inicio,
      'fin'     => $this->Lea_Fin,
      'modo'     => $this->Lea_Modo,
      'nombre_completo'     => $this->nombre_completo,
      'asistencia'     => $this->Lea_Asistencia
    ];
  }
}

?>