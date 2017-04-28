class Guest < ApplicationRecord

  def appear
    puts "BROADCASTING"
    AppearancesBroadcastJob.perform_later(self)
  end

  def disappear
    GuestCleanupJob.perform_later(self)
    destroy
  end

  def speak(message)
    ChatBroadcastJob.perform_later(self, message)
  end

end
