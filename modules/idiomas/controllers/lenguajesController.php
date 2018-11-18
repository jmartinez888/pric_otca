<?php

use App\Idioma;
use App\IdiomaFiles;
use App\IdiomaFilesVars;
use App\IdiomaFilesVarsBody;
use Illuminate\Database\Capsule\Manager as DB;
class lenguajesController extends idiomasController {
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
					//obtener nombre de variables de fichero
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
							//crear variables
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
		if (is_numeric($id)) {
			$query = IdiomaFilesVars::byFile($id);
			$records_total = $query->count();
			$records_total_filter = $records_total;
			if ($this->filledGet('buscar')) {
				$query->where(function($q) {
					$q->orWhere('Ifv_VarName', 'like', '%'.$this->getTexto('buscar').'%');
						// ->orWhere('ODif_Descripcion', 'like', '%'.$_GET['buscar'].'%');
				});
				$records_total_filter = $query->count();
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
	        'data' => $rows
				];
				$this->_view->responseJson($data);
			}
		}

	}
	public function datatable () {
		$query = IdiomaFiles::select();
		$records_total = $query->count();
		$records_total_filter = $records_total;
		if ($this->filledGet('buscar')) {
			$query->where(function($q) {
				$q->orWhere('Idif_FileName', 'like', '%'.$this->getTexto('buscar').'%');
					// ->orWhere('ODif_Descripcion', 'like', '%'.$_GET['buscar'].'%');
			});
			$records_total_filter = $query->count();
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
		$row = IdiomaFiles::find($id);
		if ($this->isAcceptJson()) {
			$res = ['success' => $row != null, 'data' => null];
			$res['data'] = $row->formatToArray();
			$this->_view->responseJson($res);
		} else {
			$idiomas = Idioma::activos();
			$vars_idioma = [];
			$idiomas->map(function($item) use(&$vars_idioma) {
				$vars_idioma['idioma_'.$item->Idi_IdIdioma] = '';
			});
			$data_vue = [
				'idiomas' => $vars_idioma,
				'file_id' => $row->Idif_IdIdiomaFile
			];
			$data['elemento'] = $row;
			$data['idiomas'] = $idiomas;
			$data['data_vue'] = $data_vue;
			$this->_view->assign($data);
			$this->_view->render('detalles');
		}
	}
	public function index ($id = 'index') {
		if ($id == 'index' || !is_numeric($id)) {
			$lenguaje = $this->_view->getLenguaje('idiomas_lenguajes', false, true);
			$data['titulo'] = $lenguaje->var('idiomas_lenguajes_titulo');
			$this->_view->assign($data);
			$this->_view->render('index');
		} else {
			$this->show($id);
		}
	}
}

 ?>