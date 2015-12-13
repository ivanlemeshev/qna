require 'rails_helper'

feature 'Remove answer', %q(
  In order to remove my answer
  As an author of answer
  I want to have ability to remove my answers
) do
  given(:author)     { create(:user) }
  given(:non_author) { create(:user) }
  given(:question)   { create(:question) }
  given(:answer)     { create(:answer, question: question, user: author) }

  scenario 'Author of answer tries to delete it' do
    sign_in(author)
    write_answer(question)
    fill_in 'Body', with: 'Test answer'
    click_on 'Create Answer'
    visit question_path(question)
    click_on 'Remove answer'
    expect(page).to have_content 'Your answer successfully removed'
    expect(current_path).to eq question_path(question)
  end

  scenario 'Non-author of answer tries to delete it' do
    sign_in(non_author)
    visit question_path(question)
    expect(page).to_not have_content 'Remove answer'
  end
end
