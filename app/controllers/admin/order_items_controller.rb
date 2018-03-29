class Admin::OrderItemsController < AdminController
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]

  # GET /order_items
  def index
    @order_items = OrderItem.all.order(updated_at: :desc)
    authorize :order_item, :index?
  end

  # GET /order_items/1
  def show
  end

  # GET /order_items/new
  def new
    @order_item = OrderItem.new
    authorize @order_item
  end

  # GET /order_items/1/edit
  def edit
  end

  # POST /order_items
  def create
    @order_item = OrderItem.new(order_item_params)
    authorize @order_item

    if @order_item.save
      flash[:success] = "登録に成功しました。"
      redirect_to [:admin, @order_item]
    else
      render :new
    end
  end

  # PATCH/PUT /order_items/1
  def update
    if @order_item.update(order_item_params)
      flash[:success] = "更新に成功しました。"
      redirect_to [:admin, @order_item]
    else
      render :edit
    end
  end

  # DELETE /order_items/1
  def destroy
    @order_item.destroy
    flash[:success] = "削除に成功しました。"
    redirect_to admin_order_items_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    	authorize @order_item
    end

    # Only allow a trusted parameter "white list" through.
    def order_item_params
      params.require(:order_item).permit(:cloth_id, :amount, :deliver_month, :deliver_period, :status)
    end
end