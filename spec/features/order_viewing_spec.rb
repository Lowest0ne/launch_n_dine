require 'spec_helper'

describe 'viewing an order' do

  before( :each ) do

    @pool = create_pool
    @requested_order = create_order( @pool[:customer], @pool[:restaurant], 'requested' )
    @confirmed_order = create_order( @pool[:customer], @pool[:restaurant], 'confirmed' )
    @claimed_order = create_order( @pool[:customer], @pool[:restaurant], 'claimed' )
    @picked_up_order = create_order( @pool[:customer], @pool[:restaurant], 'picked_up' )
    @completed_order = create_order( @pool[:customer], @pool[:restaurant], 'completed' )
    @canceled_order = create_order( @pool[:customer], @pool[:restaurant], 'canceled' )

  end



end
