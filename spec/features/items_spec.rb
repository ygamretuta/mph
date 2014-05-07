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
    expect(find('ul.right li span').text).to eq('5')
  end

  scenario 'create an invalid item' do
    visit new_user_item_path(user)
    fill_in 'Name', with:''
    attach_file 'item_pictures_attributes_0_path', "#{Rails.root}/app/assets/images/image.jpg"
    click_button 'Post Ad'
    expect(find('ul.right li span').text).to eq('0')
  end

  scenario 'search for an item' do
    visit root_path
    fill_in 'q', with:item.name
    click_button 'Search For It Here'
    expect(page).to have_content item.name
  end
end
