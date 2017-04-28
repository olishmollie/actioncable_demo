class GuestsController < ApplicationController

  def index
    guests = Guest.all.map do |guest|
      template = render_to_string partial: "guest", locals: { guest: guest }
      Hash[id: guest.id, template: template]
    end
    request.xhr? && render(json: {guests: guests})
  end

  def create
    guest = Guest.new(guest_params)
    if guest.save
      cookies.signed[:guest_id] = guest.id
      head 200
    else
      head 422
    end
  end

  def destroy_all
    Guest.destroy_all
    redirect_to '/'
  end

  private
    def guest_params
      params.require(:guest).permit(:name)
    end
end

