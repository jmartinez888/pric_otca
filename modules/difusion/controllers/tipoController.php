<?php

use App\ContenidoTraducido;
use App\Idioma;
use App\ODifusionTipo;
use Illuminate\Database\Capsule\Manager as DB;
class tipoController extends difusionController {

	public function datatable () {
		$query = ODifusionTipo::select();

		$query->visibles();

		$records_total = $query->count();
		$records_total_filter = $records_total;

		if ($this->filledGet('buscar')) {
			// $query->where('ODii_Descripcion', 'like', '%'.$this->getTexto('buscar').'%');
			$query->where(function($q) {
				$q->orWhere('ODit_Tipo', 'like', '%'.$this->getTexto('buscar').'%')
					->orWhere('ODit_Descripcion', 'like', '%'.$this->getTexto('buscar').'%');
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
	public function store () {
		$lenguaje = $this->_view->LoadLenguaje(['difusion_contenido_index', 'request']);
		$res = ['success' => false, 'msg' => ''];

	  $idiomas = Idioma::activos();
    $self = $this;
    if ($this->has(['idiomas', 'estado'])) {
    	$post = $_POST;
			DB::transaction(function () use ($self, &$res, $post, $idiomas, $lenguaje) {
		      $new = new ODifusionTipo();
		      $opcionales = [];
		      foreach ($idiomas as $value) {
		          $idioma_var = "idioma_".$value->Idi_IdIdioma;
		          if (array_key_exists($idioma_var, $post['idiomas'])) {
		              if ($value->Idi_IdIdioma == Cookie::lenguaje()) {
		                  //por defecto agregar en el idioma actual
		                  $new->ODit_Tipo = $post['idiomas'][$idioma_var]['titulo'];
		                  $new->ODit_Descripcion = $post['idiomas'][$idioma_var]['descripcion'];
		                  $new->ODit_Estado = $post['estado'];
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

		      if ($new->ODit_IdTipoDifusion != 0) {
		          foreach ($opcionales as  $value) {
		          	ContenidoTraducido::setRow('ora_difusion_tipo', $new->ODit_IdTipoDifusion, 'ODit_Tipo', $value['titulo'], $value['idioma']);
		          	ContenidoTraducido::setRow('ora_difusion_tipo', $new->ODit_IdTipoDifusion, 'ODit_Descripcion', $value['descripcion'], $value['idioma']);
		          }

		          $res['success'] = true;
		          $res['msg'] = str_replace('%elemento%', $new->ODit_Tipo, $lenguaje['str_registro_success']);
		      }
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
        'elemento_id' => 0
    ];
    $data['titulo'] = $d['difusion_tipo_index_titulo'].' - '.$d['str_crear'];
		$this->_view->assign($data);
		$this->_view->render('create');
	}

	public function edit ($id) {
		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$d = $this->_view->getLenguaje('difusion_contenido_index');
		$data['idiomas'] = Idioma::activos();
		$data['edit'] = true;
		if (is_numeric($id)) {
			$row = ODifusionTipo::find($id);
			// dd($row);
			if ($row) {
				$data['row'] = true;
				$vars_idioma = [];
				$data['idiomas']->map(function($item) use(&$vars_idioma, $row){
					if ($row->Idi_IdIdioma == $item->Idi_IdIdioma) {
						$vars_idioma['idioma_'.$item->Idi_IdIdioma] = [
		            'id' => $item->Idi_IdIdioma,
		            'titulo' => $row->ODit_Tipo,
		            'descripcion' => $row->ODit_Descripcion,
		            'default' => 1
		        ];
					} else {
						$traducido = ContenidoTraducido::getRow(
							'ora_difusion_tipo',
							$row->ODit_IdTipoDifusion,
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
		        		'ODit_Tipo')->first()->Cot_Traduccion;

		        	$vars_idioma['idioma_'.$item->Idi_IdIdioma]['descripcion'] = $traducido->where(
		        		'Cot_Columna',
		        		'ODit_Descripcion')->first()->Cot_Traduccion;
		        }
					}


		    });
				$data['data_vue'] = [
		        'idiomas' => $vars_idioma,
		        'idioma_actual' => Cookie::lenguaje(),
		        'estado' => $row->ODit_Estado == 1 ? true : false,
		        'edit' => true,
		        'elemento_id' => $row->ODit_IdTipoDifusion
		    ];

			} else {

			}
		}

    $data['titulo'] = $d['difusion_links_index_titulo'].' - '.$d['str_editar'];
		$this->_view->assign($data);
		$this->_view->render('create');
	}
	public function delete ($id) {
		// dd($_POST);
		$res = ['success' => false, 'msg' => ''];
		$lenguaje = $this->_view->loadLenguaje(['difusion_contenido_index', 'request']);
		if ($this->isAcceptJson()) {
			if ($this->has(['id'])) {
				if ($row_id = $this->getInt('id')) {
					if ($row_id != 0 && $row_id == $id)
					$row = ODifusionTipo::find($row_id);
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
	public function update ($id, $modo = 'index') {
		$res = ['success' => false, 'msg' => ''];
		$lenguaje = $this->_view->loadLenguaje(['difusion_contenido_index', 'request']);
		if ($this->isAcceptJson()) {
			switch ($modo) {
				case 'index':
					// dd($_POST);
					if ($this->has(['idiomas', 'estado', 'id'])) {
						if (is_numeric($id)) {
							$row = ODifusionTipo::find($id);
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
                            $row->ODit_Tipo = $post['idiomas'][$idioma_var]['titulo'];
                            $row->ODit_Descripcion = $post['idiomas'][$idioma_var]['descripcion'];
                            $row->ODit_Estado = $post['estado'];
                            $row->save();

                        } else {
                            ContenidoTraducido::updateRow('ora_difusion_tipo', $row->ODit_IdTipoDifusion, $value->Idi_IdIdioma, [
                                'ODit_Tipo' => $post['idiomas'][$idioma_var]['titulo'],
                                'ODit_Descripcion' => $post['idiomas'][$idioma_var]['descripcion'],
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
							$row = ODifusionTipo::find($row_id);
							if ($row) {
								$row->ODit_Estado = $this->getInt('estado');
								$row->save();
								$res['success'] = true;
								$res['msg'] = $row->ODit_Estado == 1 ? $lenguaje['str_elemento_is_activo'] :  $lenguaje['str_elemento_is_inactivo'];
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
	    $data['ruta'] = 'tipo';//evento
	    $lenguaje = $this->_view->getLenguaje('difusion_contenido_index');
	    $data['titulo'] = $lenguaje['difusion_tipo_index_titulo'];
	    $this->_view->assign($data);
	    $this->_view->render('index');
		} else {
			$this->show($id);
		}
	}
}
 ?>