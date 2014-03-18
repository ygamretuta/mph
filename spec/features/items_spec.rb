require 'spec_helper'

feature "Items" do
  let!(:user) {FactoryGirl.create(:user)}

  background do
    login_as(user)
  end

  scenario 'create an item' do
    visit new_user_item_path(user)
    fill_in 'Name', with:'Sample Item'
    attach_file 'item_pictures_attributes_0_path', "#{Rails.root}/app/assets/images/image.jpg"
    click_button 'Create Item'
    expect(page).to have_content 'Sample Item'
  end
end
