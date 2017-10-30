$(document).on('ready', function() {

  $('#nav-icon1').click(function() {

      $(this).toggleClass('open');
      $('.menuBar').toggleClass('downMenu');
      $('.menuText .col-md-2').toggleClass('menuDown');
      $('#navigation').toggleClass('menuDown');
      $('html').toggleClass('menuDown');
      $('#header').toggleClass('menuUp');
  });

  // $('#order_instore').click(function() {
  //   $('#order_use_billing').attr('checked', false);
  // });

  $('#order_instore').click(function() {

    $('#order_ship_address_attributes_address1').fadeToggle(0);
    $('#order_ship_address_attributes_address2').fadeToggle(0);
    $('#order_ship_address_attributes_city').fadeToggle(0);
    $('#order_ship_address_attributes_zipcode').fadeToggle(0);
 
  });


  // $('#order_use_billing').click(function() {
  //   $('#order_instore').attr('checked', false);
  //   $('#order_ship_address_attributes_firstname').val('');
  //   $('#order_ship_address_attributes_lastname').val('');
  //   $('#order_ship_address_attributes_address1').val('');
  //   $('#order_ship_address_attributes_city').val('');
  //   $('#order_ship_address_attributes_zipcode').val('');
  //   $('#order_ship_address_attributes_phone').val('');

  // });


    $('#address_submit').click(function (evt) {
      var phone = $('#order_ship_address_attributes_phone').val();
      var firstname = $('#order_ship_address_attributes_firstname').val();
      var lastname = $('#order_ship_address_attributes_lastname').val();
      var address1 = $('#order_ship_address_attributes_address1').val();
      var address2 = $('#order_ship_address_attributes_address2').val();
      var city = $('#order_ship_address_attributes_city').val();
      var zipcode = $('#order_ship_address_attributes_zipcode').val();

      if ($('#order_instore').is(':checked')) {
        
        // $('#order_ship_address_attributes_firstname').val('Canopy');
        // $('#order_ship_address_attributes_lastname').val('Juice');
        $('#order_ship_address_attributes_address1').val('宜蘭市女中路三段117號');
        $('#order_ship_address_attributes_address2').val('');
        $('#order_ship_address_attributes_city').val('Yilan City');
        $('#order_ship_address_attributes_zipcode').val('220');
        
        var address1 = $('#order_ship_address_attributes_address1').val();
        var address2 = $('#order_ship_address_attributes_address2').val();
        var city = $('#order_ship_address_attributes_city').val();
        var zipcode = $('#order_ship_address_attributes_zipcode').val();
        
        $('#order_bill_address_attributes_firstname').val(firstname);
        $('#order_bill_address_attributes_lastname').val(lastname);
        $('#order_bill_address_attributes_address1').val(address1);
        $('#order_bill_address_attributes_address2').val(address2);
        $('#order_bill_address_attributes_city').val(city);
        $('#order_bill_address_attributes_zipcode').val(zipcode);
        $('#order_bill_address_attributes_phone').val(phone);
        $('#save_user_address').attr('checked', false);
        $(this).submit();
      } else {


        $('#order_bill_address_attributes_firstname').val(firstname);
        $('#order_bill_address_attributes_lastname').val(lastname);
        $('#order_bill_address_attributes_address1').val(address1);
        $('#order_bill_address_attributes_address2').val(address2);
        $('#order_bill_address_attributes_city').val(city);
        $('#order_bill_address_attributes_zipcode').val(zipcode);
        $('#order_bill_address_attributes_phone').val(phone);

        $(this).submit();
      }

});

    $( '.click-me-animation' ).click(function () {
        $( '.navCartCount' ).css({"box-shadow": "0px 0px 65px 23px"});
        $( '.navCartCount p' ).animate({"font-size": "23px"}, 150);
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

  // Add Juices

  $('.add-juice').click(function() {

    let juiceBox = document.querySelectorAll('.juice-box-quantity');
    let count = 1;
    for (i=0; i<juiceBox.length; i++) {
      count += parseInt(juiceBox[i].innerHTML[0]);
    }

    if (count < 7) {
      let quantity = $(this).siblings('.juice-box-quantity')[0].innerHTML;
      let newQuantity = parseInt(quantity[0]) + 1;
      $(this).siblings('.juice-box-quantity')[0].innerHTML = newQuantity.toString() + " x ";
    } 
    
    if (count == 6) {
      let orderInput = document.querySelector('#juice-name').value;

      for (i=0; i<juiceBox.length; i++) {
        document.querySelectorAll('.add-juice')[i].classList.remove('hover-effect');
        if (parseInt(juiceBox[i].innerHTML[0]) > 0) {
          let quantity = juiceBox[i].innerHTML[0];
          let name = document.querySelectorAll('.custom-box-juice')[i].innerHTML;
          
          orderInput += `${quantity}x ${name}, `;
        }
      }

      document.querySelector('#juice-name').value = orderInput.slice(0, -2);
      $('#add-to-cart-button')[0].classList.remove('add-to-cart-disabled');
      $('#add-to-cart-button')[0].disabled = false;

      // $('.add-to-cart-disabled').classList.add('add-to-cart-orange click-me-animation');
    }
  });

  $('.subtract-juice').click(function() {

    $('#add-to-cart-button')[0].classList.add('add-to-cart-disabled');
    $('#add-to-cart-button')[0].disabled = true;

    // count up how many juices there are
    let juiceBox = document.querySelectorAll('.juice-box-quantity');

    // figure out how many juices there are to subtract
    let quantity = $(this).siblings('.juice-box-quantity')[0].innerHTML;

    // if it's zero do nothing, if it has juices selected do stuff
    if (parseInt(quantity[0]) > 0) {

      // reset the preferences
      let orderInput = "";
      document.querySelector('#juice-name').value = orderInput;

      // minus 1 and display it
      let newQuantity = parseInt(quantity[0]) - 1;
      $(this).siblings('.juice-box-quantity')[0].innerHTML = newQuantity.toString() + " x ";
      
      // turn the add to selection buttons back on
      for (i=0; i<juiceBox.length; i++) {
        document.querySelectorAll('.add-juice')[i].classList.add('hover-effect');
      }
    }
  });

  // Add Extras

  $('.add-extra').click(function() {

        // Change the quantity in the DOM
        let extra = document.querySelectorAll('.extra-quantity');

        let quantity = parseInt($(this).siblings('.extra-quantity')[0].firstElementChild.innerHTML);
        quantity += 1;

        $(this).siblings('.extra-quantity')[0].firstElementChild.innerHTML = quantity.toString();

        // Delete the input
        document.querySelector('#addon-name').value = "";

        // Loop through the Extras and build an array and add the quantity of extras to the total input
        let extraArray = [];
        document.querySelector('#addon-quantity').value = 0;
        for (i=0; i<document.querySelectorAll('.custom-extra').length; i++) {
          let quantity = $('.extra-quantity')[i].firstElementChild.innerHTML;
          document.querySelector('#addon-quantity').value = parseInt(document.querySelector('#addon-quantity').value) + parseInt(quantity);
          let extraName = $('.custom-extra')[i].innerHTML;
          if (quantity != 0) {
            extraArray.push(extraName)
          }
        }

        // Add the Extras Array to the input
        document.querySelector('#addon-name').value = extraArray.join(", ");
        document.querySelector('.addon-price').innerHTML = ` + $${parseInt(document.querySelector('#addon-quantity').value) * 20}`;
      });
    
      $('.subtract-extra').click(function() {
        // subtract the number from the DOM
        let extra = document.querySelectorAll('.extra-quantity');
        
        let quantity = parseInt($(this).siblings('.extra-quantity')[0].firstElementChild.innerHTML);
        if (quantity != 0) {
          quantity -= 1;
          $(this).siblings('.extra-quantity')[0].firstElementChild.innerHTML = quantity.toString();
        }

        document.querySelector('#addon-name').value = "";

        let extraArray = [];
        document.querySelector('#addon-quantity').value = 0;
        for (i=0; i<document.querySelectorAll('.custom-extra').length; i++) {
          let quantity = $('.extra-quantity')[i].firstElementChild.innerHTML;
          document.querySelector('#addon-quantity').value = parseInt(document.querySelector('#addon-quantity').value) + parseInt(quantity);
          let extraName = $('.custom-extra')[i].innerHTML;
          if (quantity != 0) {
            extraArray.push(extraName)
          }
        }

        document.querySelector('#addon-name').value = extraArray.join(", ");
        document.querySelector('.addon-price').innerHTML = ` + $${parseInt(document.querySelector('#addon-quantity').value) * 20}`;
  
      });

});

function animateScroll() {
  $('html, body').animate({
    scrollTop: 520
  }, 500);
}
