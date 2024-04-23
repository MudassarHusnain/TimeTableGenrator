class DepClassesController < ApplicationController
  before_action :set_dep_class, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /dep_classes or /dep_classes.json
  def index
    @department = Department.find_by(id: params[:department_id])
    @dep_classes = DepClass.all
  end

  # GET /dep_classes/1 or /dep_classes/1.json
  def show
    @department = Department.find_by(id: params[:department_id])
    @dep_class = DepClass.find_by(id: params[:id])
  end

  # GET /dep_classes/new
  def new
    @department = Department.find_by(id: params[:department_id])
    @dep_class = @department.dep_classes.new
  end

  # GET /dep_classes/1/edit
  def edit
  end

  # POST /dep_classes or /dep_classes.json
  def create
    @department = Department.find_by(id: params[:department_id])
    @afternoon_classes = @department.dep_classes.where(class_type: dep_class_params[:class_type])
    @afternoon_available_rooms = @department.rooms.left_outer_joins(:dep_classes).where.not(id: @afternoon_classes.pluck(:room_id))

    if @afternoon_available_rooms.empty?
      flash[:notice] = "No rooms available for afternoon classes."
      redirect_to new_department_dep_class_path(@department) # Redirect to the new action
    else
      dep_class_params[:room_id] = @afternoon_available_rooms.uniq.first.id
      
      @dep_class = @department.dep_classes.new(dep_class_params)
      @dep_class.room_id = @afternoon_available_rooms.first.id

      respond_to do |format|
        if @dep_class.save
          format.html { redirect_to department_dep_class_url(@department, @dep_class), notice: "Dep class was successfully created." }
          format.json { render :show, status: :created, location: @dep_class }
        else
          format.html { render :new, status: :unprocessable_entity, notice: "Class not Created Due to Room is not available." }
          format.json { render json: @dep_class.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /dep_classes/1 or /dep_classes/1.json
  def update
    respond_to do |format|
      if @dep_class.update(dep_class_params)
        format.html { redirect_to department_dep_class_url(@dep_class.department,@dep_class), notice: "Dep class was successfully updated." }
        format.json { render :show, status: :ok, location: @dep_class }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dep_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dep_classes/1 or /dep_classes/1.json
  def destroy
    @dep_class.destroy

    respond_to do |format|
      format.html { redirect_to department_dep_classes_url, notice: "Dep class was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def download_pdf
    @department = Department.find_by(id: params[:department_id])
    @dep_class = DepClass.find_by(id: params[:dep_class_id])
    authorize! :download_pdf, @dep_class
    respond_to do |format|
      format.pdf do
        render pdf: "#{@dep_class.name.capitalize} Time Table",
               template: "dep_classes/download_pdf",
               disposition: 'attachment'
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dep_class
      @dep_class = DepClass.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dep_class_params
      params.require(:dep_class).permit(:name, :room_id, :department_id,:class_type, :strength)
    end
end
