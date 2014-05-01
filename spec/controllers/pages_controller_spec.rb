require 'spec_helper'

describe PagesController do
  let(:item){@item}
  let(:user){@user}

  login_user_with_item

  describe 'GET search', es:true do
    it 'searches for an item' do
      get :search, q:'Item'
      expect(assigns(:items).results).to eq([@item])
    end
  end
end