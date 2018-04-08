# Load the Rails application.
require_relative 'application'
require "browser/aliases"
Browser::Base.include(Browser::Aliases)

# Initialize the Rails application.
Rails.application.initialize!
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end