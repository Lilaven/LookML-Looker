view: of_dep_sched_smry {
  sql_table_name: `ONEFORCE.OF_DEP_SCHED_SMRY`
    ;;

  dimension: bsa_ttl_teu_quantity {
    label: "BSA TTL TEU Quantity"
    type: number
    sql: ${TABLE}.BSA_TTL_TEU_Quantity ;;
  }

  dimension: delay {
    label: "Delay"
    type: number
    sql: ${TABLE}.Delay ;;
  }

  dimension: dominant_leg_flag {
    label: "DOM/N-DOM"
    type: string
    sql: ${TABLE}.Dominant_Leg_Flag ;;
  }

  dimension: record_id {
    primary_key: yes
    label: "Record Id"
    type: string
    sql: ${TABLE}.Record_Id ;;
    hidden: yes
  }

  dimension: sales_week {
    label: "Scheduled Week"
    type: string
    sql: ${TABLE}.Sales_Week ;;
  }

  dimension: seq_check {
    label: "Seq Check"
    type: string
    sql: ${TABLE}.SEQ_CHECK ;;
  }

  dimension: service_lane {
    label: "Service Lane (Rev)"
    type: string
    sql: ${TABLE}.Service_Lane ;;
  }

  dimension: trade_code {
    label: "Service Scope Group"
    type: string
    sql: ${TABLE}.Trade_Code ;;
  }

  dimension: schedule_status {
    label: "Schedule Status"
    type: string
    sql: ${TABLE}.Schedule_Status ;;
  }

  dimension: is_loader {
    label: "Is Loader"
    type: string
    sql: ${TABLE}.Is_Loader ;;
  }

  measure: c_loader {
    label: "No of Loader Sailing"
    type: count
    filters: [is_loader: "Yes", schedule_status: "Scheduled"]
    drill_fields: []
  }
  measure: c_sailing {
    label: "No of Total Sailing"
    type: count
  }

  measure: sailing_satus {
    label: "Sailing Status"
    type: list
    list_field: schedule_status
  }
  measure: c_scheduled {
    label: "No of Scheduled Sailing"
    type: count
    filters: [schedule_status: "Scheduled"]
    drill_fields: []
  }

  measure: c_scheduled_wo_ldr {
    label: "No of Scheduled without Loader"
    type: number
    sql:  ${c_scheduled}-${c_loader} ;;
    drill_fields: []
  }

  measure: c_void {
    label: "No of Void Sailing"
    type: count
    filters: [schedule_status: "Void"]
    drill_fields: []
  }

  measure: c_void_wo_ldr {
    label: "No of Void Sailing without Loader"
    type: number
    sql:
      CASE
        WHEN ${c_void} > 0 THEN ${c_void}-${c_loader}
        ELSE ${c_void}
      END ;;
  }

  measure: c_phaseout {
    label: "No of Phaseout Sailing"
    type: count
    filters: [schedule_status: "No Schedule"]
    drill_fields: []
  }

  measure: total_schedule {
    label: "Total Schedule"
    type: number
    sql: ${c_scheduled}+${c_void};;
  }
  measure: scheduled_wo_wk_perc {
    label: "Sailing without loader %"
    type: number
    sql: (${c_scheduled_wo_ldr}/NULLIF(${c_scheduled}+${c_void},0))*100;;
    #value_format_name: decimal_0
    #DCN-484 : correct the format
    value_format: "0\%"
  }
  measure: scheduled_wk_perc {
    label: "Schedule %"
    type: number
    sql: (${c_scheduled}/NULLIF(${c_scheduled}+${c_void_wo_ldr},0))*100;;
    value_format_name: decimal_0
    #DCN-484 : temporarily changed it to decimal_2 for checking
    #value_format_name: decimal_2
  }
  measure: vms_wk_perc {
    label: "Void without loader %"
    type: number
    sql: (${c_void_wo_ldr}/NULLIF(${c_scheduled}+${c_void},0))*100;;
    #value_format_name: decimal_0
    #DCN-484 : correct the format
    value_format: "0\%"
  }

  measure: loader_wk_perc {
    label: "Loader %"
    type: number
    sql: (${c_loader}/NULLIF(${c_scheduled}+${c_void},0))*100;;
    #value_format_name: decimal_0
    #DCN-484 : correct the format
    value_format: "0.00\%"
  }


  parameter: show_or_hide_vms_target {
# change by Helen on 20210823
  label: "Target(with VMS adjustment)"
  type: string
  allowed_value: {
    label: "Yes"
    value: "Show"
  }
  allowed_value: {
    label: "No"
    value: "Hide"
  }
# end change by Helen on 20210823
  default_value: "Hide"
}

measure: sched_target{
  #label: "Target (without VMS) TEU" #Jack DCN-484 - correct label
  label: "Adjusted Target (TEU)"
  type: number
#    sql:
#        CASE
#            WHEN {% parameter show_or_hide_vms_target %} = 'Show' THEN
#                  (${of_consolidated.total_target_teu} * ceiling(${scheduled_wk_perc}))/100
#            WHEN {% parameter show_or_hide_vms_target %} = 'Hide' THEN NULL
#        END ;;
#Jack DCN-484 : to handle looker issue of wrongly generating NULL as 'cast(null as numerci(38,0) )'
  sql:
      {% if show_or_hide_vms_target._parameter_value == "'Show'" %}
        (${of_consolidated.total_target_teu} * ceiling(${scheduled_wk_perc}))/100
      {% else %}
        NULL
      {% endif %};;
  value_format_name: decimal_0
}

#Jack DCN-484 : start

measure: sched_target_till_last_complete_mth{
  label: "Adjusted Target (TEU) - Till Last Mth"
  type: number
#    sql:
#        CASE
#            WHEN {% parameter show_or_hide_vms_target %} = 'Show' THEN
#                  (${of_consolidated.total_target_teu_till_last_complete_mth} * ceiling(${scheduled_wk_perc}))/100
#            WHEN {% parameter show_or_hide_vms_target %} = 'Hide' THEN NULL
#        END ;;
#Jack DCN-484 : to handle looker issue of wrongly generating NULL as 'cast(null as numerci(38,0) )'
  sql:
      {% if show_or_hide_vms_target._parameter_value == "'Show'" %}
        (${of_consolidated.total_target_teu_till_last_complete_mth} * ceiling(${scheduled_wk_perc}))/100
      {% else %}
        NULL
      {% endif %};;
  value_format_name: decimal_0
}

#Jack DCN-484 : end


##  measure: teu_sched_achievement {
##    label: "Achievement (without VMS)"
##    type: number
##    sql:
##      CASE
##        WHEN {% parameter show_or_hide_vms_target %} = 'Show' THEN
##          ${of_consolidated.total_actual_teu} / NULLIF(${sched_target},0)
##        ELSE
##          NULL
##      END ;;
##    value_format_name: percent_0
##  }

measure: teu_sched_achievement {
  #label: "Achievement (without VMS)" #Jack DCN-484 - correct label
  label: "Adjusted Achievement"
  type: number
#    sql:
#      CASE
#        WHEN {% parameter show_or_hide_vms_target %} = 'Show' THEN
#          ${of_consolidated.total_booking_teu} / NULLIF(${sched_target},0)
#        ELSE
#          NULL
#      END ;;
#Jack DCN-484 : to handle looker issue of wrongly generating NULL as 'cast(null as numerci(38,0) )'
  sql:
      {% if show_or_hide_vms_target._parameter_value == "'Show'" %}
        ${of_consolidated.total_booking_teu} / NULLIF(${sched_target},0)
      {% else %}
        NULL
      {% endif %};;
  value_format_name: percent_0
}

#Jack DCN-484 : start

measure: teu_sched_achievement_till_last_complete_mth {
  #label: "Achievement (without VMS)" #Jack DCN-484 - correct label
  label: "Adjusted Achievement - till last complete mth"
  type: number
  sql:
      {% if show_or_hide_vms_target._parameter_value == "'Show'" %}
        ${of_consolidated.total_booking_teu_till_last_complete_mth} / NULLIF(${sched_target_till_last_complete_mth},0)
      {% else %}
        NULL
      {% endif %};;
  value_format_name: percent_0
}

#Jack DCN-484 : end


##  measure: teu_sched_variance {
##    label: "Variance (without VMS)"
##    type: number
##    sql:
##      CASE
##        WHEN {% parameter show_or_hide_vms_target %} = 'Show' THEN
##           ${of_consolidated.total_actual_teu} - ${sched_target}
##        ELSE
##         NULL
##        END ;;
##    value_format_name: decimal_0
##  }

measure: teu_sched_variance {
  label: "Variance (without VMS)"
  type: number
  sql:
      CASE
        WHEN {% parameter show_or_hide_vms_target %} = 'Show' THEN
           ${of_consolidated.total_booking_teu} - ${sched_target}
        ELSE
         NULL
        END ;;
  value_format_name: decimal_0
}

}

view: of_dep_sched_smry2 {
  sql_table_name: `ONEFORCE.OF_DEP_SCHED_SMRY`
    ;;

  dimension: bsa_ttl_teu_quantity {
    label: "BSA TTL TEU Quantity"
    type: number
    sql: ${TABLE}.BSA_TTL_TEU_Quantity ;;
  }

  dimension: delay {
    label: "Delay"
    type: number
    sql: ${TABLE}.Delay ;;
  }

  dimension: dominant_leg_flag {
    label: "DOM/N-DOM"
    type: string
    sql: ${TABLE}.Dominant_Leg_Flag ;;
  }

  dimension: record_id {
    primary_key: yes
    label: "Record Id"
    type: string
    sql: ${TABLE}.Record_Id ;;
    hidden: yes
  }

  dimension: sales_week {
    label: "Scheduled Week"
    type: string
    sql: ${TABLE}.Sales_Week ;;
  }

  dimension: seq_check {
    label: "Seq Check"
    type: string
    sql: ${TABLE}.SEQ_CHECK ;;
  }

  dimension: service_lane {
    label: "Service Lane (Rev)"
    type: string
    sql: ${TABLE}.Service_Lane ;;
  }

  dimension: trade_code {
    label: "Service Scope Group"
    type: string
    sql: ${TABLE}.Trade_Code ;;
  }

  dimension: schedule_status {
    label: "Schedule Status"
    type: string
    sql: ${TABLE}.Schedule_Status ;;
  }

  dimension: is_loader {
    label: "Is Loader"
    type: string
    sql: ${TABLE}.Is_Loader ;;
  }

  measure: c_loader {
    label: "No of Loader Sailing"
    type: count
    filters: [is_loader: "Yes", schedule_status: "Scheduled"]
    drill_fields: []
  }
  measure: c_sailing {
    label: "No of Total Sailing"
    type: count
  }

  measure: sailing_satus {
    label: "Sailing Status"
    type: list
    list_field: schedule_status
  }
  measure: c_scheduled {
    label: "No of Scheduled Sailing"
    type: count
    filters: [schedule_status: "Scheduled"]
    drill_fields: []
  }

  measure: c_scheduled_wo_ldr {
    label: "No of Scheduled without Loader"
    type: number
    sql:  ${c_scheduled}-${c_loader} ;;
    drill_fields: []
  }

  measure: c_void {
    label: "No of Void Sailing"
    type: count
    filters: [schedule_status: "Void"]
    drill_fields: []
  }

  measure: c_void_wo_ldr {
    label: "No of Void Sailing without Loader"
    type: number
    sql:
      CASE
        WHEN ${c_void} > 0 THEN ${c_void}-${c_loader}
        ELSE ${c_void}
      END ;;
  }

  measure: c_phaseout {
    label: "No of Phaseout Sailing"
    type: count
    filters: [schedule_status: "No Schedule"]
    drill_fields: []
  }

  measure: total_schedule {
    label: "Total Schedule"
    type: number
    sql: ${c_scheduled}+${c_void};;
  }
  measure: scheduled_wo_wk_perc {
    label: "Sailing without loader %"
    type: number
    sql: (${c_scheduled_wo_ldr}/NULLIF(${c_scheduled}+${c_void},0))*100;;
    #value_format_name: decimal_0
    #DCN-484 : correct the format
    value_format: "0\%"
  }
  measure: scheduled_wk_perc {
    label: "Schedule %"
    type: number
    sql: (${c_scheduled}/NULLIF(${c_scheduled}+${c_void_wo_ldr},0))*100;;
    value_format_name: decimal_0
    #DCN-484 : temporarily changed it to decimal_2 for checking
    #value_format_name: decimal_2
  }
  measure: vms_wk_perc {
    label: "Void without loader %"
    type: number
    sql: (${c_void_wo_ldr}/NULLIF(${c_scheduled}+${c_void},0))*100;;
    #value_format_name: decimal_0
    #DCN-484 : correct the format
    value_format: "0\%"
  }

  measure: loader_wk_perc {
    label: "Loader %"
    type: number
    sql: (${c_loader}/NULLIF(${c_scheduled}+${c_void},0))*100;;
    #value_format_name: decimal_0
    #DCN-484 : correct the format
    value_format: "0.00\%"
  }


  parameter: show_or_hide_vms_target {
# change by Helen on 20210823
  label: "Target(with VMS adjustment)"
  type: string
  allowed_value: {
    label: "Yes"
    value: "Show"
  }
  allowed_value: {
    label: "No"
    value: "Hide"
  }
# end change by Helen on 20210823
  default_value: "Hide"
}

#measure: sched_target{
#  label: "Adjusted Target (TEU)"
#  type: number
#  sql:
#      {% if show_or_hide_vms_target._parameter_value == "'Show'" %}
#        (${of_consolidated2.total_target_teu} * ceiling(${scheduled_wk_perc}))/100
#      {% else %}
#        NULL
#      {% endif %};;
#  value_format_name: decimal_0
#}


#measure: teu_sched_achievement {
#  #label: "Achievement (without VMS)" #Jack DCN-484 - correct label
#  label: "Adjusted Achievement"
#  type: number
#  sql:
#      {% if show_or_hide_vms_target._parameter_value == "'Show'" %}
#        ${of_consolidated2.total_booking_teu} / NULLIF(${sched_target},0)
#      {% else %}
#        NULL
#      {% endif %};;
#  value_format_name: percent_0
#}

#measure: teu_sched_variance {
#  label: "Variance (without VMS)"
#  type: number
#  sql:
#      CASE
#        WHEN {% parameter show_or_hide_vms_target %} = 'Show' THEN
#           ${of_consolidated2.total_booking_teu} - ${sched_target}
#        ELSE
#         NULL
#        END ;;
#  value_format_name: decimal_0
#}

### Measures till last complete week <<start>>
measure: c_loader_till_last_cmpl_wk {
  type: count
  filters: [is_loader: "Yes", schedule_status: "Scheduled", of_sales_week_master.is_till_last_cmpl_wk: "yes"]
  drill_fields: []
}

measure: c_void_till_last_cmpl_wk {
  type: count
  filters: [schedule_status: "Void", of_sales_week_master.is_till_last_cmpl_wk: "yes"]
  drill_fields: []
}

measure: c_scheduled_till_last_cmpl_wk {
  type: count
  filters: [schedule_status: "Scheduled", of_sales_week_master.is_till_last_cmpl_wk: "yes"]
  drill_fields: []
}

measure: c_void_wo_ldr_till_last_cmpl_wk {
  type: number
  sql:
      CASE
        WHEN ${c_void_till_last_cmpl_wk} > 0 THEN ${c_void_till_last_cmpl_wk}-${c_loader_till_last_cmpl_wk}
        ELSE ${c_void_till_last_cmpl_wk}
      END ;;
}

measure: scheduled_wk_perc_last_cmpl_wk {
  type: number
  sql: (${c_scheduled_till_last_cmpl_wk}/NULLIF(${c_scheduled_till_last_cmpl_wk}+${c_void_wo_ldr_till_last_cmpl_wk},0))*100;;
  value_format_name: decimal_0
}


### Measures till last complete week <<end>>

}

view: of_plan_week {

  #sql_table_name:  `ONEFORCE.OF_PLAN_WEEK`;; change for dcn591 extend AP DB visibilty to 6 weeks ahead.
  derived_table: {
    sql: select sales_week from ONEFORCE.OF_PLAN_WEEK
         union all
         (select cast(sales_week as int64)
          from ONEFORCE.OF_SALES_WEEK_MASTER
          where cast ( sales_week as int64)  > ( select max(sales_week) from ONEFORCE.OF_PLAN_WEEK) order by 1 limit 6)
;;
  }


  dimension: sales_week {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.Sales_Week ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

view: of_vms_smry {
  sql_table_name: `ONEFORCE.OF_VMS_SMRY`
    ;;

  dimension: schedule_status {
    type: string
    sql: ${TABLE}.Schedule_Status ;;
  }

  dimension: record_id {
    type: string
    sql: ${TABLE}.Record_Id ;;
  }

  dimension: sales_week {
    type: string
    sql: ${TABLE}.Sales_Week ;;
  }

  dimension: service_lane {
    type: string
    sql: ${TABLE}.Service_Lane ;;
  }

  measure: schedule_id {
    type: list
    list_field: schedule_status
  }

  measure: count {
    type: count
    drill_fields: []
  }

}

view: first_case_transfer_history {
  derived_table: {
    sql:
    SELECT *EXCEPT(RowNumber) FROM
      (SELECT DISTINCT
        of_case.CaseNumber AS CaseNumber,
        case when
            ((CASE WHEN transfer_by.FirstName IS NULL THEN transfer_by.LastName
               WHEN transfer_by.LastName IS NULL THEN transfer_by.FirstName
               ELSE  concat(transfer_by.FirstName," ",transfer_by.LastName) END)) is not null
        then ((CASE WHEN transfer_by.FirstName IS NULL THEN transfer_by.LastName
                    WHEN transfer_by.LastName IS NULL THEN transfer_by.FirstName
                    ELSE  concat(transfer_by.FirstName," ",transfer_by.LastName) END)) end AS Transfer_by_name,
        transfer_by.office_code_number  AS Transfer_by_office,
        case_transfer_history.Transfer_Reason,
        case_transfer_history.Transfer_Date_Time,
        ROW_NUMBER() OVER(PARTITION BY of_case.CaseNumber ORDER BY case_transfer_history.Transfer_Date_Time ASC) as RowNumber
        FROM `ONEFORCE.OF_CASE`
           AS of_case
        LEFT JOIN `ONEFORCE.OF_CASE_TRANSFER_HISTORY`
           AS case_transfer_history ON case_transfer_history.Case = of_case.ONEForce_Id
        LEFT JOIN `ONEFORCE.OF_USER`
          AS transfer_by ON transfer_by.ONEForce_ID = case_transfer_history.Transfer_by
        WHERE of_case.IsTransfer = 'true')
    WHERE RowNumber = 1
    ORDER BY CaseNumber
    ;;

    persist_for: "2 hours"
  }

  dimension: Transfer_by_name {
    label:"Transfer by Name"
    type: string
    sql: ${TABLE}.Transfer_by_name ;;
  }

  dimension: Transfer_by_office {
    label:"Transfer by Office"
    type: string
    sql: ${TABLE}.Transfer_by_office ;;
  }

  dimension: Transfer_Reason {
    label:"Transfer Reason"
    type: string
    sql: ${TABLE}.Transfer_Reason ;;
  }

  dimension: CaseNumber {
    label:"Case Number"
    type: string
    sql: ${TABLE}.CaseNumber ;;
  }
}

view: tender_contract_current {
  derived_table: {
    sql: select 'CURR' as record_type, PARSE_DATE("%m/%d/%Y",a.report_dt) report_dt,
              g.cust_grp_nm as cust_grp_nm,
              a.cust_grp_id,
              a.tender_nm,
              a.ckam,
              a.manual_actual_flag,
              trim(b) as svc_cont_no,
              a.record_id,
              PARSE_DATE("%m/%d/%Y",a.curr_cont_start_dt) as cont_start_dt,
              PARSE_DATE("%m/%d/%Y",a.curr_cont_end_dt) as cont_end_dt,
              FORMAT_DATE("%Y%m",PARSE_DATE("%m/%d/%Y",a.curr_cont_end_dt)) as cont_end_month,
              date_diff(PARSE_DATE("%m/%d/%Y",a.curr_cont_end_dt),PARSE_DATE("%m/%d/%Y",a.curr_cont_start_dt),MONTH)+1 as cont_duration,
              least(12,date_diff(PARSE_DATE("%m/%d/%Y",a.curr_cont_end_dt),PARSE_DATE("%m/%d/%Y",a.curr_cont_start_dt),MONTH)+1) as cont_dur_uplmt,
              w2.sales_week,
              w.fiscal_year,
              RIGHT(a.curr_cont_start_dt,4) as calendar_year,
              a.remarks,
              coalesce(a.visible,'C') as visible,
              FORMAT_DATE("%Y%m",PARSE_DATE("%m/%d/%Y", a.curr_cont_start_dt))  as scrfa_start_month
              from `ONEFORCE.V_TENDER_CONTRACT` a,
              unnest(split(curr_svc_cont_no,",")) b
              inner join ${of_sales_week_master.SQL_TABLE_NAME} w  on PARSE_DATE("%m/%d/%Y", a.curr_cont_start_dt) between w.week_start_date and w.week_end_date
              inner join ${of_sales_week_master.SQL_TABLE_NAME} w2  on PARSE_DATE("%m/%d/%Y", a.report_dt) between w2.week_start_date and w2.week_end_date
              inner join ${of_customer_group.SQL_TABLE_NAME} g on a.cust_grp_id = g.cust_grp_id
              where coalesce(a.visible,'C') <> 'N'
              union distinct
            select
            'CURR' as record_type, PARSE_DATE("%m/%d/%Y",a.report_dt) report_dt,
              g.cust_grp_nm as cust_grp_nm,
              a.cust_grp_id,
              a.tender_nm,
              a.ckam,
              a.manual_actual_flag,
              null as svc_cont_no,
              a.record_id,
              PARSE_DATE("%m/%d/%Y",a.curr_cont_start_dt)  as cont_start_dt,
              PARSE_DATE("%m/%d/%Y",a.curr_cont_end_dt) as cont_end_dt,
              FORMAT_DATE("%Y%m",PARSE_DATE("%m/%d/%Y",a.curr_cont_end_dt)) as cont_end_month,
              date_diff(PARSE_DATE("%m/%d/%Y",a.curr_cont_end_dt),PARSE_DATE("%m/%d/%Y",a.curr_cont_start_dt),MONTH)+1 as cont_duration,
              least(12,date_diff(PARSE_DATE("%m/%d/%Y",a.curr_cont_end_dt),PARSE_DATE("%m/%d/%Y",a.curr_cont_start_dt),MONTH)+1) as cont_dur_uplmt,
              w2.sales_week,
              w.fiscal_year,
              RIGHT(a.curr_cont_start_dt,4) as calendar_year,
              a.remarks,
              coalesce(a.visible,'C') as visible,
              null as scrfa_start_month
              from `ONEFORCE.V_TENDER_CONTRACT` a
              inner join ${of_sales_week_master.SQL_TABLE_NAME} w  on PARSE_DATE("%m/%d/%Y", a.curr_cont_start_dt) between w.week_start_date and w.week_end_date
              inner join ${of_sales_week_master.SQL_TABLE_NAME} w2 on PARSE_DATE("%m/%d/%Y", a.report_dt) between w2.week_start_date and w2.week_end_date
              inner join ${of_customer_group.SQL_TABLE_NAME} g on a.cust_grp_id = g.cust_grp_id
              where curr_svc_cont_no is null
              and coalesce(a.visible,'C') <> 'N'
  ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    hidden: yes
  }

  dimension: record_id {
    type: string
    sql: ${TABLE}.record_id
      primary key: yes;;
    hidden: yes
  }

  dimension: record_type {
    type: string
    sql: ${TABLE}.record_type ;;
    hidden: yes
  }

  dimension: report_dt {
    label: "Current: Report Date"
    type: date
    datatype: date
    sql: ${TABLE}.report_dt ;;
  }

  dimension: cust_grp_nm {
    label: "Current: Group Customer Name"
    type: string
    sql: ${TABLE}.cust_grp_nm ;;
  }

  dimension: cust_grp_id {
    label: "Current: Group Customer Code"
    type: string
    sql: ${TABLE}.cust_grp_id ;;
  }

  dimension: tender_nm {
    label: "Current: Tender Name"
    type: string
    sql: ${TABLE}.tender_nm ;;
  }

  dimension: visible {
    label: "Current: Visible"
    type: string
    sql: ${TABLE}.visible ;;
  }

  dimension: ckam {
    label: "Current: CKAM"
    type: string
    sql: ${TABLE}.ckam ;;
  }

  dimension: manual_actual_flag {
    label: "Current: Manual Actual Flag"
    type: string
    sql: ${TABLE}.manual_actual_flag ;;
  }

  dimension: svc_cont_no {
    label: "Current: SC/RFA Number"
    type: string
    sql: ${TABLE}.svc_cont_no ;;
  }

  dimension: cont_end_month {
    label: "Current: SC/RFA End Month"
    type: string
    sql: ${TABLE}.cont_start_month ;;
  }

  dimension: scrfa_start_month {
    label: "Current: SC/RFA Start Month"
    type: string
    sql: ${TABLE}.scrfa_start_month ;;
  }

  dimension: cont_start_dt {
    label: "Current: SC/RFA Eff Date"
    type: date
    datatype: date
    sql: ${TABLE}.cont_start_dt ;;
  }

  dimension: cont_end_dt {
    label: "Current: SC/RFA Exp Date"
    type: date
    datatype: date
    sql: ${TABLE}.cont_end_dt ;;
  }

  dimension: cont_duration {
    label: "Current: SC/RFA Duration"
    type: number
    sql: ${TABLE}.cont_duration ;;
  }

  dimension: cont_dur_uplmt {
    label: "Current: SC/RFA Duration Upper Limit"
    type: number
    sql: ${TABLE}.cont_dur_uplmt ;;
    hidden: yes
  }

  dimension: sales_week {
    label: "Current: Sales Week"
    type: string
    sql: ${TABLE}.sales_week ;;
  }

  dimension: fiscal_year {
    label: "Current: Fiscal Year"
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }

  dimension: calendar_year {
    label: "Current: Calendar Year"
    type: string
    sql: ${TABLE}.calendar_year ;;
  }

  dimension: remarks {
    label: "Current: Remarks"
    type: string
    sql: ${TABLE}.remarks ;;
  }

  set: detail {
    fields: [
      report_dt,
      cust_grp_nm,
      cust_grp_id,
      tender_nm,
      svc_cont_no,
      cont_start_dt,
      cont_end_dt
    ]
  }
}

view: tender_contract_previous {
  derived_table: {
    sql:select 'PREV' as record_type, PARSE_DATE("%m/%d/%Y",c.report_dt) report_dt,
              g.cust_grp_nm,
              c.cust_grp_id,
              c.tender_nm,
              c.ckam,
              c.manual_actual_flag,
              trim(d) as svc_cont_no,
              c.record_id,
              PARSE_DATE("%m/%d/%Y",c.prev_cont_start_dt) as cont_start_dt,
              PARSE_DATE("%m/%d/%Y",c.prev_cont_end_dt) as cont_end_dt,
              date_diff(PARSE_DATE("%m/%d/%Y",c.prev_cont_end_dt),PARSE_DATE("%m/%d/%Y",c.prev_cont_start_dt),MONTH)+1 as cont_duration,
              least(12,date_diff(PARSE_DATE("%m/%d/%Y",c.prev_cont_end_dt),PARSE_DATE("%m/%d/%Y",c.prev_cont_start_dt),MONTH)+1) as cont_dur_uplmt,
              w2.sales_week,
              w.fiscal_year,
              cast(cast(RIGHT(c.curr_cont_start_dt,4) as int64) - 1 as string) as calendar_year,
              c.remarks,
              coalesce(c.visible,'C') as visible,
              FORMAT_DATE("%Y%m",PARSE_DATE("%m/%d/%Y",c.curr_cont_start_dt)) as curr_scrfa_start_month
          from `ONEFORCE.V_TENDER_CONTRACT` c,
          unnest(split(prev_svc_cont_no,",")) d
          inner join ${of_sales_week_master.SQL_TABLE_NAME} w on PARSE_DATE("%m/%d/%Y", c.curr_cont_start_dt) between w.week_start_date and w.week_end_date
          inner join ${of_sales_week_master.SQL_TABLE_NAME} w2 on PARSE_DATE("%m/%d/%Y", c.report_dt) between w2.week_start_date and w2.week_end_date
          inner join ${of_customer_group.SQL_TABLE_NAME} g on g.cust_grp_id = c.cust_grp_id
          where coalesce(c.visible,'C') = 'C'
          union all
          select 'PREV' as record_type, PARSE_DATE("%m/%d/%Y",c1.report_dt) report_dt,
                  g1.cust_grp_nm,
                  c1.cust_grp_id,
                  c1.tender_nm,
                  c1.ckam,
                  c1.manual_actual_flag,
                  null as svc_cont_no,
                  c1.record_id,
                  PARSE_DATE("%m/%d/%Y",c1.prev_cont_start_dt) as cont_start_dt,
                  PARSE_DATE("%m/%d/%Y",c1.prev_cont_end_dt) as cont_end_dt,
                  date_diff(PARSE_DATE("%m/%d/%Y",c1.prev_cont_end_dt),PARSE_DATE("%m/%d/%Y",c1.prev_cont_start_dt),MONTH)+1 as cont_duration,
                  least(12,date_diff(PARSE_DATE("%m/%d/%Y",c1.prev_cont_end_dt),PARSE_DATE("%m/%d/%Y",c1.prev_cont_start_dt),MONTH)+1) as cont_dur_uplmt,
                  w21.sales_week,
                  w1.fiscal_year,
                  cast(cast(RIGHT(c1.curr_cont_start_dt,4) as int64) - 1 as string) as calendar_year,
                  c1.remarks,
                  coalesce(c1.visible,'C') as visible,
                  FORMAT_DATE("%Y%m",PARSE_DATE("%m/%d/%Y",c1.curr_cont_start_dt)) as curr_scrfa_start_month
          from `ONEFORCE.V_TENDER_CONTRACT` c1
          inner join ${of_sales_week_master.SQL_TABLE_NAME} w1 on PARSE_DATE("%m/%d/%Y", c1.curr_cont_start_dt) between w1.week_start_date and w1.week_end_date
          inner join ${of_sales_week_master.SQL_TABLE_NAME} w21 on PARSE_DATE("%m/%d/%Y", c1.report_dt) between w21.week_start_date and w21.week_end_date
          inner join ${of_customer_group.SQL_TABLE_NAME} g1 on g1.cust_grp_id = c1.cust_grp_id
          where coalesce(c1.visible,'C') = 'Y'
;;

  }

  measure: count {
    type: count
    drill_fields: [detail*]
    hidden: yes
  }

  dimension: record_id {
    type: string
    sql: ${TABLE}.record_id
      primary key: yes;;
    hidden: yes
  }

  dimension: record_type {
    type: string
    sql: ${TABLE}.record_type ;;
    hidden: yes
  }

  dimension: report_dt {
    type: date
    datatype: date
    sql: ${TABLE}.report_dt ;;
  }

  dimension: cust_grp_nm {
    label: "Previous: Group Customer Name"
    type: string
    sql: ${TABLE}.cust_grp_nm ;;
  }

  dimension: cust_grp_id {
    label: "Previous: Group Customer Code"
    type: string
    sql: ${TABLE}.cust_grp_id ;;
  }

  dimension: tender_nm {
    label: "Previous: Tender Name"
    type: string
    sql: ${TABLE}.tender_nm ;;
  }

  dimension: visible {
    label: "Previous: Visible"
    type: string
    sql: ${TABLE}.visible ;;
  }

  dimension: ckam {
    label: "Previous: CKAM"
    type: string
    sql: ${TABLE}.ckam ;;
  }

  dimension: manual_actual_flag {
    label: "Previous: Manual Actual Flag"
    type: string
    sql: ${TABLE}.manual_actual_flag ;;
  }

  dimension: svc_cont_no {
    label: "Previous: SC/RFA Number"
    type: string
    sql: ${TABLE}.svc_cont_no ;;
  }

  dimension: cont_start_dt {
    label: "Previous: SC/RFA Eff Date"
    type: date
    datatype: date
    sql: ${TABLE}.cont_start_dt ;;
  }

  dimension: cont_end_dt {
    label: "Previous: SC/RFA Exp Date"
    type: date
    datatype: date
    sql: ${TABLE}.cont_end_dt ;;
  }

  dimension: cont_duration {
    label: "Previous: SC/RFA Duration"
    type: number
    sql: ${TABLE}.cont_duration ;;
  }

  dimension: cont_dur_uplmt {
    label: "Previous: SC/RFA Duration Upper Limit"
    type: number
    sql: ${TABLE}.cont_dur_uplmt ;;
    hidden: yes
  }

  dimension: sales_week {
    label: "Previous: Sales Week"
    type: string
    sql: ${TABLE}.sales_week ;;
  }

  dimension: curr_scrfa_start_month {
    label: "Current SC/RFA Start Month"
    type: string
    sql: ${TABLE}.curr_scrfa_start_month ;;
  }

  dimension: fiscal_year {
    label: "Previous: Fiscal Year"
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }

  dimension: calendar_year {
    label: "Previous: Calendar Year"
    type: string
    sql: ${TABLE}.calendar_year ;;
  }

  dimension: remarks {
    label: "Previous: Remarks"
    type: string
    sql: ${TABLE}.remarks ;;
  }

  set: detail {
    fields: [
      report_dt,
      cust_grp_nm,
      cust_grp_id,
      tender_nm,
      svc_cont_no,
      cont_start_dt,
      cont_end_dt
    ]
  }
}

view: bkg_cncl_reason {
  derived_table: {
    # testing KT demo
    sql: SELECT 'Sales Guidance' as cancel_reason, 'S' as code, 'CANCEL REASON : SALES GUIDANCE' as cancel_reason_raw, 'ONE' as category, 'Yes' as reason_category, 'Cancel Reason has been deactivated' as cancel_reason_def
      UNION ALL
      SELECT 'Marketing Guidance' as cancel_reason, 'G' as code, 'CANCEL REASON : MARKETING GUIDANCE' as cancel_reason_raw, 'ONE' as category, 'Yes' as reason_category, 'Cancel Reason has been deactivated' as cancel_reason_def
      UNION ALL
      SELECT 'Missing Documents' as cancel_reason, 'M' as code, 'CANCEL REASON : MISSING DOCUMENTS' as cancel_reason_raw, 'Customer' as category, 'Yes' as reason_category, 'When the booking is cancelled by Carrier, as the shipment cannot be processed due to missing documents' as cancel_reason_def
      UNION ALL
      SELECT 'Lack of Space' as cancel_reason, 'L' as code, '' as cancel_reason_raw, 'ONE' as category, 'Yes' as reason_category, 'When Carrier rejects the booking due to space limitation (incl.cases where customers exceed their AP) ' as cancel_reason_def
      UNION ALL
      SELECT 'Duplicate Booking' as cancel_reason, 'D' as code, 'CANCEL REASON : DUPLICATE BOOKING' as cancel_reason_raw, 'Customer' as category, 'Yes' as reason_category,'For Duplicate bookings made by Customer' as cancel_reason_def
      UNION ALL
      SELECT 'Customer Circumstance' as cancel_reason, 'C' as code, 'CANCEL REASON : Customer Circumstance (Container Picked Up)' as cancel_reason_raw, 'Customer' as category, 'Yes' as reason_category, 'When Customer/Shipper requests to cancel due to own reason from Customer (e.g. cargo not yet ready)' as cancel_reason_def
      UNION ALL
      SELECT 'No Show' as cancel_reason, 'N' as code, 'CANCEL REASON : NO SHOW (CONFIRM BOOKINGS BUT NO PICKUP CONTAINER)' as cancel_reason_raw, 'Customer' as category, 'Yes' as reason_category, 'When Customer does not provide SI, pick up the container on time, and/or miss the documentation cut-off time' as cancel_reason_def
      UNION ALL
      SELECT 'Internal Reason' as cancel_reason, 'I' as code, 'CANCEL REASON : INTERNAL ERROR' as cancel_reason_raw, 'ONE' as category, 'Yes' as reason_category, 'Cancel Reason has been deactivated' as cancel_reason_def
      UNION ALL
      SELECT 'Booking Combine' as cancel_reason, 'B' as code, '' as cancel_reason_raw, 'Booking Combine' as category, 'Yes' as reason_category, 'When a booking is combined to another booking' as cancel_reason_def
      UNION ALL
      SELECT 'Lack of Equipment (old)' as cancel_reason, 'E' as code, '' as cancel_reason_raw, 'ONE' as category, 'Yes' as reason_category,'Cancel Reason has been deactivated' as cancel_reason_def
      UNION ALL
      SELECT 'Lack of Space or Equipment (Before Codified)' as cancel_reason, 'LE' as code, 'CANCEL REASON : LACK OF SPACE AND EQUIPMENT' as cancel_reason_raw, 'ONE' as category, 'Yes' as reason_category,'' as cancel_reason_def
      UNION ALL
      SELECT 'Other' as cancel_reason, 'O' as code, 'CANCEL REASON : OTHER' as cancel_reason_raw, 'ONE' as category, 'Yes' as reason_category,'Other Reason' as cancel_reason_def
      --UNION ALL
      --SELECT 'No Reason' as cancel_reason, 'Z' as code, '' as cancel_reason_raw, 'No Reason' as category, 'No' as reason_category,'When the booking is cancelled without specified reason' as cancel_reason_def
      UNION ALL
      SELECT 'ONE QUOTE: Route or Equipment Amendment' as cancel_reason, 'A' as code, '' as cancel_reason_raw, 'Customer' as category, 'Yes' as reason_category,'When Customer requests to amend the booking for routing and/or EQ size/type and thus needs to cancel' as cancel_reason_def
      UNION ALL
      SELECT 'VVD Cancellation or Port Omission (Customer)' as cancel_reason, 'P' as code, '' as cancel_reason_raw, 'Customer' as category, 'Yes' as reason_category,'When Customer decides to cancel the booking due to port omission or VVD cancellation even though Carrier has provided an alternative vessel option' as cancel_reason_def
      UNION ALL
      SELECT 'ONE QUOTE: Increase in Containers' as cancel_reason, 'Q' as code, '' as cancel_reason_raw, 'Customer' as category, ' Yes' as reason_category,'When Customer requests to amend the booking to increase the volume and thus needs to cancel' as cancel_reason_def
      UNION ALL
      SELECT 'Lack of Equipment (Customer)' as cancel_reason, 'R' as code, '' as cancel_reason_raw, 'Customer' as category, 'Yes' as reason_category, 'When Customer decides to cancel the booking due to no EQ availability even though Carrier has provided an alternative EQ option' as cancel_reason_def
      UNION ALL
      SELECT 'Lack of Equipment (Carrier)' as cancel_reason, 'V' as code, '' as cancel_reason_raw, 'ONE' as category, 'Yes' as reason_category, 'When Carrier decides to cancel the booking due to no EQ availability' as cancel_reason_def
      UNION ALL
      SELECT 'VVD Cancellation or Port Omission (Carrier)' as cancel_reason, 'X' as code, '' as cancel_reason_raw, 'ONE' as category, 'Yes' as reason_category,'When Carrier decides to cancel the booking due to port omission or VVD cancellation' as cancel_reason_def
      UNION ALL
      SELECT 'ONE QUOTE: Decrease in Containers' as cancel_reason, 'Y' as code, '' as cancel_reason_raw, 'Customer' as category, 'Yes' as reason_category,'When Customer requests to amend the booking to decrease the volume and thus needs to cancel' as cancel_reason_def
      UNION ALL
      SELECT 'Advanced Booking' as cancel_reason, 'Z' as code, '' as cancel_reason_raw, 'ONE' as category, 'Yes' as reason_category,'Advanced booking' as cancel_reason_def
      UNION ALL
      SELECT 'Missing Approval'                  as cancel_reason, 'U' as code, '' as cancel_reason_raw, 'ONE'      as category, 'Yes' as reason_category,'Missing Approval'                  as cancel_reason_def
      UNION ALL
      SELECT 'ONE QUOTE'                         as cancel_reason, 'K' as code, '' as cancel_reason_raw, 'Customer' as category, 'Yes' as reason_category,'ONE QUOTE'                         as cancel_reason_def
      UNION ALL
      SELECT 'VVD Cancellation or Port Omission' as cancel_reason, 'W' as code, '' as cancel_reason_raw, 'Customer' as category, 'Yes' as reason_category,'VVD Cancellation or Port Omission' as cancel_reason_def

      ;;

    persist_for: "24 hours"
  }



  dimension: code {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: cancel_reason {
    type: string
    sql: ${TABLE}.cancel_reason ;;
  }

  dimension: cancel_reason_raw {
    type: string
    sql: ${TABLE}.cancel_reason_raw ;;
  }

  dimension: cancel_reason_def {
    type: string
    sql: ${TABLE}.cancel_reason_def ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: reason_category {
    type: string
    sql: ${TABLE}.reason_category ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [cancel_reason, code, cancel_reason_raw, cancel_reason_def, category, reason_category]
  }
}

view: bkg_cxl_sub_rsn {
  derived_table: {
    sql:
    SELECT 'C1'  as bkg_cxl_sub_rsn_cd , 'Customer Circumstance: Cargo Readiness/Availability/Quality'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'C2'  as bkg_cxl_sub_rsn_cd , 'Customer Circumstance: Incorrect Booking Info'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'C3'  as bkg_cxl_sub_rsn_cd , 'Customer Cancelled (no specific reason provided)'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'D1'  as bkg_cxl_sub_rsn_cd , 'Duplicate Booking'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'E1'  as bkg_cxl_sub_rsn_cd , 'Lack of Equipment (Cancelled by Customer)'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'E2'  as bkg_cxl_sub_rsn_cd , 'Lack of Equipment (Cancelled by Carrier)'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'K1'  as bkg_cxl_sub_rsn_cd , 'ONE QUOTE: Due to Route or Equipment Type Amendment'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'K2'  as bkg_cxl_sub_rsn_cd , 'ONE QUOTE: Increase in Number of Containers'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'K3'  as bkg_cxl_sub_rsn_cd , 'ONE QUOTE: Decrease in Number of Containers'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'K4'  as bkg_cxl_sub_rsn_cd , 'ONE QUOTE: Vessel Overbooked/Over allocation'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'L1'  as bkg_cxl_sub_rsn_cd , 'Lack of Space (Carrier\'s Request): Vessel Overbooked and No/Over Customer Account Plan'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'L2'  as bkg_cxl_sub_rsn_cd , 'Lack of Space (Customer\'s Request): Partial GD1/ Booking was more than Customer Account Plan'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'M1'  as bkg_cxl_sub_rsn_cd , 'Missing Documents - DG, RF, AK/OOG, Special'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'M2'  as bkg_cxl_sub_rsn_cd , 'Missing Documents - Others'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'N1'  as bkg_cxl_sub_rsn_cd , 'Customer Circumstance (Container NOT Picked Up/No Show)'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'O1'  as bkg_cxl_sub_rsn_cd , 'Regulatory Non Compliance'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'O2'  as bkg_cxl_sub_rsn_cd , 'Sanctions apply'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'O3'  as bkg_cxl_sub_rsn_cd , 'Commodity prohibited/restricted'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'O4'  as bkg_cxl_sub_rsn_cd , 'Wrong Booking Office'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'O5'  as bkg_cxl_sub_rsn_cd , 'POL / POD restriction'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'S1'  as bkg_cxl_sub_rsn_cd , 'Rates not Accepted by Customer'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'S2'  as bkg_cxl_sub_rsn_cd , 'Rate Filing Issue by Carrier'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'U1'  as bkg_cxl_sub_rsn_cd , 'No Cargo Approval Received - DG, RF, AK/OOG, Special'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'U2'  as bkg_cxl_sub_rsn_cd , 'No Special Stowage Approval'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'W1'  as bkg_cxl_sub_rsn_cd , 'VVD Cancellation or Port Omission (Cancelled by Customer)'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'W2'  as bkg_cxl_sub_rsn_cd , 'VVD Cancellation or Port Omission (Cancelled by Carrier)'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'Z1'  as bkg_cxl_sub_rsn_cd , 'Advance Booking (clean-up)'  as bkg_cxl_sub_rsn_desc UNION ALL
    SELECT 'Z2'  as bkg_cxl_sub_rsn_cd , 'Booking Window (too far in advance compared to sailing)'  as bkg_cxl_sub_rsn_desc
           ;;

    persist_for: "24 hours"
  }



  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: bkg_cxl_sub_rsn_cd {
    type: string
    sql: ${TABLE}.bkg_cxl_sub_rsn_cd ;;
  }

  dimension: bkg_cxl_sub_rsn_desc {
    type: string
    sql: ${TABLE}.bkg_cxl_sub_rsn_desc ;;
  }

  set: detail {
    fields: [bkg_cxl_sub_rsn_cd, bkg_cxl_sub_rsn_desc]
  }
}

# view: cgm_cva_actual {
#   derived_table: {
#     sql:
#       select c.ori_cnt
#       , of_country.Country_Name as ori_cnt_nm
#       , (CASE of_reg_ref.reg_cust_cnt_cd
#                                                       WHEN "BR" THEN "SAOHQ"
#                                                       WHEN "US" THEN "RICHQ"
#                                                       WHEN "HK" THEN "HKGHQ"
#                                                       WHEN "SG" THEN "SINHQ"
#                                                       WHEN "GB" THEN "LONHQ" END) as ori_rhq
#       , c.svc_scp_cd
#       , c.svc_scp_grp_cd
#       , c.dominant_flg
#       , c.container_cat
#       , LEFT(c.rlane_cd, 3) as rlane
#       , c.ctrt_prop_rhq_code as ctrt_rhq_cd
#       , c.ctrt_prop_ofc_cd as ctrt_ofc_cd
#       , c.ctrt_prop_ctry_code as ctrt_cnt_cd
#       , ctrt_country.Country_Name as ctrt_cnt_nm
#       , c.scp_ofc_cd
#       , c.cn_sub_reg
#       , of_user.FirstName || " " || of_user.LastName as ckam
#       , c.consolidated_cnt_cust_cd as cust_cd
#       , c.consolidated_cnt_cust_grp_cd as cust_grp_cd
#       , c.sc_rfa_typ
#       , "Booking" as record_type
#       , (SELECT MAX (a) FROM (SELECT MAX(t.target) as a from ${of_customer_target_and_target_dtl_weekly.SQL_TABLE_NAME} t
#       GROUP BY
#         t.sales_week,
#         t.v_customer_opus_n_prospect_of_cust_grp_cd,
#         t.v_customer_opus_n_prospect_cust_cd,
#         t.service_scope_group,
#         t.Dominant_Flag,
#         t.scp_ofc_cd,
#         t.origin_country,
#         t.Revenue_Lane_Code
#       HAVING c.week  = t.sales_week
#               {% if cva_coverage_criterion_param._parameter_value == "'OPT_1'" %}
#               and c.consolidated_cnt_cust_grp_cd = t.v_customer_opus_n_prospect_of_cust_grp_cd

#               {% elsif cva_coverage_criterion_param._parameter_value == "'OPT_2'" %}
#               and c.consolidated_cnt_cust_grp_cd = t.v_customer_opus_n_prospect_of_cust_grp_cd
#               and c.consolidated_cnt_cust_cd = t.v_customer_opus_n_prospect_cust_cd

#               {% elsif cva_coverage_criterion_param._parameter_value == "'OPT_3'" %}
#               and c.consolidated_cnt_cust_grp_cd = t.v_customer_opus_n_prospect_of_cust_grp_cd
#               and c.consolidated_cnt_cust_cd = t.v_customer_opus_n_prospect_cust_cd
#               and c.svc_scp_grp_cd = t.service_scope_group

#               {% elsif cva_coverage_criterion_param._parameter_value == "'OPT_4'" %}
#               and c.consolidated_cnt_cust_grp_cd = t.v_customer_opus_n_prospect_of_cust_grp_cd
#               and c.consolidated_cnt_cust_cd = t.v_customer_opus_n_prospect_cust_cd
#               and c.svc_scp_grp_cd = t.service_scope_group
#               and c.dominant_flg = (CASE WHEN t.Dominant_Flag = "Y" then "DOM" else "N-DOM" end)

#               {% elsif cva_coverage_criterion_param._parameter_value == "'OPT_5'" %}
#               and c.consolidated_cnt_cust_grp_cd = t.v_customer_opus_n_prospect_of_cust_grp_cd
#               and c.consolidated_cnt_cust_cd = t.v_customer_opus_n_prospect_cust_cd
#               and c.svc_scp_grp_cd = t.service_scope_group
#               and c.dominant_flg = (CASE WHEN t.Dominant_Flag = "Y" then "DOM" else "N-DOM" end)
#               and c.scp_ofc_cd = t.scp_ofc_cd

#               {% elsif cva_coverage_criterion_param._parameter_value == "'OPT_6'" %}
#               and c.consolidated_cnt_cust_grp_cd = t.v_customer_opus_n_prospect_of_cust_grp_cd
#               and c.consolidated_cnt_cust_cd = t.v_customer_opus_n_prospect_cust_cd
#               and c.svc_scp_grp_cd = t.service_scope_group
#               and c.dominant_flg = (CASE WHEN t.Dominant_Flag = "Y" then "DOM" else "N-DOM" end)
#               and c.scp_ofc_cd = t.scp_ofc_cd
#               and c.ori_cnt = t.origin_country

#               {% elsif cva_coverage_criterion_param._parameter_value == "'OPT_7'" %}
#               and c.consolidated_cnt_cust_grp_cd = t.v_customer_opus_n_prospect_of_cust_grp_cd
#               and c.consolidated_cnt_cust_cd = t.v_customer_opus_n_prospect_cust_cd
#               and c.svc_scp_grp_cd = t.service_scope_group
#               and c.dominant_flg = (CASE WHEN t.Dominant_Flag = "Y" then "DOM" else "N-DOM" end)
#               and c.scp_ofc_cd = t.scp_ofc_cd
#               and c.ori_cnt = t.origin_country
#               and c.rlane_cd = t.Revenue_Lane_Code

#               {% endif %}
#       )
#       ) as bkg_cva_teu
#       , c.rec_typ_n_bkg_sts_cd
#       , c.bkg_channel_code
#       , c.is_one_quotation
#       , c.week
#       , c.teu
#       , c.cm_amt
#       , c.primary_key
#       from ${of_consolidated2.SQL_TABLE_NAME} c
#       left join ${of_user.SQL_TABLE_NAME} of_user on of_user.oneforce_id = c.ckam_sales_person
#       left join ${of_country.SQL_TABLE_NAME} of_country on of_country.Country_Code = c.ori_cnt
#       left join ${of_country.SQL_TABLE_NAME} ctrt_country on ctrt_country.Country_Code = c.ctrt_prop_ctry_code
#       left join ${of_reg_ref.SQL_TABLE_NAME} of_reg_ref on of_reg_ref.CUST_CNT_CD = of_country.Country_Code
#         where c.record_type = 'Booking'
#   --   and   {% condition filter_bkg_channel  %} c.bkg_channel {% endcondition %}

#       UNION ALL

#       select c.ori_cnt
#       , origin_country.Country_Name as ori_cnt_nm
#       , (CASE of_reg_ref.reg_cust_cnt_cd
#                                                       WHEN "BR" THEN "SAOHQ"
#                                                       WHEN "US" THEN "RICHQ"
#                                                       WHEN "HK" THEN "HKGHQ"
#                                                       WHEN "SG" THEN "SINHQ"
#                                                       WHEN "GB" THEN "LONHQ" END) as ori_rhq
#       , c.svc_scp_cd
#       , c.svc_scp_grp_cd
#       , c.dominant_flg
#       , c.container_cat
#       , LEFT(c.rlane_cd, 3) as rlane
#       , (CASE WHEN contract_rhq.reg_cust_cnt_cd = "BR" THEN 'SAOHQ'
#               WHEN contract_rhq.reg_cust_cnt_cd = "US" THEN 'RICHQ'
#               WHEN contract_rhq.reg_cust_cnt_cd = "HK" THEN 'HKGHQ'
#               WHEN contract_rhq.reg_cust_cnt_cd = "SG" THEN 'SINHQ'
#               WHEN contract_rhq.reg_cust_cnt_cd = "GB" THEN 'LONHQ' END) as ctrt_rhq_cd
#       , c.ctrt_prop_ofc_cd as ctrt_ofc_cd
#       , c.ctrt_prop_ctry_code as ctrt_cnt_cd
#       , ctrt_country.Country_Name as ctrt_cnt_nm
#       , c.scp_ofc_cd
#       , c.cn_sub_reg
#       , of_user.FirstName || " " || of_user.LastName as ckam
#       , c.consolidated_cnt_cust_cd as cust_cd
#       , c.consolidated_cnt_cust_grp_cd as cust_grp_cd
#       , NULL as sc_rfa_typ
#       , "Target" as record_type
#       , NULL as bkg_cva_teu
#       , c.rec_typ_n_bkg_sts_cd
#       , NULL as bkg_channel_code
#       , c.is_one_quotation
#       , c.week
#       , c.teu
#       , c.cm_amt
#       , c.primary_key
#       from ${of_consolidated2.SQL_TABLE_NAME} c
#       left join ${of_user.SQL_TABLE_NAME} of_user on of_user.oneforce_id = c.ckam_sales_person
#       left join ${of_country.SQL_TABLE_NAME} origin_country on origin_country.Country_Code = c.ori_cnt
#       left join ${of_country.SQL_TABLE_NAME} ctrt_country on ctrt_country.Country_Code = c.ctrt_prop_ctry_code
#       left join ${of_reg_ref.SQL_TABLE_NAME} of_reg_ref on of_reg_ref.CUST_CNT_CD = origin_country.Country_Code
#       left join ${of_office.SQL_TABLE_NAME} contract_office on c.ctrt_prop_ofc_cd = contract_office.office_code
#       left join ${of_location.SQL_TABLE_NAME} contract_location on contract_office.location_code = contract_location.location_code
#       left join ${of_country.SQL_TABLE_NAME} contract_country on contract_country.country_code = contract_location.country_code
#       left join ${of_reg_ref.SQL_TABLE_NAME} contract_rhq on contract_rhq.cust_cnt_cd = contract_country.country_code
#       where c.record_type = 'Target'

#       UNION ALL

#       select (CASE
#           WHEN cgm.por_country_code = 'CCN' OR
#           cgm.por_country_code = 'NCN' OR
#           cgm.por_country_code = 'SCN' THEN 'CN'
#           ELSE cgm.por_country_code
#           END) as ori_cnt
#       , CGM_origin_country.Country_Name as ori_cnt_nm
#       , cgm.POR_RHQ_Code as ori_rhq
#       , NULL as svc_scp_cd
#       , cgm.Service_Scope_Group as svc_scp_grp_cd
#       , (CASE WHEN cgm.Dom_NonDom_Flag = "DOM" OR cgm.Dom_NonDom_Flag = "dom" THEN "DOM"
#               ELSE "N-DOM" END) as dominant_flg
#       , NULL as container_cat
#       , cgm.Revenue_Lane as rlane
#       , cgm.Contract_Office_RHQ_Code as ctrt_rhq_cd
#       , cgm.Contract_Office_Code as ctrt_ofc_cd
#       , CGM_contract_location.Country_Code as ctrt_cnt_cd
#       , CGM_contract_country.Country_Name as ctrt_cnt_nm
#       , NULL as scp_ofc_cd
#       , NULL as cn_sub_reg
#       , NULL as ckam
#       , NULL as cust_cd
#       , NULL as cust_grp_cd
#       , NULL as sc_rfa_typ
#       , "CGM" as record_type
#       , NULL as bkg_cva_teu
#       , "CGM" as rec_typ_n_bkg_sts_cd
#       , NULL as bkg_channel_code
#       , "No" as is_one_quotation
#       , cgm.sales_week as week
#       , cgm.teu
#       , cgm.CM_Amount as cm_amt
#       , cgm.record_id as primary_key
#       from ${of_cgm_target.SQL_TABLE_NAME} cgm
#       left join ${of_office.SQL_TABLE_NAME} CGM_contract_office on CGM_contract_office.OFFICE_CODE = cgm.contract_office_code
#       left join ${of_location.SQL_TABLE_NAME} CGM_contract_location on CGM_contract_location.Location_Code = CGM_contract_office.Location_Code
#       left join ${of_country.SQL_TABLE_NAME} CGM_contract_country on CGM_contract_location.Country_Code = CGM_contract_country.Country_Code
#       left join ${of_country.SQL_TABLE_NAME} CGM_origin_country on CGM_origin_country.Country_Code = (CASE
#                                                                                                     WHEN cgm.por_country_code = 'CCN'
#                                                                                                     OR cgm.por_country_code = 'NCN'
#                                                                                                     OR cgm.por_country_code = 'SCN'
#                                                                                                     THEN 'CN' ELSE cgm.por_country_code END)
#   ;;
#     # sql_trigger_value: SELECT  CASE WHEN
#     # CAST(TIME_DIFF(EXTRACT(TIME FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore"),
#     # TIME(EXTRACT(DATE FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore")),MINUTE)
#     # AS INT64)  < 150 THEN 150
#     # WHEN
#     # CAST(TIME_DIFF(EXTRACT(TIME FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore"),
#     # TIME(EXTRACT(DATE FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore")),MINUTE)
#     # AS INT64)  < 510 THEN 510
#     # WHEN
#     # CAST(TIME_DIFF(EXTRACT(TIME FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore"),
#     # TIME(EXTRACT(DATE FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore")),MINUTE)
#     # AS INT64) < 870 THEN 870
#     # WHEN
#     # CAST(TIME_DIFF(EXTRACT(TIME FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore"),
#     # TIME(EXTRACT(DATE FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore")),MINUTE)
#     # AS INT64) < 1230 THEN 1230
#     # ELSE 150 END ;;
#   }



#   # parameter: CGM_by_Contract_Country_or_CGM_by_POR_Country {
#   #   label: "CGM Country Picker"
#   #   type: string
#   #   allowed_value: {
#   #     label: "Contract Country"
#   #     value: "CGM_CTRT_OFF"
#   #   }
#   #   allowed_value: {
#   #     label: "POR Country"
#   #     value: "CGM_POR_CTRY"
#   #   }
#   #   default_value: "CGM_POR_CTRY"
#   # }

#   parameter: cva_coverage_criterion_param {
#     allowed_value: { value: "OPT_1" label: "Customer Group"}
#     allowed_value: { value: "OPT_2" label: "Customer Code"}
#     allowed_value: { value: "OPT_3" label: "Service Scope Group"}
#     allowed_value: { value: "OPT_4" label: "Dominant Flag"}
#     allowed_value: { value: "OPT_5" label: "Service Scope Office"}
#     allowed_value: { value: "OPT_6" label: "POR Region"}
#     allowed_value: { value: "OPT_7" label: "Revenue Lane"}
#     default_value: "OPT_6"
#   }

#   # filter: cva_coverage_criterion {
#   #   type: string
#   #   suggestions: ["Customer Group", "Customer", "Service Scope Group", "Dom/ Non-Dom", "Service Scope Office"]
#   # }

#   filter: filter_bkg_channel {
#     type: string
#     suggest_explore: bkg_channel
#     suggest_dimension: bkg_channel.channel
#   }

#   # parameter: dynamic_cgm_act_param {
#   #   label: "Dynamic Dimension for CGM vs Actual"
#   #   type: string
#   #   allowed_value: {label: "RHQ" value: "rhq"}
#   #   allowed_value: {label: "Country" value: "country"}
#   # }

#   # parameter: dynamic_cva_act_param {
#   #   label: "Dynamic Dimension for CVA vs Actual"
#   #   type: string
#   #   allowed_value: {label: "RHQ" value: "rhq"}
#   #   allowed_value: {label: "Country" value: "country"}
#   #   allowed_value: {label: "Contract Office" value: "sales_office"}
#   #   allowed_value: {label: "CKAM" value: "ckam"}
#   # }

#   # parameter: dynamic_cgm_cva_param {
#   #   label: "Dynamic Dimension for CGM vs CVA"
#   #   type: string
#   #   allowed_value: {label: "RHQ" value: "rhq"}
#   #   allowed_value: {label: "Country" value: "country"}
#   #   allowed_value: {label: "Contract Office" value: "sales_office"}
#   #   allowed_value: {label: "CKAM" value: "ckam"}
#   # }

#   parameter: dynamic_param_overall {
#     label: "Overall Performance Dimension*"
#     type: string
#     allowed_value: {label: "Contract Country" value: "ctrt_ctry"}
#     allowed_value: {label: "Contract Office" value: "ctrt_ofc"}
#     allowed_value: {label: "POR Country" value: "por_ctry"}
#     allowed_value: {label: "Key Account Type" value: "key_acc_tp"}
#     allowed_value: {label: "Customer Type" value: "cust_tp"}
#     default_value: "por_ctry"
#   }

#   parameter: dynamic_param {
#     label: "Actual by CVA Dimension*"
#     type: string
#     allowed_value: {label: "Period" value: "period"}
#     allowed_value: {label: "Contract RHQ" value: "ctrt_rhq"}
#     allowed_value: {label: "Contract Country" value: "ctrt_ctry"}
#     allowed_value: {label: "Contract Office" value: "ctrt_ofc"}
#     allowed_value: {label: "POR RHQ" value: "por_rhq"}
#     allowed_value: {label: "POR Country" value: "por_ctry"}
#     allowed_value: {label: "Dominant Flag" value: "domi_flg"}
#     allowed_value: {label: "Trade Group" value: "trade_grp"}
#     allowed_value: {label: "Service Scope Group" value: "svc_scp_grp"}
#     allowed_value: {label: "Revenue Lane" value: "rlane"}
#     allowed_value: {label: "C-KAM" value: "ckam"}
#     allowed_value: {label: "Key Account Type" value: "key_acc_tp"}
#     allowed_value: {label: "Customer Type" value: "cust_tp"}
#     default_value: "period"
#   }

#   dimension: dynamic_dim_overall {
#     label: "{% if dynamic_param_overall._parameter_value == \"'ctrt_ctry'\" %} *Contract Country
#             {% elsif dynamic_param_overall._parameter_value == \"'ctrt_ofc'\" %} *Contract Office
#             {% elsif dynamic_param_overall._parameter_value == \"'por_ctry'\" %} *POR Country
#             {% elsif dynamic_param_overall._parameter_value == \"'key_acc_tp'\" %} *Key Account Type
#             {% elsif dynamic_param_overall._parameter_value == \"'cust_tp'\" %} *Customer Type
#             {% else %} *POR Country {% endif %}"
#     type: string
#     sql:  {% if  dynamic_param_overall._parameter_value == "'ctrt_ctry'" %} ${ctrt_cnt_cd}
#           {% elsif  dynamic_param_overall._parameter_value == "'ctrt_ofc'" %} ${ctrt_ofc_cd}
#           {% elsif  dynamic_param_overall._parameter_value == "'por_ctry'" %} ${ori_cnt}
#           {% elsif  dynamic_param_overall._parameter_value == "'key_acc_tp'" %} ${of_customer_group.key_acct_tp_cd}
#           {% elsif  dynamic_param_overall._parameter_value == "'cust_tp'" %} ${of_customer_group.global_customer_type}
#           {% else %} ${ori_cnt}
#           {% endif %}
#           ;;
#   }

#   dimension: dynamic_dim {
#     label: "{% if dynamic_param._parameter_value == \"'period'\" %} *Period
#             {% elsif dynamic_param._parameter_value == \"'ctrt_rhq'\" %} *Contract RHQ
#             {% elsif dynamic_param._parameter_value == \"'ctrt_ctry'\" %} *Contract Country
#             {% elsif dynamic_param._parameter_value == \"'ctrt_ofc'\" %} *Contract Office
#             {% elsif dynamic_param._parameter_value == \"'por_rhq'\" %} *POR RHQ
#             {% elsif dynamic_param._parameter_value == \"'por_ctry'\" %} *POR Country
#             {% elsif dynamic_param._parameter_value == \"'domi_flg'\" %} *Dominant Flag
#             {% elsif dynamic_param._parameter_value == \"'trade_grp'\" %} *Trade Group
#             {% elsif dynamic_param._parameter_value == \"'svc_scp_grp'\" %} *Service Scope Group
#             {% elsif dynamic_param._parameter_value == \"'rlane'\" %} *Revenue Lane
#             {% elsif dynamic_param._parameter_value == \"'ckam'\" %} *C-KAM
#             {% elsif dynamic_param._parameter_value == \"'key_acc_tp'\" %} *Key Account Type
#             {% elsif dynamic_param._parameter_value == \"'cust_tp'\" %} *Customer Type
#               {% else %} *Period {% endif %}"
#     type: string
#     sql:  {% if  dynamic_param._parameter_value == "'domi_flg'" %} ${dominant_flg}
#           {% elsif  dynamic_param._parameter_value == "'period'" %} ${time_gra}
#           {% elsif  dynamic_param._parameter_value == "'ctrt_rhq'" %} ${ctrt_rhq_cd}
#           {% elsif  dynamic_param._parameter_value == "'ctrt_ctry'" %} ${ctrt_cnt_cd}
#           {% elsif  dynamic_param._parameter_value == "'ctrt_ofc'" %} ${ctrt_ofc_cd}
#           {% elsif  dynamic_param._parameter_value == "'por_rhq'" %} ${ori_rhq}
#           {% elsif  dynamic_param._parameter_value == "'por_ctry'" %} ${ori_cnt}
#           {% elsif  dynamic_param._parameter_value == "'trade_grp'" %} ${trade_group}
#           {% elsif  dynamic_param._parameter_value == "'svc_scp_grp'" %} ${svc_scp_grp_cd}
#           {% elsif  dynamic_param._parameter_value == "'rlane'" %} ${rlane}
#           {% elsif  dynamic_param._parameter_value == "'ckam'" %} ${ckam}
#           {% elsif  dynamic_param._parameter_value == "'key_acc_tp'" %} ${of_customer_group.key_acct_tp_cd}
#           {% elsif  dynamic_param._parameter_value == "'cust_tp'" %} ${of_customer_group.global_customer_type}
#           {% else %} ${time_gra}
#           {% endif %};;

#   }

#   # dimension: contract_dynamic_dim {
#   #   type: string
#   #   label: "{% if dynamic_dim_param._parameter_value == \"'country'\" %} *Country {% else %} *RHQ {% endif %}"
#   #   sql: {% if  dynamic_dim_param._parameter_value == "'country'" %} ${ctrt_cnt_cd}
#   #       {% else %} ${ctrt_rhq_cd}
#   #       {% endif %};;
#   #   drill_fields: [trade_group, dominant_flg, svc_scp_grp_cd, rlane]
#   # }

#   # dimension: origin_dynamic_dim {
#   #   type: string
#   #   label: "{% if dynamic_dim_param._parameter_value == \"'country'\" %} *Country {% else %} *RHQ {% endif %}"
#   #   sql: {% if  dynamic_dim_param._parameter_value == "'country'" %} ${ori_cnt}
#   #       {% else %} ${ori_rhq}
#   #       {% endif %};;
#   #   drill_fields: [trade_group, dominant_flg, svc_scp_grp_cd, rlane]
#   # }

#   dimension: primary_key {
#     type: string
#     sql: ${TABLE}.primary_key ;;
#     primary_key: yes
#   }

#   dimension: time_gra {
#     label: "Time"
#     type: string
#     sql: ${of_sales_week_master.Timeline_New_Fmt};;
#     drill_fields: [cust_cd, cust_grp_cd, ckam]
#   }

#   dimension: sub_record_type {
#     type: string
#     sql:
#       CASE
#       WHEN ${record_type} = 'CGM' AND  ${ori_cnt} IS NOT NULL THEN 'CGM_POR_CTRY'
#       WHEN ${record_type} = 'CGM' AND  ${ori_cnt} IS     NULL THEN 'CGM_CTRT_OFF'
#       ELSE 'NA'
#       END;;
#   }

#   dimension: rec_typ_n_bkg_sts_cd {
#     type: string
#     sql: ${TABLE}.rec_typ_n_bkg_sts_cd ;;
#     suggestions: ["BKG:F","BKG:S","BKG:W","BKG:X","PLN","TGT"]
#   }

#   dimension: ori_cnt  {
#     label: "Origin Country Code"
#     type: string
#     sql: ${TABLE}.ori_cnt ;;
#   }

#   dimension: ori_cnt_nm {
#     label: "Origin Country Name"
#     type: string
#     sql: ${TABLE}.ori_cnt_nm ;;
#   }

#   dimension: ori_rhq {
#     label: "Origin RHQ Code"
#     type: string
#     sql: ${TABLE}.ori_rhq ;;
#   }

#   dimension: ctrt_ofc_cd {
#     type: string
#     sql: ${TABLE}.ctrt_ofc_cd ;;
#     label: "Contract Office Code"
#   }

#   dimension: ctrt_cnt_cd {
#     label: "Contract Country Code"
#     type: string
#     sql: ${TABLE}.ctrt_cnt_cd ;;
#   }

#   dimension: ctrt_cnt_nm {
#     label: "Contract Country Name"
#     type: string
#     sql: ${TABLE}.ctrt_cnt_nm ;;
#     drill_fields: [ctrt_ofc_cd]
#   }

#   dimension: ctrt_rhq_cd {
#     label: "Contract RHQ Code"
#     type: string
#     sql: ${TABLE}.ctrt_rhq_cd ;;
#   }

#   dimension: scp_ofc_cd {
#     label: "Scope Office Code"
#     type: string
#     sql: ${TABLE}.scp_ofc_cd ;;
#   }

#   dimension: svc_scp_cd  {
#     label: "Service Scope Code"
#     type: string
#     sql: ${TABLE}.svc_scp_cd ;;
#   }

#   dimension: svc_scp_grp_cd {
#     label: "Service Scope Group Code"
#     type: string
#     sql: ${TABLE}.svc_scp_grp_cd ;;
#   }

#   dimension: dominant_flg {
#     type: string
#     sql: ${TABLE}.dominant_flg  ;;
#   }

#   dimension: trade_group {
#     type: string
#     label: "Trade Group"
#     sql: ${of_svc_scp_grp_cat.group_cat} ;;
#   }

#   dimension: container_cat {
#     type: string
#     sql: ${TABLE}.container_cat ;;
#   }

#   dimension: rlane {
#     type: string
#     sql: ${TABLE}.rlane ;;
#     label: "Revenue Lane"
#   }

#   dimension: record_type {
#     type: string
#     sql: ${TABLE}.record_type ;;
#   }

#   dimension: booking_type {
#     type: string
#     sql: CASE
#             WHEN ${record_type} = "Booking" and ${TABLE}.bkg_cva_teu > 0
#                 THEN  "3Bkg-CVA covered"
#             WHEN ${record_type} = "Booking" and ${TABLE}.bkg_cva_teu = 0
#                 THEN "5Bkg-Zero CVA covered"
#             WHEN ${record_type} = "Booking" and ${TABLE}.bkg_cva_teu is NULL
#                 THEN "4Bkg-W/O CVA"
#             WHEN ${record_type} = "CGM"
#                 THEN "1CGM"
#             ELSE "2CVA" END  ;;
#   }

#   dimension: cn_sub_reg {
#     type: string
#     sql: ${TABLE}.cn_sub_reg ;;
#   }

#   dimension: ckam {
#     type: string
#     label: "CKAM"
#     sql: ${TABLE}.ckam ;;
#   }

#   dimension: cust_cd {
#     type: string
#     label: "Customer Code"
#     sql: ${TABLE}.cust_cd ;;
#   }

#   dimension: cust_grp_cd {
#     type: string
#     label: "Customer Group Code"
#     sql: ${TABLE}.cust_grp_cd ;;
#   }

#   dimension: bkg_channel_code {
#     type: string
#     label: "Booking Channel Code"
#     sql: ${TABLE}.bkg_channel_code ;;
#   }

#   dimension: is_one_quotation {
#     label: "Is ONE Quote?"
#     type: string
#     sql: ${TABLE}.is_one_quotation ;;
#   }

#   dimension: sc_rfa_typ {
#     # hidden: yes
#     type: string
#     sql: ${TABLE}.sc_rfa_typ ;;
#   }

#   filter: contract_type {
#     label: "Contract Type"
#     type: string
#     suggestions: ["RFA", "S/C", "Tariff", "Other"]
#   }

#   dimension: ctrt_tp_include {
#     type: string
#     sql: CASE WHEN ({% condition contract_type %} "RFA" {% endcondition %}
#                     AND (${sc_rfa_typ} = "R" OR (${sc_rfa_typ} IS NULL AND ${record_type} IN ("CGM", "Target"))))
#                 OR
#                   ({% condition contract_type %} "S/C" {% endcondition %}
#                     AND (${sc_rfa_typ} = "S" OR (${sc_rfa_typ} IS NULL AND ${record_type} IN ("CGM", "Target"))))
#                 OR
#                   ({% condition contract_type %} "Tariff" {% endcondition %}
#                     AND (${sc_rfa_typ} = "T" OR (${sc_rfa_typ} IS NULL AND ${record_type} IN ("CGM", "Target"))))
#                 OR
#                   ({% condition contract_type %} "Other" {% endcondition %}
#                     AND ${sc_rfa_typ} IS NULL)
#                 THEN "Y"
#               ELSE "N"
#               END;;
#   }

#   dimension: week {
#     type: string
#     sql: ${TABLE}.week ;;
#   }

#   dimension: teu {
#     sql: ${TABLE}.teu ;;
#     type: number
#   }

#   dimension: cm_amt {
#     sql: ${TABLE}.cm_amt ;;
#     type: number
#   }

#   dimension: ytd {
#     type: string
#     sql: case when cast(RIGHT(${week}, 2) as int64) <= extract(week from current_timestamp()) AND cast(LEFT(${week}, 4) as int64) = extract(year from current_timestamp()) then "YTD" else "N" end   ;;
#   }

#   dimension: ytd_fiscal {
#     type: string
#     sql: case when cast(RIGHT(${of_sales_week_master.sales_month_new_fmt}, 2) as int64) <= extract(month from current_timestamp()) AND cast(LEFT(${week}, 4) as int64) = extract(year from current_timestamp()) then "YTD" else "N" end ;;
#   }

#   # dimension: dynamic_ytd {
#   #   type: string
#   #   sql: CASE WHEN ${of_sales_week_master.calendar_selection} = "CALENDAR" THEN ${ytd}
#   #         ELSE ${ytd_fiscal}
#   #         END;;
#   # }

#   measure: total_cgm_por_ctry_teu {
#     label:"Total TEU - CGM (by POR Country)"
#     type: sum
#     sql: ${teu} ;;
#     filters: [record_type: "CGM", sub_record_type: "CGM_POR_CTRY"]
#     # value_format_name: decimal_0
#     value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0.0"
#   }

#   measure: total_cgm_ctrt_off_teu {
#     label:"Total TEU - CGM (by Contract Office)"
#     type: sum
#     sql: ${teu} ;;
#     filters: [record_type: "CGM", sub_record_type: "CGM_CTRT_OFF"]
#     # value_format_name: decimal_0
#     value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0.0"
#   }

#   measure: cgm_teu_dynamic {
#     label: "CGM TEU Dynamic"
#     type: number
#     sql: {% if  dynamic_param._parameter_value == "'por_ctry'" %}
#           ${total_cgm_por_ctry_teu}
#         {% elsif dynamic_param._parameter_value == "'por_rhq'" %}
#           ${total_cgm_por_ctry_teu}
#         {% elsif dynamic_param._parameter_value == "'ctrt_ctry'" %}
#           ${total_cgm_ctrt_off_teu}
#         {% elsif dynamic_param._parameter_value == "'ctrt_ofc'" %}
#           ${total_cgm_ctrt_off_teu}
#         {% elsif dynamic_param._parameter_value == "'ctrt_rhq'" %}
#           ${total_cgm_ctrt_off_teu}
#         {% else %}
#           ${total_cgm_por_ctry_teu}
#         {% endif %};;
#     value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0.0"

#   }

#   # measure: CGM_TEU_Dynamic {
#   #   type: number
#   #   value_format_name: decimal_0
#   #   #value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0.0"
#   #   sql:
#   #     CASE
#   #       WHEN {% parameter CGM_by_Contract_Country_or_CGM_by_POR_Country %} = 'CGM_POR_CTRY'        THEN ${total_cgm_por_ctry_teu}
#   #               ELSE ${total_cgm_ctrt_off_teu}
#   #     END ;;
#   # }

#   measure: total_booking_cm_amt {
#     label: "Gross CM"
#     type: sum
#     sql:  ${cm_amt} ;;
#     filters: [record_type: "Booking"]
#     value_format_name: usd_0
#   }

#   measure: target {
#     value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0.0"
#     label: "Target"
#     type: sum
#     sql: ${teu} ;;
#     filters: [record_type: "Target"]
#   }

#   measure: total_target_teu_with_vms {
#     label: "Adjusted Target (TEU)"
#     type: number
#     sql: ${target} * ceiling(${of_dep_sched_smry2.scheduled_wk_perc}) /100 ;;
#     value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0.0"
#   }

#   measure: cgm {
#     value_format_name: decimal_0
#     label: "CGM"
#     type: sum
#     sql: ${teu} ;;
#     filters: [record_type: "CGM"]
#   }

#   measure: act_with_cva {
#     value_format_name: decimal_0
#     label: "Actual with CVA"
#     type: sum
#     sql: ${teu} ;;
#     filters: [booking_type: "3Bkg-CVA covered"]
#   }

#   measure: act_with_zero_cva {
#     value_format_name: decimal_0
#     label: "Actual with Zero CVA"
#     type: sum
#     sql: ${teu} ;;
#     filters: [booking_type: "5Bkg-Zero CVA covered"]
#   }

#   measure: act_without_cva {
#     value_format_name: decimal_0
#     label: "Actual without CVA"
#     type: sum
#     sql: ${teu} ;;
#     filters: [booking_type: "4Bkg-W/O CVA"]
#   }

#   measure: total_actual {
#     value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0.0"
#     label: "Total Actual"
#     type: sum
#     sql: ${teu} ;;
#     filters: [record_type: "Booking"]
#   }

#   measure: total_target_teu_with_param {
#     type: number
#     sql: {% if apply_vms_adjustment_to_target._parameter_value == "'Yes'" %}
#             ${total_target_teu_with_vms}
#         {% else %}
#             ${target}
#         {% endif %};;
#     value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0.0"
#   }

#   measure: tgt {
#     label: "{% if    apply_vms_adjustment_to_target._parameter_value ==  \"'Yes'\"  %}Adj Tgt{%
#     elsif apply_vms_adjustment_to_target._parameter_value ==  \"'No'\"   %}Tgt{%
#     else  %}total_target_teu_with_vms_formatted{% endif %}"
#     type: number
#     sql: ${total_target_teu_with_param};;
#     value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0.0"
#     # html: {{total_target_teu_with_param._rendered_value}}  ;;
#   }
#   parameter: apply_vms_adjustment_to_target {
#     label: "Target Selection"
#     type: string
#     allowed_value: {label: "Target"      value: "No"  }
#     allowed_value: {label: "Adj. Target" value: "Yes" }
#     default_value: "No"
#   }

#   measure: cm_per_teu {
#     label: "CM/ TEU"
#     type: number
#     sql: ${total_booking_cm_amt} / NULLIF(${total_actual}, 0) ;;
#     value_format_name: usd_0
#   }

#   measure: cgm_contract_country_actual_gap {
#     type: number
#     sql: ${total_actual} - ${total_cgm_ctrt_off_teu} ;;
#     value_format_name: decimal_0
#   }

#   measure: cgm_por_country_actual_gap {
#     type: number
#     sql: ${total_actual} - ${total_cgm_por_ctry_teu} ;;
#     value_format_name: decimal_0
#   }

#   measure: cgm_contract_country_actual_achievement {
#     type: number
#     sql: ${total_actual} / NULLIF(${total_cgm_ctrt_off_teu}, 0) ;;
#     value_format_name: percent_0
#   }

#   measure: cgm_por_country_actual_achievement {
#     type: number
#     sql: ${total_actual} / NULLIF(${total_cgm_por_ctry_teu}, 0) ;;
#     value_format_name: percent_0
#   }

#   measure: cgm_contract_country_cva_gap {
#     type: number
#     sql: ${target} - ${total_cgm_ctrt_off_teu} ;;
#     value_format_name: decimal_0
#   }

#   measure: cgm_por_country_cva_gap {
#     type: number
#     sql: ${target} - ${total_cgm_por_ctry_teu} ;;
#     value_format_name: decimal_0
#   }

#   measure: cgm_contract_country_cva_achievement {
#     type: number
#     sql: ${target} / NULLIF(${total_cgm_ctrt_off_teu}, 0) ;;
#     value_format_name: percent_0
#   }

#   measure: cgm_por_country_cva_achievement {
#     type: number
#     sql: ${target} / NULLIF(${total_cgm_por_ctry_teu}, 0) ;;
#     value_format_name: percent_0
#   }

#   measure: cva_actual_w_cva_gap {
#     type: number
#     sql: ${act_with_cva} - ${target} ;;
#     value_format_name: decimal_0
#   }

#   measure: cva_actual_w_cva_achievement {
#     type: number
#     sql: ${act_with_cva} / NULLIF(${target}, 0) ;;
#     value_format_name: percent_0
#   }

#   measure: cva_actual_wo_cva_achievement {
#     type: number
#     sql: ${act_without_cva} / NULLIF(${target}, 0) ;;
#     value_format_name: percent_0
#   }

#   measure: cva_actual_zero_cva_achievement {
#     type: number
#     sql: ${act_with_zero_cva} / NULLIF(${target}, 0) ;;
#     value_format_name: percent_0
#   }

#   set: detail {
#     fields: [
#             ctrt_ofc_cd
#             , svc_scp_cd
#             , svc_scp_grp_cd]
#   }

# }

view: ckam_mapping_one_per_country {
  derived_table: {
    sql:
    SELECT Customer_Group        as customer_grp_oneforce_id,
           cust_grp_id           as customer_grp_id,
           Sales_Person          as ckam_sales_person,
           contract_country_code as contract_country_code,
           contract_country_name as contract_country_name
FROM (
  SELECT
  Customer_Group,
  cust_grp_id,
  Sales_Person,
  Team_Role,
  contract_country_code,
  Country_Name as contract_country_name,
  of_sstm_country_country.LastModifiedDate ,
  row_number() OVER ( PARTITION BY Customer_Group, contract_country_code
                      ORDER BY of_sstm_country_country.LastModifiedDate DESC, of_sstm_country_country.CreatedDate DESC
                    ) as rn
  FROM ${of_sales_team_member_contract_country.SQL_TABLE_NAME} of_sstm_country_country
  LEFT JOIN ${of_country.SQL_TABLE_NAME} of_country
  ON of_sstm_country_country.contract_country_code = of_country.Country_Code
  LEFT JOIN ${of_user.SQL_TABLE_NAME} of_user
  ON of_sstm_country_country.Sales_Person = of_user.ONEForce_ID
  WHERE Team_Role = 'Contract Key Account Manager (C-KAM)'
) WHERE rn = 1 ;;

    persist_for: "1 hour"
  }


  dimension: customer_grp_oneforce_id {
    type: string
    sql: ${TABLE}.customer_grp_oneforce_id ;;
  }

  dimension: customer_grp_id {
    type: string
    sql: ${TABLE}.customer_grp_id ;;
  }

  dimension: ckam_sales_person {
    type: string
    sql: ${TABLE}.ckam_sales_person ;;
  }

  dimension: contract_country_code {
    type: string
    sql: ${TABLE}.contract_country_code ;;
  }

  dimension: contract_country_name {
    type: string
    sql:  ${TABLE}.contract_country_name ;;
  }


}

view: ckam_mapping_one_per_office {
  derived_table: {
    sql:
    SELECT Customer_Group        as customer_grp_oneforce_id,
           cust_grp_id           as customer_grp_id,
           Sales_Person          as ckam_sales_person,
           contract_country_code as contract_country_code,
           contract_country_name as contract_country_name,
           Office_Code_Number    as contract_office_code
FROM (
  SELECT
  Customer_Group,
  cust_grp_id,
  Sales_Person,
  Team_Role,
  contract_country_code,
  Country_Name as contract_country_name,
  of_sstm_country_country.LastModifiedDate ,
  of_user.Office_Code_Number,
  row_number() OVER (PARTITION BY Customer_Group, contract_country_code, Office_Code_Number ORDER BY of_sstm_country_country.LastModifiedDate DESC, of_sstm_country_country.CreatedDate DESC) as rn
  FROM ${of_sales_team_member_contract_country.SQL_TABLE_NAME} of_sstm_country_country
  LEFT JOIN ${of_country.SQL_TABLE_NAME} of_country
  ON of_sstm_country_country.contract_country_code = of_country.Country_Code
  LEFT JOIN ${of_user.SQL_TABLE_NAME} of_user
  ON of_sstm_country_country.Sales_Person = of_user.ONEForce_ID
  WHERE Team_Role = 'Contract Key Account Manager (C-KAM)'
) WHERE rn = 1 ;;

    persist_for: "1 hour"
  }


  dimension: customer_grp_oneforce_id {
    type: string
    sql: ${TABLE}.customer_grp_oneforce_id ;;
  }

  dimension: customer_grp_id {
    type: string
    sql: ${TABLE}.customer_grp_id ;;
  }

  dimension: ckam_sales_person {
    type: string
    sql: ${TABLE}.ckam_sales_person ;;
  }

  dimension: contract_country_code {
    type: string
    sql: ${TABLE}.contract_country_code ;;
  }

  dimension: contract_country_name {
    type: string
    sql:  ${TABLE}.contract_country_name ;;
  }

  dimension: contract_office_code {
    type: string
    sql: ${TABLE}.contract_office_code ;;
  }
}

view: cust_priority_list {
  # # All active GKA, RKA, LKA regardless of lifting plus SME and Ungroup Customer having TEU in FY2020
  derived_table: {
    #sql: WITH  fy_teu as (select coalesce(s.cust_cd,b.cust_cd) as cust_cd,  w.fiscal_year, sum(bkg_teu) teu
    #  from OF_ACTUALS a
    #  inner join ${of_sales_week_master.SQL_TABLE_NAME} as w on a.week = cast(regexp_replace(w.sales_week, '[/W]', '') as int64) and w.fiscal_year = 'FY2020'
    #  left join ${of_svc_contract.SQL_TABLE_NAME} as s on a.svc_cont_no =  s.sc_rfa_no
    #  inner join ${v_customer_opus_n_prospect.SQL_TABLE_NAME} as b on coalesce(s.cust_cd, a.cnt_cust_cd) = b.cust_cd and b.delt_flg in ('N','false')
    #  group by 1, 2)
    #  -- MAIN
    #  select  distinct a.cust_cd, a.cust_grp_id, g.key_Acct_tp_cd, fy_teu.fiscal_year, fy_teu.teu
    #  from ${v_customer_opus_n_prospect.SQL_TABLE_NAME} a
    #  inner join (select coalesce(svc.cust_cd, bkg.ctrt_cust_cd) ctrt_cust_cd
    #             from ${of_booking.SQL_TABLE_NAME} as bkg
    #             left join ${of_svc_contract.SQL_TABLE_NAME} as svc on bkg.svc_cont_no = svc.sc_rfa_no) as b on b.ctrt_cust_cd = a.cust_cd
    #  left join ${of_customer_group.SQL_TABLE_NAME} g on (a.cust_grp_id = g.cust_grp_id and g.delt_flg = 'N')
    #  left join fy_teu on fy_teu.cust_cd = a.cust_cd
    #  where a.delt_flg in ('N','false')
    #  and a.cust_cd is not null
    #  and 0 < ( CASE WHEN IFNULL(g.key_acct_tp_cd, 'XXX') not in ('GKA','RKA','LKA') THEN fy_teu.teu ELSE 1 END)
    #   ;;

    #sql:  select  distinct a.cust_cd, a.cust_grp_id, g.key_Acct_tp_cd, fy_teu.fiscal_year, fy_teu.teu
    #  from ${v_customer_opus_n_prospect.SQL_TABLE_NAME} a
    #  inner join ${of_booking.SQL_TABLE_NAME} b on b.ctrt_cust_cd = a.cust_cd
    #  left join ${of_customer_group.SQL_TABLE_NAME} g on (a.cust_grp_id = g.cust_grp_id and g.delt_flg = 'N')
    #  left join (select b.cust_cd, w.fiscal_year, sum(bkg_teu) teu
    #              from ${of_actuals.SQL_TABLE_NAME} a
    #              inner join ${v_customer_opus_n_prospect.SQL_TABLE_NAME} b on a.cnt_cust_cd = b.cust_cd and b.delt_flg in ('N','false')
    #              inner join ${of_sales_week_master.SQL_TABLE_NAME} w on a.week = cast(regexp_replace(w.sales_week, '[/W]', '') as int64) and w.fiscal_year = 'FY2020'
    #              group by b.cust_cd, w.fiscal_year) as fy_teu on fy_teu.cust_cd = a.cust_cd
    #  where a.delt_flg in ('N','false')
    #  and a.cust_cd is not null
    #  and 0 < ( CASE WHEN IFNULL(g.key_acct_tp_cd, 'XXX') not in ('GKA','RKA','LKA') THEN fy_teu.teu ELSE 1 END)
    #   ;;

    sql:  select  distinct a.cust_cd,
                  a.cust_grp_id,
                  g.key_Acct_tp_cd,
                  fy_teu.fiscal_year,
                  fy_teu.teu
          from    ${v_customer_opus_n_prospect.SQL_TABLE_NAME} a
          inner join (select coalesce(cont.cust_cd, bkg.ctrt_cust_cd) as cust_cd
                      from ${of_booking.SQL_TABLE_NAME} bkg
                      left join ${of_svc_contract.SQL_TABLE_NAME} cont on bkg.svc_cont_no = cont.sc_rfa_no
                      --where bkg.svc_cont_no is null or extract(DATE from cont.ctrt_exp_dt) >= current_date()
                      ) b
          on b.cust_cd = a.cust_cd
          left join ${of_customer_group.SQL_TABLE_NAME} g on (a.cust_grp_id = g.cust_grp_id and g.delt_flg = 'N')
          left join (select b.cust_cd, w.fiscal_year, sum(bkg_teu) teu
                      from ${of_actuals.SQL_TABLE_NAME} a
                      left join ${of_svc_contract.SQL_TABLE_NAME} cont2 on a.svc_cont_no = cont2.sc_rfa_no  and extract(DATE from cont2.ctrt_exp_dt) >= current_date()
                      inner join ${v_customer_opus_n_prospect.SQL_TABLE_NAME} b on coalesce(cont2.cust_cd,a.cnt_cust_cd) = b.cust_cd and b.delt_flg in ('N','false')
                      inner join ${of_sales_week_master.SQL_TABLE_NAME} w on a.week = cast(regexp_replace(w.sales_week, '[/W]', '') as int64) and w.fiscal_year = 'FY2020'
                      --where a.svc_cont_no is null or extract(DATE from cont2.ctrt_exp_dt) >= current_date()
                      group by b.cust_cd, w.fiscal_year) as fy_teu on fy_teu.cust_cd = a.cust_cd
          where a.delt_flg in ('N','false')
          and a.cust_cd is not null
          and 0 < ( CASE WHEN IFNULL(g.key_acct_tp_cd, 'XXX') not in ('GKA','RKA','LKA') THEN fy_teu.teu ELSE 1 END )
       ;;

    #persist_for: "4 hours"
    sql_trigger_value: SELECT  CASE WHEN
          CAST(TIME_DIFF(EXTRACT(TIME FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore"),
          TIME(EXTRACT(DATE FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore")),MINUTE)
          AS INT64)  < 150 THEN 150
          WHEN
          CAST(TIME_DIFF(EXTRACT(TIME FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore"),
          TIME(EXTRACT(DATE FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore")),MINUTE)
          AS INT64)  < 510 THEN 510
          WHEN
          CAST(TIME_DIFF(EXTRACT(TIME FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore"),
          TIME(EXTRACT(DATE FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore")),MINUTE)
          AS INT64) < 870 THEN 870
          WHEN
          CAST(TIME_DIFF(EXTRACT(TIME FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore"),
          TIME(EXTRACT(DATE FROM CURRENT_TIMESTAMP() AT TIME ZONE "Asia/Singapore")),MINUTE)
          AS INT64) < 1230 THEN 1230
          ELSE 150 END ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    hidden: yes
  }

  measure: count_cust_cd {
    type: count_distinct
    sql:  ${cust_cd} ;;
    drill_fields: [detail*]
  }


  dimension: cust_cd {
    label: "Customer Code"
    type: string
    sql: ${TABLE}.cust_cd ;;
  }

  dimension: cust_grp_id {
    label: "Customer Group"
    type: string
    sql: ${TABLE}.cust_grp_id ;;
  }

  dimension: key_acct_tp_cd {
    label: "Key Account Type"
    type: string
    sql: ${TABLE}.key_Acct_tp_cd ;;
  }

  dimension: fiscal_year {
    label: "Fiscal Year"
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }

  dimension: teu {
    label: "FY. TEU"
    type: number
    sql: ${TABLE}.teu ;;
  }

  set: detail {
    fields: [cust_cd, cust_grp_id, key_acct_tp_cd, teu]
  }
}

# include: "of_user.view"
view: of_user_duplicate_cust_grp {
  extends: [of_user]

  dimension: rhq_code {
    type: string
    label: "RHQ Code"
    sql: CASE WHEN ${username} = 'crm.systemuser@one-line.com' then 'Unclaimed'
      ELSE (case when ${regional_head_office} is not null then trim(substr(${regional_head_office}, instr(${regional_head_office},'-',-1)+1)) else NULL end ) END ;;
  }

  dimension: country {
    type: string
    sql: case when ${username} = 'crm.systemuser@one-line.com' then 'Unclaimed' else ${TABLE}.Country end;;
  }

  dimension: office_code_new {
    type: string
    sql: case when ${username} = 'crm.systemuser@one-line.com' then 'Unclaimed' else ${TABLE}.Office_Code_Number end;;
  }


}

view: duplicate_cust_grp {
  derived_table: {
    sql: WITH dup_grp_idx_list AS (
         SELECT dup_grp_idx_cd,
                string_agg(g.cust_grp_id) cust_grp_id_lst,
                count(1) cust_grp_cnt,
                count( NULLIF(g.delt_flg,'Y') )  cust_grp_cnt_active,
                case when ( sum(case when g.delt_flg = 'N' and g.vld_retn_flg = 'Y' then 1 else 0 end) = 1 ) then 'Y' else 'N' end as vld_retn_identified,
                CASE WHEN COUNT(DISTINCT IFNULL( g.key_acct_tp_cd,'SME')) > 1 THEN 'Y' ELSE 'N' END as inconsistent_acct_typ,
                CASE WHEN MAX( upper(trim(g.cust_grp_nm)) ) = MIN( upper(trim(g.cust_grp_nm)) ) THEN 'Exact Match' ELSE 'Partial Match' END as matching_condition
         FROM `ONEFORCE.OF_CUSTOMER_GROUP`  g
         --where g.DELT_FLG  = 'N' and ( g.dup_grp_idx_cd IS NOT NULL  )
         where ( g.dup_grp_idx_cd IS NOT NULL  )
         group by dup_grp_idx_cd having count(1) > 1
      ),
      gam_list as (
         SELECT Customer_Group, sales_person, row_num_per_cust_grp
         FROM ( SELECT t.Customer_Group, t.sales_person,
                ROW_NUMBER() OVER (PARTITION BY t.Customer_Group  ) AS row_num_per_cust_grp
                FROM `ONEFORCE.OF_SALES_TEAM_MEMBER`  t
                WHERE team_role = 'Global Account Manager (GAM)' and inactive = 'false' order by t.Customer_Group
              )
         WHERE row_num_per_cust_grp = 1
      ),
      bkg_list as (
         SELECT coalesce(sc.cust_cd, bkg.ctrt_cust_cd) as ctrt_cust_cd,
                SUM( bkg.bkg_teu) teu
         FROM `ONEFORCE.OF_BOOKING` bkg
         INNER JOIN `ONEFORCE.OF_SALES_WEEK_MASTER` wk ON (bkg.week = cast(wk.sales_week as INT64) )
         LEFT JOIN `ONEFORCE.OF_SVC_CONTRACT` sc ON (bkg.svc_cont_no = sc.sc_rfa_no)
         WHERE EXISTS ( SELECT 1
                        FROM  `ONEFORCE.OF_CUSTOMER` cust
                        INNER JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g ON (cust.cust_grp_id = g.cust_grp_id)
                        WHERE coalesce(sc.cust_cd, bkg.ctrt_cust_cd) = cust.cust_cd
                        AND   EXISTS (select 1 from dup_grp_idx_list l where g.dup_grp_idx_cd = l.dup_grp_idx_cd )
                      )
         AND   {% condition fiscal_year_filter   %} wk.fiscal_year   {% endcondition %}
         AND   {% condition calendar_year_filter %} wk.calendar_year {% endcondition %}
         AND   {% condition sales_month_filter   %} wk.sales_month   {% endcondition %}
         AND   bkg.bkg_sts_cd NOT IN ('X')
         group by 1
      ),
      child_cust_list as (
         SELECT c.ONEForce_Id,
                c.cust_cd,
                c.name,
                c.cust_grp_id,
                c.delt_flg,
                c.of_owner_id     as cust_owner_id ,
                ofc.modi_cust_cd2 as to_be_cust_cd ,
                (CASE WHEN c.vld_retn_flg = 'true' THEN 'Y' ELSE 'N' END)    as vld_retn_flg  ,
                (CASE WHEN c.poten_dup_flg = 'true' THEN 'Y' ELSE 'N' END)   as poten_dup_flg ,
                (CASE WHEN c.delt_flg in ('N', 'false' ) THEN 'Active' ELSE 'Inactive' END ) as active_flg,
                (CASE WHEN c.Commercial = 'true' THEN 'Y' ELSE 'N' END) as is_contract_cust,
                ( CASE substr(c.cust_grp_hrchy_cd,1,1)
                  WHEN 'G' THEN 'Global' WHEN 'R' THEN 'Regional' WHEN 'C' THEN 'County' WHEN 'I' THEN 'Individual' END) as ofc_type,
                ( CASE substr(c.cust_grp_hrchy_cd,1,1)
                  WHEN 'G' THEN 1 WHEN 'R' THEN 2 WHEN 'C' THEN 3 WHEN 'I' THEN 4 ELSE 5 END) as ofc_type_order,
                ROW_NUMBER() OVER (PARTITION BY c.cust_grp_id
                ORDER BY (CASE substr(c.cust_grp_hrchy_cd,1,1) WHEN 'G' THEN 1 WHEN 'R' THEN 2 WHEN 'C' THEN 3 WHEN 'I' THEN 4 ELSE 5 END), b.teu DESC )  AS row_num_per_cust_grp,
                FIRST_VALUE(u.regional_head_office) OVER (PARTITION BY c.cust_grp_id
                ORDER BY (CASE substr(c.cust_grp_hrchy_cd,1,1) WHEN 'G' THEN 1 WHEN 'R' THEN 2 WHEN 'C' THEN 3 WHEN 'I' THEN 4 ELSE 5 END), b.teu DESC ) AS top_child_rhq,
                FIRST_VALUE(u.email) OVER (PARTITION BY c.cust_grp_id
                ORDER BY (CASE substr(c.cust_grp_hrchy_cd,1,1) WHEN 'G' THEN 1 WHEN 'R' THEN 2 WHEN 'C' THEN 3 WHEN 'I' THEN 4 ELSE 5 END), b.teu DESC ) AS top_child_srep_eml,
                FIRST_VALUE(u.firstname||' '||u.lastname) OVER (PARTITION BY c.cust_grp_id
                ORDER BY (CASE substr(c.cust_grp_hrchy_cd,1,1) WHEN 'G' THEN 1 WHEN 'R' THEN 2 WHEN 'C' THEN 3 WHEN 'I' THEN 4 ELSE 5 END), b.teu DESC ) AS top_child_srep_fullname,
                FIRST_VALUE(u.office_code_number) OVER (PARTITION BY c.cust_grp_id
                ORDER BY (CASE substr(c.cust_grp_hrchy_cd,1,1) WHEN 'G' THEN 1 WHEN 'R' THEN 2 WHEN 'C' THEN 3 WHEN 'I' THEN 4 ELSE 5 END), b.teu DESC ) AS top_child_office_code_number,
                FIRST_VALUE(u.country) OVER (PARTITION BY c.cust_grp_id
                ORDER BY (CASE substr(c.cust_grp_hrchy_cd,1,1) WHEN 'G' THEN 1 WHEN 'R' THEN 2 WHEN 'C' THEN 3 WHEN 'I' THEN 4 ELSE 5 END), b.teu DESC ) AS top_child_country
         FROM `ONEFORCE.V_CUSTOMER_OPUS_N_PROSPECT` c
         LEFT JOIN `ONEFORCE.OF_CUSTOMER` ofc ON (c.cust_cd = ofc.cust_cd)
         LEFT JOIN `ONEFORCE.OF_USER` u ON (c.of_owner_id = u.ONEForce_ID)
         LEFT JOIN bkg_list b ON (c.cust_cd = b.ctrt_cust_cd)
         WHERE c.cust_cd not like 'G-%'
         AND EXISTS ( SELECT 1 FROM `ONEFORCE.OF_CUSTOMER_GROUP`  g
                        WHERE c.cust_grp_id = g.cust_grp_id
                        AND EXISTS (select 1 from dup_grp_idx_list l where g.dup_grp_idx_cd = l.dup_grp_idx_cd )
                     )
      ),
      cust_grp_list as (
         SELECT l.dup_grp_idx_cd,
                l.cust_grp_cnt,
                g.cust_grp_id,
                u.email,
                u.firstname,
                u.lastname,
                u.office_code_number,
                u.country,
                u.regional_head_office,
                coalesce(u.email,  MAX(top_child_srep_eml) ) pic_email,
                CASE WHEN u.email IS NOT NULL THEN u.firstname||' '||u.lastname ELSE MAX(c.top_child_srep_fullname ) END  as pic_fullname,
                coalesce(u.office_code_number,  MAX(c.top_child_office_code_number) ) for_ref_office,
                coalesce(u.country,  MAX(c.top_child_country) ) for_ref_country,
                coalesce(u.regional_head_office,  MAX(c.top_child_rhq) ) for_ref_rhq,
                ROW_NUMBER() OVER (PARTITION BY l.dup_grp_idx_cd ORDER by g.cust_grp_id) AS row_num_per_dup_grp,
                max(g.oneforce_id) as cust_grp_oneforce_id,
                max(g.cust_grp_nm) as cust_grp_nm,
                (CASE WHEN max(g.delt_flg) = 'Y' THEN 'Inactive' ELSE 'Active' END) as active_flg,
                (CASE WHEN max(g.vld_retn_flg) = 'Y' THEN 'Y' ELSE 'N' END ) as vld_retn_flg,
                max(g.dup_grp_cgrp_cd) as dup_grp_cgrp_cd,
                max(g.cntr_cust_tp_cd) as cntr_cust_tp_cd,
                replace( IFNULL( max(g.key_acct_tp_cd),'SME'), 'SME', 'ONE Care') as key_acct_tp_cd,
                max(gam.sales_person) as gam_usr_id,
                count(distinct c.ONEForce_ID) as child_cust_cnt,
                sum( case when c.delt_flg in ('false','N') then 1 else 0 end  ) as child_cust_cnt_active
         FROM `ONEFORCE.OF_CUSTOMER_GROUP`  g
         INNER JOIN dup_grp_idx_list l on (g.dup_grp_idx_cd = l.dup_grp_idx_cd )
         LEFT JOIN gam_list gam on (g.ONEForce_Id  = gam.Customer_Group )
         LEFT JOIN `ONEFORCE.OF_USER` u ON (gam.sales_person = u.ONEForce_ID)
         LEFT JOIN child_cust_list c ON (c.cust_grp_id = g.cust_grp_id AND c.cust_cd NOT LIKE 'G-%'  )
         GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9
      )
      SELECT
      -- duplicate grp set
      cast(g.dup_grp_idx_cd as int64) as dup_grp_idx_cd                ,
      l.cust_grp_cnt                  as cust_grp_cnt                  ,
      l.cust_grp_cnt_active           as cust_grp_cnt_active           ,
      l.vld_retn_identified           as vld_retn_identified           ,
      l.inconsistent_acct_typ         as inconsistent_acct_typ         ,
      l.cust_grp_id_lst               as cust_grp_id_lst               ,
      l.matching_condition            as matching_condition            ,
      FIRST_VALUE(g.for_ref_office)  OVER (PARTITION BY g.dup_grp_idx_cd ORDER BY g.child_cust_cnt_active DESC, g.cust_grp_id ASC) AS dup_grp_for_ref_office,
      FIRST_VALUE(g.for_ref_country) OVER (PARTITION BY g.dup_grp_idx_cd ORDER BY g.child_cust_cnt_active DESC, g.cust_grp_id ASC) AS dup_grp_for_ref_country,
      FIRST_VALUE(g.for_ref_rhq)     OVER (PARTITION BY g.dup_grp_idx_cd ORDER BY g.child_cust_cnt_active DESC, g.cust_grp_id ASC) AS dup_grp_for_ref_rhq,
      FIRST_VALUE(g.pic_email)       OVER (PARTITION BY g.dup_grp_idx_cd ORDER BY g.child_cust_cnt_active DESC, g.cust_grp_id ASC) AS dup_grp_pic_email,
      FIRST_VALUE(g.pic_fullname)    OVER (PARTITION BY g.dup_grp_idx_cd ORDER BY g.child_cust_cnt_active DESC, g.cust_grp_id ASC) AS dup_grp_pic_fullname,
      -- customer group
      g.row_num_per_dup_grp         as cust_grp_row_num           ,
      g.cust_grp_id                 as cust_grp_id                ,
      g.cust_grp_nm                 as cust_grp_nm                ,
      g.active_flg                  as cust_grp_active_flg        ,
      g.vld_retn_flg                as cust_grp_vld_retn_flg      ,
      g.key_acct_tp_cd              as key_acct_tp_cd             ,
      g.for_ref_rhq                 as cust_grp_for_ref_rhq       ,
      g.pic_email                   as cust_grp_pic_email         ,
      g.pic_fullname                as cust_grp_pic_fullname      ,
      g.gam_usr_id                  as gam_usr_id                 ,
      gam_usr.email                 as gam_usr_email              ,
      gam_usr.office_code_number    as gam_usr_office_code_number ,
      gam_usr.country               as gam_usr_country            ,
      gam_usr.regional_head_office  as gam_usr_rhq                ,
      gam_usr.firstname ||' '||gam_usr.lastname
                                    as gam_usr_fullname           ,
      g.child_cust_cnt              as child_cust_cnt             ,
      g.child_cust_cnt_active       as child_cust_cnt_active      ,
      -- child customers
      IFNULL(c.row_num_per_cust_grp,0)  as child_row_num_per_cust_grp  ,
      c.cust_cd                         as child_cust_cd               ,
      c.name                            as child_cust_name             ,
      c.active_flg                      as child_cust_active_flg       ,
      c.to_be_cust_cd                   as child_cust_to_be_cust_cd    ,
      c.is_contract_cust                as child_cust_is_contract      ,
      c.poten_dup_flg                   as child_cust_poten_dup_flg    ,
      c.vld_retn_flg                    as child_cust_vld_rtn_flg      ,
      c.ofc_type                        as child_cust_off_type         ,
      c.ofc_type_order                  as child_cust_off_type_order   ,
      c.cust_owner_id                   as child_cust_owner_id         ,
      c.top_child_rhq                   as child_cust_top_child_rhq    ,
      b.teu                             as child_cust_teu
      FROM cust_grp_list g
      LEFT JOIN dup_grp_idx_list l ON (g.dup_grp_idx_cd = l.dup_grp_idx_cd )
      LEFT JOIN child_cust_list c ON (c.cust_grp_id = g.cust_grp_id)
      LEFT JOIN bkg_list b ON (c.cust_cd = b.ctrt_cust_cd)
      LEFT JOIN `ONEFORCE.OF_USER`  gam_usr ON ( g.gam_usr_id = gam_usr.ONEForce_Id)
      order by
      cast(g.dup_grp_idx_cd as int64),
      g.cust_grp_id,
      IFNULL(c.row_num_per_cust_grp,0)
      ;;
  }

  filter: fiscal_year_and_quarter_filter {
    type: string
    suggest_explore: of_sales_week_master
    suggest_dimension: of_sales_week_master.fiscal_year_and_quarter
  }

  filter: fiscal_year_filter {
    type: string
    suggest_explore: of_sales_week_master
    suggest_dimension: of_sales_week_master.fiscal_year
  }

  filter: calendar_year_filter {
    type: string
    suggest_explore: of_sales_week_master
    suggest_dimension: of_sales_week_master.calendar_year
  }

  filter: sales_month_filter {
    type: string
    suggest_explore: of_sales_week_master
    suggest_dimension: of_sales_week_master.sales_month
  }

  filter: grp_without_active_children_filter {
    type: string
    label: "With/without active children"
    suggestions: ["With active children","Without active children"]
    sql: ( ({% condition %} 'With active children' {% endcondition %} AND ${child_cust_cnt_active} >= 1) OR
      ({% condition %} 'Without active children' {% endcondition %} AND ${child_cust_cnt_active} = 0 )  ) ;;
  }

  filter: effect_on_excl_inactive_filter {
    type: string
    label: "Effect on excluding inactive cust grps"
    suggestions: ["Remaining duplicate","No longer duplicate"]
    sql: ( ({% condition %} 'Remaining duplicate' {% endcondition %} AND ${cust_grp_cnt_active}  > 1) OR
      ({% condition %} 'No longer duplicate' {% endcondition %} AND ${cust_grp_cnt_active} <= 1) ) ;;
  }

  filter: child_cust_donotuse_filter {
    type: string
    label: "Are Child Custs [Do not use]?"
    suggestions: ["Yes","No"]
    sql: ( ({% condition %} 'Yes' {% endcondition %} AND upper(${child_cust_name}) like '%DO NOT USE%') OR
      ({% condition %} 'No'  {% endcondition %} AND upper(${child_cust_name}) not like '%DO NOT USE%') ) ;;
  }

  parameter: dup_set_count_dimension_param {
    label: "Duplicate Set Count Dimension (Param)"
    type: string
    allowed_value: { value: "RHQ"  label: "RHQ"     }
    allowed_value: { value: "CTRY" label: "Country" }
    allowed_value: { value: "OFC"  label: "Office"  }
    default_value: "RHQ"
  }

  dimension: dup_set_count_dimension  {
    type: string
    label_from_parameter:  dup_set_count_dimension_param
    sql:
      {% if dup_set_count_dimension_param._parameter_value == "'RHQ'" %}
        ${dup_grp_for_ref_rhq}
      {% elsif dup_set_count_dimension_param._parameter_value == "'CTRY'" %}
        ${dup_grp_for_ref_country}
      {% elsif dup_set_count_dimension_param._parameter_value == "'OFC'" %}
        ${dup_grp_for_ref_office}
      {% endif %};;
    drill_fields: [dup_grp_for_ref_country, dup_grp_for_ref_office]
  }

  dimension: dup_grp_idx_cd {
    #type: string
    type: number
    label: "Duplicate Set Index"
    sql: ${TABLE}.dup_grp_idx_cd ;;
    #sql: '<span style="color: red;">'|| ${TABLE}.dup_grp_idx_cd || '</span>'  ;;
    #html: <span style="color: red;"> {{rendered_value}} </span>  ;;
  }

  # Sales Process Landing Page ----- Start -------
  dimension: dup_grp_idx_cd1 {
    #type: string
    type: number
    label: "Duplicate Set Index1"
    sql: ${TABLE}.dup_grp_idx_cd ;;
    drill_fields:[dup_grp_idx_cd, cust_grp_id_lst, dup_grp_for_ref_rhq, dup_grp_pic_email, cust_grp_cnt, cust_grp_row_num, cust_grp_nm, cust_grp_id]
  }
  # Sales Process Landing Page ----- End -------

  dimension: dup_grp_idx_cd_even_odd {
    type: number
    label: "Duplicate Set Index - Even / Odd"
    sql: MOD( ${TABLE}.dup_grp_idx_cd , 2 );;
  }

  dimension: dup_grp_for_ref_office {
    type: string
    label: "Duplicate Set PIC Office"
    drill_fields: [dup_grp_for_ref_rhq, dup_grp_for_ref_country]
    sql: case when ${TABLE}.dup_grp_pic_email = 'crm.systemuser@one-line.com'  then null else ${TABLE}.dup_grp_for_ref_office end ;;
  }

  dimension: dup_grp_for_ref_country {
    type: string
    label: "Duplicate Set PIC Country"
    drill_fields: [dup_grp_for_ref_rhq, dup_grp_for_ref_office]
    sql: case when ${TABLE}.dup_grp_for_ref_country like  '%Unclaimed%' then null else ${TABLE}.dup_grp_for_ref_country end ;;
  }

  dimension: dup_grp_for_ref_rhq {
    type: string
    label: "Duplicate Set PIC RHQ"
    drill_fields: [dup_grp_for_ref_country, dup_grp_for_ref_office]
    sql: case when ${TABLE}.dup_grp_for_ref_rhq like 'Unclaimed%' then null
      else trim(substr( ${TABLE}.dup_grp_for_ref_rhq , instr( ${TABLE}.dup_grp_for_ref_rhq ,'-',-1)+1)) end ;;
  }

  dimension: dup_grp_pic_email {
    type: string
    label: "Duplicate Set PIC Email"
    sql: ${TABLE}.dup_grp_pic_email;;
  }

  dimension: dup_grp_pic_fullname {
    type: string
    label: "Duplicate Set PIC Fullname"
    sql: ${TABLE}.dup_grp_pic_fullname;;
  }

  dimension: cust_grp_cnt {
    type: number
    label: "No. of Cust Grps in this Set"
    sql: ${TABLE}.cust_grp_cnt ;;
  }

  dimension: cust_grp_cnt_active {
    type: number
    label: "No. of Active Cust Grps in this Set"
    sql: ${TABLE}.cust_grp_cnt_active ;;
  }

  dimension: no_longer_dup_on_excl_deleted {
    type: string
    label: "No longer duplicate on excluding inactived ones"
    sql: ${TABLE}.no_longer_dup_on_excl_deleted ;;
  }

  dimension: vld_retn_identified {
    type: string
    label: "[Validated and Retained] Identified"
    sql: ${TABLE}.vld_retn_identified ;;
  }

  dimension: cust_grp_id_lst {
    type: string
    label: "Grp Codes in this Set"
    sql: ${TABLE}.cust_grp_id_lst ;;
  }

  dimension: matching_condition {
    type: string
    label: "Matching Condition"
    sql: ${TABLE}.matching_condition ;;
  }

  dimension: cust_grp_row_num {
    type: number
    label: "G-codes rownum per grp"
    sql: ${TABLE}.cust_grp_row_num ;;
  }

  dimension: cust_grp_id {
    type: string
    label: "Cust Grp Code"
    sql: ${TABLE}.cust_grp_id ;;
  }

  dimension: cust_grp_nm {
    type: string
    label: "Cust Grp Name"
    sql: ${TABLE}.cust_grp_nm ;;
  }

  dimension: cust_grp_id_n_nm {
    type: string
    label: "Cust Grp Code and Name"
    sql: ${cust_grp_id} ||' - '|| ${cust_grp_nm} ;;
  }

  dimension: cust_grp_active_flg {
    type: string
    label: "Cust Grp Active/Inactive"
    sql: ${TABLE}.cust_grp_active_flg ;;
  }

  dimension: cust_grp_vld_retn_flg {
    type: string
    label: "Cust Grp Valdated and Retained"
    sql: ${TABLE}.cust_grp_vld_retn_flg ;;
  }

  dimension: cust_grp_pic_email {
    type: string
    label: "Cust Grp PIC Email"
    sql: ${TABLE}.cust_grp_pic_email ;;
  }

  dimension: key_acct_tp_cd {
    type: string
    label: "Cust Grp Key Account Type"
    order_by_field: key_acct_tp_cd_order
    sql: ${TABLE}.key_acct_tp_cd ;;
  }

  dimension: key_acct_tp_cd_order {
    type: number
    label: "Cust Grp Key Account Type Sort Order"
    sql: CASE key_acct_tp_cd WHEN 'GKA' THEN 1 WHEN 'RKA' THEN 2 WHEN 'LKA' THEN 3  WHEN 'ONE Care' THEN 4 ELSE 5 END    ;;
  }

  dimension: inconsistent_acct_typ {
    type: string
    label: "Inconsistent Key Account Type"
    sql: ${TABLE}.inconsistent_acct_typ ;;
  }

  dimension: gam_usr_id {
    type: string
    label: "GAM Usr Id"
    sql: ${TABLE}.gam_usr_id ;;
  }

  dimension: gam_usr_email {
    type: string
    label: "GAM Email"
    sql: ${TABLE}.gam_usr_email ;;
  }

  dimension: gam_usr_fullname {
    type: string
    label: "GAM Fullname"
    sql: ${TABLE}.gam_usr_fullname ;;
  }

  dimension: gam_usr_office_code_number {
    type: string
    label: "GAM Office Code"
    sql: ${TABLE}.gam_usr_office_code_number ;;
  }

  dimension: gam_usr_country {
    type: string
    label: "GAM Office Country"
    sql: ${TABLE}.gam_usr_country ;;
  }

  dimension: gam_usr_rhq {
    type: string
    label: "GAM Office RHQ Full Name"
    sql: ${TABLE}.gam_usr_rhq ;;
  }

  dimension: gam_usr_rhq_short_nm {
    type: string
    label: "GAM Office RHQ"
    sql: case when ${gam_usr_rhq} is not null then trim(substr(${gam_usr_rhq}, instr(${gam_usr_rhq},'-',-1)+1)) else NULL end;;
  }

  dimension: for_ref_rhq {
    type: string
    label: "For-reference RHQ"
    sql: case when  coalesce(gam_usr_rhq,child_cust_top_child_rhq) like 'Unclaimed%' then null
      else trim(substr( coalesce(gam_usr_rhq,child_cust_top_child_rhq) , instr( coalesce(gam_usr_rhq,child_cust_top_child_rhq) ,'-',-1)+1)) end ;;
  }

  dimension: cust_grp_for_ref_rhq {
    type: string
    label: "Cust Grp for-ref RHQ"
    sql: case when ${TABLE}.cust_grp_for_ref_rhq like 'Unclaimed%' then null
      else trim(substr( ${TABLE}.cust_grp_for_ref_rhq , instr( ${TABLE}.cust_grp_for_ref_rhq ,'-',-1)+1)) end ;;
  }

  dimension: child_cust_cnt {
    type: number
    label: "No. of children in this cust grp"
    sql: ${TABLE}.child_cust_cnt ;;
  }

  dimension: child_cust_cnt_active {
    type: number
    label: "No. of acitve children in this cust grp"
    sql: ${TABLE}.child_cust_cnt_active ;;
  }

  dimension: child_cust_cnt_active_n_total {
    type: string
    label: "No. of acitve children vs total"
    sql: ${TABLE}.child_cust_cnt_active || '/' || ${TABLE}.child_cust_cnt ;;
  }

  dimension: child_row_num_per_cust_grp {
    type: number
    label: "Child cust row num per grp"
    sql: ${TABLE}.child_row_num_per_cust_grp ;;
  }

  dimension: child_cust_cd {
    type: string
    label: "Child Cust Code"
    sql: ${TABLE}.child_cust_cd ;;
  }

  dimension: child_cust_name {
    type: string
    label: "Child Cust Name"
    sql: ${TABLE}.child_cust_name ;;
  }

  dimension: child_cust_cd_n_name {
    type: string
    label: "Child Cust Code & Name"
    sql: ${child_cust_cd} || ' - ' || ${child_cust_name} ;;
  }

  dimension: child_cust_active_flg {
    type: string
    label: "Child Cust Active/Inactive"
    sql: ${TABLE}.child_cust_active_flg ;;
  }

  dimension: child_cust_to_be_cust_cd {
    type: string
    label: "Child Cust to be customer code"
    sql: ${TABLE}.child_cust_to_be_cust_cd ;;
  }

  dimension: child_cust_is_contract {
    type: string
    label: "Child Cust - Is Contract Customer"
    sql: ${TABLE}.child_cust_is_contract ;;
  }

  dimension: child_cust_poten_dup_flg {
    type: string
    label: "Child Cust - Potential Duplicate"
    sql: ${TABLE}.child_cust_poten_dup_flg ;;
  }

  dimension: child_cust_vld_rtn_flg {
    type: string
    label: "Child Cust - Validated and Retained"
    sql: ${TABLE}.child_cust_vld_rtn_flg ;;
  }

  dimension: child_cust_off_type {
    type: string
    label: "Child Cust - Office Type"
    sql: ${TABLE}.child_cust_off_type ;;
  }

  dimension: child_cust_off_type_order {
    type: number
    label: "Child Cust - Office Type Order"
    sql: ${TABLE}.child_cust_off_type_order ;;
  }

  dimension: child_cust_owner_id {
    type: string
    label: "Child Cust - Owner Id"
    sql: ${TABLE}.child_cust_owner_id ;;
  }

  dimension: child_cust_top_child_rhq {
    type: string
    label: "Child Cust - For-ref RHQ"
    sql: ${TABLE}.child_cust_top_child_rhq ;;
  }

  dimension: child_cust_teu {
    type: number
    label: "Child Cust - TEU"
    sql: ${TABLE}.child_cust_teu ;;
  }

  #set: detail {
  #  fields: [
  #    dup_grp_idx_cd,
  #    cust_grp_cnt,
  #    cust_grp_row_num,
  #    cust_grp_id,
  #    cust_grp_nm,
  #    cust_grp_active_flg,
  #    cust_grp_vld_retn_flg,
  #    key_acct_tp_cd,
  #    gam_usr_id,
  #    gam_usr_email,
  #    gam_usr_office_code_number,
  #    gam_usr_rhq,
  #    child_cust_cnt,
  #    child_row_num_per_cust_grp,
  #    child_cust_cd,
  #    child_cust_name,
  #    child_cust_active_flg,
  #    child_cust_to_be_cust_cd,
  #    child_cust_is_contract,
  #    child_cust_poten_dup_flg,
  #    child_cust_vld_rtn_flg,
  #    child_cust_off_type,
  #    child_cust_off_type_order,
  #    child_cust_owner_id,
  #    child_cust_teu
  #  ]
  #}
}

view: equipment_category {
  derived_table: {
    sql:
      SELECT '20ST'  as equipment_type_abbreviation, 'D2' as equipment_type_size, 'Dry Van' as equipment_category
      UNION ALL
      SELECT '20HC'  as equipment_type_abbreviation, 'D3' as equipment_type_size, 'Dry Van' as equipment_category
      UNION ALL
      SELECT '40ST'  as equipment_type_abbreviation, 'D4' as equipment_type_size, 'Dry Van' as equipment_category
      UNION ALL
      SELECT '40HC'  as equipment_type_abbreviation, 'D5' as equipment_type_size, 'Dry Van' as equipment_category
      UNION ALL
      SELECT '45HC'  as equipment_type_abbreviation, 'D7' as equipment_type_size, 'Dry Van' as equipment_category
      UNION ALL
      SELECT '20RF-RAD'  as equipment_type_abbreviation, 'R2-DRY' as equipment_type_size, 'Dry Van' as equipment_category
      UNION ALL
      SELECT '40HR-RAD'  as equipment_type_abbreviation, 'R5-DRY' as equipment_type_size, 'Dry Van' as equipment_category
      UNION ALL
      SELECT '45HR-RAD'  as equipment_type_abbreviation, 'R7-DRY' as equipment_type_size, 'Dry Van' as equipment_category
      UNION ALL
      SELECT 'LIVE FISH-RAD'  as equipment_type_abbreviation, 'R8-DRY' as equipment_type_size, 'Dry Van' as equipment_category
      UNION ALL
      SELECT '20RF'  as equipment_type_abbreviation, 'R2' as equipment_type_size, 'Reefer' as equipment_category
      UNION ALL
      SELECT '40HR'  as equipment_type_abbreviation, 'R5' as equipment_type_size, 'Reefer' as equipment_category
      UNION ALL
      SELECT '45HR'  as equipment_type_abbreviation, 'R7' as equipment_type_size, 'Reefer' as equipment_category
      UNION ALL
      SELECT 'LIVE FISH'  as equipment_type_abbreviation, 'R8' as equipment_type_size, 'Reefer' as equipment_category
      UNION ALL
      SELECT 'BULK'  as equipment_type_abbreviation, 'B4' as equipment_type_size, 'Special' as equipment_category
      UNION ALL
      SELECT '20FR'  as equipment_type_abbreviation, 'F2' as equipment_type_size, 'Special' as equipment_category
      UNION ALL
      SELECT '40FR'  as equipment_type_abbreviation, 'F4' as equipment_type_size, 'Special' as equipment_category
      UNION ALL
      SELECT '40FT'  as equipment_type_abbreviation, 'F5' as equipment_type_size, 'Special' as equipment_category
      UNION ALL
      SELECT '20OT'  as equipment_type_abbreviation, 'O2' as equipment_type_size, 'Special' as equipment_category
      UNION ALL
      SELECT '40OT'  as equipment_type_abbreviation, 'O4' as equipment_type_size, 'Special' as equipment_category
      UNION ALL
      SELECT '40HO'  as equipment_type_abbreviation, 'O5' as equipment_type_size, 'Special' as equipment_category
      UNION ALL
      SELECT '40HC PALLET WIDE'  as equipment_type_abbreviation, 'P5' as equipment_type_size, 'Special' as equipment_category
      UNION ALL
      SELECT '45HC PALLET WIDE'  as equipment_type_abbreviation, 'P7' as equipment_type_size, 'Special' as equipment_category
      UNION ALL
      SELECT 'DEAD SPACE 20FT'  as equipment_type_abbreviation, 'Q2' as equipment_type_size, 'Special' as equipment_category
      UNION ALL
      SELECT 'DEAD SPACE 40FT'  as equipment_type_abbreviation, 'Q4' as equipment_type_size, 'Special' as equipment_category
      UNION ALL
      SELECT 'DEAD SPACE 45FT'  as equipment_type_abbreviation, 'Q5' as equipment_type_size, 'Special' as equipment_category
      UNION ALL
      SELECT '20TK'  as equipment_type_abbreviation, 'T2' as equipment_type_size, 'Special' as equipment_category
      UNION ALL
      SELECT '40TK'  as equipment_type_abbreviation, 'T4' as equipment_type_size, 'Special' as equipment_category
    ;;
  }


  dimension: equipment_type_size {
    primary_key: yes
    view_label: "B/L Information"
    label: "Container Type Size Code"
    type: string
    sql: ${TABLE}.equipment_type_size ;;
    hidden: yes
  }

  dimension: equipment_type_abbreviation {
    view_label: "B/L Information"
    label: "Container Type Abbreviation"
    type: string
    sql: ${TABLE}.equipment_type_abbreviation ;;
  }

  dimension: equipment_category {
    view_label: "B/L Information"
    label: "Container Category"
    type: string
    sql: ${TABLE}.equipment_category ;;
  }
}

view: gam_mapping {
  derived_table: {
    sql:
    SELECT customer_group       as customer_grp_oneforce_id,
           CUST_GRP_ID          as customer_grp_id,
           Sales_Person         as gam_usr_id,
    FROM (
      SELECT
      s.customer_group,
      g.CUST_GRP_ID ,
      s.Sales_Person,
      u.Username,
      row_number() OVER (PARTITION BY s.customer_group ORDER BY s.LastModifiedDate DESC, s.CreatedDate DESC) as rn
      FROM `ONEFORCE.OF_SALES_TEAM_MEMBER` s
      INNER JOIN `ONEFORCE.OF_USER`           u on (s.Sales_Person   = u.ONEForce_ID)
      INNER JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g on (s.customer_group = g.ONEForce_ID)
      WHERE s.team_role like 'Global Account Manager (GAM)' and s.inactive = 'false'
    ) WHERE rn = 1
     ;;

    persist_for: "1 hour"
  }

  dimension: customer_grp_oneforce_id {
    type: string
    sql: ${TABLE}.customer_grp_oneforce_id ;;
  }

  dimension: customer_grp_id {
    type: string
    sql: ${TABLE}.customer_grp_id ;;
  }

  dimension: gam_usr_id {
    type: string
    sql: ${TABLE}.gam_usr_id ;;
  }

  set: detail {
    fields: [customer_grp_oneforce_id, customer_grp_id, gam_usr_id]
  }
}

view: global_cva_completion {
  derived_table: {

    sql:
          select v.cust_cd, v.name as customer_name,
                 case when g.global_customer_type = "N" then "NVO"
                      when g.global_customer_type = "B" then "BCO"
                      else g.global_customer_type end as nvo_bco_flag,
                gam.fullname as gam_name, g.cust_grp_nm, g.cust_grp_id, aa.*
          from ${v_customer_opus_n_prospect.SQL_TABLE_NAME}  as v
          inner join ${of_customer_group.SQL_TABLE_NAME} as g on v.cust_grp_id = g.cust_grp_id
          left join (select team.customer_group, team.team_role, user.firstname||' '||user.lastname fullname,
                      Row_Number() Over (Partition By team.customer_group Order By team.oneforce_id Desc) as rn
                     from  ${of_sales_team_member.SQL_TABLE_NAME} as team
                     inner join ${of_user.SQL_TABLE_NAME} user on team.sales_person = user.oneforce_id and team.inactive = 'false'
                     where upper(team_role) like 'GLOBAL ACCOUNT MANAGER (GAM)') as gam on gam.customer_group = g.oneforce_id and gam.rn = 1
          left join ( select 'QualCVA' record_type, x.*, null rn
                      from ${global_cva_target.SQL_TABLE_NAME} as x
                      where  ( timestamp(x.end_month||' 23:59:59') >=  coalesce({% date_start date_filter %} , current_timestamp()) and timestamp(x.start_month) <=  coalesce({% date_end date_filter %},current_timestamp()) )
                      union all
                      select 'LastCVA' record_type, y.* , Row_Number() Over (Partition By cust_cd2 Order By end_month Desc) as rn
                      from ${global_cva_target.SQL_TABLE_NAME} y
                      where NOT ( timestamp(y.end_month||' 23:59:59') >=  coalesce({% date_start date_filter %} , current_timestamp())  and timestamp(y.start_month) <=  coalesce({% date_end date_filter %} , current_timestamp())  )
                      and not exists (select 1
                                      from ${global_cva_target.SQL_TABLE_NAME} z
                                      where y.cust_cd2 = z.cust_cd2
                                      and ( timestamp(z.end_month||' 23:59:59') >=  coalesce({% date_start date_filter %} , current_timestamp())  and timestamp(z.start_month) <=  coalesce({% date_end date_filter %} , current_timestamp()) )
                    )) as aa
                    on v.cust_cd = aa.cust_cd2 and 1 = (case when aa.record_type = 'QualCVA' then 1 else aa.rn end)
          where v.cust_grp_hrchy_cd = 'G' and g.delt_flg = 'N' and v.delt_flg = 'N' and v.cust_cd is not null
           ;;


  }

  filter: date_filter {
    type: date
    default_value: "today"
    convert_tz: yes
  }

  parameter: show_percent {
    allowed_value: {
      label: "Yes"
      value: "Yes"}
    allowed_value: {
      label: "No"
      value: "No"
    }
    default_value: "No"
  }

  dimension: cust_cd {
    type: string
    sql: ${TABLE}.cust_cd ;;
  }

  dimension: cust_grp_hrchy_cd {
    type: string
    sql: ${TABLE}.cust_grp_hrchy_cd ;;
  }

  dimension: cust_grp_hrchy_cd_dscr {
    type:  string
    label: "Office Type"
    sql:  ${global_cva.cust_grp_hrchy_cd_dscr} ;;
  }

  dimension: customer_target {
    type: string
    sql: ${TABLE}.customer_target ;;
    primary_key:yes
  }

  dimension: record_type {
    type: string
    sql: ${TABLE}.record_type ;;
  }

  dimension: syear {
    type: string
    sql: ${TABLE}.syear ;;
  }

  dimension: cva_name {
    type: string
    sql: ${TABLE}.cva_name ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
  }

  dimension: group_code {
    type: string
    sql: ${TABLE}.cust_grp_id ;;
  }

  dimension: group_name {
    type: string
    sql: ${TABLE}.cust_grp_nm ;;
  }

  dimension: nvo_bco_flag {
    type: string
    sql: ${TABLE}.nvo_bco_flag ;;
  }

  dimension: gam_name {
    type: string
    description: "from KA mapping"
    sql: ${TABLE}.gam_name ;;
  }

  dimension: ram_name {
    type: string
    description: "Sales Person in CVA"
    sql: ${TABLE}.cva_ram ;;
  }

  dimension: service_scope_group {
    type: string
    sql: ${TABLE}.service_scope_group ;;
  }

  dimension: service_scope {
    type: string
    sql: ${TABLE}.service_scope ;;
  }

  dimension: direction {
    type: string
    sql: ${TABLE}.direction ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
  }

  dimension: origin_country {
    type: string
    sql: ${TABLE}.origin_country ;;
  }

  dimension: destination {
    type: string
    sql: ${TABLE}.destination ;;
  }

  dimension: sc_rfa_no {
    type: string
    sql: ${TABLE}.sc_rfa_no ;;
  }

  dimension: ctrt_period_tp_cd {
    type: string
    sql: ${TABLE}.ctrt_period_tp_cd ;;
  }

  dimension: service_lane {
    type: string
    sql: ${TABLE}.service_lane ;;
  }

  dimension: cva_target {
    type: number
    sql: ${TABLE}.cva_target ;;
    value_format_name: decimal_0
  }

  dimension: start_month {
    type: date
    datatype: date
    sql: ${TABLE}.start_month ;;
  }

  dimension: end_month {
    type: date
    datatype: date
    sql: ${TABLE}.end_month ;;
  }

  dimension: latest_start_month {
    type: date
    datatype: date
    sql: CASE WHEN ${record_type} = 'QualCVA' THEN NULL ELSE ${TABLE}.start_month END ;;
  }

  dimension: latest_end_month {
    type: date
    datatype: date
    sql: CASE WHEN ${record_type} = 'QualCVA' THEN NULL ELSE ${TABLE}.end_month END;;
  }

  measure: count {
    type: count
    drill_fields: [detail_w*]
    hidden: yes
  }

  measure: cva_count_w {
    type: count_distinct
    sql: ${customer_target} ;;
    drill_fields: [detail_w*]
  }

  measure: cva_count_wo {
    type: count_distinct
    sql: ${customer_target} ;;
    drill_fields: [detail_wo*]
  }

  measure: with_CVA_count {
    label: "Completed Count"
    type: count_distinct
    sql: ${cust_cd};;
    drill_fields: [cust_detail_w*]
    filters: [record_type: "QualCVA"]
    link: {
      label: "By Customer"
      url: "{{ with_CVA_count._link }}"
    }
    link: {
      label: "By CVA"
      url: "{{ cva_count_w._link }}"
    }
  }

  measure: with_CVA_count2 {
    label: "Completion"
    type: count_distinct
    sql: ${cust_cd};;
    drill_fields: [cust_detail_w*]
    filters: [record_type: "QualCVA"]
    link: {
      label: "By Customer"
      url: "{{ with_CVA_count._link }}"
    }
    link: {
      label: "By CVA"
      url: "{{ cva_count_w._link }}"
    }
  }

  measure: without_CVA_count {
    label: "Not Completed Count"
    type: count_distinct
    sql: ${cust_cd};;
    drill_fields: [cust_detail_wo*]
    filters: [record_type: "-QualCVA", cust_cd: "-null"]
    link: {
      label: "By Customer"
      url: "{{ without_CVA_count._link }}"
    }
    link: {
      label: "By Volume Agreement"
      url: "{{ cva_count_wo._link }}"
    }
  }
  measure: without_CVA_count2 {
    label: "Outstanding"
    type: count_distinct
    sql: ${cust_cd};;
    drill_fields: [cust_detail_wo*]
    filters: [record_type: "-QualCVA", cust_cd: "-null"]
    link: {
      label: "By Customer"
      url: "{{ without_CVA_count._link }}"
    }
    link: {
      label: "By Volume Agreement"
      url: "{{ cva_count_wo._link }}"
    }
  }


  measure: with_CVA_perc {
    label: "Completed Percent"
    type: number
    sql: ${with_CVA_count}/NULLIF((${with_CVA_count}+${without_CVA_count}),0);;
    drill_fields: [cust_detail_w*]
    value_format_name: percent_0
  }

  measure: without_CVA_perc {
    label: "Not Completed Percent"
    type: number
    sql: ${without_CVA_count}/NULLIF((${with_CVA_count}+${without_CVA_count}),0);;
    drill_fields: [cust_detail_wo*]
    value_format_name: percent_0
  }

  measure: with_CVA_perc1 {
    label: "Fullfill%"
    type: number
    sql: ${with_CVA_count}/NULLIF((${with_CVA_count}+${without_CVA_count}),0);;
    drill_fields: [cust_detail_w*]
    value_format_name: percent_0
  }


  measure: Total_Teu {
    type: sum
    sql: ${cva_target} ;;
    value_format_name: decimal_0
  }

  dimension: cva_exp_date_diff_raw {
    hidden: yes
    type: number
    #sql: date_diff(timestamp(${end_month}),timestamp({% date_end date_filter %}),Day) ;;
    sql: date_diff(timestamp(${end_month}),timestamp(current_date()||' 23:59:59'),Day) ;;
  }

  dimension: cva_start_date_diff_raw {
    hidden: yes
    type: number
    #sql: date_diff(timestamp(${end_month}),timestamp({% date_end date_filter %}),Day) ;;
    sql: date_diff(timestamp(${start_month}),timestamp(current_date()||' 23:59:59'),Day) ;;
  }

  dimension: ctrt_exp_diff {
    type: string
    sql:
    CASE WHEN ${record_type} = 'QualCVA' THEN
      CASE
      WHEN ${cva_exp_date_diff_raw} IS NULL THEN 'Error'
      WHEN ${cva_exp_date_diff_raw} < 0  THEN 'Expired'
      WHEN ${cva_exp_date_diff_raw} = 0 THEN 'Today'
      WHEN ${cva_start_date_diff_raw} > 0  THEN 'Future'
      WHEN ${cva_exp_date_diff_raw} > 0  AND ${cva_exp_date_diff_raw} <= 30 THEN 'Within 1-30 days'
      WHEN ${cva_exp_date_diff_raw} >= 31 AND ${cva_exp_date_diff_raw} <= 60 THEN 'Within 31-60 days'
      WHEN ${cva_exp_date_diff_raw} >= 61 AND ${cva_exp_date_diff_raw} <= 90 THEN 'Within 61-90 days'
      WHEN ${cva_exp_date_diff_raw} >= 91 AND ${cva_start_date_diff_raw} <= 0 THEN 'more than 90 days'
      END
    ELSE
      'Not Qualified'
    END
    ;;
  }

  dimension: ctrt_exp_mtrx {
    type: string
    sql:
    CASE WHEN ${record_type} = 'QualCVA' THEN
      CASE
      WHEN ${cva_exp_date_diff_raw} IS NULL THEN 'Error'
      WHEN ${cva_exp_date_diff_raw} < 0  THEN 'Expired'
      WHEN ${cva_exp_date_diff_raw} = 0 THEN 'Today'
      WHEN ${cva_start_date_diff_raw} > 0 THEN 'Future'
      WHEN ${cva_exp_date_diff_raw} > 0  AND ${cva_exp_date_diff_raw} <= 30 THEN 'Within 1-30 days'
      WHEN ${cva_exp_date_diff_raw} >= 31 AND ${cva_exp_date_diff_raw} <= 60 THEN 'Within 31-60 days'
      WHEN ${cva_exp_date_diff_raw} >= 61 AND ${cva_exp_date_diff_raw} <= 90 THEN 'Within 61-90 days'
      WHEN ${cva_exp_date_diff_raw} >= 91 THEN 'more than 90 days'
      END
    ELSE
      CASE
      WHEN date_diff(timestamp(${end_month}),timestamp(current_date()||' 23:59:59'),Day) <= 0 THEN 'Expired'
      WHEN date_diff(timestamp(${start_month}),timestamp(current_date()||' 23:59:59'),Day) > 0 THEN 'Future'
      ELSE 'N/A'
      END
    END
    ;;
  }

  # Sales Process Landing Page ----- Start -------

  measure: with_CVA_count1 {
    label: "Completed Count"
    type: count_distinct
    sql: ${cust_cd};;
    drill_fields: [cust_detail_w*]
    filters: [record_type: "QualCVA"]

    link: {
      label: "BCO-NVO"
      url: "{{bco_comp._link}}"
    }
    link: {
      label: "Completion by GAM"
      url: "{{ bco_nvo_w._link }}"
    }

    link: {
      label: "Customer & Volume Agreement Details"
      url: "{{cust_vol_w._link}}"

    }
  }

  measure: bco_nvo_w {
    type: count_distinct
    sql: ${nvo_bco_flag} ;;
    drill_fields: [of_user.full_name1,with_CVA_perc,with_CVA_count,without_CVA_count]
  }

  measure: cust_vol_w {
    type: count_distinct
    sql: ${cust_cd} ;;
    drill_fields: [of_customer_group.cust_grp_and_name,of_customer_group.key_acct_tp_cd,start_month,end_month,cva_target]
  }

  measure: bco_comp {
    type: count_distinct
    sql: ${cust_cd} ;;
    filters: [nvo_bco_flag: "BCO, NVO"]
    drill_fields: [nvo_bco_flag,with_CVA_count]
  }

  measure: bco_outs {
    type: count_distinct
    sql: ${cust_cd} ;;
    filters: [nvo_bco_flag: "BCO, NVO"]
    drill_fields: [nvo_bco_flag,without_CVA_count]
  }

  measure: without_CVA_count1 {
    label: "Not Completed Count"
    type: count_distinct
    sql: ${cust_cd};;
    drill_fields: [cust_detail_wo*]
    filters: [record_type: "-QualCVA", cust_cd: "-null"]
    link: {
      label: "BCO-NVO"
      url: "{{bco_outs._link}}"
    }

    link: {
      label: "Completion by GAM"
      url: "{{ bco_nvo_w._link }}"
    }

    link: {
      label: "Customer & Volume Agreement Details"
      url: "{{ cust_vol_w._link }}"
    }
  }

  # Sales Process Landing Page ----- End -------

  set: detail_w {
    fields: [
      group_code,
      group_name,
      cust_cd,
      customer_name,
      nvo_bco_flag,
      cust_grp_hrchy_cd_dscr,
      gam_name,
      syear,
      cva_name,
      start_month,
      end_month,
      service_scope_group,
      service_scope,
      direction,
      origin_country,
      origin,
      destination,
      cva_target,
      customer_target
    ]
  }

  set: detail_wo {
    fields: [
      group_code,
      group_name,
      cust_cd,
      customer_name,
      nvo_bco_flag,
      cust_grp_hrchy_cd_dscr,
      gam_name,
      syear,
      cva_name,
      latest_start_month,
      latest_end_month,
      sc_rfa_no,
      ctrt_period_tp_cd,
      service_scope_group,
      service_scope,
      service_lane,
      direction,
      origin,
      origin_country,
      destination,
      cva_target,
      customer_target
    ]
  }

  set: cust_detail_w {
    fields: [
      group_code,
      group_name,
      cust_cd,
      customer_name,
      nvo_bco_flag,
      cust_grp_hrchy_cd_dscr,
      gam_name
    ]
  }

  set: cust_detail_wo {
    fields: [
      group_code,
      group_name,
      cust_cd,
      customer_name,
      nvo_bco_flag,
      cust_grp_hrchy_cd_dscr,
      gam_name,
      latest_start_month,
      latest_end_month,
      sc_rfa_no,
      ctrt_period_tp_cd
    ]
  }
}

view: global_cva_completion_2_1 {
  derived_table: {
    sql:
        SELECT
         mth_master.calendar_year
        ,mth_master.fiscal_year_new_fmt
        ,inview.month
        ,inview.cust_grp_typ
        ,inview.cust_grp_key_acct_tp_cd
        ,inview.cust_grp_id
        ,inview.cust_cd
        ,inview.cust_grp_id_n_nm
        ,inview.cust_cd_n_nm
        ,inview.sc_rfa_no
        -- Service scoupe group info
        ,inview.trade_grp
        ,inview.service_scope_group_code
        ,inview.gka_nvo_svc_scp_cd
        ,inview.dominant_flag
        -- contract info
        ,inview.ctrt_rhq_code
        ,inview.ctrt_country_cgm_logic
        ,inview.ctrt_ofc_code
        ,inview.scp_ofc_cd
        ,inview.ckam_sales_person
        ,inview. ctrt_eff_dt_dtl
        ,inview. ctrt_exp_dt_dtl
        ,inview.ctrt_period_typ
        -- sc fra status
        {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
          ,inview.scrfa_done_vs_missing
        {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
          ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
           THEN
              inview.scrfa_done_vs_missing_4_gkanvo
           ELSE
              inview.scrfa_done_vs_missing
           END as scrfa_done_vs_missing
        {% endif %}
        -- target
        ,inview.target_for_mth
        -- groupped status : overall (ok)
        {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
          ,inview.cust_grp_grp_sts
          ,inview.cust_cd_grp_sts
        {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
          ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
           THEN
              inview.cust_grp_grp_sts_4_gkanvo
           ELSE
              inview.cust_grp_grp_sts
           END as cust_grp_grp_sts

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_cd_grp_sts_4_gkanvo
      ELSE
      inview.cust_cd_grp_sts
      END as cust_cd_grp_sts
      {% endif %}
      ------------- groupped status : key account (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,inview.cust_grp_n_trd_grp_sts
      ,inview.cust_cd_n_trd_grp_sts
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_grp_n_trd_grp_sts_4_gkanvo
      ELSE
      inview.cust_grp_n_trd_grp_sts
      END as cust_grp_n_trd_grp_sts

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_cd_n_trd_grp_sts_4_gkanvo
      ELSE
      inview.cust_cd_n_trd_grp_sts
      END as cust_cd_n_trd_grp_sts
      {% endif %}
      ------------- groupped status : Service Scope Grp (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,inview.cust_grp_n_ssg_grp_sts
      ,inview.cust_cd_n_ssg_grp_sts
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_grp_n_ssg_grp_sts_4_gkanvo
      ELSE
      inview.cust_grp_n_ssg_grp_sts
      END as cust_grp_n_ssg_grp_sts

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_cd_n_ssg_grp_sts_4_gkanvo
      ELSE
      inview.cust_cd_n_ssg_grp_sts
      END as cust_cd_n_ssg_grp_sts
      {% endif %}
      ------------- groupped status : Dom Flag (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,inview.cust_grp_n_dom_grp_sts
      ,inview.cust_cd_n_dom_grp_sts
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_grp_n_dom_grp_sts_4_gkanvo
      ELSE
      inview.cust_grp_n_dom_grp_sts
      END as cust_grp_n_dom_grp_sts

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_cd_n_dom_grp_sts_4_gkanvo
      ELSE
      inview.cust_cd_n_dom_grp_sts
      END as cust_cd_n_dom_grp_sts
      {% endif %}
      ------------- groupped status : Contract RHQ (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,inview.cust_grp_n_ctrtrhq_grp_sts
      ,inview.cust_cd_n_ctrtrhq_grp_sts
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_grp_n_ctrtrhq_grp_sts_4_gkanvo
      ELSE
      inview.cust_grp_n_ctrtrhq_grp_sts
      END as cust_grp_n_ctrtrhq_grp_sts

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_cd_n_ctrtrhq_grp_sts_4_gkanvo
      ELSE
      inview.cust_cd_n_ctrtrhq_grp_sts
      END as cust_cd_n_ctrtrhq_grp_sts
      {% endif %}
      ------------- groupped status : Contract Country (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,inview.cust_grp_n_ctrtctry_grp_sts
      ,inview.cust_cd_n_ctrtctry_grp_sts
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_grp_n_ctrtctry_grp_sts_4_gkanvo
      ELSE
      inview.cust_grp_n_ctrtctry_grp_sts
      END as cust_grp_n_ctrtctry_grp_sts

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_cd_n_ctrtctry_grp_sts_4_gkanvo
      ELSE
      inview.cust_cd_n_ctrtctry_grp_sts
      END as cust_cd_n_ctrtctry_grp_sts
      {% endif %}
      ------------- groupped status : Contract Office (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,inview.cust_grp_n_ctrtofc_grp_sts
      ,inview.cust_cd_n_ctrtofc_grp_sts
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_grp_n_ctrtofc_grp_sts_4_gkanvo
      ELSE
      inview.cust_grp_n_ctrtofc_grp_sts
      END as cust_grp_n_ctrtofc_grp_sts

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_cd_n_ctrtofc_grp_sts_4_gkanvo
      ELSE
      inview.cust_cd_n_ctrtofc_grp_sts
      END as cust_cd_n_ctrtofc_grp_sts
      {% endif %}
      ------------- groupped status : CKAM (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,inview.cust_grp_n_ckam_grp_sts
      ,inview.cust_cd_n_ckam_grp_sts
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_grp_n_ckam_grp_sts_4_gkanvo
      ELSE
      inview.cust_grp_n_ckam_grp_sts
      END as cust_grp_n_ckam_grp_sts

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_cd_n_ckam_grp_sts_4_gkanvo
      ELSE
      inview.cust_cd_n_ckam_grp_sts
      END as cust_cd_n_ckam_grp_sts
      {% endif %}
      ------------- groupped status : Contract Period (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,inview.cust_grp_n_period_grp_sts
      ,inview.cust_cd_n_period_grp_sts
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_grp_n_period_grp_sts_4_gkanvo
      ELSE
      inview.cust_grp_n_period_grp_sts
      END as cust_grp_n_period_grp_sts

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_cd_n_period_grp_sts_4_gkanvo
      ELSE
      inview.cust_cd_n_period_grp_sts
      END as cust_cd_n_period_grp_sts
      {% endif %}
      ------------- groupped status : Service Scope Code (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,CAST(NULL as string) as cust_grp_n_sscp_grp_sts
      ,CAST(NULL as string) as cust_cd_n_sscp_grp_sts
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_grp_n_sscp_grp_sts_4_gkanvo
      ELSE
      CAST(NULL as string)
      END as cust_grp_n_sscp_grp_sts

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      inview.cust_cd_n_sscp_grp_sts_4_gkanvo
      ELSE
      CAST(NULL as string)
      END as cust_cd_n_sscp_grp_sts
      {% endif %}
      -------------------------------------------------
      -- Cross Month Status -------------------------
      -------------------------------------------------
      ------- Cross Month Status: Overall (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,CASE MAX(inview.cust_grp_grp_sts ) OVER(partition by cust_grp_id)||'-'||
      MIN(inview.cust_grp_grp_sts ) OVER(partition by cust_grp_id)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_grp_sts_multimth

      ,CASE MAX(inview.cust_cd_grp_sts ) OVER(partition by cust_cd)||'-'||
      MIN(inview.cust_cd_grp_sts ) OVER(partition by cust_cd)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_cd_sts_multimth
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      CASE MAX(inview.cust_grp_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id)||'-'||
      MIN(inview.cust_grp_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      CASE MAX(inview.cust_grp_grp_sts ) OVER(partition by cust_grp_id)||'-'||
      MIN(inview.cust_grp_grp_sts ) OVER(partition by cust_grp_id)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_grp_sts_multimth

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      CASE MAX(inview.cust_cd_grp_sts_4_gkanvo ) OVER(partition by cust_cd)||'-'||
      MIN(inview.cust_cd_grp_sts_4_gkanvo ) OVER(partition by cust_cd)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      CASE MAX(inview.cust_cd_grp_sts ) OVER(partition by cust_cd)||'-'||
      MIN(inview.cust_cd_grp_sts ) OVER(partition by cust_cd)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_cd_sts_multimth
      {% endif %}
      ------------- Cross Month Status: Trade Grp (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,CASE MAX(inview.cust_grp_n_trd_grp_sts ) OVER(partition by cust_grp_id, trade_grp)||'-'||
      MIN(inview.cust_grp_n_trd_grp_sts ) OVER(partition by cust_grp_id, trade_grp)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_grp_n_trd_grp_sts_multimth

      ,CASE MAX(inview.cust_cd_n_trd_grp_sts ) OVER(partition by cust_cd, trade_grp)||'-'||
      MIN(inview.cust_cd_n_trd_grp_sts ) OVER(partition by cust_cd, trade_grp)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_cd_n_trd_grp_sts_multimth
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      CASE MAX(inview.cust_grp_n_trd_grp_sts_4_gkanvo  ) OVER(partition by cust_grp_id, trade_grp)||'-'||
      MIN(inview.cust_grp_n_trd_grp_sts_4_gkanvo  ) OVER(partition by cust_grp_id, trade_grp)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      CASE MAX(inview.cust_grp_n_trd_grp_sts ) OVER(partition by cust_grp_id, trade_grp)||'-'||
      MIN(inview.cust_grp_n_trd_grp_sts ) OVER(partition by cust_grp_id, trade_grp)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END

      END as cust_grp_n_trd_grp_sts_multimth

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      CASE MAX(inview.cust_cd_n_trd_grp_sts_4_gkanvo ) OVER(partition by cust_cd, trade_grp)||'-'||
      MIN(inview.cust_cd_n_trd_grp_sts_4_gkanvo ) OVER(partition by cust_cd, trade_grp)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      CASE MAX(inview.cust_cd_n_trd_grp_sts ) OVER(partition by cust_cd, trade_grp)||'-'||
      MIN(inview.cust_cd_n_trd_grp_sts ) OVER(partition by cust_cd, trade_grp)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_cd_n_trd_grp_sts_multimth
      {% endif %}
      ------------- Cross Month Status: Service Scp Grp (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,CASE MAX(inview.cust_grp_n_ssg_grp_sts ) OVER(partition by cust_grp_id, service_scope_group_code)||'-'||
      MIN(inview.cust_grp_n_ssg_grp_sts ) OVER(partition by cust_grp_id, service_scope_group_code)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_grp_n_ssg_grp_sts_multimth

      ,CASE MAX(inview.cust_cd_n_ssg_grp_sts ) OVER(partition by cust_cd, service_scope_group_code)||'-'||
      MIN(inview.cust_cd_n_ssg_grp_sts ) OVER(partition by cust_cd, service_scope_group_code)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_cd_n_ssg_grp_sts_multimth
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      ,CASE MAX(inview.cust_grp_n_ssg_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, service_scope_group_code)||'-'||
      MIN(inview.cust_grp_n_ssg_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, service_scope_group_code)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      ,CASE MAX(inview.cust_grp_n_ssg_grp_sts ) OVER(partition by cust_grp_id, service_scope_group_code)||'-'||
      MIN(inview.cust_grp_n_ssg_grp_sts ) OVER(partition by cust_grp_id, service_scope_group_code)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_grp_n_ssg_grp_sts_multimth

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      ,CASE MAX(inview.cust_cd_n_ssg_grp_sts_4_gkanvo ) OVER(partition by cust_cd, service_scope_group_code)||'-'||
      MIN(inview.cust_cd_n_ssg_grp_sts_4_gkanvo ) OVER(partition by cust_cd, service_scope_group_code)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      ,CASE MAX(inview.cust_cd_n_ssg_grp_sts ) OVER(partition by cust_cd, service_scope_group_code)||'-'||
      MIN(inview.cust_cd_n_ssg_grp_sts ) OVER(partition by cust_cd, service_scope_group_code)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_cd_n_ssg_grp_sts_multimth
      {% endif %}
      ------------- Cross Month Status: Dom Flag (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,CASE MAX(inview.cust_grp_n_dom_grp_sts ) OVER(partition by cust_grp_id, dominant_flag)||'-'||
      MIN(inview.cust_grp_n_dom_grp_sts ) OVER(partition by cust_grp_id, dominant_flag)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_grp_n_dom_grp_sts_multimth
      ,CASE MAX(inview.cust_cd_n_dom_grp_sts ) OVER(partition by cust_cd, dominant_flag)||'-'||
      MIN(inview.cust_cd_n_dom_grp_sts ) OVER(partition by cust_cd, dominant_flag)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_cd_n_dom_grp_sts_multimth
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      ,CASE MAX(inview.cust_grp_n_dom_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, dominant_flag)||'-'||
      MIN(inview.cust_grp_n_dom_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, dominant_flag)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      ,CASE MAX(inview.cust_grp_n_dom_grp_sts ) OVER(partition by cust_grp_id, dominant_flag)||'-'||
      MIN(inview.cust_grp_n_dom_grp_sts ) OVER(partition by cust_grp_id, dominant_flag)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_grp_n_dom_grp_sts_multimth

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      ,CASE MAX(inview.cust_cd_n_dom_grp_sts_4_gkanvo ) OVER(partition by cust_cd, dominant_flag)||'-'||
      MIN(inview.cust_cd_n_dom_grp_sts_4_gkanvo ) OVER(partition by cust_cd, dominant_flag)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      ,CASE MAX(inview.cust_cd_n_dom_grp_sts ) OVER(partition by cust_cd, dominant_flag)||'-'||
      MIN(inview.cust_cd_n_dom_grp_sts ) OVER(partition by cust_cd, dominant_flag)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_cd_n_dom_grp_sts_multimth
      {% endif %}
      ------------- Cross Month Status: Contract RHQ (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,CASE MAX(inview.cust_grp_n_ctrtrhq_grp_sts ) OVER(partition by cust_grp_id, ctrt_rhq_code)||'-'||
      MIN(inview.cust_grp_n_ctrtrhq_grp_sts ) OVER(partition by cust_grp_id, ctrt_rhq_code)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_grp_n_ctrtrhq_grp_sts_multimth
      ,CASE MAX(inview.cust_cd_n_ctrtrhq_grp_sts ) OVER(partition by cust_cd, ctrt_rhq_code)||'-'||
      MIN(inview.cust_cd_n_ctrtrhq_grp_sts ) OVER(partition by cust_cd, ctrt_rhq_code)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_cd_n_ctrtrhq_grp_sts_multimth
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      ,CASE MAX(inview.cust_grp_n_ctrtrhq_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, ctrt_rhq_code)||'-'||
      MIN(inview.cust_grp_n_ctrtrhq_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, ctrt_rhq_code)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      ,CASE MAX(inview.cust_grp_n_ctrtrhq_grp_sts ) OVER(partition by cust_grp_id, ctrt_rhq_code)||'-'||
      MIN(inview.cust_grp_n_ctrtrhq_grp_sts ) OVER(partition by cust_grp_id, ctrt_rhq_code)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_grp_n_ctrtrhq_grp_sts_multimth

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      ,CASE MAX(inview.cust_cd_n_ctrtrhq_grp_sts_4_gkanvo ) OVER(partition by cust_cd, ctrt_rhq_code)||'-'||
      MIN(inview.cust_cd_n_ctrtrhq_grp_sts_4_gkanvo ) OVER(partition by cust_cd, ctrt_rhq_code)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      ,CASE MAX(inview.cust_cd_n_ctrtrhq_grp_sts ) OVER(partition by cust_cd, ctrt_rhq_code)||'-'||
      MIN(inview.cust_cd_n_ctrtrhq_grp_sts ) OVER(partition by cust_cd, ctrt_rhq_code)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_cd_n_ctrtrhq_grp_sts_multimth
      {% endif %}
      ------------- Cross Month Status: Contract Country (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,CASE MAX(inview.cust_grp_n_ctrtctry_grp_sts ) OVER(partition by cust_grp_id, ctrt_country_cgm_logic)||'-'||
      MIN(inview.cust_grp_n_ctrtctry_grp_sts ) OVER(partition by cust_grp_id, ctrt_country_cgm_logic)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_grp_n_ctrtctry_grp_sts_multimth
      ,CASE MAX(inview.cust_cd_n_ctrtctry_grp_sts ) OVER(partition by cust_cd, ctrt_country_cgm_logic)||'-'||
      MIN(inview.cust_cd_n_ctrtctry_grp_sts ) OVER(partition by cust_cd, ctrt_country_cgm_logic)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_cd_n_ctrtctry_grp_sts_multimth
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      ,CASE MAX(inview.cust_grp_n_ctrtctry_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, ctrt_country_cgm_logic)||'-'||
      MIN(inview.cust_grp_n_ctrtctry_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, ctrt_country_cgm_logic)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      ,CASE MAX(inview.cust_grp_n_ctrtctry_grp_sts ) OVER(partition by cust_grp_id, ctrt_country_cgm_logic)||'-'||
      MIN(inview.cust_grp_n_ctrtctry_grp_sts ) OVER(partition by cust_grp_id, ctrt_country_cgm_logic)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_grp_n_ctrtctry_grp_sts_multimth

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      ,CASE MAX(inview.cust_cd_n_ctrtctry_grp_sts_4_gkanvo ) OVER(partition by cust_cd, ctrt_country_cgm_logic)||'-'||
      MIN(inview.cust_cd_n_ctrtctry_grp_sts_4_gkanvo ) OVER(partition by cust_cd, ctrt_country_cgm_logic)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      ,CASE MAX(inview.cust_cd_n_ctrtctry_grp_sts ) OVER(partition by cust_cd, ctrt_country_cgm_logic)||'-'||
      MIN(inview.cust_cd_n_ctrtctry_grp_sts ) OVER(partition by cust_cd, ctrt_country_cgm_logic)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_cd_n_ctrtctry_grp_sts_multimth
      {% endif %}
      ------------- Cross Month Status: Contract Office (Svc Scp Level) (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,CASE MAX(inview.cust_grp_n_ctrtofc_grp_sts ) OVER(partition by cust_grp_id, scp_ofc_cd)||'-'||
      MIN(inview.cust_grp_n_ctrtofc_grp_sts ) OVER(partition by cust_grp_id, scp_ofc_cd)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_grp_n_ctrtofc_grp_sts_multimth
      ,CASE MAX(inview.cust_cd_n_ctrtofc_grp_sts ) OVER(partition by cust_cd, scp_ofc_cd)||'-'||
      MIN(inview.cust_cd_n_ctrtofc_grp_sts ) OVER(partition by cust_cd, scp_ofc_cd)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_cd_n_ctrtofc_grp_sts_multimth
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      ,CASE MAX(inview.cust_grp_n_ctrtofc_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, scp_ofc_cd)||'-'||
      MIN(inview.cust_grp_n_ctrtofc_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, scp_ofc_cd)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      ,CASE MAX(inview.cust_grp_n_ctrtofc_grp_sts ) OVER(partition by cust_grp_id, scp_ofc_cd)||'-'||
      MIN(inview.cust_grp_n_ctrtofc_grp_sts ) OVER(partition by cust_grp_id, scp_ofc_cd)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END

      END as cust_grp_n_ctrtofc_grp_sts_multimth

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      ,CASE MAX(inview.cust_cd_n_ctrtofc_grp_sts_4_gkanvo ) OVER(partition by cust_cd, scp_ofc_cd)||'-'||
      MIN(inview.cust_cd_n_ctrtofc_grp_sts_4_gkanvo ) OVER(partition by cust_cd, scp_ofc_cd)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      ,CASE MAX(inview.cust_cd_n_ctrtofc_grp_sts ) OVER(partition by cust_cd, scp_ofc_cd)||'-'||
      MIN(inview.cust_cd_n_ctrtofc_grp_sts ) OVER(partition by cust_cd, scp_ofc_cd)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_cd_n_ctrtofc_grp_sts_multimth
      {% endif %}
      ------------- Cross Month Status: CKAM (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,CASE MAX(inview.cust_grp_n_ckam_grp_sts ) OVER(partition by cust_grp_id, ckam_sales_person)||'-'||
      MIN(inview.cust_grp_n_ckam_grp_sts ) OVER(partition by cust_grp_id, ckam_sales_person)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_grp_n_ckam_grp_sts_multimth
      ,CASE MAX(inview.cust_cd_n_ckam_grp_sts ) OVER(partition by cust_cd, ckam_sales_person)||'-'||
      MIN(inview.cust_cd_n_ckam_grp_sts ) OVER(partition by cust_cd, ckam_sales_person)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_cd_n_ckam_grp_sts_multimth
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      ,CASE MAX(inview.cust_grp_n_ckam_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, ckam_sales_person)||'-'||
      MIN(inview.cust_grp_n_ckam_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, ckam_sales_person)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      ,CASE MAX(inview.cust_grp_n_ckam_grp_sts ) OVER(partition by cust_grp_id, ckam_sales_person)||'-'||
      MIN(inview.cust_grp_n_ckam_grp_sts ) OVER(partition by cust_grp_id, ckam_sales_person)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_grp_n_ckam_grp_sts_multimth

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      ,CASE MAX(inview.cust_cd_n_ckam_grp_sts_4_gkanvo ) OVER(partition by cust_cd, ckam_sales_person)||'-'||
      MIN(inview.cust_cd_n_ckam_grp_sts_4_gkanvo ) OVER(partition by cust_cd, ckam_sales_person)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      ,CASE MAX(inview.cust_cd_n_ckam_grp_sts ) OVER(partition by cust_cd, ckam_sales_person)||'-'||
      MIN(inview.cust_cd_n_ckam_grp_sts ) OVER(partition by cust_cd, ckam_sales_person)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_cd_n_ckam_grp_sts_multimth
      {% endif %}
      ------------- Cross Month Status: Contract Period (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,CASE MAX(inview.cust_grp_n_period_grp_sts ) OVER(partition by cust_grp_id, ctrt_period_typ)||'-'||
      MIN(inview.cust_grp_n_period_grp_sts ) OVER(partition by cust_grp_id, ctrt_period_typ)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_grp_n_period_grp_sts_multimth
      ,CASE MAX(inview.cust_cd_n_period_grp_sts ) OVER(partition by cust_cd, ctrt_period_typ)||'-'||
      MIN(inview.cust_cd_n_period_grp_sts ) OVER(partition by cust_cd, ctrt_period_typ)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END as cust_cd_n_period_grp_sts_multimth
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      ,CASE MAX(inview.cust_grp_n_period_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, ctrt_period_typ)||'-'||
      MIN(inview.cust_grp_n_period_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, ctrt_period_typ)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      ,CASE MAX(inview.cust_grp_n_period_grp_sts ) OVER(partition by cust_grp_id, ctrt_period_typ)||'-'||
      MIN(inview.cust_grp_n_period_grp_sts ) OVER(partition by cust_grp_id, ctrt_period_typ)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_grp_n_period_grp_sts_multimth

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      ,CASE MAX(inview.cust_cd_n_period_grp_sts_4_gkanvo ) OVER(partition by cust_cd, ctrt_period_typ)||'-'||
      MIN(inview.cust_cd_n_period_grp_sts_4_gkanvo ) OVER(partition by cust_cd, ctrt_period_typ)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      ,CASE MAX(inview.cust_cd_n_period_grp_sts ) OVER(partition by cust_cd, ctrt_period_typ)||'-'||
      MIN(inview.cust_cd_n_period_grp_sts ) OVER(partition by cust_cd, ctrt_period_typ)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      END as cust_cd_n_period_grp_sts_multimth
      {% endif %}
      ------------- Cross Month Status: Service Scope Code (ok)
      {% if    param_gka_nvo_option._parameter_value == "'SSG_DOM'"  %}
      ,CAST(NULL as string) as cust_grp_n_sscp_grp_sts_multimth
      ,CAST(NULL as string) as cust_cd_n_sscp_grp_sts_multimth
      {% elsif param_gka_nvo_option._parameter_value == "'SVC_SCP'"  %}
      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      CASE MAX(inview.cust_grp_n_sscp_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, gka_nvo_svc_scp_cd)||'-'||
      MIN(inview.cust_grp_n_sscp_grp_sts_4_gkanvo ) OVER(partition by cust_grp_id, gka_nvo_svc_scp_cd)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      CAST(NULL as string)
      END as cust_grp_n_sscp_grp_sts_multimth

      ,CASE WHEN inview.cust_grp_typ ||'-'|| inview.cust_grp_key_acct_tp_cd  = 'NVO-GKA'
      THEN
      CASE MAX(inview.cust_cd_grp_sts_4_gkanvo ) OVER(partition by cust_cd, gka_nvo_svc_scp_cd)||'-'||
      MIN(inview.cust_cd_grp_sts_4_gkanvo ) OVER(partition by cust_cd, gka_nvo_svc_scp_cd)
      WHEN 'Pending-Pending'   THEN 'Pending'
      WHEN 'Complete-Complete' THEN 'Complete'
      ELSE 'Partial' END
      ELSE
      CAST(NULL as string)
      END as cust_cd_n_sscp_grp_sts_multimth

      {% endif %}
      -------------
      FROM ${global_cva_completion_2_1_inner.SQL_TABLE_NAME} inview
      LEFT JOIN ${global_cva_completion_2_mth_master.SQL_TABLE_NAME} mth_master ON ( inview.month = mth_master.month )
      WHERE {% condition filter_mths  %} inview.month {% endcondition %}
      {% if    calendar_selection._parameter_value == "'CALENDAR'"  %}
      AND   {% condition filter_years %} mth_master.calendar_year {% endcondition %}
      {% elsif calendar_selection._parameter_value == "'FISCAL'"  %}
      AND   {% condition filter_years %} mth_master.fiscal_year_new_fmt {% endcondition %}
      {% endif %}




      ;;
  }

  parameter: param_gka_nvo_option {
    type: string
    allowed_value: { value: "SSG_DOM"  label: "By SSG & DOM" }
    allowed_value: { value: "SVC_SCP"  label: "By Service Scope" }
    default_value: "SSG_DOM"
  }

  parameter: calendar_selection {
    label: "Calendar Selection"
    type: string
    allowed_value: { value: "CALENDAR" label: "Calendar" }
    allowed_value: { value: "FISCAL"   label: "Fiscal" }
    default_value: "FISCAL"
    suggest_persist_for: "24 hour"
  }

  filter: filter_years {
    type: string
    #suggestions: ["2022", "2023" ]
    #suggest_explore:
    suggest_dimension: fiscal_or_cal_yr
    suggest_persist_for: "24 hour"
  }

  filter: filter_mths {
    type: string
    #suggestions: ["202204", "202205", "202206", "202207", "202208", "202209", "202210", "202211", "202212", "202301", "202302", "202303", "202304", "202305", "202306", "202307", "202308", "202309", "202310", "202311", "202312" , "202401", "202402", "202403" ]
    #default_value: "202304"
    #suggest_explore: global_cva_completion_2_mth_master
    suggest_dimension: month
    suggest_persist_for: "24 hour"
  }


  parameter: param_dynamic_dim_1{
    type: string
    allowed_value: { label: "By Service Scope Code"   value: "SSCP_CODE"  }
    allowed_value: { label: "By Contract Office"      value: "CTRT_OFC"   }
    allowed_value: { label: "By Contract Country"     value: "CTRT_CTRY"  }
    allowed_value: { label: "By CKAM"                 value: "CKAM"       }
    default_value: "CTRT_OFC"
  }

  parameter: param_dynamic_dim_2{
    type: string
    allowed_value: { label: "By Service Scope Code"   value: "SSCP_CODE"       }
    allowed_value: { label: "By Contract Office"      value: "CTRT_OFC"       }
    allowed_value: { label: "By Contract Country"     value: "CTRT_CTRY"       }
    allowed_value: { label: "By CKAM"                 value: "CKAM"       }
    default_value: "CTRT_CTRY"
  }

  parameter: param_dynamic_dim_3{
    type: string
    allowed_value: { label: "By Service Scope Code"   value: "SSCP_CODE"       }
    allowed_value: { label: "By Contract Office"      value: "CTRT_OFC"       }
    allowed_value: { label: "By Contract Country"     value: "CTRT_CTRY"       }
    allowed_value: { label: "By CKAM"                 value: "CKAM"       }
    default_value: "CKAM"
  }

  parameter: param_drill_option{
    type: string
    allowed_value: { label: "Overall"             value: "OVERALL"   }
    allowed_value: { label: "By Dom Flag"         value: "DOM"       }
    allowed_value: { label: "By Trade Group"      value: "TRD_GRP"       }
    allowed_value: { label: "By Svc Scp Grp"      value: "SSG_GRP"       }
    allowed_value: { label: "By Contract RHQ"     value: "CTRT_RHQ"       }
    allowed_value: { label: "By Contract Country" value: "CTRT_CTRY"       }
    allowed_value: { label: "By Contract Office"  value: "CTRT_OFC"       }
    allowed_value: { label: "By CKAM"             value: "CKAM"       }
    allowed_value: { label: "By Contract Length"  value: "CTRT_LEN"       }
    allowed_value: { label: "By Month"            value: "MTH"       }
    default_value: "OVERALL"
  }

  parameter: param_cust_grping_option {
    label: "Customer Grouping Option"
    type: string
    allowed_value: { label: "By Customer Group"  value: "CUST_GRP"     }
    allowed_value: { label: "By Customer Code"   value: "CUST_CD"  }
    default_value: "CUST_CD"
  }

  parameter: param_cust_percent_partition {
    type: string
    allowed_value: { label: "By Dummy Val"     value: "DUMMY"     }
    allowed_value: { label: "By Key Account"   value: "KEY_ACC"     }
    allowed_value: { label: "By Dominant Flag" value: "DOM_FLG"  }
    default_value: "DUMMY"
  }

  dimension: fiscal_or_cal_yr {
    type: string
    sql:
        {% if    calendar_selection._parameter_value == "'CALENDAR'"  %}
            ${TABLE}.calendar_year
        {% elsif calendar_selection._parameter_value == "'FISCAL'"  %}
            ${TABLE}.fiscal_year_new_fmt
        {% endif %};;
  }

  dimension: dynamic_dim_1 {
    label: "{%  if    param_dynamic_dim_1._parameter_value ==  \"'SSCP_CODE'\"  %}Service Scope Code{%
    elsif param_dynamic_dim_1._parameter_value ==  \"'CTRT_OFC'\"   %}Contract Office{%
    elsif param_dynamic_dim_1._parameter_value ==  \"'CTRT_CTRY'\"  %}Contract Country{%
    elsif param_dynamic_dim_1._parameter_value ==  \"'CKAM'\"       %}CKAM{%
    endif %}"
    type: string
    sql:
        {% if     param_dynamic_dim_1._parameter_value == "'SSCP_CODE'"  %} ${gka_nvo_svc_scp_cd}
        {% elsif  param_dynamic_dim_1._parameter_value == "'CTRT_OFC'"   %} ${scp_ofc_cd}
        {% elsif  param_dynamic_dim_1._parameter_value == "'CTRT_CTRY'"  %} ${ctrt_country_cgm_logic}
        {% elsif  param_dynamic_dim_1._parameter_value == "'CKAM'"       %} ${ckam_usr.full_name}
        {% endif %} ;;
  }

  dimension: dynamic_dim_pivot_1 {
    type: string
    sql:
        {% if     param_dynamic_dim_1._parameter_value == "'SSCP_CODE'"  %} ${cust_n_ssg_grp_sts_multimth}
        {% elsif  param_dynamic_dim_1._parameter_value == "'CTRT_OFC'"   %} ${cust_n_ctrtofc_grp_sts_multimth}
        {% elsif  param_dynamic_dim_1._parameter_value == "'CTRT_CTRY'"  %} ${cust_n_ctrtctry_grp_sts_multimth}
        {% elsif  param_dynamic_dim_1._parameter_value == "'CKAM'"       %} ${cust_n_ckam_grp_sts_multimth}
        {% endif %} ;;
  }

  measure: cust_cnt_dynamic_1 {
    type: number
    label: "{%  if    param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\"  %}By Customer Group{%
    elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"   %}By Customer Code{%
    endif %}"
    sql:  {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_cnt}
          {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd_cnt}
          {% endif %} ;;

    link: {
      label: "Drill to Details"
      url:  "{% if    param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_dynamic_dim_1._parameter_value ==  \"'SSCP_CODE'\" %}{{ drill_4_sscp_cust_grp._link     }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_dynamic_dim_1._parameter_value ==  \"'CTRT_CTRY'\" %}{{ drill_4_ctrtctry_cust_grp._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_dynamic_dim_1._parameter_value ==  \"'CTRT_OFC'\"  %}{{ drill_4_ctrtofc_cust_grp._link  }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_dynamic_dim_1._parameter_value ==  \"'CKAM'\"      %}{{ drill_4_ckam_cust_grp._link     }}{%

      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_dynamic_dim_1._parameter_value ==  \"'SSCP_CODE'\" %}{{ drill_4_sscp_cust_cd._link     }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_dynamic_dim_1._parameter_value ==  \"'CTRT_CTRY'\" %}{{ drill_4_ctrtctry_cust_cd._link  }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_dynamic_dim_1._parameter_value ==  \"'CTRT_OFC'\"  %}{{ drill_4_ctrtofc_cust_cd._link   }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_dynamic_dim_1._parameter_value ==  \"'CKAM'\"      %}{{ drill_4_ckam_cust_cd._link      }}{%

      endif %}"
    }
  }

  dimension: dynamic_dim_2 {
    label: "{%  if    param_dynamic_dim_2._parameter_value ==  \"'SSCP_CODE'\"  %}Service Scope Code{%
    elsif param_dynamic_dim_2._parameter_value ==  \"'CTRT_OFC'\"   %}Contract Office{%
    elsif param_dynamic_dim_2._parameter_value ==  \"'CTRT_CTRY'\"  %}Contract Country{%
    elsif param_dynamic_dim_2._parameter_value ==  \"'CKAM'\"       %}CKAM{%
    endif %}"
    type: string
    sql:
        {% if     param_dynamic_dim_2._parameter_value == "'SSCP_CODE'"  %} ${gka_nvo_svc_scp_cd}
        {% elsif  param_dynamic_dim_2._parameter_value == "'CTRT_OFC'"   %} ${scp_ofc_cd}
        {% elsif  param_dynamic_dim_2._parameter_value == "'CTRT_CTRY'"  %} ${ctrt_country_cgm_logic}
        {% elsif  param_dynamic_dim_2._parameter_value == "'CKAM'"       %} ${ckam_usr.full_name}
        {% endif %} ;;
  }

  dimension: dynamic_dim_pivot_2 {
    type: string
    sql:
        {% if     param_dynamic_dim_2._parameter_value == "'SSCP_CODE'"  %} ${cust_n_ssg_grp_sts_multimth}
        {% elsif  param_dynamic_dim_2._parameter_value == "'CTRT_OFC'"   %} ${cust_n_ctrtofc_grp_sts_multimth}
        {% elsif  param_dynamic_dim_2._parameter_value == "'CTRT_CTRY'"  %} ${cust_n_ctrtctry_grp_sts_multimth}
        {% elsif  param_dynamic_dim_2._parameter_value == "'CKAM'"       %} ${cust_n_ckam_grp_sts_multimth}
        {% endif %} ;;
  }

  measure: cust_cnt_dynamic_2 {
    type: number
    label: "{%  if    param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\"  %}By Customer Group{%
    elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"   %}By Customer Code{%
    endif %}"
    sql:  {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_cnt}
          {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd_cnt}
          {% endif %} ;;

    link: {
      label: "Drill to Details"
      url:  "{% if    param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_dynamic_dim_2._parameter_value ==  \"'SSCP_CODE'\" %}{{ drill_4_sscp_cust_grp._link     }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_dynamic_dim_2._parameter_value ==  \"'CTRT_CTRY'\" %}{{ drill_4_ctrtctry_cust_grp._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_dynamic_dim_2._parameter_value ==  \"'CTRT_OFC'\"  %}{{ drill_4_ctrtofc_cust_grp._link  }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_dynamic_dim_2._parameter_value ==  \"'CKAM'\"      %}{{ drill_4_ckam_cust_grp._link     }}{%

      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_dynamic_dim_2._parameter_value ==  \"'SSCP_CODE'\" %}{{ drill_4_sscp_cust_cd._link     }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_dynamic_dim_2._parameter_value ==  \"'CTRT_CTRY'\" %}{{ drill_4_ctrtctry_cust_cd._link  }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_dynamic_dim_2._parameter_value ==  \"'CTRT_OFC'\"  %}{{ drill_4_ctrtofc_cust_cd._link   }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_dynamic_dim_2._parameter_value ==  \"'CKAM'\"      %}{{ drill_4_ckam_cust_cd._link      }}{%

      endif %}"
    }
  }

  dimension: dynamic_dim_3 {
    label: "{%  if    param_dynamic_dim_3._parameter_value ==  \"'SSCP_CODE'\"  %}Service Scope Code{%
    elsif param_dynamic_dim_3._parameter_value ==  \"'CTRT_OFC'\"   %}Contract Office{%
    elsif param_dynamic_dim_3._parameter_value ==  \"'CTRT_CTRY'\"  %}Contract Country{%
    elsif param_dynamic_dim_3._parameter_value ==  \"'CKAM'\"       %}CKAM{%
    endif %}"
    type: string
    sql:
        {% if     param_dynamic_dim_3._parameter_value == "'SSCP_CODE'"  %} ${gka_nvo_svc_scp_cd}
        {% elsif  param_dynamic_dim_3._parameter_value == "'CTRT_OFC'"   %} ${scp_ofc_cd}
        {% elsif  param_dynamic_dim_3._parameter_value == "'CTRT_CTRY'"  %} ${ctrt_country_cgm_logic}
        {% elsif  param_dynamic_dim_3._parameter_value == "'CKAM'"       %} ${ckam_usr.full_name}
        {% endif %} ;;
  }

  dimension: dynamic_dim_pivot_3 {
    type: string
    sql:
        {% if     param_dynamic_dim_3._parameter_value == "'SSCP_CODE'"  %} ${cust_n_ssg_grp_sts_multimth}
        {% elsif  param_dynamic_dim_3._parameter_value == "'CTRT_OFC'"   %} ${cust_n_ctrtofc_grp_sts_multimth}
        {% elsif  param_dynamic_dim_3._parameter_value == "'CTRT_CTRY'"  %} ${cust_n_ctrtctry_grp_sts_multimth}
        {% elsif  param_dynamic_dim_3._parameter_value == "'CKAM'"       %} ${cust_n_ckam_grp_sts_multimth}
        {% endif %} ;;
  }

  measure: cust_cnt_dynamic_3 {
    type: number
    label: "{%  if    param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\"  %}By Customer Group{%
    elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"   %}By Customer Code{%
    endif %}"
    sql:  {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_cnt}
          {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd_cnt}
          {% endif %} ;;

    link: {
      label: "Drill to Details"
      url:  "{% if    param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_dynamic_dim_3._parameter_value ==  \"'SSCP_CODE'\" %}{{ drill_4_sscp_cust_grp._link     }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_dynamic_dim_3._parameter_value ==  \"'CTRT_CTRY'\" %}{{ drill_4_ctrtctry_cust_grp._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_dynamic_dim_3._parameter_value ==  \"'CTRT_OFC'\"  %}{{ drill_4_ctrtofc_cust_grp._link  }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_dynamic_dim_3._parameter_value ==  \"'CKAM'\"      %}{{ drill_4_ckam_cust_grp._link     }}{%

      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_dynamic_dim_3._parameter_value ==  \"'SSCP_CODE'\" %}{{ drill_4_sscp_cust_cd._link     }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_dynamic_dim_3._parameter_value ==  \"'CTRT_CTRY'\" %}{{ drill_4_ctrtctry_cust_cd._link  }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_dynamic_dim_3._parameter_value ==  \"'CTRT_OFC'\"  %}{{ drill_4_ctrtofc_cust_cd._link   }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_dynamic_dim_3._parameter_value ==  \"'CKAM'\"      %}{{ drill_4_ckam_cust_cd._link      }}{%

      endif %}"
    }
  }



  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: cust_grp_typ {
    type: string
    sql: ${TABLE}.cust_grp_typ ;;
  }

  dimension: cust_grp_id {
    label: "Customer Group Code"
    type: string
    sql: ${TABLE}.cust_grp_id ;;
  }

  dimension: cust_cd {
    label: "Customer Code"
    type: string
    sql: ${TABLE}.cust_cd ;;
  }

  dimension: cust_grp_id_n_nm {
    type: string
    sql: ${TABLE}.cust_grp_id_n_nm ;;
    suggest_persist_for: "4 hours"
  }

  dimension: cust_cd_n_nm {
    type: string
    sql: ${TABLE}.cust_cd_n_nm ;;
    suggest_persist_for: "4 hours"
  }

  dimension: sc_rfa_no {
    label: "Svc / RFA Number"
    type: string
    sql: ${TABLE}.sc_rfa_no ;;
  }

  # Contract info

  dimension: ctrt_rhq_code {
    label: "Contract RHQ"
    type: string
    sql: ${TABLE}.ctrt_rhq_code ;;
  }

  dimension: ctrt_country_cgm_logic {
    label: "Contract Country"
    type: string
    sql: ${TABLE}.ctrt_country_cgm_logic ;;
  }

  dimension: ctrt_ofc_code {
    label: "Contract Office (Header)"
    type: string
    sql: ${TABLE}.ctrt_ofc_code ;;
  }

  dimension: scp_ofc_cd {
    label: "Contract Office (Per Service Scope)"
    type: string
    sql: ${TABLE}.scp_ofc_cd ;;
  }

  dimension: ckam_sales_person {
    type: string
    sql: ${TABLE}.ckam_sales_person ;;
  }

  dimension: ctrt_period_typ {
    label: "Contract Length"
    type: string
    sql: ${TABLE}.ctrt_period_typ ;;
  }

  # SC/RFA status and total Target TEU
  dimension: scrfa_done_vs_missing {
    type: string
    sql: ${TABLE}.scrfa_done_vs_missing ;;
  }

  dimension: scrfa_is_cva_complete {
    type: string
    sql: CASE ${TABLE}.scrfa_done_vs_missing
      WHEN 'CVA Missing' THEN 'No' WHEN 'CVA Done' THEN 'Yes' END;;
  }

  measure: total_target_for_mth {
    type: sum
    sql: ${TABLE}.target_for_mth ;;
    value_format_name: usd_0
  }

  measure: drill_4_overall_cust_grp {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, cust_sts_multimth]
  }

  measure: drill_4_overall_cust_cd {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_cd, v_customer_opus_n_prospect.name, cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, cust_sts_multimth]
  }


  measure: drill_4_dom_cust_grp {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, dominant_flag,cust_n_dom_grp_sts_multimth]
  }

  measure: drill_4_dom_cust_cd {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_cd, v_customer_opus_n_prospect.name, cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, dominant_flag,cust_n_dom_grp_sts_multimth]
  }

  measure: drill_4_trd_grp_cust_grp {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, trade_grp, cust_n_trd_grp_sts_multimth]
  }

  measure: drill_4_trd_grp_cust_cd {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_cd, v_customer_opus_n_prospect.name, cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, trade_grp, cust_n_trd_grp_sts_multimth]
  }

  measure: drill_4_ssg_grp_cust_grp {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, service_scope_group_code, cust_n_ssg_grp_sts_multimth]
  }

  measure: drill_4_ssg_grp_cust_cd {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_cd, v_customer_opus_n_prospect.name, cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, service_scope_group_code, cust_n_ssg_grp_sts_multimth]
  }

  measure: drill_4_sscp_cust_grp {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, gka_nvo_svc_scp_cd, cust_n_ssg_grp_sts_multimth]
  }

  measure: drill_4_sscp_cust_cd {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_cd, v_customer_opus_n_prospect.name, cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, gka_nvo_svc_scp_cd, cust_n_ssg_grp_sts_multimth]
  }

  measure: drill_4_ctrtrhq_cust_grp {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, ctrt_rhq_code, cust_n_ctrtrhq_grp_sts_multimth]
  }

  measure: drill_4_ctrtrhq_cust_cd {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_cd, v_customer_opus_n_prospect.name, cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, ctrt_rhq_code, cust_n_ctrtrhq_grp_sts_multimth]
  }

  measure: drill_4_ctrtctry_cust_grp {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, ctrt_country_cgm_logic, cust_n_ctrtctry_grp_sts_multimth]
  }

  measure: drill_4_ctrtctry_cust_cd {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_cd, v_customer_opus_n_prospect.name, cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, ctrt_country_cgm_logic, cust_n_ctrtctry_grp_sts_multimth]
  }

  measure: drill_4_ctrtofc_cust_grp {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, scp_ofc_cd, cust_n_ctrtofc_grp_sts_multimth]
  }

  measure: drill_4_ctrtofc_cust_cd {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_cd, v_customer_opus_n_prospect.name, cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, scp_ofc_cd, cust_n_ctrtofc_grp_sts_multimth]
  }

  measure: drill_4_ckam_cust_grp {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, ckam_usr.full_name, cust_n_ckam_grp_sts_multimth]
  }

  measure: drill_4_ckam_cust_cd {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_cd, v_customer_opus_n_prospect.name, cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, ckam_usr.full_name, cust_n_ckam_grp_sts_multimth]
  }

  measure: drill_4_period_cust_grp {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, ctrt_period_typ, cust_n_period_grp_sts_multimth]
  }

  measure: drill_4_period_cust_cd {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_cd, v_customer_opus_n_prospect.name, cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, ctrt_period_typ, cust_n_period_grp_sts_multimth]
  }

  measure: drill_4_mth_cust_grp {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, month, cust_sts]
  }

  measure: drill_4_mth_cust_cd {
    type:  number
    sql: 1 ;;
    drill_fields: [cust_cd, v_customer_opus_n_prospect.name, cust_grp_id, of_customer_group.cust_grp_nm, of_customer_group.key_acct_tp_cd, of_customer_group.global_customer_type, month, cust_sts]
  }



  # Service Scope info


  dimension: trade_grp_ord {
    type: number
    sql: CASE ${TABLE}.trade_grp
      WHEN 'TPTA' THEN 1 WHEN 'AE' THEN 2 WHEN 'ASOC' THEN 3 WHEN 'AFLA' THEN 4 END    ;;
  }

  dimension: trade_grp {
    label: "Trade Group"
    order_by_field: trade_grp_ord
    type: string
    sql: ${TABLE}.trade_grp ;;
  }

  dimension: service_scope_group_code {
    type: string
    sql: ${TABLE}.service_scope_group_code ;;
  }

  dimension: dominant_flag {
    label: "Dominant Flag"
    type: string
    sql: ${TABLE}.dominant_flag ;;
  }

  dimension: gka_nvo_svc_scp_cd {
    label: "Service Scope Code (for GKA NVO)"
    type: string
    sql: ${TABLE}.gka_nvo_svc_scp_cd ;;
  }

  #### Individual months###################
  dimension: cust_grp_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_grp_sts ;;
  }

  dimension: cust_cd_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_grp_sts ;;
  }

  dimension: cust_sts {
    label: "Monthly CVA Status (Overall)"
    type: string
    sql: {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_grp_sts}
         {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd_grp_sts}
         {% endif %} ;;
  }

  dimension: cust_grp_n_trd_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_n_trd_grp_sts ;;
  }

  dimension: cust_cd_n_trd_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_n_trd_grp_sts ;;
  }

  dimension: cust_grp_n_ssg_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_n_ssg_grp_sts ;;
  }

  dimension: cust_cd_n_ssg_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_n_ssg_grp_sts ;;
  }

  dimension: cust_grp_n_dom_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_n_dom_grp_sts ;;
  }

  dimension: cust_cd_n_dom_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_n_dom_grp_sts ;;
  }

  dimension: cust_grp_n_ctrtrhq_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_n_ctrtrhq_grp_sts ;;
  }

  dimension: cust_cd_n_ctrtrhq_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_n_ctrtrhq_grp_sts ;;
  }

  dimension: cust_grp_n_ctrtctry_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_n_ctrtctry_grp_sts ;;
  }

  dimension: cust_cd_n_ctrtctry_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_n_ctrtctry_grp_sts ;;
  }

  dimension: cust_grp_n_ctrtofc_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_n_ctrtofc_grp_sts ;;
  }

  dimension: cust_cd_n_ctrtofc_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_n_ctrtofc_grp_sts ;;
  }

  dimension: cust_grp_n_ckam_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_n_ckam_grp_sts ;;
  }

  dimension: cust_cd_n_ckam_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_n_ckam_grp_sts ;;
  }


  #### Multi months###################

  dimension: cust_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_grp_sts_multimth ;;
  }

  dimension: cust_cd_sts_multimth {
    type: string
    sql: ${TABLE}.cust_cd_sts_multimth ;;
  }

  dimension: cust_sts_multimth {
    label: "Grouped CVA Status (Overall)"
    type: string
    sql: {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_sts_multimth}
         {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd_sts_multimth}
         {% endif %} ;;
  }

  dimension: cust_grp_n_trd_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_grp_n_trd_grp_sts_multimth ;;
  }

  dimension: cust_cd_n_trd_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_cd_n_trd_grp_sts_multimth ;;
  }

  dimension: cust_n_trd_grp_sts_multimth {
    label: "Grouped CVA Status (Trade Group)"
    type: string
    sql: {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_n_trd_grp_sts_multimth}
         {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd_n_trd_grp_sts_multimth}
         {% endif %} ;;
  }

  dimension: cust_grp_n_ssg_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_grp_n_ssg_grp_sts_multimth ;;
  }

  dimension: cust_cd_n_ssg_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_cd_n_ssg_grp_sts_multimth ;;
  }

  dimension: cust_n_ssg_grp_sts_multimth {
    label: "Grouped CVA Status (Svc Scp Grp)"
    type: string
    sql: {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_n_ssg_grp_sts_multimth}
         {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd_n_ssg_grp_sts_multimth}
         {% endif %} ;;
  }

  dimension: cust_grp_n_dom_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_grp_n_dom_grp_sts_multimth ;;
  }

  dimension: cust_cd_n_dom_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_cd_n_dom_grp_sts_multimth ;;
  }

  dimension: cust_n_dom_grp_sts_multimth {
    label: "Grouped CVA Status (Dominant Flag)"
    type: string
    sql: {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_n_dom_grp_sts_multimth}
         {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd_n_dom_grp_sts_multimth}
         {% endif %} ;;
  }

  dimension: cust_grp_n_ctrtrhq_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_grp_n_ctrtrhq_grp_sts_multimth ;;
  }

  dimension: cust_cd_n_ctrtrhq_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_cd_n_ctrtrhq_grp_sts_multimth ;;
  }

  dimension: cust_n_ctrtrhq_grp_sts_multimth {
    label: "Grouped CVA Status (Contract RHQ)"
    type: string
    sql: {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_n_ctrtrhq_grp_sts_multimth}
         {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd_n_ctrtrhq_grp_sts_multimth}
         {% endif %} ;;
  }

  dimension: cust_grp_n_ctrtctry_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_grp_n_ctrtctry_grp_sts_multimth ;;
  }

  dimension: cust_cd_n_ctrtctry_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_cd_n_ctrtctry_grp_sts_multimth ;;
  }

  dimension: cust_n_ctrtctry_grp_sts_multimth {
    label: "Grouped CVA Status (Contract Country)"
    type: string
    sql: {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_n_ctrtctry_grp_sts_multimth}
         {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd_n_ctrtctry_grp_sts_multimth}
         {% endif %} ;;
  }

  dimension: cust_grp_n_ctrtofc_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_grp_n_ctrtofc_grp_sts_multimth ;;
  }

  dimension: cust_cd_n_ctrtofc_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_cd_n_ctrtofc_grp_sts_multimth ;;
  }

  dimension: cust_n_ctrtofc_grp_sts_multimth {
    label: "Grouped CVA Status (Contract Ofc)"
    type: string
    sql: {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_n_ctrtofc_grp_sts_multimth}
         {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd_n_ctrtofc_grp_sts_multimth}
         {% endif %} ;;
  }

  dimension: cust_grp_n_ckam_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_grp_n_ckam_grp_sts_multimth ;;
  }

  dimension: cust_cd_n_ckam_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_cd_n_ckam_grp_sts_multimth ;;
  }

  dimension: cust_n_ckam_grp_sts_multimth {
    label: "Grouped CVA Status (CKAM)"
    type: string
    sql: {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_n_ckam_grp_sts_multimth}
         {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd_n_ckam_grp_sts_multimth}
         {% endif %} ;;
  }

  dimension: cust_grp_n_period_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_grp_n_period_grp_sts_multimth ;;
  }

  dimension: cust_cd_n_period_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_cd_n_period_grp_sts_multimth ;;
  }

  dimension: cust_n_period_grp_sts_multimth {
    label: "Grouped CVA Status (Contract Length)"
    type: string
    sql: {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_n_period_grp_sts_multimth}
         {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd_n_period_grp_sts_multimth}
         {% endif %} ;;
  }

  dimension: cust_grp_n_sscp_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_grp_n_sscp_grp_sts_multimth ;;
  }

  dimension: cust_cd_n_sscp_grp_sts_multimth {
    type: string
    sql: ${TABLE}.cust_cd_n_sscp_grp_sts_multimth ;;
  }

  dimension: cust_n_sscp_grp_sts_multimth {
    label: "Grouped CVA Status (Service Scope Code)"
    type: string
    sql: {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_n_sscp_grp_sts_multimth}
         {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd_n_sscp_grp_sts_multimth}
         {% endif %} ;;
  }

  measure: cust_grp_cnt {
    type: count_distinct
    label: "No of Cust Grp (raw)"
    sql: ${cust_grp_id} ;;
  }

  measure: cust_cd_cnt {
    type: count_distinct
    label: "No of Cust Code (raw)"
    sql: ${cust_cd} ;;
  }

  measure: cust_cnt {
    type: number
    label: "{% if    param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\"  %}By Customer Group{%
    elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"   %}By Customer Code{%
    endif %}"
    sql:  {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_cnt}
          {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd_cnt}
          {% endif %} ;;

    link: {
      label: "Drill to Details"
      url:   "{% if    param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_drill_option._parameter_value ==  \"'OVERALL'\"   %}{{ drill_4_overall_cust_grp._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_drill_option._parameter_value ==  \"'DOM'\"       %}{{ drill_4_dom_cust_grp._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_drill_option._parameter_value ==  \"'TRD_GRP'\"   %}{{ drill_4_trd_grp_cust_grp._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_drill_option._parameter_value ==  \"'SSG_GRP'\"   %}{{ drill_4_ssg_grp_cust_grp._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_drill_option._parameter_value ==  \"'CTRT_RHQ'\"  %}{{ drill_4_ctrtrhq_cust_grp._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_drill_option._parameter_value ==  \"'CTRT_CTRY'\" %}{{ drill_4_ctrtctry_cust_grp._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_drill_option._parameter_value ==  \"'CTRT_OFC'\"  %}{{ drill_4_ctrtofc_cust_grp._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_drill_option._parameter_value ==  \"'CKAM'\"      %}{{ drill_4_ckam_cust_grp._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_drill_option._parameter_value ==  \"'CTRT_LEN'\"  %}{{ drill_4_period_cust_grp._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_GRP'\" and param_drill_option._parameter_value ==  \"'MTH'\"       %}{{ drill_4_mth_cust_grp._link }}{%

      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_drill_option._parameter_value ==  \"'OVERALL'\"   %}{{ drill_4_overall_cust_cd._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_drill_option._parameter_value ==  \"'DOM'\"       %}{{ drill_4_dom_cust_cd._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_drill_option._parameter_value ==  \"'TRD_GRP'\"   %}{{ drill_4_trd_grp_cust_cd._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_drill_option._parameter_value ==  \"'SSG_GRP'\"   %}{{ drill_4_ssg_grp_cust_cd._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_drill_option._parameter_value ==  \"'CTRT_RHQ'\"  %}{{ drill_4_ctrtrhq_cust_cd._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_drill_option._parameter_value ==  \"'CTRT_CTRY'\" %}{{ drill_4_ctrtctry_cust_cd._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_drill_option._parameter_value ==  \"'CTRT_OFC'\"  %}{{ drill_4_ctrtofc_cust_cd._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_drill_option._parameter_value ==  \"'CKAM'\"      %}{{ drill_4_ckam_cust_cd._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_drill_option._parameter_value ==  \"'CTRT_LEN'\"  %}{{ drill_4_period_cust_cd._link }}{%
      elsif param_cust_grping_option._parameter_value ==  \"'CUST_CD'\"  and param_drill_option._parameter_value ==  \"'MTH'\"       %}{{ drill_4_mth_cust_cd._link }}{%

      endif %}"
    }
  }

  dimension: grouping_element {
    type: string
    sql:  {% if     param_cust_grping_option._parameter_value == "'CUST_GRP'" %} ${cust_grp_id}
          {% elsif  param_cust_grping_option._parameter_value == "'CUST_CD'"  %} ${cust_cd}
          {% endif %} ;;
  }

  measure: grp_element_cnt {
    type: count_distinct
    sql: ${grouping_element} ;;
  }

  measure: percent_ttl_cust_cnt {
    label: "% Count of Customer"
    type: number
    sql:  COUNT(DISTINCT ${grouping_element} ) /
          {% if    param_cust_percent_partition._parameter_value == "'DUMMY'" %}
                NULLIF( SUM( COUNT(DISTINCT ${grouping_element} ) ) OVER (PARTITION BY 1) , 0)
          {% elsif param_cust_percent_partition._parameter_value == "'KEY_ACC'" %}
                NULLIF( SUM( COUNT(DISTINCT ${grouping_element} ) ) OVER (PARTITION BY ${of_customer_group.key_acct_tp_cd} ) , 0)
          {% elsif param_cust_percent_partition._parameter_value == "'DOM_FLG'" %}
                NULLIF( SUM( COUNT(DISTINCT ${grouping_element} ) ) OVER (PARTITION BY ${dominant_flag} ) , 0)
          {% endif %};;
    value_format_name: percent_4
  }
  #DCN-1048, June 13rd 2023
  measure: data_file_4_missing_cva_elements {
    hidden: yes
    type: average
    filters: [scrfa_done_vs_missing: "CVA Missing" ]
    sql: 1;;
    drill_fields: [
      v_customer_opus_n_prospect.oneforce_id
      , of_customer.cust_grp_id
      , of_customer_group.cust_grp_nm
      , cust_cd
      , v_customer_opus_n_prospect.name
      , dummy_ckam_rhq
      , ckam_usr.country
      , dummy_ckam_country_name
      , ckam_usr.office_code_number
      , sc_rfa_no
      , ctrt_eff_dt_dtl
      , ctrt_exp_dt_dtl
      , ckam_usr.username
      , service_scope_group_code
      , dominant_flag_code
      , dummy_POR_RHQ
      , dummy_por_cd
      , dummy_por_nm
      , dummy_rev_lane_cd
      , dummy_live_reefer_flg
      , dummy_target_teu
      , dummy_origin_code
      , dummy_destination_code
      , dummy_destinantion_country_code
      , dummy_service_scope_code
      , dummy_CN_Sub_Region
    ]
  }

  measure: For_CVA_data_upload {
    label: "For Zero (0) CVA data upload"
    type: string
    sql: MAX('For Zero (0) CVA data upload') ;;
    link: {
      label: "Click to download CVA data file template"
      url: "{{data_file_4_missing_cva_elements._link}}"
    }
  }

  dimension: dominant_flag_code {
    label: "Dominant Flag"
    type: string
    sql: CASE WHEN ${dominant_flag} = 'DOM' then 'Y' ELSE 'N' END ;;
  }

  dimension: ctrt_eff_dt_dtl  {
    label: "CVA Effective Date (mm/dd/yyyy)"
    type: date
    html: {{ rendered_value | date: "%m-%d-%Y" }} ;;
    sql: ${TABLE}.ctrt_eff_dt_dtl ;;
  }

  dimension: ctrt_exp_dt_dtl {
    label: "CVA Expiry Date (mm/dd/yyyy)"
    type: date
    html: {{ rendered_value | date: "%m-%d-%Y" }} ;;
    sql: ${TABLE}.ctrt_exp_dt_dtl ;;
  }

  dimension: dummy_por_cd {
    label: "Origin Country Code"
    type: string
    sql: NULL ;;
  }

  dimension: dummy_por_nm {
    label: "Origin Country Name"
    type: string
    sql: NULL ;;
  }

  dimension: dummy_rev_lane_cd {
    label: "Revenue Lane Code"
    type: string
    sql: NULL ;;
  }

  dimension: dummy_live_reefer_flg {
    label: "Live Reefer Flag"
    type: string
    sql:  "N" ;;
  }

  dimension: dummy_target_teu {
    label: "Volume Agreement (numbers)"
    type: number
    sql: 0 ;;
  }

  dimension: dummy_ckam_rhq {
    label: "C-KAM RHQ"
    type: string
    sql: NULL ;;
  }

  dimension: dummy_ckam_country_name {
    label: "C-KAM Country Name"
    type: string
    sql: NULL ;;
  }

  dimension: dummy_POR_RHQ {
    label: "POR RHQ"
    type: string
    sql: NULL ;;
  }

  dimension: dummy_origin_code {
    label: "Origin Code"
    type: string
    sql: NULL ;;
  }

  dimension: dummy_destination_code {
    label: "Destination Code"
    type: string
    sql: NULL ;;
  }

  dimension: dummy_destinantion_country_code {
    label: "Destination Country Code"
    type: string
    sql: NULL ;;
  }

  dimension: dummy_service_scope_code {
    label: "Service Scope Code"
    type: string
    sql: NULL ;;
  }

  dimension: dummy_CN_Sub_Region {
    label: "CN Sub Region"
    type: string
    sql: NULL ;;
  }

  set: general_drill_down_overall {
    fields: [
      cust_grp_id,
      cust_cd,
      sc_rfa_no,
      service_scope_group_code,
      dominant_flag,
      cust_grp_sts_multimth,
      cust_cd_sts_multimth
    ]
  }

  set: detail {
    fields: [
      month,
      cust_grp_typ,
      cust_grp_id,
      cust_cd,
      sc_rfa_no,
      service_scope_group_code,
      dominant_flag,
      cust_grp_sts_multimth,
      cust_cd_sts_multimth
    ]
  }
}

view: global_cva_completion_2_1_inner {
  derived_table: {
    sql: WITH mths AS (
         SELECT DISTINCT Sales_Month as month
         FROM `ONEFORCE.OF_SALES_WEEK_MASTER`
         WHERE Sales_Month >= '202204'
     ),
     cva_each_mth AS (
        SELECT tgt.ONEForce_ID as tgt_id,
               tgt.CVA_Effective_Date,
               tgt.CVA_Expiry_Date,
               tgt.Contract_Office_Code ,
               mths.month ,
               tgt.target *
               ( date_diff(LEAST   (tgt.CVA_Expiry_Date,     LAST_DAY( CAST( mths.month  AS DATE FORMAT 'YYYYMM'),MONTH) ) ,
                           GREATEST(tgt.CVA_Effective_Date,            CAST( mths.month  AS DATE FORMAT 'YYYYMM')        ) , day ) + 1 ) /
               ( date_diff(tgt.CVA_Expiry_Date, tgt.CVA_Effective_Date, day)+1 ) as target_for_mth,
               tgt.Customer as customer_id,
               tgt.internal_contract_id,
               tgt.Service_Scope_Group_Code,
               (CASE tgt.Dominant_Flag WHEN 'Y' THEN 'DOM' ELSE 'N-DOM' END) as dominant_flag,
        FROM   `ONEFORCE.OF_CUSTOMER_TARGET`   tgt
        INNER JOIN mths ON  mths.month BETWEEN FORMAT_DATE('%Y%m', tgt.CVA_Effective_Date) and FORMAT_DATE('%Y%m', tgt.CVA_Expiry_Date)
     ),
     cva_each_mth_gka_nvo AS (
        SELECT tgt.ONEForce_ID as tgt_id,
               tgt.Contract_Office_Code ,
               mths.month ,
               tgt.Customer as customer_id,
               tgt.internal_contract_id,
               tgt.Service_Scope
        FROM   `ONEFORCE.OF_CUSTOMER_TARGET`   tgt
        INNER JOIN mths ON  mths.month BETWEEN FORMAT_DATE('%Y%m', tgt.CVA_Effective_Date) and FORMAT_DATE('%Y%m', tgt.CVA_Expiry_Date)
     ),
     sc_each_mth AS (
         SELECT DISTINCT
                schdr.sc_rfa_no,
                schdr.ONEForce_ID as contract_id,
                schdr.CTRT_EFF_DT,
                schdr.CTRT_EXP_DT,
                mths.month,
                schdr.cust_cd,
                sccust.ONEForce_ID as customer_id,
                sccust.cust_grp_id,
                CASE sccgrp.cntr_cust_tp_cd WHEN 'B' THEN 'BCO' WHEN 'N' THEN 'NVO' END as cust_grp_typ,
                sccgrp.key_acct_tp_cd as cust_grp_key_acct_tp_cd, -- GKA,LKA,RKA,SME
                CASE WHEN sccgrp.cntr_cust_tp_cd = 'N' and sccgrp.key_acct_tp_cd = 'GKA'
                     THEN scdtl.svc_scp_cd ELSE NULL END as gka_nvo_svc_scp_cd,
                sscp.service_scope_group_code,
                sscp.dominant_flag, -- DOM / N-DOM
                ssgcat.group_cat                as trade_grp,
                schdr.ofc_cd                    as ctrt_ofc_code,
                scdtl.scp_ofc_cd                as scp_ofc_cd ,
                CASE of_ctrt_rhq.REG_CUST_CNT_CD WHEN 'BR' THEN 'SAOHQ' WHEN 'US' THEN 'RICHQ' WHEN 'HK' THEN 'HKGHQ' WHEN 'SG' THEN 'SINHQ' WHEN 'GB' THEN 'LONHQ' END
                                                as ctrt_rhq_code,
                --DCN-1049
                --ckam_mapping.ckam_sales_person  as ckam_sales_person,
                CASE WHEN ckam_map_ofc.ckam_sales_person IS NOT NULL THEN ckam_map_ofc.ckam_sales_person ELSE ckam_map_ctry.ckam_sales_person END as ckam_sales_person,
                sccgrp.cust_grp_id ||' - '|| sccgrp.cust_grp_nm as cust_grp_id_n_nm ,
                sccust.cust_cd || ' - ' || sccust.name          as cust_cd_n_nm     ,
                schdr.sc_rfa_no||'-'||sscp.service_scope_group_code||'-'||sscp.dominant_flag as sc_key ,
                case
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '11' then 'North China' --'NCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '12' then 'North China' --'NCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '13' then 'North China' --'NCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '14' then 'North China' --'NCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '15' then 'North China' --'NCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '21' then 'North China' --'NCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '22' then 'North China' --'NCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '23' then 'North China' --'NCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '61' then 'North China' --'NCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '62' then 'North China' --'NCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '63' then 'North China' --'NCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '64' then 'North China' --'NCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '65' then 'North China' --'NCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '37' then 'North China' --'NCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '41' then 'North China' --'NCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '31' then 'Central China' --'CCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '32' then 'Central China' --'CCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '33' then 'Central China' --'CCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '34' then 'Central China' --'CCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '36' then 'Central China' --'CCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '42' then 'Central China' --'CCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '43' then 'Central China' --'CCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '50' then 'Central China' --'CCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '51' then 'Central China' --'CCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '35' then 'South China' --'SCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '44' then 'South China' --'SCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '45' then 'South China' --'SCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '46' then 'South China' --'SCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '52' then 'South China' --'SCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '53' then 'South China' --'SCN'
                when of_ctrt_loc.Country_Code = 'CN' and of_ctrt_loc.State_Code = '54' then 'South China' --'SCN'
                when of_ctrt_loc.Country_Code in ('HK','MO')                           then 'South China' --'SCN'
                else of_ctrt_ctry.Country_Name end  as ctrt_country_cgm_logic,
                CASE IFNULL( schdr.ctrt_dur_tp_cd , 'S' )
                WHEN 'S' THEN 'Short' WHEN 'L' THEN 'Long' WHEN 'M' THEN 'Medium' END as ctrt_period_typ
                , scdtl. ctrt_eff_dt as ctrt_eff_dt_dtl
                , scdtl. ctrt_exp_dt as ctrt_exp_dt_dtl
         FROM        `ONEFORCE.OF_SVC_CONTRACT`     schdr
         INNER JOIN  `ONEFORCE.OF_SVC_CONTRACT_DTL` scdtl  ON scdtl.sc_rfa_no    = schdr.sc_rfa_no
         INNER JOIN  mths ON ( ( mths.month BETWEEN FORMAT_DATE('%Y%m', schdr.CTRT_EFF_DT) and FORMAT_DATE('%Y%m', schdr.CTRT_EXP_DT) ) AND
                               ( mths.month BETWEEN FORMAT_DATE('%Y%m', scdtl.CTRT_EFF_DT) and FORMAT_DATE('%Y%m', scdtl.CTRT_EXP_DT) ) AND
                               ( scdtl.CTRT_EXP_DT >= CURRENT_DATE()  )
                             )
         INNER JOIN  `ONEFORCE.OF_SVC_SCP`                sscp    ON scdtl.svc_scp_cd              = sscp.Service_Scope_Code
         LEFT JOIN   ${of_svc_scp_grp_cat.SQL_TABLE_NAME} ssgcat  ON sscp.service_scope_group_code = ssgcat.svc_scp_grp
         INNER JOIN  `ONEFORCE.OF_CUSTOMER`         sccust ON schdr.cust_cd      = sccust.cust_cd
         INNER JOIN  `ONEFORCE.OF_CUSTOMER_GROUP`   sccgrp ON sccust.cust_grp_id = sccgrp.cust_grp_id
       --LEFT JOIN   `ONEFORCE.OF_OFFICE`     of_ctrt_ofc  ON schdr.ofc_cd              = of_ctrt_ofc.office_code
         LEFT JOIN   `ONEFORCE.OF_OFFICE`     of_ctrt_ofc  ON scdtl.scp_ofc_cd          = of_ctrt_ofc.office_code -- use service scope level office for mapping
         LEFT JOIN   `ONEFORCE.OF_LOCATION`   of_ctrt_loc  ON of_ctrt_ofc.location_code = of_ctrt_loc.location_code
         LEFT JOIN   `ONEFORCE.OF_COUNTRY`    of_ctrt_ctry ON of_ctrt_loc.country_code  = of_ctrt_ctry.country_code
         LEFT JOIN   `ONEFORCE.OF_REG_REF`    of_ctrt_rhq  ON of_ctrt_loc.country_code  = of_ctrt_rhq.cust_cnt_cd
         --DCN-1049 s
         LEFT JOIN   ${ckam_mapping_one_per_country.SQL_TABLE_NAME} ckam_map_ctry ON (sccust.cust_grp_id = ckam_map_ctry.customer_grp_id and of_ctrt_loc.country_code = ckam_map_ctry.contract_country_code)
         LEFT JOIN   ${ckam_mapping_one_per_office.SQL_TABLE_NAME} ckam_map_ofc ON (sccust.cust_grp_id = ckam_map_ofc.customer_grp_id and of_ctrt_loc.country_code = ckam_map_ofc.contract_country_code and of_ctrt_ofc.office_code = ckam_map_ofc.contract_office_code)
         --DCN-1049 e
        WHERE
         -- exclude ONE Quote contract and tariff
         NOT (  SUBSTR(schdr.sc_rfa_no,1,2)='KT'  OR
                    REGEXP_CONTAINS(schdr.sc_rfa_no, r'^R[0-9JQ][A-Za-z][0-9]{8}$') OR
                    REGEXP_CONTAINS(schdr.sc_rfa_no, r'^S[0-9JQ][A-Za-z][0-9]{7}$') OR
                    REGEXP_CONTAINS(schdr.sc_rfa_no, r'^R[0-9]{8}[A-Za-z][0-9JQ]$') OR
                    REGEXP_CONTAINS(schdr.sc_rfa_no, r'^S[0-9]{7}[A-Za-z][0-9JQ]$')  )
         AND schdr.sc_rfa_typ IN ('S','R')
     ),
     svc_sts AS (
         -- CVA done
         SELECT sc_each_mth.month,
                sc_each_mth.cust_grp_typ,
                sc_each_mth.cust_grp_key_acct_tp_cd,
                sc_each_mth.cust_grp_id,
                sc_each_mth.cust_cd,
                sc_each_mth.cust_grp_id_n_nm,
                sc_each_mth.cust_cd_n_nm,
                sc_each_mth.sc_rfa_no,
                sc_each_mth.service_scope_group_code,
                sc_each_mth.gka_nvo_svc_scp_cd ,
                sc_each_mth.dominant_flag  ,
                sc_each_mth.trade_grp ,
                sc_each_mth.ctrt_ofc_code ,
                sc_each_mth.scp_ofc_cd ,
                sc_each_mth.ctrt_country_cgm_logic ,
                sc_each_mth.ctrt_rhq_code ,
                sc_each_mth.ctrt_period_typ ,
                sc_each_mth.ckam_sales_person
                , sc_each_mth. ctrt_eff_dt_dtl
                , sc_each_mth. ctrt_exp_dt_dtl
                ,  CASE WHEN sc_each_mth.service_scope_group_code IN ('LN','EA') THEN --August 23rd 2023,
                ( SELECT CASE MAX(1) WHEN 1 THEN 'CVA Done' ELSE 'CVA Missing' END
                  FROM   cva_each_mth
                  WHERE  sc_each_mth.customer_id       = cva_each_mth.customer_id
                  AND    ( (sc_each_mth.cust_grp_typ = 'BCO' and sc_each_mth.contract_id = cva_each_mth.internal_contract_id )
                           or
                          (sc_each_mth.cust_grp_typ = 'NVO' or sc_each_mth.cust_grp_typ is null) )   -- matching ontract
                  AND    sc_each_mth.service_scope_group_code = cva_each_mth.Service_Scope_Group_Code  -- matching svc scp grp
                 -- AND    sc_each_mth.Dominant_Flag            = cva_each_mth.dominant_flag             -- matching dominant flag (DOM / N-DOM)
                  AND    sc_each_mth.scp_ofc_cd               = cva_each_mth.Contract_Office_Code      -- matching contract office code
                  AND    sc_each_mth.month                    = cva_each_mth.month                     -- matching of month
                )
                ELSE  ( SELECT CASE MAX(1) WHEN 1 THEN 'CVA Done' ELSE 'CVA Missing' END
                  FROM   cva_each_mth
                  WHERE  sc_each_mth.customer_id       = cva_each_mth.customer_id
                  AND    ( (sc_each_mth.cust_grp_typ = 'BCO' and sc_each_mth.contract_id = cva_each_mth.internal_contract_id )
                           or
                          (sc_each_mth.cust_grp_typ = 'NVO' or sc_each_mth.cust_grp_typ is null) )   -- matching ontract
                  AND    sc_each_mth.service_scope_group_code = cva_each_mth.Service_Scope_Group_Code  -- matching svc scp grp
                  AND    sc_each_mth.Dominant_Flag            = cva_each_mth.dominant_flag             -- matching dominant flag (DOM / N-DOM)
                  AND    sc_each_mth.scp_ofc_cd               = cva_each_mth.Contract_Office_Code      -- matching contract office code
                  AND    sc_each_mth.month                    = cva_each_mth.month                     -- matching of month
                ) END as scrfa_done_vs_missing
                , (SELECT CASE WHEN sc_each_mth.cust_grp_typ ||'-'|| sc_each_mth.cust_grp_key_acct_tp_cd = 'NVO-GKA'
                        THEN ( CASE MAX(1) WHEN 1 THEN 'CVA Done' ELSE 'CVA Missing' END )
                        ELSE ( MAX( CAST(null AS string) )                               ) END
                  FROM   cva_each_mth_gka_nvo
                  WHERE  sc_each_mth.customer_id              = cva_each_mth_gka_nvo.customer_id
                  AND    sc_each_mth.cust_grp_typ             = 'NVO'
                  AND    sc_each_mth.cust_grp_key_acct_tp_cd  = 'GKA'
                  AND    sc_each_mth.gka_nvo_svc_scp_cd       = cva_each_mth_gka_nvo.Service_Scope         -- matching svc scp
                  AND    sc_each_mth.scp_ofc_cd               = cva_each_mth_gka_nvo.Contract_Office_Code  -- matching contract office code
                  AND    sc_each_mth.month                    = cva_each_mth_gka_nvo.month                 -- matching of month
                ) as scrfa_done_vs_missing_4_gkanvo,
                ( SELECT SUM( cva_each_mth.target_for_mth )
                  FROM   cva_each_mth
                  WHERE  sc_each_mth.customer_id       = cva_each_mth.customer_id
                  AND    ( (sc_each_mth.cust_grp_typ = 'BCO' and sc_each_mth.contract_id = cva_each_mth.internal_contract_id )
                           or
                          (sc_each_mth.cust_grp_typ = 'NVO' or sc_each_mth.cust_grp_typ is null) )   -- matching ontract
                  AND    sc_each_mth.service_scope_group_code = cva_each_mth.Service_Scope_Group_Code  -- matching svc scp grp
                  AND    sc_each_mth.Dominant_Flag            = cva_each_mth.dominant_flag             -- matching dominant flag (DOM / N-DOM)
                  AND    sc_each_mth.scp_ofc_cd               = cva_each_mth.Contract_Office_Code      -- matching contract office code
                  AND    sc_each_mth.month                    = cva_each_mth.month                     -- matching of month
                ) as target_for_mth
      FROM  sc_each_mth
      )
      SELECT
        svc_sts.month
      , svc_sts.cust_grp_typ
      , svc_sts.cust_grp_key_acct_tp_cd
      , svc_sts.cust_grp_id
      , svc_sts.cust_cd
      , svc_sts.cust_grp_id_n_nm
      , svc_sts.cust_cd_n_nm
      , svc_sts.sc_rfa_no
      , svc_sts.service_scope_group_code
      , svc_sts.gka_nvo_svc_scp_cd
      , svc_sts.dominant_flag
      , svc_sts.trade_grp
      , svc_sts.ctrt_ofc_code
      , svc_sts.scp_ofc_cd
      , svc_sts.ctrt_country_cgm_logic
      , svc_sts.ctrt_rhq_code
      , svc_sts.ctrt_period_typ
      , svc_sts.ckam_sales_person
      , svc_sts.scrfa_done_vs_missing
      , svc_sts.scrfa_done_vs_missing_4_gkanvo
      , svc_sts.target_for_mth
      , svc_sts. ctrt_eff_dt_dtl
      , svc_sts. ctrt_exp_dt_dtl
      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id )||'-'||
             MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_grp_sts
      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd )||'-'||
             MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_grp_sts

      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, trade_grp )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, trade_grp )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_trd_grp_sts
      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, trade_grp  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, trade_grp  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_trd_grp_sts

      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, service_scope_group_code )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, service_scope_group_code )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_ssg_grp_sts
      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, service_scope_group_code  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, service_scope_group_code  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_ssg_grp_sts

      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, dominant_flag )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, dominant_flag )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_dom_grp_sts
      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, dominant_flag  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, dominant_flag  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_dom_grp_sts

      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, ctrt_rhq_code )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, ctrt_rhq_code )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_ctrtrhq_grp_sts
      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, ctrt_rhq_code  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, ctrt_rhq_code  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_ctrtrhq_grp_sts

      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, ctrt_country_cgm_logic )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, ctrt_country_cgm_logic )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_ctrtctry_grp_sts
      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, ctrt_country_cgm_logic  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, ctrt_country_cgm_logic  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_ctrtctry_grp_sts

      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, scp_ofc_cd )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, scp_ofc_cd )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_ctrtofc_grp_sts
      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, scp_ofc_cd  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, scp_ofc_cd  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_ctrtofc_grp_sts

      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, ckam_sales_person )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, ckam_sales_person )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_ckam_grp_sts
      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, ckam_sales_person  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, ckam_sales_person  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_ckam_grp_sts

      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, ctrt_period_typ )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_grp_id, ctrt_period_typ )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_period_grp_sts
      , CASE MAX(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, ctrt_period_typ  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing) OVER (PARTITION BY month, cust_cd, ctrt_period_typ  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_period_grp_sts

      ----- Status computed by  scrfa_done_vs_missing_4_gkanvo

      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_grp_sts_4_gkanvo
      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_grp_sts_4_gkanvo

      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, trade_grp )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, trade_grp )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_trd_grp_sts_4_gkanvo
      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, trade_grp  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, trade_grp  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_trd_grp_sts_4_gkanvo

      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, service_scope_group_code )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, service_scope_group_code )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_ssg_grp_sts_4_gkanvo
      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, service_scope_group_code  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, service_scope_group_code  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_ssg_grp_sts_4_gkanvo

      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, dominant_flag )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, dominant_flag )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_dom_grp_sts_4_gkanvo
      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, dominant_flag  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, dominant_flag  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_dom_grp_sts_4_gkanvo

      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, ctrt_rhq_code )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, ctrt_rhq_code )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_ctrtrhq_grp_sts_4_gkanvo
      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, ctrt_rhq_code  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, ctrt_rhq_code  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_ctrtrhq_grp_sts_4_gkanvo

      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, ctrt_country_cgm_logic )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, ctrt_country_cgm_logic )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_ctrtctry_grp_sts_4_gkanvo
      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, ctrt_country_cgm_logic  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, ctrt_country_cgm_logic  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_ctrtctry_grp_sts_4_gkanvo

      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, scp_ofc_cd )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, scp_ofc_cd )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_ctrtofc_grp_sts_4_gkanvo
      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, scp_ofc_cd  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, scp_ofc_cd  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_ctrtofc_grp_sts_4_gkanvo

      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, ckam_sales_person )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, ckam_sales_person )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_ckam_grp_sts_4_gkanvo
      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, ckam_sales_person  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, ckam_sales_person  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_ckam_grp_sts_4_gkanvo

      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, ctrt_period_typ )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, ctrt_period_typ )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_period_grp_sts_4_gkanvo
      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, ctrt_period_typ  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, ctrt_period_typ  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_period_grp_sts_4_gkanvo

      -----------

      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, gka_nvo_svc_scp_cd )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_grp_id, gka_nvo_svc_scp_cd )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_grp_n_sscp_grp_sts_4_gkanvo
      , CASE MAX(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, gka_nvo_svc_scp_cd  )||'-'||
      MIN(svc_sts.scrfa_done_vs_missing_4_gkanvo) OVER (PARTITION BY month, cust_cd, gka_nvo_svc_scp_cd  )
      WHEN 'CVA Missing-CVA Done'    THEN 'Partial'
      WHEN 'CVA Missing-CVA Missing' THEN 'Pending'
      WHEN 'CVA Done-CVA Done'       THEN 'Complete'
      ELSE 'Error' END  as cust_cd_n_sscp_grp_sts_4_gkanvo

      FROM   svc_sts
      order by 1, 2, 3, 4, 5, 6, 7, 8, 9
      ;;
    persist_for: "1 hour"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  filter: filter_mths {
    type: string
    suggestions: ["202204", "202205", "202206", "202207", "202208", "202209", "202210", "202211", "202212", "202301", "202302", "202303", "202304", "202305", "202306", "202307", "202308", "202309", "202310", "202311", "202312" , "202401", "202402", "202403" ]
    sql:  ({% condition filter_mths %} month {% endcondition %}  ) ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: cust_grp_typ {
    type: string
    sql: ${TABLE}.cust_grp_typ ;;
  }

  dimension: cust_grp_key_acct_tp_cd {
    type: string
    sql: ${TABLE}.cust_grp_key_acct_tp_cd ;;
  }

  dimension: cust_grp_id {
    type: string
    sql: ${TABLE}.cust_grp_id ;;
  }

  dimension: cust_cd {
    type: string
    sql: ${TABLE}.cust_cd ;;
  }

  dimension: cust_grp_id_n_nm {
    type: string
    sql: ${TABLE}.cust_grp_id_n_nm ;;
  }

  dimension: cust_cd_n_nm {
    type: string
    sql: ${TABLE}.cust_cd_n_nm ;;
  }

  dimension: sc_rfa_no {
    type: string
    sql: ${TABLE}.sc_rfa_no ;;
  }

  dimension: service_scope_group_code {
    type: string
    sql: ${TABLE}.service_scope_group_code ;;
  }

  dimension: dominant_flag {
    type: string
    sql: ${TABLE}.dominant_flag ;;
  }

  dimension: trade_grp_ord {
    type: number
    sql: CASE ${TABLE}.trade_grp
      WHEN 'TPTA' THEN 1 WHEN 'AE' THEN 2 WHEN 'ASOC' THEN 3 WHEN 'AFLA' THEN 4 END    ;;
  }

  dimension: trade_grp {
    type: string
    order_by_field: trade_grp_ord
    sql: ${TABLE}.trade_grp ;;
  }

  dimension: ctrt_ofc_code {
    type: string
    sql: ${TABLE}.ctrt_ofc_code ;;
  }

  dimension: scp_ofc_cd {
    type: string
    sql: ${TABLE}.scp_ofc_cd ;;
  }

  dimension: ctrt_country_cgm_logic {
    type: string
    sql: ${TABLE}.ctrt_country_cgm_logic ;;
  }

  dimension: ctrt_rhq_code {
    type: string
    sql: ${TABLE}.ctrt_rhq_code ;;
  }

  dimension: ctrt_period_typ {
    type: string
    sql: ${TABLE}.ctrt_period_typ ;;
  }

  dimension: ckam_sales_person {
    type: string
    sql: ${TABLE}.ckam_sales_person ;;
  }

  dimension: scrfa_done_vs_missing {
    type: string
    sql: ${TABLE}.scrfa_done_vs_missing ;;
  }

  dimension: scrfa_done_vs_missing_4_gkanvo {
    type: string
    sql: ${TABLE}.scrfa_done_vs_missing_4_gkanvo ;;
  }

  dimension: scrfa_is_cva_complete {
    type: string
    sql: CASE ${TABLE}.scrfa_done_vs_missing
      WHEN 'CVA Missing' THEN 'No' WHEN 'CVA Done' THEN 'Yes' END     ;;
  }

  dimension: target_for_mth {
    type: string
    sql: ${TABLE}.target_for_mth ;;
  }

  dimension: cust_grp_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_grp_sts ;;
  }

  dimension: cust_grp_n_trd_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_n_trd_grp_sts ;;
  }

  dimension: cust_grp_n_ssg_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_n_ssg_grp_sts ;;
  }

  dimension: cust_grp_n_dom_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_n_dom_grp_sts ;;
  }

  dimension: cust_grp_n_ctrtrhq_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_n_ctrtrhq_grp_sts ;;
  }

  dimension: cust_grp_n_ctrtctry_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_n_ctrtctry_grp_sts ;;
  }

  dimension: cust_grp_n_ctrtofc_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_n_ctrtofc_grp_sts ;;
  }

  dimension: cust_grp_n_ckam_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_n_ckam_grp_sts ;;
  }

  dimension: cust_grp_n_period_grp_sts {
    type: string
    sql: ${TABLE}.cust_grp_n_period_grp_sts ;;
  }

  dimension: cust_cd_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_grp_sts ;;
  }

  dimension: cust_cd_n_trd_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_n_trd_grp_sts ;;
  }

  dimension: cust_cd_n_ssg_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_n_ssg_grp_sts ;;
  }

  dimension: cust_cd_n_dom_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_n_dom_grp_sts ;;
  }

  dimension: cust_cd_n_ctrtrhq_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_n_ctrtrhq_grp_sts ;;
  }

  dimension: cust_cd_n_ctrtctry_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_n_ctrtctry_grp_sts ;;
  }

  dimension: cust_cd_n_ctrtofc_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_n_ctrtofc_grp_sts ;;
  }

  dimension: cust_cd_n_ckam_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_n_ckam_grp_sts ;;
  }

  dimension: cust_cd_n_period_grp_sts {
    type: string
    sql: ${TABLE}.cust_cd_n_period_grp_sts ;;
  }

  dimension: cust_grp_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_grp_grp_sts_4_gkanvo ;;
  }

  dimension: cust_cd_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_cd_grp_sts_4_gkanvo ;;
  }

  dimension: cust_grp_n_trd_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_grp_n_trd_grp_sts_4_gkanvo ;;
  }

  dimension: cust_cd_n_trd_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_cd_n_trd_grp_sts_4_gkanvo ;;
  }

  dimension: cust_grp_n_ssg_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_grp_n_ssg_grp_sts_4_gkanvo ;;
  }

  dimension: cust_cd_n_ssg_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_cd_n_ssg_grp_sts_4_gkanvo ;;
  }

  dimension: cust_grp_n_dom_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_grp_n_dom_grp_sts_4_gkanvo ;;
  }

  dimension: cust_cd_n_dom_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_cd_n_dom_grp_sts_4_gkanvo ;;
  }

  dimension: cust_grp_n_ctrtrhq_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_grp_n_ctrtrhq_grp_sts_4_gkanvo ;;
  }

  dimension: cust_cd_n_ctrtrhq_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_cd_n_ctrtrhq_grp_sts_4_gkanvo ;;
  }

  dimension: cust_grp_n_ctrtctry_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_grp_n_ctrtctry_grp_sts_4_gkanvo ;;
  }

  dimension: cust_cd_n_ctrtctry_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_cd_n_ctrtctry_grp_sts_4_gkanvo ;;
  }

  dimension: cust_grp_n_ctrtofc_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_grp_n_ctrtofc_grp_sts_4_gkanvo ;;
  }

  dimension: cust_cd_n_ctrtofc_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_cd_n_ctrtofc_grp_sts_4_gkanvo ;;
  }

  dimension: cust_grp_n_ckam_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_grp_n_ckam_grp_sts_4_gkanvo ;;
  }

  dimension: cust_cd_n_ckam_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_cd_n_ckam_grp_sts_4_gkanvo ;;
  }

  dimension: cust_grp_n_period_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_grp_n_period_grp_sts_4_gkanvo ;;
  }

  dimension: cust_cd_n_period_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_cd_n_period_grp_sts_4_gkanvo ;;
  }

  dimension: cust_grp_n_sscp_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_grp_n_sscp_grp_sts_4_gkanvo ;;
  }

  dimension: cust_cd_n_sscp_grp_sts_4_gkanvo {
    type: string
    sql: ${TABLE}.cust_cd_n_sscp_grp_sts_4_gkanvo ;;
  }


  set: detail {
    fields: [
      month,
      cust_grp_typ,
      cust_grp_id,
      cust_cd,
      sc_rfa_no,
      service_scope_group_code,
      dominant_flag,
      trade_grp,
      ctrt_ofc_code,
      ctrt_country_cgm_logic,
      ctrt_rhq_code,
      ckam_sales_person,
      scrfa_done_vs_missing,
      cust_grp_grp_sts,
      cust_grp_n_trd_grp_sts,
      cust_grp_n_ssg_grp_sts,
      cust_grp_n_dom_grp_sts,
      cust_grp_n_ctrtrhq_grp_sts,
      cust_grp_n_ctrtctry_grp_sts,
      cust_grp_n_ctrtofc_grp_sts,
      cust_grp_n_ckam_grp_sts,
      cust_cd_grp_sts,
      cust_cd_n_trd_grp_sts,
      cust_cd_n_ssg_grp_sts,
      cust_cd_n_dom_grp_sts,
      cust_cd_n_ctrtrhq_grp_sts,
      cust_cd_n_ctrtctry_grp_sts,
      cust_cd_n_ctrtofc_grp_sts,
      cust_cd_n_ckam_grp_sts
    ]
  }
}
