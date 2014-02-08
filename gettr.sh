#!/bin/bash

wget -O csv_data/btce_transactions.csv -q http://api.bitcoincharts.com/v1/csv/btceUSD.csv
tail -1 csv_data/btce_transactions.csv > csv_data/btce_transaction_last.csv