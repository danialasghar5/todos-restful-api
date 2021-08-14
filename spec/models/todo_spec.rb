require 'rails_helper'

RSpec.describe Todo, type: :model do
  #association test
  describe "Associations" do
    it {should have_many(:items).dependent(:destroy)}
  end

  #validations test to check title and created_by must be present
  describe "validations" do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:created_by)}
  end
end
