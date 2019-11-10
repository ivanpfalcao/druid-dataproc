DRUID_ADDRESS=[Dataproc Master/Druid IP]

curl -X POST \
  http://${DRUID_ADDRESS}:8082/druid/v2/sql \
  -H 'Content-Type: application/json' \
  -d '{"query":"SELECT count(*) FROM base_dataset"}'