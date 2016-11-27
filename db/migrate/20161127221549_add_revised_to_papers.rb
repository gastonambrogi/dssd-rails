class AddRevisedToPapers < ActiveRecord::Migration[5.0]
  def change
    add_column :papers, :revised, :boolean
  end
end
