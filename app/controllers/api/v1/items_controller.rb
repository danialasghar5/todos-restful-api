class Api::V1::ItemsController < ApplicationController

	before_action :set_todo
	before_action :set_todo_item, only: [:show, :update, :destroy]

	#GET /todos/:todo_id/items
	def index
		json_response(@todo.items)
	end

	#POST /todos
	def create
		@item = @todo.items.new(item_params)
		if @item.save!
			json_response(@item, :created)
		else
			render json: { status: :unprocessable_entity, message: @item.errors.full_messages.first} 
		end
	end

	#GET /todos/:todo_id/items/:id
	def show
		json_response(@item)
	end

	def update
		if @item.update(item_params)
			json_response(@item)
		else
			render json: { status: :unprocessable_entity, message: @item.errors.full_messages.first} 
		end
	end

	def destroy
		if @item.destroy!
			json_response(@item)
		else
			render json: { status: :unprocessable_entity, message: @item.errors.full_messages.first} 
		end
	end

	private

	def item_params
		params.permit(:name, :done)
	end

	def set_todo
		@todo = Todo.find(params[:todo_id])
	end

	def set_todo_item
		@item = @todo.items.find_by!(id: params[:id]) if @todo
	end
end
