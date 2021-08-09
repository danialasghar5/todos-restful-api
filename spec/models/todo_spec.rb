require 'rails_helper'

RSpec.describe Todo, type: :model do
  #association test
  it {should have_many(:items).dependent(:destroy)}

  #validations test to check title and created_by must be present
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:created_by)}
end
