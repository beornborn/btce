function showPointDetails(time){
  var path = '/chart/point_details'

  get_chart_data = $.ajax({
    url: path,
    data: {time: time},
  })

  $.when(get_chart_data).done(function(data){
    $('#details').html('')
    $.each(data, function(k, v){
      $('<div/>', {
        text: k + ': ' + v
      }).appendTo('#details')
    })
  })
}
