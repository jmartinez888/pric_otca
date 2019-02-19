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
  public function resumenRespuesta () {
    $res = [];
    switch ($this->Fpr_Tipo) {
      case 'texto':
      case 'fecha':
      case 'hora':
      case 'parrafo':
        $query = FormularioUsuarioRespuestasDetalles::byPregunta($this->Fpr_IdForPreguntas)
          ->groupBy('Fre_Respuesta');
        $res = $query->get()->map(function($item) {
          return [
            'respuesta' => $item->Fre_Respuesta
          ];
        });   
        break;
      case 'select':
      case 'radio':
      $query = FormularioUsuarioRespuestasDetalles::byPregunta($this->Fpr_IdForPreguntas)
          ->select(
            'formulario_usuario_respuestas_detalles.Fpr_IdForPreguntas as pregunta',
            'formulario_preguntas_opciones.Fpo_Opcion as opcion',
            DB::raw('COUNT(formulario_usuario_respuestas_detalles.Fpr_IdForPreguntas) as total_respuestas')
            )
          ->join('formulario_preguntas_opciones', 'formulario_preguntas_opciones.Fpo_IdForPrOpc', 'formulario_usuario_respuestas_detalles.Fpo_IdForPrOpc')
          ->groupBy('formulario_usuario_respuestas_detalles.Fpo_IdForPrOpc');
        $res = $query->get()->toArray();   
        break;
      case 'box':
        $temp_res = [];
        $opc_ids = FormularioUsuarioRespuestasDetalles::byPregunta($this->Fpr_IdForPreguntas)
          ->select('Fre_Respuesta')->get();
          // print_r($opc_ids);
          $inicia = 1;
        foreach ($opc_ids as $key => $value) {
          $respuesta = explode('-', $value->Fre_Respuesta);
          foreach ($respuesta as $keyR => $valueR) {
            $inicia++;
            if (count($temp_res) == 0) {
              $temp_res[] = [
                'opcion' => FormularioPreguntasOpciones::find($valueR)->Fpo_Opcion,
                'opcion_id' => $valueR,
                'total_respuestas' => 1
              ];
            } else {
              $existe = false;
              foreach ($temp_res as $k => $v) {
                if ($v['opcion_id'] == $valueR) {
                  $temp_res[$k]['total_respuestas'] += 1;
                  $existe = true;
                  break;
                }  
              }
              if (!$existe) {
                $temp_res[] = [
                  'opcion' => FormularioPreguntasOpciones::find($valueR)->Fpo_Opcion,
                  'opcion_id' => $valueR,
                  'total_respuestas' => 1
                ];
              }
            }
          }
          
        }
        $res = $temp_res;
        break;
    }
    return $res;
  }
  public function hijos () {
    return $this->hasMany('App\FormularioPreguntas', 'Fpr_Parent');
  }
  public function existeDetalleRespuestaByResUsu ($respuesta_usuario_id) {
    return true;
    // return $this->respuestas()->where('Fur_IdFrmUsuRes', $respuesta_usuario_id)->count() > 0;
  }
  public function detalleRespuestaByResUsu ($respuesta_usuario_id) {
    //filtrar solo las respuestas de un usuario
    $target = $this->respuestas()->where('Fur_IdFrmUsuRes', $respuesta_usuario_id)->first();
    // dd($target);
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
  /**
   * [respuestas retorna detalles de respuesta de la pregunta X de  todos los usuarios ]
   *
   * @return  [type]  [return description]
   */
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