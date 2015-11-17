require 'rails_helper'

feature 'Delete answer', %q(
  In order to delete my answer
  As an author of answer
  I want to have ability to delete my answers
) do
  scenario 'Author of `answer` tries to delete it'

  scenario 'Non author of answer tries to delete it'
end
