<style>
  .header {
      background-color: rgba(0,0,0, .3);
      height: 80px;
  }
  .sidebar-left {
      padding-top: 20px;
      width: 100%;
      padding-right: 0px;
  }
  .side-menu {
      list-style: none;
      color: #222;
      padding: 10px 20px;
      cursor: pointer;
      background-color: #ffffff;
      font-size: 15px;
      text-align: left;
      border-color: #D5D5D5;
      border-style: solid;
      border-width: 1px;

    -moz-box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.6);
    -webkit-box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.6);
    box-shadow: 3px 3px 10px rgba(100, 100, 100, 0.6);
  }

  .side-menu2{
    border-left: 5px solid #355D3A;
  }

  .side-menu2:hover{
    border-left: 5px solid #355D3A;
    -moz-box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.6);
    -webkit-box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.6);
    box-shadow: 3px 3px 10px rgba(100, 100, 100, 0.6);
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
    <div class="sidebar-left">

        <ul>
          <a href="{BASE_URL}elearning/cursos/" class="nounderline">
          <div class="side-menu2"><li class="side-menu" style="position: relative">
          <i class="glyphicon glyphicon-book"></i>
          <span> Cursos</span></li></div>
          </a>
        </ul>
        {if Session::get('id_usuario')}
        <ul>
          <a href="{BASE_URL}elearning/cursos/miscursos" class="nounderline">
            <div class="side-menu2"><li class="side-menu" style="position: relative">
            <i class="glyphicon glyphicon-book"></i>
            <span> Mis Cursos</span></li></div>
          </a>
        </ul>
        <ul>
          <a href="{BASE_URL}elearning/gestion/_inicio" class="nounderline">
            <div class="side-menu2"><li class="side-menu" style="position: relative">
            <i class="glyphicon glyphicon-book"></i>
            <span> Mis Cursos (Docente)</span></li></div>
          </a>
        </ul>
        <ul>
          <a href="{BASE_URL}elearning/message/message" class="nounderline">
            <div class="side-menu2"><li class="side-menu" style="position: relative">
            <i class="glyphicon glyphicon-comment"></i>
            <span> Bandeja de Entrada</span></li></div>
          </a>
        </ul>
        <ul>
            <a href="{BASE_URL}elearning/certificado/miscertificados" class="nounderline">
                <div class="side-menu2"><li class="side-menu" style="position: relative">
                        <i class="glyphicon glyphicon-education"></i>
                        <span>Mis Certificados</span></li></div>
            </a>
        </ul>
        {/if}
        <ul>
          <a href="{BASE_URL}elearning/cursos/calendario" class="nounderline">
            <div class="side-menu2"><li class="side-menu" style="position: relative">
            <i class="glyphicon glyphicon-calendar"></i>
            <span> Calendario de Cursos</span></li></div>
          </a>
        </ul>

        <ul>
          <a href="{BASE_URL}elearning/certificado/verificar" class="nounderline">
            <div class="side-menu2"><li class="side-menu" style="position: relative">
            <i class="glyphicon glyphicon-education"></i>
            <span>Verificar Certificados</span></li></div>
          </a>
        </ul>
    </div>
  </div>
