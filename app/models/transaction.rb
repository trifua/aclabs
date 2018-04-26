class Transaction < ApplicationRecord
	has_many :transactions
	belongs_to :original_currency, class_name: 'Currency'
	belongs_to :final_currency, class_name: 'Currency'
end
