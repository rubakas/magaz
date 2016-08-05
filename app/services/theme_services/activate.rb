class ThemeServices::Activate
  attr_reader :success, :result
  alias_method :success?, :success

  def initialize(shop_id:, installed_theme_id:)
    @shop    = Shop.find(shop_id)
    @result  = Theme.find(installed_theme_id)
    @success = true
  end

  def run
    @shop.transaction do
      begin
        @shop.themes.each do |current_theme|
          current_theme.deactivate!
        end
        @result.activate!
        @shop.reload
      rescue RuntimeError, ActiveRecord::RecordInvalid
        @success = false
        raise ActiveRecord::Rollback
      end
    end
    self
  end
end
