<?php
  if (! function_exists('charsToInt')) {
    /**
     * [charsToInt generar int ASCCI concatenado, 2 caracteres]
     *
     * @return  [int]  [return  int]
     */
    function charsToInt ($char) {
      $t = str_split($char);
      $tt = '';
      foreach($t as $x) {
        $tt .= ord($x);
      }
      return +$tt;
    }
  }
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

  trait verificarIdioma {
    public static function setForceLang ($lang, $force = true) {
      self::$USE_FORCE_LANG = $force;
      self::$FORCE_LANG = $lang;
    }
    public static function getCurrentLang () {
      if (self::$USE_FORCE_LANG) {
        return self::$FORCE_LANG;
      } else {
        return \Cookie::lenguaje();
      }
    }
  }

 ?>