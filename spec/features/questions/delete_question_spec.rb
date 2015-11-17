require 'rails_helper'

feature 'Delete question', %q(
  In order to delete my question
  As an author of question
  I want to have ability to delete my questions
) do
  scenario 'Author of question tries to delete it'

  scenario 'Non author of question tries to delete it'
end
