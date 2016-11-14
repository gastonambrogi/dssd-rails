class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :gdocs_key
      t.boolean :finished, default: false
      t.integer :id_document
      t.timestamps
    end
  end
end
