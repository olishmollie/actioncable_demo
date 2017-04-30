class AppearancesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'appearances'
  end

  def unsubscribed
    guest && ActionCable.server.broadcast("appearances", id: guest.id)
  end

  def appear
    guest && ActionCable.server.broadcast('appearances',
      appear: true,
      template: guest_template(guest))
  end

  private
    def guest_template(guest)
      ApplicationController.renderer.render(partial: "guests/guest", locals: { guest: guest })
    end
end
