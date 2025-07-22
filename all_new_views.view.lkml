


view: dmc_period_mtrc_dt {
  dimension: accqtr_desc { 
    view_label: "Lightning Usage"
    group_label: "Metrics Date (TZ)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Metrics Date Fiscal Quarter (YYYY/QQ)"
    sql: ${TABLE}.MTRC_DT ;;
  }

  dimension: iso_yrwk_desc { 
    view_label: "Lightning Usage"
    group_label: "Metrics Date (TZ)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Metrics Date Week of Year (YYYY/WW)"
    sql: ${TABLE}.MTRC_DT ;;
  }

  dimension: yrmon_desc { 
    view_label: "Lightning Usage"
    group_label: "Metrics Date (TZ)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Metrics Date Month (YYYY/MM)"
    sql: ${TABLE}.MTRC_DT ;;
  }

  dimension: yrqtr_desc { 
    view_label: "Lightning Usage"
    group_label: "Metrics Date (TZ)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Metrics Date Calendar Quarter (YYYY/QQ)"
    sql: ${TABLE}.MTRC_DT ;;
  }

 }



view: dmo_lgt_usg_mtrc {
  dimension: OF_ID { 
    view_label: "Lightning Usage"
    group_item_label: "ONEForce Id"
    label: "ONEForce Id"
    type: string
    sql: ${TABLE}.OF_ID ;;
  }

  dimension: application_dynamic { 
    view_label: "Special"
    label: "Application Dynamic"
    type: string
    sql: CASE
  WHEN {% parameter application_param %} = "RHQ" THEN ${of_user.regional_head_office}
  WHEN {% parameter application_param %} = "Country" THEN ${of_user.office_Country_Code}
  WHEN {% parameter application_param %} = "Office_Type" THEN ${of_user.officetype}
  WHEN {% parameter application_param %} = "Profile" THEN ${of_user.profile_group_name}
  WHEN {% parameter application_param %} = "Role" THEN ${of_user.user_role_name}
  ELSE ${pg_nm} END ;;
  }

  dimension: hardware_dynamic { 
    view_label: "Special"
    label: "Hardware Dynamic"
    type: string
    sql: CASE
  WHEN {% parameter hardware_param %} = "Country" THEN ${of_user.office_Country_Code}
  WHEN {% parameter hardware_param %} = "Office" THEN ${of_user.office_code_new}
  ELSE ${of_user.full_name} END ;;
  }

  dimension: mtrc_dt_dynamic { 
    view_label: "Lightning Usage"
    group_item_label: "Metrics Month"
    label: "Metrics Month"
    type: string
    sql: {% if time_param._parameter_value == "Date" %} ${mtrc_dt_date}
  {% elsif time_param._parameter_value == "Week" %} ${mtrc_dt_week}
  {% else %} ${mtrc_dt_month}
  {% endif %}  ;;
  }

  dimension: network_geo_dynamic { 
    view_label: "Special"
    label: "Network Geo Dynamic"
    type: string
    sql: CASE
  WHEN {% parameter network_geo_param %} = "Country" THEN ${of_user.office_Country_Code}
  ELSE ${of_user.office_code_new} END ;;
  }

  dimension: pg_nm { 
    view_label: "Lightning Usage"
    group_item_label: "Page Name"
    label: "Page Name"
    type: string
    sql: ${TABLE}.PG_NM ;;
  }

  dimension: pg_nm_nodrill { 
    view_label: "Lightning Usage"
    group_item_label: "Page Name (No Drllldown)"
    label: "Page Name (No Drllldown)"
    type: string
    description: "This Page Name is skipped over drilling"
    sql: ${TABLE}.PG_NM ;;
  }

  dimension: usr_id { 
    view_label: "User"
    group_item_label: "User ID"
    label: "User ID"
    type: string
    sql: ${TABLE}.USR_ID ;;
  }

  
  dimension_group: mtrc_dt { 
    view_label: "Lightning Usage"
    group_label: "Metrics Date (TZ)"
    group_item_label: "@{time_frames}"
    label: "Metrics"
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
    sql: ${TABLE}.MTRC_DT ;;
  }

  dimension_group: mtrc_gdt { 
    view_label: "Lightning Usage"
    group_label: "Metrics Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Metrics"
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
    sql: ${TABLE}.MTRC_DT ;;
  }

  
  measure: count_of_ept_record { 
    view_label: "Measures"
    group_item_label: "Count of EPT Record "
    label: "Count of EPT Record "
    type: sum
    sql: ${TABLE}.REC_CNT_EPT ;;
  }

  measure: count_of_ept_record_count_sales { 
    view_label: "Measures"
    group_item_label: "Count of EPT Record (Sales)"
    label: "Count of EPT Record (Sales)"
    type: sum
    filters: {condition=Sales Cloud, field=of_user.sales_service_profile}
    sql: ${TABLE}.REC_CNT_EPT ;;
  }

  measure: count_of_ept_record_count_svc { 
    view_label: "Measures"
    group_item_label: "Count of EPT Record (Service)"
    label: "Count of EPT Record (Service)"
    type: sum
    filters: {condition=Service Cloud, field=of_user.sales_service_profile}
    sql: ${TABLE}.REC_CNT_EPT ;;
  }

  measure: detail_01 { 
    hidden: No
    view_label: "Measures"
    group_item_label: "Detail 01"
    label: "Detail 01"
    type: count
  }

  measure: ept_bin_u3_kpi { 
    view_label: "Measures"
    group_item_label: "EPT Under 3 Sec KPI"
    label: "EPT Under 3 Sec KPI"
    type: number
    value_format: "#,##0%"
    sql: 0.85 ;;
  }

  measure: ept_bin_under5_kpi { 
    view_label: "Measures"
    group_item_label: "EPT Under 5 Sec KPI"
    label: "EPT Under 5 Sec KPI"
    type: number
    value_format: "#,##0%"
    sql: 0.99 ;;
  }

  measure: percentile_of_cores_bin_2_4 { 
    view_label: "Measures"
    group_item_label: "% of CoresBin 2 To 4 Sec"
    label: "Percentile of CoresBin 2 To 4 Sec"
    type: number
    value_format: "#,##0%"
    description: "Percentage with rendered Coresbin"
    sql: ${sum_of_cores_bin_2to4}/NULLIF((${sum_of_cores_bin_u2}+${sum_of_cores_bin_2to4}+${sum_of_cores_bin_4to8}+${sum_of_cores_bin_o8}),0) ;;
  }

  measure: percentile_of_cores_bin_4_8 { 
    view_label: "Measures"
    group_item_label: "% of CoresBin 4 To 8 Sec"
    label: "Percentile of CoresBin 4 To 8 Sec"
    type: number
    value_format: "#,##0%"
    description: "Percentage with rendered Coresbin"
    sql: ${sum_of_cores_bin_4to8}/NULLIF((${sum_of_cores_bin_u2}+${sum_of_cores_bin_2to4}+${sum_of_cores_bin_4to8}+${sum_of_cores_bin_o8}),0) ;;
  }

  measure: percentile_of_cores_bin_o8 { 
    view_label: "Measures"
    group_item_label: "% of CoresBin Over 8 Sec"
    label: "Percentile of CoresBin Over 8 Sec"
    type: number
    value_format: "#,##0%"
    description: "Percentage with rendered Coresbin"
    sql: ${sum_of_cores_bin_o8}/NULLIF((${sum_of_cores_bin_u2}+${sum_of_cores_bin_2to4}+${sum_of_cores_bin_4to8}+${sum_of_cores_bin_o8}),0) ;;
  }

  measure: percentile_of_cores_bin_u2 { 
    view_label: "Measures"
    group_item_label: "% of CoresBin Under 2 Sec"
    label: "Percentile of CoresBin Under 2 Sec"
    type: number
    value_format: "#,##0%"
    description: "Percentage with rendered Coresbin"
    sql: ${sum_of_cores_bin_u2}/NULLIF((${sum_of_cores_bin_u2}+${sum_of_cores_bin_2to4}+${sum_of_cores_bin_4to8}+${sum_of_cores_bin_o8}),0) ;;
  }

  measure: percentile_of_dwnlnk_bin_3_5 { 
    view_label: "Measures"
    group_item_label: "% of Downlink 3 To 5 Frequency"
    label: "Percentile of Downlink 3 To 5 Frequency"
    type: number
    value_format: "#,##0%"
    description: "Percentage with rendered Downlink"
    sql: ${sum_of_dwnlnk_bin_3to5}/NULLIF((${sum_of_dwnlnk_bin_u3}+${sum_of_dwnlnk_bin_3to5}+${sum_of_dwnlnk_bin_5_8}+${sum_of_dwnlnk_bin_8_10}+${sum_of_dwnlnk_bin_o10}),0) ;;
  }

  measure: percentile_of_dwnlnk_bin_5_8 { 
    view_label: "Measures"
    group_item_label: "% of Downlink 5 To 8 Frequency"
    label: "Percentile of Downlink 5 To 8 Frequency"
    type: number
    value_format: "#,##0%"
    description: "Percentage with rendered Downlink"
    sql: ${sum_of_dwnlnk_bin_5_8}/NULLIF((${sum_of_dwnlnk_bin_u3}+${sum_of_dwnlnk_bin_3to5}+${sum_of_dwnlnk_bin_5_8}+${sum_of_dwnlnk_bin_8_10}+${sum_of_dwnlnk_bin_o10}),0)  ;;
  }

  measure: percentile_of_dwnlnk_bin_over8 { 
    view_label: "Measures"
    group_item_label: "% of Downlink Over 8 Frequency"
    label: "Percentile of Downlink Over 8 Frequency"
    type: number
    value_format: "#,##0%"
    description: "Percentage with rendered Downlink"
    sql: ${dwnlnk_bin_over8}/NULLIF((${dwnlnk_bin_u3}+${dwnlnk_bin_3to5}+${dwnlnk_bin_5_8}+${dwnlnk_bin_8_10}+${dwnlnk_bin_o10}),0) ;;
  }

  measure: percentile_of_dwnlnk_bin_u3 { 
    view_label: "Measures"
    group_item_label: "% of Downlink Under 3 Frequency"
    label: "Percentile of Downlink Under 3 Frequency"
    type: number
    value_format: "#,##0%"
    description: "Percentage with rendered Downlink"
    sql: ${dwnlnk_bin_u3}/NULLIF((${dwnlnk_bin_u3}+${dwnlnk_bin_3to5}+${dwnlnk_bin_5_8}+${dwnlnk_bin_8_10}+${dwnlnk_bin_o10}),0) ;;
  }

  measure: percentile_of_ept_bin_3_5 { 
    view_label: "Measures"
    group_item_label: "% of EPT 3 To 5 Sec"
    label: "Percentile of EPT 3 To 5 Sec"
    type: number
    value_format: "#,##0%"
    description: "Percentage with rendered EPT Record Count"
    sql: ${sum_of_ept_bin_3_5}/NULLIF(${sum_of_ept_record_count},0) ;;
  }

  measure: percentile_of_ept_bin_3_5_std { 
    view_label: "Measures"
    group_item_label: "% of EPT 3 To 5 Sec (Standard)"
    label: "Percentile of EPT 3 To 5 Sec (Standard)"
    type: number
    value_format: "#,##0.00%"
    description: "Standard Percentage"
    sql: ${sum_of_ept_bin_3_5}/NULLIF(${sum_of_ept_record_count},0) ;;
  }

  measure: percentile_of_ept_bin_5_8_std { 
    view_label: "Measures"
    group_item_label: "% of EPT 5 To 8 Sec"
    label: "Percentile of EPT 5 To 8 Sec"
    type: number
    value_format: "#,##0.00%"
    description: "Standard Percentage"
    sql: ${sum_of_ept_bin_5_8}/NULLIF(${count_of_ept_record},0) ;;
  }

  measure: percentile_of_ept_bin_8_10_std { 
    view_label: "Measures"
    group_item_label: "% of EPT 8 To 10 Sec"
    label: "Percentile of EPT 8 To 10 Sec"
    type: number
    value_format: "#,##0.00%"
    description: "Standard Percentage"
    sql: ${sum_of_ept_bin_8_10}/NULLIF(${count_of_ept_record},0) ;;
  }

  measure: percentile_of_ept_bin_o10_std { 
    view_label: "Measures"
    group_item_label: "% of EPT Over 10 Sec"
    label: "Percentile of EPT Over 10 Sec"
    type: number
    value_format: "#,##0.00%"
    description: "Standard Percentage"
    sql: ${sum_of_ept_bin_o10}/NULLIF(${count_of_ept_record},0) ;;
  }

  measure: percentile_of_ept_bin_over5 { 
    view_label: "Measures"
    group_item_label: "% of EPT Over 5 Sec"
    label: "Percentile of EPT Over 5 Sec"
    type: number
    value_format: "#,##0%"
    description: "Percentage with rendered EPT Record Count"
    sql: ${sum_of_ept_bin_over5}/NULLIF(${count_of_ept_record},0) ;;
  }

  measure: percentile_of_ept_bin_u3 { 
    view_label: "Measures"
    group_item_label: "% of EPT Under 3 Sec"
    label: "Percentile of EPT Under 3 Sec"
    type: number
    value_format: "#,##0%"
    description: "Percentage with rendered EPT Record Count"
    sql: ${sum_of_ept_bin_u3}/NULLIF(${count_of_ept_record},0) ;;
  }

  measure: percentile_of_ept_bin_u3_sales { 
    view_label: "Measures"
    group_item_label: "% of EPT Under 3 Sec (Service)"
    label: "Percentile of EPT Under 3 Sec (Service)"
    type: number
    value_format: "#,##0.00%"
    description: "For Sales EPT value chart"
    sql: ${sum_of_ept_bin_u3_sales}/NULLIF(${count_of_ept_record_sales},0) ;;
  }

  measure: percentile_of_ept_bin_u3_std { 
    view_label: "Measures"
    group_item_label: "% of EPT Under 3 Sec (Standard)"
    label: "Percentile of EPT Under 3 Sec (Standard)"
    type: number
    value_format: "#,##0.00%"
    description: "Standard Percentage"
    sql: ${sum_of_ept_bin_u3}/NULLIF(${count_of_ept_record},0) ;;
  }

  measure: percentile_of_ept_bin_u3_svc { 
    view_label: "Measures"
    group_item_label: "% of EPT Under 3 Sec (Sales)"
    label: "Percentile of EPT Under 3 Sec (Sales)"
    type: number
    value_format: "#,##0.00%"
    description: "For Service EPT value chart"
    sql: ${sum_of_ept_bin_u3_svc}/NULLIF(${count_of_ept_record_svc},0) ;;
  }

  measure: percentile_of_ept_bin_u3_total { 
    view_label: "Measures"
    group_item_label: "% of EPT Under 3 Sec (Total)"
    label: "Percentile of EPT Under 3 Sec (Total)"
    type: number
    value_format: "#,##0.00%"
    description: "For Total EPT value chart"
    sql: ${sum_of_ept_bin_u3}/NULLIF(${count_of_ept_record},0) ;;
  }

  measure: percentile_of_ept_bin_under5 { 
    view_label: "Measures"
    group_item_label: "% of EPT Under 5 Sec"
    label: "Percentile of EPT Under 5 Sec"
    type: number
    value_format: "#,##0%"
    description: "Percentage with rendered EPT Record Count"
    sql: ${sum_of_ept_bin_under5}/NULLIF(${count_of_ept_record},0) ;;
  }

  measure: percentile_of_ept_bin_under5_sales { 
    view_label: "Measures"
    group_item_label: "% of EPT Under 5 Sec (Sales)"
    label: "Percentile of EPT Under 5 Sec (Sales)"
    type: number
    value_format: "#,##0.00%"
    description: "For Sales EPT value chart"
    sql: ${sum_of_ept_bin_under5_sales}/NULLIF(${count_of_ept_record_sales},0) ;;
  }

  measure: percentile_of_ept_bin_under5_svc { 
    view_label: "Measures"
    group_item_label: "% of EPT Under 5 Sec (Service)"
    label: "Percentile of EPT Under 5 Sec (Service)"
    type: number
    value_format: "#,##0.00%"
    description: "For Service EPT value chart"
    sql: ${sum_of_ept_bin_under5_svc}/NULLIF(${count_of_ept_record_svc},0) ;;
  }

  measure: percentile_of_ept_bin_under5_total { 
    view_label: "Measures"
    group_item_label: "% of EPT Under 5 Sec (Total)"
    label: "Percentile of EPT Under 5 Sec (Total)"
    type: number
    value_format: "#,##0.00%"
    description: "For Total EPT value chart"
    sql: ${sum_of_ept_bin_under5}/NULLIF(${count_of_ept_record},0) ;;
  }

  measure: percentile_of_prtt_bin_u50 { 
    view_label: "Measures"
    group_item_label: "% of RTT Under 50"
    label: "Percentile of RTT Under 50"
    type: number
    value_format: "#,##0%"
    description: "Percentage with rendered RTT"
    sql: ${percentile_of_rtt_bin_u50}/NULLIF((${percentile_of_rtt_bin_u50}+${percentile_of_rtt_bin_50_150}+${percentile_of_rtt_bin_o150}),0) ;;
  }

  measure: percentile_of_rtt_bin_50_150 { 
    view_label: "Measures"
    group_item_label: "% of RTT 50 To 150"
    label: "Percentile of RTT 50 To 150"
    type: number
    value_format: "#,##0%"
    description: "Percentage with rendered RTT"
    sql: ${percentile_of_rtt_bin_50_150}/NULLIF((${percentile_of_rtt_bin_u50}+${percentile_of_rtt_bin_50_150}+${percentile_of_rtt_bin_o150}),0) ;;
  }

  measure: percentile_of_rtt_bin_o150 { 
    view_label: "Measures"
    group_item_label: "% of RTT Over 150"
    label: "Percentile of RTT Over 150"
    type: number
    value_format: "#,##0%"
    description: "Percentage with rendered RTT"
    sql: ${percentile_of_rtt_bin_o150}/NULLIF((${percentile_of_rtt_bin_u50}+${percentile_of_rtt_bin_50_150}+${percentile_of_rtt_bin_o150}),0) ;;
  }

  measure: sum_of_cores_bin_2_4 { 
    view_label: "Measures"
    group_item_label: "Sum of CoresBin 2 To 4 Sec"
    label: "Sum of CoresBin 2 To 4 Sec"
    type: sum
    sql: ${TABLE}.CORES_BIN_2_4 ;;
  }

  measure: sum_of_cores_bin_4_8 { 
    view_label: "Measures"
    group_item_label: "Sum of CoresBin 4 To 8 Sec"
    label: "Sum of CoresBin 4 To 8 Sec"
    type: sum
    sql: ${TABLE}.CORES_BIN_4_8 ;;
  }

  measure: sum_of_cores_bin_o8 { 
    view_label: "Measures"
    group_item_label: "Sum of CoresBin Over 8 Sec"
    label: "Sum of CoresBin Over 8 Sec"
    type: sum
    sql: ${TABLE}.CORES_BIN_O8  ;;
  }

  measure: sum_of_cores_bin_u2 { 
    view_label: "Measures"
    group_item_label: "Sum of CoresBin Under 2 Sec"
    label: "Sum of CoresBin Under 2 Sec"
    type: sum
    sql: ${TABLE}.CORES_BIN_U2 ;;
  }

  measure: sum_of_dwnlnk_bin_3_5 { 
    view_label: "Measures"
    group_item_label: "Sum of Downlink 3 To 5 Frequency"
    label: "Sum of Downlink 3 To 5 Frequency"
    type: sum
    sql: ${TABLE}.DWNLNK_BIN_3_5 ;;
  }

  measure: sum_of_dwnlnk_bin_5_8 { 
    view_label: "Measures"
    group_item_label: "Sum of Downlink 5 To 8 Frequency"
    label: "Sum of Downlink 5 To 8 Frequency"
    type: sum
    sql: ${TABLE}.DWNLNK_BIN_5_8 ;;
  }

  measure: sum_of_dwnlnk_bin_8_10 { 
    view_label: "Measures"
    group_item_label: "Sum of Downlink 8 To 10 Frequency"
    label: "Sum of Downlink 8 To 10 Frequency"
    type: sum
    sql: ${TABLE}.DWNLNK_BIN_8_10 ;;
  }

  measure: sum_of_dwnlnk_bin_o10 { 
    view_label: "Measures"
    group_item_label: "Sum of Downlink Over 10 Frequency"
    label: "Sum of Downlink Over 10 Frequency"
    type: sum
    sql: ${TABLE}.DWNLNK_BIN_O10 ;;
  }

  measure: sum_of_dwnlnk_bin_over8 { 
    view_label: "Measures"
    group_item_label: "Sum of Downlink Over 8 Frequency"
    label: "Sum of Downlink Over 8 Frequency"
    type: number
    sql: ${dwnlnk_bin_8_10} + ${dwnlnk_bin_o10} ;;
  }

  measure: sum_of_dwnlnk_bin_u3 { 
    view_label: "Measures"
    group_item_label: "Sum of Downlink Under 3 Frequency"
    label: "Sum of Downlink Under 3 Frequency"
    type: sum
    sql: ${TABLE}.DWNLNK_BIN_U3 ;;
  }

  measure: sum_of_ept_bin_3_5 { 
    view_label: "Measures"
    group_item_label: "Sum of EPT 3 To 5 Sec"
    label: "Sum of EPT 3 To 5 Sec"
    type: sum
    sql: ${TABLE}.EPT_BIN_3_5  ;;
  }

  measure: sum_of_ept_bin_3_5_sales { 
    view_label: "Measures"
    group_item_label: "Sum of EPT 3 To 5 Sec (Sales)"
    label: "Sum of EPT 3 To 5 Sec (Sales)"
    type: sum
    filters: {field=of_user.sales_service_profile, condition=Sales Cloud}
    sql: ${TABLE}.EPT_BIN_3_5  ;;
  }

  measure: sum_of_ept_bin_3_5_svc { 
    view_label: "Measures"
    group_item_label: "Sum of EPT 3 To 5 Sec (Service)"
    label: "Sum of EPT 3 To 5 Sec (Service)"
    type: sum
    filters: {field=of_user.sales_service_profile, condition=Service Cloud}
    sql: ${TABLE}.EPT_BIN_3_5  ;;
  }

  measure: sum_of_ept_bin_5_8 { 
    view_label: "Measures"
    group_item_label: "Sum of EPT 5 To 8 Sec"
    label: "Sum of EPT 5 To 8 Sec"
    type: sum
    sql: ${TABLE}.EPT_BIN_5_8 ;;
  }

  measure: sum_of_ept_bin_8_10 { 
    view_label: "Measures"
    group_item_label: "Sum of EPT 8 To 10 Sec"
    label: "Sum of EPT 8 To 10 Sec"
    type: sum
    sql: ${TABLE}.EPT_BIN_8_10 ;;
  }

  measure: sum_of_ept_bin_o10 { 
    view_label: "Measures"
    group_item_label: "Sum of EPT Over 10 Sec"
    label: "Sum of EPT Over 10 Sec"
    type: sum
    sql: ${TABLE}.EPT_BIN_O10 ;;
  }

  measure: sum_of_ept_bin_over5 { 
    view_label: "Measures"
    group_item_label: "Sum of EPT Over 5 Sec"
    label: "Sum of EPT Over 5 Sec"
    type: number
    sql: ${sum_of_ept_bin_5_8} + ${sum_of_ept_bin_8_10} + ${sum_of_ept_bin_o10} ;;
  }

  measure: sum_of_ept_bin_u3 { 
    view_label: "Measures"
    group_item_label: "Sum of EPT Under 3 Sec"
    label: "Sum of EPT Under 3 Sec"
    type: sum
    sql: ${TABLE}.EPT_BIN_U3 ;;
  }

  measure: sum_of_ept_bin_u3_sales { 
    view_label: "Measures"
    group_item_label: "Sum of EPT Under 3 Sec (Sales)"
    label: "Sum of EPT Under 3 Sec (Sales)"
    type: sum
    filters: {condition=Sales Cloud, field=of_user.sales_service_profile}
    sql: ${TABLE}.EPT_BIN_U3 ;;
  }

  measure: sum_of_ept_bin_u3_svc { 
    view_label: "Measures"
    group_item_label: "Sum of EPT Under 3 Sec (Service)"
    label: "Sum of EPT Under 3 Sec (Service)"
    type: sum
    filters: {condition=Service Cloud, field=of_user.sales_service_profile}
    sql: ${TABLE}.EPT_BIN_U3 ;;
  }

  measure: sum_of_ept_bin_under5 { 
    view_label: "Measures"
    group_item_label: "Sum of EPT Under 5 Sec"
    label: "Sum of EPT Under 5 Sec"
    type: number
    sql: ${sum_of_ept_bin_u3} + ${sum_of_ept_bin_3_5} ;;
  }

  measure: sum_of_ept_bin_under5_sales { 
    view_label: "Measures"
    group_item_label: "Sum of EPT Under 5 Sec (Sales)"
    label: "Sum of EPT Under 5 Sec (Sales)"
    type: number
    sql: ${sum_of_ept_bin_u3_sales} + ${sum_of_ept_bin_3_5_sales} ;;
  }

  measure: sum_of_ept_bin_under5_svc { 
    view_label: "Measures"
    group_item_label: "Sum of EPT Under 5 Sec (Service)"
    label: "Sum of EPT Under 5 Sec (Service)"
    type: number
    sql: ${sum_of_ept_bin_u3_svc} + ${sum_of_ept_bin_3_5_svc} ;;
  }

  measure: sum_of_rtt_bin_50_150 { 
    view_label: "Measures"
    group_item_label: "Sum of RTT 50 To 150"
    label: "Sum of RTT 50 To 150"
    type: sum
    sql: ${TABLE}.RTT_BIN_50_150 ;;
  }

  measure: sum_of_rtt_bin_o150 { 
    view_label: "Measures"
    group_item_label: "Sum of RTT Over 150"
    label: "Sum of RTT Over 150"
    type: sum
    sql: ${TABLE}.RTT_BIN_O150 ;;
  }

  measure: sum_of_rtt_bin_u50 { 
    view_label: "Measures"
    group_item_label: "Sum of RTT Under 50"
    label: "Sum of RTT Under 50"
    type: sum
    sql: ${TABLE}.RTT_BIN_U50 ;;
  }

  
  
 }



view: dmc_period_mtrc_gdt {
  dimension: accqtr_desc { 
    view_label: "Lightning Usage"
    group_label: "Metrics Date (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Metrics Date Fiscal Quarter (YYYY/QQ)"
    sql: ${TABLE}.MTRC_DT ;;
  }

  dimension: iso_yrwk_desc { 
    view_label: "Lightning Usage"
    group_label: "Metrics Date (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Metrics Date Week of Year (YYYY/WW)"
    sql: ${TABLE}.MTRC_DT ;;
  }

  dimension: yrmon_desc { 
    view_label: "Lightning Usage"
    group_label: "Metrics Date (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Metrics Date Month (YYYY/MM)"
    sql: ${TABLE}.MTRC_DT ;;
  }

  dimension: yrqtr_desc { 
    view_label: "Lightning Usage"
    group_label: "Metrics Date (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Metrics Date Calendar Quarter (YYYY/QQ)"
    sql: ${TABLE}.MTRC_DT ;;
  }

 }



view: dmo_usr_svc_ept {
  dimension: cnt_cd { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "09. Country Code"
    label: "User Office Country Code"
    type: string
  }

  dimension: cnt_nm { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "10. Country Name"
    label: "User Office Country Name"
    type: string
    sql: CASE TRIM( SUBSTR( ${TABLE}.Office_Code, INSTR( ${TABLE}.Office_Code, '-', -1 )+1 ) )
  WHEN 'TSNBB' then 'China North'
  WHEN 'SJWBB' then 'China North'
  WHEN 'DLCBB' then 'China North'
  WHEN 'SHABB' then 'China Central'
  WHEN 'LYGBB' then 'China North'
  WHEN 'NKGBB' then 'China Central'
  WHEN 'SZHBB' then 'China Central'
  WHEN 'HGHBB' then 'China Central'
  WHEN 'JIXBB' then 'China Central'
  WHEN 'NBOBB' then 'China Central'
  WHEN 'HFEBB' then 'China Central'
  WHEN 'FOCBB' then 'HK & China South'
  WHEN 'XMNBB' then 'HK & China South'
  WHEN 'TAOBB' then 'China North'
  WHEN 'CGOBB' then 'China North'
  WHEN 'WUHBB' then 'China Central'
  WHEN 'CANBB' then 'HK & China South'
  WHEN 'SWABA' then 'HK & China South'
  WHEN 'SZPBB' then 'HK & China South'
  WHEN 'ZHOBB' then 'HK & China South'
  WHEN 'ZHUBB' then 'HK & China South'
  WHEN 'CKGBB' then 'China Central'
  WHEN 'CTUBB' then 'China Central'
  WHEN 'SIABB' then 'China North'
  WHEN 'HKGBB' then 'HK & China South'
  WHEN 'HKGHQ' then 'HK & China South'
  WHEN 'MACBA' then 'HK & China South'
  WHEN 'SELBB' then 'Korea Republic Of'
  WHEN 'PUSBB' then 'Korea Republic Of'
        ELSE
  TRIM( SUBSTR (${TABLE}.Office_Code, 1, STRPOS(${TABLE}.Office_Code, '-') -2))
        END  ;;
  }

  dimension: conti_cd { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "15. Continent Code"
    label: "User Office Continent Code"
    type: string
  }

  dimension: conti_nm { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "16. Continent Name"
    label: "User Office Continent Name"
    type: string
  }

  dimension: full_name { 
    view_label: "User"
    group_item_label: "Full Name"
    label: "Full Name"
    type: string
    sql: concat(${first_name}," ",${last_name})  ;;
  }

  dimension: isactive { 
    view_label: "User"
    group_item_label: "Is Active? (Yes/No)"
    label: "Is Active?"
    type: string
    sql: ${TABLE}.isactive  ;;
  }

  dimension: loc_cd { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "03. Location Code"
    label: "User Office Location Code"
    type: string
  }

  dimension: loc_nm { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "04. Location Name"
    label: "User Office Location Name"
    type: string
  }

  dimension: ofc_eng_nm { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "02. Name"
    label: "User Office Name"
    type: string
  }

  dimension: ofc_tp_nm { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "18. Type"
    label: "User Office Type"
    type: string
    sql: IFNULL(${TABLE}.OfficeType,'Others')  ;;
  }

  dimension: office_code { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "01. Code"
    label: "User Office Code"
    type: string
    sql: `ONEFORCE.offshore_ofc_cd_conv`(${TABLE}.Office_Code_Number)   ;;
  }

  dimension: profile_group_name { 
    view_label: "User"
    group_item_label: "Profile Group Name"
    label: "Profile Group Name"
    type: string
    sql: CASE WHEN ${profile_name} = 'Sales Executive'
  OR ${profile_name} = 'Sales Manager'
  OR ${profile_name} = 'Trade Marketing'
  OR ${profile_name} = 'Third Party Agent'
  OR ${profile_name} = 'Customer Care Agent'
  OR ${profile_name} = 'Customer Care Supervisor'
  OR ${profile_name} = 'TPA (Service Cloud) CCA'
  OR ${profile_name} = 'TPA (Service Cloud) CCS'
  THEN ${profile_name}
  ELSE "Others" END ;;
  }

  dimension: rgn_cd { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "11. Region Code"
    label: "User Office Region Code"
    type: string
  }

  dimension: rgn_nm { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "12. Region Name"
    label: "User Office Region Name"
    type: string
  }

  dimension: rhq_cd { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "17. RHQ"
    label: "User Office RHQ"
    type: string
  }

  dimension: sales_service_profile { 
    view_label: "User"
    group_item_label: "Is Sales or Service Profile? (Yes/No)"
    label: "Is Sales or Service Profile?"
    type: string
    sql: CASE WHEN ${profile_name} = 'Sales Executive'
  OR ${profile_name} = 'Sales Manager'
  OR ${profile_name} = 'Trade Marketing'
  OR ${profile_name} = 'Third Party Agent' THEN 'Sales Cloud'
  WHEN ${profile_name} = 'Customer Care Agent'
  OR ${profile_name} = 'Customer Care Supervisor'
  OR ${profile_name} = 'TPA (Service Cloud) CCA'
  OR ${profile_name} = 'TPA (Service Cloud) CCS' THEN 'Service Cloud'
  ELSE null END ;;
  }

  dimension: sconti_cd { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "13. Subcontinent Code"
    label: "User Office Subcontinent Code"
    type: string
  }

  dimension: sconti_nm { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "14. Subcontinent Name"
    label: "User Office Subcontinent Name"
    type: string
  }

  dimension: ste_cd { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "05. State Code"
    label: "User Office State Code"
    type: string
  }

  dimension: ste_nm { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "06. State Name"
    label: "User Office State Name"
    type: string
  }

  dimension: sub_cnt_cd { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "07. Sub Country Code"
    label: "User Office Sub Country Code"
    type: string
  }

  dimension: sub_cnt_nm { 
    view_label: "User"
    group_label: "Office"
    group_item_label: "08. Sub Country Name"
    label: "User Office Sub Country Name"
    type: string
  }

  dimension: user_role_name { 
    view_label: "User"
    group_item_label: "User Role Name"
    label: "User Role Name"
    type: string
    sql: ${TABLE}.User_Role_Name  ;;
  }

 }



view: ept_pdt {
  dimension: ept_record_count { 
    hidden: No
    view_label: "Measures"
    group_item_label: "EPT Record Count"
    label: "Count of EPT Record"
    type: number
    description: "This is a dimensionalized EPT Record Count"
    sql: ept_pdt.ept_record_count ;;
  }

 }

