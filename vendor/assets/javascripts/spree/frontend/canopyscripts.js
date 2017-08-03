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
    /////////// product to cart animation ///////////

    var cart = $('.b-cart'),
        basket =  $('#shopcart')
        cartCountCont = basket.find('.b-cart__count'),
        cartCount = parseInt(cartCountCont.text(), 10),
        addToCart = $('.b-items__item__add-to-cart');

    addToCart.on('click', function (evt) {
      evt.preventDefault();
      evt.stopPropagation();

      var el = $(this),
          item = el.parent(),
          img = item.find('.b-items__item__img'),
          cartTopOffset = cart.offset().top - item.offset().top,
          cartLeftOffset = cart.offset().left - item.offset().left;

      var flyingImg = $('<img class="b-flying-img">');
      flyingImg.attr('src', img.attr('src'));
      flyingImg.css('width', '200').css('height', '200');

      cartCount += 1;

     flyingImg.animate({
        top: cartTopOffset,
        left: cartLeftOffset,
        width: 50,
        height: 50,
        opacity: 0.1
      }, 800, function () {
        flyingImg.remove();
        cartCountCont.text(cartCount);
      });

      el.parent().append(flyingImg);
    });
});
