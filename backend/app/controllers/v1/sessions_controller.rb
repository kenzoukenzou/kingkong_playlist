class V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email])
    # has_secure_passwordを使うことでauthenticateメソッドが使えるようになる
    # ref: https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      cookies.permanent.signed[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { error: 'ログインに失敗しました。' }, status: :unauthorized
    end
  end

  def destroy
    cookies.delete(:user_id)
  end
end
