class MakeupsController < ApplicationController
  def new
    @makeup = Makeup.new
    @department = Department.find_by(id: current_user.department_id)
  end

  def create
  end
end
