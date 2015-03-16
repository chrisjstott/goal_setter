require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'username', with: :testing_username
      fill_in 'password', with: :biscuits
      click_on "Create User"
      expect(page).to have_content "testing_username"
    end

  end

end

feature "logging in" do

  before(:each) do
    User.create(username: 'testing_username', password: 'biscuits')
  end

  scenario "shows username on the homepage after login" do
    visit new_session_url
    fill_in 'username', with: :testing_username
    fill_in 'password', with: :biscuits
    click_on "Sign In"
    expect(page).to have_content "testing_username"
  end

end

feature "logging out" do

  before(:each) do
    User.create(username: 'testing_username', password: 'biscuits')
  end

  it "begins with logged out state" do
    visit goals_url
    expect(page).to have_content "Sign In"
  end

  it "doesn't show username on the homepage after logout" do
    visit new_session_url
    fill_in 'username', with: :testing_username
    fill_in 'password', with: :biscuits
    click_on "Sign In"
    click_on "Log Out"
    expect(page).to_not have_content "testing_username"
  end


end
