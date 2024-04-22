class CoursesController < ApplicationController
  before_action :set_course,:set_department, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /courses or /courses.json
  def index
    @department = Department.find_by(id: params[:department_id])
    @courses = Course.all
  end

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @department = Department.find(params[:department_id])
    @course = @department.courses.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @teacher = Teacher.find(params[:course][:teacher_id])
    @department = Department.find(params[:department_id])
    # debugger
    @course = Course.find_by(courseName: course_params[:courseName]) || @department.courses.new(course_params.except(:teacher_id))
    @teacher.courses << @course

    respond_to do |format|
      if @course.save
        format.html { redirect_to department_course_path(@department,@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        flash[:error] = "Already have a Course and Teacher"
        format.html { redirect_to new_department_course_path, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to department_course_url(@course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to department_courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end
    def set_department
      @department = Department.find(params[:department_id])
    end
    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:courseName, :department_id)
    end
end
