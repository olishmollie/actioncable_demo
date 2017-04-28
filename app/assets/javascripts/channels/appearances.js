function subscribeToAppearances() {
  App.appearances = App.cable.subscriptions.create("AppearancesChannel", {
    connected: function() {
      this.perform("appear");
    },

    disconnected: function() {
      $("#flash").flash("ERROR: Connection to the server was lost.", {class: 'alert'});
    },
    // TODO: Fix guestIds bullshit hack
    received: function(data) {
      var $guestIds = $('#guest-ids');
      if (data.appear) {
        fadeInGuestList(data.template);
        $guestIds.text($guestIds.text() + '[' + data.guest_id + ']');
      } else {
        $('#guest-' + data.id).fadeOut("slow", function() {
          $(this).remove();
        });
      }
    },

  });
}
