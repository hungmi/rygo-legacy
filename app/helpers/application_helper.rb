module ApplicationHelper
def meta_title
  @page_title.present? ? '#{@page_title} | RYGO' : 'RYGO'
end

def notice_message(opts = {})
  if flash.any?
    flash.map do |type, message|
      content_tag :div, class: "alert alert-#{type}", role:'alert' do
        content_tag :strong, type.capitalize
        message
      end
    end[0]
  end
end

def not_desktop?
	browser = Browser.new(request.user_agent)
	browser.mobile? || browser.tablet?
end

def searching_customer?
	params[:q].try(:[], :customer_id_eq).present?
end
end
