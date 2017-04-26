class ChatroomController < ApplicationController
  def show
    @guest = Guest.new
    @guests = Guest.all
  end
end
