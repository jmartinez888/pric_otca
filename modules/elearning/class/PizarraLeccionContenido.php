<?php

namespace App;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class PizarraLeccionContenido extends Eloquent
{
  protected $table = 'pizarra_leccion_contenido';
  protected $primaryKey = 'Plc_IdPizLecCon';
  const CREATED_AT = 'Plc_CreatedAt';
  const UPDATED_AT = 'Plc_UpdatedAt';

  public  function pizarra () {
    return $this->belongsTo('App\PizarraLeccion', 'Piz_IdPizarra');
    
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