# Druid Dataproc

### This project intents to create an easy way to work with Druid using Google Dataproc


## Preparations

### First of all we need to create/get some information from your GCP cluster:

- Project ID;
- Choose a region for your bucket/cluster;
- Create a Google Cloud Storage bucket and get its name;
- In your Google cloud shell, clone this project.


## Set initialization-actions script

### In the dataproc_druid_init_script.sh script you will need to set the variable:

Replace your Google Cloud Storage bucket name:

    GCS_BUCKET="[add your bucket name here]"


## Set firewall rules

### The set_firewall_rules.sh script will open for inbound inbound traffic some ports of the machines with "druid" tag. Actually it opens TCP ports:
- 8081;
- 8082;
- 8088;
- 8090;
- 8200;
- 8042;
- 8200;

Replace your project id on the variable below:

    PROJECT_ID="[set your project id here]"

## Set dataproc cluster creation script

### In the init_dataproc_druid.sh script you will need to set the variables:

Again, replace your Google Cloud Storage bucket name:

    GCS_BUCKET="[set your bucket name here]"


Replace your project id on the variable below:

    PROJECT_ID="[set your project name here]"


Replace the region wher your cluster will be created. I sugest that your bucket should be in the same region.

    GCP_REGION="[set the region where your cluster will be created]"


Replace the name that you want for your cluster:

    DATAPROC_CLUSTER_NAME="[set the name for your cluster]"


You may also set the size of the master machine:


    --master-machine-type n1-standard-8 \
    --master-boot-disk-type pd-ssd \
    --master-boot-disk-size 150 \



And the worker/preemptive machines:


    --worker-machine-type n1-standard-8 \
    --worker-boot-disk-type pd-ssd \
    --worker-boot-disk-size 150 \



Another important setting is the number of workers:


    --num-workers 2 \



And the number of preemptive nodes:


    --num-preemptible-workers 5


## Starting up your cluster.

### After configure your scripts you may start up your cluster by executing the command:

    bash init_dataproc_druid.sh

### The firewal rules may be set by executing the command below. This command you will execute only once:
    
    bash set_firewall_rules.sh