GCS_BUCKET="[add your bucket name here]"

if [ -e /var/reboot_ctrl.txt ]
then
    echo "No reboot necessary" >> /var/reboot_ctrl.txt
else
    echo "Reboot necessary" > /var/reboot_ctrl.txt
    cp -r /usr/lib/hadoop/lib/gcs-*.jar /usr/lib/druid/hadoop-dependencies/hadoop-client/2.9.2
    cp -r /usr/lib/druid/extensions/druid-google-extensions /usr/lib/hadoop/lib
    echo 'export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:/usr/lib/hadoop/lib/gcs-connector.jar' >> /usr/lib/hadoop/etc/hadoop/hadoop-env.sh
    sed -i 's+druid.indexer.task.hadoopWorkingPath=var/druid/hadoop-tmp+druid.indexer.task.hadoopWorkingPath=/hadoop/tmp+g' /usr/lib/druid/conf/druid/middleManager/runtime.properties
    

    #GCS Connector to druid
    cp -r /usr/lib/hadoop/lib/gcs-*.jar /usr/lib/druid/lib/
    cp -r /usr/lib/hadoop/lib/gcs-*.jar /usr/lib/druid/extensions/druid-hdfs-storage/

    # Google Cloud Storage - Deep Storage
    sed -i "s+druid.storage.type=hdfs+#druid.storage.type=hdfs+g" /usr/lib/druid/conf/druid/_common/common.runtime.properties
    sed -i "s+druid.storage.storageDirectory=/druid/segments+#druid.storage.storageDirectory=/druid/segments+g" /usr/lib/druid/conf/druid/_common/common.runtime.properties
    echo "druid.storage.type=google" >> /usr/lib/druid/conf/druid/_common/common.runtime.properties
    echo "druid.google.bucket=${GCS_BUCKET}" >> /usr/lib/druid/conf/druid/_common/common.runtime.properties
    echo "druid.google.prefix=druid/deep-storage" >> /usr/lib/druid/conf/druid/_common/common.runtime.properties

    # Google Cloud Storage - Indexing Logs
    sed -i "s+druid.indexer.logs.type=hdfs+#druid.indexer.logs.type=hdfs+g" /usr/lib/druid/conf/druid/_common/common.runtime.properties
    sed -i "s+druid.indexer.logs.directory=/druid/indexing-logs+#druid.indexer.logs.directory=/druid/indexing-logs+g" /usr/lib/druid/conf/druid/_common/common.runtime.properties
    echo "druid.indexer.logs.type=google" >> /usr/lib/druid/conf/druid/_common/common.runtime.properties
    echo "druid.indexer.logs.bucket=${GCS_BUCKET}" >> /usr/lib/druid/conf/druid/_common/common.runtime.properties
    echo "druid.indexer.logs.prefix=druid/indexing-logs" >> /usr/lib/druid/conf/druid/_common/common.runtime.properties    
    
    sed -i 's+"druid-hdfs-storage"+"druid-google-extensions"+g' /usr/lib/druid/conf/druid/_common/common.runtime.properties

    shutdown -r +1
fi