mv nyc-rolling-sales.csv nyc_edit.csv
rm nyc-rolling-sales.csv
sed 's/,[[:blank:]]*-[[:blank:]]*,/,,/g' nyc_edit.csv > nyc-rolling-sales.csv
rm nyc_edit.csv


rm nyc_edited.csv

sudo hive -f hive_ny_realestate_queries.sql

hdfs dfs -rm -r realestate/results
pig -x -useHCatalog mapreduce pig_ny_realestate_analysis.pig

rm -r results
hdfs dfs -copyToLocal realestate/results results



