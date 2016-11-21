class Document < ApplicationRecord
  has_one :paper
  has_one :schedule

  scope :finished, lambda { where(finished: true) }

  def finish_edit
    self.finished=true
    self.save
  end
end
