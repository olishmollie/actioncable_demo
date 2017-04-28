require 'rails_helper'

RSpec.feature "Chats", type: :feature do
  let(:chat_input) { find('#chat-input') }

  before(:each) do
    visit '/'
  end

  scenario "user sees chat during modal guest registration", js: true do
    within_new_incognito_window do
      visit '/'
      create_guest 'Picard'
      chat 'Energize'
    end
    expect(page).to have_content('Picard: Energize')
  end

  scenario "user can post message in chat box", js: true do
    create_guest 'Picard'
    chat 'Energize'
    expect(chat_input).to_not have_content 'Energize'
    expect(page).to have_content 'Picard: Energize'
  end

  scenario "another user can see any messages posted by guests", js: true do
    create_guest 'Picard'
    within_new_incognito_window do
      visit '/'
      create_guest 'Riker'
      chat 'Red alert!'
    end
    expect(page).to have_content 'Riker: Red alert!'
  end

end
