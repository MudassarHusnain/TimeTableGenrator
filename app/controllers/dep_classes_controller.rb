class DepClassesController < ApplicationController
  before_action :set_dep_class, only: %i[ show edit update destroy ]

  # GET /dep_classes or /dep_classes.json
  def index
    @department = Department.find_by(id: params[:department_id])
    @dep_classes = DepClass.all
  end

  # GET /dep_classes/1 or /dep_classes/1.json
  def show
    @department = Department.find_by(id: params[:department_id])
  end

  # GET /dep_classes/new
  def new
    @department = Department.find_by(id: params[:department_id])
    @available_rooms = @department.rooms.left_outer_joins(:dep_classes).where(dep_classes: { room_id: nil })
    debugger
    @dep_class = @department.dep_classes.new
  end

  # GET /dep_classes/1/edit
  def edit
  end

  # POST /dep_classes or /dep_classes.json
  def create
    @department = Department.find_by(id: params[:department_id])
    @dep_class = @department.dep_classes.new(dep_class_params)

    respond_to do |format|
      if @dep_class.save
        format.html { redirect_to department_dep_class_url(@department,@dep_class), notice: "Dep class was successfully created." }
        format.json { render :show, status: :created, location: @dep_class }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dep_class.errors, status: :unprocessable_entity }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dep_class
      @dep_class = DepClass.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dep_class_params
      params.require(:dep_class).permit(:name, :room_id, :department_id, :strength)
    end
end
