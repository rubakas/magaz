module MagazStoreAdmin
  class ErrorsController < ApplicationController
    layout 'admin'

    def page_not_found
      respond_to do |format|
        format.html { render template: 'magaz_store_admin/errors/not_found_error', status: 404 }
        format.all  { render nothing: true, status: 404 }
      end
    end

    def server_error
      respond_to do |format|
        format.html { render template: 'magaz_store_admin/errors/internal_server_error', status: 500 }
        format.all  { render nothing: true, status: 500}
      end
    end
  end
end