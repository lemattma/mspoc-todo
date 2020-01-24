class TodosController < ApplicationController
  def index
    render json: Todo.all
  end

  def create
    todo = Todo.create(
      description: todo_params[:description],
      completed: false,
    )

    if todo.persisted?
      render json: todo
    else
      render json: { errors: [todo.errors.full_messages] }, status: :unprocessable_entity
    end
  end

  private

  def todo_params
    @todo_params ||= params.require(:todo).permit(:description)
  end
end
