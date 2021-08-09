require 'rails_helper'

RSpec.describe "Todos API", type: :request do
	let!(:todos) {create_list(:todo, 10)}
	let(:todo_id) {todos.first.id}

	describe 'GET /todos index method' do
		before { get '/todos'}

		it 'returns todos' do
			expect(json).not_to be_empty
			expect(json.size).to eq(10)
		end

		it 'returns status code' do
			expect(response).to have_http_status(200)
		end
	end

	describe 'GET /todos/:id' do
		before {get "/todos/#{todo_id}"}

		context "when record exists" do
			it "returns todo with id" do
				expect(json).not_to be_empty
				expect(json["id"]).to eq(todo_id)
			end

			it "returns status code" do
				expect(response).to have_http_status(200)
			end
		end

		context "when record does not exist" do
			let(:todo_id) {100}

			it "returns status code 404" do
				expect(response).to have_http_status(404)
			end

			it "returns not found error message" do
				expect(response.body).to match(/Couldn't find Todo/)
			end
		end
	end

	#create test todos
	describe 'POST /todos' do
		let(:valid_attributes) {{title: "Covid-19", created_by: "1"}}

		context "when record is valid" do
			before {post '/todos', params: valid_attributes}

			it "creates a todo" do
				expect(json["title"]).to eq("Covid-19")
			end

			it "returs status code 201" do
				expect(response).to have_http_status(201)
			end
		end

		context "when record is in-valid" do
			before {post '/todos', params: {title: "Foobar"}}

			it "returns status code 422" do
				expect(response).to have_http_status(422)
			end

			it "returns validation error message" do
				expect(response.body).to match(/Validation failed: Created by can't be blank/)
			end
		end
	end

	describe "PUT update /todos/:id" do
		let(:valid_attributes) {{title: "Updated title"}}

		context "when record present" do
			before {put "/todos/#{todo_id}", params: valid_attributes}

			it "updates todos" do
				expect(response.body).not_to be_empty
			end

			it 'returns status code 200' do
		        expect(response).to have_http_status(200)
		    end
		end
	end

	#DELETE /todos/:id
	describe 'DELETE /todos/:id' do
		before { delete "/todos/#{todo_id}" }

		it 'returns status code 200' do
		  expect(response).to have_http_status(200)
		end
	end
end