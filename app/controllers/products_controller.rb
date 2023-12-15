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

  def confirm
    @product = Product.new(product_params)
    @selected_frame = Frame.find_by(kind: @product.frame.kind) if @product.frame.present?
    @selected_category = Category.find(@product.category_id).name
    @selected_alert = ProductAlert.find(@product.product_alert_id).quantity
    render :new if @product.invalid?
    build_taggings
  end

  def edit_found
    @products = Product.where(id: params[:select_products])
  end

  def edit_confirm
    @changed_products = []
    @data_table = {}
    params[:product].each do |product_id, product_params|
      product = Product.find(product_id)
      back_stock = params[:back_stock]
      next if product.stock.to_s == product_params[:stock] && product.product_alert.id.to_s == product_params[:product_alert_id] && product.name == product_params[:name] && product.category.id.to_s == product_params[:category_id]
      if product.stock.to_s != product_params[:stock] && back_stock == 'true'
        # チェックボックスにチェックを入れたら傘だけ在庫が増えて、チェックが入らなければ、傘は増えて傘骨は減る
        @data_table[product.id] = product_params[:stock]
        product.stock = product.stock + product_params[:stock].to_i
      else
        @data_table[product.id] = product_params[:stock]
        product.stock = product.stock + product_params[:stock].to_i
        if product_params[:stock].to_i.positive?
          product.frame.inventory = product.frame.inventory - product_params[:stock].to_i
        end
      end
      if product.product_alert.id.to_s != product_params[:product_alert_id]
        product.product_alert_id = product_params[:product_alert_id]
      end
      if product.name != product_params[:name]
        product.name = product_params[:name]
      end
      if product.category.id.to_s != product_params[:category_id]
        product.category_id = product_params[:category_id]
      end

      @changed_products << product
    end
    render :edit_confirm
  end

  def modify
    if params[:back]
      redirect_to products_path and return
    end
    if !params[:product]
      redirect_to products_path, notice: '更新するものがありません' and return
    end
    params[:product].each do |product_id, product_params|
      product = Product.find(product_id)
      next if product.stock.to_s == product_params[:stock] && product.product_alert.id.to_s == product_params[:product_alert_id] && product.name == product_params[:name] && product.category.id.to_s == product_params[:category_id]
      if product.stock.to_s != product_params[:stock]
        product.update(stock: product_params[:stock])
        product.frame.update(inventory: product_params[:frame_inventory])
      end

      if product.product_alert_id != product_params[:product_alert_id]
        product.update(product_alert_id: product_params[:product_alert_id])
      end
      if product.name != product_params[:name]
        product.update(name: product_params[:name])
      end
      if product.category.id != product_params[:category_id]
        product.update(category_id: product_params[:category_id])
      end
    end
    redirect_to products_path, notice: '更新しました'
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to products_path, notice: '削除しました'
    end
  end

  private

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
      :frame_inventory,
      :product_alert_id,
      :image,
      category_ids: [],
      frame_ids: [],
      tag_ids: [],
      taggings_attributes: [:id, :tag_id, :_destroy]
    )
  end

end
