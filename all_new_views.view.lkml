


view: dmc_period_cre_dt_pipeline {
  dimension: accqtr_desc { 
    view_label: "Case Information"
    group_label: "Created Date (TZ)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Created TZ Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc { 
    view_label: "Case Information"
    group_label: "Created Date (TZ)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Created TZ Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Case Information"
    group_label: "Created Date (TZ)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Created TZ Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Case Information"
    group_label: "Created Date (TZ)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Created TZ Calendar Quarter (YYYY/QQ)"
  }

 }



view: dmc_period_cur_dt_pipeline {
  dimension: accqtr_desc { 
    view_label: "Pipeline Monitor"
    group_label: "Current Time (TZ)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Current TZ Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc { 
    view_label: "Pipeline Monitor"
    group_label: "Current Time (TZ)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Current TZ Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Pipeline Monitor"
    group_label: "Current Time (TZ)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Current TZ Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Pipeline Monitor"
    group_label: "Current Time (TZ)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Current TZ Calendar Quarter (YYYY/QQ)"
  }

 }



view: dmc_crm_bh_hol_pl {
  dimension: bh_oneforce_id { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Holiday and Business Hours"
    group_item_label: "Oneforce Business Hour ID"
    label: "Oneforce Business Hour ID"
    sql: ${TABLE}.BH_ONEForce_Id  ;;
  }

  dimension: day_et { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Holiday and Business Hours"
    group_item_label: "End time"
    label: "End time"
    sql: ${TABLE}.DAY_ET ;;
  }

  dimension: day_st { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Holiday and Business Hours"
    group_item_label: "Start Time"
    label: "Start Time"
    sql: ${TABLE}.DAY_ST ;;
  }

  dimension: hol_flg { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Holiday and Business Hours"
    group_item_label: "Is Holiday? (Yes / No)"
    label: "Is Holiday? (Yes / No)"
    sql: ${TABLE}.HOL_FLG  ;;
  }

  dimension: hol_nm { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Holiday and Business Hours"
    group_item_label: "Holiday Name"
    label: "Holiday Name"
    sql: ${TABLE}.HOL_NM  ;;
  }

  dimension: office { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Holiday and Business Hours"
    group_item_label: "Office"
    label: "Office"
    sql: ${TABLE}.OFFICE  ;;
  }

  dimension: time_zone_sid_key { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Holiday and Business Hours"
    group_item_label: "Time zone Key"
    label: "Time zone Key"
    sql: ${TABLE}.TimeZoneSidKey  ;;
  }

  dimension: weekday { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Holiday and Business Hours"
    group_item_label: "Weekday"
    label: "Weekday"
    sql: ${TABLE}.WEEKDAY  ;;
  }

  
  dimension_group: bse_dt { 
    hidden: FALSE
    view_label: "Holiday and Business Hours"
    group_label: "Based Date"
    group_item_label: "@{time_frames}"
    label: "Based UTC"
    type: time
    timeframes: 
	[raw,
	time,
	hour_of_day,
	date,
	day_of_week,
	week_of_year,
	month_num,
	quarter_of_year,
	fiscal_quarter_of_year,
	year,
	fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.BSE_DT ;;
  }

 }



view: dmc_period_ed_dt_pipeline {
  dimension: accqtr_desc { 
    view_label: "Pipeline Monitor"
    group_label: "End Time of Checking Period (TZ)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "End Time of Checking Period TZ Fiscal Quarter (YYYY/QQ)"
    sql: DATETIME_SUB(${end_checking_period_raw}, INTERVAL {{checking_period._parameter_value}} MINUTE)  ;;
  }

  dimension: iso_yrwk_desc { 
    view_label: "Pipeline Monitor"
    group_label: "End Time of Checking Period (TZ)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "End Time of Checking Period TZ Week of Year (YYYY/WW)"
    sql: DATETIME_SUB(${end_checking_period_raw}, INTERVAL {{checking_period._parameter_value}} MINUTE)  ;;
  }

  dimension: yrmon_desc { 
    view_label: "Pipeline Monitor"
    group_label: "End Time of Checking Period (TZ)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "End Time of Checking Period TZ Month (YYYY/MM)"
    sql: DATETIME_SUB(${end_checking_period_raw}, INTERVAL {{checking_period._parameter_value}} MINUTE)  ;;
  }

  dimension: yrqtr_desc { 
    view_label: "Pipeline Monitor"
    group_label: "End Time of Checking Period (TZ)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "End Time of Checking Period TZ Calendar Quarter (YYYY/QQ)"
    sql: DATETIME_SUB(${end_checking_period_raw}, INTERVAL {{checking_period._parameter_value}} MINUTE)  ;;
  }

 }



view: dmo_case_v_pipeline {
  dimension:  { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Case Information"
    group_item_label: "Contact Email"
    label: "Contact Email"
    sql: ${TABLE}.CNTC_EML ;;
  }

  dimension: bus_hrs_id { 
    primary_key: FALSE
    hidden: TRUE
    view_label: "Case Information"
    group_item_label: "Business Hours ID"
    label: "Business Hours ID"
    sql: ${TABLE}.BUS_HRS_ID ;;
  }

  dimension: case_drop_dynamic { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Special"
    group_item_label: "Case Drop Dynamic"
    label: "Case Drop Dynamic"
    sql: CASE WHEN "{% parameter case_drop_param %}" = "RHQ" THEN ${Regional_Head_Office}
  WHEN "{% parameter case_drop_param %}" = "Country" THEN ${country}
  WHEN "{% parameter case_drop_param %}" = "Office" THEN ${office}
  WHEN "{% parameter case_drop_param %}" = "Channel" THEN ${origin}
  WHEN "{% parameter case_drop_param %}" = "Queue" THEN ${of_queue.developer_name_pipeline}
  ELSE "Global" END ;;
  }

  dimension: clst_cnt { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Case Information"
    group_item_label: "Cluster Country"
    label: "Cluster Country"
    sql: CASE WHEN ${country2} IN ('AT' , 'HU') THEN "AT & HU"
  WHEN ${country2} IN ('CZ' , 'SK') THEN "CZ & SK"
  WHEN ${country2} IN ('SE' , 'NO') THEN "SE & NO"
  ELSE ${service_office_hierarchy.sub_country_code} END ;;
  }

  dimension: cre_dt_dynamic { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Case Information"
    group_item_label: "Open Date Dynamic"
    label: "Open Date Dynamic"
    sql: CASE
    WHEN {% parameter timeframe_picker %} = 'Day' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${createddate_raw}),'{{_query._query_timezone}}'),DAY)
    WHEN {% parameter timeframe_picker %} = 'Week' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${createddate_raw}),'{{_query._query_timezone}}'), WEEK(MONDAY))
    WHEN {% parameter timeframe_picker %} = 'Month' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${createddate_raw}),'{{_query._query_timezone}}'),MONTH)
    WHEN {% parameter timeframe_picker %} = 'Quarter' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${createddate_raw}),'{{_query._query_timezone}}'),QUARTER)
    WHEN {% parameter timeframe_picker %} = 'Year' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${createddate_raw}),'{{_query._query_timezone}}'),YEAR)
    ELSE NULL
    END  ;;
  }

  dimension: cs_no { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Case Information"
    group_item_label: "Case Number "
    label: "Case Number"
    sql: ${TABLE}.CS_NO ;;
  }

  dimension: cs_ofc_cd { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Case Information"
    group_item_label: "Office Code"
    label: "Office Code"
    sql: (CASE
      WHEN service_office_hierarchy.office_code is not Null THEN service_office_hierarchy.office_code
      ELSE  user_office_hierarchy.office_code
    END)  ;;
  }

  dimension: cs_ori { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Case Information"
    group_item_label: "Channel"
    label: "Channel"
    sql: CASE WHEN ${leave_a_message_cases.is_first_chat_leave_a_message} = "true" THEN "Chat"
  ELSE ${TABLE}.CS_ORI END   ;;
  }

  dimension: cs_own_id { 
    primary_key: FALSE
    hidden: TRUE
    view_label: "Case Information"
    group_item_label: "Owner ID"
    label: "Owner ID"
    sql: ${TABLE}.CS_OWN_ID ;;
  }

  dimension: cs_prio { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Case Information"
    group_item_label: "Priority"
    label: "Priority"
    sql: ${TABLE}.CS_PRIO ;;
  }

  dimension: cs_stt { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Case Information"
    group_item_label: "Status"
    label: "Status"
    sql: ${TABLE}.CS_STT ;;
  }

  dimension: in_checking_period { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Pipeline Monitor"
    group_item_label: "Is Created in Checking Period (Yes/No)"
    label: "Is Created in Checking Period"
    sql: CASE WHEN ${createddate_raw} >= ${start_checking_period_raw} THEN "Yes" ELSE "No" END ;;
  }

  dimension: indv_cnt { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Case Information"
    group_item_label: "Individual Country"
    label: "Individual Country"
    sql: ONEFORCE.individual_country_mapping(${country2}) ;;
  }

  dimension: is_wk_time { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Pipeline Monitor"
    group_item_label: "Is Working time? (Yes/No)"
    label: "Is Working time?"
    sql: CASE WHEN FORMAT_TIME("%X", ${of_biz_hrs_hol.day_st}) = FORMAT_TIME("%X", ${of_biz_hrs_hol.day_et}) THEN "No"
  WHEN (FORMAT_DATETIME("%X",DATETIME(${last_hour_start})) >= FORMAT_TIME("%X", ${of_biz_hrs_hol.day_st}) AND FORMAT_DATETIME("%X",DATETIME(${last_hour_start})) <= FORMAT_TIME("%X", ${of_biz_hrs_hol.day_et})
  AND FORMAT_DATETIME("%X",DATETIME(${last_hour_end})) >= FORMAT_TIME("%X", ${of_biz_hrs_hol.day_st}) AND FORMAT_DATETIME("%X",DATETIME(${last_hour_end})) <= FORMAT_TIME("%X", ${of_biz_hrs_hol.day_et})) THEN "Yes"
  WHEN (FORMAT_DATETIME("%X",DATETIME(${last_hour_end})) >= FORMAT_TIME("%X", ${of_biz_hrs_hol.day_st}) and FORMAT_DATETIME("%X",DATETIME(${last_hour_end})) <= FORMAT_TIME("%X", ${of_biz_hrs_hol.day_et})
  AND FORMAT_DATETIME("%X",DATETIME(${last_hour_start})) < FORMAT_TIME("%X", ${of_biz_hrs_hol.day_st})) THEN "Yes"
  WHEN (FORMAT_DATETIME("%X",DATETIME(${last_hour_start})) >= FORMAT_TIME("%X", ${of_biz_hrs_hol.day_st}) and FORMAT_DATETIME("%X",DATETIME(${last_hour_start})) <= FORMAT_TIME("%X", ${of_biz_hrs_hol.day_et})
  AND FORMAT_DATETIME("%X",DATETIME(${last_hour_end})) > FORMAT_TIME("%X", ${of_biz_hrs_hol.day_et})) THEN "Yes"
        ELSE "No" END  ;;
  }

  dimension: last_hour_end { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Pipeline Monitor"
    group_item_label: "Last Hour End Time"
    label: "Last Hour End Time"
    sql: TIMESTAMP(TIMESTAMP_TRUNC(CURRENT_DATETIME(COALESCE(${of_biz_hrs_hol.time_zone_sid_key},"UTC")), MINUTE))  ;;
  }

  dimension: last_hour_start { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Pipeline Monitor"
    group_item_label: "Last Hour Start Time"
    label: "Last Hour Start Time"
    sql: TIMESTAMP(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_DATETIME(COALESCE(${of_biz_hrs_hol.time_zone_sid_key},"UTC")), MINUTE), INTERVAL -60 MINUTE))  ;;
  }

  dimension: office_code { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Case Information"
    group_item_label: "Service Office"
    label: "Service Office"
    sql: `ONEFORCE.offshore_ofc_cd_conv`(${TABLE}.Office)  ;;
  }

  dimension: rhq_cd_svc { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Case Information"
    group_item_label: "RHQ Code"
    label: "Regional Head Office"
    sql: coalesce(
    CASE WHEN ${case_regional_head_office} IS NOT NULL THEN ${case_regional_head_office} -- take regional head office from CASE table
  WHEN ${createddate_date} < DATE("2024-04-01") THEN ( -- if case created before 2024-04-01
  -- take value from previous Queue regional head office
  CASE WHEN ${queue_name_office_hierarchy.previous_regional_head_office} IS NOT NULL THEN substr(queue_name_office_hierarchy.previous_regional_head_office,-5)
  -- take value from previous Case Owner regional head office, except "Unclaimed - RHQ" & "SINHO"
  WHEN ${user_office_hierarchy.previous_regional_head_office} IS NOT NULL
  AND ${user_office_hierarchy.previous_regional_head_office} != "Unclaimed - RHQ"
  AND substr(${user_office_hierarchy.previous_regional_head_office}, -2) != "HO"  THEN substr(user_office_hierarchy.previous_regional_head_office, -5)
  -- if no value, return "Unclaimed"
  ELSE "Unclaimed" END)
  ELSE ( -- WHEN ${createddate_date} >= DATE("2024-04-01") will fall under ELSE clause
  -- take value from current Queue regional head office
  CASE WHEN ${queue_name_office_hierarchy.regional_head_office} IS NOT NULL THEN substr(queue_name_office_hierarchy.regional_head_office,-5)
  -- take value from current Case Owner regional head office, except "Unclaimed - RHQ" & "SINHO"
  WHEN ${user_office_hierarchy.regional_head_office} IS NOT NULL
  AND ${user_office_hierarchy.regional_head_office} != "Unclaimed - RHQ"
  AND substr(${user_office_hierarchy.regional_head_office}, -2) != "HO"  THEN substr(user_office_hierarchy.regional_head_office, -5)
  -- if no value, return "Unclaimed"
  ELSE "Unclaimed" END)
        END, "Unclaimed")  ;;
  }

  dimension: tp { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Case Information"
    group_item_label: "Type"
    label: "Type"
    sql: ${TABLE}.CS_TP ;;
  }

  
  dimension_group: cls_dt { 
    view_label: "Case Information"
    group_label: "Closed Date (TZ)"
    group_item_label: "@{time_frames}"
    label: "Closed TZ"
    type: time
    timeframes: 
	[raw,
	time,
	hour_of_day,
	date,
	day_of_week,
	week_of_year,
	month_num,
	quarter_of_year,
	fiscal_quarter_of_year,
	year,
	fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.CLS_DT ;;
  }

  dimension_group: cre_dt { 
    hidden: FALSE
    view_label: "Case Information"
    group_label: "Created Date (TZ)"
    group_item_label: "@{time_frames}"
    label: "Created TZ"
    type: time
    timeframes: 
	[raw,
	time,
	hour_of_day,
	date,
	day_of_week,
	week_of_year,
	month_num,
	quarter_of_year,
	fiscal_quarter_of_year,
	year,
	fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.CRE_DT ;;
  }

  dimension_group: cur_dt { 
    hidden: FALSE
    view_label: "Pipeline Monitor"
    group_label: "Current Time (TZ)"
    group_item_label: "@{time_frames}"
    label: "Current TZ"
    type: time
    timeframes: 
	[raw,
	time,
	hour_of_day,
	date,
	day_of_week,
	week_of_year,
	month_num,
	quarter_of_year,
	fiscal_quarter_of_year,
	year,
	fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: CURRENT_DATETIME(${of_biz_hrs_hol.time_zone_sid_key})  ;;
  }

  dimension_group: ed_chck_dt { 
    view_label: "Pipeline Monitor"
    group_label: "End Time of Checking Period (TZ)"
    group_item_label: "@{time_frames}"
    label: "End Time of Checking Period TZ"
    type: time
    timeframes: 
	[raw,
	time,
	hour_of_day,
	date,
	day_of_week,
	week_of_year,
	month_num,
	quarter_of_year,
	fiscal_quarter_of_year,
	year,
	fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: CURRENT_DATETIME()  ;;
  }

  dimension_group: rslv_dt { 
    view_label: "Case Information"
    group_label: "Resolved Date (TZ)"
    group_item_label: "@{time_frames}"
    label: "Resolved TZ"
    type: time
    timeframes: 
	[raw,
	time,
	hour_of_day,
	date,
	day_of_week,
	week_of_year,
	month_num,
	quarter_of_year,
	fiscal_quarter_of_year,
	year,
	fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.CS_RSLVD_DT_TM ;;
  }

  dimension_group: st_chck_dt { 
    view_label: "Pipeline Monitor"
    group_label: "Start Time of Checking Period (TZ)"
    group_item_label: "@{time_frames}"
    label: "Start Time of Checking Period TZ"
    type: time
    timeframes: 
	[raw,
	time,
	hour_of_day,
	date,
	day_of_week,
	week_of_year,
	month_num,
	quarter_of_year,
	fiscal_quarter_of_year,
	year,
	fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: DATETIME_SUB(${end_checking_period_raw}, INTERVAL {{checking_period._parameter_value}} MINUTE)  ;;
  }

  
  measure: count_checking_period { 
    hidden: FALSE
    view_label: "Measures"
    group_item_label: "Count of cases in checking period"
    label: "Count of cases in checking period"
    filters: {condition=Yes, field=of_pipeline.in_checking_period}
    sql: CASE WHEN ${createddate_raw} >= ${start_checking_period_raw} THEN 1 ELSE 0 END  ;;
  }

  measure: count_of_cases { 
    hidden: FALSE
    view_label: "Measures"
    group_item_label: "Count of cases"
    label: "Count of cases"
    sql: ${TABLE}.CS_NO ;;
  }

  measure: count_of_cases_last_120m, { 
    hidden: FALSE
    view_label: "Measures"
    group_item_label: "Count of cases in last 120m"
    label: "Count of cases in last 120m"
    filters: {field=of_pipeline.createddate_time, condition=120 minutes}
    sql: ${TABLE}.CS_NO ;;
  }

  measure: count_of_cases_last_24h { 
    hidden: FALSE
    view_label: "Measures"
    group_item_label: "Count of cases in last 24h"
    label: "Count of cases in last 24h"
    filters: {condition=1440 minutes, field=of_pipeline.createddate_time}
    sql: ${TABLE}.CS_NO ;;
  }

  measure: count_of_cases_last_60m { 
    hidden: FALSE
    view_label: "Measures"
    group_item_label: "Count of cases in last 60m"
    label: "Count of cases in last 60m"
    filters: {condition=60 minutes, field=of_pipeline.createddate_time}
    sql: ${TABLE}.CS_NO ;;
  }

  measure: count_of_cases_seconds_60m { 
    hidden: FALSE
    view_label: "Measures"
    group_item_label: "Count of cases in last second 60m"
    label: "Count of cases in last second 60m"
    sql: ${count_last_120m} - ${count_last_60m}   ;;
  }

  
  
 }



view: dmc_period_rslv_dt_pipeline {
  dimension: accqtr_desc { 
    view_label: "Case Information"
    group_label: "Resolved Date (TZ)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Resolved TZ Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc { 
    view_label: "Case Information"
    group_label: "Resolved Date (TZ)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Resolved TZ Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Case Information"
    group_label: "Resolved Date (TZ)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Resolved TZ Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Case Information"
    group_label: "Resolved Date (TZ)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Resolved TZ Calendar Quarter (YYYY/QQ)"
  }

 }



view: dmc_period_st_dt_pipeline {
  dimension: accqtr_desc { 
    view_label: "Pipeline Monitor"
    group_label: "Start Time of Checking Period (TZ)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Start Time of Checking Period TZ Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc { 
    view_label: "Pipeline Monitor"
    group_label: "Start Time of Checking Period (TZ)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Start Time of Checking Period TZ Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Pipeline Monitor"
    group_label: "Start Time of Checking Period (TZ)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Start Time of Checking Period TZ Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Pipeline Monitor"
    group_label: "Start Time of Checking Period (TZ)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Start Time of Checking Period TZ Calendar Quarter (YYYY/QQ)"
  }

 }



view: dmo_case_v_latest_tm {
  dimension: checking_period_before { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Pipeline Monitor"
    group_label: "Lastest Time Indicator"
    group_item_label: "Pre checking period mins Date Time"
    label: "Pre 60 mins Date Time"
    sql: ${TABLE}.checking_period_before  ;;
  }

  dimension: current_datetime { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Pipeline Monitor"
    group_label: "Lastest Time Indicator"
    group_item_label: "Current Date Time"
    label: "Current Date Time"
    sql: ${TABLE}.current_datetime  ;;
  }

  dimension: has_cases_created_in_checking_period { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Pipeline Monitor"
    group_label: "Lastest Time Indicator"
    group_item_label: "Has Cases created in checking period?"
    label: "Has Cases created in checking period"
    sql: ${TABLE}.has_cases_created_in_checking_period  ;;
  }

  dimension: has_cases_created_last_hour { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Pipeline Monitor"
    group_label: "Lastest Time Indicator"
    group_item_label: "Has Cases created in last hour?"
    label: "Has Cases created in last hour"
    sql: ${TABLE}.has_cases_created_last_hour  ;;
  }

  dimension: latest_created_time { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Pipeline Monitor"
    group_label: "Lastest Time Indicator"
    group_item_label: "Latest Created Time"
    label: "Latest Created Time"
    sql: ${TABLE}.latest_created_time  ;;
  }

  dimension: pre_60m_time_before { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Pipeline Monitor"
    group_label: "Lastest Time Indicator"
    group_item_label: "Pre 60 mins Date Time"
    label: "Pre 60 mins Date Time"
    sql: ${TABLE}.pre_60m_time_before  ;;
  }

 }



view: dmc_period_cls_dt_pipeline {
  dimension: accqtr_desc { 
    view_label: "Case Information"
    group_label: "Closed Date (TZ)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Closed TZ Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc { 
    view_label: "Case Information"
    group_label: "Closed Date (TZ)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Closed TZ Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Case Information"
    group_label: "Closed Date (TZ)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Closed TZ Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Case Information"
    group_label: "Closed Date (TZ)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Closed TZ Calendar Quarter (YYYY/QQ)"
  }

 }



view: dmc_period_bse_dt_pipeline {
  dimension: accqtr_desc { 
    view_label: "Holiday and Business Hours"
    group_label: "Based Date"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Based UTC Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc { 
    view_label: "Holiday and Business Hours"
    group_label: "Based Date"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Based UTC Week of Year (YYYY/WW)"
    sql: ${TABLE}.BSE_DT ;;
  }

  dimension: yrmon_desc { 
    view_label: "Holiday and Business Hours"
    group_label: "Based Date"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Based UTC Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Holiday and Business Hours"
    group_label: "Based Date"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Based UTC Calendar Quarter (YYYY/QQ)"
  }

 }



view: dmo_queue {
  dimension: dev_nm_pipeline { 
    primary_key: FALSE
    hidden: FALSE
    view_label: "Case Information"
    group_item_label: "Queue Name"
    label: "Queue Name"
    sql: ${TABLE}.DEV_NM ;;
  }

 }

