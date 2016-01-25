require 'spec_helper'

describe 'Form' do
  
  # Before each test
  # we will visit
  # the root URL of the game
  before do
    visit '/'
  end


  # ----------------------------------------
  # Form
  # ----------------------------------------

  describe 'disk move form' do

    it 'is present in the page' do
      expect(page).to have_css('form', :count => 1)
    end


    it 'has a label with text "From" and a "for" attribute set to "from"' do
      label = find('form label[for="from"]', :text => 'From')
      expect(label).to_not be_nil
    end


    it 'has a label with text "To" and a "for" attribute set to "to"' do
      label = find('form label[for="to"]', :text => 'To')
      expect(label).to_not be_nil
    end


    it 'has a "from" input with "name" and "id" set to "from"' do
      expect(page).to have_css('form input#from[name="from"]', :count => 1)
    end


    it 'has a "to" input with "name" and "id" set to "to"' do
      expect(page).to have_css('form input#to[name="to"]', :count => 1)
    end


    it 'has a button of type submit' do
      expect(page).to have_css('form button[type=submit]', :count => 1)
    end


    describe 'submission' do

      it 'moves a disk by tower numbers' do
        make_move(1, 3)
        expect(page).to have_css('.tower-3 .disk-1', :count => 1)
        expect(page).to have_css('.tower-1 .disk-2', :count => 1)
        expect(page).to have_css('.tower-1 .disk-3', :count => 1)
      end
    end
  end
end
