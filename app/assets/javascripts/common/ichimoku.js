var color_by_serie = {
  'tenkan_sen': '#4ba745',
  'kijun_sen': '#f2095b',
  'chinkou_span': '#9d45a7',
  'senkou_span_a': '#023b7e',
  'senkou_span_b': '#1ef0dd'
}

function addIchimoku(begin, end, id){
  var path = '/indicators/' + id + '/data'

  get_chart_data = $.ajax({
    url: path,
    data: {begin: begin, end: end},
    beforeSend: function(){
      $('#status').text('running')
    }
  })

  $.when(get_chart_data).done(function(data){
    $('#status').text('')
    $.each(data, function(name, series){
      var serie = chart.get(name)
      if (serie != undefined){
        serie.remove()
      }
      chart.addSeries({
        id: name,
        color: color_by_serie[name],
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
