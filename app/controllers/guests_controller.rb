class GuestsController < ApplicationController
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
    redirect_to root_path
  end

  private
    def guest_params
      params.require(:guest).permit(:name)
    end
end

