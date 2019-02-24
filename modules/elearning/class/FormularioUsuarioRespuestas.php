<?php

namespace App;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class FormularioUsuarioRespuestas extends Eloquent
{
	protected $table = 'formulario_usuario_respuestas';
  protected $primaryKey = 'Fur_IdFrmUsuRes';
  const CREATED_AT = 'Fur_CreatedAt';
  const UPDATED_AT = 'Fur_UpdatedAt';

  public function usuario () {
  	return $this->belongsTo('App\Usuario', 'Usu_IdUsuario');
  }

  public function scopeJoinUsuarios ($query) {
    return $query->leftJoin('usuario', 'usuario.Usu_IdUsuario', 'formulario_usuario_respuestas.Usu_IdUsuario');
  }

  public function detalles () {
  	return $this->hasMany('App\FormularioUsuarioRespuestasDetalles', 'Fur_IdFrmUsuRes');
  }

  public function formulario () {
  	return $this->belongsTo('App\Formulario', 'Frm_IdFormulario');
  }


}

?>