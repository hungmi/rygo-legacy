class Admin::ClothsController < AdminController
  before_action :set_cloth, only: [:show, :edit, :update, :destroy]
  before_action :set_search

  # GET /cloths
  def index
    authorize [:admin, :cloth], :index?
    @cloths =  if current_user.admin?
                  @q.result(distinct: true)
                elsif current_user.supplier?
                  @q.result(distinct: true).where(supplier_id: current_user.id)
                end.with_attached_images.order(updated_at: :desc)
  end

  # GET /cloths/1
  def show
  end

  # GET /cloths/new
  def new
    @cloth = Cloth.new
    authorize [:admin, @cloth]
  end

  # GET /cloths/1/edit
  def edit
  end

  # POST /cloths
  def create
    @cloth = Cloth.new(cloth_params.except(:images))
    authorize [:admin, @cloth]

    if @cloth.save
      @cloth.images.attach(params[:cloth][:images]) if params[:cloth][:images]
      flash[:success] = "登録に成功しました。"
      redirect_to [:admin, @cloth]
    else
      render :new
    end
  end

  # PATCH/PUT /cloths/1
  def update
    if @cloth.update(cloth_params.except(:images))
      # byebug #cloth_params[:remove_images]
      @cloth.images.where(id: params[:cloth][:remove_images].keys).map(&:purge_later) if params[:cloth][:remove_images].present?
      @cloth.images.attach(params[:cloth][:images]) if params[:cloth][:images]
      flash[:success] = "更新に成功しました。"
      redirect_to [:admin, @cloth]
    else
      render :edit
    end
  end

  # DELETE /cloths/1
  def destroy
    @cloth.destroy
    flash[:success] = "削除に成功しました。"
    redirect_to admin_cloths_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_cloth
      @cloth = Cloth.find(params[:id])
      authorize [:admin, @cloth]
    end

    def set_search
      @q = Cloth.ransack(params[:q])
      @nav_search_symbol = :code_cont
    end

    # Only allow a trusted parameter "white list" through.
    def cloth_params
      params.require(:cloth).permit(:code, :jancode, :brand, :price, :supplier_id, images: [], remove_images: [])
    end
end