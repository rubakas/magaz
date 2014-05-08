class Admin::ProductImagesController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  inherit_resources
  actions :all, :except => [:edit]

  protected

  def permitted_params
    { product_image:
        params.fetch(:product_image, {}).permit(:image) }
  end
end
