class SlotsController < ApplicationController
  before_action :set_slot, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /slots or /slots.json
  def index
    @department = Department.find_by(id: params[:department_id])
    @slots = Slot.all
  end

  # GET /slots/1 or /slots/1.json
  def show
  end

  # GET /slots/new
  def new
    @department = Department.find_by(id: params[:department_id])

    @slot = @department.slots.new
  end

  # GET /slots/1/edit
  def edit
  end

  # POST /slots or /slots.json
  def create
    @department = Department.find_by(id: params[:department_id])

    @slot = @department.slots.new(slot_params)

    respond_to do |format|
      if @slot.save
        format.html { redirect_to department_slot_url(@department,@slot), notice: "Slot was successfully created." }
        format.json { render :show, status: :created, location: @slot }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slots/1 or /slots/1.json
  def update
    respond_to do |format|
      if @slot.update(slot_params)
        format.html { redirect_to department_slot_url(@slot), notice: "Slot was successfully updated." }
        format.json { render :show, status: :ok, location: @slot }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slots/1 or /slots/1.json
  def destroy
    @slot.destroy

    respond_to do |format|
      format.html { redirect_to department_slots_url, notice: "Slot was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slot
      @slot = Slot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def slot_params
      params.require(:slot).permit(:start_time, :end_time,:department_id)
    end
end
