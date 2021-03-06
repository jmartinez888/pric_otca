<?php

use App\ODifusionLinkInteres;

abstract class Controller
{
    private $_registry;
    protected $_view;
    protected $_acl;
    protected $_request;

    protected $_lenguaje;
    protected $_url;


    public function __construct($lang, $url = '')
    {
        $this->_registry = Registry::getInstancia();
        $this->_acl = $this->_registry->_acl;
        $this->_request = $this->_registry->_request;
        $this->_view = new View($this->_request, $this->_acl);
        $this->_lenguaje = $lang;
        $this->_url = $url;
        Session::set("fileLenguaje",array());
        if(isset($this->_url) && trim($this->_url) != '')
            $this->_view->assign('url', $this->_url);
        else $this->_view->assign('url', '');


        $this->init();
    }
    private function init() {
        $data['links_interes'] = ODifusionLinkInteres::activos()->visibles()->limit(5)->get();
        $this->_view->assign($data);
    }
    abstract public function index();

    public function vcomponent ($name) {
        header('Content-type: application/javascript');
        $this->_view->render('component/'.$name);
    }

    protected function loadModel($modelo, $modulo = false, $instance = false)
    {
        $modelo = $modelo . 'Model';
        $rutaModelo = ROOT . 'models' . DS . $modelo . '.php';

        if(!$modulo)
        {
            $modulo = $this->_request->getModulo();
        }

        if($modulo)
        {
           if($modulo != 'default')
           {
               $rutaModelo = ROOT . 'modules' . DS . $modulo . DS . 'models' . DS . $modelo . '.php';
           }
        }

        if(is_readable($rutaModelo))
        {
            require_once $rutaModelo;
            $modelo = new $modelo;
            return $modelo;
        } else {
            throw new Exception('Error de modelo - ' . $rutaModelo);
        }
    }

    protected function loadController($controller, $modulo = false)
    {
        $controller = $controller . 'Controller';
        $rutaController = ROOT . 'controllers' . DS . $controller . '.php';

        if(!$modulo)
        {
            $modulo = $this->_request->getModulo();
        }

        if($modulo)
        {
           if($modulo != 'default')
           {
               $rutaController = ROOT . 'modules' . DS . $modulo . DS . 'controllers' . DS . $controller . '.php';
           }
        }

        if(is_readable($rutaController))
        {
            require_once $rutaController;
            $controller = new $controller;
            return $controller;
        } else {
            throw new Exception('Error de controller - ' . $rutaController);
            return false;
        }
    }

    protected function botonPress($clave)
    {
        if(isset($_REQUEST[$clave]))
        {
            return true;
        } else {
            return false;
        }
    }

    protected function getLibrary($libreria)
    {
        $rutaLibreria = ROOT . 'libs' . DS . $libreria . '.php';

        if(is_readable($rutaLibreria))
        {
            require_once $rutaLibreria;
        } else {
            throw new Exception('Error de libreria');
        }
    }
    protected function setStore () {
        // header("Access-Control-Allow-Origin: *");
        // header("Content-Type: application/json; charset=UTF-8");
        // header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
        if (strtoupper($_SERVER['REQUEST_METHOD']) == 'POST') {
            header("Access-Control-Allow-Methods: POST");
            header("Access-Control-Max-Age: 3600");
        } else {
            http_response_code(404);
            // header('Content-type: application/json');
            echo json_encode(['msg' => 'error method, not is post']);
            die();
        }

    }

    protected function setDelete () {
        // header("Access-Control-Allow-Origin: *");
        // header("Content-Type: application/json; charset=UTF-8");
        // header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
        if (strtoupper($_SERVER['REQUEST_METHOD']) == 'DELETE') {
            header("Access-Control-Allow-Methods: GET");
            header("Access-Control-Max-Age: 3600");
        } else {
            http_response_code(404);
            // header('Content-type: application/json');
            echo json_encode(['msg' => 'error method, not is delete']);
            die();
        }

    }

    protected function isAcceptJson () {
        $accept = explode(',', $_SERVER['HTTP_ACCEPT']);
        foreach ($accept as $key => $value) {
            $accept[$key] = trim($value);
        }
        return in_array('application/json', $accept);
        // return strtolower($_SERVER['HTTP_ACCEPT']) == 'application/json';

    }
    protected function setPostRequest () {
        header("Access-Control-Allow-Origin: *");
        // header("Content-Type: application/json; charset=UTF-8");
        header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
        if (strtoupper($_SERVER['REQUEST_METHOD']) == 'POST') {
            header("Access-Control-Allow-Methods: POST");
        } else {
            http_response_code(404);
            // header('Content-type: application/json');
            echo json_encode(['msg' => 'error method, not is post']);
            die();
        }
    }
    protected function setPut () {
        header("Access-Control-Allow-Origin: *");
        // header("Content-Type: application/json; charset=UTF-8");
        header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
        if (strtoupper($_SERVER['REQUEST_METHOD']) == 'PUT') {
            header("Access-Control-Allow-Methods: POST");
            header("Access-Control-Max-Age: 3600");
        } else {
            http_response_code(404);
            // header('Content-type: application/json');
            echo json_encode(['msg' => 'error method, not is put']);
            die();
        }

    }
    protected function filledPost ($value) {
       return  isset($_POST[$value]) && !empty($_POST[$value]);
    }
    protected function filledGet ($value) {
       return  isset($_GET[$value]) && !empty($_GET[$value]);
    }
    protected function filledAllPost($array) {
        if (is_array($array)) {
            foreach ($array as $value) {
                if (!isset($_POST[$value]))
                    return false;
            }
            return true;
        } else return false;
    }
    protected function filledAllGet($array) {
        if (is_array($array)) {
            foreach ($array as $value) {
                if (!(isset($_GET[$value]) && (is_numeric($_GET[$value]) ? true : !empty($_GET[$value])) ))
                    return false;
            }
            return true;
        } else return false;
    }
    protected function has($array, $mode = 'request') {
        if (is_array($array)) {
            foreach ($array as $value) {
                switch ($mode) {
                    case 'post':
                        if (!isset($_POST[$value])) return false;
                        break;
                    case 'get':
                        if (!isset($_GET[$value])) return false;
                        break;
                    default:
                        if (!isset($_REQUEST[$value])) return false;
                }
            }
            return true;
        } else {
            switch ($mode) {
                case 'post': return isset($_POST[$array]); break;
                case 'get': return isset($_GET[$array]); break;
                default: return isset($_REQUEST[$array]);
            }
        }
        return false;
    }
    protected function getTexto($clave)
    {
        if(isset($_POST[$clave]) && !empty($_POST[$clave]))
        {
            $_POST[$clave] = htmlspecialchars($_POST[$clave], ENT_QUOTES);
            return $_POST[$clave];
        }

        if(isset($_GET[$clave]) && !empty($_GET[$clave]))
        {
            $_GET[$clave] = htmlspecialchars($_GET[$clave], ENT_QUOTES);
            return $_GET[$clave];
        }

        return '';
    }

    protected function getInt($clave)
    {
        if(isset($_POST[$clave]) && !empty($_POST[$clave]))
        {
            $_POST[$clave] = filter_input(INPUT_POST, $clave, FILTER_VALIDATE_INT);
            return $_POST[$clave];
        }

        if(isset($_GET[$clave]) && !empty($_GET[$clave]))
        {
            $_GET[$clave] = filter_input(INPUT_GET, $clave, FILTER_VALIDATE_INT);
            return $_GET[$clave];
        }

        return 0;
    }
    
    protected function redireccionarReferer ($ruta = false, $absolute = false)
    {
        if ($_SERVER['HTTP_REFERER'] != null && $_SERVER['SCRIPT_URI'] != $_SERVER['HTTP_REFERER']) {
            $this->redireccionar($_SERVER['HTTP_REFERER'], true);
        } else {
            $this->redireccionar($ruta, $absolute);
        }
        
    }
    protected function redireccionar($ruta = false, $absolute = false)
    {
        if ($absolute) {
            header('location:' . $ruta);
            exit;
        } else {
            if($ruta)
            {
                $leng = strpos($ruta, Cookie::lenguaje()."/");
            //Para ver si la hay variable idioma en la url diferente a la del navegador
                $leng_into_url = explode('/', $ruta)[0];
    
                if($leng !== false)
                    header('location:' . BASE_URL . $ruta);
                else if(strlen($leng_into_url) == 2)
                     header('location:' . BASE_URL. $ruta);
                else if(strlen($ruta) > 2)
                     header('location:' . BASE_URL .Cookie::lenguaje().'/'. $ruta);
                else
                    header('location:' . BASE_URL . Cookie::lenguaje());
                exit;
            } else {
                header('location:' . BASE_URL . Cookie::lenguaje());
                exit;
            }
        }
    }

    protected function filtrarInt($int)
    {
        $int = (int) $int;

        if(is_int($int))
        {
            return $int;
        } else {
            return 0;
        }
    }

    
    protected function filtrarInts($int, $diferente = 0)
    {
        foreach ($int as $key => $value) {
            if (!(is_numeric($value) && is_int(+$value)) || (+$value == $diferente)) {
                return false;
            }
        }
        return true;
    }

    protected function filtrarTexto($texto)
    {
        if(isset($texto) && !empty($texto))
        {
            $texto = htmlspecialchars($texto, ENT_QUOTES);
            return $texto;
        }

        return '';
    }

    protected function filtrarSql($texto)
    {
        if(isset($texto) && !empty($texto))
        {
            $texto = strip_tags($texto);

            if(!get_magic_quotes_gpc())
            {
                #$_POST[$clave] = mysqli_escape_string($_POST[$clave]);
                $texto = ($texto);
            }

            return trim($texto);
        }
    }

    protected function getUrl()
    {
        if(isset($this->_url))
            return $this->_url;
    }

    protected function getPostParam($clave)
    {
        if(isset($_POST[$clave]))
        {
            return $_POST[$clave];
        }
    }

    private function _sql ($value) {
        if (!is_array($value)) {
            $value = strip_tags($value);
            $value = htmlspecialchars($value, ENT_QUOTES);
            return trim($value);
        } else {
            
            foreach ($value as $key => $item) {
                $value[$key] = $this->_sql($item);
            }
            return $value;
        }
    }
    protected function getSql($clave)
    {
        if(isset($_POST[$clave]) && !empty($_POST[$clave]))
        {
            if (!is_array($_POST[$clave])) {
                $_POST[$clave] = strip_tags($_POST[$clave]);
    
                if(!get_magic_quotes_gpc())
                {
                    #$_POST[$clave] = mysqli_escape_string($_POST[$clave]);
                    $_POST[$clave] = ($_POST[$clave]);
                }
    
                return trim($_POST[$clave]);
            } else {
                foreach ($_POST[$clave] as $key => $item) {
                    $_POST[$clave][$key] = $this->_sql($item);
                }
                return $_POST[$clave];
            }
        }

        if(isset($_GET[$clave]) && !empty($_GET[$clave]))
        {
            if (!is_array($_GET[$clave])) {
                $_GET[$clave] = strip_tags($_GET[$clave]);
    
                if(!get_magic_quotes_gpc())
                {
                    #$_GET[$clave] = mysqli_escape_string($_GET[$clave]);
                    $_GET[$clave] = ($_GET[$clave]);
                }
    
                return trim($_GET[$clave]);
            } else {
                foreach ($_GET[$clave] as $key => $item) {
                    $_GET[$clave][$key] = $this->_sql($item);
                }
                return $_GET[$clave];
            }
        }
    }

    protected function getAlphaNum($clave)
    {
        if(isset($_POST[$clave]) && !empty($_POST[$clave]))
        {
            $_POST[$clave] = (string) preg_replace('/[^A-Z0-9_]/i', '', $_POST[$clave]);
            return trim($_POST[$clave]);
        }
    }

    public function validarEmail($email)
    {
        if(!filter_var($email, FILTER_VALIDATE_EMAIL))
        {
            return false;
        }

        return true;
    }
    public function validarUrl($url)
    {
        if(!filter_var($url, FILTER_VALIDATE_URL))
        {
            return false;
        }

        return true;
    }


	protected function formatPermiso($clave)
    {
        if(isset($_POST[$clave]) && !empty($_POST[$clave]))
        {
            $_POST[$clave] = (string) preg_replace('/[^A-Z_]/i', '', $_POST[$clave]);
            return trim($_POST[$clave]);
        }

    }

    protected function validarUrlIdioma($norender=false)
    {
        if($this->_lenguaje)
        {
            Cookie::setLenguaje($this->_lenguaje);
        }else if(!$norender)
        {
            header('location:' . BASE_URL . Cookie::lenguaje() . "/".  $this->_url);
        }
    }

    public function utf8_converter_array($array)
    {
        array_walk_recursive($array, function(&$item, $key)
        {
            if (!mb_detect_encoding($item, 'utf-8', true))
            {
                $item = utf8_encode($item);
            }
        });
        return $array;
    }

    public function itemView(){
        include_once ROOT . 'modules' . DS . $this->_request->getModulo()
                . DS . 'views' . DS . $this->_request->getControlador()
                . DS . 'widget' . DS . $this->_request->getMetodo() . '.html';
    }

    public function isAjax(){
        // print_r($_SERVER);
        if (isset( $_SERVER['HTTP_X_REQUESTED_WITH'] ) && strtoupper($_SERVER['HTTP_X_REQUESTED_WITH']) === strtoupper('XMLHttpRequest')) {
            return true;
        } else {
            header('Content-type: application/json');
            echo json_encode(['msg' => 'Not is AJAX']);
            http_response_code(404);
            die();
        }
    }

    public function show404 () {
        // header('Content-type: application/json');
        echo '404 NOT FOUND';
        http_response_code(404);
        die();
    }
    // public function getContTrad($Cot_Tabla, $Cot_IdRegistro, $Idi_IdIdioma)
    // {
    //     return Model::getContTrad($Cot_Tabla, $Cot_IdRegistro, $Idi_IdIdioma);
    // }

}

?>
