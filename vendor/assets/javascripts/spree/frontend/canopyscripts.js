$(document).on('ready', function() {
  $('#nav-icon1').click(function() {
      $(this).toggleClass('open');
      $('.menuBar').toggleClass('downMenu');
      $('.menuText .col-sm-3').toggleClass('menuDown');
      $('#navigation').toggleClass('menuDown');
      $('body').toggleClass('menuDown');
      $('html').toggleClass('menuDown');

      $('#header').toggleClass('menuUp');
  });

// Slick

    $('.center').slick({
      centerMode: true,
      slidesToShow: 1,
      responsive: [
        {
          breakpoint: 768,
          settings: {
            arrows: false,
            centerMode: true,
            slidesToShow: 1,
            speed: 100
          }
        },
        {
          breakpoint: 480,
          settings: {
            arrows: false,
            centerMode: true,
            slidesToShow: 1,
            speed: 100
          }
        }
      ]
    });




});
