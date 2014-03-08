function addIchimoku(begin, end, id){
  var path = '/ichimoku'

  get_chart_data = $.ajax({
    url: path,
    data: {begin: begin, end: end, id: id},
    beforeSend: function(){
      $('#status').text('running')
    }
  })

  $.when(get_chart_data).done(function(data){
    $('#status').text('')
    $.each(data, function(name, series){
      chart.addSeries({
        id: name,
        name: name,
        data: series
      })
    })
    $('#ichimoku_control').show()
  })
}

function updateIchimoku(name, show){
  var serie = serieByName(chart.series, name)
  if (show){
    serie.show()
  } else {
    serie.hide()
  }
}

function serieByName(series, name){
  var result = null
  $(series).each(function(i, serie){
    if (serie.options.name == name){
      result = serie
    }
  })
  return result
}
