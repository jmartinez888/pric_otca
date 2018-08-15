<input class="estado" id="hidden_tmp_session" value='{$learn_url_tmp}'>
<input class="estado" id="hidden_lang" value="{$learn_lenguaje}" />
<input class="estado" id="hidden_usuario" value="{$learn_usuario}" />
<input class="estado" id="hidden_root" value="{$_url}" />
<input class="estado" id="hidden_url" value="{$learn_url}" />
<input class="estado" id="hidden_curso" value="{Session::get('learn_param_curso')}" />
<input class="estado" id="hidden_modulo" value="{Session::get('learn_param_modulo')}" />
<input class="estado" id="hidden_leccion" value="{Session::get('learn_param_leccion')}" />
<div id="menu_docente">{include file='modules/elearning/views/cursos/menu/lateral.tpl'}</div>
<div id="menu_curso" style="display: none">{include file='modules/elearning/views/gestion/menu/menu.tpl'}</div>
<div class="col col-lg-10" style="padding-top: 20px">
	<div class="col col-lg-12">
        <div id="learn_content_main"></div>
    </div>
</div>
