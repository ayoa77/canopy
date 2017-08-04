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

    /////////// product to cart animation ///////////

    var cart = $('.navCartCount'),
        addToCart = $('.add-to-cart');

    addToCart.on('click', function (evt) {
      // evt.preventDefault();
      // evt.stopPropagation();

      var el = $(this),
          item = el.parent().prev(),
          img = item.find('.item__img'),
          cartTopOffset = cart.offset().top - item.offset().top,
          cartLeftOffset = cart.offset().left - item.offset().left;

      var flyingImg = $('<img class="flying-img">');
      flyingImg.attr('src', img.attr('src'));
      flyingImg.css('width', '100px').css('height', '100px');

     flyingImg.animate({
        top: cartTopOffset,
        left: cartLeftOffset,
        width: 50,
        height: 50,
        opacity: 0.1
      }, 800, function () {
        flyingImg.remove();
      });

      el.parent().prev().prepend(flyingImg);
      count =  parseInt($('#shopcount .navCartCount').text()),
      count +=1;
      $('#shopcount .navCartCount').html(count);
    });

});
