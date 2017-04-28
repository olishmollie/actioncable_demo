function Poll(options, success, failure) {

  var timer;

  Object.assign({
    url: '/',
    method: 'get',
    interval: 5000
  }, options);

  var poll = function() {
    $.ajax({method: options.method, url: options.url})
      .done(function (response) {
        success(response);
      })
      .fail(function (error) {
        failure(error);
      });
  };

  var updateTimer = function() {
    poll();
    timer = setTimeout(updateTimer, options.interval);
  }

  return {
    start: function() {
      updateTimer();
    },

    stop: function() {
      clearTimeout(timer);
    }
  }
}

