class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :courses
  has_many :purchases
  has_many :sections, through: :purchases
  has_many :orders
  has_many :section_orders

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  has_one_attached :photo
end
