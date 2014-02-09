#!/bin/bash

wget -O - --header="Accept-Encoding: gzip" http://api.bitcoincharts.com/v1/csv/btceUSD.csv.gz | gunzip > csv_data/btce_transactions.csv
tail -1 csv_data/btce_transactions.csv > csv_data/btce_transaction_last.csv
