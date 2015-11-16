module ControllerMacros
  def sign_in_user
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @user = create(:user)
      @user.confirm
      sign_in @user
    end
  end
end
