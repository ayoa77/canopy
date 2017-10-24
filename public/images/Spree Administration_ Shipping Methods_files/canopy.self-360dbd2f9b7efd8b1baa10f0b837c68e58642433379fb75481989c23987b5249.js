$(document).on('ready', function() {
  $('#weekly_check').click(function() {
    $('#monthly_check').attr('checked', false);
  });

  $('#monthly_check').click(function() {
    $('#weekly_check').attr('checked', false);
  });

  });
