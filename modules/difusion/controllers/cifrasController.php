<?php

use App\ContenidoTraducido;
use App\Idioma;
use App\ODifusionIndicadores;
use App\OIndicadores;
use Illuminate\Database\Capsule\Manager as DB;
class cifrasController extends difusionController {
	public function show($id) {

	}
	public function edit ($id) {

		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$lenguaje = $this->_view->getLenguaje('difusion_contenido_index');
		$data['idiomas'] = Idioma::activos();
		$data['edit'] = true;
		if (is_numeric($id)) {
			$row = ODifusionIndicadores::find($id);
			if ($row) {
				$data['row'] = true;
				$vars_idioma = [];
				$data['idiomas']->map(function($item) use(&$vars_idioma){
					if ($row->Idi_IdIdioma == $item->Idi_IdIdioma) {
		        $vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
		            'id' => $item->Idi_IdIdioma,
		            'titulo' => '',
		            'descripcion' => ''
		        ];
					} else {
						$traducido = ContenidoTraducido::getRow(
							'ora_difusion_indicadores',
							$row->ODli_IdDifLini,
							$item->Idi_IdIdioma
						);

		        $vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
		            'id' => $item->Idi_IdIdioma,
		            'titulo' => '',
		            'descripcion' => '',
		            'default' => 0
		        ];

		        if ($traducido->count() > 0) {
		        	$vars_idioma['idioma_'.$item->Idi_IdIdioma]['titulo'] = $traducido->where(
		        		'Cot_Columna',
		        		'ODli_Titulo')->first()->Cot_Traduccion;

		        	$vars_idioma['idioma_'.$item->Idi_IdIdioma]['descripcion'] = $traducido->where(
		        		'Cot_Columna',
		        		'ODli_Descripcion')->first()->Cot_Traduccion;
		        }

					}
		    });

			}
		}

    $data['data_vue'] = [
        'idiomas' => $vars_idioma,
        'idioma_actual' => Cookie::lenguaje(),
        'estado' => true,
        'edit' => false,
        'url' => '',
        'elemento_id' => 0,
        'indicador' => 0,
        'tematica_name' => ''
    ];
    $data['titulo'] = $d['difusion_cifras_index_titulo'].' - '.$d['str_crear'];
		$this->_view->assign($data);
		$this->_view->render('create');
	}
	public function store () {

		$lenguaje = $this->_view->LoadLenguaje(['difusion_contenido_index', 'request']);
		$res = ['success' => false, 'msg' => ''];
    $idiomas = Idioma::activos();
    $self = $this;
    if ($this->has(['idiomas', 'estado', 'url', 'difusion', 'indicador', 'latitude', 'longitude'])) {
    	$post = $_POST;
			DB::transaction(function () use ($self, &$res, $post, $idiomas, $lenguaje) {
		      $new = new ODifusionIndicadores();
		      $opcionales = [];
		      foreach ($idiomas as $value) {
		          $idioma_var = "idioma_".$value->Idi_IdIdioma;
		          if (array_key_exists($idioma_var, $post['idiomas'])) {
		              if ($value->Idi_IdIdioma == Cookie::lenguaje()) {
		                  //por defecto agregar en el idioma actual
		                  // $new->ODii_Titulo = $post['idiomas'][$idioma_var]['titulo'];
		                  $new->ODif_IdDifusion = $post['difusion'];
		                  $new->OInd_IdIndicadores = $post['indicador'];
		                  $new->ODii_Descripcion = $post['idiomas'][$idioma_var]['descripcion'];
		                  $new->ODii_RefUrl = $post['url'];
		                  $new->ODii_Estado = $post['estado'];
		                  $new->Idi_IdIdioma = Cookie::lenguaje();
		                  $new->ODii_PosLatitude = $post['latitude'];
		                  $new->ODii_PosLongitude = $post['longitude'];
		                  $new->save();
		              } else {
		                  $opcionales[] = [
		                      'idioma' => $value->Idi_IdIdioma,
		                      'descripcion' => $post['idiomas'][$idioma_var]['descripcion']
		                  ];
		              }
		          }
		      }

		      if ($new->ODii_IdDifIndi != 0) {
		          foreach ($opcionales as  $value) {
		          	ContenidoTraducido::setRow('ora_difusion_indicadores', $new->ODii_IdDifIndi, 'ODii_Descripcion', $value['descripcion'], $value['idioma']);
		          }

		          $res['success'] = true;
		          $res['msg'] = $lenguaje['str_registro_b_success'];
		      }



			});
    } else
    	$res['msg'] = $lenguaje['str_parametro_falta'];
		// } else
		// 	$res['msg'] = $lenguaje['str_verificar_imagen_error'];
		$this->_view->responseJson($res);
	}
	public function create () {

		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$d = $this->_view->getLenguaje('difusion_contenido_index');
		$data['idiomas'] = Idioma::activos();
		$data['indicadores'] = OIndicadores::activos()->visibles()->get();
		$data['edit'] = false;
		$data['idiomas']->map(function($item) use(&$vars_idioma){
        $vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
            'id' => $item->Idi_IdIdioma,
            'titulo' => '',
            'descripcion' => ''
        ];
    });
    $data['data_vue'] = [
        'idiomas' => $vars_idioma,
        'idioma_actual' => Cookie::lenguaje(),
        'estado' => true,
        'edit' => false,
        'url' => '',
        'elemento_id' => 0,
        'difusion_id' => 0,
        'nombre_difusion' => '',
        'indicador' => count($data['indicadores']) > 0 ? $data['indicadores'][0]->OInd_IdIndicadores : 0,
        'tematica_name' => '',
        'latitude' => 0,
        'longitude' => 0,
    ];
    $data['titulo'] = $d['difusion_cifras_index_titulo'].' - '.$d['str_crear'];
		$this->_view->assign($data);
		$this->_view->render('create');
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
				return $item->formatToArray([], [], ['indicador']);
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