class Admin::ProductImagesController < ApplicationController
  include Authenticable
  inherit_resources
  actions :all, :except => [:edit]

  protected

  def permitted_params
    { product_image:
        params.fetch(:product_image, {}).permit(:iamge)}
  end
end
