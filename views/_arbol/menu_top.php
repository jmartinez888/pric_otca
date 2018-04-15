<?php if (isset($this->_tree)): ?>     
    <?php for ($i = 0; $i < count($this->_tree); $i++): ?> 

        <li  <?php if (isset($this->_tree[$i]["hijo"]) && sizeof($this->_tree[$i]["hijo"]) > 0): ?> class="dropdown" <?php else : ?> class="nav-item" <?php endif; ?>>
            <a href=" <?php if($this->_tree[$i]['Pag_Selectable']==0):
                echo BASE_URL."index/index/".$this->_link.$this->_tree[$i]['Pag_IdPagina'];  
                else : echo $this->_link.$this->_tree[$i]['Pag_Url']; endif;?>"
                <?php if (isset($this->_tree[$i]["hijo"]) && sizeof($this->_tree[$i]["hijo"]) > 0): ?> 
                        href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
                        class="nav-link dropdown-toggle txt-color-black padding-10"
                <?php else : ?>
                        class="nav-link txt-color-black padding-10" 
                <?php endif; ?>
                title="<?php echo $this->_tree[$i]['Pag_Nombre'] ?>" > 

                

                <?php if($this->_tree[$i]['Pag_IdPagina']==9): ?>
                        <?php echo $this->_tree[$i]['Pag_Nombre'] ?>
                        <span class="caret"></span>
                <?php else: 
                            if($this->_tree[$i]['Pag_IdPagina']==5): ?>
                                <i class="fa fa-home f-z-19" ></i>
                            <?php else: echo $this->_tree[$i]['Pag_Nombre']; endif;?>
                <?php endif;?>
            </a>   
        <?php
        if (!empty($this->_tree[$i]["hijo"]) && sizeof($this->_tree[$i]["hijo"]) > 0):
            $arbol = new Arbol();?>
        <ul class="dropdown-menu" >
           <?php echo $arbol->enrraizar($this->_tree[$i]["hijo"], $this->_vista, $this->_link,$this->_seleccionado);?> 
        </ul>    

        <?php endif; ?>
        </li>
    <?php endfor; ?>    
<?php endif; ?>

       