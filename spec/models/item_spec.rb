require 'rails_helper'

RSpec.describe Item, type: :model do
  #associations
  it {should belong_to(:todo)}

  #ensure name must be present
  it {should validate_presence_of(:name)}
end
