function subscribeToAppearances() {
  App.appearances = App.cable.subscriptions.create("AppearancesChannel", {
    connected: function() {
      this.perform("appear");
    },

    disconnected: function() {
    },

    received: function(data) {
      $(data.template).hide().appendTo("#guest-list").fadeIn("slow");
    }
  });
}
