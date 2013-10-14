require 'spec_helper'

describe 'menu operations' do

  describe 'creating a menu' do

    it 'can not be done unless signed in'
    it 'can not be done by a customer'
    it 'can not be done by a driver'
    it 'can not be done by the wrong owner'
    it 'can not be done with invalid information'
    it 'confirms success with valid information'

  end

  describe 'viewing a menu' do

    it 'can be done by anyone'

  end

  describe 'editing and deleting menu' do

    it 'can not be done unless signed in'
    it 'can not be done by a customer'
    it 'can not be done by a driver'
    it 'can not be done by a different owner'

    describe 'as the owner of the menu' do

      it 'I am allowed to edit the menu'
      it 'I am allowed to delete the menu'

    end
  end
end
