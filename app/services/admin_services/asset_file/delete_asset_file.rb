class AdminServices::AssetFile::DeleteAssetFile

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(id:, shop_id:)
    @result = ::Shop
              .find(shop_id)
              .asset_files
              .find(id)
              .destroy
  end

  def run
    @success = @result.destroy
    self
  end
end
