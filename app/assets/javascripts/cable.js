// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the rails generate channel command.
//
//= require action_cable
//= require_self
//= require_tree ./channels

function initiateActionCable() {
  this.App || (this.App = {});
  App.cable = ActionCable.createConsumer();
};

function subscribeToAllChannels() {
  subscribeToAppearances();
  subscribeToChat();
}

function unsubscribeFromAllChannels() {
  App.appearances.unsubscribe();
  App.chat.unsubscribe();
}

function resetActionCable() {
  unsubscribeFromAllChannels();
  initiateActionCable();
}


ActionCable.Subscription.prototype.disconnected = function() {
  $("#flash").flash("ERROR: Connection to the server was lost.", {class: 'alert'});
}
