new Vue({
	el: '#index_banner',
	data: function () {
		return {
			banners: []
		}
	},
	created: function () {
		console.log(this)
		axios.get(_root_lang + 'difusion/banner/json/index').then(res => {
			console.log(res.data)
			this.banners = res.data
		})
	},
	mounted: function () {

	}
})