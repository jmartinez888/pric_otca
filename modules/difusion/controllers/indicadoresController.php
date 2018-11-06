<?php

use App\ContenidoTraducido;
use App\Idioma;
use App\OIndicadores;
use Illuminate\Database\Capsule\Manager as DB;
class indicadoresController extends difusionController {
	public function json ($modo) {
		$res = ['success' => false, 'msg'  => ''];
		switch ($modo) {
			case 'index':
				$build = OIndicadores::orderParaGestor()->visibles();
				if ($this->has(['l', 's'])) {
					$query = $this->getSql('q');
					if ($query && $query != '') {
						$build->where('OInd_Titulo', 'like', '%'.$query.'%');
					}
					$build->offset($this->getInt('s'))->limit($this->getInt('l'));
				}
				$rows =  $build->get()->map(function ($item) {
					$temp = $item->formatToArray();
					$temp['image'] = BASE_URL.'files/difusion/indicador/'.$item->OInd_IdIndicadores.'/'.$item->OInd_IconoPath;
					return $temp;
				});
				$this->_view->responseJson($rows);
				break;
			default:
				$this->_view->responseJson($res);
				exit;
				break;
		}
	}
	public function update ($id, $modo = 'index') {
		$res = ['success' => false, 'msg' => ''];
		$lenguaje = $this->_view->loadLenguaje(['difusion_contenido_index', 'request']);
		if ($this->isAcceptJson()) {
			switch ($modo) {
				case 'index':
					// dd($_POST);
					if ($this->has(['idiomas', 'estado', 'id'])) {
						if (is_numeric($id) && $id == $this->getInt('id')) {
							$row = OIndicadores::find($id);
							if ($row) {
								$idiomas = Idioma::activos();
								$self = $this;
								$post = $_POST;
								$image = null;
								if (!empty($_FILES["imagen"]) && in_array($_FILES['imagen']['type'], $this->image_types))
									$image = $_FILES['imagen'];

								DB::transaction( function() use ($self, &$res, $post, $idiomas, $row, $lenguaje) {
									$opcionales = [];
									foreach ($idiomas as $value) {
                    $idioma_var = "idioma_".$value->Idi_IdIdioma;
                    if (array_key_exists($idioma_var, $post['idiomas'])) {
                        if ($post['idiomas'][$idioma_var]['default'] == 1) {
                            $row->OInd_Titulo = $post['idiomas'][$idioma_var]['titulo'];
                            $row->OInd_Descripcion = $post['idiomas'][$idioma_var]['descripcion'];
                            $row->save();

                        } else {
                            ContenidoTraducido::updateRow('ora_indicadores', $row->OInd_IdIndicadores, $value->Idi_IdIdioma, [
                                'OInd_Titulo' => $post['idiomas'][$idioma_var]['titulo'],
                                'OInd_Descripcion' => $post['idiomas'][$idioma_var]['descripcion'],
                            ], true);
                        }
                    }
                  }
                  $res['success'] = true;
                  $res['msg'] = $lenguaje['str_elemento_actualizado'];
								});

								if ($image != null && $res['success']) {
                	 	$path = $self->ruta_indicadores.$row->OInd_IdIndicadores.DS;
							      if (!file_exists($path))
				              mkdir($path);
				            $ext = explode('/', $image['type']);
				            $namefinal = md5($image['name'].$row->OInd_IdIndicadores).'.'.end($ext);
				            $destino_path = $path.$namefinal;
				            // $destino_path = $path.rawurlencode($image['name']);
				            if (move_uploaded_file($image['tmp_name'], $destino_path)) {
				            	// $name_thumb = md5($image['name']).'.jpg';
				            	// Helper::create_thumbnail_image($destino_path, $path.$name_thumb);
	      							$row->OInd_IconoPath = $namefinal;
					            $row->save();
				            }
                }
							}
						}
					} else {
						$res['msg'] = $lenguaje['str_parametro_falta'];
					}
					break;
				case 'ocultar':
					$this->setPostRequest();
					if ($this->has(['id'])) {
						if (is_numeric($id) && $id == $this->getInt('id')) {
							$row = OIndicadores::find($id);
							if ($row) {
								$row->OInd_Estado = 0;
								$row->save();
								$res['success'] = true;
								$res['msg'] = str_replace('%elemento%', $row->OInd_Titulo, $lenguaje['str_elemento_actualizado_titulo']).' - '.strtolower($lenguaje['str_oculto']);
							} else {
								$res['msg'] = $lenguaje['str_elemento_no_encontrado'];
							}
						}
					} else
						$res['msg'] = $lenguaje['str_parametro_falta'];
					break;
				case 'mostrar':
					$this->setPostRequest();
					if ($this->has(['id'])) {
						if (is_numeric($id) && $id == $this->getInt('id')) {
							$row = OIndicadores::find($id);
							if ($row) {
								$row->OInd_Estado = 1;
								$row->save();
								$res['success'] = true;
								$res['msg'] = str_replace('%elemento%', $row->OInd_Titulo, $lenguaje['str_elemento_actualizado_titulo']).' - '.strtolower($lenguaje['str_visible']);
							}
						}
					} else
						$res['msg'] = $lenguaje['str_parametro_falta'];
					break;
			}
		} else {
			$res['msg'] = 'method fail';
		}
		$this->_view->responseJson($res);

	}
	public function delete ($id) {
		$this->setDelete();
		$lenguaje = $this->_view->LoadLenguaje('difusion_contenido_index');
		$res = ['success' => false, 'msg' => ''];
		if (is_numeric($id)) {
			$row = OIndicadores::find($id);
			if ($row) {
				$name = $row->OInd_Titulo;
				$row->Row_Estado = 0;
				$row->save();
				$res['success'] = true;
				$res['msg'] = str_replace('%elemento%', $name, $lenguaje['str_elemento_eliminado_titulo']);
				// $row->delete();
				// if (!$row->exists) {
				// 	$res['success'] = true;
				// 	$res['msg'] = str_replace('%banner%', $name, $lenguaje['str_elemento_eliminado_titulo']);
				// }
			} else {
				$res['msg'] = str_replace('%banner%', $name, $lenguaje['str_elemento_no_encontrado']);
			}
			$this->_view->responseJson($res);
		}
	}
	public function store () {
		// dd($_POST);
		// dd($_FILES);
		// $this->setStore();
		// $post = file_get_contents('php://input');


    if (!empty($_FILES["imagen"])) {
    	$image = $_FILES['imagen'];
			$lenguaje = $this->_view->LoadLenguaje(['difusion_contenido_index', 'request']);
			$res = ['success' => false, 'msg' => ''];
	    $idiomas = Idioma::activos();
	    $self = $this;
	    if ($this->has(['idiomas', 'estado','id'])) {
	    	$post = $_POST;
				DB::transaction(function () use ($self, &$res, $post, $idiomas, $lenguaje, $image) {
			      $row = new OIndicadores();
			      $opcionales = [];



			      foreach ($idiomas as $value) {
			          $idioma_var = "idioma_".$value->Idi_IdIdioma;
			          if (array_key_exists($idioma_var, $post['idiomas'])) {
			              if ($value->Idi_IdIdioma == Cookie::lenguaje()) {
			                  //por defecto agregar en el idioma actual
			                  $row->OInd_Titulo = $post['idiomas'][$idioma_var]['titulo'];
			                  $row->OInd_Descripcion = $post['idiomas'][$idioma_var]['descripcion'];
			                  $row->OInd_Estado = $post['estado'];
			                  $row->OInd_Color = '#af3';
			                  $row->Idi_IdIdioma = Cookie::lenguaje();
			                  $row->save();
			              } else {
			                  $opcionales[] = [
			                      'idioma' => $value->Idi_IdIdioma,
			                      'titulo' => $post['idiomas'][$idioma_var]['titulo'],
			                      'descripcion' => $post['idiomas'][$idioma_var]['descripcion']
			                  ];
			              }
			          }
			      }

			      if ($row->OInd_IdIndicadores != 0) {
			          foreach ($opcionales as  $value) {
			          	ContenidoTraducido::setRow('ora_indicadores', $row->OInd_IdIndicadores, 'OInd_Titulo', $value['titulo'], $value['idioma']);
			          	ContenidoTraducido::setRow('ora_indicadores', $row->OInd_IdIndicadores, 'OInd_Descripcion', $value['descripcion'], $value['idioma']);

			          }
			          $res['success'] = true;
			          $res['msg'] = str_replace('%contenido%', $row->OInd_Titulo, $lenguaje['difusion_contenido_index_registro_success']);
			      }


			      $path = $self->ruta_indicadores.$row->OInd_IdIndicadores.DS;
			      if (!file_exists($path))
              mkdir($path);
            $ext = explode('/', $image['type']);
            $namefinal = md5($image['name'].$row->OInd_IdIndicadores).'.'.end($ext);
            $destino_path = $path.$namefinal;
            // $destino_path = $path.rawurlencode($image['name']);

            if (move_uploaded_file($image['tmp_name'], $destino_path)) {
	            $ext = explode('/', $image['type']);
	            $row->OInd_IconoPath = md5($image['name'].$row->OInd_IdIndicadores).'.'.end($ext);
	            $row->save();
            }


			  });
	    } else {
	    	$res['msg'] = $lenguaje['str_parametro_falta'];
	    }
    }


    $this->_view->responseJson($res);
	}
	public function edit($id) {
		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$d = $this->_view->getLenguaje('difusion_contenido_index');
		$data['idiomas'] = Idioma::activos();
		$data['edit'] = true;

		if (is_numeric($id)) {
			$row = OIndicadores::withoutGlobalScope('translate')->find($id);
			if ($row) {
				$data['row'] = true;
				$vars_idioma = [];
				$data['idiomas']->map(function($item) use(&$vars_idioma, $row){
					if ($row->Idi_IdIdioma == $item->Idi_IdIdioma) {
						$vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
		            'id' => $item->Idi_IdIdioma,
		            'titulo' => $row->OInd_Titulo,
		            'descripcion' => $row->OInd_Descripcion,
		            'default' => 1
		        ];
					} else {
						$traducido = ContenidoTraducido::getRow(
							'ora_indicadores',
							$row->OInd_IdIndicadores,
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
		        		'OInd_Titulo')->first()->Cot_Traduccion;

		        	$vars_idioma['idioma_'.$item->Idi_IdIdioma]['descripcion'] = $traducido->where(
		        		'Cot_Columna',
		        		'OInd_Descripcion')->first()->Cot_Traduccion;
		        }
					}


		    });
				$data['data_vue'] = [
		        'idiomas' => $vars_idioma,
		        'idioma_actual' => Cookie::lenguaje(),
		        'estado' => $row->OInd_Estado == 1 ? true : false,
		        'edit' => true,
		        'image' => BASE_URL.'files/difusion/indicador/'.$row->OInd_IdIndicadores.'/'.$row->OInd_IconoPath,
		        'imagen' => null,
		        'elemento_id' => $row->OInd_IdIndicadores
		    ];

			} else {

			}
		}

    $data['titulo'] = $d['str_indicadores'].' - '.$d['str_editar'];
		$this->_view->assign($data);
		$this->_view->render('create');
	}
	public function create () {
		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$d = $this->_view->getLenguaje('difusion_contenido_index');
		$data['idiomas'] = Idioma::activos();
		$data['edit'] = false;
		$data['titulo'] = $d['str_indicadores'].' - '.$d['str_crear'];
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
        'imagen' => null,
        'edit' => false,
        'image' => '',
        'image_banner' => '',
        'estado' => false,
        'elemento_id' => 0,
    ];
		$this->_view->assign($data);
		$this->_view->render('create');
	}

	public function index() {
		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$lenguaje = $this->_view->getLenguaje('difusion_contenido_index');
		$data['titulo'] = $lenguaje['str_indicadores'];
		$this->_view->assign($data);
		$this->_view->render('index');
	}
}
 ?>