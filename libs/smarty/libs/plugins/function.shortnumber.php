<?php
/**
 * Smarty plugin
 *
 * @package    Smarty
 * @subpackage PluginsFunction
 */

/**
 * Smarty {shortnumber} function plugin
 * Type:     function<br>
 * Name:     shortnumber<br>
 * Date:     Nov 27, 2018<br>
 * Purpose:  shortnumber through given values<br>
 * Params:
 * <pre>
 * - number      - numero a cortar 
 * - precision    - cantidad de digitos (optional) por defecto 1
 * </pre>
 * Examples:<br>
 * <pre>
 * {shortnumber number=2000} -> 2.0K
 * {shortnumber number=3200 precision=2} -> 3.2k
 * </pre>
 *
 * @link     no tiee {shortnumber}
 *           (Smarty online manual)
 * @author   Rodofo Cardenas i<viercavi@gmail.com>
 * @version  1
 *
 * @param array                    $params   parameters
 * @param Smarty_Internal_Template $template template object
 *
 * @return string
 */

function smarty_function_shortnumber($params, $template){

     $number = (int)$params['number'];
     if (!is_int($number)) {
        $number=0;
     }

     if (!empty($params['precision']))
        $precision=$params['precision'];
    else 
        $precision=1;

	if ($number < 900) {
        // 0 - 900
        $n_format = number_format($number, $precision);
        $suffix = '';
        } else if ($number < 900000) {
            // 0.9k-850k
            $n_format = number_format($number / 1000, $precision);
            $suffix = 'K';
        } else if ($number < 900000000) {
            // 0.9m-850m
            $n_format = number_format($number / 1000000, $precision);
            $suffix = 'M';
        } else if ($number < 900000000000) {
            // 0.9b-850b
            $n_format = number_format($number / 1000000000, $precision);
            $suffix = 'B';
        } else {
            // 0.9t+
            $n_format = number_format($number / 1000000000000, $precision);
            $suffix = 'T';
        }
      // Remove unecessary zeroes after decimal. "1.0" -> "1"; "1.00" -> "1"
      // Intentionally does not affect partials, eg "1.50" -> "1.50"
        if ( $precision > 0 ) {
            $dotzero = '.' . str_repeat( '0', $precision );
            $n_format = str_replace( $dotzero, '', $n_format );
        }
        return $n_format . $suffix;

}