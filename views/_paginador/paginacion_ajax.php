<?php if(isset($this->_paginacion) && !empty($this->_paginacion)): ?>

<nav style="text-align: center;"> 
    <ul class="pagination" >
        <?php if($this->_paginacion['primero']): ?>

            <li><a class="pagina" nombre="<?php echo $this->_nombrelista;?>" parametros="<?php echo $this->_parametros;?>"  pagina="<?php echo $this->_paginacion['primero']; ?>" total_registros="<?php echo $this->_paginacion['total_registros']; ?>" href="javascript:void(0);">&Lt;</a></li>

        <?php else: ?>

            <li class="disabled"><span>&Lt;</span></li>

        <?php endif; ?>

        <?php if($this->_paginacion['anterior']): ?>

            <li><a class="pagina" nombre="<?php echo $this->_nombrelista;?>" parametros="<?php echo $this->_parametros;?>"  pagina="<?php echo $this->_paginacion['anterior']; ?>" total_registros="<?php echo $this->_paginacion['total_registros']; ?>" href="javascript:void(0);">&lt;</a></li>

        <?php else: ?>

            <li class="disabled"><span>&lt;</span></li>

        <?php endif; ?>

        <?php for($i = 0; $i < count($this->_paginacion['rango']); $i++): ?>

            <?php if($this->_paginacion['actual'] == $this->_paginacion['rango'][$i]): ?>

                <li class="active"><span><?php echo $this->_paginacion['rango'][$i]; ?></span></li>

            <?php else: ?>

                <li>
                    <a class="pagina" nombre="<?php echo $this->_nombrelista;?>" parametros="<?php echo $this->_parametros;?>"  pagina="<?php echo $this->_paginacion['rango'][$i]; ?>" total_registros="<?php echo $this->_paginacion['total_registros']; ?>" href="javascript:void(0);">
                        <?php echo $this->_paginacion['rango'][$i]; ?>
                    </a>
                </li>

            <?php endif; ?>

        <?php endfor; ?>

        <?php if($this->_paginacion['siguiente']): ?>

            <li><a class="pagina" nombre="<?php echo $this->_nombrelista;?>" parametros="<?php echo $this->_parametros;?>"  pagina="<?php echo $this->_paginacion['siguiente']; ?>" total_registros="<?php echo $this->_paginacion['total_registros']; ?>" href="javascript:void(0);">&gt;</a></li>

        <?php else: ?>

            <li class="disabled"><span>&gt;</span></li>

        <?php endif; ?>

        <?php if($this->_paginacion['ultimo']): ?>

            <li><a class="pagina" nombre="<?php echo $this->_nombrelista;?>" parametros="<?php echo $this->_parametros;?>"  pagina="<?php echo $this->_paginacion['ultimo']; ?>" total_registros="<?php echo $this->_paginacion['total_registros']; ?>" href="javascript:void(0);">&Gt;</a></li>

        <?php else: ?>

            <li class="disabled"><span>&Gt;</span></li>

        <?php endif; ?>
    </ul>
</nav>
<div style="text-align: center">
    <p>
        <small>
           <?php echo $this->_lenguaje["paginador_pagina"]." "; echo $this->_paginacion['actual']; echo " ".$this->_lenguaje["paginador_de"]?>  <?php echo $this->_paginacion['total']; ?>
            
            <br>
        </small>
    </p>
</div>

<?php endif; ?>