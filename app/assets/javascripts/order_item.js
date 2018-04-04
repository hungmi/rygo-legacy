$(document).on("change", "#order_item_cloth_id", function() {
	if (this.value.length > 0) {
		$.get({
			url: `/admin/cloths/${this.value}`,
			dataType: 'script'
		})	
	} else {
		$("#orderItemImgCarousel").html('<img class="w-100" src="https://dummyimage.com/600x400/000000/fff&amp;text=衣服品番を選択してください">')
	}
})

$(document).on("change", "#order_item_deliver_month", function() {
	console.log(this.value.length)
	if (this.value.length === 0) {
		document.querySelector("#order_item_deliver_period").classList.add("d-none")
	} else {
		document.querySelector("#order_item_deliver_period").classList.remove("d-none")
	}
})

$(document).on("change", "#q_deliver_month_eq", function() {
	console.log(this.value.length)
	if (this.value.length === 0) {
		document.querySelector("#q_deliver_period_eq").classList.add("d-none")
	} else {
		document.querySelector("#q_deliver_period_eq").classList.remove("d-none")
	}
})