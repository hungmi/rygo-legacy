class Admin::CustomersController < AdminController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  def index
    @customers = Customer.all.order(updated_at: :desc)
    authorize [:admin, :customer], :index?
  end

  # GET /customers/1
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    authorize [:admin, @customer]
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)
    authorize [:admin, @customer]

    if @customer.save
      flash[:success] = I18n.t('flash.create_success')
      redirect_to [:admin, @customer]
    else
      render :new
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      flash[:success] = I18n.t('flash.update_success')
      redirect_to [:admin, @customer]
    else
      render :edit
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy
    flash[:success] = I18n.t('flash.destroy_success')
    redirect_to admin_customers_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    	authorize [:admin, @customer]
    end

    # Only allow a trusted parameter "white list" through.
    def customer_params
      params.require(:customer).permit(:name, :address, :phone, :company_name)
    end
end