class Users::OffDaysController < ApplicationController
  before_action :set_off_day, only: %i[ show edit update destroy ]

  # GET /off_days or /off_days.json
  def index
    @off_days = OffDay.all
  end

  # GET /off_days/1 or /off_days/1.json
  def show
  end

  # GET /off_days/new
  def new
    @off_day = OffDay.new
  end

  # GET /off_days/1/edit
  def edit
  end

  # POST /off_days or /off_days.json
  def create
    @off_day = current_user.off_days.new(off_day_params)

    respond_to do |format|
      if @off_day.save
        format.html { redirect_to users_calendars_path, notice: "Calender is successfully updated." }
        # format.json { render :show, status: :created, location: @off_day }
      else
        format.html { redirect_to users_calendars_path, notice: "Date range overlaps with an existing Off Day." }
        # format.json { render json: @off_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /off_days/1 or /off_days/1.json
  def update
    respond_to do |format|
      if @off_day.update(off_day_params)
        format.html { redirect_to off_day_url(@off_day), notice: "Off day was successfully updated." }
        format.json { render :show, status: :ok, location: @off_day }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @off_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /off_days/1 or /off_days/1.json
  def destroy
    @off_day.destroy!

    respond_to do |format|
      format.html { redirect_to users_calendars_path, notice: "Off day was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_off_day
      @off_day = OffDay.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def off_day_params
      params.require(:off_day).permit(:id,:start_date, :end_date, :user_id)
    end
end
