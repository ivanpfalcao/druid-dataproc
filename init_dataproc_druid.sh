BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

GCS_BUCKET="[set your bucket name here]"
PROJECT_ID="[set your project name here]"
GCP_REGION="[set the region where your cluster will be created]"
DATAPROC_CLUSTER_NAME="[set the name for your cluster]"

gcloud config set project "$PROJECT_ID"

gsutil cp ${BASEDIR}/dataproc_druid_init_script.sh gs://${GCS_BUCKET}/init_scripts/dataproc_druid_init_script.sh

gcloud beta dataproc clusters create \
    $DATAPROC_CLUSTER_NAME \
    --project $PROJECT_ID \
    --bucket $GCS_BUCKET \
    --region $GCP_REGION \
    --properties dataproc:dataproc.conscrypt.provider.enable=false \
    --enable-component-gateway \
    --metadata "enable-oslogin=TRUE"\
    --scopes 'https://www.googleapis.com/auth/cloud-platform' \
    --zone "" \
    --optional-components=DRUID,ZOOKEEPER \
    --image-version 1.3-deb9 \
    --tags druid \
    --master-machine-type n1-standard-8 \
    --master-boot-disk-type pd-ssd \
    --master-boot-disk-size 150 \
    --num-workers 2 \
    --worker-machine-type n1-standard-8 \
    --worker-boot-disk-type pd-ssd \
    --worker-boot-disk-size 150 \
    --initialization-actions "gs://${GCS_BUCKET}/init_scripts/dataproc_druid_init_script.sh" \
    --num-preemptible-workers 5
#    --max-idle 9000
	
#Druid portal
#http://35.231.240.9:8081

#Druid indexer
#http://35.231.240.9:8090

#Druid Status
#curl -s 35.231.240.9:8082/status
