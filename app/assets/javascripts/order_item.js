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