// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$( "#name" )/*.datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: 'yy-mm-dd',
        duration: '',
        showTime: true,
        constrainInput: false,
        stepMinutes: 1,
        stepHours: 1,
        time24h: true,
        showOtherMonths: true,
        selectOtherMonths: true
      })*/.autocomplete({
        source: function( request, response ) {
        $.ajax({
          url: "/autocomplete.json",
          dataType: "json",
          data: {
            name: request.term
          },
          success: function( data ) {
            response( $.map( data, function( item ) {
              return {
                label: item.name,
                image: item.image.tiny_url,
                value: item.name
              }
            }));
          }
        })},
        minLength: 2

      }).data( "autocomplete" )._renderItem = function( ul, item ) {
        return $( "<li></li>" )
          .data( "item.autocomplete", item )
          .append( "<a><img src='" + item.image + "' />" + item.label + "</a>" )
          .appendTo( ul );
      };
