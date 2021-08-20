mv nyc-rolling-sales.csv nyc_edited.csv
sed 's/,[ -]*,/,,/g' nyc_edited.csv > nyc-rolling-sales.csv

sudo hive -f hive_ny_realestate_queries.sql

hdfs dfs -rm -r realestate/results
pig -x -useHCatalog mapreduce pig_ny_realestate_analysis.pig

rm -r results
hdfs dfs -copyToLocal realestate/results results



