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
                    {$lenguaje.no_registros}
                {/if}                