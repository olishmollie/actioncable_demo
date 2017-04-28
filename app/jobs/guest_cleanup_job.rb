class GuestCleanupJob < ApplicationJob
  queue_as :default

  def perform(guest)
    ActionCable.server.broadcast "apperances",
        { id: guest.id }
  end

end
