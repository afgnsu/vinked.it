$(document).ready(function(){
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

});


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
