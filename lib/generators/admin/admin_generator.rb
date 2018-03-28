require "rails/generators/resource_helpers"

module Rails
  module Generators
		class AdminGenerator < Rails::Generators::NamedBase
		  source_root File.expand_path('templates', __dir__)
      include ResourceHelpers
      check_class_collision suffix: "Controller"
		  class_option :namespace, type: :string, default: 'admin'
		  class_option :orm, default: 'admin', banner: "NAME", type: :string, required: true,
                         desc: "ORM to generate the controller for"
      argument :attributes, type: :array, default: [], banner: "field:type field:type"

		  def create_admin_controller_file
		  	template "admin/admin_controller.rb", "app/controllers/#{options[:namespace]}_controller.rb"
		  end

		  def create_admin_policy_file
		  	template "admin/admin_policy.rb", "app/policies/#{options[:namespace]}_policy.rb"
		  end

      def create_admin_css_file
        template "admin/admin.scss", "app/assets/stylesheets/#{options[:namespace]}.scss"
      end

      def create_admin_js_file
        template "admin/admin.js", "app/assets/javascripts/#{options[:namespace]}.js"
      end

      def create_admin_layout_file
        template "admin/admin.html.erb", "app/views/layouts/#{options[:namespace]}.html.erb"
      end

      def create_admin_nav_file
        template '_nav_top.html.erb', "app/views/#{options[:namespace]}/common/_nav_top.html.erb"
      end

      def create_admin_routes
        inject_into_file 'config/routes.rb', before: /^end/ do <<-RUBY.strip_heredoc
            get 'admin', to: redirect('/')
            namespace :#{options[:namespace]} do
              resources :#{plural_name}
              get 'signin', to: 'sessions#new'
              post 'signin', to: 'sessions#create'
              delete 'logout', to: 'sessions#destroy'
            end
          RUBY
        end
      end

      def setup_application_controller
        inject_into_file 'app/controllers/application_controller.rb', before: /^end/ do <<-RUBY.strip_heredoc
            private
            def user_not_authorized
              flash[:warning] = '請先登入。'
              redirect_to admin_signin_path(back_path: request.fullpath)
            end
          RUBY
        end

        inject_into_file 'app/controllers/application_controller.rb', after: /Base$/ do <<-RUBY.strip_heredoc

            include Pundit
            helper_method :current_user, :user_signed_in?
            after_action :verify_authorized

            def current_user
              @current_user ||= User.find_by_id(session[:user_id])
            end

            def user_signed_in?
              current_user.present?
            end

            rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
          RUBY
        end
      end

      def setup_assets_rb
        append_to_file 'config/initializers/assets.rb' do <<-RUBY.strip_heredoc

            Rails.application.config.assets.precompile += %w( admin.js admin.css )
          RUBY
        end
      end

      def setup_application_helper
        inject_into_file "app/helpers/application_helper.rb", before: /^end/ do <<-'RUBY'.strip_heredoc
            def meta_title
              @page_title.present? ? '#{@page_title} | 鴻妍搏命' : '鴻妍搏命工作室'
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
          RUBY
        end
      end

      ## 以下生成管理員、登入頁、登入授權
      def create_user_model
        template "model/user.rb", "app/models/user.rb"
        template "model/create_user.rb", "db/migrate/#{Time.now.strftime('%Y%m%d%H%M%S')}_create_user.rb"
      end

		  def copy_session_files
        copy_file "sessions/sessions.scss", "app/assets/stylesheets/sessions.scss"
        template "sessions/signin.html.erb", "app/views/sessions/new.html.erb"
        template "sessions/session_controller.rb", "app/controllers/sessions_controller.rb"
        template "sessions/session_policy.rb", "app/policies/session_policy.rb"
      end

      def copy_rake_files
        copy_file "rake/admin_user.rake", "lib/tasks/admin_user.rake"
        copy_file "rake/dev.rake", "lib/tasks/dev.rake"
        rake 'db:rebuild'
      end

      ## 以上生成管理員、登入頁、登入授權

      def copy_vendor_files
        default_vendor_folder_path = "vendor/assets"
        copy_file "vendor/js/jquery.min.js", "#{default_vendor_folder_path}/js/jquery.min.js"
        copy_file "vendor/js/jquery.timeago.js", "#{default_vendor_folder_path}/js/jquery.timeago.js"
        copy_file "vendor/css/_bootswatch.scss", "#{default_vendor_folder_path}/css/_bootswatch.scss"
        copy_file "vendor/css/_variables.scss", "#{default_vendor_folder_path}/css/_variables.scss"
        copy_file "vendor/css/bootstrap.min.css", "#{default_vendor_folder_path}/css/bootstrap.min.css"
      end

      def install_pundit
        `rails g pundit:install`
      end
		end
	end
end