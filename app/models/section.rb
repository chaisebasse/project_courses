class Section < ApplicationRecord
  belongs_to :course

  has_many :purchases
  has_many :users, through: :purchases
  has_many :orders, as: :purchasable
  has_many :videos

  accepts_nested_attributes_for :videos, allow_destroy: true

  validates :title, presence: true

  has_one_attached :video
  has_one_attached :photo

  monetize :price_cents
end
