class Admin::UsersController < AdminController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_search

  def index
    authorize [:admin, :user], :index?
    @users = if current_user.admin?
               @q.result(distinct: true)
             elsif current_user.supplier?
               User.where(id: current_user.id)
             end.order(updated_at: :desc)
  end

	def show
	end

  # GET /users/new
  def new
    @user = User.new
    authorize [:admin, @user]
  end

	def edit
	end

  # POST /users
  def create
    @user = User.new(user_params)
    authorize [:admin, @user]

    if @user.save
      flash[:success] = "登録に成功しました。"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      flash[:success] = "更新に成功しました。"
      redirect_to [:admin, @user]
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    flash[:success] = "削除に成功しました。"
    redirect_to admin_users_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      authorize [:admin, @user]
    end

    def set_search
      @q = User.ransack(params[:q])
      @nav_search_symbol = :name_cont
      @nav_search_placeholder = User.human_attribute_name("name") + "で検索"
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :role, :password, :password_confirmation, :password_digest)
    end
end