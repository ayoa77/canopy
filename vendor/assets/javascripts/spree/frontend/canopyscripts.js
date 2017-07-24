$(document).on('ready', function() {
  $('#nav-icon1').click(function() {
      $(this).toggleClass('open');
      $('.menuBar').toggleClass('downMenu');
      $('.menuText .col-xs-3').toggleClass('menuDown');
      $('#navigation').toggleClass('menuDown');
      $('body').toggleClass('menuDown');
      $('html').toggleClass('menuDown');

    });
});
