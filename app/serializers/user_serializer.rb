class UserSerializer < ActiveModel::Serializer
  has_many :purchases
  has_many :messages

  attributes :first_name, :last_name, :email, :phone, :billing_address, :zip_code, :fan_level, :tier
end
