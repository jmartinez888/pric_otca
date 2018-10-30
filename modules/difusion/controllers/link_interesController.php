<?php

use App\ContenidoTraducido;
use App\Idioma;
use App\ODifusionLinkInteres;
use Illuminate\Database\Capsule\Manager as DB;
class link_interesController extends difusionController {

	public function all () {
		if ($this->isAcceptJson()) {
			$rows = ODifusionLinkInteres::activos()->visibles()->select();
			if ($this->filledGet('buscar')) {
				$rows->where('ODli_Titulo', 'like', '%'.$this->getTexto('buscar').'%');
				$rows->orWhere('ODli_Descripcion', 'like', '%'.$this->getTexto('buscar').'%');
			}
			if ($this->has(['start', 'length'])) {
				$rows->offset($this->getInt('start'))->limit($this->getInt('length'));
			}
			$rows = $rows->get();
			$rows = $rows->map(function($item) {
				return $item->formatToArray();
			});
			$this->_view->responseJson($rows);
		} else {
			$this->_view->setTemplate(LAYOUT_FRONTEND);
			$d = $this->_view->getLenguaje('difusion_contenido_index');
			$data['idiomas'] = Idioma::activos();
			$data['idiomas']->map(function($item) use(&$vars_idioma){
	        $vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
	            'id' => $item->Idi_IdIdioma,
	            'titulo' => '',
	            'descripcion' => ''
	        ];
	    });
	    $data['data_vue'] = [
	        'idiomas' => $vars_idioma,
	        'idioma_actual' => Cookie::lenguaje()
	    ];
	    $data['titulo'] = $d['difusion_links_index_titulo'];
			$this->_view->assign($data);
			$this->_view->render('all');
		}
	}
	public function store () {

		$lenguaje = $this->_view->LoadLenguaje(['difusion_contenido_index', 'request']);
		$res = ['success' => false, 'msg' => ''];

		// if (!empty($_FILES["imagen"]) && in_array($_FILES['imagen']['type'], $this->image_types)) {
			// $image = $_FILES['imagen'];

	    $idiomas = Idioma::activos();
	    $self = $this;

	    if ($this->has(['idiomas', 'estado', 'url'])) {
	    	$post = $_POST;
				DB::transaction(function () use ($self, &$res, $post, $idiomas, $lenguaje) {
			      $new = new ODifusionLinkInteres();
			      $opcionales = [];
			      foreach ($idiomas as $value) {
			          $idioma_var = "idioma_".$value->Idi_IdIdioma;
			          if (array_key_exists($idioma_var, $post['idiomas'])) {
			              if ($value->Idi_IdIdioma == Cookie::lenguaje()) {
			                  //por defecto agregar en el idioma actual
			                  $new->ODli_Titulo = $post['idiomas'][$idioma_var]['titulo'];
			                  $new->ODli_Descripcion = $post['idiomas'][$idioma_var]['descripcion'];
			                  $new->ODli_Estado = $post['estado'];
			                  $new->ODli_Url = $post['url'];
			                  $new->Idi_IdIdioma = Cookie::lenguaje();
			                  $new->save();
			              } else {
			                  $opcionales[] = [
			                      'idioma' => $value->Idi_IdIdioma,
			                      'titulo' => $post['idiomas'][$idioma_var]['titulo'],
			                      'descripcion' => $post['idiomas'][$idioma_var]['descripcion']
			                  ];
			              }
			          }
			      }

			      if ($new->ODli_IdDifLini != 0) {
			          foreach ($opcionales as  $value) {
			          	ContenidoTraducido::setRow('ora_difusion_link_interes', $new->ODli_IdDifLini, 'ODli_Titulo', $value['titulo'], $value['idioma']);
			          	ContenidoTraducido::setRow('ora_difusion_link_interes', $new->ODli_IdDifLini, 'ODli_Descripcion', $value['descripcion'], $value['idioma']);
			          }

			          $res['success'] = true;
			          $res['msg'] = str_replace('%elemento%', $new->ODli_Titulo, $lenguaje['str_registro_success']);
			      }
			      // $path = $self->ruta_banners.$new->ODib_IdDifBanner.DS;
			      // if (!file_exists($path))
         //      mkdir($path);
         //    $ext = explode('/', $image['type']);
         //    // $ext = end($ext);
         //    $name = md5($image['name'].$new->ODib_IdDifBanner).'.'.end($ext);
         //    $destino_path = $path.$name;

         //    if (move_uploaded_file($image['tmp_name'], $destino_path)) {
         //    	// $name_thumb = md5($image['name']).'.jpg';
         //    	// Helper::create_thumbnail_image($destino_path, $path.$name_thumb);
	        //     $new->ODib_Banner = $name;
	        //     // $new->ODif_Image = $name_thumb;
	        //     $new->save();
         //    }


			  });
	    } else
	    	$res['msg'] = $lenguaje['str_parametro_falta'];
		// } else
		// 	$res['msg'] = $lenguaje['str_verificar_imagen_error'];
		$this->_view->responseJson($res);
	}
	public function create() {
		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$d = $this->_view->getLenguaje('difusion_contenido_index');
		$data['idiomas'] = Idioma::activos();
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
        'elemento_id' => 0
    ];
    $data['titulo'] = $d['difusion_links_index_titulo'].' - '.$d['str_crear'];
		$this->_view->assign($data);
		$this->_view->render('create');
	}
	public function datatable () {
		$query = ODifusionLinkInteres::visibles();

		$records_total = $query->count();
		$records_total_filter = $records_total;

		if ($this->filledGet('buscar')) {
			// $query->where('ODii_Descripcion', 'like', '%'.$this->getTexto('buscar').'%');
			$query->where(function($q) {
				$q->orWhere('ODli_Titulo', 'like', '%'.$this->getTexto('buscar').'%')
					->orWhere('ODli_Descripcion', 'like', '%'.$this->getTexto('buscar').'%');
			});
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
	public function delete ($id) {
		// dd($_POST);
		$res = ['success' => false, 'msg' => ''];
		$lenguaje = $this->_view->loadLenguaje(['difusion_contenido_index', 'request']);
		if ($this->isAcceptJson()) {
			if ($this->has(['id'])) {
				if ($row_id = $this->getInt('id')) {
					$row = ODifusionLinkInteres::find($row_id);
					if ($row) {
						$row->Row_Estado = 0;
						$row->save();
						$res['success'] = true;
						$res['msg'] = $lenguaje['str_elemento_eliminado'];
					}
				}
			} else {
				$res['msg'] = $lenguaje['str_parametro_falta'];
			}
		} else {
			$res['msg'] = 'method fail';
		}
		$this->_view->responseJson($res);

	}
	public function show ($id) {
		$g = 1;
		// dd(is_numeric($g));
		// $_POST['cc'] = '1';
		if ($xx = $this->getInt('cc')) {
			dd($xx);
		} else {
			echo 'asdxx';
		}
	}
	public function edit ($id) {
		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$d = $this->_view->getLenguaje('difusion_contenido_index');
		$data['idiomas'] = Idioma::activos();
		$data['edit'] = true;
		if (is_numeric($id)) {
			$row = ODifusionLinkInteres::find($id);
			// dd($row);
			if ($row) {
				$data['row'] = true;
				$vars_idioma = [];
				$data['idiomas']->map(function($item) use(&$vars_idioma, $row){
					if ($row->Idi_IdIdioma == $item->Idi_IdIdioma) {
						$vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
		            'id' => $item->Idi_IdIdioma,
		            'titulo' => $row->ODli_Titulo,
		            'descripcion' => $row->ODli_Descripcion,
		            'default' => 1
		        ];
					} else {
						$traducido = ContenidoTraducido::getRow(
							'ora_difusion_link_interes',
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
				$data['data_vue'] = [
		        'idiomas' => $vars_idioma,
		        'idioma_actual' => Cookie::lenguaje(),
		        'url' => $row->ODli_Url,
		        'estado' => $row->ODli_Estado == 1 ? true : false,
		        'edit' => true,
		        'elemento_id' => $row->ODli_IdDifLini
		    ];

			} else {

			}
		}

    $data['titulo'] = $d['difusion_links_index_titulo'].' - '.$d['str_editar'];
		$this->_view->assign($data);
		$this->_view->render('create');
	}
	private function _export ($query, $method){

	}

	public function update ($id, $modo = 'index') {
		$res = ['success' => false, 'msg' => ''];
		$lenguaje = $this->_view->loadLenguaje(['difusion_contenido_index', 'request']);
		if ($this->isAcceptJson()) {
			switch ($modo) {
				case 'index':
					// dd($_POST);
					if ($this->has(['idiomas', 'estado', 'url', 'id'])) {
						if (is_numeric($id)) {
							$row = ODifusionLinkInteres::find($id);
							if ($row) {
								$idiomas = Idioma::activos();

								$self = $this;
								$post = $_POST;
								DB::transaction( function() use ($self, &$res, $post, $idiomas, $row, $lenguaje) {
									$opcionales = [];
									foreach ($idiomas as $value) {
                    $idioma_var = "idioma_".$value->Idi_IdIdioma;
                    if (array_key_exists($idioma_var, $post['idiomas'])) {
                        if ($post['idiomas'][$idioma_var]['default'] == 1) {
                        	// dd($post['idiomas'][$idioma_var]);
                            //update en 'temtatica'
                            $row->ODli_Titulo = $post['idiomas'][$idioma_var]['titulo'];
                            $row->ODli_Descripcion = $post['idiomas'][$idioma_var]['descripcion'];
                            $row->ODli_Estado = $post['estado'];
                            $row->ODli_Url = $post['url'];
                            $row->save();

                        } else {
                            ContenidoTraducido::updateRow('ora_difusion_link_interes', $row->ODli_IdDifLini, $value->Idi_IdIdioma, [
                                'ODli_Titulo' => $post['idiomas'][$idioma_var]['titulo'],
                                'ODli_Descripcion' => $post['idiomas'][$idioma_var]['descripcion'],
                            ], true);


                        }
                    }
                  }

                  $res['success'] = true;
                  $res['msg'] = $lenguaje['str_elemento_actualizado'];

								});
							}
						}
					} else {
						$res['msg'] = $lenguaje['str_parametro_falta'];
					}
					break;
				case 'estado':
					if ($this->has(['id', 'estado'])) {
						if ($row_id = $this->getInt('id')) {
							$row = ODifusionLinkInteres::find($row_id);
							if ($row) {
								$row->ODli_Estado = $this->getInt('estado');
								$row->save();
								$res['success'] = true;
								$res['msg'] = $row->ODli_Estado == 1 ? $lenguaje['str_elemento_is_activo'] :  $lenguaje['str_elemento_is_inactivo'];
							}
						}
					}
					break;
			}
		} else {
			$res['msg'] = 'method fail';
		}
		$this->_view->responseJson($res);
	}
	public function index ($id = 'index') {
		if ($id == 'index') {
			$this->_view->setTemplate(LAYOUT_FRONTEND);
	    $data['idiomas'] = Idioma::activos();
	    $data['ruta'] = 'link_interes';//evento
	    $lenguaje = $this->_view->getLenguaje('difusion_contenido_index');
	    $data['titulo'] = $lenguaje['difusion_links_index_titulo'];
	    $this->_view->assign($data);
	    $this->_view->render('index');
		} else {
			$this->show($id);
		}
	}
}

?>