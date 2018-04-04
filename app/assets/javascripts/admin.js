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
  // var input = document.getElementById("q_cloth_id_cont");
  // if (input !== null) {
		// new Awesomplete(input, { minChars: 1 });
  // }
  $("#q_cloth_id_eq").select2();
})