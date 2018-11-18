<?php
use App\Idioma;
use App\IdiomaFiles;
use App\IdiomaFilesVars;
use App\IdiomaFilesVarsBody;
use Illuminate\Database\Capsule\Manager as DB;
class variablesController extends idiomasController {
	public function generate_file ($file_id) {
		$res = ['success' => false, 'msg' => ''];
		if ($this->isAcceptJson()) {
			$row = IdiomaFiles::find($file_id);
			if ($row) {
				$res = $row->generate_file($file_id);
			}

		}
		$this->_view->responseJson($res);

	}
	public function update ($id) {
		$res = ['success' => false, 'msg' => ''];
		$lenguaje = $this->_view->loadLenguaje(['request']);
		if ($this->isAcceptJson()) {
			if ($this->has(['idiomas', 'nombre', 'variable_id'])) {
				DB::transaction(function () use(&$res, $lenguaje) {
					$prename = $this->getTexto('nombre');
					try{
						$row = IdiomaFilesVars::find($this->getInt('variable_id'));
				    if ($row) {
				    	$row->Ifv_VarName = $prename;
				    	$body = $row->body;
				    	foreach ($_POST['idiomas'] as $key => $value) {
				    		$idi = explode('_', $value['idioma']);
				    		$var_body = $body->where('Idi_IdIdioma', end($idi))->first();
				    		if ($var_body == null) {
				    			$new_body = new IdiomaFilesVarsBody();
				    			$new_body->Ifv_IdFileVar = $this->getInt('variable_id');
				    			$new_body->Idi_IdIdioma = end($idi);
				    			$new_body->Ifvb_Body = $value['body'];
				    			$new_body->save();
				    		} else {
					    		$var_body->Ifvb_Body = $value['body'];
					    		$var_body->save();
				    		}
				    	}
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
	public function store () {
		// dd($_POST);

		$res = ['success' => false, 'msg' => ''];
		$lenguaje = $this->_view->loadLenguaje(['request']);
		if ($this->has(['nombre', 'file_id', 'idiomas'])) {
			DB::transaction(function () use($lenguaje, &$res) {
				try {
					$prename = $this->getTexto('nombre');

					$new = new IdiomaFilesVars();
			    $new->Ifv_VarName = $prename;
			    $new->Idif_IdIdiomaFile = $this->getInt('file_id');
			    if ($new->save()) {
			    	foreach ($_POST['idiomas'] as $key => $value) {
			    		$new_var = new IdiomaFilesVarsBody();
			    		$new_var->Ifv_IdFileVar = $new->Ifv_IdFileVar;
			    		$idi = explode('_', $value['idioma']);
			    		$new_var->Idi_IdIdioma = end($idi);
			    		$new_var->Ifvb_Body = $value['body'];
			    		$new_var->save();
			    	}
			    }
			    $res['success'] = true;
			    $res['msg'] = $lenguaje['str_elemento_no_registrado'];
			    IdiomaFilesVarsBody::generate_files();
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
		$row = IdiomaFilesVars::find($id);
		if ($this->isAcceptJson()) {
			//show json
			$res = ['success' => $row != null, 'data' => null];
			$data = $row->formatToArray();
			$data['body'] = $row->body->map(function($item) {
				return $item->formatToArray();
			});
			$res['data'] = $data;
			$this->_view->responseJson($res);
		} else {
			//show html
			$this->redireccionar();
		}
	}
	public function index ($id = 'index') {
		if ($id == 'index' || !is_numeric($id)) {
			echo 'show html';
			exit;
		} else {
			$this->show($id);
		}
	}
}

 ?>