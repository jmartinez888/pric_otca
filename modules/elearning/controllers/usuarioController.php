<?php

/**
 * Description of loginController
 * @author ROLORO
 */
class usuarioController extends elearningController {

	public function __construct($lang, $url) {
		parent::__construct($lang, $url);
		if (!Session::get("autenticado")) {$this->redireccionar("elearning/");}
	}

	public function index() {
		$this->redireccionar("elearning/usuario/perfil");
	}

	public function perfil() {
		$lang = $this->_view->getLenguaje('elearning_cursos', false, true);
		$usuario = Session::get("id_usuario");
		$model = $this->loadModel("usuario");
		$usuario = $model->getUsuarioXId($usuario);

		if ($usuario == null || count($usuario) == 0) {$this->redireccionar("elearning/");}

		$this->_view->setTemplate(LAYOUT_FRONTEND);
		$this->_view->setCss(array("perfil"));
		$this->_view->setJs(array(array(BASE_URL . "modules/elearning/views/gestion/js/core/util.js"), "perfil"));
		$this->_view->assign("usuario", $usuario[0]);
		$this->_view->renderizar("perfil");
	}

	public function _actualizar_perfil() {
		$id = $this->getTexto("id");
		$especialidad = $this->getTexto("especialidad");
		$perfil = $this->getTexto("perfil");
		$institucion = $this->getTexto("institucion");
		$cargo = $this->getTexto("cargo");
		$grado = $this->getTexto("grado");

		$model = $this->loadModel("usuario");
		$model->updatePerfil($id, $institucion, $cargo, $grado, $especialidad, $perfil);

		$this->redireccionar("elearning/usuario/perfil");
	}

	public function _actualizar_img() {
		$this->getLibrary("ServiceResult");
		$id = $this->getTexto("id");
		$img = $this->getTexto("img");

		$model = $this->loadModel("usuario");
		$model->updateImgUsuario($id, $img);
		Session::set('Usu_URLImage', $img);
		$service = new ServiceResult();
		$service->Success($img);
		$service->Send();
	}
}