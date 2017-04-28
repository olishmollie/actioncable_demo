$(window).load(function() {
  var $registerGuestModal = $('#register-guest-modal');

  $registerGuestModal.modal('show');

  $registerGuestModal.on('shown.bs.modal', function () {
    $('form input[type=text]').focus();
  });

  $('#new_guest').on('submit', function (e) {
    e.preventDefault();

    if (this['guest[name]'].value === '') {
      $('#modal-flash').flash("Please enter a name", {class: 'text-red'});
      return;
    }

    var formData = $(this).serialize();

    $.ajax({data: formData, method: this.method, url: this.action})
      .done(function (response) {
        $registerGuestModal.modal('hide');
        poll.stop();
        initiateActionCable();
        subscribeToAppearances();
      })
      .fail(function (error) {
        $registerGuestModal.modal('hide');
        $('#flash').flash('ERROR: ' + error);
      });

  });

  var options = {
    url: '/guests',
    method: 'get',
    interval: 2000
  }

  var poll = new Poll(options,
    function (response) {
      var guests = response.guests;
      var $guestIds = $('#guest-ids');
      for (var i = 0; i < guests.length; i++) {
        // TODO: Fix guestIds bullshit hack
        if ($('#guest-ids').text().includes(guests[i].id)) { continue; }
        fadeInGuestList(guests[i].template);
        $guestIds.text($guestIds.text() + '[' + guests[i].id + ']');
      }
    },
    function (error) {
      poll.stop();
      $('#flash').flash("ERROR: " + error.statusText, {class: 'alert'});
    });

  poll.start();
});
