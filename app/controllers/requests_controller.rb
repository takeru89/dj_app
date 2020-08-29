class RequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    request = Request.create(request_params)
    render json: { request: request,
                   request_date: request.created_at.strftime('%Y/%m/%d'),
                   request_person: request.user.nickname }
  end

  private

  def request_params
    params.permit(:request_word).merge(user_id: current_user.id)
  end
end
