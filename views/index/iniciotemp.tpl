{extends 'template.tpl'}
{block 'css'}
<style type="text/css" media="screen">
    .mainstage .main_story .transition_layer {
        background-repeat: no-repeat !important;
        background-size: 100%;
    }
</style>
{/block}
{block 'contenido'}
<div id="inicio">

    <!-- NOTICIAS -->
    <div id="TB" class="jsoft-bloque padding-t-10">
        <div id="page col-md-12">
            <div id="banner col-md-12">
                {* <objtemplate objtemplate_id="517" objtemplate_filename="getunik.pandaorg3.h-spotlight"></objtemplate> *}

                {* <objtemplate objtemplate_id="517" objtemplate_filename="getunik.pandaorg3.h-spotlight"> *}
                    <div class="row">
                        <div class="main-column">
                            <div class="container col-sm-12">
                                <div class="mainstage col-sm-12">
                                    {* <a class="main_story" href="http://www.otca-oficial.info/news/details/341" style="background-image: url({$_layoutParams.ruta_img}slider_noticias/noticia1.JPG); background-color: #000000;">
                                        <p class="alt">Cinco de las siete especies de tortugas marinas que existen en la costa peruana y todas ...</p>
                                    </a> *}
                                </div>
                            </div>
                        </div>
                    </div>
                {* </objtemplate> *}
            </div>
        </div>
    </div>


                        <hr>
    <!-- SERVICIOS Y MAPA DE DATOS Y CIFRAS-->
    <div class="row padding-10">
        <div class="col col-md-8 col-sm-12 col-xs-12 ">
            <div class="cont-recursos row">
                <div class="tit-float-left-top">
                    Servicios PRIC

                </div>

                <div class="col-sm-6 col-md-4">
                    <div class="thumbnail">
                        <img  src="{$_layoutParams.ruta_img}m_cursos.png">
                        <div class="caption">
                        <h3>Cursos</h3>
                        <p style="text-align: justify;">Actualmente la plataforma PRIC ofrece una gran variedad de cursos en modalidades mooc y e-learning, tanto de larga duración, Másters y Expertos, como de Formación Continua y Especializada ...</p>
                        <p><a href="{$_layoutParams.root}elearning" class="btn-jsoft btn btn-primary" role="button">ver más</a></p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-4">
                    <div class="thumbnail">
                        <img  src="{$_layoutParams.ruta_img}m_discusiones.png">
                        <div class="caption">
                        <h3>Discusiones</h3>
                        <p style="text-align: justify;">Discusión en línea asincrónico donde las personas publican mensajes alrededor de un tema, creando de esta forma un hilo de conversación jerárquico; los foros o discusiones, a su vez, ...</p>
                        <p><a href="{$_layoutParams.root}foro" class="btn-jsoft btn btn-primary" role="button">ver más</a></p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-4">
                    <div class="thumbnail">
                        <img  src="{$_layoutParams.ruta_img}m_documentos.png">
                        <div class="caption">
                        <h3>Documentos</h3>
                        <p style="text-align: justify;">En la actualidad lo habitual es almacenar toda la información de manera digital con el software pertinente y este es necesario que, entre otras cosas, ofrezca personalización e interoperatividad.</p>
                        <p><a href="{$_layoutParams.root}dublincore/documentos" class="btn-jsoft btn btn-primary" role="button">ver más</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- EVENTOS E INTERESES -->
        <div class="col col-md-4 col-sm-12 col-xs-12 back-color-white" style="border-left: 1px solid #ebeaea; padding-left: 10px;">
            {include 'tab_interes.tpl'}
        </div>

        <div class="col col-md-12 col-sm-12 col-xs-12">
           <hr>
        </div>
        <!-- EVENTOS E INTERESES -->

        <div class="col col-md-12 col-sm-12 col-xs-12">
            <div class=" margin-0 " style="background: url({$_layoutParams.ruta_img}frontend/bg-contador.png); heigh:60vh">
                <div class="tit-float-left-top" style="margin-top: 17px;">
                Datos y cifras
                </div>

                    <div id="map" style="height: 60vh;width:100%"></div>
                 <a href="#" class="mas_cifras"> +</a>
                </div>

            </div>
        </div>
    </div>
</div>

{/block}

{block 'template'}

    {* <template id="interes">
        <a target="_blank" :href="'{$_layoutParams.root}difusion/contenido/' + id" class="col-md-12 col-sm-12 col-xs-12  link-tabs-jsoft">
            <div class="col-md-4 col-sm-4 col-xs-4  py-3 px-2">
                <img :src="difusion.ODif_Image" class="w-100">
            </div>
            <div class="col-md-8 col-sm-8 col-xs-8">
                <div class="card-block ">
                    <h3 class="card-title" style="font-size: 15px;">{literal}{{ difusion.ODif_Titulo }}{/literal}</h3>
                    <p class="card-text" style="font-size: 12px;"><i class="fa fa-calendar"></i> Publicado: {literal}{{ moment().format('YYYY-MM-DD') }}{/literal}</p>
                </div>
            </div>
        </a>
    </template> *}
{/block}
{block 'js'}
    <script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBM7aMHbWEPvofhwPQuKPnijDmQ0_AAkrI" type="text/javascript"></script>
    <script src="{BASE_URL}public/vendors/js-info-bubble/src/infobubble-compiled.js" type="text/javascript"></script>
    <script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
    <script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
    <script src="{$_layoutParams.ruta_js}global.js" type="text/javascript"></script>
    <script>
        var banners = {$banners};
    </script>
    <script src="{$_layoutParams.root}difusion/contenido/vcomponent/interes"></script>
    <script src="{BASE_URL}views/index/js/inicio.js" type="text/javascript"></script>

    <!-- <script type="text/javascript">
        var jQuery_1_5_7 = $.noConflict(true);
    </script> -->

    <script type="text/javascript">
        /* <![CDATA[ */
        /* this JSON copied from current, live site for the sake of testing. In production it would be populated dynamically.*/
        // $('.mainstage').wwfMainstage([{

        //     'backgroundImage': '{$_layoutParams.ruta_img}slider_noticias/noticia1.JPG',
        //     'thumbnail': '{$_layoutParams.ruta_img}slider_noticias/thumbnail/noticia1.JPG',
        //     'credit':'©  OTCA | foto ceremonia: Marcos Corrêa/PR',
        //     'categoria': 'NOTICIA',
        //     'headline': 'Potencialidades - Plantas para uso medicinal ou cosmético.',
        //     // 'headline2': 'Urgen compromisos para su conservación',

        //     'href': '{$_layoutParams.root}noticias/index/index/341',
        //     'storyTitle': 'Potencialidades - Plantas para uso medicinal ou cosmético ...'


        // },
        // {

        //     'backgroundImage': '{$_layoutParams.ruta_img}slider_noticias/noticia2.jpg',
        //     'thumbnail': '{$_layoutParams.ruta_img}slider_noticias/thumbnail/noticia2.jpg',
        //     'credit':'© OTCA',
        //     'categoria': 'NOTICIA',
        //     'headline': 'La selva amazónica: formada hace 20 millones de años',
        //     // 'headline2': 'WWF lanza Premio Periodístico en el Perú',

        //     //'href': 'http://www.otca-oficial.info/news/details/333',
        //     'href': '{$_layoutParams.root}noticias/index/index/333',
        //     'storyTitle': 'La selva amazónica: formada hace 20 millones de años al surgir de los andes...'
        // },
        // {

        //     'backgroundImage': '{$_layoutParams.ruta_img}slider_noticias/noticia3.jpg',
        //     'thumbnail': '{$_layoutParams.ruta_img}slider_noticias/thumbnail/noticia3.jpg',
        //     'credit':'© OTCA',
        //     'categoria': 'INVESTIGACIÓN',
        //     'headline': 'La atlántida amazónica.',
        //     // 'headline2': 'Iniciativa logra recuperar y reforestar suelos degradados',

        //     //'href': 'http://www.otca-oficial.info/news/details/338',
        //     'href': '{$_layoutParams.root}noticias/index/index/338',
        //     'storyTitle': 'La atlántida amazónica, nuevas pruebas sedimentarias sufieren que, hace millones de años, una parte de ...'
        // },
        // {

        //     'backgroundImage': '{$_layoutParams.ruta_img}slider_noticias/noticia4.jpg',
        //     'thumbnail': '{$_layoutParams.ruta_img}slider_noticias/thumbnail/noticia4.jpg',
        //     'credit':'© CAF | OTCA',
        //     'categoria': 'INVESTIGACIÓN',
        //     'headline': '¿Cuándo se formó el río Amazonas?',
        //     // 'headline2': 'Promoviendo su conservación en el litoral peruano',

        //     //'href': 'http://www.otca-oficial.info/news/details/328',
        //     'href': '{$_layoutParams.root}noticias/index/index/328',
        //     'storyTitle': 'Un nuevo estudio data el nacimiento del río más caudaloso del mundo en más de 9 millones de años ...'
        // },



        // ]);

    </script>
{/block}
