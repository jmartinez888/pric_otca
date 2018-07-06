<?php
/**
 * @package dompdf
 * @link    http://dompdf.github.com/
 * @author  Benj Carson <benjcarson@digitaljunkies.ca>
 * @author  Fabien Ménager <fabien.menager@gmail.com>
 * @license http://www.gnu.org/copyleft/lesser.html GNU Lesser General Public License
 */

// HMLT5 Parser
require_once("libs/dompdf/lib/html5lib/Parser.php");

// Sabberworm
spl_autoload_register(function($class)
{
    if (strpos($class, 'Sabberworm') !== false) {
        $file = str_replace('\\', DIRECTORY_SEPARATOR, $class);
        $file = realpath(__DIR__ . '/lib/php-css-parser/lib/' . (empty($file) ? '' : DIRECTORY_SEPARATOR) . $file . '.php');
        if (file_exists($file)) {
            require_once $file;
            return true;
        }
    }
    return false;
});

require_once("libs/dompdf/lib/html5lib/Parser.php"); 
require_once("libs/dompdf/lib/php-font-lib/src/FontLib/Autoloader.php"); 
require_once("libs/dompdf/lib/php-svg-lib/src/autoload.php"); 
require_once("libs/dompdf/src/Autoloader.php"); 
require_once("libs/Dompdf.php");

Dompdf\Autoloader::register();
