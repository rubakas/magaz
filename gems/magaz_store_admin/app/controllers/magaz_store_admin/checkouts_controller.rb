module MagazStoreAdmin
  class CheckoutsController < ApplicationController
    include MagazCore::Concerns::Authenticable

    def index
      @abandoned_checkouts = current_shop.checkouts.abandoned_checkouts.page(params[:page])
    end

    def show
      @abandoned_checkout = current_shop.checkouts.abandoned_checkouts.find(params[:id])
    end

    def destroy
      service = MagazCore::AdminServices::Checkout::DeleteCheckout.run(id: params[:id])
      redirect_to checkouts_url
    end

  end
end
