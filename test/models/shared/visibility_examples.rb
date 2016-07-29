module Shared
  module VisibilityExamples
    def setup_visibility_examples(model_class:, factory_name:)
      @shop = create(:shop)
      @model_class = model_class
      @model_instance = if model_class.new.respond_to? :shop
        create(factory_name, shop: @shop)
      else
        create(factory_name)
      end

      @published_models = if model_class.new.respond_to? :shop
        create_list(factory_name, 10, publish_on: nil, published_at: 1.minute.ago, shop: @shop)
      else
        create_list(factory_name, 10, publish_on: nil, published_at: 1.minute.ago)
      end

      @not_published_models = if model_class.new.respond_to? :shop
        create_list(factory_name, 10, publish_on: 1.day.from_now, published_at: nil, shop: @shop)
      else
        create_list(factory_name, 10, publish_on: 1.day.from_now, published_at: nil)
      end
      
      @pending_publishing_models = if model_class.new.respond_to? :shop
        create_list(factory_name, 10, publish_on: 1.minute.ago, published_at: nil, shop: @shop)
      else
        create_list(factory_name, 10, publish_on: 1.minute.ago, published_at: nil)
      end
    end

    def test_basic_visibility_functionality
      @model_instance.update_attributes(publish_on: nil, published_at: nil)
      assert @model_instance.valid?
      refute @model_instance.published?

      @model_instance.update_attributes(publish_on: 2.days.from_now, published_at: nil)
      assert @model_instance.valid?
      refute @model_instance.published?

      @model_instance.update_attributes(publish_on: nil, published_at: 2.days.ago)
      assert @model_instance.valid?
      assert @model_instance.published?
    end

    def test_visibility_scopes
      refute @model_class.published.blank?
      refute @model_class.not_published.blank?
      refute @model_class.pending_publishing.blank?
    end

    def test_visibility_scopes_and_methods
      @model_class.published.each do |v|
        assert v.published?
      end

      @model_class.not_published.each do |h|
        refute h.published?
      end

      @model_class.pending_publishing.each do |p|
        refute p.published?
      end
    end

    def test_worker_created
      assert_difference 'VisibilityWorker.jobs.length', 1 do
        @model_instance.update_attributes(publish_on: 2.days.from_now, published_at: nil)
      end
    end

  end
end
