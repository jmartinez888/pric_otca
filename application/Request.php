<?php

/*
 * -------------------------------------
 * www.dlancedu.com | Jaisiel Delance
 * framework mvc basico
 * Request.php
 * -------------------------------------
 * Modificado por @vicercavi | Rodolfo Cardenas
 */

class Request
{
    private $_url;
    private $_modulo;
    private $_lenguaje;
    private $_controlador;
    private $_metodo;
    private $_argumentos;
    private $_modules;

    private $_route;

    public function __construct()
    {

        $_modulos=scandir(ROOT . 'modules');
        $_modulos=array_splice($_modulos, 2);

        $routes = [];
        foreach ($_modulos as $key => $value) {
            $path = ROOT.'modules'.DS.$value.DS.'routes.php';
            if (is_readable($path)){
                require_once $path;
                if (isset($route) && is_array($route) && count($route) > 0) {
                    foreach ($route as $key => $values) {
                        $route[$key][] = $value;
                    }
                    array_unshift($routes, ...$route);
                }
            }
        }

        $this->_modules  = $_modulos;


        if(isset($_GET['url']))
        {
            $this->_url=$_GET['url'];

            $url = str_replace('%20', '(*)', $this->_url);
            $url = filter_var( $url, FILTER_SANITIZE_URL);
            $url = str_replace('(*)', ' ', $this->_url);

            $base_url = $url;
            $url = explode('/', $url);

            $url = $pre_url = array_filter($url);
            $pre_lenguaje = false;
            if (strlen($pre_url[0]) == 2) {
                $pre_lenguaje = $pre_url[0];
                array_shift($pre_url);
            }
            $params_reg = [];
            //comparar similitudes
            $final = [];
            foreach ($routes as $key => $value) {
                $params_reg = [];
                $partes = explode('/', $value[0]);
                if ($partes[0] == '{lang}') {
                    array_shift($partes);
                }
                if (count($partes) == count($pre_url)) {
                    $same = true;
                    foreach ($partes as $keyp => $valuep) {
                        preg_match('/^\w*{\w{2,}}\w*$/', $valuep , $reg);
                        if (count($reg) > 0) {
                            $params_reg[] = $pre_url[$keyp];
                        } else {
                            if ($partes[$keyp] != $pre_url[$keyp]){
                                $same = false;
                                break;
                            }

                        }
                    }
                    if ($same) {
                        $final = $routes[$key];
                        break;
                    } else {
                        continue;
                    }

                }
            }
            $this->_route = $final;


            if (count($final) > 0) {
                $this->_lenguaje = $pre_lenguaje;
                if (count($final) == 5) {
                    $this->_modulo = $final[1];
                    $this->_controlador = $final[2];
                    $this->_metodo = $final[3];
                    $this->_argumentos = $params_reg;
                }
                if (count($final) == 4) {
                    $this->_modulo = $final[3];
                    $this->_controlador = $final[1];
                    $this->_metodo = $final[2];
                    $this->_argumentos = $params_reg;
                }
                if (count($final) == 3) {
                    $this->_modulo = false;
                    $this->_metodo = $final[1];
                    $this->_controlador = $final[2];
                    $this->_argumentos = $params_reg;
                }
            } else {
                /* modulos de la app */
                #$this->_modules = array('usuarios','arquitectura','acl','bitacora','busqueda','visita', 'descarga','dublincore', 'estandar','legislacion','pliniancore', 'darwincore','movil','atlas','excel','calidaddeagua','pecari','hidrogeo', 'rss', 'bdrecursos');


                $this->_lenguaje= strtolower(array_shift($url));
                $this->_modulo;

                if( strlen($this->_lenguaje)>2)
                {
                     $this->_modulo=$this->_lenguaje;
                     $this->_lenguaje = false;
                }
                else
                {
                      $this->_modulo=strtolower(array_shift($url));;
                }

                if(!$this->_lenguaje)
                {
                     $this->_lenguaje = false;
                }

                if(!$this->_modulo) {
                    $this->_modulo = false;
                } else {
                    if(count($this->_modules))
                    {
                        if(!in_array($this->_modulo, $this->_modules))
                        {
                            $this->_controlador = $this->_modulo;
                            $this->_modulo = false;
                        }
                        else
                        {
                            $this->_controlador = strtolower(array_shift($url));
                            if(!$this->_controlador)
                            {
                                $this->_controlador = 'index';
                            }
                        }
                    }
                    else
                    {
                         $this->_controlador = $this->_modulo;
                         $this->_modulo = false;
                    }
                }

                $this->_metodo = strtolower(array_shift($url));
                $this->_argumentos = $url;

            }



        }

        if(!$this->_controlador)
        {
            $this->_controlador = DEFAULT_CONTROLLER;
        }

        if(!$this->_metodo)
        {
            $this->_metodo = 'index';
        }

        if(!isset($this->_argumentos))
        {
            $this->_argumentos = array();
        }
    }
     public function getUrl()
    {
        return $this->_url;
    }
     public function getLenguaje()
    {
        return $this->_lenguaje;
    }
    public function getModulo()
    {
        return $this->_modulo;
    }

    public function getControlador()
    {
        return $this->_controlador;
    }

    public function getMetodo()
    {
        return $this->_metodo;
    }

    public function getArgs()
    {
        return $this->_argumentos;
    }
}

?>