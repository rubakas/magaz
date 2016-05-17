class AdminServices::AssetFile::AddFile < ActiveInteraction::Base

  set_callback :validate, :after, -> {datafile}

  file :file
  integer :shop_id
  string :name

  validates :name, :shop_id, :file, presence: true

  def datafile
    @datafile = Shop.find(shop_id).files.new
    add_errors if errors.any?
    @datafile
  end

  def execute
    unless @datafile.update_attributes(inputs)
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
