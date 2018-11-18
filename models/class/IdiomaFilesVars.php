<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;

class IdiomaFilesVars extends Eloquent
{
  protected $table = 'idiomas_files_vars';
  protected $primaryKey = 'Ifv_IdFileVar';
  public $timestamps = false;

  public static function get_var_by_name ($name) {
    return IdiomaFilesVars::where('Ifv_VarName', $name)->first();
  }

  public function scopeByFile($query, $file_id) {
  	return $query->where('Idif_IdIdiomaFile', $file_id);
  }
  public function body () {
    return $this->hasMany('App\IdiomaFilesVarsBody', 'Ifv_IdFileVar');
  }

  public function file () {
    return $this->belongsTo('App\IdiomaFiles', 'Idif_IdIdiomaFile');
  }



  public function formatToArray ($exclude = []) {
    return [
      'id' => $this->Ifv_IdFileVar,
      'variable' => $this->Ifv_VarName,
      'body' => []
    ];
  }
}
