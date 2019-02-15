<?php

use App\Curso;
use App\Leccion;
use App\Formulario;
use App\LeccionSession;
use App\LeccionAsistencia;
use App\LeccionFormulario;
use Illuminate\Database\Capsule\Manager as DB;

/**
 * Description of loginController
 * @author ROLORO
 */
class gleccionController extends elearningController {

    protected $_link;
    protected $service;
		public function datatable_asistencia_detalles ($leccion_session_id) {
			$res = ['success' => false];
			$this->_acl->autenticado();
			$success = false;
			if ($this->_acl->tienePermisos('iniciar_leccion_dirigida') && is_numeric($leccion_session_id) && $leccion_session_id != 0) {
				// DB::enableQueryLog();
				$objAsistencia = LeccionAsistencia::find($leccion_session_id);

				if ($objAsistencia) {
					$query = $objAsistencia->detalles();
					$records_total = $query->count();
					$records_total_filter = $records_total;

					if ($this->filledGet('buscar')) {
						// $query->where(function($q) {
						// 	$q->orWhere('Ifv_VarName', 'like', '%'.$this->getTexto('buscar').'%');
						// 		// ->orWhere('ODif_Descripcion', 'like', '%'.$_GET['buscar'].'%');
						// });
						// $records_total_filter = $query->count();
					}

					if ($this->has(['order', 'columns'])) {
						foreach ($_GET['order'] as $key => $value) {
							$nc = $_GET['columns'][$value['column']]['data'];
							switch ($nc) {
								case 'ingreso': $nc = 'Lead_Ingreso'; break;
								case 'salida': 	$nc = 'Lead_Salida'	;	break;
							}
							$query->orderBy($nc, $value['dir']);
						}
					}
					
					if ($this->filledGet('export')) {
						$this->_export($query, $this->getTexto('export'));
					} else {
						$rows = $query->offset($this->getInt('start'))->limit($this->getInt('length'))->get()->map(function($item) {
							return $item->formatToArray();
						});
						$data = [
							'draw' => $this->getInt('draw'),
							'recordsTotal' => $records_total,
							'recordsFiltered' => $records_total_filter,
							'data' => $rows,
							// 'query' =>  DB::getQueryLog()
						];
						$this->_view->responseJson($data);
					}
				}
			}
			

		}

		public function asistencia_detalles ($leccion_id, $usuario_id) {
			// dd($leccion_id, $usuario_id);
			$this->_acl->autenticado();
			$success = false;
			if ($this->_acl->tienePermisos('iniciar_leccion_dirigida') && is_numeric($leccion_id) && $leccion_id != 0 && is_numeric($usuario_id) && $usuario_id != 0) {
				$objLeccion = Leccion::find($leccion_id);
				$objUsuario = Leccion::find($usuario_id);

				if ($objLeccion && $objUsuario) {
					$lang = $this->_view->LoadLenguaje(['elearning_cursos', 'elearning_formulario_responder'], false, true);
					$success = true;
					$asistencia = LeccionAsistencia::select('Lea_IdLeccAsis', 'Les_IdLeccSess')->getByUsuarioAndLeccion($usuario_id, $leccion_id)->get()->map(function($item) {
						return [
							'leccion_asistencia_id' => $item->Lea_IdLeccAsis,
							'leccion_session_id'		=> $item->Les_IdLeccSess,
							'leccion_session_id_format'		=> fill_zeros($item->Les_IdLeccSess)
						];
					});
					$data['objLeccion'] = $objLeccion;
					$data['titulo'] = $lang->get('elearning_cursos_asistencia_detalles');
					$data['asistencia_ref'] = $asistencia;
					
					$this->_view->setTemplate(LAYOUT_FRONTEND);
					// dd($asistencia->toArray(), $asistencia[0]->detalles);
					$this->_view->assign($data);
					$this->_view->render('asistencia_leccion_detalles');
				}
			}
			if (!$success) 
				$this->redireccionarReferer('elearning/cursos/cursos');
			
		}

		public function registrar_asistencia () {
			$res = ['success' => false, 'msg' => ''];
			$this->_acl->autenticado();
      if ($this->_acl->tienePermisos('iniciar_leccion_dirigida') && $this->has(['leccion_asistencia_id'])) {
        $lang = $this->_view->LoadLenguaje(['elearning_cursos', 'elearning_formulario_responder'], false, true);
				$lecc_ass = LeccionAsistencia::find($this->getInt('leccion_asistencia_id'));
				if ($lecc_ass) {
					$lecc_ass->Lea_Asistencia = 1;
					if ($lecc_ass->save()) {
							$res['success'] = true;
							$res['msg'] = $lang->get('elearning_cursos_asistencia_marcada');
					}

				}
      }
      $this->_view->responseJson($res);
		} 

		public function datatable_asistencia ($leccion_id) {
			$this->_acl->autenticado();
			if ($this->_acl->tienePermisos('iniciar_leccion_dirigida') && is_numeric($leccion_id) && $leccion_id != 0) {
				$objLeccion = Leccion::find($leccion_id);
				if ($objLeccion) {				
					DB::enableQueryLog();
					//OBTENER EL Máximo valor de Lea_Asistencia, para considerar que asistió a alguna de las sessiones de la lección
					// $query = $objLeccion->leccion_asistencia()
					$query_total = LeccionAsistencia::SelectParaAsistencia($objLeccion->Lec_IdLeccion, $objLeccion->getDocente());
					
					$query = LeccionAsistencia::SelectParaAsistencia($objLeccion->Lec_IdLeccion, $objLeccion->getDocente())
						->SelectParaAsistenciaComplemento();
					$records_total = $total_asistencia = DB::query()->selectRaw('count(*) total from ('.$query_total->toSql().') tt', $query_total->getBindings())->first()->total;
					$total_confirmados = DB::query()->selectRaw('count(*) total_confirmadas from ('.$query_total->toSql().') tt', $query_total->getBindings())->where(DB::raw('confirma_asistencia'), LeccionAsistencia::ASISTENCIA_CONFIRMADA)->first()->total_confirmadas;
					// dd($total_confirmados);
					$total_sin_confirmados = DB::query()->selectRaw('count(*) total_sin_confirmadas from ('.$query_total->toSql().') tt', $query_total->getBindings())->where(DB::raw('confirma_asistencia'), LeccionAsistencia::ASISTENCIA_FALTA)->first()->total_sin_confirmadas;
					$records_total_filter = $records_total;
											
					if ($this->has(['filter'])) {
						// if ($_GET['filter']['filter_alumno'] != '') {
							$query->where(function($query) {
								if ($_GET['filter']['filter_alumno'] != '') 
									$query->orWhere(DB::raw("CONCAT(usuario.Usu_Nombre, ' ', usuario.Usu_Apellidos)"), 'like', '%'.$_GET['filter']['filter_alumno'].'%');

								if (is_numeric($_GET['filter']['filter_session']) && $_GET['filter']['filter_session'] != -1) 
									$query->where('leccion_asistencia.Les_IdLeccSess', $_GET['filter']['filter_session']);	
							});
							$query_total->where(function($query) {
								if ($_GET['filter']['filter_alumno'] != '') 
									$query->orWhere(DB::raw("CONCAT(usuario.Usu_Nombre, ' ', usuario.Usu_Apellidos)"), 'like', '%'.$_GET['filter']['filter_alumno'].'%');

								if (is_numeric($_GET['filter']['filter_session']) && $_GET['filter']['filter_session'] != -1) 
									$query->where('leccion_asistencia.Les_IdLeccSess', $_GET['filter']['filter_session']);	
							});
							$records_total_filter = $total_asistencia = DB::query()->selectRaw('count(*) total from ('.$query_total->toSql().') tt', $query_total->getBindings())->first()->total;
							$total_confirmados = DB::query()->selectRaw('count(*) total_confirmadas from ('.$query_total->toSql().') tt', $query_total->getBindings())->where(DB::raw('confirma_asistencia'), LeccionAsistencia::ASISTENCIA_CONFIRMADA)->first()->total_confirmadas;
							$total_sin_confirmados = DB::query()->selectRaw('count(*) total_sin_confirmadas from ('.$query_total->toSql().') tt', $query_total->getBindings())->where(DB::raw('confirma_asistencia'), LeccionAsistencia::ASISTENCIA_FALTA)->first()->total_sin_confirmadas;
						// }
					}

					if ($this->has(['order', 'columns'])) {
						foreach ($_GET['order'] as $key => $value) {
							$nc = $_GET['columns'][$value['column']]['data'];
							switch ($nc) {
								case 'nombre_completo': $nc = 'nombre_completo'; break;
								case 'inicio': 	$nc = 'Lea_Inicio'	;	break;
								case 'fin': 	$nc = 'Lea_Fin'	;	break;
							}
							$query->orderBy($nc, $value['dir']);
						}
					}
					if ($this->filledGet('export')) {
						$this->_export($query, $this->getTexto('export'));
					} else {
						$rows = $query->offset($this->getInt('start'))
							->limit($this->getInt('length'))
							->get()->map(function($item) {
								
								$idss = explode('-', $item->str_sessiones);
								$ssf = [];
								foreach ($idss as $key => $value) {
									$ttt = LeccionSession::selectParaAsistencia($value)->find($value);
									// $ttt->format_id = fill_zeros($value);
									$ssf[] = [
										'id' => $value,
										'format_id' => fill_zeros($value),
										'tipo' 			=> $ttt->Les_Tipo,
									];
								}
								$item->sessiones_format = $ssf;
								
								return [
									'id' 								=> $item->Lea_IdLeccAsis,
									'nombre_completo' 	=> $item->nombre_completo,
									'inicio' 						=> $item->fecha_min,
									'fin' 							=> $item->fecha_max,
									'usuario_id' 				=> $item->Usu_IdUsuario,
									'leccion_id' 				=> $item->Lec_IdLeccion,
									// 'asistencia' 				=> $item->Lea_Asistencia,
									'asistencia' 				=> $item->confirma_asistencia,
									'sessiones_format' 	=> $ssf
								];
							});
						$data = [
							'draw' 						=> $this->getInt('draw'),
							'recordsTotal' 		=> $records_total,
							'recordsFiltered' => $records_total_filter,
							'data' 						=> $rows,
							'confirmadas' 		=> $total_confirmados,
							'sin_confirmadas' => $total_sin_confirmados,
							'total' 					=> $total_asistencia,
							'query'	 					=> DB::getQueryLog()
						];
						$this->_view->responseJson($data);
					}
				}
			}

		}

		public function asistencia ($leccion_id) {
			$this->_acl->autenticado();
			if ($this->_acl->tienePermisos('iniciar_leccion_dirigida') && is_numeric($leccion_id) && $leccion_id != 0) {
				$objLeccion = Leccion::find($leccion_id);
				if ($objLeccion) {
					$mod_curso = $this->loadModel("_gestionCurso");
					$curso = $mod_curso->getCursoById($objLeccion->getCursoID());
					$this->_view->setTemplate(LAYOUT_FRONTEND);
					$lang = $this->_view->getLenguaje(['elearning_cursos', 'elearning_formulario_responder'], false, true);

					$data['curso'] = $curso;
					$data['obj_leccion'] = $objLeccion;
					$data['idcurso'] = $curso['Cur_IdCurso'];
					$data['other_tags'] = [$lang->get('str_asistencia')];
					$data['titulo'] = $lang->get('str_asistencia').' - '.str_limit($curso['Cur_Titulo'], 20);
					$data['active'] = 'asistencia';

					$data['sessiones'] = $objLeccion->sessiones()
						->select('leccion_asistencia.Les_IdLeccSess')
						->join('leccion_asistencia', 'leccion_asistencia.Les_IdLeccSess', 'leccion_session.Les_IdLeccSess')
						->whereNotIn('leccion_asistencia.Usu_IdUsuario', [$objLeccion->getDocente()])
						->groupBy('leccion_asistencia.Les_IdLeccSess')
						->get();
					
					$this->_view->assign($data);
					$this->_view->render('asistencia_leccion');

				} else {
					$this->redireccionarReferer('elearning/cursos/cursos');
				}
			} else {
				$this->redireccionarReferer('elearning/cursos/cursos');
			}
      
		}
    public function pizarras ($curso_id) {
    $this->validarUrlIdioma();
        $this->_acl->autenticado();
        if ($this->_acl->tienePermisos('crear_pizarras')) {
            $this->_view->setTemplate(LAYOUT_FRONTEND);
            $lang = $this->_view->getLenguaje(['elearning_cursos', 'elearning_formulario_responder'], false, true);
            if (is_numeric($curso_id) && $curso_id != 0) {
							$mod_curso = $this->loadModel("_gestionCurso");
							$curso = $mod_curso->getCursoById($curso_id, Cookie::lenguaje());
							// dd($curso);
							if ($curso) {
								$mod_modulo = $this->loadModel("_gestionModulo");
								$mod_leccion = $this->loadModel("_gestionLeccion");
								$modulos = $mod_modulo->getModulos($curso_id);
								$mod_ids = [];
								foreach ($modulos as $key => $value) {
										$mod_ids[] = $value['Moc_IdModuloCurso'];
								}
								$pizarras = Leccion::getByModulos($mod_ids)->getPizarras()->get();
								
								$data['pizarras'] = $pizarras;
								$data['modulos'] = $modulos;
                $data['active'] = 'pizarras';
                $data['curso'] = $curso;
                $data['idcurso'] = $curso['Cur_IdCurso'];
                $data['other_tags'] = [$lang->get('str_pizarras')];
								$data['data_vue'] = [
									'curso_id' 			=> $curso['Cur_IdCurso'],
									'leccion_mode' 	=> 'pizarras',
								];
                $data['titulo'] = $lang->get('str_pizarras').' - '.str_limit($curso['Cur_Titulo'], 20);

                $this->_view->assign($data);
                $this->_view->render('pizarras');
							}



            }
        } else {
            echo 'no posee';
        }


    }
    public function __construct($lang,$url)
    {
        parent::__construct($lang,$url);
        $this->_view->assign('_url', BASE_URL . "modules/" . $this->_request->getModulo() . "/views/");
        $this->getLibrary("ServiceResult");
        $this->service = new ServiceResult();
        $this->examen = $this->loadModel("examen");
		}
		public function store_pizarra ($curso_id) {
			$this->_acl->autenticado();
			if (is_numeric($curso_id) && $curso_id != 0 && Curso::existeCurso($curso_id)) {

				$titulo = $this->getTexto('titulo');
				$desc = $this->getTexto('descripcion');
				$tiempo = $this->getTexto('tiempo');
				$modulo = $this->getTexto('modulo');
				// dd($modulo);
				if ($modulo != 0) {
						$Mmodel = $this->loadModel("_gestionLeccion");
						$leccion_id = $Mmodel->insertLeccion($modulo, Leccion::TIPO_DIRIGIDA, $titulo, $desc, $tiempo);
						$this->redireccionar('elearning/gleccion/pizarras/'.$curso_id);
				}
			}
		}
    public function store_encuesta ($curso_id) {
        //$this->validarUrlIdioma();
        $this->_acl->autenticado();
        if (is_numeric($curso_id) && $curso_id != 0 && Curso::existeCurso($curso_id)) {
            $titulo = $this->getTexto('titulo');
            $desc = $this->getTexto('descripcion');
            $tiempo = $this->getTexto('tiempo');
            $modulo = $this->getTexto('modulo');
            
            if ($modulo != 0 || $modulo == Formulario::hashEncuestaLibre()) {
                $lang = $this->_view->getLenguaje(['elearning_cursos', 'elearning_formulario_responder'], false, true);
                $Mmodel = $this->loadModel("_gestionLeccion");
		    dd(Formulario::hashEncuestaLibre(),$modulo);
                if (Formulario::hashEncuestaLibre() == $modulo)
                    $leccion_id = $Mmodel->insertLeccion(null , Leccion::TIPO_ENCUESTA_LIBRE, $titulo, $desc, $tiempo);
                else 
                    $leccion_id = $Mmodel->insertLeccion($modulo , Leccion::TIPO_ENCUESTA, $titulo, $desc, $tiempo);


                    //registrar un formulario y su relación
                $frm = new Formulario();
                $frm->Frm_Titulo = $titulo;
                $frm->Frm_Descripcion = $desc;
                $frm->Cur_IdCurso = $curso_id;
                $frm->Frm_Titulo = $titulo;
                $frm->Frm_Estado = 1;
                $frm->Frm_Tipo = 1;
                $frm->Frm_Mensaje = $lang->get('elearning_cursos_gracias_por_contestar_encuesta');
                if ($frm->save()) {
                    $lf = new LeccionFormulario();
                    $lf->Lec_IdLeccion = $leccion_id;
                    $lf->Frm_IdFormulario = $frm->Frm_IdFormulario;
                    if ($lf->save()) {
                        $this->redireccionar('elearning/gleccion/encuestas/'.$curso_id);

                    }
                }

            } else echo 'asd';
        }
    }

    public function agregar_pizarra ($curso_id) {
      $this->agregar_encuesta($curso_id, 'pizarras');
    }
    /**
     * [agregar_encuesta registrar encuestas y lecciones 
     *  $modo|encuestas, registra solo encuestas
     *  $modo|pizarras, solo pizarras
     * ]
     *
     * @return  [type]  [return description]
     */
    public function agregar_encuesta ($curso_id, $modo = 'encuestas') {
        $this->_acl->autenticado();
        // dd($this->_acl->getPermisos());
        if ($this->_acl->tienePermisos('crear_encuestas_leccion')) {
            $this->_view->setTemplate(LAYOUT_FRONTEND);

            $data = [];
            $lang = $this->_view->getLenguaje(['elearning_cursos', 'elearning_formulario_responder'], false, true);
            if (is_numeric($curso_id) && $curso_id != 0) {
                $mod_curso = $this->loadModel("_gestionCurso");
                $curso = $mod_curso->getCursoById($curso_id, Cookie::lenguaje());
                $mod_modulo = $this->loadModel("_gestionModulo");
								$modulos = $mod_modulo->getModulos($curso_id);
								$data['modo'] = $modo;
                $data['curso'] = $curso;
                $data['modulos'] = $modulos;
								$data['idcurso'] = $curso['Cur_IdCurso'];
								if ($modo == 'encuestas'){
									$data['other_tags'] = [$lang->get('elearning_cursos_agregar_encuesta')];
									$data['titulo'] = $lang->get('elearning_cursos_agregar_encuesta').' - '.$curso['Cur_Titulo'];
									$data['target_url_store'] = BASE_URL.'elearning/gleccion/store_encuesta/'.$curso['Cur_IdCurso'];
								}
								if ($modo == 'pizarras') {
                	$data['other_tags'] = [$lang->get('elearning_cursos_agregar_pizarra')];
									$data['titulo'] = $lang->get('elearning_cursos_agregar_pizarra').' - '.$curso['Cur_Titulo'];
									$data['target_url_store'] = BASE_URL.'elearning/gleccion/store_pizarra/'.$curso['Cur_IdCurso'];
								}
                $this->_view->assign($data);
                $this->_view->render('agregar_encuesta');
            }
        } else {
             $this->redireccionar('');
        }
    }

    public function eliminar_encuesta ($leccion_id) {
        $this->_acl->autenticado();
        $res = ['success' => false, 'msg' => ''];
        if ($this->_acl->tienePermisos('crear_encuestas_leccion')) {
            $lecc_form = LeccionFormulario::findByLeccion($leccion_id);
            if ($lecc_form) {
                $leccion = Leccion::find($lecc_form->Lec_IdLeccion);
                $formulario = Formulario::find($lecc_form->Frm_IdFormulario);
                DB::transaction(function () use($lecc_form, $leccion, $formulario, &$res) {
                    if ($lecc_form) {
                        $lecc_form->delete();
                        $leccion->delete();
                        $formulario->delete();
                        $res['success'] = true;
                        $res['msg'] = 'Elemento eliminado';
                    }
                });

            }
        } else {
            $res['msg'] = 'No posee permisos';
        }
        $this->_view->responseJson($res);
		}
		
		public function datatable_lecciones ($curso_id, $modo = 'default') {
			$this->_acl->autenticado();	
			if ($modo != 'default') {
				$objCurso = Curso::find($curso_id);
				if ($objCurso) {
					$lang = $this->_view->getLenguaje(false, false, true);
					DB::enableQueryLog();
					$datatable_response = [
						'draw' 						=> $this->getInt('draw'),
						'recordsTotal' 		=> 0,
						'recordsFiltered' => 0,
						'data' 						=> [],
						'query'	 					=> []
					];
					// $mod_curso = $this->loadModel("_gestionCurso");
					// $curso = $mod_curso->getCursoById($curso_id);
					$mod_modulo = $this->loadModel("_gestionModulo");
					// $mod_leccion = $this->loadModel("_gestionLeccion");
					$modulos = $mod_modulo->getModulos($curso_id);
					$mod_ids = [];
					foreach ($modulos as $key => $value) {
							$mod_ids[] = $value['Moc_IdModuloCurso'];
					}
					

					

					if ($modo == 'pizarras') {
						$query = Leccion::getByModulos($mod_ids)->select()->addSelect('modulo_curso.Moc_Titulo as Moc_Titulo_Format')
							->join('modulo_curso', 'modulo_curso.Moc_IdModuloCurso', 'leccion.Moc_IdModuloCurso');
						$query->where('leccion.Lec_Tipo', Leccion::TIPO_DIRIGIDA);
					}
					if ($modo == 'encuestas') {
						$query = LeccionFormulario::getByCurso($curso_id)->select('leccion.*', 'modulo_curso.*',
							DB::raw("IFNULL(modulo_curso.Moc_Titulo, '".$lang->get('str_encuesta_libre')."') as Moc_Titulo_Format")
						);
						$query->whereIn('leccion.Lec_Tipo', [Leccion::TIPO_ENCUESTA, Leccion::TIPO_ENCUESTA_LIBRE]);
					}
					
					$datatable_response['recordsTotal'] = $datatable_response['recordsFiltered'] = $query->count();
					
					if ($this->has('filter')) {
						$query->where(function($query) use($lang){
							if (isset($_GET['filter']['query']) && $_GET['filter']['query'] != '') 
								$query->orWhere(DB::raw("CONCAT(Lec_Titulo, ' ', IFNULL(modulo_curso.Moc_Titulo, '".$lang->get('str_encuesta_libre')."'))"), 'like', '%'.$_GET['filter']['query'].'%');
							if (isset($_GET['filter']['modulo_id']) && $_GET['filter']['modulo_id'] != -1)
								if ($_GET['filter']['modulo_id'] == Formulario::hashEncuestaLibre())
									$query->where('formulario.Frm_Tipo', Formulario::TIPO_ENCUESTA_LIBRE);
								else
									$query->where('leccion.Moc_IdModuloCurso', $_GET['filter']['modulo_id']);
						});
					}

					
					if ($this->has(['order', 'columns'])) {
						foreach ($_GET['order'] as $key => $value) {
							$nc = $_GET['columns'][$value['column']]['data'];
							// dd($nc);
							if ($modo == 'encuestas') {
								switch ($nc) {
									case 'leccion_titulo': $nc = 'formulario.Frm_Titulo'; break;
									case 'leccion_descripcion': $nc = 'formulario.Frm_Descripcion'; break;
									case 'modulo_titulo': $nc = 'Moc_Titulo_Format'; break;

									// case 'inicio': 	$nc = 'leccion.Lec_FechaDesde'	;	break;
									// case 'fin': 	$nc = 'leccion.Lec_FechaHasta'	;	break;
									default: $nc = 'none';
								}
							}
							if ($modo == 'pizarras') {
								switch ($nc) {
									case 'leccion_titulo': $nc = 'leccion.Lec_Titulo'; break;
									case 'leccion_descripcion': $nc = 'leccion.Lec_Descripcion'; break;
									case 'modulo_titulo': $nc = 'modulo_curso.Moc_Titulo'; break;

									// case 'inicio': 	$nc = 'leccion.Lec_FechaDesde'	;	break;
									// case 'fin': 	$nc = 'leccion.Lec_FechaHasta'	;	break;
									default: $nc = 'none';
								}
							}
							if ($nc != 'none' && $_GET['columns'][$value['column']]['data'])
								$query->orderBy($nc, $value['dir']);
						}
					}

					// if ($this->filledGet('export')) 
					$rows = $query->offset($this->getInt('start'))
						->limit($this->getInt('length'))
						->get()->map(function($item) {
							return [
								'leccion_id' => $item->Lec_IdLeccion,
								'leccion_titulo' => $item->Lec_Titulo,
								'leccion_descripcion' => str_limit($item->Lec_Descripcion, 100),
								'modulo_titulo' => $item->Moc_Titulo_Format,
								'modulo_id' => $item->Moc_IdModuloCurso,
							];
						});
					$datatable_response['data'] = $rows;
					$datatable_response['query'] = DB::getQueryLog();
					$this->_view->responseJson($datatable_response);
				}
			}
		}

    public function encuestas ($curso_id) {
        $this->_acl->autenticado();
        if ($this->_acl->tienePermisos('crear_encuestas_leccion')) {
            $this->_view->setTemplate(LAYOUT_FRONTEND);
            $data = [];
            $lang = $this->_view->getLenguaje(['elearning_cursos', 'elearning_formulario_responder'], false, true);
            if (is_numeric($curso_id) && $curso_id != 0) {
                $mod_curso = $this->loadModel("_gestionCurso");
                $curso = $mod_curso->getCursoById($curso_id, Cookie::lenguaje());
                $mod_modulo = $this->loadModel("_gestionModulo");
                $mod_leccion = $this->loadModel("_gestionLeccion");
								$modulos = $mod_modulo->getModulos($curso_id);
                // $mod_ids = [];
                // foreach ($modulos as $key => $value) {
                //     $mod_ids[] = $value['Moc_IdModuloCurso'];
                // }
                // $encuestas = Leccion::getByModulos($mod_ids)->getEncuestas()->get();
                // dd($encuestas);
                // $data['encuestas'] = $encuestas;
                $data['active'] = 'encuestas';
                $data['modulos'] = $modulos;
                $data['curso'] = $curso;
                $data['idcurso'] = $curso['Cur_IdCurso'];
                $data['other_tags'] = [$lang->get('str_encuestas')];
								$data['data_vue'] = [
									'curso_id' 			=> $curso['Cur_IdCurso'],
									'leccion_mode' 	=> 'encuestas',
								];
                $data['titulo'] = $lang->get('str_encuestas').' - '.str_limit($curso['Cur_Titulo'], 20);

                $this->_view->assign($data);
                $this->_view->render('encuestas');
            }
        } else {
            $this->redireccionar('');
        }

		}
		public function datatable_encuesta_respuestas ($leccion_id) {
			$this->_acl->autenticado();	
			$datatable_response = [
				'draw' 						=> $this->getInt('draw'),
				'recordsTotal' 		=> 0,
				'recordsFiltered' => 0,
				'data' 						=> [],
				'query'	 					=> []
			];
			DB::enableQueryLog();
			if ($this->filtrarInts([$leccion_id]) && Leccion::existeLeccion($leccion_id)) {
				$lecc_frm = LeccionFormulario::findByLeccion($leccion_id);
				if ($lecc_frm) {
					$formulario = $lecc_frm->formulario;
					$query = $formulario->respuestas()
						->select(
							'formulario_usuario_respuestas.*',
							DB::raw("CONCAT(usuario.Usu_Nombre, ' ', usuario.Usu_Apellidos) as Usu_NombreCompleto"),
							'Usu_Usuario'
							)
						->joinUsuarios();
				}
				$datatable_response['recordsTotal'] = $datatable_response['recordsFiltered'] = $query->count();
				
				if ($this->has('filter')) {
					$query->where(function($query) {
						if (isset($_GET['filter']['query']) && $_GET['filter']['query'] != '') 
							$query->orWhere(DB::raw("CONCAT(usuario.Usu_Nombre, ' ', usuario.Usu_Apellidos)"), 'like', '%'.$_GET['filter']['query'].'%');
					});
				}

				
				if ($this->has(['order', 'columns'])) {
					foreach ($_GET['order'] as $key => $value) {
						$nc = $_GET['columns'][$value['column']]['data'];
						switch ($nc) {
							case 'usuario_id': $nc = 'Usu_IdUsuario'; break;
							case 'usuario_nombre': 	$nc = 'Usu_NombreCompleto'	;	break;
							case 'usuario_cuenta': 	$nc = 'Usu_Usuario'	;	break;
							case 'respuesta_fecha': 	$nc = 'Fur_CreatedAt'	;	break;
							default: $nc = 'no_found_col'; break;
						}
						if ($nc != 'no_found_col')
							$query->orderBy($nc, $value['dir']);
					}
				}

				// if ($this->filledGet('export')) 
				$rows = $query->offset($this->getInt('start'))
					->limit($this->getInt('length'))
					->get()->map(function($item) {
						// print_r($item->toArray());
						return [
							'usuario_id' => $item->Usu_IdUsuario,
							'usuario_nombre' => $item->Usu_NombreCompleto,
							'usuario_cuenta' => $item->Usu_Usuario,
							'respuesta_fecha' => $item->Fur_CreatedAt->format('Y-m-d H:i:s'),
							'formulario_respuesta_id' => $item->Fur_IdFrmUsuRes,
							'formulario_id' => $item->Frm_IdFormulario
						];
					});
				$datatable_response['data'] = $rows;
				$datatable_response['query'] = DB::getQueryLog();
				
			}
			$this->_view->responseJson($datatable_response);
		
		}
    public function encuesta ($leccion_id) {
        $this->_acl->autenticado();
        // dd($this->_acl->getPermisos());
        if ($this->_acl->tienePermisos('crear_encuestas_leccion')) {
            $this->_view->setTemplate(LAYOUT_FRONTEND);

            $data = [];
            $lang = $this->_view->getLenguaje(['elearning_cursos', 'elearning_formulario_responder'], false, true);
            if (is_numeric($leccion_id) && $leccion_id != 0) {
                $mod_leccion = $this->loadModel("_gestionLeccion");
                $mod_modulo = $this->loadModel("_gestionModulo");
								$leccion = $mod_leccion->getLeccionId($leccion_id);
								// dd($leccion);
								
								

                if ($leccion) {
										
                    $data["modulo"] =  $modulo ?? null;
                    $data["leccion"] =  $leccion;
                    $data['idLeccion'] =  $leccion_id;
										
										$mod_curso = $this->loadModel("_gestionCurso");

										$lecc_frm = LeccionFormulario::findByLeccion($leccion_id);

										if ($leccion['Lec_Tipo'] == Leccion::TIPO_ENCUESTA) {

											$modulo = $mod_modulo->getModuloId($leccion["Moc_IdModuloCurso"]);
											$curso = $mod_curso->getCursoById($modulo['Cur_IdCurso'], Cookie::lenguaje());
										}
										if ($leccion['Lec_Tipo'] == Leccion::TIPO_ENCUESTA_LIBRE) {
											$curso = $mod_curso->getCursoById($lecc_frm->formulario->Cur_IdCurso, Cookie::lenguaje());
										}
                    
                    $data['titulo'] = $lang->get('str_encuesta').' - '.str_limit($curso['Cur_Titulo'], 20);
                    // $data['active'] = 'examen';

                    $data['idcurso'] = $curso['Cur_IdCurso'];
                    $data['curso'] = $curso;

                    
                    // dd($lecc_frm->formulario);
                    $data['formulario'] = null;
                    // $data['respuestas'] = null;
                    if ($lecc_frm) {
											$formulario = $data['formulario'] = $lecc_frm->formulario;
											// if (isset($formulario) && $formulario != null) {
											// 		// $data['respuestas'] = $formulario->respuestas;
											// }
										}
										
                    //buscar formulario
                }


            }

            $this->_view->assign($data);
            $this->_view->render('encuesta');
        } else {
            $this->redireccionar('');
        }
    }
    public function _view_lecciones_modulo($id_curso = 0, $id_modulo = 0){
        // $curso = $this->getTexto("curso");
        // $modulo = $this->getTexto("modulo");
    $this->validarUrlIdioma();

        $this->_view->setTemplate(LAYOUT_FRONTEND);
         $lang = $this->_view->getLenguaje(['elearning_cursos'], false, true);
        if(strlen($id_curso)==0){ $id_curso = Session::get("learn_param_curso"); }
        if(strlen($id_modulo)==0){ $id_modulo = Session::get("learn_param_modulo"); }
        if(strlen($id_curso)==0 || strlen($id_modulo)==0){ exit; }

        Session::set("learn_param_curso", $id_curso);
        Session::set("learn_param_modulo", $id_modulo);

        $Lmodel = $this->loadModel("_gestionLeccion");
        $Cmodel = $this->loadModel("_gestionCurso");
        $Mmodel = $this->loadModel("_gestionModulo");  
        $_arquitectura = $this->loadModel('index','arquitectura');

        $curso = $Cmodel->getCursoXId($id_curso, Cookie::lenguaje());
        $tipo = $Lmodel->getTipoLecccion( $curso["Moa_IdModalidad"]==2? " ": "", Cookie::lenguaje() );
        $lecciones = $Lmodel->getLecciones($id_modulo, Cookie::lenguaje());
        $modulo = $Mmodel->getModuloId($id_modulo, Cookie::lenguaje());

        Session::set("learn_url_tmp", "gleccion/_view_lecciones_modulo");
        $this->_view->assign('idiomas',$_arquitectura->getIdiomas());

        $this->_view->assign('IdiomaOriginal',$curso["Idi_IdIdioma"]);
        $this->_view->assign("tipo", $tipo);
        $this->_view->assign('menu', 'curso');
        $this->_view->assign("lecciones", $lecciones);
        $this->_view->assign("modulo", $modulo);
        $this->_view->assign("curso", $curso);

        $this->_view->assign("titulo", $modulo['Moc_Titulo'].' - '.$curso['Cur_Titulo']);
        $this->_view->render("ajax/_view_lecciones_modulo");
    }

    //JM-Ya
    public function gestion_idiomas() {
        // $this->_view->getLenguaje(['elearning_gcurso', 'elearning_cursos'], false, true);   
        $_arquitectura = $this->loadModel('index','arquitectura');
        $condicion1 = '';
        $idIdiomaOriginal = $this->getPostParam('idIdiomaOriginal');  
        $Idi_IdIdioma = $this->getPostParam('idIdioma');      
        $Moc_IdModuloCurso = $this->getPostParam('Moc_IdModuloCurso');

        // $condicion1 .= " WHERE m.Moc_IdModuloCurso = $Moc_IdModuloCurso ";            
        // $datos = $this->_arquitectura->getPaginaTraducida($condicion1,$Idi_IdIdioma);
        // echo $condicion1;
        $Mmodel = $this->loadModel("_gestionModulo");
        $datos = $Mmodel->getModuloId($Moc_IdModuloCurso);
        // print_r($datos);
        $this->_view->assign('idiomas',$_arquitectura->getIdiomas());
        // echo $Idi_IdIdioma;
        // echo $idIdiomaOriginal ;
        if ($idIdiomaOriginal != $Idi_IdIdioma) { 
            $Moc_TiempoDedicacion = $datos["Moc_TiempoDedicacion"];
            $datos = array();
            $datos["Moc_IdModuloCurso"] = $Moc_IdModuloCurso;
            $datos["Cur_IdCurso"] = "";
            $datos["Moc_Titulo"] = "";
            $datos["Moc_Descripcion"] = "";
            $datos["Moc_TiempoDedicacion"] = $Moc_TiempoDedicacion;
            $datos["Moc_Porcentaje"] = "";
            $datos["Idi_IdIdioma"] = $Idi_IdIdioma;
            $datos["Moc_FechaReg"] = "";
            $datos["Moc_Estado"] = "";
            $datos["Row_Estado"] = "";

            $contTrad = $Mmodel->getContTraducido("modulo_curso", $Moc_IdModuloCurso, $Idi_IdIdioma);
            // print_r($contTrad);
            for ($i=0; $i < count($contTrad); $i++) { 
                $datos[$contTrad[$i]["Cot_Columna"]] = $contTrad[$i]["Cot_Traduccion"];
            }
          // print_r($datos);
        }

        $this->_view->assign('modulo',$datos);  

        $this->_view->assign('IdiomaOriginal',$this->getPostParam('idIdiomaOriginal'));
        // $this->_view->assign('parametros', $parametros);
        // echo Cookie::lenguaje();
        $this->_view->renderizar('ajax/gestion_idiomas', false, true);
    }

    public function _registrar_leccion(){
        // dd($_REQUEST);
        $id = $this->getTexto("id");
        if (is_numeric($id) && $id != 0) {
            $mod_modulo = $this->loadModel("_gestionModulo");
            $modulo = $mod_modulo->getModuloId($id);
            if ($modulo) {
                $tipo = $this->getTexto("tipo");
                $titulo = $this->getTexto("titulo");
                $descripcion = $this->getTexto("descripcion");
                $dedicacion = $this->getTexto("dedicacion");

                $Mmodel = $this->loadModel("_gestionLeccion");
                $leccion_id = $Mmodel->insertLeccion($id, $tipo, $titulo, $descripcion, $dedicacion);
                if ($tipo == 10) {
                    //registrar un formulario y su relación
                    $frm = new Formulario();
                    $frm->Frm_Titulo = $titulo;
                    $frm->Frm_Descripcion = $descripcion;
                    $frm->Cur_IdCurso = $modulo['Cur_IdCurso'];
                    $frm->Frm_Titulo = $titulo;
                    $frm->Frm_Estado = 1;
                    $frm->Frm_Tipo = 1;
                    $frm->Frm_Mensaje = 'Gracias por contestar esta encuesta';
                    if ($frm->save()) {
                        $lf = new LeccionFormulario();
                        $lf->Lec_IdLeccion = $leccion_id;
                        $lf->Frm_IdFormulario = $frm->Frm_IdFormulario;
                        if ($lf->save()) {


                        }
                    }
                }

            }
        }

        $this->service->Success("Se resgistó el módulo con exito");
        $this->service->Send();
    }

    public function _estado_leccion(){
        $id = $this->getTexto("id");
        $estado = $this->getTexto("estado");
        $model = $this->loadModel("_gestionLeccion");

        $leccion = $model->getLeccionId($id);
        if ($leccion["Lec_Tipo"]==3 && $estado == 1){
            $mensaje = $model->ValidarPreguntasExamen($id);
            if(strlen($mensaje)!=0){
                // echo "a";exit;
                $this->service->error($mensaje);
                $this->service->Send();
            }else{
                $model->updateEstadoLeccion($id, $estado);
                 // echo "aca";exit;
                $this->service->Success($estado);
                $this->service->Send();
            }
        }else{
            $model->updateEstadoLeccion($id, $estado);
            $this->service->Success($estado);
            $this->service->Send();
        }
    }

    public function _eliminar_leccion(){
        $id = $this->getTexto("id");
        $model = $this->loadModel("_gestionLeccion");
        $model->deleteLeccion($id);

        $this->service->Success($estado);
        $this->service->Send();
    }

    public function _eliminar_referencia(){
        $id = $this->getTexto("id");
        $model = $this->loadModel("_gestionLeccion");
        $model->deleteReferencia($id);

        $this->service->Success($estado);
        $this->service->Send();
    }

    public function _eliminar_material(){
        $id = $this->getTexto("id");
        $model = $this->loadModel("_gestionLeccion");
        $model->deleteMaterial($id);

        $this->service->Success($estado);
        $this->service->Send();
    }

    public function _view_leccion($curso = 0, $modulo = 0, $leccion = 0){

        // $curso = $this->getTexto("curso");
        // $modulo = $this->getTexto("modulo");
        // $leccion = $this->getTexto("leccion");
    $this->validarUrlIdioma();
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        if(strlen($curso)==0){ $curso = Session::get("learn_param_curso"); }
        if(strlen($modulo)==0){ $modulo = Session::get("learn_param_modulo"); }
        if(strlen($leccion)==0){ $leccion = Session::get("learn_param_leccion"); }
        if(strlen($curso)==0 || strlen($modulo)==0 || strlen($leccion)==0){ exit; }

        Session::set("learn_param_curso", $curso);
        Session::set("learn_param_modulo", $modulo);
        Session::set("learn_param_leccion", $leccion);
        Session::set("learn_url_tmp", "gleccion/_view_leccion");

        $Tmodel = $this->loadModel("trabajo"); //RODRIGO 20180605
        $Cmodel = $this->loadModel("_gestionCurso");
        $Mmodel = $this->loadModel("_gestionModulo");
        $model = $this->loadModel("_gestionLeccion");
        $examen = $this->loadModel("examen");

        $Exa_Porcentaje = $examen->getExamenesPorcentaje($curso);
        $Tra_Porcentaje = $examen->getTrabajosPorcentaje($curso);

        $Porcentaje = 100 - $Exa_Porcentaje['Exa_PorcentajeTotal'] - $Tra_Porcentaje['Tra_PorcentajeTotal'];

        $cursoDatos = $Cmodel->getCursoXId($curso);
        $modulo = $Mmodel->getModuloId($modulo);
        $leccion = $model->getLeccionId($leccion);
        $referencias = $model->getReferenciaLeccion($leccion["Lec_IdLeccion"]);
        $material = $model->getMaterialLeccion($leccion["Lec_IdLeccion"]);
        $trabajo = $Tmodel->getTrabajoUsuario($leccion["Lec_IdLeccion"]); //RODRIGO 20180605
        $tipo_trabajo = $Tmodel->getConstanteTrabajo(); //RODRIGO 20180605

        $data['titulo'] = $leccion['Tipo'].' - '.$leccion['Lec_Titulo'];
        $this->_view->assign($data);
        $view = "";
        $this->_view->assign('porcentaje', $Porcentaje);
        $this->_view->assign('menu', 'curso');
        $this->_view->assign("curso", $cursoDatos);
        $this->_view->assign("modulo", $modulo);
        $this->_view->assign("leccion", $leccion);
        $this->_view->assign("referencias", $referencias);
        $this->_view->assign("material", $material);
        $this->_view->assign("trabajo", $trabajo); //RODRIGO 20180605
				$this->_view->assign("tipo_trabajo", $tipo_trabajo); //RODRIGO 20180605
				
        switch ($leccion["Lec_Tipo"]) {
            case Leccion::TIPO_HTML:
                $contenido = $model->getContenidoLeccion($leccion["Lec_IdLeccion"]);
                $this->_view->assign("contenido", $contenido);
                $this->_view->assign("Lec_Tipo",$leccion["Lec_Tipo"]);
                $view = "ajax/_view_1";
                break;
            case Leccion::TIPO_VIDEO:
                $contenido = $model->getDetalleLeccion2($leccion["Lec_IdLeccion"]);
                $this->_view->assign("contenido", $contenido);
                $view = "ajax/_view_2";
                break;
            case Leccion::TIPO_EXAMEN:
                // $ExaModel = $this->loadModel("examen");
                // $examen = $ExaModel->getExamenxLeccion($leccion["Lec_IdLeccion"]);
                $condicion = " WHERE e.Lec_IdLeccion = ".$leccion["Lec_IdLeccion"]." ";
                $this->_view->assign('examens',  $this->examen->getExamensCondicion(0,CANT_REG_PAG, $condicion));
                $paginador = new Paginador();
                $arrayRowCount = $this->examen->getExamenesRowCount($condicion);
                $totalRegistros = $arrayRowCount['CantidadRegistros'];
                $paginador->paginar($totalRegistros,"listarexamens", "", 0, CANT_REG_PAG, true);
                $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
                $this->_view->assign('idcurso', $curso);


                // $porcentaje = $this->examen->getExamensCondicion(0,CANT_REG_PAG, " WHERE e.Lec_IdLeccion = ".$leccion["Lec_IdLeccion"]." AND e.Exa_Estado = 1 AND e.Row_Estado = 1");
                // // print_r($porcentaje);
                // if (count($porcentaje)>0) {

                // $this->_view->assign('porcentaje', $porcentaje['Porcentaje'] );
                // } else {

                // $this->_view->assign('porcentaje', "");
                // }


                // if ($examen && count($examen) > 0) {
                // // print_r($examen);exit;
                //     $this->redireccionar("elearning/examen/editarexamen/".$examen["Cur_IdCurso"]."/".$examen["Exa_IdExamen"]);
                // } else {
                //     $this->redireccionar("/elearning/examen/nuevoexamen/".$curso["Cur_IdCurso"]);
                // }


                // $examen = $model->insertExamenLeccion($leccion["Lec_IdLeccion"], "", 0, 0, 0);
                // $preguntas = $model->getPreguntas($examen[0]["Exa_IdExamen"]);
                // $this->_view->assign("examen", $examen);
                // $this->_view->assign("preguntas", $preguntas);
                $view = "ajax/_view_3";

                break;
            case Leccion::TIPO_DIRIGIDA:
                $piz = $this->loadModel("pizarra");
                $pizarras = $piz->getPizarrasLeccion($leccion["Lec_IdLeccion"]);
                $this->_view->assign("pizarras", $pizarras);
                $view = "ajax/_view_4";
                break;
            case 6:
                $contenido = $model->getContenidoLeccion($leccion["Lec_IdLeccion"]);
                $this->_view->assign("contenido", $contenido);
                $this->_view->assign("Lec_Tipo",$leccion["Lec_Tipo"]);
                $view = "ajax/_view_1";
                break;


				}
        $this->_view->render($view);
    }

    public function _cambiarEstadoExamenPO(){
        $this->_acl->acceso('agregar_rol');
        //Para Mensajes
        $resultado = array();
        $mensaje = "error";
        $contenido = "";
        //Para mensajes

        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $Exa_Idpregunta = $this->getInt('_Exa_IdExamen');
        $Exa_Estado = $this->getInt('_Exa_Estado');
        $Lec_IdLeccion = $this->getInt('_Lec_IdLeccion');
        // $idExamen=$this->getInt('idexamen');
        $idcurso = $this->getInt('_idcurso');
        // echo $Per_Estado."//".$Per_Idpregunta; exit;

        if(!$Exa_Idpregunta){
            $contenido = 'Error parametro ID...!!';
            $mensaje = "error";
            array_push($resultado, array(0 => $mensaje, 1 => $contenido));
        } else {
            $rowCountEstado = $this->examen->cambiarEstadoExamen($Exa_Idpregunta, $Exa_Estado);
            if ($rowCountEstado > 0) {
                if ($Exa_Estado == 1) {
                    $contenido = ' Se cambio de estado correctamente a <b>Deshabilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign" title="Deshabilitado" style="background: #FFF; color: #DD4B39; padding: 2px;"/> ...!! ';
                }
                if ($Exa_Estado == 0) {
                     $contenido = ' Se cambio de estado correctamente a <b>Habilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign" title="Habilitado" style=" background: #FFF;  color: #088A08; padding: 2px;"/> ...!! ';
                }
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            } else {
                $contenido = 'Error de variable(s) en consulta..!!';
                $mensaje = "error";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            }
        }
        $mensaje_json = json_encode($resultado);
        // echo($mensaje_json); exit();
        $this->_view->assign('_mensaje_json', $mensaje_json);

        $condicion = " ";
        $soloActivos = 0;

        //Filtro por Activos/Eliminados
        $condicion = " WHERE e.Lec_IdLeccion = $Lec_IdLeccion ORDER BY e.Row_Estado DESC ";
        if (!$this->_acl->permiso('ver_eliminados')) {
            $soloActivos = 1;
            $condicion = " WHERE e.Lec_IdLeccion = $Lec_IdLeccion AND e.Row_Estado = $soloActivos ";
        }

        // $paginador = new Paginador();

        // $arrayRowCount = $this->examen->getPreguntasRowCount($condicion);
        // $totalRegistros = $arrayRowCount['CantidadRegistros'];
        // $this->_view->assign('preguntas', $this->examen->getPreguntasCondicion($pagina,$filas, $condicion));

        // $paginador->paginar( $totalRegistros ,"listarpreguntas", "$txtBuscar", $pagina, $filas, true);

        // $peso= $this->examen->getExamenPeso($idExamen);
        // $puntos_pregunta= $this->examen->getPuntosPregunta($idExamen);
        // $puntos_maximo=$peso['Exa_Peso']-$puntos_pregunta['puntos_pregunta'];
        // $this->_view->assign('puntos_maximo', $puntos_maximo);
        // $this->_view->assign('idcurso', $idcurso);
        // $this->_view->assign('examen',$idExamen);
        // $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        // $this->_view->assign('paginacionpreguntas', $paginador->getView('paginacion_ajax_s_filas'));

        $ExaModel = $this->loadModel("examen");

        $paginador = new Paginador();

        $arrayRowCount = $ExaModel->getExamenesRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        // $examen = $ExaModel->getExamenxLeccion($leccion["Lec_IdLeccion"]);
        $this->_view->assign('examens',  $ExaModel->getExamensCondicion(0,CANT_REG_PAG, $condicion));

        $paginador->paginar( $totalRegistros,"listarexamens", "", 0, CANT_REG_PAG, true);
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('idcurso', $idcurso);
        $this->_view->assign('porcentaje', $ExaModel->getExamensCondicion(0,CANT_REG_PAG, " WHERE e.Lec_IdLeccion = ".$leccion["Lec_IdLeccion"]." AND e.Exa_Estado = 1 AND e.Row_Estado = 1"));

        $this->_view->renderizar('ajax/listarexamens', false, true);
    }

    public function _cambiarEstadoExamen(){
        $this->_acl->acceso('agregar_rol');
        //Para Mensajes
        $resultado = array();
        $mensaje = "error";
        $contenido = "";
        //Para Mensajes

        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $Exa_Idpregunta = $this->getInt('_Exa_IdExamen');
        $Exa_Estado = $this->getInt('_Exa_Estado');
        $Lec_IdLeccion = $this->getInt('_Lec_IdLeccion');
        // $idExamen=$this->getInt('idexamen');
        $idcurso = $this->getInt('idcurso');
        // echo $Per_Estado."//".$Per_Idpregunta; exit;
        if(!$Exa_Idpregunta){
            $contenido = 'Error parametro ID...!!';
            $mensaje = "error";
            array_push($resultado, array(0 => $mensaje, 1 => $contenido));
        } else {
            $rowCountEstado = $this->examen->cambiarEstadoExamen($Exa_Idpregunta, $Exa_Estado);
            if ($rowCountEstado > 0) {
                if ($Exa_Estado == 1) {
                    $contenido = ' Se cambio de estado correctamente a <b>Deshabilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign" title="Deshabilitado" style="background: #FFF; color: #DD4B39; padding: 2px;"/> ...!! ';
                }
                if ($Exa_Estado == 0) {
                     $contenido = ' Se cambio de estado correctamente a <b>Habilitado</b> <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign" title="Habilitado" style=" background: #FFF;  color: #088A08; padding: 2px;"/> ...!! ';
                }
                $mensaje = "ok";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            } else {
                $contenido = 'Error de variable(s) en consulta..!!';
                $mensaje = "error";
                array_push($resultado, array(0 => $mensaje, 1 => $contenido));
            }
        }
        $mensaje_json = json_encode($resultado);
        // echo($mensaje_json); exit();
        $this->_view->assign('_mensaje_json', $mensaje_json);
        $this->_buscarexamens();
    }

    public function _buscarexamens(){
        $txtBuscar = $this->getSql('palabra');
        $pagina = $this->getInt('pagina');
        $idcurso=$this->getInt('idcurso');

        // $Exa_Idpregunta = $this->getInt('_Exa_IdExamen');
        // $Exa_Estado = $this->getInt('_Exa_Estado');
        $Lec_IdLeccion = $this->getInt('_Lec_IdLeccion');

        $condicion = " ";
        $soloActivos = 0;
        if ($txtBuscar)
        {
            $condicion = "  WHERE Lec_IdLeccion = $Lec_IdLeccion  AND Exa_Titulo liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND e.Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY e.Row_Estado DESC  ";
            }
        } else {
            //Filtro por Activos/Eliminados
            $condicion = "  WHERE e.Lec_IdLeccion = $Lec_IdLeccion ORDER BY e.Row_Estado DESC ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = "  WHERE e.Lec_IdLeccion = $Lec_IdLeccion AND e.Row_Estado = $soloActivos ";
            }
        }

        $paginador = new Paginador();

        $arrayRowCount = $this->examen->getExamensRowCount($condicion);
        $totalRegistros = $arrayRowCount['CantidadRegistros'];
        // echo($totalRegistros);
        // print_r($arrayRowCount); echo($condicion);exit;
        $porcentaje = $this->examen->getExamensPorcentaje($idcurso);
        $this->_view->assign('examens', $this->examen->getExamensCondicion($pagina,CANT_REG_PAG, $condicion));
        $this->_view->assign('porcentaje', $porcentaje['Porcentaje'] );

        $paginador->paginar( $totalRegistros ,"listarexamens", "$txtBuscar", $pagina, CANT_REG_PAG, true);

        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('paginacionexamens', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarexamens', false, true);
    }

    public function _paginacion_listarexamens($txtBuscar = false){
        //$this->validarUrlIdioma();
        $pagina = $this->getInt('pagina');
        $filas=$this->getInt('filas');
        $idcurso=$this->getInt('idcurso');
        $totalRegistros = $this->getInt('total_registros');

        $condicion = " ";
        $soloActivos = 0;
        // $nombre = $this->getSql('palabra');
        if ($txtBuscar)
        {
            $condicion = " WHERE Cur_IdCurso=$idcurso AND Exa_Titulo liKe '%$txtBuscar%' ";
            //Filtro por Activos/Eliminados
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion .= " AND e.Row_Estado = $soloActivos ";
            } else {
                $condicion .= " ORDER BY e.Row_Estado DESC  ";
            }
        } else {
            //Filtro por Activos/Eliminados
            $condicion = "  WHERE Cur_IdCurso=$idcurso ORDER BY e.Row_Estado DESC ";
            if (!$this->_acl->permiso('ver_eliminados')) {
                $soloActivos = 1;
                $condicion = "  WHERE Cur_IdCurso=$idcurso AND e.Row_Estado = $soloActivos ";
            }
        }

        $paginador = new Paginador();
        // $arrayRowCount = $this->_aclm->getpreguntasRowCount$arrayRowCount = 0,($condicion);
        $porcentaje = $this->examen->getExamensPorcentaje($idcurso);
        $paginador->paginar( $totalRegistros,"listarexamens", "$txtBuscar", $pagina, $filas, true);
        // print_r($porcentaje['Porcentaje']);
        $this->_view->assign('examens', $this->examen->getExamensCondicion($pagina,$filas, $condicion));
        $this->_view->assign('numeropagina', $paginador->getNumeroPagina());
        $this->_view->assign('porcentaje', $porcentaje['Porcentaje'] );
        //$this->_view->assign('cantidadporpagina',$registros);
        $this->_view->assign('paginacionexamens', $paginador->getView('paginacion_ajax_s_filas'));
        $this->_view->renderizar('ajax/listarexamens', false, true);
    }

  public function _modificar_contenido(){
    $id = $this->getTexto("id");
    $titulo = $this->getTexto("titulo");
    $contenido = $this->getPostParam("contenido");

    $model = $this->loadModel("_gestionLeccion");
    $model->updateContenido($id, $titulo, $contenido);

    $this->service->Success("Se resgistó el contenido con exito");
    $this->service->Send();
  }

  public function _registrar_contenido(){
    $leccion = $this->getTexto("leccion");
    $titulo = $this->getTexto("titulo");
    $contenido = $this->getPostParam("contenido");

    $contenido = str_replace("<script>", "", $contenido);
    $contenido = str_replace("</script>", "", $contenido);
    $contenido = str_replace("<script type=\"text/javascript\">", "", $contenido);
    $contenido = str_replace("<script", "", $contenido);

    $model = $this->loadModel("_gestionLeccion");
    $model->insertContenido($leccion, $titulo, $contenido);

    $this->service->Success("Se resgistó el contenido con exito");
    $this->service->Send();
  }


    public function _actualizar_leccion(){
        $id = $this->getTexto("id_leccion");
        $titulo = $this->getTexto("titulo");
        $descripcion = $this->getTexto("descripcion");
        $dedicacion = $this->getTexto("dedicacion");

        $model = $this->loadModel("_gestionLeccion");
        $model->updateLeccion($id, $titulo, $descripcion, $dedicacion);

        $this->service->Success("Se resgistó el contenido con exito");
        $this->service->Send();
    }

    public function _registrar_referencia(){
        $leccion = $this->getTexto("leccion");
        $titulo = $this->getTexto("titulo");
        $descripcion = $this->getTexto("descripcionRef");

        $model = $this->loadModel("_gestionLeccion");
        $model->insertReferencia($leccion, $titulo, $descripcion);

        $this->service->Success("Se resgistó el contenido con exito");
        $this->service->Send();
    }

  public function _fechas_leccion(){
    $anio = $this->getTexto("anio");
    $mes = $this->getTexto("mes");
    $modulo = $this->getTexto("modulo");

    $model = $this->loadModel("_gestionLeccion");
    $data = $model->getLeccionesCalendario($mes, $anio, $modulo);

    echo json_encode($data);
  }

  public function _actualizar_fecha(){
    $dia = $this->getTexto("dia");
    $mes = $this->getTexto("mes");
    $anio = $this->getTexto("anio");
    $leccion = $this->getTexto("leccion");

    $fecha = $anio . "-" . $mes . "-" . $dia;
    $model = $this->loadModel("_gestionLeccion");
    $data = $model->updateFechaLección($leccion, $fecha);

    $this->service->Success("Se actualizó la fecha con exito");
    $this->service->Send();
  }

  public function _actualizar_video(){
    $id = $this->getTexto("id");
    $link = $this->getTexto("link");
    $descripcion = $this->getTexto("descripcion");

    // Video YouTube
    $cadena='watch?v=';
    $pos=strpos($link,$cadena);
    $pos= $pos + strlen($cadena);
    $link=substr($link,$pos,100);

    $model = $this->loadModel("_gestionLeccion");
    $model->updateVideoLeccion($id, $link, $descripcion);

    $this->service->Success("Se actualizó la fecha con exito");
    $this->service->Send();
  }

    public function _registrar_material(){

        $tipo = $this->getTexto("tipo");
        $leccion = $this->getTexto("leccion");
        $urls = json_decode($_POST['url']);
        $url = $this->getTexto("url");
        $descripcion = $this->getTexto("descripcion");
        $model = $this->loadModel("_gestionLeccion");

        if($tipo==2){

          // $url = html_entity_decode($url);
          // $url = json_decode($url, true);
            if (is_array($urls)) {
              foreach ($urls as $i) {
                $model->insertMaterial($leccion, $i->url, 2, $descripcion);
              }
            }
        }else{

          $model->insertMaterial($leccion, $url, 1, $descripcion);
        }
        $this->service->Success("Se insertó los materiales");
        $this->service->Send();
    }

  public function _registrar_pregunta(){
    $leccion = $this->getTexto("leccion");
    $tipo = $this->getTexto("tipo");

    if($tipo==1){
        $pregunta = $this->getTexto("pregunta");
        $valor = $this->getTexto("valor");
        $alt1 = $this->getTexto("alt1");
        $alt2 = $this->getTexto("alt2");
        $alt3 = $this->getTexto("alt3");
        $alt4 = $this->getTexto("alt4");
        $alt5 = $this->getTexto("alt5");

        $model = $this->loadModel("_gestionLeccion");
        $pregunta = $model->insertPregunta($leccion, $pregunta, $valor, $tipo);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 1, $alt1);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 2, $alt2);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 3, $alt3);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 4, $alt4);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 5, $alt5);
    }

    else if($tipo==2){
        $pregunta = $this->getTexto("pregunta");
        $valor = $this->getTexto("valor");
        $alt1 = $this->getTexto("alt1");
        $alt2 = $this->getTexto("alt2");
        $alt3 = $this->getTexto("alt3");
        $alt4 = $this->getTexto("alt4");
        $alt5 = $this->getTexto("alt5");

        $model = $this->loadModel("_gestionLeccion");
        $pregunta = $model->insertPregunta($leccion, $pregunta, $valor,$tipo);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 1, $alt1);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 2, $alt2);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 3, $alt3);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 4, $alt4);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 5, $alt5);
    }

    else if($tipo==3){
        $pregunta = $this->getTexto("pregunta");
        $pregunta2 = $this->getTexto("pregunta2");
        $valor = $this->getTexto("valor");
        $model = $this->loadModel("_gestionLeccion");
        $pregunta = $model->insertPregunta($leccion, $pregunta, $valor,$tipo,$pregunta2);
    }

    else if($tipo==4){
        $pregunta = $this->getTexto("pregunta");
        $valor = $this->getTexto("valor");
        $alt1 = $this->getTexto("alt1");
        $alt2 = $this->getTexto("alt2");
        $alt3 = $this->getTexto("alt3");
        $alt4 = $this->getTexto("alt4");
        $alt5 = $this->getTexto("alt5");
        $rpta1 = $this->getTexto("rpta1");
        $rpta2 = $this->getTexto("rpta2");
        $rpta3 = $this->getTexto("rpta3");
        $rpta4 = $this->getTexto("rpta4");
        $rpta5 = $this->getTexto("rpta5");

        $model = $this->loadModel("_gestionLeccion");
        $pregunta = $model->insertPregunta($leccion, $pregunta, $valor, $tipo);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 1, $alt1);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 2, $alt2);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 3, $alt3);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 4, $alt4);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 5, $alt5);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 1, $rpta1,1);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 2, $rpta2,2);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 3, $rpta3,3);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 4, $rpta4,4);
        $model->insertAlternativa($pregunta["Pre_IdPregunta"], 5, $rpta5,5);
    }

     else if($tipo==5){
        $pregunta = $this->getTexto("pregunta");
        $valor = $this->getTexto("valor");

        $model = $this->loadModel("_gestionLeccion");
        $pregunta = $model->insertPregunta($leccion, $pregunta, $valor, $tipo);
    }

        $this->service->Success("Se insertó la pregunta");
        $this->service->Send();

  }

  public function _actualizar_examen(){
    $id = $this->getTexto("id");
    $intentos = $this->getTexto("intentos");
    $porcentaje = $this->getTexto("porcentaje");
    $descripcion = $this->getTexto("descripcion");
    $peso = $this->getTexto("peso");
    $nro_preguntas = $this->getTexto("nro_preguntas");

    $model = $this->loadModel("_gestionLeccion");
    $model->updateExamen($id, $intentos, $porcentaje, $descripcion, $peso, $nro_preguntas);

    $this->service->Success("Se insertó los materiales");
    $this->service->Send();
  }

  public function _eliminar_pregunta(){
    $id = $this->getTexto("id");

    $model = $this->loadModel("_gestionLeccion");
    $model->deletePregunta($id);

    $this->service->Success("Se insertó los materiales");
    $this->service->Send();
  }

  public function _estado_pregunta(){
    $id = $this->getTexto("id");
    $estado = $this->getTexto("estado");
    $estado = strlen($estado) == 0 ? "0": "1";

    $model = $this->loadModel("_gestionLeccion");
    $model->updateEstadoPregunta($id, $estado);

    $this->service->Success("Se insertó los materiales");
    $this->service->Send();
  }

  public function _modificar_pregunta(){
    $pregunta = $this->getTexto("pregunta");
    $descripcion = $this->getTexto("descripcion");
    $valor = $this->getTexto("valor");
    $alt1 = $this->getTexto("alt1");
    $alt2 = $this->getTexto("alt2");
    $alt3 = $this->getTexto("alt3");
    $alt4 = $this->getTexto("alt4");
    $alt5 = $this->getTexto("alt5");
    $id_alt1 = $this->getTexto("id_alt1");
    $id_alt2 = $this->getTexto("id_alt2");
    $id_alt3 = $this->getTexto("id_alt3");
    $id_alt4 = $this->getTexto("id_alt4");
    $id_alt5 = $this->getTexto("id_alt5");

    $model = $this->loadModel("_gestionLeccion");
    $model->updatePregunta($pregunta, $descripcion, $valor);

    $model->updateAlternativa($id_alt1, $alt1);
    $model->updateAlternativa($id_alt2, $alt2);
    $model->updateAlternativa($id_alt3, $alt3);
    $model->updateAlternativa($id_alt4, $alt4);
    $model->updateAlternativa($id_alt5, $alt5);

    $this->service->Success("Se insertó los materiales");
    $this->service->Send();
  }
}
