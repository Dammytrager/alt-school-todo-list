module Types
  class MutationType < Types::BaseObject
    field :todo_create, mutation: Mutations::TodoCreate
    # field :todo, mutation: Mutations::Todo
  end
end
