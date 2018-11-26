(function(Vue) {

    var tpl = `
            <div class="thumbnail" :id="'banner-' + banner.id">
                <img :src="banner.image" alt="" style="width: 100%">
                <div class="caption">
                    <h3 style="margin-top: 0px; margin-bottom: 0px">{literal}{{banner.titulo}}{/literal}</h3>
                    <p>{literal}{{banner.descripcion}}{/literal}</p>
                    <p >

                        <button v-if="banner.estado_item == 1" data-toggle="tooltip" data-placement="bottom" data-accion="visible" class="btn btn-default btn-sm glyphicon glyphicon-eye-open estado-rol btn-acciones"  data-estado="" :data-id="banner.id"  data-nombre="" title="{$lenguaje['str_visible']}"  @click="onClick_ocultar(banner.id)"> </button>
                        <button v-if="banner.estado_item == 0" data-toggle="tooltip" data-placement="bottom" data-accion="oculto" class="btn btn-default btn-sm glyphicon glyphicon-eye-close estado-rol btn-acciones"  data-estado="" :data-id="banner.id"  data-nombre="" title="{$lenguaje['str_oculto']}"  @click="onClick_mostrar(banner.id)"> </button>
                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-acciones btn-sm glyphicon glyphicon-edit" title="{$lenguaje['str_editar']}" :href="'{$_layoutParams.root}difusion/banner/' + banner.id +'/edit'"></a>
                        <button data-toggle="tooltip" data-placement="bottom" data-accion="estado" class="btn btn-default btn-sm glyphicon glyphicon-trash estado-rol btn-acciones"  data-estado="" :data-id="banner.id"  data-nombre="" title="{$lenguaje['str_cambiar_estado']}"  @click="onClick_btnEiminar(banner.id)"> </button>
                    </p>
                  </div>
            </div>
        `;
    Vue.component('component', {
      props: ['banner'],
        // data: function () {
        //     return {
        //         banner: null

        //     }
        // },
        template: tpl,
        methods: {
            onClick_ocultar: function (id) {
                let params = new FormData()
                params.append('id', id)
                axios.post(_root_lang + 'difusion/banner/' + id + '/update/ocultar', params).then( res => {
                    console.log(res.data.success)
                    if (res.data.success) {
                        msg.success(res.data.msg)
                        this.banner.estado_item = 0
                    }
                })
            },
            onClick_mostrar: function (id) {
                let params = new FormData()
                params.append('id', id)
                axios.post(_root_lang + 'difusion/banner/' + id + '/update/mostrar', params).then( res => {
                    console.log(res.data.success)
                    if (res.data.success) {
                        msg.success(res.data.msg)
                        this.banner.estado_item = 1
                    }
                })
            },
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
