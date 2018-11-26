<?php

namespace App;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class FormularioPreguntasOpciones extends Eloquent
{
  protected $table = 'formulario_preguntas_opciones';
  protected $primaryKey = 'Fpo_IdForPrOpc';
  const CREATED_AT = 'Fpo_CreatedAt';
  const UPDATED_AT = 'Fpo_UpdatedAt';

  public function formatToArray ($exclude = []) {
    return [
      'id' => $this->Fpo_IdForPrOpc,
      'opcion' => $this->Fpo_Opcion,
      'orden' => $this->Fpo_Orden,
      'pregunta_id' => $this->Fpr_IdForPreguntas,
      'create' => $this->Fpo_CreatedAt,
      'update' => $this->Fpo_UpdatedAt
    ];
  }
}

?>