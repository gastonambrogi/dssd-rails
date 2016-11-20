class Paper < ApplicationRecord
  belongs_to :user
  belongs_to :document, optional: true

  has_and_belongs_to_many :users

  validates :title, :summary, :theme, :personal_email, :email, :presentation, presence: true

  scope :not_evaluated, lambda { where(evaluated: false) }

  def approved(gdrive_key)
    if self.document.nil?
      self.evaluated = true
      self.document = Document.create(paper: self, gdocs_key: gdrive_key, id_document: self.id)
      self.save
    end
  end

  def disapproved
    unless self.evaluated
      self.evaluated = true
      self.save
    end
  end
end
