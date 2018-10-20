<?php

use App\ForoTematica;
use App\Idioma;
use App\ODifusionTipo;
class datosController extends difusionController {

	public function create () {
		// $this->_view->setTemplate(LAYOUT_FRONTEND);
		// $data['idiomas'] = Idioma::activos();
		// $data['tipo_difusion'] = ODifusionTipo::activos()->visibles()->get();
		// $data['tematicas'] = ForoTematica::activos()->visibles()->get();
		// $this->_view->getLenguaje('difusion_contenido_index');

		// //generar variables para los inputs del form en el cliente
		// $vars_idioma = [];
  //   $data['idiomas']->map(function($item) use(&$vars_idioma){
  //       $vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
  //           'id' => $item->Idi_IdIdioma,
  //           'titulo' => '',
  //           'descripcion' => '',
  //           'palabras_clave' => '',
  //           'contenido' => ''
  //       ];
  //   });
  //   $data['data_vue'] = [
  //       'idiomas' => $vars_idioma,
  //       'idioma_actual' => Cookie::lenguaje(),
  //       'tipo' => count($data['tipo_difusion']) > 0 ? $data['tipo_difusion'][0]->ODit_IdTipoDifusion : 0,
  //       'linea_tematica' => count($data['tematicas']) > 0 ? $data['tematicas'][0]->Lit_IdLineaTematica : 0,
  //       'imagen' => null,
  //       'datos_interes' => 1
  //   ];

		// // $lenguaje = $this->_view->LoadLenguaje('foro_admin_tematica');
		// // $this->_view->getLenguaje('foro_admin_tematica');
		// $this->_view->assign($data);
		// $this->_view->render('../contenido/create');
		$this->prepareCreate('create_difusion', 1, 0);

	}
	public function index () {
		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$data['idiomas'] = Idioma::activos();
		$data['zone'] = 1;//datos
		$data['ruta'] = 'datos';//datos
		$data['tipo_difusion'] = ODifusionTipo::activos()->visibles()->get();
		$data['tematicas'] = ForoTematica::activos()->visibles()->get();
		$lenguaje = $this->_view->getLenguaje('difusion_contenido_index');
		$data['titulo'] = $lenguaje['difusion_datos_index_titulo'];
		$this->_view->assign($data);
		$this->_view->render('index_difusion');
	}
	// public function datatable () {
	// 	$query = ODifusion::select()->where('ODif_Datos', 1);
	// 	$records_total = $query->count();
	// 	$records_total_filter = $records_total;
	// 	if ($this->filledGet('buscar')) {
	// 		$query->where('ODif_Titulo', 'like', '%'.$_GET['buscar'].'%')
	// 			->orWhere('ODif_Descripcion', 'like', '%'.$_GET['buscar'].'%');
	// 		$records_total_filter = $query->count();
	// 	}

	// 	if ($this->filledGet('export')) {
	// 		$this->_export($query, $this->getTexto('export'));
	// 	} else {
	// 		$rows = $query->offset($_GET['start'])->limit($_GET['length'])->get();

	// 		$data = [
	// 			'draw' => +$_GET['draw'],
	// 			'recordsTotal' => $records_total,
 //        'recordsFiltered' => $records_total_filter,
 //        'data' => $rows
	// 		];

	// 		$this->_view->responseJson($data);

	// 	}
	// }
}
 ?>