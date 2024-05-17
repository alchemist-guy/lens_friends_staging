class Gallery < ApplicationRecord
  belongs_to :session_type
  
  has_many_attached :images
  has_many_attached :videos

  validate :validate_images
  validate :validate_videos

  private

  def validate_videos
    if videos.length > 3
      errors.add(:videos, 'cannot exceed 3 videos')
    else
      videos.each do |video|
        validate_media_size(video, 'videos', 400.megabytes)
      end
    end
  end

  def validate_media_size(media, attribute, max_size)
    if media.blob.byte_size > max_size
      errors.add(attribute, "each #{attribute.to_s.singularize} should be less than #{max_size / 1.megabyte}MB")
    end
  end

  def validate_images
    if images.blank?
      errors.add(:images, 'should have at least one image')
    elsif images.length > 20
      errors.add(:images, 'cannot exceed 20 images')
    else
      images.each do |image|
        validate_image_size(image)
      end
    end
  end

  def validate_image_size(image)
    if image.blob.byte_size > 50.megabytes
      errors.add(:images, 'each image should be less than 50MB')
    end
  end
end