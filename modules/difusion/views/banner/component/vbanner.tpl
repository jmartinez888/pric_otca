(function(Vue) {

    var tpl = `
            <div class="thumbnail" :id="'banner-' + banner.id">
                <img :src="banner.image" alt="" style="width: 100%">
                <div class="caption">
                    <h3 style="margin-top: 0px; margin-bottom: 0px">{literal}{{banner.titulo}}{/literal}</h3>
                    <p>{literal}{{banner.descripcion}}{/literal}</p>
                    <p >
                        <button data-toggle="tooltip" data-placement="bottom" data-accion="estado" class="btn btn-default btn-sm glyphicon glyphicon-trash estado-rol btn-acciones"  data-estado="" :data-id="banner.id"  data-nombre="" title="{$lenguaje['str_cambiar_estado']}"  @click="onClick_btnEiminar(banner.id)"> </button>
                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-acciones btn-sm glyphicon glyphicon-edit" title="{$lenguaje['str_editar']}" :href="'{$_layoutParams.root}difusion/banner/' + banner.id +'/edit'"></a></p>
                  </div>
            </div>
        `;

    Vue.component('difusion-banners', {
      props: ['banner'],
        // data: function () {
        //     return {
        //         banner: null

        //     }
        // },
        template: tpl,
        methods: {
            onClick_btnEiminar: function (e) {
                axios.delete(_root_lang + 'difusion/banner/'+ e +'/delete').then(res => {
                    console.log(res.data)
                    if (res.data.success) {
                        msg.success(res.data.msg)
                        $('#container-banner-' + e).remove()
                    }
                })
            }
        },
        created () {
            // axios.get(_root_lang + 'difusion/contenido/' + this.id).then(res => {
            //     console.log(res.data)
            //     this.banner = res.data
            // })
            // console.log(this.id)
        },
        mounted: function () {
            $('#banner-' + this.banner.id + ' [data-toggle="tooltip"]').tooltip();
        }
    })
}(Vue))
