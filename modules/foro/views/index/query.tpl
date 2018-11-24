<div  class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px;">
        <div class="col col-xs-11 col-sm-11 col-md-11 col-lg-11">
            <h2 class="titulo">Consultas</h2>
        </div>
        
        <div class="col col-xs-1 col-sm-1 col-md-1 col-lg-1   pull-right text-right titulo">
            <button  title="Opciones" id="btn-configuracion" class="btn btn-primary btn-circle dropdown-toggle btn-configuracion" data-toggle="dropdown" type="button"><i class="glyphicon glyphicon-cog"></i>
            </button>
            <ul class="dropdown-menu" style="min-width: 200px;">
                {if $_acl->permiso("agregar_query")}
                <li><a href="{$_layoutParams.root}foro/admin/form/new/query" class="opciones_foro" style="cursor: pointer;">Nueva Consulta<i class="i_opciones_foro glyphicon glyphicon-plus pull-right"></i></a></li>
                {/if}
                <li><a href="#" id_foro="{$foro.For_IdForo}" class="opciones_foro" style="cursor: pointer;">Exportar EXCEL<i class="i_opciones_foro glyphicon glyphicon-export pull-right"></i></a></li>
                <li><a href="#" id_foro="{$foro.For_IdForo}" class="opciones_foro" style="cursor: pointer;">Exportar CSV<i class="i_opciones_foro glyphicon glyphicon-export pull-right"></i></a></li>
                <li><a href="#" id_foro="{$foro.For_IdForo}" class="opciones_foro" style="cursor: pointer;">Exportar PDF<i class="i_opciones_foro glyphicon glyphicon-export pull-right"></i></a></li>
            </ul>
        </div>
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12 p-rt-lt-0">
            <hr class="cursos-hr-title-foro">
        </div>
        <div class="col col-md-offset-6 col-lg-offset-6 col-md-6 col-xs-12 col-sm-12 col-lg-6">
            <div class="input-group">
                <input type ="text" class="form-control"  data-toggle="tooltip" data-original-title="Buscar" placeholder="Buscar" name="text_busqueda" id="text_busqueda" onkeypress="tecla_enter_foro(event)" value="{$palabrabuscada|default:''}">
                <span class="input-group-btn">
                    <button class="btn  btn-success btn-buscador" for_funcion ="query" ajax="lista_buscar_query" type="button" id="buscar_foro"><i class="glyphicon glyphicon-search"></i></button>
                </span>
                </div><!-- /input-group -->
                
            </div>
            
            <div id="lista_buscar_query" class="row">
                <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12" style="margin-bottom: 30px; margin-top: 15px;">
                    
                    {if count($lista_foros)>0}
                    {foreach from=$lista_foros item=foro}
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="">
                            <div class="cabecera-discusion">
                                <a class="link-foro" href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">
                                    <h4 style="text-align: justify;"><strong>{$foro.For_Titulo}</strong></h4>
                                </a>
                            </div>
                            <div class="detalles-act-reciente">{$foro.Usu_Usuario} &nbsp;&nbsp;-&nbsp;&nbsp; hace {$foro.tiempo} &nbsp;&nbsp;-&nbsp;&nbsp; 3 votos &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.For_TComentarios|default:0} comentario(s)</div>
                            <!-- <div class="body-item">
                                <p>{$foro.For_Resumen|truncate:120:"..."}</p>
                            </div> -->
                            <!-- <div class="footer-item row">
                                <div class="col-md-6">
                                    {$end_date=($foro.For_FechaCierre|date_format:"%d-%m-%Y")}
                                    <span class="date">{$foro.For_FechaCreacion|date_format:"%d-%m-%Y"} {if ($foro.For_FechaCierre|date_format:"%d-%m-%Y")!=""} / {($foro.For_FechaCierre|date_format:"%d-%m-%Y")}{/if}</span>
                                </div>
                                <div class="col-md-6 text-right">
                                    Colaboraciones <span class="badge">{$foro.For_TComentarios}</span>
                                </div>
                            </div> -->
                        </div>
                    </div>
                    {/foreach}
                    {else}
                    <h4>No se encontraron Resultados</h4>
                    {/if}
                    
                </div>
            </div>
        </div>
    </div>