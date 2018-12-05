{if count($lista_foros)>0}
<table class="table table-striped">
    <thead>
        <tr>
            <th colspan="2" style="border-top: 1px solid #ddd;"><h4>Detalles de resultado</h4></th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$lista_foros item=foro}
        <tr class=" 
        {if $foro.For_Estado==0 && $foro.Row_Estado==1}
         disable_foro
        {elseif  $foro.Row_Estado==0}
         delete_foro
        {/if}
        "
        >
            <td>
                <h4><a class="simulalink" href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}" target="_blank"><strong>{$foro.For_Titulo}</strong></a></h4>
                <a class="simulalink" style="color: black; text-align: justify;" href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}" target="_blank">{$foro.For_Resumen|truncate:80:"..."}</a>
                <div  style="padding-top: 10px;padding-bottom: 10px; font-size: 12px;">
                    <span class="badge" style="border-radius: 4px;">{$foro.For_Funcion}
                    </span>
                    &nbsp;&nbsp;-&nbsp;&nbsp;
                    {$foro.Usu_Usuario}
                    &nbsp;&nbsp;-&nbsp;&nbsp;
                    {shortnumber number=$foro.Nvaloraciones_foro} voto(s)
                    &nbsp;&nbsp;-&nbsp;&nbsp;
                    {$foro.For_NParticipantes} participante(s)
                    &nbsp;&nbsp;-&nbsp;&nbsp;
                    {$foro.For_NComentarios}  comentario(s)
                </div>
            </td>
            <td class="f-z-14">
                <small>
                <strong>Iniciado:</strong>
                </small>
                {assign var="datei" value=" "|explode:$foro.For_FechaCreacion}
                <br>
                <i class="glyphicon glyphicon-calendar"></i>
                {$datei[0]|replace:'-':'.'}
                <i class="fa fa-clock-o" aria-hidden="true"></i> {$datei[1]}
                <br>
                <small>
                <strong>Finalizado:</strong>
                </small>
                <br>
                {assign var="datef" value=" "|explode:$foro.For_FechaCierre}
                <i class="glyphicon glyphicon-calendar"></i>
                {$datef[0]|replace:'-':'.'}
                <i class="fa fa-clock-o" aria-hidden="true"></i> {$datef[1]}
                
            </td>
        </tr>
        <!--washington-->
        {/foreach}
    </tbody>
</table>
{$paginacion|default:""}
{else}
<div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    <h4>No se encontraron resultados!...</h4>
</div>
{/if}