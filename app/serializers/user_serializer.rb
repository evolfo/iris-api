class UserSerializer < ActiveModel::Serializer
  has_many :purchases

  attributes :first_name, :last_name, :email, :phone, :billing_address, :fan_level, :tier
end
