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