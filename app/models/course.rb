class Course < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :sections, dependent: :destroy
  has_many :orders, as: :purchasable

  monetize :price_cents
  validates :price_cents, presence: true
  validates :title, presence: true, uniqueness: true
  has_one_attached :photo

end
