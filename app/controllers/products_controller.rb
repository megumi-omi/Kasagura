class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin, only: [:create] #傘の新規登録はadminのみ

  def index
    @categories = Category.all
    @products = Product.all
    @frames = Frame.all
    @tags = Tag.all

    # タグ検索
    if params.dig(:tag) && params.dig(:tag, :tag_ids).reject(&:empty?).present?
      @tags_search = Tag.where(id: params[:tag][:tag_ids])
      @categories = nil
      @products = nil
      @frames = nil
      @tags = nil
      render :search_result
    end

    # 検索条件が１つ以上選択された場合に実行
    if (params.dig(:category) || params.dig(:frame)) && (params.dig(:category, :category_ids).reject(&:empty?).present? ||
      params.dig(:frame, :frame_ids).reject(&:empty?).present? || params[:products_none].present?)

      @categories = Category.where(id: params[:category][:category_ids])
      @frames = Frame.where(kind: params[:frame][:frame_ids])
      @products_none= Product.stock_zero if params[:products_none].present?

      @products_search =
        case
        when params[:products_none].present? && @categories.present? && @frames.present?
          Product.category_and_frame_stock(@categories, @frames).stock_zero
        when params[:products_none].present? && @categories.present?
          Product.category_stock(@categories).stock_zero
        when params[:products_none].present? && @frames.present?
          Product.frame_stock(@frames).stock_zero
        when @categories.present? && @frames.present?
          Product.category_and_frame_stock(@categories, @frames)
        end

      render :search_result
    end
    # JavaScriptでフラッシュメッセージ「選択してください」
  end

  def new
    @product = Product.new
    @tag = Tag.all
  end

  def create
    @product = Product.new(product_params)
    build_taggings
    if @product.save
      redirect_to products_path, notice: "商品を作成しました"
    else
      render :new
    end
  end

  def confirm
    @product = Product.new(product_params)
    @selected_frame = Frame.find_by(kind: @product.frame.kind) if @product.frame.present?
    @selected_category = Category.find_by(id: @product.category_id)
    @selected_alert = ProductAlert.find_by(id: @product.product_alert_id)
    build_taggings
    render :new if @product.invalid?
  end

  def edit_found
    @products = Product.where(id: params[:select_products])
    if params[:select_products].blank?
      flash.now[:notice] = "商品を選択してください"
    end
  end

  # ちょっとなんとかしたい
  def edit_confirm
    if !params[:product]
      redirect_to products_path, notice: '更新するものがありません' and return
    end

    @changed_products = []
    @data_table = {}
    params[:product].each do |product_id, product_params|
      product = Product.find(product_id)
      back_stock = params[:back_stock]
      selected_tag = product.tags.pluck(:id).map(&:to_s)
      tag_params = params[:product][product.id.to_s][:tag_id]
      #1 タグが付いてなくてパラメータも空の時
      #2 タグがついててパラメーターも同じ時
      skip_based_on_tag = (!selected_tag.present? && tag_params == [""]) ||
                          (selected_tag.present? && tag_params[-1] == selected_tag[0])

      next if product_params[:name].blank? && product_params[:stock].blank? &&
        product.product_alert.id.to_s == product_params[:product_alert_id] &&
        product.category.id.to_s == product_params[:category_id] &&
        skip_based_on_tag

        if product.stock.to_s != product_params[:stock] && back_stock == "true"
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
      if product.tag_ids.map(&:to_s) != product_params[:tag_id]

        if product.taggings.present?
          product.taggings.first.tag_id = product_params[:tag_id][1]
        else
          product.taggings.build(tag_id: product_params[:tag_id][1])
        end
      end
      @changed_products << product
    end
    if !@changed_products.present?
      @products = Product.where(id: params[:product].keys)
      @is_no_change = true
      render :edit_found
    end
  end

# こっちもなんとかしたい
  def modify
    if !params[:product]
      redirect_to products_path, notice: '更新するものがありません' and return
    end

    params[:product].each do |product_id, product_params|
      product = Product.find(product_id)
      selected_tag = product.tags.pluck(:id).map(&:to_s)
      tag_params = params[:product][product.id.to_s][:tag_id]

      next if product_params[:name].blank? && product_params[:stock].blank? &&
        (tag_params[-1] == selected_tag[0] || tag_params == [""]) &&
        product.product_alert.id.to_s == product_params[:product_alert_id] &&
        product.category.id.to_s == product_params[:category_id]
      if product.stock.to_s != product_params[:stock]
        product.update(stock: product_params[:stock])
        product.frame.update(inventory: product_params[:frame_inventory])
      end

      if product.product_alert_id.to_s != product_params[:product_alert_id]
        product.update(product_alert_id: product_params[:product_alert_id])
      end

      if product.name != product_params[:name]
        if !product_params[:name].blank?
          product.update(name: product_params[:name])
        end
      end

      if product.category.id.to_s != product_params[:category_id]
        product.update(category_id: product_params[:category_id])
      end

      if product.tag_ids.map(&:to_s) != product_params[:tag_ids]
        product.update(tag_ids: product_params[:tag_ids])
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
      :select_products,
      :products_none,
      category_ids: [],
      frame_ids: [],
      tag_ids: [],
      taggings_attributes: [:id, :tag_id, :_destroy]
    )
  end

  def authenticate_admin
    unless current_user.admin?
      redirect_to root_path, alert: "管理者でログインしてください"
    end
  end

end
