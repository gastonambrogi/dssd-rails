class DocumentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @papers_approved = Paper.includes(:document).where(user: current_user, evaluated:true).where.not(document: nil)
  end

  def finished
    document=Document.find(params[:id])
    document.finish_edit

    redirect_to :documents
  end

  def stop_sharing
    document=Document.find(params[:id])

    drive_session = GoogleDrive::Session.from_service_account_key(
      "dssd-rails-grupo4-f789d79057b7.json",
      [ "https://www.googleapis.com/auth/drive", "https://spreadsheets.google.com/feeds/" ]
    )

    file = drive_session.file_by_id(document.gdocs_key)

    role_writer_index = file.acl.each.find_index { |p| p.role == 'writer' }

  	file.acl.delete(file.acl[role_writer_index])

    file.acl.push({ type: "user", email_address: "grupo4.dssd@gmail.com", role: "owner" }, { transfer_ownership:true })

    render json: document
  end
end
