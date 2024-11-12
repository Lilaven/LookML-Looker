


view:  {
 }



view: dmc_crm_biz_hrs {
  dimension: day_end_gmt { 
    view_label: "Office"
    group_item_label: "Day End Time (UTC)"
    label: "Day End Time (UTC)"
    sql: ${TABLE}.DAY_END_GMT ;;
  }

  dimension: day_end_tm { 
    view_label: "Office"
    group_item_label: "Day End Time (Local)"
    label: "Day End Time (Local)"
    sql: ${TABLE}.DAY_END_TM ;;
  }

  dimension: day_st_gmt { 
    view_label: "Office"
    group_item_label: "Day Start Time (UTC)"
    label: "Day Start Time (UTC)"
    sql: ${TABLE}.DAY_ST_GMT ;;
  }

  dimension: day_st_tm { 
    view_label: "Office"
    group_item_label: "Day Start Time (Local)"
    label: "Day Start Time (Local)"
    sql: ${TABLE}.DAY_ST_TM ;;
  }

  dimension: hol_dt { 
    view_label: "Office"
    group_item_label: "Is Holiday (Yes/No)"
    label: "Is Holiday (Yes/No)"
    sql: CASE WHEN ${hol_dt} is not null THEN "Yes" ELSE "No" END ;;
  }

  dimension: hours { 
    view_label: "Office"
    group_item_label: "Working Hours"
    label: "Working Hours"
    sql: ${TABLE}.HOURS ;;
  }

  dimension: office { 
    view_label: "Office"
    group_item_label: "Office Code"
    label: "Office Code"
    sql: ${TABLE}.OFFICE ;;
  }

  
  dimension_group: dt { 
    view_label: "Office"
    group_label: "Date (Local)"
    group_item_label: "@{time_frames}"
    label: "Date"
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



view: dmc_crm_holiday_v {
  dimension: all_dy_flg { 
    view_label: "Office"
    group_item_label: "Is Holiday All Day (Yes/No)"
    label: "Is Holiday All Day (Yes/No)"
    sql: CASE WHEN ${all_dy_flg} = "true" THEN "Yes" ELSE "No" END ;;
  }

  dimension: hld_desc { 
    view_label: "Office"
    group_item_label: "Holiday Description"
    label: "Holiday Description"
    sql: ${TABLE}.HLD_DESC ;;
  }

  dimension: hld_nm { 
    view_label: "Office"
    group_item_label: "Holiday Name"
    label: "Holiday Name"
    sql: ${TABLE}.HLD_NM ;;
  }

 }



view: dmc_crm_ofc_hrc_v {
  dimension: cnt_nm { 
    view_label: "Office"
    group_item_label: "Office Country Name"
    label: "Office Country Name"
    sql: ${TABLE}.CNT_NM ;;
  }

  dimension: day_end_gmt { 
    view_label: "Parent Office"
    group_item_label: "Parent Office Day End Time (UTC)"
    label: "Parent Office Day End Time (UTC)"
    sql: ${TABLE}.DAY_END_GMT ;;
  }

  dimension: day_end_tm { 
    view_label: "Parent Office"
    group_item_label: "Parent Office Day End Time (Local)"
    label: "Parent Office Day End Time (Local)"
    sql: ${TABLE}.DAY_END_TM ;;
  }

  dimension: day_st_gmt { 
    view_label: "Parent Office"
    group_item_label: "Parent Office Day Start Time (UTC)"
    label: "Parent Office Day Start Time (UTC)"
    sql: ${TABLE}.DAY_ST_GMT ;;
  }

  dimension: day_st_tm { 
    view_label: "Parent Office"
    group_item_label: "Parent Office Day Start Time (Local)"
    label: "Parent Office Day Start Time (Local)"
    sql: ${TABLE}.DAY_ST_TM ;;
  }

  dimension: ghq_ofc_nm { 
    view_label: "Office"
    group_item_label: "Head Office"
    label: "Head Office"
    sql: ${TABLE}.GHQ_OFC_NM ;;
  }

  dimension: ofc_cnt_cd { 
    view_label: "Office"
    group_item_label: "Office Country Code"
    label: "Office Country Code"
    sql: ${TABLE}.OFC_CNT_CD ;;
  }

  dimension: ofc_nm { 
    view_label: "Office"
    group_item_label: "Office Name"
    label: "Office Name"
    sql: ${TABLE}.OFC_NM ;;
  }

  dimension: prnt_ofc_cd { 
    view_label: "Parent Office"
    group_item_label: "Parent Office"
    label: "Parent Office"
    sql: ${TABLE}.PRNT_OFC_CD ;;
  }

  dimension: rhq_ofc_nm { 
    view_label: "Office"
    group_item_label: "Regional Head Office"
    label: "Regional Head Office"
    sql: ${TABLE}.RHQ_OFC_NM ;;
  }

 }



view: dmc_period {
  dimension: accqtr_desc { 
    view_label: "Office"
    group_label: "Date (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Fiscal Quarter (YYYY/QQ)"
    sql: ${TABLE}.ACCQTR_DESC ;;
  }

  dimension: iso_yrwk_desc { 
    view_label: "Office"
    group_label: "Date (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Week of Year (YYYY/WW)"
    sql: ${TABLE}.ISO_YRWK_DESC ;;
  }

  dimension: yrmon_desc { 
    view_label: "Office"
    group_label: "Date (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Month (YYYY/MM)"
    sql: ${TABLE}.YRMON_DESC ;;
  }

  dimension: yrqtr_desc { 
    view_label: "Office"
    group_label: "Date (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Calendar Quarter (YYYY/QQ)"
    sql: ${TABLE}.YRQTR_DESC ;;
  }

 }

