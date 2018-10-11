<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;

class UsuarioForo extends Eloquent
{
  protected $table = 'usuario_foro';
  protected $primaryKey = ['Usu_IdUsuario', 'For_IdForo'];
	public $incrementing = false;
  public $timestamps = false;


}
