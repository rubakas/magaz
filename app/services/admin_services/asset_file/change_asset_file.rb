class AdminServices::AssetFile::ChangeAssetFile

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(id:, shop_id:, params:)
    @result = Shop.find(shop_id).asset_files.find(id)
    @params = params
  end

  def run
    @success = @result.update_attributes(asset_params)
    self
  end

  private

  def asset_params
    @params.slice 'file',
                  'name'
  end
end
