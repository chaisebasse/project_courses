class Section < ApplicationRecord
  belongs_to :course
  has_many :purchases
  has_many :users, through: :purchases
  has_many :videos
  has_many :orders, as: :purchasable

  validates :title, presence: true
  has_one_attached :video
  has_one_attached :photo

  monetize :price_cents
end
