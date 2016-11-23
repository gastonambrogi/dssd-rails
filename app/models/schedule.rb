class Schedule < ApplicationRecord
  belongs_to :document

  def scheduled_message
    "Su trabajo " + self.paper_title + " fue programado para el dia "+ self.publication_datetime.strftime('%e/%m/%y')+" a las "+ self.publication_datetime.strftime('%H:%M')+" en el "+self.place+"."
  end
end
