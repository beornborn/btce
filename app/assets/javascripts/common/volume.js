function toggleVolume(show){
  var ready_to_show = (chart.series[1].yAxis.top != 0)
  if (show != ready_to_show){ return null}

  var delta_height = chart.series[1].yAxis.height
  var main_top = chart.series[0].yAxis.top
  var chart_height = $(chart.renderTo).height()

  if (show){
    chart.series[1].yAxis.update({top: 0})
    chart.series[2].yAxis.update({top: 0})
    chart.series[0].yAxis.update({top: main_top + delta_height})
    $(chart.renderTo).css('height', chart_height + delta_height)
  } else {
    chart.series[1].yAxis.update({top: -200})
    chart.series[2].yAxis.update({top: -200})
    chart.series[0].yAxis.update({top: main_top - delta_height})
    $(chart.renderTo).css('height', chart_height - delta_height)
  }
  chart.reflow()
}
