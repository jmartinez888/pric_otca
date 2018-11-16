<?php
$route = [
	['{lang}/elearning/leccion/{id}/edit', 'contenido', 'edit'],
	['{lang}/difusion/contenido/{id}/update', 'contenido', 'update'],
	['{lang}/difusion/contenido/{id}/delete', 'contenido', 'delete'],
	['{lang}/difusion/contenido/{id}/relations', 'contenido', 'relations'],

	['{lang}/difusion/banner/create', 'banner', 'create'],
	['{lang}/difusion/banner/store', 'banner', 'store'],
	['{lang}/difusion/banner/{id}', 'banner', 'show'],
	['{lang}/difusion/banner/{id}/delete', 'banner', 'delete'],
	['{lang}/difusion/banner/{id}/edit', 'banner', 'edit'],
	['{lang}/difusion/banner/{id}/update/{method}', 'banner', 'update'],

	['{lang}/difusion/cifras/{id}/edit', 'cifras', 'edit'],
	['{lang}/difusion/cifras/{id}/update/{modo}', 'cifras', 'update'],
	['{lang}/difusion/cifras/{id}/delete', 'cifras', 'delete'],

	['{lang}/difusion/link_interes/{id}/edit', 'link_interes', 'edit'],
	['{lang}/difusion/link_interes/{id}/update/{modo}', 'link_interes', 'update'],
	['{lang}/difusion/link_interes/{id}/delete', 'link_interes', 'delete'],

	['{lang}/difusion/indicadores/{id}/edit', 'indicadores', 'edit'],
	['{lang}/difusion/indicadores/{id}/update/{modo}', 'indicadores', 'update'],
	['{lang}/difusion/indicadores/{id}/delete', 'indicadores', 'delete'],


	['{lang}/difusion/tipo/{id}/edit', 'tipo', 'edit'],
	['{lang}/difusion/tipo/{id}/update/{modo}', 'tipo', 'update'],
	['{lang}/difusion/tipo/{id}/delete', 'tipo', 'delete'],
];

?>