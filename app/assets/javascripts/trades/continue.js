function initContinue(){
  var id = $('#chart').data('id')
  var begin = $('#chart').data('begin')
  var end = $('#chart').data('end')
  var volume_show = $('#volume').is(":checked")

  init()

  function init(){
    $.when(createTradeChart()).done(function(){
      addIchimoku(begin, end)
      get_signals()
      subscribeEvents()
      toggleVolume(volume_show)
    })
  }

  function createTradeChart(){
    return $.get('/trades/'+id+'/continue_chart').done(function(data){
      initCommonChart(data)
    })
  }

  function subscribeEvents(){
    subscribeUpdateSignals()
    subscribeToggleIchimoku()
    subscribeToggleVolume()
    subscribeToggleCurrency()
  }
}
