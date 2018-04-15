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

  .sidebar-left li {
      display: list-item;
      text-align: -webkit-match-parent;
  }

  a.nounderline: link { text-decoration: none; }

 .sidebar-left ul{
    padding-left: 0px !important;
  }
</style>
  <div class="col-md-2 col-xs-12 col-sm-4 col-lg-2" style="padding-left: 0px !important">
    <div class="sidebar-left">
      <div class="side-menu">
        <ul>
          <a href="{BASE_URL}foro/" class="nounderline">
            <li style="position: relative"><span>Home</span></li>
          </a>
        </ul>
       
        <ul>
          <a href="#" class="nounderline">
            <li style="position: relative"><span>Foros</span></li>
          </a>
        </ul>
        <ul>
          <a href="#" class="nounderline">
            <li style="position: relative"><span>Webinars</span></li>
          </a>
        </ul>
             <ul>
          <a href="#" class="nounderline">
            <li style="position: relative"><span>Agenda</span></li>
          </a>
        </ul>
     
      </div>
    </div>
  </div>
