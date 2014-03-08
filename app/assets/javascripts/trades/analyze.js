function initAnalyze(){
  page = 'analyze'
  var begin, end, model, before_callback, after_callback
  var id = $('#chart').data('id')
  var volume_show = $('#volume').is(":checked")

  init()

  function init(){
    $.when(getTrade()).pipe(function(trade_data){
      trade = trade_data
      setPageTradeData()
      getAnalyzeChartData()
      subscribeEvents()
    })
  }

  function updateVars(){
    begin = $('#begin').text()
    end = $('#end').text()
    model = 'Hour'

    before_callback = function(){$('#status').text('running')}
    after_callback = function(){
      $('#status').text('')
      toggleVolume(volume_show)
    }
  }

  function getAnalyzeChartData(){
    updateVars()
    return drawChart(begin, end, model, before_callback, after_callback)
  }
  function getTrade(){ return $.get('/trades/' + id + '/get') }

  function setPageTradeData(){
    $('#trade #description').text(trade.options.description)
    $('#trade #begin').text(trade.begin)
    $('#trade #end').text(trade.end)
    $('#trade #profit_rate').text(trade.profit_rate)
  }

  function subscribeEvents(){
    subscribeToggleIchimoku()
    subscribeToggleVolume()
    subscribeToggleCurrency()
    subscribeDrawIchimoku()
    subscribeDrawTradeResults()
  }
}
