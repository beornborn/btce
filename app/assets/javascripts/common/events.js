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

function subscribeDrawIchimoku(){
  $('#draw_ichimoku').click(function(){
    var begin = $('#begin').text()
    var end = $('#end').text()
    var id = trade.strategy.options.indicator_id
    console.log(trade)
    addIchimoku(begin, end, id)
  })
}

function subscribeDrawTradeResults(){
  $('#draw_trade_results').click(function(){
    var id = $('#chart').data('id')
    addTradeResults(id)
  })
}
