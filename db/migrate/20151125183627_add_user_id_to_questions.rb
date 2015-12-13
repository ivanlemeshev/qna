class AddUserIdToQuestions < ActiveRecord::Migration
  def change
    add_belongs_to :questions, :user, index: true
  end
end
