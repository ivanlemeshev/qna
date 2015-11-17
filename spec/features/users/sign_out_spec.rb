require 'rails_helper'

feature 'User sign out', %q(
  In order to be able to exit from system
  As an authenticated user
  I want to have ability to sign out
) do
  scenario 'Authenticated user try to sign out'

  scenario 'Unauthenticated user try to sign out'
end
