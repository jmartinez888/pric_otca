<link rel="stylesheet" type="text/css" href="{BASE_URL}/modules/elearning/views/calendario/css/calendario.css"/>
<input hidden="hidden" id="hiddenCalend_AntAnio" value="{$anterior.ANIO}" />
<input hidden="hidden" id="hiddenCalend_AntMes" value="{$anterior.MES}" />
<input hidden="hidden" id="hiddenCalend_SigAnio" value="{$siguiente.ANIO}" />
<input hidden="hidden" id="hiddenCalend_SigMes" value="{$siguiente.MES}" />
<div class="col-lg-12">
  <div align="center">
    <div class="col-lg-4" style="padding-left: 0px; margin-bottom: 10px">
      <button id="btn_calend_anterior" class="btn btn-success" style="float: left">Anterior</button>
    </div>
    <div class="col-lg-4">
      <center><h4><strong>{$titulo}</strong></h4></center>
    </div>
    <div class="col-lg-4" style="padding-right: 0px; margin-bottom: 10px">
      <button id="btn_calend_siguiente" class="btn btn-success" style="float: right">Anterior</button>
    </div>
    <table class="table-calendar" border="1" cellspacing="0">
      <tr>
        <th>Lunes</th>
        <th>Martes</th>
        <th>Miercoles</th>
        <th>Jueves</th>
        <th>Viernes</th>
        <th>Sabado</th>
        <th>Domingo</th>
      </tr>
      {foreach from=$calendario item=semana}
        <tr>
        {foreach from=$semana item=dia}
        <td class="{if $dia.T==1}dia-calendario{else}no-month{/if}">
          {if isset($dia.eventos) && count($dia.eventos)>0}
            <div class="eventos-dia-calendario">
            {for $i=0;$i < 2;$i++}
              {if isset($dia.eventos[$i])}
                <div class="evento-dia-calendario">
                  <div class="evento-dia-calendario-texto">
                    {substr($dia.eventos[$i].DET, 0, 20)}...
                  </div>
                  <input hidden="hidden" class="evento-dia-calendario-data" value='{json_encode($dia.eventos[$i])}' />
                </div>
              {/if}
            {/for}
            </div>
          {/if}
          <input hidden="hidden" value='{if isset($dia.eventos) && count($dia.eventos)>0}{json_encode($dia.eventos)}{else}0{/if}' class="calendario-eventos" />
          <input hidden="hidden" value="{$dia.D}" class="calendario-dia" />
          <input hidden="hidden" value="{$dia.M}" class="calendario-mes" />
          <input hidden="hidden" value="{$dia.A}" class="calendario-anio" />
          <div class="fecha-dia-calendario">{$dia.D}</div>
        </td>
        {/foreach}
        </tr>
      {/foreach}
    </table>
    </br>
  </div>
</div>

<div class="modal fade" id="panel-dia-calendario" tabindex="-5" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-focus-on="input:first">
    <div class="modal-dialog modal-xm">
       <div class="panel">
           <div class="panel-heading panel-calendario-header">
               <span style="height: 20px; width: 20px; margin-right: 5px; margin: 0px 0px 0px 5px;" class="glyphicon glyphicon-calendar"></span>
               <div id="panel-calendario-titulo" style="display: inline-block"></div>
               <button class="close" data-dismiss="modal" style="margin-top: 0px;color: white !important">&times;</button>
           </div>
           <div class="panel-body" style="padding: 10px 0px 10px 0px !important;">
              <div id="content-p-e-c"></div>
           </div>
       </div>
   </div>
</div>
<script type="text/javascript" src="{BASE_URL}/modules/elearning/views/calendario/js/calendario.js"></script>
