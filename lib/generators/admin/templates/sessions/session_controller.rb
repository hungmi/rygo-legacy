class <%= options[:namespace].camelize %>::SessionsController < AdminController
	def new
		authorize [:<%= options[:namespace] %>, :session], :new?
		if user_signed_in?
			flash[:success] = "您已經登入"
			redirect_to admin_path
		end
	end

	def create
		@user = User.find_by_name(params[:session][:user_name])
		if @user.present? && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
			redirect_to (params[:session][:back_path] || root_path)
		else
      flash.now[:danger] = "帳號或密碼錯誤。"
			render :new
		end
		authorize [:<%= options[:namespace] %>, :session], :create?
	end

  def destroy
  	authorize [:<%= options[:namespace] %>, :session], :destroy?
    session.delete(:user_id)
    @current_user = nil
    flash.now[:success] = "已登出。"
    redirect_to admin_path
  end
end