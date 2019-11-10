PROJECT_ID="[set your project id here]"

gcloud config set project "$PROJECT_ID"

gcloud compute --project=$PROJECT_ID firewall-rules create druid-ingress --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:8081,tcp:8082,tcp:8088,tcp:8090,tcp:8200 --source-ranges=0.0.0.0/0 --target-tags=druid
gcloud compute --project=$PROJECT_ID firewall-rules create druid-yarn-ingress --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:8042,tcp:8200 --source-ranges=0.0.0.0/0 --target-tags=druid