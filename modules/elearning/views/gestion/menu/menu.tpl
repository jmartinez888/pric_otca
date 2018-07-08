<style>
  .header {
      background-color: rgba(0,0,0, .3);
      height: 80px;
  }
  .sidebar-left {
      padding-top: 40px;
      width: 100%;
      padding-right: 0px;
  }
  .side-menu li {
      padding: 10px 20px;
      cursor: pointer;
      background-color: #ffffff;
      margin-bottom: 5px;
      font-size: 15px;
      text-align: left;
      height: auto;
      overflow: hidden;
      border-left: 4px solid #000000;
      box-shadow: 0 0 15px 1px #9e9e9e;
  }
  .contenedor {
      padding-top: 10px ;
      background-color: #ffffff;
      margin: 0px 0px 30px;
      box-shadow: 0 0 15px 1px #9e9e9e;

  }

  li {
      display: list-item;
      text-align: -webkit-match-parent;
      cursor: pointer;
      color: #3CACDF;
  }

  a.nounderline: link { text-decoration: none; }


  .course-image {
      width: 90%;
      border-radius: 10px;

  }



  .course-title {
      text-align: left;
      padding-left: 2px;
      font-size: 24px;
      font-weight: 600;
  }

  .course-page-progress-container {
      position: relative;
      display: inline-block;
      float: right;
      width: 130px;
      top: 20px;
  }

  .contenido {
      padding-top: 40px;
  background-color: rgba( 0,0,0, .2);
  }


  element.style {
      display: flex;
      align-items: center;
  }

  .course-page-info {
      display: inline-block;
      width: calc(100%);
      padding-right: 15px;
      padding-left: 15px;
      text-align: justify;
  }

  .course-page-description {
      margin-top: 10px;
      font-size: 14px;
  }

  p {
      margin: 0 0 10px;
  }

  .course-title-container {
      display: inherit;
      width: 300%;
  }
  .course-students-amount {
      margin-left: 15px;
      border: 1px solid #d2d2d2;
      padding: 5px 8px 5px;
      display: inline-block;
      background-color: #f9f9f9;
      color: #191919;
  }
  .course-payment-hint {
      background-color: goldenrod;
      width: 100%;
      padding: 10px 4px 2px 10px;
      margin-bottom: 15px;
      border-radius: 3px;
  }


  .course-payment-div {
      margin-left: 15px;
      overflow: hidden;
      padding: 10px 8px;
      margin-top: 10px;
      width: 94%;
  }

  .course-module {
      min-height: 84px;
      max-height: 84px;
      margin-bottom: 15px;
      position: relative;
      background-color: #f1f1f1;
      padding: 2px;
  }

  .course-module-info {
      width: 70%;
      display: inline-block;
      position: absolute;
      bottom: 10px;
      right: 10px;
      padding-left: 15px;
  }


  .course-modules-container {
      padding: 10px 15px;
      margin-top: 5px;
  }

  .course-modules-column-1 {
      margin-right: 1%;
  }

  .course-modules-column {
      width: 48%;
      display: block;
      position: relative;
      float: left;
  }

  .course-module-image-container {
      position: absolute;
      width: 24%;
      display: inline-flex;
      max-width: 80px;
      justify-content: center;
      flex-direction: row;
      align-items: center;
      height: 100%;
      left: 10px;
  }

  .course-module-image {
      width: 100%;
      max-height: 80px;
      position: relative;
      bottom: 0;
      padding: 2px;
  }
  .course-module-info-title {
      overflow: hidden;
      max-height: 40px;
      font-size: 14px;
  }

  .course-modules-progress-bar-container {
      background-color: #ababab;
      overflow: hidden;
      max-height: 20px;
  }

  .cred-Uni {
      margin-left: 15px;
      width: 96%;
      padding: 5px 5px 8px;
      display: inline-block;
      background-color: rgba(0,0,0, .1);

  }
  ul{
    padding-left: 0px !important;
  }
</style>
<div class="col-lg-2" style="padding-left: 0px !important">
  ghjklñkjhghjklhlk
  <!--div class="sidebar-left">
    <div class="side-menu">
      <ul id="item-lista-curso">
          <li style="position: relative"><span> Mis Cursos (docente)</span></li>
      </ul>
      <ul id="item-ficha-curso">
          <li style="position: relative"><span> Ficha Curso</span></li>
      </ul>
      <ul id="item-modulos-curso">
        <li style="position: relative"><span> Mis modulos</span></li>
      </ul>
    </div>
  </div-->
</div>

<script type="text/javascript">
  setTimeout(function(){
    $("#item-lista-curso").click(function(){
      CargarPagina("gcurso/_view_mis_cursos", { id: $("#hidden_curso").val() }, false, $(this));
    });
    $("#item-ficha-curso").click(function(){
        CargarPagina("gcurso/_view_finalizar_registro", { id: $("#hidden_curso").val() }, false, $(this));
    });
    $("#item-modulos-curso").click(function(){
        CargarPagina("gmodulo/_view_modulos_curso", { id: $("#hidden_curso").val() }, false, $(this));
    });
  }, 400);
</script>
