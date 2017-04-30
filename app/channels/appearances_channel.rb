class AppearancesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'appearances'
  end

  def unsubscribed
    if guest
      ActionCable.server.broadcast "appearances",
        guest_id: guest.id
      guest.destroy
    end
  end

  def appear
    if guest
      ActionCable.server.broadcast "appearances",
        appear: true,
        guest_id: guest.id,
        template: guest_template(guest)
    end
  end

  private
    def guest_template(guest)
      ApplicationController.renderer.render(partial: "guests/guest", locals: { guest: guest })
    end
end
