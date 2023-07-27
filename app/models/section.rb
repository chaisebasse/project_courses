class Section < ApplicationRecord
  belongs_to :course
  has_many :purchases
  has_many :users, through: :purchases
  has_many :videos

  validates :title, presence: true
  has_one_attached :video

  monetize :price_cents
end
