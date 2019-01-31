

    <input type="hidden" id="Idiomaseleccionado" name="Idiomaseleccionado" value="{$Idiomaseleccionado}" />
    <div style="margin-bottom: 25px;" class="form-group" >
        {if isset($foro) && count($foro)}
        {if  isset($idiomas) && count($idiomas)}
        <ul class="nav nav-tabs ">
            {foreach from=$idiomas item=idi}
            <li role="presentation" class="{if $foro.Idi_IdIdioma==$idi.Idi_IdIdioma} active {/if}">
                <a class="idioma_s" id="idioma_{$idi.Idi_IdIdioma}" href="#">{$idi.Idi_Idioma}</a>
                <input type="hidden" id="hd_idioma_{$idi.Idi_IdIdioma}" value="{$idi.Idi_IdIdioma}" />
                <input type="hidden" id="idiomaTradu" value="{$foro.Idi_IdIdioma}"/>
            </li>
            {/foreach}
        </ul>
        {/if}
        {/if}
    </div>
    <div class="form-group">
        <label for="text_titulo">{$lenguaje.foro_form_titulo}:</label>
        <input type="text" placeholder="{$lenguaje.foro_form_titulo}" class="form-control" id="text_titulo" name="text_titulo" value="{$foro.For_Titulo|default:""}">
    </div>
    {if $Form_Funcion!="query"}
    <div class="form-group">
        <label for="text_resumen">{$lenguaje.foro_form_resumen}:</label>
        <textarea type="text" placeholder="{$lenguaje.foro_form_resumen}" class="form-control" id="text_resumen" name="text_resumen">{$foro.For_Resumen|default:""}</textarea>
    </div>
    <div class="form-group">
        <label for="text_palabras_claves">{$lenguaje.foro_form_etiquetas}:</label>
        <input type="text" placeholder="{$lenguaje.foro_form_etiquetas}" class="form-control" id="text_palabras_claves" name="text_palabras_claves" value="{$foro.For_PalabrasClaves|default:""}">
    </div>
    {/if}
    <div class="form-group">
        <label for="text_descripcion">{$lenguaje.foro_form_descripcion}</label>
        <textarea type="text" class="form-control" id="text_descripcion" name="text_descripcion">
        {$foro.For_Descripcion|default:""}
        </textarea>
    </div>
