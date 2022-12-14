class Api::TodosController < ApiController
  before_action :authenticate
  before_action :validate_params, only: [:create]

  def index
  end

  def create
    todo = Todo.create({ **@todo_params.except(:user_id), user: @user })
    if todo.errors.blank?
      return render json: {
        message: 'Todo created successfully',
        data: todo
      }, status: :created
    else
      return render json: {
        message: todo.errors.full_messages.first || 'There was an error creating todo'
      }, status: :bad_request
    end
  end

  def update
  end

  def destroy
  end

  private

  def validate_params
    status = params.require(:status)

    if Todo.statuses.keys.exclude?(status.downcase)
      return render json: { message: 'Status should be either pending, done or cancelled' }
    end

    @todo_params = {
      status: status,
      name: params.require(:name)
    }
  end

  def authenticate
    token = request.headers['Authorization']&.gsub('Bearer ', '')
    return render json: { message: 'No token in the header' }, status: :unauthorized if token.blank?

    user_data = TokenService.decode(token)
    @user = User.find(user_data.first['id'])
  end
end