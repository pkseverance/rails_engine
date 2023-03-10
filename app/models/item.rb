class Item < ApplicationRecord
    has_many :invoice_items, dependent: :destroy
    has_many :invoices, through: :invoice_items
    belongs_to :merchant
end
