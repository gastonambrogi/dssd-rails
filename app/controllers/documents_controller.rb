class DocumentsController < ApplicationController
  def index
    @papers_approved = Paper.includes(:document).where(user: current_user, evaluated:true).where.not(document: nil)
  end

  def finished
    Document.find(params[:id]).finish_edit
    redirect_to :documents
  end
end
