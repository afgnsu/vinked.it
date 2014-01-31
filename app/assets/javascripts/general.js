$(document).ready(function(){
  $(document).on('click', '.close', function(e) {
    $(this).parent().remove();
  });
});