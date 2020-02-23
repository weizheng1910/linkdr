class RoomsController < ApplicationController
  # Loads:
  # @rooms = all rooms
  # @room = current room when applicable
  

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  
def show
  @room = Room.find(params[:id])
  if user_company_signed_in?
  @company = current_user_company.company
  else 
  @candidate = current_user_candidate.candidate
  end

  @match = Match.find(params[:id])

  # If you are logged in as a company or a candidate 
  # Check if you should be in the room 
  if @company 
    if @match.job.company.user_company.email != cookies.signed['email']
      redirect_to dashboard_path
    end
  elsif @candidate
    if @match.candidate.user_candidate.email != cookies.signed['email']
      redirect_to dashboard_path
    end
  end

  @room_messages = RoomMessage.where( room_id:params[:id])
  @room_message = RoomMessage.new room: @room
  
end


  def create
    puts permitted_parameters
    @room = Room.new(permitted_parameters)

    if @room.save
      flash[:success] = "Room #{@room.name} was created successfully"
      redirect_to rooms_path
    else
      render plain: "failed"
    end
  end

  def edit
  end

  def update
    if @room.update_attributes(permitted_parameters)
      flash[:success] = "Room #{@room.name} was updated successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  protected


  def load_entities
    @rooms = Room.all
    @room = Room.find(params[:id]) if params[:id]
  end

  def permitted_parameters
    params.require(:room).permit(:name)
  end
end

