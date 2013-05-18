class UserController < ApplicationController
  before_filter :check_session
  
  def index
    @title = "Enter Payroll"
    (@timesheet = @user.timesheet).update_attributes(params[:timesheet]) if request.post?
  end
  
  def esign
    @title = "eSign Payroll"
    @timesheet = @user.weeks.find(params[:id])
    @timesheet.update_attributes(params[:timesheet]) if request.post?
  end
  
  def new_batch
    @title = "Record Credit Card Batch"
    redirect_to "/login?error=p_inv" unless @user.can_submit_batches
    
    if request.post?
      batch = params[:batch]
      # Set restricted parameters
      batch[:user_id] = @user.id
      batch[:gl_account_number] = ""
      batch[:customer_code] = ""
      begin
        batch[:batch_date] = Date.parse("#{params[:batch]["batch_date(2i)"]}/#{params[:batch]["batch_date(3i)"]}/#{Time.now.year.to_s}")
      rescue
        batch[:batch_date] = Time.now
      end
      begin
        @batch = CCBatch.create(batch) 
      rescue Exception => e
        logger.info e.inspect # An error has ocurred - give an error notice if request.post? and the view is being rendered
      else
        redirect_to "/user/print_batch/#{@batch.id}"
      end
    end
  end
  
  def print_batch
    @title = "Credit Card Transactional Spreadsheet"
    @batch = CCBatch.find(params[:id]) if @user.is_admin or @user.can_submit_batches
    render :layout => false
  end

  def edit
    @title = "Change Password"
    @user.update_attributes(params[:user_profile]) if params[:user_profile]
  end
end
