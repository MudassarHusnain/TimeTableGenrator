class LeaveRequestsController < ApplicationController
  def index
    @current_user_leave_requests = current_user.leave_requests
    @leave_requests = LeaveRequest.all
  end

  def new
    @leave_request = current_user.leave_requests.new
  end

  def create
    @leave_request = current_user.leave_requests.new(leave_request_params)
    @leave_request.user_name = current_user.username
    if @leave_request.save
      flash[:notice] = "Your is send for approval"
      redirect_to leave_requests_path
    end

  end


  def approved
   @leave_request = LeaveRequest.find_by(id: params[:leave_request_id])
     @leave_request.status = true
     if @leave_request.save
       flash[:notice] = "Leave request is Approved"
       redirect_to leave_requests_path
     end

  end

  private

  def leave_request_params
    params.require(:leave_request).permit(:user_id,:start_date,:end_date,:user_name,:status)
  end
end
