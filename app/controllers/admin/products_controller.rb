class Admin::ProductsController < Admin::DashboardController
	#inherit_resources
  private
  #def permitted_params
  #  params.permit
  #end
  def permitted_params
    params[:product] ||= {}
    params.require(:product).permit(:name,:description)
  end
end
