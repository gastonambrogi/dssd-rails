class SchedulerMailer < ApplicationMailer
  default from: 'grupo4.dssd@gmail.com'

  def schedule_email(schedule)
    mail(to: schedule.email,
         body: schedule.scheduled_message,
         subject: "DSSD2016 - Trabajo Programado")
  end
end
