# Curl druid

### You can locate the Druid IP by finding the Dataproc Master machine external IP.

    DRUID_ADDRESS=[Dataproc Master/Druid IP]


### Here are some examples of operations:

- <code>index-csv-cube.sh</code>: Indexes a CSV file loaded from Google Cloud Storage using a Hadoop Mapreduce job to do it. You can check the progress by YARN;
- <code>index-json-cube.sh</code>: Indexes a JSON file loaded from Google Cloud Storage using a Hadoop Mapreduce job to do it. You can check the progress by YARN;
- <code>run-query.sh</code>: It runs an SQL query based on your dataset;