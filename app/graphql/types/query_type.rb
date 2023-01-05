module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false, description: "An example field added by the generator"
    field :todos, [Types::TodoType], null: false
    field :todo, Types::TodoType, null: false do
      argument :id, ID, required: true
    end

    def todos
      user = context[:current_user]
      user.todos.order(created_at: :desc)
    end

    def todo(id:)
      Todo.find id
    end

    def test_field
      "Hello World!"
    end
  end
end
