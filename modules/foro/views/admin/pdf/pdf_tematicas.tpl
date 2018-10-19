<!DOCTYPE html>
<html>
	<head>
		<link href='views/layout/backend/css/pdf.css' rel='stylesheet' type='text/css'>
		<link href='views/layout/backend/css/pdf_custom.css' rel='stylesheet' type='text/css'>
	</head>
	<body>
		<div class='table-responsive'>
			<h3 style='text-align: center; color:black; font-family: inherit;'>TEMÁTICA FORO</h3>
			<table class='table table-minimal'>
				<thead>
					<tr>
						<th>Tematica</th>
						<th>Estado</th>

					</tr>
				</thead>
				<tbody>
					{foreach $tematicas as $item}
					    <tr>
								<td>{$item->Lit_Nombre}</td>
								<td>{$item->Lit_Descripcion}</td>
							</tr>
					{/foreach}

				</tbody>
			</table>
		</div>
	</body>
</html>