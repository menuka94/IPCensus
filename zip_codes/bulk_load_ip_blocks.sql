DROP TABLE IF EXISTS `ip_blocks`;
CREATE          TABLE  `ip_blocks` (
  `start_ip`      int(10)  unsigned NOT NULL,
  `end_ip`        int(10)  unsigned NOT NULL,
  `location_id`   int(11)           NOT NULL,
  `start_ip_8`    TINYINT  unsigned NOT NULL,
  `end_ip_8`      TINYINT  unsigned NOT NULL,
  `start_ip_12`   SMALLINT unsigned NOT NULL,
  `end_ip_12`     SMALLINT unsigned NOT NULL,
  INDEX       start_ip_8  (start_ip_8, start_ip_12, start_ip, end_ip),
  INDEX       start_ip_12 (start_ip_12, start_ip, end_ip),
  PRIMARY KEY  (`start_ip`,`end_ip`, location_id)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 PACK_KEYS=1
;

TRUNCATE TABLE ip_blocks;
ALTER TABLE ip_blocks DISABLE KEYS;
LOAD DATA INFILE '/Users/flip/ics/projects/IPCensus/geoip_ripd/GeoLiteCity-Blocks.csv' 
   INTO TABLE ip_blocks
   FIELDS TERMINATED BY "," ENCLOSED BY '"'
   IGNORE 2 LINES
   (start_ip, end_ip, location_id)
   SET
     start_ip_8  = start_ip >> 24,
     end_ip_8    = end_ip   >> 24,
     start_ip_12 = start_ip >> 20,
     end_ip_12   = end_ip   >> 20
;
SELECT COUNT(*), NOW(), 'ip_blocks', 'done load, enabling indexes' FROM ip_blocks ;
ALTER TABLE ip_blocks ENABLE KEYS;
SELECT COUNT(*), NOW(), 'ip_blocks', 'done import' FROM ip_blocks ;
OPTIMIZE TABLE ip_blocks;

