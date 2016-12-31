module ThemeServices
  class InstallTheme
    attr_reader :success
    attr_reader :result
    alias_method :success?, :success

    def initialize  shop_id:, 
                    source_theme_id:
      @shop          = ::Shop.find(shop_id)
      @source_theme  = ::Theme.find(source_theme_id)
      @success       = false
    end

    def run
      #TODO: process payment
      # copy theme data and associate with shop
      @result = @shop.themes.build(name: @source_theme.name, source_theme: @source_theme)
      @source_theme.assets.each do |source_asset|
        @result
          .assets
          .build(source_asset.attributes.reject { |k| 'id' == k.to_s })
      end
      @success = @result.save!
      self
    end

    # TODO: check how to works errors for ActiveInteraction
    # def shop_exists?
    #   if Shop.find_by_id(shop_id)
    #     return true
    #   else
    #     errors.add(:base, I18n.t('services.install_theme.invalid_shop_id'))
    #     return false
    #   end
    # end
  end
end
