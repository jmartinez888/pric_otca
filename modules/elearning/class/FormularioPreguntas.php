<?php

namespace App;
use App\FormularioPreguntasOpciones;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class FormularioPreguntas extends Eloquent
{
  protected $table = 'formulario_preguntas';
  protected $primaryKey = 'Fpr_IdForPreguntas';
  const CREATED_AT = 'Fpr_CreatedAt';
  const UPDATED_AT = 'Fpr_UpdatedAt';

  public function opciones () {
    return $this->hasMany('App\FormularioPreguntasOpciones', 'Fpr_IdForPreguntas');
  }

  public function hijos () {
    return $this->hasMany('App\FormularioPreguntas', 'Fpr_Parent');
  }

  public function detalleRespuestaByResUsu ($respuesta_usuario_id) {
    $target = $this->respuestas()->where('Fur_IdFrmUsuRes', $respuesta_usuario_id)->first();
    switch ($this->Fpr_Tipo) {
      case 'box':
        // dd($target);
        $opc_id = explode('-', $target->Fre_Respuesta);
        $temp = [];
        foreach ($opc_id as $key => $value) {
          $temp[] = FormularioPreguntasOpciones::find($value);
        }
        return $temp;
        break;
      case 'casilla':
        dd($target);
        break;
      case 'upload':
        $html = '';
        if ($target) {

          $pre_path = 'files'.DS.'elearning'.DS.'formularios'.DS.$target->respuesta->Frm_IdFormulario.DS.$target->Fpr_IdForPreguntas.DS.$target->Fre_Respuesta;
          $path = ROOT.$pre_path;
          if (file_exists($path)) {
            $finfo = finfo_open(FILEINFO_MIME_TYPE);
            $mime = finfo_file($finfo, $path);
            finfo_close($finfo);
            $formato = explode('/', $mime);
            $params['ruta'] = $pre_path;
            $params['pregunta'] = $target->pregunta->Fpr_Pregunta;
            if ($formato[0] == 'image') {
              return new class ($params) {
                public function __construct($values)
                {
                  $this->values = $values;
                    $this->path = BASE_URL.$values['ruta'];
                }
                public function format () {

$html = <<<THTML
    <img class="w-100" src="{$this->path}" alt="{$this->values['pregunta']}" title="{$this->values['pregunta']}"/>
THTML;

                  return $html;
                }
              };
            }
          } else {
            return null;
          }
        }


        break;
    }
    return $target;
  }

  public function respuestas () {
    return $this->hasMany('App\FormularioUsuarioRespuestasDetalles', 'Fpr_IdForPreguntas');
  }
  public function formatToArray ($exclude = []) {
    return [
      'id' => $this->Fpr_IdForPreguntas,
      'pregunta' => $this->Fpr_Pregunta,
      'descripcion' => $this->Fpr_Descripcion,
      'obligatorio' => $this->Fpr_Obligatorio,
      'posee_des' => $this->Fpr_PoseeDescripcion,
      'orden' => $this->Fpr_Orden,
      'tipo' => $this->Fpr_Tipo,
      'formulario_id' => $this->Frm_IdFormulario,
      'create' => $this->Fpr_CreatedAt,
      'update' => $this->Fpr_UpdatedAt,
      'parent' => $this->Fpr_Parent
    ];
  }
}

?>