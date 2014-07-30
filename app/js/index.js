$(function () {
  onLoad();

  $('a[href="start"]').click(function() {
    var id = $(this).parents('ul').attr('id'),
        url = '/start/' + id,
        timer = $('#timer-' + id).TimeCircles();

    $.ajax({
      url: url,
      type: 'PUT'
    });

    timer.start();

    return false;
  });

  $('a[href="stop"]').click(function() {
    var id = $(this).parents('ul').attr('id'),
        url = '/stop/' + id,
        timer = $('#timer-' + id).TimeCircles(),
        elapsed = timer.getTime();

    $.ajax({
      url: url,
      data: {elapsed: elapsed},
      type: 'PUT'
    });

    timer.stop();

    return false;
  });

  $('a[href="restart"]').click(function() {
    var id = $(this).parents('ul').attr('id'),
        url = '/restart/' + id,
        timer = $('#timer-' + id).TimeCircles();

    timer.restart();

    return false;
  });

  $('a[href="resume"]').click(function() {
    var id = $(this).parents('ul').attr('id'),
        url = '/resume/' + id,
        timer = $('#timer-' + id).TimeCircles(),
        elapsed = timer.getTime();

    $.ajax({
      url: url,
      type: 'PUT',
      success: function () {
        alert('stopped');
      }
    });

    timer.start();

    return false;
  });

  $('a[href="delete"]').click(function() {
    var id = $(this).parents('ul').attr('id'),
        url = '/delete/' + id;

    $.ajax({
      url: url,
      type: 'DELETE',
      success: function() {
        alert('deleted');
      }
    });

    return false;
  });
});

function onLoad() {
  var runningTimers = $('[data-running="true"]');

  runningTimers.each(function() {
    var parent = $(this).parent('ul'),
        id = parent.attr('id'),
        timer = $('#timer-' + id).TimeCircles(),
        elapsed = parent.data('elapsed');

    if (elapsed < 0) {
      timer.start(elapsed);
    } else {
      timer.end().data('date', parent.data('started'));
      timer.start();
    }
  });
}
