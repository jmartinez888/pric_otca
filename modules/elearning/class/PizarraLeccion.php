<?php

namespace App;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class PizarraLeccion extends Eloquent
{
  protected $table = 'pizarra_leccion';
  protected $primaryKey = 'Piz_IdPizarra';
  public $timestamps = false;

  public  function contenido () {
    return $this->hasOne('App\PizarraLeccionContenido', 'Piz_IdPizarra');
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