class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :confirmable, :validatable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

  def owner_of?(model)
    model.user_id == id
  end
end
