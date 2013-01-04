// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require modernizr
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require h5bp
//= require timepicker
//= require_self

(function (opacity) {
  if ( !document.createElement('canvas').getContext ) {
    return true;
  }

  var canvas = document.createElement('canvas')
  , ctx = canvas.getContext('2d')
  , x,y
  , r,g,b
  , opacity = opacity || .1
  ;

  canvas.width = 55;
  canvas.height = 55;

  for ( x = 0; x < canvas.width; x++ ) {
    for ( y = 0; y < canvas.height; y++ ) {
      r = Math.floor( Math.random() * 55 );
      g = Math.floor( Math.random() * 55 );
      b = Math.floor( Math.random() * 55 );

      ctx.fillStyle = 'rgba(' + r + ',' + g + ',' + b + ',' + opacity + ')';
      ctx.fillRect(x,y,1,1);
    }
  }
  $('body').css('backgroundImage', 'url(' + canvas.toDataURL("image/png") + ')');
})();

$( "#input" ).datepicker({
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
  selectOtherMonths: true,
  showOn: 'button',
  buttonImageOnly: true,
  buttonImage: '/images/date.png',
  buttonText: 'Choose a date'
}).autocomplete({
  source: function( request, response ) {
  $.ajax({
    url: "/autocomplete.json",
    dataType: "json",
    data: {
      "input": request.term
    },
    success: function( data ) {
      response( $.map( data, function( item ) {
        if (item.expected_release_year || item.original_release_date)
          return {
            label: item.name,
            image: ((item.image) ? ((typeof item.image.tiny_url != "undefined") ? item.image.tiny_url : "") : ""),
            value: item.name
          }
      }));
    }
  })},
  minLength: 2

}).data( "autocomplete" )._renderItem = function( ul, item ) {
  return $( "<li></li>" )
    .data( "item.autocomplete", item )
    .append( "<a><img src='" + (item.image != '' ? item.image : '/images/unknown-game.png') + "' /><strong>" + item.label + "</strong></a>" )
    .appendTo( ul );
};

$result_dup = $('<div id="result_dup" class="result" />').css({'visibility':'hidden','position':'absolute', 'width':'640px', 'bottom': 0, 'left': 0, 'z-index': -1}).prependTo('body');
$convert_form = $('#convert_form');
$convert_form.attr('action', $convert_form.attr('action') + '.txt');
$convert_form.live('ajax:before', function(){
  if (Modernizr.csstransforms) clock_update('spin');
  return true;
}).live('ajax:success', function(xhr, data, status){
  if (Modernizr.csstransforms) {
    clearInterval(window.clock_interval);
    window.clock_interval = setInterval("clock_update('spinandstop')", 1000);
  }
  $result = $('#result');

  $data = $(data).filter('#result');
  if ($result.length == 0) {
    $('<div id="result" class="result" />').css({'display':'none'}).prependTo('#main').slideDown(1000).html($data.html());
  } else {
    $background = $('<div id="background" />');
    height = $result.height();
    $result_dup.html($data.html()).show();
    new_height = $result_dup.height();

    $background.prependTo($result).animate({'opacity': 0}, 1000/*, function() {$(this).remove();}*/);
    $result
      .css({'height': height})
      .html($data.html())
      .animate({'height': new_height}, 1000, function() {
      $(this).css({height: null});
    });
    $result_dup.empty();
  }
});
$(window).bind('keypress', function () {
  $('#input').focus();
});
$('li','#examples').click(function(){$('#input').val($(this).text()).focus();});
/*initial values:
    #hours   = -14355 degrees
    #minutes = -14470 degrees*/
$(document).ready(function () {

if (Modernizr.csstransforms) {
  window.update_transforms = update_transforms = function() {
    $hours.css({
      '-moz-transform': 'rotate('+window.hours_deg+'deg)',
      '-webkit-transform': 'rotate('+window.hours_deg+'deg)',
      '-o-transform': 'rotate('+window.hours_deg+'deg)',
      'transform': 'rotate('+window.hours_deg+'deg)'
    });
    $minutes.css({
      '-moz-transform': 'rotate('+window.minutes_deg+'deg)',
      '-webkit-transform': 'rotate('+window.minutes_deg+'deg)',
      '-o-transform': 'rotate('+window.minutes_deg+'deg)',
      'transform': 'rotate('+window.minutes_deg+'deg)'
    });
  };

  $('<div id="clock"/>').append('<div id="hours"/>').append('<div id="minutes"/>').appendTo('#header');

  window.hours_deg = -14355;
  window.minutes_deg = -14472;
  window.minutes_deg_per_sec = 0.1;
  window.hours_deg_per_sec = 30/3600;
  window.$hours = $hours = $('#hours');
  window.$minutes = $minutes = $('#minutes');

  window.clock_update = function (mode) {
    clearInterval(window.clock_interval);

    // we have a mode given!
    if (typeof mode == "string") {
      switch (mode) {

        case "startspinandstop":
          var d = new Date()
            , h = d.getHours() % 12
            , m = d.getMinutes()
            , s = d.getSeconds()
            ;
          //-14470;
          window.hours_deg = -14400 + (h*30) + (m*0.5) + (s*window.hours_deg_per_sec);
          window.hours_deg += 360; //30*4
          window.minutes_deg = -14400 + (m*6) + (s*window.minutes_deg_per_sec);
          window.minutes_deg += 1440; //360*4
          window.clock_interval = setInterval("clock_update()", 1000);
          break;

        case "spinandstop":
          var d = new Date()
            , h = d.getHours() % 12
            , m = d.getMinutes()
            , s = d.getSeconds()
            ;
          window.hours_deg = parseInt(window.hours_deg/360)*360 + (h*30) + (m*0.5) + (s*window.hours_deg_per_sec);
          //window.hours_deg += 360; //30*4
          window.minutes_deg = parseInt(window.minutes_deg/360)*360 + (m*6) + (s*window.minutes_deg_per_sec);
          //window.minutes_deg += 1440; //360*4
          window.clock_interval = setInterval("clock_update()", 1000);
          break;

        case "spin":
          window.minutes_deg += 1440; //360*4
          window.hours_deg += 360; //30*4
          window.clock_interval = setInterval("clock_update('spin')", 1000);
          break;

      }
    } else {
      window.minutes_deg += window.minutes_deg_per_sec;
      window.hours_deg += window.hours_deg_per_sec;
      window.clock_interval = setInterval("clock_update()", 1000);
    }
    window.update_transforms();

  }

  window.clock_interval = setInterval("clock_update('startspinandstop')", 2000);
}

});
if ( typeof window.history.pushState != "undefined" ) {
  $convert_form.bind('submit', function(){
    val = $('#input').val();
    if (val.length > 0) {
      data = {}
      data["input"] = val;
      window.history.pushState(data, val + " - Valve Time Calculator", "/?input="+encodeURI(val).replace(' ', '+'));
    }
  });
  window.onpopstate = function (data) {
    console.log(data.state.input);
  }
}
