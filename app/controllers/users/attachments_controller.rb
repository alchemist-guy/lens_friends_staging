class Users::AttachmentsController < ApplicationController
  # before_action :authenticate_user!

  layout false

  before_action :set_gallery, only: :index

  def index
  end

  private

  def set_gallery
    @gallery = Gallery.find_by(id: params[:gallery_id])
    if @gallery == nil
      @image_blob = ActiveStorage::Blob.find_by(key: params[:gallery_id])
    end
  end
end