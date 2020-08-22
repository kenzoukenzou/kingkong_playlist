class V1::SearchController < ApplicationController
  

  def index
    @q = Video.ransack(params[:query])
    @videos = @q.result.order(:id)
  end
end
