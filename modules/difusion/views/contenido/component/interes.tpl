(function(Vue) {

    var tpl = `
        <a target="_blank" :href="'{$_layoutParams.root}difusion/contenido/' + id" class="col-md-12 col-sm-12 col-xs-12  link-tabs-jsoft">
        <div class="col-md-4 col-sm-4 col-xs-4  py-3 px-2">
            <img :src="'{BASE_URL}files/difusion/contenido/' + difusion.ODif_IdDifusion + '/' + difusion.ODif_Image" class="w-100">
        </div>
        <div class="col-md-8 col-sm-8 col-xs-8">
            <div class="card-block ">
                <h3 class="card-title" style="font-size: 15px;">{literal}{{ difusion.ODif_Titulo }}{/literal}</h3>
                <p class="card-text" style="font-size: 12px;"><i class="fa fa-calendar"></i> Publicado: {literal}{{ moment().format('YYYY-MM-DD') }}{/literal}</p>
            </div>
        </div>
    </a>`;

    Vue.component('interes', {
      props: ['id', 'tipo'],
        data: function () {
            return {
                difusion: {
                    ODif_Image: ''
                }
            }
        },
        template: tpl,
        created () {
            axios.get(_root_lang + 'difusion/contenido/' + this.id).then(res => {
                this.difusion = res.data.data
            })
        }
    })
}(Vue))
