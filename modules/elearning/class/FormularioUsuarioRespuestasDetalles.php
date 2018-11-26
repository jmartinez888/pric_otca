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
}

?>