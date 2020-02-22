class RoomMessagesController < ApplicationController
  before_action :load_entities

  def create

    @candidate = current_user_candidate
    @company = current_user_company

    if @candidate 
      this_name = @candidate.candidate.given_name
    elsif @company
      this_name = @company.company.name
      puts "ANANANNANANANANANNANA"
      puts @company.company.name
      puts "ANANANNANANANANANNANA"

    end

    

    @room_message = RoomMessage.create name: this_name,
                                       room: @room,
                                       message: params.dig(:room_message, :message)
  
  RoomChannel.broadcast_to @room, @room_message

  end

  protected

  def load_entities
    @room = Room.find params.dig(:room_message, :room_id)
  end
end
