class Quote < ApplicationRecord
  belongs_to :company

  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  # after_create_commit -> { broadcast_prepend_later_to "quotes", partial: "quotes/quote", locals: { quote: self}, target: "quotes" }
  # after_update_commit -> { broadcast_replace_later_to "quotes", partial: "quotes/quote", locals: { quote: self}, target: self }
  # after_destroy_commit -> { broadcast_remove_to "quotes", target: self }
  broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend
end