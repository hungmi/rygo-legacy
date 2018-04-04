module OrderItemHelper
	def which_deliver_period(date)
		if date.to_i <= 10 && date.to_i > 0
			"up"
		elsif date.to_i > 10 && date.to_i < 21
			"middle"
		elsif date.to_i > 0
			"down"
		end
	end

	def render_deliver_period_selected(order_item)
		order_item.persisted? ? order_item.deliver_period : which_deliver_period(Date.today.strftime("%d"))
	end
end