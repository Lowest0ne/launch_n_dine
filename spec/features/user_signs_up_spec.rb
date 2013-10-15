require 'spec_helper'

describe 'a user signing up' do

  before { visit root_path }

  it 'can sign up as a driver' do
    click_on 'Driver'
    page.should have_selector('input', value:'driver')
  end

  it 'can sign up as an owner' do
    click_on 'Owner'
    page.should have_selector('input', value:'owner')
  end

  it 'can sign up as a customer' do
    click_on 'Customer'
    page.should have_selector('input', value:'customer')
  end

  describe 'with valid information' do
    subject { page }

    let ( :customer ){ FactoryGirl.build(:customer) }

    before ( :each ) do
      click_on 'Customer'

      @prev_count = User.count

      ActionMailer::Base.deliveries = []

      fill_in 'user_first_name', with: customer.first_name
      fill_in 'user_last_name', with: customer.last_name
      fill_in 'user_email', with: customer.email
      fill_in 'user_password', with: customer.password
      fill_in 'user_password_confirmation', with: customer.password
      click_button 'Sign Up'
    end

    it { should have_content("Welcome to Launch 'n Dine") }
    it { should have_content("Sign Out") }
    it { should_not have_content('Sign Up')}
    it { should_not have_content('Sign In')}

    it 'records my information in the database' do
      User.count.should == @prev_count + 1
      user = User.last
      user.first_name.should == customer.first_name
      user.last_name.should == customer.last_name
      user.email.should == customer.email
    end

    it 'delivers an email to the correct person' do

      expect( ActionMailer::Base.deliveries.size).to eql(1)
      last_email = ActionMailer::Base.deliveries.last

      expect( last_email ).to have_subject("Launch 'n Dine Welcomes You")
      expect( last_email ).to deliver_to( User.last.email )
      expect( last_email ).to have_body_text("Thanks for being a customer")

    end
  end

  describe 'with invalid information' do
    before (:each) do
      @prev_count = User.count
      visit root_path
      click_on 'Customer'
      click_button 'Sign Up'
    end

    it 'does not store info in the database' do
      User.count.should == @prev_count
    end

    subject{ page }
    it { should_not have_content('Sign Out') }
    it { should have_content("can't be blank") }
  end
end
