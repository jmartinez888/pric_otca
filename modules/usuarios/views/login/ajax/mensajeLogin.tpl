<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="myModalLabel">Bienvenido {$usuario} ...!!!</h4>
</div>
<div class="modal-body">
    {if isset($_mensaje)}
    	<p class="text-success">{$_mensaje}</p>
	{/if}
    <p class="text-success">Para continuar seleccion Aceptar</p>
    <!-- <input type='text' class='form-control' name='codigo' id='validate-number' placeholder='Codigo' required> --> 
</div>
<input type="hidden" name="params_usu" id="params_usu" value="{$params_usu|default:'*'}">
<div class="modal-footer">
    <button type="button" class="btn btn-success" data-dismiss="modal">Aceptar</button>
</div>