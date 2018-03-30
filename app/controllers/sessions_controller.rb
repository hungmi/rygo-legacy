class SessionsController < AdminController
	def new
		authorize :session, :new?
		if user_signed_in?
			flash[:success] = "すでにログインしています。"
			redirect_to admin_path
		end
	end

	def create
		@user = User.find_by_name(params[:session][:user_name])
		if @user.present? && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
			redirect_to (params[:session][:back_path].present? ? params[:session][:back_path] : admin_path)
		else
      flash.now[:danger] = "ユーザー名またはパスワードが違います。"
			render :new
		end
		authorize :session, :create?
	end

  def destroy
  	authorize :session, :destroy?
    session.delete(:user_id)
    @current_user = nil
    flash[:success] = "ログアウトしました。"
    redirect_to signin_path
  end
end