require 'spec_helper'

describe ItemsController do
  let(:item){@item}
  let(:user){@user}

  login_user_with_item

  def valid_attributes
    FactoryGirl.attributes_for(:item)
  end

  describe 'GET index' do
    it 'assigns all items as items' do
      get :index, {user_id:user.id}
      expect(assigns(:items)).to eq([item])
    end
  end

  describe 'GET show' do
    it 'assigns the requested item as item' do
      get :show, {id:item.id.to_s, user_id:user.id}
      expect(assigns(:item)).to eq(item)
    end
  end

  describe 'GET new' do
    it 'assigns new item as item' do
      get :new, {user_id:user.id}
      expect(assigns(:item)).to be_a_new(Item)
    end
  end

  describe 'GET edit' do
    let(:item2){FactoryGirl.create(:item)}
    subject {get :edit, {id:item2.id, user_id:item2.user.id}}

    it 'redirects to root if user does not own item' do
      expect(subject).to redirect_to(root_path)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      subject{post :create, user_id:user.id, item:valid_attributes}

      it 'redirects to item show' do
        expect(subject).to redirect_to user_item_path(user, Item.last)
      end

      it 'creates an Item' do
        # using subject here does not work
        expect{post :create, user_id:user.id, item:valid_attributes}.to change(Item, :count).by(1)
      end

      it 'decreases allowed ads count by 1' do
        # login_with_user creates an item for the user, so we can immediately check it here
        expect(user.allowed_ads_today).to eq(1)
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested item' do
        expect_any_instance_of(Item).to receive(:update).with({'name' => item.name})
        put :update, id:item.id, :item => {'name' => item.name}, :user_id => user.id
      end

      it 'assigns the requested item as item' do
        put :update, {id:item.id, item:valid_attributes ,user_id:user.id}
        expect(response).to redirect_to([user, item])
      end

      it 'redirects to the item' do
        put :update, {id:item.id, item:valid_attributes, user_id:user.id}
        expect(response).to redirect_to([user, item])
      end
    end
  end
end