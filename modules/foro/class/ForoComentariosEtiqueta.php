<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;

class ForoComentariosEtiqueta extends Eloquent
{
  protected $table = 'comentarios_etiquetas';
  protected $primaryKey = 'Cet_IdEtiqueta';
  public $timestamps = false;

  // public static function activos () {
  // 	return self::where('Idi_Estado', 1)->get();
  // }
  // public function scopeActivos () {

  // }

  public static function insertar ($comentario_id, $usuario_id) {
  	$e = new ForoComentariosEtiqueta();
    $e->Com_IdComentario = $comentario_id;
    $e->Usu_IdUsuario = $usuario_id;
    $e->save();

    return $e;
  }
}
