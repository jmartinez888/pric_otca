<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;

class ModuloCurso extends Eloquent
{
  protected $table = 'modulo_curso';
  protected $primaryKey = 'Moc_IdModuloCurso';
  public $timestamps = false;

}