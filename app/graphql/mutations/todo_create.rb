# frozen_string_literal: true

module Mutations
  class TodoCreate < BaseMutation
    description "Creates a new todo"

    field :id, ID, null: false
    field :name, String, null: false
    field :status, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user_id, Integer

    argument :input, Types::TodoInputType, required: true

    def resolve(input:)
      todo = ::Todo.new(**input)
      raise GraphQL::ExecutionError.new "Error creating todo", extensions: todo.errors.to_hash unless todo.save

      return todo
    end
  end
end
