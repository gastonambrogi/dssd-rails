class AddDocumentReferenceToPapers < ActiveRecord::Migration[5.0]
  def change
      add_reference :papers, :document, index: true, foreign_key: true
  end
end
