realestate = LOAD 'ny_realestate.realestate_data' using org.apache.hive.hcatalog.pig.HCatLoader();

realestateByType = GROUP realestate by building_class_at_time_of_sale;
typeAveragesUnordered = FOREACH realestateByType GENERATE group as building_type, AVG(realestate.sale_price) as avg_sale;
typeAverages = ORDER typeAveragesUnordered by avg_sale DESC;

STORE typeAverages INTO 'realestate/results/avg_sale_by_buildingtype' using PigStorage (',');

realestateAveragePPF = FOREACH realestate GENERATE realestate.burough as burough, (float)realestate.sale_price/realestate.gross_square_feet as pricePerFoot;

realestateByBorough = GROUP realestateAveragePPF by borough;

boroughAveragesUnordered = FOREACH realestateByBorough GENERATE group as borough, AVG(realestateAveragePPF.pricePerFoot) as avg_pricePerSqFoot;
boroughAverages = ORDER boroughAveragesUnordered by avg_pricePerSqFoot DESC;

STORE boroughAverages INTO 'realestate/results/avg_price_per_squarefoot_by_borough' using PigStorage (',');