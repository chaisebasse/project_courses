class Video < ApplicationRecord
  belongs_to :section

  has_one_attached :video
end
