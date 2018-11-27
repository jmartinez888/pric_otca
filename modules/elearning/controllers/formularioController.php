<?php
use App\Formulario;
use App\FormularioPreguntas;
use App\FormularioPreguntasOpciones;
use App\FormularioUsuarioRespuestas;
use App\FormularioUsuarioRespuestasDetalles;
use App\Usuario;
use Illuminate\Database\Capsule\Manager as DB;
class formularioController extends elearningController {

	public function store_respuesta ($curso_id) {
		$mod_usuario = $this->loadModel('usuario', 'usuarios');
		$usuario = $mod_usuario::find(Session::get('id_usuario'));

		$roles = $usuario->getUsuariosRoles();
		$success_pass = false;
		foreach ($roles as $key => $value) {
			if ($value['Rol_Ckey'] == 'alumno') {
				$success_pass = true;
				break;
			}
		}

		if (is_numeric($curso_id) && $curso_id != 0) {
			$mod_curso = $this->loadModel('curso');
			$curso = $mod_curso::find($curso_id);
			if ($curso) {
				$frm = $curso->getFormularioActivo();

				if ($frm) {
					$respuesta = $frm->getRespuestaByUsuario(Session::get('id_usuario'));
					if ($respuesta == null) {
					  $preguntas = $frm->preguntas;
					  $success_insert = true;
					  $pre_respuestas = [];
					  foreach ($_POST as $key => $value) {
					  	$t = explode('_', $key);
					  	$pregunta = $preguntas->where('Fpr_IdForPreguntas', end($t))->first();
					  	if ($pregunta) {
					  		$pres = new FormularioUsuarioRespuestasDetalles();
					  		$pres->Fpr_IdForPreguntas = $pregunta->Fpr_IdForPreguntas;
					  		if (is_array($value)) {
					  			$pres->Fre_Respuesta = implode('-', $value);
					  		} else
					  			$pres->Fre_Respuesta = $value;
					  		$pre_respuestas[] = $pres;
					  	} else {
					  		$success_insert = false;
					  		break;
					  	}

					  }
					  if ($success_insert) {
					  	DB::transaction(function () use ($usuario, $frm, $pre_respuestas) {
						  	$new_respuesta = new FormularioUsuarioRespuestas();
						  	$new_respuesta->Usu_IdUsuario = $usuario->Usu_IdUsuario;
						  	$new_respuesta->Frm_IdFormulario = $frm->Frm_IdFormulario;
						  	$new_respuesta->Fur_Completado = 1;
						  	if ($new_respuesta->save()) {
							  	foreach ($pre_respuestas as $key => $value) {
							  		$value->Fur_IdFrmUsuRes = $new_respuesta->Fur_IdFrmUsuRes;
							  		$value->save();
							  	}

						  	}
					  	});
					  	$this->redireccionar('elearning/cursos/curso/'.$curso->Cur_IdCurso);
					  }
					}

				}
			}
		}
	}
	public function responder ($curso_id) {
		$mod_usuario = $this->loadModel('usuario', 'usuarios');
		$usuario = $mod_usuario::find(Session::get('id_usuario'));
		$roles = $usuario->getUsuariosRoles();
		$success_pass = false;
		$data['menu'] = '';
		$data['formulario'] = null;
		$data['obj_curso'] = null;
		$data['respuesta'] = null;
		foreach ($roles as $key => $value) {
			if ($value['Rol_Ckey'] == 'alumno') {
				$success_pass = true;
				break;
			}
		}
		if ($success_pass) {
			//load formulario

			$data['menu'] = 'curso';

		}
		if (is_numeric($curso_id) && $curso_id != 0) {
			$mod_curso = $this->loadModel('curso');

			$curso = $mod_curso::find($curso_id);
			// dd($curso);
			// $data['obj_curso'] = $curso;
			$this->_view->setTemplate(LAYOUT_FRONTEND);
			if ($curso ) {
				$frm = $curso->getFormularioActivo();
				$data['obj_curso'] = $curso;
				if ($frm) {
					$data['respuesta'] = $frm->getRespuestaByUsuario(Session::get('id_usuario'));
					// dd($respuesta);
					$data['formulario'] = $frm;

				}

			}
			$this->_view->assign($data);
			$this->_view->render('responder');
			exit;
		}
		$this->redireccionar('');
	}
	public function delete_opcion ($opc_id) {
		$res = ['success' =>  false];
		if (is_numeric($opc_id) && $this->getInt('opcion_id') == $opc_id) {
			$opc = FormularioPreguntasOpciones::find($opc_id);
			if ($opc->delete())
				$res['success'] = true;
		}
		$this->_view->responseJson($res);
	}
	public function preguntas ($frm_id) {
		$res = [];
		if (is_numeric($frm_id) && $frm_id != 0) {
			$frm = Formulario::find($frm_id);
			if ($frm) {
				$res = $frm->preguntas->map(function($item) {
					$p = $item->formatToArray();
					$p['opciones'] = $item->opciones->map(function($itemb) {
						return $itemb->formatToArray();
					});
					return $p;
				});
			}
		}
		$this->_view->responseJson($res);
	}
	public function store_opcion ($pre_id) {
		$res = ['success' => false, 'data' => null];
		if (is_numeric($pre_id) && $pre_id != 0) {
			$pref = FormularioPreguntas::find($pre_id);
			if ($pref) {
				DB::transaction(function () use (&$res, $pref){
					$max = $pref->opciones()->max('Fpo_Orden');
					$opcion = new FormularioPreguntasOpciones();
					$opcion->Fpo_Orden = $max + 1;
					$opcion->Fpo_Opcion ='';
					$opcion->Fpr_IdForPreguntas = $pref->Fpr_IdForPreguntas;
					if ($opcion->save()) {
						$res['success'] = true;
						$res['data'] = $opcion->formatToArray();
					}
				});
			}
		}
		// dd($_POST);
		$this->_view->responseJson($res);
	}
	public function store_pregunta ($frm_id) {
		$res = ['success' => false, 'data' => null];
		if (is_numeric($frm_id) && $frm_id != 0) {
			$frm = Formulario::find($frm_id);
			if ($frm) {
				DB::transaction(function () use (&$res, $frm){
					$max = $frm->preguntas()->max('Fpr_Orden');
					$pregunta = new FormularioPreguntas();
					$pregunta->Fpr_Orden = $max + 1;
					$pregunta->Fpr_Pregunta ='';
					$pregunta->Fpr_Descripcion ='';
					$pregunta->Fpr_Tipo ='texto';
					$pregunta->Frm_IdFormulario = $frm->Frm_IdFormulario;
					if ($pregunta->save()) {
						$res['success'] = true;
						$to = $pregunta->formatToArray();
						$to['opciones'] = [];
						$res['data'] = $to;
					}
				});
			}
		}
		// dd($_POST);
		$this->_view->responseJson($res);
	}
	public function update_pregunta ($id) {
		// dd($_POST);
		$res = ['success' => false];
		if ($this->has(['tipo', 'formulario_id'])) {
			$pre_id = $this->getInt('pregunta_id');
			if (is_numeric($id) && $id != 0 && $pre_id == $id) {
				// $row = Formulario::find()
				$pre = FormularioPreguntas::find($pre_id);
				if ($pre) {
					$tipo = $this->getTexto('tipo');
							DB::transaction(function () use ($pre, &$res, $tipo) {
								$pre->Fpr_Pregunta = $_POST['values']['pregunta'];
								$pre->Fpr_Descripcion = $_POST['values']['descripcion'];
								$pre->Fpr_Tipo = strtolower($tipo);
								$pre->Fpr_Obligatorio = $_POST['values']['obligatorio'] == 1 ? 1 : 0;
								$pre->Fpr_PoseeDescripcion = trim($_POST['values']['descripcion']) != '' ? 1 : 0;

								if (isset($_POST['values']['options'])) {
									$opcs = $_POST['values']['options'];
									foreach ($opcs as $key => $value) {
										$opc = FormularioPreguntasOpciones::find($value['id']);
										if ($opc) {
											$opc->Fpo_Opcion = $value['opcion'];
											$opc->Fpo_Orden = $value['orden'];
											$opc->save();
										}
									}
								}
								switch ($tipo) {
									case 'texto':
									break;
								}
								if ($pre->save())
										$res['success'] = true;
							});

				}

			}
		}
		$this->_view->responseJson($res);
	}
	public function update ($id) {
		// dd($_POST);
		$frm_id = $this->getInt('formulario_id');
		if (is_numeric($id) && $id == $frm_id) {
			$row = Formulario::find($id);
			$row->Frm_Titulo = $_POST['values']['pregunta'];
			$row->Frm_Descripcion = $_POST['values']['descripcion'];
			$row->save();
		}
	}
	public function store () {
		if ($this->has('mode')) {
			$curso_id = $this->getInt('curso_id');
			if ($this->getTexto('mode') == 'unique' && $curso_id != 0) {
				$forms = Formulario::getByCurso($curso_id);
				if ($forms->count() == 0) {
					$new = new Formulario();
					$new->Frm_Titulo = 'Titulo';
					$new->Frm_Descripcion = '';
					$new->Cur_IdCurso = $curso_id;
					if ($new->save()) {
						$this->redireccionar('elearning/gcurso/formulario/'.$curso_id);
					}
				}
				// if ()
			}
		}
	}
}
?>