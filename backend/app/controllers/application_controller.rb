class ApplicationController < ActionController::API
  include ActionController::Cookies

  def authenticate_user!
    user = User.find(cookies.signed[:user_id])
    unless user
      render json: { message: 'unauthorized' }, status: 401
    end
  end
end
