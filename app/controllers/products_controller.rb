class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def confirm
    @product = Product.new(product_params)
    render :new if @product.invalid?
    build_taggings
  end

  def create
    @product = Product.new(product_params)
    build_taggings
    if params[:back]
      render :new
    else
      if @product.save
        redirect_to products_path, notice: "商品を作成しました"
      else
        render :new
      end
    end
  end

private

def build_taggings
  Tag.where(id: params[:product][:tag_id]).each do |tag|
    @product.taggings.build(tag_id: tag.id)
  end
end

  def product_params
    params.require(:product).permit(
      :name,
      :stock,
      :category_id,
      :frame_id,
      :product_alert_id,
      :image,
      taggings_attributes: [:id, :tag_id, :_destroy]
    )
  end

end
