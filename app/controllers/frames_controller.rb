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
