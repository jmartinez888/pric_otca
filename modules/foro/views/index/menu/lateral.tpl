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
    .side-menu li {
        color: #222;
        padding: 10px 20px;
        cursor: pointer;
        background-color: #ffffff;
        margin-bottom: 5px;
        font-size: 15px;
        text-align: left;
        height: auto;
        overflow: hidden;
        border-left: 5px solid #355D3A;
        -moz-box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.6);
        -webkit-box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.6);
        box-shadow: 3px 3px 10px rgba(100, 100, 100, 0.6);
    }
    .side-menu2:hover{
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

    .sidebar-left li {
        display: list-item;
        text-align: -webkit-match-parent;
    }

    a.nounderline: link { text-decoration: none; }

    .sidebar-left ul{
        padding-left: 0px !important;
    }
</style>
<div class="col-md-2 col-xs-12 col-sm-3 col-lg-2" style="padding-left: 0px !important">
    <div class="sidebar-left">
        <div class="side-menu">
            <ul>
                <a href="{$_layoutParams.root}foro/" class="nounderline">
                    <div class="side-menu2">
                        <li style="position: relative"><span>Home</span></li>
                    </div>
                </a>
            </ul>
            <ul>
                <a href="{$_layoutParams.root}foro/index/forum" class="nounderline">
                    <div class="side-menu2">
                        <li style="position: relative"><span>{$lenguaje.foro_admin_tematica}</span></li>
                    </div>
                </a>
            </ul>
            <ul>
                <a href="{$_layoutParams.root}foro/index/query" class="nounderline">
                    <div class="side-menu2">
                        <li style="position: relative"><span>Consultas</span></li>
                    </div>
                </a>
            </ul>
            <ul>
                <a href="{$_layoutParams.root}foro/index/webinar" class="nounderline">
                    <div class="side-menu2">
                        <li style="position: relative"><span>Webinars</span></li>
                    </div>
                </a>
            </ul>
            <ul>
                <a href="{$_layoutParams.root}foro/index/workshop" class="nounderline">
                    <div class="side-menu2">
                        <li style="position: relative"><span>Workshop</span></li>
                    </div>
                </a>
            </ul>  
            <ul>
                <a href="{$_layoutParams.root}foro/index/agenda" class="nounderline">
                    <div class="side-menu2">
                        <li style="position: relative"><span>Agenda</span></li>
                    </div>
                </a>
            </ul>
            <ul>
                <a href="{$_layoutParams.root}foro/index/historico" class="nounderline">
                    <div class="side-menu2">
                        <li style="position: relative"><span>Histórico</span></li>
                    </div>
                </a>
            </ul>
            <ul>
                <a href="{$_layoutParams.root}foro/index/statistics" class="nounderline">
                    <div class="side-menu2">
                        <li style="position: relative"><span>Estadisticas</span></li>
                    </div>
                </a>
            </ul>

        </div>
    </div>
</div>
