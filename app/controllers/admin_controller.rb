class AdminController < ApplicationController
  layout 'application', :except => [:print_timesheet]
  before_filter :check_session
  
  def index
  end
  
  # Reminder Emails
  def send_reminders
    submitted = Week.current.collect { |week| week.user_id }
    User.worker.select { |user| not submitted.include? user.id }.each { |user| UserMailer.send_reminder_email(user).deliver }
    render :text => "OK"
  end
  
  # Print Timesheets
  def timesheets
    @weeks = Week.current((params[:weeks_ago] ||= 0).to_i).select { |week| week.user and week.user.report_payroll }
    respond_to do |format|
      format.html { render layout: false }
      format.xlsx {
        render xlsx: "timesheets", disposition: "attachment", filename: "payroll_#{Time.now.strftime("%m%d")}.xlsx"
      }
    end
  end
  
  def timesheet
    @week = Week.find(params[:id])
    render :layout => false
  end
end
