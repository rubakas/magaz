class Admin::ProductsController < Admin::DashboardController
	inherit_resources
  private
  def permitted_params
    params.permit
  end
end
