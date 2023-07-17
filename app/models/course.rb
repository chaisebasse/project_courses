class Course < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :sections, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  has_one_attached :video
end
