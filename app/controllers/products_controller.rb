class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show update destroy ]

  # GET /products
  def index
    @products = Product.all
    @products_with_image_urls = @products.map do |product|
      image_urls = product.pictures.map { |picture| url_for(picture) }
      { product: product, image_urls: image_urls }
    end
    render json: @products_with_image_urls
  end

  # GET /products/1
  def show
    @product = Product.find(params[:id])
    image_urls = @product.pictures.map { |picture| url_for(picture) }
    render json: { product: @product, image_urls: image_urls }
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :price, pictures: [])
    end
end
