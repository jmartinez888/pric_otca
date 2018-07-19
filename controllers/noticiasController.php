<?php

class noticiasController extends Controller
{
    private $_not;
    
    public function __construct($lang,$url) 
    {
        parent::__construct($lang,$url);       
    }
    
    public function index()
    {       
        $this->validarUrlIdioma();
    }      
}

?>
