class Users::GalleryController < ApplicationController
    before_action :authenticate_user!
    before_action :set_gallery, only: %i[ show edit update destroy]

    def index
    end

    def new
      @gallery = Gallery.new
    end

    def create
      @gallery = Gallery.new(gallery_params)
      @gallery.session_type_id = current_user.session_type.id
      respond_to do |format|
        if @gallery.save
          check_gallery_fields
          format.html { redirect_to users_profiles_path, notice: "Gallery is successfully created." }
        else
          format.turbo_stream
        end
      end
    end
  
    def show

    end

    def edit
    end

    def update
      respond_to do |format|
        if @gallery.update(gallery_params)
          format.html { redirect_to users_gallery_path(@gallery), notice: "Gallery was successfully updated." }
        else
          format.turbo_stream
        end
      end
    end

    def remove_image
      referer_url = request.referer
      id_match = referer_url.match(/\/(\w{8}-\w{4}-\w{4}-\w{4}-\w{12})\/edit/)
      if id_match
        extracted_id = id_match[1]
        @gallery = Gallery.find(extracted_id)
        if @gallery.images.count > 1
          @image = ActiveStorage::Attachment.find(params[:id])
          @image.purge_later
        end
      end
      redirect_back(fallback_location: request.referer)
    end

    def remove_video
      @video = ActiveStorage::Attachment.find(params[:id])
      @video.purge_later
      redirect_back(fallback_location: request.referer)
    end

    def destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_gallery
        @gallery = Gallery.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def gallery_params
        params.require(:gallery).permit(:gallery_type, images: [], videos: [])
      end

      def check_gallery_fields
        @track_profile    = current_user.track_profile
        @check_galleries  = current_user.session_type.galleries.present?
        if @check_galleries == true
          @track_profile.update(gallery_data: 10)
        else
          @track_profile.update(gallery_data: 0)
        end

      end

  
  end