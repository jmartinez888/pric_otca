(function(Vue) {

    var tpl = `
            <div class="media" :id="'indicador-' + indicador.id">
                <div class="media-left">
                    <a href="#">
                        <img class="media-object"  :src="indicador.image" data-holder-rendered="true" >
                    </a>
                </div>
                <div class="media-body">
                    <h4 class="media-heading">{literal}{{indicador.titulo}}{/literal}</h4>
                    <p>
                    {literal}{{indicador.descripcion}}{/literal}
                    </p>
                    <p class="pb-4">
                        <button v-if="indicador.estado_item == 1" data-toggle="tooltip" data-placement="bottom" data-accion="visible" class="btn btn-default btn-sm glyphicon glyphicon-eye-open estado-rol btn-acciones"  data-estado="" :data-id="indicador.id"  data-nombre="" title="{$lenguaje['str_visible']}"  @click="onClick_ocultar(indicador.id)"> </button>
                        <button v-if="indicador.estado_item == 0" data-toggle="tooltip" data-placement="bottom" data-accion="oculto" class="btn btn-default btn-sm glyphicon glyphicon-eye-close estado-rol btn-acciones"  data-estado="" :data-id="indicador.id"  data-nombre="" title="{$lenguaje['str_oculto']}"  @click="onClick_mostrar(indicador.id)"> </button>
                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-acciones btn-sm glyphicon glyphicon-edit" title="{$lenguaje['str_editar']}" :href="'{$_layoutParams.root}difusion/indicador/' + indicador.id +'/edit'"></a>
                        <button data-toggle="tooltip" data-placement="bottom" data-accion="estado" class="btn btn-default btn-sm glyphicon glyphicon-trash estado-rol btn-acciones"  data-estado="" :data-id="indicador.id"  data-nombre="" title="{$lenguaje['str_cambiar_estado']}"  @click="onClick_btnEiminar(indicador.id)"> </button>
                    </p>
                </div>
            </div>
        `;

    Vue.component('difusion-indicador', {
      props: ['indicador'],
        // data: function () {
        //     return {
        //         indicador: null

        //     }
        // },
        template: tpl,
        methods: {
            onClick_ocultar: function (id) {
                let params = new FormData()
                params.append('id', id)
                axios.post(_root_lang + 'difusion/indicador/' + id + '/update/ocultar', params).then( res => {
                    console.log(res.data.success)
                    if (res.data.success) {
                        msg.success(res.data.msg)
                        this.indicador.estado_item = 0
                    }
                })
            },
            onClick_mostrar: function (id) {
                let params = new FormData()
                params.append('id', id)
                axios.post(_root_lang + 'difusion/indicador/' + id + '/update/mostrar', params).then( res => {
                    console.log(res.data.success)
                    if (res.data.success) {
                        msg.success(res.data.msg)
                        this.indicador.estado_item = 1
                    }
                })
            },
            onClick_btnEiminar: function (e) {
                axios.delete(_root_lang + 'difusion/indicador/'+ e +'/delete').then(res => {
                    console.log(res.data)
                    if (res.data.success) {
                        msg.success(res.data.msg)
                        $('#container-indicador-' + e).remove()
                    }
                })
            }
        },
        created () {
            // axios.get(_root_lang + 'difusion/contenido/' + this.id).then(res => {
            //     console.log(res.data)
            //     this.indicador = res.data
            // })
            // console.log(this.id)
        },
        mounted: function () {
            $('#indicador-' + this.indicador.id + ' [data-toggle="tooltip"]').tooltip();
        }
    })
}(Vue))
