class Document < ApplicationRecord
  has_one :paper
  has_one :schedule

  def finish_edit
    self.finished=true
    self.save
  end
end
