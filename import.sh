#!/bin/bash
### Please edit grafana_* variables to match your Grafana setup:
grafana_host="http://localhost:3000"
grafana_cred="admin:admin"
grafana_datasource="influxdb"
ds=(928);
for d in "${ds[@]}"; do
  echo -n "Processing $d: "
  j=$(curl -s -k -u "$grafana_cred" $grafana_host/api/gnet/dashboards/$d | jq .json)
  curl -s -k -u "$grafana_cred" -XPOST -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    -d "{\"dashboard\":$j,\"overwrite\":true, \
        \"inputs\":[{\"name\":\"DS_INFLUXDB_TELEGRAF\",\"type\":\"datasource\", \
        \"pluginId\":\"influxdb\",\"value\":\"$grafana_datasource\"}]}" \
    $grafana_host/api/dashboards/import; echo ""
done
