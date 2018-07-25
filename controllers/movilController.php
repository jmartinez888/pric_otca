<?php

class movilController extends Controller {    

    private $_movil;
    public function __construct($lang,$url) {
        parent::__construct($lang,$url);       
    }
    public function index(){
       $this->validarUrlIdioma();
    }
}
