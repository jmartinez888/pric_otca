<style>
#raizaMenu{
   padding-top: 10px;
}
@media (min-width: 1200px){
  #raizaMenu {
     margin-left: 8.33333333%;
  }
}
@media(max-width: 991px){
  #raizaMenu-jp ul{
      height: 30px !important;
  }
}
#raizaMenu-jp ul{
   list-style: none;
   width: 100%;
    height: 30px;
      padding: 0px 10px;
}
#raizaMenu-jp li{
   top: 3px;
   margin: 0px 2px;
   float: left;
}
#raizaMenu-jp li .actual{
  color: #444f4a;
}
#raizaMenu-jp a{
   margin: 0px 3px;
   color: #03a506;
}

</style>

<!-- <div id="raizaMenu-jp" clas="col-xs-3 col-sm-3 col-md-2 col-lg-2">
  <ul clas="col-xs-3 col-sm-3 col-md-2 col-lg-2">
    <li>
      <a class="underline" href="{$_layoutParams.root_clear}">{$lenguaje["label_inicio"]} </a>
    </li>
    <li>/</li>
    <li>
      <a class='actual' >{$lenguaje["label_h2_titulo_documentos"]} </a>
    </li>
  </ul>
</div> -->

<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0" style="background-image: url({BASE_URL}modules/dublincore/views/documentos/img/encabezado-repositorio.jpg); background-repeat: no-repeat;">
    <div class="col-md-5 col-lg-5" style="color: #333; font-weight: bold; font-size: 18px;">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
          <center><h1 class="titulo2">{$lenguaje["titulo2"]}</h1></center>
          <div class="col-lg-12 p-rt-lt-0">
            <hr class="cursos-hr2">
          </div>
          <div class="col-lg-12 p-rt-lt-0">
            <p class="descripcion-documentos">{$lenguaje["texto_repositorio"]}</p>
          </div>
          <input id="metodo" name="metodo" type="hidden" value="buscarporpalabras"/>
          <input id="query" name="query" type="hidden"/>
      </div>
    </div>
</div>

<div class="container-fluid">
<!-- <div class="row">
    <div class="col-md-12 col-lg-12">
    <center><h2 class = "Repositorio de Documentos"></h2></center>
    <div class="col-lg-12 p-rt-lt-0">
      <hr class="cursos-hr">
    </div>
    <div class="col-lg-12 p-rt-lt-0">
      <h4 class="descripcion-documentos" style="text-align: justify;">{$lenguaje["texto_repositorio"]}</h4>
    </div>
    <input id="metodo" name="metodo" type="hidden" value="buscarporpalabras"/>
    <input id="query" name="query" type="hidden"/>
    </div>
 </div> -->

<div class="row">


  <div id="resultados" >
     <div class="col-xs-12 col-md-12">
      <div class="">
        <div class="panel-body p-rt-lt-0">
            <div class="row">
              <div class="col-md-12">
                  <div class="row">
                    <div class="col-md-12 col-lg-12" style="padding-top: 10px;">
                      <div class="pull-right">
                        <center><a id="activar_avanzado" onclick="mostrar_seccion()" style="cursor: pointer;"><button class="btn btn-success pull-right"></button>{$lenguaje["activar_busqueda_avanzada"]}</a></center>
                        <center><a id="desactivar_avanzado" onclick="quitar_seccion()" style="cursor: pointer; display: none;"><button class="btn btn-success pull-right">{$lenguaje["desactivar_busqueda_avanzada"]}</button></a></center>
                      </div>
                          <!-- <center>
                            <a class="text-muted" id="busquedaAvanzada" style=""><button class="btn btn-success pull-right">Búsqueda Avanzada</button></a>
                          </center> -->
                      <div class="col-md-5 pull-right">
                          <div class="input-group">
                              <input type ="text" class="form-control"  data-toggle="tooltip" data-original-title="{$lenguaje['title_cuadro_buscar']}" placeholder="{$lenguaje['titulo_resultados_documentos']}" name="palabra" id="palabra" onkeypress="tecla_enter_dublincore(event)" value="{$palabrabuscada|default:''}">
                              <span class="input-group-btn">
                                <button class="btn  btn-success btn-buscador" onclick="buscarPalabraDocumentos('palabra','filtrotemadocumento','filtrotipodocumento','filtroautordocumento','filtroformatodocumento','filtropaisdocumento')" type="button" id="btnEnviar"><i class="glyphicon glyphicon-search"></i></button>
                              </span>
                          </div><!-- /input-group -->
                      </div>

                    {if $_acl->getAutenticado()}
                      {if isset($filtrousuario)}
                      <div class="col-md-3">
                        <button class="btn  btn-success " onclick="buscarPalabraDocumentos('palabra','filtrotemadocumento','filtrotipodocumento','filtroautordocumento','filtroformatodocumento','filtropaisdocumento')" type="button" id="btnMisDoc"><i class="glyphicon glyphicon-list"></i> Todos </button>
                      </div>
                      {else}
                        <div class="col-md-3 p-rt-lt-0">
                          <button data-toggle="tooltip" data-placement="top" title="Solo Mis Documentos"  class="btn  btn-success " onclick="buscarPalabraDocumentos('palabra','filtrotemadocumento','filtrotipodocumento','filtroautordocumento','filtroformatodocumento','filtropaisdocumento',1)" type="button" id="btnMisDoc"><i class="glyphicon glyphicon-user"></i></button>
                        </div>
                      {/if}
                    {/if}
                  </div>
                </div>
              </div>

              <div class="col-md-12 col-lg-12" id="seccion_filtros" style="display: none;">
                <form class="col-md-12 col-lg-12 busqueda-avanzada" style="margin-top: 15px;">
                    <div class="form-horizontal col-sm-offset-1 col-sm-10 col-md-offset-3 col-md-8" id="ba_div" style="padding-top: 30px; text-align: left;">
                        <!-- {if isset($temadocumento) && count($temadocumento)}
                        <div class="form-group">
                            <label class="col-xs-3 control-label">Temática : </label>
                            <div class="col-xs-9">
                                <select class="form-control selectpicker" name="filtrotemadocumento" id="filtrotemadocumento" data-live-search="true">
                                    <option value=""> -- Seleccione Temática --</option>
                                    {foreach item=dt from=$temadocumento}
                                        <option value="{$dt.Ted_Descripcion}">{$dt.Ted_Descripcion}</option>
                                    {/foreach}

                                </select>
                            </div>
                        </div>
                        {/if}  -->
                        {if isset($temadocumento) && count($temadocumento)}
                        <div class="form-group">
                            <label class="col-md-2 control-label-jp">Temática : </label>
                            <div class="col-md-7">
                                <!-- <input class="form-control"  list="tematicas"  id ="ba_tematica" type="text"  name="nombre" value="" placeholder="Temática" /> -->
                                <input type="text" list="temas" class="form-control" id="filtrotemadocumento" name="filtrotemadocumento" placeholder="Temática"/>
                                <datalist id="temas">
                                    {foreach item=dat from=$temadocumento}
                                        <option value="{$dat.Ted_Descripcion}">{$dat.Ted_Descripcion}</option>
                                    {/foreach}
                                </datalist>
                            </div>
                        </div>
                        {/if}
                        {if isset($autores) && count($autores)}
                        <div class="form-group">
                            <label class="col-md-2 control-label-jp" >Autor : </label>
                            <div class="col-md-7">
                                <input type="text" list="autores" class="form-control" id="filtroautordocumento" name="filtroautordocumento" placeholder="Autor"/>
                                <datalist id="autores">
                                    {foreach item=dat from=$autores}
                                        <option value="{$dat.Aut_Nombre}">{$dat.Aut_Nombre}</option>
                                    {/foreach}
                                </datalist>
                                <!-- <select class="form-control selectpicker" name="filtroautordocumento" id="filtroautordocumento" data-live-search="true">
                                    <option value=""> -- Seleccione Autor --</option>
                                    {foreach item=da from=$autores}
                                        <option value="{$da.Aut_Nombre}">{$da.Aut_Nombre}</option>
                                    {/foreach}
                                </select> -->
                            </div>
                        </div>
                        {/if}
                        {if isset($formatos) && count($formatos)}
                        <div class="form-group">
                            <label class="col-md-2 control-label-jp" >Formato : </label>
                            <div class="col-md-7">

                                <select class="form-control selectpicker" name="filtroformatodocumento" id="filtroformatodocumento" data-live-search="true">
                                    <option value=""> -- Seleccione Formato --</option>
                                    {foreach item=df from=$formatos}
                                        <option value="{$df.Taf_Descripcion}">{$df.Taf_Descripcion}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        {/if}
                          <button class="btn btn-primary col-md-offset-3" onclick="buscarPalabraDocumentos('palabra','filtrotemadocumento','filtrotipodocumento','filtroautordocumento','filtroformatodocumento','filtropaisdocumento')" type="button" id="btnEnviar">Realizar Búsqueda Avanzada</button>
                          <br><br>
                    </div>
                </form>
              </div>

              <!-- <div class="col-xs-12 text-center">
                  {foreach item=abc from=LIST_ABC}
                      <div class="abc" letra="{$abc}">
                            <b  id="letra" {if isset($filtroLetra) && $filtroLetra == $abc} class="active" {/if}> {$abc} </b>
                      </div>
                  {/foreach}
              </div>

              <div class="col-md-12 text-center">
                {if isset($paises) && count($paises)}
                    {foreach item=datos from=$paises}
                        <div {if isset($filtroPais) && $datos.Pai_Nombre == $filtroPais}
                         style="margin-top:17px;display:inline-block;vertical-align:top;text-align:center; background: #40bc4bad;"
                         {else}
                          style="margin-top:17px;display:inline-block;vertical-align:top;text-align:center;"
                         {/if}
                           >
                            <img class="pais " data-toggle="tooltip" data-original-title="{$lenguaje['title_paises_buscar']}" style="cursor:pointer;width:40px" src="{$_layoutParams.root_clear}public/img/legal/{$datos.Pai_Nombre}.png" pais="{$datos.Pai_Nombre}" />
                            <br>
                            <b>{$datos.Pai_Nombre}</b>
                            <p style="font-size:.8em">({$datos.cantidad|default:0})</p>
                        </div>
                    {/foreach}
               {else}
                    <p><strong>{$lenguaje["sin_resultados"]}</strong></p>
               {/if}
              </div> -->

              <!-- <div class="col-md-6 col-md-offset-3 div-filtro text-center">
                {if isset($filtroTema) OR isset($filtroTipo) OR isset($filtroAutor) OR isset($filtroFormato) OR isset($filtroPais) OR isset($filtroLetra) OR isset($filtrousuario)}
                  <strong> Filtro:</strong>
                {/if}
                {if isset($filtrousuario)}
                <input type="hidden" id= "filtrousuariodocumento" value="{$filtrousuario}">
                <a class="badge badge-dark" href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/all/{$filtroTipo|default:'all'}/{$filtroAutor|default:'all'}/{$filtroFormato|default:'all'}/{$filtroPais|default:'all'}/all">
                 Usuario: {$usuario}  <i class="fa fa-times"></i>
                </a>
                {/if}

                {if isset($filtroTema)}
                <input type="hidden" id= "filtrotemadocumento" value="{$filtroTema}">
                <a class="badge badge-dark" href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/all/{$filtroTipo|default:'all'}/{$filtroAutor|default:'all'}/{$filtroFormato|default:'all'}/{$filtroPais|default:'all'}/{$filtrousuario|default:'all'}">
                 Tema: {$filtroTema}  <i class="fa fa-times"></i>
                </a>
                {/if}
                {if isset($filtroTipo)}
                <input type="hidden" id= "filtrotipodocumento" value="{$filtroTipo}">
                <a class="badge badge-dark" href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/{$filtroTema|default:'all'}/all/{$filtroAutor|default:'all'}/{$filtroFormato|default:'all'}/{$filtroPais|default:'all'}/{$filtrousuario|default:'all'}">
                 Tipo: {$filtroTipo} <i class="fa fa-times"></i>
                </a>
                {/if}
                {if isset($filtroAutor)}
                <input type="hidden" id= "filtroautordocumento" value="{$filtroAutor}">
                <a class="badge badge-dark" href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/{$filtroTema|default:'all'}/{$filtroTipo|default:'all'}/all/{$filtroFormato|default:'all'}/{$filtroPais|default:'all'}/{$filtrousuario|default:'all'}">
                 Autor: {$filtroAutor} <i class="fa fa-times"></i>
                </a>
                {/if}
                {if isset($filtroFormato)}
                <input type="hidden" id= "filtroformatodocumento" value="{$filtroFormato}">
                <a class="badge badge-dark" href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/{$filtroTema|default:'all'}/{$filtroTipo|default:'all'}/{$filtroAutor|default:'all'}/all/{$filtroPais|default:'all'}/{$filtrousuario|default:'all'}">
                 Formato: {$filtroFormato} <i class="fa fa-times"></i>
                </a>
                {/if}
                {if isset($filtroPais)}
                <input type="hidden" id= "filtropaisdocumento" value="{$filtroPais}">
                <a class="badge badge-dark " href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/{$filtroTema|default:'all'}/{$filtroTipo|default:'all'}/{$filtroAutor|default:'all'}/{$filtroFormato|default:'all'}/all/{$filtrousuario|default:'all'}">
                 País: {$filtroPais} <i class="fa fa-times"></i>
                </a>
                {/if}
                {if isset($filtroLetra)}
                <input type="hidden" id= "filtroletradocumento" value="{$filtroLetra}">
                <a class="badge badge-dark " href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/{$filtroTema|default:'all'}/{$filtroTipo|default:'all'}/{$filtroAutor|default:'all'}/{$filtroFormato|default:'all'}/{$filtroPais|default:'all'}/{$filtrousuario|default:'all'}/all">
                 País: {$filtroLetra} <i class="fa fa-times"></i>
                </a>
                {/if}
                {if isset($filtroTema) OR isset($filtroTipo) OR isset($filtroAutor) OR isset($filtroFormato) OR isset($filtroPais) OR isset($filtroLetra)}
                  <a class="badge badge-dark" data-toggle="tooltip" data-placement="top" title="Quitar todos los filtros" style="background: #bd0000b5" href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/all/all/all/all/all/all">
                   Quitar Filtros <i class="fa fa-times"></i>
                   </a>
                {/if}
              </div> -->
              {if $totaldocumentos[0] > 0 }
               <div class="col-md-12">
                  <div class="row">
                    <div class="col-md-6">
                      <h3>{$lenguaje["total_resultados_documentos"]}: {$totaldocumentos[0]}</h3>
                    </div>
                    <div class="col-md-6">
                      {if isset($resultPalabra) }
                        <b>Resultado de búsqueda</b>
                      {$resultPalabra}{/if}
                    </div>
                    <div class="col-lg-12">
                      <hr class="cursos-hr">
                    </div>
                  </div>
               </div>
               {/if}

                <div class="col-md-12 col-lg-12">
                <div class="col-xs-12 col-sm-4 col-md-3 col-lg-3 resumen-home">
                  <div class="">
                    <div class="cabecera-resumenes">
                        <h4 class="panel-title">
                        <strong>{$lenguaje["menu_izquierdo1_documentos"]}
                          {if isset($temadocumento) && count($temadocumento)}
                              <span class="badge badge-dark pull-right">{count($temadocumento)|default:0}</span>
                          {/if}
                        </strong>
                       </h4>
                    </div>
                    <div id="accordionOne" class="panel-collapse col-md-12 p-rt-lt-0">
                      <ul id="tematicas" class="list-group scroll"   style="height: 400px;overflow-y: auto;">
                          {if isset($temadocumento) && count($temadocumento)}
                            {foreach item=datos from = $temadocumento}
                              <li class="list-group-item-jp col-md-12 p-rt-lt-0 padding-li">
                                <div class="col-md-9 col-lg-9 p-rt-lt-0">
                                  <a href="#{$datos.Ted_Descripcion}" style="cursor:pointer"><span class="temadocumento subtitle-resumen" id="temadocumento">{$datos.Ted_Descripcion}</span></a>
                                </div>
                                <div class="col-md-3 col-lg-3 p-rt-lt-0" style="position: absolute; top: 30%; right: 5%;">
                                  <span class="badge pull-right">{$datos.cantidad|default:0}</span>
                                </div>
                              </li>
                            {/foreach}
                            {/if}
                      </ul>
                    </div>
                  </div>
                </div>

                <div class="col-xs-12 col-sm-4 col-md-3 col-lg-3 resumen-home">
                  <div class="">
                    <div class="cabecera-resumenes">
                        <h4 class="panel-title">
                         <strong>{$lenguaje["menu_izquierdo2_documentos"]}</strong>
                         {if isset($tipodocumento) && count($tipodocumento)}
                            <span class="badge badge-dark pull-right">{count($tipodocumento)|default:0}</span>
                          {/if}
                       </h4>
                     </div>
                    <div id="accordionOne2" class="panel-collapse col-md-12 p-rt-lt-0" >
                      <ul id="tipodocumento" class="list-group scroll"   style="height: 400px;overflow-y: auto;">
                       {if isset($tipodocumento) && count($tipodocumento)}
                        {foreach item=datos from = $tipodocumento}
                            <li class="list-group-item-jp col-md-12 p-rt-lt-0 padding-li">
                                <div class="col-md-9 col-lg-9 p-rt-lt-0">
                                  <a href="#{$datos.Tid_Descripcion}" style="cursor:pointer"><span class="palabraclave subtitle-resumen" id="palabraclave">{$datos.Tid_Descripcion}</span></a>
                                </div>
                                <div class="col-md-3 col-lg-3 p-rt-lt-0" style="position: absolute; top: 30%; right: 5%;">
                                  <span class="badge pull-right">{$datos.cantidad|default:0}</span>
                                </div>
                            </li>
                            {/foreach}
                            {/if}
                      </ul>
                    </div>
                  </div>
                </div>
                <div class="col-xs-12 col-sm-4 col-md-3 col-lg-3 resumen-home">
                  <!-- Filtro Autor -->
                  <div class="">
                    <div class="cabecera-resumenes">
                        <h4 class="panel-title">
                         <strong>{$lenguaje["autores_metadata_documentos"]}</strong>
                         {if isset($autores) && count($autores)}
                            <span class="badge badge-dark pull-right">{count($autores)|default:0}</span>
                          {/if}
                       </h4>
                     </div>
                    <div id="accordionAutor" class="panel-collapse col-md-12 p-rt-lt-0" >
                      <ul id="autor" class="list-group scroll"   style="height: 400px;overflow-y: auto;">
                         {if isset($autores) && count($autores)}
                          {foreach item=a from = $autores}
                          <li class="list-group-item-jp col-md-12 p-rt-lt-0 padding-li">
                              <div class="col-md-9 col-lg-9 p-rt-lt-0">
                                <a href="#{$a.Aut_Nombre}" style="cursor:pointer"><span class="autordocumento subtitle-resumen" id="autorDocumento">{$a.Aut_Nombre}</span></a>
                              </div>
                              <div class="col-md-3 col-lg-3 p-rt-lt-0" style="position: absolute; top: 30%; right: 5%;">
                                <span class="badge pull-right">{$a.cantidad|default:0}</span>
                              </div>
                            </li>
                          {/foreach}
                          {/if}
                      </ul>
                    </div>
                  </div>
                </div>
                <div class="col-xs-12 col-sm-4 col-md-3 col-lg-3 resumen-home">
                  <!-- Filtro Formato -->
                  <div class="">
                    <div class="cabecera-resumenes">
                        <h4 class="panel-title">
                          <strong>{$lenguaje["tabla_campo_tipo_documentos"]}</strong>
                          {if isset($formatos) && count($formatos)}
                            <span class="badge badge-dark pull-right">{count($formatos)|default:0}</span>
                          {/if}
                      </h4>
                    </div>
                    <div id="accordionFormato" class="panel-collapse col-md-12 p-rt-lt-0" >
                      <ul id="formato" class="list-group scroll"   style="height: 400px;overflow-y: auto;">
                          {if isset($formatos) && count($formatos)}
                          {foreach item=t from = $formatos}
                          <li class="list-group-item-jp col-md-12 p-rt-lt-0 padding-li">
                            <div class="col-md-9 col-lg-9 p-rt-lt-0">
                              <a href="#{$t.Taf_Descripcion}" style="cursor:pointer"><span class="formatodocumento subtitle-resumen" id="formatoDocumento">{$t.Taf_Descripcion}</span></a>
                            </div>
                            <div class="col-md-3 col-lg-3 p-rt-lt-0" style="position: absolute; top: 30%; right: 5%;">
                              <span class="badge pull-right">{$t.cantidad|default:0}</span>
                            </div>
                          </li>
                          {/foreach}
                          {/if}
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
            <!-- <p>Some default panel content here.</p> -->
        </div>
    <div id="paginar">
        <div class="table-responsive">
          {if isset($documentos) && count($documentos)}
            <table class="table table-hover table-condensed table-filtros">
              <thead class="bg-default">
                <tr><th>#<th class="cabecera"><a href="#" class="small" ><span class="btn btn-xs btn-default glyphicon glyphicon-sort-by-alphabet pull-right"></span> {$lenguaje["tabla_campo_titulo"]}</a><th>{$lenguaje["tabla_campo_descripcion_documentos"]}<th>{$lenguaje["autores_metadata_documentos"]}<th>{$lenguaje["tabla_campo_tipo_documento_documentos"]}<th>{$lenguaje["fechadocumentos_metadata_documentos"]}<th>{$lenguaje["tabla_campo_tipo_documentos"]}<th>
                {$lenguaje["tabla_campo_pais_documentos"]}
                {if $_acl->permiso("editar_documentos")}
                <th style=" text-align: center">Estado</th>
                {/if}
                <th>{$lenguaje["tabla_campo_enlaces_documentos"]}
                <tbody>
                  {foreach item=datos from=$documentos}
                    <tr>
                        <td scope="row">{$numeropagina++}<td>{$datos.Dub_Titulo}<td><div data-toggle="tooltip" data-placement="right" title="{$datos.Dub_Descripcion}">{$datos.Dub_Descripcion|truncate:150:" ..."}</div>
                          <td>{$datos.Aut_Nombre}
                          <td>{$datos.Tid_Descripcion}
                          <td class="text-center">{$datos.Dub_FechaDocumento|default:"-"}
                          <td class="text-center"> <img data-toggle="tooltip" data-placement="top" title="{$datos.Taf_Descripcion}"  src="{$_layoutParams.root_clear}public/img/documentos/{$datos.Taf_Descripcion}.png"/>
                          <td class="text-center">{if isset($datos.Pai_Nombre) && $datos.Pai_Cantidad == 1} <img data-toggle="tooltip" data-placement="top" title="{$datos.Pai_Nombre}" class="pais " style="width:40px" src="{$_layoutParams.root_clear}public/img/legal/{$datos.Pai_Nombre}.png"/> {else} Varios {/if}

                          {if $_acl->permiso("editar_documentos")}
                          <td style=" text-align: center">
                              {if {$datos.Dub_Estado}==0}
                                  <i data-toggle="tooltip" data-placement="top"  class="glyphicon glyphicon-remove-sign" title="Deshabilitado" style="color: #DD4B39;"/>
                              {/if}
                              {if {$datos.Dub_Estado}==1}
                                  <i data-toggle="tooltip" data-placement="top"  class="glyphicon glyphicon-ok-sign" title="Habilitado" style="color: #088A08;"/>
                              {/if}
                              {if {$datos.Dub_Estado}==2}
                                  <i data-toggle="tooltip" data-placement="top"  class="glyphicon glyphicon-info-sign" title="Privado" style="color: #f39c12;"/>
                              {/if}
                          </td>
                          {/if}

                         <td> <a class="btn btn-default btn-sm" data-toggle="tooltip" data-placement="top" href="{$_layoutParams.root_clear}dublincore/documentos/metadata/{$datos.Dub_IdDublinCore}" target="_blank" title="{$lenguaje["tabla_campo_detalle_documentos"]}"><i class="glyphicon glyphicon-list-alt" ></i></a>
                        <a data-toggle="tooltip" data-placement="top" class="btn btn-default btn-sm" href="{$_layoutParams.root_clear}dublincore/documentos/descargar/{$datos.Arf_PosicionFisica}/{$datos.Dub_IdDublinCore}" target="_blank" title="{$lenguaje["icono_descargar_documentos"]}"><i class="glyphicon glyphicon-download-alt" ></i></a>

                        {if $_acl->permiso("editar_todos_los_documentos") || $_acl->Usu_IdUsuario() == $datos.Usu_IdUsuario}
                          {if $_acl->permiso("editar_documentos")}
                              <a data-toggle="tooltip" data-placement="top" type="button" title="{$lenguaje['label_editar_bdrecursos']}" class="btn btn-default btn-sm glyphicon glyphicon-edit" href="{$_layoutParams.root}dublincore/editar/index/{$datos.Dub_IdDublinCore}" target="_blank">
                              </a>
                          {/if}
                          {if $_acl->permiso("cambiar_estado_documentos")}
                              <a data-toggle="tooltip" data-placement="top" class="btn btn-default btn-sm glyphicon glyphicon-refresh ce_dublin" id_dublin="{$datos.Dub_IdDublinCore}" estado_dublin="{if $datos.Dub_Estado==0}1{/if}{if $datos.Dub_Estado==1}2{/if}{if $datos.Dub_Estado==2}0{/if}"  title="{$lenguaje['cambiar_estado_bdrecursos']}" > </a>
                          {/if}
                          {if $_acl->permiso("eliminar_documentos")}
                               <a data-toggle="modal" data-target="#confirm-delete" href="#" type="button" title="{$lenguaje['label_eliminar_bdrecursos']}" data-id='{$datos.Dub_IdDublinCore}' data-nombre="{$datos.Dub_Titulo}" class="btn btn-default btn-sm glyphicon glyphicon-trash" >
                              </a>
                          {/if}
                        {/if}

                  {/foreach}
                </tbody>
            </table>
          {/if}
          {if !empty(count($documentos))}
            {$paginacion|default:""}
          {else}
            {if isset($resumen) && $resumen == 1}
            {else}
              <div class="col-md-offset-2 col-md-8 text-center">
                <label class="glyphicon glyphicon-alert " style="font-size: 60px"></label>
                <h4 >  <b >{$lenguaje["sin_resultados_documentos"]}...!!!</b></h4>
              </div>
            {/if}
          {/if}
         </div>
        </div>
    </div>
	  </div>

  </div>
</div>
</div>




<!--  Modal login -->
<div class="modal fade top-space-0" id="modal-recurso" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg login-dialog">
        <div class="modal-content cursor-pointer" id="mensajeLogeo">
            <!-- <div class="modal-header">
                  <button type="button" class="close" data-dismiss="#modal-1">CLOSE &times;</button>
                <h1 class="modal-title" >{$lenguaje["login_intranet"]}</h1>
            </div> -->

            <div class="modal-body" >
                <div class="row">
                    <div class="col-md-12" id="adjuntarArchivo">
                        <div class="panel panel-login">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <a href="#" class="active" id="agregar-form-link">Agregar Recurso</a>
                                    </div>
                                    <div class="col-xs-6">
                                        <a href="#" id="buscar-form-link">Buscar Recurso</a>
                                    </div>
                                </div>
                                <hr>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <form id="agregar-form" action="#" method="post" role="form" style="display: block;">
                                            <!-- <input type="hidden" name="url" id="url" value="{$url}"> -->
                                            <input type="hidden" name="hd_login_modulo" id="hd_login_modulo" value="">
                                            <div id="registrar_recursos_dublin">
                                                <div id="myTabContent" class="tab-content">
                                                    <div class="tab-pane active in  form-horizontal" id="tabular">
                                                        <form id="form1" method="post" data-toggle="validator" role="form" autocomplete="on">
                                                            <div class="col-md-offset-3 col-md-6">
                                                                <!-- <input type="hidden" id="hd_idrecurso"  name="hd_idrecurso" value="{$recurso.Rec_IdRecurso|default}"/> -->
                                                                <input type="hidden" id="tipoServicio"  name="tipoServicio" value="{$tipoServicio|default:''}"/>

                                                                <div class="form-group" >
                                                                    <input type="hidden" id="hd_idioma_defecto" name="hd_idioma_defecto" value="{$recurso.Idi_IdIdioma|default}">
                                                                    <label class="control-label col-lg-2">{$lenguaje["label_idioma_bdrecursos"]}</label>
                                                                    {if  isset($idiomas) && count($idiomas)}
                                                                        <div class="col-lg-10 form-inline">
                                                                            {foreach from=$idiomas item=idi}
                                                                                <div class="radio">
                                                                                    <label>
                                                                                        <input type="radio" name="rb_idioma" id="rb_idioma" class=" {if isset($recurso)}{$lenguaje["label_idioma-recurso_bdrecursos"]}{/if}" value="{$idi.Idi_IdIdioma}"
                                                                                               {if isset($recurso) && $recurso.Idi_IdIdioma==$idi.Idi_IdIdioma}
                                                                                                   checked="checked"
                                                                                               {elseif !isset($recurso) && isset($idioma) && $idioma==$idi.Idi_IdIdioma}
                                                                                                   checked="checked"
                                                                                                {/if}
                                                                                               required>
                                                                                        {$idi.Idi_Idioma}
                                                                                    </label>
                                                                                </div>
                                                                            {/foreach}
                                                                        </div>
                                                                    {else}
                                                                        <div class="form-inline col-lg-9">
                                                                            <label class="control-label">{$lenguaje["label_idioma-inexistente_bdrecursos"]} </label>
                                                                        </div>
                                                                    {/if}
                                                                </div>
                                                                <div id="index_nuevo_recurso">
                                                                    <div class="form-group">
                                                                        <label class="col-lg-2 control-label" for="tb_nombre_recurso">{$lenguaje["label_nombre_bdrecursos"]}*</label>
                                                                        <div class="col-lg-10">
                                                                            <input type="text" class="form-control" id="tb_nombre_recurso"  name="tb_nombre_recurso"
                                                                                   placeholder="{$lenguaje["label_place_nombre_bdrecursos"]}" value="" required/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label  class="col-lg-2 control-label" for="tb_fuente_recurso">{$lenguaje["label_fuente_bdrecursos"]}*</label>
                                                                        <div class="col-lg-10">
                                                                            <input type="text" list="dl_fuente" class="form-control" id="tb_fuente_recurso"  value="" name="tb_fuente_recurso"
                                                                                   placeholder="{$lenguaje["label_place_fuente_bdrecursos"]}"required/>
                                                                            <datalist id="dl_fuente">
                                                                                {foreach item=datos from=$fuente}
                                                                                    <option value='{$datos.Rec_Fuente}'>
                                                                                    {/foreach}
                                                                            </datalist>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label  class="col-lg-2 control-label" for="tb_origen_recurso">{$lenguaje["label_origen_bdrecursos"]}*</label>
                                                                        <div class="col-lg-10">
                                                                            <input type="text" list="dl_origen" class="form-control" id="tb_origen_recurso" value="" name="tb_origen_recurso"
                                                                                   placeholder="{$lenguaje["label_place_origen_bdrecursos"]}" required/>
                                                                            <datalist id="dl_origen">
                                                                                {foreach item=datos from=$origenrecurso}
                                                                                    <option value='{$datos.Rec_Origen}'> {$datos.Rec_Origen}</option>
                                                                                {/foreach}
                                                                            </datalist>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-lg-2 control-label" for="sl_estandar_recurso">Estandar*</label>
                                                                    <div class="col-lg-10">
                                                                        <input type="hidden" id="sl_estandar_recurso" name="sl_estandar_recurso" value="3">
                                                                        <select class="form-control" disabled="" required="">
                                                                            <option value="">{$lenguaje["label_seleccione_estandar_bdrecursos"]}</option>
                                                                            {foreach item=datosEst from=$estandares}
                                                                                <option value='{$datosEst.Esr_IdEstandarRecurso}' {if $datosEst.Esr_IdEstandarRecurso == 3}selected{/if}> {$datosEst.Esr_Nombre}</option>
                                                                            {/foreach}
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="col-lg-offset-2 col-lg-10">
                                                                        <input type="hidden" id="hd_tipo_recurso" name="hd_tipo_recurso" value="1">
                                                                        <button type="button"  class="btn btn-success" id="bt_registrar" name="bt_registrar"><i class="glyphicon glyphicon-floppy-disk"> </i> {$lenguaje["boton_guardar_bdrecursos"]}</button>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- <div class="form-group text-center">
                                                <input type="checkbox" tabindex="3" class="" name="remember" id="remember">
                                                <label for="remember"> Recordarme</label>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-sm-6 col-sm-offset-3">
                                                        <button type="button" name="logear" id="logear" tabindex="4" class="form-control btn btn-login" >{$lenguaje["text_iniciarsession"]}</button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="text-center">
                                                            <a href="#" tabindex="5" class="forgot-password">¿Has olvidado tu contraseña?</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> -->
                                        </form>
                                        <form id="buscar-form" action="" style="display: none;">

                                            <div id="lista_recursos_dublin">
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <a href="#" class="btn btn-default" data-dismiss="modal">Cerrar</a>
            </div>
        </div>
    </div>
</div>
<!--  Modal end -->
