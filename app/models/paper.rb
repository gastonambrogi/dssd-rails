class Paper < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :users

  validates :title, :user_id, :summary, :theme, :personal_email, :email, :presentation, presence: true
end
