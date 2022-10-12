class AddUserIdToTodo < ActiveRecord::Migration[6.1]
  def change
    # add_column :todos, :user_id, :integer
    #
    # add_foreign_key :todos, :users, column: :user_id

    t.belongs_to :user
  end
end
