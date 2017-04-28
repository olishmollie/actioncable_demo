class AppearancesBroadcastJob < ApplicationJob
  queue_as :default

  def perform(guest)
    ActionCable.server.broadcast 'appearances',
                                 guest_id: guest.id,
                                 template: template(guest),
                                 appear: true
  end

  private
    def template(guest)
      ApplicationController.renderer.render partial: "guests/guest", locals: { guest: guest }
    end
end
