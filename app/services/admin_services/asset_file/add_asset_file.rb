class AdminServices::AssetFile::AddAssetFile

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize  shop_id:, 
                  params:
    @result = Shop.find(shop_id).asset_files.new
    @params = params
  end

  def run
    @result.attributes = asset_params
    @success = @result.save
    self
  end

  private

  def asset_params
    @params.slice 'file',
                  'name'
  end
end
