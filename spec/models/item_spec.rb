require 'rails_helper'

RSpec.describe Item, type: :model do
  #associations
  describe "Associations" do
   it {should belong_to(:todo)}
  end

  #ensure name must be present
  describe 'validations' do
    it {should validate_presence_of(:name)}
  end
end
