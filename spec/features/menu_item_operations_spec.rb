require 'spec_helper'

describe 'menu item operations' do

  describe 'creating a menu item' do

    it 'can not be done unless signed in'
    it 'can not be done by a customer'
    it 'can not be done by a driver'
    it 'can not be done by a different owner'

    describe 'as the owner of the menu item' do

      describe 'with valid information' do

        it 'confirms that I have created a menu item on the screen'
        it 'does not send me an email'
        it 'stores my item in the database'

      end

      describe 'with valid information' do

        it 'displays the error messages'
        it 'does not send me an email'
        it 'does not store data in the database'

      end

    end

    describe 'viewing a menu item' do

      it 'can be done by anyone'

    end

    describe 'editing and deleting a menu item' do

      it 'can not be done unless logged in'
      it 'can not be done by a customer'
      it 'can not be done by a driver'
      it 'can not be done by a different owner'

      describe 'as a the owner of the menu item' do

        it 'displays confirmation of my edit'
        it 'updates the database properly'
        it 'displays errors when I fail'
        it 'does nothing if I fail'

      end
    end
  end
end
