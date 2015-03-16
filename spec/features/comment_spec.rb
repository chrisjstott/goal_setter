require 'rails_helper'

feature "the comment creation process" do


  before(:each) do
    user = User.create(username: 'testing_username', password: 'biscuits')
    goal = Goal.create(content: "i'm testing goals content" status: "incomplete" privacy: "public")
    visit new_session_url
    fill_in 'username', with: :testing_username
    fill_in 'password', with: :biscuits
    click_on "Sign In"
  end

  scenario "goal has a new comment form" do
    visit goal_url(goal)
    expect(page).to have_content "New Comment"
  end

  scenario "creates goal comment" do
    visit goal_url(goal)
    fill_in 'body', with: "hey man I can appreciate your efforts in testing goals content"
    click_on "Add Comment"
    expect(page).to have_content "hey man"
  end

  scenario "user has a new comment form" do
    visit user_url(user)
    expect(page).to have_content "New Comment"
  end

  scenario "creates user comment" do
    visit user_url(user)
    fill_in 'body', with: "hey man gj"
    click_on "Add Comment"
    expect(page).to have_content "hey man gj"
  end

end
