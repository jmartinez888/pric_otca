<?php

namespace App;

use App\LeccionSession;
use Illuminate\Database\Eloquent\Model as Eloquent;
use Illuminate\Database\Capsule\Manager as DB;

class Leccion extends Eloquent
{
  protected $table = 'leccion';
  protected $primaryKey = 'Lec_IdLeccion';
  public $timestamps = false;

  public const ESTADO_NOINICIADO  = 0;
  public const ESTADO_INICIADO    = 1;

  public  const TIPO_HTML             = 1;
  public  const TIPO_VIDEO            = 2;
  public  const TIPO_EXAMEN           = 3;
  public  const TIPO_DIRIGIDA         = 4;
  public  const TIPO_EXAMEN_DIRIGIDO  = 5;
  public  const TIPO_ENCUESTA         = 10;

  protected $guarded = ['docente_id'];

  public function modulo () {
  	return $this->belongsTo('App\ModuloCurso', 'Moc_IdModuloCurso');
  }
  
  public function leccion_formulario () {
  	return $this->hasOne('App\LeccionFormulario', 'Lec_IdLeccion');
  }
  
  public function leccion_asistencia () {
  	return $this->hasMany('App\LeccionAsistencia', 'Lec_IdLeccion');
  }
  
  public function sessiones () {
  	return $this->hasMany('App\LeccionSession', 'Lec_IdLeccion');
  }

  public function getSessionActiva () {
    return $this->sessiones()->where('Les_Concluido', 0)
      ->where('Les_Tipo', LeccionSession::TIPO_ONLINE)
      ->orderBy('Les_DateInicio', 'asc')->first();
  }
  /**
   * [getSessionEnEspera description]
   *
   * @param   [$fecha]   [type DateTime]
   * @return  [type]    [return description]
   */
  public function getSessionEnEspera ($fecha) {
    return $this->sessiones()->where('Les_Concluido', 0)
      ->where('Les_Tipo', LeccionSession::TIPO_ESPERA)
      ->where(DB::raw('DATE(Les_DateInicio)'), $fecha)
      ->orderBy('Les_DateInicio', 'asc')->first();
  }

  public function generarSessionDeEspera ($fecha_inicio, $usuario_id) {
    $ls = new LeccionSession();
    $ls->Lec_IdLeccion = $this->Lec_IdLeccion;
    $ls->Les_DateInicio = $fecha_inicio;
    $ls->Usu_IdUsuario = $usuario_id;
    $ls->Les_Tipo = LeccionSession::TIPO_ESPERA;
    //do {
      $date = new \DateTime();
      $thash = self::hashLeccion($this->Lec_IdLeccion, $this->getDocente(), $date->format('Y-m-d'));
    //} while(LeccionSession::existeHash($thash));
    $ls->Les_Hash = $thash;
    return $ls->save() ? $ls : null;
  }

  public function getSessionOnline () {
    return $this->getSessionActiva() != null && $this->Lec_LMSEstado == Leccion::ESTADO_INICIADO;
  }
  /**
   * [getByModulos obtener lecciones por los n módulos assignados]
   * @param  [array|string] $modulo_id []
   * @return [array]            [description]
   */
  public function scopegetByModulos ($query, $modulos_id) {
  	return $query->whereIn('Moc_IdModuloCurso', $modulos_id);
  }

  
  public function scopegetEncuestas ($query) {
  	return $query->where('Lec_Tipo', 10);
  }

  public function scopeGetPizarras ($query) {
  	return $query->where('Lec_Tipo', self::TIPO_DIRIGIDA);
  }
  
  public static function hashLeccion ($leccion_id, $docente_id, $extra = '') {
    return md5($leccion_id.$extra).md5($docente_id.$extra);
  }
  public function getCursoID () {
    $res =  $this->modulo()
      ->select('curso.Cur_IdCurso')
      ->join('curso', 'curso.Cur_IdCurso', 'modulo_curso.Cur_IdCurso')
      ->first();
    return $res ? $res->Cur_IdCurso : 0;
    
  }
  
  public function getDocente () {
    // if ($this->docente_id == null) {
      $docente = $this->select('Usu_IdUsuario as docente_id')
        ->join('modulo_curso', 'modulo_curso.Moc_IdModuloCurso', 'leccion.Moc_IdModuloCurso')
        ->join('curso', 'curso.Cur_IdCurso', 'modulo_curso.Cur_IdCurso')
        ->where('leccion.Lec_IdLeccion', $this->Lec_IdLeccion)->first();
      return  $docente ? $docente->docente_id : 0;
    // }
    // return $this->docente_id;
    
  }

  // public function scopeActivos () {

  // }
}
