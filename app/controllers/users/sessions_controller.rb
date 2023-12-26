class Users::SessionsController < Devise::SessionsController
  def general_guest_sign_in
    user = User.general_guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザー(一般)としてログインしました。'
  end

  def admin_guest_sign_in
    user = User.admin_guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザー(管理者)としてログインしました。'
  end
end