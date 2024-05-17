class Users::SessionTypesController < ApplicationController
  before_action :authenticate_user!
    
  
  # GET /off_days or /off_days.json
  def index
    
  end

  # GET /off_days/1 or /off_days/1.json
  def show
  end

  # GET /off_days/new
  def new
    
  end

  # GET /off_days/1/edit
  def edit
    @session_type = current_user.session_type || current_user.build_session_type
    @session_type.save unless @session_type.persisted?
  end

  # POST /off_days or /off_days.json
  def create
    
  end

  # PATCH/PUT /off_days/1 or /off_days/1.json
  def update
    @session_type = current_user.session_type
    respond_to do |format|
      if @session_type.update(session_type_params)
        check_session_fields
        format.html { redirect_to users_profiles_path, notice: "Session Type Updated Successfully" }
      else
        format.html { render edit_users_session_type_path(current_user), status: :unprocessable_entity }
      end
    end
  end

  # DELETE /off_days/1 or /off_days/1.json
  def destroy
    
  end

  private

    def check_session_fields
      @track_profile = current_user.track_profile
      if [@session_type.family, @session_type.portrait, @session_type.couples, @session_type.product, @session_type.wedding, @session_type.graduation, @session_type.maternity, @session_type.newborn, @session_type.interior, @session_type.fashion, @session_type.branding, @session_type.boudoir].any?
        @track_profile.update(session_type_data: 20)
      else
        @track_profile.update(session_type_data: 0)
      end
    end

    # Only allow a list of trusted parameters through.
    def session_type_params
      params.require(:session_type).permit(:family, :portrait, :couples, :product,
                                           :graduation, :maternity, :newborn,
                                           :interior, :fashion, :branding,
                                           :wedding, :boudoir)
    end
end
  