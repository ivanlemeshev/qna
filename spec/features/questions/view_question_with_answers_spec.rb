require 'rails_helper'

feature 'View question with a list of answers', %q(
  In order to find best answer on question
  As an user
  I want to have ability to view questions with a list of answers
) do
  given(:question_author) { create :user }
  given(:answer_author)   { create :user }
  given(:question)        { create :question, user: question_author }
  given!(:answers)        { create_list :answer, 3, question: question, user: answer_author }

  scenario 'View question with a list of answers' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each { |answer| expect(page).to have_content answer.body }
  end
end
