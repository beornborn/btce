// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require highstock
//= require_tree ./trades
//= require_tree ./common
var chart = null
var page = null
var trade = null

Highcharts.setOptions({
  global: {
    useUTC: false
  }
});

function getFlagData(flags){
  var flag_data = []
  $.each(flags, function(index, flag){
    flag_data.push({x: new Date(flag['x']), title: flag['title']})
  })
  return flag_data
}

function initChart(data){
    var flag_data = getFlagData(data['flags'])

    $('#trade_chart').highcharts('StockChart', {
      plotOptions: {
        column: {
          dataGrouping: {
            approximation: 'average'
          }
        }
      },

      title: {
        text: 'Forex ' + data['rate']
      },

      rangeSelector : {
        buttons : [
          {type : 'minute', count : 1, text : '1m'},
          {type : 'minute', count : 3, text : '3m'},
          {type : 'minute', count : 5, text : '5m'},
          {type : 'minute', count : 15, text : '15m'},
          {type : 'hour', count : 1, text : '1h'},
          {type : 'day', count : 1, text : '1D'},
          {type : 'all', count : 1, text : 'All'}
        ],
        selected : 6,
        inputEnabled : false
      },

      yAxis: [{
        title: {
            text: 'OHLC'
        },
        height: 200,
        lineWidth: 2
      }, {
        title: {
          text: 'Strategy'
        },
        top: 300,
        height: 100,
        offset: 0,
        lineWidth: 2
      }],

      series : [{
        id: 'candlestick',
        name : 'EUR/USD',
        type: 'candlestick',
        data : data['minutes'],
        tooltip: {
          valueDecimals: 6
        }
      },{
        type: 'column',
        name: 'Estimate Profit',
        data: data['trade'],
        yAxis: 1
      },{
        type: 'flags',
        name: 'Deals',
        data: flag_data,
        onSeries: 'candlestick',
        shape: 'circlepin',
        turboThreshold: 10000000
      }]
    });

}
