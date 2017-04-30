function subscribeToAppearances() {
  App.appearances = App.cable.subscriptions.create("AppearancesChannel", {
    connected: function() {
      this.perform("appear");
    },

    received: function(data) {
      if (data.appear) {
        this.fadeInGuestList(data.template);
      } else {
        $('#guest-' + data.id).fadeOut("slow", function() {
          $(this).remove();
        });
      }
    },

    fadeInGuestList: function(html) {
      $(html).hide().appendTo("#guest-list").fadeIn("slow");
    }
  });
}
