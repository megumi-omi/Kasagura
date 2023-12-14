class ProductsController < ApplicationController

  def index
    @categories = Category.all
    # カテゴリまたは種類が選択された場合に実行
    if (params.dig(:category) || params.dig(:frame)) && (params.dig(:category, :category_ids).reject(&:empty?).present? || params.dig(:frame, :frame_ids).reject(&:empty?).present?)
      @categories = Category.where(id: params[:category][:category_ids])
      @frames = Frame.where(kind: params[:frame][:frame_ids])
      @selected_items = params[:select_items] || []
      render :search_result
    end
    # JavaScriptでフラッシュメッセージ「選択してください」 
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

  def edit_products
    @products = Product.where(id: params[:select_products])
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
