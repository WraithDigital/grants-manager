(function() {

  // notes rejection
  $('.button-reject').click(function(e) {
    e.preventDefault();
    var notes = window.prompt('Rejection reason');
    if (notes !== null) {
      var form = $(this).closest('form');
      $('<input type="hidden" name="reviewer_notes" value="' + notes + '">').appendTo(form);
      form.submit();
    }
  });

  // pagination
  $('.filters select').change(function() {
    $(this).closest('form').submit();
  });

  // selectize for grant multiselects

  $('.multi-country').selectize({
    maxItems: 15
  });

  $('.multi-applicant').selectize({
    maxItems: 100
  });

  // deadlines wizard

  $(document).on('click', '.rem', function (e) {
    e.preventDefault()
    e.target.closest('.input-group-deadline').remove()

  });

  $(document.body).on('click', '#add-deadline',
    function(e) {
      e.preventDefault()
      var HTMLalertRow = '<div class="input-group-deadline group" data-deadline-group="%data%"><div class="float-left"><input name="deadline[%timestamp%][date]" type="text" class="deadline text start-time-%time%"><select name="deadline[%timestamp%][item_due]" class="item-due"><option selected="selected" value="application">Application</option><option value="other">Other</option></select></div><div><textarea name="deadline[%timestamp%][notes]" placeholder="notes" rows="3" class=""></textarea><a class="rem"><img class="rem-no" src="/no.svg"></a></div></div>'

      var $ = jQuery;
      // var name = '%name%';
      var time = '%time%'
      // var sendAt = '%timestamp%';
      var data = '%data%';
      var timestamp = new Date().getTime();
      var numb = $('.input-group-deadline').last().data("deadline-group") + 1

      $('.deadlines-group').append(HTMLalertRow
        // .replace(name, numb)
        .replace(data, numb)
        .replace(time, numb)
        .replace(/%timestamp%/g, timestamp)
      );
      $('.start-time-'+numb).datetimepicker({
          validateOnBlur: false,
          format:'d/m/Y',
          timepicker: false
        });

      $('body,html').animate({
        scrollTop: $('.input-group-deadline').last().offset().top + 'px'
      },500,'linear');
    }
  );

})();
