$(document).ready(bindEventListeners);


function bindEventListeners() {
    $('#create_tweet').on('click', function(e) {
      ajaxMyShit(e)
  })
}

function ajaxMyShit(e) {
      e.preventDefault();
      $.ajax({
        type: "post"
        url:  "/tweet_something"
        data: $(this).serialize()
      }).done(function(serverResponse) {
        console.log(serverResponse)
      }).fail(function(){
        (console.log(this))
      })
}