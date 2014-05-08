require 'test_helper'

module MagazCore
  class ThemeTest < ActiveSupport::TestCase

    test 'self referencing association' do
      @source_theme = create(:theme)
      @installed_theme = Theme.new(name: @source_theme.name)
      
      @installed_theme.source_theme = @source_theme
      
      assert @installed_theme.save
      
      assert_equal @source_theme, @installed_theme.source_theme
      assert_includes @source_theme.installed_themes, @installed_theme
    end

    test 'finder of source associations' do
      @source_theme   = create(:theme)
      @installed_theme  = create(:theme, source_theme: @source_theme)

      assert_includes Theme.sources, @source_theme
      refute_includes Theme.sources, @installed_theme
    end

    test 'finder of roles' do
      @theme_main        = create(:theme, role: 'main')
      @theme_unpublished = create(:theme, role: 'unpublished')

      assert Theme.with_role(:main).include?(@theme_main)
      refute Theme.with_role(:main).include?(@theme_unpublished)

      refute Theme.with_role(:unpublished).include?(@theme_main)
      assert Theme.with_role(:unpublished).include?(@theme_unpublished)
    end

  end
end