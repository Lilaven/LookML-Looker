


view: dmc_period_dspt_cs_cre_sap_tms_dt {
  dimension: accqtr_desc { 
    view_label: "Dispute Info"
    group_label: "Dispute Case Created (Local) "
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Dispute Case Created in SAP Local Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc { 
    view_label: "Dispute Info"
    group_label: "Dispute Case Created (Local) "
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Dispute Case Created in SAP Local Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Dispute Info"
    group_label: "Dispute Case Created (Local) "
    group_item_label: "12. Month (YYYY/MM)"
    label: "Dispute Case Created in SAP Local Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Dispute Info"
    group_label: "Dispute Case Created (Local) "
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Dispute Case Created in SAP Local Calendar Quarter (YYYY/QQ)"
  }

 }



view: dmo_case_v_ext_epx {
  dimension_group: dspt_cs_cre_sap_tms_dt { 
    view_label: "Dispute Info"
    group_label: "Dispute Case Created (Local) "
    group_item_label: "@{time_frames}"
    label: "Dispute Case Created in SAP Local"
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
    sql: DATETIME_ADD(${TABLE}.DSPT_CS_CRE_SAP_TMS, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension_group: dspt_cs_upd_sap_tms_dt { 
    view_label: "Dispute Info"
    group_label: "Dispute Case Updated (Local) "
    group_item_label: "@{time_frames}"
    label: "Dispute Case Updated in SAP Local"
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
    sql: DATETIME_ADD(${TABLE}.DSPT_CS_UPD_SAP_TMS, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

 }



view: dmo_1st_case_trns_his_epx {
  dimension_group: trns_dt { 
    view_label: "Case First Transfer"
    group_label: "Transfer Date (Local)"
    group_item_label: "@{time_frames}"
    label: "First Transfer Local"
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
    sql: DATETIME_ADD(${TABLE}.trns_dt_tm, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

 }



view: dmc_period_dspt_cs_upd_sap_tms_dt {
  dimension: accqtr_desc { 
    view_label: "Dispute Info"
    group_label: "Dispute Case Updated (Local) "
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Dispute Case Updated in SAP Local Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc { 
    view_label: "Dispute Info"
    group_label: "Dispute Case Updated (Local) "
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Dispute Case Updated in SAP Local Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Dispute Info"
    group_label: "Dispute Case Updated (Local) "
    group_item_label: "12. Month (YYYY/MM)"
    label: "Dispute Case Updated in SAP Local Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Dispute Info"
    group_label: "Dispute Case Updated (Local) "
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Dispute Case Updated in SAP Local Calendar Quarter (YYYY/QQ)"
  }

 }



view: dmc_period_1st_cs_trns_his_trns_dt {
  dimension: accqtr_desc { 
    view_label: "Case First Transfer"
    group_label: "Transfer Date (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "First Transfer Local Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc { 
    view_label: "Case First Transfer"
    group_label: "Transfer Date (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "First Transfer Local Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc { 
    view_label: "Case First Transfer"
    group_label: "Transfer Date (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "First Transfer Local Month (YYYY/MM)"
  }

  dimension: yrqtr_desc { 
    view_label: "Case First Transfer"
    group_label: "Transfer Date (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "First Transfer Local Calendar Quarter (YYYY/QQ)"
  }

 }

