DRUID_ADDRESS=[Dataproc Master/Druid IP]

curl -X POST \
  http://${DRUID_ADDRESS}:8090/druid/indexer/v1/task \
  -H 'Content-Type: application/json' \
  -d '  {
     "type" : "index_hadoop",
     "spec" : {
         "dataSchema" : {
        		"dataSource" : "base_dataset",
        		"parser" : {
        		  "type" : "hadoopyString",
        		  "parseSpec" : {
        		    "format" : "csv",
        		    "columns" : ["oper_ts","nome","cpf","email","idade_cliente","cidade","cep","numero_endereco","regiao","credito","risco_serasa","tipo_de_pessoa","marca","modelo","valor_venda","comissao"],
        		    "dimensionsSpec" : {
        		      "dimensions" : ["oper_ts","nome","cpf","email","idade_cliente","cidade","cep","numero_endereco","regiao","credito","risco_serasa","tipo_de_pessoa","marca","modelo",
        		        { "name": "valor_venda", "type": "long" },
        		        { "name": "comissao", "type": "long" }
        		      ]
        		    },
        		    "timestampSpec": {
        		      "column": "oper_ts",
        		      "format": "iso"
        		    }
        		  }
        		},
        		"metricsSpec" : [
        		    {
        		        "name" : "count",
        		        "type" : "count"
        		    },
        		    { 
        		        "type" : "longSum", 
        		        "name" : "valor_venda_total", 
        		        "fieldName" : "valor_venda" 
        		    },
        		    { 
        		        "type" : "longSum", 
        		        "name" : "comissao_total", 
        		        "fieldName" : "comissao" 
        		    }
        		],
             "granularitySpec" : {
                 "type": "uniform",
                 "segmentGranularity": "MONTH",
                 "queryGranularity": {
                     "type": "none"
                 },
                 "rollup": false,
                 "intervals": null
             }
         },
         "ioConfig" : {
             "type" : "hadoop",
             "inputSpec" : {
                 "type" : "static",
                 "paths" : "gs://your-cloud-storage-bucket/dados/*.csv"
             }
         },
        "appendToExisting" : true,
         "tuningConfig" : {
             "type" : "hadoop",
             "partitionsSpec" : {
                 "type" : "hashed",
                 "targetPartitionSize" : 5000000
             },
             "forceExtendableShardSpecs" : true,
             "jobProperties" : {
                 "mapreduce.job.classloader": "true",
                 "mapreduce.job.user.classpath.first": "true",
                 "mapreduce.map.java.opts":"-Duser.timezone=UTC -Dfile.encoding=UTF-8", 
                 "mapreduce.reduce.java.opts":"-Duser.timezone=UTC -Dfile.encoding=UTF-8",
        		 "mapreduce.map.memory.mb" : "4000",
        		 "mapreduce.map.cpu.vcores" : "4",
        		 "mapreduce.reduce.memory.mb" : "9000",
        		 "mapreduce.reduce.cpu.vcores" : "4",
        		 "mapreduce.input.fileinputformat.split.minsize" : "1258291",
        		 "mapreduce.input.fileinputformat.split.maxsize" : "268435456"                 
             }
         }
     },
	"hadoopDependencyCoordinates": ["org.apache.hadoop:hadoop-client:2.9.2"]
 }'