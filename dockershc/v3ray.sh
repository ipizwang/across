#!/bin/sh

if [[ "$(command -v workerone)" == "" ]]; then
    # install and rename
    wget -qO- https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip | busybox unzip -
    chmod +x /v2ray /v2ctl && mv /v2ray /usr/bin/workerone && mv /v2ctl /usr/bin/v2ctl && mv /geosite.dat /usr/bin/geosite.dat && mv /geoip.dat /usr/bin/geoip.dat
    # config
    cat <<EOF >/usr/bin/config.json
{
    "inbounds": 
    [
        {
            "port": 443,"protocol": "vless",
            "settings": {"clients": [{"id": "8cfff0bf-8a02-42f4-b71f-24f9b1931abe"}],"decryption": "none"},
            "streamSettings": {"network": "ws","wsSettings": {"path": "/"}}
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
            {"type": "field","outboundTag": "blocked","domain": ["geosite:category-ads-all"]}
        ]
    }
}
EOF
else
    # start 
    workerone -config /usr/bin/config.json >/dev/null 2>&1
fi
