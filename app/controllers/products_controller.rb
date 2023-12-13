class ProductsController < ApplicationController

  def index
    @categories = Category.all
    if params.dig(:category, :category_ids).present? || params.dig(:frame, :frame_ids).present?
      @categories = Category.where(id: params[:category][:category_ids])
      @frames = Frame.where(kind: params[:frame][:frame_ids])
      render :search_result
    else
      flash[:notice] = "選択してください"
      render :index
    end
  end

  def new
    @product = Product.new
  end

  def confirm
    @product = Product.new(product_params)
    build_taggings
  end

  def create
    @product = Product.new(product_params)
    build_taggings
    if @product.save
      redirect_to products_path
    else
      render :new
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
      category_ids: [],
      frame_ids: [],
      tag_ids: [],
      taggings_attributes: [:id, :tag_id, :_destroy]
    )
  end

end
