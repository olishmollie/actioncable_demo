require 'rails_helper'

RSpec.feature "Chats", type: :feature, js: true do
  let(:chat_input) { find('#chat-input') }

  before(:each) do
    visit '/'
  end

  scenario "user sees chat during modal guest registration" do
    within_new_incognito_window do
      visit '/'
      create_guest 'Picard'
      chat 'Energize'
    end
    expect(page).to have_content 'Picard: Energize', count: 1
  end

  scenario "user can post message in chat box" do
    create_guest 'Picard'
    chat 'Energize'
    expect(chat_input).to_not have_content 'Energize'
    expect(page).to have_content 'Picard: Energize', count: 1
  end

  scenario "another user can see any messages posted by guests" do
    create_guest 'Picard'
    within_new_incognito_window do
      visit '/'
      create_guest 'Riker'
      chat 'Red alert!'
    end
    expect(page).to have_content 'Riker: Red alert!', count: 1
  end

end
