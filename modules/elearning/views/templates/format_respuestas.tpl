<form role="form" action="{$_layoutParams.root}elearning/formulario/store_respuesta/{$obj_curso['Cur_IdCurso']}" method="post" enctype="multipart/form-data" id="frm_enviar_respuesta">
  {if isset($formulario_modo_registro)}
    <input type="hidden" name="formulario_modo_registro" value="{$formulario_modo_registro}">
  {else}
    <input type="hidden" name="formulario_modo_registro" value="none">
  {/if}
  
  
  
                  <div class="form-group">
                    <h1>{$formulario->Frm_Titulo}</h1>
                    <p>{$formulario->Frm_Descripcion}</p>
                  </div>
                  <hr>

                  <input type="hidden" name="formulario_id" value="{$formulario.Frm_IdFormulario}">
                  {if isset($redireccion)}
                    <input type="hidden" name="redireccion" value="{$redireccion}">
                  {/if}
                  {foreach $formulario->preguntas as $pre}
                    <div class="form-group">
                      {if ($pre->Fpr_Tipo == 'titulo_a' || $pre->Fpr_Tipo == 'titulo_b')}
                        {if ($pre->Fpr_Tipo == 'titulo_a')}
                          <h2 class="tag-custom">{$pre->Fpr_Pregunta}</h2>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'titulo_b')}
                          <h3 class="tag-custom">{$pre->Fpr_Pregunta}</h3>
                        {/if}
                        {if (trim($pre->Fpr_Descripcion) != '')}
                          <p>{$pre->Fpr_Descripcion}</p>
                        {/if}
                      {else}

                        <label class="control-label">{$pre->Fpr_Pregunta}</label>
                        {if ($pre->Fpr_Tipo == 'texto')}
                          <input form="frm_enviar_respuesta" type="text" name="frm_pre_{$pre->Fpr_IdForPreguntas}"  class="form-control" {if ($pre->Fpr_Obligatorio == 1)}required="required"{/if}>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'parrafo')}
                          <textarea name="frm_pre_{$pre->Fpr_IdForPreguntas}" class="form-control" rows="3" {if ($pre->Fpr_Obligatorio == 1)}required="required"{/if}></textarea>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'select')}
                          <select form="frm_enviar_respuesta" name="frm_pre_{$pre->Fpr_IdForPreguntas}"  class="form-control" {if ($pre->Fpr_Obligatorio == 1)}required="required"{/if}>
                            {foreach $pre->opciones as $opc}
                              <option value="{$opc->Fpo_IdForPrOpc}">{$opc->Fpo_Opcion}</option>
                            {/foreach}
                          </select>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'radio')}
                          {foreach $pre->opciones as $opc}
                            <div class="radio">
                              <label>
                                <input form="frm_enviar_respuesta" type="radio" name="frm_pre_{$pre->Fpr_IdForPreguntas}"  value="{$opc->Fpo_IdForPrOpc}" {if ($pre->Fpr_Obligatorio == 1)}required="required"{/if}>
                                {$opc->Fpo_Opcion}
                              </label>
                            </div>
                          {/foreach}
                        {/if}
                        {if ($pre->Fpr_Tipo == 'box')}
                          {foreach $pre->opciones as $opc}
                            <div class="checkbox">
                              <label>
                                <input form="frm_enviar_respuesta" type="checkbox" name="frm_pre_{$pre->Fpr_IdForPreguntas}[]" value="{$opc->Fpo_IdForPrOpc}" >
                                {$opc->Fpo_Opcion}
                              </label>
                            </div>
                          {/foreach}
                        {/if}
                        {if ($pre->Fpr_Tipo == 'upload')}
                          <input form="frm_enviar_respuesta" type="file" name="file_pre_{$pre->Fpr_IdForPreguntas}"  class="form-control" {if ($pre->Fpr_Obligatorio == 1)}required="required"{/if} >
                        {/if}
                        {if ($pre->Fpr_Tipo == 'fecha')}
                          <input form="frm_enviar_respuesta" type="date" name="frm_pre_{$pre->Fpr_IdForPreguntas}"  class="form-control"  {if ($pre->Fpr_Obligatorio == 1)}required="required"{/if} >
                        {/if}
                        {if ($pre->Fpr_Tipo == 'hora')}
                          <input form="frm_enviar_respuesta" type="time" name="frm_pre_{$pre->Fpr_IdForPreguntas}"  class="form-control" {if ($pre->Fpr_Obligatorio == 1)}required="required"{/if}>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'cuadricula')}
                          <table class="table table-bordered table-hover">
                            <thead>
                              <tr>
                                <th>&nbsp;</th>
                                {foreach $pre->opciones as $col}
                                  <th>{$col->Fpo_Opcion}</th>
                                {/foreach}
                              </tr>
                            </thead>
                            <tbody>
                              {foreach $pre->hijos as $fil}
                                {* {if $fil->Fpo_Tipo == 'fil'} *}
                                  <tr>
                                    <td>{$fil->Fpr_Pregunta}</td>
                                    {foreach $pre->opciones as $col}
                                      <td>
                                        <div class="radio">
                                          <label>
                                            <input form="frm_enviar_respuesta" type="radio" name="frm_pre_{$fil->Fpr_IdForPreguntas}" value="{$col->Fpo_IdForPrOpc}" {if ($pre->Fpr_Obligatorio == 1)}required="required"{/if}>
                                          </label>
                                        </div>
                                      </td>

                                    {/foreach}
                                  </tr>
                                {* {/if} *}
                              {/foreach}
                            </tbody>
                          </table>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'casilla')}
                          <table class="table table-bordered table-hover">
                            <thead>
                              <tr>
                                <th>&nbsp;</th>
                                {foreach $pre->opciones as $col}
                                  <th>{$col->Fpo_Opcion}</th>
                                {/foreach}
                              </tr>
                            </thead>
                            <tbody>
                              {foreach $pre->hijos as $fil}
                                {* {if $fil->Fpo_Tipo == 'fil'} *}
                                  <tr>
                                    <td>{$fil->Fpr_Pregunta}</td>
                                    {foreach $pre->opciones as $col}
                                      <td>
                                        <div class="checkbox">
                                          <label>
                                            <input form="frm_enviar_respuesta" type="checkbox" name="frm_pre_{$fil->Fpr_IdForPreguntas}[]" value="{$col->Fpo_IdForPrOpc}">
                                          </label>
                                        </div>
                                      </td>

                                    {/foreach}
                                  </tr>
                                {* {/if} *}
                              {/foreach}
                            </tbody>
                          </table>
                        {/if}
                      {/if}
                    </div>
                  {/foreach}
                  <button form="frm_enviar_respuesta" type="submit" class="btn btn-success">{$lang->get('elearning_cursos_enviar_encuestas')}</button>
                </form>