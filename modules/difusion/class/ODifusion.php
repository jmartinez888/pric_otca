<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Capsule\Manager as DB;

class ODifusion extends Eloquent
{
  protected $table = 'ora_difusion';
  protected $primaryKey = 'ODif_IdDifusion';
  public $timestamps = false;


  public function formatToArray ($exclude = []) {
    return [
      'id' => $this->ODif_IdDifusion,
      'titulo' => $this->ODif_Titulo,
      'descripcion' => $this->ODif_Descripcion,
      'estado_item' => $this->ODif_Estado,
      'estado_row' => $this->Row_Estado,
      'idioma_id' => $this->Idi_IdIdioma,
      // 'latitude' => $this->ODii_PosLatitude,
      // 'longitude' => $this->ODii_PosLongitude
    ];
  }

  public function tipo () {
    return $this->belongsTo('App\ODifusionTipo', 'ODit_IdTipoDifusion');
  }

  public function tematica () {
    return $this->belongsTo('App\ForoTematica', 'Lit_IdLineaTematica');
  }

  public function referencias () {
  	return $this->hasMany('App\ODifusionReferencias', 'ODif_IdDifusion');
  }

  public function scopeEventos_interes ($query) {
    return $query->where('ODif_Evento', 1);
  }

  public function scopeDatos_interes ($query) {
  	return $query->where('ODif_Datos', 1);
  }
  public function scopebanner ($query) {
  	return $query->where('ODif_Banner', 1);
  }


  public function scopeActivos ($query) {
    return $query->where('ODif_Estado', 1);
  }
  public function scopeVisibles ($query) {
    return $query->where('Row_Estado', 1);
  }
  public function  scopeBuscarByTitulo($query, $value) {
    // return $query->where('ODif_Titulo', 'like', '%'.$value.'%');
    return $query->where(DB::raw("fn_TraducirContenido('ora_difusion','ODif_Titulo',ora_difusion.ODif_IdDifusion,'".\Cookie::lenguaje()."',ora_difusion.ODif_Titulo)"), 'like', "%".$value."%");
  }
  public function getPalabrasClaves () {
    $palabras = $this->ODif_Palabras;
    $array = explode(',', $palabras);
    foreach ($array as $key => $value) {
      $array[$key] = trim($value);
    }
    return $array;
  }

  public function getRelacionado ($length = 5, $start = 0) {
    $palabras = $this->getPalabrasClaves();
    if (count($palabras) > 0) {
      $q = ODifusion::whereNotIn('ODif_IdDifusion', [$this->ODif_IdDifusion]);
      $q->where(function($query) use ($palabras) {
        foreach ($palabras as $value) {
          $query->orWhere('ODif_Palabras', 'like', '%'.$value.'%');
        }
      });
      $q->offset($start)->limit($length);
      return $q->get();
    }
    return [];

  }

  protected static function boot() {
      parent::boot();

      static::addGlobalScope('translate', function (Builder $builder) {
        $builder->select(
          '*',
          DB::raw("fn_TraducirContenido('ora_difusion','ODif_Titulo',ora_difusion.ODif_IdDifusion,'".\Cookie::lenguaje()."',ora_difusion.ODif_Titulo)  ODif_Titulo"),
          DB::raw("fn_TraducirContenido('ora_difusion','ODif_Descripcion',ora_difusion.ODif_IdDifusion,'".\Cookie::lenguaje()."',ora_difusion.ODif_Descripcion)  ODif_Descripcion"),
          DB::raw("fn_TraducirContenido('ora_difusion','ODif_Contenido',ora_difusion.ODif_IdDifusion,'".\Cookie::lenguaje()."',ora_difusion.ODif_Contenido)  ODif_Contenido"),
          DB::raw("fn_TraducirContenido('ora_difusion','ODif_Palabras',ora_difusion.ODif_IdDifusion,'".\Cookie::lenguaje()."',ora_difusion.ODif_Palabras)  ODif_Palabras")

        );

      });
  }

}
