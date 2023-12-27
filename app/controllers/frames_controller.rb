class FramesController < ApplicationController
  before_action :authenticate_admin, only: [:new, :create, :destroy]

  def index
    @frames = Frame.all
  end

  def new
    @frame = Frame.new
  end

  def confirm
    @frame = Frame.new(frame_params)
    render :new if @frame.invalid?
  end

  def create
    @frame = Frame.new(frame_params)
    if @frame.save
      redirect_to frames_path, notice: "傘骨情報を作成しました"
    else
      render :new
    end
  end

  def edit_confirm
    @changed_frames = []
    @data_table = {}
    modified = false

    if params[:frame].present?
      params[:frame].each do |frame_id, frame_params|
        frame = Frame.find(frame_id)
        next if frame_params[:inventory].blank? &&
          frame.frame_alert.id.to_s == frame_params[:frame_alert_id]

        if frame_params[:inventory].present?
          @data_table[frame.id] = frame_params[:inventory]
          frame.inventory += frame_params[:inventory].to_i
          modified = true
        end

        if frame.frame_alert.id.to_s != frame_params[:frame_alert_id]
          frame.frame_alert_id = frame_params[:frame_alert_id]
          modified = true
        end
        @changed_frames << frame if modified
      end
    end
    if modified
      render :edit_confirm
    else
      redirect_to frames_path, notice: "更新するものがありません"
    end
  end


  def modify
    if !params[:frame]
      redirect_to frames_path, notice: '更新するものがありません' and return
    end
    params[:frame].each do |frame_id, frame_params|
      frame = Frame.find(frame_id)
      next if frame.inventory.to_s == frame_params[:inventory] &&
      frame.frame_alert.id.to_s == frame_params[:frame_alert_id]
      if frame.inventory.to_s != frame_params[:inventory]
        frame.update(inventory: frame_params[:inventory])
      end
      if frame.frame_alert_id != frame_params[:frame_alert_id]
        frame.update(frame_alert_id: frame_params[:frame_alert_id])
      end
    end
    redirect_to frames_path, notice: '更新しました'
  end

  def destroy
    @frame = Frame.find(params[:id])
    if @frame.products.exists?
      redirect_to frames_path, alert: '商品と紐づけられているので削除できません'
    else
      @frame.destroy
      redirect_to frames_path, notice: '削除しました'
    end
  end

  private

  def frame_params
    params.require(:frame).permit(
      :name,
      :kind,
      :inventory,
      :frame_alert_id,
      frame_alerts_attributes: [:id, :quantity, :_destroy]
    )
  end

  def authenticate_admin
    unless current_user.admin?
      redirect_to root_path, alert: "管理者でログインしてください"
    end
  end

end
