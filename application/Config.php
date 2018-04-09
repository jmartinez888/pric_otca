<?php

/*
 * -------------------------------------
 * www.dlancedu.com | Jaisiel Delance
 * framework mvc basico
 * Config.php
 * -------------------------------------
 * Modificado por: 
 * @vicercavi | Rodolfo Cardenas |
 * @jmartinez | Jhon Martinez
 */

define('BASE_URL', 'http://'.$_SERVER['SERVER_NAME'].'/pric_otca/');
define('DEFAULT_CONTROLLER', 'index');
define('DEFAULT_LAYOUT', 'backend');
define('LAYOUT_FRONTEND', 'frontend');
define('ROOT_ARCHIVO_FISICO',$_SERVER['DOCUMENT_ROOT'].'/pric_otca/files/');
define('URL_ARCHIVO_FISICO',BASE_URL.'files/');
define('LENGUAJE', 'es');
define('CANT_REG_PAG', 50);#Indica la cantidad de fila que se listaran al cargar un arreglo

// $ver = (float)phpversion(); Version Actual PHP 5.6.32 - JMartinez
// phpinfo();exit;
const LIST_REG_PAG = [CANT_REG_PAG,1,2,3,4,5,6,7];
// $a = range("A", "Z"); //Array con letras desde la A hasta la Z; pero no se puede asignar a LIST_ABC. 
const LIST_ABC = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];

// foreach (range("A", "Z") as $letra) {
//     echo $letra;
// }
// for($i = 0; $i < count($a); $i++){
// 	LIST_ABC[$i] = $a[$i];
// 	echo $a[$i];
// }

// const LIST_REG_PAG = [CANT_REG_PAG,50,100,250,500,1000,2500,5000];
// if ((float)phpversion() < 7.0) {
// 	const LIST_REG_PAG = [CANT_REG_PAG,50,100,250,500,1000,2500,5000];
// echo(phpversion());print_r(LIST_REG_PAG); exit;
// } else {
// 	define('LIST_REG_PAG', [CANT_REG_PAG,50,100,250,500,1000,2500,5000]);
// }
    

define('APP_NAME', 'PHP MVC');
define('APP_SLOGAN', 'Framework MVC en PHP');
define('APP_COMPANY', 'www.iiap.org.pe');
define('COOKIE_TIME', 60*(1*24));//minutos()
define('SESSION_TIME', 10000000000000000);
define('HASH_KEY', '4f6a6d832be79');

define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', 'pric');
define('DB_NAME', 'pric_otca');
define('DB_CHAR', 'utf8');

?>
