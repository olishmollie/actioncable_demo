class AppearancesBroadcastJob < ApplicationJob
  queue_as :default

  def perform(guest)
    ActionCable.server.broadcast('appearances', {template: template(guest)})
  end

  private
    def template(guest)
      ApplicationController.renderer.render partial: "guests/guest", locals: { guest: guest }
    end
end
