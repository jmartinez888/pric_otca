{if isset($curso) && count($curso)}
    {if  isset($idiomas) && count($idiomas)}
      <div class="col-lg-12">
          <ul class="nav nav-tabs ">
            {foreach from=$idiomas item=idi}
                <li role="presentation_idioma" class="{if $curso.Idi_IdIdioma==$idi.Idi_IdIdioma} active {/if}">
                    <a class="idioma_s" id="idioma_{$idi.Idi_IdIdioma}" href="#">{$idi.Idi_Idioma}</a>
                    <input type="hidden" id="hd_idioma_{$idi.Idi_IdIdioma}" value="{$idi.Idi_IdIdioma}" />
                    <input type="hidden" id="idiomaTradu" value="{$curso.Idi_IdIdioma}"/>
                </li>    
            {/foreach}
          </ul>
      </div>        
    {/if}

    <div class="col-lg-12" style="padding-top: 15px;">
      <ul class="nav nav-tabs">
        <li role="presentation" class="active" id="item_presentacion"><a>PRESENTACIÓN</a></li>
        <li role="presentation" id="item_contenido" ><a>CONTENIDO</a></li>
        <li role="presentation" id="item_parametros" ><a>PARAMETROS</a></li>
      </ul>
    </div>

    <!-- PRESENTACION -->
    <div {if isset($actives) && $actives == "pre" } class="col-lg-12  div_presentacion display-block" {else} class="col-lg-12  div_presentacion" {/if} >
      <div class="panel panel-default" style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">

        <div class="panel-body form-horizontal"  id="panelImg">

          <div class="form-group">
              <label class="col-md-3 control-label"> {$lang->get('elearning_gcurso_imagen_icono')} : </label>
              <div class="col-md-6">
                  {if strlen($curso.Cur_UrlBanner)>0 && $curso.Cur_UrlBanner != "default.jpg"}
                      <img class="img-banner w-100" id="img_banner_new" src="{BASE_URL}files/elearning/cursos/img/portada/{$curso.Cur_UrlBanner}" />
                  {else}
                    <b class="col-xs-12 text-center">Imagen Default</b>
                      <img class="img-banner w-100" style="opacity: 0.6" src="{BASE_URL}files/elearning/cursos/img/portada/default.jpg" />
                  {/if}
              </div>
              <div class=" col-md-2">
                <button id="btn-subir-imagen" class="btn btn-info btn-sm">Seleccionar Imagen</button>
              </div>
          </div>

          <!-- Jhon Martinez -->
          <!-- <div class="form-group">
              <label for="exampleInputFile" class="col-md-4 control-label"> Video Presentación </label>
              <div class="col-md-6">
                  <input class="btn btn-success btn-sm" type="file" id="Arf_IdArchivoFisico" name="Arf_IdArchivoFisico">
              </div>
          </div> -->
          <div class="form-group">
              <label class="col-md-3 control-label"> {$lang->get('elearning_gcurso_video_presenta')} : </label>
              <div class="col-md-6">
                {if strlen($curso.Cur_UrlVideoPresentacion)>0}
                  <input name="Cur_UrlVideoPresentacion" id="Cur_UrlVideoPresentacion" class="form-control" value="https://www.youtube.com/watch?v={$curso.Cur_UrlVideoPresentacion}" />
                {else}
                  <input name="Cur_UrlVideoPresentacion" id="Cur_UrlVideoPresentacion" class="form-control" value="" placeholder="Video de Presentación de Curso" />
                {/if}
              </div>
              <div class=" col-md-2">
                  <button id="btn-guardarVideo" class=" form-control btn btn-success btn-sm"> <i class="glyphicon glyphicon-floppy-disk"></i> Guardar</button>
              </div>
          </div>
          <div class="form-group">
              {if strlen($curso.Cur_UrlVideoPresentacion)>0}
                  <div class="col-md-offset-3 col-md-6 " id="div_video" style="padding: 5px; border: 2px solid #00a65a;">
                      <object width="100%" height="344">
                        <param name="movie" id="video_curso_param"  value="http://www.youtube.com/v/{$curso.Cur_UrlVideoPresentacion}"></param>
                        <param name="allowFullScreen" value="true"></param>
                        <param name="allowscriptaccess" value="always"></param>
                        <embed id="video_curso_embed" src="http://www.youtube.com/v/{$curso.Cur_UrlVideoPresentacion}" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="100%" height="344"></embed>
                      </object>
                  </div>
              {else}
                  <div class="col-md-offset-3 col-md-6 hidden" id="div_video" style="padding: 5px; border: 2px solid #00a65a;">
                      <object width="100%" height="344">
                        <param name="movie" id="video_curso_param" value=""></param>
                        <param name="allowFullScreen" value="true"></param>
                        <param name="allowscriptaccess" value="always"></param>
                        <embed id="video_curso_embed" src="" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="100%" height="344"></embed>
                      </object>
                  </div>
              {/if}
          </div>

          <!-- <div class="col-lg-12 hidden">
              <object width="425" height="344">
                <param name="movie" value="http://www.youtube.com/v/s-fjg7Stgb4&hl=es&fs=1&"></param>
                <param name="allowFullScreen" value="true"></param>
                <param name="allowscriptaccess" value="always"></param>
                <embed src="http://www.youtube.com/v/s-fjg7Stgb4&hl=es&fs=1&" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="344"></embed>
              </object>
          </div> -->

        </div>
      </div>
    </div>

    {include file='modules/elearning/views/uploader/uploader.tpl'}

    <!-- CONTENIDO -->
    <div {if isset($actives) && $actives == "con" } class="col-lg-12  div_contenido display-block" {else} class="col-lg-12  div_contenido" {/if}  >
      <div class="panel panel-default" style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">

        <div class="panel-body"  id="panelDetalle">
          <form method="post" action="gcurso/_modificar_curso" id="frm_registro">
            <input type="hidden" name="IdiomaOriginal" id="_IdiomaOriginal" value="{$IdiomaOriginal}"/>
            <input type="hidden" name="idiomaTradu" value="{$curso.Idi_IdIdioma}"/>
            <input type="hidden" id="hidden_curso_" name="id" value="{$curso.Cur_IdCurso}"/>
            <div class="col-lg-12"><h5><strong>Título del Curso</strong></h5></div>
            <div class="col-lg-12">
              <input name="titulo" id="inTitulo" class="form-control" value="{$curso.Cur_Titulo}"/>
            </div>
            <div class="col-lg-12"><h5><strong>Descripción del Curso</strong></h5></div>
            <div class="col-lg-12">
              <textarea class="form-control" id="inDescripcion" name="descripcion" rows="10">{$curso.Cur_Descripcion}</textarea>
            </div>
            <div class="col-lg-12 margin-top-10">
              <strong></strong>
            </div>
            <div class="col-lg-12"><h5><strong>Objetivo General del Curso</strong></h5></div>
            <div class="col-lg-12"><textarea class="form-control" id="inObjetivo" name="objgeneral" >{$curso.Cur_ObjetivoGeneral}</textarea></div>
            <div class="col-lg-12 margin-top-10"><h5><strong>Objetivos Específicos</strong></h5></div>
            <div id="divObjetivosEspecificos"></div>
            <div class="col-xs-3">
              <input class="estado" id="toggle_NuevoObjetivo" value="0" />
              <button id="btnNuevoObjetivo" class="col-xs-12 btn btn-sm btn-warning" >Agregar objetivo</button>
            </div>
            <div class="col-lg-12 margin-top-10"><h5><strong>Público Objetivo</strong></h5></div>
            <div class="col-lg-12"><textarea class="form-control" id="inPublico" name="publico" >{$curso.Cur_PublicoObjetivo}</textarea></div>
            <div class="col-lg-12 margin-top-10"><h5><strong>N° Vacantes</strong></h5></div>
            <div class="col-lg-12"><input type="number" {if $curso.Idi_IdIdioma != $IdiomaOriginal} disabled="" {/if} class="form-control" id="inVacantes" name="vacantes" value="{$curso.Cur_Vacantes}"/></div>
            <div class="col-lg-12 margin-top-10"><h5><strong>Contacto</strong></h5></div>
            <div class="col-lg-12"><textarea class="form-control" id="inContacto" name="contacto" > {$curso.Cur_Contacto}</textarea> </div>
            <div class="col-lg-12"><h5><strong>Requisitos Sotftware</strong></h5></div>
            <div class="col-lg-12"><textarea class="form-control" id="inSoftware" name="software" >{$curso.Cur_ReqSoftware}</textarea></div>
            <div class="col-lg-12"><h5><strong>Requisitos Hardware</strong></h5></div>
            <div class="col-lg-12"><textarea class="form-control" id="inHardware" name="hardware" >{$curso.Cur_ReqHardware}</textarea></div>
            <div class="col-lg-12"><h5><strong>Metodología</strong></h5></div>
            <div class="col-lg-12"><textarea class="form-control" id="inMetodologia" name="metodologia" >{$curso.Cur_Metodologia}</textarea></div>
            <div id="divDetallesCursos"></div>
            <div class="col-xs-3">
              <input class="estado" id="toggle_NuevoDetalle" value="0" />
              <button id="btnNuevoDetalle" class="col-xs-12 btn btn-sm btn-warning" >Agregar información</button>
            </div>
            <div class="col-lg-12 margin-top-10" >
              <button class="btn btn-success" style=" float: right" type="button" id="btn_registrar">
                <i class="glyphicon glyphicon-book"></i> Actualizar Información
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- PARAMETROS -->
    <div {if isset($actives) && $actives == "par" } class="col-lg-12  div_parametros display-block" {else} class="col-lg-12  div_parametros" {/if}  >
      <div class="panel panel-default" style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">

        <div class="panel-body" id="panelParametros">
          <div class="col-lg-6">
            <label>Nota Minima</label>
            <input {if $curso.Idi_IdIdioma != $IdiomaOriginal} disabled="" {/if} class="form-control" id="inParMinNota" type="number"  min="0" value="{$parametros['Par_NotaMinima']}"/>
          </div>
          <div class="col-lg-6">
            <label>Nota Máxima</label>
            <input {if $curso.Idi_IdIdioma != $IdiomaOriginal} disabled="" {/if} class="form-control" id="inParMaxNota" type="number"  min="0" value="{$parametros['Par_NotaMaxima']}"/>
          </div>
          <div class="col-lg-12" style="margin-top: 10px">
            <button {if $curso.Idi_IdIdioma != $IdiomaOriginal} disabled="" {/if} class="btn btn-success pull-right" id="btnParams"> Registrar Datos</button>
          </div>
        </div>
      </div>
    </div>
{else}
<p>No hay datos</p>
{/if}
