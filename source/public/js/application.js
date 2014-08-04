$(document).ready(function() {
  $('#content button[type="submit"]').on('click', function(e){
    e.preventDefault();
    // debugger
    battletag = $("input[name='battletag']").val();
    battletagCode = $("input[name='battletag_code']").val();
    $.ajax({
      url: '/battletag_account/new',
      type: 'POST',
      data: {battletag: battletag, battletag_code: battletagCode}
    }).fail(function(XHR, response){
      $('#error').html(XHR.responseText)
    }).success(function(response){
      $('#content').html(response)
    })
  })
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
});