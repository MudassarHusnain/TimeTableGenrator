class MakeupsController < ApplicationController

  def index

    @current_user_makeups = current_user.makeups
    @makeups = Makeup.all

  end
  def new
    @makeup = Makeup.new
    @department = Department.find_by(id: current_user.department_id)
  end

  def create

    @department = Department.find_by(id: current_user.department_id)
    @class = DepClass.find_by(id: makeup_params[:dep_class_id])
    @teacher_course = TeacherCourse.find_by(id: makeup_params[:teacher_course_id])
    if @teacher_course

      @course = @teacher_course.course
      @teacher = @teacher_course.teacher

      #   this block of code is uses to get all the teacher slot for day1 and day2 he will teach and these are not assign to other class for that make clashes
      @teacher_reserved_slots_day3=Makeup.get_the_teacher_used_slots(@teacher,'day3')

      #   this block of code is used for not making duplication of course in one class

      @teacher_courses=@course.teacher_courses
      @handle_duplication_of_course = @class.makeups.where(teacher_course_id: @teacher_courses.pluck(:id))
      if @handle_duplication_of_course.empty?

        #   this block of code is use for selecting all the slots that a class have already used for day1 and day2
        @class_used_slots_day3 = Makeup.get_class_course_slots(@class,'day3')


        #   this is the total slots that we cannot be able to use it in the select combination of teacher and course
        @used_slots_day3 = (@class_used_slots_day3+ @teacher_reserved_slots_day3).uniq

        #   all the slots for morning and afternoon class
        @slots_for_morning = @department.slots.where("EXTRACT(HOUR FROM start_time) <= ?", 12)
        @slots_for_afternoon= @department.slots.where("EXTRACT(HOUR FROM start_time) >= ?", 12)

        @available_slots_day3

        #   available slots for morning class and after
        if @class.class_type == 'morning'
          @available_slots_day3= @slots_for_morning.ids - @used_slots_day3
        else
          @available_slots_day3= @slots_for_afternoon.ids - @used_slots_day3
        end
        if !@available_slots_day3.empty?
          @class_course_slot = @class.makeups.new(makeup_params)
          @class_course_slot.slot_id = @available_slots_day3.first
          @class_course_slot.days = "day3"
        else
          flash[:notice] = "There are no available slots for this Teacher that you have selected"
          redirect_to new_department_dep_class_class_course_slot_path(@department,@class) and return # Redirect to the new action
        end

        @class_course_slot.user_id = current_user.id
        respond_to do |format|
          if @class_course_slot.save
            format.html { redirect_to makeups_path, notice: "Class course slot was successfully created." }
            format.json { render :show, status: :created, location: @class_course_slot }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @class_course_slot.errors, status: :unprocessable_entity }
          end
        end


      else
        flash[:notice] = "Course Is already present."
        redirect_to new_makeup_path(@department) # Redirect to the new action
      end
    else
      # Handle the case where teacher_course_id is nil
      flash[:alert] = "Please select a valid teacher course."
      redirect_to new_makeup_path(@department)
    end
  end

  def approved
    @makeup = Makeup.find_by(id: params[:makeup_id])
    @makeup.status = true
    if @makeup.save
      redirect_to makeups_path
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_makeup
    @makeup = Makeup.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def makeup_params
    params.require(:makeup).permit(:slot_id, :dep_class_id,:days,:teacher_course_id,:status,:user_id)
  end
end
