function drawChart(begin, end, model, before_callback, after_callback){
  get_chart_data = $.ajax({
    url: '/chart',
    data: {begin: begin, end: end, model: model},
    beforeSend: before_callback
  })

  $.when(get_chart_data).done(function(data){
    initCommonChart(data)
  }).always(after_callback)
}

function toggleCandles(show){
  var serie = chart.series[0]
  if (show){
    serie.show()
  } else {
    serie.hide()
  }
}

function profit_rate_by_range(event){
  var begin = Math.round(event.xAxis[0].min / 1000)
  var end = Math.round(event.xAxis[0].max / 1000)
  $.get('profit_rate_by_range', {begin: begin, end: end}).done(function(data){
    $('#profit_rate').text(data)
  })
}

function initCommonChart(data){
  chart = new Highcharts.StockChart({
    chart: {
      zoomType: 'x',
      renderTo: 'chart',
      events: {
        selection: function(event) {
          if (page == 'analyze'){
            profit_rate_by_range(event)
          }
        }
      }
    },

    colors: ['#4572a7','#bb0000', '#49fff7', '#b41e95', '#4bff68', '#c34420', '#58313c', '#B5CA92'],
    rangeSelector: {
      enabled: false,
      buttons: [
        {type: 'hour', count: 1, text: '1h'},
        {type: 'hour', count: 6, text: '6h'},
        {type: 'hour', count: 12, text: '12h'},
        {type: 'day', count: 1, text: '1d'},
        {type: 'day', count: 3, text: '3d'},
        {type: 'day', count: 7, text: '7d'},
        {type: 'day', count: 14, text: '14d'},
        {type: 'month', count: 1, text: '1m'},
        {type: 'month', count: 3, text: '3m'},
        {type: 'month', count: 6, text: '6m'},
        {type: 'year', count: 1, text: '1y'},
        {type: 'all', text: 'all'},
      ],
      selected: 7,
      inputEnabled: false
    },

    yAxis: [{
      title: {
          text: 'OHLC'
      },
      height: 500,
      top: 0,
      lineWidth: 2,
      opposite: true
    }, {
      title: {
        text: 'Volume'
      },
      top: -200,
      height: 130,
      offset: 0,
      lineWidth: 2
    }, {
      top: -200,
      height: 130,
      offset: 0,
      lineWidth: 0,
      opposite: true
    }],

    plotOptions: {
      column: {
        dataGrouping: {
          approximation: 'average'
        },
      },
      candlestick: {
        allowPointSelect: true,
        colorByPoint: true,
        upColor: '#49c043',
        colors: ['#cc1414'],
        pointPadding: 0.1,
        point: {
          events: {
            select: function(e){
              if (page == 'analyze'){
                var id = $('#chart').data('id')
                showTradeResultDetails(this.x / 1000, id)
              }
            }
          },
        }
      }
    },

    series : [{
      id: 'candlestick',
      name : 'EUR/USD',
      type: 'candlestick',
      data : data['intervals'],
      tooltip: {
        valueDecimals: 6
      }
    }, {
      type: 'column',
      name: 'Volume',
      data: data['volumes'],
      yAxis: 1
    }, {
      type: 'column',
      name: 'Tramount',
      data: data['tramounts'],
      yAxis: 2
    }]
  });
}
