class RequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @request = Request.new(params[:rquest])
    if @request.save
      redirect_to root_path
    else
      flash.now[:alert] = 'Request Failed'
      render root_path
    end
  end

  def destroy
    @request = Request.find(params[:id])
    if @request.destroy
      redirect_to root_path
    else
      flash.now[:alert] = 'Delete Failed'
      render root_path
    end
  end
end
