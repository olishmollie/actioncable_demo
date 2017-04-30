require 'rails_helper'

RSpec.feature "Appearances", type: :feature, js: true do
  let(:picard) { 'Picard' }
  let(:riker) { 'Riker' }

  before(:each) do
    visit '/'
  end

  scenario "A new guest appears" do
    create_guest picard
    within_new_incognito_window do
      visit '/'
      create_guest riker
    end
    expect(page).to have_content riker
  end

  scenario "A guest disappears" do
    create_guest picard
    new_window = within_new_incognito_window do
      visit '/'
      expect(page).to have_content picard
      create_guest riker
    end
    new_window.close
    expect(page).to_not have_content riker
  end

  scenario "A guest appears even during registration" do
    within_new_incognito_window do
      visit '/'
      create_guest riker
    end

    expect(page).to have_content riker
  end
end
