


  

$(function() {
  $('[data-channel-subscribe="room"]').each(function(index, element) {
    var $element = $(element),
        room_id = $element.data('room-id')
        messageTemplate = $('[data-role="message-template"]');

       $element.animate({ scrollTop: $element.prop("scrollHeight")}, 0)   

    App.cable.subscriptions.create(
      {
        channel: "RoomChannel",
        room: room_id
      },
      {
        received: function(data) {
          var content = messageTemplate.children().clone(true, true);      
          location.reload()
          content.find('[data-role="user-name"]').text(data.name);
          content.find('[data-role="message-text"]').text(data.message);
          content.find('[data-role="message-date"]').text(timeago.format(data.updated_at));

          $element.append(content);
           $('.chat-input').focus()   
          
        }
      }
    );
  });
});