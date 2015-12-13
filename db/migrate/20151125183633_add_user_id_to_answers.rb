class AddUserIdToAnswers < ActiveRecord::Migration
  def change
    add_belongs_to :answers, :user, index: true
  end
end
