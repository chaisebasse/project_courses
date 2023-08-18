class Course < ApplicationRecord
  has_and_belongs_to_many :users

  has_many :orders, as: :purchasable
  has_many :sections, dependent: :destroy

  accepts_nested_attributes_for :sections, allow_destroy: true

  monetize :price_cents

  validates :price_cents, presence: true
  validates :title, presence: true, uniqueness: true

  has_one_attached :photo
  has_one_attached :video
end
