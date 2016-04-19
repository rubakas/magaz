class MagazCore::AdminServices::File::AddFile < ActiveInteraction::Base

  file :file
  integer :shop_id
  string :name

  validates :name, :shop_id, :file, presence: true

  def execute
    file = MagazCore::File.new(inputs)

    unless file.save
      errors.merge!(file.errors)
    end

    file
  end

end