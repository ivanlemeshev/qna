require 'rails_helper'

feature 'Create answer', %q(
  In order to help
  As an authenticated user
  I want to have ability to answer questions
) do
  given(:user)     { create :user }
  given(:question) { create :question, user: user }

  scenario 'Authenticated user creates answer with valid data', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Your answer', with: 'Test answer'
    click_on 'Create Answer'
    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'Test answer'
    end
  end

  scenario 'Authenticated user tries to create answer with invalid body' do
    sign_in(user)
    visit question_path(question)
    fill_in 'Your answer', with: nil
    expect(current_path).to eq question_path(question)
  end

  scenario 'Unauthenticated user tries to create answer' do
    visit question_path(question)
    expect(page).to have_content 'You need to sign in to answer the question.'
  end
end
