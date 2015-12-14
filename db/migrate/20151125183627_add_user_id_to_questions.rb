class AddUserIdToQuestions < ActiveRecord::Migration
  def change
    add_belongs_to :questions, :user, index: true, foreign_key: true
  end
end
