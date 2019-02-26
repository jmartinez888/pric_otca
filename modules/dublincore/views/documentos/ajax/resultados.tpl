<div class="col-xs-12 col-sm-8 col-md-offset-0 col-md-9 col-lg-offset-0 col-lg-9" style="margin-bottom: 15px;">
      
        <div class="">
            <div class="row">
                <div class="col-md-12">
                  <div class="row">
                    <div class="col-md-6 col-md-offset-3">
                      <div class="input-group">
                        <input type ="text" class="form-control"  data-toggle="tooltip" data-original-title="{$lenguaje['title_cuadro_buscar']}" placeholder="{$lenguaje['titulo_resultados_documentos']}" name="palabra" id="palabra" onkeypress="tecla_enter_dublincore(event)" value="{$palabrabuscada|default:''}">                  
                        <span class="input-group-btn">
                        <button class="btn  btn-success btn-buscador" onclick="buscarPalabraDocumentos('palabra','filtrotemadocumento','filtrotipodocumento','filtroautordocumento','filtroformatodocumento','filtropaisdocumento')" type="button" id="btnEnviar"><i class="glyphicon glyphicon-search"></i></button>
                        </span>
                      </div><!-- /input-group -->
                    </div>

                    {if $_acl->getAutenticado()}
                      {if isset($filtrousuario)}
                      <div class="col-md-3 ">
                        <button class="btn  btn-success " onclick="buscarPalabraDocumentos('palabra','filtrotemadocumento','filtrotipodocumento','filtroautordocumento','filtroformatodocumento','filtropaisdocumento')" type="button" id="btnMisDoc"><i class="glyphicon glyphicon-list"></i> Todos </button>
                      </div>
                      {else}
                        <div class="col-md-3 ">
                          <button data-toggle="tooltip" data-placement="top" title="Solo Mis Documentos"  class="btn  btn-success " onclick="buscarPalabraDocumentos('palabra','filtrotemadocumento','filtrotipodocumento','filtroautordocumento','filtroformatodocumento','filtropaisdocumento',1)" type="button" id="btnMisDoc"><i class="glyphicon glyphicon-user"></i></button>
                        </div>
                      {/if}
                    {/if}
                  </div>
                </div>

                <div class="col-md-12 col-lg-12">
                  <div class="col-xs-12 col-md-12 col-lg-12 text-center letras">
                      {foreach item=abc from=LIST_ABC}
                          <div class="abc" letra="{$abc}">
                              <b  id="letra" {if isset($filtroLetra) && $filtroLetra == $abc} class="active" {/if}> {$abc} </b>
                          </div>
                      {/foreach}
                  </div>
                </div>

                <div class="col-md-12 text-center">
                  {if isset($paises) && count($paises)}
                      {foreach item=datos from=$paises}
                          <div {if isset($filtroPais) && $datos.Pai_Nombre == $filtroPais}
                           class="instituciones-paises-color" 
                           {else}
                            class="instituciones-paises" 
                           {/if}
                             >
                              <img class="pais " data-toggle="tooltip" data-original-title="{$lenguaje['title_paises_buscar']}" style="cursor:pointer;width:40px" src="{$_layoutParams.root_clear}public/img/legal/{$datos.Pai_Nombre}.png" pais="{$datos.Pai_Nombre}" />
                              <br>
                              <b>{$datos.Pai_Nombre}</b>
                              <br>
                              {if isset($filtroPais) && $datos.Pai_Nombre == $filtroPais}
                              <span class="badge-jp" style="font-size:.8em">{$datos.cantidad|default:0}</span>
                              {else}
                              <span class="badge-pais" style="font-size:.8em">{$datos.cantidad|default:0}</span>
                              {/if}
                          </div>
                      {/foreach}
                  {else}
                      <p><strong>{$lenguaje["sin_resultados"]}</strong></p>
                  {/if}             
                </div>

                <div class="col-md-6 col-md-offset-3 div-filtro text-center">
                  {if isset($filtroTema) OR isset($filtroTipo) OR isset($filtroAutor) OR isset($filtroFormato) OR isset($filtroPais) OR isset($filtroLetra) OR isset($filtrousuario)}
                    <strong> Filtro:</strong> 
                    {if isset($filtrousuario)}
                      <input type="hidden" id= "filtrousuariodocumento" value="{$filtrousuario}">
                      <a class="badge" style="margin: 3px !important;" href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/all/{$filtroTipo|default:'all'}/{$filtroAutor|default:'all'}/{$filtroFormato|default:'all'}/{$filtroPais|default:'all'}/all">
                       Usuario: {$usuario}  <i class="fa fa-times"></i> 
                      </a>
                    {/if}
                    {if isset($filtroTema)}
                      <input type="hidden" id= "filtrotemadocumento" value="{$filtroTema}">
                      <a class="badge" style="margin: 3px !important;" href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/all/{$filtroTipo|default:'all'}/{$filtroAutor|default:'all'}/{$filtroFormato|default:'all'}/{$filtroPais|default:'all'}/{$filtrousuario|default:'all'}">
                       Tema: {$filtroTema}  <i class="fa fa-times"></i> 
                      </a>
                    {/if}
                    {if isset($filtroTipo)}
                      <input type="hidden" id= "filtrotipodocumento" value="{$filtroTipo}">
                      <a class="badge" style="margin: 3px !important;" href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/{$filtroTema|default:'all'}/all/{$filtroAutor|default:'all'}/{$filtroFormato|default:'all'}/{$filtroPais|default:'all'}/{$filtrousuario|default:'all'}">
                       Tipo: {$filtroTipo} <i class="fa fa-times"></i>               
                      </a>
                    {/if}
                    {if isset($filtroAutor)}
                      <input type="hidden" id= "filtroautordocumento" value="{$filtroAutor}">
                      <a class="badge" style="margin: 3px !important;" href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/{$filtroTema|default:'all'}/{$filtroTipo|default:'all'}/all/{$filtroFormato|default:'all'}/{$filtroPais|default:'all'}/{$filtrousuario|default:'all'}">
                       Autor: {$filtroAutor} <i class="fa fa-times"></i>               
                      </a>
                    {/if}
                    {if isset($filtroFormato)}
                      <input type="hidden" id= "filtroformatodocumento" value="{$filtroFormato}">
                      <a class="badge" style="margin: 3px !important;" href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/{$filtroTema|default:'all'}/{$filtroTipo|default:'all'}/{$filtroAutor|default:'all'}/all/{$filtroPais|default:'all'}/{$filtrousuario|default:'all'}">
                       Formato: {$filtroFormato} <i class="fa fa-times"></i>               
                      </a>
                    {/if}
                    {if isset($filtroPais)}
                      <input type="hidden" id= "filtropaisdocumento" value="{$filtroPais}">
                      <a class="badge" style="margin: 3px !important;" href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/{$filtroTema|default:'all'}/{$filtroTipo|default:'all'}/{$filtroAutor|default:'all'}/{$filtroFormato|default:'all'}/all/{$filtrousuario|default:'all'}">
                       País: {$filtroPais} <i class="fa fa-times"></i>               
                      </a>
                    {/if}
                    {if isset($filtroLetra)}
                      <input type="hidden" id= "filtroletradocumento" value="{$filtroLetra}">
                      <a class="badge" style="margin: 3px !important;" href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/{$filtroTema|default:'all'}/{$filtroTipo|default:'all'}/{$filtroAutor|default:'all'}/{$filtroFormato|default:'all'}/{$filtroPais|default:'all'}/{$filtrousuario|default:'all'}/all">
                       País: {$filtroLetra} <i class="fa fa-times"></i>               
                      </a>
                    {/if}
                  {/if}
                  {if isset($filtroTema) OR isset($filtroTipo) OR isset($filtroAutor) OR isset($filtroFormato) OR isset($filtroPais) OR isset($filtroLetra)}
                    <a class="badge" style="margin: 3px !important;" data-toggle="tooltip" data-placement="top" title="Quitar todos los filtros" style="background: #bd0000b5" href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/{$palabrabuscada|default:'all'}/all/all/all/all/all/all">
                     Quitar Filtros <i class="fa fa-times"></i>
                     </a>
                  {/if}
                </div>

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
            </div>
            <!-- <p>Some default panel content here.</p> -->
        </div>

        <div class="" id="paginar" style="float: inherit;">
          <div class="table-responsive ">
            {if isset($documentos) && count($documentos)}
              <table class="table table-hover table-condensed table-filtros">
                <thead class="bg-default">
                  <tr><th>#<th class="cabecera">{$lenguaje["tabla_campo_titulo"]}<th>{$lenguaje["tabla_campo_descripcion_documentos"]}<th>{$lenguaje["autores_metadata_documentos"]}<th>{$lenguaje["tabla_campo_tipo_documento_documentos"]}<th>{$lenguaje["fechadocumentos_metadata_documentos"]}<th>{$lenguaje["tabla_campo_tipo_documentos"]}<th>
                  {$lenguaje["tabla_campo_pais_documentos"]}
                  {if $_acl->permiso("editar_documentos") && $_acl->getAutenticado()}
                  <th style=" text-align: center">Estado</th>
                  <th>{$lenguaje["tabla_campo_enlaces_documentos"]}
                  {/if}
                <tbody>
                  {foreach item=datos from=$documentos}
                    <tr {if $datos.Row_Estado==0}
                            {if $_acl->permiso("ver_eliminados")}
                                class="bg-red" title="Documento Desahabilitado"
                            {else}
                                hidden {$numeropagina=$numeropagina-1}
                            {/if}
                        {/if} >
                      <td scope="row">{$numeropagina++}<td class=" text-left"><a class="text-primary text-bold link" data-toggle="tooltip" data-placement="top" href="{$_layoutParams.root_clear}dublincore/documentos/metadata/{$datos.Dub_IdDublinCore}" target="_blank" title="{$lenguaje['tabla_campo_detalle_documentos']}">{$datos.Dub_Titulo}</a><td><div data-toggle="tooltip" data-placement="right" title="{$datos.Dub_Descripcion}">{$datos.Dub_Descripcion|truncate:150:" ..."}</div>
                      <td><a class="text-primary text-bold link" data-toggle="tooltip" data-placement="top" href="{$_layoutParams.root_clear}dublincore/documentos/busqueda/all/all/all/{$datos.Aut_Nombre}/all/all/all" title="Ver solo {$datos.Aut_Nombre}">{$datos.Aut_Nombre}</a>
                      <td>{$datos.Tid_Descripcion}
                      <td class="text-center">{$datos.Dub_FechaDocumento|default:"-"}
                      <td class="text-center"> <a data-toggle="tooltip" data-placement="top" href="{$_layoutParams.root_clear}dublincore/documentos/descargar/{$datos.Arf_PosicionFisica}/{$datos.Dub_IdDublinCore}" target="_blank" title="{$lenguaje['icono_descargar_documentos']}"><img src="{$_layoutParams.root_clear}public/img/documentos/{$datos.Taf_Descripcion}.png"/></a>
                      <td class="text-center">{if isset($datos.Pai_Nombre) && $datos.Pai_Cantidad == 1} <img data-toggle="tooltip" data-placement="top" title="{$datos.Pai_Nombre}" class="pais " pais="{$datos.Pai_Nombre}" style="width:40px" src="{$_layoutParams.root_clear}public/img/legal/{$datos.Pai_Nombre}.png"/> {else} Varios {/if}

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

                      <td> 
                        {if $_acl->permiso("editar_todos_los_documentos") || $_acl->Usu_IdUsuario() == $datos.Usu_IdUsuario}
                          {if $_acl->permiso("editar_documentos")}
                              <a data-toggle="tooltip" data-placement="top" type="button" title="{$lenguaje['label_editar_bdrecursos']}" class="btn btn-primary btn-sm glyphicon glyphicon-edit" href="{$_layoutParams.root}dublincore/editar/index/{$datos.Dub_IdDublinCore}" target="_blank" style="margin: 3px;">
                              </a>
                          {/if}
                          {if $_acl->permiso("cambiar_estado_documentos")}
                              <a data-toggle="tooltip" data-placement="top" class="btn btn-warning btn-sm glyphicon glyphicon-refresh ce_dublin" id_dublin="{$datos.Dub_IdDublinCore}" estado_dublin="{if $datos.Dub_Estado==0}1{/if}{if $datos.Dub_Estado==1}2{/if}{if $datos.Dub_Estado==2}0{/if}"  title="{$lenguaje['cambiar_estado_bdrecursos']}" style="margin: 3px;"> </a>
                          {/if}
                          {if $_acl->permiso("eliminar_documentos")}
                              <a  
                                {if $datos.Row_Estado==0}
                                    data-toggle="tooltip" 
                                    class="btn btn-success btn-sm glyphicon glyphicon-ok confirmar-habilitar-dublin" title="{$lenguaje.label_habilitar}" 
                                {else}
                                    data-book-id="{$datos.Dub_Titulo}"
                                    data-toggle="modal"  data-target="#confirm-delete"
                                    class="btn btn-danger btn-sm glyphicon glyphicon-trash confirmar-eliminar-dublin" title="{$lenguaje['label_eliminar_bdrecursos']}"
                                {/if} 
                                id_dublin="{$datos.Dub_IdDublinCore}" data-placement="bottom" style="margin: 3px;"> </a>
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