Types::UserType = GraphQL::ObjectType.define do
  name "User"
  description "An end user of the API"
  # `!` marks a field as "non-null"
  field :id, !types.ID
  field :email, !types.String
  field :first_name, !types.String
  field :last_name, !types.String
end
