FactoryBot.define do
	factory :user do
		name {Faker::Name.name}
		email "dev@gmail.com"
		password "dev123"
	end
end