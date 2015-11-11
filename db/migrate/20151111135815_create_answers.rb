class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body

      t.timestamps null: false
    end

    add_belongs_to :answers, :question, index: true
  end
end
