<?php

//date_default_timezone_set('America/Sao_Paulo');//Definir Zona Horaria, Brasil.

define('DS', DIRECTORY_SEPARATOR);
define('LANG_PATH', 'lang');
define('ROOT', realpath(dirname(__FILE__)) . DS);
define('APP_PATH', ROOT . 'application' . DS);
try{
    require_once APP_PATH . 'Exception.php';
    require_once APP_PATH . 'Autoload.php';
    require_once APP_PATH . 'Config.php';
    require_once APP_PATH . 'Vendors.php';

    Session::init();
    //Registry->Se utiliza para guardar instancia de clases que utilizan en
    //la aplicacion, utiliza el patron Singleton.
    $registry = Registry::getInstancia();
    $registry->_request = new Request();

    $registry->_db = new Database(DB_HOST, DB_NAME, DB_USER, DB_PASS, DB_CHAR);
    $registry->_acl = new ACL();

    Bootstrap::run($registry->_request);
} catch(Exception $exception){
    echo "Excepción no capturada: " , $exception->getMessage(), " en : <b>", $exception->getFile() . "</b>, linea : <b>" . $exception->getLine() . "</b>\n";
}
?>