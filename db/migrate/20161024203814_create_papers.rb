class CreatePapers < ActiveRecord::Migration[5.0]
  def change
    create_table :papers do |t|
      t.string :title
      t.belongs_to :user, index: true
      t.text :summary
      t.string :theme
      t.string :personal_email
      t.string :email
      t.string :presentation
      t.boolean :evaluated, default: false

      t.timestamps
    end

    create_join_table :papers, :users
  end
end
