{extends 'template.tpl'}
{block 'contenido'}
<input type="text" id="inHiddenCurso" value="{$curso.Cur_IdCurso}" hidden="hidden"> <!-- RODRIGO 20180607 -->
<div class="col col-lg-12">
  <div class="col-lg-12">
    <div class="col-lg-12 referencia-curso-total">
      <a class="referencia-curso" href="{BASE_URL}elearning/cursos/">Cursos</a>  /  {$curso.Cur_Titulo}
    </div>
  </div>
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col col-lg-10" style="margin-top: 20px; padding-left: 0px;">
    <div class="col-lg-12">
      <div class="panel panel-default">
        <div class="panel-body">
          {include 'respuestas_format.tpl'}
        </div>
      </div>
    </div>
  </div>
</div>

{/block}

{block 'css'}
<link rel="stylesheet" type="text/css" href="{BASE_URL}modules/elearning/views/cursos/css/jp-curso.css">
{/block}