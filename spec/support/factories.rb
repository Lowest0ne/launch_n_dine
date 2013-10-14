
FactoryGirl.define do

  factory :user do
    first_name 'Carl'
    last_name 'Schwope'
    sequence(:email){|n|"email#{n}@example.com"}
    password 'my_password'

    factory :customer do
      role 'customer'
    end

    factory :driver do
      role 'driver'
    end

    factory :owner do
      role 'owner'
    end

    after(:create) do |user|
      FactoryGirl.create(:location, findable: user )
    end

  end
  factory :restaurant do
    sequence(:name){|n|"restaurant#{n}"}

    after( :create ) { |r| FactoryGirl.create(:location, findable: r) }
  end

  factory :menu do
    sequence(:name){|n|"menu#{n}"}
  end

  factory :menu_item do
    sequence(:name){|n|"menu_item#{n}"}
    description 'very good description'
    sequence(:price){|n| n / 4.0 }
  end

  factory :location do
    sequence(:street){|n|"#{n} Harrison Ave"}
    sequence(:city){|n|"City: #{n}"}
    sequence(:state){|n|"State: #{n}" }
  end

end
