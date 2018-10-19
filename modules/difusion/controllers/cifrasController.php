<?php

use App\ODifusionIndicadores;
class cifrasController extends difusionController {
	public function show($id) {

	}
	public function create () {

	}
	public function datatable () {
		$query = ODifusionIndicadores::select();

		$records_total = $query->count();
		$records_total_filter = $records_total;

		if ($buscar = $this->filledGet('buscar')) {
			$query->where('ODii_Descripcion', 'like', '%'.$this->getTexto('buscar').'%');
			// $query->where(function($q) {
			// 	$q->orWhere('ODif_Titulo', 'like', '%'.$_GET['buscar'].'%')
			// 		->orWhere('ODif_Descripcion', 'like', '%'.$_GET['buscar'].'%');
			// });
			$records_total_filter = $query->count();
		}

		if ($this->filledGet('export')) {
			$this->_export($query, $this->getTexto('export'));
		} else {
			$rows = $query->offset($_GET['start'])->limit($_GET['length'])->get();
			$rows = $rows->map(function($item) {
				return $item->formatToArray();
			});
			$data = [
				'draw' => +$_GET['draw'],
				'recordsTotal' => $records_total,
        'recordsFiltered' => $records_total_filter,
        'data' => $rows
			];

			$this->_view->responseJson($data);

		}
	}
	public function index ($id = 'index') {
		if ($id == 'index') {
			$this->_view->setTemplate(LAYOUT_FRONTEND);
			$lenguaje = $this->_view->getLenguaje('difusion_contenido_index');
			$data['titulo'] = $lenguaje['difusion_cifras_index_titulo'];
			$data['ruta'] = 'cifras';
			$this->_view->assign($data);
			$this->_view->render('index');
		} else {
			$this->show($id);
		}
	}
}
 ?>