class Admin::OrderItemsController < AdminController
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]

  # GET /order_items
  def index
    authorize [:admin, :order_item], :index?
    
    @order_items =  if current_user.admin?
                      OrderItem.all
                    elsif current_user.supplier?
                      current_user.order_items
                    end.order(updated_at: :desc)
  end

  # GET /order_items/1
  def show
  end

  # GET /order_items/new
  def new
    @order_item = OrderItem.new
    authorize [:admin, @order_item]
  end

  # GET /order_items/1/edit
  def edit
  end

  # POST /order_items
  def create
    @order_item = OrderItem.new(order_item_params)
    authorize [:admin, @order_item]

    if @order_item.save
      flash[:success] = "登録に成功しました。"
      redirect_to [:admin, @order_item]
    else
      render :new
    end
  end

  # PATCH/PUT /order_items/1
  def update
    # 若此訂單的衣服被手動更改 html 成其他廠商的 id，也視為 not authorized
    if current_user.admin? || current_user.cloth_ids.include?(order_item_params[:cloth_id].to_i)
      if @order_item.update(order_item_params)
        flash[:success] = "更新に成功しました。"
        redirect_to [:admin, @order_item]
      else
        render :edit
      end
    else
      raise Pundit::NotAuthorizedError
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
    	authorize [:admin, @order_item]
    end

    # Only allow a trusted parameter "white list" through.
    def order_item_params
      params.require(:order_item).permit(:cloth_id, :amount, :deliver_month, :deliver_period, :status)
    end
end