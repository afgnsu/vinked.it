$(document).ready(function(){
  $(document).on('click', '.close', function(e) {
    $(this).parent().remove();
  });

  $(document).on('click', '.vink_button', function(e) {
    e.preventDefault();
    var id = this.id;
    $('#club_'+id).show();
  });

  $(document).on('click', '.vink_close', function(e) {
    e.preventDefault();
    $('.vink_form').hide();
  });

});