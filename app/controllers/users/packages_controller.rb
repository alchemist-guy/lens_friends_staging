class Users::PackagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_package, only: %i[show edit update destroy]


  def index
    @packages = current_user.packages
  end

  def show
    # Your show action logic here
  end

  def new
    @package = Package.new
    @package.price_ranges.build
  end

  def create
    @package = current_user.packages.new(package_params)
    respond_to do |format|
      if @package.save
        check_packages_fields
        format.html { redirect_to users_packages_path, notice: "Package is successfully created." }
      else
        format.turbo_stream
        # format.json { render json: @off_day.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit
  end

  def update
    if @package.update(package_params)
      check_packages_fields
      redirect_to users_packages_path, notice: 'Package updated successfully.'
    else
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def destroy
    @package.destroy!
    check_packages_fields

    respond_to do |format|
      format.html { redirect_to users_packages_path, notice: "Package successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def check_packages_fields
    @track_profile      = current_user.track_profile
    @check_packages     = current_user.packages.present?
    if @check_packages == true
      @track_profile.update(price_package_data: 10)
    else
      @track_profile.update(price_package_data: 0)
    end
  end

  def set_package
    @package = Package.find(params[:id])
  end

  def package_params
    params.require(:package).permit(:session_type, :service_type, :description,
                                    price_ranges_attributes: [:id, :_destroy, :hour, :price])
  end

end