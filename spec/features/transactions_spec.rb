require 'spec_helper'

feature "Transactions" do
  let!(:user) {FactoryGirl.create(:user)}
  let!(:item) {FactoryGirl.create(:item)}


  background do
    login_as(user)
  end

  scenario 'create a transaction' do
    visit root_path
    fill_in 'q', with: item.name
    click_button 'Search For It Here'
    click_link 'Reserve'
    expect(page).to have_content item.name
  end
end