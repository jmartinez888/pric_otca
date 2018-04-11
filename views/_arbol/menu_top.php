<?php if (isset($this->_tree)): ?>     
    <?php for ($i = 0; $i < count($this->_tree); $i++): ?> 

        <li  <?php if (isset($this->_tree[$i]["hijo"]) && sizeof($this->_tree[$i]["hijo"]) > 0): ?> class="dropdown-submenu"<?php else : ?> class="nav-item" <?php endif; ?>>
               
            <a class="nav-link txt-color-black padding-10" href=" <?php if($this->_tree[$i]['Pag_Selectable']==0):
                            echo BASE_URL."index/index/".$this->_link.$this->_tree[$i]['Pag_IdPagina'];  
                            else : echo $this->_link.$this->_tree[$i]['Pag_Url']; endif;?>"
                            data-toggle="tooltip" data-placement="bottom" 
                            
                            title="<?php echo $this->_tree[$i]['Pag_Nombre'] ?>"> 
                            <?php if($this->_tree[$i]['Pag_IdPagina']==45): ?>
                                <i style="font-size:15px" class="fa fa-info-circle" ></i>
                            <?php echo $this->_tree[$i]['Pag_Nombre'] ?>
                            <?php endif;?>
                            <?php if($this->_tree[$i]['Pag_IdPagina']==46): ?>
                                <i style="font-size:15px" class="fa fa-envelope" ></i>
                            <?php echo $this->_tree[$i]['Pag_Nombre'] ?>
                            <?php endif;?>
                            <?php if($this->_tree[$i]['Pag_IdPagina']==5): ?>
                                <i class="fa fa-home f-z-19" ></i>
                            <?php else: echo $this->_tree[$i]['Pag_Nombre']; endif;?>
                        </a>   
            
        <?php
        if (!empty($this->_tree[$i]["hijo"]) && sizeof($this->_tree[$i]["hijo"]) > 0):
            $arbol = new Arbol();?>
        <ul class="nav navbar-nav" >
           <?php echo $arbol->enrraizar($this->_tree[$i]["hijo"], $this->_vista, $this->_link,$this->_seleccionado);?> 
        </ul>    

        <?php endif; ?>
        </li>
    <?php endfor; ?>    
<?php endif; ?>

       