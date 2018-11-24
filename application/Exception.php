<?php
function manejador_excepciones($exception) {
    // dd($exception);
  echo "Excepción no capturada: " , $exception->getMessage(), " en : <b>", $exception->getFile() . "</b>, linea : <b>" . $exception->getLine() . "</b>\n";
}

set_exception_handler('manejador_excepciones');
function miGestorDeErrores($errno, $errstr, $errfile, $errline)
{
    if (!(error_reporting() & $errno)) {
        // Este código de error no está incluido en error_reporting
        return;
    }

    switch ($errno) {
    case E_ERROR:
        echo "<b>E_ERROR </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;
    case E_WARNING:
        echo "<b>E_WARNING </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;
    case E_PARSE:
        echo "<b>E_PARSE </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;
    case E_NOTICE:
        $temp = explode('.', basename($errfile));
        if (in_array('tpl', $temp)) {
            $tt = strtolower($errstr);
            $f = explode('undefined index:', $tt);
            $f = array_filter($f, function($item) {
                return trim($item);
            });
            $msg = end($f);
            // print_r($f);
            print_r('['.$msg.']');
        } else {
            echo "<b>E_NOTICE </b> $errstr, $errfile, line $errline<br/>\n";
        }

        // exit(1);
        break;
    case E_CORE_ERROR:
        echo "<b>E_CORE_ERROR </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;
    case E_CORE_WARNING:
        echo "<b>E_CORE_WARNING </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;
    case E_COMPILE_ERROR:
        echo "<b>E_COMPILE_ERROR </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;
    case E_COMPILE_WARNING:
        echo "<b>E_COMPILE_WARNING </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;
    case E_USER_ERROR:
        echo "<b>E_USER_ERROR </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;
    case E_USER_WARNING:
        echo "<b>E_USER_WARNING </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;
    case E_USER_NOTICE:
        echo "<b>E_USER_NOTICE </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;
    case E_STRICT:
        echo "<b>E_STRICT </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;
    case E_RECOVERABLE_ERROR:
        echo "<b>E_RECOVERABLE_ERROR </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;
    case E_DEPRECATED:
        echo "<b>E_DEPRECATED </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;
    case E_USER_DEPRECATED:
        echo "<b>E_USER_DEPRECATED </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;
    case E_USER_NOTICE:
        echo "<b>E_USER_NOTICE </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;
    case E_ALL:
        echo "<b>E_ALL </b> $errstr, $errfile, line $errline<br/>\n";
        // exit(1);
        break;


    default:
        echo "Tipo de error desconocido: [$errno] $errstr, $errline<br/>\n";
        break;
    }
    /* No ejecutar el gestor de errores interno de PHP */
    return true;
}
set_error_handler("miGestorDeErrores");
?>