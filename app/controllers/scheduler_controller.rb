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
end
