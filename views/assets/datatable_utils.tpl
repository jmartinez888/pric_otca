class DatatableUtil {
	static textEstado (tipo) {
		if (tipo == 0) {
			return `<p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign " title="{$lenguaje['str_denegado']}" style="color: #DD4B39;"></p>`;
		}
		if (tipo == 1) {
			return `<p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign " title="" style="color: #088A08;" data-original-title="{$lenguaje['str_habilitado']}"></p>`;
		}
	}
}