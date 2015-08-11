#!/bin/bash

docker run -d -t --dns 127.0.0.1 -e NODE_TYPE=s  -P --name slave3 -h slave3.mycorp.kom yiwei1012/hadoop-hsa-dn:1.2
