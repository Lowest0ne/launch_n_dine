$(document).ready( function(){

  $notice_obj = $('.alert-box');
  if ($notice_obj.length != 0)
  {
    $notice_obj.delay(1000).fadeOut(1000, function(){ $notice_obj.remove; } );
  }

});
