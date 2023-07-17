class Section < ApplicationRecord
  belongs_to :course
  has_many :purchases
  has_many :users, through: :purchases
  has_many :videos

  validates :name, presence: true
  has_one_attached :video
end
