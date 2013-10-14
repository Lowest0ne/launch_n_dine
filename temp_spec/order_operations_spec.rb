require 'spec_helper'

describe 'creating orders' do

  it 'can not be done unless signed in'
  it 'can not be done by a driver'
  it 'can not be done by a owner'

  describe 'as a customer' do

    describe 'with valid information' do

      it 'confirms that I created an order with an email'
      it 'confirms that I created an order on the screen'
    end

    describe 'with invalid information' do

      it 'does not send me an email'
      it 'displays an error message on the screen'

    end
  end

  describe 'viewing orders' do

    it 'can not be done unless signed in' do
      visit orders_path
      current_path.should == new_user_session_path
    end

    it 'can not be done by a customer' do
      customer = create_signed_in(:customer)
      visit orders_path
      current_path.should == root_path
    end

    describe 'as a restuarant owner' do
      it 'I can only see orders that belong to my restaurants'
    end

    describe 'as a delivery driver' do
      it 'I can see all of the unclaimed orders'
    end
  end

  describe 'order state changing' do

    describe 'confirming an order' do

      it 'can not be done unless signed in'
      it 'can not be done by a customer'
      it 'can not be done by a driver'
      it 'can not be done by a different owner'
      it 'can be done by the correct owner'

    end
    describe 'claiming an order' do

      it 'can not be done unless signed in'
      it 'can not be done by a customer'
      it 'can not be done by a owner'
      it 'can be done by a driver'
    end

    describe 'picking up an order' do

      it 'can not be done unless logged in'
      it 'can not be done by a customer'
      it 'can not be done by an owner'
      it 'can be done by a driver'
    end

    describe 'completing an order' do

      it 'can not be done unless signed in'
      it 'can not be done by a customer'
      it 'can not be done by an owner'
      it 'can be done by a driver'

    end
    describe 'canceling orders' do

      it 'can not be done unless signed in'
      it 'can not be done by a driver'
      it 'can not be done once picked up'

    end
  end
end
