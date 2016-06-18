class Admin::CustomersController < Admin::ApplicationController
  include Concerns::Authenticable
  respond_to :csv

  def index
    @customers = current_shop.customers.page(params[:page])
  end

  def show
    @customer = current_shop.customers.find(params[:id])
  end

  def new
    @customer = current_shop.customers.new
  end

  def create
    service = AdminServices::Customer::AddCustomer
              .run(first_name: params[:customer][:first_name],
                   last_name: params[:customer][:last_name],
                   email: params[:customer][:email],
                   shop_id: current_shop.id)

    if service.valid?
      @customer = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_customer_path(@customer)
    else
      @customer = service.customer
      flash.now[:notice] = t('.notice_fail')
      render 'new'
    end
  end

  def update
    service = AdminServices::Customer::ChangeCustomer
              .run(id: params[:id],
                   first_name: params[:customer][:first_name],
                   last_name: params[:customer][:last_name],
                   email: params[:customer][:email],
                   shop_id: current_shop.id)
    if service.valid?
      @customer = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_customer_path(@customer)
    else
      @customer = service.customer
      flash.now[:notice] = t('.notice_fail')
      render 'show'
    end
  end

  def import
    AdminServices::Customer::ImportCustomersFromCsv
      .call(shop_id: current_shop.id, csv_file: params[:csv_file])

    redirect_to admin_customers_path, notice: t('.notice_success')
  end

  def export
    @customers = current_shop.customers.all
    respond_to do |format|
      format.html
      format.csv { send_data @customers.to_csv, :type => "text/csv",
                   :disposition => "attachment; filename=сustomers.csv" }
    end
  end

  def destroy
    service = AdminServices::Customer::DeleteCustomer
                .run(id: params[:id], shop_id: current_shop.id)
    flash[:notice] = t('.notice_success')
    redirect_to admin_customers_path
  end
end
