class UserMailer < ActionMailer::Base
  default from: "bsa@brown.edu"
  
  def send_reset_email(user)
    @user = user
    mail(:to => user.email, :subject => "Reset your BSA Payroll Password")
  end
  
  def send_reminder_email(user)
    @user = user
    mail(:to => user.email, :subject => "TIME TO SUBMIT PAYROLL")
  end
  
  def send_signature_required(timesheet)
    @timesheet = timesheet
    mail(:to => timesheet.user.email, :subject => "You forgot to sign for payroll..")
  end
end
