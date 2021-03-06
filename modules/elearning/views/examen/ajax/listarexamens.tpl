<div class="col-xs-12">
    <input type="hidden" name="porcentaje" id="porcentaje" value="{$porcentaje|default:'0'}">
    {if $porcentaje < 100}
        {if isset($idLeccion) && $idLeccion > 0}
            <input type="hidden" class="estado" id="hidden_habilitado" value="{$Exa_Habilitado|default:'0'}" />

            <a href="{$_layoutParams.root}elearning/gleccion/_view_leccion/{$idcurso}/{$modulo.Moc_IdModuloCurso}/{$idLeccion}" class="btn btn-danger margin-t-10 " id="btn_nuevo" ><i class="glyphicon glyphicon-triangle-left"></i> Regresar</a>
            
            <a href="{$_layoutParams.root}elearning/examen/nuevoexamen/{$idcurso}/{$idLeccion}" class="btn btn-primary margin-t-10 " id="btn_nuevo" > <i class="glyphicon glyphicon-plus"></i> Nuevo</a>
        {else}
         <a href="{$_layoutParams.root}elearning/examen/nuevoexamen/{$idcurso}" class="btn btn-primary margin-t-10 glyphicon glyphicon-plus" id="btn_nuevo" > Nuevo</a>
        {/if}
    {else}
     <a data-toggle="modal"  data-target="#msj-invalido" class="btn btn-danger margin-t-10 glyphicon glyphicon-plus" data-placement="bottom" > Nuevo</a>
    {/if}            
    {if isset($examens) && count($examens)}
        <div class="table-responsive">
            <table class="table" style="  margin: 20px auto">
                <tr>
                    <th style=" text-align: center">Nº</th>
                    <th style=" text-align: center">{$lenguaje["examen_titulo"]}</th>
                    <th style=" text-align: center">{$lenguaje["examen_intentos"]}</th>
                    <th style=" text-align: center">{$lenguaje["examen_procentaje"]}</th>
                    <th style=" text-align: center">{$lenguaje["examen_estado"]}</th>
                    <th style=" text-align: center">{$lenguaje["examen_opciones"]}</th>
                </tr>
                {foreach item=rl from=$examens}
                    <tr {if $rl.Row_Estado==0}
                            {if $_acl->permiso("ver_eliminados")}
                                class="btn-danger"
                            {else}
                                hidden {$numeropagina = $numeropagina-1}
                            {/if}
                        {/if} >
                        <td style=" text-align: center">{$numeropagina++}</td>
                        <td style=" text-align: center">{$rl.Exa_Titulo}</td>
                        <td style=" text-align: center">{$rl.Exa_Intentos}</td>
                        <td style=" text-align: center">{$rl.Exa_Porcentaje}%</td>
                        <td style=" text-align: center">  
                        {if $rl.Exa_Estado==0}
                            <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign " title="{$lenguaje.label_deshabilitado}" style="color: #DD4B39;"></p>
                        {/if}        
                        {if $rl.Exa_Estado==1}
                            <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign " title="{$lenguaje.label_habilitado}" style="color: #088A08;"></p>
                        {/if}
                        </td>
                        {if $_acl->permiso("editar_rol")}
                        <td style=" text-align: center">
                            {if  $rl.Emitido>=0}
                            <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-examen" title="{$lenguaje.tabla_opcion_cambiar_est}" Exa_Porcentaje = "{$rl.Exa_Porcentaje}" 
                            id_examen="{$rl.Exa_IdExamen}" estado="{$rl.Exa_Estado}"> </a>
                            {/if}
                            <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" id="btn-Editar" title="Editar" href="{$_layoutParams.root}elearning/examen/editarexamen/{$idcurso}/{$rl.Exa_IdExamen}"></a>

                             <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-question-sign btn-preguntas" title="Preguntas" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$rl.Exa_IdExamen}"></a>

                            {if  $rl.Emitido >= 0}
                            <a   
                            {if $rl.Row_Estado == 0 }
                                data-toggle="tooltip" 
                                class="btn btn-default btn-sm  glyphicon glyphicon-ok confirmar-habilitar-examen" title="{$lenguaje.label_habilitar}" 
                            {else}
                                data-book-id="{$rl.Pre_Descripcion}"
                                data-toggle="modal"  data-target="#confirm-delete"
                                class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-examen" {/if}
                            id_examen="{$rl.Exa_IdExamen}" data-placement="bottom" > </a>
                            {/if}
                            {/if}
                        </td>
                    </tr>
                {/foreach}
            </table>
        </div>
        {$paginacionexamens|default:""}
    {else}
        No hay registros
    {/if}                
</div>

{if isset($_mensaje_json)}
<script type="text/javascript">
    mensaje({$_mensaje_json});
</script>
{/if}
