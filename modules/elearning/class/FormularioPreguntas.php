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

  public function resumenRespuesta ($json_encode = false) {
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
            'respuesta' => htmlentities($item->Fre_Respuesta)
          ];
        })->toArray();   
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
      case 'cuadricula':
        $pre_res = [
          'data' => [],
          'opciones' => []
        ];
        $opciones = $this->opciones;
        foreach ($opciones as $key => $value) {
          $pre_res['opciones'][] = [
            'opcion' => $value->Fpo_Opcion,
            'opcion_id' => $value->Fpo_IdForPrOpc
          ];
        }
        foreach ($this->hijos as $key => $value) {
          $res_predata = [];
          foreach ($opciones as $kopc => $valopc) {  
            $td = FormularioUsuarioRespuestasDetalles::byPregunta($value->Fpr_IdForPreguntas)
            ->select(DB::raw('COUNT(*) as total_respuestas'))
            ->where('formulario_usuario_respuestas_detalles.Fpo_IdForPrOpc', $valopc->Fpo_IdForPrOpc)
            ->first();

            $res_predata[$valopc->Fpo_IdForPrOpc] = $td->total_respuestas;
          }
          $pre_res['data'][] = ['pregunta' => $value->Fpr_Pregunta] + $res_predata;
        }
        $res = $pre_res;
        break;
      case 'casilla':
        $pre_res = [
          'data' => [],
          'opciones' => []
        ];
        $opciones = $this->opciones;
        foreach ($opciones as $key => $value) {
          $pre_res['opciones'][] = [
            'opcion' => $value->Fpo_Opcion,
            'opcion_id' => $value->Fpo_IdForPrOpc
          ];
        }
        foreach ($this->hijos as $keyH => $valueH) {
          $temp_res = [];
          $res_predata = [];
          $opc_ids = FormularioUsuarioRespuestasDetalles::byPregunta($valueH->Fpr_IdForPreguntas)
          ->select('Fre_Respuesta')->get();
          foreach ($opc_ids as $key => $value) {
            $respuesta = explode('-', $value->Fre_Respuesta);
            foreach ($respuesta as $keyR => $valueR) {
              if (count($temp_res) == 0) {
                $temp_res[] = [
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
                    'opcion_id' => $valueR,
                    'total_respuestas' => 1
                  ];
                }
              }
            }
            
          }
          foreach ($temp_res as $trk => $trv) {
            $res_predata[$trv['opcion_id']] = $trv['total_respuestas'];
          }
          $pre_res['data'][] = ['pregunta' => $valueH->Fpr_Pregunta] + $res_predata;
        }
        $res = $pre_res;
        break;
    }
    return $json_encode ? json_encode($res) : $res;
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
    
    $pre =  [
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
    foreach ($exclude as $key => $value) {
      if (isset($pre[$value])) {
        unset($pre[$value]);
      }
    }
    return $pre;
  }
}

?>