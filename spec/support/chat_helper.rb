module ChatHelper
  def chat(message)
    chat_input = find('#chat-input')
    chat_input.set(message)
    click_on('Send')
  end
end

RSpec.configure do |config|
  config.include ChatHelper, :type => :feature
end