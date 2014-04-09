# https://github.com/plataformatec/devise/wiki/How-To:-Controllers-tests-with-Rails-3-(and-rspec)
module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      # user.confirm
      sign_in @user
    end
  end

  def login_seller
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @item = FactoryGirl.create(:item)
      @user = @item.user
      # @user.confirm
      sign_in @user
    end
  end
end