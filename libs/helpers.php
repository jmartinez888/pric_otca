<?php
  if (! function_exists('get_lenguaje')) {
      function get_lenguaje($var)
      {
      	dd(ROOT);
        return $lenguaje[$var];
      }
  }

  if (! function_exists('fill_zeros')) {
    function fill_zeros($number, $zeros = 4)
    {
      $num = number_format($number, 0, '', '');
      return str_pad($num, $zeros, '0', STR_PAD_LEFT);
    }
  }

 ?>