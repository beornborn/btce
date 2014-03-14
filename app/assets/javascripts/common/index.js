function initIndex(){
  page = 'index'
  var begin, end, model, ichimoku_id, before_callback, after_callback

  init()

  function init(){
    updateVars()
    $.when(createChart()).done(function(){
      addIchimoku(begin, end, ichimoku_id)
      get_signals()
      subscribeEvents()
    })
  }

  function updateVars(){
    begin = $('#begin').val()
    end = $('#end').val()
    model = $('#model').find(":selected").val()
    ichimoku_id = $('#indicator_id').find(":selected").val()

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
    subscribeDrawIchimoku()
  }

  function subscribeChartCreate(){
    $('#go').click(function(){createChart() })
  }

  function subscribeDrawIchimoku(){
    $('#draw_ichimoku').click(function(){
      updateVars()
      addIchimoku(begin, end, ichimoku_id)
    })
  }
}
