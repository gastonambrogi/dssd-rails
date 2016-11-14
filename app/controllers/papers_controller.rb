class PapersController < ApplicationController
  before_action :set_paper, only: [:show, :edit, :update, :destroy, :approved]

  # GET /papers
  # GET /papers.json
  def index
    @papers = Paper.where(user: current_user)
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

# GET /papers/1/edit
#  def edit
#    @authors = get_users
#  end

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

  def approved
    @paper.approved
    render nothing: true, status: :ok, json: @paper
  end
# PATCH/PUT /papers/1
# PATCH/PUT /papers/1.json
#  def update
#    respond_to do |format|
#      if @paper.update(paper_params)
#        format.html { redirect_to @paper, notice: 'Paper was successfully updated.' }
#        format.json { render :show, status: :ok, location: @paper }
#      else
#        @authors = get_users
#        format.html { render :edit }
#        format.json { render json: @paper.errors, status: :unprocessable_entity }
#      end
#    end
#  end

# DELETE /papers/1
# DELETE /papers/1.json

#  def destroy
#    @paper.destroy
#    respond_to do |format|
#      format.html { redirect_to papers_url, notice: 'Paper was successfully destroyed.' }
#      format.json { head :no_content }
#    end
#  end

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
end
