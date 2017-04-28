require 'rails_helper'

RSpec.feature "Appearances", type: :feature, js: true do
  let(:guest) { 'Picard' }
  let(:new_guest) { 'Riker' }

  before(:each) do
    visit '/'
    create_guest('Picard')
  end

  scenario "A new guest appears" do
    within_new_incognito_window do
      visit '/'
      create_guest(new_guest)
    end
    expect(page).to have_content new_guest
  end

  scenario "A guest leaves" do
    new_window = within_new_incognito_window do
      visit '/'
      create_guest(new_guest)
    end

    new_window.close
    expect(page).to_not have_content new_guest
  end
end
