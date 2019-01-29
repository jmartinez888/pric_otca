{if isset($modulo) && count($modulo)}
    {if  isset($idiomas) && count($idiomas)}
      <div class="col-lg-12">
          <ul class="nav nav-tabs ">
            {foreach from=$idiomas item=idi}
                <li role="presentation" class="{if $modulo.Idi_IdIdioma==$idi.Idi_IdIdioma} active {/if}">
                    <a class="idioma_s" id="idioma_{$idi.Idi_IdIdioma}" href="#">{$idi.Idi_Idioma}</a>
                    <input type="hidden" id="hd_idioma_{$idi.Idi_IdIdioma}" value="{$idi.Idi_IdIdioma}" />
                    <input type="hidden" id="idiomaTradu" value="{$modulo.Idi_IdIdioma}"/>
                </li>    
            {/foreach}
          </ul>
      </div>        
    {/if}

    <!--  Tabs-->
    <div class="col-xs-12" style="padding-top: 15px;">
      <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active" id="item_modulo"><a href="#item" aria-controls="item">MÓDULO</a></li>
        <li role="presentation" id="item_lecciones" ><a href="#item" aria-controls="lecciones">LECCIONES</a></li>
      </ul>
    </div>
    <!-- Modulo -->
    <div {if isset($active) && $active == "mod" } class="col-xs-12  div_modulo display-block tab-pane" {else} class="col-xs-12  div_modulo tab-pane" {/if} id="item" role="tabpanel">
      <div class="panel panel-default" style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">
        <!-- <div class="panel-heading">
          <h3 class="panel-title">
            <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
            <strong>{$modulo.Moc_Titulo}</strong>
          </h3>
        </div> -->
        <div class="panel-body">
          <form id="frm-act-modulo" method="post" action="gmodulo/_actualizar_modulo">
              <input hidden="hidden" id="hidden_curso" name="id_curso" value="{$curso.Cur_IdCurso}" />
              <input name="id" id="hidden_modulo" hidden="hidden" value="{$modulo.Moc_IdModuloCurso}" />

              <input hidden="hidden" name="idiomaTradu" value="{$modulo.Idi_IdIdioma}" />
              <input hidden="hidden" name="IdiomaOriginal" value="{$IdiomaOriginal}" />
          <div class="col-xs-12"><strong>Titulo</strong></div>
          <div class="col-xs-12">
            <input class="form-control" name="titulo" value="{$modulo.Moc_Titulo}" />
          </div>
          <div class="col-xs-12 margin-t-10"><strong>Descripcion</strong></div>
          <div class="col-xs-12">
            <textarea class="form-control" name="descripcion">{$modulo.Moc_Descripcion}</textarea>
          </div>
          <div class="col-xs-12 margin-t-10"><strong>Tiempo de Dedicación</strong></div>

          <div class="col-xs-12">
            <input {if $modulo.Idi_IdIdioma != $IdiomaOriginal} disabled="" {/if} class="form-control" name="dedicacion" value="{$modulo.Moc_TiempoDedicacion}" />
          </div>
          </form>
          <div class="col-xs-12 margin-t-10">
            <button id="btn_actualizar_modulo" class="btn btn-success">Actualizar Datos</button>
          </div>
        </div>
      </div>
    </div>

{/if}