class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'chat'
  end

  def unsubscribed
  end

  def speak(message)
    ActionCable.server.broadcast 'chat',
      message_template(guest, message)
  end

  private
    def message_template(guest, message)
      ApplicationController.renderer.render(partial: 'guests/message', locals: { guest: guest, message: message['text'] })
    end
end
