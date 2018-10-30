new Vue({
	el: '#index_banner',
	data: function () {
		return {
			banners: [],
			buscar: '',
			start: 0,
			length: 3,
			page: 0,
			disable: {
				prev: true,
				next: true
			}
		}
	},
	methods: {
		onClick_pageNext: function () {
			if (!this.disable.next) {
				this.start += this.length
				this.loadBanner()
			}
		},
		onClick_pagePrev: function () {
			if (!this.disable.prev) {
				this.start -= this.length
				this.loadBanner()
			}
		},
		loadBanner: function () {
			this.disable.next = false
			this.disable.prev = false
			axios.get(_root_lang + 'difusion/banner/json/index', {params: {
				q: this.buscar,
				l: this.length,
				s: this.start
			}}).then(res => {
				if (res.data.length < this.length && this.start >= 0) {
					this.disable.next = true
					if (this.start == 0)
						this.disable.prev = true
				} else if (this.start == 0){
					this.disable.prev = true
				}
				this.banners = res.data
			})
		},
		onSubmit_buscar: function () {
			this.start = 0
			this.loadBanner()
		}
	},
	created: function () {
		console.log(this)
		this.loadBanner()
		// axios.get(_root_lang + 'difusion/banner/json/index', {params: {l: this.length, s: this.start}}).then(res => {
		// 	if (res.data.length == 0 && this.start > 0) {
		// 		this.disable.next = true
		// 	} else if (this.start == 0){
		// 		this.disable.prev = true
		// 	}
		// 	this.banners = res.data
		// })
	},
	mounted: function () {

	}
})