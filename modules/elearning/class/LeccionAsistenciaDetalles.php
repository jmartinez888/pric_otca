<?php

namespace App;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class LeccionAsistenciaDetalles extends Eloquent
{
  protected $table = 'leccion_asistencia_detalles';
  protected $primaryKey = 'Lead_IdLecAsDet';
  public $timestamps = false;
  
  public  function asistencia () {
    return $this->belongsTo('App\LeccionAsistencia', 'Lea_IdLeccAsis');
  }
  
  public function formatToArray ($exclude = []) {
    return [
      'id' => $this->Lead_IdLecAsDet,
      'usuario_id' => $this->Usu_IdUsuario,
      'asistencia_id' => $this->Lea_IdLeccAsis,
      'ingreso' => $this->Lead_Ingreso,
      'salida' => $this->Lead_Salida,
      'fuente' => $this->Lead_Fuente
    ];
  }
}

?>