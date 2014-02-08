#!/bin/bash

sudo pkill -9 -f sidekiq
redis-cli flushdb
