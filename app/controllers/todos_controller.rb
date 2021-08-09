class TodosController < ApplicationController

	before_action :set_todo, only: [:show, :update, :destroy]

	#Get all todos
	def index
		@todos = Todo.all
		json_response(@todos)
	end

	#GET todos/:id
	def show
		json_response(@todo)
	end

	#POST /todos
	def create
		@todo = Todo.create!(todo_params)
		json_response(@todo, :created)
	end

	#PUT /todos/:id
	def update
		if @todo.update(todo_params)
			json_response(@todo)
		else
			render json: { status: :unprocessable_entity, message: @todo.errors.full_messages.first}
		end
	end

	#DELETE /todos/:id
	def destroy
		if @todo.destroy
			json_response(@todo)
		else
			render json: { status: :unprocessable_entity, message: @todo.errors.full_messages.first }
		end
	end

	private
	def todo_params
		params.permit(:title, :created_by)
	end

	def set_todo
		@todo = Todo.find(params[:id])
	end
end
