require 'rails_helper'

feature 'View a list of questions', %q(
  In order to find a question
  As an user
  I want to have ability to view a list of questions
) do
  scenario 'User view a list of questions' do
    user = create :user
    questions = create_list :question, 2, user: user
    visit questions_path
    expect(page).to have_link questions[0].title, href: question_path(questions[0])
    expect(page).to have_link questions[1].title, href: question_path(questions[1])
  end
end
