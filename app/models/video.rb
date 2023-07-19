class Video < ApplicationRecord
  belongs_to :section

  has_one_attached :video

  def cloudinary_url
    return '' unless video.attached?

    video.service_url
  end
end
