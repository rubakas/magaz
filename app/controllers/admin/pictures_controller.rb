class Admin::PicturesController < ApplicationController
  include Authenticable
  inherit_resources
  actions :new, :create, :destroy

  protected

  def begin_of_association_chain
    current_shop
  end

  def permitted_params
    { picture:
        params.fetch(:picture, {}).permit(:image) }
  end
end
