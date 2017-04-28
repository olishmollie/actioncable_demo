class AppearancesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'appearances'
  end

  def unsubscribed
  end

  def appear
    guest.appear
  end
end
