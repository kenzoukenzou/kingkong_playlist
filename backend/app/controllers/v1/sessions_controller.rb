class V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email])
    # has_secure_passwordを使うことでauthenticateメソッドが使えるようになる
    # ref: https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
    if user && user.authenticate(params[:session][:password])
      render json: user
    else
    end
  end

  def destroy; end
end
