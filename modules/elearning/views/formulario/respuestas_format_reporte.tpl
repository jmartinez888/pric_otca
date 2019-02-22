
<form role="form" >
  {foreach $formulario->preguntas as $pre}
    
      <div class="form-group">
        
          <label class="control-label">{$pre->Fpr_Pregunta}</label>
          {if ($pre->Fpr_Tipo == 'texto')}
            
          {/if}
          {if ($pre->Fpr_Tipo == 'parrafo')}
            
          {/if}
          {if ($pre->Fpr_Tipo == 'select')}
            
          {/if}
          {if ($pre->Fpr_Tipo == 'radio')}
            
          {/if}
          {if ($pre->Fpr_Tipo == 'box')}

          {/if}
          {if ($pre->Fpr_Tipo == 'upload')}
            
          {/if}
          {if ($pre->Fpr_Tipo == 'fecha')}
            
          {/if}
          {if ($pre->Fpr_Tipo == 'hora')}
            
          {/if}
          {if ($pre->Fpr_Tipo == 'cuadricula')}
          {/if}
          {if ($pre->Fpr_Tipo == 'casilla')}

          {/if}
        
      </div>
      <hr>
    
  {/foreach}
</form>
