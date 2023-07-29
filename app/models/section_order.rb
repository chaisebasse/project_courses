class SectionOrder < ApplicationRecord
  belongs_to :user
  belongs_to :section

  monetize :amount_cents
end
