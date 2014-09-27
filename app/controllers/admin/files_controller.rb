class Admin::FilesController < ApplicationController
  include MagazCore::Concerns::Authenticable
  inherit_resources
  layout 'admin_settings'
  actions :all, :except => [:edit]

  def update
    update! do |success, failure|
      failure.html { render :show }
    end
  end

  protected

  def begin_of_association_chain
    current_shop
  end

  def collection
    @files ||= end_of_association_chain.page(params[:page])
  end

  def resource
    @file ||= end_of_association_chain.find(params[:id])
  end

  def permitted_params
    { file:
        params.fetch(:file, {}).permit(:file, :name)}
  end
end
