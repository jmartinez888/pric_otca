<div id="formulario_editar_vue">
  <div class="col-sm-12">
    <form role="form" >
      <div class="form-group">
        <h1>{$lang->get('str_alumno')} : {$alumno->Usu_Nombre} {$alumno->Usu_Apellidos}</h1>
        <h3 class="text-right">{$respuesta->Fur_CreatedAt}</h3>
      </div>
      <hr>
      <div class="form-group">
        <h1>{$formulario->Frm_Titulo}</h1>
        <p>{$formulario->Frm_Descripcion}</p>
      </div>
      <hr>
      {foreach $formulario->preguntas as $pre}
        {if $pre->existeDetalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)}
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

                <p>{$pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->Fre_Respuesta}</p>
              {/if}
              {if ($pre->Fpr_Tipo == 'parrafo')}
                <p>{$pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->Fre_Respuesta}</p>
              {/if}
              {if ($pre->Fpr_Tipo == 'select')}
                <p>{$pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->opcion->Fpo_Opcion}</p>
              {/if}
              {if ($pre->Fpr_Tipo == 'radio')}
                <p>{$pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->opcion->Fpo_Opcion}</p>
              {/if}
              {if ($pre->Fpr_Tipo == 'box')}

                  <ul class="">
                  {foreach $pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes) as $opc}

                      <li>{$opc->Fpo_Opcion}</li>

                  {/foreach}
                  </ul>

              {/if}
              {if ($pre->Fpr_Tipo == 'upload')}
                {if ($pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes) != null)}
                  {$pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->format()}
                {else}
                  <p>{$lang->get('elearning_formulario_responder_fichero_no_encontrado')}</p>
                {/if}
              {/if}
              {if ($pre->Fpr_Tipo == 'fecha')}
                <p>{$pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->Fre_Respuesta}</p>
              {/if}
              {if ($pre->Fpr_Tipo == 'hora')}
                <p>{$pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->Fre_Respuesta}</p>
              {/if}
              {if ($pre->Fpr_Tipo == 'cuadricula')}
              
                <table class="table table-bordered table-hover">
                  <tbody>
                    
                      {foreach $pre->hijos as $fil}
                      <tr>
                        <td><strong>{$fil->Fpr_Pregunta}</strong></td>
                        <td>{$fil->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->opcion->Fpo_Opcion}</td>
                      </tr>
                      {/foreach}
                  </tbody>
                </table>
              {/if}
              {if ($pre->Fpr_Tipo == 'casilla')}
                <table class="table table-bordered table-hover">
                  <tbody>
                      {foreach $pre->hijos as $fil}
                      <tr>
                        <td><strong>{$fil->Fpr_Pregunta}</strong></td>
                        <td>
                          <ul class="">
                          {foreach $fil->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes) as $opc}
                            <li>{$opc->Fpo_Opcion}</li>
                          {/foreach}
                          </ul>
                        </td>
                      </tr>
                      {/foreach}
                  </tbody>
                </table>
              {/if}
            {/if}
          </div>
        {/if}
      {/foreach}
    </form>
  </div>
</div>