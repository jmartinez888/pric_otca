<!DOCTYPE html>
<html>
	<head>
		<link href='views/layout/backend/css/pdf.css' rel='stylesheet' type='text/css'>
		<link href='views/layout/backend/css/pdf_custom.css' rel='stylesheet' type='text/css'>
	</head>
	<body>
		<h1 style='text-align: center;'>{$lenguaje['difusion_contenido_index_titulo']|upper}</h1>
		<div class='table-responsive'>
			<table class='table table-minimal'>
				<thead>
					<tr>
						<th>{$lenguaje['str_difusion']}</th>
						<th>{$lenguaje['str_descripcion']}</th>
						<th>{$lenguaje['str_estado']}</th>
					</tr>
				</thead>
				<tbody>
					{foreach $difusiones as $item}
					    <tr>
								<td>{$item->ODif_Titulo}</td>
								<td>{$item->ODif_Descripcion}</td>
								<td>{$item->ODif_Estado}</td>
							</tr>
					{/foreach}

				</tbody>
			</table>
		</div>
	</body>
</html>