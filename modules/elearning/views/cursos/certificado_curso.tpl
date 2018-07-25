<div class="printableArea">
<!-- <div class="col-lg-12 col-xs-12" style="padding:20px; text-align:center; border: 10px solid #187875">
<div class="col-lg-12 col-xs-12" style="padding:20px; text-align:center; border: 5px solid #787878"> -->
  <div class="col-lg-12 col-xs-12" style="position: relative; display: inline-block; text-align:center; height:21cm; padding:0px;">
    <img src="{$_layoutParams.root_clear}{$plantilla.Plc_UrlImg}"  style="width:100%; height:21cm;">
                <!-- <div class="col col-md-3 col-sm-2 col-xs-3 padding-10">
                    <img  class="width-250" src="{$_layoutParams.ruta_img}frontend/logo.png" alt="La ORA" title="ORA">
                </div>
                 <div class="col col-md-6 col-sm-8 col-xs-6 padding-10 align-right">
                </div>

                <div class="col col-md-3 col-sm-2 col-xs-3 padding-10 text-align-right">
                    <img src="{$_layoutParams.ruta_img}frontend/logo_otca.png" align="right">
                </div>
                <div class="fondo-header-active"></div> -->
                <!--  <div class="col-lg-12 col-xs-12" style="position: absolute; top:310px; left: 5%; transform: translate(-0%, -50%);"><span style="font-size:25px"><b>{$certificado[0]['Usu_Nombre']}  {$certificado[0]['Usu_Apellidos']} </b></span><br/></div> -->
<!--                 <div class="col-lg-12 col-xs-12" style="position: absolute; top:315px; left: 6%; transform: translate(-0%, -50%);"><span style="font-size:30px"><b>{$certificado}</b></span><br/></div> -->
<!-- <div class="col-lg-12 hidden-xs" style="position: absolute; top:32%; left: 5%; transform: translate(-0%, -50%); font-size:3vw; "><b>{$certificado[0]['Usu_Nombre']}  {$certificado[0]['Usu_Apellidos']}</b><br/></div> -->

<div class="" style="{$plantilla.Plc_StyleNombre}border:0; "><b>{$certificado[0]['Usu_Nombre']}  {$certificado[0]['Usu_Apellidos']}</b><br/></div>

<!-- <div class=" col-xs-12  visible-xs" style="position: absolute; top:32%; left: 5%; transform: translate(-0%, -50%); font-size:5vw; "><b>{$certificado[0]['Usu_Nombre']}  {$certificado[0]['Usu_Apellidos']}</b><br/></div> -->

<div class="col-lg-12 hidden-xs" style="{$plantilla.Plc_StyleCurso}border:0; "><span style="font-size:30px"><b>{$certificado[0]['Cur_Titulo']}</b></span><br/></div>

<div class="col-xs-12  visible-xs" style="position: absolute; top:45%; left: 5%; transform: translate(-0%, -50%);"><span style="font-size:4vw"><b>{$certificado[0]['Cur_Titulo']}</b></span><br/></div>

<!--   <div class="col-lg-12 hidden-xs" style="position: absolute; top:47%; left: 12%; width:88%; transform: translate(0%, 8%)"><p style="font-size:22px">de 40 horas de duración, superando con éxito los módulos de:</p><span style="font-size:23px"><b>{$cont=1} {foreach item=m from=$modulo}{$m.Mod_Titulo}.{if $cont!=count($modulo)}, {else}.{/if}{$cont=$cont+1}{/foreach}</b></span><br/><br/><p style="font-size:20px">Y para que así conste, hacemos entrega del siguiente certificado acreditativo.</p><br/></div>

    <div class="col-xs-12  visible-xs" style="position: absolute; top:51%; left: 12%; width:88%; transform: translate(0%, 15%)"><span style="font-size:3vw"><b>{$cont=1} {foreach item=m from=$modulo}{$m.Mod_Titulo}.{if $cont!=count($modulo)}, {else}.{/if}{$cont=$cont+1}{/foreach}</b></span><br/></div>
 -->
<div class="col-lg-12 hidden-xs" style="{$plantilla.Plc_StyleFecha}border:0; "><span style="font-size:20px">{$certificado[0]['Fecha_completa']}</span><br/></div>

<div class="col-lg-12 hidden-xs" style="{$plantilla.Plc_StyleHora}border:0; "><span style="font-size:20px">{$certificado[0]['Cur_Duracion']}</span><br/></div>     

<div class="col-xs-12  visible-xs" style="position: absolute; top:68%; left:30%; "><span style="font-size:25px">{$certificado[0]['Fecha_completa']}</span><br/></div>   
            

<div class="col-lg-12 col-xs-12" style="position: absolute; bottom:0; left: 5%;"><span style="font-size:13px">Certificación de aprobación online</span><br/><span style="font-size:12px">Código: {$certificado[0]['Cer_Codigo']}</span></div>

</div>
      <!--  <span style="font-size:40px; font-weight:bold">Certifica a</span>
       <br><br> -->
      
      <!--  <span style="font-size:20px">Por participar y aprobar el curso de</span> <br/><br/>
       <span style="font-size:50px"><b>{$certificado[0]['Cur_Titulo']}</b></span> <br/> -->
      <!--  <div class="col-lg-12 text-align-center">
       <div class="col-lg-4 col-lg-offset-4 img-curso">
       <center><img src="{BASE_URL}modules/elearning/views/cursos/img/portada/{$certificado[0]['Cur_UrlBanner']}"/></center>       
      </div>
      </div> -->
<!--        <span style="font-size:20px">de {$certificado[0]['Cur_Duracion']} horas de duración, superando con éxito todos los módulos:{$cont=1} {foreach item=m from=$modulo}{$m.Mod_Titulo}{if $cont!=count($modulo)}, {else}.{/if}{$cont=$cont+1}{/foreach}</span><br/><br/> -->
       <!-- <span style="font-size:18px">Y para que así conste, hacemos entrega del presente certificado acreditativo.</span> <br/><br/><br/> -->
<!--        <div class="col-lg-12 col-xs-12 text-align-center"> -->
       <!-- <div class="col-lg-4 col-xs-4 col-lg-offset-4 col-xs-offset-4" style="border-bottom: 2px solid black;""> -->
       <!-- <div class="col-lg-3 col-xs-3 col-lg-offset-4 col-xs-offset-4">
       <center><img src="{BASE_URL}modules/elearning/views/cursos/img/firma_y_nombre.png"/></center>       
        </div>
      </div> -->
       <!-- <span style="font-size:15px">Cristian Romeo Rios Rodriguez</span> <br/>
       <span style="font-size:18px"><b>COO de PRIC-OTCA</b></span> <br/><br/> -->
       <!-- <span style="font-size:15px"><b>{$certificado[0]['Fecha_completa']}</b></span><br/>
       <span style="font-size:13px">Certificación de aprobación online</span><br/>
       <span style="font-size:11px">Código: {$certificado[0]['Cer_Codigo']}</span> -->
<!-- </div>
</div> -->
</div>
<!-- <p><input type="button" class="printer" value="Imprimir"></p> -->
<!-- <a href="javascript:void(0);" id="printButton">Print</a>   -->

<form method="POST">                       
  <div class="form-group ">
    <div class="well-sm col-sm-12">
        <div id="botones" class="btn-group pull-right">
            <button type="submit" id="export_data_pdf" name="export_data_pdf" class="btn btn-info glyphicon glyphicon-download-alt">  PDF</button>
        </div>
    </div>
  </div>
</form>