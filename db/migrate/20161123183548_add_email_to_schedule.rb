class AddEmailToSchedule < ActiveRecord::Migration[5.0]
  def change
    add_column :schedules, :email, :string
  end
end
