class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from'chat'
  end

  def unsubscribed
  end

  def speak(message)
    # ActionCable.server.broadcast 'chat',
    #     message
    guest.speak(message['text'])
  end
end
