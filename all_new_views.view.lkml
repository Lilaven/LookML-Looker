


view: dmc_origin_created_by {
  dimension: loc_cd { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "05. Office Location Code"
    label: "Created By User Office Location Code"
  }

  dimension: loc_nm { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "06. Office Location Name"
    label: "Created By User Office Location Name"
  }

  dimension: ste_cd { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "07. Office State Code"
    label: "Created By User Office State Code"
  }

  dimension: ste_nm { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "08. Office State Name"
    label: "Created By User Office State Name"
  }

  dimension: rgn_cd { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "09. Office Region Code"
    label: "Created By User Office Region Code"
  }

  dimension: rgn_nm { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "10. Office Region Name"
    label: "Created By User Office Region Name"
  }

  dimension: sconti_cd { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "15. Office Subcontinent Code"
    label: "Created By User Office Subcontinent Code"
  }

  dimension: sconti_nm { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "16. Office Subcontinent Name"
    label: "Created By User Office Subcontinent Name"
  }

  dimension: conti_cd { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "17. Office Continent Code"
    label: "Created By User Office Continent Code"
  }

  dimension: conti_nm { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "18. Office Continent Name"
    label: "Created By User Office Continent Name"
  }

  dimension: ofc_lat_lon { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "22. Office Geolocation"
    label: "Created By User Office Geolocation"
  }

  dimension: ctrl_ofc_cnt_cd { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "26. Country Hierarchy Code"
    label: "Created By User Country Hierarchy Code"
  }

  dimension: ctrl_ofc_cnt_nm { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "27. Country Hierarchy Name"
    label: "Created By User Country Hierarchy Name"
  }

 }



view: dmc_origin_presence_user {
  dimension: loc_cd { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "05. Office Location Code"
    label: "Presence User Office Location Code"
  }

  dimension: loc_nm { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "06. Office Location Name"
    label: "Presence User Office Location Name"
  }

  dimension: ste_cd { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "07. Office State Code"
    label: "Presence User Office State Code"
  }

  dimension: ste_nm { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "08. Office State Name"
    label: "Presence User Office State Name"
  }

  dimension: rgn_cd { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "09. Office Region Code"
    label: "Presence User Office Region Code"
  }

  dimension: rgn_nm { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "10. Office Region Name"
    label: "Presence User Office Region Name"
  }

  dimension: sconti_cd { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "15. Office Subcontinent Code"
    label: "Presence User Office Subcontinent Code"
  }

  dimension: sconti_nm { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "16. Office Subcontinent Name"
    label: "Presence User Office Subcontinent Name"
  }

  dimension: conti_cd { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "17. Office Continent Code"
    label: "Presence User Office Continent Code"
  }

  dimension: conti_nm { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "18. Office Continent Name"
    label: "Presence User Office Continent Name"
  }

  dimension: ofc_lat_lon { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "22. Office Geolocation"
    label: "Presence User Office Geolocation"
  }

  dimension: ctrl_ofc_cnt_cd { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "26. Country Hierarchy Code"
    label: "Presence User Country Hierarchy Code"
  }

  dimension: ctrl_ofc_cnt_nm { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "27. Country Hierarchy Name"
    label: "Presence User Country Hierarchy Name"
  }

 }



view: dmo_usr_srvc_prsnc_v {
  dimension: cnfgrd_cpcy { 
    view_label: "Capacity"
    group_label: "Configured Capacity"
    label: "Configured Capacity"
    sql: ${TABLE}.CNFGRD_CPCY ;;
  }

  dimension: away_flg { 
    view_label: "Capacity"
    group_label: "Status"
    group_item_label: "Is Away"
    label: "Is Away"
    sql: ${TABLE}.AWAY_FLG ;;
  }

  dimension: curr_stt_flg { 
    view_label: "Capacity"
    group_label: "Status"
    group_item_label: "Is Current State"
    label: "Is Current State"
    sql: ${TABLE}.CURR_STT_FLG ;;
  }

  dimension: delt_flg { 
    view_label: "Capacity"
    group_label: "Status"
    group_item_label: "Is Deleted"
    label: "Is Deleted"
    sql: ${TABLE}.DELT_FLG ;;
  }

  dimension: srvc_prsnc_stts_id { 
    view_label: "Capacity"
    group_label: "Status"
    group_item_label: "Service Presence Status"
    label: "Service Presence Status"
    sql: ${TABLE}.SRVC_PRSNC_STTS_ID ;;
  }

  dimension: cre_usr_id { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "01. User ID"
    label: "Created By User ID"
    sql: ${TABLE}.CRE_USR_ID ;;
  }

  dimension: upd_usr_id { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "01. User ID"
    label: "Last Modified By User ID"
    sql: ${TABLE}.UPD_USR_ID ;;
  }

  dimension: own_id { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "01. User ID"
    label: "Presence Owner ID"
    sql: ${TABLE}.OWN_ID ;;
  }

  dimension: usr_id { 
    view_label: "User"
    group_label: "User Presence ID"
    label: "User Presence ID"
    sql: ${TABLE}.USR_ID ;;
  }

  
  dimension_group: cre_lc_dt { 
    view_label: "Date"
    group_label: "Created Date (Local)"
    group_item_label: "@{time_frames}"
    label: "Created Local"
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
    sql: DATETIME_ADD(${cre_utc_dt_raw}, INTERVAL ${dmc_ofc_time_gmt_adj_cre_utc_dt.gmt_hrs_adj} MINUTE) ;;
  }

  dimension_group: cre_utc_dt { 
    view_label: "Date"
    group_label: "Created Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Created UTC"
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

  dimension_group: upd_lc_dt { 
    view_label: "Date"
    group_label: "Last Modified Date (Local)"
    group_item_label: "@{time_frames}"
    label: "Last Modified Local"
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
    sql: DATETIME_ADD(${upd_utc_dt_raw}, INTERVAL ${dmc_ofc_time_gmt_adj_upd_utc_dt.gmt_hrs_adj} MINUTE) ;;
  }

  dimension_group: upd_utc_dt { 
    view_label: "Date"
    group_label: "Last Modified Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Last Modified UTC"
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
    sql: ${TABLE}.UPD_DT ;;
  }

  dimension_group: stts_end_lc_dt { 
    view_label: "Date"
    group_label: "Status End Date (Local)"
    group_item_label: "@{time_frames}"
    label: "Status End Local"
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
    sql: DATETIME_ADD(${stts_end_utc_dt_raw}, INTERVAL ${dmc_ofc_time_gmt_adj_stts_end_utc_dt.gmt_hrs_adj} MINUTE) ;;
  }

  dimension_group: stts_end_utc_dt { 
    view_label: "Date"
    group_label: "Status End Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Status End UTC"
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
    sql: ${TABLE}.STTS_END_DT ;;
  }

  dimension_group: stts_strt_lc_dt { 
    view_label: "Date"
    group_label: "Status Start Date (Local)"
    group_item_label: "@{time_frames}"
    label: "Status Start Local"
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
    sql: DATETIME_ADD(${stts_strt_utc_dt_raw}, INTERVAL ${dmc_ofc_time_gmt_adj_stts_strt_utc_dt.gmt_hrs_adj} MINUTE) ;;
  }

  dimension_group: stts_strt_utc_dt { 
    view_label: "Date"
    group_label: "Status Start Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Status Start UTC"
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
    sql: ${TABLE}.STTS_STRT_DT ;;
  }

  
  measure: at_cpcy_drtn { 
    view_label: "Capacity"
    group_label: "Duration"
    group_item_label: "At Capacity Duration"
    label: "At Capacity Duration"
    sql: ${TABLE}.AT_CPCY_DRTN ;;
  }

  measure: avg_cpcy { 
    view_label: "Capacity"
    group_label: "Duration"
    group_item_label: "Average Capacity"
    label: "Average Capacity"
    sql: ${TABLE}.AVG_CPCY ;;
  }

  measure: idle_drtn { 
    view_label: "Capacity"
    group_label: "Duration"
    group_item_label: "Idle Duration"
    label: "Idle Duration"
    sql: ${TABLE}.IDLE_DRTN ;;
  }

  measure: stts_strt_dt
stts_end_dt { 
    view_label: "Capacity"
    group_label: "Duration"
    group_item_label: "Status Duration"
    label: "Status Duration"
    sql: DATETIME_DIFF(${TABLE}.STTS_END_DT, ${TABLE}.STTS_STRT_DT, "SECOND")
 ;;
  }

  
  
 }



view: dmc_period_usr_srvc_prsnc_upd_utc_dt {
  dimension: iso_yrwk_desc { 
    view_label: "Date"
    group_label: "Last Modified Date (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Last Modified UTC Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Date"
    group_label: "Last Modified Date (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Last Modified UTC Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Date"
    group_label: "Last Modified Date (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Last Modified UTC Calendar Quarter (YYYY/QQ)"
  }

  dimension: accqtr_desc { 
    view_label: "Date"
    group_label: "Last Modified Date (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Last Modified UTC Fiscal Quarter (YYYY/QQ)"
  }

 }



view: dmc_period_usr_srvc_prsnc_cre_lc_dt {
  dimension: iso_yrwk_desc { 
    view_label: "Date"
    group_label: "Created Date (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Created Local Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Date"
    group_label: "Created Date (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Created Local Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Date"
    group_label: "Created Date (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Created Local Calendar Quarter (YYYY/QQ)"
  }

  dimension: accqtr_desc { 
    view_label: "Date"
    group_label: "Created Date (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Created Local Fiscal Quarter (YYYY/QQ)"
  }

 }



view: dmc_origin_last_modified_by {
  dimension: loc_cd { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "05. Office Location Code"
    label: "Last Modified By User Office Location Code"
  }

  dimension: loc_nm { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "06. Office Location Name"
    label: "Last Modified By User Office Location Name"
  }

  dimension: ste_cd { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "07. Office State Code"
    label: "Last Modified By User Office State Code"
  }

  dimension: ste_nm { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "08. Office State Name"
    label: "Last Modified By User Office State Name"
  }

  dimension: rgn_cd { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "09. Office Region Code"
    label: "Last Modified By User Office Region Code"
  }

  dimension: rgn_nm { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "10. Office Region Name"
    label: "Last Modified By User Office Region Name"
  }

  dimension: sconti_cd { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "15. Office Subcontinent Code"
    label: "Last Modified By User Office Subcontinent Code"
  }

  dimension: sconti_nm { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "16. Office Subcontinent Name"
    label: "Last Modified By User Office Subcontinent Name"
  }

  dimension: conti_cd { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "17. Office Continent Code"
    label: "Last Modified By User Office Continent Code"
  }

  dimension: conti_nm { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "18. Office Continent Name"
    label: "Last Modified By User Office Continent Name"
  }

  dimension: ofc_lat_lon { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "22. Office Geolocation"
    label: "Last Modified By User Office Geolocation"
  }

  dimension: ctrl_ofc_cnt_cd { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "26. Country Hierarchy Code"
    label: "Last Modified By User Country Hierarchy Code"
  }

  dimension: ctrl_ofc_cnt_nm { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "27. Country Hierarchy Name"
    label: "Last Modified By User Country Hierarchy Name"
  }

 }



view: dmo_usr_created_by {
  dimension: usr_nm { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "02. User Name"
    label: "Created By User Name"
  }

  dimension: ofc_cd_no { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "03. Office Code"
    label: "Created By User Office Code"
  }

  dimension: ofc_eng_nm { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "04. Office Name"
    label: "Created By User Office Name"
  }

  dimension: sub_cnt_cd { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "11. Office Sub Country Code"
    label: "Created By User Office Sub Country Code"
  }

  dimension: sub_cnt_nm { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "12. Office Sub Country Name"
    label: "Created By User Office Sub Country Name"
  }

  dimension: cnt_cd { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "13. Office Country Code"
    label: "Created By User Office Country Code"
  }

  dimension: cnt_nm { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "14. Office Country Name"
    label: "Created By User Office Country Name"
  }

  dimension: rhq_cd { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "19. Office RHQ"
    label: "Created By User Office RHQ"
  }

  dimension: rhq_nm { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "20. Office RHQ Name"
    label: "Created By User Office RHQ Name"
  }

  dimension: rhq_abbr { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "21. Office RHQ Abbreviation"
    label: "Created By User Office RHQ Abbreviation"
  }

  dimension: is_oneline_user { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "23. Is ONE ID (Yes/No)"
    label: "Is Created By ONE ID"
  }

  dimension: is_agent { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "24. Is Third Party Agent (Yes/No)"
    label: "Is Created By Third Party Agent"
  }

  dimension: usr_tp { 
    view_label: "User"
    group_label: "Created By"
    group_item_label: "25. User Type"
    label: "Created By User Type"
  }

 }



view: dmo_usr_last_modified_by {
  dimension: usr_nm { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "02. User Name"
    label: "Last Modified By User Name"
  }

  dimension: ofc_cd_no { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "03. Office Code"
    label: "Last Modified By User Office Code"
  }

  dimension: ofc_eng_nm { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "04. Office Name"
    label: "Last Modified By User Office Name"
  }

  dimension: sub_cnt_cd { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "11. Office Sub Country Code"
    label: "Last Modified By User Office Sub Country Code"
  }

  dimension: sub_cnt_nm { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "12. Office Sub Country Name"
    label: "Last Modified By User Office Sub Country Name"
  }

  dimension: cnt_cd { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "13. Office Country Code"
    label: "Last Modified By User Office Country Code"
  }

  dimension: cnt_nm { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "14. Office Country Name"
    label: "Last Modified By User Office Country Name"
  }

  dimension: rhq_cd { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "19. Office RHQ"
    label: "Last Modified By User Office RHQ"
  }

  dimension: rhq_nm { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "20. Office RHQ Name"
    label: "Last Modified By User Office RHQ Name"
  }

  dimension: rhq_abbr { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "21. Office RHQ Abbreviation"
    label: "Last Modified By User Office RHQ Abbreviation"
  }

  dimension: is_oneline_user { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "23. Is ONE ID (Yes/No)"
    label: "Is Last Modified By ONE ID"
  }

  dimension: is_agent { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "24. Is Third Party Agent (Yes/No)"
    label: "Is Last Modified By Third Party Agent"
  }

  dimension: usr_tp { 
    view_label: "User"
    group_label: "Last Modified By"
    group_item_label: "25. User Type"
    label: "Last Modified By User Type"
  }

 }



view: dmo_usr_presence_owner {
  dimension: usr_nm { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "02. User Name"
    label: "Presence Owner Name"
  }

  dimension: ofc_cd_no { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "03. Office Code"
    label: "Presence Owner Office Code"
  }

  dimension: ofc_eng_nm { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "04. Office Name"
    label: "Presence Owner Office Name"
  }

  dimension: sub_cnt_cd { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "11. Office Sub Country Code"
    label: "Presence Owner Office Sub Country Code"
  }

  dimension: sub_cnt_nm { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "12. Office Sub Country Name"
    label: "Presence Owner Office Sub Country Name"
  }

  dimension: cnt_cd { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "13. Office Country Code"
    label: "Presence Owner Office Country Code"
  }

  dimension: cnt_nm { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "14. Office Country Name"
    label: "Presence Owner Office Country Name"
  }

  dimension: rhq_cd { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "19. Office RHQ"
    label: "Presence Owner Office RHQ"
  }

  dimension: rhq_nm { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "20. Office RHQ Name"
    label: "Presence Owner Office RHQ Name"
  }

  dimension: rhq_abbr { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "21. Office RHQ Abbreviation"
    label: "Presence Owner Office RHQ Abbreviation"
  }

  dimension: is_oneline_user { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "23. Is ONE ID (Yes/No)"
    label: "Is Presence Owner ONE ID"
  }

  dimension: is_agent { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "24. Is Third Party Agent (Yes/No)"
    label: "Is Presence Owner Third Party Agent"
  }

  dimension: usr_tp { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "25. User Type"
    label: "Presence Owner User Type"
  }

 }



view: dmc_origin_presence_owner {
  dimension: loc_cd { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "05. Office Location Code"
    label: "Presence Owner Office Location Code"
  }

  dimension: loc_nm { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "06. Office Location Name"
    label: "Presence Owner Office Location Name"
  }

  dimension: ste_cd { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "07. Office State Code"
    label: "Presence Owner Office State Code"
  }

  dimension: ste_nm { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "08. Office State Name"
    label: "Presence Owner Office State Name"
  }

  dimension: rgn_cd { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "09. Office Region Code"
    label: "Presence Owner Office Region Code"
  }

  dimension: rgn_nm { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "10. Office Region Name"
    label: "Presence Owner Office Region Name"
  }

  dimension: sconti_cd { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "15. Office Subcontinent Code"
    label: "Presence Owner Office Subcontinent Code"
  }

  dimension: sconti_nm { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "16. Office Subcontinent Name"
    label: "Presence Owner Office Subcontinent Name"
  }

  dimension: conti_cd { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "17. Office Continent Code"
    label: "Presence Owner Office Continent Code"
  }

  dimension: conti_nm { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "18. Office Continent Name"
    label: "Presence Owner Office Continent Name"
  }

  dimension: ofc_lat_lon { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "22. Office Geolocation"
    label: "Presence Owner Office Geolocation"
  }

  dimension: ctrl_ofc_cnt_cd { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "26. Country Hierarchy Code"
    label: "Presence Owner Country Hierarchy Code"
  }

  dimension: ctrl_ofc_cnt_nm { 
    view_label: "User"
    group_label: "Presence Owner"
    group_item_label: "27. Country Hierarchy Name"
    label: "Presence Owner Country Hierarchy Name"
  }

 }



view: dmc_period_usr_srvc_prsnc_stts_end_utc_dt {
  dimension: iso_yrwk_desc { 
    view_label: "Date"
    group_label: "Status End Date (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Status End UTC Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Date"
    group_label: "Status End Date (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Status End UTC Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Date"
    group_label: "Status End Date (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Status End UTC Calendar Quarter (YYYY/QQ)"
  }

  dimension: accqtr_desc { 
    view_label: "Date"
    group_label: "Status End Date (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Status End UTC Fiscal Quarter (YYYY/QQ)"
  }

 }



view: dmo_usr_presence_user {
  dimension: of_id_pk { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "01. User ID"
    label: "Presence User ID"
  }

  dimension: usr_nm { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "02. User Name"
    label: "Presence User Name"
  }

  dimension: ofc_cd_no { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "03. Office Code"
    label: "Presence User Office Code"
  }

  dimension: ofc_eng_nm { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "04. Office Name"
    label: "Presence User Office Name"
  }

  dimension: sub_cnt_cd { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "11. Office Sub Country Code"
    label: "Presence User Office Sub Country Code"
  }

  dimension: sub_cnt_nm { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "12. Office Sub Country Name"
    label: "Presence User Office Sub Country Name"
  }

  dimension: cnt_cd { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "13. Office Country Code"
    label: "Presence User Office Country Code"
  }

  dimension: cnt_nm { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "14. Office Country Name"
    label: "Presence User Office Country Name"
  }

  dimension: rhq_cd { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "19. Office RHQ"
    label: "Presence User Office RHQ"
  }

  dimension: rhq_nm { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "20. Office RHQ Name"
    label: "Presence User Office RHQ Name"
  }

  dimension: rhq_abbr { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "21. Office RHQ Abbreviation"
    label: "Presence User Office RHQ Abbreviation"
  }

  dimension: is_oneline_user { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "23. Is ONE ID (Yes/No)"
    label: "Is Presence User ONE ID"
  }

  dimension: is_agent { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "24. Is Third Party Agent (Yes/No)"
    label: "Is Presence User Third Party Agent"
  }

  dimension: usr_tp { 
    view_label: "User"
    group_label: "Presence User"
    group_item_label: "25. User Type"
    label: "Presence User Type"
  }

  dimension: hybrd_dul_cap_sls_and_svc { 
    view_label: "User"
    group_label: "User Is Hybrid/Dual Cap (Sales and Service)"
    label: "User Is Hybrid/Dual Cap (Sales and Service)"
  }

 }



view: dmc_period_usr_srvc_prsnc_stts_strt_lc_dt {
  dimension: iso_yrwk_desc { 
    view_label: "Date"
    group_label: "Status Start Date (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Status Start Local Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Date"
    group_label: "Status Start Date (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Status Start Local Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Date"
    group_label: "Status Start Date (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Status Start Local Calendar Quarter (YYYY/QQ)"
  }

  dimension: accqtr_desc { 
    view_label: "Date"
    group_label: "Status Start Date (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Status Start Local Fiscal Quarter (YYYY/QQ)"
  }

 }



view: dmc_period_usr_srvc_prsnc_stts_end_lc_dt {
  dimension: iso_yrwk_desc { 
    view_label: "Date"
    group_label: "Status End Date (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Status End Local Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Date"
    group_label: "Status End Date (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Status End Local Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Date"
    group_label: "Status End Date (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Status End Local Calendar Quarter (YYYY/QQ)"
  }

  dimension: accqtr_desc { 
    view_label: "Date"
    group_label: "Status End Date (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Status End Local Fiscal Quarter (YYYY/QQ)"
  }

 }



view: dmc_period_usr_srvc_prsnc_cre_utc_dt {
  dimension: iso_yrwk_desc { 
    view_label: "Date"
    group_label: "Created Date (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Created UTC Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Date"
    group_label: "Created Date (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Created UTC Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Date"
    group_label: "Created Date (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Created UTC Calendar Quarter (YYYY/QQ)"
  }

  dimension: accqtr_desc { 
    view_label: "Date"
    group_label: "Created Date (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Created UTC Fiscal Quarter (YYYY/QQ)"
  }

 }



view: dmc_period_usr_srvc_prsnc_upd_lc_dt {
  dimension: iso_yrwk_desc { 
    view_label: "Date"
    group_label: "Last Modified Date (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Last Modified Local Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Date"
    group_label: "Last Modified Date (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Last Modified Local Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Date"
    group_label: "Last Modified Date (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Last Modified Local Calendar Quarter (YYYY/QQ)"
  }

  dimension: accqtr_desc { 
    view_label: "Date"
    group_label: "Last Modified Date (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Last Modified Local Fiscal Quarter (YYYY/QQ)"
  }

 }



view: dmc_period_usr_srvc_prsnc_stts_strt_utc_dt {
  dimension: iso_yrwk_desc { 
    view_label: "Date"
    group_label: "Status Start Date (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Status Start UTC Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Date"
    group_label: "Status Start Date (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Status Start UTC Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Date"
    group_label: "Status Start Date (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Status Start UTC Calendar Quarter (YYYY/QQ)"
  }

  dimension: accqtr_desc { 
    view_label: "Date"
    group_label: "Status Start Date (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Status Start UTC Fiscal Quarter (YYYY/QQ)"
  }

 }

