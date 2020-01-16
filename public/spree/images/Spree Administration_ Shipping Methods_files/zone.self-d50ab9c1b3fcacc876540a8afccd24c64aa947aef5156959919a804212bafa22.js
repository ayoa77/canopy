(function() {
  var show_country, show_state;

  $(function() {
    ($('#country_based')).click(function() {
      return show_country();
    });
    ($('#state_based')).click(function() {
      return show_state();
    });
    if (($('#country_based')).is(':checked')) {
      return show_country();
    } else if (($('#state_based')).is(':checked')) {
      return show_state();
    } else {
      show_state();
      return ($('#state_based')).click();
    }
  });

  show_country = function() {
    ($('#state_members :input')).each(function() {
      return ($(this)).prop('disabled', true);
    });
    ($('#state_members')).hide();
    ($('#zone_members :input')).each(function() {
      return ($(this)).prop('disabled', true);
    });
    ($('#zone_members')).hide();
    ($('#country_members :input')).each(function() {
      return ($(this)).prop('disabled', false);
    });
    return ($('#country_members')).show();
  };

  show_state = function() {
    ($('#country_members :input')).each(function() {
      return ($(this)).prop('disabled', true);
    });
    ($('#country_members')).hide();
    ($('#zone_members :input')).each(function() {
      return ($(this)).prop('disabled', true);
    });
    ($('#zone_members')).hide();
    ($('#state_members :input')).each(function() {
      return ($(this)).prop('disabled', false);
    });
    return ($('#state_members')).show();
  };

}).call(this);
