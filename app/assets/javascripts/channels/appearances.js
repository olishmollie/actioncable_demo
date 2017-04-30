function subscribeToAppearances() {
  App.appearances = App.cable.subscriptions.create("AppearancesChannel", {
    connected: function() {
      this.perform('appear');
    },

    disconnected: function() {
      $("#flash").flash("ERROR: Connection to the server was lost.", {class: 'alert'});
    },

    received: function(data) {
      if (data.appear) {
        this.fadeInGuestList(data.template);
      } else {
        this.fadeOutGuestList(data.guest_id);
      }
    },

    fadeInGuestList: function(html) {
      $(html).hide().appendTo("#guest-list").fadeIn("slow");
    },

    fadeOutGuestList: function(guestId) {
      $('#guest-' + guestId).fadeOut('slow', function() {
        $(this).remove();
      });
    },

    guestOnPage: function(guestId) {
      return $('#guest-' + guestId)[0];
    }
  });
}

function unsubscribeFromAppearances() {
  App.appearances.unsubscribe();
}
