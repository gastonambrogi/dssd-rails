class Paper < ApplicationRecord
  belongs_to :user
  belongs_to :document, optional: true, dependent: :destroy

  has_and_belongs_to_many :users

  validates :title, :summary, :theme, :personal_email, :email, :presentation, presence: true

  scope :not_evaluated, lambda { where(evaluated: false) }
  scope :unrevised, lambda { where(revised: false) }
  scope :evaluated, lambda { where(evaluated: true) }

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

  def mark_as_revised
    self.update revised: true
  end

  def is_revised?
    self.revised
  end
  def has_document?
    !self.document.nil?
  end
end
