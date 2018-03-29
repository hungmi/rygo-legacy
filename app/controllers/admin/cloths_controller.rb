class Admin::ClothsController < AdminController
  before_action :set_cloth, only: [:show, :edit, :update, :destroy]

  # GET /cloths
  def index
    authorize [:admin, :cloth], :index?
    @cloths = Admin::ClothPolicy::Scope.new(current_user, Cloth).resolve.order(updated_at: :desc)
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
    @cloth = Cloth.new(cloth_params)
    authorize [:admin, @cloth]

    if @cloth.save
      flash[:success] = "建立成功。"
      redirect_to [:admin, @cloth]
    else
      render :new
    end
  end

  # PATCH/PUT /cloths/1
  def update
    if @cloth.update(cloth_params)
      # byebug #cloth_params[:remove_images]
      @cloth.images.where(id: params[:cloth][:remove_images].keys).destroy_all if params[:cloth][:remove_images].present?
      flash[:success] = "更新成功。"
      redirect_to [:admin, @cloth]
    else
      render :edit
    end
  end

  # DELETE /cloths/1
  def destroy
    @cloth.destroy
    flash[:success] = "刪除成功。"
    redirect_to admin_cloths_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_cloth
      @cloth = Cloth.find(params[:id])
    	authorize @cloth
    end

    # Only allow a trusted parameter "white list" through.
    def cloth_params
      params.require(:cloth).permit(:code, :jancode, :brand, :price, :supplier_id, images: [], remove_images: [])
    end
end