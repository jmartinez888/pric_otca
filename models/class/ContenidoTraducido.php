<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;

class ContenidoTraducido extends Eloquent
{
  protected $table = 'contenido_traducido';
  protected $primaryKey = 'Cot_IdContenidoTraducido';
  public $timestamps = false;

  public static function getRow ($table, $id, $lenguaje) {
  	return self::where('Cot_Tabla', $table)
  							->where('Cot_IdRegistro', $id)
  							->where('Idi_IdIdioma', $lenguaje)
  							->get();
  }
  /**
	  values = [
	  	'columna'	 => 'new_value'
	  ]
  */
  public static function updateRow ($table, $id, $idioma, $values, $create_new = false) {
  	foreach ($values as $key => $value) {
	  	$temp = self::where('Cot_Tabla', $table)
	    	->where('Cot_IdRegistro', $id)
	    	->where('Cot_Columna', $key)
	    	->where('Idi_IdIdioma', $idioma);

      if ($create_new) {
        $row = $temp->get();
        if ($row->count() > 0) {
          // $row->first()->update(['Cot_Traduccion' => $value]);
          $temp->update(['Cot_Traduccion' => $value]);
        } else {
          $ct = new ContenidoTraducido();
          $ct->Cot_Tabla = $table;
          $ct->Cot_IdRegistro = $id;
          $ct->Cot_Columna = $key;
          $ct->Idi_IdIdioma = $idioma;
          $ct->Cot_Traduccion = $value;
          $ct->save();
        }
      } else {
	    	$temp->update(['Cot_Traduccion' => $value]);
      }
      // if ($temp->count)
	    // else {

	    // }

  	}
  }
}