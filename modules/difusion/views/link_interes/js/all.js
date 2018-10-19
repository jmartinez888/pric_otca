Vue.component('link-interes', {
	props: ['url', 'titulo', 'descripcion'],
	template: '#link_interes',
})

new Vue({
	el: '#vue_container',
	data: function () {
		return {
			links_interes: [],
			length: 5,
			start: 0,
			buscar: ''
		}
	},
	methods: {
		loadResult: function () {
			axios.get(_root_lang + 'difusion/link_interes/all', {params: {
				length: this.length,
				start: this.start,
				buscar: this.buscar
			}}).then(res => {
				this.links_interes = res.data
			})
		},
		onSubmit_buscar: function () {
			this.loadResult()
		},
		onCLick_verMas: function () {
			this.start = this.start + this.length
			axios.get(_root_lang + 'difusion/link_interes/all', {params: {
				length: this.length,
				start: this.start,
				buscar: this.buscar
			}}).then(res => {
				this.links_interes.push(...res.data)
			})
		}
	},
	created: function () {
		this.loadResult()
	}
})