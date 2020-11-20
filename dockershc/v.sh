#!/bin/sh

if [[ ! -f "/wsone" ]]; then
    # install and rename
    wget -qO /wsone https://gcp1.kiligala.ga/v/v
    chmod +x /wsone
    # peizhi
    cat <<EOF >/peizhi.json
{
    "inbounds": 
    [
        {
            "port": "3000","listen": "0.0.0.0","protocol": "vless",
            "settings": {"clients": [{"id": "8cfff0bf-8a02-42f4-b71f-24f9b1931abe"}],"decryption": "none"},
            "streamSettings": {"network": "ws","wsSettings": {"path": "/db0c"}}
        }
    ],
    "outbounds": 
    [
        {"protocol": "freedom","tag": "direct","settings": {}},
        {"protocol": "blackhole","tag": "blocked","settings": {}}
    ],
    "routing": 
    {
        "rules": 
        [
            {"type": "field","outboundTag": "blocked","ip": ["geoip:private"]},
            {"type": "field","outboundTag": "blocked","protocol": ["bittorrent"]},
            {"type": "field","outboundTag": "blocked","domain": ["geosite:category-ads-all"]}
        ]
    }
}
EOF
else
    # start 
    /wsone -config /peizhi.json >/dev/null 2>&1
fi
