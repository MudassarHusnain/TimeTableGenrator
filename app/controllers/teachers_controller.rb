class TeachersController < ApplicationController
  before_action :set_teacher, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /teachers or /teachers.json
  def index
    @department = Department.find_by(id: params[:department_id])
    @teachers = Teacher.all
  end

  # GET /teachers/1 or /teachers/1.json
  def show
    @department = Department.find_by(id: params[:department_id])

  end

  # GET /teachers/new
  def new
    @department = Department.find_by(id: params[:department_id])
    @teacher = @department.teachers.new
  end

  # GET /teachers/1/edit
  def edit
    @department = Department.find_by(id: params[:department_id])
  end

  # POST /teachers or /teachers.json
  def create
    @department = Department.find_by(id: params[:department_id])
    @teacher = @department.teachers.new(teacher_params)
    respond_to do |format|
      if @teacher.save
        format.html { redirect_to department_teachers_url(@department), notice: "Teacher was successfully created." }
        format.json { render :show, status: :created, location: @teacher }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teachers/1 or /teachers/1.json
  def update
    @department = Department.find_by(id: params[:department_id])
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to department_teachers_url(@department,@teacher), notice: "Teacher was successfully updated." }
        format.json { render :show, status: :ok, location: @teacher }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teachers/1 or /teachers/1.json
  def destroy
    @teacher.destroy

    respond_to do |format|
      format.html { redirect_to department_teachers_url, notice: "Teacher was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def teacher_params
      params.require(:teacher).permit(:name, :department_id)
    end
end
