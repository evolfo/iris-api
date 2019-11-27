class User < ApplicationRecord
	has_many :purchases
	has_many :messages

	before_create :add_tier

	def add_tier 
		self.tier = "silver"
	end

	def full_name
		return self.first_name + " " + self.last_name
	end
end
