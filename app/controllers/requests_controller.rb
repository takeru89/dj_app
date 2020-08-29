class RequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @request = Request.new(request_params)
    if @request.save
      redirect_to root_path
    else
      flash.now[:alert] = 'Request Failed'
      render root_path
    end
  end

  def destroy
    @request = Request.find(request_params)
    if @request.destroy
      redirect_to root_path
    else
      flash.now[:alert] = 'Delete Failed'
      render root_path
    end
  end

  private

  def request_params
    params.permit(:request_word).merge(user_id: current_user.id)
  end
end
