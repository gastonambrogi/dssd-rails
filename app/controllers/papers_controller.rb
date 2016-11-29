class PapersController < ApplicationController
  before_action :authenticate_user!, except: [:approved, :disapproved, :take_one_unrevised, :revised]
  before_action :set_paper, only: [:show, :edit, :update, :destroy, :approved, :disapproved, :revised]

  # GET /papers
  # GET /papers.json
  def index
    @papers = Paper.not_evaluated.where(user: current_user)
  end

  # GET /papers/1
  # GET /papers/1.json
  def show
  end

  # GET /papers/new
  def new
    @authors = get_users
    @paper = Paper.new
  end

  # POST /papers
  # POST /papers.json
  def create
    @paper = Paper.new(paper_params)
    @paper.user = current_user

    respond_to do |format|
      if @paper.save
        format.html { redirect_to @paper, notice: 'Paper was successfully created.' }
        format.json { render :show, status: :created, location: @paper }
      else
        @authors = get_users
        format.html { render :new }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  def take_one_unrevised
    paper = Paper.unrevised.first
    paper.mark_as_revised unless paper.nil?
    render json: paper
  end

  def approved
    unless @paper.has_document?
      file = create_drive_document @paper
      @paper.approved file.id
      render status: :ok, plain: file.human_url
    else
      render status: :ok, plain: @paper.document.gdocs_url
    end
  end

  def disapproved
    @paper.disapproved
    render status: :ok, plain: "Paper #{@paper.id} Desaprobado"
  end

  def revised
    @paper.mark_as_revised
    render json: @paper
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper
      @paper = Paper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_params
      params.require(:paper).permit!
    end

    def get_users
      User.all.where.not(id: current_user.id)
    end

    def create_drive_document(paper)
      drive_session = GoogleDrive::Session.from_service_account_key(
        "dssd-rails-grupo4-f789d79057b7.json",
        [
          "https://www.googleapis.com/auth/drive",
          "https://spreadsheets.google.com/feeds/",
        ]
      )
      file_title = paper.id
      unless drive_session.files.detect{|f| f.title == paper.id.to_s }.nil?
        file_title="#{file_title}_#{paper.title}"
      end

      # drive_session.files.each {|d| d.delete(permanent:true) }

      file = drive_session.upload_from_string(" ", file_title, :content_type => "text/plain")
      file.acl.push({ type: "user", email_address: paper.email, role: "writer" }, {send_notification_email: false}) #
      file
    end
end
