function subscribeToAppearances() {
  App.appearances = App.cable.subscriptions.create("AppearancesChannel", {
    connected: function() {
      this.perform("appear");
    },

    disconnected: function() {
      $("#flash").flash("ERROR: Connection to the server was lost.", {class: 'alert'});
    },

    received: function(data) {
      var $guestIds = $('#guest-ids');
      if (data.appear) {
        fadeInGuestList(data.template);
      } else {
        $('#guest-' + data.id).fadeOut("slow", function() {
          $(this).remove();
        });
      }
    },

  });
}
