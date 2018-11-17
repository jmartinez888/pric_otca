<?php

namespace App;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class IdiomaFiles extends Eloquent
{
  protected $table = 'idiomas_files';
  protected $primaryKey = 'Idif_IdIdiomaFile';
  public $timestamps = false;
  public static function existe_file ($name) {
    return IdiomaFiles::where('Idif_FileName', $name)->get()->count() == 0 ? false : true;
  }
  public static function get_file_by_name ($name) {
    return IdiomaFiles::where('Idif_FileName', $name)->first();
  }
  public  function generate_file ($file_id) {
    $idiomas = Idioma::all();
    $res = [];
    $path = ROOT.'lang'.DS;
    $proccess = ['success' => false, 'msg' => ''];
    try {
      foreach ($idiomas as $key_idioma => $idioma) {
        if (!file_exists($path.$idioma->Idi_IdIdioma))
          mkdir($path.$idioma->Idi_IdIdioma);
        $vars = IdiomaFilesVarsBody::getParentsValue()
                ->getByIdioma($idioma->Idi_IdIdioma)
                ->where('idiomas_files.Idif_IdIdiomaFile', $file_id)
                ->orderBy('idiomas_files_vars.Ifv_VarName', 'asc')
                ->get();

        foreach ($vars as $key_var => $var) {
          $res[$idioma->Idi_IdIdioma][$var->Idif_FileName][$var->Ifv_VarName] = $var->Ifvb_Body;
        }
      }
      // dd($res);
      foreach ($res as $key => $value_file) {
        foreach ($value_file as $key_file => $value_var) {
          $handle = fopen($path.$key.DS.$key_file.'.php', 'w');
          fwrite($handle, '<?php'.PHP_EOL);
          foreach ($value_var as $key_var => $value_body) {
            $data = '$lenguaje["'.$key_var.'"] = "'.$value_body.'";'.PHP_EOL;
            fwrite($handle, $data);
          }
          fclose($handle);
        }

      }
      $proccess['success'] = true;
    } catch (Exception $e) {
      $proccess['msg']  = $e->getMessage();
    }
    return $proccess;
  }
  public static function generate_files () {
    $idiomas = Idioma::all();
    $res = [];
    $path = ROOT.'lang'.DS;
    $proccess = ['success' => false, 'msg' => ''];
    try {

      foreach ($idiomas as $key_idioma => $idioma) {
        if (!file_exists($path.$idioma->Idi_IdIdioma))
          mkdir($path.$idioma->Idi_IdIdioma);
        $vars = IdiomaFilesVarsBody::getParentsValue()
                ->getByIdioma($idioma->Idi_IdIdioma)
                ->orderBy('idiomas_files_vars.Ifv_VarName', 'asc')
                ->get();
        foreach ($vars as $key_var => $var) {
          $res[$idioma->Idi_IdIdioma][$var->Idif_FileName][$var->Ifv_VarName] = $var->Ifvb_Body;
        }
      }
      foreach ($res as $key => $value_file) {
        foreach ($value_file as $key_file => $value_var) {
          $handle = fopen($path.$key.DS.$key_file.'.php', 'w');
          fwrite($handle, '<?php'.PHP_EOL);
          foreach ($value_var as $key_var => $value_body) {
            $data = '$lenguaje["'.$key_var.'"] = "'.$value_body.'";'.PHP_EOL;
            fwrite($handle, $data);
          }
          fclose($handle);
        }
      }
      $proccess['success'] = true;
    } catch (Exception $e) {
      $proccess['msg']  = $e->getMessage();
    }
    return $proccess;



  }

  public function scopeVisibles ($query) {
  	return $query->where('Row_Estado', 1);
  }
  public function vars () {
    return $this->hasMany('App\IdiomaFilesVars', 'Idif_IdIdiomaFile');
  }

  public function formatToArray ($exclude = []) {
    return [
      'id' => $this->Idif_IdIdiomaFile,
      'titulo' => $this->Idif_FileName,
      'estado_row' => $this->Row_Estado,
      'descripcion' => $this->Idif_Descripcion
    ];
  }
}
