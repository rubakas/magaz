class Admin::CustomersController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  inherit_resources
  actions :all, :except => [:edit]
  respond_to :csv

  def update
    update! do |success, failure|
      failure.html { render :show }
    end
  end

  def import
    MagazCore::Customer.import(params[:file])
    redirect_to admin_customers_path, notice: "Customers imported"
  end

  def export
    @customers = MagazCore::Customer.all
    respond_to do |format|
      format.html
      format.csv { send_data @customers.to_csv, :disposition => "attachment; filename=сustomers.csv"  }
    end
  end

  protected

  def begin_of_association_chain
    current_shop
  end

  def collection
    @customers ||= end_of_association_chain.page(params[:page])
  end

  #TODO:  collection_ids are not guaranteed to belong to this shop!!!
  # https://github.com/josevalim/inherited_resources#strong-parameters
  def permitted_params
    { customer:
        params.fetch(:customer, {}).permit(:first_name, :last_name, :email) }
  end
end
