class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]

  # GET /todos or /todos.json
  def index
    @todos = Todo.all.order(created_at: :desc)
  end

  # GET /todos/1 or /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos or /todos.json
  def create
    Todo.create(params[:todo].permit!)
    redirect_to todos_path
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    @todo.update(params[:todo].permit!)
    redirect_to todos_path
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy
    redirect_to todos_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end
end
