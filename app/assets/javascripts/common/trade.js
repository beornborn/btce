function addTradeResults(id){
  get_chart_data = $.get('/trades/' + id + '/trade_results')

  $.when(get_chart_data).done(function(data){
    chart.addSeries({
      id: 'trade_results',
      type: 'flags',
      name: 'trade_results',
      data: data,
      onSeries: 'candlestick',
      shape: 'squarepin',
      turboThreshold: 10000
    })
  })
}

function showTradeResultDetails(time, trade_id){
  var path = '/trade_results/find'

  get_chart_data = $.ajax({
    url: path,
    data: {time: time, trade_id: trade_id},
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
