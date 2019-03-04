<?php

namespace App;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class LeccionSession extends Eloquent
{
  protected $table = 'leccion_session';
  protected $primaryKey = 'Les_IdLeccSess';
  public $timestamps = false;

  public const CONCLUIDO      = 1;
  public const NO_CONCLUIDO   = 0;
  public const TIPO_NONE      = 0;
  public const TIPO_ESPERA    = 1;
  public const TIPO_ONLINE    = 2;

  public  function leccion () {
    return $this->belongsTo('App\Leccion', 'Lec_IdLeccion');
  }
  public function asistencias () {
    return $this->hasMany('App\LeccionAsistencia', 'Les_IdLeccSess');
  }
  public static function getSession ($leccion_id) {
    
  }

  public function links_video () {
    return $this->hasMany('App\LeccionSessionLinkVideo', 'Les_IdLeccSess');
  }
  public function scopeSelectParaAsistencia ($query) {
    return $query->select('Les_IdLeccSess', 'Lec_IdLeccion', 'Les_Tipo');
  }

  public static function getSessionByHashAndID ($hash, $leccion_id, $solo_concluidas = false) {
    $build = self::where('Les_Hash', $hash)->where('Les_IdLeccSess', $leccion_id);
    if ($solo_concluidas) {
      $build->where('Les_Concluido', self::CONCLUIDO);
    }
    return $build->first();
      
  }

  public static function getSessionByHash ($hash, $solo_concluidas = false) {
    $build = self::where('Les_Hash', $hash);
    if ($solo_concluidas) {
      $build->where('Les_Concluido', self::CONCLUIDO);
    }
    return $build->first();
      
  }

  public function concluir ($fecha = false) {
    $this->Les_DateFin = $fecha ? $fecha : DB::raw('NOW()');
    $this->Les_Concluido = LeccionSession::CONCLUIDO;
    $this->save();
  }

  public static function existeHash ($hash, $solo_concluidas = false) {
    return self::getSessionByHash($hash, $solo_concluidas) != null;
  }

  public static function validaHashLeccion ($leccion_id, $hash) {
      $session = self::getSessionByHash($hash);
      if ($session) {
        return $session->Lec_IdLeccion == $leccion_id;
      }
      return false;

    
  }
  // public function formatToArray ($exclude = []) {
  //   return [
  //     'id' => $this->Frm_IdFormulario,
  //     'titulo' => $this->Frm_Titulo,
  //     'descripcion' => $this->Frm_Descripcion,
  //     'create' => $this->Frm_CreatedAt,
  //     'update' => $this->Frm_UpdatedAt,
  //     'curso_id' => $this->Cur_IdCurso,
  //     'estado' => $this->Frm_Estado
  //   ];
  // }
}

?>