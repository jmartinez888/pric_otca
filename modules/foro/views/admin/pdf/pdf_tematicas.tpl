<!DOCTYPE html>
<html>
	<head>
		<link href='views/layout/frontend/css/bootstrap.min.css' rel='stylesheet' type='text/css'>
	</head>
	<body>
		<div class='table-responsive'>
			<h3 style='text-align: center; color:black; font-family: inherit;'>ROLES DEL SISTEMA</h3>
			<table class='table'>
				<thead>
					<tr>
						<th>Tematica</th>
						<th>Estado</th>

					</tr>
				</thead>
				<tbody>
					{foreach $tematicas as $item}
					    <tr>
								<td>{$item->Tem_Nombre}</td>
								<td>{$item->Tem_estado}</td>
							</tr>
					{/foreach}

				</tbody>
			</table>
		</div>
	</body>
</html>