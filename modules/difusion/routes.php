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

	// ['{lang}/difusion/contenido/datatable', 'contenido', 'datatable'],
	// ['{lang}/difusion/contenido/datos_cifras', 'contenido', 'datos_cifras'],
	// ['{lang}/difusion/contenido/{id}', 'contenido', 'show'],
];

?>