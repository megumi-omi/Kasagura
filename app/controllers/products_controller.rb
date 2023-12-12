class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @product.taggings.build
  end

  def confirm
    @product = Product.new(product_params)
    params[:product][:tag_id]
    Tag.where(id: params[:product][:tag_id]).each do |tag|
      @product.taggings.build(tag_id: tag.id)
    end
  end

  def create
    @product = Product.new(product_params)
    Tag.where(id: params[:product][:tag_id]).each do |tag|
      @product.taggings.build(tag_id: tag.id)
    end

    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :stock,
      :category_id,
      :frame_id,
      :product_alert_id,
      :image,
      #tag_id: [],
      taggings_attributes: [:id, :tag_id, :_destroy]
    )
  end

end
