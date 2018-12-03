<?php

namespace App;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class FormularioUsuarioRespuestasDetalles extends Eloquent
{
	protected $table = 'formulario_usuario_respuestas_detalles';
  protected $primaryKey = 'Fre_IdForRespuestas';
  const CREATED_AT = 'Fre_CreatedAt';
  const UPDATED_AT = 'Fre_UpdatedAt';

  public function pregunta () {
  	return $this->belongsTo('App\FormularioPreguntas', 'Fpr_IdForPreguntas');
  }

  public function opcion () {
  	return $this->belongsTo('App\FormularioPreguntasOpciones', 'Fpo_IdForPrOpc');
  }

  public function respuesta () {
  	return $this->belongsTo('App\FormularioUsuarioRespuestas', 'Fur_IdFrmUsuRes');
  }

  public static function existePregunta ($pregunta_id) {
  	$t = self::where('Fpr_IdForPreguntas', $pregunta_id)->get();
  	return $t->count() >  0 ? true : false;
  }

  public static function getByPregunta ($pregunta_id) {
  	return self::where('Fpr_IdForPreguntas', $pregunta_id)->get();
  }

  public function formatToArray ($exclude = []) {
    return [
      'id' => $this->Fre_IdForRespuestas,
      'respuesta_id' => $this->Fur_IdFrmUsuRes,
      'pregunta_id' => $this->Fpr_IdForPreguntas,
      'opcion_id' => $this->Fpo_IdForPrOpc,
      'respuesta' => $this->Fre_Respuesta,
      'create' => $this->Fre_CreatedAt,
      'update' => $this->Fre_UpdatedAt,
      'auxiliar' => $this->Fre_Auxiliar
    ];
  }
}

?>