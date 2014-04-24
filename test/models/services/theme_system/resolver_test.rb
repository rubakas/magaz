require 'test_helper'

class Services::ThemeSystem::ResolverTest < ActiveSupport::TestCase
  setup do
    @theme = create(:theme)
    @erb_body = "<%= 'Hi from theme template asset!' %>"
    @template_asset = create(:asset, key: 'prefix/template', theme: @theme, value: @erb_body)

    @resolver = Services::ThemeSystem::Resolver.new { @theme }
    @details  = { formats: [:html], locale: [:en], handlers: [:erb] }
  end

  test 'initialize' do
    refute_nil @resolver
    assert_kind_of Services::ThemeSystem::Resolver, @resolver
    assert @resolver.respond_to? :find_all
  end

  test 'find_all - returns empty array' do
    assert @resolver.find_all('notemplate', 'noprefix', false, @details).empty?
    assert @resolver.find_all('notemplate', 'noprefix', true, @details).empty?
  end

  test 'find_all - returns template, when it is exist' do
    template = @resolver.find_all('template', 'prefix', false, @details).first
    assert_kind_of ActionView::Template, template

    # Assert specific information about the found template
    assert_equal @erb_body, template.source 
    assert_kind_of ActionView::Template::Handlers::ERB, template.handler 
    assert_equal [:html], template.formats
    assert_equal "prefix/template", template.virtual_path
    assert_match %r[Asset - \d+ - "prefix/template"], template.identifier
  end
end
