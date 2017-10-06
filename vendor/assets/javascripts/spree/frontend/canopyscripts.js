$(document).on('ready', function() {
  $('#nav-icon1').click(function() {

      $(this).toggleClass('open');
      $('.menuBar').toggleClass('downMenu');
      $('.menuText .col-md-2').toggleClass('menuDown');
      $('#navigation').toggleClass('menuDown');
      $('html').toggleClass('menuDown');
      $('#header').toggleClass('menuUp');
  });

  $('#order_instore').click(function() {
    $('#order_use_billing').attr('checked', false);
  });

  $('#order_instore').click(function() {
    console.log();
  if  ($('.inner_address_form').not(':first').is(':visible')){
    $('.inner_address_form').not(':first').fadeOut(0);
  } else if ($('.inner_address_form').not(':first').is(':hidden') && !$(this).is(':checked')) {
      $('.inner_address_form').not(':first').fadeIn(0);
    }
  });


  $('#order_use_billing').click(function() {
    $('#order_instore').attr('checked', false);
    $('#order_ship_address_attributes_firstname').val('');
    $('#order_ship_address_attributes_lastname').val('');
    $('#order_ship_address_attributes_address1').val('');
    $('#order_ship_address_attributes_city').val('');
    $('#order_ship_address_attributes_zipcode').val('');
    $('#order_ship_address_attributes_phone').val('');

  });


    $('#address_submit').click(function (evt) {
      var phone = $('#order_bill_address_attributes_phone').val();
      if ($('#order_instore').is(':checked')) {
        $('#order_ship_address_attributes_firstname').attr('disabled',false);
        $('#order_ship_address_attributes_lastname').attr('disabled',false);
        $('#order_ship_address_attributes_address1').attr('disabled',false);
        $('#order_ship_address_attributes_address2').attr('disabled',false);
        $('#order_ship_address_attributes_city').attr('disabled',false);
        $('#order_ship_address_attributes_zipcode').attr('disabled',false);
        $('#order_ship_address_attributes_phone').attr('disabled',false);

        $('#order_ship_address_attributes_firstname').val('Canopy');
        $('#order_ship_address_attributes_lastname').val('Juice');
        $('#order_ship_address_attributes_address1').val('宜蘭市女中路三段117號');
        $('#order_ship_address_attributes_city').val('Yilan City');
        $('#order_ship_address_attributes_zipcode').val('220');
        $('#order_ship_address_attributes_phone').val(phone);
        $(this).submit();
      } else {
        $(this).submit();
      }

});

    $( '.click-me-animation' ).click(function () {
        $( '.navCartCount' ).css({"box-shadow": "0px 0px 40px 8px"});
        $( '.navCartCount p' ).animate({"font-size": "18px"}, 150);
      setTimeout(function() {
        $( '.navCartCount' ).css({"box-shadow": "0px 0px 0px"});
      }, 200);
        $( '.navCartCount p' ).animate({"font-size": "14px"}, 150);
    });

// Slick

    $('.center').slick({
      centerMode: true,
      slidesToShow: 1,
      responsive: [
        {
          breakpoint: 1024,
          settings: {
            arrows: false,
            centerMode: true,
            centerPadding: '200px',
            slidesToShow: 1,
            speed: 100
          }
        },
        {
          breakpoint: 480,
          settings: {
            arrows: false,
            centerMode: true,
            centerPadding: '20px',
            slidesToShow: 1,
            speed: 100
          }
        }
      ]
    });

    /////////// product to cart animation ///////////

    // addToCart = $('.add-to-cart');

    $('.add-to-cart').on('click', function (evt) {
      var cart = $('.navCartCount');
      // evt.preventDefault();
      // evt.stopPropagation();

    var el = $(this),
        item = el.parent().prev(),
        img = item.find('.item__img'),
        flyStartLeft = $('.product-body').width() / 2,
        cartTopOffset = cart.offset().top - item.offset().top,
        cartLeftOffset = cart.offset().left - item.offset().left;

    var flyingImg = $('<img class="flying-img">');
        flyingImg.attr('src', img.attr('src'));
        flyingImg.css('width', '100px').css('height', '100px').css('left',flyStartLeft);

     flyingImg.animate({
        top: cartTopOffset,
        left: cartLeftOffset,
        width: 50,
        height: 50,
        opacity: 0.1
      }, 1000, function () {
        flyingImg.remove();
      });

      img.before(flyingImg);
      count =  parseInt($('#shopcount .navCartCount').text()),
      count +=1;
      $('#shopcount .navCartCount').html(count);
    });


if (($('form#update-cart')).is('*')) {
  return ($('form#update-cart a.destroy')).show().one('click', function() {
    ($(this)).parents('#line-item').first().find('input.line_item_quantity').val(0);
    ($(this)).parents('form').first().submit();
    return false;
  });
}

$('form#update-cart a.submit').click(function() {
  $('form#update-cart').submit();
  });// this. get id and then use that to call on the form id and submit it.

  $('#add-to-cart-button').on('click', function (evt) {
    amoutToAdd = parseInt($('#quantity').val()),
    // evt.preventDefault();
    // evt.stopPropagation();

    shoWcount =  parseInt($('#shopcount .navCartCount').text()),
    shoWcount += amoutToAdd;
    $('#shopcount .navCartCount p').html(shoWcount);
  });


});
