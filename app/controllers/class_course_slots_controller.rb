class ClassCourseSlotsController < ApplicationController
  before_action :set_class_course_slot, only: %i[ show edit update destroy ]

  # GET /class_course_slots or /class_course_slots.json
  def index
    @department = Department.find_by(id: params[:department_id])
    @class = DepClass.find_by(id: params[:dep_class_id])
    @class_course_slots = @class.class_course_slots.all
  end

  # GET /class_course_slots/1 or /class_course_slots/1.json
  def show
    @department = Department.find_by(id: params[:department_id])
    @class = DepClass.find_by(id: params[:dep_class_id])
  end

  # GET /class_course_slots/new
  def new
    @department = Department.find_by(id: params[:department_id])
    @class = DepClass.find_by(id: params[:dep_class_id])


    @class_course_slot = @class.class_course_slots.new
  end

  # GET /class_course_slots/1/edit
  def edit
    @department = Department.find_by(id: params[:department_id])
    @class = DepClass.find_by(id: params[:dep_class_id])
  end

  # POST /class_course_slots or /class_course_slots.json
  def create
    @department = Department.find_by(id: params[:department_id])
    @class = DepClass.find_by(id: params[:dep_class_id])
    @teacher_course = TeacherCourse.find_by(id: class_course_slot_params[:teacher_course_id])
    @course = @teacher_course.course
    @teacher_courses=@course.teacher_courses
    @handle_duplication_of_course = @class.class_course_slots.where(teacher_course_id: @teacher_courses.pluck(:id))
    if @handle_duplication_of_course.empty?
      debugger
      @class_course_slot = @class.class_course_slots.new(class_course_slot_params)

      respond_to do |format|
        if @class_course_slot.save
          format.html { redirect_to department_dep_class_url(@department,@class), notice: "Class course slot was successfully created." }
          format.json { render :show, status: :created, location: @class_course_slot }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @class_course_slot.errors, status: :unprocessable_entity }
        end
      end
    else
      debugger
      flash[:notice] = "Course Is already present."
      redirect_to new_department_dep_class_class_course_slot_path(@department,@class) # Redirect to the new action
      end
  end

  # PATCH/PUT /class_course_slots/1 or /class_course_slots/1.json
  def update
    @department = Department.find_by(id: params[:department_id])
    @class = DepClass.find_by(id: params[:dep_class_id])
    respond_to do |format|
      if @class_course_slot.update(class_course_slot_params)
        format.html { redirect_to department_dep_class_class_course_slot_url(@department,@dep_class,@class_course_slot), notice: "Class course slot was successfully updated." }
        format.json { render :show, status: :ok, location: @class_course_slot }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @class_course_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_course_slots/1 or /class_course_slots/1.json
  def destroy
    @department = Department.find_by(id: params[:department_id])
    debugger
    @class = DepClass.find_by(id: params[:dep_class_id])
    @class_course_slot.destroy

    respond_to do |format|
      format.html { redirect_to department_dep_class_class_course_slots_url(@department,@class), notice: "Class course slot was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_class_course_slot
      @class_course_slot = ClassCourseSlot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def class_course_slot_params
      params.require(:class_course_slot).permit(:dep_class_id, :teacher_course_id, :slot_id,:days)
    end
end
