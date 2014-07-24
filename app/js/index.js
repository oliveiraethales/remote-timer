$(function () {
  var runningTimers = $('[data-running="true"]');

  runningTimers.each(function() {
    var id = $(this).parent('ul').attr('id');

    $('#timer-' + id).TimeCircles().start();
  });

  $('a[href="start"]').click(function() {
    var id = $(this).parents('ul').attr('id'),
        url = '/start/' + id;

    $('body').load(url, function(resp, stat, xhr) {
      console.log(resp);
      console.log(stat);
    });

    $('#timer-' + id).TimeCircles().start();

    return false;
  });

  $('a[href="stop"]').click(function() {
    var id = $(this).parents('ul').attr('id'),
        url = '/stop/' + id;

    $('body').load(url, function(resp, stat, xhr) {
      console.log(resp);
      console.log(stat);
    });

    $('#timer-' + id).TimeCircles().stop();

    return false;
  });

  $('a[href="restart"]').click(function() {
    var id = $(this).parents('ul').attr('id'),
        url = '/restart/' + id;

    $('body').load(url, function(resp, stat, xhr) {
      console.log(resp);
      console.log(stat);
    });

    $('#timer-' + id).TimeCircles().restart();

    return false;
  });
});
