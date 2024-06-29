class UsersController < ApplicationController
  def update
    if current_user.update(user_params)
    redirect_to root_path

    else
    render :edit, status: :unprocessable_entity
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :nickname, :lastname, :firstname, :lastname_kana, :firstname_kana, :birthday)
  end
end
end
