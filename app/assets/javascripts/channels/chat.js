function subscribeToChat() {
  App.chat = App.cable.subscriptions.create("ChatChannel", {
    connected: function () {
    },

    received: function (data) {
      this.renderInChat(data);
    },

    disconnected: function() {
      this.teardownChat();
    },

    speak: function(message) {
      this.perform("speak", {text: message})
    },

    setupChat: function() {
      var $chatInput = $('#chat-input');
      var $chatSend = $('#chat-send');

      $chatSend.on('click', function() {
        if ($chatInput.val().length === 0) { return; }

        App.chat.speak($chatInput.val());
      });

      $chatInput.on('keyup', function(e) {
        if (e.keyCode === 13) {
          $chatSend.trigger('click');
        }
      });
    },

    teardownChat: function() {
      var $chatInput = $('#chat-input');
      var $chatSend = $('#chat-send');

      $chatInput.off();
      $chatSend.off();
    },

    renderInChat: function(template) {
      var chatContainer = document.getElementById('chat-container');
      var chatInput = document.getElementById('chat-input');
      chatContainer.innerHTML = chatContainer.innerHTML + template;
      chatContainer.scrollTop = chatContainer.scrollHeight;
      chatInput.value = '';
    }
  });
}
