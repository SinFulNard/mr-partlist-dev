$(document).ready(function(){

  //Basic input change for the Sign in hover box
  $('#nameInput').find('input').attr('value', 'username');
  $('#nameInput').find('input').focus(function(){
    $(this).attr('value', '');
  });

  $('#passInput').find('input').attr('value', '123456789');
  $('#passInput').find('input').focus(function(){
    $(this).attr('value', '');
  });

  //Drop down section for adding parts
  $('.addButton').click(function(){
    $(this).next('.addField').slideDown();
    $(this).html('');
  });

  //Tooltip for a long part name
  $('.long-name').tooltip({'placement':'top'});
});

