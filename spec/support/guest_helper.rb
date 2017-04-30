module GuestHelper
  def within_new_incognito_window
    new_window = open_new_window
    within_window new_window do
      Capybara.current_session.driver.clear_cookies
      yield
    end
    new_window
  end

  def create_guest(name)
    within('#new_guest') do
      fill_in('guest[name]', with: name)
    end
    click_on("Go")
    expect(page).to have_content name
  end
end

RSpec.configure do |config|
  config.include GuestHelper, :type => :feature
end

