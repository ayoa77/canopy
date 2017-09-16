// $(document).ready(function() {
//   $("#add-to-cart-from-product-show").submit(function(event) {
//     event.preventDefault();
//     $.post('/orders/variant_populate'), $(this).serialize(),
// null, "script");
//         return false;
//       })
//  });

$(document).ready(function() {
      $("#add-to-cart-from-product-show").submit(function(event) {
        event.preventDefault();
        $.post('/orders/variant_populate'), $(this).serialize(),
null, "script");
        return false;
      })
 });
