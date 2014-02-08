function subscribeChartCreate(){
  $('#go').click(function(){createChart() })
}

function subscribeUpdateSignals(){
  $('#indicator_id').change(function(){get_signals()})
}

function subscribeToggleIchimoku(){
  $('#ichimoku_control input').change(function(){
    var name = $(this).attr('name')
    var show = ($(this).is(":checked"))
    updateIchimoku(name, show)
  })
}

function subscribeToggleVolume(){
  $('#volume').change(function(){
    var show = ($(this).is(":checked"))
    toggleVolume(show)
  })
}

function subscribeToggleCurrency(){
  $('#currency').change(function(){
    var show = ($(this).is(":checked"))
    toggleCandles(show)
  })
}
