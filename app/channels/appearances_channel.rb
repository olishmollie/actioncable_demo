class AppearancesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'appearances'
  end

  def unsubscribed
    guest.disappear if guest
  end

  def appear
    guest.appear if guest
  end
end
