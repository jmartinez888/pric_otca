{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-10">    
    <div class="col-lg-12">
        <h3>Verificación de Certificados</h3>
        <hr class="cursos-hr">
        <span>Para verificar un Certificado generado por la Plataforma Elearning del PRIC, ingresa el código de verificación y haz click en "Verificar".</span>
    </div>
    <div class="col-lg-12" style="margin-top: 20px">
        <div class="form-inline" action="/action_page.php">
            <div class="form-group">
                <label for="email">Código de Verificación: </label>
                <input type="text"placeholder="Ingrese Código" class="form-control" name="palabracertificado" id="palabracertificado">
            </div>            
            <button type="button" class="btn btn-default" id="buscarcertificadootros">Verificar</button>
        </div>
    </div>
    <div class="col-lg-12">
         
        <div id="listarcertificados">
            {if isset($certificados) && count($certificados)}
                <div class="table-responsive">
                    <table class="table" style="  margin: 20px auto">
                        <tr>
                            <th style=" text-align: center">Nº</th>
                            <th style=" text-align: center">Código</th>
                            <th style=" text-align: center">Nombre</th>
                            <th style=" text-align: center">Curso</th>
                            <th style=" text-align: center">Fecha</th>
                                {if $_acl->permiso("editar_rol")}
                                <th style=" text-align: center">Opciones</th>
                                {/if}
                        </tr>
                        {foreach item=rl from=$certificados}
                            <tr>
                                <td style=" text-align: center">{$numeropagina++}</td>
                                <td style=" text-align: center">{$rl.Cer_Codigo}</td>
                                <td style=" text-align: center">{$rl.Usu_Nombre} {$rl.Usu_Apellidos}</td>
                                <td style=" text-align: center">{$rl.Cur_Titulo}</td>
                                <td style=" text-align: center">{$rl.Cer_FechaReg}</td>
                                {if $_acl->permiso("editar_rol")}
                                    <td style=" text-align: center">
                                        <a target="_blank" class="btn btn-success btn-certificado" style="margin-bottom: 10px" href="{BASE_URL}elearning/cursos/obtenerCertificado/{$rl.Cer_IdCertificado}">
                                            <strong><span class="glyphicon glyphicon-list-alt"></span> &nbsp;Visualizar</strong>
                                        </a>
                                    </td>
                                {/if}
                            </tr>
                        {/foreach}
                    </table>
                </div>
                {$paginacioncertificados|default:""}
            {else}
                No hay registros
            {/if}                
        </div>
    </div>
     <div class="col-lg-12">
         <h4>¿Dónde encuentro el Código de Verificación?</h4>
          <hr class="cursos-hr">
          <span>
              El Código de verificación de un certificado generado por la Plataforma Elearning del PRIC aparece en la parte inferior derecha del documento. Este código también lo puede encontrar en el correo electrónico de entrega del certificado. Haga click en las imágenes a continuación para ver ejemplos:
          </span>
     </div>
</div>
