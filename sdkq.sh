#!/bin/bash

sudo pkill -9 -f sidekiq
redis-cli flushdb
sidekiq -d -L log/sidekiq.log -t 100000
rake sidekiq