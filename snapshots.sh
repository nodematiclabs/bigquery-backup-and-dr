bq query --use_legacy_sql=false --display_name="Monthly snapshots of the TABLE table" \
--location="us" --schedule="1 of month 05:00" \
--project_id=PROJECT \
'DECLARE snapshot_name STRING;
DECLARE expiration TIMESTAMP;
DECLARE query STRING;
SET expiration = DATE_ADD(@run_time, INTERVAL 40 DAY);
SET snapshot_name = CONCAT("BACKUP.TABLE_",
  FORMAT_DATETIME("%Y%m%d", @run_date));
SET query = CONCAT("CREATE SNAPSHOT TABLE ", snapshot_name,
  " CLONE PROJECT.DATASET.TABLE OPTIONS(expiration_timestamp=TIMESTAMP \"",
  expiration, "\");");
EXECUTE IMMEDIATE query;'