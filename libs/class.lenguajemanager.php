<?php
class LenguajeManager {
	private $lenguajes;
	public function __construct($lenguajes) {
		$this->lenguajes = $lenguajes;
	}

	public function var ($name) {
		if ($name != '')
			return isset($this->lenguajes[$name]) ? $this->lenguajes[$name] : '['.$name.']';
		else return '[]';
	}

}

 ?>