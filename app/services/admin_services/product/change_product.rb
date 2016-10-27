class AdminServices::Product::ChangeProduct

  attr_reader :success, :result, :errors
  alias_method :success?, :success

  def initialize(id: nil, shop_id: nil, params: nil)
    @result = Shop.find(shop_id).products.friendly.find(id)
    @params = params
    @success = true
    @errors = []
  end

  def run
    Product.connection.transaction do
      _change_product
      _add_product_image
      _remove_product_images
      check_errors
    end
    self
  end

  private

  def _change_product
    @result.attributes = product_params
    @result.save
    collect_errors(@result)
    check_errors
  end

  def _add_product_image
    if product_image_params.present? && !@params[:product_images_attributes]["0"].key?("_destroy")
      product_image = AdminServices::ProductImage::AddProductImage
                          .new(product_id: @result.id, params: product_image_params)
                          .run
                          .result
      collect_errors(product_image)
    end
  end

  def _remove_product_images
    if @params.key?(:product_images_attributes) && @params[:product_images_attributes]["0"].key?("_destroy")
      @params[:product_images_attributes].each do |key, value|
        AdminServices::ProductImage::DeleteProductImage.new(id: value["id"], product_id: @result.id).run
      end
    end
  end

  def check_errors
    if @errors.present?
      @success = false
      raise ActiveRecord::Rollback
    end
  end

  def default_params
    { price: nil, product_images_attributes: {}, collection_ids: nil }
  end

  def product_params
    @params.slice(:name, :price, :collection_ids, :description, :handle, :page_title, :meta_description)
  end

  def product_image_params
    @params.dig(:product_images_attributes, "0")
  end

  def collect_errors(object)
    @errors += object.errors.full_messages if object.errors.present?
  end
end
