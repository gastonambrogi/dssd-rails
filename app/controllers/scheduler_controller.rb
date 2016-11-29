class SchedulerController < ApplicationController
  layout "scheduler_layout"

  def index
    @documents = Document.finished.without_schedule
  end

  def scheduled
    render json: Schedule.all
  end

  def schedule
    document = Document.includes(:schedule, paper: :user).find(params[:id])

    unless document.schedule.present?
      paper=document.paper
      author= paper.user
      email= paper.email

      from=Date.today+1.week
      to=Date.today+2.week
      date=Faker::Time.between(from, to, :day)

      schedule=Schedule.create email:email, author_name: author.name, author_lastname: author.lastname, paper_title: paper.title, publication_datetime: date.to_datetime, place: "Aula #{Faker::Space.constellation}", document: document

      SchedulerMailer.schedule_email(schedule).deliver_now
    else
      schedule = document.schedule
    end

    render json: schedule
  end

  def generate_index
    index_entries = Schedule.all.map { |s| s.to_index_entry }.join("\n")

    drive_session = GoogleDrive::Session.from_service_account_key(
      "dssd-rails-grupo4-f789d79057b7.json",
      [
        "https://www.googleapis.com/auth/drive",
        "https://spreadsheets.google.com/feeds/",
      ]
    )

    # drive_session.files.each {|d| d.delete(permanent:true) }

    file = drive_session.upload_from_string(index_entries, "indice.pdf", content_type: 'application/pdf')

    file.acl.push({ type: "user", email_address: "grupo4.dssd@gmail.com", role: "owner" }, { transfer_ownership:true })
    render status: :ok, plain: file.human_url
  end
end
