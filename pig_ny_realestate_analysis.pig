realestate = LOAD 'ny_realestate.realestate_data' using org.apache.hive.hcatalog.pig.HCatLoader();

realestateByType = GROUP realestate by building_class_at_time_of_sale;
typeAveragesUnordered = FOREACH realestateByType GENERATE group as building_type, AVG(realestate.sale_price) as avg_sale;
typeAverages = ORDER typeAveragesUnordered by avg_sale DESC;

STORE typeAverages INTO 'realestate/results/avg_sale_by_buildingtype' using PigStorage (',');

realestateByBorough = GROUP realestate by borough;
boroughAveragesUnordered = FOREACH realestateByBorough {
							total_price = SUM(realestate.sale_price);
							total_sqft = SUM(realestate.gross_square_feet);
							GENERATE group as borough,(float)(total_price/total_sqft) as avg_pricePerSqFoot;
							}
boroughAverages = ORDER boroughAveragesUnordered by avg_pricePerSqFoot DESC;

STORE boroughAverages INTO 'realestate/results/avg_price_per_squarefoot_by_borough' using PigStorage (',');