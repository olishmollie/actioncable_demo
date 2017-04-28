class ChatBroadcastJob < ApplicationJob
  queue_as :default

  def perform(guest, message)
    ActionCable.server.broadcast 'chat',
                                 message_template(guest, message)
  end

  private
  def message_template(guest, message)
    ApplicationController.renderer.render(partial: 'guests/message', locals: { guest: guest, message: message })
  end
end
