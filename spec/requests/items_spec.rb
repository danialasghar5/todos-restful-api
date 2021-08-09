require 'rails_helper'

RSpec.describe "Items API", type: :request do
	let!(:todo) {create(:todo)}
	let!(:items) {create_list(:item, 20, todo_id: todo.id)}
	let(:todo_id) {todo.id}
	let(:id) {items.first.id}

	#GET /todos/:todo_id/items
	describe "GET /todos/:todo_id/items" do
		before {get "/todos/#{todo_id}/items"}

		context "when valid todo items record exists." do
			it "returns todo items" do
				expect(json.size).to eq(20)
			end

			it "returns success status of 200" do
				expect(response).to have_http_status(200)
			end
		end

		context 'when record does not exists' do
			let(:todo_id) {0}

			it "returns error with no record" do
				expect(response).to have_http_status(404)
			end

			it 'returns a not found message' do
				expect(response.body).to match(/Couldn't find Todo/)
			end
		end
	end

	describe "GET /todos/:todo_id/items/:id" do
		before {get "/todos/#{todo_id}/items/#{id}"}

		context "when valid item exists" do
			it "returns record" do
				expect(json["id"]).to eq(id)
			end

			it "returns status as succeess 200" do
				expect(response).to have_http_status(200)
			end
		end

		context "when record does not exists" do
			let(:id) {0}

			it "returns error status code 404" do
				expect(response).to have_http_status(404)
			end

			it "returns error message" do
				expect(response.body).to match(/Couldn't find Item/)
			end
		end
	end

	describe "POST /todos/:todo_id/items" do
		let(:valid_attributes) {{name: "FINAL YEAR", done: true}}

		context "when all data is valid" do
			before {post "/todos/#{todo_id}/items", params: valid_attributes}

			it "should create a record with status" do
				expect(response).to have_http_status(201)
			end
		end

		context "when record is invalid" do
			before {post "/todos/#{todo_id}/items", params: {}}

			it "should return error message of 422" do
				expect(response).to have_http_status(422)
			end
		end
	end

	describe "PUT /todos/:todo_id/items/:id" do
		let(:valid_attributes) { { name: 'Mozart' } }

		before { put "/todos/#{todo_id}/items/#{id}", params: valid_attributes }

		context 'when item exists' do
	      it 'returns status code 200' do
	        expect(response).to have_http_status(200)
	      end

	      it 'updates the item' do
	        expect(json["name"]).to eq("Mozart")
	      end
	    end

	    context 'when the item does not exist' do
	      let(:id) { 0 }

	      it 'returns status code 404' do
	        expect(response).to have_http_status(404)
	      end

	      it 'returns a not found message' do
	        expect(response.body).to match(/Couldn't find Item/)
	      end
	    end

	end

	describe 'DELETE /todos/:id' do
		before { delete "/todos/#{todo_id}/items/#{id}" }

		it 'returns status code 200' do
		  expect(response).to have_http_status(200)
		end
	end
end