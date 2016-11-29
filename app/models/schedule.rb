class Schedule < ApplicationRecord
  belongs_to :document

  def to_index_entry(i)
    "(Página: #{i}) Autor: #{self.author_lastname}, #{self.author_name}. Paper: \"#{self.paper_title}\". Fecha: #{self.publication_datetime.strftime('%e/%m/%y')}  #{self.publication_datetime.strftime('%H:%M')}. Lugar: #{self.place}. "
  end

  def scheduled_message
    "Su trabajo #{self.paper_title} fue programado para el dia #{self.publication_datetime.strftime('%e/%m/%y')} a las #{self.publication_datetime.strftime('%H:%M')} en el #{self.place}."
  end
end
