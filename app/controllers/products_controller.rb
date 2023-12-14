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
    flash[:product_alert] = "在庫が不足しています"
    # JavaScriptでフラッシュメッセージ「選択してください」 
  end

  def new
    @product = Product.new
  end

  def confirm
    @product = Product.new(product_params)
    @selected_frame = Frame.find_by(kind: @product.frame.kind) if @product.frame.present?
    @selected_category = Category.find(@product.category_id).name
    @selected_alert = ProductAlert.find(@product.product_alert_id).quantity
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

  def edit_products
    @products = Product.where(id: params[:select_products])
  end

  #ここはモデルに定義したい
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
