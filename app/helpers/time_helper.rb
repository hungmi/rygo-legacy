# app/helpers/time.rb
module TimeHelper
	def timeago(time, options = {})
		options[:class] ||= "timeago"
		content_tag(
			:time,
			time.to_s,
			options.merge(datetime: time.getutc.iso8601)
		) if time
	end

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