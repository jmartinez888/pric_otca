{extends 'index_elearning.tpl'}
{block 'css' append}
<link href="{$_url}gcurso/css/_view_registrar.css" rel="stylesheet" type="text/css"/>
{/block}
{block 'subcontenido'}
<!-- <link href="{$_url}gcurso/css/_view_registrar.css" rel="stylesheet" type="text/css"/> -->

<div class="col-lg-12" style="margin-bottom: 10px">
  <button class="btn btn-success" style=" float: left" type="button" id="btn_inicio">
    <i class="glyphicon glyphicon-book"></i> Inicio
  </button>
</div>


<div class="col-lg-12">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>{$lenguaje.learn_curso_registro_titulo}</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      <form method="post" action="gcurso/_registrar_curso" id="frm_curso">

        <div class="form-group" >
            <label class="col-lg-12 control-label">{$lenguaje.label_idioma} : </label>
            {if  isset($idiomas) && count($idiomas)}              
                <div class="form-inline col-lg-12">
                {foreach from=$idiomas item=idi}                    
                    <div class="radio">
                        <label>
                            <input type="radio"  name="idiomaRadio" id="idiomaRadio" value="{$idi.Idi_IdIdioma}"  
                                {if isset($idiomaCookie) && $idiomaCookie == $idi.Idi_IdIdioma } checked="checked" {/if} required>
                            {$idi.Idi_Idioma} 
                        </label>                                        
                    </div>
                {/foreach}
                </div>              
            {/if}
        </div>
       
        <div class="col-lg-12"><h5><strong>{$lenguaje.learn_curso_modalidad_curso}</strong></h5></div>

        <div class="col-lg-4 col-md-6 col-sm-12">
          <select class="form-control" name="modalidad" id="slModalidad">
              <option value="-1" selected disabled>{$lenguaje.learn_curso_seleccion_modalidad}</option>
            {foreach from=$modalidad item=mod}
              <option value="{$mod.Moa_IdModalidad}">{$mod.Moc_Titulo}</option>
            {/foreach}
          </select>
        </div>
        <div class="col-lg-8 col-md-6 col-sm-12" style="text-align: justify">
          <div class="opcion_mod" style="color: red; display: inherit">({$lenguaje.learn_curso_seleccion_modalidad})</div>
          {foreach from=$modalidad item=mod}
          <div class="opcion_mod" id="ModCurso{$mod.Moa_IdModalidad}">{$mod.Moc_Descripcion}</div>
          {/foreach}
        </div>
        <div class="col-lg-12 margin-top-10"><h5><strong>{$lenguaje.learn_curso_titulo_curso}</strong></h5></div>
        <div class="col-lg-12"><input class="form-control" name="curso_titulo"/></div>
        <div class="col-lg-12 margin-top-10"><h5><strong>{$lenguaje.learn_curso_decripcion_curso}</strong></h5></div>
        <div class="col-lg-12">
          <textarea class="form-control no-required" name="curso_descripcion" rows="5"></textarea>
        </div>
        <div class="col-lg-12 " style="text-align: right">
          <button class="btn btn-success margin-top-10" type="button" id="btn_guardar">
            <i class="glyphicon glyphicon-floppy-saved"></i> {$lenguaje.learn_curso_registrar} 
          </button>
        </div>
      </form>
    </div>
  </div>
</div>
{/block}  

{block 'js' append}
<script type="text/javascript" src="{$_url}gcurso/js/_view_registrar.js"></script>
{/block}
