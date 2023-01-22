class UserSerializer < ActiveModel::Serializer
  attributes :id,:full_name, :contact_number, :joined_at
end
