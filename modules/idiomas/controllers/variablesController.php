<?php
use App\Idioma;
use App\IdiomaFiles;
use App\IdiomaFilesVars;
use App\IdiomaFilesVarsBody;
use Illuminate\Database\Capsule\Manager as DB;
class variablesController extends idiomasController {
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

	public function index ($id = 'index') {
		if ($id == 'index' || !is_numeric($id)) {

		}
	}
}

 ?>