var ready;
ready = function() {
  $(".fancybox").fancybox();

  $(document).on('click', '.close', function(e) {
    $(this).parent().remove();
  });

  $(document).on('click', '.vink_button', function(e) {
    e.preventDefault();
    var id = this.id;
    $('#club_'+id).toggle();
  });

  $(document).on('click', '.vink_close', function(e) {
    e.preventDefault();
    $('.vink_form').hide();
    $('.errors').empty();
  });

  $(document).on('click', '.vink_details', function(e) {
    e.preventDefault();
    var id = this.id;
    $('#vink_'+id).toggle();
  });

  if ($("#league").length > 0){
    $.conditionalize($("#country"), $("#league"), "data-country");
  }
  if ($("#club_league_id").length > 0){
    $.conditionalize($("#club_country_id"), $("#club_league_id"), "data-country");
  }

  updateCountdown();
  $('.comment_input').change(updateCountdown);
  $('.comment_input').keyup(updateCountdown);
};

$(document).ready(ready);
$(document).on('page:load', ready);

$.conditionalize = function(sourceSelect, targetSelect, dataSelector){
  options = $(targetSelect).children().clone();
  $(sourceSelect).on('change', function() {
    selected_id = $(this).val();
    $(targetSelect).children().remove();
    if (selected_id == ""){
      options.appendTo(targetSelect);
    }
    else{
      options.filter('[' + dataSelector + '="' + selected_id + '"]').appendTo(targetSelect);
      $(targetSelect).prepend("<option value=''></option>");
    }
  });
}

function updateCountdown() {
  if ($(".comment_input").length > 0){
    var remaining = 140 - jQuery('.comment_input').val().length;
    jQuery('.countdown').text(remaining + ' characters remaining');
  }
}
