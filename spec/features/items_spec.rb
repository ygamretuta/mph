require 'spec_helper'

feature "Items" do
  let!(:user) {FactoryGirl.create(:user)}
  let(:item) {FactoryGirl.create(:item)}

  background do
    login_as(user)
  end

  scenario 'create an item' do
    visit new_user_item_path(user)
    fill_in 'Name', with:'Sample Item'
    attach_file 'item_pictures_attributes_0_path', "#{Rails.root}/app/assets/images/image.jpg"
    click_button 'Post Ad'
    expect(page).to have_content 'Sample Item'
  end

  scenario 'search for an item' do
    visit root_path
    fill_in 'q', with:item.name
    click_button 'Search For It Here'
    expect(page).to have_content item.name
  end
end
