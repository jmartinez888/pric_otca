<?php

namespace App;

use App\Idioma;
use Illuminate\Database\Eloquent\Model as Eloquent;

class IdiomaFilesVarsBody extends Eloquent
{
  protected $table = 'idiomas_files_vars_body';
  protected $primaryKey = 'Ifvb_IdVarBody';
  public $timestamps = false;



  public function var () {
    return $this->belongsTo('App\IdiomaFilesVars', 'Ifv_IdFileVar');
  }


  public function scopeGetByIdioma ($query, $idioma) {
  	return $query->where('idiomas_files_vars_body.Idi_IdIdioma', $idioma);
  }

  public function scopeGetParentsValue ($query) {
  	return $query->rightJoin('idiomas_files_vars', 'idiomas_files_vars_body.Ifv_IdFileVar', 'idiomas_files_vars.Ifv_IdFileVar')
  								->rightJoin('idiomas_files', 'idiomas_files_vars.Idif_IdIdiomaFile', 'idiomas_files.Idif_IdIdiomaFile');
  }


  public function formatToArray ($exclude = []) {
    return [
      'id' => $this->Ifvb_IdVarBody,
      'variable_id' => $this->Ifv_IdFileVar,
      'idioma_id' => $this->Idi_IdIdioma,
      'body' => $this->Ifvb_Body
    ];
  }

}
