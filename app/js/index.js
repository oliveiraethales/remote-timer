$(function () {
  var runningTimers = $('[data-running="true"]');

  runningTimers.each(function() {
    var id = $(this).parent('ul').attr('id');

    $('#timer-' + id).TimeCircles().start();
  });

  $('a[href="start"]').click(function() {
    var id = $(this).parents('ul').attr('id'),
        url = '/start/' + id;

    $.post(url, function(data) {
      alert(data);
    });

    $('#timer-' + id).TimeCircles().start();

    return false;
  });

  $('a[href="stop"]').click(function() {
    var id = $(this).parents('ul').attr('id'),
        url = '/stop/' + id;

    $.post(url, function(data) {
      alert(data);
    });

    $('#timer-' + id).TimeCircles().stop();

    return false;
  });

  $('a[href="restart"]').click(function() {
    var id = $(this).parents('ul').attr('id'),
        url = '/restart/' + id;

    $.post(url, function(data) {
      alert(data);
    });

    $('#timer-' + id).TimeCircles().restart();

    return false;
  });
});
