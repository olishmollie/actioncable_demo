class GuestCleanupJob < ApplicationJob
  queue_as :default

  def perform(guest)
    ActionCable.server.broadcast "appearances",
                                 id: guest.id
  end

end
