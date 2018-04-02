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
end