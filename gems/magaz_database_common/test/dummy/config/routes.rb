Rails.application.routes.draw do

  mount MagazDatabaseCommon::Engine => "/magaz_database_common"
end
