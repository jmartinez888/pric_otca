<?php

namespace App;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class LeccionAsistencia extends Eloquent
{
  protected $table = 'leccion_asistencia_detalles';
  protected $primaryKey = 'Lead_IdLecAsDet';
  public $timestamps = false;
  
  public  function asistencia () {
    return $this->belongsTo('App\LeccionAsistencia', 'Lea_IdLeccAsis');
  }
  
  // public function formatToArray ($exclude = []) {
  //   return [
  //     'id' => $this->Frm_IdFormulario,
  //     'titulo' => $this->Frm_Titulo,
  //     'descripcion' => $this->Frm_Descripcion,
  //     'create' => $this->Frm_CreatedAt,
  //     'update' => $this->Frm_UpdatedAt,
  //     'curso_id' => $this->Cur_IdCurso,
  //     'estado' => $this->Frm_Estado
  //   ];
  // }
}

?>