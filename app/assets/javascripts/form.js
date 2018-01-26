(function() {

  // $('#formjs').on( "submit", function(e) {
  //   e.preventDefault();
  //
    // $.ajax({
    //      type        : 'POST',
    //      url         : 'http://localhost:3000/grants',
    //      data        : $(this).serialize(),
    //      dataType    : 'json',
    //      encode      : true
    //  })
     // .done(function(data) {
     //      console.log(data);
     //
     //      if (data.status == 'redirect') {
     //        window.location.href = data.location;
     //      } else {
     //        $('.help-block').remove()
     //        $('#formjs-url').addClass('has-error');
     //        $('#formjs-url').parent('div').append('<div class="help-block">' + data.message + '</div>');
     //      }
     //  })
  // });

    $('#formjs-url').blur(function() {
      $.ajax({
           type        : 'POST',
           url         : '/grants/validate',
           data        : $(this).serialize(),
           dataType    : 'json',
           encode      : true
       })
       .done(function(data) {
            if (data.status == 'exists') {
              $(":submit").attr("disabled", true);
              $('.help-block').remove();
              $('#formjs-url').addClass('has-error');
              $('#formjs-url').parent('div').append('<div class="help-block">' + data.message + '</div>');
            } else if (data.status == 'available') {
              $(":submit").removeAttr("disabled");
              $('.help-block').remove();
            }
        })
    })

})();
