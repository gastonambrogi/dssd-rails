class AddSharingToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :sharing, :boolean, default: true
  end
end
