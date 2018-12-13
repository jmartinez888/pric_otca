<?php

namespace App;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class Formulario extends Eloquent
{
  protected $table = 'formulario';
  protected $primaryKey = 'Frm_IdFormulario';
  const CREATED_AT = 'Frm_CreatedAt';
  const UPDATED_AT = 'Frm_UpdatedAt';

  public static function getActivoByCursoId ($curso_id) {
    return self::where('Frm_Estado', 1)->where('Cur_IdCurso', $curso_id)->first();
  }

  public function scopeActivos ($query) {
    return $query->where('Frm_Estado', 1);
  }
  public function preguntas () {
    return $this->hasMany('App\FormularioPreguntas', 'Frm_IdFormulario')->whereNull('Fpr_Parent')->orderBy('Fpr_Orden', 'asc');
  }
  public function preguntasTodas () {
    return $this->hasMany('App\FormularioPreguntas', 'Frm_IdFormulario');
  }
  public function leccion_formulario () {
    return $this->hasOne('App\LeccionFormulario', 'Frm_IdFormulario');
  }
  public function respuesta () {
    return $this->hasOne('App\FormularioUsuarioRespuestas', 'Frm_IdFormulario');
  }
  public function respuestas () {
    return $this->hasMany('App\FormularioUsuarioRespuestas', 'Frm_IdFormulario');
  }
  public function getRespuestaByUsuario ($usuario_id) {
    return $this->respuesta()->where('Usu_IdUsuario', $usuario_id)->first();
  }
  public static function getByCurso ($curso_id) {
    return self::where('Cur_IdCurso', $curso_id)->get();
  }
  public function formatToArray ($exclude = []) {
    return [
      'id' => $this->Frm_IdFormulario,
      'titulo' => $this->Frm_Titulo,
      'descripcion' => $this->Frm_Descripcion,
      'create' => $this->Frm_CreatedAt,
      'update' => $this->Frm_UpdatedAt,
      'curso_id' => $this->Cur_IdCurso,
      'estado' => $this->Frm_Estado
    ];
  }
}

?>