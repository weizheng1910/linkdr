# ChatRoom Problem-Solving Process

After Googling, I came across this [site](https://iridakos.com/programming/2019/04/04/creating-chat-application-rails-websockets)

After scanning through the document. I learnt that WebSockets is a protocol which enables constant 2-way communication between the client and the server of a web application.

In a standard HTTP protocol, communication is one way - the client sends a request to the server, which ends the communication after sending a response back to the client. 

There are drawbacks to this protocol.

The page has to be re-rendered to get the latest state of the processes. With AJAX, you might be able to do so without refreshing the page, but only the client who has made the request gets the update. Other clients viewing the same page will still have to re-render the page to get the latest state.

This is where WebSockets come in. It allows any client subscribed to the channel to be able to get the latest state of the processes.

## Chatroom

In the case of the chatroom, all rooms will be subscribed to the RoomChannel, where there is a stream passing messages back and forth within each room.

```
class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find params[:room]
    stream_for room

    # or
    # stream_from "room_#{params[:room]}"
  end
end

``` 

Once subscription to the channel is established, the `subscribed` method gets called, which sets up the stream.

Every time we do a AJAX post request to post a message, we must also do a broadcast to the stream, so that those subsribed can instantly view those messages.
`RoomChannel.broadcast_to @room, @room_message` Or `<Channel Name>.broadcast_to <stream>,<data>`

```
def create
  @room_message = RoomMessage.create user: current_user,
                                     room: @room,
                                     message: params.dig(:room_message, :message)

  RoomChannel.broadcast_to @room, @room_message
end
``` 

Now that we can broadcast our messages, we also need to be able to receive them.

We can subscribe to a room stream using jQuery.
The call is `App.cable.subscriptions.create` 

When a new message is broadcasted, the messaging template snippet (identified by the tag [data-role="message-template"]) is cloned and updated with the new message, and then appended to the main chat-div where all the messages are displayed (identified by the tag[data-channel-subscribe="room"])

jQuery Code
```
$(function() {
  $('[data-channel-subscribe="room"]').each(function(index, element) {
    var $element = $(element),
        room_id = $element.data('room-id')
        messageTemplate = $('[data-role="message-template"]');

    App.cable.subscriptions.create(
      {
        channel: "RoomChannel",
        room: room_id
      },
      {
        received: function(data) {
          var content = messageTemplate.children().clone(true, true);
          content.find('[data-role="message-text"]').text(data.message);
          content.find('[data-role="message-date"]').text(data.updated_at);
          $element.append(content);
          $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000);
        }
      }
    );
  });
});

```

JSX View File

```
<div class="col">
    <div class="chat" data-channel-subscribe="room" data-room-id="<%= @room.id %>">
      <% @room_messages.each do |room_message| %>
        <div class="chat-message-container">
          <div class="row no-gutters">
            <div class="col-auto">
               <span class="user-name"><%= room_message.name %>:</span>
            </div>

            <div class="col">
              <div class="message-content">
                <p class="mb-1 px-3">
                  <%= room_message.message %>
                </p>

                <div class="text-right">
                  <small>
                  <em class="timestamp">
                    <%= time_ago_in_words(room_message.updated_at)%> ago
                    </em>
                  </small>
                </div>
              </div>
            </div>
          </div>
        </div>
      <% end %>
    </div>

    <%= simple_form_for @room_message,  remote: true do |form| %>
      <div id="the-input-box" class="input-group">
        <%= form.input :message, as: :string,
                                 wrapper: false,
                                 label: false,
                                 input_html: {
                                   class: 'chat-input col-9',
                                   placeholder: 'Type a message...',
                                   autocomplete: 'off',
                                   autofocus: 'true'
                                 } %>
        <div class="input-group-append col-3">
          <%= form.submit "Send", class: 'btn btn-primary chat-input' %>
        </div>
      </div>

      <%= form.input :room_id, as: :hidden %>
    <% end %>
  </div>
```

## Authentication

The file responsible for authenticating the WebSocket Connection can be found in the channels/application_cable/connection.rb 

In order to authenticate the WebSocket Connection, I have to validate that the client is a registered candidate or company. When a registered user logs in, a cookie of its email is created which is later use to verify the client when it attempts to establish the WebSocket connection.

```
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if verified_user = UserCandidate.find_by(email: cookies.signed['email'])
        puts verified_user
        verified_user
      elsif verified_user = UserCompany.find_by(email: cookies.signed['email'])
        puts verified_user
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
```

The above authentication prevents unwanted intruders from getting into the chat without logging in. 

To prevent logged-in users from visiting the chats that they should not be in, we verify their data using the Rooms table in the database. There should only be one authorised candidate and one authorised company allowed in each chatroom. All other busybodies are redirected back to their main dashboard.

```
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
```
## 
