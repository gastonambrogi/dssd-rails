class Document < ApplicationRecord
  has_one :paper
  has_one :schedule

  scope :finished, lambda { where(finished: true) }
  scope :without_schedule, lambda { where("id NOT IN (?)", Schedule.all.pluck(:document_id)) }

  def finish_edit
    self.finished=true
    self.save
  end
end
