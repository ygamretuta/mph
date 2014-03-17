require 'spec_helper'

feature "Items" do
  let!(:user) {FactoryGirl.create(:user)}

  background do
    login_as(user)
  end

  scenario 'create an item' do
    visit new_user_item_path(user)
    click_link 'Post An Ad'
    expect(page).to have_content 'Post An Ad'
  end
end
