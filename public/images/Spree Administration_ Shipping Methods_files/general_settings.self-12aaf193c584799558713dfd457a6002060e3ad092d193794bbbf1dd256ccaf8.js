(function() {
  $(this).ready(function() {
    return $('[data-hook=general_settings_clear_cache] #clear_cache').click(function() {
      return $.ajax({
        type: 'POST',
        url: Spree.routes.clear_cache,
        success: function() {
          return show_flash('success', "Cache was flushed.");
        },
        error: function(msg) {
          if (msg.responseJSON["error"]) {
            return show_flash('error', msg.responseJSON["error"]);
          } else {
            return show_flash('error', "There was a problem while flushing cache.");
          }
        }
      });
    });
  });

}).call(this);
