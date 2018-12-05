<?php

 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

 /**
 * Description of loginController
 *
 * @author ROLORO
 */
class elearningController extends Controller {
	protected $ruta_formularios = ROOT.'files'.DS.'elearning'.DS.'formularios'.DS;
  public function __construct($lang,$url)
  {
    parent::__construct($lang,$url);
  }

  public function index()
  {
     $this->validarUrlIdioma();
  }
}
