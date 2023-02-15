require 'rails_helper'

RSpec.feature 'Posts management', type: :feature do
  before :each do
    User.create(name: 'user@example.com', photo: 'password', bio: 'bio')
  end
  scenario 'User creates a new post' do
    visit '/posts/new'
    fill_in 'Title', with: 'Test Post'
    fill_in 'Text', with: 'This is a post for testing purposes'
    click_button 'Post!'

    expect(page).to have_text('successfully')
  end
end
