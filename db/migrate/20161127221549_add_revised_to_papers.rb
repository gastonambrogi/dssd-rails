class AddRevisedToPapers < ActiveRecord::Migration[5.0]
  def change
    add_column :papers, :revised, :boolean, default: false
  end
end
