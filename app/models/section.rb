class Section < ApplicationRecord
  belongs_to :course
  has_many :purchases
  has_many :users, through: :purchases
  has_many :videos
end
