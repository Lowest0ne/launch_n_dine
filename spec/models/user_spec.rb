require 'spec_helper'

describe User do

  it { should validate_presence_of(:first_name)}
  it { should validate_presence_of(:last_name) }

  it { should     have_valid(:role).when( 'driver', 'customer', 'owner' ) }
  it { should_not have_valid(:role).when( nil, '', 'anythingelse', 'drivera', 'adriver' ) }

  it { should have_many(:restaurants) }
  it { should have_many(:purchases) }
  it { should have_many(:deliveries) }

  it { should have_many(:locations) }

  it 'sends an email after registration' do
    prev_count = ActionMailer::Base.deliveries.count
    FactoryGirl.create(:user)
    expect( ActionMailer::Base.deliveries.count ).to eql( prev_count + 1 )
  end
end
