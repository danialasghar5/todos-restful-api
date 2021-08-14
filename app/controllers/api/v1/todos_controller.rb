class Api::V1::TodosController < ApplicationController

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
		@todo = Todo.new(todo_params)
		if @todo.save
		  json_response(@todo, :created)
		else
		 json_response({ message: @todo.errors.full_messages }, :unprocessable_entity)
		end
	end

	#PUT /todos/:id
	def update
		if @todo.update(todo_params)
			json_response(@todo)
		else
			json_response({ message: @todo.errors.full_messages }, :unprocessable_entity)
		end
	end

	#DELETE /todos/:id
	def destroy
		if @todo.destroy
			json_response(@todo)
		else
			json_response({ message: @todo.errors.full_messages }, :unprocessable_entity)
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
