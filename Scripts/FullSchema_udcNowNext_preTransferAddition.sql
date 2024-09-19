
;DROP DATABASE IF EXISTS devdb
;CREATE DATABASE devdb /*!40100 DEFAULT CHARACTER SET utf8 */;
use devdb;

-- TOOLS LIB --
@include devTools_lib.sql

-- mav_mw_db_rc.activity_type_dict definition

CREATE TABLE `activity_type_dict` (
  `cid` char(1) NOT NULL,
  `tag` varchar(32) NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `activity_type_dict_tag_unique` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- mav_mw_db_rc.activity definition

CREATE TABLE `run_state_enum` (
  `value` int NOT NULL,
  `name` varchar(45) default NULL,
  `desc` varchar(255) default NULL,
  PRIMARY KEY (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- mav_mw_db_rc.activity definition

CREATE TABLE `activity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type_cid` char(1) NOT NULL,
  `tag` varchar(32) not null COMMENT 'mdr independent. acts as external token in API',
  `run_state_enum` int NOT NULL,
  `error_code` int NOT NULL DEFAULT '0',
  `accept_dt` varchar(32) DEFAULT NULL,
  `start_dt` varchar(32) DEFAULT NULL,
  `end_dt` varchar(32) DEFAULT NULL,
  `expire_dt` varchar(32) DEFAULT NULL,
  `scheduled_order` bigint unsigned NOT null COMMENT 'defaults to activity\'s id. may be changed',
  PRIMARY KEY (`id`),
  CONSTRAINT `activity_type_cid_fk` FOREIGN KEY (`type_cid`) REFERENCES `activity_type_dict` (`cid`) ON DELETE RESTRICT ON UPDATE cascade,
  CONSTRAINT `activity_run_state_enum_fk` FOREIGN KEY (`run_state_enum`) REFERENCES `run_state_enum` (`value`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- mav_mw_db_rc.agv definition

CREATE TABLE `agv` (
  `cid` char(1) NOT NULL,
  `tag` varchar(32) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `agv_tag_unique` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- mav_mw_db_rc.repository_type_dict definition

CREATE TABLE `repository_type_dict` (
  `cid` char(1) NOT NULL,
  `tag` varchar(32) NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `repository_type_dict_unique` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- mav_mw_db_rc.udc definition

CREATE TABLE `udc` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(100) NOT NULL,
  `jdata` varchar(255) default null COMMENT 'dynamic field used by the app to persist custom info',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udc_tag_unique` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- mav_mw_db_rc.repository definition

CREATE TABLE `repository` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(32) NOT NULL,
  `type_cid` char(1) NOT NULL,
  `udc_now_id` bigint unsigned DEFAULT NULL,
  `udc_next_id` bigint unsigned DEFAULT NULL,
  #`flags` binary(1) NOT NULL DEFAULT '0' COMMENT 'from least significant bit:\r\nIsOutOfFLow | \r\nIsOutOfFlow: ignored by automatic store control flow. manual set/unset only (not from automatic flow)',
  #`is_disabled` binary(1) NOT NULL DEFAULT '0' COMMENT  'first bit: true/false\r\nother bits: who can alter this value\r\nx|x|x|x| api | auto | value',
  #`is_uncertain` binary(1) NOT NULL DEFAULT '0' COMMENT 'first bit: true/false\r\nother bits: who can alter this value\r\nx|x|x|x| api | auto | value',
  `is_disabled` boolean NOT NULL DEFAULT false, #COMMENT  'first bit: true/false\r\nother bits: who can alter this value\r\nx|x|x|x| api | auto | value',
  `is_uncertain` boolean NOT NULL DEFAULT false, 
  PRIMARY KEY (`id`),
  UNIQUE KEY `repository_tag_idx` (`tag`),
  UNIQUE KEY `repository_udc_now_idx` (`udc_now_id`),
  UNIQUE KEY `repository_udc_next_id_idx` (`udc_next_id`) USING BTREE,
  #KEY `repository_repository_type_dict_fk` (`type_cid`),
  CONSTRAINT `repository_repository_type_dict_fk` FOREIGN KEY (`type_cid`) REFERENCES `repository_type_dict` (`cid`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `repository_udc_now_fk` FOREIGN KEY (`udc_now_id`) REFERENCES `udc` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `repository_udc_next_fk` FOREIGN KEY (`udc_next_id`) REFERENCES `udc` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- mav_mw_db_rc.activity_uses_fleettag definition

CREATE TABLE `activity_uses_fleettag` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `activity_id` bigint unsigned NOT NULL,
  `fleettag` bigint unsigned NOT NULL,
  PRIMARY KEY (`activity_id`,`fleettag`),
  UNIQUE KEY `activity_uses_fleettag_id_idx` (`id`),
  UNIQUE KEY `activity_uses_fleettag_fleettag_idx` (`fleettag`),
  CONSTRAINT `activity_uses_fleettag_activity_fk` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
  #,CONSTRAINT `activity_uses_fleettag_fleettag_fk` FOREIGN KEY (`fleettag`) REFERENCES `fleettag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- mav_mw_db_rc.activity_uses_udc definition

CREATE TABLE `activity_uses_udc` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `activity_id` bigint unsigned NOT NULL,
  `udc_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`activity_id`,`udc_id`),
  UNIQUE KEY `activity_uses_udc_id_idx` (`id`),
  CONSTRAINT `activity_uses_udc_activity_fk` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `activity_uses_udc_udc_fk` FOREIGN KEY (`udc_id`) REFERENCES `udc` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- mav_mw_db_rc.activity_uses_agv definition

CREATE TABLE `activity_uses_agv` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `activity_id` bigint unsigned NOT NULL,
  `agv_cid` char(1) NOT NULL,
  PRIMARY KEY (`activity_id`,`agv_cid`),
  UNIQUE KEY `activity_uses_agv_id_idx` (`id`),
  CONSTRAINT `activity_uses_agv_activity_fk` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `activity_uses_agv_agv_fk` FOREIGN KEY (`agv_cid`) REFERENCES `agv` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- mav_mw_db_rc.activity_uses_repository definition

CREATE TABLE `activity_uses_repository` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `activity_id` bigint unsigned NOT NULL,
  `repository_id` int unsigned NOT NULL,
  PRIMARY KEY (`activity_id`,`repository_id`),
  UNIQUE KEY `activity_uses_repository_id_idx` (`id`),
  CONSTRAINT `activity_uses_repository_activity_fk` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `activity_uses_repository_repository_fk` FOREIGN KEY (`repository_id`) REFERENCES `repository` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- mav_mw_db_rc.activity_uses_agv definition
-- 
-- CREATE TABLE `repository_hasmany_udcnext` (
--   `id` bigint unsigned NOT NULL AUTO_INCREMENT,
--   `repository_id` bigint unsigned NOT NULL,
--   `udc_id` char(1) NOT NULL,
--   PRIMARY KEY (`repository_id`,`udc_id`),
--   UNIQUE KEY `repository_hasmany_udcnext_id_idx` (`id`),
--   CONSTRAINT `repository_hasmany_udcnext_repository_fk` FOREIGN KEY (`repository_id`) REFERENCES `repository` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
--   CONSTRAINT `repository_hasmany_udcnext_udc_fk` FOREIGN KEY (`udc_id`) REFERENCES `udc` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8
-- COMMENT "v2 introduced concurrent transitions from shelf to outbays";
-- 







-- mav_mw_db_rc.activity_hasunique_clienttag definition

CREATE TABLE `activity_hasunique_clienttag` (
  `activity_id` bigint unsigned NOT NULL,
  `clienttag`  varchar(32) NOT NULL,
  PRIMARY KEY (`activity_id`),
  UNIQUE KEY `activity_hasunique_clienttag_clienttag_idx` (`clienttag`),
  CONSTRAINT `activity_has_clienttag_activity_fk` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- mav_mw_db_rc.activity_has_unique_fleettag definition

CREATE TABLE `activity_hasunique_fleettag` (
  `activity_id` bigint unsigned NOT NULL,
  `fleettag`  varchar(32) NOT NULL,
  PRIMARY KEY (`activity_id`),
  UNIQUE KEY `activity_hasunique_fleettag_fleettag_idx` (`fleettag`),
  CONSTRAINT `activity_hasunique_fleettag_activity_fk` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8
COMMENT="the fleet provides unique tags relative to its runtime. A tag is removed from here as soon as it's no more available in the fleet service";

-- mav_mw_db_rc.activity_has_fleettag definition
-- 
-- CREATE TABLE `activity_has_fleettag` (
--   `id` bigint unsigned NOT NULL AUTO_INCREMENT,
--   `activity_id` bigint unsigned NOT NULL,
--   `fleettag`  varchar(32) NOT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `activity_has_fleettag_activity_id_idx` (`activity_id`),
--   KEY `activity_has_fleettag_tag_idx` (`fleettag`),
--   CONSTRAINT `activity_has_fleettag_activity_fk` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8
-- COMMENT="fleet-provided tags related to archived activities. A tag is persisted here after activity has been completed, therefore it may be not unique";
-- 


@include StaticInitialData.sql