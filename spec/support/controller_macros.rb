# https://github.com/plataformatec/devise/wiki/How-To:-Controllers-tests-with-Rails-3-(and-rspec)
module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
  end

  def login_user_with_item
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      @item = FactoryGirl.create(:item, user:@user)
      Item.searchkick_index.refresh
      sign_in @user
    end
  end

  def login_seller
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @item = FactoryGirl.create(:item)
      @transaction = FactoryGirl.create(:transaction, item:@item)
      @user = @transaction.seller
      sign_in @user
    end
  end
end