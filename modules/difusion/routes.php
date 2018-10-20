<?php
//variables en un {nombre_variable}
//4,url, modulo ext, controller, metodo
//3 url, controller, metodo
//2 url, metodo modulo por defecto
$route = [
	['{lang}/difusion/banner/create', 'banner', 'create'],
	['{lang}/difusion/banner/store', 'banner', 'store'],
	['{lang}/difusion/banner/{id}', 'banner', 'show'],
	['{lang}/difusion/banner/{id}/delete', 'banner', 'delete'],

	['{lang}/difusion/link_interes/{id}/edit', 'link_interes', 'edit'],
	['{lang}/difusion/link_interes/{id}/update/{modo}', 'link_interes', 'update'],


	['{lang}/difusion/tipo/{id}/edit', 'tipo', 'edit'],
	['{lang}/difusion/tipo/{id}/update/{modo}', 'tipo', 'update'],
];

?>