class MessageSerializer < ActiveModel::Serializer
  attributes :content, :user_id
end
