{extends 'template.tpl'}
{block 'css'}
<link href="{BASE_URL}modules/elearning/views/gestion/css/principal.css" rel="stylesheet" type="text/css">
{/block}
{block 'contenido'}
{* <input class="estado" id="hidden_tmp_session" value='{$learn_url_tmp}'>
<input class="estado" id="hidden_lang" value="{$learn_lenguaje}" />
<input class="estado" id="hidden_usuario" value="{$learn_usuario}" />
<input class="estado" id="hidden_root" value="{$_url}" />
<input class="estado" id="hidden_url" value="{$learn_url}" />
<input class="estado" id="hidden_curso" value="{Session::get('learn_param_curso')}" />
<input class="estado" id="hidden_modulo" value="{Session::get('learn_param_modulo')}" />
<input class="estado" id="hidden_leccion" value="{Session::get('learn_param_leccion')}" /> *}
{if isset($menu)}
	{if $menu == 'docente'}
		<div id="menu_docente">{include file='modules/elearning/views/cursos/menu/lateral.tpl'}</div>
	{/if}
	{if $menu == 'curso'}
		<div id="menu_curso" >{include file='modules/elearning/views/gestion/menu/menu.tpl'}</div>
	{/if}
{else}
	<div >SIN MENU</div>
{/if}
<div class="col col-lg-10" style="padding-top: 20px">
	<div class="col col-lg-12">
        <div id="learn_content_main">
        	{block 'subcontenido'}
        	{/block}
        </div>
    </div>
</div>
{/block}

{block 'js' }
	<script src="{BASE_URL}modules/elearning/views/gestion/js/core/util.js"></script>
	<script src="{BASE_URL}modules/elearning/views/gestion/js/core/view.js"></script>
	<script src="{BASE_URL}modules/elearning/views/gestion/js/core/controller.js"></script>
{/block}



