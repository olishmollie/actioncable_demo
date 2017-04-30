$(window).load(function() {

  function fadeInGuestList(html) {
    $(html).hide().appendTo("#guest-list").fadeIn("slow");
  }

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
        App.appearances.unsubscribe();
        App.chat.unsubscribe();
        initiateActionCable();
        App.chat.setupChat();
      })
      .fail(function (error) {
        $registerGuestModal.modal('hide');
        $('#flash').flash('ERROR: ' + error);
      });
  });

  initiateActionCable();
});
