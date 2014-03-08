function initIndex(){
  page = 'index'
  var begin, end, model, before_callback, after_callback

  init()

  function init(){
    updateVars()
    $.when(createChart()).done(function(){
      addIchimoku(begin, end)
      get_signals()
      subscribeEvents()
    })
  }

  function updateVars(){
    begin = $('#begin').val()
    end = $('#end').val()
    model = $('#model').find(":selected").val()

    before_callback = function(){$('#status').text('running')}
    after_callback = function(){$('#status').text('')}
  }

  function createChart(){
    updateVars()
    return drawChart(begin, end, model, before_callback, after_callback)
  }

  function subscribeEvents(){
    subscribeChartCreate()
    subscribeUpdateSignals()
    subscribeToggleIchimoku()
    subscribeToggleVolume()
    subscribeToggleCurrency()
  }

  function subscribeChartCreate(){
    $('#go').click(function(){createChart() })
  }
}
