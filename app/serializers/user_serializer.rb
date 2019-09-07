class UserSerializer < ActiveModel::Serializer
  has_many :purchases
  has_many :messages

  attributes :id, :first_name, :last_name, :email, :phone, :billing_address, :zip_code, :fan_level, :tier, :stripe_id
end
