
FactoryGirl.define do

  factory :user do
    first_name 'Carl'
    last_name 'Schwope'
    sequence(:email){|n| "person#{n}@example.com"}
    password 'my_password'
    role 'customer'

    factory :owner do
      role 'owner'

      after(:create) do |owner|
        FactoryGirl.create( :restaurant, user: owner )
        FactoryGirl.create( :restaurant, user: owner )
      end
    end
  end

  factory :location do
    street '33 Harrison Ave'
    city 'Boston'
    state 'MA'
  end

  factory :restaurant do
    sequence(:name){|n|"restaurant#{n}"}
    after(:create) do |restaurant|
      FactoryGirl.create(:location, findable: restaurant )
      FactoryGirl.create(:menu, restaurant: restaurant )
    end
  end

  factory :menu do
    sequence(:name){|n|"menu#{n}"}
  end


end
