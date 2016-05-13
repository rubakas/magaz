module MagazCore
  class File < ActiveRecord::Base
    self.table_name = 'files'

    belongs_to :shop

    mount_uploader :file, MagazCore::FileUploader
  end
end
