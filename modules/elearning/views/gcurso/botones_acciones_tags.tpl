<button type="button" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('str_eliminar')}" @click.prevent="onClick_delete" class="btn btn-sm btn-danger"><i class="glyphicon glyphicon-trash"></i></button>
<button type="button" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('str_obligatorio')}" @click.prevent="onClick_Obligatorio" class="btn btn-sm btn-success"><i :class="{
		glyphicon: true,
		'glyphicon-unchecked' : element.obligatorio == 0,
		'glyphicon-check' : element.obligatorio == 1
		}"></i></button>