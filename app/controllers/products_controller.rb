class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    products = Product.all.map do |p|
      { id: p.id, name: p.name, description: p.description, price: p.price, image: p.image.attached? ? url_for(p.image) : null }
    end
    render inertia: 'Products/Index', props: { products: products }
  end

  # GET /products/1 or /products/1.json
  def show
    p = Product.find(params[:id])
    product = { id: p.id, name: p.name, description: p.description, price: p.price, image: p.image.attached? ? url_for(p.image) : null }
    render inertia: 'Products/Show', props: { product: product }

  end

  # GET /products/new
  def new
    render inertia: 'Products/New', props: {}
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    p = Product.find(params[:id])

    product = { id: p.id, name: p.name, description: p.description, price: p.price, image: p.image.attached? ? url_for(p.image) : null }
    render inertia: 'Products/Edit', props: { product: product }
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    @product.save

    redirect_to products_path

    # respond_to do |format|
    #   if @product.save
    #     format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
    #     format.json { render :show, status: :created, location: @product }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @product.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update

    if @product.update(product_params)
      redirect_to products_path
    end

  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    redirect_to products_path

    # respond_to do |format|
    #   format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:id, :name, :description, :price, :image)
  end
end
