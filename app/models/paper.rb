class Paper < ApplicationRecord
  belongs_to :user
  belongs_to :document

  has_and_belongs_to_many :users

  validates :title, :user_id, :summary, :theme, :personal_email, :email, :presentation, presence: true


  def approved
    if self.document.nil?
      self.document = Document.create paper: self
      self.save
    end
  end
end
