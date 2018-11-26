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
}

?>