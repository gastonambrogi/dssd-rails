class Paper < ApplicationRecord
  belongs_to :user
  belongs_to :document, optional: true

  has_and_belongs_to_many :users

  validates :title, :summary, :theme, :personal_email, :email, :presentation, presence: true

  scope :without_approbation, lambda { where(document: nil) }

  def approved
    if self.document.nil?
      self.document = Document.create paper: self
      self.save
    end
  end
end
