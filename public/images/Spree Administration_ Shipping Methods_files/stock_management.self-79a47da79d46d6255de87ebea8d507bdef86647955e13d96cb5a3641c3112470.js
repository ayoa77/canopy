(function() {
  jQuery(function() {
    $('.stock_item_backorderable').on('click', function() {
      return $(this).parent('form').submit();
    });
    return $('.toggle_stock_item_backorderable').on('submit', function() {
      $.ajax({
        type: this.method,
        url: this.action,
        data: $(this).serialize()
      });
      return false;
    });
  });

}).call(this);
