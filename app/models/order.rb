class Order < ApplicationRecord
  belongs_to :user
  belongs_to :purchasable, polymorphic: true

  monetize :amount_cents
end
