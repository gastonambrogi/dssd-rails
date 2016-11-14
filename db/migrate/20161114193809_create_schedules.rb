class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.string :author_name
      t.string :author_lastname
      t.string :paper_title
      t.datetime :publication_datetime
      t.string :place
      t.belongs_to :document, index: true
      t.timestamps
    end
  end
end
