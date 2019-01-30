<?php

use App\Curso;
use App\Leccion;
use App\LeccionAsistencia;
use App\LeccionSession;
use Illuminate\Database\Capsule\Manager as DB;

/**
 * Description of loginController
 * @author ROLORO
 */
class claseController extends elearningController {

	public function __construct($lang, $url) {
		parent::__construct($lang, $url);
		if (!Session::get("autenticado")) {$this->redireccionar("elearning/");}
	}

	public function index() {
		$this->redireccionar("elearning/");
	}

	public function clase($curso = "", $modulo = "", $leccion = "", $id = "") {
		$this->_acl->autenticado();
		$data['titulo'] = '';
		if ($curso == "" || !is_numeric($curso)
			|| $modulo == "" || !is_numeric($modulo)
			|| $leccion == "" || !is_numeric($leccion)) {
			$this->redireccionar("elearning/");
		}
		// $this->_acl->tienePermisos()

		$Cmodel = $this->loadModel("curso");
		$Mmodel = $this->loadModel("modulo");
		$Lmodel = $this->loadModel("leccion");
		$chmodel = $this->loadModel("chat");
		$Pmodel = $this->loadModel("pizarra");
		$Gmodel = $this->loadModel("_gestionCurso");

		if (!$Mmodel->validarCursoModulo($curso, $modulo)) {$this->redireccionar("elearning/cursos");}
		if (!$Mmodel->validarModuloUsuario($modulo, Session::get("id_usuario"))) {$this->redireccionar("elearning/cursos");};

		$OLeccion = $Lmodel->getLeccion($leccion, $modulo, Session::get("id_usuario"));

		$obj_leccion = Leccion::find($leccion);

		if ($OLeccion["Lec_Tipo"] != 4) {
			$this->redireccionar("elearning/cursos/modulo/" . $curso . "/" . $modulo . "/" . $OLeccion["Lec_IdLeccion"]);
			exit;
		}

		$this->_view->getLenguaje(["elearning_cursos"]);
		$lecciones = $Lmodel->getLecciones($modulo, Session::get("id_usuario"));
		$ocurso = $Cmodel->getCursoID($curso);

		// dd($ocurso);
		if ($ocurso == null && count($ocurso) == 0) {$this->redireccionar("elearning/cursos");}
		if ($lecciones == null && count($lecciones) == 0) {$this->redireccionar("elearning/cursos");}
		$ocurso = $ocurso[0];
		$data['titulo'] .= $ocurso['Cur_Titulo'];
		$alumnos = $Gmodel->getAlumnos($ocurso["Cur_IdCurso"]);
		$docente_id = $obj_leccion->getDocente();
		$data['hash_leccion'] = Leccion::hashLeccion($OLeccion['Lec_IdLeccion'], $docente_id);
		$data['docente_id'] = $docente_id;
		$data['is_docente'] = $Gmodel->validarDocenteCurso($curso, Session::get('id_usuario'));
		$data['hash_session_activa'] = 'none';
		$alumnos_format = [];

		foreach ($alumnos as $key => $value) {
			$alumnos_format[] = [
				'id' => $value['Usu_IdUsuario'],
				'usuario' => $value['Usu_Nombre'] . ' ' . $value['Usu_Apellidos'],
				'url' => $value['Usu_URLImage'],
				'docente' => $value['Docente'],
			];
		}

		//VALIDACION FECHA
		date_default_timezone_set('America/Lima');
		$DT_ACTUAL = (new DateTime("now"))->format('Y-m-d');
		$DT_DESDE = (new DateTime($OLeccion["Lec_FechaDesde"]))->format('Y-m-d');
		$DT_HASTA = (new DateTime($OLeccion["Lec_FechaHasta"]))->format('Y-m-d');

		$datos_modulo = $Mmodel->getModuloDatos($modulo);

		$this->_view->assign("mod_datos", $datos_modulo);

		$this->_view->setTemplate(LAYOUT_FRONTEND);

		$this->_view->assign("curso", $curso);
		$obj_modulo = $Mmodel->getModulo($modulo);

		if ($obj_modulo) {
			$data['titulo'] .= ' - ' . $obj_modulo['Moc_Titulo'];
		}

		if ($OLeccion) {
			$data['titulo'] .= ' - ' . $OLeccion['Lec_Titulo'];
		}

		$this->_view->assign("modulo", $obj_modulo);
		$this->_view->assign("lecciones", $lecciones);
		$this->_view->assign("ocurso", $ocurso);
		$this->_view->assign("usuario", Session::get("id_usuario"));
		$this->_view->assign("leccion", $OLeccion);
		$this->_view->assign("referencias", $Lmodel->getReferencias($OLeccion["Lec_IdLeccion"]));
		$this->_view->assign("materiales", $Lmodel->getMateriales($OLeccion["Lec_IdLeccion"]));
		$this->_view->setCss(array("colorPicker", "modulo", "pizarra", "chat", "jp-modulo"));

		$this->_view->assign($data);


		if (!$obj_leccion->getSessionOnline()) {
			if ($DT_ACTUAL < $DT_DESDE) {
				$this->_view->render("clase_falta");
			} else {
				if ($DT_ACTUAL > $DT_HASTA) {
					$this->_view->render("clase_pasada");
				} else {
					// exit;
					//EN ESPERA

					$session_espera = $obj_leccion->getSessionEnEspera($DT_ACTUAL);
					// dd($session_espera);
					
					if ($session_espera == null) {
						$session_espera = $obj_leccion->generarSessionDeEspera(new DateTime(), Session::get('id_usuario'));
						
					}
					$this->_view->assign('hash_session_activa', $session_espera->Les_Hash . '-' . $session_espera->Les_IdLeccSess);
					$this->_view->assign("alumnos_json", json_encode($alumnos_format));
					$this->_view->render("clase_espera");
				}
			}
			exit;
		} else {
			$session_activa = $obj_leccion->getSessionActiva();
			$this->_view->assign('hash_session_activa', $session_activa->Les_Hash . '-' . $session_activa->Les_IdLeccSess);
		}
		var_dump($data);
		exit;
		// if($DT_ACTUAL < $DT_DESDE){
		//   $this->_view->render("clase_falta");
		//   exit;
		// }else if (($DT_ACTUAL > $DT_HASTA) || $OLeccion["Lec_LMSEstado"]==2){
		//   $this->_view->render("clase_pasada");
		//   exit;
		// }

		// if($OLeccion["Lec_LMSEstado"] == Leccion::ESTADO_NOINICIADO || $obj_leccion->getSessionActiva() == null){
		//   $this->_view->assign("alumnos_json", json_encode($alumnos_format));
		//   $this->_view->render("clase_espera");
		//   exit;
		// }
		$pizarras = $Pmodel->getPizarras($OLeccion["Lec_IdLeccion"]);
		$mensajes = $chmodel->ListarChat($ocurso["Cur_IdCurso"], $OLeccion["Lec_IdLeccion"]);

		$this->_view->assign("chat", $mensajes);
		$this->_view->assign("pizarra", $pizarras);
		$this->_view->assign("alumnos", $alumnos);
		$this->_view->assign("alumnos_json", json_encode($alumnos_format));
		$this->_view->assign("referencias", $Lmodel->getReferencias($OLeccion["Lec_IdLeccion"]));
		$this->_view->assign("materiales", $Lmodel->getMateriales($OLeccion["Lec_IdLeccion"]));
		// $this->_view->setJs(array("clase","colorPicker", "pizarra/Herramientas", "pizarra/events", "pizarras", "pizarra/base", "chat",array('https://apis.google.com/js/platform.js')));
		$this->_view->render("clase");
	}

	public function obtener_mensaje_leccion_session() {
		$res = [];
		if ($this->has(['leccion_id', 'hash_leccion_session'])) {
			$session = LeccionSession::getSessionByHash($this->getTexto('hash_leccion_session'));
			if ($session) {
				$lid = $this->getInt('leccion_id');
				if ($session->Lec_IdLeccion == $lid) {
					$curso_id = $session->leccion->getCursoID();
					$chmodel = $this->loadModel("chat");
					$mensajes = $chmodel->ListarChat($curso_id, $lid, $session->Les_IdLeccSess);
					// dd($mensajes);
					foreach ($mensajes as $key => $value) {
						$res[] = [
							'curso_id' => $value['Cur_IdCurso'],
							'leccion_id' => $value['Lec_IdLeccion'],
							'leccion_session_id' => $value['Les_IdLeccSess'],
							'msg_descripcion' => $value['Men_Descripcion'],
							'msg_fecha' => $value['Men_Fecha'],
							'msg_id' => $value['Men_IdMensaje'],
							// 'estado' => $value['Row_Estado'],
							'usuario_id' => $value['Usu_IdUsuario'],
							'usuario_nombres' => $value['Usu_Nombre'],
							'usuario_apellidos' => $value['Usu_Apellidos'],
						];
					}
					// dd($mensajes);
				}
			}

		}
		$this->_view->responseJson($res);
	}

	public function _registrar_interaccion() {
		$leccion = $this->getTexto("leccion");
		$pizarra = $this->getTexto("pizarra");

		$this->getLibrary("ServiceResult");
		$json = new ServiceResult();

		$model = $this->loadModel("leccion");
		$json->Success("Exito");
		$model->RegistrarPizarra($leccion, $pizarra);
		$json->Send();
	}

	public function registrar_asistencia() {
		$res = ['success' => false];
		if ($this->has(['leccion_id', 'alumno_id', 'docente_id', 'hash'])) {
			$docente_id = $this->getInt('docente_id');
			$alumno_id = $this->getInt('alumno_id');
			$leccion_id = $this->getInt('leccion_id');
			$hash = $this->getTexto('hash');

			$objLeccion = Leccion::find($leccion_id);
			if ($objLeccion) {
				$Gmodel = $this->loadModel("_gestionCurso");
				$curso_id = $objLeccion->getCursoID();
				$alumnos = $Gmodel->getAlumnos($curso_id);
				if (Curso::existeAlumno($alumnos, $alumno_id) && $Gmodel->validarDocenteCurso($curso_id, $docente_id)) {
					if (Leccion::hashLeccion($leccion_id, $docente_id) == $hash) {
						$asistencia = LeccionAsistencia::byLeccionAndAlumno($leccion_id, $alumno_id);
						if ($asistencia == null) {
							$asistencia = new LeccionAsistencia();
							$asistencia->Usu_IdUsuario = $alumno_id;
							$asistencia->Lec_IdLeccion = $leccion_id;
						} else {
							//calcular tiempo transcurrido
							$total = 0;
							if ($asistencia->detalles) {
								$asistencia->detalles->map(function ($item) {
									$total += Carbon::createFromFormat('Y-m-d H', $asistencia->Lead_Ingreso)->diffMinutes(Carbon::createFromFormat('Y-m-d H', $asistencia->Lead_Salida));
								});
							}
							$asitencia->Lea_Tiempo = $total;
						}
						$asistencia->Lea_Asistencia = 1;
						//LEA TIEMPO
						//RECALCULAR EL TIEMPOD E ESTANCIA DESDE leccion_asistencia
						// $asistencia->Lea_Tiempo = 0;

						$asistencia->save();
						$res['success'] = true;
					}

				}
			}

		}

		$this->_view->responseJson($res);
	}

	public function _registrar_mensaje() {
		$usuario = $this->getTexto("usuario");
		$curso = $this->getTexto("curso");
		$leccion = $this->getTexto("leccion");
		$mensaje = $this->getTexto("mensaje");

		$hash = $this->getTexto("session_hash");

		$this->getLibrary("ServiceResult");
		$json = new ServiceResult();

		if (strlen($usuario) == 0 || strlen($curso) == 0 || strlen($leccion) == 0 || strlen($mensaje) == 0) {
			$json->Error("");
			$json->Send();exit;
		}
		if (!is_numeric($usuario) || !is_numeric($leccion) || !is_numeric($curso)) {
			$json->Error("");
			$json->Send();exit;}

		$model = $this->loadModel("chat");
		$session = LeccionSession::getSessionByHash($hash);
		if ($session && $session->Lec_IdLeccion == $leccion) {

			$model->registrarMensajeConSession($usuario, $curso, $leccion, $mensaje, $session->Les_IdLeccSess);
			$json->Populate([
				'usuario' => $usuario,
				'curso' => $curso,
				'leccion' => $leccion,
				'mensaje' => $mensaje,
			]);
			$json->Success("Exito");
		} else {
			$json->Error("");
		}
		$json->Send();
	}

	public function iniciar($curso, $modulo, $leccion) {
		$res = ['success' => false];
		if ($this->has(['docente_id', 'leccion_session_espera_id'])) {
			$this->_acl->autenticado();
			$objLecc = Leccion::find($leccion);
			if ($objLecc) {
				$docente_id = $this->getInt('docente_id');
				if ($docente_id == Session::get("id_usuario") && $docente_id == $objLecc->getDocente()) {
					if ($this->_acl->tienePermisos('iniciar_leccion_dirigida')) {
						// $model = $this->loadModel("leccion");

						//AGREGAR SESSION CLASE
						DB::transaction(function () use ($leccion, $docente_id, &$res, $objLecc) {
							// $model->EstadoLeccionLMS($leccion, Leccion::ESTADO_INICIADO);//no cachea el transaction :c
							$objLecc->Lec_LMSEstado = Leccion::ESTADO_INICIADO;
							// $objLecc->update(['Lec_LMSEstado' => Leccion::ESTADO_INICIADO]);
							$objLecc->save();

							$ls = new LeccionSession();
							//verifgicar si exsite una session en espera
							$espera_session = LeccionSession::getSessionByHash($this->getTexto('leccion_session_espera_id'));
							if ($espera_session) {
								$espera_session->concluir(DB::raw('NOW()'));
								$ls->Les_Padre = $espera_session->Les_IdLeccSess;
							}
							$ls->Lec_IdLeccion = $leccion;
							$ls->Les_DateInicio = DB::raw('NOW()');
							//APLICAR HASH ÚNICO PARA CADA LESSION
							do {
								$thash = Leccion::hashLeccion($leccion, $docente_id, (new DateTime("now"))->format('Y-m-d'));
							} while (LeccionSession::existeHash($thash, true));
							// $ls->Les_Hash = Leccion::hashLeccion($leccion, $docente_id, (new DateTime("now"))->format('Y-m-d'));
							$ls->Les_Hash = $thash;
							$ls->save();
							$res['success'] = true;
						});
					}
				}
			}
		}
		if ($this->isAcceptJson()) {
			$this->_view->responseJson($res);
		} else {
			$this->redireccionar("elearning/clase/clase/" . $curso . "/" . $modulo . "/" . $leccion);
		}
	}

	public function finalizar($curso, $modulo, $leccion) {
		$model = $this->loadModel("leccion");
		$model->EstadoLeccionLMS($leccion, 2);
		$this->redireccionar("elearning/clase/clase/" . $curso . "/" . $modulo . "/" . $leccion);
	}

	public function download($file) {
		$ruta = ROOT . "files" . DS . "elearning" . DS . "_material" . DS . $file;

		if (is_readable($ruta)) {
			header("Content-disposition: attachment; filename=" . $file);
			header("Content-type: " . mime_content_type($ruta));
			readfile($ruta);
		} else {
			header("Content-disposition: attachment; filename=" . $file);
			header("Content-type: " . mime_content_type($file));
			readfile($ruta);
		}
	}
}
