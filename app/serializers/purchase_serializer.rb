class PurchaseSerializer < ActiveModel::Serializer
  belongs_to :user

  attributes :amount, :bundle_name
end
