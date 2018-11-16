<?php

use App\Idioma;
use App\IdiomaFiles;
use App\IdiomaFilesVars;
use App\IdiomaFilesVarsBody;
use Illuminate\Database\Capsule\Manager as DB;
class lenguajesController extends idiomasController {

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
	public function generate_files () {

	}
	public function generate_local_files () {

		// foreach ($idiomas as $key_idioma => $idioma) {
		// 	$temp = ['idioma' => $idioma->Idi_IdIdioma, 'files' => []];
		// 	$vars = IdiomaFilesVarsBody::getParentsValue()->getByIdioma($idioma->Idi_IdIdioma)->get();
		// 	// dd($vars);
		// 	foreach ($vars as $key_var => $var) {
		// 		// $var->var->file;
		// 		if (count($temp['files']) == 0) {
		// 			$temp['files'][] = ['file' => $var->Idif_FileName, 'vars' => []];

		// 		}

		// 		$new_row_file = true;

		// 		foreach ($temp['files'] as $key_files => $file) {
		// 			if ($file['file'] == $var->Idif_FileName) {
		// 				$new_row_file = false;
		// 				break;
		// 			}
		// 		}

		// 		if ($new_row_file) {
		// 			$temp['files'][] = ['file' => $var->Idif_FileName, 'vars' => []];
		// 		}





		// 	}

		// 	$res[] = $temp;
		// }

		// dd($res);
		// $lenguajes = Idioma::getAllLenguajes();
		// $res = [];
		// $files_final = [];
		// foreach ($files as $key_file => $file) {
		// 	foreach ($file->vars as $key_var => $var) {

		// 	}
		// }

		// $lenguajes->map(function($files) use ($idiomas, &$files_final){
		// 	$pre = ['idioma' => '', 'files' => []];
		// 	$files->vars->map(function($itemd) use ($idiomas, $files, &$files_final){

		// 		foreach ($itemd->body as $key => $value) {
		// 			foreach ($idiomas as $idi) {
		// 				if ($idi->Idi_IdIdioma == $idi->Idi_IdIdioma) {

		// 				}
		// 			}
		// 		}
		// 	});
		// });

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
	public function index ($id = 'index') {
		if ($id == 'index' || !is_numeric($id)) {
			$data['titulo'] = 'asd';
			$this->_view->assign($data);
			$this->_view->render('index');
		} else {

			$this->show($id);
		}
	}
}

 ?>