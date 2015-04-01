module MagazStoreAdmin 
class Admin::CustomersController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
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
    @customer = current_shop.customers.new(permitted_params[:customer])
    if @customer.save
      flash[:notice] = 'Customer was successfully created.'
      redirect_to admin_customer_path(@customer)
    else
      render 'new'
    end
  end

  def update
    @customer = current_shop.customers.find(params[:id])
    if @customer.update_attributes(permitted_params[:customer])
      flash[:notice] = 'Customer was successfully updated.'
      redirect_to admin_customer_path(@customer)
    else
      render 'show'
    end
  end

  def import
    MagazCore::ShopServices::ImportCustomersFromCsv.call(shop_id: current_shop.id, csv_file: params[:csv_file])
    redirect_to admin_customers_path, notice: "Customers imported"
  end

  def export
    @customers = current_shop.customers.all
    respond_to do |format|
      format.html
      format.csv { send_data @customers.to_csv, :type => "text/csv", :disposition => "attachment; filename=сustomers.csv" }
    end
  end

  def destroy
    @customer = current_shop.customers.find(params[:id])
    @customer.destroy
    flash[:notice] = 'Customer was successfully deleted.'
    redirect_to admin_customers_path
  end

  protected

  #TODO:  collection_ids are not guaranteed to belong to this shop!!!
  # https://github.com/josevalim/inherited_resources#strong-parameters
  def permitted_params
    { customer:
        params.fetch(:customer, {}).permit(:first_name, :last_name, :email) }
  end
end
end
