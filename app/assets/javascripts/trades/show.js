function createChart(begin, end){
  var id = $('#trade_chart').data('id')
  var path = '/trades/' + id + '/chart'
  

  get_chart_data = $.ajax({
    url: path,
    data: {begin: begin, end: end},
    beforeSend: function(){
      $('#status').text('running')
    }
  })

  $.when(get_chart_data).done(function(data){
    $('#status').text('')
    initChart(data)
  })
}