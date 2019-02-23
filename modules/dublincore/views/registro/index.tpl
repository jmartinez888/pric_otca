<div id="registrarDocumento" >

        <h1 align="center" >{$nombreRecurso}</h1>
        <h2 align="center">{$lenguaje["registro_documento"]} </h2>


        <form enctype="multipart/form-data" class="formulario" name="form_registro_documento" method="post" >
            <input id="registrar" type="hidden" value="1" name="registrar"  />
            <input type="hidden" value="{$idrecurso}" name="recurso"/>
            <input type="hidden" value="{$cantidaRegistros}" name="cantidadRegistros"/>
            <div class="nuevo_dato">

            </div>
            <div id="form_registrar_documento" >
            <table class="table-registro-documento">
                <tr>
                    <td> <label>{$lenguaje["idioma_metadata"]} :</label> </td>
                    <td>
                        {if isset($idiomas) && count($idiomas)}
                        <select name="idIdiomaMetadata">
                            {foreach item=datos from=$idiomas}
                                <option  value="{$datos.Idi_IdIdioma|default:0}">{$datos.Idi_Idioma|default:{$lenguaje["seleccionar_idioma"]}</option>
                            {/foreach}
                        </select>
                        {/if}
                        <a href="{$_layoutParams.root}dublincore/registro/nuevoIdioma">{$lenguaje["nuevo"]}</a>
                    </td>
                </tr>
                <tr>
                    <td> <label>{$lenguaje["autores_metadata_documentos"]}: </label> </td>
                    <td>
                        {if isset($autores) && count($autores)}
                        <select name="idAutor">
                            {foreach item=datos from=$autores}
                                <option  value="{$datos.Aut_IdAutor|default:0}">{$datos.Aut_Nombre|default:{$lenguaje["seleccionar_autor"]}}</option>
                            {/foreach}
                        </select>
                        {else}

                        {/if}
                        <a href="{$_layoutParams.root}dublincore/registro/nuevoAutor">{$lenguaje["nuevo"]}</a>
                    </td>
                </tr>
                <tr>
                    <td><label>{$lenguaje["tema_metadata_documentos"]}</label> </td>
                    <td>
                        {if isset($temas) && count($temas)}
                        <select name="idTemaDublin">
                            {foreach item=datos from=$temas}
                                <option  value="{$datos.Ted_IdTemaDublin|default:0}">{$datos.Ted_Descripcion|default:{$lenguaje["seleccionar_tema"]}}</option>
                            {/foreach}
                        </select>
                        {else}

                        {/if}
                        <a href="{$_layoutParams.root}dublincore/registro/nuevoTema">{$lenguaje["nuevo"]}</a>
                    </td>
                </tr>
                <tr>
                    <td><label>{$lenguaje["menu_izquierdo2_documentos"]} </label></td>
                    <td>
                        {if isset($tipodublin) && count($tipodublin)}
                        <select  name="idTipoDublin">
                            {foreach item=datos from=$tipodublin}
                                <option value="{$datos.Tid_IdTipoDublin|default:0}">{$datos.Tid_Descripcion|default:{$lenguaje["seleccionar_tipo_dublin"]}}</option>
                            {/foreach}
                        </select>
                        {else}

                        {/if}
                        <a href="{$_layoutParams.root}dublincore/registro/nuevoTipoDocumento">{$lenguaje["nuevo"]}</a>
                    </td>
                </tr>
                <tr>
                    <td><label>{$lenguaje["tabla_campo_idiomas_documentos" "titulo_resultados_documentos"]}: </label></td>
                    <td>
                        {if isset($idiomas) && count($idiomas)}
                        <select name="idiomaDocumento">
                            {foreach item=datos from=$idiomas}
                                <option  value="{$datos.Idi_Idioma|default:0}">{$datos.Idi_Idioma|default:"{$lenguaje["seleccionar_idioma"]}}</option>
                            {/foreach}
                        </select>
                        {else}

                        {/if}
                        <a href="{$_layoutParams.root}dublincore/registro/nuevoIdioma">{$lenguaje["nuevo"]}</a>
                    </td>
                </tr>
                <tr>
                    <td><label>{$lenguaje["tabla_campo_tipo_documentos"]} : </label></td>
                    <td>
                        {if isset($tipoarchivosfisicos) && count($tipoarchivosfisicos)}
                        <select  name="formato">
                            {foreach item=datos from=$tipoarchivosfisicos}
                                <option value="{$datos.Taf_IdTipoArchivoFisico|default:0}">{$datos.Taf_Descripcion|default:{$lenguaje["seleccionar_formato"]}}</option>
                            {/foreach}
                        </select>
                        {else}

                        {/if}
                        <a href="{$_layoutParams.root}dublincore/registro/nuevoFormato">{$lenguaje["nuevo"]}</a>
                    </td>
                </tr>
                <tr>
                    <td><label>{$lenguaje["subir_archivo"]}</label></td>
                    <td><input name="archivo" type="file" id="archivo" /></td>
                    <td></td>
                </tr>
                <tr > <td></td><td class="messages"></td> </tr>
                <tr > <td></td><td class="showImage"></td> </tr>
                <tr>
                    <td><label>{$lenguaje["label_titulo_bdrecursos"]}: </label></td>
                    <td><input type="text" name="titulo" value="{$datos.titulo|default:""}"/></td></tr>
                <tr>
                    <td><label>{$lenguaje["label_descripcion_bdrecursos"]}: </label></td>
                    <td><input type="text" name="descripcion" value="{$datos.descripcion|default:""}"/></td></tr>
                <tr>
                    <td><label>{$lenguaje["label_editor_dbrecursos"]}: </label></td>
                    <td><input type="text" name="editor" value="{$datos.editor|default:""}"/></td></tr>
                <tr>
                    <td><label>{$lenguaje["label_colaborador_bdrecursos"]}: </label></td>
                    <td><input type="text" name="colaborador" value="{$datos.colaborador|default:""}"/></td></tr>
                <tr>
                  <td>
                    <label>{$lenguaje["fechadocumentos_metadata_documentos"]}:</label>
                  </td>
                  <td>
                    <input type="text" id="f_rangeIni" name="fechaDocumento" />
                    <button id="f_rangeIni_trigger">...</button>
                    <script type="text/javascript">
                      CAL_1 = new Calendar({
                              inputField: "f_rangeIni",
                              dateFormat: "%d/%m/%Y",
                              trigger: "f_rangeIni_trigger",
                              bottomBar: false,
                              onSelect: function() {
                                      var date = Calendar.intToDate(this.selection.get());
                                      LEFT_CAL.args.max = date;
                                      LEFT_CAL.redraw();
                                      this.hide();
                              }
                      });
                    </script>
                  </td>
                </tr>
                <tr>
                    <td><label>{$lenguaje["label_fuente_bdrecursos"]}: </label></td>
                    <td><input type="text" name="fuente" value="{$datos.fuente|default:""}"/></td></tr>
                <tr>
                    <td><label>{$lenguaje["label_identificador_bdrecursos"]}: </label></td>
                    <td><input type="text" name="identificador" value="{$datos.identificador|default:""}"/></td></tr>
                <tr>
                    <td><label>{$lenguaje["label_relacion_bdrecursos"]}: </label></td>
                    <td><input type="text" name="relacion" value="{$datos.relacion|default:""}"/></td></tr>
                <tr>
                    <td><label>{$lenguaje["label_cobertura_bdrecursos"]}: </label></td>
                    <td><input type="text" name="cobertura" value="{$datos.cobertura|default:""}"/></td></tr>
                <tr>
                    <td><label>{$lenguaje["palabra_clave_documentos"]}: </label></td>
                    <td><input type="text" name="palabraclave" value="{$datos.palabraclave|default:""}"/></td></tr>
                <tr>
                    <td><label>{$lenguaje["label_derecho_bdrecursos"]}: </label></td>
                    <td><input type="text" name="derechos" value="{$datos.derechos|default:""}"/></td></tr>

            </table>

                <input type="submit" id="btnregistrarDoc" name="submit_registrar" value="registrar" />

        </form>
                <br><br><br>
    </div>

</div>
