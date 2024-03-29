//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery.min
//= require popper
//= require bootstrap
//= require jquery.timeago
//= require previewable
//= require order_item

$(document).on("change", "[name*='remove_images']", function() {
	console.log(this.checked)
	if (this.checked === true) {
		$(this).parents("div.card").find("img.card-img-top").css("opacity", "0.4")
	} else {
		$(this).parents("div.card").find("img.card-img-top").css("opacity", "1")
	}
})

$(document).on("turbolinks:load", function() {
  flatpickr("#order_item_deliver_date", { "locale": "ja" });
  $("time.timeago").timeago();
  $(".select2").select2();
})

$(document).on("click", "#btnPrint", function () {
	window.print();
});