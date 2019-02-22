<h2> {$lenguaje["registrar_nuevo_autor"]}</h2>
<form name="form2" method="post" action="">
    <div></div>
    <label>{$lenguaje["label_nombre_bdrecursos"]} : </label>
    <input type="text" name="autornombre"/>
    <label>{$lenguaje["label_profesion"]} : </label>
    <input type="text" name="autorprofesion"/>
    <label>{$lenguaje["label_email"]} : </label>
    <input type="text" name="autoremail"/>
    <input type="submit" name="registrar_Idioma" id="registrar_Idioma" value="registrar">
    <input  type="hidden" value="1" name="registrar"  />
</form>
