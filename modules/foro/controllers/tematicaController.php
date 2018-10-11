<?php

use App\Foro;
use App\ForoTematica;
use Illuminate\Database\Capsule\Manager as DB;
class tematicaController extends foroController {

	public function detalles ($tematica_id = 0) {
		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$tematica = ForoTematica::find($tematica_id);
		if ($tematica) {
			if ($this->filledGet('evento')) {
				$res = ['success' => false, 'data' => [], 'total' => 0];
				switch ($this->getTexto('evento')) {
					case 'recientes':
						// DB::enableQueryLog();
					 	$build = $tematica->foros()->orderBy('For_FechaCreacion', 'DESC');
					 // dd($_GET);

						if ($this->has(['buscar', 'funcion'])) {
							if ($this->getTexto('funcion') != 'todo') {
								$build->where('For_Funcion', $this->getTexto('funcion'));
							}
							$buscar = trim($this->getTexto('buscar'));
							if ($buscar != '')
								$build->where(function($query) use($buscar) {
									$query->orWhere('For_Titulo', 'like', "%$buscar%");
									$query->orWhere('For_Resumen', 'like', "%$buscar%");
									$query->orWhere('For_Descripcion', 'like', "%$buscar%");
								});
						}

						if ($this->filledAllGet(['start', 'length'])) {
							$build->offset($_GET['start'])->limit($_GET['length']);
						}
						$res['data'] = $build->get()->map(function($item) {
							$item->For_Resumen = str_limit(strip_tags(html_entity_decode($item->For_Resumen)), 200);
							$item->ref_url = BASE_URL.Cookie::lenguaje().'/foro/index/ficha/'.$item->For_IdForo;
							$item->total_comentarios = $item->comentarios()->count();
							$item->total_miembros = $item->miembros()->count();
							$item->autor;
							return $item;
						});
						// $res['query'] = DB::getQueryLog();
						break;
					case 'agenda':
						$build = $tematica->foros()->orderBy('For_FechaCreacion', 'ASC');
						$res['data'] = $build->get()->map(function($item) {
							// $item->For_Resumen = str_limit(strip_tags(html_entity_decode($item->For_Resumen)), 200);
							$item->ref_url = BASE_URL.Cookie::lenguaje().'/foro/index/ficha/'.$item->For_IdForo;
							// $item->total_comentarios = $item->comentarios()->count();
							// $item->total_miembros = $item->miembros()->count();
							// $item->autor;
							return $item;
						});
						break;
				}
				$this->_view->responseJson($res);
			} else {

				$this->_view->setJs([
					[BASE_URL . 'public/js/moment/moment.js'],
					[BASE_URL . 'public/js/axios/dist/axios.min.js'],
					[BASE_URL . 'public/js/vuejs/vue.min.js'],
					'tematica_detalles'
				]);
				$data['tematica'] = $tematica;
				$data['funciones'] = Foro::funciones();
				$this->_view->assign($data);
				$this->_view->render('detalles');
			}
		} else {
			echo 'asd';
			//contenido no encontrado
		}

	}
	public function index () {
		throw new Exception("Contenido no encontrado");
		exit;
	}
}

?>