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

});