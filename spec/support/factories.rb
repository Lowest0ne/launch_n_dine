
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
        FactoryGirl.create_list( :restaurant, 2 , user: owner )
      end
    end

    factory :driver do
      role 'driver'
    end

    after(:create) do |user|
      FactoryGirl.create(:location, findable: user)
    end

  end

  factory :location do
    sequence(:street){|n|"#{n} Harrison Ave"}
    city 'Boston'
    state 'MA'
  end

  factory :restaurant do
    sequence(:name){|n|"restaurant#{n}"}

    after(:create) do |restaurant|
      FactoryGirl.create_list(:menu, 2 , restaurant: restaurant )
      FactoryGirl.create(:location, findable: restaurant)
    end
  end

  factory :menu do
    sequence(:name){|n|"menu#{n}"}
    after(:create) do |menu|
      FactoryGirl.create_list(:menu_item, 2, menu: menu )
    end
  end

  factory :menu_item do
    sequence(:name){|n|"menu_item#{n}"}
    description 'very good description'
    sequence(:price){|n| n / 4.0 }
  end

end
