<?php

use App\ContenidoTraducido;
use App\Idioma;
use App\ODifusionIndicadores;
use App\OIndicadores;
use Illuminate\Database\Capsule\Manager as DB;
class cifrasController extends difusionController {
	public function show($id) {
		echo 'show';
	}
	public function delete ($id) {
		$res = ['success' => false, 'msg' => 'method fail'];
		$this->setPostRequest();
		if ($this->isAcceptJson()) {
			$lenguaje = $this->_view->loadLenguaje(['difusion_contenido_index', 'request']);
			if ($this->has(['id'])) {
				if (is_numeric($id) && $id == $this->getInt('id')) {
					$row = ODifusionIndicadores::find($id);
					if ($row) {
						$row->Row_Estado = 0;
						$row->save();
						$res['success'] = true;
						$res['msg'] = $lenguaje['str_elemento_eliminado'];
					}
				}
			}
		}
		$this->_view->responseJson($res);
	}
	public function update ($id, $modo = 'index') {
		$res = ['success' => false, 'msg' => ''];
		$lenguaje = $this->_view->loadLenguaje(['difusion_contenido_index', 'request']);
		if ($this->isAcceptJson()) {
			switch ($modo) {
				case 'index':
					if ($this->has(['idiomas', 'id', 'estado', 'url', 'difusion', 'indicador', 'latitude', 'longitude'])) {
						if (is_numeric($id) && $id == $this->getInt('id')) {
							$row = ODifusionIndicadores::find($id);
							if ($row) {
								$idiomas = Idioma::activos();
								$self = $this;
								$post = $_POST;

								DB::transaction( function() use ($self, &$res, $post, $idiomas, $lenguaje, $row) {
									$opcionales = [];
									foreach ($idiomas as $value) {
	                  $idioma_var = "idioma_".$value->Idi_IdIdioma;
	                  if (array_key_exists($idioma_var, $post['idiomas'])) {
                      if ($post['idiomas'][$idioma_var]['default'] == 1) {
                          $row->ODif_IdDifusion = +$post['difusion'];
				                  $row->OInd_IdIndicadores = +$post['indicador'];
				                  $row->ODii_Descripcion = $post['idiomas'][$idioma_var]['descripcion'];
				                  $row->ODii_RefUrl = $post['url'];
				                  $row->ODii_Estado = +$post['estado'];
				                  $row->Idi_IdIdioma = Cookie::lenguaje();
				                  $row->ODii_PosLatitude = +$post['latitude'];
				                  $row->ODii_PosLongitude = +$post['longitude'];
                          $row->save();

                      } else {
                          ContenidoTraducido::updateRow('ora_difusion_indicadores', $row->ODii_IdDifIndi, $value->Idi_IdIdioma, [
                              'ODii_Descripcion' => $post['idiomas'][$idioma_var]['descripcion'],
                          ], true);
                      }
	                  }
	                }

	                $res['success'] = true;
	                $res['msg'] = $lenguaje['str_elemento_actualizado'];
								});
							}
						}
					} else
						$res['msg'] = $lenguaje['str_elemento_actualizado'];
					break;
				case 'estado':
					$this->setPostRequest();
					if ($this->has(['id'])) {
						if (is_numeric($id) && $id == $this->getInt('id')) {
							$row = ODifusionIndicadores::find($id);
							if ($row) {
								if ($row->ODii_Estado == 1)
									$row->ODii_Estado = 0;
								else if ($row->ODii_Estado == 0)
									$row->ODii_Estado = 1;
								$row->save();
								$res['success'] = true;
								$res['msg'] = $row->ODii_Estado == 1 ? $lenguaje['str_elemento_is_activo'] :  $lenguaje['str_elemento_is_inactivo'];
							}
						}
					} else
						$res['msg'] = $lenguaje['str_parametro_falta'];
					break;
			}
		}
		$this->_view->responseJson($res);
	}
	public function edit ($id) {

		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$lenguaje = $this->_view->getLenguaje('difusion_contenido_index');
		$data['idiomas'] = Idioma::activos();
		$data['indicadores'] = OIndicadores::activos()->visibles()->get();
		$data['edit'] = true;
		if (is_numeric($id)) {
			$row = ODifusionIndicadores::find($id);
			if ($row) {
				$data['row'] = true;
				$vars_idioma = [];

				$data['idiomas']->map(function($item) use(&$vars_idioma, $row){
					if ($row->Idi_IdIdioma == $item->Idi_IdIdioma) {
		        $vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
		            'id' => $item->Idi_IdIdioma,
		            'titulo' => '',
		            'descripcion' => $row->ODii_Descripcion,
		            'default' => 1
		        ];
					} else {
						$traducido = ContenidoTraducido::getRow(
							'ora_difusion_indicadores',
							$row->ODii_IdDifIndi,
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
		        		'ODii_Descripcion')->first()->Cot_Traduccion;
		        }
					}
		    });

	    	$data['data_vue'] = [
	        'idiomas' => $vars_idioma,
	        'idioma_actual' => Cookie::lenguaje(),
	        'estado' => $row->ODii_Estado,
	        'edit' => true,
	        'url' => $row->ODii_RefUrl,
	        'elemento_id' => $row->ODii_IdDifIndi,
	        'difusion_id' => $row->ODif_IdDifusion,
	        'nombre_difusion' => $row->difusion->ODif_Titulo,
	        'descripcion_difusion' => str_limit($row->difusion->ODif_Descripcion, 200),
	        'indicador' => $row->OInd_IdIndicadores,
	        'tematica_name' => '',
	        'latitude' => $row->ODii_PosLatitude,
	        'longitude' => $row->ODii_PosLongitude
		    ];

			}
		}

    // $data['data_vue'] = [
    //     'idiomas' => $vars_idioma,
    //     'idioma_actual' => Cookie::lenguaje(),
    //     'estado' => true,
    //     'edit' => false,
    //     'url' => '',
    //     'elemento_id' => 0,
    //     'indicador' => 0,
    //     'tematica_name' => ''
    // ];
    $data['titulo'] = $lenguaje['difusion_cifras_index_titulo'].' - '.$lenguaje['str_editar'];
		$this->_view->assign($data);
		$this->_view->render('create');
	}
	public function store () {
		// dd($_POST);

		$lenguaje = $this->_view->LoadLenguaje(['difusion_contenido_index', 'request']);
		$res = ['success' => false, 'msg' => ''];
    $idiomas = Idioma::activos();
    $self = $this;
    if ($this->has(['idiomas', 'estado', 'url', 'difusion', 'indicador', 'latitude', 'longitude'])) {
    	$post = $_POST;

    	if ($post['indicador'] != 0 && $post['difusion'] != 0 && trim($post['url']) != '') {

				DB::transaction(function () use ($self, &$res, $post, $idiomas, $lenguaje) {

			      $new = new ODifusionIndicadores();
			      $opcionales = [];
			      foreach ($idiomas as $value) {
			          $idioma_var = "idioma_".$value->Idi_IdIdioma;
			          if (array_key_exists($idioma_var, $post['idiomas'])) {
			              if ($value->Idi_IdIdioma == Cookie::lenguaje()) {
			                  //por defecto agregar en el idioma actual
			                  // $new->ODii_Titulo = $post['idiomas'][$idioma_var]['titulo'];
			                  $new->ODif_IdDifusion = +$post['difusion'];
			                  $new->OInd_IdIndicadores = $post['indicador'];
			                  $new->ODii_Descripcion = $post['idiomas'][$idioma_var]['descripcion'];
			                  $new->ODii_RefUrl = $post['url'];
			                  $new->ODii_Estado = +$post['estado'];
			                  $new->Idi_IdIdioma = Cookie::lenguaje();
			                  $new->ODii_PosLatitude = +$post['latitude'];
			                  $new->ODii_PosLongitude = +$post['longitude'];
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
        'descripcion_difusion' => '',
        'indicador' => count($data['indicadores']) > 0 ? $data['indicadores'][0]->OInd_IdIndicadores : 0,
        'tematica_name' => '',
        'latitude' => 0,
        'longitude' => 0
    ];
    $data['titulo'] = $d['difusion_cifras_index_titulo'].' - '.$d['str_crear'];
		$this->_view->assign($data);
		$this->_view->render('create');
	}
	public function datatable () {
		$query = ODifusionIndicadores::select()->visibles();

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
				$temp = $item->formatToArray([], [], ['indicador']);
				// dd($temp);
				return $temp;
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