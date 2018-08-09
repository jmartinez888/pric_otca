                    
                        {if Session::get('autenticado')}
                            {if $valoracion_foro == 0}
                            <button title="Me gusta" class="btn-like btn pull-right" id="ValorarForo" name="ValorarForo" id_foro="{$foro.For_IdForo}" id_usuario="{Session::get('id_usuario')}" valor="{$valoracion_foro}"  ajaxtpl="valoraciones_foro">
                                <i class="glyphicon glyphicon-heart-empty"></i>
                                <strong>&nbsp;{$Nvaloraciones_foro}</strong>
                            </button>
                            {else}
                            <button title="Ya no me gusta" class="btn btn-info pull-right" id="ValorarForo" name="ValorarForo" id_foro="{$foro.For_IdForo}" id_usuario="{Session::get('id_usuario')}" valor="{$valoracion_foro}"  ajaxtpl="valoraciones_foro">
                                <i class="glyphicon glyphicon-heart-empty"></i>
                                <strong>&nbsp;{$Nvaloraciones_foro}</strong>
                            </button>
                            {/if}                        
                        {else}
                        <button data-toggle="modal" data-target="#modal-login" id="login-form-link" class="btn btn-default btn-comentar">
                            <i class="glyphicon glyphicon-comment"></i>
                        &nbsp;Comentar</button>
                        <button data-toggle="modal" data-target="#modal-login" id="login-form-link" class="btn-like btn  pull-right">
                            <i class="glyphicon glyphicon-heart-empty"></i>
                            <strong>&nbsp;{$Nvaloraciones_foro}</strong>
                        </button>
                        {/if}
                   