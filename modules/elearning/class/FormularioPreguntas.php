<?php

namespace App;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class FormularioPreguntas extends Eloquent
{
  protected $table = 'formulario_preguntas';
  protected $primaryKey = 'Fpr_IdForPreguntas';
  const CREATED_AT = 'Fpr_CreatedAt';
  const UPDATED_AT = 'Fpr_UpdatedAt';

  public function opciones () {
    return $this->hasMany('App\FormularioPreguntasOpciones', 'Fpr_IdForPreguntas');
  }

  public function formatToArray ($exclude = []) {
    return [
      'id' => $this->Fpr_IdForPreguntas,
      'pregunta' => $this->Fpr_Pregunta,
      'descripcion' => $this->Fpr_Descripcion,
      'obligatorio' => $this->Fpr_Obligatorio,
      'posee_des' => $this->Fpr_PoseeDescripcion,
      'orden' => $this->Fpr_Orden,
      'tipo' => $this->Fpr_Tipo,
      'formulario_id' => $this->Frm_IdFormulario,
      'create' => $this->Fpr_CreatedAt,
      'update' => $this->Fpr_UpdatedAt
    ];
  }
}

?>