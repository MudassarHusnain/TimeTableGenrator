class ClassCourseSlotsController < ApplicationController
  before_action :set_class_course_slot, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  load_and_authorize_resource
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
    if @teacher_course

          @course = @teacher_course.course
        @teacher = @teacher_course.teacher

        #   this block of code is uses to get all the teacher slot for day1 and day2 he will teach and these are not assign to other class for that make clashes
        @teacher_reserved_slots_day1=ClassCourseSlot.get_the_teacher_used_slots(@teacher,'day1')
        @teacher_reserved_slots_day2=ClassCourseSlot.get_the_teacher_used_slots(@teacher,'day2')

        #   this block of code is used for not making duplication of course in one class

        @teacher_courses=@course.teacher_courses
        @handle_duplication_of_course = @class.class_course_slots.where(teacher_course_id: @teacher_courses.pluck(:id))
        if @handle_duplication_of_course.empty?

          #   this block of code is use for selecting all the slots that a class have already used for day1 and day2
          @class_used_slots_day1 = ClassCourseSlot.get_class_course_slots(@class,'day1')
          @class_used_slots_day2 = ClassCourseSlot.get_class_course_slots(@class,'day2')


          #   this is the total slots that we cannot be able to use it in the select combination of teacher and course
          @used_slots_day1 = (@class_used_slots_day1+ @teacher_reserved_slots_day1).uniq
          @used_slots_day2 = (@class_used_slots_day2+ @teacher_reserved_slots_day2).uniq

          #   all the slots for morning and afternoon class
          @slots_for_morning = @department.slots.where("EXTRACT(HOUR FROM start_time) <= ?", 12)
          @slots_for_afternoon= @department.slots.where("EXTRACT(HOUR FROM start_time) >= ?", 12)

          @available_slots_day1
          @available_slots_day2

          #   available slots for morning class and after
          if @class.class_type == 'morning'
          @available_slots_day1= @slots_for_morning.ids - @used_slots_day1
          @available_slots_day2 = @slots_for_morning.ids - @used_slots_day2
          else
            @available_slots_day1= @slots_for_afternoon.ids - @used_slots_day1
            @available_slots_day2 = @slots_for_afternoon.ids - @used_slots_day2
          end
          if !@available_slots_day1.empty?
            @class_course_slot = @class.class_course_slots.new(class_course_slot_params)
            @class_course_slot.slot_id = @available_slots_day1.first
            @class_course_slot.days = "day1"
          elsif !@available_slots_day2.empty?
            @class_course_slot = @class.class_course_slots.new(class_course_slot_params)
            @class_course_slot.slot_id = @available_slots_day2.first
            @class_course_slot.days = "day2"
          elsif @available_slots_day1.empty? && @available_slots_day2.empty?
            flash[:notice] = "There are no available slots for this Teacher that you have selected"
            redirect_to new_department_dep_class_class_course_slot_path(@department,@class) and return # Redirect to the new action
          end


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
          flash[:notice] = "Course Is already present."
          redirect_to new_department_dep_class_class_course_slot_path(@department,@class) # Redirect to the new action
        end
    else
      # Handle the case where teacher_course_id is nil
      flash[:alert] = "Please select a valid teacher course."
      redirect_to new_department_dep_class_class_course_slot_path(@department, @class)
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
    @class = DepClass.find_by(id: params[:dep_class_id])
    @class_course_slot.destroy

    respond_to do |format|
      format.html { redirect_to department_dep_class_url(@department,@class), notice: "Class course slot was successfully destroyed." }
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
