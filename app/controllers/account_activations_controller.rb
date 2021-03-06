class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      flash[:success] = t "activations.edit.activated"
      redirect_to user
    else
      flash[:danger] = t "activations.edit.invalid_link"
      redirect_to root_url
    end
  end
end
