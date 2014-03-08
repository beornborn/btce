function initContinue(){
  page = 'trade'
  var id = $('#chart').data('id')
  var volume_show = $('#volume').is(":checked")
  var trade

  init()

  function init(){
    $.when(getTrade(), getTradeChartData()).done(function(trade_data, chart_data){
      trade = trade_data[0]
      setPageTradeData()
      initCommonChart(chart_data[0])
      var end_minus_7_days = new Date(Date.parse(trade.end) - 1000*60*60*24*7)
      addIchimoku(end_minus_7_days, trade.end)
      get_signals()
      toggleVolume(volume_show)
      subscribeEvents()
    })
  }

  function getTradeChartData(){ return $.get('/trades/'+id+'/continue_chart') }
  function getTrade(){ return $.get('/trades/' + id + '/get') }

  function updateTrade(){
    $.when(getTrade()).done(function(trade_data){
      trade = trade_data
      setPageTradeData()
      addChartPoint()
      addIchimokuPoint()
    })
  }

  function addChartPoint(){
    $.get('/trades/' + id + '/last_chart_point').done(function(point){
      chart.series[0].addPoint(point['intervals'][0])
      chart.series[1].addPoint(point['volumes'][0])
      chart.series[2].addPoint(point['tramounts'][0])
    })
  }

  function addIchimokuPoint(){
    $.get('/trades/' + id + '/last_ichimoku_point').done(function(data){
      $.each(data, function(name, point){
        chart.get(name).addPoint(point[0])
      })
    })
  }

  function subscribeTradeAction(){
    $('#action button').click(function(e){
      e.preventDefault();
      var path = $(e.toElement).parent().attr('href')
      $.get(path).done(function(){ updateTrade() })
    })
  }

  function setPageTradeData(){
    $('#trade #description').text(trade.options.description)
    $('#trade #begin').text(trade.begin)
    $('#trade #end').text(trade.end)
    $('#trade #profit_rate').text(trade.profit_rate)

    if (trade.usd > 0){
      $('#action #buy').show()
    } else {
      $('#action #buy').hide()
    }

    if (trade.btc > 0){
      $('#action #sell').show()
    } else {
      $('#action #sell').hide()
    }
  }

  function subscribeEvents(){
    subscribeUpdateSignals()
    subscribeToggleIchimoku()
    subscribeToggleVolume()
    subscribeToggleCurrency()
    subscribeTradeAction()
  }
}
