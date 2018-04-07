<link href="{BASE_URL}modules/elearning/views/uploader/css/uploader.css" rel="stylesheet" />
<div class="modal fade" id="panel-uplader" tabindex="-5" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-focus-on="input:first">
    <div class="modal-dialog modal-xm">
       <div class="panel">
           <div class="panel-heading panel-uplader-header">
               <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-add"></span>
               <div id="panel-uploader-titulo" style="display: inline-block">Subir archivos</div>
               <button class="close" data-dismiss="modal" style="margin-top: 0px;color: white !important">&times;</button>
           </div>
           <div class="panel-body" style="padding: 10px 0px 10px 0px !important;">
             <div class="container-uploader">
               <center>
               <form id="frm-load-file" method="post" action="" enctype="multipart/form-data" class="box has-advanced-upload">
                 <div class="box__input">
                   <svg class="box__icon" width="50" height="43" viewBox="0 0 50 43">
                     <path d="M48.4 26.5c-.9 0-1.7.7-1.7 1.7v11.6h-43.3v-11.6c0-.9-.7-1.7-1.7-1.7s-1.7.7-1.7 1.7v13.2c0 .9.7 1.7 1.7 1.7h46.7c.9 0 1.7-.7 1.7-1.7v-13.2c0-1-.7-1.7-1.7-1.7zm-24.5 6.1c.3.3.8.5 1.2.5.4 0 .9-.2 1.2-.5l10-11.6c.7-.7.7-1.7 0-2.4s-1.7-.7-2.4 0l-7.1 8.3v-25.3c0-.9-.7-1.7-1.7-1.7s-1.7.7-1.7 1.7v25.3l-7.1-8.3c-.7-.7-1.7-.7-2.4 0s-.7 1.7 0 2.4l10 11.6z"></path>
                   </svg>
                   <input class="box__file" type="file" name="files[]" id="file" data-multiple-caption="1 files selected" multiple/>
                   <label for="file">
                     <center><strong>Seleccione un archivo</strong>
                     <span class="box__dragndrop"> o arrastre aquí</span>.</center>
                   </label>
                   <button class="box__button" type="submit">Subir</button>
                 </div>
                 <div class="box__uploading">Cargando&hellip;</div>
                 <div class="box__success">Archivo(s) subidos!</div>
                 <div class="box__error">Error! <span></span>.</div>
                 <input name="route" value="" hidden="hidden" id="hidden-uploader-route"/>
               </form>
               </center>
             </div>
           </div>
       </div>
   </div>
</div>
<script src="{BASE_URL}modules/elearning/views/uploader/js/uploader.js" type="text/javascript"></script>
