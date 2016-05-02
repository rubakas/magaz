class MagazCore::AdminServices::File::ChangeFile < ActiveInteraction::Base

  set_callback :validate, :after, -> {datafile} 

  file :file
  integer :id, :shop_id
  string :name

  validates :id, :file, :shop_id, :name, presence: true

  def datafile
    @datafile = MagazCore::Shop.find(shop_id).files.find(id)
    add_errors if errors.any?
    @datafile
  end

  def execute
    unless @datafile.update_attributes(inputs.slice!(:id))
      errors.merge!(@datafile.errors)
    end
    @datafile
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @datafile.errors.add(:base, msg)
    end
  end

end
