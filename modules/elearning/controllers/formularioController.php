<?php
use App\Formulario;
use App\FormularioPreguntas;
use App\FormularioPreguntasOpciones;
use App\FormularioUsuarioRespuestas;
use App\FormularioUsuarioRespuestasDetalles;
use App\Usuario;
use Illuminate\Database\Capsule\Manager as DB;
class formularioController extends elearningController {
	public function delete_respuesta ($respuesta_id) {
		$res = ['success' => false];
		if (is_numeric($respuesta_id) && $respuesta_id != 0) {
			$respuesta = FormularioUsuarioRespuestas::find($respuesta_id);
			if ($respuesta) {
				DB::transaction(function () use ($respuesta, &$res) {
					foreach($respuesta->detalles as $det) {
						$det->delete();
					}
					if ($respuesta->delete())
						$res['success'] = true;
				});
			}

		}
		$this->_view->responseJson($res);
	}
	public function respuesta ($respuesta_id) {
		if ($this->_acl->tienePermisos('ver_respuestas_formulario_alumnos')) {
			$lang = $this->_view->getLenguaje('elearning_formulario_responder', false, true);
			$this->curso = $this->loadModel("_gestionCurso");

			$success_pass = true;
			$data['menu'] = '';
			$data['formulario'] = null;
			$data['alumno'] = null;
			$data['obj_curso'] = null;
			$data['respuesta'] = null;
			$data['titulo'] = $lang->get('elearning_formulario_respuesta_titulo');

				//load formulario

			$data['menu'] = 'curso';


			if (is_numeric($respuesta_id) && $respuesta_id != 0) {
				$respuesta = FormularioUsuarioRespuestas::find($respuesta_id);
				if ($respuesta) {

					// dd($respuesta->detalles);
					// dd($curso);
					// $data['obj_curso'] = $curso;
					$this->_view->setTemplate(LAYOUT_FRONTEND);


					$data['alumno'] = $respuesta->usuario;
					$frm = $respuesta->formulario;


					// $data['obj_curso'] = $curso;
					if ($frm) {
						$curso = $this->curso->getCursoXId($frm->Cur_IdCurso);
						$data['titulo'] = $curso['Cur_Titulo'].' - '.$data['titulo'];
						$data['curso'] = $curso;
						$data['respuesta'] = $respuesta;
						$data['formulario'] = $frm;

					}


					$this->_view->assign($data);
					$this->_view->render('respuesta');
					exit;
				} else {
					$this->redireccionar('');
				}
			}
		} else {
			$this->redireccionar('');
		}

	}
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
					  $preguntas = $frm->preguntasTodas;
					  $success_insert = true;
					  $pre_respuestas = [];
					  // dd($_POST);
					  foreach ($_POST as $key => $value) {
					  	$t = explode('_', $key);
					  	$pregunta = $preguntas->where('Fpr_IdForPreguntas', end($t))->first();
					  	print_r($pregunta->Fpr_IdForPreguntas);
					  	if ($pregunta) {
					  		$pres = new FormularioUsuarioRespuestasDetalles();
					  		$pres->Fpr_IdForPreguntas = $pregunta->Fpr_IdForPreguntas;
					  		if (is_array($value)) {
					  			$pres->Fre_Respuesta = implode('-', $value);
					  			if ($pregunta->Fpr_Tipo == 'casilla') {
					  				$pres->Fpo_IdForPrOpc = $value;
					  			}
					  		} else {
					  			$pres->Fre_Respuesta = $value;
					  			switch ($pregunta->Fpr_Tipo) {
					  				case 'cuadricula':
					  				case 'radio':
					  				case 'select':
					  					$pres->Fpo_IdForPrOpc = $value;
					  					break;
					  			}
					  		}
					  		$pre_respuestas[] = $pres;
					  	} else {
					  		$success_insert = false;
					  		break;
					  	}

					  }


					  foreach ($_FILES as $key => $value) {

					  	$t = explode('_', $key);
					  	$pregunta = $preguntas->where('Fpr_IdForPreguntas', end($t))->first();
					  	if ($pregunta) {
					  		$path = $this->ruta_formularios.$pregunta->Frm_IdFormulario.DS;
					  		if (!file_exists($path)) {
					  			mkdir($path);
					  		}
					  		$path_pregunta = $path.$pregunta->Fpr_IdForPreguntas.DS;
					  		if (!file_exists($path_pregunta)) {
					  			mkdir($path_pregunta);
					  		}

								$ext = pathinfo($value['name'], PATHINFO_EXTENSION);
		            $namefinal = md5($value['name'].$pregunta->Fpr_IdForPreguntas).'.'.$ext;
		            $destino_path = $path_pregunta.$namefinal;
					  		if (move_uploaded_file($value['tmp_name'], $destino_path)) {
					  			$pres = new FormularioUsuarioRespuestasDetalles();
									$pres->Fpr_IdForPreguntas = $pregunta->Fpr_IdForPreguntas;
									$pres->Fre_Respuesta = $namefinal;
									$pre_respuestas[] = $pres;
					  		}

					  	}
					  	break;
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
					} else {
						$this->redireccionar('elearning/cursos/curso/'.$curso->Cur_IdCurso);
					}
				}
			}
		}
	}
	public function responder ($curso_id) {
		$this->_acl->autenticado();


		$mod_usuario = $this->loadModel('usuario', 'usuarios');
		$usuario = $mod_usuario::find(Session::get('id_usuario'));
		$lang = $this->_view->getLenguaje(['elearning_formulario_responder','elearning_cursos'], false, true);
		$roles = $usuario->getUsuariosRoles();
		$success_pass = false;
		$data['menu'] = '';
		$data['formulario'] = null;
		$data['obj_curso'] = null;
		$data['respuesta'] = null;
		$data['titulo'] = $lang->get('elearning_formulario_responder_titulo');
		// dd($roles);
		foreach ($roles as $key => $value) {
			if ($value['Rol_Ckey'] == 'alumno') {
				$success_pass = true;
				break;
			}
		}
		if ($success_pass) {
			//load formulario

			$data['menu'] = 'docente';

		}
		if (is_numeric($curso_id) && $curso_id != 0) {
			$mod_curso = $this->loadModel('curso');

			$curso = $mod_curso::find($curso_id);
			// dd($curso);
			// $data['obj_curso'] = $curso;
			$this->_view->setTemplate(LAYOUT_FRONTEND);
			if ($curso ) {
				$data['titulo'] = $curso->Cur_Titulo.' - '.$data['titulo'];
				$frm = $curso->getFormularioActivo();
				$data['obj_curso'] = $curso;
				if ($frm) {
					$data['respuesta'] = $frm->getRespuestaByUsuario(Session::get('id_usuario'));
					$data['formulario'] = $frm;

				}

			}
			$this->_view->assign($data);
			$this->_view->render('responder');
			exit;
		}
		$this->redireccionar('');
	}
	public function delete_pregunta ($pregunta_id) {
		$res = ['success' =>  false];
		if (is_numeric($pregunta_id) && $this->getInt('pregunta_id') == $pregunta_id) {
			DB::transaction(function () use (&$res, $pregunta_id) {
				$pre = FormularioPreguntas::find($pregunta_id);

				$respuestas = FormularioUsuarioRespuestasDetalles::getByPregunta($pregunta_id);
				if ($respuestas->count() > 0) {
					foreach ($respuestas as $key => $value) {
						$value->delete();
					}
				}

				$opciones = FormularioPreguntasOpciones::getByPregunta($pregunta_id);
				if ($opciones->count() > 0) {
					foreach ($opciones as $key => $value) {
						$value->delete();
					}
				}
				if ($pre->delete())
					$res['success'] = true;
			});
		}
		$this->_view->responseJson($res);
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
					$p['hijos'] = $item->hijos->map(function($itemb) {
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
		if (is_numeric($pre_id) && $pre_id != 0 && $this->getInt('pregunta_id') == $pre_id) {
			$pref = FormularioPreguntas::find($pre_id);
			if ($pref) {
				DB::transaction(function () use (&$res, $pref){
					$max = $pref->opciones()->max('Fpo_Orden');
					$opcion = new FormularioPreguntasOpciones();
					$opcion->Fpo_Orden = $max + 1;
					$opcion->Fpo_Opcion ='';
					if (isset($_POST['tipo_opc']) && ($_POST['tipo_opc'] == 'fil'))
						$opcion->Fpo_Tipo = $_POST['tipo_opc'];
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
	public function store_pregunta ($frm_id, $tipo = 'texto') {
		$res = ['success' => false, 'data' => null];
		if (is_numeric($frm_id) && $frm_id != 0) {
			$frm = Formulario::find($frm_id);
			if ($frm) {
				DB::transaction(function () use (&$res, $frm, $tipo){
					$max = $frm->preguntas()->max('Fpr_Orden');
					$pregunta = new FormularioPreguntas();
					$pregunta->Fpr_Orden = $max + 1;
					$pregunta->Fpr_Pregunta = '';
					$pregunta->Fpr_Descripcion = '';
					$pregunta->Fpr_Tipo = $tipo;
					$pregunta->Frm_IdFormulario = $frm->Frm_IdFormulario;
					if (isset($_POST['pregunta_padre']) && $_POST['pregunta_padre'] != 0) {
						$pregunta->Fpr_Parent = $_POST['pregunta_padre'];
					}
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
	public function update_pregunta ($id, $opc = 'default') {

		$res = ['success' => false];

		if ($this->has(['tipo', 'formulario_id'])) {

			$pre_id = $this->getInt('pregunta_id');
			if (is_numeric($id) && $id != 0 && $pre_id == $id) {

				// $row = Formulario::find()
				$pre = FormularioPreguntas::find($pre_id);
				if ($pre) {
					$tipo = $this->getTexto('tipo');
							DB::transaction(function () use ($pre, &$res, $tipo, $opc) {

								if ($opc == 'default') {

									$pre->Fpr_Pregunta = $_POST['values']['pregunta'];
									$pre->Fpr_Descripcion = $_POST['values']['descripcion'];
									$pre->Fpr_Tipo = strtolower($tipo);
									// $pre->Fpr_Obligatorio = $_POST['values']['obligatorio'] == 1 ? 1 : 0;
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
									if (isset($_POST['values']['preguntas'])) {
										$pregs = $_POST['values']['preguntas'];
										foreach ($pregs as $key => $value) {
											$preh = $pre->hijos->where('Fpr_IdForPreguntas', $value['id'])->first();
											if ($preh) {
												$preh->Fpr_Pregunta = $value['pregunta'];
												$preh->Fpr_Orden = $value['orden'];
												$preh->save();
											}
										}
									}
									switch ($tipo) {
										case 'texto':
										break;
									}
								}
								if ($opc == 'obligatorio') {
									if (isset($_POST['obligatorio'])) {

										$val = $_POST['obligatorio'];
										if (is_numeric($val) && ($val == 1 || $val == 0))
											$pre->Fpr_Obligatorio = $val;
									}
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