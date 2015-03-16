require 'rails_helper'

feature "the goal creation process" do


  before(:each) do
    User.create(username: 'testing_username', password: 'biscuits')
    visit new_session_url
    fill_in 'username', with: :testing_username
    fill_in 'password', with: :biscuits
    click_on "Sign In"
  end

  scenario "has a new goal page" do
    visit new_goal_url
    expect(page).to have_content "New Goal"
  end


  scenario "making a goal" do
    visit new_goal_url
    choose "Private"
    fill_in 'content', with: "My first goal"
    click_on "Submit"
    expect(page).to have_content "My first goal"
    expect(page).to_not have_content "Submit"
  end

  scenario "shows private / public goals appropriately" do
    Goal.create(content: "i'm public", user_id: 1, privacy: "public", status: "incomplete")
    Goal.create(content: "i'm private", user_id: 1, privacy: "private", status: "incomplete")
    visit goals_url
    expect(page).to have_content "i'm public"
    expect(page).to have_content "i'm private"
    click_on "Log Out"
    visit goals_url
    expect(page).to have_content "i'm public"
    expect(page).to_not have_content "i'm private"
  end

  scenario "updating a goal" do
    goal = Goal.create(content: "edit me", user_id: 1, privacy: "public", status: "incomplete")
    visit edit_goal_url(goal)
    fill_in "content", with: "Edited goal"
    click_on "Submit"
    expect(page).to have_content "Edited goal"
    expect(page).to_not have_content "Submit"
    expect(page).to_not have_content "edit me"
  end


  scenario "deleting a goal" do
    Goal.create(content: "delete me", user_id: 1, privacy: "public", status: "incomplete")
    visit goals_url
    click_on "Remove Goal"
    expect(page).to_not have_content "delete me"
  end
end

feature "completion tracking" do
  before(:each) do
    User.create(username: 'testing_username', password: 'biscuits')
    visit new_session_url
    fill_in 'username', with: :testing_username
    fill_in 'password', with: :biscuits
    click_on "Sign In"
  end

  scenario "tracks progress of goals" do
    goal = Goal.create(content: "testing completion", user_id: 1, privacy: "public", status: "incomplete")
    visit goals_url
    expect(page).to have_content "incomplete"
    click_on "Edit Goal"
    choose "complete"
    visit goals_url
    expect(page).to have_content "complete"
  end

end
