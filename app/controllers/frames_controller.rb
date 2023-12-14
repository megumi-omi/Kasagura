class FramesController < ApplicationController

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

  def edit_confirm
    @changed_frames = []
    params[:frame].each do |frame_id, frame_params|
      frame = Frame.find(frame_id)
      if frame.inventory.to_s != frame_params[:inventory]
        frame.inventory = frame_params[:inventory]
        @changed_frames << frame
      end
    end
    render :edit_confirm
  end

  def create
    @frame = Frame.new(frame_params)
    if params[:back]
      render :new
    else
      if @frame.save
        redirect_to frames_path, notice: "傘骨情報を作成しました"
      else
        render :new
      end
    end
  end

  def update_frames
    params[:frame].each do |frame_id, frame_params|
      frame = Frame.find(frame_id)
      if frame.inventory.to_s != frame_params[:inventory]
        frame.update(inventory: frame_params[:inventory])
      end
    end
    redirect_to frames_path, notice: '更新しました'

  end

  private

  def frame_params
    params.require(:frame).permit(
      :name,
      :kind,
      :inventory,
      :frame_alert_id
    )
  end

end
