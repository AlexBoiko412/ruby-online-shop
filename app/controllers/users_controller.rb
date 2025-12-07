class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    user_params = params.require(:user)

    password_changed = user_params[:password].present? || user_params[:password_confirmation].present?

    if password_changed
      if @user.update_with_password(update_params)
        sign_in @user, bypass: true
        redirect_to user_profile_path, notice: "Пароль успішно змінено!"
      else
        render :edit, status: :unprocessable_entity
      end
    else
      unless @user.valid_password?(user_params[:current_password])
        @user.errors.add(:current_password, "неправильний")
        render :edit, status: :unprocessable_entity
        return
      end

      if @user.update(email: user_params[:email], phone: user_params[:phone])
        redirect_to user_profile_path, notice: "Профіль успішно оновлено!"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  private

  def update_params
    params.require(:user).permit(
      :email,
      :phone,
      :password,
      :password_confirmation,
      :current_password
    )
  end
end