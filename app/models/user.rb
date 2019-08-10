class User < ApplicationRecord
	has_many :purchases

	before_create :add_tier

	def add_tier 
		self.tier = "bronze"
	end
end
