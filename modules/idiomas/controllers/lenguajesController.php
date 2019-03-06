<?php

use App\Idioma;
use App\IdiomaFiles;
use App\IdiomaFilesVars;
use App\IdiomaFilesVarsBody;
use Illuminate\Database\Capsule\Manager as DB;
class lenguajesController extends idiomasController {
	protected $path_temp_import = ROOT.'tmp'.DS.'import_files'.DS;
	public function upload_import ($id) {
		$res = ['success' => false];
		if (!file_exists($this->path_temp_import))
			mkdir($this->path_temp_import);
		$row = IdiomaFiles::find($id);
		if ($row) {
			if (isset($_FILES['file']) && $_FILES['file']['type'] == 'application/json') {
				$file = $_FILES['file'];
				$name = pathinfo($file['name'], PATHINFO_FILENAME);
				if ($name == $row->Idif_FileName) {
					if(move_uploaded_file($file['tmp_name'], $this->path_temp_import.$file['name'])) {
						$res['success'] = true;
					}
				}
			}
		}
		// dd($_FILES);
		$this->_view->responseJson($res);

	}
	public function import($id) {

		$this->_view->getLenguaje('idiomas_lenguajes');
		$row = IdiomaFiles::find($id);
		$comparador = [];
		if ($row) {
			$json = '';
			$file = $this->path_temp_import.$row->Idif_FileName.'.json';
			if (is_readable($file) && basename($file) == $row->Idif_FileName.'.json') {
				$json = file_get_contents($file);
				$json = json_decode($json, true);
				if ($json['file']['name'] == $row->Idif_FileName) {
					foreach ($json['file']['vars'] as $key => $value) {
						$var = IdiomaFilesVars::get_var_by_name($value['name']);
						if ($var == null) {
							$comparador[] = ['name' => $value['name'], 'import' =>  $value, 'base' => []];
						} else{
							$var->body;
							$pre_var = ['name' => $var->Ifv_VarName, 'body' => []];
							foreach ($var->body as $key_body => $value_body) {
								$pre_var['body'][] = ['idioma' => $value_body->Idi_IdIdioma, 'value' => $value_body->Ifvb_Body];
							}
							$comparador[] = ['name' => $value['name'], 'import' => $value, 'base' => $pre_var];
						}
					}
				}
			}

		}
		dd($comparador);
		// exit;
		$vars_idioma = [];
		// $idiomas->map(function($item) use(&$vars_idioma) {
		// 	$vars_idioma['idioma_'.$item->Idi_IdIdioma] = '';
		// });
		// $data_vue = [
		// 	'idiomas' => $vars_idioma,
		// 	'file_id' => $row->Idif_IdIdiomaFile
		// ];
		$data['elemento'] = $row;
		$data['comparador'] = $comparador;
		$data['idiomas'] = $idiomas;
		$data['data_vue'] = $data_vue;
		$this->_view->assign($data);
		$this->_view->render('import');
	}
	public function migrate_files ($id) {
			if ($id == 999888) {
				$files = scandir(ROOT . 'lenguaje');
				$idiomas = Idioma::all();
				$container_idiomas = [];
				$container_files = [];
				$files_value = [];
				foreach ($idiomas as $key => $value) {
					$path_idioma = ROOT.'lenguaje'.DS.$value->Idi_IdIdioma;
					$container_idiomas[$value->Idi_IdIdioma] = [];
					if (is_readable($path_idioma)) {
						$files_idioma = scandir($path_idioma);
						$files_idioma = array_splice($files_idioma, 2);
						foreach ($files_idioma as $key_fi => $value_fi) {
							$container_files[] = $value_fi;
						}
					}
				}
				$container_files = array_unique($container_files);
				foreach ($container_files as $key => $value_file) {
					$vars_idioma = [];
					$var_idioma = [];
					$vars_file = [];
					$files_value[$value_file] = [];
					foreach ($idiomas as $key => $value) {
						$path_file = ROOT.'lenguaje'.DS.$value->Idi_IdIdioma.DS.$value_file;
						if (is_readable($path_file)) {
							$lenguaje = [];
							include $path_file;
							foreach ($lenguaje as $key_lenguaje => $value_lenguaje) {
								$vars_file[] = $key_lenguaje;
							}
						}
					}
					$vars_file = array_unique($vars_file);
					foreach ($idiomas as $key => $value) {
						$path_file = ROOT.'lenguaje'.DS.$value->Idi_IdIdioma.DS.$value_file;
						if (is_readable($path_file)) {
							$lenguaje = [];
							include $path_file;
							foreach ($vars_file as $key_vars => $value_vars) {
								if (isset($lenguaje[$value_vars])) {
									$files_value[$value_file][$value_vars][$value->Idi_IdIdioma] = $lenguaje[$value_vars];
								}
							}
						}
					}
				}

				DB::transaction(function () use($files_value) {
					foreach ($files_value as $file_name => $variables) {
						//crear ficheros
						$name = explode('.', $file_name);
						$file = IdiomaFiles::get_file_by_name($name);
						if ($file == null) {
							$file = new IdiomaFiles();
							$file->Idif_FileName = $name[0];
							$file->Idif_Descripcion = 'by migrate';
							$file->save();
						}
						if (+$file->Idif_IdIdiomaFile != 0) {
							foreach ($variables as $var => $var_body) {
								$new_variable = IdiomaFilesVars::get_var_by_name($var);
								if ($new_variable == null) {
									$new_variable = new IdiomaFilesVars();
									$new_variable->Ifv_VarName = $var;
									$new_variable->Idif_IdIdiomaFile = $file->Idif_IdIdiomaFile;
									$new_variable->save();
								}
								if (+$new_variable->Ifv_IdFileVar != 0) {
									//crear contenido de variables
									foreach ($var_body as $ref_idioma => $body) {
										$pre_build = IdiomaFilesVarsBody::where('Ifv_IdFileVar', $new_variable->Ifv_IdFileVar)->where('Idi_IdIdioma', $ref_idioma)->get();
										if ($pre_build->count() == 0) {
											$new_body = new IdiomaFilesVarsBody();
										} else {
											$new_body = $pre_build->first();
										}
										$new_body->Ifv_IdFileVar = $new_variable->Ifv_IdFileVar;
										$new_body->Idi_IdIdioma = $ref_idioma;
										$new_body->Ifvb_Body = utf8_encode($body);
										$new_body->save();


									}
								}
							}
						}
					}
				});
				echo 'TERMINADO';
			}
	}
	public function migrate_files_old ($id) {
		// if ($id == 999888) {
			$files = scandir(ROOT . 'lenguaje');
			$idiomas = Idioma::all();
			$container_idiomas = [];
			foreach ($idiomas as $key => $value) {
				$path_idioma = ROOT.'lenguaje'.DS.$value->Idi_IdIdioma;
				if (is_readable($path_idioma)) {
					$container_idiomas[$value->Idi_IdIdioma] = [];
					$files_idioma = scandir($path_idioma);
					$files_idioma = array_splice($files_idioma, 2);

					foreach ($files_idioma as $key_fi => $value_fi) {
						$lenguaje = [];
						$path_file = $path_idioma.DS.$value_fi;
						if (is_readable($path_file)) {
							include $path_file;

							if (isset($lenguaje))
								$container_idiomas[$value->Idi_IdIdioma][$value_fi] = $lenguaje;
						}
					}
				}
			}
			dd($container_idiomas);

		// }
	}
	public function generate_files () {
		$res = ['success' => false, 'msg' => ''];
		if ($this->isAcceptJson()) {
			$res = IdiomaFiles::generate_files();
		}
		$this->_view->responseJson($res);

	}
	public function delete ($id) {
		$res = ['success' => false, 'msg' => ''];
		$lenguaje = $this->_view->loadLenguaje(['request']);
		if ($this->isAcceptJson()) {
			if ($this->has(['file_id'])) {
				DB::transaction(function () use(&$res, $lenguaje) {
					try{
						$row = IdiomaFiles::find($this->getInt('file_id'));
				    if ($row) {
				    	$prename = $row->Idif_FileName;
				    	if ($row->vars()->count() == 0) {
				    		$res['success'] = $row->delete();
				    	} else {

				    	}
              $res['msg'] = str_replace('%elemento%', $prename, $lenguaje['str_elemento_eliminado_titulo']);
				    }
					} catch (Exception $e) {
						//$res['msg'] = str_replace('%elemento%', $prename, $lenguaje['str_elemento_ya_registrado']);
					}

				});
			} else {
				$res['msg'] = $lenguaje['str_parametro_falta'];
			}
		} else {
			$res['msg'] = 'method fail';
		}
		$this->_view->responseJson($res);
	}
	public function update ($id) {
		$res = ['success' => false, 'msg' => ''];
		$lenguaje = $this->_view->loadLenguaje(['request']);
		if ($this->isAcceptJson()) {
			if ($this->has(['nombre', 'descripcion', 'file_id'])) {
				DB::transaction(function () use(&$res, $lenguaje) {
					$prename = $this->getTexto('nombre');
					try{
						$row = IdiomaFiles::find($this->getInt('file_id'));
				    if ($row) {
				    	$row->Idif_FileName = $prename;
				    	$row->Idif_Descripcion = $this->getTexto('descripcion');
				    	$row->save();
				    	$res['success'] = true;
              $res['msg'] = str_replace('%elemento%', $prename, $lenguaje['str_elemento_actualizado_titulo']);
				    }
					} catch (Exception $e) {
						$res['msg'] = str_replace('%elemento%', $prename, $lenguaje['str_elemento_ya_registrado']);
					}

				});
			} else {
				$res['msg'] = $lenguaje['str_parametro_falta'];
			}
		} else {
			$res['msg'] = 'method fail';
		}
		$this->_view->responseJson($res);

	}
	public function datatable_file ($id) {
		DB::enableQueryLog();
		if (is_numeric($id)) {
			$query = IdiomaFilesVars::byFile($id)->select(
				'idiomas_files_vars.Ifv_IdFileVar',
				'idiomas_files_vars.Ifv_VarName'
			)
			->join('idiomas_files_vars_body', 'idiomas_files_vars.Ifv_IdFileVar', 'idiomas_files_vars_body.Ifv_IdFileVar')
			->groupBy('idiomas_files_vars.Ifv_IdFileVar');
			$records_total = $records_total_filter = DB::query()->selectRaw('count(*) total from ('.$query->toSql().') table_total', $query->getBindings())->first()->total;
			if ($this->filledGet('buscar')) {
				$query->where(function($q) {
					$q->orWhere('idiomas_files_vars.Ifv_VarName', 'like', '%'.$this->getTexto('buscar').'%');
					$q->orWhere('idiomas_files_vars_body.Ifvb_Body', 'like', '%'.$this->getTexto('buscar').'%');
				});
				$records_total_filter = DB::query()->selectRaw('count(*) total from ('.$query->toSql().') table_total', $query->getBindings())->first()->total;
			}
			if ($this->filledGet('export')) {
				$this->_export($query, $this->getTexto('export'));
			} else {
				$rows = $query->offset($this->getInt('start'))->limit($this->getInt('length'))->get()->map(function($item) {
					$res = $item->formatToArray();
					$res['body'] = $item->body->map(function($itemb) {
						return $itemb->formatToArray();
					});
					return $res;
				});
				$data = [
					'draw' => $this->getInt('draw'),
					'recordsTotal' => $records_total,
					'recordsFiltered' => $records_total_filter,
					'query' => DB::getQueryLog(),
	        'data' => $rows
				];
				$this->_view->responseJson($data);
			}
		}

	}
	public function datatable () {
		DB::enableQueryLog();
		$query = IdiomaFiles::select([
			'idiomas_files.Idif_IdIdiomaFile',
			'idiomas_files.Idif_FileName',
			'idiomas_files.Idif_Descripcion',
			'idiomas_files.Row_estado',
			'idiomas_files_vars.Ifv_IdFileVar',
			'idiomas_files_vars.Ifv_VarName'
		])
		->leftJoin('idiomas_files_vars', 'idiomas_files.Idif_IdIdiomaFile', 'idiomas_files_vars.Idif_IdIdiomaFile')
		->leftJoin('idiomas_files_vars_body', 'idiomas_files_vars.Ifv_IdFileVar', 'idiomas_files_vars_body.Ifv_IdFileVar')
		->groupBy('idiomas_files.Idif_IdIdiomaFile');
		$records_total = $query->get()->count();
		$records_total_filter = $records_total;
		if ($this->filledGet('buscar')) {
			$query->where(function($q) {
				$buscar = trim($this->getTexto('buscar'));
				$words = explode(' ', $buscar);
				$words = array_filter($words, function ($carry) {
					return $carry;
				});
				foreach ($words as $key => $value) {
					$q->orWhere('idiomas_files.Idif_FileName', 'like', '%'.$value.'%');
					$q->orWhere('idiomas_files_vars.Ifv_VarName', 'like', '%'.$value.'%');
					$q->orWhere('idiomas_files_vars_body.Ifvb_Body', 'like', '%'.$value.'%');
				}




					// ->orWhere('ODif_Descripcion', 'like', '%'.$_GET['buscar'].'%');
			});
			$records_total_filter = $query->get()->count();
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
        'data' => $rows
        // 'query' => DB::getQueryLog()
			];
			$this->_view->responseJson($data);
		}
	}


	public function create () {

	}

	public function store () {

		$res = ['success' => false, 'msg' => ''];
		$lenguaje = $this->_view->loadLenguaje(['request']);
		if ($this->has('nombre')) {
			DB::transaction(function () use($lenguaje, &$res) {
				try {
					$prename = $this->getTexto('nombre');
					$new = new IdiomaFiles();
			    $new->Idif_FileName = $prename.'_lang';
			    $new->Idif_Descripcion = $this->getTexto('descripcion');
			    $res['success'] = $new->save();
			    $res['msg'] = $res['success'] ? str_replace('%elemento%', $prename, $lenguaje['str_registro_success']) : $lenguaje['str_elemento_no_registrado'];
				} catch (Exception $e) {
					$res['msg'] = str_replace('%elemento%', $prename, $lenguaje['str_elemento_ya_registrado']);
				}


			});
		} else {
			$res['msg'] = $lenguaje['str_parametro_falta'];
		}
		$this->_view->responseJson($res);
	}

	public function show ($id) {
		$lenguaje = $this->_view->getLenguaje('idiomas_lenguajes', false, true);
		$row = IdiomaFiles::find($id);
		if ($this->isAcceptJson()) {
			$res = ['success' => $row != null, 'data' => null];
			$res['data'] = $row->formatToArray();
			$this->_view->responseJson($res);
		} else {
			$idiomas = Idioma::activos();
			if ($this->has('export')) {
				$res = [];
				if ($this->getTexto('export') == 'json_export') {
					// $row
					$res = ['file' => [
						'name' => $row->Idif_FileName,
						'vars' => []
					]];
					$row->vars->map(function($item) use(&$res, $row){
						// $item->body;
						$vars = ['name' => $item->Ifv_VarName, 'body' => []];
						foreach ($item->body as $key => $value) {
							$vars['body'][] = ['idioma' => $value->Idi_IdIdioma, 'value' => $value->Ifvb_Body];
							// $res['file']['vars'][][$value->Idi_IdIdioma] = $value->Ifvb_Body;


						}
						$res['file']['vars'][] = $vars;
					});
					// dd($res);
					header("Content-disposition: attachment; filename=".$row->Idif_FileName.'.json');
					header("Content-type: application/json");
					$this->_view->responseJson($res);
					// readfile("nombre_del_archivo.extension");
				}
			} else {
				$vars_idioma = [];
				$idiomas->map(function($item) use(&$vars_idioma) {
					$vars_idioma['idioma_'.$item->Idi_IdIdioma] = '';
				});
				$data_vue = [
					'idiomas' => $vars_idioma,
					'file_id' => $row->Idif_IdIdiomaFile
				];
				$data['titulo'] = $lenguaje->get('idiomas_lenguajes_titulo').' - '.$row->Idif_FileName;
				$data['elemento'] = $row;
				$data['idiomas'] = $idiomas;
				$data['data_vue'] = $data_vue;
				$this->_view->assign($data);
				$this->_view->render('detalles');
			}
		}
	}
	public function index ($id = 'index') {
		if ($id == 'index' || !is_numeric($id)) {
			$lenguaje = $this->_view->getLenguaje('idiomas_lenguajes', false, true);
			$data['titulo'] = $lenguaje->get('idiomas_lenguajes_titulo');
			$this->_view->assign($data);
			$this->_view->render('index');
		} else {
			$this->show($id);
		}
	}
}

 ?>