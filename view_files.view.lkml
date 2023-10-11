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

view: global_cva_completion_2_mth_master {
  derived_table: {
    sql: SELECT DISTINCT
      of_sales_week_master.Calendar_Year  AS calendar_year,
      RIGHT(of_sales_week_master.Fiscal_Year,4) AS fiscal_year_new_fmt,
      LEFT(of_sales_week_master.Sales_Month,4) ||''|| RIGHT(of_sales_week_master.Sales_Month,2)  AS month
      FROM `ONEFORCE.OF_SALES_WEEK_MASTER` AS of_sales_week_master
      WHERE of_sales_week_master.Sales_Month >= '202204'
       ;;

    persist_for: "24 hours"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: calendar_year {
    type: string
    sql: ${TABLE}.calendar_year ;;
  }

  dimension: fiscal_year_new_fmt {
    type: string
    sql: ${TABLE}.fiscal_year_new_fmt ;;
  }


  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  set: detail {
    fields: [calendar_year, fiscal_year_new_fmt, month]
  }
}

view: global_cva_gam {

  derived_table: {
    sql: with aa as (select *,
                            row_number() over (partition by customer_group, team_role ) as rn
                     from  `ONEFORCE.OF_SALES_TEAM_MEMBER`
                     where  upper(team_role) like 'GLOBAL ACCOUNT MANAGER (GAM)' and inactive = 'false' )
         select * from aa where rn = 1;;

  }

  dimension: oneforce_id {
    hidden: yes
    label: "ONEForce Id"  # programmatically added by LookML modifier
    primary_key: yes
    type: string
    sql: ${TABLE}.ONEForce_ID ;;
  }

  dimension: commodity {
    label: "Commodity"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Commodity ;;
  }

  dimension: container_type {
    label: "Container Type" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Container_Type ;;
  }

  dimension: created_by_id {
    label: "Created By Id"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CreatedById ;;
  }

  dimension_group: created {
    label: "Created Date" # programmatically added by LookML modifier
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.CreatedDate ;;
  }

  dimension: customer {
    hidden: yes
    type: string
    sql: ${TABLE}.Customer ;;
  }

  dimension: customer_group {
    type: string
    sql: ${TABLE}.Customer_Group ;;
  }


  dimension: destination {
    label: "Destination"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Destination ;;
  }

  dimension: last_modified_by_id {
    label: "Last Modified By Id"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.LastModifiedById ;;
  }

  dimension_group: last_modified {
    label: "Last Modified Date" # programmatically added by LookML modifier
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.LastModifiedDate ;;
  }

  dimension: origin {
    label: "Origin" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Origin ;;
  }

  dimension: sales_person {
    type: string
    sql: ${TABLE}.Sales_Person ;;
  }

  dimension: service_scope {
    label: "Service Scope"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Service_Scope ;;
  }

  dimension: service_scope_group {
    label: "Service Scope Group"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Service_Scope_Group ;;
  }

  dimension: svc_rfa_number {
    label: "SVC RFA Number" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SVC_RFA_Number ;;
  }

  dimension: team_role {
    label: "Team Member Role" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Team_Role ;;
  }

  dimension: sales_person_rownum {
    label: "Sales person rownum"
    type: number
    sql: ${TABLE}.sales_person_rownum ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }

  set: primary_key {
    fields: [oneforce_id, count]
  }
}

view: global_cva_status_options {
  derived_table: {
    sql: SELECT 'Complete' as grouped_status UNION ALL
         SELECT 'Pending'  as grouped_status UNION ALL
         SELECT 'Partial'  as grouped_status
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: grouped_status {
    type: string
    sql: ${TABLE}.grouped_status ;;
  }

  set: detail {
    fields: [grouped_status]
  }
}

view: global_cva_target {
  derived_table: {
    sql: select  v_customer_opus_n_prospect_of_cust_grp_cd as cust_grp_id2,
                                v_customer_opus_n_prospect_cust_cd as cust_cd2,
                                v_customer_opus_n_prospect_cust_grp_hrchy_cd as cust_grp_hrchy_cd,
                                a.oneforce_id as customer_target,
                                a.of_user_fullname as cva_ram,
                                coalesce(a.syear, cast(Format_Date("%Y", cva_effective_date) as int64)) as syear,
                                a.name as cva_name,
                                a.service_scope_group,
                                a.service_scope,
                                a.direction,
                                a.of_location_origin_location_code as origin,
                                ctry.country_name as origin_country,
                                of_svc_contract_sc_rfa_no  as  sc_rfa_no,
                                of_svc_contract_cont_period_typ_cd as ctrt_period_tp_cd,
                                of_vsl_svc_lane_service_lane_code as service_lane,
                                a.of_location_destination_location_code as destination,
                                --sum(a.weekly_average) cva_target,
                                a.target as cva_target,
                                min(coalesce(parse_date("%d%b%Y",concat('01',LEFT(cast(month_year_id as string),7))),cva_effective_date)) as start_month,
                                max(coalesce(last_day(parse_date("%d%b%Y",concat('01',LEFT(cast(month_year_id as string),7))),MONTH),cva_expiry_date)) as end_month
                          from  ${of_customer_target_and_target_dtl_weekly.SQL_TABLE_NAME} a
                          left join ${of_country.SQL_TABLE_NAME} ctry on ctry.country_code = LEFT(a.of_location_origin_location_code,2)
                          group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
         union all
         select  zv.cust_grp_id,
                 zv.cust_cd,
                 zv.cust_grp_hrchy_cd,
                 zt.oneforce_id,
                 CONCAT(zu.firstname, ' ', zu.lastname),
                 zt.syear,
                 zt.name as cva_name,
                 zt.service_scope_group,
                 zt.service_scope,
                 zt.direction,
                 zpor.location_code as origin,
                 zpctry.country_name as origin_country,
                 zsvc.sc_rfa_no  as  sc_rfa_no,
                 zsvc.ctrt_dur_tp_cd as ctrt_period_tp_cd,
                 zlane.service_lane_code as service_lane,
                 zdel.location_code as destination,
                 target,
                 coalesce(parse_date("%b%Y",concat(StartMonth,Syear)),cva_effective_date) as start_month,
                 coalesce(last_day(parse_date("%b%Y",concat(EndMonth,Eyear))),cva_expiry_date) as End_month
            from ${of_customer_target.SQL_TABLE_NAME} as zt
            left join ${v_customer_opus_n_prospect.SQL_TABLE_NAME} as zv on zv.oneforce_id = zt.customer and zv.cust_cd is not null
            left join ${of_user.SQL_TABLE_NAME} as zu on zu.oneforce_id = zt.sales_person
            left join ${of_location.SQL_TABLE_NAME} as zpor on zpor.oneforce_id = zt.origin
            left join ${of_country.SQL_TABLE_NAME} as zpctry on zpctry.country_code = zpor.country_code
            left join ${of_location.SQL_TABLE_NAME} as zdel on zdel.oneforce_id = zt.destination
            left join ${of_svc_contract.SQL_TABLE_NAME} as zsvc on zsvc.oneforce_id = zt.internal_contract_id
            left join ${of_vsl_svc_lane.SQL_TABLE_NAME} as zlane  ON zt.service_lane_product = zlane.ONEForce_ID
            where coalesce(zt.target,0) = 0
 ;;

    persist_for: "4 hours"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: cust_grp_id2 {
    type: string
    sql: ${TABLE}.cust_grp_id2 ;;
  }

  dimension: cust_cd2 {
    type: string
    sql: ${TABLE}.cust_cd2 ;;
  }

  dimension: cust_grp_hrchy_cd {
    type: string
    sql: ${TABLE}.cust_grp_hrchy_cd ;;
  }

  dimension: customer_target {
    type: string
    sql: ${TABLE}.customer_target ;;
  }

  dimension: syear {
    type: number
    sql: ${TABLE}.syear ;;
  }

  dimension: cva_ram {
    type: string
    sql: ${TABLE}.cva_ram ;;
  }

  dimension: cva_name {
    type: string
    sql: ${TABLE}.cva_name ;;
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

  dimension: cva_target {
    type: number
    sql: ${TABLE}.cva_target ;;
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

  set: detail {
    fields: [
      cust_grp_id2,
      cust_cd2,
      cust_grp_hrchy_cd,
      customer_target,
      syear,
      cva_name,
      service_scope_group,
      service_scope,
      direction,
      origin,
      origin_country,
      destination,
      cva_target,
      start_month,
      end_month
    ]
  }
}

view: grp_cust_list {
  derived_table: {
    sql:with aa as (select  c.cust_grp_id, sum(bkg_teu) bkg_teu
          from OF_BOOKING a
          -- add/change by Helen for DCN-491
          left join  ${of_svc_contract.SQL_TABLE_NAME} as of_svc_contract ON a.svc_cont_no = of_svc_contract.sc_rfa_no
          inner join  ${of_sales_week_master.SQL_TABLE_NAME} b on a.week = cast(b.sales_week as int64)
                      and sales_month <=  CAST(  EXTRACT(YEAR  FROM DATE_SUB( date_trunc(current_date(), month), INTERVAL 1 MONTH) ) * 100 +
                                                 EXTRACT(MONTH FROM DATE_SUB( date_trunc(current_date(), month), INTERVAL 1 MONTH) )  AS STRING )
          inner join  ${v_customer_opus_n_prospect.SQL_TABLE_NAME} c
          --on a.cnt_cust_cd = c.cust_cd
          on coalesce(of_svc_contract.cust_cd, a.ctrt_cust_cd) = c.cust_cd
          where a.bkg_sts_cd not in ( 'X','W')
          and {% condition fiscal_year_filter %} b.fiscal_year {% endcondition %}
          -- end for DCN-491
          group by c.cust_grp_id)
        select  g.CUST_GRP_ID,
                g.CUST_GRP_NM,
                aa.bkg_teu,
                g.KEY_ACCT_TP_CD,
                g.KEY_ACCT_CNT_CD,
                g.KEY_ACCT_RGN_CD,
                case when g.global_customer_type = 'B' THEN 'BCO' when g.global_customer_type = 'N' then 'NVO' else 'N/A' end as CNTR_CUST_TP_CD,
                g.delt_flg,
                g.srep_nm,
                g.srep_ofc_cd as office_code,
                f.location_code,
                r.reg_cust_cnt_cd,
                r.reg_nm1,
                r.cust_cnt_cd,
                g.srep_email
        from ${of_customer_group.SQL_TABLE_NAME} g
        left join aa ON  aa.CUST_GRP_ID = g.CUST_GRP_ID and g.delt_flg = 'N'
        left join ${of_office.SQL_TABLE_NAME} f on g.srep_ofc_cd = f.office_code
        left join ${of_reg_ref.SQL_TABLE_NAME} r on left(f.location_code,2) = r.cust_cnt_cd
        where ((0 < CASE WHEN IFNULL(g.key_acct_tp_cd,'XXX') not in ('GKA','RKA','LKA') THEN aa.bkg_teu  ELSE 1 END )
                 AND  (g.delt_flg = CASE WHEN IFNULL(g.key_acct_tp_cd,'XXX') not in ('GKA','RKA','LKA') THEN 'N' ELSE g.delt_flg END))
               and {% condition inactive_ka_filter %} g.delt_flg {% endcondition %}
   ;;
   #sql:  select  g.CUST_GRP_ID,
   #              g.CUST_GRP_NM,
   #              g.KEY_ACCT_TP_CD,
   #              g.KEY_ACCT_CNT_CD,
   #              g.KEY_ACCT_RGN_CD,
   #              case when g.global_customer_type = 'B' THEN 'BCO' when g.global_customer_type = 'N' then 'NVO' else 'N/A' end as CNTR_CUST_TP_CD,
   #              g.delt_flg,
   #              g.srep_nm,
   #              g.srep_ofc_cd as office_code,
   #              f.location_code,
   #              r.reg_cust_cnt_cd,
   #              r.reg_nm1,
   #              r.cust_cnt_cd,
   #              g.srep_email
   #        from ${of_customer_group.SQL_TABLE_NAME} g
   #        left join ${grp_cust_weekly_teu.SQL_TABLE_NAME} aa on aa.cust_grp_id = g.cust_grp_id
   #        left join ${of_office.SQL_TABLE_NAME} f on g.srep_ofc_cd = f.office_code
   #        left join ${of_reg_ref.SQL_TABLE_NAME} r on left(f.location_code,2) = r.cust_cnt_cd
   #        where g.delt_flg = CASE WHEN IFNULL(g.key_acct_tp_cd,'XXX') not in ('GKA','RKA','LKA') THEN 'N' ELSE g.delt_flg END
   #        group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14
   #        having (case when g.KEY_ACCT_TP_CD in ('GKA','RKA','LKA') then 1 else sum(aa.bkg_teu) end > 0)
   #;;
       #left join ${of_user.SQL_TABLE_NAME} u on trim(lower(g.srep_email)) = trim(lower(u.email)) -- DCN-552 , Jack 2022 Mar 15
    }

    measure: count {
      view_label: "Measure"
      type: count_distinct
      sql:  ${TABLE}.CUST_GRP_ID;;
      drill_fields: [detail*]

    }

    filter: fiscal_year_filter {
      type: string
      suggest_explore: of_sales_week_master
      suggest_dimension: of_sales_week_master.fiscal_year
    }


    filter: inactive_ka_filter {
      type: string
      suggestions: ["Y","N"]
    }

    dimension: cust_grp_id {
      view_label: "Group Customer"
      label: "Cust Group Code"
      type: string
      sql: ${TABLE}.CUST_GRP_ID ;;
      primary_key: yes
    }

    dimension: cust_grp_nm {
      view_label: "Group Customer"
      label: "Cust Group Name"
      type: string
      sql: ${TABLE}.CUST_GRP_NM ;;
    }


    dimension: cust_grp_id_and_name {
      view_label: "Group Customer"
      label: "Cust Group Code & Name"
      type: string
      sql: CONCAT(${cust_grp_id}," - ", ${cust_grp_nm});;
    }


    dimension: bkg_teu {
      view_label: "Group Customer"
      label: "TEU"
      description: "TEU till last completed month in the specified fiscal year "

      type: number
      sql: ${TABLE}.bkg_teu ;;
    }

    dimension: key_acct_tp_cd {
      view_label: "Group Customer"
      label: "Segmentation"
      type: string
      sql:  CASE
            WHEN ${TABLE}.KEY_ACCT_TP_CD ='GKA' THEN 'GKA'
            WHEN ${TABLE}.KEY_ACCT_TP_CD ='RKA' THEN 'RKA'
            WHEN ${TABLE}.KEY_ACCT_TP_CD ='LKA' THEN 'LKA'
            WHEN ${TABLE}.KEY_ACCT_TP_CD ='SME' THEN 'ONECare'
            ELSE ${TABLE}.KEY_ACCT_TP_CD
            END ;;
      suggest_persist_for: "24 hour"
    }

    dimension: key_acct_cnt_cd {
      view_label: "Group Customer"
      label: "Group Customer Country"
      type: string
      sql: ${TABLE}.KEY_ACCT_CNT_CD ;;
    }

    dimension: key_acct_rgn_cd {
      view_label: "Group Customer"
      label: "Group Customer Region"
      type: string
      sql: ${TABLE}.KEY_ACCT_RGN_CD ;;
    }

    dimension: delt_flg {
      view_label: "Group Customer"
      label: "Inactive"
      type: string
      sql:  ${TABLE}.delt_flg  ;;
    }


    dimension: cntr_cust_tp_cd {
      view_label: "Group Customer"
      label: "BCO/NVO Flag"
      description: "from global customer"
      type: string
      sql: ${TABLE}.CNTR_CUST_TP_CD ;;
    }

    dimension: Sales_Month_From {
      view_label: "Sales Week Master"
      label: "Sales Month From"
      type: string
      sql: cast(FORMAT_DATE("%b %Y",DATE_SUB(DATE_TRUNC(current_date(),MONTH), INTERVAL 12 MONTH)+1) as string) ;;
    }

    dimension: Sales_Month_To {
      view_label: "Sales Week Master"
      label: "Sales Month To"
      type: string
      sql: cast(FORMAT_DATE("%b %Y",DATE_TRUNC(current_date(),MONTH)-1) as string) ;;
    }

    dimension: Sales_Month_Range {
      view_label: "Sales Week Master"
      label: "Sales Month Range"
      type:  string
      sql:  CONCAT(${Sales_Month_From}," ~ ", ${Sales_Month_To} );;
    }

    dimension: Sales_Rep_Name {
      view_label: "Sales Rep Info"
      description: "GAM (if not available, sales rep of global child customer)"
      label: "Sales Rep"
      type:  string
      sql: initcap(${TABLE}.srep_nm);;
    }

    dimension: Sales_Rep_Email{
      view_label: "Sales Rep Info"
      label: "Sales_Rep_Email"
      type:  string
      sql: ${TABLE}.srep_email;;
    }
    dimension: Sales_Office {
      view_label: "Sales Rep Info"
      label: "Sales Office"
      type:  string
      sql: ${TABLE}.office_code;;
    }
    dimension: Location_Office {
      view_label: "Sales Rep Info"
      label: "Location Office"
      type:  string
      sql: ${TABLE}.location_code;;
    }
    dimension: Region {
      view_label: "Sales Rep Info"
      label: "Region"
      type:  string
      sql: ${TABLE}.reg_nm1;;
    }
    dimension: Sales_Rep_Country{
      view_label: "Sales Rep Info"
      label: "Sales_Rep_Country"
      type:  string
      sql: ${TABLE}.cust_cnt_cd;;
    }

    set: detail {
      fields: [
        cust_grp_id,
        cust_grp_nm,
        bkg_teu,
        key_acct_tp_cd,
        key_acct_cnt_cd,
        key_acct_rgn_cd,
        Sales_Rep_Name,
        Sales_Rep_Email,
        Location_Office,
        Sales_Rep_Country,
        Region
      ]
    }
  }

view: ka_actuals {
  derived_table: {
    #WH DCN-1077 (2023-07) Chg line 24 : inner join ${of_sales_week_master.SQL_TABLE_NAME} as  w on o.week = cast(w.sales_week as int64) and w.fiscal_year = 'FY2020'
    sql: with aa as (
          select distinct c.cust_grp_id, g.key_acct_tp_cd, g.cust_grp_nm, concat(g.cust_grp_id, " - ", g.cust_grp_nm) as cust_grp_and_name,
                  g.key_acct_cnt_cd as Key_Acct_Country, coalesce(f.office_code,c.ofc_cd) as ofc_cd, coalesce(LEFT(f.location_code,2),c.cust_cnt_cd) ctry_cd, cast(null as string) as SVC_CONT_NO,
                  g.ONEFORCE_ID, 'GAM' role_reqd, g.KEY_ACCT_RGN_CD, "" as ctrt_typ
            from ${v_customer_opus_n_prospect.SQL_TABLE_NAME} c
              inner join ${of_customer_group.SQL_TABLE_NAME} as g on c.cust_grp_id = g.cust_grp_id and g.key_acct_tp_cd in ('LKA','GKA','RKA')
              left join ${of_sales_team_member.SQL_TABLE_NAME} as b on g.oneforce_id = b.customer_group and g.global_account_manager = b.sales_person and b.team_role like '%(GAM)%' and b.inactive = 'false'
              left join ${of_user.SQL_TABLE_NAME} as u on b.sales_person = u.oneforce_id
              left join ${of_office.SQL_TABLE_NAME} as f on u.office_code_number = f.office_code
          where c.delt_flg = "N" and g.delt_flg = "N" and c.cust_grp_hrchy_cd = "G"
          union distinct
          select distinct c.cust_grp_id, g.key_acct_tp_cd, g.cust_grp_nm, concat(g.cust_grp_id, " - ", g.cust_grp_nm) as cust_grp_and_name,
                    g.key_acct_cnt_cd as Key_Acct_Country,  o.CTRT_PROP_OFC_CD ofc_cd, LEFT(f.location_code,2) ctry_cd, o.SVC_CONT_NO,
                    g.ONEFORCE_ID, 'CKAM' role_reqd, g.KEY_ACCT_RGN_CD, of_svc_contract.SC_RFA_TYP as ctrt_typ
            from `ONEFORCE.OF_BOOKING` o
                left join ${of_svc_contract.SQL_TABLE_NAME} as of_svc_contract ON o.svc_cont_no = of_svc_contract.sc_rfa_no
                inner join ${v_customer_opus_n_prospect.SQL_TABLE_NAME} as c on coalesce(of_svc_contract.cust_cd, o.ctrt_cust_cd) = c.cust_cd
                inner join ${of_customer_group.SQL_TABLE_NAME} as g on c.cust_grp_id = g.cust_grp_id and g.key_acct_tp_cd in ('LKA','GKA','RKA')
                inner join ${of_office.SQL_TABLE_NAME} as f on f.office_code = o.CTRT_PROP_OFC_CD
                inner join ${of_sales_week_master.SQL_TABLE_NAME} as  w on o.week = cast(w.sales_week as int64) and w.fiscal_year = 'FY2022'
            where o.bkg_sts_cd NOT IN ('X', 'W') and coalesce(o.xter_bkg_rqst_cd, 'XX') <> 'WEQ' and of_svc_contract.SC_RFA_TYP <> 'T'
            union distinct
            select distinct c.cust_grp_id, g.key_acct_tp_cd, g.cust_grp_nm, concat(g.cust_grp_id, " - ", g.cust_grp_nm) as cust_grp_and_name,
                    g.key_acct_cnt_cd as Key_Acct_Country,  o.CTRT_PROP_OFC_CD ofc_cd, LEFT(por_cd,2) ctry_cd, o.SVC_CONT_NO,
                    g.ONEFORCE_ID, 'SKAM' role_reqd, g.KEY_ACCT_RGN_CD, of_svc_contract.SC_RFA_TYP as ctrt_typ
            from `ONEFORCE.OF_BOOKING` o
                left join ${of_svc_contract.SQL_TABLE_NAME} as of_svc_contract ON o.svc_cont_no = of_svc_contract.sc_rfa_no
                inner join ${v_customer_opus_n_prospect.SQL_TABLE_NAME} as c on coalesce(of_svc_contract.cust_cd, o.ctrt_cust_cd) = c.cust_cd
                inner join ${of_customer_group.SQL_TABLE_NAME} as g on c.cust_grp_id = g.cust_grp_id
                inner join ${of_location.SQL_TABLE_NAME} as a on a.location_code = o.por_cd
                left join ${ka_actuals_teu.SQL_TABLE_NAME} ct on g.cust_grp_id = ct.cust_grp_id and ct.ctry_cd = LEFT(o.por_cd,2)
            where o.bkg_sts_cd NOT IN ('X', 'W') and (g.key_acct_tp_cd in ('GKA','RKA') and coalesce(ct.total_teu,0) >= 50 or g.key_acct_tp_cd = 'LKA' and coalesce(ct.total_teu,0) >= 500) and of_svc_contract.SC_RFA_TYP <> 'T'
            union distinct
            select distinct c.cust_grp_id, g.key_acct_tp_cd, g.cust_grp_nm, concat(g.cust_grp_id, " - ", g.cust_grp_nm) as cust_grp_and_name,
                    g.key_acct_cnt_cd as Key_Acct_Country,  o.CTRT_PROP_OFC_CD ofc_cd, LEFT(del_cd,2) ctry_cd, o.SVC_CONT_NO,
                    g.ONEFORCE_ID, 'SKAM' role_reqd, g.KEY_ACCT_RGN_CD, of_svc_contract.SC_RFA_TYP as ctrt_typ
            from `ONEFORCE.OF_BOOKING` o
                left join ${of_svc_contract.SQL_TABLE_NAME} as of_svc_contract ON o.svc_cont_no = of_svc_contract.sc_rfa_no
                inner join ${v_customer_opus_n_prospect.SQL_TABLE_NAME} as c on coalesce(of_svc_contract.cust_cd, o.ctrt_cust_cd) = c.cust_cd
                inner join ${of_customer_group.SQL_TABLE_NAME} as g on c.cust_grp_id = g.cust_grp_id
                inner join ${of_location.SQL_TABLE_NAME} as a on a.location_code = o.del_cd
                left  join ${ka_actuals_teu.SQL_TABLE_NAME} ct on g.cust_grp_id = ct.cust_grp_id and ct.ctry_cd = LEFT(o.del_cd,2)
            where o.bkg_sts_cd NOT IN ('X', 'W') and  (g.key_acct_tp_cd in ('GKA','RKA') and coalesce(ct.total_teu,0) >= 50 or g.key_acct_tp_cd = 'LKA' and coalesce(ct.total_teu,0) >= 500) and of_svc_contract.SC_RFA_TYP <> 'T'
            union distinct
            select distinct c.cust_grp_id, g.key_acct_tp_cd, g.cust_grp_nm, concat(g.cust_grp_id, " - ", g.cust_grp_nm) as cust_grp_and_name,
                    g.key_acct_cnt_cd as Key_Acct_Country, o.CTRT_PROP_OFC_CD ofc_cd, LEFT(por_cd,2) ctry_cd, o.SVC_CONT_NO,
                    g.ONEFORCE_ID, 'SKAS' role_reqd, g.KEY_ACCT_RGN_CD, of_svc_contract.SC_RFA_TYP as ctrt_typ
            from `ONEFORCE.OF_BOOKING` o
                left join ${of_svc_contract.SQL_TABLE_NAME} as of_svc_contract ON o.svc_cont_no = of_svc_contract.sc_rfa_no
                inner join ${v_customer_opus_n_prospect.SQL_TABLE_NAME} as c on coalesce(of_svc_contract.cust_cd, o.ctrt_cust_cd) = c.cust_cd
                inner join ${of_customer_group.SQL_TABLE_NAME} as g on c.cust_grp_id = g.cust_grp_id
                inner join ${of_location.SQL_TABLE_NAME} as a on a.location_code = o.por_cd
                left  join ${ka_actuals_teu.SQL_TABLE_NAME} ct on g.cust_grp_id = ct.cust_grp_id and ct.ctry_cd = LEFT(o.por_cd,2)
            where o.bkg_sts_cd NOT IN ('X', 'W') and g.key_acct_tp_cd in ('LKA','GKA','RKA') and coalesce( ct.total_teu, 0) >= 10 and of_svc_contract.SC_RFA_TYP <> 'T'
            union distinct
            select distinct c.cust_grp_id, g.key_acct_tp_cd, g.cust_grp_nm, concat(g.cust_grp_id, " - ", g.cust_grp_nm) as cust_grp_and_name,
                    g.key_acct_cnt_cd as Key_Acct_Country, o.CTRT_PROP_OFC_CD ofc_cd, LEFT(del_cd,2) ctry_cd, o.SVC_CONT_NO,
                    g.ONEFORCE_ID, 'SKAS' role_reqd, g.KEY_ACCT_RGN_CD, of_svc_contract.SC_RFA_TYP as ctrt_typ
            from `ONEFORCE.OF_BOOKING` o
                left join ${of_svc_contract.SQL_TABLE_NAME} as of_svc_contract ON o.svc_cont_no = of_svc_contract.sc_rfa_no
                inner join ${v_customer_opus_n_prospect.SQL_TABLE_NAME} as c on coalesce(of_svc_contract.cust_cd, o.ctrt_cust_cd) = c.cust_cd
                inner join ${of_customer_group.SQL_TABLE_NAME} as g on c.cust_grp_id = g.cust_grp_id
                inner join ${of_location.SQL_TABLE_NAME} as a on a.location_code = o.del_cd
                left  join ${ka_actuals_teu.SQL_TABLE_NAME} ct on g.cust_grp_id = ct.cust_grp_id and ct.ctry_cd = LEFT(o.del_cd,2)
            where o.bkg_sts_cd NOT IN ('X', 'W') and  g.key_acct_tp_cd in   ('LKA','GKA','RKA')  and coalesce( ct.total_teu, 0) >= 10 and of_svc_contract.SC_RFA_TYP <> 'T' )
            select aa.*, row_number() OVER(ORDER BY role_reqd ) AS prim_key
            from aa
            where aa.role_reqd = {% if ckam_or_skam._parameter_value == 'CKAM' %} 'CKAM'
            {% elsif ckam_or_skam._parameter_value == 'SKAM' %} 'SKAM'
            {% elsif ckam_or_skam._parameter_value == 'SKAS' %} 'SKAS'
            {% elsif ckam_or_skam._parameter_value == 'GAM' %} 'GAM'
            {% else %} 'CKAM' {% endif %}
            ;;
  }

  ##################################
  ### Parameters
  ##################################

  parameter: ckam_or_skam {
    type: unquoted
    allowed_value: {
      label: "GAM"
      value: "GAM"
    }
    allowed_value: {
      label: "C-KAM"
      value: "CKAM"
    }
    allowed_value: {
      label: "S-KAM"
      value: "SKAM"
    }
    allowed_value: {
      label: "S-KAS"
      value: "SKAS"
    }
    default_value: "GAM"
  }

  parameter: show_exception_as {
    type: unquoted
    allowed_value: {
      label: "Completed"
      value: "Completed"
    }
    allowed_value: {
      label: "Outstanding"
      value: "Outstanding"
    }
    default_value: "Completed"
  }


  ##################################
  ### Table fields
  ##################################

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: ctrt_typ {
    type: string
    sql: ${TABLE}.ctrt_typ ;;
    label: "Contract Type"
  }

  dimension: exception {
    type: yesno
    sql:  CASE
          WHEN "{% parameter show_exception_as %}" ='Completed' THEN coalesce(${of_ckam_skam_4.status},'Invalid') in ('Invalid','Approved')
          WHEN "{% parameter show_exception_as %}" ='Outstanding' THEN coalesce(${of_ckam_skam_4.exception},'no') = 'no'
          END ;;
  }

  dimension: cust_grp_id {
    type: string
    sql: ${TABLE}.cust_grp_id ;;
  }

  dimension: key_acct_tp_cd {
    type: string
    #sql: ${TABLE}.key_acct_tp_cd ;; HELEN
    sql:  CASE
          WHEN ${TABLE}.key_acct_tp_cd ='GKA' THEN 'GKA'
          WHEN ${TABLE}.key_acct_tp_cd ='RKA' THEN 'RKA'
          WHEN ${TABLE}.key_acct_tp_cd ='LKA' THEN 'LKA'
          WHEN ${TABLE}.key_acct_tp_cd ='SME' THEN 'ONECare'
          ELSE ${TABLE}.key_acct_tp_cd
          END ;;
  }

  dimension: cust_grp_nm {
    type: string
    sql: ${TABLE}.cust_grp_nm ;;
  }

  dimension: cust_grp_and_name {
    type: string
    sql: ${TABLE}.cust_grp_and_name ;;
  }

  dimension: key_acct_country {
    type: string
    sql: ${TABLE}.Key_Acct_Country ;;
  }

  dimension: ofc_cd {
    view_label: "Role-based"
    label: "{% if ckam_or_skam._parameter_value == 'GAM' %} Customer Global Office
    {% else %} Contract Office
    {% endif %}"
    type: string
    sql: ${TABLE}.ofc_cd ;;
  }

  dimension: ctry_cd {
    view_label: "Role-based"
    label: "POR/DEL Country"
    type: string
    sql: ${TABLE}.ctry_cd ;;
  }

  dimension: svc_cont_no {
    label: "Contract Number"
    type: string
    sql: ${TABLE}.SVC_CONT_NO ;;
  }

  dimension: oneforce_id {
    type: string
    hidden: yes
    sql: ${TABLE}.ONEFORCE_ID ;;
  }

  dimension: role_reqd {
    type: string
    sql: ${TABLE}.role_reqd ;;
  }

  dimension: key_acct_rgn_cd  {
    type:  string
    sql: ${TABLE}.KEY_ACCT_RGN_CD;;
  }

  dimension: prim_key {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
  }

  ##################################
  ### Derived Fields
  ##################################

  dimension: Role_Tile {
    type:  string
    view_label: "Role-based"
    sql: case when "{% parameter ckam_or_skam %}" = "CKAM" then "C-KAM"
              when "{% parameter ckam_or_skam %}" = "SKAM" then "S-KAM"
              when "{% parameter ckam_or_skam %}" = "GAM" then "GAM"
              else "S-KAS" end;;
    html: <h2> {{rendered_value}} </h2> ;;
  }

  dimension: Role_Define_Tile {
    view_label: "Role-based"
    type:  string
    sql:  case when "{% parameter ckam_or_skam %}" = "CKAM" then
                  CONCAT( "At least 1xC-KAM mapping is expected for each contract office country.\n",
                          "Unfulfillment% is calculated by missing C-KAM mapping count/ expected count.\n",
                          "e.g. G-AB12345 has 3 contract countries. If only one contract country has C-KAM mapping then unfulfillment% = 2/3 = 67%")
               when "{% parameter ckam_or_skam %}" = "SKAM" then
                  CONCAT( "At least 1xS-KAM mapping is expected for each inbound and outbound country (at or above 50 TEUs per year for GKA & RKA and at or above 500 TEUs per year for LKA). ",
                          "Unfulfillment% is calculated by missing S-KAM mapping count/ Expected count.\n",
                          "e.g. GKA G-AB12345 has annual TEU of 600, 280 and 49 in CN,US and DE respectively. If only US has S-KAM mapping then unfulfillment% = 1/2 = 50%")
               when "{% parameter ckam_or_skam %}" = "GAM" then
                  CONCAT( "Every Group customer should have only 1x GAM. ",
                          "Unfulfillment% is calculated by missing GAM mapping count/ Expected count.\n")
               else
                  CONCAT( "At least 1xS-KAS mapping is expected for each inbound and outbound country (at or above 10 TEUs per year)\n",
                          "UnFulfillment% is calculated by missing S-KAS mapping count/ Expected count.\n",
                          "e.g. GKA G-AB12345 has annual TEU of 20 and 9 in DE and SE respectively. If DE has S-KAS mapping then unfulfillment% = 0/1 = 0%")
          end ;;

    html: <h4 style="white-space:pre-line; text-align:left; font-size:50% line-height:150%; font-family:Calibri " > {{rendered_value}} </h4> ;;

  }

  dimension: RHQ_Name {
    type:  string
    view_label: "Role-based"
    label: "{% if ckam_or_skam._parameter_value == 'CKAM' %} Contract Office (RHQ)
    {% elsif ckam_or_skam._parameter_value == 'GAM' %} Customer Global Office (RHQ)
    {% else %} POR/DEL Country (RHQ)
    {% endif %}"
    sql: ${of_reg_ref.reg_rhq_code} ;;
  }

  dimension: Country_Name {
    type:  string
    view_label: "Role-based"
    label: "{% if ckam_or_skam._parameter_value == 'CKAM' %} Contract Country
    {% elsif ckam_or_skam._parameter_value == 'GAM' %} Customer Global Office Country
    {% else %} POR/DEL Country
    {% endif %}"
    sql: ${of_country.country_name} ;;
  }


  measure: Total_Mapped {
    view_label: "Role-based"
    type: count_distinct
    label: "{% if ckam_or_skam._parameter_value == 'CKAM' %} With C-KAM mapping
    {% elsif ckam_or_skam._parameter_value == 'SKAM' %} With S-KAM mapping
    {% elsif ckam_or_skam._parameter_value == 'GAM' %} With GAM mapping
    {% else %} With S-KAS mapping
    {% endif %}"
    sql:  CASE WHEN ${of_ckam_skam_4.role} = ${role_reqd} AND ${exception} AND "{% parameter ckam_or_skam %}" = ${role_reqd} THEN CONCAT( ${cust_grp_id} ,${ctry_cd})  END ;;
    link: {
      label: "Show All {{value}} Customer Group"
      url: "{{ drill_fields_CustGrp._link }} &fields=ka_actuals.UnMapped_CustGrp_Detail* &f[ka_actuals.Total_Mapped]=%3E0 "
    }
    link: {
      label: "Explore by Contract Office"
      url: "{{ mapped_drill_fields_Office._link  }} &fields=ka_actuals.Mapped_Office_Detail* &f[ka_actuals.Total_Mapped]=%3E0 "
    }
  }

  measure: Total_UnMapped {
    view_label: "Role-based"
    type: count_distinct
    label: "{% if ckam_or_skam._parameter_value == 'CKAM' %} Without C-KAM mapping
    {% elsif ckam_or_skam._parameter_value == 'SKAM' %} Without S-KAM mapping
    {% elsif ckam_or_skam._parameter_value == 'GAM' %} Without GAM mapping
    {% else %} Without S-KAS mapping
    {% endif %}"
    sql: CASE WHEN (${of_ckam_skam_4.role} is null OR not ${exception}) AND "{% parameter ckam_or_skam %}" = ${role_reqd} THEN CONCAT( ${cust_grp_id} ,${ctry_cd})  END ;;
    #drill_fields: [Dummy_Detail*]
    link: {
      label: "Show All {{value}} Customer Group"
      url: "{{ drill_fields_CustGrp._link }} &fields=ka_actuals.UnMapped_CustGrp_Detail* &f[ka_actuals.Total_UnMapped]=%3E0 "
    }
    link: {
      label: "Explore by Contract Office"
      url: "{{ unmapped_drill_fields_Office._link  }} &fields=ka_actuals.UnMapped_Office_Detail* &f[ka_actuals.Total_UnMapped]=%3E0 "
    }
  }

  measure: drill_fields_CustGrp {
    type: number
    hidden: yes
    sql:  0 ;;
    drill_fields: [UnMapped_CustGrp_Detail*]
  }

  measure: unmapped_drill_fields_Office {
    type: number
    hidden: yes
    sql:  0 ;;
    drill_fields: [UnMapped_Office_Detail*]
  }

  measure: mapped_drill_fields_Office {
    type: number
    hidden: yes
    sql:  0 ;;
    drill_fields: [Mapped_Office_Detail*]
  }


  measure: Unfulfillment {
    view_label: "Role-based"
    type: number
    sql:  ${Total_UnMapped}/if((${Total_Mapped}+${Total_UnMapped})=0,1,(${Total_Mapped}+${Total_UnMapped}))*100;;
    value_format: "0\%"
    html: With {% parameter ckam_or_skam %} Mapping: {{Total_Mapped._rendered_value}} ({{Fulfillment._rendered_value}}), Without {% parameter ckam_or_skam %} Mapping: {{Total_UnMapped._rendered_value}} ({{rendered_value}});;
  }


  measure: Fulfillment {
    view_label: "Role-based"
    type: number
    sql:  ${Total_Mapped}/if((${Total_Mapped}+${Total_UnMapped})=0,1,(${Total_Mapped}+${Total_UnMapped}))*100;;
    value_format: "0\%"
    html: With {% parameter ckam_or_skam %} Mapping: {{Total_Mapped._rendered_value}} ({{rendered_value}}), Without {% parameter ckam_or_skam %} Mapping: {{Total_UnMapped._rendered_value}} ({{Unfulfillment._rendered_value}});;
  }

  dimension: CtrtVol {
    view_label: "Role-based"
    label: "Contract Volume"
    type: number
    sql:  CASE WHEN "{% parameter ckam_or_skam %}" = ${role_reqd} AND (${role_reqd} = 'CKAM') THEN ${ka_actuals_vol.contract_volume}
                  WHEN "{% parameter ckam_or_skam %}" = ${role_reqd} AND (${role_reqd} = 'GAM') THEN ${ka_actuals_vol.contract_volume}
                  ELSE 0 END ;;
  }

  measure: Total_CtrtVol {
    view_label: "Role-based"
    label: "Total Contract Volume"
    type: sum
    sql: ${CtrtVol};;
    value_format_name: decimal_0
    sql_distinct_key: CONCAT(${prim_key},${ka_actuals_vol.prim_key}) ;;
  }

  dimension: Total_Teu {
    view_label: "Role-based"
    label: "Export + Import Teu"
    type:  number
    sql:  CASE WHEN "{% parameter ckam_or_skam %}" = ${role_reqd}
      AND (${role_reqd} = 'SKAM' OR ${role_reqd} = 'SKAS') THEN ${ka_actuals_teu_dtl.total_teu} ELSE 0 END ;;
  }

  dimension: Export_Teu {
    view_label: "Role-based"
    label: "Export Teu"
    type:  number
    sql:  CASE WHEN "{% parameter ckam_or_skam %}" = ${role_reqd}
      AND (${role_reqd} = 'SKAM' OR ${role_reqd} = 'SKAS') THEN ${ka_actuals_teu_dtl.export_teu} ELSE 0 END ;;
  }

  dimension: Import_Teu {
    view_label: "Role-based"
    label: "Import Teu"
    type:  number
    sql:  CASE WHEN "{% parameter ckam_or_skam %}" = ${role_reqd}
      AND (${role_reqd} = 'SKAM' OR ${role_reqd} = 'SKAS') THEN ${ka_actuals_teu_dtl.import_teu} ELSE 0 END ;;
  }


  measure: Sum_Total_Teu {
    view_label: "Role-based"
    label: "Total Export + Import Teu"
    type: sum
    sql:  ${Total_Teu} ;;
    value_format_name: decimal_0
  }

  measure: Total_Dynamic {
    view_label: "Role-based"
    type:  sum
    #WH DCN-1077 (202307)
    #label: "{% if ckam_or_skam._parameter_value == 'CKAM' %} Contract Vol.
    #{% elsif ckam_or_skam._parameter_value == 'GAM' %} FY2020 TEU
    #{% else %} Total
    #{% endif %} "
    label: "{% if ckam_or_skam._parameter_value == 'CKAM' %} Contract Vol.
    {% elsif ckam_or_skam._parameter_value == 'GAM' %} FY2022 TEU
    {% else %} Total
    {% endif %} "

    sql:  CASE WHEN "{% parameter ckam_or_skam %}" = "CKAM" THEN ${CtrtVol}
                WHEN "{% parameter ckam_or_skam %}" = "GAM" THEN ${CtrtVol}
               ELSE ${Total_Teu} END;;
    value_format_name: decimal_0
    #drill_fields: [Total_Contract_Detail*]
    #link: {
    #  label: "{% if ckam_or_skam._parameter_value == 'CKAM' or ckam_or_skam._parameter_value == 'CKAS' %} By Contract Office
    #  {% else %} By Country
    #  {% endif %} "
    #  url: "{{ link }}
    #  {% if ckam_or_skam._parameter_value == 'CKAM' or ckam_or_skam._parameter_value == 'CKAS' %} &fields=ka_actuals.Total_Contract_Detail* &f[ka_actuals.Total_Dynamic]=%3E0
    #  {% else %} &fields=ka_actuals.Total_Service_Detail* &f[ka_actuals.Total_Dynamic]=%3E0
    #  {% endif %} "
    #}
    link: {
      label: "{% if ckam_or_skam._parameter_value == 'CKAM' or ckam_or_skam._parameter_value == 'GAM' %} Show All {{rendered_value}}
      {% else %} Show All {{rendered_value}}
      {% endif %} "
      url: "
      {% if ckam_or_skam._parameter_value == 'CKAM' %} {{ drill_fields_Contract._link }} &fields=ka_actuals.Total_Contract_Detail* &f[ka_actuals.Total_Dynamic]=%3E0
      {% elsif ckam_or_skam._parameter_value == 'GAM' %} {{ drill_fields_GAM._link }} &fields=ka_actuals.Total_GAM_Detail* &f[ka_actuals.Total_Dynamic]=%3E0
      {% else %} {{ drill_fields_Service._link }} &fields=ka_actuals.Total_Service_Detail* &f[ka_actuals.Total_Dynamic]=%3E0
      {% endif %} "
    }
  }

  measure: drill_fields_Contract {
    type: number
    hidden: yes
    sql:  0 ;;
    drill_fields: [Total_Contract_Detail*]
  }

  measure: drill_fields_GAM {
    type: number
    hidden: yes
    sql:  0 ;;
    drill_fields: [Total_GAM_Detail*]
  }

  measure: drill_fields_Service {
    type: number
    hidden: yes
    sql:  0 ;;
    drill_fields: [Total_Service_Detail*]
  }

  measure: Sum_Export_Teu {
    view_label: "Role-based"
    label: "Total Export Teu"
    type: sum
    sql: ${Export_Teu};;
    value_format_name: decimal_0
    #sql_distinct_key: CONCAT(${prim_key},${ka_actuals_te.prim_key}) ;;
  }

  measure: Export_Dynamic {
    view_label: "Role-based"
    type:  number
    label: "{% if ckam_or_skam._parameter_value == 'CKAM' %} Not Applicable
    {% elsif ckam_or_skam._parameter_value == 'GAM' %} Not Applicable
    {% else %} Export
    {% endif %}"
    sql:  SUM(CASE WHEN "{% parameter ckam_or_skam %}" = "CKAM" THEN 0
                     WHEN "{% parameter ckam_or_skam %}" = "GAM" THEN 0
                     ELSE ${Export_Teu}
                     END);;
    value_format_name: decimal_0
    html:
          {% if ckam_or_skam._parameter_value == 'CKAM' or ckam_or_skam._parameter_value == 'GAM' %}
          n.a
          {% else %}
          {{Sum_Export_Teu._rendered_value}}
          {% endif %}
          ;;
  }

  measure: Sum_Import_Teu {
    view_label: "Role-based"
    label: "Total Import Teu"
    type: sum
    sql: ${Import_Teu};;
    value_format_name: decimal_0
    #sql_distinct_key: CONCAT(${prim_key},${ka_actuals_te.prim_key}) ;;
  }

  measure: Import_Dynamic {
    view_label: "Role-based"
    type:  number
    label: "{% if ckam_or_skam._parameter_value == 'CKAM' %} Not Applicable
    {% elsif ckam_or_skam._parameter_value == 'GAM' %} Not Applicable
    {% else %} Import
    {% endif %} "
    sql:  SUM(CASE WHEN "{% parameter ckam_or_skam %}" = "CKAM" THEN 0
                     WHEN "{% parameter ckam_or_skam %}" = "GAM" THEN 0
                     ELSE ${Import_Teu}
                     END);;
    value_format_name: decimal_0
    html:
          {% if ckam_or_skam._parameter_value == 'CKAM' or ckam_or_skam._parameter_value == 'GAM' %}
          n.a
          {% else %}
          {{Sum_Import_Teu._rendered_value}}
          {% endif %}
          ;;
  }

  set: Total_GAM_Detail {
    fields: [
      cust_grp_nm,
      cust_grp_id,
      ofc_cd,
      Country_Name,
      Total_Dynamic
    ]
  }

  set: Total_Contract_Detail {
    fields: [
      cust_grp_nm,
      cust_grp_id,
      ofc_cd,
      svc_cont_no,
      Total_Dynamic
    ]
  }

  set: Total_Service_Detail {
    fields: [
      cust_grp_nm,
      cust_grp_id,
      Country_Name,
      ofc_cd,
      svc_cont_no,
      Total_Dynamic,
      Sum_Export_Teu,
      Sum_Import_Teu
    ]
  }

  set: UnMapped_CustGrp_Detail {
    fields: [
      Country_Name,
      cust_grp_id,
      cust_grp_nm
    ]
  }

  set: UnMapped_Office_Detail {
    fields: [
      Country_Name,
      ofc_cd,
      Total_UnMapped
    ]
  }

  set: Mapped_Office_Detail {
    fields: [
      Country_Name,
      ofc_cd,
      Total_Mapped
    ]
  }

  set: Dummy_Detail {
    fields: [
      Country_Name
    ]
  }

  set: detail {
    fields: [
      cust_grp_id,
      key_acct_tp_cd,
      cust_grp_nm,
      cust_grp_and_name,
      key_acct_country,
      ofc_cd,
      ctry_cd,
      svc_cont_no,
      oneforce_id,
      role_reqd
    ]
  }

}

view: ka_actuals_gam {
  derived_table: {
    #sql: select cust_grp_id, srep_nm as salesrep_gam, row_number() over (partition by cust_grp_id ) as rownum
    #  from V_CUSTOMER_OPUS_N_PROSPECT c
    #  where delt_flg = 'N' and cust_grp_hrchy_cd = 'G'
    #   ;;
    sql: select g.cust_grp_id, u.firstname||' '||u.lastname as salesrep_gam,row_number() over (partition by cust_grp_id ) as rownum
        from ${of_customer_group.SQL_TABLE_NAME} as g
        left join ${of_sales_team_member.SQL_TABLE_NAME} as b on g.oneforce_id = b.customer_group and g.global_account_manager = b.sales_person and b.team_role like '%(GAM)%'
        left join ${of_user.SQL_TABLE_NAME} as u on b.sales_person = u.oneforce_id
        where b.inactive = 'false'
        ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: cust_grp_id {
    type: string
    sql: ${TABLE}.cust_grp_id ;;
  }

  dimension: salesrep_gam {
    description: "Global Account Manager (if not available, sales rep of global child customer)"
    type: string
    sql: UPPER(${TABLE}.salesrep_gam) ;;
  }

  dimension: rownum {
    type: number
    sql: ${TABLE}.rownum ;;
  }

  set: detail {
    fields: [cust_grp_id, salesrep_gam, rownum]
  }
}

view: ka_actuals_teu {
  derived_table: {
    #WH DCN-1077 (20230718) - change below parameter "FY2020" to "FY2022"
    #inner join ${of_sales_week_master.SQL_TABLE_NAME} as m on o.week =  cast(regexp_replace(m.sales_week, '[/W]', '') as int64) and m.Fiscal_Year = 'FY2020'
    #inner join ${of_sales_week_master.SQL_TABLE_NAME} as m on o.week =  cast(regexp_replace(m.sales_week, '[/W]', '') as int64) and m.Fiscal_Year = 'FY2020'
    sql: with aa as  (select  c.cust_grp_id, LEFT(por_cd,2) ctry_cd , sum(o.bkg_teu) past12m_actual_TEU, 'EXPORT' TEU_TYPE
                      from `ONEFORCE.OF_BOOKING` o
                      left  join ${of_svc_contract.SQL_TABLE_NAME} as of_svc_contract ON o.svc_cont_no = of_svc_contract.sc_rfa_no
                      inner join ${v_customer_opus_n_prospect.SQL_TABLE_NAME} as c on coalesce(of_svc_contract.cust_cd, o.ctrt_cust_cd) = c.cust_cd
                      inner join ${of_customer_group.SQL_TABLE_NAME} as g on c.cust_grp_id = g.cust_grp_id and g.key_acct_tp_cd in ('LKA','GKA','RKA')
                      inner join ${of_location.SQL_TABLE_NAME} as a on a.location_code = o.por_cd
                      inner join ${of_sales_week_master.SQL_TABLE_NAME} as m on o.week =  cast(regexp_replace(m.sales_week, '[/W]', '') as int64) and m.Fiscal_Year = 'FY2022'
                      where o.bkg_sts_cd not in ('X','W') and coalesce(o.xter_bkg_rqst_cd,'XX') <> 'WEQ'
                      group by  c.cust_grp_id,  LEFT(por_cd,2)
                      union all
                      select  c.cust_grp_id,  LEFT(del_cd,2) ctry_cd , sum(o.bkg_teu) past12m_actual_TEU, 'IMPORT' TEU_TYPE
                      from `ONEFORCE.OF_BOOKING` o
                      left  join ${of_svc_contract.SQL_TABLE_NAME} as of_svc_contract ON o.svc_cont_no = of_svc_contract.sc_rfa_no
                      inner join ${v_customer_opus_n_prospect.SQL_TABLE_NAME} as c on coalesce(of_svc_contract.cust_cd, o.ctrt_cust_cd) = c.cust_cd
                      inner join ${of_customer_group.SQL_TABLE_NAME} as g on c.cust_grp_id = g.cust_grp_id and g.key_acct_tp_cd in ('LKA','GKA','RKA')
                      inner join ${of_location.SQL_TABLE_NAME} as a on a.location_code = o.del_cd
                      inner join ${of_sales_week_master.SQL_TABLE_NAME} as m on o.week =  cast(regexp_replace(m.sales_week, '[/W]', '') as int64) and m.Fiscal_Year = 'FY2022'
                      where o.bkg_sts_cd not in ('X','W') and  coalesce(o.xter_bkg_rqst_cd,'XX') <> 'WEQ'
                      group by  c.cust_grp_id,  LEFT(del_cd,2)
                      )
            select cust_grp_id,  ctry_cd,
                   sum(case when teu_type = 'EXPORT' then past12m_actual_TEU else 0 end) export_teu,
                   sum(case when teu_type = 'IMPORT' then past12m_actual_TEU else 0 end) import_teu,
                   sum(case when teu_type = 'CTRVOL' then 0 else past12m_actual_TEU end) total_teu
             from  aa
             group by cust_grp_id,  ctry_cd
            ;;
    #persist_for: "4 hours"
      sql_trigger_value: SELECT
        CASE WHEN
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
    }

    dimension: cust_grp_id {
      type: string
      sql: ${TABLE}.cust_grp_id ;;
    }

    dimension: ctry_cd {
      type: string
      sql: ${TABLE}.ctry_cd ;;
    }

    dimension: export_teu {
      type: number
      sql: ${TABLE}.export_teu ;;
    }

    dimension: import_teu {
      type: number
      sql: ${TABLE}.import_teu ;;
    }

    dimension: total_teu {
      type: number
      sql: ${TABLE}.total_teu ;;
    }

    set: detail {
      fields: [cust_grp_id, ctry_cd, export_teu, import_teu, total_teu]
    }
  }

view: ka_actuals_teu_dtl {
  derived_table: {
    #WH DCN-1077 (20230718) change parameter "FY2020" to "FY2022"
    #inner join ${of_sales_week_master.SQL_TABLE_NAME} m on o.week =  cast(regexp_replace(m.sales_week, '[/W]', '') as int64) and m.Fiscal_Year = 'FY2020'
    #inner join ${of_sales_week_master.SQL_TABLE_NAME} m on o.week =  cast(regexp_replace(m.sales_week, '[/W]', '') as int64) and m.Fiscal_Year = 'FY2020'
    sql: with aa as (
                select  c.cust_grp_id, LEFT(por_cd,2) ctry_cd, o.CTRT_PROP_OFC_CD office_code, o.svc_cont_no, sum(o.bkg_teu) teu, 'EXPORT' TEU_TYPE
                from `ONEFORCE.OF_BOOKING` o
                left  join ${of_svc_contract.SQL_TABLE_NAME} as of_svc_contract ON o.svc_cont_no = of_svc_contract.sc_rfa_no
                inner join ${v_customer_opus_n_prospect.SQL_TABLE_NAME} as c on coalesce(of_svc_contract.cust_cd, o.ctrt_cust_cd) = c.cust_cd
                inner join ${of_customer_group.SQL_TABLE_NAME} as g on c.cust_grp_id = g.cust_grp_id and g.key_acct_tp_cd in ('LKA','GKA','RKA')
                inner join ${of_location.SQL_TABLE_NAME} as a on a.location_code = o.por_cd
                inner join ${of_sales_week_master.SQL_TABLE_NAME} m on o.week =  cast(regexp_replace(m.sales_week, '[/W]', '') as int64) and m.Fiscal_Year = 'FY2022'
                where o.bkg_sts_cd NOT IN ('X', 'W')
                group by  c.cust_grp_id,  LEFT(por_cd,2), o.CTRT_PROP_OFC_CD,  o.svc_cont_no
                union all
                select  c.cust_grp_id,  LEFT(del_cd,2) ctry_cd , o.CTRT_PROP_OFC_CD office_code, o.svc_cont_no, sum(o.bkg_teu) bkg_teu, 'IMPORT' TEU_TYPE
                from `ONEFORCE.OF_BOOKING` o
                left  join ${of_svc_contract.SQL_TABLE_NAME} as of_svc_contract ON o.svc_cont_no = of_svc_contract.sc_rfa_no
                inner join ${v_customer_opus_n_prospect.SQL_TABLE_NAME} as c on  coalesce(of_svc_contract.cust_cd, o.ctrt_cust_cd) = c.cust_cd
                inner join ${of_customer_group.SQL_TABLE_NAME} as g on c.cust_grp_id = g.cust_grp_id and g.key_acct_tp_cd in ('LKA','GKA','RKA')
                inner join ${of_location.SQL_TABLE_NAME} as a on a.location_code = o.del_cd
                inner join ${of_sales_week_master.SQL_TABLE_NAME} m on o.week =  cast(regexp_replace(m.sales_week, '[/W]', '') as int64) and m.Fiscal_Year = 'FY2022'
                where o.bkg_sts_cd NOT IN ('X', 'W')
                group by  c.cust_grp_id,  LEFT(del_cd,2), o.CTRT_PROP_OFC_CD,  o.svc_cont_no)
          select cust_grp_id, ctry_cd, office_code, svc_cont_no,
                 sum(case when teu_type = 'EXPORT' then teu else 0 end) export_teu,
                 sum(case when teu_type = 'IMPORT' then teu else 0 end) import_teu,
                 sum(teu) total_teu
          from aa
          group by cust_grp_id, ctry_cd, office_code, svc_cont_no
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
    }

    dimension: cust_grp_id {
      type: string
      sql: ${TABLE}.cust_grp_id ;;
    }

    dimension: ctry_cd {
      type: string
      sql: ${TABLE}.ctry_cd ;;
    }

    dimension: office_code {
      type: string
      sql: ${TABLE}.office_code ;;
    }

    dimension: svc_cont_no {
      type: string
      sql: ${TABLE}.svc_cont_no ;;
    }

    dimension: total_teu {
      type: number
      sql: ${TABLE}.total_teu ;;
    }

    dimension: export_teu {
      type: number
      sql: ${TABLE}.export_teu ;;
    }

    dimension: import_teu {
      type: number
      sql: ${TABLE}.import_teu ;;
    }

    dimension: teu_type {
      type: string
      sql: ${TABLE}.TEU_TYPE ;;
    }

    set: detail {
      fields: [
        cust_grp_id,
        ctry_cd,
        office_code,
        svc_cont_no,
        total_teu,
        export_teu,
        import_teu,
        teu_type
      ]
    }
  }

view: ka_actuals_vol {
  derived_table: {
    #WH DCN-1077 (20230718) change parameter "FY2020" to "FY2022"
    #inner join ${of_sales_week_master.SQL_TABLE_NAME} m on o.week =  cast(regexp_replace(m.sales_week, '[/W]', '') as int64) and m.Fiscal_Year = 'FY2020'
    #inner join ${of_sales_week_master.SQL_TABLE_NAME} m on o.week =  cast(regexp_replace(m.sales_week, '[/W]', '') as int64) and m.Fiscal_Year = 'FY2020'
    sql: select  c.cust_grp_id,  LEFT(f.location_code,2) ctry_cd , f.office_code, o.svc_cont_no, 'CKAM' role,
                 sum(o.bkg_teu) contract_volume
         from ${of_booking.SQL_TABLE_NAME} o
         left  join ${of_svc_contract.SQL_TABLE_NAME} as of_svc_contract ON o.svc_cont_no = of_svc_contract.sc_rfa_no
         inner join ${v_customer_opus_n_prospect.SQL_TABLE_NAME} as c on coalesce(of_svc_contract.cust_cd, o.ctrt_cust_cd) = c.cust_cd
         inner join ${of_customer_group.SQL_TABLE_NAME} as g on c.cust_grp_id = g.cust_grp_id and g.key_acct_tp_cd in ('LKA','GKA','RKA')
         inner join ${of_office.SQL_TABLE_NAME} f on f.office_code = o.CTRT_PROP_OFC_CD
         inner join ${of_sales_week_master.SQL_TABLE_NAME} m on o.week =  cast(regexp_replace(m.sales_week, '[/W]', '') as int64) and m.Fiscal_Year = 'FY2022'
        where o.bkg_sts_cd NOT IN ('X', 'W')
        group by  c.cust_grp_id, LEFT(f.location_code,2) , f.office_code, o.svc_cont_no
        union all
        select  c.cust_grp_id,  'n.a' as ctry_cd , 'n.a' as office_code, 'n.a' as svc_cont_no, 'GAM' role,
                 sum(o.bkg_teu) contract_volume
         from ${of_booking.SQL_TABLE_NAME} o
         left  join ${of_svc_contract.SQL_TABLE_NAME} as of_svc_contract ON o.svc_cont_no = of_svc_contract.sc_rfa_no
         inner join ${v_customer_opus_n_prospect.SQL_TABLE_NAME} as c on coalesce(of_svc_contract.cust_cd, o.ctrt_cust_cd) = c.cust_cd
         inner join ${of_customer_group.SQL_TABLE_NAME} as g on c.cust_grp_id = g.cust_grp_id and g.key_acct_tp_cd in ('LKA','GKA','RKA')
         inner join ${of_sales_week_master.SQL_TABLE_NAME} m on o.week =  cast(regexp_replace(m.sales_week, '[/W]', '') as int64) and m.Fiscal_Year = 'FY2022'
        where o.bkg_sts_cd NOT IN ('X', 'W')
        group by  c.cust_grp_id
 ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [detail*]
  }

  dimension: cust_grp_id {
    type: string
    sql: ${TABLE}.cust_grp_id ;;
  }

  dimension: ctry_cd {
    type: string
    sql: ${TABLE}.ctry_cd ;;
  }

  dimension: office_code {
    type: string
    sql: ${TABLE}.office_code ;;
  }

  dimension: svc_cont_no {
    type: string
    sql: ${TABLE}.svc_cont_no ;;
  }

  dimension: contract_volume {
    type: number
    sql: ${TABLE}.contract_volume ;;
  }

  dimension: role {
    type: string
    sql: ${TABLE}.role ;;
  }

  dimension: prim_key {
    type:  string
    sql: CONCAT(cust_grp_id,  ctry_cd , office_code, svc_cont_no, role) ;;
  }

  set: detail {
    fields: [cust_grp_id, ctry_cd, contract_volume]
  }
}

view: is_missed_selection {
  derived_table: {
    sql: SELECT 'Yes' is_missed  UNION ALL
         SELECT 'No'  is_missed
        ;;
  }
  dimension: is_missed {
    type: string
    primary_key: yes
    sql: ${TABLE}.is_missed ;;
  }
}

view: is_fulfilled_selection {
  derived_table: {
    sql: SELECT 'Yes' is_fulfilled  UNION ALL
         SELECT 'No'  is_fulfilled
        ;;
  }
  dimension: is_fulfilled {
    type: string
    primary_key: yes
    sql: ${TABLE}.is_fulfilled ;;
  }
}
#######################################
view: mpr_qbr_quarter_master {
  derived_table: {
    sql: SELECT
          left(Calendar_Quarter,4)||'Q'||right(Calendar_Quarter,1) as Calendar_Quarter
        , Calendar_Year
        , CASE WHEN current_date() between qtr_start_date and qtr_end_date THEN 'Current Quater'
               WHEN date_sub( date_trunc( current_date(), month) , interval  3 month ) between qtr_start_date and qtr_end_date THEN 'Last Quater'
               ELSE NULL END as quarter_selection
        FROM ( SELECT
               Calendar_Quarter
              ,Calendar_Year
              ,parse_date('%Y%m', min(Sales_Month)  ) qtr_start_date
              ,date_sub( date_add( parse_date('%Y%m', max(Sales_Month)  ),interval 1 month), interval 1 day)  qtr_end_date
              FROM `ONEFORCE.OF_SALES_WEEK_MASTER` w
              GROUP BY 1, 2
             ) X
        ORDER BY 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: calendar_quarter {
    type: string
    sql: ${TABLE}.Calendar_Quarter ;;
  }

  dimension: calendar_year {
    type: string
    sql: ${TABLE}.Calendar_Year ;;
  }

  dimension: quarter_selection {
    type: string
    sql: ${TABLE}.quarter_selection ;;
  }

  set: detail {
    fields: [calendar_quarter, calendar_year, quarter_selection]
  }
}
#######################################
view: ckam_skam_master {
  derived_table: {
    sql:SELECT
        mbr.sales_person ,
        mbr.customer_group,
        usr.FirstName || ' '|| usr.LastName as full_name,
        ckam_ctry.contract_country_code as kam_country_code
        FROM `ONEFORCE.OF_SALES_TEAM_MEMBER` mbr
        INNER JOIN ${of_sales_team_member_contract_country.SQL_TABLE_NAME} ckam_ctry on (mbr.oneforce_id = ckam_ctry.oneforce_id )
        LEFT JOIN ${of_user.SQL_TABLE_NAME}     usr on (mbr.sales_person = usr.oneforce_id )
        WHERE mbr.team_role = 'Contract Key Account Manager (C-KAM)' and mbr.sales_person is not null and ckam_ctry.contract_country_code is not null and mbr.inactive = 'false'
        UNION DISTINCT
        SELECT
        mbr.sales_person ,
        mbr.customer_group,
        usr.FirstName || ' '|| usr.LastName as full_name,
        skam_ctry.service_country_code as kam_country_code,
        FROM `ONEFORCE.OF_SALES_TEAM_MEMBER` mbr
        INNER JOIN ${of_sales_team_member_service_country.SQL_TABLE_NAME} as skam_ctry on (mbr.oneforce_id = skam_ctry.oneforce_id )
        LEFT JOIN ${of_user.SQL_TABLE_NAME}     usr on (mbr.sales_person = usr.oneforce_id )
        WHERE mbr.team_role = 'Service Key Account Manager (S-KAM)' and mbr.sales_person is not null and skam_ctry.service_country_code is not null and mbr.inactive = 'false'
       ;;
  }

  dimension: sales_person {
    type: string
    sql: ${TABLE}.sales_person ;;
  }

  dimension: customer_group {
    type: string
    sql: ${TABLE}.customer_group ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}.full_name ;;
  }

  dimension: kam_country_code {
    type: string
    sql: ${TABLE}.kam_country_code ;;
  }

}
#######################################
view: qbr_monitor {
  derived_table: {
    sql: WITH
      qtr_master as (
        SELECT
          left(Calendar_Quarter,4)||'Q'||right(Calendar_Quarter,1) as Calendar_Quarter
        , Calendar_Year
        , qtr_start_date, qtr_end_date
        , CASE WHEN current_date() between qtr_start_date and qtr_end_date THEN 'Current Quater'
               WHEN date_sub( date_trunc( current_date(), month) , interval  3 month ) between qtr_start_date and qtr_end_date THEN 'Last Quater'
               ELSE NULL END as quarter_selection
        FROM ( SELECT
               Calendar_Quarter
              ,Calendar_Year
              ,parse_date('%Y%m', min(Sales_Month)  ) qtr_start_date
              ,date_sub( date_add( parse_date('%Y%m', max(Sales_Month)  ),interval 1 month), interval 1 day)  qtr_end_date
              FROM `ONEFORCE.OF_SALES_WEEK_MASTER` w
              GROUP BY 1, 2 ) X
        ORDER BY 1
      ),
      ckam as (
        SELECT
        mbr.sales_person ,
        usr.FirstName || ' '|| usr.LastName as full_name,
        mbr.customer_group,
        --mbr.contract_country,
        ckam_ctry.contract_country_code as contract_country,
        c.country_name as contract_country_name,
        mbr.SVC_RFA_Number,
        date_trunc(mbr.CreatedDate, day) as createddate,
        g.cust_grp_id, -- DCN-1013
        g.cust_grp_nm
        FROM `ONEFORCE.OF_SALES_TEAM_MEMBER` mbr
        INNER JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g on (mbr.customer_group = g.ONEForce_Id ) and g.delt_flg = 'N'
        INNER JOIN ${of_sales_team_member_contract_country.SQL_TABLE_NAME} as ckam_ctry on (mbr.oneforce_id = ckam_ctry.oneforce_id )
        --LEFT JOIN `ONEFORCE.OF_COUNTRY`         c on (mbr.contract_country = c.country_code )
        LEFT JOIN `ONEFORCE.OF_COUNTRY`         c on (ckam_ctry.contract_country_code = c.country_code )
        LEFT JOIN ${of_user.SQL_TABLE_NAME}     usr on (mbr.sales_person = usr.oneforce_id )
        WHERE mbr.team_role = 'Contract Key Account Manager (C-KAM)' and mbr.sales_person is not null and mbr.inactive = 'false' and ckam_ctry.contract_country_code is not null
      ),
      evnt_qbr_ckam as (
      SELECT e.*,
             (CASE WHEN g.oneforce_id is not null then g.ONEForce_Id else e.WhatId end ) as cust_grp_oneforce_id
       FROM `ONEFORCE.OF_EVENT` e
       LEFT JOIN `ONEFORCE.V_CUSTOMER_OPUS_N_PROSPECT` c on (e.WhatId = c.ONEForce_Id)
       LEFT JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g          on (c.cust_grp_id = g.cust_grp_id)
       WHERE e.Event_Category in ( 'Quarterly Business Review' )
       AND   e.Event_Status = 'Completed'
       AND   EXISTS(SELECT 1 FROM `ONEFORCE.OF_SALES_TEAM_MEMBER` mbr
                    WHERE  mbr.team_role = 'Contract Key Account Manager (C-KAM)'
                    AND    e.ownerid     = mbr.sales_person  )
      )
      SELECT 'CKAM-QBR' as record_type,
             qtr.Calendar_Quarter, qtr.Calendar_Year, qtr.quarter_selection,
             ckam.sales_person, ckam.full_name as ckam_full_name,
             ckam.cust_grp_nm, ckam.cust_grp_id, ckam.customer_group as cust_grp_oneforce_id, ckam.SVC_RFA_Number as svc_rfa_oneforce_id, ckam.contract_country_name, ckam.contract_country,
             (case when evnt_qbr_ckam.oneforce_id is null then 'Missed' else 'QBR:'||evnt_qbr_ckam.subject end) as subject, evnt_qbr_ckam.startdatetime , evnt_qbr_ckam.completed_on , evnt_qbr_ckam.oneforce_id,
             (case when evnt_qbr_ckam.oneforce_id is null then 'Yes' else 'No' end) is_missed,
             (case when evnt_qbr_ckam.oneforce_id is null then 'No' else 'Yes' end) is_fulfilled,
             (case when evnt_qbr_ckam.oneforce_id is null     then qtr.Calendar_Quarter||'-'||ckam.sales_person||'-'||ckam.cust_grp_id||'-'||ckam.contract_country else NULL end) qbr_not_fulfilled,
             (case when evnt_qbr_ckam.oneforce_id is not null then qtr.Calendar_Quarter||'-'||ckam.sales_person||'-'||ckam.cust_grp_id||'-'||ckam.contract_country else NULL end) qbr_fulfilled
      FROM qtr_master as qtr
      LEFT JOIN ckam     on (ckam.createddate <= qtr.qtr_end_date)
      LEFT JOIN evnt_qbr_ckam on ( ckam.sales_person     = evnt_qbr_ckam.ownerid and
                                   -- ckam.contract_country = evnt_qbr_ckam.country and -- DCN-1061
                                   ckam.customer_group   = evnt_qbr_ckam.cust_grp_oneforce_id and
                                   ( date_trunc( evnt_qbr_ckam.startdatetime, day ) between qtr.qtr_start_date and qtr.qtr_end_date )
                                   --( evnt_qbr_ckam.completed_on between qtr.qtr_start_date and qtr.qtr_end_date )  -- DCN-662 use event start date instead of event completed on
                                 )
      WHERE qtr.qtr_start_date <= date_trunc( current_date(), month)
      ORDER BY 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: record_type {
    type: string
    sql: ${TABLE}.record_type ;;
  }

  dimension: calendar_quarter {
    type: string
    sql: ${TABLE}.Calendar_Quarter ;;
  }

  dimension: calendar_year {
    type: string
    sql: ${TABLE}.Calendar_Year ;;
  }

  dimension: quarter_selection {
    type: string
    sql: ${TABLE}.quarter_selection ;;
  }

  dimension: sales_person {
    type: string
    sql: ${TABLE}.sales_person ;;
  }

  dimension: ckam_full_name {
    label: "C-KAM"
    type: string
    sql: ${TABLE}.ckam_full_name ;;
  }

  dimension: cust_grp_nm {
    label: "Customer Group"
    type: string
    sql: ${TABLE}.cust_grp_nm ;;
  }

  dimension: cust_grp_id {
    label: "Customer Group Code"
    type: string
    sql: ${TABLE}.cust_grp_id ;;
  }

  dimension: cust_grp_oneforce_id {
    type: string
    sql: ${TABLE}.cust_grp_oneforce_id ;;
  }

  dimension: svc_rfa_oneforce_id {
    type: string
    sql: ${TABLE}.svc_rfa_oneforce_id ;;
  }

  dimension: contract_country_name {
    label: "CKAM Contract Country"
    type: string
    sql: ${TABLE}.contract_country_name ;;
  }

  dimension: contract_country {
    label: "CKAM Contract Code"
    type: string
    sql: ${TABLE}.contract_country ;;
  }

  dimension: subject {
    label: "Event Subject"
    type: string
    sql: ${TABLE}.subject ;;
    html:
      {% if value == 'Missed' %}
        <p>{{rendered_value}}</p>
      {% else %}
        <p><a href="https://one-line.lightning.force.com/lightning/r/Event/{{ qbr_monitor.oneforce_id._value }}/view" target="_blank">{{rendered_value}}</a></p>
      {% endif %}
    ;;
  }

  #dimension_group: startdatetime {
  #  label: "Event Date"
  #  type: time
  #  datatype: datetime
  #  sql: ${TABLE}.startdatetime ;;
  #}

  dimension: startdatetime {
    label: "Event Start Date"
    type: date
    datatype: datetime
    sql: ${TABLE}.startdatetime ;;
  }

  dimension: completed_on {
    label: "Event Completed On"
    type: date
    datatype: date
    sql: ${TABLE}.completed_on ;;
  }

  dimension: oneforce_id {
    type: string
    sql: ${TABLE}.oneforce_id ;;
  }

  dimension: is_missed {
    type: string
    sql: ${TABLE}.is_missed ;;
  }

  dimension: is_fulfilled {
    type: string
    sql: ${TABLE}.is_fulfilled ;;
  }

  dimension: qbr_not_fulfilled {
    type: string
    sql: ${TABLE}.qbr_not_fulfilled ;;
  }

  dimension: qbr_fulfilled {
    type: string
    sql: ${TABLE}.qbr_fulfilled ;;
  }

  measure: qbr_not_fulfilled_count {
    type: count_distinct
    label: "Not fulfilled (CKAM-QBR)"
    sql: ${TABLE}.qbr_not_fulfilled ;;
    filters: [qbr_not_fulfilled: "-NULL"]
    #drill_fields: [qbr_monitor.cust_grp_nm,qbr_monitor.calendar_quarter,qbr_monitor.ckam_full_name,of_svc_contract.sc_rfa_no,qbr_monitor.contract_country_name,qbr_monitor.subject,qbr_monitor.startdatetime]
    drill_fields: [qbr_monitor.cust_grp_nm,qbr_monitor.cust_grp_id,qbr_monitor.calendar_quarter,qbr_monitor.ckam_full_name,of_user.office_code_number,of_user_mgr.full_name,qbr_monitor.contract_country_name,qbr_monitor.subject,qbr_monitor.startdatetime]
  }

  measure: qbr_fulfilled_count {
    type: count_distinct
    label: "Fulfilled (CKAM-QBR)"
    sql: ${TABLE}.qbr_fulfilled ;;
    filters: [qbr_fulfilled: "-NULL"]
    #drill_fields: [qbr_monitor.cust_grp_nm,qbr_monitor.calendar_quarter,qbr_monitor.ckam_full_name,of_svc_contract.sc_rfa_no,qbr_monitor.contract_country_name,qbr_monitor.subject,qbr_monitor.startdatetime]
    drill_fields: [qbr_monitor.cust_grp_nm,qbr_monitor.cust_grp_id,qbr_monitor.calendar_quarter,qbr_monitor.ckam_full_name,of_user.office_code_number,of_user_mgr.full_name,qbr_monitor.contract_country_name,qbr_monitor.subject,qbr_monitor.startdatetime]
  }

  measure: qbr_not_fulfilled_count1 {
    type: count_distinct
    label: "Not fulfilled (CKAM-QBR)"
    sql: ${TABLE}.qbr_not_fulfilled ;;
    filters: [qbr_not_fulfilled: "-NULL"]
    #drill_fields: [qbr_monitor.cust_grp_nm,qbr_monitor.calendar_quarter,qbr_monitor.ckam_full_name,of_svc_contract.sc_rfa_no,qbr_monitor.contract_country_name,qbr_monitor.subject,qbr_monitor.startdatetime]
    drill_fields: [qbr_monitor.cust_grp_nm,qbr_monitor.cust_grp_id,qbr_monitor.calendar_quarter,qbr_monitor.ckam_full_name,of_user.office_code_number,of_user_mgr.full_name,qbr_monitor.contract_country_name,qbr_monitor.subject,qbr_monitor.startdatetime]
  }

  measure: qbr_fulfilled_count1 {
    type: count_distinct
    label: "Fulfilled (CKAM-QBR)"
    sql: ${TABLE}.qbr_fulfilled ;;
    filters: [qbr_fulfilled: "-NULL"]
    #drill_fields: [qbr_monitor.cust_grp_nm,qbr_monitor.calendar_quarter,qbr_monitor.ckam_full_name,of_svc_contract.sc_rfa_no,qbr_monitor.contract_country_name,qbr_monitor.subject,qbr_monitor.startdatetime]
    drill_fields: [qbr_monitor.cust_grp_nm,qbr_monitor.calendar_quarter,qbr_monitor.ckam_full_name,of_user.office_code_number,of_user_mgr.full_name,qbr_monitor.contract_country_name,qbr_monitor.subject,qbr_monitor.startdatetime]
  }

  #DCN-662 start
  measure: qbr_not_fulfilled_count_tile_by_ckam {
    type: count_distinct
    sql: 1 ;;
    drill_fields: [qbr_monitor.ckam_full_name,qbr_not_fulfilled_count,qbr_fulfilled_count,qbr_fulfilled_percentage_tile]
    hidden: yes
  }

  measure: qbr_fulfilled_count_tile_by_ckam {
    type: count_distinct
    sql: 1 ;;
    drill_fields: [qbr_monitor.ckam_full_name,qbr_fulfilled_count,qbr_not_fulfilled_count,qbr_fulfilled_percentage_tile]
    hidden: yes
  }

  measure: qbr_fulfilled_percentage_tile_by_ckam {
    type: count_distinct
    sql: 1 ;;
    drill_fields: [qbr_monitor.ckam_full_name,qbr_fulfilled_percentage_tile,qbr_fulfilled_count,qbr_not_fulfilled_count]
    hidden: yes
  }

  measure: qbr_not_fulfilled_count_tile_by_custgrp {
    type: count_distinct
    sql: 1 ;;
    drill_fields: [qbr_monitor.cust_grp_nm,qbr_monitor.cust_grp_id,qbr_not_fulfilled_count,qbr_fulfilled_count,qbr_fulfilled_percentage_tile]
    hidden: yes
  }

  measure: qbr_fulfilled_count_tile_by_custgrp {
    type: count_distinct
    sql: 1 ;;
    drill_fields: [qbr_monitor.cust_grp_nm,qbr_monitor.cust_grp_id,qbr_fulfilled_count,qbr_not_fulfilled_count,qbr_fulfilled_percentage_tile]
    hidden: yes
  }

  measure: qbr_fulfilled_percentage_tile_by_custgrp {
    type: count_distinct
    sql: 1 ;;
    drill_fields: [qbr_monitor.cust_grp_nm,qbr_monitor.cust_grp_id,qbr_fulfilled_percentage_tile,qbr_fulfilled_count,qbr_not_fulfilled_count]
    hidden: yes
  }

  measure: qbr_fulfilled_percentage_tile {
    type: number
    label: "Fulfillment % (CKAM-QBR)"
    sql: ${qbr_fulfilled_count} / NULLIF( ( ${qbr_fulfilled_count} + ${qbr_not_fulfilled_count} ), 0 );;
    value_format_name: percent_0
    link: {
      label: "By CKAM"
      url: "{{ qbr_fulfilled_percentage_tile_by_ckam._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ qbr_fulfilled_percentage_tile_by_custgrp._link }}"
    }
  }

  measure: qbr_not_fulfilled_count_tile {
    type: count_distinct
    label: "Not fulfilled (CKAM-QBR) - Tile"
    sql: ${TABLE}.qbr_not_fulfilled ;;
    link: {
      label: "By CKAM"
      url: "{{ qbr_not_fulfilled_count_tile_by_ckam._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ qbr_not_fulfilled_count_tile_by_custgrp._link }}"
    }
  }

  measure: qbr_fulfilled_count_tile {
    type: count_distinct
    label: "Fulfilled (CKAM-QBR) - Tile"
    sql: ${TABLE}.qbr_fulfilled ;;
    link: {
      label: "By CKAM"
      url: "{{ qbr_fulfilled_count_tile_by_ckam._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ qbr_fulfilled_count_tile_by_custgrp._link }}"
    }
  }



  #DCN-662 end

  set: detail {
    fields: [
      record_type,
      calendar_quarter,
      calendar_year,
      quarter_selection,
      sales_person,
      cust_grp_nm,
      cust_grp_id,
      subject,
      startdatetime,
      oneforce_id
    ]
  }

}
#######################################
view: mpr_monitor {
  derived_table: {
    sql: WITH
      month_master as (
        SELECT
          Calendar_Month
        , left(Calendar_Quarter,4)||'Q'||right(Calendar_Quarter,1) as Calendar_Quarter
        , Calendar_Year
        , qtr_start_date, qtr_end_date
        , mth_start_date, mth_end_date
        , CASE WHEN current_date() between qtr_start_date and qtr_end_date THEN 'Current Quater'
               WHEN date_sub( date_trunc( current_date(), month) , interval  3 month ) between qtr_start_date and qtr_end_date THEN 'Last Quater'
               ELSE NULL END as quarter_selection
        FROM ( SELECT
               Sales_Month as Calendar_Month
              ,Calendar_Quarter
              ,Calendar_Year
              ,parse_date('%Y%m', Sales_Month ) mth_start_date
              ,date_sub( date_add( parse_date('%Y%m', Sales_Month ),interval 1 month), interval 1 day)  mth_end_date
              ,parse_date('%Y%m', min(Sales_Month) over (partition by Calendar_Quarter) ) qtr_start_date
              ,date_sub( date_add( parse_date('%Y%m', max(Sales_Month) over (partition by Calendar_Quarter) ),interval 1 month), interval 1 day)  qtr_end_date
              FROM `ONEFORCE.OF_SALES_WEEK_MASTER` w
              GROUP BY 1, 2, 3 ) X
        ORDER BY 1
      ),
      ckam as (
        SELECT
        mbr.sales_person ,
        usr.FirstName || ' '|| usr.LastName as full_name,
        mbr.customer_group,
        --mbr.contract_country,
        ckam_ctry.contract_country_code as contract_country,
        c.country_name as contract_country_name,
        mbr.SVC_RFA_Number,
        date_trunc(mbr.CreatedDate, day) as createddate,
        g.cust_grp_id,
        g.cust_grp_nm
        FROM `ONEFORCE.OF_SALES_TEAM_MEMBER` mbr
        INNER JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g on (mbr.customer_group = g.ONEForce_Id ) and g.delt_flg = 'N'
        INNER JOIN ${of_sales_team_member_contract_country.SQL_TABLE_NAME} as ckam_ctry on (mbr.oneforce_id = ckam_ctry.oneforce_id )
        --LEFT JOIN `ONEFORCE.OF_COUNTRY`         c on (mbr.contract_country = c.country_code )
        LEFT JOIN `ONEFORCE.OF_COUNTRY`         c on (ckam_ctry.contract_country_code = c.country_code )
        LEFT JOIN ${of_user.SQL_TABLE_NAME}     usr on (mbr.sales_person = usr.oneforce_id )
        WHERE mbr.team_role = 'Contract Key Account Manager (C-KAM)' and mbr.sales_person is not null and mbr.inactive = 'false' and ckam_ctry.contract_country_code is not null
      ),
      skam as (
        SELECT
        mbr.sales_person ,
        usr.FirstName || ' '|| usr.LastName as full_name,
        mbr.customer_group,
        --mbr.service_country,
        skam_ctry.service_country_code as service_country,
        c.country_name as service_country_name,
        mbr.SVC_RFA_Number,
        date_trunc(mbr.CreatedDate, day) as createddate,
        g.cust_grp_id,
        g.cust_grp_nm
        FROM `ONEFORCE.OF_SALES_TEAM_MEMBER` mbr
        INNER JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g   on (mbr.customer_group = g.ONEForce_Id ) and g.delt_flg = 'N'
        INNER JOIN ${of_sales_team_member_service_country.SQL_TABLE_NAME} as skam_ctry on (mbr.oneforce_id = skam_ctry.oneforce_id )
        --LEFT JOIN  `ONEFORCE.OF_COUNTRY`        c   on (mbr.service_country = c.country_code )
        LEFT JOIN  `ONEFORCE.OF_COUNTRY`        c   on (skam_ctry.service_country_code = c.country_code )
        LEFT JOIN ${of_user.SQL_TABLE_NAME}     usr on (mbr.sales_person = usr.oneforce_id )
        WHERE mbr.team_role = 'Service Key Account Manager (S-KAM)' and mbr.sales_person is not null and mbr.inactive = 'false' and skam_ctry.service_country_code is not null
      ),
      evnt_mpr_ckam as (
      SELECT e.*,
             (CASE e.Event_Category WHEN 'Monthly Performance Review' THEN 'MPR:'
                                    WHEN 'Quarterly Business Review'  THEN 'QBR:'
                                    ELSE NULL END ) as pfx,
             (CASE WHEN g.oneforce_id is not null then g.ONEForce_Id else e.WhatId end ) as cust_grp_oneforce_id
       FROM `ONEFORCE.OF_EVENT` e
       LEFT JOIN `ONEFORCE.V_CUSTOMER_OPUS_N_PROSPECT` c on (e.WhatId = c.ONEForce_Id)
       LEFT JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g          on (c.cust_grp_id = g.cust_grp_id)
       WHERE e.Event_Category in (  'Monthly Performance Review' , 'Quarterly Business Review' )
       AND   e.Event_Status = 'Completed'
       AND   EXISTS(SELECT 1 FROM `ONEFORCE.OF_SALES_TEAM_MEMBER` mbr
                    WHERE  mbr.team_role = 'Contract Key Account Manager (C-KAM)'
                    AND    e.ownerid     = mbr.sales_person  )
      ),
      evnt_mpr_skam as (
      SELECT e.*,
             (CASE WHEN g.oneforce_id is not null then g.ONEForce_Id else e.WhatId end ) as cust_grp_oneforce_id
       FROM `ONEFORCE.OF_EVENT` e
       LEFT JOIN `ONEFORCE.V_CUSTOMER_OPUS_N_PROSPECT` c on (e.WhatId = c.ONEForce_Id)
       LEFT JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g          on (c.cust_grp_id = g.cust_grp_id)
       WHERE e.Event_Category in ( 'Monthly Performance Review'  )
       AND   e.Event_Status = 'Completed'
       AND   EXISTS(SELECT 1 FROM `ONEFORCE.OF_SALES_TEAM_MEMBER` mbr
                    WHERE  mbr.team_role = 'Service Key Account Manager (S-KAM)'
                    AND    e.ownerid     = mbr.sales_person  )
      )
      SELECT 'CKAM-MPR' as record_type,
             mth.Calendar_Month, mth.Calendar_Quarter, mth.Calendar_Year, mth.quarter_selection,
             ckam.sales_person,
             ckam.full_name as kam_full_name,
             ckam.full_name as kam_full_name2,
             ckam.cust_grp_nm, ckam.customer_group as cust_grp_oneforce_id, ckam.SVC_RFA_Number as svc_rfa_oneforce_id,
             ckam.cust_grp_id, -- DCN-1013
             ckam.contract_country_name as kam_country_name,
             ckam.contract_country_name as kam_country_name2,
             ckam.contract_country as kam_country,
             (case when evnt_mpr_ckam.oneforce_id is null then 'Missed' else evnt_mpr_ckam.pfx||evnt_mpr_ckam.subject end) as subject, evnt_mpr_ckam.startdatetime , evnt_mpr_ckam.completed_on , evnt_mpr_ckam.oneforce_id,
             (case when evnt_mpr_ckam.oneforce_id is null then 'Yes' else 'No' end) is_missed,
             (case when evnt_mpr_ckam.oneforce_id is null then 'No' else 'Yes' end) is_fulfilled,
             (case when evnt_mpr_ckam.oneforce_id is null     then mth.Calendar_Month||'-'||ckam.sales_person||'-'||ckam.cust_grp_id||'-'||ckam.contract_country else NULL end) mpr_not_fulfilled,
             (case when evnt_mpr_ckam.oneforce_id is not null then mth.Calendar_Month||'-'||ckam.sales_person||'-'||ckam.cust_grp_id||'-'||ckam.contract_country else NULL end) mpr_fulfilled
      FROM month_master as mth
      LEFT JOIN ckam     on (ckam.createddate <= mth.mth_end_date)
      LEFT JOIN evnt_mpr_ckam on ( ckam.sales_person     = evnt_mpr_ckam.ownerid and
                                   -- ckam.contract_country = evnt_mpr_ckam.country and -DCN-1061
                                   ckam.customer_group   = evnt_mpr_ckam.cust_grp_oneforce_id and
                                   (date_trunc( evnt_mpr_ckam.startdatetime, day ) between mth.mth_start_date and mth.mth_end_date)
                                   --( evnt_mpr_ckam.completed_on between mth.mth_start_date and mth.mth_end_date)  -- DCN-662 use event start date instead of event completed on
                                 )
      WHERE mth.mth_start_date <= date_trunc( current_date(), month)
      --and mth.Calendar_Month  between '202201' and '202206' --and evnt_mpr_ckam.oneforce_id is not null and 1=2
      -----------------
      UNION ALL
      -----------------
      SELECT 'SKAM-MPR' as record_type,
             mth.Calendar_Month, mth.Calendar_Quarter, mth.Calendar_Year, mth.quarter_selection,
             skam.sales_person,
             skam.full_name as kam_full_name,
             skam.full_name as kam_full_name2,
             skam.cust_grp_nm, skam.customer_group as cust_grp_oneforce_id, skam.SVC_RFA_Number as svc_rfa_oneforce_id,
             skam.cust_grp_id, --DCN-1013
             skam.service_country_name as kam_country_name,
             skam.service_country_name as kam_country_name2,
             skam.service_country as kam_country,
             (case when evnt_mpr_skam.oneforce_id is null then 'Missed' else 'MPR:'||evnt_mpr_skam.subject end) as subject, evnt_mpr_skam.startdatetime , evnt_mpr_skam.completed_on , evnt_mpr_skam.oneforce_id,
             (case when evnt_mpr_skam.oneforce_id is null then 'Yes' else 'No' end) is_missed,
             (case when evnt_mpr_skam.oneforce_id is null then 'No' else 'Yes' end) is_fulfilled,
             (case when evnt_mpr_skam.oneforce_id is null     then mth.Calendar_Month||'-'||skam.sales_person||'-'||skam.cust_grp_id||'-'||skam.service_country else NULL end) mpr_not_fulfilled,
             (case when evnt_mpr_skam.oneforce_id is not null then mth.Calendar_Month||'-'||skam.sales_person||'-'||skam.cust_grp_id||'-'||skam.service_country else NULL end) mpr_fulfilled
      FROM month_master as mth
      LEFT JOIN skam     on (skam.createddate <= mth.mth_end_date)
      LEFT JOIN evnt_mpr_skam on ( skam.sales_person     = evnt_mpr_skam.ownerid and
                                   -- skam.service_country  = evnt_mpr_skam.country and --DCN-1061
                                   skam.customer_group   = evnt_mpr_skam.cust_grp_oneforce_id and
                                   ( date_trunc( evnt_mpr_skam.startdatetime, day ) between mth.mth_start_date and mth.mth_end_date)
                                   --( evnt_mpr_skam.completed_on between mth.mth_start_date and mth.mth_end_date) -- DCN-662 use event start date instead of event completed on
                                 )
      WHERE mth.mth_start_date <= date_trunc( current_date(), month)
      --and mth.Calendar_Month  between '202201' and '202206' --and evnt_mpr_ckam.oneforce_id is not null and 1=2
      ORDER BY 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: record_type {
    type: string
    sql: ${TABLE}.record_type ;;
  }

  dimension: calendar_month {
    type: string
    sql: ${TABLE}.Calendar_Month ;;
  }

  dimension: calendar_quarter {
    type: string
    sql: ${TABLE}.Calendar_Quarter ;;
  }

  dimension: calendar_year {
    type: string
    sql: ${TABLE}.Calendar_Year ;;
  }

  dimension: quarter_selection {
    type: string
    sql: ${TABLE}.quarter_selection ;;
  }

  dimension: sales_person {
    type: string
    sql: ${TABLE}.sales_person ;;
  }

  dimension: kam_full_name {
    label: "C-KAM"
    type: string
    sql: ${TABLE}.kam_full_name ;;
  }

  dimension: kam_full_name2 {
    label: "S-KAM"
    type: string
    sql: ${TABLE}.kam_full_name2 ;;
  }

  dimension: cust_grp_nm {
    label: "Customer Group"
    type: string
    sql: ${TABLE}.cust_grp_nm ;;
  }

  dimension: cust_grp_id {
    label: "Customer Group Code"
    type: string
    sql: ${TABLE}.cust_grp_id ;;
  }

  dimension: cust_grp_oneforce_id {
    type: string
    sql: ${TABLE}.cust_grp_oneforce_id ;;
  }

  dimension: svc_rfa_oneforce_id {
    type: string
    sql: ${TABLE}.svc_rfa_oneforce_id ;;
  }

  dimension: kam_country_name {
    label: "C-KAM Contract Country"
    type: string
    sql: ${TABLE}.kam_country_name ;;
  }

  dimension: kam_country_name2 {
    label: "S-KAM Service Country"
    type: string
    sql: ${TABLE}.kam_country_name2 ;;
  }

  dimension: kam_country {
    label: "KAM Country Code"
    type: string
    sql: ${TABLE}.kam_country ;;
  }

  dimension: subject {
    label: "Event Subject"
    type: string
    sql: ${TABLE}.subject ;;
    html:
      {% if value == 'Missed' %}
        <p>{{rendered_value}}</p>
      {% else %}
        <p><a href="https://one-line.lightning.force.com/lightning/r/Event/{{ mpr_monitor.oneforce_id._value }}/view" target="_blank">{{rendered_value}}</a></p>
      {% endif %}
    ;;

  }

  #dimension_group: startdatetime {
  #  label: "Event Date"
  #  type: time
  #  datatype: datetime
  #  sql: ${TABLE}.startdatetime ;;
  #}

  dimension: startdatetime {
    label: "Event Start Date"
    type: date
    datatype: datetime
    sql: ${TABLE}.startdatetime ;;
  }

  dimension: completed_on {
    label: "Event Completed On"
    type: date
    datatype: date
    sql: ${TABLE}.completed_on ;;
  }

  dimension: oneforce_id {
    label: "Event ONEForce Id"
    type: string
    sql: ${TABLE}.oneforce_id ;;
  }

  dimension: is_missed {
    type: string
    sql: ${TABLE}.is_missed ;;
  }

  dimension: is_fulfilled {
    type: string
    sql: ${TABLE}.is_fulfilled ;;
  }

  dimension: mpr_not_fulfilled {
    type: string
    sql: ${TABLE}.mpr_not_fulfilled ;;
  }

  dimension: mpr_fulfilled {
    type: string
    sql: ${TABLE}.mpr_fulfilled ;;
  }

  #DCN-662 start
  measure: mpr_fulfilled_count_tile_by_ckam {
    type: number
    sql: 1;;
    drill_fields: [mpr_monitor.kam_full_name,mpr_monitor.mpr_fulfilled_count,mpr_monitor.mpr_not_fulfilled_count, mpr_fulfilled_percentage_tile]
    hidden: yes
  }

  measure: mpr_not_fulfilled_count_tile_by_ckam {
    type: number
    sql: 1;;
    drill_fields: [mpr_monitor.kam_full_name,mpr_monitor.mpr_not_fulfilled_count,mpr_monitor.mpr_fulfilled_count, mpr_fulfilled_percentage_tile]
    hidden: yes
  }

  measure: mpr_fulfilled_percentage_tile_by_ckam {
    type: number
    sql: 1;;
    drill_fields: [mpr_monitor.kam_full_name,mpr_fulfilled_percentage_tile,mpr_monitor.mpr_fulfilled_count,mpr_monitor.mpr_not_fulfilled_count]
    hidden: yes
  }

  measure: mpr_fulfilled_count_tile_by_skam {
    type: number
    sql: 1;;
    drill_fields: [mpr_monitor.kam_full_name2,mpr_monitor.mpr_fulfilled_count2,mpr_monitor.mpr_not_fulfilled_count2, mpr_fulfilled_percentage_tile2]
    hidden: yes
  }

  measure: mpr_not_fulfilled_count_tile_by_skam {
    type: number
    sql: 1;;
    drill_fields: [mpr_monitor.kam_full_name2,mpr_monitor.mpr_not_fulfilled_count2,mpr_monitor.mpr_fulfilled_count2, mpr_fulfilled_percentage_tile2]
    hidden: yes
  }

  measure: mpr_fulfilled_percentage_tile_by_skam {
    type: number
    sql: 1;;
    drill_fields: [mpr_monitor.kam_full_name2,mpr_fulfilled_percentage_tile2,mpr_monitor.mpr_fulfilled_count2,mpr_monitor.mpr_not_fulfilled_count2]
    hidden: yes
  }

  measure: mpr_fulfilled_count_tile_by_custgrp {
    type: number
    sql: 1;;
    drill_fields: [mpr_monitor.cust_grp_nm,mpr_monitor.cust_grp_id, mpr_monitor.mpr_fulfilled_count,mpr_monitor.mpr_not_fulfilled_count, mpr_fulfilled_percentage_tile]
    hidden: yes
  }

  measure: mpr_not_fulfilled_count_tile_by_custgrp {
    type: number
    sql: 1;;
    drill_fields: [mpr_monitor.cust_grp_nm,mpr_monitor.cust_grp_id,mpr_monitor.mpr_not_fulfilled_count,mpr_monitor.mpr_fulfilled_count, mpr_fulfilled_percentage_tile]
    hidden: yes
  }

  measure: mpr_fulfilled_percentage_tile_by_custgrp {
    type: number
    sql: 1;;
    drill_fields: [mpr_monitor.cust_grp_nm,mpr_monitor.cust_grp_id,mpr_fulfilled_percentage_tile,mpr_monitor.mpr_fulfilled_count,mpr_monitor.mpr_not_fulfilled_count]
    hidden: yes
  }

  measure: mpr_fulfilled_count_tile_by_custgrp2 {
    type: number
    sql: 1;;
    drill_fields: [mpr_monitor.cust_grp_nm,mpr_monitor.cust_grp_id,mpr_monitor.mpr_fulfilled_count2,mpr_monitor.mpr_not_fulfilled_count2, mpr_fulfilled_percentage_tile2]
    hidden: yes
  }

  measure: mpr_not_fulfilled_count_tile_by_custgrp2 {
    type: number
    sql: 1;;
    drill_fields: [mpr_monitor.cust_grp_nm,mpr_monitor.cust_grp_id,mpr_monitor.mpr_fulfilled_count2,mpr_monitor.mpr_not_fulfilled_count2, mpr_fulfilled_percentage_tile2]
    hidden: yes
  }

  measure: mpr_fulfilled_percentage_tile_by_custgrp2 {
    type: number
    sql: 1;;
    drill_fields: [mpr_monitor.cust_grp_nm,mpr_monitor.cust_grp_id,mpr_fulfilled_percentage_tile2,mpr_monitor.mpr_fulfilled_count2,mpr_monitor.mpr_not_fulfilled_count2]
    hidden: yes
  }

  measure: mpr_not_fulfilled_count_tile {
    type: count_distinct
    label: "Not fulfilled (CKAM-MPR) - For Tile"
    sql: ${TABLE}.mpr_not_fulfilled ;;
    #filters: [mpr_not_fulfilled: "-NULL"]
    link: {
      label: "By CKAM"
      url: "{{ mpr_not_fulfilled_count_tile_by_ckam._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ mpr_not_fulfilled_count_tile_by_custgrp._link }}"
    }
  }

  measure: mpr_fulfilled_count_tile {
    type: count_distinct
    label: "Fulfilled (CKAM-MPR) - For Tile"
    sql: ${TABLE}.mpr_fulfilled ;;
    #filters: [mpr_fulfilled: "-NULL"]
    link: {
      label: "By CKAM"
      url: "{{ mpr_fulfilled_count_tile_by_ckam._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ mpr_fulfilled_count_tile_by_custgrp._link }}"
    }
  }

  measure: mpr_fulfilled_percentage_tile {
    type: number
    label: "Fulfillment % (CKAM-MPR)"
    sql: ${mpr_fulfilled_count} / NULLIF( ( ${mpr_fulfilled_count} + ${mpr_not_fulfilled_count} ), 0 );;
    value_format_name: percent_0
    link: {
      label: "By CKAM"
      url: "{{ mpr_fulfilled_percentage_tile_by_ckam._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ mpr_fulfilled_percentage_tile_by_custgrp._link }}"
    }
  }


  measure: mpr_not_fulfilled_count_tile2 {
    type: count_distinct
    label: "Not fulfilled (SKAM-MPR) - For Tile"
    sql: ${TABLE}.mpr_not_fulfilled ;;
    #filters: [mpr_not_fulfilled: "-NULL"]
    link: {
      label: "By SKAM"
      url: "{{ mpr_not_fulfilled_count_tile_by_skam._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ mpr_not_fulfilled_count_tile_by_custgrp2._link }}"
    }
  }

  measure: mpr_fulfilled_count_tile2 {
    type: count_distinct
    label: "Fulfilled (SKAM-MPR) - For Tile"
    sql: ${TABLE}.mpr_fulfilled ;;
    #filters: [mpr_fulfilled: "-NULL"]
    link: {
      label: "By SKAM"
      url: "{{ mpr_fulfilled_count_tile_by_skam._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ mpr_fulfilled_count_tile_by_custgrp2._link }}"
    }
  }

  measure: mpr_fulfilled_percentage_tile2 {
    type: number
    label: "Fulfillment % (SKAM-MPR)"
    sql: ${mpr_fulfilled_count2} / NULLIF( ( ${mpr_fulfilled_count2} + ${mpr_not_fulfilled_count2} ), 0 );;
    value_format_name: percent_0
    link: {
      label: "By SKAM"
      url: "{{ mpr_fulfilled_percentage_tile_by_skam._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ mpr_fulfilled_percentage_tile_by_custgrp2._link }}"
    }
  }






  #DCN-662 end

  measure: mpr_not_fulfilled_count {
    type: count_distinct
    label: "Not fulfilled (CKAM-MPR)"
    sql: ${TABLE}.mpr_not_fulfilled ;;
    filters: [mpr_not_fulfilled: "-NULL"]
    #drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.calendar_month,mpr_monitor.kam_full_name,of_svc_contract.sc_rfa_no,mpr_monitor.kam_country_name,mpr_monitor.subject,mpr_monitor.startdatetime]
    drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.cust_grp_id,mpr_monitor.calendar_month,mpr_monitor.kam_full_name,of_user.office_code_number,of_user_mgr.full_name,mpr_monitor.kam_country_name,mpr_monitor.subject,mpr_monitor.startdatetime]
  }

  measure: mpr_fulfilled_count {
    type: count_distinct
    label: "Fulfilled (CKAM-MPR)"
    sql: ${TABLE}.mpr_fulfilled ;;
    filters: [mpr_fulfilled: "-NULL"]
    #drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.calendar_month,mpr_monitor.kam_full_name,of_svc_contract.sc_rfa_no,mpr_monitor.kam_country_name,mpr_monitor.subject,mpr_monitor.startdatetime]
    drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.cust_grp_id,mpr_monitor.calendar_month,mpr_monitor.kam_full_name,of_user.office_code_number,of_user_mgr.full_name,mpr_monitor.kam_country_name,mpr_monitor.subject,mpr_monitor.startdatetime]
  }

  measure: mpr_not_fulfilled_count2 {
    type: count_distinct
    label: "Not fulfilled (SKAM-MPR)"
    sql: ${TABLE}.mpr_not_fulfilled ;;
    filters: [mpr_not_fulfilled: "-NULL"]
    #drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.calendar_month,mpr_monitor.kam_full_name2,of_svc_contract.sc_rfa_no,mpr_monitor.kam_country_name2,mpr_monitor.subject,mpr_monitor.startdatetime]
    drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.cust_grp_id,mpr_monitor.calendar_month,mpr_monitor.kam_full_name2,of_user.office_code_number,of_user_mgr.full_name,mpr_monitor.kam_country_name2,mpr_monitor.subject,mpr_monitor.startdatetime]
  }

  measure: mpr_fulfilled_count2 {
    type: count_distinct
    label: "Fulfilled (SKAM-MPR)"
    sql: ${TABLE}.mpr_fulfilled ;;
    filters: [mpr_fulfilled: "-NULL"]
    #drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.calendar_month,mpr_monitor.kam_full_name2,of_svc_contract.sc_rfa_no,mpr_monitor.kam_country_name2,mpr_monitor.subject,mpr_monitor.startdatetime]
    drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.cust_grp_id,mpr_monitor.calendar_month,mpr_monitor.kam_full_name2,of_user.office_code_number,of_user_mgr.full_name,mpr_monitor.kam_country_name2,mpr_monitor.subject,mpr_monitor.startdatetime]
  }

  # Sales Process Landing Page ----- Start -------
  measure: mpr_fulfilled_count1 {
    type: count_distinct
    label: "Fulfilled (CKAM-MPR)"
    sql: ${TABLE}.mpr_fulfilled ;;
    filters: [mpr_fulfilled: "-NULL",record_type: "CKAM-MPR"]
    #drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.calendar_month,mpr_monitor.kam_full_name,of_svc_contract.sc_rfa_no,mpr_monitor.kam_country_name,mpr_monitor.subject,mpr_monitor.startdatetime]
    drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.cust_grp_id,mpr_monitor.calendar_month,mpr_monitor.kam_full_name,of_user.office_code_number,of_user_mgr.full_name,mpr_monitor.kam_country_name,mpr_monitor.subject,mpr_monitor.startdatetime]
  }

  measure: mpr_fulfilled_count3 {
    type: count_distinct
    label: "Fulfilled (SKAM-MPR)"
    sql: ${TABLE}.mpr_fulfilled ;;
    filters: [mpr_fulfilled: "-NULL",record_type: "SKAM-MPR"]
    #drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.calendar_month,mpr_monitor.kam_full_name,of_svc_contract.sc_rfa_no,mpr_monitor.kam_country_name,mpr_monitor.subject,mpr_monitor.startdatetime]
    drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.cust_grp_id,mpr_monitor.calendar_month,mpr_monitor.kam_full_name,of_user.office_code_number,of_user_mgr.full_name,mpr_monitor.kam_country_name,mpr_monitor.subject,mpr_monitor.startdatetime]
  }

  measure: mpr_not_fulfilled_count3 {
    type: count_distinct
    label: "Not fulfilled (CKAM-MPR)"
    sql: ${TABLE}.mpr_not_fulfilled ;;
    filters: [mpr_not_fulfilled: "-NULL",record_type: "CKAM-MPR"]
    #drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.calendar_month,mpr_monitor.kam_full_name2,of_svc_contract.sc_rfa_no,mpr_monitor.kam_country_name2,mpr_monitor.subject,mpr_monitor.startdatetime]
    drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.cust_grp_id,mpr_monitor.calendar_month,mpr_monitor.kam_full_name2,of_user.office_code_number,of_user_mgr.full_name,mpr_monitor.kam_country_name2,mpr_monitor.subject,mpr_monitor.startdatetime]
  }

  measure: mpr_not_fulfilled_count4 {
    type: count_distinct
    label: "Not fulfilled (SKAM-MPR)"
    sql: ${TABLE}.mpr_not_fulfilled ;;
    filters: [mpr_not_fulfilled: "-NULL",record_type: "SKAM-MPR"]
    #drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.calendar_month,mpr_monitor.kam_full_name2,of_svc_contract.sc_rfa_no,mpr_monitor.kam_country_name2,mpr_monitor.subject,mpr_monitor.startdatetime]
    drill_fields: [mpr_monitor.cust_grp_nm ,mpr_monitor.cust_grp_id,mpr_monitor.calendar_month,mpr_monitor.kam_full_name2,of_user.office_code_number,of_user_mgr.full_name,mpr_monitor.kam_country_name2,mpr_monitor.subject,mpr_monitor.startdatetime]
  }
  # Sales Process Landing Page ----- End -------

  set: detail {
    fields: [
      record_type,
      calendar_month,
      calendar_quarter,
      calendar_year,
      quarter_selection,
      sales_person,
      cust_grp_nm,
      cust_grp_id,
      subject,
      startdatetime,
      oneforce_id
    ]
  }

}

# include: "of_user.view"
view: mpr_qbr_monitor_of_user {
  extends: [of_user]

  dimension: office_Country_Code {
    view_label: "User"
    label: "Country"
    drill_fields: [office_code_number]
  }

  dimension: office_code_number {
    view_label: "User"
    label: "Office Code"
  }

  dimension: regional_head_office_short_nm {
    label: "Region"
    view_label: "User"
    drill_fields: [office_Country_Code, office_code_number]
  }


}

#DCN-662 : start
view: mpr_qbr_monitor_of_user_mgr {
  extends: [of_user]

  dimension: office_Country_Code {
    view_label: "User's Manager"
    label: "Country"
    drill_fields: [office_code_number]
  }

  dimension: office_code_number {
    view_label: "User's Manager"
    label: "Office Code"
  }

  dimension: regional_head_office_short_nm {
    view_label: "User's Manager"
    label: "Region"
    drill_fields: [office_Country_Code, office_code_number]
  }

  dimension: full_name {
    label: "Manager"
  }
}

#DCN-662 : end

view: na_bkg_vs_budget_qry {
  derived_table: {
    sql:
    SELECT 'Budget' as Record_Type,
          u.ONEForce_ID as usr_id,
          c.us_sub_region as usr_sub_region, -- NA dashboard
          c.Service_Scope_Group,
          c.bound as bound,
          c.dom_non_dom as dominant_flg,
          CASE c.Service_Scope_Group||'|'||c.bound||'|'||c.dom_non_dom
               WHEN 'LN|S|N-DOM' THEN 'Latin'
               WHEN 'TP|E|DOM'   THEN 'TP Domi.'
               WHEN 'TP|W|N-DOM' THEN 'TP Non Domi.'
               WHEN 'TA|E|N-DOM' THEN 'TA Non Domi.'
               ELSE NULL END  as Trade,
          CAST(NULL as string) as slane_cd,
          c.Customer_Code as cust_cd,
          (CASE c.Type_ WHEN 'RFR' THEN 'Reefer' ELSE 'Dry' END) as cargo_type,
          m.Sales_Month,
          m.Sales_Week,
          d.monthly_target / ( count(distinct m.Sales_Week) over (partition by m.Sales_Month)) TEU ,
          d.Monthly_Target_CM_USD / ( count(distinct m.Sales_Week) over (partition by m.Sales_Month)) CM , -- NA dashboard new field
    FROM `ONEFORCE.OF_SALES_BUDGET_CAPTURE` c
    INNER JOIN `ONEFORCE.OF_SALES_BUDGET_CAPTURE_DTL` d ON (c.ONEForce_ID = d.Sales_Budget_Capture)
    INNER JOIN `ONEFORCE.OF_SALES_WEEK_MASTER` m ON (m.Sales_Month = CAST( EXTRACT(YEAR FROM d.Month_Year)*100 + EXTRACT(MONTH FROM d.Month_Year) AS STRING) )
    INNER JOIN `ONEFORCE.OF_USER` u ON (u.ONEForce_ID = c.Salesperson)
    --group by 1, 2 , 3, 4, 5, 6, 7, 8, 9, 10

      ----------------------------------------------
      UNION ALL
      ----------------------------------------------

      SELECT 'Booking' as Record_Type,
      u.ONEForce_ID as usr_id,
      --u.sub_region as usr_sub_region, -- NA dashboard
      u.sub_region as usr_sub_region, -- NA dashboard
      scp.Service_Scope_Group_Code,
      scp.bound_code as bound,
      CASE WHEN bkg.svc_scp_cd = 'LEA' AND n1st_pol_cd LIKE 'MX%' THEN 'N-DOM'
      WHEN bkg.svc_scp_cd = 'LEA' THEN 'DOM'
      WHEN bkg.svc_scp_cd = 'IAA' AND right(t_vvd_cd,1) IN ('S','W') THEN 'DOM'
      WHEN bkg.svc_scp_cd = 'IAA' THEN 'N-DOM'
      ELSE scp.dominant_flag
      END as dominant_flg       ,
      CASE WHEN bkg.svc_scp_cd IN ('LAS','LWS') THEN 'Latin'
      WHEN scp.Service_Scope_Group_Code||'|'||scp.Dominant_Flag = 'TP|DOM'   THEN 'TP Domi.'
      WHEN scp.Service_Scope_Group_Code||'|'||scp.Dominant_Flag = 'TP|N-DOM' THEN 'TP Non Domi.'
      WHEN scp.Service_Scope_Group_Code||'|'||scp.Dominant_Flag = 'TA|N-DOM' THEN 'TA Non Domi.'
      ELSE NULL END as Trade,
      substr(rlane_cd,1,3) as slane_cd,
      coalesce(sc.cust_cd, bkg.ctrt_cust_cd) as cust_cd,
      (CASE WHEN bkg.cntr_tpsz LIKE 'R%' AND bkg.rd_cgo_flg = 'N' THEN 'Reefer' ELSE 'Dry' END) as cargo_type,
      m.Sales_Month,
      m.Sales_Week,
      bkg.bkg_teu as TEU,
      CAST( (CASE WHEN scp.Service_Scope_Group_Code = 'TP'
      THEN cm_amt2 - (IFNULL(othercost.VIP_AMT_PER_TEU_USD,0) * (case when substr(bkg.cntr_tpsz,1,1)='Q' then 0 else bkg.bkg_teu end) )
      ELSE cm_amt1 - (IFNULL(othercost.VIP_AMT_PER_TEU_USD,0) * (case when substr(bkg.cntr_tpsz,1,1)='Q' then 0 else bkg.bkg_teu end) )
      END ) as numeric) as CM_AMT
      FROM `ONEFORCE.OF_BOOKING` bkg
      INNER JOIN `ONEFORCE.OF_SALES_WEEK_MASTER` m ON ( CAST(m.Sales_Week as INT64) = bkg.WEEK )
      LEFT JOIN `ONEFORCE.OF_SVC_CONTRACT` as sc ON (bkg.svc_cont_no = sc.sc_rfa_no)
      --LEFT JOIN `ONEFORCE.OF_SVC_CONTRACT_DTL` as sd ON (sc.sc_rfa_no = sd.sc_rfa_no AND bkg.svc_scp_cd = sd.svc_scp_cd) -- sundar suggested to use svc scp sales person, but later suspended this idea, due to much incomplete data in OF_SVC_CONTRACT_DTL
      --LEFT JOIN `ONEFORCE.OF_USER` AS u ON trim(lower(sd.SREP_EML)) = trim(lower((CASE WHEN u.TPA_user = 'true' THEN u.Email_2 ELSE u.Email END))) -- sundar suggested to use svc scp sales person
      LEFT JOIN `ONEFORCE.OF_USER` AS u ON trim(lower(sc.SREP_EML)) = trim(lower((CASE WHEN u.TPA_user = 'true' THEN u.Email_2 ELSE u.Email END)))
      LEFT JOIN `ONEFORCE.V_CUSTOMER_OPUS_N_PROSPECT` as cust ON ( cust.cust_cd = coalesce(sc.cust_cd, bkg.ctrt_cust_cd) )
      LEFT JOIN `ONEFORCE.OF_SVC_SCP` as scp ON (bkg.SVC_SCP_CD = scp.Service_Scope_Code)
      LEFT JOIN `ONEFORCE.UPLOAD_VIP_COST` as othercost
      ON ( othercost.rc_flg           = bkg.rc_flg           AND
      othercost.REV_PERIOD_YRQTR = bkg.rev_period_yrqtr AND
      othercost.CUST_GRP_ID      = cust.cust_grp_id AND
      othercost.SVC_GRP_CD       = scp.service_scope_group_code AND
      othercost.DMNT_FLG         = (CASE WHEN bkg.svc_scp_cd = 'LEA' AND bkg.n1st_pol_cd LIKE 'MX%' THEN 'N'
      WHEN bkg.svc_scp_cd = 'LEA' THEN 'Y'
      WHEN bkg.svc_scp_cd = 'IAA' AND right(bkg.t_vvd_cd,1) IN ('S','W') THEN 'Y'
      WHEN bkg.svc_scp_cd = 'IAA' THEN 'N'
      WHEN scp.dominant_flag = 'DOM' THEN 'Y'
      ELSE 'N' END)
      )
      WHERE bkg.bkg_sts_cd NOT IN ('X')
      --group by 1 , 2, 3, 4, 5
      ;;
  }

  parameter: measure_choice {
    type:  string
    label: "Choice of Measure"
    allowed_value: { value:"CM"  label:"CM" }
    allowed_value: { value:"TEU" label:"TEU" }
    default_value: "TEU"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: record_type {
    type: string
    sql: ${TABLE}.Record_Type ;;
  }

  dimension: usr_id {
    type: string
    sql: ${TABLE}.usr_id ;;
  }

  dimension: usr_sub_region {
    type: string
    sql: ${TABLE}.usr_sub_region ;;
  }

  dimension: bound {
    type: string
    sql: ${TABLE}.bound ;;
  }

  dimension: dominant_flg {
    type: string
    sql: ${TABLE}.dominant_flg ;;
  }


  dimension: trade_order {
    type: string
    sql: case ${TABLE}.trade
         when 'Latin' then 4
         when 'TA Non Domi.' then 3
         when 'TP Domi.' then 1
         when 'TP Non Domi.' then 2
         else 5 end ;;
  }

  dimension: trade {
    order_by_field: trade_order
    type: string
    sql: ${TABLE}.trade ;;
  }




  dimension: slane_cd {
    label: "Service Lane Code"
    type: string
    sql: ${TABLE}.slane_cd ;;
  }

  dimension: cargo_type {
    label: "Cargo Type"
    type: string
    sql: ${TABLE}.cargo_type ;;
  }

  dimension: cust_cd {
    type: string
    sql: ${TABLE}.cust_cd ;;
  }

  dimension: service_scope_group {
    type: string
    sql: ${TABLE}.Service_Scope_Group ;;
  }

  dimension: sales_week {
    type: string
    sql: ${TABLE}.Sales_Week ;;
  }

  measure: teu {
    type: sum
    sql: ${TABLE}.TEU ;;
  }

  measure: teu_booking {
    type: sum
    sql: ${TABLE}.TEU ;;
    filters: [record_type: "Booking"]
    #value_format_name: decimal_0
    value_format: "[>=10000000]#,##0,,\"M\" ; [>=10000]#,##0,\"K\" ; 0.00,\"K\" "
  }

  measure: teu_target {
    type: sum
    sql: ${TABLE}.TEU ;;
    filters: [record_type: "Budget"]
    #value_format_name: decimal_0
    value_format: "[>=10000000]#,##0,,\"M\" ; [>=10000]#,##0,\"K\" ; 0.00,\"K\" "
  }

  measure: teu_booking_raw {
    type: sum
    sql: ${TABLE}.TEU ;;
    filters: [record_type: "Booking"]
    value_format_name: decimal_0
  }

  measure: teu_target_raw {
    type: sum
    sql: ${TABLE}.TEU ;;
    filters: [record_type: "Budget"]
    value_format_name: decimal_0
  }

  measure: cm {
    type: sum
    sql: ${TABLE}.CM ;;
  }

  measure: cm_booking {
    type: sum
    sql: ${TABLE}.CM ;;
    filters: [record_type: "Booking"]
    #value_format_name: decimal_0
    value_format: "[>=10000000]$#,##0,,\"M\" ; [>=10000]$#,##0,\"K\" ; $0.00,\"K\" "
  }

  measure: cm_target {
    type: sum
    sql: ${TABLE}.CM ;;
    filters: [record_type: "Budget"]
    #value_format_name: decimal_0
    value_format: "[>=10000000]$#,##0,,\"M\" ; [>=10000]$#,##0,\"K\" ; $0.00,\"K\" "
  }

  measure: measure_for_target_chosen {
    type:  number
    label: "{% if    measure_choice._parameter_value ==  \"'CM'\"  %}Target (CM){%
    elsif measure_choice._parameter_value ==  \"'TEU'\" %}Target (TEU){%
    else  %}xxx{% endif %}"
    sql:  {% if    measure_choice._parameter_value == "'CM'"  %} ${cm_target}
          {% elsif measure_choice._parameter_value == "'TEU'" %} ${teu_target}
          {% else %} ${teu_target}
          {% endif %};;
    value_format: "[>=10000000]#,##0,,\"M\" ; [>=10000]#,##0,\"K\" ; 0.00,\"K\" "
  }

  measure: measure_for_booking_chosen {
    type:  number
    label: "{% if    measure_choice._parameter_value ==  \"'CM'\"  %}Actual (CM){%
    elsif measure_choice._parameter_value ==  \"'TEU'\" %}Actual (TEU){%
    else  %}xxx{% endif %}"
    sql:  {% if    measure_choice._parameter_value == "'CM'"  %} ${cm_booking}
          {% elsif measure_choice._parameter_value == "'TEU'" %} ${teu_booking}
          {% else %} ${teu_booking}
          {% endif %};;
    value_format: "[>=10000000]#,##0,,\"M\" ; [>=10000]#,##0,\"K\" ; 0.00,\"K\" "
  }

  measure: cm_booking_raw {
    type: sum
    sql: ${TABLE}.CM ;;
    filters: [record_type: "Booking"]
    value_format_name: usd_0
  }

  measure: cm_target_raw {
    type: sum
    sql: ${TABLE}.CM ;;
    filters: [record_type: "Budget"]
    value_format_name: usd_0
  }



  set: detail {
    fields: [record_type, usr_id, service_scope_group, sales_week, teu]
  }
}

view: na_budget_trade_type {
  derived_table: {
    sql:
      SELECT  'Latin'        as trade UNION ALL
      SELECT  'TP Domi.'     as trade UNION ALL
      SELECT  'TP Non Domi.' as trade UNION ALL
      SELECT  'TA Non Domi.' as trade
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: trade {
    type: string
    sql: ${TABLE}.trade ;;
  }

  set: detail {
    fields: [trade]
  }
}

view: na_cargo_type {
  derived_table: {
    sql: SELECT 'Reefer' as cargo_type UNION ALL
         SELECT 'Dry'    as cargo_type
       ;;
  }

  dimension: cargo_type {
    label: "Cargo Type"
    type: string
    sql: ${TABLE}.cargo_type ;;
  }

}

view: na_case_inquiry {
  derived_table: {
    sql:
    --WITH ckam_skam_lst as (
    --     SELECT
    --        mbr.sales_person ,
    --        ckam_ctry.contract_country_code as kam_country_code,
    --        g.cust_grp_id
    --        FROM `ONEFORCE.OF_SALES_TEAM_MEMBER` mbr
    --        LEFT JOIN ${of_sales_team_member_contract_country.SQL_TABLE_NAME} ckam_ctry on (mbr.oneforce_id = ckam_ctry.oneforce_id )
    --        LEFT JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g on (mbr.customer_group = g.ONEForce_Id )
    --        WHERE mbr.team_role in ( 'Contract Key Account Manager (C-KAM)')  and mbr.sales_person is not null
    --        UNION DISTINCT
    --        SELECT
    --        mbr.sales_person ,
    --        skam_ctry.service_country_code as kam_country_code,
    --        g.cust_grp_id
    --        FROM `ONEFORCE.OF_SALES_TEAM_MEMBER` mbr
    --        LEFT JOIN ${of_sales_team_member_service_country.SQL_TABLE_NAME} as skam_ctry on (mbr.oneforce_id = skam_ctry.oneforce_id )
    --        LEFT JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g on (mbr.customer_group = g.ONEForce_Id )
    --        WHERE mbr.team_role in ( 'Service Key Account Manager (S-KAM)') and mbr.sales_person is not null
    --)
          SELECT
          of_case.case_casenumber                  AS case_casenumber,
          of_case.case_ownerid                     AS case_ownerid,
          of_case.case_total_escalation            AS case_total_escalation,
          of_case.case_priority                    AS case_priority,
          of_case.case_sales_week                  AS case_sales_week,
          of_case.case_status                      AS case_status,
          of_case.case_is_active                   as case_is_active,
          of_case.case_resolution_reason           as case_resolution_reason,
          of_case.case_suppliedemail               AS case_suppliedemail,
          of_case.case_createddate                 AS case_createddate,
          of_case.case_office                      AS case_office ,
          of_case.case_type                        AS case_type,
          of_case.case_origin                      AS case_origin,
          of_case.case_category_l2                 AS case_category_l2,
          of_case.case_country_code                AS case_country_code,
          of_case.case_owner_fullname              AS case_owner_fullname,
          -- Customer
          of_case.case_customer_cd_n_nm            AS case_customer_cd_n_nm ,
          of_case.case_cust_cd                     AS case_cust_cd,
          of_case.case_cust_grp_id                 AS case_cust_grp_id,
          -- CKAM & SKAM
          --kam.sales_person                         AS case_kam,
          -- open days
          of_case.no_of_days_since_created_order   AS no_of_days_since_created_order,
          of_case.no_of_days_since_created         AS no_of_days_since_created
          FROM  ${na_case_inquiry_core.SQL_TABLE_NAME} of_case
          --LEFT JOIN ckam_skam_lst AS kam ON ( -- case ownership mapping --
          --                                    ( kam.sales_person = of_case.case_ownerid)
          --                                    OR
          --                                    -- kam mapping using cust grp and country --
          --                                    ( of_case.case_cust_grp_id = kam.cust_grp_id AND
          --                                      ( -- without country
          --                                        kam.kam_country_code IS NULL OR
          --                                        -- with country
          --                                        kam.kam_country_code = of_case.case_country_code
          --                                      )
          --                                    )
          --                                  )
          WHERE 1=1
          ;;

    persist_for: "1 hour"
  }


  dimension: case_ownerid {
    type: string
    sql: ${TABLE}.case_ownerid ;;
  }

  dimension: case_sales_week {
    type: string
    sql: ${TABLE}.case_sales_week ;;
  }

  dimension: case_total_escalation {
    type: number
    sql: ${TABLE}.case_total_escalation ;;
  }

  dimension: case_status {
    type: string
    sql: ${TABLE}.case_status ;;
    label:"Status"
  }

  dimension: case_is_active {
    type: string
    sql:  ${TABLE}.case_is_active;;
    label:"Case Is Active"
  }

  dimension: case_resolution_reason {
    type: string
    sql:  ${TABLE}.case_resolution_reason ;;
    label: "Resolution Reason"
  }

  dimension: case_suppliedemail {
    type: string
    sql: ${TABLE}.case_suppliedemail ;;
    label: "Web Email"
  }

  dimension: no_of_days_since_created_order {
    type: number
    sql:  ${TABLE}.no_of_days_since_created_order ;;
    hidden: yes
  }

  dimension: no_of_days_since_created {
    type: string
    sql:  ${TABLE}.no_of_days_since_created ;;
    label: "No of days since created"
    order_by_field: no_of_days_since_created_order
  }

  dimension: case_priority {
    type: string
    sql: ${TABLE}.case_priority ;;
    label:"Priority"
  }

  #dimension: case_kam {
  #  type: string
  #  sql: ${TABLE}.case_kam ;;
  #  label:"CKAM/SKAM"
  #}

  dimension: case_cust_cd {
    type: string
    sql: ${TABLE}.case_cust_cd ;;
    hidden:  yes
  }

  dimension: case_casenumber {
    type: string
    sql: ${TABLE}.case_casenumber ;;
    label:"Case Number"
  }

  dimension: case_createddate {
    type: date
    datatype: datetime
    sql: ${TABLE}.case_createddate ;;
    label:"Open Date"
  }

  dimension_group: case_createddate_filter {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    group_label: "Open Date For Filter"
    label: "Open Date For Filter"
    sql: ${TABLE}.case_createddate ;;
  }

  dimension: case_office {
    type: string
    sql: ${TABLE}.case_office ;;
    label:"Office"

  }

  dimension: case_type {
    type: string
    sql: ${TABLE}.case_type ;;
    label:"Type"
  }

  dimension: case_origin {
    type: string
    sql: ${TABLE}.case_origin ;;
    label:"Case Origin"
  }

  dimension: case_category_l2 {
    type: string
    sql: ${TABLE}.case_category_l2 ;;
    label:"Category (L2)"
  }

  dimension: case_owner_fullname {
    type: string
    sql: ${TABLE}.case_owner_fullname ;;
    label:"Owner"
  }

  dimension: case_customer_cd_n_nm {
    type: string
    sql: ${TABLE}.case_customer_cd_n_nm ;;
    label:"Customer"
  }

  measure: case_count {
    type: count_distinct
    sql: ${TABLE}.case_casenumber ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [case_casenumber,case_origin,case_priority,case_type,case_status,case_office,case_category_l2,case_createddate,case_owner_fullname,case_customer_cd_n_nm]
  }
}

view: na_case_inquiry_backup {
  derived_table: {
    sql:
    WITH ckam_skam_lst as (
         SELECT
            mbr.sales_person ,
            ckam_ctry.contract_country_code as kam_country_code,
            g.cust_grp_id
            FROM `ONEFORCE.OF_SALES_TEAM_MEMBER` mbr
            LEFT JOIN ${of_sales_team_member_contract_country.SQL_TABLE_NAME} ckam_ctry on (mbr.oneforce_id = ckam_ctry.oneforce_id )
            LEFT JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g on (mbr.customer_group = g.ONEForce_Id )
            WHERE mbr.team_role in ( 'Contract Key Account Manager (C-KAM)')  and mbr.sales_person is not null
            UNION DISTINCT
            SELECT
            mbr.sales_person ,
            skam_ctry.service_country_code as kam_country_code,
            g.cust_grp_id
            FROM `ONEFORCE.OF_SALES_TEAM_MEMBER` mbr
            LEFT JOIN ${of_sales_team_member_service_country.SQL_TABLE_NAME} as skam_ctry on (mbr.oneforce_id = skam_ctry.oneforce_id )
            LEFT JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g on (mbr.customer_group = g.ONEForce_Id )
            WHERE mbr.team_role in ( 'Service Key Account Manager (S-KAM)') and mbr.sales_person is not null
    )
          SELECT
          of_case.CaseNumber                  AS case_casenumber,
          of_case.OwnerId                     AS case_ownerid,
          CAST(of_case.Total_Escalation AS NUMERIC) AS case_total_escalation,
          of_case.Priority                    AS case_priority,
          wk.Sales_Week                       AS case_sales_week,
          CASE WHEN of_case.Status IN ('Resolved', 'Closed') THEN 'No' ELSE 'Yes' END as case_is_active,
          of_case.Resolution_Reason           AS case_resolution_reason_raw,
          IFNULL( of_case.Resolution_Reason, 'None') as case_resolution_reason,


      of_case.SuppliedEmail               AS case_suppliedemail,
      of_case.CreatedDate                 AS case_createddate,
      of_case.Office                      AS case_office ,
      of_case.Type                        AS case_type,
      of_case.Origin                      AS case_origin,
      of_case.Sub_Category_L2             AS case_category_l2,
      (CASE WHEN service_office_hierarchy.Country is not Null THEN service_office_hierarchy.Country
      WHEN queue_name_office_hierarchy.Country is not Null THEN queue_name_office_hierarchy.Country
      ELSE user_office_hierarchy.Country END)       AS case_country_code,
      case_owner.firstname||' '||case_owner.lastname AS case_owner_fullname,
      of_case.OwnerId                                AS case_owne_id,
      -- case country
      (CASE WHEN service_office_hierarchy.Country is not Null THEN service_office_hierarchy.Country
      WHEN queue_name_office_hierarchy.Country is not Null THEN queue_name_office_hierarchy.Country
      ELSE user_office_hierarchy.Country END)  AS case_country,
      -- Customer
      of_customer.cust_cd ||'-'||of_customer.name    AS case_customer_cd_n_nm ,
      of_customer.cust_cd                 AS case_cust_cd,
      of_customer.cust_grp_id             AS case_cust_grp_id,
      -- CKAM & SKAM
      kam.sales_person                    AS case_kam,
      -- Case Open Date
      CASE WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) <=7               THEN 0
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) BETWEEN 8 and 14  THEN 1
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) BETWEEN 15 and 30 THEN 2
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) BETWEEN 31 and 90 THEN 3
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) > 90              THEN 4
      ELSE NULL END           AS no_of_days_since_created_order,

      CASE WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) <=7               THEN '0-7 days'
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) BETWEEN 8 and 14  THEN '8-14 days'
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) BETWEEN 15 and 30 THEN '15-30 days'
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) BETWEEN 31 and 90 THEN '31-90 days'
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) > 90              THEN 'More than 90 days'
      ELSE NULL END           AS no_of_days_since_created

      FROM `ONEFORCE.OF_CASE`      AS of_case
      LEFT JOIN `ONEFORCE.OF_USER` AS case_owner   ON ( case_owner.ONEForce_ID = of_case.OwnerId )
      LEFT JOIN `ONEFORCE.OF_SALES_WEEK_MASTER` wk ON (EXTRACT(DATE FROM of_case.CreatedDate) BETWEEN wk.week_start_date and wk.week_end_date )
      -- for ckam-skam mapping
      LEFT JOIN `ONEFORCE.OF_QUEUE`            AS of_queue ON of_queue.ONEForce_ID = of_case.OwnerId
      LEFT JOIN `ONEFORCE.OF_OFFICE_HIERARCHY` AS service_office_hierarchy ON ( service_office_hierarchy.Office_Code=of_case.Office )
      LEFT JOIN `ONEFORCE.OF_OFFICE_HIERARCHY` AS user_office_hierarchy ON ( user_office_hierarchy.Office_Code = case_owner.Office_Code_Number)
      LEFT JOIN `ONEFORCE.OF_OFFICE_HIERARCHY` AS queue_name_office_hierarchy ON ( queue_name_office_hierarchy.Country = (CASE
      WHEN instr(of_queue.DeveloperName,"_")=3 AND substr(of_queue.DeveloperName,1, instr(of_queue.DeveloperName,"_")-1)="NA" THEN "US"
      WHEN instr(of_queue.DeveloperName,"_")=3 THEN substr(of_queue.DeveloperName,1, instr(of_queue.DeveloperName,"_")-1) ELSE "Unknown" END)) and queue_name_office_hierarchy.Regional_Head_Office IS NOT NULL
      LEFT JOIN `ONEFORCE.OF_CUSTOMER`         AS of_customer ON ( of_customer.ONEForce_ID = CASE WHEN of_case.Contract_Customer_Name IS NOT NULL THEN of_case.Contract_Customer_Name ELSE of_case.AccountId END and  of_customer.ONEForce_ID IS NOT NULL )
      LEFT JOIN ckam_skam_lst AS kam ON ( -- case ownership mapping --
      ( kam.sales_person = of_case.OwnerId)
      OR
      -- kam mapping using cust grp and country --
      ( of_customer.cust_grp_id = kam.cust_grp_id AND
      ( -- without country
      kam.kam_country_code IS NULL OR
      -- with country
      kam.kam_country_code = (CASE WHEN service_office_hierarchy.Country is not Null THEN service_office_hierarchy.Country
      WHEN queue_name_office_hierarchy.Country is not Null THEN queue_name_office_hierarchy.Country
      ELSE user_office_hierarchy.Country END)
      )
      )
      )
      WHERE 1=1
      -- correspond to sql-always-where in of_case
      AND   ( of_case.Origin in ('Chat','Phone','Email','Web','Internal') and
      of_case.Status not in  ('Waiting on Customer Response','Waiting on Internal ONE Team','On Hold','Merged') and
      of_case.Office is not null  and not ( of_case.Origin is null and case_owner.FirstName = 'CRM' and case_owner.LastName = 'System User' ) and
      (DATE(of_case.CreatedDate )) >= DATE('2022-03-28')
      )
      --group by 1, 2, 3, 4, 5, 6, 7, 8
      ;;

    persist_for: "1 hour"
  }


  dimension: case_ownerid {
    type: string
    sql: ${TABLE}.case_ownerid ;;
  }

  dimension: case_sales_week {
    type: string
    sql: ${TABLE}.case_sales_week ;;
  }

  dimension: case_total_escalation {
    type: number
    sql: ${TABLE}.case_total_escalation ;;
  }

  dimension: case_status {
    type: string
    sql: ${TABLE}.case_status ;;
    label:"Status"
  }

  dimension: case_is_active {
    type: string
    sql:  ${TABLE}.case_is_active;;
    label:"Case Is Active"
  }

  dimension: case_resolution_reason {
    type: string
    sql:  ${TABLE}.case_resolution_reason ;;
    label: "Resolution Reason"
  }

  dimension: case_suppliedemail {
    type: string
    sql: ${TABLE}.case_suppliedemail ;;
    label: "Web Email"
  }

  dimension: no_of_days_since_created_order {
    type: number
    sql:  ${TABLE}.no_of_days_since_created_order ;;
    hidden: yes
  }

  dimension: no_of_days_since_created {
    type: string
    sql:  ${TABLE}.no_of_days_since_created ;;
    label: "No of days since created"
    order_by_field: no_of_days_since_created_order
  }

  dimension: case_priority {
    type: string
    sql: ${TABLE}.case_priority ;;
    label:"Priority"
  }

  dimension: case_kam {
    type: string
    sql: ${TABLE}.case_kam ;;
    label:"CKAM/SKAM"
  }

  dimension: case_cust_cd {
    type: string
    sql: ${TABLE}.case_cust_cd ;;
    hidden:  yes
  }

  dimension: case_casenumber {
    type: string
    sql: ${TABLE}.case_casenumber ;;
    label:"Case Number"
  }

  dimension: case_createddate {
    type: date
    datatype: datetime
    sql: ${TABLE}.case_createddate ;;
    label:"Open Date"
  }

  dimension_group: case_createddate_filter {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    group_label: "Open Date For Filter"
    label: "Open Date For Filter"
    sql: ${TABLE}.case_createddate ;;
  }

  dimension: case_office {
    type: string
    sql: ${TABLE}.case_office ;;
    label:"Office"

  }

  dimension: case_type {
    type: string
    sql: ${TABLE}.case_type ;;
    label:"Type"
  }

  dimension: case_origin {
    type: string
    sql: ${TABLE}.case_origin ;;
    label:"Case Origin"
  }

  dimension: case_category_l2 {
    type: string
    sql: ${TABLE}.case_category_l2 ;;
    label:"Category (L2)"
  }

  dimension: case_owner_fullname {
    type: string
    sql: ${TABLE}.case_owner_fullname ;;
    label:"Owner"
  }

  dimension: case_customer_cd_n_nm {
    type: string
    sql: ${TABLE}.case_customer_cd_n_nm ;;
    label:"Customer"
  }

  measure: case_count {
    type: count_distinct
    sql: ${TABLE}.case_casenumber ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [case_casenumber,case_origin,case_priority,case_type,case_status,case_office,case_category_l2,case_createddate,case_owner_fullname,case_customer_cd_n_nm]
  }
}

view: na_case_inquiry_core {
  derived_table: {
    sql: SELECT
      of_case.CaseNumber                  AS case_casenumber,
      of_case.OwnerId                     AS case_ownerid,
      CAST(of_case.Total_Escalation AS NUMERIC) AS case_total_escalation,
      of_case.Priority                    AS case_priority,
      wk.Sales_Week                       AS case_sales_week,
      of_case.Status                      AS case_status,
      CASE WHEN of_case.Status IN ('Resolved', 'Closed') THEN 'No' ELSE 'Yes' END as case_is_active,
      of_case.Resolution_Reason           AS case_resolution_reason_raw,
      IFNULL( of_case.Resolution_Reason, 'None') as case_resolution_reason,
      of_case.SuppliedEmail               AS case_suppliedemail,
      of_case.CreatedDate                 AS case_createddate,
      of_case.Office                      AS case_office ,
      of_case.Type                        AS case_type,
      of_case.Origin                      AS case_origin,
      of_case.Sub_Category_L2             AS case_category_l2,
      (CASE WHEN service_office_hierarchy.Country is not Null THEN service_office_hierarchy.Country
      WHEN queue_name_office_hierarchy.Country is not Null THEN queue_name_office_hierarchy.Country
      ELSE user_office_hierarchy.Country END)       AS case_country_code,
      case_owner.firstname||' '||case_owner.lastname AS case_owner_fullname,
      -- Customer
      of_customer.cust_cd ||'-'||of_customer.name    AS case_customer_cd_n_nm ,
      of_customer.cust_cd                 AS case_cust_cd,
      of_customer.cust_grp_id             AS case_cust_grp_id,
      -- Case Open Date
      CASE WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) <=7               THEN 0
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) BETWEEN 8 and 14  THEN 1
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) BETWEEN 15 and 30 THEN 2
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) BETWEEN 31 and 90 THEN 3
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) > 90              THEN 4
      ELSE NULL END           AS no_of_days_since_created_order,

      CASE WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) <=7               THEN '0-7 days'
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) BETWEEN 8 and 14  THEN '8-14 days'
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) BETWEEN 15 and 30 THEN '15-30 days'
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) BETWEEN 31 and 90 THEN '31-90 days'
      WHEN DATE_DIFF( CURRENT_DATE(), DATE(of_case.CreatedDate), DAY ) > 90              THEN 'More than 90 days'
      ELSE NULL END           AS no_of_days_since_created

      FROM `ONEFORCE.OF_CASE`      AS of_case
      LEFT JOIN `ONEFORCE.OF_USER` AS case_owner   ON ( case_owner.ONEForce_ID = of_case.OwnerId )
      LEFT JOIN `ONEFORCE.OF_SALES_WEEK_MASTER` wk ON (EXTRACT(DATE FROM of_case.CreatedDate) BETWEEN wk.week_start_date and wk.week_end_date )
      -- for ckam-skam mapping
      LEFT JOIN `ONEFORCE.OF_QUEUE`            AS of_queue ON of_queue.ONEForce_ID = of_case.OwnerId
      LEFT JOIN `ONEFORCE.OF_OFFICE_HIERARCHY` AS service_office_hierarchy ON ( service_office_hierarchy.Office_Code=of_case.Office )
      LEFT JOIN `ONEFORCE.OF_OFFICE_HIERARCHY` AS user_office_hierarchy ON ( user_office_hierarchy.Office_Code = case_owner.Office_Code_Number)
      LEFT JOIN `ONEFORCE.OF_OFFICE_HIERARCHY` AS queue_name_office_hierarchy ON ( queue_name_office_hierarchy.Country = (CASE
      WHEN instr(of_queue.DeveloperName,"_")=3 AND substr(of_queue.DeveloperName,1, instr(of_queue.DeveloperName,"_")-1)="NA" THEN "US"
      WHEN instr(of_queue.DeveloperName,"_")=3 THEN substr(of_queue.DeveloperName,1, instr(of_queue.DeveloperName,"_")-1) ELSE "Unknown" END)) and queue_name_office_hierarchy.Regional_Head_Office IS NOT NULL
      LEFT JOIN `ONEFORCE.OF_CUSTOMER`         AS of_customer ON ( of_customer.ONEForce_ID = CASE WHEN of_case.Contract_Customer_Name IS NOT NULL THEN of_case.Contract_Customer_Name ELSE of_case.AccountId END and  of_customer.ONEForce_ID IS NOT NULL )
      WHERE 1=1
      -- correspond to sql-always-where in of_case
      AND   ( of_case.Origin in ('Chat','Phone','Email','Web','Internal') and
      of_case.Status not in  ('Waiting on Customer Response','Waiting on Internal ONE Team','On Hold','Merged') and
      of_case.Office is not null  and not ( of_case.Origin is null and case_owner.FirstName = 'CRM' and case_owner.LastName = 'System User' ) and
      DATE(of_case.CreatedDate ) >= DATE('2022-03-28')
      )
      -- other condition moved from dashboard to core SQL
      AND   of_case.CreatedDate   >= DATETIME_ADD(DATETIME_TRUNC(CURRENT_DATETIME('UTC'), DAY), INTERVAL -364 DAY)
      AND   of_case.CreatedDate   <  DATETIME_ADD(DATETIME_ADD(DATETIME_TRUNC(CURRENT_DATETIME('UTC'), DAY), INTERVAL -364 DAY), INTERVAL 365 DAY)
      AND   IFNULL( of_case.Resolution_Reason, 'None')  IN ('Customer Query Resolved', 'Customer Query Un-resolved', 'None')
      AND   ( of_case.SuppliedEmail  NOT LIKE '%@one-line.com%' OR of_case.SuppliedEmail IS NULL )


      ;;
    persist_for: "1 hour"

  }

  measure: count {
    type: count
  }

  dimension: case_casenumber {
    type: string
    sql: ${TABLE}.case_casenumber ;;
  }

  dimension: case_ownerid {
    type: string
    sql: ${TABLE}.case_ownerid ;;
  }

  dimension: case_total_escalation {
    type: number
    sql: ${TABLE}.case_total_escalation ;;
  }

  dimension: case_priority {
    type: string
    sql: ${TABLE}.case_priority ;;
  }

  dimension: case_sales_week {
    type: string
    sql: ${TABLE}.case_sales_week ;;
  }

  dimension: case_status {
    type: string
    sql: ${TABLE}.case_status ;;
  }

  dimension: case_is_active {
    type: string
    sql: ${TABLE}.case_is_active ;;
  }

  dimension: case_resolution_reason_raw {
    type: string
    sql: ${TABLE}.case_resolution_reason_raw ;;
  }

  dimension: case_resolution_reason {
    type: string
    sql: ${TABLE}.case_resolution_reason ;;
  }

  dimension: case_suppliedemail {
    type: string
    sql: ${TABLE}.case_suppliedemail ;;
  }

  dimension_group: case_createddate {
    type: time
    datatype: datetime
    sql: ${TABLE}.case_createddate ;;
  }

  dimension: case_office {
    type: string
    sql: ${TABLE}.case_office ;;
  }

  dimension: case_type {
    type: string
    sql: ${TABLE}.case_type ;;
  }

  dimension: case_origin {
    type: string
    sql: ${TABLE}.case_origin ;;
  }

  dimension: case_category_l2 {
    type: string
    sql: ${TABLE}.case_category_l2 ;;
  }

  dimension: case_country_code {
    type: string
    sql: ${TABLE}.case_country_code ;;
  }

  dimension: case_owner_fullname {
    type: string
    sql: ${TABLE}.case_owner_fullname ;;
  }

  dimension: case_customer_cd_n_nm {
    type: string
    sql: ${TABLE}.case_customer_cd_n_nm ;;
  }

  dimension: case_cust_cd {
    type: string
    sql: ${TABLE}.case_cust_cd ;;
  }

  dimension: case_cust_grp_id {
    type: string
    sql: ${TABLE}.case_cust_grp_id ;;
  }

  dimension: no_of_days_since_created_order {
    type: number
    sql: ${TABLE}.no_of_days_since_created_order ;;
  }

  dimension: no_of_days_since_created {
    type: string
    sql: ${TABLE}.no_of_days_since_created ;;
  }


}

view: na_case_inquiry_kam {
  derived_table: {
    sql:
      WITH ckam_skam_lst as (
           SELECT
              mbr.sales_person ,
              ckam_ctry.contract_country_code as kam_country_code,
              g.cust_grp_id
              FROM `ONEFORCE.OF_SALES_TEAM_MEMBER` mbr
              LEFT JOIN ${of_sales_team_member_contract_country.SQL_TABLE_NAME} ckam_ctry on (mbr.oneforce_id = ckam_ctry.oneforce_id )
              LEFT JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g on (mbr.customer_group = g.ONEForce_Id )
              WHERE mbr.team_role in ( 'Contract Key Account Manager (C-KAM)', 'Contract Key Account Support (C-KAS)' )
              and mbr.sales_person is not null
              and mbr.inactive = 'false'
              UNION DISTINCT
              SELECT
              mbr.sales_person ,
              skam_ctry.service_country_code as kam_country_code,
              g.cust_grp_id
              FROM `ONEFORCE.OF_SALES_TEAM_MEMBER` mbr
              LEFT JOIN ${of_sales_team_member_service_country.SQL_TABLE_NAME} as skam_ctry on (mbr.oneforce_id = skam_ctry.oneforce_id )
              LEFT JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g on (mbr.customer_group = g.ONEForce_Id )
              WHERE mbr.team_role in ( 'Service Key Account Manager (S-KAM)', 'Service Key Account Support (S-KAS)')
              and mbr.sales_person is not null
              and mbr.inactive = 'false'
      )
            SELECT
            of_case.case_casenumber                  AS case_casenumber,
            of_case.case_ownerid                     AS case_ownerid,
            of_case.case_total_escalation            AS case_total_escalation,
            of_case.case_priority                    AS case_priority,
            of_case.case_sales_week                  AS case_sales_week,
            of_case.case_status                      AS case_status,
            of_case.case_is_active                   as case_is_active,
            of_case.case_resolution_reason           as case_resolution_reason,
            of_case.case_suppliedemail               AS case_suppliedemail,
            of_case.case_createddate                 AS case_createddate,
            of_case.case_office                      AS case_office ,
            of_case.case_type                        AS case_type,
            of_case.case_origin                      AS case_origin,
            of_case.case_category_l2                 AS case_category_l2,
            of_case.case_country_code                AS case_country_code,
            of_case.case_owner_fullname              AS case_owner_fullname,
            -- Customer
            of_case.case_customer_cd_n_nm            AS case_customer_cd_n_nm ,
            of_case.case_cust_cd                     AS case_cust_cd,
            of_case.case_cust_grp_id                 AS case_cust_grp_id,
            -- CKAM & SKAM
            kam.sales_person                         AS case_kam,
            -- open days
            of_case.no_of_days_since_created_order   AS no_of_days_since_created_order,
            of_case.no_of_days_since_created         AS no_of_days_since_created
            FROM  ${na_case_inquiry_core.SQL_TABLE_NAME} of_case
            LEFT JOIN ckam_skam_lst AS kam ON ( -- case ownership mapping --
                                                ( kam.sales_person = of_case.case_ownerid)
                                                OR
                                                -- kam mapping using cust grp and country --
                                                ( of_case.case_cust_grp_id = kam.cust_grp_id AND
                                                  ( -- without country
                                                    kam.kam_country_code IS NULL OR
                                                    -- with country
                                                    kam.kam_country_code = of_case.case_country_code
                                                  )
                                                )
                                              )
            WHERE 1=1
            ;;

    persist_for: "1 hour"
  }


  dimension: case_ownerid {
    type: string
    sql: ${TABLE}.case_ownerid ;;
  }

  dimension: case_sales_week {
    type: string
    sql: ${TABLE}.case_sales_week ;;
  }

  dimension: case_total_escalation {
    type: number
    sql: ${TABLE}.case_total_escalation ;;
  }

  dimension: case_status {
    type: string
    sql: ${TABLE}.case_status ;;
    label:"Status"
  }

  dimension: case_is_active {
    type: string
    sql:  ${TABLE}.case_is_active;;
    label:"Case Is Active"
  }

  dimension: case_resolution_reason {
    type: string
    sql:  ${TABLE}.case_resolution_reason ;;
    label: "Resolution Reason"
  }

  dimension: case_suppliedemail {
    type: string
    sql: ${TABLE}.case_suppliedemail ;;
    label: "Web Email"
  }

  dimension: no_of_days_since_created_order {
    type: number
    sql:  ${TABLE}.no_of_days_since_created_order ;;
    hidden: yes
  }

  dimension: no_of_days_since_created {
    type: string
    sql:  ${TABLE}.no_of_days_since_created ;;
    label: "No of days since created"
    order_by_field: no_of_days_since_created_order
  }

  dimension: case_priority {
    type: string
    sql: ${TABLE}.case_priority ;;
    label:"Priority"
  }

  dimension: case_kam {
    type: string
    sql: ${TABLE}.case_kam ;;
    label:"CKAM/SKAM"
  }

  dimension: case_cust_cd {
    type: string
    sql: ${TABLE}.case_cust_cd ;;
    hidden:  yes
  }

  dimension: case_casenumber {
    type: string
    sql: ${TABLE}.case_casenumber ;;
    label:"Case Number"
  }

  dimension: case_createddate {
    type: date
    datatype: datetime
    sql: ${TABLE}.case_createddate ;;
    label:"Open Date"
  }

  dimension_group: case_createddate_filter {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    group_label: "Open Date For Filter"
    label: "Open Date For Filter"
    sql: ${TABLE}.case_createddate ;;
  }

  dimension: case_office {
    type: string
    sql: ${TABLE}.case_office ;;
    label:"Office"

  }

  dimension: case_type {
    type: string
    sql: ${TABLE}.case_type ;;
    label:"Type"
  }

  dimension: case_origin {
    type: string
    sql: ${TABLE}.case_origin ;;
    label:"Case Origin"
  }

  dimension: case_category_l2 {
    type: string
    sql: ${TABLE}.case_category_l2 ;;
    label:"Category (L2)"
  }

  dimension: case_owner_fullname {
    type: string
    sql: ${TABLE}.case_owner_fullname ;;
    label:"Owner"
  }

  dimension: case_customer_cd_n_nm {
    type: string
    sql: ${TABLE}.case_customer_cd_n_nm ;;
    label:"Customer"
  }

  measure: case_count {
    type: count_distinct
    sql: ${TABLE}.case_casenumber ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [case_casenumber,case_origin,case_priority,case_type,case_status,case_office,case_category_l2,case_createddate,case_owner_fullname,case_customer_cd_n_nm]
  }
}

view: na_dashboard_param {
  derived_table: {
    sql: SELECT 1 as Col1
      ;;
  }

  parameter: measure_choice {
    label: "Choice of Measure"
    allowed_value: { value:"CM"  label:"CM" }
    allowed_value: { value:"TEU" label:"TEU" }
    default_value: "TEU"
  }

  measure: count {
    type: count
  }

  dimension: measure_chosen {
    type: string
    sql:  {% if    measure_choice._parameter_value == "'CM'" %} 'CM'
          {% elsif measure_choice._parameter_value == "'TEU'" %} 'TEU'
          {% else %} 'TEU'
          {% endif %};;
  }

  dimension: col_1 {
    type: number
    sql: ${TABLE}.Col1 ;;
  }

}

view: na_event_query {
  derived_table: {
    sql:
    WITH e AS (
      SELECT e.*, svc_scp_grp_cd AS svc_scp_grp_cd
      FROM `ONEFORCE.OF_EVENT` e cross join unnest(SPLIT( e.Service_Scope_Group , ';' ) ) as svc_scp_grp_cd
      WHERE e.Service_Scope_Group  is NOT NULL
      UNION ALL
      SELECT e.*, CAST(NULL as STRING) svc_scp_grp_cd
      FROM `ONEFORCE.OF_EVENT` e
      WHERE e.Service_Scope_Group  is NULL
    )
    SELECT
          e.ONEForce_ID      as evnt_oneforce_id,
          e.Event_Status     as evnt_status,
          e.OwnerId          as evnt_owner_id,
          e.Subject          as evnt_subject,
          e.Sales_Call_Type  as evnt_event_type,
          e.Event_Category   as evnt_category,
          w.Sales_Week    as evnt_sales_week ,
          e.StartDateTime as evnt_start_date ,
          (CASE e.event_priority WHEN '2'  THEN 'High'  WHEN '1'  THEN 'Normal'  WHEN '0'  THEN 'Low' ELSE NULL END ) as evnt_priority,
          e.WhatId         as evnt_what_id,
          REPLACE( IFNULL(e.svc_scp_grp_cd, 'ALL'),'ALL','All or (Blank)' )
                           as evnt_svc_scp_grp_cd,
          c.CUST_CD        as evnt_cust_cd,
          c.NAME           as evnt_cust_name,
          coalesce(g.CUST_GRP_ID, g2.CUST_GRP_ID ) as evnt_cust_grp_id,
          CASE WHEN g.cust_grp_id  IS NOT NULL THEN (CASE WHEN IFNULL( g.KEY_ACCT_TP_CD,  'SME' ) = 'SME' THEN 'ONECare' ELSE g.KEY_ACCT_TP_CD  END )
               WHEN g2.cust_grp_id IS NOT NULL THEN (CASE WHEN IFNULL( g2.KEY_ACCT_TP_CD, 'SME' ) = 'SME' THEN 'ONECare' ELSE g2.KEY_ACCT_TP_CD END )
               ELSE NULL END as evnt_cust_key_acct_typ
          FROM e
          INNER JOIN `ONEFORCE.OF_SALES_WEEK_MASTER` w ON (EXTRACT(DATE FROM e.StartDateTime) BETWEEN w.week_start_date and w.week_end_date )
          LEFT JOIN `ONEFORCE.V_CUSTOMER_OPUS_N_PROSPECT` c ON (e.WhatId = c.ONEForce_ID)
          LEFT JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g ON (c.CUST_GRP_ID = g.CUST_GRP_ID)
          -- NA dashboard 2022 Nov 2,after checking the data, consider do not use the join betweene WhatId = g2.ONEForce_ID, since sales call
          -- of these data pattern look rather exceptional.The dashboard Sales Activity Monitor also does not treat WhatId as cust_grp
          -- The join condition is diabled using 1=2
          LEFT JOIN `ONEFORCE.OF_CUSTOMER_GROUP` g2 ON (e.WhatId = g2.ONEForce_ID and 1=2)
          LEFT JOIN `ONEFORCE.OF_USER` u ON (e.OwnerId = u.ONEForce_Id)
          WHERE e.Event_Status  = 'Completed'
          -- Jack 2022.8.29 follow logic of Sales Activity Monitoring (Event)
          AND e.CreatedById = e.OwnerId
          AND u.profile_name in ('Sales Executive', 'Third Party Agent')
          AND e.WhatId is not null
           ;;

    persist_for: "1 hour"
  }

  measure: count {
    label: "Count"
    type: count_distinct
    sql: ${TABLE}.evnt_oneforce_id ;;
    drill_fields: [detail*]
  }

  dimension: evnt_oneforce_id {
    type: string
    sql: ${TABLE}.evnt_oneforce_id ;;
  }

  dimension: evnt_owner_id {
    type: string
    sql: ${TABLE}.evnt_owner_id ;;
  }

  dimension: evnt_subject {
    label: "Subject"
    type: string
    sql: ${TABLE}.evnt_subject ;;
    link: {
      label: "View Sales Call"
      url: "https://one-line.lightning.force.com/{{ evnt_oneforce_id }}"
      icon_url: "https://www.salesforce.com/content/dam/sfdc-docs/www/logos/logo-salesforce.svg"
    }
  }

  dimension: evnt_event_type {
    label: "Event Type"
    type: string
    sql: ${TABLE}.evnt_event_type ;;
  }

  dimension: evnt_status {
    type: string
    sql: ${TABLE}.evnt_status ;;
  }

  dimension: evnt_category {
    label: "Event Category"
    type: string
    sql: ${TABLE}.evnt_category ;;
  }

  dimension: evnt_cust_name {
    type: string
    sql: ${TABLE}.evnt_cust_name ;;
  }

  dimension: evnt_sales_week {
    type: string
    sql: ${TABLE}.evnt_sales_week ;;
  }

  dimension: evnt_sales_week_new_fmt {
    label: "Sales Week"
    type: string
    sql: LEFT(${evnt_sales_week},4) ||'/W'|| RIGHT(${evnt_sales_week},2)  ;;
  }

  dimension: evnt_start_date  {
    label: "Start"
    type: date_time
    sql: ${TABLE}.evnt_start_date ;;
  }


  dimension: evnt_priority {
    label: "Priority"
    type: string
    sql: ${TABLE}.evnt_priority ;;
  }

  dimension: evnt_what_id {
    type: string
    sql: ${TABLE}.evnt_what_id ;;
  }

  dimension: evnt_cust_cd {
    type: string
    sql: ${TABLE}.evnt_cust_cd ;;
  }

  dimension: evnt_cust_key_acct_typ {
    type: string
    sql: ${TABLE}.evnt_cust_key_acct_typ ;;
  }

  dimension: evnt_cust_grp_id {
    type: string
    sql: ${TABLE}.evnt_cust_grp_id ;;
  }

  dimension: svc_scp_grp_cd {
    label: "Service Scope Group Code"
    type: string
    sql: ${TABLE}.evnt_svc_scp_grp_cd  ;;
  }

  dimension: na_trade {
    type: string
    sql: CASE ${TABLE}.evnt_svc_scp_grp_cd
         WHEN 'LN' THEN 'Latin'
         WHEN 'LW' THEN 'Latin'
         ELSE evnt_svc_scp_grp_cd END
        ;;
  }

#  dimension: svc_scp_grp_fake {
#    label: "Service Scope Group Code (fake)"
#    type: string
#    sql: (CASE SUBSTR( ${TABLE}.evnt_cust_cd, 8, 1)
#               WHEN '1' THEN 'TP'
#               WHEN '2' THEN 'TP'
#               WHEN '3' THEN 'TP'
#               WHEN '4' THEN 'TP'
#               WHEN '5' THEN 'TP'
#               WHEN '6' THEN 'TP'
#               WHEN '7' THEN 'TP'
#               WHEN '8' THEN 'TP'
#               WHEN '9' THEN 'TA'
#               WHEN '0' THEN 'LN'
#          END)    ;;

#    sql: (CASE WHEN SUBSTR( ${TABLE}.evnt_cust_cd, 8, 1) BETWEEN '1' AND '3' THEN 'TPT'
#               WHEN SUBSTR( ${TABLE}.evnt_cust_cd, 8, 1) BETWEEN '4' AND '6' THEN 'TAT'
#               WHEN SUBSTR( ${TABLE}.evnt_cust_cd, 8, 1) = '7' THEN 'LAT'
#               WHEN SUBSTR( ${TABLE}.evnt_cust_cd, 8, 1) = '8' THEN 'LET'
#               WHEN SUBSTR( ${TABLE}.evnt_cust_cd, 8, 1) = '9' THEN 'LNT'
#               WHEN SUBSTR( ${TABLE}.evnt_cust_cd, 8, 1) = '0' THEN 'LWT' END)
#  }

  set: detail {
    fields: [
      evnt_subject,
      evnt_priority,
      evnt_start_date,
      evnt_sales_week_new_fmt,
      v_customer_opus_n_prospect.customer_cd_and_name,
      of_customer_group.cust_grp_and_name,
      evnt_event_type,
      evnt_category,
      na_user_evnt.full_name,
    ]
  }
}

view: na_landing_last_n_week {
  derived_table: {
    sql:
    SELECT 'Current and Past' as rec_type,
           Week_Start_Date,
           Week_End_Date,
           Sales_Week,
           row_num
    FROM (
       SELECT wk.Week_Start_Date,   wk.Week_End_Date, wk.Sales_Week,
              row_number() over (order by sales_week desc) row_num
       FROM `ONEFORCE.OF_SALES_WEEK_MASTER` wk
       WHERE wk.Week_Start_Date <= CURRENT_DATE()
    )
    WHERE row_num <= {% parameter param_last_n_week %} OR NOT( {% parameter param_last_future_n_week_filtered %} )
    UNION ALL
    SELECT 'Future' as rec_type,
           Week_Start_Date,
           Week_End_Date,
           Sales_Week,
           row_num
    FROM (
       SELECT wk.Week_Start_Date,   wk.Week_End_Date, wk.Sales_Week,
              row_number() over (order by sales_week) row_num
       FROM `ONEFORCE.OF_SALES_WEEK_MASTER` wk
       WHERE wk.Week_Start_Date > CURRENT_DATE()
    )
    WHERE row_num <= {% parameter param_next_n_week %} OR NOT( {% parameter param_last_future_n_week_filtered %} )
     ;;
  }



  parameter: param_last_future_n_week_filtered {
    type: yesno
    default_value: "No"
  }

  #dimension: is_last_n_future_n_week_filter_applied {
  #  type: string
  #  sql: 'Within the range' ;;
  #  suggestions: ["Within the range"]
  #}

  parameter: param_last_n_week {
    type: number
    allowed_value: {value: "1"}
    allowed_value: {value: "2"}
    allowed_value: {value: "3"}
    allowed_value: {value: "4"}
    allowed_value: {value: "5"}
    allowed_value: {value: "6"}
    allowed_value: {value: "7"}
    allowed_value: {value: "8"}
    allowed_value: {value: "9"}
    allowed_value: {value: "10"}
    allowed_value: {value: "11"}
    allowed_value: {value: "12"}
    allowed_value: {value: "13"}
    default_value: "10"
  }

  parameter: param_next_n_week {
    type: number
    allowed_value: {value: "1"}
    allowed_value: {value: "2"}
    allowed_value: {value: "3"}
    allowed_value: {value: "4"}
    allowed_value: {value: "5"}
    allowed_value: {value: "6"}
    allowed_value: {value: "7"}
    allowed_value: {value: "8"}
    allowed_value: {value: "9"}
    allowed_value: {value: "10"}
    allowed_value: {value: "11"}
    allowed_value: {value: "12"}
    allowed_value: {value: "13"}
    default_value: "2"
  }

  measure: count {
    type: count
  }

  dimension: rec_type {
    type: string
    sql: ${TABLE}.rec_type ;;
  }

  dimension: week_start_date {
    type: date
    datatype: date
    sql: ${TABLE}.Week_Start_Date ;;
  }

  dimension: week_end_date {
    type: date
    datatype: date
    sql: ${TABLE}.Week_End_Date ;;
  }

  dimension: sales_week {
    type: string
    sql: ${TABLE}.Sales_Week ;;
  }

  dimension: row_num {
    type: string
    sql: ${TABLE}.row_num ;;
  }



}

view: na_user {
  derived_table: {
    sql: SELECT
        'Yes'                               as na_users_only
      , u.ONEForce_ID                       as oneforce_id
      , u.FirstName ||' ' || u.LastName     as full_name
      , u.Sub_Region                        as sub_region
      , mgr.FirstName ||' ' || mgr.LastName as mgr_full_name
      , u.Username                          as username
      , u.Profile_Name
      , u.User_role_name
      , u.CRM_Trainer
      , u.Suppressed_in_CRM_Usage_KPI_Dashboard
      , u.Regional_Head_Office
      , u.Office_Code_Number
      , u.IsActive
      , u.OfficeType
      , u.TPA_user
      , u.Email
      , u.Email_2
      , mgr.Regional_Head_Office as mgr_regional_head_office
      , mgr.Office_Code_Number as mgr_office_code_number
      , mgr.Sub_Region as mgr_sub_region
      , mgr.Username as mgr_username
      FROM ${of_user.SQL_TABLE_NAME} u
      LEFT JOIN ${of_user.SQL_TABLE_NAME} mgr ON (u.ManagerId = mgr.ONEForce_ID)
      WHERE u.Regional_Head_Office like '%RICHQ%'
      AND (  {% condition manager_full_name %} u.FirstName ||' '|| u.LastName {% endcondition %}
             OR
             {% condition manager_full_name %} mgr.FirstName ||' '|| mgr.LastName {% endcondition %}
          )
       ;;
  }

  filter: manager_full_name   {
    label: "Manager Filter"
    suggest_dimension: mgr_full_name
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: email_4_join_with_cust  {
    hidden: yes
    type: string
    sql: CASE WHEN ${TABLE}.TPA_user = 'true' THEN ${TABLE}.Email_2 ELSE ${TABLE}.Email END   ;;
  }

  dimension: na_users_only {
    type: string
    sql: ${TABLE}.na_users_only ;;
  }

  dimension: oneforce_id {
    type: string
    sql: ${TABLE}.oneforce_id ;;
    primary_key: yes
  }

  dimension: full_name {
    label: "Sales Person"
    type: string
    sql: ${TABLE}.full_name ;;
  }

  dimension: mgr_full_name {
    label: "Manager Full Name"
    type: string
    sql: ${TABLE}.mgr_full_name ;;
  }

  dimension: mgr_username {
    label: "Manager Username"
    type: string
    sql: ${TABLE}.mgr_username ;;
  }

  dimension: username {
    label: "Username"
    type: string
    sql: ${TABLE}.username ;;
  }

  dimension: sub_region {
    label: "Sub Region"
    type: string
    sql: ${TABLE}.sub_region ;;
  }

  dimension: profile_name {
    label: "Profile"
    type: string
    sql: ${TABLE}.Profile_Name ;;
  }

  dimension: user_role_name {
    label: "Role"
    type: string
    sql: ${TABLE}.User_role_name ;;
  }

  dimension: crm_trainer {
    label: "Is CRM Trainer"
    type: string
    sql: ${TABLE}.CRM_Trainer ;;
  }

  dimension: suppressed_in_crm_usage_kpi_dashboard {
    label: "Is Suppressed in KPI Dashboard"
    type: string
    sql: ${TABLE}.Suppressed_in_CRM_Usage_KPI_Dashboard ;;
  }

  dimension: office_code_number {
    label: "Office Code"
    type: string
    sql: ${TABLE}.Office_Code_Number ;;
  }

  dimension: regional_head_office {
    label: "Regional Head Office"
    type: string
    sql: ${TABLE}.Regional_Head_Office ;;
  }

  dimension: mgr_regional_head_office {
    label: "Manager Regional Head Office"
    type: string
    sql: ${TABLE}.mgr_regional_head_office ;;
  }

  dimension: mgr_office_code_number {
    label: "Manager Office Code"
    type: string
    sql: ${TABLE}.mgr_office_code_number ;;
  }

  dimension: mgr_sub_region {
    label: "Manager Sub Region"
    type: string
    sql: ${TABLE}.mgr_sub_region ;;
  }


  dimension: is_active {
    label: "Is Active"
    type: string
    sql: ${TABLE}.IsActive ;;
  }

  dimension: office_type {
    label: "Office Type"
    type: string
    sql: ${TABLE}.OfficeType ;;
  }

  set: detail {
    fields: [
      oneforce_id,
      full_name,
      sub_region,
      profile_name,
      user_role_name,
      crm_trainer,
      suppressed_in_crm_usage_kpi_dashboard,
      office_code_number,
      is_active,
      office_type
    ]
  }
}

# include: "na_user.view"
view: na_user_evnt {
  extends: [na_user]

  dimension: full_name {
    label: "Assigned To"
  }
}

# include: "na_user.view"
view: na_user_opp {
  extends: [na_user]

  dimension: full_name {
    label: "Opportunity Owner"
  }

}

# include: "na_user.view"
view: na_user_sales_rep_in_contract_n_budget {
  extends: [na_user]

  dimension: full_name {
    #label: "Sales Person"
    label: "{% if    _view._name ==  'na_user_sales_rep_in_contract_n_budget'  %}Sales Person{%
    elsif _view._name ==  'na_user_scrfa_main_sls_rep'              %}SC/RFA Main Sales Rep{%
    elsif _view._name ==  'na_user_scrfa_dtl_sls_rep'               %}SC/RFA Svc Scp Sales Rep{%
    else  %}Sales Person{% endif %}"
    #label: "{{_view._name}}"
  }
}

view: of_account_plan {
  sql_table_name: `ONEFORCE.OF_ACCOUNT_PLAN`
    ;;

  dimension: record_id {
    label: "Record Id"  # programmatically added by LookML modifier
    description: "By GENERATE_UUID()"
    primary_key: yes
    type: string
    sql: ${TABLE}.Record_Id ;;
  }

  dimension: ap_submission_office {
    label: "AP Submission Office" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.AP_Submission_Office ;;
  }

##  ## 22 Oct 2021 by Zoe ## (future enhancement)
##  dimension: ap_submission_country_manual {
##    label: "AP Submission Country (Manual)" # programmatically added by LookML modifier
##    type: string
##    sql:
##      CASE WHEN ${TABLE}.AP_Submission_Office IS NOT NULL THEN LEFT(${of_office.Location_Code},2)
##       ELSE NULL
##      END ;;
##  }



  dimension: ap_teu {
    label: "AP TEU" # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.AP_TEU ;;
  }

  dimension: cif_fob {
    label: "CIF/FOB"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CIF_FOB ;;
  }

  dimension: contract_office_code {
    label: "Contract Office Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Contract_Office_Code ;;
  }

  dimension: contract_office_country_code {
    label: "Contract Office Country Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Contract_Office_Country_Code ;;
  }

  dimension: dominant_leg_flag {
    label: "Dominant Leg Flag"  # programmatically added by LookML modifier
    type: string
    sql:
      CASE
        WHEN ${TABLE}.Dominant_Leg_Flag = 'Y' THEN 'DOM'
        WHEN ${TABLE}.Dominant_Leg_Flag = 'N' THEN 'N-DOM'
      ELSE NULL
      END
      ;;
  }

  dimension: gka_flag {
    label: "GKA Flag" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.GKA_Flag ;;
  }

  dimension: loading_sales_rep_office_code {
    label: "Loading Sales Rep Office Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Loading_Sales_Rep_Office_Code ;;
  }

  dimension: loading_sales_rep_office_country_code {
    label: "Loading Sales Rep Office Country Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Loading_Sales_Rep_Office_Country_Code ;;
  }

  dimension: office_rhq_code {
    label: "Office RHQ Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Office_RHQ_Code ;;
  }

  dimension: rf_flag {
    label: "RF Flag"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.RF_Flag ;;
  }

  dimension: sales_week {
    label: "Sales Week" # programmatically added by LookML modifier
    type: number
    sql: cast(regexp_replace(${TABLE}.Sales_Week, '[/W]', '') as int64)  ;;
  }

  dimension: sc_rfa_contract_type {
    label: "SC/RFA Contract Type" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SC_RFA_Contract_Type ;;
  }

  dimension: sc_rfa_customer_code {
    label: "SC/RFA Customer Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SC_RFA_Customer_Code ;;
  }

  dimension: sc_rfa_customer_group_code {
    label: "SC/RFA Customer Group Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SC_RFA_Customer_Group_Code ;;
  }

  dimension: sc_rfa_customer_type_label {
    label: "SC/RFA Customer Type label" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SC_RFA_Customer_Type_label ;;
  }

  dimension: sc_rfa_number {
    label: "SC/RFA Number"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SC_RFA_Number ;;
  }

  dimension: sub_trade_code {
    label: "Sub Trade Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Sub_Trade_Code ;;
  }

  dimension: trade_code {
    label: "Trade Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Trade_Code ;;
  }

  dimension: trunk_vvd_code {
    label: "Trunk VVD Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Trunk_VVD_Code ;;
  }

  dimension: trunk_vvd_direction_code {
    label: "Trunk VVD Direction Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Trunk_VVD_Direction_Code ;;
  }

  dimension: trunk_vvd_service_lane_code {
    label: "Service Lane (Rev)"
    type: string
    sql: ${TABLE}.Trunk_VVD_Service_Lane_Code ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }

##  ## Add by Zoe Cheung on 21 Oct ##
  dimension: Account_Plan_Tab_link {
    type: string
    sql:  CONCAT(1,2);;
    html: <div style="border-radius: 5px; padding: 5px 10px; background: #808080; height: 60px; color: red;">
        <nav style="font-size: 18px;">
        <a style="color: #FFFFFF; padding: 5px 15px; float: left; line-height: 40px;font-weight: bold; cursor: not-allowed; " href="https://onelinedev.cloud.looker.com/dashboards-next/202?Trade={{ _filters['of_consolidated.svc_scp_grp_cd'] | url_encode }}&Fiscal%20Year={{ _filters['of_sales_week_master.fiscal_year'] | url_encode }}&Sales%20Week={{ _filters['of_sales_week_master.sales_week'] | url_encode }}&Sales%20Month={{ _filters['of_sales_week_master.sales_month'] | url_encode }}&Customer%20Group={{ _filters['of_customer_group.cust_grp_and_name'] | url_encode }}&CIF%2FFOB={{ _filters['of_consolidated.gsym_cif_fob'] | url_encode }}&Revenue%20VVD={{ _filters['of_consolidated.rev_vvd'] | url_encode }}&Service%20Lane%20(Rev)= {{ _filters['of_consolidated.slane_cd'] | url_encode }}&Svc%2FRFA%20No={{ _filters['of_consolidated.svc_cont_no'] | url_encode }}&Contract%20Length={{ _filters['of_svc_contract.ctrt_dur_tp_cd'] | url_encode }}&AP%20Submission%20Office={{ _filters['of_consolidated.ctrt_scp_srep_ofc_cd'] | url_encode }}&AP%20Submission%20Country={{ _filters['ap_submission_country.country_name'] | url_encode }}&Contract%20(Header)= {{ _filters['of_consolidated.ctrt_prop_ofc_cd'] | url_encode }}&DOM%20%2FNon-DOM={{ _filters['of_consolidated.dominant_flg'] | url_encode }}&Loading%20Country={{ _filters['loading_country.country_name'] | url_encode }}&Loading%20Office={{ _filters['of_consolidated.ob_sls_ofc_cd'] | url_encode }}&Customer%20Segmentation={{ _filters['of_customer_group.key_acct_tp_cd'] | url_encode }}&Group%20Customer%20Region={{ _filters['of_customer_group.key_acct_rgn_cd'] | url_encode }}&Group%20Customer%20Country={{ _filters['of_customer_group.key_acct_cnt_name'] | url_encode }}&Show%20%2F%20Hide%20CM={{ _filters['of_consolidated.show_or_hide_cm'] | url_encode }}&Timeline%20Granularity={{ _filters['of_sales_week_master.timeframe_picker'] | url_encode }}&Show%20%2F%20Hide%20Target={{ _filters['of_consolidated.show_or_hide_target'] | url_encode }}&Calendar%20Year={{ _filters['of_sales_week_master.calendar_year'] | url_encode }}&SVC%2FRFA%20Owner%27s%20Office={{ _filters['of_customer_owner.office_code'] | url_encode }}&SVC%2FRFA%20Owner%27s%20RHQ={{ _filters['of_customer_owner.regional_head_office'] | url_encode }}&Svc%2FRFA%20Owner={{ _filters['of_user.full_name'] | url_encode }}&Via%20ONE%20Quote={{ _filters['of_consolidated.is_one_quotation'] | url_encode }}&Service%20Scope%20Code={{ _filters['of_svc_scp.service_scope_code_and_name'] | url_encode }}" target="_blank" > Overview </a>
        <a style="color: #efefef; padding: 5px 15px; float: left; line-height: 40px;" href="https://onelinedev.cloud.looker.com/dashboards-next/258?Trade={{ _filters['of_consolidated.svc_scp_grp_cd'] | url_encode }}&Fiscal%20Year={{ _filters['of_sales_week_master.fiscal_year'] | url_encode }}&Sales%20Week={{ _filters['of_sales_week_master.sales_week'] | url_encode }}&Sales%20Month={{ _filters['of_sales_week_master.sales_month'] | url_encode }}&Customer%20Group={{ _filters['of_customer_group.cust_grp_and_name'] | url_encode }}&CIF%2FFOB={{ _filters['of_consolidated.gsym_cif_fob'] | url_encode }}&Revenue%20VVD={{ _filters['of_consolidated.rev_vvd'] | url_encode }}&Service%20Lane%20(Rev)= {{ _filters['of_consolidated.slane_cd'] | url_encode }}&Svc%2FRFA%20No={{ _filters['of_consolidated.svc_cont_no'] | url_encode }}&Contract%20Length={{ _filters['of_svc_contract.ctrt_dur_tp_cd'] | url_encode }}&AP%20Submission%20Office={{ _filters['of_consolidated.ctrt_scp_srep_ofc_cd'] | url_encode }}&AP%20Submission%20Country={{ _filters['ap_submission_country.country_name'] | url_encode }}&Contract%20(Header)= {{ _filters['of_consolidated.ctrt_prop_ofc_cd'] | url_encode }}&DOM%20%2FNon-DOM={{ _filters['of_consolidated.dominant_flg'] | url_encode }}&Loading%20Country={{ _filters['loading_country.country_name'] | url_encode }}&Loading%20Office={{ _filters['of_consolidated.ob_sls_ofc_cd'] | url_encode }}&Customer%20Segmentation={{ _filters['of_customer_group.key_acct_tp_cd'] | url_encode }}&Group%20Customer%20Region={{ _filters['of_customer_group.key_acct_rgn_cd'] | url_encode }}&Group%20Customer%20Country={{ _filters['of_customer_group.key_acct_cnt_name'] | url_encode }}&Show%20%2F%20Hide%20CM={{ _filters['of_consolidated.show_or_hide_cm'] | url_encode }}&Timeline%20Granularity={{ _filters['of_sales_week_master.timeframe_picker'] | url_encode }}&Show%20%2F%20Hide%20Target={{ _filters['of_consolidated.show_or_hide_target'] | url_encode }}&Calendar%20Year={{ _filters['of_sales_week_master.calendar_year'] | url_encode }}&SVC%2FRFA%20Owner%27s%20Office={{ _filters['of_customer_owner.office_code'] | url_encode }}&SVC%2FRFA%20Owner%27s%20RHQ={{ _filters['of_customer_owner.regional_head_office'] | url_encode }}&Svc%2FRFA%20Owner={{ _filters['of_user.full_name'] | url_encode }}&Via%20ONE%20Quote={{ _filters['of_consolidated.is_one_quotation'] | url_encode }}&Service%20Scope%20Code={{ _filters['of_svc_scp.service_scope_code_and_name'] | url_encode }}" target="_blank" > Raw Data </a>
         </nav>
       </div>
  ;;
  }

  dimension: Account_Plan_Tab_link2 {
    type: string
    sql:  CONCAT(1,2);;
    html: <div style="border-radius: 5px; padding: 5px 10px; background: #808080; height: 60px; color: red;">
        <nav style="font-size: 18px;">
        <a style="olor: #efefef; padding: 5px 15px; float: left; line-height: 40px; " href="https://onelinedev.cloud.looker.com/dashboards-next/202?Trade={{ _filters['of_consolidated.svc_scp_grp_cd'] | url_encode }}&Fiscal%20Year={{ _filters['of_sales_week_master.fiscal_year'] | url_encode }}&Sales%20Week={{ _filters['of_sales_week_master.sales_week'] | url_encode }}&Sales%20Month={{ _filters['of_sales_week_master.sales_month'] | url_encode }}&Customer%20Group={{ _filters['of_customer_group.cust_grp_and_name'] | url_encode }}&CIF%2FFOB={{ _filters['of_consolidated.gsym_cif_fob'] | url_encode }}&Revenue%20VVD={{ _filters['of_consolidated.rev_vvd'] | url_encode }}&Service%20Lane%20(Rev)= {{ _filters['of_consolidated.slane_cd'] | url_encode }}&Svc%2FRFA%20No={{ _filters['of_consolidated.svc_cont_no'] | url_encode }}&Contract%20Length={{ _filters['of_svc_contract.ctrt_dur_tp_cd'] | url_encode }}&AP%20Submission%20Office={{ _filters['of_consolidated.ctrt_scp_srep_ofc_cd'] | url_encode }}&AP%20Submission%20Country={{ _filters['ap_submission_country.country_name'] | url_encode }}&Contract%20(Header)= {{ _filters['of_consolidated.ctrt_prop_ofc_cd'] | url_encode }}&DOM%20%2FNon-DOM={{ _filters['of_consolidated.dominant_flg'] | url_encode }}&Loading%20Country={{ _filters['loading_country.country_name'] | url_encode }}&Loading%20Office={{ _filters['of_consolidated.ob_sls_ofc_cd'] | url_encode }}&Customer%20Segmentation={{ _filters['of_customer_group.key_acct_tp_cd'] | url_encode }}&Group%20Customer%20Region={{ _filters['of_customer_group.key_acct_rgn_cd'] | url_encode }}&Group%20Customer%20Country={{ _filters['of_customer_group.key_acct_cnt_name'] | url_encode }}&Show%20%2F%20Hide%20CM={{ _filters['of_consolidated.show_or_hide_cm'] | url_encode }}&Timeline%20Granularity={{ _filters['of_sales_week_master.timeframe_picker'] | url_encode }}&Show%20%2F%20Hide%20Target={{ _filters['of_consolidated.show_or_hide_target'] | url_encode }}&Calendar%20Year={{ _filters['of_sales_week_master.calendar_year'] | url_encode }}&SVC%2FRFA%20Owner%27s%20Office={{ _filters['of_customer_owner.office_code'] | url_encode }}&SVC%2FRFA%20Owner%27s%20RHQ={{ _filters['of_customer_owner.regional_head_office'] | url_encode }}&Svc%2FRFA%20Owner={{ _filters['of_user.full_name'] | url_encode }}&Via%20ONE%20Quote={{ _filters['of_consolidated.is_one_quotation'] | url_encode }}&Service%20Scope%20Code={{ _filters['of_svc_scp.service_scope_code_and_name'] | url_encode }}" target="_blank" > Overview </a>
        <a style="color: #FFFFFF; padding: 5px 15px; float: left; line-height: 40px;font-weight: bold; cursor: not-allowed;" href="https://onelinedev.cloud.looker.com/dashboards-next/258?Trade={{ _filters['of_consolidated.svc_scp_grp_cd'] | url_encode }}&Fiscal%20Year={{ _filters['of_sales_week_master.fiscal_year'] | url_encode }}&Sales%20Week={{ _filters['of_sales_week_master.sales_week'] | url_encode }}&Sales%20Month={{ _filters['of_sales_week_master.sales_month'] | url_encode }}&Customer%20Group={{ _filters['of_customer_group.cust_grp_and_name'] | url_encode }}&CIF%2FFOB={{ _filters['of_consolidated.gsym_cif_fob'] | url_encode }}&Revenue%20VVD={{ _filters['of_consolidated.rev_vvd'] | url_encode }}&Service%20Lane%20(Rev)= {{ _filters['of_consolidated.slane_cd'] | url_encode }}&Svc%2FRFA%20No={{ _filters['of_consolidated.svc_cont_no'] | url_encode }}&Contract%20Length={{ _filters['of_svc_contract.ctrt_dur_tp_cd'] | url_encode }}&AP%20Submission%20Office={{ _filters['of_consolidated.ctrt_scp_srep_ofc_cd'] | url_encode }}&AP%20Submission%20Country={{ _filters['ap_submission_country.country_name'] | url_encode }}&Contract%20(Header)= {{ _filters['of_consolidated.ctrt_prop_ofc_cd'] | url_encode }}&DOM%20%2FNon-DOM={{ _filters['of_consolidated.dominant_flg'] | url_encode }}&Loading%20Country={{ _filters['loading_country.country_name'] | url_encode }}&Loading%20Office={{ _filters['of_consolidated.ob_sls_ofc_cd'] | url_encode }}&Customer%20Segmentation={{ _filters['of_customer_group.key_acct_tp_cd'] | url_encode }}&Group%20Customer%20Region={{ _filters['of_customer_group.key_acct_rgn_cd'] | url_encode }}&Group%20Customer%20Country={{ _filters['of_customer_group.key_acct_cnt_name'] | url_encode }}&Show%20%2F%20Hide%20CM={{ _filters['of_consolidated.show_or_hide_cm'] | url_encode }}&Timeline%20Granularity={{ _filters['of_sales_week_master.timeframe_picker'] | url_encode }}&Show%20%2F%20Hide%20Target={{ _filters['of_consolidated.show_or_hide_target'] | url_encode }}&Calendar%20Year={{ _filters['of_sales_week_master.calendar_year'] | url_encode }}&SVC%2FRFA%20Owner%27s%20Office={{ _filters['of_customer_owner.office_code'] | url_encode }}&SVC%2FRFA%20Owner%27s%20RHQ={{ _filters['of_customer_owner.regional_head_office'] | url_encode }}&Svc%2FRFA%20Owner={{ _filters['of_user.full_name'] | url_encode }}&Via%20ONE%20Quote={{ _filters['of_consolidated.is_one_quotation'] | url_encode }}&Service%20Scope%20Code={{ _filters['of_svc_scp.service_scope_code_and_name'] | url_encode }}" target="_blank" > Raw Data </a>
         </nav>
       </div>
  ;;
  }


  set: primary_key {
    fields: [record_id, count]
  }
}

view: of_account_plan_grfa_grp {
  sql_table_name: `ONEFORCE.OF_ACCOUNT_PLAN_GRFA_GRP`
    ;;

  dimension: record_id {
    label: "Record Id"  # programmatically added by LookML modifier
    description: "By GENERATE_UUID()"
    primary_key: yes
    type: string
    sql: ${TABLE}.Record_Id ;;
  }

  dimension: cust_contract_no {
    label: "Cust Contract No."  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Cust_Contract_No ;;
  }

  dimension: is_unique_group {
    label: "Is Unique Group"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Is_Unique_Group ;;
  }

  dimension: opus_cust_grp_code {
    label: "OPUS Cust Grp Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.OPUS_Cust_Grp_Code ;;
  }

  dimension: sbc_cust_grp_id {
    label: "SBC Cust Grp Id"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SBC_Cust_Grp_Id ;;
  }

  dimension: sbc_cust_grp_name {
    label: "SBC Cust Grp Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SBC_Cust_Grp_Name ;;
  }

  dimension: trade_code {
    label: "Trade Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Trade_Code ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [sbc_cust_grp_name]
  }

  set: primary_key {
    fields: [record_id, count]
  }
}

# include: "oneforce.model.lkml"
# include: "/views/of_consolidated.view.lkml"
# include: "/views/of_customer_group.view.lkml"
# include: "/views/of_sales_week_master.view.lkml"

view: of_account_plan_rowtot_sort {
  derived_table: {
    explore_source: account_plan {
      column: cust_grp_id { field: of_customer_group.cust_grp_id }
      column: cust_grp_nm { field: of_customer_group.cust_grp_nm }
      #column: sales_week { field: of_sales_week_master.sales_week }
      column: deviation { field: of_consolidated.deviation }
      derived_column: deviation_total {
        sql: SUM(deviation) over (partition by cust_grp_id) ;;
      }
      bind_all_filters: yes
    }
  }
  dimension: cust_grp_id {
    label: "Customer Group Code"
    description: ""
  }
  dimension: cust_grp_nm {
    label: "Customer Group Code Customer Group Name"
    description: ""
  }
  dimension: sales_week {
    label: "Sales Week"
    description: ""
  }
  dimension: deviation {
    label: "Deviation"
    description: ""
    value_format: "#,##0"
    type: number
  }
  dimension: deviation_total {
    label: "Total Deviation"
    description: ""
    value_format: "#,##0"
    type: number
  }
}

view: of_actuals {
  derived_table: {
    sql:
      SELECT of_actuals.*
         -- add by Helen on 2021.12.28 for DCN-491
      , coalesce(of_svc_contract.cust_cd, of_actuals.cnt_cust_cd) as CNT_CUST_CD2
      , v_customer_opus_n_prospect.cust_grp_id as CUST_GRP_CD2
      , v_customer_opus_n_prospect.name as CNT_CUST_NM2
      , v_customer_opus_n_prospect.cust_grp_nm as CUST_GRP_NM2
    -- end 2021.12.28 for DCN-491
      FROM `ONEFORCE.OF_ACTUALS` as of_actuals
           -- add by Helen on 2021.12.28 for DCN-491
      LEFT JOIN ${of_svc_contract.SQL_TABLE_NAME} as of_svc_contract ON of_actuals.svc_cont_no = of_svc_contract.sc_rfa_no
      LEFT JOIN (
          SELECT distinct vv.cust_cd, vv.name, vv.cust_grp_id, g.cust_grp_nm
          FROM ${v_customer_opus_n_prospect.SQL_TABLE_NAME} vv,
               ${of_customer_group.SQL_TABLE_NAME} g
          WHERE vv.cust_grp_id = g.cust_grp_id
        ) as v_customer_opus_n_prospect
      ON coalesce(of_svc_contract.cust_cd, of_actuals.cnt_cust_cd) = v_customer_opus_n_prospect.cust_cd
      -- end change on 2021.12.28 for DCN-491
      WHERE bkg_no IS NOT NULL AND bkg_no != '' ;;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: concat(${bkg_no}, ${cntr_tpsz_cd}) ;;
  }

  dimension: ac_com_amt {
    label: "Agency" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.AC_COM_AMT as NUMERIC) ;;
  }

  dimension: ac_fac_amt {
    label: "Brokerage." # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.AC_FAC_AMT as NUMERIC) ;;
  }

  dimension_group: act_arr_dt {
    label: "Actual Arrival Datetime - Final Dsch. Port" # programmatically added by LookML modifier
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.ACT_ARR_DT ;;
  }

  dimension_group: act_dep_dt {
    label: "Actual Depature Datetime - 1st Load Port" # programmatically added by LookML modifier
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.ACT_DEP_DT ;;
  }

  dimension: act_mty_pkup_scc_cd {
    label: "Actual Empty Pick Up SCC Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.ACT_MTY_PKUP_SCC_CD ;;
  }

  dimension: act_mty_pkup_yd_cd {
    label: "Actual Empty Pick Up Yard Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.ACT_MTY_PKUP_YD_CD ;;
  }

  dimension: actual_cust_cd {
    label: "Actual Customer Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.ACTUAL_CUST_CD ;;
  }

  dimension: actual_cust_nm {
    label: "Actual Customer Name" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.ACTUAL_CUST_NM ;;
  }

  dimension: aft_curr_cd {
    label: "AFT CURR CD"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.AFT_CURR_CD ;;
  }

  dimension: aft_expt_dc_amt {
    label: "AFT EXPT DC AMT"  # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.AFT_EXPT_DC_AMT ;;
  }

  dimension: aft_expt_dc_amt_usd {
    label: "Additional deduction based on DAR after Booking, in USD"  # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.AFT_EXPT_DC_AMT_USD ;;
  }

  dimension: avg_rpb_flg {
    label: "Avg RPB Flag (Y/N)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.AVG_RPB_FLG ;;
  }

  dimension: bil_amt {
    label: "BIL AMT"  # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.BIL_AMT ;;
  }

  dimension: bil_curr_cd {
    label: "BIL CURR CD"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BIL_CURR_CD ;;
  }

  dimension: bill_amt_usd {
    label: "Final billable amount for Per Diem in USD"  # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.BILL_AMT_USD ;;
  }

  dimension: bkg_cgo_wgt {
    label: "Gross weight."  # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.BKG_CGO_WGT ;;
  }

  dimension: bkg_cgo_wgt_teu {
    label: "Gross weight per TEU" # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.BKG_CGO_WGT_TEU ;;
  }

  dimension: bkg_del_conti {
    label: "To Continent" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_DEL_CONTI ;;
  }

  dimension: bkg_mty_rtn_scc_cd {
    label: "Empty Return SCC Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_MTY_RTN_SCC_CD ;;
  }

  dimension: bkg_no {
    view_label: "B/L Information"
    label: "BKG Number"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_NO ;;
    hidden: yes
  }

  dimension: bkg_ofc_cd {
    view_label: "Office Information"
    label: "Booking Office Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_OFC_CD ;;
  }

  dimension: bkg_ofc_cnt_cd {
    view_label: "Office Information"
    label: "BKG Office Country Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_OFC_CNT_CD ;;
  }

  dimension: bkg_ofc_cnt_nm {
    view_label: "Office Information"
    label: "BKG Office Country Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_OFC_CNT_NM ;;
  }

  dimension: bkg_oft_rev {
    label: "Freight Revenue"  # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.BKG_OFT_REV as NUMERIC) ;;
  }

  dimension: bkg_por_conti {
    label: "From Continent" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_POR_CONTI ;;
  }

  dimension: bkg_sts_cd {
    view_label: "B/L Information"
    label: "BKG Status Code" # programmatically added by LookML modifier
    type: string
    sql: CAST(${TABLE}.BKG_STS_CD as STRING) ;;
  }

  dimension: bkg_teu {
    label: "TEU"  # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.BKG_TEU ;;
  }

  dimension: bl_no {
    label: "Bill of Lading number." # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BL_NO ;;
  }

  dimension: cgo_ntr_cd {
    label: "Cargo Nature Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CGO_NTR_CD ;;
  }

  dimension: cgo_ntr_nm {
    label: "Cargo Nature Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CGO_NTR_NM ;;
  }

  dimension: cif_fob_split_cd {
    label: "CIF / FOB Split Code (Obsoluete)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CIF_FOB_SPLIT_CD ;;
  }

  dimension: cm_amt2 {
    label: "CM (EPP B)."  # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.CM_AMT2 as NUMERIC);;
  }

  dimension: cmd_expt_amt_usd {
    label: "Deduction by commodity exception, in USD" # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.CMD_EXPT_AMT_USD ;;
  }

  dimension: cmdt_cd {
    label: "Commodity Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CMDT_CD ;;
  }

  dimension: cmdt_nm {
    label: "Commodity label"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CMDT_NM ;;
  }

  dimension: cnee_cust_cd {
    label: "Consignee code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CNEE_CUST_CD ;;
  }

  dimension: cnee_cust_nm {
    label: "Consignee name" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CNEE_CUST_NM ;;
  }

  dimension: cnt_cust_cd {
    label: "Contract Party Customer Code" # programmatically added by LookML modifier
    type: string
    # change for DCN-491
    #sql: ${TABLE}.CNT_CUST_CD ;;
    sql: ${TABLE}.CNT_CUST_CD2 ;;
    # end change DCN-491
  }

  dimension: cnt_cust_nm {
    label: "Contract Party Customer Name" # programmatically added by LookML modifier
    type: string
    # change for DCN-491
    #sql: ${TABLE}.CNT_CUST_NM ;;
    sql: ${TABLE}.CNT_CUST_NM2 ;;
    # end change DCN-491
  }

  dimension: cntr {
    label: "CNTR" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.CNTR as NUMERIC) ;;
  }

  dimension: cntr_lterm_pa_amt {
    label: "Container Fixed Cost (Per Diem)"  # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.CNTR_LTERM_PA_AMT as NUMERIC) ;;
  }

  dimension: cntr_qty {
    label: "Container Quantity" # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.CNTR_QTY ;;
  }

  dimension: cntr_tpsz_cd {
    view_label: "B/L Information"
    label: "Container Type Size Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CNTR_TPSZ_CD ;;
    hidden: yes
  }

  dimension: col_chg_amt {
    label: "Collect Ocean Freight Revenue"  # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.COL_CHG_AMT as NUMERIC);;
  }

  dimension_group: cont_effective_dt {
    label: "Customer contract effective date" # programmatically added by LookML modifier
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CONT_EFFECTIVE_DT ;;
  }

  dimension_group: cont_expiry_dt {
    label: "Customer contract expiry date"  # programmatically added by LookML modifier
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CONT_EXPIRY_DT ;;
  }

  dimension: cont_period_typ_cd {
    label: "Contract Period Type Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CONT_PERIOD_TYP_CD ;;
  }

  dimension: cop_cd {
    label: "Collect payer code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.COP_CD ;;
  }

  dimension: cop_nm {
    label: "Collect payer name" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.COP_NM ;;
  }

  dimension: crm_if_flg {
    label: "Contract Cust [Track in CRM] Indicator" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CRM_IF_FLG ;;
  }

  dimension: crm_removal_flg {
    label: "CRM Remove Flag - a programmatic control field to identify lifting records not longer qualified for OUPS-CRM interfaace"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CRM_REMOVAL_FLG ;;
  }

  dimension: ctrt_prop_ofc_cd {
    view_label: "Office Information"
    label: "Contract sales rep office code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_PROP_OFC_CD ;;
  }

  dimension: ctrt_prop_ofc_nm {
    view_label: "Office Information"
    label: "Service Contract Sales Rep Office Name" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_PROP_OFC_NM ;;
  }

  dimension: ctrt_prop_srep_eml {
    label: "Service Contract Sales Rep Email" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_PROP_SREP_EML ;;
  }

  dimension: ctrt_prop_srep_nm {
    label: "Service Contract Sales Rep" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_PROP_SREP_NM ;;
  }

  dimension: ctrt_scp_srep_eml {
    label: "S/C Service Scope Sales Rep Email"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_SCP_SREP_EML ;;
  }

  dimension: ctrt_scp_srep_nm {
    label: "S/C Service Scope Sales Rep"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_SCP_SREP_NM ;;
  }

  dimension: ctrt_scp_srep_ofc_cd {
    view_label: "Office Information"
    label: "Service Scope sale rep office code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_SCP_SREP_OFC_CD ;;
  }

  dimension: ctrt_scp_srep_ofc_nm {
    view_label: "Office Information"
    label: "S/C Service Scope Sales Rep Office Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_SCP_SREP_OFC_NM ;;
  }

  dimension: cust_grp_cd {
    label: "Contract Party Customer Group Code" # programmatically added by LookML modifier
    type: string
    # change for DCN-491
    #sql: ${TABLE}.CUST_GRP_CD ;;
    sql: ${TABLE}.CUST_GRP_CD2 ;;
    # end change DCN-491
  }

  dimension: cust_grp_nm {
    label: "Contract Party Customer Group Name" # programmatically added by LookML modifier
    type: string
    # change for DCN-491
    #sql: ${TABLE}.CUST_GRP_NM ;;
    sql: ${TABLE}.CUST_GRP_NM2 ;;
    # end change DCN-491
  }

  dimension: dcgo_flg {
    label: "Hazardous Commodity Indicator"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DCGO_FLG ;;
  }

  dimension: de_term_cd {
    label: "CY / Door (Destination)"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DE_TERM_CD ;;
  }

  dimension: del_cd {
    label: "Place of delivery code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DEL_CD ;;
  }

  dimension: del_cnt {
    label: "Destination Country"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DEL_CNT ;;
  }

  dimension: del_nm {
    label: "Place of Delivery Name" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DEL_NM ;;
  }

  dimension: dest_trns_svc_mod_cd {
    label: "IB Service Mode Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DEST_TRNS_SVC_MOD_CD ;;
  }

  dimension: dir_cd {
    label: "Direction Code (N/S/E/W)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DIR_CD ;;
  }

  dimension: dominant_flg {
    label: "Dom/Non-dominant Indicator (Y/N)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DOMINANT_FLG ;;
  }

  dimension: ete_dys {
    label: "End to End Shipment Transit Days" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.ETE_DYS as NUMERIC);;
  }

  dimension: fi {
    label: "FI" # programmatically added by LookML modifier
    type: number
    sql: cast(${TABLE}.FI as NUMERIC) ;;
  }

  dimension: final_pod_cd {
    label: "Final discharge port code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.FINAL_POD_CD ;;
  }

  dimension: frt_term_cd {
    label: "Prepaid / Collect Payer Indicator (P/C)"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.FRT_TERM_CD ;;
  }

  dimension: frwd_cust_cd {
    label: "Forwarder code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.FRWD_CUST_CD ;;
  }

  dimension: frwd_cust_nm {
    label: "Forwarder name" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.FRWD_CUST_NM ;;
  }

  dimension: ib_mty_pa_amt {
    label: "IB EPP A" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.IB_MTY_PA_AMT AS NUMERIC) ;;
  }

  dimension: ib_mty_pa_amt2 {
    label: "IB EPP B" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.IB_MTY_PA_AMT2 AS NUMERIC) ;;
  }

  dimension: imdg_clss_cd {
    label: "IMDG Class Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.IMDG_CLSS_CD ;;
  }

  dimension: imdg_pck_grp_cd {
    label: "IMDG Pack Grp Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.IMDG_PCK_GRP_CD ;;
  }

  dimension: imdg_un_no {
    label: "IMDG UN No."  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.IMDG_UN_NO ;;
  }

  dimension: ioc_cd {
    label: "IOC Code (I/O)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.IOC_CD ;;
  }

  dimension: ld {
    label: "LD" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.LD as NUMERIC) ;;
  }

  dimension: lst_vvd_cd {
    label: "Last VVD Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.LST_VVD_CD ;;
  }

  dimension: misc_rev {
    label: "Miscellaneous Revenue"  # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.MISC_REV as NUMERIC) ;;
  }

  dimension: misc_rev_teu {
    label: "Per TEU - Miscellaneous Revenue"  # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.MISC_REV_TEU AS NUMERIC) ;;
  }

#  dimension: month {
#    label: "MONTH (do not use)"  # programmatically added by LookML modifier
#    type: string
#    sql: ${TABLE}.MONTH ;;
#  }

  dimension: mty_pkup_scc_cd {
    label: "Empty Pick Up SCC Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.MTY_PKUP_SCC_CD ;;
  }

  dimension: mty_rtn_scc_cd {
    label: "Actual Empty Return SCC Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.MTY_RTN_SCC_CD ;;
  }

  dimension: mty_rtn_yd_cd {
    label: "Empty Return Yard Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.MTY_RTN_YD_CD ;;
  }

  dimension: n1st_finc_vvd_cd {
    label: "First VVD code."  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.N1ST_FINC_VVD_CD ;;
  }

  dimension: n1st_pod_cd {
    label: "First Discharge Port" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.N1ST_POD_CD ;;
  }

  dimension: n1st_pol_cd {
    label: "First Load Port"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.N1ST_POL_CD ;;
  }

  dimension: n1st_rlane_cd {
    label: "N1ST RLANE CD"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.N1ST_RLANE_CD ;;
  }

  dimension: ncust_cd {
    label: "Notify Party 1 code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.NCUST_CD ;;
  }

  dimension: ncust_lgl_eng_nm {
    label: "Notify Party 1 name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.NCUST_LGL_ENG_NM ;;
  }

  dimension: ntlt_grp_nm {
    label: "SC/RFA Customer Nationality Group"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.NTLT_GRP_NM ;;
  }

  dimension: ob_mty_pa_amt {
    label: "OB EPP A" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.OB_MTY_PA_AMT as NUMERIC) ;;
  }

  dimension: ob_mty_pa_amt2 {
    label: "OB EPP B" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.OB_MTY_PA_AMT2 as NUMERIC) ;;
  }

  dimension: ob_ofc_nm {
    view_label: "Office Information"
    label: "Loading Sales Rep Name" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.OB_OFC_NM ;;
  }

  dimension: ob_sls_ofc_cd {
    view_label: "Office Information"
    label: "Loading sales rep office code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.OB_SLS_OFC_CD ;;
  }

  dimension: ob_srep_cd {
    label: "Loading Sales Rep Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.OB_SREP_CD ;;
  }

  dimension: ob_srep_eml {
    label: "Loading Sales Rep Email"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.OB_SREP_EML ;;
  }

  dimension: ob_srep_nm {
    label: "Loading Sales Rep"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.OB_SREP_NM ;;
  }

  dimension_group: obl_iss_dt {
    label: "B/L Issue Date" # programmatically added by LookML modifier
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.OBL_ISS_DT ;;
  }

  dimension: ofr_col_per_teu {
    type: number
    sql: CAST(${TABLE}.OFR_COL_PER_TEU as NUMERIC) ;;
  }

  dimension: ofr_ppd_per_teu {
    type: number
    sql: CAST(${TABLE}.OFR_PPD_PER_TEU as NUMERIC) ;;
  }

  dimension: oft_rev_scg {
    label: "Freight Revenue (OFT+Surcharge Total)"  # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.OFT_REV_SCG as NUMERIC) ;;
  }

  dimension: oft_rev_scg_teu {
    label: "Per TEU - Freight Revenue (OFT+Surcharge Total)"  # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.OFT_REV_SCG_TEU as NUMERIC) ;;
  }

  dimension_group: onboard_dt {
    label: "Onboard Date" # programmatically added by LookML modifier
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.ONBOARD_DT ;;
  }

  dimension: org_chg_amt {
    label: "Charges based on Tariff"  # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.ORG_CHG_AMT ;;
  }

  dimension: org_chg_amt_usd {
    label: "Per Diem charges calculated based on Tariff in USD" # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.ORG_CHG_AMT_USD ;;
  }

  dimension: org_curr_cd {
    label: "Charges based on Tariff - Currency" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.ORG_CURR_CD ;;
  }

  dimension: org_trns_svc_mod_cd {
    label: "OB Service Mode Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.ORG_TRNS_SVC_MOD_CD ;;
  }

  dimension: ori_cnt {
    label: "Origin Country" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.ORI_CNT ;;
  }

  dimension: ovr_void_slt_qty_teu {
    label: "Void TEU" # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.OVR_VOID_SLT_QTY_TEU ;;
  }

  dimension: pa_cm_amt {
    label: "CM (EPP A)" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.PA_CM_AMT as NUMERIC) ;;
  }

  dimension: pa_cm_amt_teu {
    label: "CM Per TEU (EPP A)" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.PA_CM_AMT_TEU as NUMERIC) ;;
  }

  dimension: pa_cm_cost_ttl_amt {
    label: "Total Cost" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.PA_CM_COST_TTL_AMT as NUMERIC) ;;
  }

  dimension: pa_cm_cost_ttl_amt_teu {
    label: "Cost per TEU" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.PA_CM_COST_TTL_AMT_TEU as NUMERIC) ;;
  }

  dimension: pck_tp_cd {
    label: "Package type" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.PCK_TP_CD ;;
  }

  dimension: pod_loc_cd {
    label: "Trunk POD Location Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.POD_LOC_CD ;;
  }

  dimension: pod_loc_nm {
    label: "Trunk POD Location Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.POD_LOC_NM ;;
  }

  dimension: pol_loc_cd {
    label: "Trunk POL Location Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.POL_LOC_CD ;;
  }

  dimension: pol_loc_nm {
    label: "Trunk POL Location Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.POL_LOC_NM ;;
  }

  dimension: por_cd {
    label: "Place of receipt code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.POR_CD ;;
  }

  dimension: por_nm {
    label: "Place of Receipt Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.POR_NM ;;
  }

  dimension: ppd_chg_amt {
    label: "Prepaid Ocean Freight Revenue"  # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.PPD_CHG_AMT as. NUMERIC);;
  }

  dimension: ppp_cd {
    label: "Pre-paid Payer code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.PPP_CD ;;
  }

  dimension: ppp_nm {
    label: "Pre-paid Payer Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.PPP_NM ;;
  }

  dimension: pre_bl_no {
    label: "Previous BL No" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.PRE_BL_NO ;;
  }

  dimension: quarter {
    label: "QUARTER (do not use)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.QUARTER ;;
  }

  dimension: rcv_term_cd {
    label: "CY / Door (Origin)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.RCV_TERM_CD ;;
  }

  dimension: rd_cgo_flg {
    label: "Reefer As Dry Indicator"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.RD_CGO_FLG ;;
  }

  dimension: rep_trd_cd {
    label: "Representative Trade" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.REP_TRD_CD ;;
  }

  dimension: rev_mon {
    label: "Revenue Month"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.REV_MON ;;
  }

  dimension: rev_ttl {
    label: "Revenue Total"  # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.REV_TTL as NUMERIC) ;;
  }

  dimension: rev_ttl_teu {
    label: "Per TEU - Revenue Total"  # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.REV_TTL_TEU as NUMERIC) ;;
  }

  dimension: rlane_cd {
    label: "Revenue Lane code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.RLANE_CD ;;
  }

  dimension: sc_curr_cd {
    label: "SC CURR CD" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SC_CURR_CD ;;
  }

  dimension: sc_rfa_ctrt_tp_nm {
    label: "SC/RFA Contract Type (RFA, TAA, S/C)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SC_RFA_CTRT_TP_NM ;;
  }

  dimension: sc_rfa_expt_amt {
    label: "Charges based on RFA/SC exception"  # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.SC_RFA_EXPT_AMT ;;
  }

  dimension: sc_rfa_expt_amt_usd {
    label: "Deduction based on RFA/SC exception, in USD"  # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.SC_RFA_EXPT_AMT_USD ;;
  }

  dimension: sc_rfa_sls_rep_ofc_cnt_cd {
    view_label: "Office Information"
    label: "SC/RFA Customer Sales Rep Office Country Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SC_RFA_SLS_REP_OFC_CNT_CD ;;
  }

  dimension: sc_rfa_sls_rep_ofc_cnt_nm {
    view_label: "Office Information"
    label: "SC/RFA Customer Sales Rep Office Country Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SC_RFA_SLS_REP_OFC_CNT_NM ;;
  }

  dimension: shpr_cust_cd {
    label: "Shipper code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SHPR_CUST_CD ;;
  }

  dimension: shpr_cust_nm {
    label: "Shipper name" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SHPR_CUST_NM ;;
  }

  # dimension: slane_cd {
  #   hidden: yes
  #   label: "Service Lane (Rev)"
  #   type: string
  #   sql: ${TABLE}.slane_cd ;;
  # }

  dimension: slane_cd {
    hidden: yes
    label: "Service Lane (Rev)"
    type: string
    sql: substr(${rlane_cd},1,3) ;;
  }

  dimension: sub_trd_cd {
    label: "Sub TRADE Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SUB_TRD_CD ;;
  }

  dimension: svc_cont_no {
    label: "Service contract number." # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SVC_CONT_NO ;;
  }

  dimension: svc_scp_cd {
    label: "Service Scope Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SVC_SCP_CD ;;
  }

  dimension: trd_cd {
    label: "Trade Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.TRD_CD ;;
  }

  dimension: vvd {
    label: "Revenue VVD code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.VVD ;;
  }

  dimension: week {
    label: "Sales Week" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.WEEK ;;
  }

#  dimension: year {
#    label: "YEAR (do not use)" # programmatically added by LookML modifier
#    type: string
#    sql: ${TABLE}.YEAR ;;
#  }


  measure: TotalTeu {
    view_label: "V Customer Opus N Prospect"
    label: "{{ _view._name }}: Total Teu"
    type: sum
    sql: ${bkg_teu};;
  }


  measure: count {
    type: count
    drill_fields: []
  }

  set: primary_key {
    fields: [primary_key, bkg_no, cntr_tpsz_cd, count]
  }

  set: non_consolidated {
    fields: [
      act_arr_dt_date
      , act_arr_dt_month
      , act_arr_dt_quarter
      , act_arr_dt_year
      , act_dep_dt_date
      , act_dep_dt_month
      , act_dep_dt_quarter
      , act_dep_dt_year
      , cont_effective_dt_date
      , cont_effective_dt_month
      , cont_effective_dt_quarter
      , cont_effective_dt_year
      , cont_expiry_dt_date
      , cont_expiry_dt_month
      , cont_expiry_dt_quarter
      , cont_expiry_dt_year
      , obl_iss_dt_date
      , obl_iss_dt_month
      , obl_iss_dt_quarter
      , obl_iss_dt_year
      , onboard_dt_date
      , onboard_dt_month
      , onboard_dt_quarter
      , onboard_dt_year
      , ofr_col_per_teu
      , ofr_ppd_per_teu
    ]
  }
}

view: of_ap_distinct {
  derived_table: {
    sql: select distinct  ap.sales_week  ,
       trade_code, trunk_vvd_service_lane_code, dominant_leg_flag, sc_rfa_number , sc_rfa_customer_group_code
from ${of_account_plan.SQL_TABLE_NAME} as ap
 ;;

    persist_for: "24 hours"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: sales_week {
    type: string
    sql: ${TABLE}.sales_week;;
  }

  dimension: trade_code {
    type: string
    sql: ${TABLE}.trade_code ;;
  }

  dimension: trunk_vvd_service_lane_code {
    type: string
    sql: ${TABLE}.trunk_vvd_service_lane_code ;;
  }

  dimension: dominant_leg_flag {
    type: string
    sql: ${TABLE}.dominant_leg_flag ;;
  }

  dimension: sc_rfa_number {
    type: string
    sql: ${TABLE}.sc_rfa_number ;;
  }

  dimension: sc_rfa_customer_group_code {
    type: string
    sql: ${TABLE}.sc_rfa_customer_group_code ;;
  }

  set: detail {
    fields: [
      sales_week,
      trade_code,
      trunk_vvd_service_lane_code,
      dominant_leg_flag,
      sc_rfa_number,
      sc_rfa_customer_group_code
    ]
  }
}

view: of_audit_responses {
  sql_table_name: `ONEFORCE.OF_AUDIT_RESPONSES`
    ;;

  dimension: accuracy_remarks {
    type: string
    sql: ${TABLE}.Accuracy_Remarks ;;
  }

  dimension: acknowledgement {
    type: string
    sql: ${TABLE}.Acknowledgement ;;
  }

  measure: Avg_acknowledgement {
    type: average
    sql: ${TABLE}.Acknowledgement  ;;
    label: "Average Acknowledgement"
    value_format: "0.00"
  }

  dimension: auditee {
    type: string
    sql: ${TABLE}.Auditee ;;
  }

  dimension: authenticated {
    type: string
    sql: ${TABLE}.Authenticated ;;
  }

  dimension: case_id_chat_information {
    type: string
    sql: ${TABLE}.Case_ID_Chat_Information ;;
  }

  dimension: case_nurturing_score {
    type: string
    sql: ${TABLE}.Case_Nurturing_Score ;;
  }

  dimension: contact_name {
    type: string
    sql: ${TABLE}.Contact_Name ;;
  }

  dimension: contract_customer {
    type: string
    sql: ${TABLE}.Contract_Customer ;;
  }

  dimension: contract_customer_chat_information {
    type: string
    sql: ${TABLE}.Contract_Customer_Chat_Information ;;
  }

  dimension: contract_customer_code_chat_information {
    type: string
    sql: ${TABLE}.Contract_Customer_Code_Chat_Information ;;
  }

  dimension: correct_contact_name {
    type: string
    sql: ${TABLE}.Correct_Contact_Name ;;
  }

  dimension: correct_contract_customer {
    type: string
    sql: ${TABLE}.Correct_Contract_Customer ;;
  }

  dimension: correct_contract_customer_code {
    type: string
    sql: ${TABLE}.Correct_Contract_Customer_Code ;;
  }

  dimension: correct_reference_number {
    type: string
    sql: ${TABLE}.Correct_Reference_Number ;;
  }

  dimension: correct_service_customer {
    type: string
    sql: ${TABLE}.Correct_Service_Customer ;;
  }

  dimension: correct_service_customer_code {
    type: string
    sql: ${TABLE}.Correct_Service_Customer_Code ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.Country ;;
  }

  dimension: customer_email_add_chat_information {
    type: string
    sql: ${TABLE}.Customer_email_add_Chat_Information ;;
  }

  dimension: customer_rating {
    type: string
    sql: ${TABLE}.Customer_Rating ;;
  }

  measure: Customer_good_rating {
    type: average
    sql: CASE WHEN ${TABLE}.Customer_Rating = 'Rated Good' THEN 1 ELSE 0 END;;
    drill_fields: [detail*]
    label: "Rate Good Ratio"
    value_format_name: percent_0
  }



  dimension_group: date {
    type: time
    datatype: datetime
    timeframes: [year, month, week, week_of_year, month_num, month_name, date, raw]
    sql: ${TABLE}.Date ;;
  }

  dimension: dry_run_audit {
    type: string
    sql: ${TABLE}.Dry_Run_Audit ;;
  }

  dimension: email_address {
    type: string
    sql: ${TABLE}.Email_Address ;;
  }

  dimension: followed_solution_skillset {
    type: string
    sql: ${TABLE}.Followed_Solution_Skillset ;;
    label: "Solution Skillset"
  }

  measure: Avg_followed_solution_skillset {
    type: average
    sql: ${TABLE}.Followed_Solution_Skillset  ;;
    label: "Average Followed Solution Skillset"
    value_format: "0.00"
  }

  dimension: how_was_the_closing {
    type: string
    sql: ${TABLE}.How_was_the_Closing ;;
  }

  dimension: how_was_the_opening {
    type: string
    sql: ${TABLE}.How_was_the_Opening ;;
  }

  dimension: hows_opening_and_closing {
    type: string
    sql: ${TABLE}.Hows_opening_and_Closing ;;
  }

  measure: Avg_hows_opening_and_closing {
    type: average
    sql: ${TABLE}.Hows_opening_and_Closing  ;;
    label: "Average Opening and Closing"
    value_format: "0.00"
  }

  dimension: month {
    type: string
    sql: ${TABLE}.Month ;;
  }

  dimension: nam_opus_notes_remarks {
    type: string
    sql: ${TABLE}.NAM_OPUS_Notes_Remarks ;;
  }

  dimension: office_hierarchy {
    type: string
    sql: ${TABLE}.Office_Hierarchy ;;
  }

  dimension: offices {
    type: string
    sql: ${TABLE}.Offices ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.Platform ;;
  }

  dimension: qualify_as_best_practice {
    type: string
    sql: ${TABLE}.Qualify_as_best_practice ;;
  }

  dimension: record_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.Record_ID ;;
  }

  dimension: reference_number {
    type: string
    sql: ${TABLE}.Reference_Number ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: score {
    type: string
    sql: ${TABLE}.Score ;;
    label: "QA Score"
  }

  dimension: service_customer {
    type: string
    sql: ${TABLE}.Service_Customer ;;
  }

  dimension: service_customer_chat_information {
    type: string
    sql: ${TABLE}.Service_Customer_Chat_Information ;;
  }

  dimension: service_customer_code_chat_information {
    type: string
    sql: ${TABLE}.Service_Customer_Code_Chat_Information ;;
  }

  dimension: Timestamp {
    type: string
    sql: ${TABLE}.Timestamp ;;
  }


  dimension: Date_dynamic {
    type: string
    label: "date Dynamic"
    sql:
     {% if timeframe_picker._parameter_value == 'Day' %} ${date_date}
     {% elsif timeframe_picker._parameter_value == 'Week' %} ${Week_1}
     {% elsif timeframe_picker._parameter_value == 'Month' %} ${date_month}
     {% elsif timeframe_picker._parameter_value == 'Year' %} ${date_year}
     {% else %} null {% endif %} ;;
  }


  parameter: timeframe_picker {
    label: "Date Granularity"
    type: unquoted
    allowed_value: { value: "Day" }
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Year" }
    default_value: "Month"
  }

  dimension_group: Date_for_filter {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "Date For Filter"
    sql: ${TABLE}.Date ;;
  }

  dimension: week_number {
    type: string
    sql: ${TABLE}.Week_Number ;;
  }

  dimension: wow_factor {
    type: string
    sql: ${TABLE}.WOW_Factor ;;
  }

  measure: Avg_QA_count {
    type: average
    sql: ${TABLE}.Score  ;;
    label: "Average QA Score"
    drill_fields: [detail*]
    value_format_name: decimal_0
  }

  measure: Avg_case_nurturing_score {
    type: average
    sql: ${TABLE}.Case_Nurturing_Score  ;;
    label: "Average Case Nurturing Score"
    drill_fields: [detail*]
    value_format: "0.00"
  }


  dimension: month_segment {
    type: string
    sql: CASE
          WHEN ${month} ='January' THEN '01'
          WHEN ${month} ='February' THEN '02'
          WHEN ${month} ='March' THEN '03'
          WHEN ${month} ='April' THEN '04'
          WHEN ${month} ='May' THEN '05'
          WHEN ${month} ='June' THEN '06'
          WHEN ${month} ='July' THEN '07'
          WHEN ${month} ='August' THEN '08'
          WHEN ${month} ='September' THEN '09'
          WHEN ${month} ='October' THEN '10'
          WHEN ${month} ='November' THEN '11'
          ELSE '12' END
          ;;
    label: "Month segment"
  }

  dimension: Week_1 {
    type: string
    sql: concat(${date_year},"-",${week_segment}) ;;
  }

  dimension: yearstr {
    type: string
    sql: FORMAT(GETDATE(), 'yy') ;;
  }

  dimension: week_segment {
    type: string
    alpha_sort: yes
    sql: CASE
          WHEN ${week_number} ='Week 1' THEN 'Week 01'
          WHEN ${week_number} ='Week 2' THEN 'Week 02'
          WHEN ${week_number} ='Week 3' THEN 'Week 03'
          WHEN ${week_number} ='Week 4' THEN 'Week 04'
          WHEN ${week_number} ='Week 5' THEN 'Week 05'
          WHEN ${week_number} ='Week 6' THEN 'Week 06'
          WHEN ${week_number} ='Week 7' THEN 'Week 07'
          WHEN ${week_number} ='Week 8' THEN 'Week 08'
          WHEN ${week_number} ='Week 9' THEN 'Week 09'
          ELSE ${week_number} END
          ;;
    label: "Week Segment"
  }


  set: detail {
    fields: [
      region,
      country,
      offices,
      auditee,
      platform,
    ]
  }
}

view: of_booking {
  derived_table: {
    sql:
      SELECT booking.*, coalesce(booking.act_mty_rtn_yd_cd, booking.bkg_mty_rtn_yd_cd) as mty_rtn_yd_cd
    -- add by Helen on 2021.12.28 for DCN-491
      , coalesce(of_svc_contract.cust_cd, booking.ctrt_cust_cd, '<blank>') as CTRT_CUST_CD2
      , v_customer_opus_n_prospect.cust_grp_id as CTRT_CUST_GRP_ID2
      , v_customer_opus_n_prospect.name as CTRT_CUST_NM2
      , v_customer_opus_n_prospect.cust_grp_nm as CTRT_CUST_GRP_NM2
    -- end 2021.12.28 for DCN-491
      , etd_lp1_of_sales_week_master.sales_week as etd_lp1_sales_week
      FROM `ONEFORCE.OF_BOOKING` as booking
      LEFT JOIN ${of_sales_week_master.SQL_TABLE_NAME} as etd_lp1_of_sales_week_master ON FORMAT_DATE("%b%Y", booking.etd_lp1) = etd_lp1_of_sales_week_master.Sales_Month AND cast(booking.etd_lp1 as date) BETWEEN etd_lp1_of_sales_week_master.Week_Start_date AND etd_lp1_of_sales_week_master.Week_End_Date
      -- add by Helen on 2021.12.28 for DCN-491
      LEFT JOIN ${of_svc_contract.SQL_TABLE_NAME} as of_svc_contract ON booking.svc_cont_no = of_svc_contract.sc_rfa_no
      LEFT JOIN (
          SELECT distinct vv.cust_cd, vv.name, vv.cust_grp_id, g.cust_grp_nm
          FROM ${v_customer_opus_n_prospect.SQL_TABLE_NAME} vv,
               ${of_customer_group.SQL_TABLE_NAME} g
          WHERE vv.cust_grp_id = g.cust_grp_id
        ) as v_customer_opus_n_prospect
      ON coalesce(of_svc_contract.cust_cd, booking.ctrt_cust_cd) = v_customer_opus_n_prospect.cust_cd
      -- end change on 2021.12.28 for DCN-491
    ;;
  }

  drill_fields: [basic_details*]

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: concat(${bkg_no}, ${cntr_tpsz}) ;;
  }

  dimension: ac_com_amt {
    label: "Agency" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.AC_COM_AMT as NUMERIC) ;;
  }

  dimension: ac_fac_amt {
    label: "Brokerage." # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.AC_FAC_AMT as NUMERIC) ;;
  }

  dimension: act_mty_pkup_scc_cd {
    label: "Actual Empty Pick Up SCC Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.ACT_MTY_PKUP_SCC_CD ;;
  }

  dimension: act_mty_pkup_yd_cd {
    label: "Actual Empty Pick Up Yard Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.ACT_MTY_PKUP_YD_CD ;;
  }

  dimension: actual_cust_cd {
    label: "Actual Customer Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.ACTUAL_CUST_CD ;;
  }

  dimension: actual_cust_nm {
    label: "Actual Customer Name" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.ACTUAL_CUST_NM ;;
  }

  dimension: avg_rpb_flg {
    label: "Avg RPB Flag (Y/N)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.AVG_RPB_FLG ;;
  }

  dimension: bkg_cgo_tp_cd {
    label: "Booking cargo type" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_CGO_TP_CD ;;
  }

  dimension: bkg_cgo_wgt {
    label: "Gross weight."  # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.BKG_CGO_WGT ;;
  }

  dimension_group: bkg_cre_dt {
    label: "BKG creation date"  # programmatically added by LookML modifier
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.BKG_CRE_DT ;;
    html: {{ rendered_value | date: "%b %d, %y" }} ;;
  }

  dimension_group: bkg_cxl_dt {
    label: "Booking cancellation date"  # programmatically added by LookML modifier
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.BKG_CXL_DT ;;
    html: {{ rendered_value | date: "%b %d, %y" }} ;;
  }

  dimension: canel_date_diff_raw {
    hidden: yes
    type: number
    sql: date_diff(${etd_lp1_raw},${bkg_cxl_dt_raw},Day) ;;
#    sql: date_diff(${bkg_cxl_dt_raw}, ${etd_lp1_raw}, Day) ;;
  }

  dimension: cancel_date_diff {
    type: string
    sql:
    CASE
      WHEN ${bkg_cxl_dt_raw} IS NULL AND ${bkg_sts_cd} = 'X' THEN 'No Cancel Date'
      WHEN ${canel_date_diff_raw} = 0 THEN '0 Departure Day'
      WHEN ${canel_date_diff_raw} > 0 AND ${canel_date_diff_raw} <= 2 THEN '02 Days Before'
      WHEN ${canel_date_diff_raw} > 2 AND ${canel_date_diff_raw} <= 5 THEN '05 Days Before'
      WHEN ${canel_date_diff_raw} > 5 AND ${canel_date_diff_raw} <= 7 THEN '07 Days Before'
      WHEN ${canel_date_diff_raw} > 7 AND ${canel_date_diff_raw} <= 10 THEN '10 Days Before'
      WHEN ${canel_date_diff_raw} > 10 THEN 'More than 10 Days Before'
      WHEN ${canel_date_diff_raw} < 0 THEN '- After Departure'
      ELSE NULL
      END
    ;;
  }

  dimension: bkg_cxl_rmk {
    label: "Booking cancellation reason remarks"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_CXL_RMK ;;
  }

  dimension: len_bkg_cxl_rmk {
    label: "Length of booking cancellation reason remarks"
    type: number
    sql: length(${bkg_cxl_rmk}) ;;
    value_format_name: decimal_0
  }

  dimension: bkg_cxl_rsn_cd {
    label: "Booking cancellation reason code" # programmatically added by LookML modifier
    type: string
    sql: case when ${TABLE}.BKG_STS_CD = 'X' AND ${TABLE}.BKG_CXL_RSN_CD IS NULL THEN "Z" ELSE ${TABLE}.BKG_CXL_RSN_CD END ;;
  }

  dimension: bkg_mty_rtn_scc_cd {
    label: "Empty Return SCC Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_MTY_RTN_SCC_CD ;;
  }

  dimension: bkg_no {
    label: "Booking No."  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_NO ;;

    link: { # -- Arul+Jack OPUS Direct Link -- Start 28-Jul-2021 Rleased
      label: "View Booking"
      url: "https://cntr.one-line.com/opuscntr/dologin.jsp?relayState=%2Fopuscntr%2FESM_BKG_0079_Q.do%3FmainPage%3Dtrue%26pid%3DESM_BKG_M020%26MENU%3DY%26pgmNo%3DESM_BKG_0079_Q%26parentPgmNo%3DESM_BKG_M001%26mainMenuLinkFlag%3Dtrue%26menuflag%3Dtrue%26mainPage%3Dtrue%26bkg_no%3D{{value}}"
      icon_url: "https://cntr.one-line.com/opuscntr/img/favicon.ico"
    }
    link: {
      label: "B/L Preview"
      url: "https://cntr.one-line.com/opuscntr/dologin.jsp?relayState=%2Fopuscntr%2FESM_BKG_0927_POP.do%3Fbkg_no%3D{{value}}"
      icon_url: "https://cntr.one-line.com/opuscntr/img/favicon.ico"
    }
    link: {
      label: "Standby Booking Detail"
      url: "https://cntr.one-line.com/opuscntr/dologin.jsp?relayState=%2Fopuscntr%2FESM_BKG_2020.do%3Fbkg_no%3D{{value}}"
      icon_url: "https://cntr.one-line.com/opuscntr/img/favicon.ico"
    } # -- Arul OPUS Direct Link -- Start 28-Jul-2021


  }

  dimension: bkg_sts {
    label: "Status"
    type: string
    sql:
    CASE
        WHEN  ${TABLE}.BKG_STS_CD  = 'X' THEN 'Cancelled'
        WHEN  ${TABLE}.BKG_STS_CD  = 'F' THEN 'Firm'
        WHEN  ${TABLE}.BKG_STS_CD  = 'S' THEN 'Firm (S)'
        WHEN  ${TABLE}.BKG_STS_CD  = 'W' THEN 'Waitlisted'
        WHEN  ${TABLE}.BKG_STS_CD  = 'A' THEN 'Pseudo Booking'
        ELSE  ${TABLE}.BKG_STS_CD
      END;;
  }

  dimension: bkg_no_stripped {
    label: "BKG NO (1st 10 characters)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_NO_STRIPPED ;;
  }

  dimension: bkg_ofc_cd {
    view_label: "Office Information"
    label: "Booking Office code." # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_OFC_CD ;;
  }

  dimension: bkg_ofc_cnt_cd {
    view_label: "Office Information"
    label: "BKG Office Country Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_OFC_CNT_CD ;;
  }

  dimension: bkg_ofc_cnt_nm {
    view_label: "Office Information"
    label: "BKG Office Country Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_OFC_CNT_NM ;;
  }

  dimension: bkg_oft_rev {
    label: "Freight Revenue"  # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.BKG_OFT_REV as NUMERIC) ;;
  }

  dimension: bkg_sts_cd {
    view_label: "B/L Information"
    label: "BKG Status Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_STS_CD ;;
  }

  dimension: bkg_teu {
    label: "TEU"  # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.BKG_TEU ;;
  }

  dimension: cgo_ntr_cd {
    label: "Cargo Nature Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CGO_NTR_CD ;;
  }

  dimension: cgo_ntr_nm {
    label: "Cargo Nature Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CGO_NTR_NM ;;
  }

  dimension: cif_fob_split_cd {
    label: "CIF / FOB Split Code (Obsoluete)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CIF_FOB_SPLIT_CD ;;
  }

  dimension: cm_amt1 {
    label: "CM (EPP A)."  # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.CM_AMT1 as NUMERIC) ;;
  }

  dimension: cm_amt2 {
    label: "CM (EPP B)."  # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.CM_AMT2 as NUMERIC);;
  }

  dimension: cmdt_cd {
    label: "Commodity Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CMDT_CD ;;
  }

  dimension: cmdt_nm {
    label: "Commodity label"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CMDT_NM ;;
  }

##Zoe - 21 Jul##
  dimension: cmdt_nm_and_Cd{
    label: "Commodity label and code"  # programmatically added by LookML modifier
    type: string
    sql:concat(${cmdt_cd}, "-" ,${cmdt_nm}) ;;
  }


  dimension: cnee_cust_cd {
    label: "Consignee code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CNEE_CUST_CD ;;
  }

  dimension: cnee_cust_nm {
    label: "Consignee name" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CNEE_CUST_NM ;;
  }

  dimension: cntr {
    label: "CNTR" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.CNTR as NUMERIC) ;;
  }

  dimension: cntr_qty {
    label: "Container Quantity" # programmatically added by LookML modifier
    type: number
    sql: cast(${TABLE}.CNTR_QTY as NUMERIC) ;;
  }

  dimension: cntr_tpsz {
    label: "Equipment type size"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CNTR_TPSZ ;;
  }

  dimension: consolidated_reason_code {
    type: string
    label: "Z means no reason"
    sql:
      CASE
        WHEN ${bkg_sts_cd} = 'X' AND ${bkg_cxl_rsn_cd} IS NOT NULL THEN ${bkg_cxl_rsn_cd}
        WHEN ${bkg_sts_cd} = 'X' AND ${bkg_cxl_rsn_cd} IS NULL THEN 'Z'
        WHEN ${bkg_sts_cd} = 'X' THEN NULL
        ELSE NULL
      END;;
  }

  dimension_group: cont_effective_dt {
    label: "Customer contract effective date" # programmatically added by LookML modifier
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CONT_EFFECTIVE_DT ;;
  }

  dimension_group: cont_expiry_dt {
    label: "Customer contract expiry date"  # programmatically added by LookML modifier
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CONT_EXPIRY_DT ;;
  }

  dimension: cont_period_typ_cd {
    label: "Contract Period Type Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CONT_PERIOD_TYP_CD ;;
  }

  dimension: crm_if_flg {
    label: "Contract Cust [Track in CRM] Indicator" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CRM_IF_FLG ;;
  }

  dimension: ctrt_cust_cd {
    label: "Contract Party Customer Code" # programmatically added by LookML modifier
    type: string
    # change by Helen on 2021.12.28 for DCN-491
    #sql: ${TABLE}.CTRT_CUST_CD ;;
    sql: ${TABLE}.CTRT_CUST_CD2 ;;
    # end change by on 2021.12.28 for DCN-491
  }

  dimension: ctrt_cust_grp_id {
    label: "Contract Party Customer Group Name" # programmatically added by LookML modifier
    type: string
    # change by Helen on 2021.12.28 for DCN-491
    #sql: ${TABLE}.CTRT_CUST_GRP_ID ;;
    sql: ${TABLE}.CTRT_CUST_GRP_ID2;;
    # end change by on 2021.12.28 for DCN-491
  }

  dimension: ctrt_cust_grp_nm {
    label: "Contract Party Customer Group Code" # programmatically added by LookML modifier
    type: string
    # change by Helen on 2021.12.28 for DCN-491
    #sql: ${TABLE}.CTRT_CUST_GRP_NM ;;
    sql: ${TABLE}.CTRT_CUST_GRP_NM2 ;;
    # end change by on 2021.12.28 for DCN-491
  }

  dimension: ctrt_cust_nm {
    label: "Contract Party Customer Name" # programmatically added by LookML modifier
    type: string
    # change by Helen on 2021.12.28 for DCN-491
    #sql: ${TABLE}.CTRT_CUST_NM ;;
    sql: ${TABLE}.CTRT_CUST_NM2 ;;
    # end change by on 2021.12.28 for DCN-491
  }

  dimension: ctrt_prop_ofc_cd {
    view_label: "Office Information"
    label: "Contract sales rep office code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_PROP_OFC_CD ;;
  }

  dimension: ctrt_prop_ofc_nm {
    view_label: "Office Information"
    label: "Service Contract Sales Rep Office Name" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_PROP_OFC_NM ;;
  }

  dimension: ctrt_prop_srep_eml {
    label: "Service Contract Sales Rep Email" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_PROP_SREP_EML ;;
  }

  dimension: ctrt_prop_srep_nm {
    label: "Service Contract Sales Rep" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_PROP_SREP_NM ;;
  }

  dimension: ctrt_scp_srep_eml {
    label: "S/C Service Scope Sales Rep Email"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_SCP_SREP_EML ;;
  }

  dimension: ctrt_scp_srep_nm {
    label: "S/C Service Scope Sales Rep"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_SCP_SREP_NM ;;
  }

  dimension: ctrt_scp_srep_ofc_cd {
    view_label: "Office Information"
    label: "Service Scope sale rep office code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_SCP_SREP_OFC_CD ;;
  }

  dimension: ctrt_scp_srep_ofc_nm {
    view_label: "Office Information"
    label: "S/C Service Scope Sales Rep Office Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTRT_SCP_SREP_OFC_NM ;;
  }

  dimension: dcgo_flg {
    label: "Hazardous Commodity Indicator"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DCGO_FLG ;;
  }

  dimension: de_term_cd {
    label: "CY / Door (Destination)"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DE_TERM_CD ;;
  }

  dimension: del_cd {
    label: "Place of delivery code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DEL_CD ;;
  }

  dimension: del_cnt {
    label: "Destination Country"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DEL_CNT ;;
  }

  dimension: del_nm {
    label: "Place of Delivery Name" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DEL_NM ;;
  }

  dimension: del_nm_and_del_cnt {
    type: string
    sql: concat(${del_nm}, ', ', ${del_cnt}) ;;
  }

  dimension: dest_trns_svc_mod_cd {
    label: "IB Service Mode Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DEST_TRNS_SVC_MOD_CD ;;
  }

  dimension: dir_cd {
    label: "Direction Code (N/S/E/W)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DIR_CD ;;
  }

  dimension: dominant_flg {
    label: "Dom/Non-dominant Indicator (Y/N)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DOMINANT_FLG ;;
  }

  dimension_group: etd_lp1 {
    label: "EPS - First Load Port"  # programmatically added by LookML modifier
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ETD_LP1 ;;
  }

  dimension: ete_dys {
    label: "End to End Shipment Transit Days" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.ETE_DYS as NUMERIC);;
  }

  dimension: fi {
    label: "FI" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.FI as NUMERIC) ;;
  }

  dimension: final_pod_cd {
    label: "Final discharge port code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.FINAL_POD_CD ;;
  }

  dimension: frst_vvd {
    label: "First VVD code."  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.FRST_VVD ;;
  }

  dimension: frt_term_cd {
    label: "Prepaid / Collect Payer Indicator (P/C)"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.FRT_TERM_CD ;;
  }

  dimension: frwd_cust_cd {
    label: "Forwarder code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.FRWD_CUST_CD ;;
  }

  dimension: frwd_cust_nm {
    label: "Forwarder name" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.FRWD_CUST_NM ;;
  }

  dimension: ib_mty_pa_amt {
    label: "IB EPP A" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.IB_MTY_PA_AMT AS NUMERIC) ;;
  }

  dimension: ib_mty_pa_amt2 {
    label: "IB EPP B" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.IB_MTY_PA_AMT2 AS NUMERIC) ;;
  }

  dimension: ioc_cd {
    label: "IOC Code (I/O)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.IOC_CD ;;
  }

  dimension: ld {
    label: "LD" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.LD as NUMERIC) ;;
  }

  dimension: line_code1 {
    label: "First service lane code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.LINE_CODE1 ;;
  }

  dimension: lst_vvd_cd {
    label: "Last VVD Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.LST_VVD_CD ;;
  }

  # dimension: month {
  #  label: "MONTH (do not use)"  # programmatically added by LookML modifier
  #  type: string
  #  sql: ${TABLE}.MONTH ;;
  # }

  dimension: mty_pkup_scc_cd {
    label: "Empty Pick Up SCC Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.MTY_PKUP_SCC_CD ;;
  }

  dimension: mty_rtn_scc_cd {
    label: "Actual Empty Return SCC Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.MTY_RTN_SCC_CD ;;
  }

  dimension: mty_rtn_yd_cd {
    label: "Empty Return Yard Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.MTY_RTN_YD_CD ;;
  }

  dimension: bkg_mty_rtn_yd_cd {
    label: "Booking Empty Return Yard Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.BKG_MTY_RTN_YD_CD ;;
  }

  dimension: act_mty_rtn_yd_cd {
    label: "Actual Empty Return Yard Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.ACT_MTY_RTN_YD_CD ;;
  }

  dimension: n1st_pod_cd {
    label: "First Discharge Port" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.N1ST_POD_CD ;;
  }

  dimension_group: n1st_pol_atd_dt {
    label: "First POL ATD Date" # programmatically added by LookML modifier
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.N1ST_POL_ATD_DT ;;
  }

  dimension: n1st_pol_cd {
    label: "First Load Port"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.N1ST_POL_CD ;;
  }

  dimension: n1st_rlane_cd {
    label: "N1ST RLANE CD"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.N1ST_RLANE_CD ;;
  }

  dimension: ntfy_cust_cd {
    label: "Notify Party Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.NTFY_CUST_CD ;;
  }

  dimension: ntfy_cust_nm {
    label: "Notify Party Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.NTFY_CUST_NM ;;
  }

  dimension: ntlt_grp_nm {
    label: "SC/RFA Customer Nationality Group"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.NTLT_GRP_NM ;;
  }

  dimension: ob_mty_pa_amt {
    label: "OB EPP A" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.OB_MTY_PA_AMT as NUMERIC) ;;
  }

  dimension: ob_mty_pa_amt2 {
    label: "OB EPP B" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.OB_MTY_PA_AMT2 as NUMERIC) ;;
  }

  dimension: ob_ofc_nm {
    view_label: "Office Information"
    label: "Loading Sales Rep Name" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.OB_OFC_NM ;;
  }

  dimension: ob_sls_ofc_cd {
    view_label: "Office Information"
    label: "Loading sales rep office code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.OB_SLS_OFC_CD ;;
  }

  dimension: ob_srep_cd {
    label: "Loading Sales Rep Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.OB_SREP_CD ;;
  }

  dimension: ob_srep_eml {
    label: "Loading Sales Rep Email"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.OB_SREP_EML ;;
  }

  dimension: ob_srep_nm {
    label: "Loading Sales Rep"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.OB_SREP_NM ;;
  }

  dimension: org_trns_svc_mod_cd {
    label: "OB Service Mode Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.ORG_TRNS_SVC_MOD_CD ;;
  }

  dimension: ori_cnt {
    label: "Origin Country" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.ORI_CNT ;;
  }

  dimension: pod_loc_cd {
    label: "Trunk POD Location Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.POD_LOC_CD ;;
  }

  dimension: pod_loc_nm {
    label: "Trunk POD Location Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.POD_LOC_NM ;;
  }

  dimension: pol_loc_cd {
    label: "Trunk POL Location Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.POL_LOC_CD ;;
  }

  dimension: pol_loc_nm {
    label: "Trunk POL Location Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.POL_LOC_NM ;;
  }

  dimension: por_cd {
    label: "Place of receipt code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.POR_CD ;;
  }

  dimension: por_nm {
    label: "Place of Receipt Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.POR_NM ;;
  }

  dimension: por_nm_and_ori_cnt {
    type: string
    sql: concat(${por_nm},', ', ${ori_cnt}) ;;
  }

  # dimension: quarter {
  #  label: "QUARTER (do not use)"  # programmatically added by LookML modifier
  #  type: string
  #  sql: ${TABLE}.QUARTER ;;
  # }

  dimension: rcv_term_cd {
    label: "CY / Door (Origin)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.RCV_TERM_CD ;;
  }

  dimension: rd_cgo_flg {
    label: "Reefer As Dry Indicator"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.RD_CGO_FLG ;;
  }

  dimension: rlane_cd {
    label: "Revenue Lane code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.RLANE_CD ;;
  }

  dimension: slane_cd {
    label: "Service Lane (Rev)"
    type: string
    sql: substr(${of_booking.rlane_cd}, 1, 3) ;;
  }

  dimension: sc_rfa_ctrt_tp_nm {
    label: "SC/RFA Contract Type (RFA, TAA, S/C)" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SC_RFA_CTRT_TP_NM ;;
  }

  dimension: sc_rfa_sls_rep_ofc_cnt_cd {
    view_label: "Office Information"
    label: "SC/RFA Customer Sales Rep Office Country Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SC_RFA_SLS_REP_OFC_CNT_CD ;;
  }

  dimension: sc_rfa_sls_rep_ofc_cnt_nm {
    view_label: "Office Information"
    label: "SC/RFA Customer Sales Rep Office Country Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SC_RFA_SLS_REP_OFC_CNT_NM ;;
  }

  dimension: shpr_cust_cd {
    label: "Shipper code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SHPR_CUST_CD ;;
  }

  dimension: shpr_cust_nm {
    label: "Shipper name" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SHPR_CUST_NM ;;
  }

  dimension: sub_trd_cd {
    label: "Sub TRADE Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SUB_TRD_CD ;;
  }

  dimension: svc_cont_no {
    label: "Service contract number." # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SVC_CONT_NO ;;
    link: { # -- Arul OPUS Direct Link -- Start Released to Prod on 28-Jul-2021
      label: "{% if  of_booking.sc_rfa_ctrt_tp_nm._value == 'RFA' %}
      View RFA
      {% else %}
      View Service Contract
      {% endif %}"
      url: "{% if  of_booking.sc_rfa_ctrt_tp_nm._value == 'RFA' %}
      https://cntr.one-line.com/opuscntr/dologin.jsp?relayState=%2Fopuscntr%2FESM_PRI_2019.do%3Fpid%3DESM_PRI_M012%26MENU%3DY%26pgmNo%3DESM_PRI_2019%26parentPgmNo%3DESM_PRI_M001%26main_page%3Dtrue%26mainMenuLinkFlag%3Dtrue%26menuflag%3Dtrue%26mainPage%3Dtrue%26s_rfa_no%3D{{ value }}
      {% else %}
      https://cntr.one-line.com/opuscntr/dologin.jsp?relayState=%2Fopuscntr%2FESM_PRI_0004.do%3Fpid%3DESM_PRI_M006%26MENU%3DY%26pgmNo%3DESM_PRI_0004%26parentPgmNo%3DESM_PRI_M001%26main_page%3Dtrue%26mainMenuLinkFlag%3Dtrue%26menuflag%3Dtrue%26mainPage%3Dtrue%26sc_no_s%3D{{ value }}
      {% endif %}"
      icon_url: "https://cntr.one-line.com/opuscntr/img/favicon.ico" # -- Arul OPUS Direct Link -- End Released to Prod on 28-Jul-2021
    }
  }

  dimension: svc_scp_cd {
    label: "Service Scope Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SVC_SCP_CD ;;
    suggest_persist_for: "24 hour"
  }

  dimension: t_slan_cd {
    label: "Trunk VVD Service Lane Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.T_SLAN_CD ;;
  }

  dimension: t_vvd_cd {
    label: "Trunk VVD Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.T_VVD_CD ;;
    # link: { # -- Arul OPUS Direct Link -- Start 28-Jul-2021
    #   label: "Standby Detail"
    #   url: "https://cntr.one-line.com/opuscntr/ESM_BKG_2025.do?bkg_vvd={{value}}"
    #   icon_url: "https://cntr.one-line.com/opuscntr/img/favicon.ico"
    # } # -- Arul OPUS Direct Link -- End 28-Jul-2021
  }

  dimension: tot_g_rev {
    label: "Total Gross Revenue USD Amount" # programmatically added by LookML modifier
    type: number
    sql: CAST(${TABLE}.TOT_G_REV as NUMERIC) ;;
  }

  dimension: trd_cd {
    label: "Trade Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.TRD_CD ;;
  }

  dimension: week {
    label: "Sales Week" # programmatically added by LookML modifier
    type: string
    sql: coalesce(${TABLE}.week, cast(${TABLE}.etd_lp1_sales_week as int64)) ;;
  }

  dimension: etd_lp1_sales_week {
    hidden: yes
    type: string
    sql: ${TABLE}.etd_lp1_sales_week ;;
  }

  dimension: is_with_cancellation_code {
    type: yesno
    sql: ${bkg_cxl_rsn_cd} IS NULL OR ${bkg_cxl_rsn_cd} = '' ;;
  }

  dimension: xter_rmk {
    label: "Cancellation reason"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.XTER_RMK ;;
  }

  #DCN-944
  dimension: Is_ONEQuote {
    label: "Is ONE Quote"
    type: yesno
    sql: COALESCE(${TABLE}.XTER_BKG_RQST_CD,'XX') = 'WEQ' ;;
  }

  dimension: xter_bkg_rqst_cd {
    label: "Booking Request Code"
    type: string
    sql: XTER_BKG_RQST_CD;;
  }

  dimension: ONEQuote {
    label: "ONE Quote"
    type: string
    sql: CASE WHEN COALESCE(${TABLE}.XTER_BKG_RQST_CD,'XX') = 'WEQ' THEN 'Yes' ELSE 'No' END;;
  }

  # dimension: year {
  #  label: "YEAR (do not use)" # programmatically added by LookML modifier
  #  type: string
  #  sql: ${TABLE}.YEAR ;;
  # }

# Sharon added on 19 Nov 2021
  dimension: Booking_Cancellation_Tab_link {
    type: string
    sql:  CONCAT(1,2);;
    html: <div style="border-radius: 5px; padding: 5px 10px; background: #808080; height: 60px; color: red;">
        <nav style="font-size: 18px;">
        <a style="color: #FFFFFF; padding: 5px 15px; float: left; line-height: 40px;font-weight: bold; cursor: not-allowed;"href="https://oneline.cloud.looker.com/embed/dashboards-next/5?Customer={{ _filters['v_customer_opus_n_prospect.customer_cd_and_name'] | url_encode }}&Fiscal%20Year={{ _filters['of_sales_week_master.fiscal_year'] | url_encode }}&Customer%20Group={{ _filters['of_customer_group.cust_grp_and_name'] | url_encode }}&Sales%20Month={{ _filters['of_sales_week_master.sales_month'] | url_encode }}&Sales%20Week={{ _filters['of_sales_week_master.sales_week'] | url_encode }}&Service%20Scope={{ _filters['of_svc_scp.service_scope_code_and_name'] | url_encode }}&Service%20Scope%20Group={{ _filters['of_svc_scp_grp.service_scope_group_code_and_name'] | url_encode }}&Customer%20Segmentation={{ _filters['of_customer_group.key_acct_tp_cd'] | url_encode }}&Key%20Account%20Country={{ _filters['of_customer_group.key_acct_cnt_name'] | url_encode }}&Key%20Account%20Region={{ _filters['of_customer_group.key_acct_rgn_cd'] | url_encode }}&Customer%20Type={{ _filters['of_customer_group.global_customer_type'] | url_encode }}&Team={{ _filters['of_one_team.name'] | url_encode }}&Origin%20Country= {{ _filters['POR_country.country_name'] | url_encode }}&Destination%20Country= {{ _filters['DEL_country.country_name'] | url_encode }}&Date%20Granularity={{ _filters['of_sales_week_master.timeframe_picker'] | url_encode }}&Calendar%20Year={{ _filters['of_sales_week_master.calendar_year'] | url_encode }}&Bkg%20Office%20Country={{_filters['of_booking.bkg_ofc_cnt_nm']| url_encode }}&Load%20Port={{_filters['of_booking.n1st_pol_cd'] | url_encode }}&Discharge%20Port={{ _filters['of_booking.n1st_pod_cd']|url_encode }}&Bkg%20No%281st+10+characters%29={{ _filters['of_booking.bkg_no_stripped']| url_encode }}&Contract%20office={{ _filters['of_booking.ctrt_prop_ofc_cd']| url_encode }}&Booking%20RHQ={{ _filters['of_salesperson.regional_head_office']| url_encode }}&Service%20Lane%28Rev%29{{ _filters['of_booking.slane_cd']|url_encode }}&Booking%20Office={{ _filters['of_booking.bkg_ofc_cd']| url_encode }}&Svc%2FRFA%20No={{ _filters['of_booking.svc_cont_no']|url_encode }}&Contract%20Sales%20Person={{ _filters['of_booking.ctrt_prop_srep_nm']| url_encode }}&Actual%20Customer%20Name%28NAC%29={{ _filters['of_booking.actual_cust_nm']|url_encode }}&Cancel%20Reason={{ _filters['bkg_cncl_reason.cancel_reason']| url_encode }}&Booking%20Status={{ _filters['v_booking_cancellation_teu_drop.Bkg_grp_sts_Description']| url_encode }}&Cancellation+Category={{ _filters['bkg_cncl_reason.category'] | url_encode }}&Via%20ONE%20Quote={{ _filters['of_booking.Is_ONEQuote']| url_encode }}" target="_blank" > Booking Cancellation Monitor </a>
        <a style="color: #efefef; padding: 5px 15px; float: left; line-height: 40px;"href="https://oneline.cloud.looker.com/embed/dashboards-next/135?Customer={{ _filters['v_customer_opus_n_prospect.customer_cd_and_name'] | url_encode }}&Fiscal%20Year={{ _filters['of_sales_week_master.fiscal_year'] | url_encode }}&Customer%20Group={{ _filters['of_customer_group.cust_grp_and_name'] | url_encode }}&Sales%20Month={{ _filters['of_sales_week_master.sales_month'] | url_encode }}&Sales%20Week={{ _filters['of_sales_week_master.sales_week'] | url_encode }}&Service%20Scope={{ _filters['of_svc_scp.service_scope_code_and_name'] | url_encode }}&Service%20Scope%20Group={{ _filters['of_svc_scp_grp.service_scope_group_code_and_name'] | url_encode }}&Customer%20Segmentation={{ _filters['of_customer_group.key_acct_tp_cd'] | url_encode }}&Key%20Account%20Country={{ _filters['of_customer_group.key_acct_cnt_name'] | url_encode }}&Key%20Account%20Region={{ _filters['of_customer_group.key_acct_rgn_cd'] | url_encode }}&Customer%20Type={{ _filters['of_customer_group.global_customer_type'] | url_encode }}&Team={{ _filters['of_one_team.name'] | url_encode }}&Origin%20Country= {{ _filters['POR_country.country_name'] | url_encode }}&Destination%20Country= {{ _filters['DEL_country.country_name'] | url_encode }}&Date%20Granularity={{ _filters['of_sales_week_master.timeframe_picker'] | url_encode }}&Calendar%20Year={{ _filters['of_sales_week_master.calendar_year'] | url_encode }}&Bkg%20Office%20Country={{_filters['of_booking.bkg_ofc_cnt_nm']| url_encode }}&Load%20Port={{_filters['of_booking.n1st_pol_cd'] | url_encode }}&Discharge%20Port={{ _filters['of_booking.n1st_pod_cd']|url_encode }}&Bkg%20No%281st+10+characters%29={{ _filters['of_booking.bkg_no_stripped']| url_encode }}&Contract%20office={{ _filters['of_booking.ctrt_prop_ofc_cd']|url_encode }}&Booking%20RHQ={{ _filters['of_salesperson.regional_head_office']| url_encode }}&Service%20Lane%28Rev%29{{ _filters['of_booking.slane_cd']|url_encode }}&Booking%20Office={{ _filters['of_booking.bkg_ofc_cd']| url_encode }}&Svc%2FRFA%20No={{ _filters['of_booking.svc_cont_no']| url_encode }}&Contract%20Sales%20Person={{ _filters['of_booking.ctrt_prop_srep_nm']|url_encode }}&Actual%20Customer%20Name%28NAC%29={{ _filters['of_booking.actual_cust_nm']| url_encode }}&Cancel%20Reason={{ _filters['bkg_cncl_reason.cancel_reason']| url_encode }}&Booking%20Status={{ _filters['v_booking_cancellation_teu_drop.Bkg_grp_sts_Description']| url_encode }}&Cancellation+Category={{ _filters['bkg_cncl_reason.category'] | url_encode }}&Via%20ONE%20Quote={{ _filters['of_booking.Is_ONEQuote'] | url_encode }}" target="_blank" > Booking Cancellation Matrix </a>
         </nav>
       </div>
  ;;
  }

  dimension: Booking_Cancellation_Tab_link2 {
    type: string
    sql:  CONCAT(1,2);;
    html: <div style="border-radius: 5px; padding: 5px 10px; background: #808080; height: 60px; color: red;">
       <nav style="font-size: 18px;">
       <a style="color: #efefef; padding: 5px 15px; float: left; line-height: 40px;"href="https://oneline.cloud.looker.com/embed/dashboards-next/5?Customer={{ _filters['v_customer_opus_n_prospect.customer_cd_and_name'] | url_encode }}&Fiscal%20Year={{ _filters['of_sales_week_master.fiscal_year'] | url_encode }}&Customer%20Group={{ _filters['of_customer_group.cust_grp_and_name'] | url_encode }}&Sales%20Month={{ _filters['of_sales_week_master.sales_month'] | url_encode }}&Sales%20Week={{ _filters['of_sales_week_master.sales_week'] | url_encode }}&Service%20Scope={{ _filters['of_svc_scp.service_scope_code_and_name'] | url_encode }}&Service%20Scope%20Group={{ _filters['of_svc_scp_grp.service_scope_group_code_and_name'] | url_encode }}&Customer%20Segmentation={{ _filters['of_customer_group.key_acct_tp_cd'] | url_encode }}&Key%20Account%20Country={{ _filters['of_customer_group.key_acct_cnt_name'] | url_encode }}&Key%20Account%20Region={{ _filters['of_customer_group.key_acct_rgn_cd'] | url_encode }}&Customer%20Type={{ _filters['of_customer_group.global_customer_type'] | url_encode }}&Team={{ _filters['of_one_team.name'] | url_encode }}&Origin%20Country= {{ _filters['POR_country.country_name'] | url_encode }}&Destination%20Country= {{ _filters['DEL_country.country_name'] | url_encode }}&Date%20Granularity={{ _filters['of_sales_week_master.timeframe_picker'] | url_encode }}&Calendar%20Year={{ _filters['of_sales_week_master.calendar_year'] | url_encode }}&Bkg%20Office%20Country={{_filters['of_booking.bkg_ofc_cnt_nm']| url_encode }}&Load%20Port={{ _filters['of_booking.n1st_pol_cd'] | url_encode }}&Discharge%20Port={{ _filters['of_booking.n1st_pod_cd']|url_encode }}&Bkg%20No%201st+10+characters%29={{ _filters['of_booking.bkg_no_stripped'] | url_encode }}&Contract%20office={{ _filters['of_booking.ctrt_prop_ofc_cd'] | url_encode }}&Booking%20RHQ={{ _filters['of_salesperson.regional_head_office']|url_encode }}&Service%20Lane%28Rev%29={{ _filters['of_booking.slane_cd']|url_encode }}&Booking%20Office={{ _filters['of_booking.bkg_ofc_cd']| url_encode }}&Svc%2FRFA%20No={{ _filters['of_booking.svc_cont_no']| url_encode }}&Contract%20Sales%20Person={{ _filters['of_booking.ctrt_prop_srep_nm']|url_encode }}&Actual%20Customer%20Name%28NAC%29={{ _filters['of_booking.actual_cust_nm']| url_encode }}&Cancel%20Reason={{ _filters['bkg_cncl_reason.cancel_reason']| url_encode }}&Booking%20Status={{ _filters['v_booking_cancellation_teu_drop.Bkg_grp_sts_Description']| url_encode }}&Cancellation+Category={{ _filters['bkg_cncl_reason.category'] | url_encode }}&Via%20ONE%20Quote={{ _filters['of_booking.Is_ONEQuote'] | url_encode }}" target="_blank" > Booking Cancellation Monitor </a>
       <a style="color: #FFFFFF; padding: 5px 15px; float: left; line-height: 40px;font-weight: bold; cursor: not-allowed;" href="https://oneline.cloud.looker.com/embed/dashboards-next/135?Customer={{ _filters['v_customer_opus_n_prospect.customer_cd_and_name'] | url_encode }}&Fiscal%20Year={{ _filters['of_sales_week_master.fiscal_year'] | url_encode }}&Customer%20Group={{ _filters['of_customer_group.cust_grp_and_name'] | url_encode }}&Sales%20Month={{ _filters['of_sales_week_master.sales_month'] | url_encode }}&Sales%20Week={{ _filters['of_sales_week_master.sales_week'] | url_encode }}&Service%20Scope={{ _filters['of_svc_scp.service_scope_code_and_name'] | url_encode }}&Service%20Scope%20Group={{ _filters['of_svc_scp_grp.service_scope_group_code_and_name'] | url_encode }}&Customer%20Segmentation={{ _filters['of_customer_group.key_acct_tp_cd'] | url_encode }}&Key%20Account%20Country={{ _filters['of_customer_group.key_acct_cnt_name'] | url_encode }}&Key%20Account%20Region={{ _filters['of_customer_group.key_acct_rgn_cd'] | url_encode }}&Customer%20Type={{ _filters['of_customer_group.global_customer_type'] | url_encode }}&Team={{ _filters['of_one_team.name'] | url_encode }}&Origin%20Country= {{ _filters['POR_country.country_name'] | url_encode }}&Destination%20Country= {{ _filters['DEL_country.country_name'] | url_encode }}&Date%20Granularity={{ _filters['of_sales_week_master.timeframe_picker'] | url_encode }}&Calendar%20Year={{ _filters['of_sales_week_master.calendar_year'] | url_encode }}&Bkg%20Office%20Country={{_filters['of_booking.bkg_ofc_cnt_nm']| url_encode }}&Load%20Port={{ _filters['of_booking.n1st_pol_cd'] | url_encode }}&Discharge%20Port={{ _filters['of_booking.n1st_pod_cd']|url_encode }}&Bkg%20No%281st+10+characters%29={{ _filters['of_booking.bkg_no_stripped']| url_encode }}&Contract%20office={{ _filters['of_booking.ctrt_prop_ofc_cd']| url_encode }}&Booking%20RHQ={{ _filters['of_salesperson.regional_head_office']| url_encode }}&Service%20Lane%28Rev%29{{ _filters['of_booking.slane_cd']|url_encode }}&Booking%20Office={{ _filters['of_booking.bkg_ofc_cd']| url_encode }}&Svc%2FRFA%20No={{ _filters['of_booking.svc_cont_no']|url_encode }}&Contract%20Sales%20Person={{ _filters['of_booking.ctrt_prop_srep_nm']|url_encode }}&Actual%20Customer%20Name%28NAC%29={{ _filters['of_booking.actual_cust_nm']|url_encode }}&Cancel%20Reason={{ _filters['bkg_cncl_reason.cancel_reason']| url_encode }}&Booking%20Status={{ _filters['v_booking_cancellation_teu_drop.Bkg_grp_sts_Description']| url_encode }}&Cancellation+Category={{ _filters['bkg_cncl_reason.category'] | url_encode }}&Via%20ONE%20Quote={{ _filters['of_booking.Is_ONEQuote'] | url_encode }}" target="_blank" > Booking Cancellation Matrix </a>
        </nav>
      </div>
  ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }

  measure: count_booking_no_stripped_non_distinct {
    type: number
    sql: COUNT(${bkg_no_stripped}) ;;
    value_format_name: decimal_0
    drill_fields: [bkg_no_stripped, count_booking_no_stripped_non_distinct]
  }

  measure: count_booking_no_stripped {
    type: count_distinct
    sql: ${bkg_no_stripped} ;;
    value_format_name: decimal_0
    drill_fields: [bkg_no_stripped, count_booking_no_stripped]
  }

  measure: total_teu {
    type: sum
    sql: ${bkg_teu} ;;
    drill_fields: [basic_details*, total_teu]
  }

  set: primary_key {
    fields: [primary_key, bkg_no, cntr_tpsz, count]
  }

  set: non_consolidated {
    fields: [
      bkg_cre_dt_date
      , bkg_cre_dt_month
      , bkg_cre_dt_quarter
      , bkg_cre_dt_year
      , bkg_cxl_dt_date
      , bkg_cxl_dt_month
      , bkg_cxl_dt_quarter
      , bkg_cxl_dt_year
      , cont_effective_dt_date
      , cont_effective_dt_month
      , cont_effective_dt_quarter
      , cont_effective_dt_year
      , cont_expiry_dt_date
      , cont_expiry_dt_month
      , cont_expiry_dt_quarter
      , cont_expiry_dt_year
      , etd_lp1_date
      , etd_lp1_month
      , etd_lp1_quarter
      , etd_lp1_year
      , n1st_pol_atd_dt_date
      , n1st_pol_atd_dt_month
      , n1st_pol_atd_dt_quarter
      , n1st_pol_atd_dt_year
      , cont_period_typ_cd
    ]
  }

  set: basic_details {
    fields: [
      bkg_no
      , cntr_tpsz
      , bkg_sts_cd
      , ctrt_cust_cd
      , ctrt_cust_grp_id
      , ctrt_scp_srep_eml
      , ctrt_scp_srep_nm
    ]
  }


}

view: of_booking_ap {
  derived_table: {
    sql: select distinct bkg_no as plan_bkg
               FROM ${of_booking.SQL_TABLE_NAME} AS of_booking
                    LEFT JOIN `ONEFORCE.OF_SVC_SCP`
                   AS of_svc_scp ON of_booking.svc_scp_cd = of_svc_scp.service_scope_code
                   LEFT JOIN `ONEFORCE.OF_SVC_CONTRACT` as of_svc_contract ON of_booking.svc_cont_no = of_svc_contract.sc_rfa_no
                    LEFT JOIN (
                      SELECT cust_cd, cust_grp_id, cntr_cust_tp_cd
                      FROM `ONEFORCE.V_CUSTOMER_OPUS_N_PROSPECT`

      ) as v_customer_opus_n_prospect ON coalesce(of_svc_contract.cust_cd, of_booking.ctrt_cust_cd) = v_customer_opus_n_prospect.cust_cd
      AND coalesce(of_svc_contract.cust_cd, of_booking.ctrt_cust_cd) IS NOT NULL
      inner join ${of_account_plan.SQL_TABLE_NAME} as ap on cast(regexp_replace(ap.sales_week, '[/W]', '') as int64) = of_booking.week
      and ap.sc_rfa_customer_group_code = v_customer_opus_n_prospect.cust_grp_id and ap.sc_rfa_number = svc_cont_no
      and ap.trade_code = of_svc_scp.service_scope_group_code
      and ap.loading_sales_rep_office_code = of_booking.bkg_ofc_cd
      and ap.trunk_vvd_service_lane_code = t_slan_cd
      and (case when ap.dominant_leg_flag = 'Y' then 'DOM' when  ap.dominant_leg_flag = 'N' then 'N-DOM' else 'XXX' end) = (CASE
      WHEN svc_scp_cd = 'LEA' AND n1st_pol_cd LIKE 'MX%' THEN 'N-DOM'
      WHEN svc_scp_cd = 'LEA' THEN 'DOM'
      WHEN svc_scp_cd = 'IAA' AND right(t_vvd_cd,1) IN ('S','W') THEN 'DOM'
      WHEN svc_scp_cd = 'IAA' THEN 'N-DOM'
      ELSE of_svc_scp.dominant_flag
      END )
      WHERE of_booking.bkg_sts_cd  != 'X'
      ;;
    persist_for: "4 hours"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    hidden: yes
  }

  dimension: plan_bkg {
    type: string
    sql: ${TABLE}.plan_bkg ;;
  }

  #dimension: week {
  #   type: string
  #   sql: ${TABLE}.week ;;
  #}

  set: detail {
    fields: [plan_bkg]
  }
}

view: of_bound {
  derived_table: {
    sql: SELECT 'N' as bound UNION ALL
          SELECT 'S' as bound UNION ALL
          SELECT 'W' as bound UNION ALL
          SELECT 'E' as bound
       ;;
  }

  dimension: bound {
    label: "Bound"
    type: string
    sql: ${TABLE}.bound ;;
  }

}

view: of_business_hours {
  sql_table_name: `ONEFORCE.OF_BUSINESS_HOURS`
    ;;

  dimension: created_by_id {
    type: string
    sql: ${TABLE}.CreatedById ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.CreatedDate ;;
  }

  dimension_group: friday_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.FridayEndTime ;;
  }

  dimension_group: friday_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.FridayStartTime ;;
  }

  dimension: is_active {
    type: string
    sql: ${TABLE}.IsActive ;;
  }

  dimension: is_default {
    type: string
    sql: ${TABLE}.IsDefault ;;
  }

  dimension: is_dummy {
    type: string
    sql: ${TABLE}.IsDummy ;;
  }

  dimension: last_modified_by_id {
    type: string
    sql: ${TABLE}.LastModifiedById ;;
  }

  dimension_group: last_modified {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.LastModifiedDate ;;
  }

  dimension_group: last_viewed {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.LastViewedDate ;;
  }

  dimension_group: monday_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.MondayEndTime ;;
  }

  dimension_group: monday_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.MondayStartTime ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.Name ;;
  }

  dimension: oneforce_id {
    type: string
    sql: ${TABLE}.ONEForce_Id ;;
  }

  dimension_group: saturday_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.SaturdayEndTime ;;
  }

  dimension_group: saturday_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.SaturdayStartTime ;;
  }

  dimension_group: sunday_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.SundayEndTime ;;
  }

  dimension_group: sunday_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.SundayStartTime ;;
  }

  dimension_group: system_modstamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.SystemModstamp ;;
  }

  dimension_group: thursday_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.ThursdayEndTime ;;
  }

  dimension_group: thursday_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.ThursdayStartTime ;;
  }

  dimension: time_zone_sid_key {
    type: string
    sql: ${TABLE}.TimeZoneSidKey ;;
  }

  dimension_group: tuesday_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.TuesdayEndTime ;;
  }

  dimension_group: tuesday_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.TuesdayStartTime ;;
  }

  dimension_group: wednesday_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.WednesdayEndTime ;;
  }

  dimension_group: wednesday_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.WednesdayStartTime ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}

view: of_calendar {
  derived_table: {
    sql: SELECT  FORMAT_DATE('%Y%m%d',calendar_date) primKey
        ,calendar_date
        ,cast(EXTRACT(YEAR FROM calendar_date) as string) as calendar_year
        ,cast(EXTRACT(MONTH FROM calendar_date) as string) as calendar_month
        ,CONCAT(cast(EXTRACT(YEAR FROM calendar_date) as string),LPAD(cast(EXTRACT(MONTH FROM calendar_date) as string),2,'0')) as calendar_year_month
        ,EXTRACT(ISOWEEK FROM calendar_date) as isoweek
        ,DATE_TRUNC(calendar_date, ISOWEEK) as isoweek_start_date
        ,LAST_DAY(calendar_date, WEEK(MONDAY)) AS isoweek_end_date
        ,EXTRACT(WEEK FROM calendar_date) as week
        ,DATE_TRUNC(calendar_date, WEEK) as week_start_date
        ,LAST_DAY(calendar_date, WEEK(SUNDAY)) AS week_end_date

      FROM
      (
      SELECT DATE_ADD('2021-01-01',INTERVAL param DAY) AS calendar_date
      FROM unnest(GENERATE_ARRAY(0, 10000, 1)) as param
      )
      ;;
    persist_for: "100 hours"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: month_count {
    type: count_distinct
    sql: ${calendar_year_month} ;;
  }

  measure: week_count {
    type: count_distinct
    sql: ${isoweek_start_date} ;;
    drill_fields: [detail*]
  }

  measure: year_count {
    type: count_distinct
    sql: ${calendar_year};;
    drill_fields: [detail*]
  }

  dimension: primKey {
    type: string
    sql: ${TABLE}.primKey ;;
    primary_key: yes
  }

  dimension: calendar_date {
    type: date
    datatype: date
    sql: ${TABLE}.calendar_date ;;
  }

  dimension: calendar_year {
    type: string
    sql: ${TABLE}.calendar_year ;;
  }

  dimension: calendar_year_month {
    type: string
    sql: ${TABLE}.calendar_year_month ;;
  }

  dimension: calendar_month {
    type: string
    sql: ${TABLE}.calendar_month ;;
  }

  dimension: isoweek {
    type: number
    sql: ${TABLE}.isoweek ;;
  }

  dimension: isoweek_start_date {
    type: date
    datatype: date
    sql: ${TABLE}.isoweek_start_date ;;
  }

  dimension: isoweek_end_date {
    type: date
    datatype: date
    sql: ${TABLE}.isoweek_end_date ;;
  }

  dimension: week {
    type: number
    sql: ${TABLE}.week ;;
  }

  dimension: week_start_date {
    type: date
    datatype: date
    sql: ${TABLE}.week_start_date ;;
  }

  dimension: week_end_date {
    type: date
    datatype: date
    sql: ${TABLE}.week_end_date ;;
  }

  set: detail {
    fields: [
      calendar_date,
      calendar_year,
      calendar_month,
      isoweek,
      isoweek_start_date,
      isoweek_end_date,
      week,
      week_start_date,
      week_end_date
    ]
  }
}

view: of_calendar_week {
  derived_table: {
    sql: select  isoweek_start_date,
                 isoweek_end_date,
                 MIN(calendar_month)      as calendar_month,
                 MIN(calendar_year_month) as calendar_year_month,
                 MIN(calendar_year)       as calendar_year
      from ${of_calendar.SQL_TABLE_NAME}
      group by 1,2
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: isoweek_start_date {
    type: date
    datatype: date
    sql: ${TABLE}.isoweek_start_date ;;
    primary_key: yes
  }

  dimension: isoweek_end_date {
    type: date
    datatype: date
    sql: ${TABLE}.isoweek_end_date ;;
  }

  dimension: calendar_month {
    type: string
    sql: ${TABLE}.calendar_month ;;
  }

  dimension: calendar_year_month {
    type: string
    sql: ${TABLE}.calendar_year_month ;;
  }

  dimension: calendar_year {
    type: string
    sql: ${TABLE}.calendar_year ;;
  }

  measure: year_count {
    type: count_distinct
    sql: ${TABLE}.calendar_year ;;
  }

  measure: month_count {
    type: count_distinct
    sql: ${TABLE}.calendar_year_month ;;
  }

  measure: week_count {
    type: count_distinct
    sql: ${TABLE}.isoweek_start_date ;;
  }

  set: detail {
    fields: [isoweek_start_date, isoweek_end_date, calendar_month, calendar_year_month, calendar_year]
  }
}

view: of_campaign {
  sql_table_name: `ONEFORCE.OF_CAMPAIGN`
    ;;

  dimension: actual_cost {
    type: number
    sql: ${TABLE}.ActualCost ;;
  }

  dimension: amount_all_opportunities {
    type: number
    sql: ${TABLE}.AmountAllOpportunities ;;
  }

  dimension: budgeted_cost {
    type: number
    sql: ${TABLE}.BudgetedCost ;;
  }

  dimension: campaign_member_record_type_id {
    type: string
    sql: ${TABLE}.CampaignMemberRecordTypeId ;;
  }

  dimension: campaign_owner_full_name {
    type: string
    sql: ${TABLE}.Campaign_Owner_FullName ;;
  }

  dimension: createdbyid {
    type: string
    sql: ${TABLE}.Createdbyid ;;
  }

  dimension_group: createddate {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.Createddate ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.Description ;;
  }

  dimension: description_ {
    type: string
    sql: ${TABLE}.Description_ ;;
  }

  dimension: destination {
    type: string
    sql: ${TABLE}.Destination ;;
  }

  dimension: destination_country {
    type: string
    sql: ${TABLE}.Destination_Country ;;
  }

  dimension: enddate {
    type: string
    sql: ${TABLE}.Enddate ;;
  }

  dimension: equipment_type {
    type: string
    sql: ${TABLE}.Equipment_Type ;;
  }

  dimension: expected_response {
    type: number
    sql: ${TABLE}.ExpectedResponse ;;
  }

  dimension: expected_revenue {
    type: number
    sql: ${TABLE}.ExpectedRevenue ;;
  }

  dimension: isactive {
    type: string
    sql: ${TABLE}.Isactive ;;
  }

  dimension: isdeleted {
    type: string
    sql: ${TABLE}.Isdeleted ;;
  }

  dimension: last_activity_date {
    type: string
    sql: ${TABLE}.LastActivityDate ;;
  }

  dimension: last_modified_by_id {
    type: string
    sql: ${TABLE}.LastModifiedByID ;;
  }

  dimension_group: last_modified {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.LastModifiedDate ;;
  }

  dimension_group: last_referenced {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.LastReferencedDate ;;
  }

  dimension_group: last_viewed {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.LastViewedDate ;;
  }

  dimension: name {
    label: "Campaign Name"
    type: string
    sql: ${TABLE}.Name ;;
  }

  dimension: number_sent {
    type: string
    sql: ${TABLE}.NumberSent ;;
  }

  dimension: numberof_contacts {
    type: number
    sql: ${TABLE}.NumberofContacts ;;
  }

  dimension: numberof_converted_leads {
    type: number
    sql: ${TABLE}.NumberofConvertedLeads ;;
  }

  dimension: numberof_leads {
    type: number
    sql: ${TABLE}.NumberofLeads ;;
  }

  dimension: numberof_opportunities {
    type: number
    sql: ${TABLE}.NumberofOpportunities ;;
  }

  dimension: numberof_responses {
    type: number
    sql: ${TABLE}.NumberofResponses ;;
  }

  dimension: numberof_won_opportunities {
    type: number
    sql: ${TABLE}.NumberofWonOpportunities ;;
  }

  dimension: oneforce_id {
    type: string
    sql: ${TABLE}.ONEForce_ID ;;
    primary_key: yes
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.Origin ;;
  }

  dimension: origin_country {
    type: string
    sql: ${TABLE}.Origin_Country ;;
  }

  dimension: owner_id {
    type: string
    sql: ${TABLE}.OwnerID ;;
  }

  dimension: parent_id {
    type: string
    sql: ${TABLE}.ParentID ;;
  }

  dimension: service_lane {
    type: string
    sql: ${TABLE}.Service_Lane ;;
  }

  dimension: service_scope {
    type: string
    sql: ${TABLE}.Service_Scope ;;
  }

  dimension: service_scope_code {
    type: string
    sql: ${TABLE}.Service_Scope_Code ;;
  }

  dimension: service_scope_group {
    type: string
    sql: ${TABLE}.Service_Scope_Group ;;
  }

  dimension: start_date {
    type: string
    sql: ${TABLE}.StartDate ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: trade_marketing_direction {
    type: string
    sql: ${TABLE}.Trade_marketing_direction ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
  }

  dimension: commodity {
    type: string
    sql:  ${TABLE}.Commodity;;
  }

  dimension: camp_eff_from {
    label: "Effective Date From"
    type: date
    datatype: date
    sql:  ${TABLE}.Effective_From;;
  }

  dimension: camp_eff_to {
    label: "Effective Date To"
    type: date
    datatype: date
    sql:  ${TABLE}.Effective_To;;
  }

  measure: count {
    type: count
    drill_fields: [name, campaign_owner_full_name]
  }
}

view: of_case {

  #FOR OFPROD before DCN-1065 deployment
  sql_table_name: `ONEFORCE.OF_CASE` ;;

  #FOR OFTRAIN
  #derived_table: {
  #  sql:
  #  SELECT * FROM `ONEFORCE.OF_CASE` t1
  #  WHERE
  #  t1.Origin in ('Chat','Phone','Email','Web','Manual')
  #  and t1.Status not in ('Waiting on Customer Response','Waiting on Internal ONE Team','Merged')
  #  and t1.Office is not null
  #  and t1.CreatedDate >= DATE('2022-03-28')
  #  and coalesce(case_handle_time_minutes,0) >= 0
  #  ;;

  #  partition_keys: ["createddate"]
  #  persist_for: "2 hours"
  #}

  # sql_table_name: `ONEFORCE.OF_CASE`;;
  # Below Dimensions and Measures from Line 5-94 created for Box-Plot
  dimension: case_handling_time_new {
    label: "case Handling Time1"
    type: number
    sql:  ${TABLE}.Case_Handle_Time_Minutes ;;
    value_format_name: decimal_1
  }

  measure: chat_handling_time_new {
    label: "chat Handling Time"
    type: number
    sql:  sum(${TABLE}.Case_Handle_Time_Minutes) ;;
    value_format_name: decimal_1
  }

  dimension: min_case_handling_time_dim {
    label: "min case Handling Time dim"
    type: string
    sql:  min(${TABLE}.Case_Handle_Time_Minutes) ;;
    value_format_name: decimal_1
  }

  dimension: max_case_handling_time_dim {
    label: "max case Handling Time dim"
    type: string
    sql:  max(${TABLE}.Case_Handle_Time_Minutes) ;;
    value_format_name: decimal_1
  }

  dimension: avg_case_handling_time_dim {
    label: "avg case Handling Time dim"
    type: string
    sql:  avg(distinct ${TABLE}.Case_Handle_Time_Minutes) ;;
    value_format_name: decimal_1
  }

  measure: min_case_handling_time_new {
    label: "min case Handling Time"
    type: min
    sql:  ${TABLE}.Case_Handle_Time_Minutes ;;
    value_format_name: decimal_1
  }

  measure: max_case_handling_time_new {
    label: "max case Handling Time"
    type: max
    sql:  ${TABLE}.Case_Handle_Time_Minutes ;;
    value_format_name: decimal_1
  }

  measure: avg_case_handling_time_new {
    label: "avg case Handling Time"
    type: average
    sql:  ${TABLE}.Case_Handle_Time_Minutes ;;
    value_format_name: decimal_1
  }

  measure: min_case_handling_time_string {
    label: "min case Handling Time string"
    type: string
    sql:  min(${TABLE}.Case_Handle_Time_Minutes) ;;
    value_format_name: decimal_1
  }

  measure: max_ase_handling_time_string {
    label: "max ase Handling Time string"
    type: string
    sql:  max(${TABLE}.Case_Handle_Time_Minutes) ;;
    value_format_name: decimal_1
  }

  measure: avg_case_handling_time_string {
    label: "avg case Handling Time string"
    type: string
    sql:  avg(distinct ${TABLE}.Case_Handle_Time_Minutes) ;;
    value_format_name: decimal_1
  }

  dimension: 25_case_handling_time_new {
    label: "25% case Handling Time"
    type: number
    sql:  safe_multiply(${TABLE}.Case_Handle_Time_Minutes,0.25) ;;
    value_format_name: decimal_1
  }

  dimension: 75_case_handling_time_new {
    label: "75% case Handling Time"
    type: number
    sql:  safe_multiply(${TABLE}.Case_Handle_Time_Minutes,0.75) ;;
    value_format_name: decimal_1
  }
  # Above Dimesions and Measures from line 5-94 created for Box-Plot

  dimension: casenumber {
    type: string
    sql: ${TABLE}.CaseNumber ;;
    #label:"{{ _view._name }}"
    label: "{% if  _view._name  == 'parent_case' %} Parent Case Number {% else %} Case Number {% endif %}"
  }

  dimension: parentid {
    type: string
    sql: ${TABLE}.ParentId ;;
    label: "Parent Case"
    group_label: "Subject & Description"
    hidden: yes
  }

  dimension: subject {
    type: string
    sql: ${TABLE}.Subject ;;
    label: : "Subject"
    group_label: "Subject & Description"
  }

  dimension: description {
    type: string
    sql: ${TABLE}.Description ;;
    label: "Description"
    group_label: "Subject & Description"
  }


  dimension: contactemail {
    type: string
    sql: ${TABLE}.ContactEmail ;;
    label: "Contact Email"
  }

  dimension: contract_customer_name {
    type: string
    sql: ${TABLE}.Contract_Customer_Name ;;
    label: "Contract Customer Name"
    group_label: "Customer Information"
    hidden: no
  }


  dimension: accountid {
    type: string
    sql: ${TABLE}.AccountId ;;
    label: "Customer Name"
    group_label: "Customer Information"
    hidden: yes
  }

  dimension: contactid {
    type: string
    sql: ${TABLE}.ContactId ;;
    label: "Contact Name"
    group_label: "Customer Information"
  }

  dimension: customer_segment {
    type: string
    sql: ${TABLE}.Customer_Segment ;;
    label: "Customer Segment"
    group_label: "Customer Information"
    hidden: yes
  }

  dimension: Reference_Type {
    type: string
    sql: ${TABLE}.Reference_Type ;;
    label: "Reference Type"
    group_label: "Additional Information"
  }

  dimension: p_i_claim_number {
    type: string
    sql: ${TABLE}.P_I_Claim_Number ;;
    label: "P & I Claim Number"
    group_label: "Additional Information"
  }

  dimension: container_number {
    type: string
    sql: ${TABLE}.Container_Number ;;
    label: "Container Number"
    group_label: "Additional Information"
  }

  dimension: booking_number {
    type: string
    sql: ${TABLE}.Booking_Number ;;
    label: "Booking Number"
    group_label: "Additional Information"
  }

  dimension: is_valid_booking_number {
    type: string
    sql: CASE WHEN LENGTH(${TABLE}.Booking_Number)=12 AND UPPER(${TABLE}.Booking_Number)=${TABLE}.Booking_Number THEN 'Yes' ELSE 'No' END  ;;
    label: "Is Valid Booking Number"
    group_label: "Additional Information"
  }


  dimension: contract_number {
    type: string
    sql: ${TABLE}.Contract_Number ;;
    label: "Contract Number"
    group_label: "Additional Information"

  }

  dimension: is_valid_contract_number {
    type: string
    sql: CASE WHEN ${TABLE}.Contract_Number IS NOT NULL AND ${TABLE}.Contract_Customer_Name IS NULL THEN 'No' ELSE 'Yes' END ;;
    label: "Is Valid Contract Number"
    group_label: "Additional Information"

  }

  dimension: has_contract_customer_name {
    type: string
    sql: CASE WHEN ${TABLE}.Contract_Customer_Name IS NOT NULL THEN 'Yes' ELSE 'No' END ;;
    label: "Has Contract Customer Name"
    group_label: "Additional Information"
  }


  dimension: support_email_cc {
    type: string
    sql: ${TABLE}.Support_Email_CC ;;
    label: "Support Email CC"
    group_label: "Additional Information"
  }

  dimension: support_email_to {
    type: string
    sql: ${TABLE}.Support_Email_TO ;;
    label: "Support Email TO"
    group_label: "Additional Information"
  }

  dimension: claim_amount {
    type: number
    sql: ${TABLE}.Claim_Amount ;;
    label: "Claim Amount"
    group_label: "Additional Information"
  }


  dimension: origin {
    type: string
    sql: ${TABLE}.Origin ;;
    label: : "Channel"
    group_label: "Case Information"
    drill_fields: [drillfields*]
  }

  dimension: is_online_channel {
    type: string
    sql: (CASE WHEN ${TABLE}.Origin ="Chat" or ${TABLE}.Origin ="Phone"  THEN "Yes" ELSE "No" END) ;;
    label: : "Is Online Channel"
    group_label: "Case Information"
  }


  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
    label: : "Type"
    group_label: "Case Information"
  }


  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
    label: "Status"
    group_label: "Case Information"
    drill_fields: [drillfields*]
  }

  dimension: priority {
    type: string
    sql: ${TABLE}.Priority ;;
    label: : "Priority"
  }


  dimension: country {
    type: string
    label: "Individual Country"
    group_label: "Case Information"
    sql: case when ${country2}='HK' then 'HK & SCN'
      when ${country2}='CN' then 'NCCN' else ${country2} end ;;
  }

  dimension: country2 {
    type: string
    group_label: "Case Information"
    sql: ${TABLE}.Country ;;
  }

  dimension: office {
    type: string
    sql: ${TABLE}.Office ;;
    label: : "Service Office"
    group_label: "Case Information"
  }

  dimension: case_resolved {
    type: string
    sql: ${TABLE}.Case_Resolved ;;
    label: : "Is Case Resolved"
    group_label: "Resolution Information"
  }

  dimension: transfer_reason {
    type: string
    sql: ${TABLE}.Transfer_Reason ;;
    label: : "Transfer Reason"
    group_label: "Resolution Information"
  }

  dimension: transfer_ratio {
    type: string
    sql: case
          when ${TABLE}.Transfer_Reason is null and ${createddate_filter_year}<2023 then 'No'
          when ${is_transfer}='true' and ${createddate_filter_year}>2022 then 'Yes'
          when ${is_transfer}='false' and ${createddate_filter_year}>2022 then 'No'
       else 'Yes' end ;;
    label: : "Transfer Ratio"
    group_label: "Resolution Information"
  }

  dimension: transfer_reason_others {
    type: string
    sql: ${TABLE}.Transfer_Reason_Others ;;
    label: : "Transfer Reason Others"
    group_label: "Resolution Information"
  }

  dimension: resolution_reason {
    type: string
    sql: CASE WHEN ${TABLE}.Resolution_Reason IS NULL THEN 'None' ELSE ${TABLE}.Resolution_Reason END ;;
    label: : "Resolution Reason "
    group_label: "Resolution Information"
    drill_fields: [drillfields*]
  }

  dimension: sub_resolution_reason {
    type: string
    sql: ${TABLE}.Sub_Resolution_Reason ;;
    label: : "Sub Resolution Reason"
    group_label: "Resolution Information"
    drill_fields: [drillfields*]
  }

  dimension: other_resolution_reason {
    type: string
    sql: ${TABLE}.Other_Resolution_Reason ;;
    label: : "Other Resolution Reason "
    group_label: "Resolution Information"
  }

  dimension: survey_comment {
    type: string
    sql: ${TABLE}.Survey_Comment ;;
    label: : "Survey Comment"
    group_label: "Customer Feedback"
  }


  dimension: case_rating {
    type: string
    sql: CASE WHEN ${TABLE}.Case_Rating IS NULL THEN 'No Rating' ELSE ${TABLE}.Case_Rating END ;;
    label: : "Case Rating"
    group_label: "Customer Feedback"
  }


  dimension: is_need_get_transcript {
    type: string
    sql: ${TABLE}.Is_Need_Get_Transcript ;;
    label: : "Is Need Get Transcript"
    group_label: "Customer Feedback"
  }

  dimension: first_time_use_chat {
    type: string
    sql: ${TABLE}.First_Time_Use_Chat ;;
    label: : "First_Time_Use_Chat"
    group_label: "Customer Feedback"
  }

  dimension: reason {
    type: string
    sql: ${TABLE}.Reason ;;
    label: "Category (L1)"
    group_label: "Intent"
    drill_fields: [drillfields*]
  }

  dimension: case_sub_reason {
    type: string
    sql: ${TABLE}.Case_Sub_Reason ;;
    label: "Case Sub Reason"
    group_label: "Case Details"
  }

  dimension: total_escalation {
    type: number
    sql: CAST(${TABLE}.Total_Escalation AS NUMERIC) ;;
    label:"Total Escalation"
    view_label:"Current Escalation Details"
  }

  dimension: escalated_by {
    type: string
    sql: ${TABLE}.Escalated_By ;;
    label:"Escalated By"
    group_label:"Current Escalation Details"
    hidden: yes
  }

  dimension: escalated_to {
    type: string
    sql: ${TABLE}.Escalated_To ;;
    label:"Escalated To"
    group_label:"Current Escalation Details"
    hidden: yes
  }


  dimension_group: escalation_open_date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Escalation_Open_Date;;
    label:"Escalated Open Date"
    group_label:"Current Escalation Details"
    hidden: yes
  }

  dimension: escalation_reason {
    type: string
    sql: ${TABLE}.Escalation_Reason ;;
    label:"Escalated Reason"
    group_label:"Current Escalation Details"
    hidden: yes
  }


  dimension: escalation_type {
    type: string
    sql: ${TABLE}.Escalation_Type ;;
    label:"Escalated Type"
    group_label:"Current Escalation Details"
    hidden: yes
  }

  dimension: case_age {
    type: number
    sql: ${TABLE}.Case_Age ;;
    label:"Case Age"
    group_label: "System Information"
  }
  dimension: case_age_group {

    type: number
    sql: CASE
      WHEN ${TABLE}.Case_Age <=2 THEN "1-2 Days"
      WHEN ${TABLE}.Case_Age >2 and ${TABLE}.Case_Age <=5 THEN "3-5 Days"
      WHEN ${TABLE}.Case_Age >5 and ${TABLE}.Case_Age <=10 THEN "6-10 Days"
      WHEN ${TABLE}.Case_Age >10 and ${TABLE}.Case_Age <=20 THEN "11-20 Days"
      ELSE "More than 20 Days"
      END;;
    label:"Case Age Group"
    group_label: "System Information"
  }

  dimension: is_nurtured {
    type: string
    sql: ${TABLE}.Is_Nurtured ;;
    label: "Is Nurtured"
    group_label: "System Information"
  }

  dimension: FRT_sql_distinct_key {
    type: string
    label: "SQL Distinct Key"
    sql: case when {% parameter responsetime_Param %}= "Case Level" then
           ${of_case.oneforce_id}
          when {% parameter responsetime_Param %}= "Chat Transcript"  then
           ${of_case.oneforce_id}||${of_case.origin}||${of_chat_transcript.oneforce_id}
          end;;
  }

  dimension: case_owner {
    type: string
    sql: ${TABLE}.Case_Owner ;;
    label: "Case Owner"
    group_label:"System Information"
    hidden: yes
  }

  dimension: case_owner_role {
    type: string
    sql: ${TABLE}.Case_Owner_Role ;;
    label: "Case Owner Role"
    group_label: "System Information"
  }

  dimension: created_by_id {
    type: string
    sql: ${TABLE}.CreatedById ;;
    label: "Created By Id"
    group_label: "System Information"
    hidden: yes
  }


  dimension_group: last_modified {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.LastModifiedDate ;;
    label: "Last Modified Date"
    view_label: "System Information"
  }

  dimension_group: closeddate {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      fiscal_quarter,
      quarter,
      year
    ]
    sql: ${TABLE}.ClosedDate ;;
    group_label:"Close Date"
    label: "Close Date"
  }

  dimension_group: first_response_time {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.First_Response_Time ;;
    group_label: "First Response Time"
    label: "First Response Time"
    hidden: yes
  }

  dimension_group: first_response_date_time {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.First_Response_Date_Time ;;
    group_label: "First Response Date Time"
    label: "First Response Date Time"
  }

  dimension_group: createddate {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week,
      month,
      fiscal_quarter,
      quarter,
      year
    ]
    group_label: "Open Date"
    label: "Open Date"
    sql: ${TABLE}.CreatedDate ;;
    drill_fields: [drillfields*]
  }


  dimension: createddate_Weekfilter {
    type: date
    label: "Open Date Week"
    sql: ${createddate_week} ;;
  }

  dimension: isescalated{
    type: string
    sql: ${TABLE}.IsEscalated ;;
    label: "Is Escalated"
  }



  dimension: category_l1 {
    type: string
    sql: ${TABLE}.Category_L1 ;;
    label:"category_l1"
    group_label: "Intents"
    hidden: yes
  }

  dimension: sub_category_l2 {
    type: string
    sql: ${TABLE}.Sub_Category_L2 ;;
    label: "Category (L2)"
    group_label: "Intents"
    drill_fields: [drillfields*]
  }


  dimension: subordinate_category_l3 {
    type: string
    sql: ${TABLE}.Subordinate_Category_L3 ;;
    label:"Topic (L3)"
    group_label: "Intents"
    drill_fields: [drillfields*]
  }



  dimension: ownerid {
    type: string
    sql: ${TABLE}.OwnerId ;;
    label:"Owner ID"
    hidden: yes

  }

  dimension: oneforce_id {
    type: string
    sql: ${TABLE}.ONEForce_Id ;;
    label:"Case ID"
    hidden: yes
    primary_key: yes
  }

  dimension: escalation_history {
    type: string
    sql: ${TABLE}.Escalation_History ;;
    label: "EH Name"
    group_label: "Current Escalation Details"
    hidden: yes
  }

  set: detail {
    fields: [
      casenumber,
      service_office_hierarchy.country,
      case_owner.officetype,
      case_owner_name,
      ct_owner_name1,
      of_user.name,
      ecomm_id,
      of_contact.name,
      contactemail,
      of_customer.name,
      status,
      origin,
      type,
      reason,
      sub_category_l2,
      subordinate_category_l3,
      createddate_date,
      resolved_date_date,
      closeddate_date,
      case_age,
      first_contact_resolution,
      Case_Net_Promoter_Score,
      Case_First_Response_Time_Minutes,
      of_chat_transcript.Chat_First_Response_Time_Mins_avg,
      case_handling_time,
      of_chat_transcript.chat_handle_time1,
    ]
  }

  set: detail_csat {
    fields: [
      casenumber,
      service_office_hierarchy.country,
      case_owner.officetype,
      case_owner_name,
      ct_owner_name1,
      of_user.name,
      ecomm_id,
      of_contact.name,
      contactemail,
      of_customer.name,
      status,
      origin,
      type,
      reason,
      sub_category_l2,
      subordinate_category_l3,
      createddate_date,
      resolved_date_date,
      closeddate_date,
      case_age,
      first_contact_resolution,
      case_rating,
      of_chat_transcript.chat_case_rating,
      Case_Net_Promoter_Score,
      of_chat_transcript.chat_case_net_promoter_score,
      Case_First_Response_Time_Minutes,
      of_chat_transcript.Chat_First_Response_Time_Mins_avg,
      case_handling_time,
      of_chat_transcript.chat_handle_time1,
    ]
  }
  set: detail_fcr {
    fields: [
      casenumber,
      service_office_hierarchy.country,
      case_owner.officetype,
      case_owner_name,
      ct_owner_name1,
      of_user.name,
      ecomm_id,
      of_contact.name,
      contactemail,
      of_customer.name,
      status,
      origin,
      type,
      reason,
      sub_category_l2,
      subordinate_category_l3,
      createddate_date,
      resolved_date_date,
      closeddate_date,
      case_age,
      first_contact_resolution,
      total_transfer,
      total_escalation,
      Case_Net_Promoter_Score,
      Case_First_Response_Time_Minutes,
      of_chat_transcript.Chat_First_Response_Time_Mins_avg,
      case_handling_time,
      of_chat_transcript.chat_handle_time1,
    ]
  }

  set: responsetime_details {
    fields: [
      casenumber,
      service_office_hierarchy.country,
      case_owner.officetype,
      case_owner_name,
      of_user.name,
      ecomm_id,
      of_contact.name,
      contactemail,
      of_customer.name,
      status,
      origin,
      type,
      reason,
      sub_category_l2,
      subordinate_category_l3,
      createddate_date,
      resolved_date_date,
      closeddate_date,
      case_age,
      first_contact_resolution,
      Case_Net_Promoter_Score,
      Case_First_Response_Time_Minutes,
      of_chat_transcript.Chat_First_Response_Time_Mins_avg,
      case_handling_time,
      of_chat_transcript.chat_handle_time1,
    ]
  }

  set: details1 {
    fields: [
      casenumber,
      service_office_hierarchy.country,
      case_owner.officetype,
      case_owner_name,
      ct_owner_name1,
      of_user.name,
      ecomm_id,
      of_contact.name,
      contactemail,
      of_customer.name,
      status,
      origin,
      type,
      reason,
      sub_category_l2,
      subordinate_category_l3,
      createddate_date,
      resolved_date_date,
      closeddate_date,
      case_age,
      total_transfer,
      first_contact_resolution,
      Avg_First_Response_Time,
      avg_handling_time,
      of_chat_transcript.avg_chat_handle_time,
      Case_Net_Promoter_Score,
    ]
  }

  set: escdetail {
    fields: [
      casenumber,
      number_of_escalated_cases,
      service_office_hierarchy.country,
      case_owner.officetype,
      case_owner_name,
      of_user.name,
      ecomm_id,
      of_contact.name,
      contactemail,
      of_customer.name,
      status,
      origin,
      type,
      reason,
      sub_category_l2,
      subordinate_category_l3,
      createddate_date,
      resolved_date_date,
      closeddate_date,
      case_age,
      first_contact_resolution,
      Avg_First_Response_Time,
      avg_handling_time,
      of_chat_transcript.avg_chat_handle_time,
      Case_Net_Promoter_Score,
    ]
  }

  set: drillfields {
    fields: [
      Regional_Head_Office,
      case_country,
      case_office_code,
      origin,
      Initial_Queue_Name,
      sub_category_l2,
      subordinate_category_l3,
      of_customer_group.cust_grp_and_name,
      of_customer.customer_cd_and_name,
      case_owner_name,
      of_user.name,
      priority,
      case_age_group,
      status,
      nps_group,
      createddate_month,
      ecomm_id,
      of_contact.name,
      contactemail
    ]
  }

  set: transferdetail {
    fields: [
      casenumber,
      service_office_hierarchy.country,
      case_owner.officetype,
      case_owner_name,
      case_transfer_history.transfer_by_name,
      case_transfer_history.transfer_from_name,
      case_transfer_history.transfer_to_name,
      case_transfer_history.transfer_type,
      case_transfer_history.last_transfer_date_time,
      case_transfer_history.transfer_duration_in_minutes,
      case_transfer_history.transfer_reason,
      total_transfer,
      of_customer.name,
      of_contact.name,
      contactemail,
      status,
      origin,
      type,
      reason,
      sub_category_l2,
      subordinate_category_l3,
    ]
  }

##############Added Dimensions


#dimension: additional_cargo_details {
#type: string
#sql: ${TABLE}.Additional_Cargo_Details ;;
#hidden: yes
#}

#dimension: additional_contact_emails {
#type: string
#sql: ${TABLE}.Additional_Contact_Emails ;;
#hidden: yes
#}

  dimension: amazon_connect_queue {
    type: string
    sql: ${TABLE}.Amazon_Connect_Queue ;;
    hidden: yes
  }

  dimension: applicant_email {
    type: string
    sql: ${TABLE}.Applicant_Email ;;
    hidden: yes
  }

  dimension: applicant_name {
    type: string
    sql: ${TABLE}.Applicant_Name ;;
    hidden: yes
  }

  dimension: applicant_party {
    type: string
    sql: ${TABLE}.Applicant_Party ;;
    hidden: yes
  }

  dimension: applicant_phone_number {
    type: string
    sql: ${TABLE}.Applicant_Phone_Number ;;
    hidden: yes
  }

#dimension: are_the_rates_filed_for_the_new_destinat {
#type: string
#sql: ${TABLE}.Are_the_rates_filed_for_the_new_destinat ;;
#hidden: yes
#}

  dimension: article_recommendation_reason {
    type: string
    sql: ${TABLE}.Article_Recommendation_Reason ;;
    hidden: yes
  }

#dimension: article_recommendation_type {
#type: string
#sql: ${TABLE}.Article_Recommendation_Type ;;
#hidden: yes
#}

  dimension: asset_id {
    type: string
    sql: ${TABLE}.AssetId ;;
    hidden: yes
  }

  dimension_group: assigned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.AssignedDate ;;
    hidden: yes
  }

#dimension: auto_titles {
#type: string
#sql: ${TABLE}.Auto_Titles ;;
#hidden: yes
#}

  dimension: bill_of_lading_number {
    type: string
    sql: ${TABLE}.Bill_of_Lading_Number ;;
    hidden: yes
  }

  dimension: bkg_office {
    type: string
    sql: ${TABLE}.BKG_Office ;;
    hidden: yes
  }

#dimension: boilerplate_review {
#type: string
#sql: ${TABLE}.Boilerplate_Review ;;
#hidden: yes
#}

  dimension: business_hours_id {
    type: string
    sql: ${TABLE}.BusinessHoursId ;;
    hidden: yes
    label: "Business Hours"
    group_label: "System Information"
  }

  dimension: bypass_validation_rules {
    type: string
    sql: ${TABLE}.Bypass_Validation_Rules ;;
    hidden: yes
  }

  dimension_group: calculated_awaiting_cust_remind_datetime {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Calculated_Awaiting_Cust_Remind_Datetime ;;
    label: "Calculated Awaiting Cust Remind Datetime"
    view_label: "System Information"
  }

  dimension_group: calculated_close_date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Calculated_Close_Date_Time ;;
    label: "Calculated Close Date/Time"
    view_label: "System Information"
  }

  dimension_group: calculated_date_time_for_one_team {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Calculated_Date_Time_for_ONE_Team ;;
    label: "Calculated Date/Time for ONE Team"
    view_label: "System Information"
  }

  dimension: cargo_nature {
    type: string
    sql: ${TABLE}.Cargo_Nature ;;
    hidden: yes
  }

#dimension_group: close_out {
#type: time
#timeframes: [
#raw,
#date,
#week,
#month,
#quarter,
#year
#]
#convert_tz: no
#datatype: date
#sql: ${TABLE}.Close_Out_Date ;;
#hidden: yes
#}


  dimension: comments {
    type: string
    sql: ${TABLE}.Comments ;;
    hidden: yes
  }

  dimension: commodity {
    type: string
    sql: ${TABLE}.Commodity ;;
    hidden: yes
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.Company_Name ;;
    hidden: yes
  }


  dimension: contact_fax {
    type: string
    sql: ${TABLE}.ContactFax ;;
    hidden: yes
  }

  dimension: contact_id {
    type: string
    sql: ${TABLE}.Contact_Id ;;
    hidden: yes
  }
  dimension: contact_mobile {
    type: string
    sql: ${TABLE}.ContactMobile ;;
    hidden: yes
  }

  dimension: contact_phone {
    type: string
    sql: ${TABLE}.ContactPhone ;;
    hidden: yes
  }

#dimension: container {
#type: string
#sql: ${TABLE}.Container ;;
#hidden: yes
#}

#dimension: container_type {
#type: string
#sql: ${TABLE}.Container_Type ;;
#hidden: yes
#}

  dimension: contract_account_name {
    type: string
    sql: ${TABLE}.Contract_Account_Name ;;
    hidden: yes
  }


#dimension: current_destination {
#type: string
#sql: ${TABLE}.Current_Destination ;;
#hidden: yes
#}

  dimension: customer_code {
    type: string
    sql: ${TABLE}.Customer_Code ;;
    hidden: yes
  }

  dimension: customer_info {
    type: string
    sql: ${TABLE}.Customer_Info ;;
    hidden: yes
  }

#dimension: customs_exam {
#type: string
#sql: ${TABLE}.CUSTOMS_Exam ;;
#hidden: yes
#}

  dimension_group: resolved_date  {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DateTimeResolved ;;
    label: "Resolved Date"
  }

#dimension_group: date_time_resolved {
#type: time
#datatype: datetime
#timeframes: [
#raw,
#time,
#date,
#week,
#month,
#quarter,
#year
#]
#sql: ${TABLE}.DateTimeResolved ;;
#  group_label:"Resolved Date"
#  label: "Resolved Date"
#}


  dimension_group: date_time_waiting_on_customer_response {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Date_Time_Waiting_on_Customer_Response ;;
    hidden: yes
  }

#dimension: direct_care_account {
#type: string
#sql: ${TABLE}.Direct_Care_Account ;;
#hidden: yes
#}

#dimension: e_com_account {
#type: string
#sql: ${TABLE}.eCom_Account ;;
#hidden: yes
#}

#dimension: e_comm_user_id {
  # label: "eCom ID"
  #type: string
  #sql: ${TABLE}.eComm_User_ID ;;
#}

#  dimension: e_commerce_user_id{
#    label: "eComm ID"
#    type: string
#    sql: ${TABLE}.eCommerce_UserID ;;
#    drill_fields: [drillfields*]
#  }

#dimension: ebo {
#type: number
#sql: ${TABLE}.EBO ;;
#hidden: yes
#}

#dimension: edt {
#type: string
#sql: ${TABLE}.EDT ;;
#hidden: yes
#}

  dimension_group: edw_upd_dt {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.EDW_UPD_DT ;;
    hidden: yes
  }

#dimension: email_assigned {
#type: string
#sql: ${TABLE}.Email_Assigned ;;
#hidden: yes
#}

#dimension: end_status_1 {
#type: string
#sql: ${TABLE}.End_Status_1 ;;
#hidden: yes
#}

#dimension_group: end_status_time_1 {
#type: time
#timeframes: [
#raw,
#time,
#date,
#week,
#month,
#quarter,
#year
#]
#sql: ${TABLE}.End_Status_Time_1 ;;
#hidden: yes
#}

  dimension: entitlement_id {
    type: string
    sql: ${TABLE}.EntitlementId ;;
    hidden: yes
  }

  dimension: escalation_history_reason {
    type: string
    sql: ${TABLE}.Escalation_History_Reason ;;
    label: "Escalation Reason"
    group_label: "Current Escalation Details"
    hidden: yes
  }

  dimension_group: escalation_open {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Escalation_Open_Date ;;
    hidden: yes
  }

#dimension: eta {
#type: string
#sql: ${TABLE}.ETA ;;
#hidden: yes
#}

#dimension: etd {
#type: string
#sql: ${TABLE}.ETD ;;
#hidden: yes
#}

  dimension: first_end_status {
    type: string
    sql: ${TABLE}.First_End_Status ;;
    hidden: yes
  }

  dimension_group: first_end_status {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.First_End_Status_Time ;;
    hidden: yes
  }

  dimension: first_pending_reason {
    type: string
    sql: ${TABLE}.First_Pending_Reason ;;
    hidden: yes
  }

  dimension: first_processor {
    type: string
    sql: ${TABLE}.First_Processor ;;
    hidden: yes
  }

  dimension_group: first_reply {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.First_Reply_Time ;;
    hidden: yes
  }


  dimension: first_response_user {
    type: string
    sql: ${TABLE}.First_Response_User ;;
    hidden: yes
  }

  dimension_group: first_restart {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.First_Restart_Time ;;
    hidden: yes
  }

  dimension: forwarder_name {
    type: string
    sql: ${TABLE}.Forwarder_Name ;;
    hidden: yes
  }

  dimension: fourth_end_status {
    type: string
    sql: ${TABLE}.Fourth_End_Status ;;
    hidden: yes
  }

  dimension_group: fourth_end_status {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Fourth_End_Status_Time ;;
    hidden: yes
  }

  dimension: fourth_processor {
    type: string
    sql: ${TABLE}.Fourth_Processor ;;
    hidden: yes
  }

  dimension: internal_correspondence {
    type: string
    sql: ${TABLE}.Internal_Correspondence ;;
    hidden: yes
  }

  dimension: is_chat_survey_submitted {
    type: string
    sql: ${TABLE}.Is_Chat_Survey_Submitted ;;
    hidden: yes
  }

  dimension: is_closed {
    type: string
    sql: ${TABLE}.IsClosed ;;
    hidden: yes
  }

  dimension: is_closed_on_create {
    type: string
    sql: ${TABLE}.IsClosedOnCreate ;;
    hidden: yes
  }

  dimension: is_deleted {
    type: string
    sql: ${TABLE}.IsDeleted ;;
    hidden: yes
  }

  dimension: is_dummy {
    type: string
    sql: ${TABLE}.IsDummy ;;
    hidden: yes
  }


  dimension: is_stopped {
    type: string
    sql: ${TABLE}.IsStopped ;;
    hidden: yes
  }

#dimension: lane {
#type: string
#sql: ${TABLE}.Lane ;;
#hidden: yes
#}

  dimension: language {
    type: string
    sql: ${TABLE}.Language ;;
    hidden: yes
  }

  dimension: last_modified_by_id {
    type: string
    sql: ${TABLE}.LastModifiedById ;;
    hidden: yes
    label: "Last Modified By"
    group_label: "System Information"
  }

#dimension: late_gates {
#type: number
#sql: ${TABLE}.Late_Gates ;;
#hidden: yes
#}

  dimension: milestone_status {
    type: string
    sql: ${TABLE}.MilestoneStatus ;;
    hidden: yes
  }

#dimension: missing_s_i {
#type: string
#sql: ${TABLE}.Missing_S_I ;;
#hidden: yes
#}

#dimension: new_destination {
#type: string
#sql: ${TABLE}.New_Destination ;;
#hidden: yes
#}

  dimension: nfvoice__voicemail_callback_phone {
    type: string
    sql: ${TABLE}.nfvoice__Voicemail_Callback_Phone ;;
    hidden: yes
  }

  dimension: nfvoice__voicemail_link {
    type: string
    sql: ${TABLE}.nfvoice__Voicemail_Link ;;
    hidden: yes
  }

  dimension: nfvoice_voicemail_callback_phone {
    type: string
    sql: ${TABLE}.nfvoice_Voicemail_Callback_Phone ;;
    hidden: yes
  }

  dimension: nfvoice_voicemail_contact_attributes {
    type: string
    sql: ${TABLE}.nfvoice_Voicemail_Contact_Attributes ;;
    hidden: yes
  }

#dimension: onboarding {
#type: string
#sql: ${TABLE}.Onboarding ;;
#hidden: yes
#}

#dimension: opus_request_number {
#type: string
#sql: ${TABLE}.Opus_Request_Number ;;
#hidden: yes
#}

  dimension: origin_indicator {
    type: string
    sql: ${TABLE}.Origin_Indicator ;;
    hidden: yes
    label: "origin_indicator"
    group_label: "Header"
  }

#dimension: original_discharge_port_pod {
#type: string
#sql: ${TABLE}.Original_Discharge_Port_POD ;;
#hidden: yes
#}

  dimension: other_reason {
    type: string
    sql: ${TABLE}.Other_Reason ;;
    hidden: yes
  }

#dimension: out_of_scope {
#type: string
#sql: ${TABLE}.Out_of_Scope ;;
#hidden: yes
#}

#dimension: pending_reason_1 {
#type: string
#sql: ${TABLE}.Pending_Reason_1 ;;
#hidden: yes
#}

#dimension: pod_change_request {
#type: string
#sql: ${TABLE}.POD_CHANGE_REQUEST ;;
#hidden: yes
#}

  dimension: port {
    type: string
    sql: ${TABLE}.PORT ;;
    hidden: yes
  }

  dimension: post_reconciliation_completed_with_biz {
    type: string
    sql: ${TABLE}.Post_Reconciliation_Completed_with_biz ;;
    hidden: yes
  }


  dimension: priority_formula {
    type: string
    sql: ${TABLE}.Priority_Formula ;;
    hidden: yes
    label: "Priority Indicator"
    group_label: "Header"
  }

  dimension: privacy_policy_consent {
    type: string
    sql: ${TABLE}.Privacy_Policy_Consent ;;
    hidden: yes
  }

#dimension: processor_1 {
#type: string
#sql: ${TABLE}.Processor_1 ;;
#hidden: yes
#}

  dimension: product_id {
    type: string
    sql: ${TABLE}.ProductId ;;
    hidden: yes
  }

#dimension: reason_s_for_cod_diversion {
#type: string
#sql: ${TABLE}.Reason_s_for_COD_Diversion ;;
#hidden: yes
#}

  dimension: record_type_id {
    type: string
    sql: ${TABLE}.RecordTypeId ;;
    hidden: yes
    label: "Case Record Type"
    group_label: "System Information"
  }

  dimension: reference_number {
    type: string
    sql: ${TABLE}.Reference_Number ;;
    hidden: yes
  }

  dimension: reference_number_type {
    type: string
    sql: ${TABLE}.Reference_Number_Type ;;
    hidden: yes
  }


#dimension: reporting {
#type: string
#sql: ${TABLE}.Reporting ;;
#hidden: yes
#}

#dimension: request_type {
#type: string
#sql: ${TABLE}.Request_Type ;;
#hidden: yes
#}

  dimension: requestor_type {
    type: string
    sql: ${TABLE}.Requestor_Type ;;
    hidden: yes
  }

  dimension: response_flag {
    type: string
    sql: ${TABLE}.Response_Flag ;;
    hidden: yes
  }

  dimension: response_received {
    type: string
    sql: ${TABLE}.Response_Received ;;
    hidden: yes
  }

  dimension: revised_destination {
    type: string
    sql: ${TABLE}.Revised_Destination ;;
    hidden: yes
  }

  dimension: second_end_status {
    type: string
    sql: ${TABLE}.Second_End_Status ;;
    hidden: yes
  }

#dimension_group: second_end_status {
#type: time
#timeframes: [
#raw,
#time,
#date,
#week,
#month,
#quarter,
#year
#]
#sql: ${TABLE}.Second_End_Status_Time ;;
#hidden: yes
#}

  dimension: second_pending_reason {
    type: string
    sql: ${TABLE}.Second_Pending_Reason ;;
    hidden: yes
  }

  dimension: second_processor {
    type: string
    sql: ${TABLE}.Second_Processor ;;
    hidden: yes
  }

  dimension_group: second_reply {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Second_Reply_Time ;;
    hidden: yes
  }

  dimension_group: second_restart {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Second_Restart_Time ;;
    hidden: yes
  }

  dimension: service_contract_id {
    type: string
    sql: ${TABLE}.ServiceContractId ;;
    hidden: yes
  }

  dimension: shipment_number {
    type: string
    sql: ${TABLE}.Shipment_Number ;;
    hidden: yes
  }

  dimension: shipper_name {
    type: string
    sql: ${TABLE}.Shipper_Name ;;
    hidden: yes
  }

  dimension_group: sla_exit {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.SlaExitDate ;;
    hidden: yes
  }

  dimension_group: sla_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.SlaStartDate ;;
    hidden: yes
  }

  dimension: source_id {
    type: string
    sql: ${TABLE}.SourceId ;;
    hidden: yes
  }

  dimension_group: stop_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.StopStartDate ;;
    hidden: yes
  }

  dimension: subordinate_category_l4 {
    type: string
    sql: ${TABLE}.Subordinate_Category_L4 ;;
    label:"Subtopic (L4)"
    group_label: "Intents"
  }

  dimension: supplied_company {
    type: string
    sql: ${TABLE}.SuppliedCompany ;;
    hidden: yes
  }

  dimension: supplied_email {
    type: string
    sql: ${TABLE}.SuppliedEmail ;;
    label: "Web Email"
    group_label: "System Information"
  }

  dimension: supplied_first_name {
    type: string
    sql: ${TABLE}.SuppliedFirstName ;;
    hidden: yes
  }

  dimension: supplied_last_name {
    type: string
    sql: ${TABLE}.SuppliedLastName ;;
    hidden: yes
  }

  dimension: supplied_name {
    type: string
    sql: ${TABLE}.SuppliedName ;;
    hidden: yes
  }

  dimension: supplied_phone {
    type: string
    sql: ${TABLE}.SuppliedPhone ;;
    hidden: yes
  }

  dimension: third_end_status {
    type: string
    sql: ${TABLE}.Third_End_Status ;;
    hidden: yes
  }

  dimension_group: third_end_status {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Third_End_Status_Time ;;
    hidden: yes
  }

  dimension: third_pending_reason {
    type: string
    sql: ${TABLE}.Third_Pending_Reason ;;
    hidden: yes
  }

  dimension: third_processor {
    type: string
    sql: ${TABLE}.Third_Processor ;;
    hidden: yes
  }

  dimension_group: third_reply {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Third_Reply_Time ;;
    hidden: yes
  }

  dimension_group: third_restart {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Third_Restart_Time ;;
    hidden: yes
  }

  dimension: training {
    type: string
    sql: ${TABLE}.Training ;;
    hidden: yes
  }

#dimension: type_of_diversion {
#type: string
#sql: ${TABLE}.Type_of_Diversion ;;
#hidden: yes
#}

  dimension: unique_case_key {
    type: string
    sql: ${TABLE}.UniqueCaseKey ;;
    hidden: yes
  }

#dimension: vessel_cleaned {
#type: string
#sql: ${TABLE}.Vessel_Cleaned ;;
#hidden: yes
#}

  dimension: voice_call {
    type: string
    sql: ${TABLE}.Voice_Call ;;
    hidden: yes
  }

  dimension: vvd {
    type: string
    sql: ${TABLE}.VVD ;;
    hidden: yes
  }

  dimension: active_case {
    type: string
    sql: (CASE WHEN ${status} ='Resolved' or ${status} ='Closed' THEN 'No' ELSE 'Yes' END)   ;;

  }

  dimension : case_owner_name {
    type : string
    sql:  CASE WHEN ${of_queue.developer_name} is not Null then ${of_queue.developer_name} else ${case_owner.name} END;;
    label : "Case Owner Name"
    drill_fields: [drillfields*]
  }

  dimension : first_contact_resolution {
    type: string
    sql: CASE
          WHEN ${origin} = 'Chat' and ${TABLE}.is_fcr ='true' THEN 'Yes'
          WHEN ${origin} = 'Chat' and ${TABLE}.is_fcr ='false' THEN 'No'
          WHEN ${total_escalation} =0 and ${transfer_reason} is Null and ${active_case} = 'No' THEN 'Yes' ELSE 'No' END ;;
    label: "First Contact Resolution"
  }

  dimension: case_office_code {
    group_label: "Office Hierarchy"
    label: "Office Code"
    type: string
    sql: (CASE
      WHEN service_office_hierarchy.office_code is not Null THEN service_office_hierarchy.office_code
      ELSE  user_office_hierarchy.office_code
    END) ;;
    drill_fields: [drillfields*]
  }


  dimension: case_country {
    group_label: "Office Hierarchy"
    label: "Cluster Country"
    type: string
    #map_layer_name: countries
    sql: (case when ${case_country1}='AT' then 'AT & HU'
               when ${case_country1}='CZ' then 'CZ & SK'
               when ${case_country1}='SE' then 'SE & NO'
               when ${case_country1}='CN' then 'NCCN' else ${case_country1} end) ;;
    drill_fields: [drillfields*]
  }

  dimension: case_country1 {
    group_label: "Office Hierarchy"
    label: "Cluster"
    type: string
    #map_layer_name: countries
    sql: (CASE
      WHEN ${service_office_hierarchy.country} is not Null THEN ${service_office_hierarchy.country}
      WHEN ${queue_name_office_hierarchy.country} is not Null THEN ${queue_name_office_hierarchy.country}
      ELSE ${user_office_hierarchy.country}
    END) ;;
    drill_fields: [drillfields*]
  }

  dimension: Regional_Head_Office {
    group_label: "Office Hierarchy"
    label: "Regional_Head_Office"
    type: string
    # First Condition added to map Offshore Offices to Service Office
    sql: coalesce((CASE
               WHEN service_office_hierarchy.Regional_Head_Office is not Null THEN substr(service_office_hierarchy.Regional_Head_Office,-5)
               WHEN queue_name_office_hierarchy.Regional_Head_Office is not Null THEN  substr(queue_name_office_hierarchy.Regional_Head_Office,-5)
               WHEN user_office_hierarchy.Regional_Head_Office is not Null and substr(user_office_hierarchy.office_code,-2) = "OS" THEN substr(service_office_hierarchy.Regional_Head_Office,-5)
               WHEN user_office_hierarchy.Regional_Head_Office is not null THEN substr(user_office_hierarchy.Regional_Head_Office,-5)
    ELSE "Unclaimed"
    END),"Unclaimed") ;;
    drill_fields: [drillfields*]
  }

  dimension: Case_Geo {
    group_label: "Office Hierarchy"
    label: "Case Geography"
    type: string
    sql: CASE
          WHEN {% parameter Geo_Param %} = "RHQ" THEN ${Regional_Head_Office}
          WHEN {% parameter Geo_Param %} = "Cluster Country" THEN ${case_country}
          WHEN {% parameter Geo_Param %} = "Individual Country" THEN ${country}
          WHEN {% parameter Geo_Param %} = "Office" THEN ${office}
          WHEN {% parameter Geo_Param %} = "Channel" THEN ${origin}
          WHEN {% parameter Geo_Param %} = "Segment" THEN ${customer_segment_number}
          WHEN {% parameter Geo_Param %} = "Segment " THEN ${of_customer_group.key_acct_tp_cd}
          WHEN {% parameter Geo_Param %} = "Agent Role" THEN ${case_owner.profile_name_service}
          WHEN {% parameter Geo_Param %} = "Escalation Role" THEN ${of_escalation_history.role}
          WHEN {% parameter Geo_Param %} = "Office Type" THEN ${case_owner.officetype}
          WHEN {% parameter Geo_Param %} = "Service Type" THEN ${type}
          ELSE "Global" END;;
    drill_fields: [drillfields*]
  }

  dimension: case_RHQ {
    group_label: "Chat Office Hierarchy"
    label: "RHQ"
    type: string
    sql: ${Regional_Head_Office} ;;
    #sql: case
    #      when ${Regional_Head_Office}='SAOHQ' THEN 'SAOHQ'
    #      when ${Regional_Head_Office}='HKGHQ' THEN 'HKGHQ'
    #      when ${Regional_Head_Office}='LONHQ' THEN 'LONHQ'
    #      when ${Regional_Head_Office}='RICHQ' THEN 'RICHQ'
    #      when ${Regional_Head_Office}='SINHQ' THEN 'SINHQ'
    #        else "Unclaimed" end;;
    #hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    label: "Count"
  }

  measure: count_transfer {
    type: count
    drill_fields: [transferdetail*]
    label: "Count Transfer"
  }

  measure: count_for_transfer {
    type: count
    drill_fields: [transferdetail*]
    label: "Count For Tranfer"
    html: Total Transfer: {{total_transfer._rendered_value}} <br> {{rendered_value}};;
  }

  measure: case_distinct_count1 {
    type: count_distinct
    sql: ${casenumber}  ;;
    drill_fields: [details1*]
    label: "Distinct Count"
  }

  measure: case_distinct_count_fcr {
    type: count_distinct
    sql: ${casenumber}  ;;
    drill_fields: [detail_fcr*]
    label: "Distinct Count FCR-related"
  }

  measure: case_distinct_count {
    type: count_distinct
    sql: ${casenumber}  ;;
    drill_fields: [detail*]
    label: "Distinct Count"
  }

  measure: case_distinct_count_csat {
    type: count_distinct
    sql: ${casenumber}  ;;
    drill_fields: [detail_csat*]
    label: "Distinct Count CSAT-related"
  }

  measure: case_distinct_count_nps {
    type: count_distinct
    sql: ${casenumber}  ;;
    drill_fields: [detail_csat*]
    label: "Distinct Count NPS-related"
  }

  measure: case_distinct_count_drill {
    type: count_distinct
    sql: ${casenumber}  ;;
    drill_fields: [detail*]
    label: "Distinct Count with drill"

    link: {
      label: "By chat owner name"
      url: "{{ CDC_by_chat_owner_name._link }}"
    }

    link: {
      label: "By RHQ"
      url: "{{ CDC_by_RHQ._link }}"
    }
    link: {
      label: "By Country"
      url: "{{ CDC_by_Country._link }}"
    }
    link: {
      label: "By Status"
      url: "{{ CDC_by_Status._link }}"
    }
    link: {
      label: "By Office"
      url: "{{ CDC_by_Office._link }}"
    }
    link: {
      label: "By Channel"
      url: "{{ CDC_by_Channel._link }}"
    }
    link: {
      label: "By Customer"
      url: "{{ CDC_by_Customer._link }}"
    }
    link: {
      label: "By case_age_group"
      url: "{{ CDC_by_case_age_group._link }}"
    }
    link: {
      label: "By case_owner_name"
      url: "{{ CDC_by_case_owner_name._link }}"
    }
    link: {
      label: "By Priority"
      url: "{{ CDC_by_Priority._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ CDC_by_Customer_Group._link }}"
    }
    link: {
      label: "By L2 Intent"
      url: "{{ CDC_by_L2_Intent._link }}"
    }
    link: {
      label: "By L3 Intent"
      url: "{{ CDC_by_L3_Intent._link }}"
    }
    link: {
      label: "By Open Date Month"
      url: "{{ CDC_by_Open_Date_Month._link }}"
    }
    link: {
      label: "By Initial Queue Name"
      url: "{{ CDC_by_Initial_Queue_Name._link }}"
    }

    link: {
      label: "By Contact Name"
      url: "{{ CDC_by_name._link }}"
    }

    link: {
      label: "By Contact Email"
      url: "{{ CDC_by_contactemail._link }}"
    }

    link: {
      label: "By eComm ID"
      url: "{{ CDC_by_ecomm_id._link }}"
    }
  }

  measure: CDC_by_chat_owner_name  {
    type: count
    drill_fields: [of_user.name, case_distinct_count_drill]
    hidden: yes
  }

  measure: CDC_by_RHQ {
    type: count
    drill_fields: [ Regional_Head_Office,case_distinct_count]
    hidden: yes
  }
  measure: CDC_by_case_age_group {
    type: count
    drill_fields: [ case_age_group,case_distinct_count]
    hidden: yes
  }
  measure: CDC_by_Status {
    type: count
    drill_fields: [ status,case_distinct_count]
    hidden: yes
  }
  measure: CDC_by_case_owner_name {
    type: count
    drill_fields: [ case_owner_name,case_distinct_count]
    hidden: yes
  }
  measure: CDC_by_Priority {
    type: count
    drill_fields: [ priority ,case_distinct_count]
    hidden: yes
  }

  measure: CDC_by_Country {
    type: count
    drill_fields: [ case_country,case_distinct_count]
    hidden: yes
  }

  measure: CDC_by_Office {
    type: count
    drill_fields: [ case_office_code,case_distinct_count]
    hidden: yes
  }

  measure: CDC_by_Channel {
    type: count
    drill_fields: [origin ,case_distinct_count]
    hidden: yes
  }
  measure: CDC_by_Customer_Group{
    type: count
    drill_fields: [ of_customer_group.cust_grp_and_name,case_distinct_count]
    hidden: yes
  }
  measure: CDC_by_Customer {
    type: count
    drill_fields: [ of_customer.customer_cd_and_name,case_distinct_count]
    hidden: yes
  }
  measure: CDC_by_L2_Intent {
    type: count
    drill_fields: [sub_category_l2 ,case_distinct_count]
    hidden: yes
  }
  measure: CDC_by_L3_Intent {
    type: count
    drill_fields: [subordinate_category_l3 ,case_distinct_count]
    hidden: yes
  }
  measure: CDC_by_Open_Date_Month {
    type: count
    drill_fields: [createddate_month ,case_distinct_count]
    hidden: yes
  }

  measure: CDC_by_Initial_Queue_Name {
    type: count
    drill_fields: [Initial_Queue_Name,case_distinct_count]
    hidden: yes
  }

  measure: CDC_by_name  {
    type: count
    drill_fields: [of_contact.name, case_distinct_count]
    hidden: yes
  }

  measure: CDC_by_contactemail  {
    type: count
    drill_fields: [contactemail, case_distinct_count]
    hidden: yes
  }

  measure: CDC_by_ecomm_id {
    type: count
    drill_fields: [ ecomm_id,case_distinct_count]
    hidden: yes
  }

  measure: Avg_First_Response_Time {
    type: average
    sql: ${FIRST_RESPONSE_TIME_CASE} ;;
    drill_fields: [detail*]
    label: "Avg First Response Time"
    value_format_name: decimal_1
  }

  dimension: First_Response_Time_Minutes {
    type: number
    sql: ${TABLE}.First_Response_Time_Minutes ;;
    label: "First Response Time Minutes"
    description: "To Plot the scatter plot outliers (FRT)"
  }

  dimension: Case_First_Response_Time_Minutes {
    type: number
    sql: ${TABLE}.First_Response_Time_Minutes ;;
    label: "Case FRT (mins)"
  }

  measure: AVG_FIRST_RESPONSE_TIME {
    type: average
    sql: ${TABLE}.First_Response_Time_Minutes ;;
    drill_fields: [detail*]
    label: "Average First Response Time"
    value_format_name: decimal_1
    link: {
      label: "By RHQ"
      url: "{{ FRT_by_RHQ._link }}"
    }
    link: {
      label: "By Country"
      url: "{{ FRT_by_Country._link }}"
    }
    link: {
      label: "By Status"
      url: "{{ FRT_by_Status._link }}"
    }
    link: {
      label: "By Office"
      url: "{{ FRT_by_Office._link }}"
    }
    link: {
      label: "By Channel"
      url: "{{ FRT_by_Channel._link }}"
    }
    link: {
      label: "By Customer"
      url: "{{ FRT_by_Customer._link }}"
    }
    link: {
      label: "By case_age_group"
      url: "{{ FRT_by_case_age_group._link }}"
    }
    link: {
      label: "By case_owner_name"
      url: "{{ FRT_by_case_owner_name._link }}"
    }
    link: {
      label: "By Priority"
      url: "{{ FRT_by_Priority._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ FRT_by_Customer_Group._link }}"
    }

    link: {
      label: "By L2 Intent"
      url: "{{ FRT_by_L2_Intent._link }}"
    }
    link: {
      label: "By L3 Intent"
      url: "{{ FRT_by_L3_Intent._link }}"
    }
    link: {
      label: "By Open Date Month"
      url: "{{ FRT_by_Open_Date_Month._link }}"
    }

    link: {
      label: "By Initial Queue Name"
      url: "{{ FRT_by_Initial_Queue_Name._link }}"
    }

    link: {
      label: "By Contact Name"
      url: "{{ FRT_by_name._link }}"
    }

    link: {
      label: "By Contact Email"
      url: "{{ FRT_by_contactemail._link }}"
    }

    link: {
      label: "By eComm ID"
      url: "{{ FRT_by_ecomm_id._link }}"
    }
  }

  measure: FRT_by_RHQ {
    type: count
    drill_fields: [ Regional_Head_Office,AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }
  measure: FRT_by_case_age_group {
    type: count
    drill_fields: [ case_age_group,AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }
  measure: FRT_by_Status {
    type: count
    drill_fields: [ status,AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }
  measure: FRT_by_case_owner_name {
    type: count
    drill_fields: [ case_owner_name,AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }
  measure: FRT_by_Priority {
    type: count
    drill_fields: [ priority,AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }
  measure: FRT_by_Country {
    type: count
    drill_fields: [ case_country,AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }

  measure: FRT_by_Office {
    type: count
    drill_fields: [ case_office_code,AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }

  measure: FRT_by_Channel {
    type: count
    drill_fields: [origin ,AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }
  measure: FRT_by_Customer_Group{
    type: count
    drill_fields: [ of_customer_group.cust_grp_and_name,AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }
  measure: FRT_by_Customer {
    type: count
    drill_fields: [ of_customer.customer_cd_and_name,AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }
  measure: FRT_by_L2_Intent {
    type: count
    drill_fields: [ sub_category_l2,AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }
  measure: FRT_by_L3_Intent {
    type: count
    drill_fields: [ subordinate_category_l3,AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }
  measure: FRT_by_Open_Date_Month {
    type: count
    drill_fields: [createddate_month ,AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }

  measure: FRT_by_Initial_Queue_Name {
    type: count
    drill_fields: [Initial_Queue_Name,AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }

  measure: FRT_by_name  {
    type: count
    drill_fields: [of_contact.name, AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }

  measure: FRT_by_contactemail  {
    type: count
    drill_fields: [contactemail, AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }

  measure: FRT_by_ecomm_id {
    type: count
    drill_fields: [ ecomm_id,AVG_FIRST_RESPONSE_TIME]
    hidden: yes
  }

  measure: AVG_FIRST_CONTACT_RESOLUTION {
    type: average
    sql: CASE
         WHEN ${origin} = 'Chat' and ${TABLE}.is_fcr ='true' THEN 1
         WHEN ${origin} = 'Chat' and ${TABLE}.is_fcr ='false' THEN 0
         WHEN ${total_escalation} =0 and ${transfer_reason} is Null and ${active_case} ='No' THEN 1 ELSE 0 END ;;
    drill_fields: [detail_fcr*]
    label: "First Contact Resolution Ratio"
    value_format_name: percent_0
  }

  measure: NURTURE_RATE {
    type: average
    sql: CASE WHEN ${is_nurtured} ='true' THEN 1 ELSE 0 END  ;;
    drill_fields: [detail*]
    label: "Nurturing Rate"
    value_format_name: percent_0
  }
  measure: is_contract_customer {
    type: average
    label: "Is contract Customer"
    sql: CASE WHEN ${contract_customer_name} is not null THEN 1 ELSE 0 END   ;;
    value_format_name: percent_0
  }

  measure: has_container_number {
    type: sum
    label: "Has Container Number"
    sql: CASE WHEN ${container_number} is not null THEN 1 ELSE 0 END   ;;
    value_format_name: decimal_0
  }

  measure: has_booking_number {
    type: sum
    label: "Has Booking Number"
    sql: CASE WHEN ${booking_number} is not null THEN 1 ELSE 0 END   ;;
    value_format_name: decimal_0
  }


  dimension: Is_Chat_Self_Service {
    type: string
    sql: ${TABLE}.Is_Chat_Self_Service ;;
    label: "Is Chat Self Service"
    group_label: "Additional Information"
  }

  dimension: is_resolved_by_automation {
    label: "Is resolved by automation"
    type: string
    sql: CASE WHEN ${case_owner.name}='Platform Integration User' THEN 'Yes' else 'No' END ;;
  }

  dimension: Automation_Type {
    label: "Automation Type"
    type: string
    drill_fields: [drillfields*]
    sql: CASE
      WHEN ${of_chat_transcript.merged_d_d_used}='true' THEN 'D&D'
      WHEN ${of_chat_transcript.lfd_used}='true' THEN 'LFD'
      WHEN ${TABLE}.Is_Chat_Self_Service = "true" THEN 'Self-Service'
      ELSE 'Others'
      END ;;
  }

  measure: has_contract_number {
    type: sum
    label: "Has Contract Number"
    sql: CASE WHEN ${contract_number} is not null THEN 1 ELSE 0 END   ;;
    value_format_name: decimal_0
  }

  measure: queue_abandonment {
    type: sum
    sql: (CASE WHEN ${of_queue.developer_name} is not Null and ${status} not in ('Resolved','Closed') THEN 1 else 0 END) ;;
    drill_fields: [detail*]
  }

  measure: queue_abandonment_ratio {
    type: average
    sql: (CASE WHEN ${of_queue.developer_name} is not Null and ${status} not in ('Resolved','Closed') THEN 1 else 0 END) ;;
    value_format_name: percent_0
  }

  dimension_group: createddate_temp {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "Created Date - Do Not Use"
    sql: ${TABLE}.CreatedDate ;;
  }

  dimension_group: createddate_filter {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    group_label: "Open Date For Filter"
    label: "Open Date For Filter"
    sql: ${TABLE}.CreatedDate ;;
  }

  dimension: BOT_Cases {
    type: string
    sql: (CASE WHEN ${Automation_Type}="D&D" OR  ${Automation_Type}="LFD" THEN 'Yes' ELSE 'No' END) ;;
    label: "BOT Cases"
    drill_fields: [drillfields*]
  }

  dimension: case_handle_time_minutes {
    label: "Case Handle Time Minutes"
    type: string
    sql:  ${TABLE}.Case_Handle_Time_Minutes ;;
  }

# Below Dimension is created for DCN-966
  dimension: is_aht_calculated_excluded {
    type: string
    description: "Refined AHT Logic for Open and Resolved dates after 1st Jan 2023"
    sql: case when ((${createddate_filter_date}>=date(2023,01,01) and ${is_aht_calculated}="Yes") OR (${resolved_date_date}>=date(2023,01,01) and ${is_aht_calculated}="Yes"))
          OR (${createddate_filter_date}<date(2023,01,01) and (${is_aht_calculated}="No" OR ${is_aht_calculated}="Yes")) then "Yes"
          else "No"
          end ;;
  }

  ### Created for DCN:947
  parameter: Exclude_Awaiting_Internal_in_AHT{
    description: "Used for toggle AHT"
    type: string
    default_value: "No"
    allowed_value: {
      label: "Yes"
      value: "Yes"
    }
    allowed_value: {
      label: "No"
      value: "No"
    }
  }

  measure: average_handling_time_new {
    label: "Average Handling Time temp"
    type: average
    sql: case WHEN {% parameter Exclude_Awaiting_Internal_in_AHT %} = "Yes" and (${createddate_filter_date}<date(2023,01,01) ) THEN ${TABLE}.CASE_HANDLE_TIME_EXCL_INTERNAL_MINS
      WHEN {% parameter Exclude_Awaiting_Internal_in_AHT %} = "No" and (${createddate_filter_date}>=date(2023,01,01) ) THEN ${TABLE}.Case_Handle_Time_Minutes
      else null
      end;;
    value_format_name: decimal_1
    #filters: [is_aht_calculated_excluded: "Yes"]
  }

  measure: case_handling_time {
    label: "Case Handle Time (mins)"
    type: average
    sql:  ${TABLE}.Case_Handle_Time_Minutes ;;
    value_format_name: decimal_1
  }

  measure: avg_handling_time {
    label: "Avg Handle Time (Mins)"
    type: number
    drill_fields: [responsetime_details*]
    sql: CASE
          WHEN {% parameter handletime_Param %} = "Chat Transcript" THEN ${of_chat_transcript.chat_handle_time_avg}
          ELSE  ${average_handling_time_new} END;;
    value_format_name: decimal_1
  }

  dimension: Case_Handle_Time_excl_Internal_mins {
    type: number
    sql: ${TABLE}.CASE_HANDLE_TIME_EXCL_INTERNAL_MINS ;;
  }

  measure: average_handling_time {
    label: "Average Handling Time"
    type: number
    drill_fields: [responsetime_details*]
    sql: CASE
          WHEN {% parameter handletime_Param %} = "Chat Transcript" THEN ${of_chat_transcript.chat_handle_time_avg}
          ELSE  ${average_handling_time_new} END;;
    value_format_name: decimal_1



    link: {
      label: "By RHQ"
      url: "{{ AHT_by_RHQ._link }}"
    }
    link: {
      label: "By Country"
      url: "{{ AHT_by_Country._link }}"
    }
    link: {
      label: "By Status"
      url: "{{ AHT_by_Status._link }}"
    }
    link: {
      label: "By Channel"
      url: "{{ AHT_by_Channel._link }}"
    }
    link: {
      label: "By Customer"
      url: "{{ AHT_by_Customer._link }}"
    }
    link: {
      label: "By Office"
      url: "{{ AHT_by_Office._link }}"
    }
    link: {
      label: "By case_age_group"
      url: "{{ AHT_by_case_age_group._link }}"
    }
    link: {
      label: "By case_owner_name"
      url: "{{ AHT_by_case_owner_name._link }}"
    }
    link: {
      label: "By Priority"
      url: "{{ AHT_by_Priority._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ AHT_by_Customer_Group._link }}"
    }
    link: {
      label: "By L2 Intent"
      url: "{{ AHT_by_L2_Intent._link }}"
    }
    link: {
      label: "By L3 Intent"
      url: "{{ AHT_by_L3_Intent._link }}"
    }
    link: {
      label: "By Open Date Month"
      url: "{{ AHT_by_Open_Date_Month._link }}"
    }
    link: {
      label: "By Initial Queue Name"
      url: "{{ AHT_by_Initial_Queue_Name._link }}"
    }

    link: {
      label: "By Contact Name"
      url: "{{ AHT_by_name._link }}"
    }

    link: {
      label: "By Contact Email"
      url: "{{ AHT_by_contactemail._link }}"
    }

    link: {
      label: "By eComm ID"
      url: "{{ AHT_by_ecomm_id._link }}"
    }
  }

  measure: AHT_by_RHQ {
    type: count
    drill_fields: [ Regional_Head_Office,average_handling_time]
    hidden: yes
  }
  measure: AHT_by_case_age_group {
    type: count
    drill_fields: [ case_age_group,average_handling_time]
    hidden: yes
  }
  measure: AHT_by_Status {
    type: count
    drill_fields: [ status,average_handling_time]
    hidden: yes
  }
  measure: AHT_by_case_owner_name {
    type: count
    drill_fields: [ case_owner_name,average_handling_time]
    hidden: yes
  }
  measure: AHT_by_Priority {
    type: count
    drill_fields: [ priority,average_handling_time]
    hidden: yes
  }
  measure: AHT_by_Country {
    type: count
    drill_fields: [ case_country,average_handling_time]
    hidden: yes
  }

  measure: AHT_by_Office {
    type: count
    drill_fields: [ case_office_code,average_handling_time]
    hidden: yes
  }

  measure: AHT_by_Channel {
    type: count
    drill_fields: [origin ,average_handling_time]
    hidden: yes
  }
  measure: AHT_by_Customer_Group{
    type: count
    drill_fields: [ of_customer_group.cust_grp_and_name,average_handling_time]
    hidden: yes
  }
  measure: AHT_by_Customer {
    type: count
    drill_fields: [ of_customer.customer_cd_and_name,average_handling_time]
    hidden: yes
  }
  measure: AHT_by_L2_Intent {
    type: count
    drill_fields: [sub_category_l2 ,average_handling_time]
    hidden: yes
  }
  measure: AHT_by_L3_Intent {
    type: count
    drill_fields: [subordinate_category_l3 ,average_handling_time]
    hidden: yes
  }
  measure: AHT_by_Open_Date_Month {
    type: count
    drill_fields: [createddate_month ,average_handling_time]
    hidden: yes
  }

  measure: AHT_by_Initial_Queue_Name {
    type: count
    drill_fields: [ Initial_Queue_Name,average_handling_time]
    hidden: yes
  }

  measure: AHT_by_name  {
    type: count
    drill_fields: [of_contact.name, average_handling_time]
    hidden: yes
  }

  measure: AHT_by_contactemail  {
    type: count
    drill_fields: [contactemail, average_handling_time]
    hidden: yes
  }

  measure: AHT_by_ecomm_id {
    type: count
    drill_fields: [ ecomm_id,average_handling_time]
    hidden: yes
  }

  dimension : No_KA_Mapping {
    type: string
    sql: CASE WHEN ${total_escalation} >0 and ${of_escalation_history.role} IS NULL THEN 'Yes' ELSE 'No' END ;;
    label: "No KA Mapping"
  }


  dimension: Initial_Queue_Name {
    type: string
    sql:CASE WHEN ${TABLE}.Origin = "Chat"  THEN ${of_chat_transcript.chat_first_queue_name_detail} else ${TABLE}.Initial_Queue_Name END;;
    label: "Initial Queue Name"
  }

  dimension: Case_Owned_by_System_Filter {
    label: "Case Owned by System Filter"
    type: string
    sql: CASE WHEN ${case_owner.name}= "Platform Integration User" OR ${case_owner.name}= "CRM System User" OR ${case_owner.name}="Automated Process" THEN 'Yes' else 'No' END ;;
  }

  dimension: has_leave_message {
    type: string
    sql: ${TABLE}.Has_Leave_Message ;;
    label: "Has Leave Message"
  }

  dimension: has_leave_message_filter {
    label: "Has Leave Message Filter"
    type: string
    sql: case when ${TABLE}.Has_Leave_Message="true" then "Yes"
          else "No"
          end;;
  }

  measure : L2_mandatory_1 {
    type: sum
    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Booking Management' THEN 1 ELSE 0 END) ;;
    label: "Mandatory L2_1"
    drill_fields: [drillfields*]
  }

  measure : L2_mandatory_2 {
    type: sum
    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Claims' THEN 1 ELSE 0 END) ;;
    label: "Mandatory L2_2"
    drill_fields: [drillfields*]
  }

  measure : L2_mandatory_3 {
    type: sum
    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Disputes' THEN 1 ELSE 0 END) ;;
    label: "Mandatory L2_3"
    drill_fields: [drillfields*]
  }

  measure : L2_mandatory_4 {
    type: sum
    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Export Documentation' THEN 1 ELSE 0 END) ;;
    label: "Mandatory L2_4"
    drill_fields: [drillfields*]
  }

  measure : L2_mandatory_5 {
    type: sum
    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Import Documentation' THEN 1 ELSE 0 END) ;;
    label: "Mandatory L2_5"
    drill_fields: [drillfields*]
  }

  measure : L2_mandatory_6 {
    type: sum
    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Import Management' THEN 1 ELSE 0 END) ;;
    label: "Mandatory L2_6"
    drill_fields: [drillfields*]
  }

  measure : L2_mandatory_7 {
    type: sum
    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Invoice & Charges' THEN 1 ELSE 0 END) ;;
    label: "Mandatory L2_7"
    drill_fields: [drillfields*]
  }

  measure : L2_mandatory_8 {
    type: sum
    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Last Free Day / Demurrage & Detention' THEN 1 ELSE 0 END) ;;
    label: "Mandatory L2_8"
    drill_fields: [drillfields*]
  }

  measure: all_cases {
    type: number
    label: "All Cases"
    sql: COUNT(DISTINCT CASE WHEN (CASE WHEN ${resolution_reason} IS NULL THEN 'None' ELSE ${resolution_reason} END  IN ('Customer Abandoned Chat', 'Customer Query Un-resolved', 'None', 'Customer Query Resolved')) THEN ${casenumber}  ELSE NULL END) ;;
    drill_fields: [drillfields*]
  }

  measure: duplicate_cases {
    type: number
    label: "Duplicate Cases"
    sql: COUNT(DISTINCT CASE WHEN ((CASE WHEN ${resolution_reason} IS NULL THEN 'None' ELSE ${resolution_reason} END) = 'Duplicate') THEN ${casenumber}  ELSE NULL END) ;;
    drill_fields: [drillfields*]
  }

  measure: no_action_required_cases {
    type: number
    label: "No Action Required Cases"
    sql: COUNT(DISTINCT CASE WHEN ((CASE WHEN ${resolution_reason} IS NULL THEN 'None' ELSE ${resolution_reason} END) = 'No Action Required') THEN ${casenumber}  ELSE NULL END) ;;
    drill_fields: [drillfields*]
  }

  parameter: Geo_Param {
    type: string
    allowed_value: {
      label: "Global"
      value: "Global"
    }
    allowed_value: {
      label: "RHQ"
      value: "RHQ"
    }
    allowed_value: {
      label: "Cluster Country"
      value: "Cluster Country"
    }
    allowed_value: {
      label: "Individual Country"
      value: "Individual Country"
    }
    allowed_value: {
      label: "Office"
      value: "Office"
    }
    allowed_value: {
      label: "Channel"
      value: "Channel"
    }
    allowed_value: {
      label: "Segment"
      value: "Segment"
    }
    allowed_value: {
      label: "Segment "
      value: "Segment "
    }
    allowed_value: {
      label: "Agent Role"
      value: "Agent Role"
    }
    allowed_value: {
      label: "Escalation Role"
      value: "Escalation Role"
    }
    allowed_value: {
      label: "Office Type"
      value: "Office Type"
    }
    allowed_value: {
      label: "Service Type"
      value: "Service Type"
    }
  }


  dimension: Reference_data {
    type: string
    sql: CASE
          WHEN ${booking_number} is not null THEN 'Booking'
          WHEN ${contract_number} is not null THEN 'Contract'
          WHEN ${container_number} is not null THEN 'Container'
          ELSE 'No Reference Number' END ;;
    label:"Reference Data"

  }

  dimension: channel_type {
    type: string
    sql: (CASE WHEN ${TABLE}.origin="Chat" or ${TABLE}.origin="Web" THEN "Digital" ELSE "Traditional " END) ;;
    label: "Channel Type"
    group_label: "Case Information"
    drill_fields: [drillfields*]
  }

  measure: deflection_ratio {
    type: average
    sql: (CASE WHEN ${origin} in ('Chat' , 'Web') THEN 1 ELSE 0 END);;
    drill_fields: [detail*]
    label: "Deflection Ratio"
    value_format_name: percent_0


    link: {
      label: "By RHQ"
      url: "{{ deflection_ratio_by_RHQ._link }}"
    }

    link: {
      label: "By Country"
      url: "{{ deflection_ratio_by_Country._link }}"
    }

    link: {
      label: "By Status"
      url: "{{ deflection_ratio_by_Status._link }}"
    }

    link: {
      label: "By Channel"
      url: "{{ deflection_ratio_by_Channel._link }}"
    }

    link: {
      label: "By Customer"
      url: "{{ deflection_ratio_by_Customer._link }}"
    }

    link: {
      label: "By Office"
      url: "{{ deflection_ratio_by_Office._link }}"
    }

    link: {
      label: "By case_age_group"
      url: "{{ deflection_ratio_by_case_age_group._link }}"
    }

    link: {
      label: "By case_owner_name"
      url: "{{ deflection_ratio_by_case_owner_name._link }}"
    }

    link: {
      label: "By Priority"
      url: "{{ deflection_ratio_by_Priority._link }}"
    }

    link: {
      label: "By Customer Group"
      url: "{{ deflection_ratio_by_Customer_Group._link }}"
    }

    link: {
      label: "By L2 Intent"
      url: "{{ deflection_ratio_by_L2_Intent._link }}"
    }

    link: {
      label: "By L3 Intent"
      url: "{{ deflection_ratio_by_L3_Intent._link }}"
    }
    link: {
      label: "By Open Date Month"
      url: "{{ deflection_ratio_by_Open_Date_Month._link }}"
    }
    link: {
      label: "By Initial Queue Name"
      url: "{{ deflection_ratio_by_Initial_Queue_Name._link }}"
    }

    link: {
      label: "By Contact Name"
      url: "{{ deflection_ratio_by_name._link }}"
    }

    link: {
      label: "By Contact Email"
      url: "{{ deflection_ratio_by_contactemail._link }}"
    }

    link: {
      label: "By eComm ID"
      url: "{{ deflection_ratio_by_ecomm_id._link }}"
    }
  }

  measure: deflection_ratio_by_RHQ {
    type: count
    drill_fields: [Regional_Head_Office,deflection_ratio]
    hidden: yes
  }

  measure: deflection_ratio_by_case_age_group {
    type: count
    drill_fields: [case_age_group,deflection_ratio]
    hidden: yes
  }

  measure: deflection_ratio_by_Status {
    type: count
    drill_fields: [status,deflection_ratio]
    hidden: yes
  }

  measure: deflection_ratio_by_case_owner_name {
    type: count
    drill_fields: [case_owner_name,deflection_ratio]
    hidden: yes
  }

  measure: deflection_ratio_by_Priority {
    type: count
    drill_fields: [priority,deflection_ratio]
    hidden: yes
  }

  measure: deflection_ratio_by_Country {
    type: count
    drill_fields: [case_country,deflection_ratio]
    hidden: yes
  }

  measure: deflection_ratio_by_Office {
    type: count
    drill_fields: [case_office_code,deflection_ratio]
    hidden: yes
  }

  measure: deflection_ratio_by_Channel {
    type: count
    drill_fields: [origin,deflection_ratio]
    hidden: yes
  }

  measure: deflection_ratio_by_Customer_Group{
    type: count
    drill_fields: [of_customer_group.cust_grp_and_name,deflection_ratio]
    hidden: yes
  }

  measure: deflection_ratio_by_Customer {
    type: count
    drill_fields: [of_customer.customer_cd_and_name,deflection_ratio]
    hidden: yes
  }

  measure: deflection_ratio_by_L2_Intent {
    type: count
    drill_fields: [sub_category_l2 ,deflection_ratio]
    hidden: yes
  }

  measure: deflection_ratio_by_L3_Intent {
    type: count
    drill_fields: [subordinate_category_l3 ,deflection_ratio]
    hidden: yes
  }
  measure: deflection_ratio_by_Open_Date_Month {
    type: count
    drill_fields: [createddate_month ,deflection_ratio]
    hidden: yes
  }

  measure: deflection_ratio_by_Initial_Queue_Name {
    type: count
    drill_fields: [Initial_Queue_Name,deflection_ratio]
    hidden: yes
  }

  measure: deflection_ratio_by_name  {
    type: count
    drill_fields: [of_contact.name, deflection_ratio]
    hidden: yes
  }

  measure: deflection_ratio_by_contactemail  {
    type: count
    drill_fields: [contactemail, deflection_ratio]
    hidden: yes
  }

  measure: deflection_ratio_by_ecomm_id {
    type: count
    drill_fields: [ ecomm_id,deflection_ratio]
    hidden: yes
  }

  dimension_group: Case_Resolved_Date_Time {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Case_Resolved_Date_Time ;;
    label: "Case Resolved Date Time"
  }

  dimension: createddate_dynamic {
    type: date
    datatype: datetime
    label: "Open Date Dynamic"
    sql:
    CASE
    WHEN {% parameter timeframe_picker %} = 'Day' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${createddate_raw}),'{{_query._query_timezone}}'),DAY)
    WHEN {% parameter timeframe_picker %} = 'Week' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${createddate_raw}),'{{_query._query_timezone}}'), WEEK(MONDAY))
    WHEN {% parameter timeframe_picker %} = 'Month' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${createddate_raw}),'{{_query._query_timezone}}'),MONTH)
    WHEN {% parameter timeframe_picker %} = 'Quarter' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${createddate_raw}),'{{_query._query_timezone}}'),QUARTER)
    WHEN {% parameter timeframe_picker %} = 'Year' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${createddate_raw}),'{{_query._query_timezone}}'),YEAR)
    ELSE NULL
    END ;;
    convert_tz: no
  }

  parameter: timeframe_picker {
    label: "Date Granularity"
    type: string
    allowed_value: { value: "Day" }
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Quarter" }
    allowed_value: { value: "Year" }
    default_value: "Month"

  }

  dimension: isWithInBusinessHour {
    type: string
    sql: CASE WHEN ${TABLE}.isWithInBusinessHour ='true' THEN 'Yes' ELSE 'No' END ;;
    label: "With In Business Hour"
  }

  dimension: is_channel_applicable_for_FRT {
    type: string
    sql: (CASE WHEN ${TABLE}.Origin ="Phone"  THEN "No" ELSE "Yes" END) ;;
    label: : "Is Channel Applicable For FRT"
    group_label: "Case Information"
  }

  measure: detractor_percentage{
    type: average
    sql: Case WHEN ${nps_group}='Detractors' THEN 1 ELSE 0 END ;;
    label:"Detractor Percentage"
    group_label: "Customer Feedback"
    filters: [nps_group: "-No Rating"]
    value_format_name: percent_0
    #hidden: yes
  }

  measure: promoter_percentage{
    type: average
    sql: Case WHEN ${nps_group}='Promoters' THEN 1 ELSE 0 END ;;
    label:"Promoters Percentage"
    group_label: "Customer Feedback"
    filters: [nps_group: "-No Rating"]
    value_format_name: percent_0
    #hidden: yes
  }

  measure: global_nps{
    type: number
    sql: (${promoter_percentage} - ${detractor_percentage}) *100 ;;
    label:"Global NPS"
    group_label: "Customer Feedback"
    value_format_name: decimal_0
    drill_fields: [detail*]

    link: {
      label: "By RHQ"
      url: "{{ global_nps_by_RHQ._link }}"
    }
    link: {
      label: "By Country"
      url: "{{ global_nps_by_Country._link }}"
    }
    link: {
      label: "By Status"
      url: "{{ global_nps_by_Status._link }}"
    }
    link: {
      label: "By Channel"
      url: "{{ global_nps_by_Channel._link }}"
    }
    link: {
      label: "By Customer"
      url: "{{ global_nps_by_Customer._link }}"
    }
    link: {
      label: "By Office"
      url: "{{ global_nps_by_Office._link }}"
    }
    link: {
      label: "By case_age_group"
      url: "{{ global_nps_by_case_age_group._link }}"
    }
    link: {
      label: "By case_owner_name"
      url: "{{ global_nps_by_case_owner_name._link }}"
    }
    link: {
      label: "By Priority"
      url: "{{ global_nps_by_Priority._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ global_nps_by_Customer_Group._link }}"
    }
    link: {
      label: "By L2 Intent"
      url: "{{ global_nps_by_L2_Intent._link }}"
    }
    link: {
      label: "By L3 Intent"
      url: "{{ global_nps_by_L3_Intent._link }}"
    }
    link: {
      label: "By Open Date Month"
      url: "{{ global_nps_by_Open_Date_Month._link }}"
    }

    link: {
      label: "By Initial Queue Name"
      url: "{{ global_nps_by_Initial_Queue_Name._link }}"
    }


    link: {
      label: "By Contact Name"
      url: "{{ global_nps_by_name._link }}"
    }

    link: {
      label: "By Contact Email"
      url: "{{ global_nps_by_contactemail._link }}"
    }

    link: {
      label: "By eComm ID"
      url: "{{ global_nps_by_ecomm_id._link }}"
    }
  }

  measure: global_nps_by_RHQ {
    type: count
    drill_fields: [ Regional_Head_Office,global_nps]
    hidden: yes
  }
  measure: global_nps_by_case_age_group {
    type: count
    drill_fields: [ case_age_group,global_nps]
    hidden: yes
  }
  measure: global_nps_by_Status {
    type: count
    drill_fields: [ status,global_nps]
    hidden: yes
  }
  measure: global_nps_by_case_owner_name {
    type: count
    drill_fields: [ case_owner_name,global_nps]
    hidden: yes
  }
  measure: global_nps_by_Priority {
    type: count
    drill_fields: [ priority,global_nps]
    hidden: yes
  }
  measure: global_nps_by_Country {
    type: count
    drill_fields: [ case_country,global_nps]
    hidden: yes
  }

  measure: global_nps_by_Office {
    type: count
    drill_fields: [ case_office_code,global_nps]
    hidden: yes
  }

  measure: global_nps_by_Channel {
    type: count
    drill_fields: [origin,global_nps]
    hidden: yes
  }
  measure: global_nps_by_Customer_Group{
    type: count
    drill_fields: [ of_customer_group.cust_grp_and_name,global_nps]
    hidden: yes
  }
  measure: global_nps_by_Customer {
    type: count
    drill_fields: [ of_customer.customer_cd_and_name,global_nps]
    hidden: yes
  }
  measure: global_nps_by_L2_Intent {
    type: count
    drill_fields: [sub_category_l2 ,global_nps]
    hidden: yes
  }
  measure: global_nps_by_L3_Intent {
    type: count
    drill_fields: [subordinate_category_l3 ,global_nps]
    hidden: yes
  }
  measure: global_nps_by_Open_Date_Month {
    type: count
    drill_fields: [createddate_month ,global_nps]
    hidden: yes
  }

  measure: global_nps_by_Initial_Queue_Name {
    type: count
    drill_fields: [Initial_Queue_Name,global_nps]
    hidden: yes
  }

  measure: global_nps_by_name  {
    type: count
    drill_fields: [of_contact.name, global_nps]
    hidden: yes
  }

  measure: global_nps_by_contactemail  {
    type: count
    drill_fields: [contactemail, global_nps]
    hidden: yes
  }

  measure: global_nps_by_ecomm_id {
    type: count
    drill_fields: [ ecomm_id, global_nps]
    hidden: yes
  }

  dimension: nps_group {
    type: string
    sql: (CASE
          WHEN ${TABLE}.Case_Net_Promoter_Score <7 THEN 'Detractors'
          WHEN ${TABLE}.Case_Net_Promoter_Score >=7 and ${TABLE}.Case_Net_Promoter_Score <9 THEN 'Passives'
          WHEN ${TABLE}.Case_Net_Promoter_Score >=9 THEN 'Promoters'
          ELSE 'No Rating' END);;
    label:"NPS Segment"
    group_label: "Customer Feedback"

  }

  dimension: Case_Net_Promoter_Score {
    type: string
    sql: ${TABLE}.Case_Net_Promoter_Score ;;
    label: "Case Net Promotor Score"
  }

  dimension: Service_Contract_Customer  {
    type: string
    sql: (CASE
      WHEN ${of_case.accountid} is not null AND ${of_case.contract_customer_name} is not null THEN 'Both'
      WHEN ${of_case.accountid} is not null THEN 'Service Customer'
      WHEN ${of_case.contract_customer_name} is not null THEN 'Contract Customer'
      Else 'None' END);;
    label: "Service or Contract Customer"
  }

  dimension: case_channel_or_geography_dynamic {
    type: string
    label: "Geography Dynamic Backlog History"
    sql: CASE
          WHEN {% parameter Customer_Param %} = "RHQ" THEN ${Regional_Head_Office}
          WHEN {% parameter Customer_Param %} = "Cluster Country" THEN ${case_country}
          WHEN {% parameter Customer_Param %} = "Individual Country" THEN ${country}
          WHEN {% parameter Customer_Param %} = "Office" THEN ${office}
          WHEN {% parameter Customer_Param %} = "Channel" THEN ${origin}
          WHEN {% parameter Customer_Param %} = "Status" THEN ${of_case_history_status_stat.status}
          WHEN {% parameter Customer_Param %} = "Segment" THEN ${of_customer_group.key_acct_tp_cd}
          WHEN {% parameter Customer_Param %} = "Agent Role" THEN ${case_owner.profile_name_service}
          WHEN {% parameter Customer_Param %} = "Escalation Role" THEN ${of_escalation_history.role}
          WHEN {% parameter Customer_Param %} = "Office Type" THEN ${case_owner.officetype}
          WHEN {% parameter Customer_Param %} = "Service Type" THEN ${type}
          ELSE "Global" END;;
    drill_fields: [drillfields*]
  }


  measure: customer_satisfaction_ratio_case_chat {
    type: number
    label: "CSAT Case/Chat"
    sql: case when {% parameter csat_Param %}= "Case Level" then
         ${Customer_satisfaction_ratio}
        when {% parameter csat_Param %}= "Chat Transcript"  then
          ${of_chat_transcript.Customer_chat_satisfaction_ratio}
          else null
          end;;
    value_format_name: percent_0
    drill_fields: [detail_csat*]
  }

  dimension: rating_case_chat {
    type: string
    label: "Rating Case/Chat"
    sql: case when {% parameter csat_Param %}= "Case Level" then
         ${case_rating}
        when {% parameter csat_Param %}= "Chat Transcript"  then
          ${of_chat_transcript.chat_case_rating}
          else null
          end;;
    drill_fields: [drillfields*]
  }

  parameter: csat_Param {
    type: string
    allowed_value: {
      label: "Case Level"
      value: "Case Level"
    }
    allowed_value: {
      label: "Chat Transcript"
      value: "Chat Transcript"
    }
  }

  measure: all_rating{
    type: count_distinct
    sql: Case WHEN ${case_rating}='Good' OR ${case_rating}='Bad'  THEN 1 ELSE 0 END ;;
    label:"All Rating Case"
  }

  measure: good_rating{
    type: count_distinct
    sql: Case WHEN ${case_rating}='Good'  THEN 1 ELSE 0 END ;;
    label:"Good Rating Case"
  }

  measure: difference_rating_case{
    type: number
    sql: (${good_rating}/NULLIF(${all_rating}, 0)) ;;
    label:"Difference Rating Case"
    drill_fields: [detail*]
  }

  measure: csat_case_analysis {
    type: number
    label: "CSAT Case Analysis"
    sql: case when {% parameter csat_Param %}= "Case Level" then
         ${difference_rating_case}
        when {% parameter csat_Param %}= "Chat Transcript"  then
          ${of_chat_transcript.difference_rating_chat}
          else null
          end;;
    value_format_name: percent_0
    drill_fields: [drillfields*]
  }


  dimension: customer_segment_number {
    type: string
    sql: CASE
          WHEN ${of_customer_group.key_acct_tp_cd} ='GKA' THEN '1'
          WHEN ${of_customer_group.key_acct_tp_cd} ='RKA' THEN '2'
          WHEN ${of_customer_group.key_acct_tp_cd} ='LKA' THEN '3'
          ELSE '4' END
          ;;
    label: "customer segment number"
  }

  dimension: customer_segment_number2 {
    type: string
    order_by_field: customer_segment_number
    sql: CASE
          WHEN ${of_customer_group.key_acct_tp_cd} ='GKA' THEN 'GKA'
          WHEN ${of_customer_group.key_acct_tp_cd} ='RKA' THEN 'RKA'
          WHEN ${of_customer_group.key_acct_tp_cd} ='LKA' THEN 'LKA'
          WHEN ${of_customer_group.key_acct_tp_cd} ='ONECare' THEN 'ONECare'
          ELSE '∅' END
          ;;
    label: "customer segment number2"
  }

  parameter: Customer_Param {
    type: string
    label: "Customer Parameter"
    allowed_value: {
      label: "Global"
      value: "Global"
    }
    allowed_value: {
      label: "RHQ"
      value: "RHQ"
    }
    allowed_value: {
      label: "Cluster Country"
      value: "Cluster Country"
    }
    allowed_value: {
      label: "Individual Country"
      value: "Individual Country"
    }
    allowed_value: {
      label: "Office"
      value: "Office"
    }
    allowed_value: {
      label: "Channel"
      value: "Channel"
    }
    allowed_value: {
      label: "Status"
      value: "Status"
    }
    allowed_value: {
      label: "Segment"
      value: "Segment"
    }
    allowed_value: {
      label: "Agent Role"
      value: "Agent Role"
    }
    allowed_value: {
      label: "Escalation Role"
      value: "Escalation Role"
    }
    allowed_value: {
      label: "Office Type"
      value: "Office Type"
    }
    allowed_value: {
      label: "Service Type"
      value: "Service Type"
    }
  }

  dimension: label {
    type: string
    sql: ${TABLE}.Label ;;
    label: "Label"
  }

  measure: Abandoned_ratio {
    type: average
    sql: CASE WHEN ${resolution_reason} = 'Customer Abandoned Chat' THEN 1 ELSE 0 END;;
    drill_fields: [detail*]
    label: "Abandoned Ratio"
    value_format_name: percent_0
  }


  measure: Customer_satisfaction_ratio {
    type: average
    sql: CASE WHEN ${case_rating} = 'Good' THEN 1 ELSE 0 END;;
    drill_fields: [detail*]
    label: "Customer Satisfaction Ratio"
    filters: [case_rating: "-No Rating"]
    value_format_name: percent_0
  }

  measure: Automation_ratio {
    type: average
    sql: (CASE WHEN ${is_resolved_by_automation} = 'Yes' and ${Automation_Type} in ('D&D', 'LFD', 'Self-Service') THEN 1 ELSE 0 END);;
    drill_fields: [detail*]
    label: "Automation Ratio"
    value_format_name: percent_0
  }

  measure: Case_Resolution_ratio {
    type: average
    sql: CASE WHEN ${status} in ('Resolved' , 'Closed')  THEN 1 ELSE 0 END;;
    drill_fields: [detail*]
    label: "Case Resolution Ratio"
    value_format_name: percent_0
  }

  dimension: filter_start{
    type: date
    datatype: datetime
    sql: {% date_start createddate_filter_date %} ;;
  }

  dimension: filter_end{
    type: date
    datatype: datetime
    sql: {% date_end createddate_filter_date %} ;;
  }

  dimension : ct_owner_name {
    type : string
    sql:  CASE WHEN ${ct_queue.developer_name} is not Null then ${ct_queue.developer_name} else ${ct_owner.name} END;;
    label : "Owner Name"
  }

  dimension : ct_owner_name1 {
    type : string
    sql:  CASE WHEN ${ct_queue.developer_name} is not Null then ${ct_queue.developer_name} else ${ct_owner.name} END;;
    label : "Chat Owner Name"
  }

  parameter: handletime_Param {
    type: string
    allowed_value: {
      label: "Case Level"
      value: "Case Level"
    }
    allowed_value: {
      label: "Chat Transcript"
      value: "Chat Transcript"
    }
  }

  parameter: responsetime_Param {
    type: string
    allowed_value: {
      label: "Case Level"
      value: "Case Level"
    }
    allowed_value: {
      label: "Chat Transcript"
      value: "Chat Transcript"
    }
  }

  dimension: Case_Resolved_Date_Time_dynamic {
    type: date
    datatype: datetime
    label: "Resolved Date Dynamic"
    sql:
    CASE
    WHEN {% parameter timeframe_picker %} = 'Day' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${Case_Resolved_Date_Time_raw}),'{{_query._query_timezone}}'),DAY)
    WHEN {% parameter timeframe_picker %} = 'Week' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${Case_Resolved_Date_Time_raw}),'{{_query._query_timezone}}'), WEEK(MONDAY))
    WHEN {% parameter timeframe_picker %} = 'Month' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${Case_Resolved_Date_Time_raw}),'{{_query._query_timezone}}'),MONTH)
    WHEN {% parameter timeframe_picker %} = 'Quarter' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${Case_Resolved_Date_Time_raw}),'{{_query._query_timezone}}'),QUARTER)
    WHEN {% parameter timeframe_picker %} = 'Year' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${Case_Resolved_Date_Time_raw}),'{{_query._query_timezone}}'),YEAR)
    ELSE NULL
    END ;;
    convert_tz: no
  }

  measure: case_escalation_ratio {
    type: average
    sql: CASE WHEN ${total_escalation} >0  THEN 1 ELSE 0 END;;
    label: "Case Escalation Ratio"
    drill_fields: [escdetail*]
    value_format_name: percent_0
  }

  measure: number_of_escalated_cases{
    type: count_distinct
    sql: case when ${total_escalation}>0 then ${casenumber} else null end;;
    drill_fields: [detail*]
    label: "Number of Escalated Cases"
  }

  measure: escalation_ratio {
    type:number
    sql: (${number_of_escalated_cases}/${case_distinct_count}) ;;
    value_format_name: percent_0
    drill_fields: [detail*]
  }

  measure: non_esc {
    type: average
    sql: case when ${total_escalation}=0 then 1 else 0 end ;;
    drill_fields: [detail*]
    value_format_name: percent_0
  }


  measure: global_nps_case_chat {
    type: number
    label: "Global NPS Case/Chat"
    sql: case when {% parameter globalnps_Param %}= "Case Level" then
         ${global_nps}
        when {% parameter globalnps_Param %}= "Chat Transcript"  then
          ${of_chat_transcript.chat_global_nps}
          else null
          end;;
    drill_fields: [detail_csat*]
  }

  dimension: nps_segment_case_chat {
    type: string
    label: "NPS Segment Case/Chat"
    sql: case when {% parameter globalnps_Param %}= "Case Level" then
         ${nps_group}
        when {% parameter globalnps_Param %}= "Chat Transcript"  then
          ${of_chat_transcript.chat_nps_group}
          else null
          end;;
  }

  parameter: globalnps_Param {
    type: string
    allowed_value: {
      label: "Case Level"
      value: "Case Level"
    }
    allowed_value: {
      label: "Chat Transcript"
      value: "Chat Transcript"
    }
  }


  measure: esc_ratio {
    type: number
    sql: 100-${non_esc} ;;
    drill_fields: [detail*]
    value_format_name: percent_0
  }

  dimension: FIRST_RESPONSE_TIME_CASE {
    type: number
    label: "FIRST RESPONSE TIME CASE"
    description: "Identifies First response time for case & chat handle time "
    sql: case when {% parameter responsetime_Param %}= "Case Level" then
         ${TABLE}.First_Response_Time_Minutes
        when {% parameter responsetime_Param %}= "Chat Transcript" and ${of_chat_transcript.Chat_First_Response_Time_Mins} >0 then
          ${of_chat_transcript.Chat_First_Response_Time_Mins}
          else null
          end;;
  }

  measure: AVG_FIRST_RESPONSE_TIME_NEW {
    type: average
    sql: ${FIRST_RESPONSE_TIME_CASE} ;;
    drill_fields: [responsetime_details*]
    label: "Average First Response Time New"
    value_format_name: decimal_1
    sql_distinct_key: ${FRT_sql_distinct_key} ;;

    link: {
      label: "By RHQ"
      url: "{{ FRT_New_by_RHQ._link }}"
    }
    link: {
      label: "By Country"
      url: "{{ FRT_New_by_Country._link }}"
    }
    link: {
      label: "By Status"
      url: "{{ FRT_New_by_Status._link }}"
    }
    link: {
      label: "By Office"
      url: "{{ FRT_New_by_Office._link }}"
    }
    link: {
      label: "By Channel"
      url: "{{ FRT_New_by_Channel._link }}"
    }
    link: {
      label: "By Customer"
      url: "{{ FRT_New_by_Customer._link }}"
    }
    link: {
      label: "By case_age_group"
      url: "{{ FRT_New_by_case_age_group._link }}"
    }
    link: {
      label: "By case_owner_name"
      url: "{{ FRT_New_by_case_owner_name._link }}"
    }
    link: {
      label: "By Priority"
      url: "{{ FRT_New_by_Priority._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ FRT_New_by_Customer_Group._link }}"
    }

    link: {
      label: "By L2 Intent"
      url: "{{ FRT_New_by_L2_Intent._link }}"
    }
    link: {
      label: "By L3 Intent"
      url: "{{ FRT_New_by_L3_Intent._link }}"
    }
    link: {
      label: "By Open Date Month"
      url: "{{ FRT_New_by_Open_Date_Month._link }}"
    }

    link: {
      label: "By Initial Queue Name"
      url: "{{ FRT_New_by_Initial_Queue_Name._link }}"
    }

    link: {
      label: "By Contact Name"
      url: "{{ FRT_New_by_name._link }}"
    }

    link: {
      label: "By Contact Email"
      url: "{{ FRT_New_by_contactemail._link }}"
    }

    link: {
      label: "By eComm ID"
      url: "{{ FRT_New_by_ecomm_id._link }}"
    }
  }

  measure: FRT_New_by_RHQ {
    type: count
    drill_fields: [ Regional_Head_Office,AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }
  measure: FRT_New_by_case_age_group {
    type: count
    drill_fields: [ case_age_group,AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }
  measure: FRT_New_by_Status {
    type: count
    drill_fields: [ status,AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }
  measure: FRT_New_by_case_owner_name {
    type: count
    drill_fields: [ case_owner_name,AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }
  measure: FRT_New_by_Priority {
    type: count
    drill_fields: [ priority,AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }
  measure: FRT_New_by_Country {
    type: count
    drill_fields: [ case_country,AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }

  measure: FRT_New_by_Office {
    type: count
    drill_fields: [ case_office_code,AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }

  measure: FRT_New_by_Channel {
    type: count
    drill_fields: [origin ,AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }
  measure: FRT_New_by_Customer_Group{
    type: count
    drill_fields: [ of_customer_group.cust_grp_and_name,AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }
  measure: FRT_New_by_Customer {
    type: count
    drill_fields: [ of_customer.customer_cd_and_name,AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }
  measure: FRT_New_by_L2_Intent {
    type: count
    drill_fields: [ sub_category_l2,AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }
  measure: FRT_New_by_L3_Intent {
    type: count
    drill_fields: [ subordinate_category_l3,AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }
  measure: FRT_New_by_Open_Date_Month {
    type: count
    drill_fields: [createddate_month ,AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }

  measure: FRT_New_by_Initial_Queue_Name {
    type: count
    drill_fields: [Initial_Queue_Name,AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }

  measure: FRT_New_by_name  {
    type: count
    drill_fields: [of_contact.name, AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }

  measure: FRT_New_by_contactemail  {
    type: count
    drill_fields: [contactemail, AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }

  measure: FRT_New_by_ecomm_id {
    type: count
    drill_fields: [ ecomm_id,AVG_FIRST_RESPONSE_TIME_NEW]
    hidden: yes
  }


  dimension: original_record_type {
    type: string
    sql: ${TABLE}.Original_Record_Type ;;
    label:"Original Record Type"
  }

  dimension: ecomm_id {
    label: "eComm ID"
    type: string
    sql: ${TABLE}.Contact_eComm_User_ID ;;
    drill_fields: [drillfields*]
  }

  dimension: no_of_times_case_reopen{
    label: "No of times case reopen"
    type: number
    sql: ${TABLE}.No_of_Times_Case_Reopen ;;
  }

  dimension: is_reopened {
    label: "Is Reopened"
    type: string
    sql: ${TABLE}.Is_Reopened ;;
  }


  dimension: Case_reopened {
    label: "Case Reopened"
    type: string
    sql: case when ${is_reopened}="true" Then "Yes" Else "No" End;;
  }

  dimension: is_transfer {
    type: string
    label: "Is Transfer"
    sql: ${TABLE}.IsTransfer ;;
  }

  dimension: total_transfer {
    type: number
    label: "Total Transfer"
    sql:  ${TABLE}.Total_Transfer;;
    drill_fields: [transferdetail*]
  }


  dimension:group_total_transfer  {
    type: string
    label: "Group Total Transfer"
    sql:  case when   ${TABLE}.Total_Transfer=0 then 'Total Transfers: 0'
          when   ${TABLE}.Total_Transfer=1 then 'Total Transfers: 01'
          when   ${TABLE}.Total_Transfer=2 then 'Total Transfers: 02'
          when   ${TABLE}.Total_Transfer=3 then 'Total Transfers: 03'
          when   ${TABLE}.Total_Transfer=4 then 'Total Transfers: 04'
          when   ${TABLE}.Total_Transfer=5 then 'Total Transfers: 05'
                     when 6<=  ${TABLE}.Total_Transfer and ${TABLE}.Total_Transfer  <=50 then 'Total Transfers: 06-50'
                     when 51<=  ${TABLE}.Total_Transfer and ${TABLE}.Total_Transfer  <=100 then 'Total Transfers: 51-100'
                    else 'Total Transfers:100 Above' end
                     ;;
  }


  measure: Agent {
    type: number
    label: "Agent"
    sql: COUNT(DISTINCT CASE WHEN ((CASE WHEN (CASE WHEN case_owner.FirstName IS NULL THEN case_owner.LastName WHEN case_owner.LastName IS NULL THEN case_owner.FirstName ELSE  concat(case_owner.FirstName," ",case_owner.LastName) END)='Platform Integration User' THEN 'Yes' else 'No' END) = 'No') THEN ${casenumber}  ELSE NULL END)  ;;
    drill_fields: [drillfields*]
  }

  measure: DD {
    type: number
    label: "D&D"
    sql:  COUNT(DISTINCT CASE WHEN (((CASE WHEN (CASE WHEN case_owner.FirstName IS NULL THEN case_owner.LastName WHEN case_owner.LastName IS NULL THEN case_owner.FirstName ELSE  concat(case_owner.FirstName," ",case_owner.LastName) END)='Platform Integration User' THEN 'Yes' else 'No' END) = 'Yes')) AND (((CASE
      WHEN of_chat_transcript.Merged_D_D_Used='true' THEN 'D&D'
      WHEN of_chat_transcript.LFD_Used='true' THEN 'LFD'
      WHEN ${Is_Chat_Self_Service} = "true" THEN 'Self-Service'
      ELSE 'Others'
      END) = 'D&D')) THEN ${casenumber}  ELSE NULL END) ;;
    drill_fields: [drillfields*]
  }

  measure: LFD {
    type: number
    label: "LFD"
    sql: COUNT(DISTINCT CASE WHEN (((CASE WHEN (CASE WHEN case_owner.FirstName IS NULL THEN case_owner.LastName WHEN case_owner.LastName IS NULL THEN case_owner.FirstName ELSE  concat(case_owner.FirstName," ",case_owner.LastName) END)='Platform Integration User' THEN 'Yes' else 'No' END) = 'Yes')) AND (((CASE
      WHEN of_chat_transcript.Merged_D_D_Used='true' THEN 'D&D'
      WHEN of_chat_transcript.LFD_Used='true' THEN 'LFD'
      WHEN ${Is_Chat_Self_Service} = "true" THEN 'Self-Service'
      ELSE 'Others'
      END) = 'LFD')) THEN ${casenumber}  ELSE NULL END) ;;
    drill_fields: [drillfields*]
  }

  measure: selfservice {
    type: number
    label: "Self-Service"
    sql:  COUNT(DISTINCT CASE WHEN (((CASE WHEN (CASE WHEN case_owner.FirstName IS NULL THEN case_owner.LastName WHEN case_owner.LastName IS NULL THEN case_owner.FirstName ELSE  concat(case_owner.FirstName," ",case_owner.LastName) END)='Platform Integration User' THEN 'Yes' else 'No' END) = 'Yes')) AND (((CASE
      WHEN of_chat_transcript.Merged_D_D_Used='true' THEN 'D&D'
      WHEN of_chat_transcript.LFD_Used='true' THEN 'LFD'
      WHEN ${Is_Chat_Self_Service} = "true" THEN 'Self-Service'
      ELSE 'Others'
      END) = 'Self-Service')) THEN ${casenumber}  ELSE NULL END) ;;
    drill_fields: [drillfields*]

  }

  dimension: intent_key {
    type: string
    label: "Intent Key"
    sql: ${TABLE}.Intent_Key ;;
  }

  dimension : is_aht_calculated {
    type: string
    sql: CASE
          WHEN ${TABLE}.Is_AHT_Calculated = 'true' THEN 'Yes'
          WHEN ${TABLE}.Is_AHT_Calculated = 'false' THEN 'No' ELSE NULL END ;;
    label: "AHT Calculated"
  }

  dimension: no_reference_reason {
    label: "No Reference Reason"
    type: string
    sql: CASE
           WHEN ${TABLE}.No_Reference_Reason = 'Not applicable' THEN 'Not applicable'
           WHEN ${TABLE}.No_Reference_Reason = 'Undetermined from multiple references' THEN 'Undetermined from multiple references'
           WHEN ${TABLE}.No_Reference_Reason = 'Customer unwilling to provide' THEN 'Customer unwilling to provide'
           WHEN ${TABLE}.No_Reference_Reason = 'Not yet available' THEN 'Not yet available'
           ELSE 'None' END ;;
    drill_fields: [drillfields*]

  }


# Below Parameter is to select channel Target selection for Target Values ##


  # parameter: channel_target_selection {

  #   label: "channel Target"
  #   description: "Used for Target channel filtering."
  #   type: string
  #   allowed_value: {
  #     label: "WEB"
  #     value: "WEB"
  #   }
  #   allowed_value: {
  #     label: "CHAT"
  #     value: "CHAT"
  #   }
  #   allowed_value: {
  #     label: "EMAIL"
  #     value: "EMAIL"
  #   }

  #   allowed_value: {
  #     label: "No Target"
  #     value: "No Target"
  #   }
  # }

  # dimension: target_dimension_for_CHAT {
  #   label: "Target Lines for Channel-chat"
  #   type: number
  #   sql: {% if average_handling_time._in_query%}
  #         case when ${of_service_kpi_target.kpi}="Average Handling Time" AND ${of_service_kpi_target.channel}="Chat"  then ${of_service_kpi_target.kpi_value}
  #         end
  #         {% elsif AVG_FIRST_RESPONSE_TIME_NEW._in_query %}
  #         case when ${of_service_kpi_target.kpi}="First Response Time" AND ${of_service_kpi_target.channel}="Chat"  then ${of_service_kpi_target.kpi_value}
  #         end
  #         {% elsif AVG_FIRST_CONTACT_RESOLUTION._in_query %}
  #         case when ${of_service_kpi_target.kpi}="First Contact Resolution" AND ${of_service_kpi_target.channel}="Chat"  then
  #         {% if of_service_kpi_target.units=="%" %}${of_service_kpi_target.kpi_value}/100
  #         {% else %} ${of_service_kpi_target.kpi_value}
  #         {% endif %}
  #         end
  #         {% elsif Abandoned_ratio._in_query %}
  #         case when ${of_service_kpi_target.kpi}="Abandoned Chat Ratio" AND ${of_service_kpi_target.channel}="Chat"  then
  #         {% if of_service_kpi_target.units=="%" %}${of_service_kpi_target.kpi_value}/100
  #         {% else %} ${of_service_kpi_target.kpi_value}
  #         {% endif %}
  #         end
  #         {% elsif case_escalation_ratio._in_query %}
  #         case when ${of_service_kpi_target.kpi}="Case Escalation" AND ${of_service_kpi_target.channel}="Chat"  then
  #         {% if of_service_kpi_target.units=="%" %}${of_service_kpi_target.kpi_value}/100
  #         {% else %} ${of_service_kpi_target.kpi_value}
  #         {% endif %}
  #         end
  #         {% elsif customer_satisfaction_ratio_case_chat._in_query %}
  #         case when ${of_service_kpi_target.kpi}="CSAT" AND ${of_service_kpi_target.channel}="Chat"  then
  #         {% if of_service_kpi_target.units=="%" %}${of_service_kpi_target.kpi_value}/100
  #         {% else %} ${of_service_kpi_target.kpi_value}
  #         {% endif %}
  #         end
  #         {% elsif deflection_ratio._in_query %}
  #         case when ${of_service_kpi_target.kpi}="Chat + Web Form Usage" AND ${of_service_kpi_target.channel}="Chat"  then
  #         {% if of_service_kpi_target.units=="%" %}${of_service_kpi_target.kpi_value}/100
  #         {% else %} ${of_service_kpi_target.kpi_value}
  #         {% endif %}
  #         end
  #         {% endif %};;
  #   hidden: yes
  # }

  # measure: target_measure_for_CHAT {
  #   type: number
  #   sql: sum(${target_dimension_for_CHAT})/count(${target_dimension_for_CHAT});;
  #   hidden: yes
  # }

  # dimension: target_dimension_for_WEB {

  #   label: "Target Lines for Channel-WEB"
  #   type: number
  #   sql: {% if average_handling_time._in_query%}
  #         case when ${of_service_kpi_target.kpi}="Average Handling Time" AND ${of_service_kpi_target.channel}="Web"  then ${of_service_kpi_target.kpi_value}
  #         end
  #         {% elsif AVG_FIRST_RESPONSE_TIME_NEW._in_query %}
  #         case when ${of_service_kpi_target.kpi}="First Response Time" AND ${of_service_kpi_target.channel}="Web"  then
  #         {% if of_service_kpi_target.units=="Hrs" %}${of_service_kpi_target.kpi_value}*60
  #         {% else %} ${of_service_kpi_target.kpi_value}
  #         {% endif %}
  #         end
  #         {% elsif AVG_FIRST_CONTACT_RESOLUTION._in_query %}
  #         case when ${of_service_kpi_target.kpi}="First Contact Resolution" AND ${of_service_kpi_target.channel}="Web"  then
  #         {% if of_service_kpi_target.units=="%" %}${of_service_kpi_target.kpi_value}/100
  #         {% else %} ${of_service_kpi_target.kpi_value}
  #         {% endif %}
  #         end
  #         {% elsif Abandoned_ratio._in_query %}
  #         case when ${of_service_kpi_target.kpi}="Abandoned Chat Ratio" AND ${of_service_kpi_target.channel}="Web"  then
  #         {% if of_service_kpi_target.units=="%" %}${of_service_kpi_target.kpi_value}/100
  #         {% else %} ${of_service_kpi_target.kpi_value}
  #         {% endif %}
  #         end
  #         {% elsif case_escalation_ratio._in_query %}
  #         case when ${of_service_kpi_target.kpi}="Case Escalation" AND ${of_service_kpi_target.channel}="Web"  then
  #         {% if of_service_kpi_target.units=="%" %}${of_service_kpi_target.kpi_value}/100
  #         {% else %} ${of_service_kpi_target.kpi_value}
  #         {% endif %}
  #         end
  #         {% elsif customer_satisfaction_ratio_case_chat._in_query %}
  #         case when ${of_service_kpi_target.kpi}="CSAT" AND ${of_service_kpi_target.channel}="Web"  then
  #         {% if of_service_kpi_target.units=="%" %}${of_service_kpi_target.kpi_value}/100
  #         {% else %} ${of_service_kpi_target.kpi_value}
  #         {% endif %}
  #         end
  #         {% elsif deflection_ratio._in_query %}
  #         case when ${of_service_kpi_target.kpi}="Chat + Web Form Usage" AND ${of_service_kpi_target.channel}="Web"  then
  #         {% if of_service_kpi_target.units=="%" %}${of_service_kpi_target.kpi_value}/100
  #         {% else %} ${of_service_kpi_target.kpi_value}
  #         {% endif %}
  #         end
  #         {% endif %};;
  #   hidden: yes
  # }

  # measure: target_measure_for_WEB {
  #   type: number
  #   sql: sum(${target_dimension_for_WEB})/count(${target_dimension_for_WEB});;
  #   hidden: yes
  # }

  # # Helen
  # measure: target_measure_for_WEB2 {
  #   label: "Web Target"
  #   type: max
  #   sql:  ${target_dimension_for_WEB};;
  #   filters: [origin: "Web"]
  # }
  # measure: target_measure_for_Chat2 {
  #   label: "Chat Target"
  #   type: max
  #   sql:  ${target_dimension_for_CHAT};;
  #   filters: [origin: "Chat"]
  # }

  # # End

  # dimension: target_dimension_for_EMAIL{
  #   label: "Target Lines for Channel- EMail"
  #   type: number
  #   sql: {% if average_handling_time._in_query %}
  #         case when ${of_service_kpi_target.kpi}="Average Handling Time" AND ${of_service_kpi_target.channel}="Email"  then ${of_service_kpi_target.kpi_value}
  #         end
  #         {% elsif AVG_FIRST_RESPONSE_TIME_NEW._in_query %}
  #         case when ${of_service_kpi_target.kpi}="First Response Time" AND ${of_service_kpi_target.channel}="Email"  then ${of_service_kpi_target.kpi_value}
  #         end
  #         {% elsif AVG_FIRST_CONTACT_RESOLUTION._in_query %}
  #         case when ${of_service_kpi_target.kpi}="First Contact Resolution" AND ${of_service_kpi_target.channel}="Email"  then ${of_service_kpi_target.kpi_value}
  #         end
  #         {% elsif Abandoned_ratio._in_query %}
  #         case when ${of_service_kpi_target.kpi}="Abandoned Chat Ratio" AND ${of_service_kpi_target.channel}="Email"  then ${of_service_kpi_target.kpi_value}
  #         end
  #         {% elsif case_escalation_ratio._in_query %}
  #         case when ${of_service_kpi_target.kpi}="Case Escalation" AND ${of_service_kpi_target.channel}="Email"  then ${of_service_kpi_target.kpi_value}
  #         end
  #         {% elsif customer_satisfaction_ratio_case_chat._in_query %}
  #         case when ${of_service_kpi_target.kpi}="CSAT" AND ${of_service_kpi_target.channel}="Email"  then ${of_service_kpi_target.kpi_value}
  #         end
  #         {% elsif deflection_ratio._in_query %}
  #         case when ${of_service_kpi_target.kpi}="Chat + Web Form Usage" AND ${of_service_kpi_target.channel}="Email"  then ${of_service_kpi_target.kpi_value}
  #         end
  #         {% endif %}
  #         ;;
  #   hidden: yes
  # }


  # measure: target_measure_for_EMAIL {
  #   label: "reference line email"
  #   type: number
  #   sql: sum(${target_dimension_for_EMAIL})/count(${target_dimension_for_EMAIL});;
  #   hidden: yes
  # }

  #DCN-973/977: including target line
  dimension: kpi_in_query {
    type: string
    sql: CASE WHEN {% if of_case.AVG_FIRST_RESPONSE_TIME_NEW._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'First Response Time'
                    WHEN {% if of_case.Achieved_FRT_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'First Response Time'
                    WHEN {% if of_case.AVG_FIRST_CONTACT_RESOLUTION._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'First Contact Resolution'
                    WHEN {% if of_case.case_escalation_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'Case Escalation'
                    WHEN {% if of_case.average_handling_time._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'Average Handling Time'
                    WHEN {% if of_case.Achieved_AHT_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'Average Handling Time'
                    WHEN {% if of_case.Abandoned_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'Abandoned Chat Ratio'
                    WHEN {% if of_case.customer_satisfaction_ratio_case_chat._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'CSAT'
                    WHEN {% if of_case.deflection_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'Chat + Web Form Usage'
                    ELSE null END
          ;;
  }

  measure: target_for_chat {
    label: "Chat Target"
    type: max
    sql:
        CASE  WHEN {% if of_case.Achieved_FRT_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 0.9
              WHEN {% if of_case.Achieved_AHT_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 0.9
              WHEN ${is_channel_filter} = true
              THEN (
                    CASE WHEN ${of_service_kpi_target.units} = '%'
                         THEN ${of_service_kpi_target.kpi_value}/100
                    ELSE ${of_service_kpi_target.kpi_value} END
                   )
              ELSE NULL END
        ;;
    filters: [origin: "Chat"]
  }

  measure: target_for_web {
    label: "Web Target"
    type: max
    sql:
        CASE  WHEN {% if of_case.Achieved_FRT_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 0.9
              WHEN {% if of_case.Achieved_AHT_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 0.9
              WHEN ${is_channel_filter} = true
              THEN (
                    CASE
                         WHEN ${of_service_kpi_target.units} = '%'
                          THEN ${of_service_kpi_target.kpi_value}/100
                      ELSE ${of_service_kpi_target.kpi_value} END
                   )
              ELSE NULL END
        ;;
    filters: [origin: "Web"]
  }

  measure: target_for_ChatWeb_Form_Usage {
    label: "Chat+Web Form Usage Target"
    type: max
    sql:

        CASE WHEN ${of_service_kpi_target.units} = '%'
        THEN ${of_service_kpi_target.kpi_value}/100
        ELSE ${of_service_kpi_target.kpi_value} END
        ;;
    filters: [origin: "Chat, Web"]
  }

  dimension: is_channel_filter  {
    type: yesno
    sql: {{ of_case.origin._is_filtered }}  ;;
  }

  ############## DCN-1004 Target-bar-and-Target-Achievement ##########################

  dimension: Average_Chat_Handling_Time {
    label: "Avg Chat Handling Time"
    type: number
    sql: ${TABLE}.Average_Chat_Handle_Time ;;
  }

  dimension: HANDLE_TIME_MINS {
    type: number
    label: "AHT mins (case/chat)"
    description: "Identifies Handle time for case & chat"
    sql: CASE WHEN {% parameter handletime_Param %}= "Case Level"
                THEN CAST(${TABLE}.Case_Handle_Time_Minutes as float64)
              WHEN {% parameter handletime_Param %}= "Chat Transcript"
                THEN CAST(${TABLE}.Average_Chat_Handle_Time as float64)
          ELSE null
          END;;
  }

  measure: Achieved_AHT_ratio {
    label: "Achieved AHT ratio"
    type: average
    sql: CASE WHEN ${HANDLE_TIME_MINS} = 0
                    THEN NULL
              WHEN ${HANDLE_TIME_MINS} <= ${of_service_kpi_target.kpi_value}
                    THEN 1
              WHEN ${HANDLE_TIME_MINS} > ${of_service_kpi_target.kpi_value}
                    THEN 0
                    ELSE NULL
                    END;;
    value_format_name: percent_0
    sql_distinct_key: ${of_case.oneforce_id} ;;
    filters: [origin: "Web,Chat", HANDLE_TIME_MINS: "NOT NULL"]
    drill_fields: [casenumber,Achieved_AHT_ratio]
  }

  dimension: Average_Chat_First_Response_Time_Minutes{
    label: "FRT Chat"
    type: number
    sql:  ${TABLE}.Avg_Chat_First_Response_Time_Minutes ;;
  }

  dimension: FIRST_RESPONSE_TIME_MINS {
    type: number
    label: "FRT mins (case/chat)"
    description: "Identifies First response time for case & chat"
    sql: CASE WHEN {% parameter responsetime_Param %}= "Case Level"
                THEN ${TABLE}.First_Response_Time_Minutes
              WHEN {% parameter responsetime_Param %}= "Chat Transcript"
                THEN ${TABLE}.Avg_Chat_First_Response_Time_Minutes
          ELSE null
          END;;
  }

  measure: Achieved_FRT_ratio {
    label: "Achieved FRT ratio"
    type: average
    sql: CASE WHEN ${FIRST_RESPONSE_TIME_MINS} = 0
                    THEN NULL
              WHEN ${FIRST_RESPONSE_TIME_MINS} <= ${of_service_kpi_target.kpi_value}
                    THEN 1
              WHEN ${FIRST_RESPONSE_TIME_MINS} > ${of_service_kpi_target.kpi_value}
                    THEN 0
                    ELSE null
                    END;;
    value_format_name: percent_0
    sql_distinct_key: ${of_case.oneforce_id} ;;
    filters: [origin: "Web,Chat", FIRST_RESPONSE_TIME_MINS: "NOT NULL"]
    drill_fields: [casenumber,Achieved_FRT_ratio]
  }
############## DCN-1067 Freeze the Chart Format to follow RHQ Selection ##########################
  dimension: Case_Geo_C_W_Usage {
    group_label: "Office Hierarchy"
    label: "Case Geography Chat + WebForm Usage"
    type: string
    sql: CASE
          WHEN {% parameter Geo_Param %} = "RHQ" THEN ${Regional_Head_Office}
          WHEN {% parameter Geo_Param %} = "Cluster Country" THEN ${case_country}
          WHEN {% parameter Geo_Param %} = "Individual Country" THEN ${country}
          WHEN {% parameter Geo_Param %} = "Office" THEN ${office}
          WHEN {% parameter Geo_Param %} = "Channel" THEN ${Regional_Head_Office}
          WHEN {% parameter Geo_Param %} = "Segment" THEN ${customer_segment_number}
          WHEN {% parameter Geo_Param %} = "Segment " THEN ${of_customer_group.key_acct_tp_cd}
          WHEN {% parameter Geo_Param %} = "Agent Role" THEN ${case_owner.profile_name_service}
          WHEN {% parameter Geo_Param %} = "Escalation Role" THEN ${Regional_Head_Office}
          WHEN {% parameter Geo_Param %} = "Office Type" THEN ${Regional_Head_Office}
          WHEN {% parameter Geo_Param %} = "Service Type" THEN ${Regional_Head_Office}
          ELSE "Global" END;;
    drill_fields: [drillfields*]
  }
############## DCN-1038 Change CSAT in CCA Analysis to Include All Channels ##########################
  parameter: Volume_per_Agent_Param {
    type: unquoted
    allowed_value: {
      label: "Case Level"
      value: "CaseLevel"
    }
    allowed_value: {
      label: "Chat Transcript"
      value: "ChatTranscript"
    }
  }
  dimension: Volume_per_Agent_sql_distinct_key {
    type: string
    label: "SQL Distinct Key for AHT"
    sql: case when "{% parameter Volume_per_Agent_Param %}"= "CaseLevel" then
          ${of_case.oneforce_id}
          when "{% parameter Volume_per_Agent_Param %}"= "ChatTranscript"  then
          ${of_case.oneforce_id}||${of_case.origin}||${of_chat_transcript.oneforce_id}
          end;;
  }
  dimension: Case_Chat_Owner {
    label: "{% if Volume_per_Agent_Param._parameter_value == 'ChatTranscript' %} Chat Owner
    {% else %} Case Owner {% endif %}"
    type: string
    sql: CASE WHEN "{% parameter Volume_per_Agent_Param %}"= "CaseLevel"
                THEN ${case_owner.name}
              WHEN "{% parameter Volume_per_Agent_Param %}"= "ChatTranscript"
                THEN ${ct_owner.name}
          ELSE null
          END ;;
  }
  measure: Case_Chat_Volume {
    label: "{% if Volume_per_Agent_Param._parameter_value == 'ChatTranscript' %} Chat Volume
    {% else %} Case Volume {% endif %}"
    type: count_distinct
    sql: CASE WHEN "{% parameter Volume_per_Agent_Param %}"= "CaseLevel"
                THEN ${oneforce_id}
              WHEN "{% parameter Volume_per_Agent_Param %}"= "ChatTranscript"
                THEN ${of_chat_transcript.oneforce_id}
          ELSE null
          END ;;
    value_format_name: decimal_0
    sql_distinct_key: ${Volume_per_Agent_sql_distinct_key} ;;
  }
  measure: Case_Chat_Response_Time{
    label: "{% if Volume_per_Agent_Param._parameter_value == 'ChatTranscript' %} Chat Avg Agent Response Time(in Secs)
    {% else %} Case Avg Response Time(in Mins) {% endif %}"
    type: average
    sql: CASE WHEN "{% parameter Volume_per_Agent_Param %}"= "CaseLevel"
                THEN ${Case_First_Response_Time_Minutes}
              WHEN "{% parameter Volume_per_Agent_Param %}"= "ChatTranscript"
                THEN ${of_chat_transcript.average_response_time_operator}
          ELSE null
          END ;;
    value_format_name: decimal_1
    sql_distinct_key: ${Volume_per_Agent_sql_distinct_key} ;;
  }
  measure: Case_Chat_Handle_Time{
    label: "{% if Volume_per_Agent_Param._parameter_value == 'ChatTranscript' %} Chat Handle Time(in Mins)
    {% else %} Case Handle Time(in Mins) {% endif %}"
    type: average
    sql: CASE WHEN "{% parameter Volume_per_Agent_Param %}"= "CaseLevel"
                THEN ${case_handling_time_new}
              WHEN "{% parameter Volume_per_Agent_Param %}"= "ChatTranscript"
                THEN ${of_chat_transcript.chat_handle_time}
          ELSE null
          END ;;
    value_format_name: decimal_1
    sql_distinct_key: ${Volume_per_Agent_sql_distinct_key} ;;
  }
  measure: Case_Chat_Good_Rating {
    label: "{% if Volume_per_Agent_Param._parameter_value == 'ChatTranscript' %} Chat CSAT Good Rating %
    {% else %} Case CSAT Good Rating % {% endif %}"
    type: average
    sql: CASE WHEN "{% parameter Volume_per_Agent_Param %}"= "CaseLevel"
                THEN
                    (CASE
                      WHEN ${case_rating} = "Good" THEN 1
                      WHEN ${case_rating} = "Bad"  THEN 0
                     ELSE NULL
                     END)
              WHEN "{% parameter Volume_per_Agent_Param %}"= "ChatTranscript"
                THEN
                    (CASE
                      WHEN ${of_chat_transcript.chat_case_rating} = "Good" THEN 1
                      WHEN ${of_chat_transcript.chat_case_rating} = "Bad"  THEN 0
                     ELSE NULL
                     END)
          ELSE null
          END ;;
    value_format_name: percent_0
    sql_distinct_key: ${Volume_per_Agent_sql_distinct_key} ;;
  }

##### DCN-1099: Create 3 charts in Case Analysis tab in Looker Dashboard #####
  parameter: Transferred_chat_case_Param {
    type: string
    allowed_value: {
      label: "User Office"
      value: "User Office"
    }
    allowed_value: {
      label: "User"
      value: "Transfer by"
    }
    allowed_value: {
      label: "Reason"
      value: "Transfer Reason"
    }
  }
  dimension: Transferred_chat_case_Dynamic {
    type: string
    sql: CASE WHEN {% parameter Transferred_chat_case_Param %} = "User Office"
              THEN ${first_case_transfer_history.Transfer_by_office}
              WHEN {% parameter Transferred_chat_case_Param %} = "Transfer by"
              THEN ${first_case_transfer_history.Transfer_by_name}
              WHEN {% parameter Transferred_chat_case_Param %} = "Transfer Reason"
              THEN ${first_case_transfer_history.Transfer_Reason}
              ELSE NULL
              END
              ;;
  }
  measure: Transferred_Case_count_distinct {
    label: "Transferred Case Distinct Count"
    type: count_distinct
    sql: ${oneforce_id};;
    filters: [is_transfer: "true"]
    drill_fields: [detail*]
  }

##### DCN-1093: Create 2 charts 1) On-Hold Cases by Location and 2) On-Hold Cases by Sub-Category #####
  dimension: No_of_Times_Case_On_Hold {
    type: number
    sql: ${TABLE}.No_of_Times_Case_On_Hold ;;
  }
  dimension: On_Hold_Reason {
    type: string
    sql: ${TABLE}.On_Hold_Reason ;;
  }
  dimension_group: On_hold_Start_Date_Time {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.On_hold_Start_Date_Time ;;
    label: "On hold Start Date Time"
  }
  dimension_group: On_hold_End_Date_Time {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.On_hold_End_Date_Time ;;
    label: "On hold End Date Time"
  }
  dimension: On_Hold_Status_Time_Mins {
    type: number
    sql: ${TABLE}.On_Hold_Status_Time_Mins ;;
  }
  dimension: Is_On_Hold {
    type: string
    sql: CASE WHEN ${status} = "Closed" AND ${No_of_Times_Case_On_Hold} > 0  THEN "On-Hold Cases"
              WHEN ${status} = "Closed" AND coalesce(${No_of_Times_Case_On_Hold},0) =  0  THEN "Non On-Hold Cases"
         ELSE NULL END;;
  }
  dimension_group: On_hold_chart_date {
    label: "Date for on-hold chart"
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${Is_On_Hold} = "On-Hold Cases" THEN ${TABLE}.On_hold_Start_Date_Time
              ELSE ${TABLE}.CreatedDate END
              ;;
  }

############## Create Charts : FRT in CCA Analysis tab and AHT in Average Handling Time tab in Looker Dashboard ##########################
  dimension: FRT_chat_tier {
    type: tier
    sql:
       CASE WHEN ${of_chat_transcript.Chat_First_Response_Time_Mins} > 0 then ${of_chat_transcript.Chat_First_Response_Time_Mins} * 60 else null end;;
    tiers: [0.1,30.1,60.1,120.1,180.1,240.1]
    style: relational
  }

  dimension: FRT_web_tier {
    type: tier
    sql:
       CASE WHEN ${origin} = 'Web' then ${TABLE}.First_Response_Time_Minutes else null end;;
    tiers: [0.1,60.1,120.1,180.1,240.1,300.1]
    style: relational
  }

  parameter: FRT_selector {
    allowed_value: {
      label: "Chat"
      value: "Chat"
    }
    allowed_value: {
      label: "Web"
      value: "Web"
    }
  }

  dimension: dynamic_FRT_tier {
    type: string
    sql: CASE WHEN {% parameter FRT_selector %}= "Chat" THEN ${FRT_chat_tier}
              WHEN {% parameter FRT_selector %}= "Web" THEN ${FRT_web_tier}
              ELSE null END
    ;;
    order_by_field: dynamic_FRT_for_order
  }

  dimension: dynamic_FRT_for_order {
    type: number
    hidden: yes
    sql:
    CASE WHEN {% parameter FRT_selector %}= "Chat" THEN
    (CASE
      WHEN ${dynamic_FRT_tier} = ">= 0.1 and < 30.1" THEN 1
      WHEN ${dynamic_FRT_tier} = ">= 30.1 and < 60.1" THEN 2
      WHEN ${dynamic_FRT_tier} = ">= 60.1 and < 120.1" THEN 3
      WHEN ${dynamic_FRT_tier} = ">= 120.1 and < 180.1" THEN 4
      WHEN ${dynamic_FRT_tier} = ">= 180.1 and < 240.1" THEN 5
      WHEN ${dynamic_FRT_tier} = ">= 240.1" THEN 6 ELSE NULL END
    )
        WHEN {% parameter FRT_selector %}= "Web" THEN
    (CASE
      WHEN ${dynamic_FRT_tier} = ">= 0.1 and < 60.1" THEN 1
      WHEN ${dynamic_FRT_tier} = ">= 60.1 and < 120.1" THEN 2
      WHEN ${dynamic_FRT_tier} = ">= 120.1 and < 180.1" THEN 3
      WHEN ${dynamic_FRT_tier} = ">= 180.1 and < 240.1" THEN 4
      WHEN ${dynamic_FRT_tier} = ">= 240.1 and < 300.1" THEN 5
      WHEN ${dynamic_FRT_tier} = ">= 300.1" THEN 6 ELSE NULL END
    ) ELSE null END;;
  }

  measure: FRT_tier_count {
    type: count_distinct
    sql: CASE WHEN {% parameter FRT_selector %}= "Chat" THEN ${of_chat_transcript.oneforce_id}
              WHEN {% parameter FRT_selector %}= "Web" THEN ${oneforce_id}
              ELSE NULL END;;
    drill_fields: [details1*]
    link: {
      label: "By RHQ"
      url: "{{ FRT_count_by_RHQ._link }}"
    }
    link: {
      label: "By Country"
      url: "{{ FRT_count_by_Country._link }}"
    }
    link: {
      label: "By Status"
      url: "{{ FRT_count_by_Status._link }}"
    }
    link: {
      label: "By Office"
      url: "{{ FRT_count_by_Office._link }}"
    }
    link: {
      label: "By Channel"
      url: "{{ FRT_count_by_Channel._link }}"
    }
    link: {
      label: "By Customer"
      url: "{{ FRT_count_by_Customer._link }}"
    }
    link: {
      label: "By case_age_group"
      url: "{{ FRT_count_by_case_age_group._link }}"
    }
    link: {
      label: "By case_owner_name"
      url: "{{ FRT_count_by_case_owner_name._link }}"
    }
    link: {
      label: "By Priority"
      url: "{{ FRT_count_by_Priority._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ FRT_count_by_Customer_Group._link }}"
    }

    link: {
      label: "By L2 Intent"
      url: "{{ FRT_count_by_L2_Intent._link }}"
    }
    link: {
      label: "By L3 Intent"
      url: "{{ FRT_count_by_L3_Intent._link }}"
    }
    link: {
      label: "By Open Date Month"
      url: "{{ FRT_count_by_Open_Date_Month._link }}"
    }

    link: {
      label: "By Initial Queue Name"
      url: "{{ FRT_count_by_Initial_Queue_Name._link }}"
    }

    link: {
      label: "By Contact Name"
      url: "{{ FRT_count_by_name._link }}"
    }

    link: {
      label: "By Contact Email"
      url: "{{ FRT_count_by_contactemail._link }}"
    }

    link: {
      label: "By eComm ID"
      url: "{{ FRT_count_by_ecomm_id._link }}"
    }
  }

  measure: FRT_count_by_RHQ {
    type: count
    drill_fields: [ Regional_Head_Office,FRT_tier_count]
    hidden: yes
  }
  measure: FRT_count_by_case_age_group {
    type: count
    drill_fields: [ case_age_group,FRT_tier_count]
    hidden: yes
  }
  measure: FRT_count_by_Status {
    type: count
    drill_fields: [ status,FRT_tier_count]
    hidden: yes
  }
  measure: FRT_count_by_case_owner_name {
    type: count
    drill_fields: [ case_owner_name,FRT_tier_count]
    hidden: yes
  }
  measure: FRT_count_by_Priority {
    type: count
    drill_fields: [ priority,FRT_tier_count]
    hidden: yes
  }
  measure: FRT_count_by_Country {
    type: count
    drill_fields: [ case_country,FRT_tier_count]
    hidden: yes
  }

  measure: FRT_count_by_Office {
    type: count
    drill_fields: [ case_office_code,FRT_tier_count]
    hidden: yes
  }

  measure: FRT_count_by_Channel {
    type: count
    drill_fields: [origin ,FRT_tier_count]
    hidden: yes
  }
  measure: FRT_count_by_Customer_Group{
    type: count
    drill_fields: [ of_customer_group.cust_grp_and_name,FRT_tier_count]
    hidden: yes
  }
  measure: FRT_count_by_Customer {
    type: count
    drill_fields: [ of_customer.customer_cd_and_name,FRT_tier_count]
    hidden: yes
  }
  measure: FRT_count_by_L2_Intent {
    type: count
    drill_fields: [ sub_category_l2,FRT_tier_count]
    hidden: yes
  }
  measure: FRT_count_by_L3_Intent {
    type: count
    drill_fields: [ subordinate_category_l3,FRT_tier_count]
    hidden: yes
  }
  measure: FRT_count_by_Open_Date_Month {
    type: count
    drill_fields: [createddate_month ,FRT_tier_count]
    hidden: yes
  }

  measure: FRT_count_by_Initial_Queue_Name {
    type: count
    drill_fields: [Initial_Queue_Name,FRT_tier_count]
    hidden: yes
  }

  measure: FRT_count_by_name  {
    type: count
    drill_fields: [of_contact.name, FRT_tier_count]
    hidden: yes
  }

  measure: FRT_count_by_contactemail  {
    type: count
    drill_fields: [contactemail, FRT_tier_count]
    hidden: yes
  }

  measure: FRT_count_by_ecomm_id {
    type: count
    drill_fields: [ ecomm_id,FRT_tier_count]
    hidden: yes
  }

  dimension: AHT_chat_tier {
    type: tier
    sql:
       CASE WHEN ${origin} = 'Chat' then ${case_handle_time_minutes} else null end;;
    tiers: [0.1,8.1,10.1,20.1,30.1]
    style: relational
  }

  dimension: AHT_web_tier {
    type: tier
    sql:
       CASE WHEN ${origin} = 'Web' then ${case_handle_time_minutes} else null end;;
    tiers: [0.1,120.1,180.1,240.1,300.1]
    style: relational
  }

  parameter: AHT_selector {
    allowed_value: {
      label: "Chat"
      value: "Chat"
    }
    allowed_value: {
      label: "Web"
      value: "Web"
    }
  }

  dimension: dynamic_AHT_tier {
    type: string
    sql: CASE WHEN {% parameter AHT_selector %}= "Chat" THEN ${AHT_chat_tier}
          WHEN {% parameter AHT_selector %}= "Web" THEN ${AHT_web_tier}
          ELSE null END
          ;;
    order_by_field: dynamic_AHT_for_order
  }

  dimension: dynamic_AHT_for_order {
    hidden: yes
    type: number
    sql: CASE WHEN ${dynamic_AHT_tier} = ">= 0.1 and < 8.1" or ${dynamic_AHT_tier} = ">= 0.1 and < 120.1" THEN 1
              WHEN ${dynamic_AHT_tier} = ">= 8.1 and < 10.1" or ${dynamic_AHT_tier} = ">= 120.1 and < 180.1" THEN 2
              WHEN ${dynamic_AHT_tier} = ">= 10.1 and < 20.1" or ${dynamic_AHT_tier} = ">= 180.1 and < 240.1" THEN 3
              WHEN ${dynamic_AHT_tier} = ">= 20.1 and < 30.1" or ${dynamic_AHT_tier} = ">= 240.1 and < 300.1" THEN 4
              WHEN ${dynamic_AHT_tier} = ">= 30.1" or ${dynamic_AHT_tier} = ">= 300.1" THEN 5
              ELSE NULL END;;
  }

  measure: AHT_tier_count {
    type: count_distinct
    sql: ${casenumber};;
    drill_fields: [details1*]
    link: {
      label: "By RHQ"
      url: "{{ AHT_count_by_RHQ._link }}"
    }
    link: {
      label: "By Country"
      url: "{{ AHT_count_by_Country._link }}"
    }
    link: {
      label: "By Status"
      url: "{{ AHT_count_by_Status._link }}"
    }
    link: {
      label: "By Office"
      url: "{{ AHT_count_by_Office._link }}"
    }
    link: {
      label: "By Channel"
      url: "{{ AHT_count_by_Channel._link }}"
    }
    link: {
      label: "By Customer"
      url: "{{ AHT_count_by_Customer._link }}"
    }
    link: {
      label: "By case_age_group"
      url: "{{ AHT_count_by_case_age_group._link }}"
    }
    link: {
      label: "By case_owner_name"
      url: "{{ AHT_count_by_case_owner_name._link }}"
    }
    link: {
      label: "By Priority"
      url: "{{ AHT_count_by_Priority._link }}"
    }
    link: {
      label: "By Customer Group"
      url: "{{ AHT_count_by_Customer_Group._link }}"
    }

    link: {
      label: "By L2 Intent"
      url: "{{ AHT_count_by_L2_Intent._link }}"
    }
    link: {
      label: "By L3 Intent"
      url: "{{ AHT_count_by_L3_Intent._link }}"
    }
    link: {
      label: "By Open Date Month"
      url: "{{ AHT_count_by_Open_Date_Month._link }}"
    }

    link: {
      label: "By Initial Queue Name"
      url: "{{ AHT_count_by_Initial_Queue_Name._link }}"
    }

    link: {
      label: "By Contact Name"
      url: "{{ AHT_count_by_name._link }}"
    }

    link: {
      label: "By Contact Email"
      url: "{{ AHT_count_by_contactemail._link }}"
    }

    link: {
      label: "By eComm ID"
      url: "{{ AHT_count_by_ecomm_id._link }}"
    }
  }

  measure: AHT_count_by_RHQ {
    type: count
    drill_fields: [ Regional_Head_Office,AHT_tier_count]
    hidden: yes
  }
  measure: AHT_count_by_case_age_group {
    type: count
    drill_fields: [ case_age_group,AHT_tier_count]
    hidden: yes
  }
  measure: AHT_count_by_Status {
    type: count
    drill_fields: [ status,AHT_tier_count]
    hidden: yes
  }
  measure: AHT_count_by_case_owner_name {
    type: count
    drill_fields: [ case_owner_name,AHT_tier_count]
    hidden: yes
  }
  measure: AHT_count_by_Priority {
    type: count
    drill_fields: [ priority,AHT_tier_count]
    hidden: yes
  }
  measure: AHT_count_by_Country {
    type: count
    drill_fields: [ case_country,AHT_tier_count]
    hidden: yes
  }

  measure: AHT_count_by_Office {
    type: count
    drill_fields: [ case_office_code,AHT_tier_count]
    hidden: yes
  }

  measure: AHT_count_by_Channel {
    type: count
    drill_fields: [origin ,AHT_tier_count]
    hidden: yes
  }
  measure: AHT_count_by_Customer_Group{
    type: count
    drill_fields: [ of_customer_group.cust_grp_and_name,AHT_tier_count]
    hidden: yes
  }
  measure: AHT_count_by_Customer {
    type: count
    drill_fields: [ of_customer.customer_cd_and_name,AHT_tier_count]
    hidden: yes
  }
  measure: AHT_count_by_L2_Intent {
    type: count
    drill_fields: [ sub_category_l2,AHT_tier_count]
    hidden: yes
  }
  measure: AHT_count_by_L3_Intent {
    type: count
    drill_fields: [ subordinate_category_l3,AHT_tier_count]
    hidden: yes
  }
  measure: AHT_count_by_Open_Date_Month {
    type: count
    drill_fields: [createddate_month ,AHT_tier_count]
    hidden: yes
  }

  measure: AHT_count_by_Initial_Queue_Name {
    type: count
    drill_fields: [Initial_Queue_Name,AHT_tier_count]
    hidden: yes
  }

  measure: AHT_count_by_name  {
    type: count
    drill_fields: [of_contact.name, AHT_tier_count]
    hidden: yes
  }

  measure: AHT_count_by_contactemail  {
    type: count
    drill_fields: [contactemail, AHT_tier_count]
    hidden: yes
  }

  measure: AHT_count_by_ecomm_id {
    type: count
    drill_fields: [ ecomm_id,AHT_tier_count]
    hidden: yes
  }

### DDCN-1152-Create-a-chart-in-CCA-Analysis-to-show-AHT-and-Waiting-time-of-On-Hold-Cases

  measure: on_hold_wait_time {
    type: average
    sql: ${On_Hold_Status_Time_Mins} ;;
    filters: [Is_On_Hold: "On-Hold Cases"]
    value_format_name: decimal_1
  }

  measure: non_on_hold_time {
    label: "Non-On Hold Time"
    type: average
    sql: CASE WHEN (${createddate_filter_date}<date(2023,01,01) ) THEN ${Case_Handle_Time_excl_Internal_mins}
              ELSE ${case_handling_time_new}
              END;;
    filters: [Is_On_Hold: "On-Hold Cases"]
    value_format_name: decimal_1
  }

  measure: total_handling_time {
    type: average
    sql: ${On_Hold_Status_Time_Mins} + (CASE WHEN (${createddate_filter_date}<date(2023,01,01) ) THEN ${Case_Handle_Time_excl_Internal_mins} ELSE ${case_handling_time_new} END) ;;
    filters: [Is_On_Hold: "On-Hold Cases"]
    value_format_name: decimal_1
  }

}

view: of_case_history {
  sql_table_name: `ONEFORCE.OF_CASE_HISTORY`
    ;;

  dimension: case_id {
    type: string
    sql: ${TABLE}.CaseId ;;
  }

  dimension: created_by_id {
    type: string
    sql: ${TABLE}.CreatedById ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.CreatedDate ;;
  }

  dimension: data_type {
    type: string
    sql: ${TABLE}.DataType ;;
  }

  dimension_group: edw_upd_dt {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.EDW_UPD_DT ;;
  }

  dimension: field {
    type: string
    sql: ${TABLE}.Field ;;
  }

  dimension: is_deleted {
    type: string
    sql: ${TABLE}.IsDeleted ;;
  }

  dimension: new_value {
    type: string
    sql: ${TABLE}.NewValue ;;
  }

  dimension: old_value {
    type: string
    sql: ${TABLE}.OldValue ;;
  }

  dimension: oneforce_id {
    type: string
    sql: ${TABLE}.ONEForce_Id ;;
  }

  dimension: status_case_Analysis {
    type: string
    sql: (CASE WHEN ${field} is not null  THEN 'Yes' ELSE 'No' END)   ;;
    label: "status Case Analysis Filter"
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: of_case_history_owner {


  derived_table: {
    sql:
      SELECT O.CASEID,O.NEWVALUE AS OWNER,
      O.CREATEDDATE AS STARTDATE,
      DATETIME_ADD((SELECT COALESCE( Min(I.CREATEDDATE),DATETIME('2099-12-31'))
          from  ${of_case_history.SQL_TABLE_NAME}  I
          where I.CASEID=O.CASEID AND I.Field='Owner' and I.DATATYPE='EntityId'
          and I.CREATEDDATE>O.CREATEDDATE )
          ,INTERVAL -1 Second)  AS ENDDATE
      FROM ${of_case_history.SQL_TABLE_NAME}  O
      where O.Field='Owner' and O.DATATYPE='EntityId'
      union all
      --To include First Record
      SELECT CASEID,OWNER,CREATEDDATE,ENDDATE
      FROM(
          SELECT C.ONEFORCE_ID AS CASEID,
          COALESCE(O.OLDVALUE,c.OWNERID) as OWNER,
          C.CREATEDDATE,
          COALESCE( DATETIME_ADD(O.CREATEDDATE,INTERVAL -1 Second),DATETIME('2099-12-31')) AS ENDDATE,
          rank() over(partition by O.caseid order by O.createddate) R
          FROM   ${of_case.SQL_TABLE_NAME} C
          LEFT JOIN  ${of_case_history.SQL_TABLE_NAME} O
          On C.ONEFORCE_ID=O.CASEID AND O.Field='Owner' and O.DATATYPE='EntityId'
      ) x
      where R=1
    ;;
  }

  dimension: case_id {
    hidden: yes
    type: string
    sql: ${TABLE}.CASEID;;
    primary_key: yes
  }

  dimension: owner {
    type: string
    sql: ${TABLE}.OWNER;;
    hidden: yes
  }

  dimension: owner_type {
    label: "Owner Type"
    type: string
    sql: CASE WHEN ${of_case_history_queue_name.developer_name} is NULL THEN 'Individual' ELSE 'Queue' END;;
  }

  dimension: owner_name {
    label: "Owner Name"
    type: string
    sql: CASE WHEN ${of_case_history_queue_name.developer_name}  is NULL THEN ${of_case_history_user_name.name}  ELSE ${of_case_history_queue_name.developer_name} END;;
  }

  dimension_group: start_date {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.STARTDATE;;
    label:"Start Date"
  }

  dimension_group: end_date {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.ENDDATE;;
    label:"End Date"
  }
}

view: of_case_history_status {

  derived_table: {
    sql:
      SELECT O.CASEID,O.NEWVALUE AS STATUS,
      O.CREATEDDATE AS STARTDATE,
      DATETIME_ADD((SELECT COALESCE( Min(I.CREATEDDATE),DATETIME('2099-12-31'))
          from  ${of_case_history.SQL_TABLE_NAME}  I
          where I.CASEID=O.CASEID AND I.Field='Status'
          and I.CREATEDDATE>O.CREATEDDATE )
          ,INTERVAL -1 Second)  AS ENDDATE
      FROM ${of_case_history.SQL_TABLE_NAME}  O
      where O.Field='Status'
      union all
      --To include First Record
      SELECT CASEID,STATUS,CREATEDDATE,ENDDATE
      FROM(
          SELECT C.ONEFORCE_ID AS CASEID,
          COALESCE(O.OLDVALUE,c.STATUS) as STATUS,
          C.CREATEDDATE,
          COALESCE( DATETIME_ADD(O.CREATEDDATE,INTERVAL -1 Second),DATETIME('2099-12-31')) AS ENDDATE,
          rank() over(partition by O.caseid order by O.createddate) R
          FROM   ${of_case.SQL_TABLE_NAME} C
          LEFT JOIN  ${of_case_history.SQL_TABLE_NAME} O
          On C.ONEFORCE_ID=O.CASEID AND O.Field='Status'
      ) x
      where R=1
    ;;
  }

  dimension: case_id {
    hidden: yes
    type: string
    sql: ${TABLE}.CASEID;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.STATUS;;
  }

  dimension_group: start_date {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.STARTDATE;;
    label:"Start Date"
  }

  dimension_group: end_date {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.ENDDATE;;
    label:"End Date"
  }

}

#undo for rls
#view: of_case_pdt {
#  derived_table: {
#    sql:
#    SELECT
#    t1.ONEForce_Id,
#    t1.IsClosed,
#    t1.IsDeleted,
#    t1.LastModifiedDate,
#    t1.Amazon_Connect_Queue,
#    t1.Applicant_Email,
#    t1.Applicant_Name,
#    t1.Applicant_Party,
#    t1.Applicant_Phone_Number,
#    t1.Article_Recommendation_Reason,
#    t1.AssetId,
#    t1.Origin,
#    t1.Bill_of_Lading_Number,
#    t1.BKG_Office,
#    t1.Booking_Number,
#    t1.BusinessHoursId,
#    t1.Bypass_Validation_Rules,
#    t1.nfvoice_Voicemail_Callback_Phone,
#    t1.Cargo_Nature,
#    t1.Case_Age,
#    t1.CaseNumber,
#    t1.Case_Origin,
#    t1.OwnerId,
#    t1.Case_Rating,
#    t1.Reason,
#    t1.RecordTypeId,
#    t1.SourceId,
#    t1.Case_Sub_Reason,
#    t1.IsClosedOnCreate,
#    t1.Commodity,
#    t1.Company_Name,
#    t1.nfvoice_Voicemail_Contact_Attributes,
#    t1.ContactEmail,
#    t1.ContactFax,
#    t1.Contact_Id,
#    t1.ContactMobile,
#    t1.ContactId,
#    t1.ContactPhone,
#    t1.CreatedById,
#    t1.Customer_Code,
#    t1.AccountId,
#    t1.AssignedDate,
#    t1.ClosedDate,
#    t1.CreatedDate,
#    t1.DateTimeResolved,
#    t1.Description,
#    t1.eCommerce_UserID,
#    t1.EntitlementId,
#    t1.SlaExitDate,
#    t1.SlaStartDate,
#    t1.IsEscalated,
#    t1.Escalation_Reason,
#    t1.First_End_Status,
#    t1.First_End_Status_Time,
#    t1.First_Pending_Reason,
#    t1.First_Processor,
#    t1.First_Reply_Time,
#    t1.First_Restart_Time,
#    t1.Forwarder_Name,
#    t1.Fourth_End_Status,
#    t1.Fourth_End_Status_Time,
#    t1.Fourth_Processor,
#    t1.Comments,
#    t1.Internal_Correspondence,
#    t1.Case_Resolved,
#    t1.Is_Chat_Survey_Submitted,
#    t1.First_Time_Use_Chat,
#    t1.Is_Need_Get_Transcript,
#    t1.Language,
#    t1.LastModifiedById,
#    t1.MilestoneStatus,
#    t1.ParentId,
#    t1.PORT,
#    t1.Post_Reconciliation_Completed_with_biz,
#    t1.Priority,
#    t1.ProductId,
#    t1.Requestor_Type,
#    t1.Response_Flag,
#    t1.Response_Received,
#    t1.Revised_Destination,
#    t1.Second_End_Status,
#    t1.Second_End_Status_Time,
#    t1.Second_Pending_Reason,
#    t1.Second_Processor,
#    t1.Second_Reply_Time,
#    t1.Second_Restart_Time,
#    t1.Shipment_Number,
#    t1.Shipper_Name,
#    t1.Status,
#    t1.IsStopped,
#    t1.StopStartDate,
#    t1.Subject,
#    t1.Survey_Comment,
#    t1.Third_End_Status,
#    t1.Third_End_Status_Time,
#    t1.Third_Pending_Reason,
#    t1.Third_Processor,
#    t1.Third_Reply_Time,
#    t1.Third_Restart_Time,
#    t1.Training,
#    t1.Type,
#    t1.UniqueCaseKey,
#    t1.Voice_Call,
#    t1.nfvoice__Voicemail_Callback_Phone,
#    t1.nfvoice__Voicemail_Link,
#    t1.VVD,
#    t1.SuppliedCompany,
#    t1.SuppliedEmail,
#    t1.SuppliedName,
#    t1.SuppliedPhone,
#    t1.Calculated_Awaiting_Cust_Remind_Datetime,
#    t1.Calculated_Close_Date_Time,
#    t1.Calculated_Date_Time_for_ONE_Team,
#    t1.Case_Owner,
#    t1.Case_Owner_Role,
#    t1.Origin_Indicator,
#    t1.Claim_Amount,
#    t1.Container_Number,
#    t1.Contract_Customer_Name,
#    t1.Contract_Number,
#    t1.Customer_Info,
#    t1.Customer_Segment,
#    t1.Date_Time_Waiting_on_Customer_Response,
#    t1.Escalation_History,
#    t1.Escalated_By,
#    t1.Escalated_To,
#    t1.Escalation_Open_Date,
#    t1.Escalation_History_Reason,
#    t1.Escalation_Type,
#    t1.SuppliedFirstName,
#    t1.Is_Nurtured,
#    t1.SuppliedLastName,
#    t1.Office,
#    t1.Other_Reason,
#    t1.Other_Resolution_Reason,
#    t1.P_I_Claim_Number,
#    t1.Priority_Formula,
#    t1.Privacy_Policy_Consent,
#    t1.Reference_Number,
#    t1.Reference_Number_Type,
#    t1.Reference_Type,
#    t1.Resolution_Reason,
#    t1.Country,
#    t1.Sub_Category_L2,
#    t1.Subordinate_Category_L3,
#    t1.Subordinate_Category_L4,
#    t1.Support_Email_CC,
#    t1.Support_Email_TO,
#    t1.Total_Escalation,
#    t1.Transfer_Reason,
#    t1.Transfer_Reason_Others,
#    t1.Initial_Queue_Name,
#    t1.First_Response_Date_Time,
#    t1.First_Response_Time_Minutes,
#    t1.Case_Handle_Time_Minutes,
#    t1.Has_Leave_Message,
#    t1.Is_Chat_Self_Service,
#    t1.Sub_Resolution_Reason,
#    t1.Is_FCR,
#    t1.Case_Resolved_Date_Time,
#    t1.isWithInBusinessHour,
#    t1.Case_Net_Promoter_Score,
#    t1.Label,
#    t1.Is_Reopened,
#    t1.No_of_Times_Case_Reopen,
#    t1.Original_Record_Type,
#    t1.Contact_eComm_User_ID,
#    t1.Total_Transfer,
#    t1.IsTransfer,
#    t1.Customer_Abandoned_Chat,
#    t1.Intent_Key,
#    t1.Intent_Key_Without_Office_Code,
#    t1.Avg_Chat_First_Response_Time_Minutes,
#    t1.Awaiting_Customer_Response_Time_Mins,
#    t1.Is_AHT_Calculated,
#    t1.Average_Chat_Handle_Time,
#    t1.No_Reference_Reason,
#    t1.Is_Booking_Contract_No_Required,
#    t1.Case_Handle_Time_excl_Internal_Mins,
#    t2.Abandoned,
#    t2.AccountId as ct_AccountID,
#    t2.Additional_Requests,
#    t2.Agent_Accepted_First_Transfer,
#    t2.Agent_Chatting_Time_sec,
#    t2.AverageResponseTimeOperator,
#    t2.AverageResponseTimeVisitor,
#    t2.Body,
#    t2.Bot_Chatting_Time_sec,
#    t2.Bot_Initiated_Transfer,
#    t2.Bot_Transfer_Abandoned,
#    t2.Browser,
#    t2.BrowserLanguage,
#    t2.Calculated_Wait_Time_sec,
#    t2.Case_Number as ct_Case_Number,
#    t2.Case_Rating as ct_Case_Rating,
#    t2.CaseId,
#    t2.Chat_First_Queue_Name,
#    t2.Chat_First_Queue_Name_Detail,
#    t2.Chat_Log_Additional_Recipient,
#    t2.Chat_Log_Recipient,
#    t2.Chat_Preferred_Language,
#    t2.ChatDuration,
#    t2.ChatKey,
#    t2.CMS_SSO_Status,
#    t2.Company_Name as ct_Company_Name,
#    t2.Contact_Email,
#    t2.Contact_Name,
#    t2.ContactId as ct_ContactId,
#    t2.Corporate_Office,
#    t2.Country as ct_Country,
#    t2.CreatedById as ct_CreatedById,
#    t2.CreatedDate as ct_CreatedDate,
#    t2.Disable_One_Quote,
#    t2.eCommerce_UserID as ct_eCommerce_UserID,
#    t2.Email,
#    t2.EndedBy,
#    t2.EndTime,
#    t2.First_Name,
#    t2.First_Queue_Name,
#    t2.First_Resolved,
#    t2.HasLeaveMessage,
#    t2.intent,
#    t2.Intent_L1,
#    t2.Intent_L2,
#    t2.Intent_L3,
#    t2.Intent_L4,
#    t2.IpAddress,
#    t2.Is_Case_Closed,
#    t2.Is_Mobile,
#    t2.Is_Need_Get_Transcript as ct_Is_Need_Get_Transcript,
#    t2.Is_Nurtured as ct_Is_Nurtured,
#    t2.Is_Queue,
#    t2.IsChatbotSession,
#    t2.IsDeleted as ct_IsDeleted,
#    t2.Janrain_UUID,
#    t2.Language as ct_Language,
#    t2.Last_Name,
#    t2.LastModifiedById as ct_LastModifiedById,
#    t2.LastModifiedDate as ct_LastModifiedDate,
#    t2.LastReferencedDate,
#    t2.LastViewedDate,
#    t2.LeadId,
#    t2.LFD_Used,
#    t2.LiveChatButtonId,
#    t2.LiveChatDeploymentId,
#    t2.LiveChatVisitorId,
#    t2.Location,
#    t2.MaxResponseTimeOperator,
#    t2.MaxResponseTimeVisitor,
#    t2.Merged_D_D_Transferred,
#    t2.Merged_D_D_Used,
#    t2.Name,
#    t2.Office as ct_Office,
#    t2.OperatorMessageCount,
#    t2.Origin as ct_Origin,
#    t2.OwnerId as ct_OwnerId,
#    t2.Platform,
#    t2.Queue_Wait_Time,
#    t2.Reference_Number as ct_Reference_Number,
#    t2.Reference_Number_Type as ct_Reference_Number_Type,
#    t2.ReferrerUri,
#    t2.RequestTime,
#    t2.ScreenResolution,
#    t2.Shipment_Number as ct_Shipment_Number,
#    t2.SkillId,
#    t2.StartTime,
#    t2.Status as ct_Status,
#    t2.SupervisorTranscriptBody,
#    t2.SystemModstamp,
#    t2.Transferred_Queues,
#    t2.TransferType,
#    t2.UserAgent,
#    t2.VisitorMessageCount,
#    t2.VisitorNetwork,
#    t2.WaitTime,
#    t2.ONEForce_ID as ct_ONEForce_ID,
#    t2.IsDummy,
#    t2.Case_Net_Promoter_Score as ct_Case_Net_Promoter_Score,
#    t2.Chat_Handle_Time,
#    t2.Customer_Abandoned_Chat as ct_Customer_Abandoned_Chat,
#    t2.Chat_First_Response_Date_Time,
#    t2.Chat_First_Response_Time_Mins,
#    t2.Is_Within_BusinessHour_Chat,
#    t2.Is_Chat_First_Transfer,
#    t2.Is_Chat_transferred,
#    t2.Total_Chat_Transfer,
#    t2.Agent_First_Accept_Date_Time,
#    t2.Chat_Case_Rating,
#    t2.Chat_Case_Net_Promoter_Score,
#    t2.Is_Chat_Survey_Submitted as ct_Is_Chat_Survey_Submitted
#    FROM `OF_CASE` t1
#    LEFT JOIN `OF_CHAT_TRANSCRIPT` t2
#    ON t1.ONEForce_ID = t2.Caseid
#    WHERE
#    t1.Origin in ('Chat','Phone','Email','Web','Manual')
#    and t1.Status not in ('Waiting on Customer Response','Waiting on Internal ONE Team','Merged')
#    and t1.Office is not null
#    and t1.CreatedDate >= DATE('2022-03-28')
#    and coalesce(case_handle_time_minutes,0) >= 0
#    ;;
#
#    persist_for: "2 hours"
#  }
#
#  dimension: casenumber {
#    type: string
#    sql: ${TABLE}.CaseNumber ;;
#    #label:"{{ _view._name }}"
#    label: "{% if  _view._name  == 'parent_case' %} Parent Case Number {% else %} Case Number {% endif %}"
#  }
#
#  dimension: parentid {
#    type: string
#    sql: ${TABLE}.ParentId ;;
#    label: "Parent Case"
#    group_label: "Subject & Description"
#    hidden: yes
#  }
#
#  dimension: subject {
#    type: string
#    sql: ${TABLE}.Subject ;;
#    label: : "Subject"
#    group_label: "Subject & Description"
#  }
#
#  dimension: description {
#    type: string
#    sql: ${TABLE}.Description ;;
#    label: "Description"
#    group_label: "Subject & Description"
#  }
#
#
#  dimension: contactemail {
#    type: string
#    sql: ${TABLE}.ContactEmail ;;
#    label: "Contact Email"
#  }
#
#  dimension: contract_customer_name {
#    type: string
#    sql: ${TABLE}.Contract_Customer_Name ;;
#    label: "Contract Customer Name"
#    group_label: "Customer Information"
#    hidden: no
#  }
#
#
#  dimension: accountid {
#    type: string
#    sql: ${TABLE}.AccountId ;;
#    label: "Customer Name"
#    group_label: "Customer Information"
#    hidden: yes
#  }
#
#  dimension: contactid {
#    type: string
#    sql: ${TABLE}.ContactId ;;
#    label: "Contact Name"
#    group_label: "Customer Information"
#  }
#
#  dimension: customer_segment {
#    type: string
#    sql: ${TABLE}.Customer_Segment ;;
#    label: "Customer Segment"
#    group_label: "Customer Information"
#    hidden: yes
#  }
#
#  dimension: Reference_Type {
#    type: string
#    sql: ${TABLE}.Reference_Type ;;
#    label: "Reference Type"
#    group_label: "Additional Information"
#  }
#
#  dimension: p_i_claim_number {
#    type: string
#    sql: ${TABLE}.P_I_Claim_Number ;;
#    label: "P & I Claim Number"
#    group_label: "Additional Information"
#  }
#
#  dimension: container_number {
#    type: string
#    sql: ${TABLE}.Container_Number ;;
#    label: "Container Number"
#    group_label: "Additional Information"
#  }
#
#  dimension: booking_number {
#    type: string
#    sql: ${TABLE}.Booking_Number ;;
#    label: "Booking Number"
#    group_label: "Additional Information"
#  }
#
#  dimension: is_valid_booking_number {
#    type: string
#    sql: CASE WHEN LENGTH(${TABLE}.Booking_Number)=12 AND UPPER(${TABLE}.Booking_Number)=${TABLE}.Booking_Number THEN 'Yes' ELSE 'No' END  ;;
#    label: "Is Valid Booking Number"
#    group_label: "Additional Information"
#  }
#
#
#  dimension: contract_number {
#    type: string
#    sql: ${TABLE}.Contract_Number ;;
#    label: "Contract Number"
#    group_label: "Additional Information"
#
#  }
#
#  dimension: is_valid_contract_number {
#    type: string
#    sql: CASE WHEN ${TABLE}.Contract_Number IS NOT NULL AND ${TABLE}.Contract_Customer_Name IS NULL THEN 'No' ELSE 'Yes' END ;;
#    label: "Is Valid Contract Number"
#    group_label: "Additional Information"
#
#  }
#
#  dimension: has_contract_customer_name {
#    type: string
#    sql: CASE WHEN ${TABLE}.Contract_Customer_Name IS NOT NULL THEN 'Yes' ELSE 'No' END ;;
#    label: "Has Contract Customer Name"
#    group_label: "Additional Information"
#  }
#
#
#  dimension: support_email_cc {
#    type: string
#    sql: ${TABLE}.Support_Email_CC ;;
#    label: "Support Email CC"
#    group_label: "Additional Information"
#  }
#
#  dimension: support_email_to {
#    type: string
#    sql: ${TABLE}.Support_Email_TO ;;
#    label: "Support Email TO"
#    group_label: "Additional Information"
#  }
#
#  dimension: claim_amount {
#    type: number
#    sql: ${TABLE}.Claim_Amount ;;
#    label: "Claim Amount"
#    group_label: "Additional Information"
#  }
#
#
#  dimension: origin {
#    type: string
#    sql: ${TABLE}.Origin ;;
#    label: : "Channel"
#    group_label: "Case Information"
#    drill_fields: [drillfields*]
#  }
#
#  dimension: is_online_channel {
#    type: string
#    sql: (CASE WHEN ${TABLE}.Origin ="Chat" or ${TABLE}.Origin ="Phone"  THEN "Yes" ELSE "No" END) ;;
#    label: : "Is Online Channel"
#    group_label: "Case Information"
#  }
#
#
#  dimension: type {
#    type: string
#    sql: ${TABLE}.Type ;;
#    label: : "Type"
#    group_label: "Case Information"
#  }
#
#
#  dimension: status {
#    type: string
#    sql: ${TABLE}.Status ;;
#    label: "Status"
#    group_label: "Case Information"
#    drill_fields: [drillfields*]
#  }
#
#  dimension: priority {
#    type: string
#    sql: ${TABLE}.Priority ;;
#    label: : "Priority"
#  }
#
#
#  dimension: country {
#    type: string
#    label: "Individual Country"
#    group_label: "Case Information"
#    sql: case when ${country2}='HK' then 'HK & SCN' else ${country2} end ;;
#  }
#
#  dimension: country2 {
#    type: string
#    group_label: "Case Information"
#    sql: ${TABLE}.Country ;;
#  }
#
#  dimension: office {
#    type: string
#    sql: ${TABLE}.Office ;;
#    label: : "Service Office"
#    group_label: "Case Information"
#  }
#
#  dimension: case_resolved {
#    type: string
#    sql: ${TABLE}.Case_Resolved ;;
#    label: : "Is Case Resolved"
#    group_label: "Resolution Information"
#  }
#
#  dimension: transfer_reason {
#    type: string
#    sql: ${TABLE}.Transfer_Reason ;;
#    label: : "Transfer Reason"
#    group_label: "Resolution Information"
#  }
#
#  dimension: transfer_ratio {
#    type: string
#    sql: case
#          when ${TABLE}.Transfer_Reason is null and ${createddate_filter_year}<2023 then 'No'
#          when ${is_transfer}='true' and ${createddate_filter_year}>2022 then 'Yes'
#          when ${is_transfer}='false' and ${createddate_filter_year}>2022 then 'No'
#       else 'Yes' end ;;
#    label: : "Transfer Ratio"
#    group_label: "Resolution Information"
#  }
#
#  dimension: transfer_reason_others {
#    type: string
#    sql: ${TABLE}.Transfer_Reason_Others ;;
#    label: : "Transfer Reason Others"
#    group_label: "Resolution Information"
#  }
#
#  dimension: resolution_reason {
#    type: string
#    sql: CASE WHEN ${TABLE}.Resolution_Reason IS NULL THEN 'None' ELSE ${TABLE}.Resolution_Reason END ;;
#    label: : "Resolution Reason "
#    group_label: "Resolution Information"
#    drill_fields: [drillfields*]
#  }
#
#  dimension: sub_resolution_reason {
#    type: string
#    sql: ${TABLE}.Sub_Resolution_Reason ;;
#    label: : "Sub Resolution Reason"
#    group_label: "Resolution Information"
#    drill_fields: [drillfields*]
#  }
#
#  dimension: other_resolution_reason {
#    type: string
#    sql: ${TABLE}.Other_Resolution_Reason ;;
#    label: : "Other Resolution Reason "
#    group_label: "Resolution Information"
#  }
#
#  dimension: survey_comment {
#    type: string
#    sql: ${TABLE}.Survey_Comment ;;
#    label: : "Survey Comment"
#    group_label: "Customer Feedback"
#  }
#
#
#  dimension: case_rating {
#    type: string
#    sql: CASE WHEN ${TABLE}.Case_Rating IS NULL THEN 'No Rating' ELSE ${TABLE}.Case_Rating END ;;
#    label: : "Case Rating"
#    group_label: "Customer Feedback"
#  }
#
#
#  dimension: is_need_get_transcript {
#    type: string
#    sql: ${TABLE}.Is_Need_Get_Transcript ;;
#    label: : "Is Need Get Transcript"
#    group_label: "Customer Feedback"
#  }
#
#  dimension: first_time_use_chat {
#    type: string
#    sql: ${TABLE}.First_Time_Use_Chat ;;
#    label: : "First_Time_Use_Chat"
#    group_label: "Customer Feedback"
#  }
#
#  dimension: reason {
#    type: string
#    sql: ${TABLE}.Reason ;;
#    label: "Category (L1)"
#    group_label: "Intent"
#    drill_fields: [drillfields*]
#  }
#
#  dimension: case_sub_reason {
#    type: string
#    sql: ${TABLE}.Case_Sub_Reason ;;
#    label: "Case Sub Reason"
#    group_label: "Case Details"
#  }
#
#  dimension: total_escalation {
#    type: number
#    sql: CAST(${TABLE}.Total_Escalation AS NUMERIC) ;;
#    label:"Total Escalation"
#    view_label:"Current Escalation Details"
#  }
#
#  dimension: escalated_by {
#    type: string
#    sql: ${TABLE}.Escalated_By ;;
#    label:"Escalated By"
#    group_label:"Current Escalation Details"
#    hidden: yes
#  }
#
#  dimension: escalated_to {
#    type: string
#    sql: ${TABLE}.Escalated_To ;;
#    label:"Escalated To"
#    group_label:"Current Escalation Details"
#    hidden: yes
#  }
#
#
#  dimension_group: escalation_open_date {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Escalation_Open_Date;;
#    label:"Escalated Open Date"
#    group_label:"Current Escalation Details"
#    hidden: yes
#  }
#
#  dimension: escalation_reason {
#    type: string
#    sql: ${TABLE}.Escalation_Reason ;;
#    label:"Escalated Reason"
#    group_label:"Current Escalation Details"
#    hidden: yes
#  }
#
#
#  dimension: escalation_type {
#    type: string
#    sql: ${TABLE}.Escalation_Type ;;
#    label:"Escalated Type"
#    group_label:"Current Escalation Details"
#    hidden: yes
#  }
#
#  dimension: case_age {
#    type: number
#    sql: ${TABLE}.Case_Age ;;
#    label:"Case Age"
#    group_label: "System Information"
#  }
#  dimension: case_age_group {
#
#    type: number
#    sql: CASE
#      WHEN ${TABLE}.Case_Age <=2 THEN "1-2 Days"
#      WHEN ${TABLE}.Case_Age >2 and ${TABLE}.Case_Age <=5 THEN "3-5 Days"
#      WHEN ${TABLE}.Case_Age >5 and ${TABLE}.Case_Age <=10 THEN "6-10 Days"
#      WHEN ${TABLE}.Case_Age >10 and ${TABLE}.Case_Age <=20 THEN "11-20 Days"
#      ELSE "More than 20 Days"
#      END;;
#    label:"Case Age Group"
#    group_label: "System Information"
#  }
#
#  dimension: is_nurtured {
#    type: string
#    sql: ${TABLE}.Is_Nurtured ;;
#    label: "Is Nurtured"
#    group_label: "System Information"
#  }
#
#  dimension: FRT_sql_distinct_key {
#    type: string
#    label: "SQL Distinct Key"
#    sql: case when {% parameter responsetime_Param %}= "Case Level" then
#           ${oneforce_id}
#          when {% parameter responsetime_Param %}= "Chat Transcript"  then
#           ${oneforce_id}||${origin}|| coalesce(${ct_ONEForce_ID}, '')
#          end;;
#  }
#
#  dimension: case_owner {
#    type: string
#    sql: ${TABLE}.Case_Owner ;;
#    label: "Case Owner"
#    group_label:"System Information"
#    hidden: yes
#  }
#
#  dimension: case_owner_role {
#    type: string
#    sql: ${TABLE}.Case_Owner_Role ;;
#    label: "Case Owner Role"
#    group_label: "System Information"
#  }
#
#  dimension: created_by_id {
#    type: string
#    sql: ${TABLE}.CreatedById ;;
#    label: "Created By Id"
#    group_label: "System Information"
#    hidden: yes
#  }
#
#
#  dimension_group: last_modified {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.LastModifiedDate ;;
#    label: "Last Modified Date"
#    view_label: "System Information"
#  }
#
#  dimension_group: closeddate {
#    type: time
#    datatype: datetime
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      fiscal_quarter,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.ClosedDate ;;
#    group_label:"Close Date"
#    label: "Close Date"
#  }
#
#  dimension_group: first_response_time {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.First_Response_Time ;;
#    group_label: "First Response Time"
#    label: "First Response Time"
#    hidden: yes
#  }
#
#  dimension_group: first_response_date_time {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.First_Response_Date_Time ;;
#    group_label: "First Response Date Time"
#    label: "First Response Date Time"
#  }
#
#  dimension_group: createddate {
#    type: time
#    datatype: datetime
#    timeframes: [
#      raw,
#      time,
#      hour_of_day,
#      date,
#      week,
#      month,
#      fiscal_quarter,
#      quarter,
#      year
#    ]
#    group_label: "Open Date"
#    label: "Open Date"
#    sql: ${TABLE}.CreatedDate ;;
#    drill_fields: [drillfields*]
#  }
#
#
#  dimension: createddate_Weekfilter {
#    type: date
#    label: "Open Date Week"
#    sql: ${createddate_week} ;;
#  }
#
#  dimension: isescalated{
#    type: string
#    sql: ${TABLE}.IsEscalated ;;
#    label: "Is Escalated"
#  }
#
#
#
#  dimension: category_l1 {
#    type: string
#    sql: ${TABLE}.Category_L1 ;;
#    label:"category_l1"
#    group_label: "Intents"
#    hidden: yes
#  }
#
#  dimension: sub_category_l2 {
#    type: string
#    sql: ${TABLE}.Sub_Category_L2 ;;
#    label: "Category (L2)"
#    group_label: "Intents"
#    drill_fields: [drillfields*]
#  }
#
#
#  dimension: subordinate_category_l3 {
#    type: string
#    sql: ${TABLE}.Subordinate_Category_L3 ;;
#    label:"Topic (L3)"
#    group_label: "Intents"
#    drill_fields: [drillfields*]
#  }
#
#
#
#  dimension: ownerid {
#    type: string
#    sql: ${TABLE}.OwnerId ;;
#    label:"Owner ID"
#    hidden: yes
#
#  }
#
#  dimension: oneforce_id {
#    type: string
#    sql: ${TABLE}.ONEForce_Id ;;
#    label:"Case ID"
#    hidden: yes
#    #primary_key: yes
#  }
#
#  dimension: ct_ONEForce_ID {
#    type: string
#    sql: ${TABLE}.ct_ONEForce_Id ;;
#    label:"Case ID"
#    hidden: yes
#    #primary_key: yes
#  }
#
#  dimension: primary_key {
#    type: string
#    sql: ${oneforce_id} || coalesce(${ct_ONEForce_ID}, '') ;;
#    hidden: yes
#    primary_key: yes
#  }
#
#  dimension: escalation_history {
#    type: string
#    sql: ${TABLE}.Escalation_History ;;
#    label: "EH Name"
#    group_label: "Current Escalation Details"
#    hidden: yes
#  }
#
#  set: detail {
#    fields: [
#      casenumber,
#      service_office_hierarchy.country,
#      case_owner.officetype,
#      case_owner_name,
#      ct_owner_name1,
#      of_user.name,
#      ecomm_id,
#      of_contact.name,
#      contactemail,
#      of_customer.name,
#      status,
#      origin,
#      type,
#      reason,
#      sub_category_l2,
#      subordinate_category_l3,
#      createddate_date,
#      resolved_date_date,
#      closeddate_date,
#      case_age,
#      first_contact_resolution,
#      Case_Net_Promoter_Score,
#      Case_First_Response_Time_Minutes,
#      Chat_First_Response_Time_Mins_avg,
#      case_handling_time,
#      chat_handle_time1,
#    ]
#  }
#
#  set: detail_csat {
#    fields: [
#      casenumber,
#      service_office_hierarchy.country,
#      case_owner.officetype,
#      case_owner_name,
#      ct_owner_name1,
#      of_user.name,
#      ecomm_id,
#      of_contact.name,
#      contactemail,
#      of_customer.name,
#      status,
#      origin,
#      type,
#      reason,
#      sub_category_l2,
#      subordinate_category_l3,
#      createddate_date,
#      resolved_date_date,
#      closeddate_date,
#      case_age,
#      first_contact_resolution,
#      case_rating,
#      chat_case_rating,
#      Case_Net_Promoter_Score,
#      chat_case_net_promoter_score,
#      Case_First_Response_Time_Minutes,
#      Chat_First_Response_Time_Mins_avg,
#      case_handling_time,
#      chat_handle_time1,
#    ]
#  }
#  set: detail_fcr {
#    fields: [
#      casenumber,
#      service_office_hierarchy.country,
#      case_owner.officetype,
#      case_owner_name,
#      ct_owner_name1,
#      of_user.name,
#      ecomm_id,
#      of_contact.name,
#      contactemail,
#      of_customer.name,
#      status,
#      origin,
#      type,
#      reason,
#      sub_category_l2,
#      subordinate_category_l3,
#      createddate_date,
#      resolved_date_date,
#      closeddate_date,
#      case_age,
#      first_contact_resolution,
#      total_transfer,
#      total_escalation,
#      Case_Net_Promoter_Score,
#      Case_First_Response_Time_Minutes,
#      Chat_First_Response_Time_Mins_avg,
#      case_handling_time,
#      chat_handle_time1,
#    ]
#  }
#
#  set: responsetime_details {
#    fields: [
#      casenumber,
#      service_office_hierarchy.country,
#      case_owner.officetype,
#      case_owner_name,
#      of_user.name,
#      ecomm_id,
#      of_contact.name,
#      contactemail,
#      of_customer.name,
#      status,
#      origin,
#      type,
#      reason,
#      sub_category_l2,
#      subordinate_category_l3,
#      createddate_date,
#      resolved_date_date,
#      closeddate_date,
#      case_age,
#      first_contact_resolution,
#      Case_Net_Promoter_Score,
#      Case_First_Response_Time_Minutes,
#      Chat_First_Response_Time_Mins_avg,
#      case_handling_time,
#      chat_handle_time1,
#    ]
#  }
#
#  set: details1 {
#    fields: [
#      casenumber,
#      service_office_hierarchy.country,
#      case_owner.officetype,
#      case_owner_name,
#      ct_owner_name1,
#      of_user.name,
#      ecomm_id,
#      of_contact.name,
#      contactemail,
#      of_customer.name,
#      status,
#      origin,
#      type,
#      reason,
#      sub_category_l2,
#      subordinate_category_l3,
#      createddate_date,
#      resolved_date_date,
#      closeddate_date,
#      case_age,
#      total_transfer,
#      first_contact_resolution,
#      Avg_First_Response_Time,
#      avg_handling_time,
#      avg_chat_handle_time,
#      Case_Net_Promoter_Score,
#    ]
#  }
#
#  set: escdetail {
#    fields: [
#      casenumber,
#      number_of_escalated_cases,
#      service_office_hierarchy.country,
#      case_owner.officetype,
#      case_owner_name,
#      of_user.name,
#      ecomm_id,
#      of_contact.name,
#      contactemail,
#      of_customer.name,
#      status,
#      origin,
#      type,
#      reason,
#      sub_category_l2,
#      subordinate_category_l3,
#      createddate_date,
#      resolved_date_date,
#      closeddate_date,
#      case_age,
#      first_contact_resolution,
#      Avg_First_Response_Time,
#      avg_handling_time,
#      avg_chat_handle_time,
#      Case_Net_Promoter_Score,
#    ]
#  }
#
#  set: drillfields {
#    fields: [
#      Regional_Head_Office,
#      case_country,
#      case_office_code,
#      origin,
#      Initial_Queue_Name,
#      sub_category_l2,
#      subordinate_category_l3,
#      of_customer_group.cust_grp_and_name,
#      of_customer.customer_cd_and_name,
#      case_owner_name,
#      of_user.name,
#      priority,
#      case_age_group,
#      status,
#      nps_group,
#      createddate_month,
#      ecomm_id,
#      of_contact.name,
#      contactemail
#    ]
#  }
#
#  set: transferdetail {
#    fields: [
#      casenumber,
#      service_office_hierarchy.country,
#      case_owner.officetype,
#      case_owner_name,
#      case_transfer_history.transfer_by_name,
#      case_transfer_history.transfer_from_name,
#      case_transfer_history.transfer_to_name,
#      case_transfer_history.transfer_type,
#      case_transfer_history.last_transfer_date_time,
#      case_transfer_history.transfer_duration_in_minutes,
#      case_transfer_history.transfer_reason,
#      total_transfer,
#      of_customer.name,
#      of_contact.name,
#      contactemail,
#      status,
#      origin,
#      type,
#      reason,
#      sub_category_l2,
#      subordinate_category_l3,
#    ]
#  }
#
###############Added Dimensions
#
#
##dimension: additional_cargo_details {
##type: string
##sql: ${TABLE}.Additional_Cargo_Details ;;
##hidden: yes
##}
#
##dimension: additional_contact_emails {
##type: string
##sql: ${TABLE}.Additional_Contact_Emails ;;
##hidden: yes
##}
#
#  dimension: amazon_connect_queue {
#    type: string
#    sql: ${TABLE}.Amazon_Connect_Queue ;;
#    hidden: yes
#  }
#
#  dimension: applicant_email {
#    type: string
#    sql: ${TABLE}.Applicant_Email ;;
#    hidden: yes
#  }
#
#  dimension: applicant_name {
#    type: string
#    sql: ${TABLE}.Applicant_Name ;;
#    hidden: yes
#  }
#
#  dimension: applicant_party {
#    type: string
#    sql: ${TABLE}.Applicant_Party ;;
#    hidden: yes
#  }
#
#  dimension: applicant_phone_number {
#    type: string
#    sql: ${TABLE}.Applicant_Phone_Number ;;
#    hidden: yes
#  }
#
##dimension: are_the_rates_filed_for_the_new_destinat {
##type: string
##sql: ${TABLE}.Are_the_rates_filed_for_the_new_destinat ;;
##hidden: yes
##}
#
#  dimension: article_recommendation_reason {
#    type: string
#    sql: ${TABLE}.Article_Recommendation_Reason ;;
#    hidden: yes
#  }
#
##dimension: article_recommendation_type {
##type: string
##sql: ${TABLE}.Article_Recommendation_Type ;;
##hidden: yes
##}
#
#  dimension: asset_id {
#    type: string
#    sql: ${TABLE}.AssetId ;;
#    hidden: yes
#  }
#
#  dimension_group: assigned {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.AssignedDate ;;
#    hidden: yes
#  }
#
##dimension: auto_titles {
##type: string
##sql: ${TABLE}.Auto_Titles ;;
##hidden: yes
##}
#
#  dimension: bill_of_lading_number {
#    type: string
#    sql: ${TABLE}.Bill_of_Lading_Number ;;
#    hidden: yes
#  }
#
#  dimension: bkg_office {
#    type: string
#    sql: ${TABLE}.BKG_Office ;;
#    hidden: yes
#  }
#
##dimension: boilerplate_review {
##type: string
##sql: ${TABLE}.Boilerplate_Review ;;
##hidden: yes
##}
#
#  dimension: business_hours_id {
#    type: string
#    sql: ${TABLE}.BusinessHoursId ;;
#    hidden: yes
#    label: "Business Hours"
#    group_label: "System Information"
#  }
#
#  dimension: bypass_validation_rules {
#    type: string
#    sql: ${TABLE}.Bypass_Validation_Rules ;;
#    hidden: yes
#  }
#
#  dimension_group: calculated_awaiting_cust_remind_datetime {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Calculated_Awaiting_Cust_Remind_Datetime ;;
#    label: "Calculated Awaiting Cust Remind Datetime"
#    view_label: "System Information"
#  }
#
#  dimension_group: calculated_close_date {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Calculated_Close_Date_Time ;;
#    label: "Calculated Close Date/Time"
#    view_label: "System Information"
#  }
#
#  dimension_group: calculated_date_time_for_one_team {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Calculated_Date_Time_for_ONE_Team ;;
#    label: "Calculated Date/Time for ONE Team"
#    view_label: "System Information"
#  }
#
#  dimension: cargo_nature {
#    type: string
#    sql: ${TABLE}.Cargo_Nature ;;
#    hidden: yes
#  }
#
##dimension_group: close_out {
##type: time
##timeframes: [
##raw,
##date,
##week,
##month,
##quarter,
##year
##]
##convert_tz: no
##datatype: date
##sql: ${TABLE}.Close_Out_Date ;;
##hidden: yes
##}
#
#
#  dimension: comments {
#    type: string
#    sql: ${TABLE}.Comments ;;
#    hidden: yes
#  }
#
#  dimension: commodity {
#    type: string
#    sql: ${TABLE}.Commodity ;;
#    hidden: yes
#  }
#
#  dimension: company_name {
#    type: string
#    sql: ${TABLE}.Company_Name ;;
#    hidden: yes
#  }
#
#
#  dimension: contact_fax {
#    type: string
#    sql: ${TABLE}.ContactFax ;;
#    hidden: yes
#  }
#
#  dimension: contact_id {
#    type: string
#    sql: ${TABLE}.Contact_Id ;;
#    hidden: yes
#  }
#  dimension: contact_mobile {
#    type: string
#    sql: ${TABLE}.ContactMobile ;;
#    hidden: yes
#  }
#
#  dimension: contact_phone {
#    type: string
#    sql: ${TABLE}.ContactPhone ;;
#    hidden: yes
#  }
#
##dimension: container {
##type: string
##sql: ${TABLE}.Container ;;
##hidden: yes
##}
#
##dimension: container_type {
##type: string
##sql: ${TABLE}.Container_Type ;;
##hidden: yes
##}
#
#  dimension: contract_account_name {
#    type: string
#    sql: ${TABLE}.Contract_Account_Name ;;
#    hidden: yes
#  }
#
#
##dimension: current_destination {
##type: string
##sql: ${TABLE}.Current_Destination ;;
##hidden: yes
##}
#
#  dimension: customer_code {
#    type: string
#    sql: ${TABLE}.Customer_Code ;;
#    hidden: yes
#  }
#
#  dimension: customer_info {
#    type: string
#    sql: ${TABLE}.Customer_Info ;;
#    hidden: yes
#  }
#
##dimension: customs_exam {
##type: string
##sql: ${TABLE}.CUSTOMS_Exam ;;
##hidden: yes
##}
#
#  dimension_group: resolved_date  {
#    type: time
#    datatype: datetime
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.DateTimeResolved ;;
#    label: "Resolved Date"
#  }
#
##dimension_group: date_time_resolved {
##type: time
##datatype: datetime
##timeframes: [
##raw,
##time,
##date,
##week,
##month,
##quarter,
##year
##]
##sql: ${TABLE}.DateTimeResolved ;;
##  group_label:"Resolved Date"
##  label: "Resolved Date"
##}
#
#
#  dimension_group: date_time_waiting_on_customer_response {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Date_Time_Waiting_on_Customer_Response ;;
#    hidden: yes
#  }
#
##dimension: direct_care_account {
##type: string
##sql: ${TABLE}.Direct_Care_Account ;;
##hidden: yes
##}
#
##dimension: e_com_account {
##type: string
##sql: ${TABLE}.eCom_Account ;;
##hidden: yes
##}
#
##dimension: e_comm_user_id {
#  # label: "eCom ID"
#  #type: string
#  #sql: ${TABLE}.eComm_User_ID ;;
##}
#
##  dimension: e_commerce_user_id{
##    label: "eComm ID"
##    type: string
##    sql: ${TABLE}.eCommerce_UserID ;;
##    drill_fields: [drillfields*]
##  }
#
##dimension: ebo {
##type: number
##sql: ${TABLE}.EBO ;;
##hidden: yes
##}
#
##dimension: edt {
##type: string
##sql: ${TABLE}.EDT ;;
##hidden: yes
##}
#
#  dimension_group: edw_upd_dt {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.EDW_UPD_DT ;;
#    hidden: yes
#  }
#
##dimension: email_assigned {
##type: string
##sql: ${TABLE}.Email_Assigned ;;
##hidden: yes
##}
#
##dimension: end_status_1 {
##type: string
##sql: ${TABLE}.End_Status_1 ;;
##hidden: yes
##}
#
##dimension_group: end_status_time_1 {
##type: time
##timeframes: [
##raw,
##time,
##date,
##week,
##month,
##quarter,
##year
##]
##sql: ${TABLE}.End_Status_Time_1 ;;
##hidden: yes
##}
#
#  dimension: entitlement_id {
#    type: string
#    sql: ${TABLE}.EntitlementId ;;
#    hidden: yes
#  }
#
#  dimension: escalation_history_reason {
#    type: string
#    sql: ${TABLE}.Escalation_History_Reason ;;
#    label: "Escalation Reason"
#    group_label: "Current Escalation Details"
#    hidden: yes
#  }
#
#  dimension_group: escalation_open {
#    type: time
#    timeframes: [
#      raw,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    convert_tz: no
#    datatype: date
#    sql: ${TABLE}.Escalation_Open_Date ;;
#    hidden: yes
#  }
#
##dimension: eta {
##type: string
##sql: ${TABLE}.ETA ;;
##hidden: yes
##}
#
##dimension: etd {
##type: string
##sql: ${TABLE}.ETD ;;
##hidden: yes
##}
#
#  dimension: first_end_status {
#    type: string
#    sql: ${TABLE}.First_End_Status ;;
#    hidden: yes
#  }
#
#  dimension_group: first_end_status {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.First_End_Status_Time ;;
#    hidden: yes
#  }
#
#  dimension: first_pending_reason {
#    type: string
#    sql: ${TABLE}.First_Pending_Reason ;;
#    hidden: yes
#  }
#
#  dimension: first_processor {
#    type: string
#    sql: ${TABLE}.First_Processor ;;
#    hidden: yes
#  }
#
#  dimension_group: first_reply {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.First_Reply_Time ;;
#    hidden: yes
#  }
#
#
#  dimension: first_response_user {
#    type: string
#    sql: ${TABLE}.First_Response_User ;;
#    hidden: yes
#  }
#
#  dimension_group: first_restart {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.First_Restart_Time ;;
#    hidden: yes
#  }
#
#  dimension: forwarder_name {
#    type: string
#    sql: ${TABLE}.Forwarder_Name ;;
#    hidden: yes
#  }
#
#  dimension: fourth_end_status {
#    type: string
#    sql: ${TABLE}.Fourth_End_Status ;;
#    hidden: yes
#  }
#
#  dimension_group: fourth_end_status {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Fourth_End_Status_Time ;;
#    hidden: yes
#  }
#
#  dimension: fourth_processor {
#    type: string
#    sql: ${TABLE}.Fourth_Processor ;;
#    hidden: yes
#  }
#
#  dimension: internal_correspondence {
#    type: string
#    sql: ${TABLE}.Internal_Correspondence ;;
#    hidden: yes
#  }
#
#  dimension: is_chat_survey_submitted {
#    type: string
#    sql: ${TABLE}.Is_Chat_Survey_Submitted ;;
#    hidden: yes
#  }
#
#  dimension: is_closed {
#    type: string
#    sql: ${TABLE}.IsClosed ;;
#    hidden: yes
#  }
#
#  dimension: is_closed_on_create {
#    type: string
#    sql: ${TABLE}.IsClosedOnCreate ;;
#    hidden: yes
#  }
#
#  dimension: is_deleted {
#    type: string
#    sql: ${TABLE}.IsDeleted ;;
#    hidden: yes
#  }
#
#  dimension: is_dummy {
#    type: string
#    sql: ${TABLE}.IsDummy ;;
#    hidden: yes
#  }
#
#
#  dimension: is_stopped {
#    type: string
#    sql: ${TABLE}.IsStopped ;;
#    hidden: yes
#  }
#
##dimension: lane {
##type: string
##sql: ${TABLE}.Lane ;;
##hidden: yes
##}
#
#  dimension: language {
#    type: string
#    sql: ${TABLE}.Language ;;
#    hidden: yes
#  }
#
#  dimension: last_modified_by_id {
#    type: string
#    sql: ${TABLE}.LastModifiedById ;;
#    hidden: yes
#    label: "Last Modified By"
#    group_label: "System Information"
#  }
#
##dimension: late_gates {
##type: number
##sql: ${TABLE}.Late_Gates ;;
##hidden: yes
##}
#
#  dimension: milestone_status {
#    type: string
#    sql: ${TABLE}.MilestoneStatus ;;
#    hidden: yes
#  }
#
##dimension: missing_s_i {
##type: string
##sql: ${TABLE}.Missing_S_I ;;
##hidden: yes
##}
#
##dimension: new_destination {
##type: string
##sql: ${TABLE}.New_Destination ;;
##hidden: yes
##}
#
#  dimension: nfvoice__voicemail_callback_phone {
#    type: string
#    sql: ${TABLE}.nfvoice__Voicemail_Callback_Phone ;;
#    hidden: yes
#  }
#
#  dimension: nfvoice__voicemail_link {
#    type: string
#    sql: ${TABLE}.nfvoice__Voicemail_Link ;;
#    hidden: yes
#  }
#
#  dimension: nfvoice_voicemail_callback_phone {
#    type: string
#    sql: ${TABLE}.nfvoice_Voicemail_Callback_Phone ;;
#    hidden: yes
#  }
#
#  dimension: nfvoice_voicemail_contact_attributes {
#    type: string
#    sql: ${TABLE}.nfvoice_Voicemail_Contact_Attributes ;;
#    hidden: yes
#  }
#
##dimension: onboarding {
##type: string
##sql: ${TABLE}.Onboarding ;;
##hidden: yes
##}
#
##dimension: opus_request_number {
##type: string
##sql: ${TABLE}.Opus_Request_Number ;;
##hidden: yes
##}
#
#  dimension: origin_indicator {
#    type: string
#    sql: ${TABLE}.Origin_Indicator ;;
#    hidden: yes
#    label: "origin_indicator"
#    group_label: "Header"
#  }
#
##dimension: original_discharge_port_pod {
##type: string
##sql: ${TABLE}.Original_Discharge_Port_POD ;;
##hidden: yes
##}
#
#  dimension: other_reason {
#    type: string
#    sql: ${TABLE}.Other_Reason ;;
#    hidden: yes
#  }
#
##dimension: out_of_scope {
##type: string
##sql: ${TABLE}.Out_of_Scope ;;
##hidden: yes
##}
#
##dimension: pending_reason_1 {
##type: string
##sql: ${TABLE}.Pending_Reason_1 ;;
##hidden: yes
##}
#
##dimension: pod_change_request {
##type: string
##sql: ${TABLE}.POD_CHANGE_REQUEST ;;
##hidden: yes
##}
#
#  dimension: port {
#    type: string
#    sql: ${TABLE}.PORT ;;
#    hidden: yes
#  }
#
#  dimension: post_reconciliation_completed_with_biz {
#    type: string
#    sql: ${TABLE}.Post_Reconciliation_Completed_with_biz ;;
#    hidden: yes
#  }
#
#
#  dimension: priority_formula {
#    type: string
#    sql: ${TABLE}.Priority_Formula ;;
#    hidden: yes
#    label: "Priority Indicator"
#    group_label: "Header"
#  }
#
#  dimension: privacy_policy_consent {
#    type: string
#    sql: ${TABLE}.Privacy_Policy_Consent ;;
#    hidden: yes
#  }
#
##dimension: processor_1 {
##type: string
##sql: ${TABLE}.Processor_1 ;;
##hidden: yes
##}
#
#  dimension: product_id {
#    type: string
#    sql: ${TABLE}.ProductId ;;
#    hidden: yes
#  }
#
##dimension: reason_s_for_cod_diversion {
##type: string
##sql: ${TABLE}.Reason_s_for_COD_Diversion ;;
##hidden: yes
##}
#
#  dimension: record_type_id {
#    type: string
#    sql: ${TABLE}.RecordTypeId ;;
#    hidden: yes
#    label: "Case Record Type"
#    group_label: "System Information"
#  }
#
#  dimension: reference_number {
#    type: string
#    sql: ${TABLE}.Reference_Number ;;
#    hidden: yes
#  }
#
#  dimension: reference_number_type {
#    type: string
#    sql: ${TABLE}.Reference_Number_Type ;;
#    hidden: yes
#  }
#
#
##dimension: reporting {
##type: string
##sql: ${TABLE}.Reporting ;;
##hidden: yes
##}
#
##dimension: request_type {
##type: string
##sql: ${TABLE}.Request_Type ;;
##hidden: yes
##}
#
#  dimension: requestor_type {
#    type: string
#    sql: ${TABLE}.Requestor_Type ;;
#    hidden: yes
#  }
#
#  dimension: response_flag {
#    type: string
#    sql: ${TABLE}.Response_Flag ;;
#    hidden: yes
#  }
#
#  dimension: response_received {
#    type: string
#    sql: ${TABLE}.Response_Received ;;
#    hidden: yes
#  }
#
#  dimension: revised_destination {
#    type: string
#    sql: ${TABLE}.Revised_Destination ;;
#    hidden: yes
#  }
#
#  dimension: second_end_status {
#    type: string
#    sql: ${TABLE}.Second_End_Status ;;
#    hidden: yes
#  }
#
##dimension_group: second_end_status {
##type: time
##timeframes: [
##raw,
##time,
##date,
##week,
##month,
##quarter,
##year
##]
##sql: ${TABLE}.Second_End_Status_Time ;;
##hidden: yes
##}
#
#  dimension: second_pending_reason {
#    type: string
#    sql: ${TABLE}.Second_Pending_Reason ;;
#    hidden: yes
#  }
#
#  dimension: second_processor {
#    type: string
#    sql: ${TABLE}.Second_Processor ;;
#    hidden: yes
#  }
#
#  dimension_group: second_reply {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Second_Reply_Time ;;
#    hidden: yes
#  }
#
#  dimension_group: second_restart {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Second_Restart_Time ;;
#    hidden: yes
#  }
#
#  dimension: service_contract_id {
#    type: string
#    sql: ${TABLE}.ServiceContractId ;;
#    hidden: yes
#  }
#
#  dimension: shipment_number {
#    type: string
#    sql: ${TABLE}.Shipment_Number ;;
#    hidden: yes
#  }
#
#  dimension: shipper_name {
#    type: string
#    sql: ${TABLE}.Shipper_Name ;;
#    hidden: yes
#  }
#
#  dimension_group: sla_exit {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.SlaExitDate ;;
#    hidden: yes
#  }
#
#  dimension_group: sla_start {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.SlaStartDate ;;
#    hidden: yes
#  }
#
#  dimension: source_id {
#    type: string
#    sql: ${TABLE}.SourceId ;;
#    hidden: yes
#  }
#
#  dimension_group: stop_start {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.StopStartDate ;;
#    hidden: yes
#  }
#
#  dimension: subordinate_category_l4 {
#    type: string
#    sql: ${TABLE}.Subordinate_Category_L4 ;;
#    label:"Subtopic (L4)"
#    group_label: "Intents"
#  }
#
#  dimension: supplied_company {
#    type: string
#    sql: ${TABLE}.SuppliedCompany ;;
#    hidden: yes
#  }
#
#  dimension: supplied_email {
#    type: string
#    sql: ${TABLE}.SuppliedEmail ;;
#    label: "Web Email"
#    group_label: "System Information"
#  }
#
#  dimension: supplied_first_name {
#    type: string
#    sql: ${TABLE}.SuppliedFirstName ;;
#    hidden: yes
#  }
#
#  dimension: supplied_last_name {
#    type: string
#    sql: ${TABLE}.SuppliedLastName ;;
#    hidden: yes
#  }
#
#  dimension: supplied_name {
#    type: string
#    sql: ${TABLE}.SuppliedName ;;
#    hidden: yes
#  }
#
#  dimension: supplied_phone {
#    type: string
#    sql: ${TABLE}.SuppliedPhone ;;
#    hidden: yes
#  }
#
#  dimension: third_end_status {
#    type: string
#    sql: ${TABLE}.Third_End_Status ;;
#    hidden: yes
#  }
#
#  dimension_group: third_end_status {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Third_End_Status_Time ;;
#    hidden: yes
#  }
#
#  dimension: third_pending_reason {
#    type: string
#    sql: ${TABLE}.Third_Pending_Reason ;;
#    hidden: yes
#  }
#
#  dimension: third_processor {
#    type: string
#    sql: ${TABLE}.Third_Processor ;;
#    hidden: yes
#  }
#
#  dimension_group: third_reply {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Third_Reply_Time ;;
#    hidden: yes
#  }
#
#  dimension_group: third_restart {
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Third_Restart_Time ;;
#    hidden: yes
#  }
#
#  dimension: training {
#    type: string
#    sql: ${TABLE}.Training ;;
#    hidden: yes
#  }
#
##dimension: type_of_diversion {
##type: string
##sql: ${TABLE}.Type_of_Diversion ;;
##hidden: yes
##}
#
#  dimension: unique_case_key {
#    type: string
#    sql: ${TABLE}.UniqueCaseKey ;;
#    hidden: yes
#  }
#
##dimension: vessel_cleaned {
##type: string
##sql: ${TABLE}.Vessel_Cleaned ;;
##hidden: yes
##}
#
#  dimension: voice_call {
#    type: string
#    sql: ${TABLE}.Voice_Call ;;
#    hidden: yes
#  }
#
#  dimension: vvd {
#    type: string
#    sql: ${TABLE}.VVD ;;
#    hidden: yes
#  }
#
#  dimension: active_case {
#    type: string
#    sql: (CASE WHEN ${status} ='Resolved' or ${status} ='Closed' THEN 'No' ELSE 'Yes' END)   ;;
#
#  }
#
#  dimension : case_owner_name {
#    type : string
#    sql:  CASE WHEN ${of_queue.developer_name} is not Null then ${of_queue.developer_name} else ${case_owner.name} END;;
#    label : "Case Owner Name"
#    drill_fields: [drillfields*]
#  }
#
#  dimension : first_contact_resolution {
#    type: string
#    sql: CASE
#          WHEN ${origin} = 'Chat' and ${TABLE}.is_fcr ='true' THEN 'Yes'
#          WHEN ${origin} = 'Chat' and ${TABLE}.is_fcr ='false' THEN 'No'
#          WHEN ${total_escalation} =0 and ${transfer_reason} is Null and ${active_case} = 'No' THEN 'Yes' ELSE 'No' END ;;
#    label: "First Contact Resolution"
#  }
#
#  dimension: case_office_code {
#    group_label: "Office Hierarchy"
#    label: "Office Code"
#    type: string
#    sql: (CASE
#      WHEN service_office_hierarchy.office_code is not Null THEN service_office_hierarchy.office_code
#      ELSE  user_office_hierarchy.office_code
#    END) ;;
#    drill_fields: [drillfields*]
#  }
#
#
#  dimension: case_country {
#    group_label: "Office Hierarchy"
#    label: "Cluster Country"
#    type: string
#    #map_layer_name: countries
#    sql: (case when ${case_country1}='AT' then 'AT & HU'
#               when ${case_country1}='CZ' then 'CZ & SK'
#               when ${case_country1}='SE' then 'SE & NO' else ${case_country1} end) ;;
#    drill_fields: [drillfields*]
#  }
#
#  dimension: case_country1 {
#    group_label: "Office Hierarchy"
#    label: "Cluster"
#    type: string
#    #map_layer_name: countries
#    sql: (CASE
#      WHEN ${service_office_hierarchy.country} is not Null THEN ${service_office_hierarchy.country}
#      WHEN ${queue_name_office_hierarchy.country} is not Null THEN ${queue_name_office_hierarchy.country}
#      ELSE ${user_office_hierarchy.country}
#    END) ;;
#    drill_fields: [drillfields*]
#  }
#
#  dimension: Regional_Head_Office {
#    group_label: "Office Hierarchy"
#    label: "Regional_Head_Office"
#    type: string
#    # First Condition added to map Offshore Offices to Service Office
#    sql: coalesce((CASE
#               WHEN service_office_hierarchy.Regional_Head_Office is not Null THEN substr(service_office_hierarchy.Regional_Head_Office,-5)
#               WHEN queue_name_office_hierarchy.Regional_Head_Office is not Null THEN  substr(queue_name_office_hierarchy.Regional_Head_Office,-5)
#               WHEN user_office_hierarchy.Regional_Head_Office is not Null and substr(user_office_hierarchy.office_code,-2) = "OS" THEN substr(service_office_hierarchy.Regional_Head_Office,-5)
#               WHEN user_office_hierarchy.Regional_Head_Office is not null THEN substr(user_office_hierarchy.Regional_Head_Office,-5)
#    ELSE "Unclaimed"
#    END),"Unclaimed") ;;
#    drill_fields: [drillfields*]
#  }
#
#  dimension: Case_Geo {
#    group_label: "Office Hierarchy"
#    label: "Case Geography"
#    type: string
#    sql: CASE
#          WHEN {% parameter Geo_Param %} = "RHQ" THEN ${Regional_Head_Office}
#          WHEN {% parameter Geo_Param %} = "Cluster Country" THEN ${case_country}
#          WHEN {% parameter Geo_Param %} = "Individual Country" THEN ${country}
#          WHEN {% parameter Geo_Param %} = "Office" THEN ${office}
#          WHEN {% parameter Geo_Param %} = "Channel" THEN ${origin}
#          WHEN {% parameter Geo_Param %} = "Segment" THEN ${customer_segment_number}
#          WHEN {% parameter Geo_Param %} = "Segment " THEN ${of_customer_group.key_acct_tp_cd}
#          WHEN {% parameter Geo_Param %} = "Agent Role" THEN ${case_owner.profile_name_service}
#          WHEN {% parameter Geo_Param %} = "Escalation Role" THEN ${of_escalation_history_pdt.role}
#          WHEN {% parameter Geo_Param %} = "Office Type" THEN ${case_owner.officetype}
#          WHEN {% parameter Geo_Param %} = "Service Type" THEN ${type}
#          ELSE "Global" END;;
#    drill_fields: [drillfields*]
#  }
#
#  dimension: case_RHQ {
#    group_label: "Chat Office Hierarchy"
#    label: "RHQ"
#    type: string
#    sql: ${Regional_Head_Office} ;;
#    #sql: case
#    #      when ${Regional_Head_Office}='SAOHQ' THEN 'SAOHQ'
#    #      when ${Regional_Head_Office}='HKGHQ' THEN 'HKGHQ'
#    #      when ${Regional_Head_Office}='LONHQ' THEN 'LONHQ'
#    #      when ${Regional_Head_Office}='RICHQ' THEN 'RICHQ'
#    #      when ${Regional_Head_Office}='SINHQ' THEN 'SINHQ'
#    #        else "Unclaimed" end;;
#    #hidden: yes
#  }
#
#  measure: count {
#    type: count
#    sql_distinct_key: ${oneforce_id};;
#    drill_fields: [detail*]
#    label: "Count"
#  }
#
#  measure: count_transfer {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [transferdetail*]
#    label: "Count Transfer"
#  }
#
#  measure: count_for_transfer {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [transferdetail*]
#    label: "Count For Tranfer"
#    html: Total Transfer: {{total_transfer._rendered_value}} <br> {{rendered_value}};;
#  }
#
#  measure: case_distinct_count1 {
#    type: count_distinct
#    sql: ${casenumber}  ;;
#    drill_fields: [details1*]
#    label: "Distinct Count"
#  }
#
#  measure: case_distinct_count_fcr {
#    type: count_distinct
#    sql: ${casenumber}  ;;
#    drill_fields: [detail_fcr*]
#    label: "Distinct Count FCR-related"
#  }
#
#  measure: case_distinct_count {
#    type: count_distinct
#    sql: ${casenumber}  ;;
#    drill_fields: [detail*]
#    label: "Distinct Count"
#  }
#
#  measure: case_distinct_count_csat {
#    type: count_distinct
#    sql: ${casenumber}  ;;
#    drill_fields: [detail_csat*]
#    label: "Distinct Count CSAT-related"
#  }
#
#  measure: case_distinct_count_nps {
#    type: count_distinct
#    sql: ${casenumber}  ;;
#    drill_fields: [detail_csat*]
#    label: "Distinct Count NPS-related"
#  }
#
#  measure: case_distinct_count_drill {
#    type: count_distinct
#    sql: ${casenumber}  ;;
#    drill_fields: [detail*]
#    label: "Distinct Count with drill"
#
#    link: {
#      label: "By chat owner name"
#      url: "{{ CDC_by_chat_owner_name._link }}"
#    }
#
#    link: {
#      label: "By RHQ"
#      url: "{{ CDC_by_RHQ._link }}"
#    }
#    link: {
#      label: "By Country"
#      url: "{{ CDC_by_Country._link }}"
#    }
#    link: {
#      label: "By Status"
#      url: "{{ CDC_by_Status._link }}"
#    }
#    link: {
#      label: "By Office"
#      url: "{{ CDC_by_Office._link }}"
#    }
#    link: {
#      label: "By Channel"
#      url: "{{ CDC_by_Channel._link }}"
#    }
#    link: {
#      label: "By Customer"
#      url: "{{ CDC_by_Customer._link }}"
#    }
#    link: {
#      label: "By case_age_group"
#      url: "{{ CDC_by_case_age_group._link }}"
#    }
#    link: {
#      label: "By case_owner_name"
#      url: "{{ CDC_by_case_owner_name._link }}"
#    }
#    link: {
#      label: "By Priority"
#      url: "{{ CDC_by_Priority._link }}"
#    }
#    link: {
#      label: "By Customer Group"
#      url: "{{ CDC_by_Customer_Group._link }}"
#    }
#    link: {
#      label: "By L2 Intent"
#      url: "{{ CDC_by_L2_Intent._link }}"
#    }
#    link: {
#      label: "By L3 Intent"
#      url: "{{ CDC_by_L3_Intent._link }}"
#    }
#    link: {
#      label: "By Open Date Month"
#      url: "{{ CDC_by_Open_Date_Month._link }}"
#    }
#    link: {
#      label: "By Initial Queue Name"
#      url: "{{ CDC_by_Initial_Queue_Name._link }}"
#    }
#
#    link: {
#      label: "By Contact Name"
#      url: "{{ CDC_by_name._link }}"
#    }
#
#    link: {
#      label: "By Contact Email"
#      url: "{{ CDC_by_contactemail._link }}"
#    }
#
#    link: {
#      label: "By eComm ID"
#      url: "{{ CDC_by_ecomm_id._link }}"
#    }
#  }
#
#  measure: CDC_by_chat_owner_name  {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [of_user.name, case_distinct_count_drill]
#    hidden: yes
#  }
#
#  measure: CDC_by_RHQ {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ Regional_Head_Office,case_distinct_count]
#    hidden: yes
#  }
#  measure: CDC_by_case_age_group {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_age_group,case_distinct_count]
#    hidden: yes
#  }
#  measure: CDC_by_Status {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ status,case_distinct_count]
#    hidden: yes
#  }
#  measure: CDC_by_case_owner_name {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_owner_name,case_distinct_count]
#    hidden: yes
#  }
#  measure: CDC_by_Priority {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ priority ,case_distinct_count]
#    hidden: yes
#  }
#
#  measure: CDC_by_Country {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_country,case_distinct_count]
#    hidden: yes
#  }
#
#  measure: CDC_by_Office {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_office_code,case_distinct_count]
#    hidden: yes
#  }
#
#  measure: CDC_by_Channel {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [origin ,case_distinct_count]
#    hidden: yes
#  }
#  measure: CDC_by_Customer_Group{
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ of_customer_group.cust_grp_and_name,case_distinct_count]
#    hidden: yes
#  }
#  measure: CDC_by_Customer {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ of_customer.customer_cd_and_name,case_distinct_count]
#    hidden: yes
#  }
#  measure: CDC_by_L2_Intent {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [sub_category_l2 ,case_distinct_count]
#    hidden: yes
#  }
#  measure: CDC_by_L3_Intent {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [subordinate_category_l3 ,case_distinct_count]
#    hidden: yes
#  }
#  measure: CDC_by_Open_Date_Month {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [createddate_month ,case_distinct_count]
#    hidden: yes
#  }
#
#  measure: CDC_by_Initial_Queue_Name {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [Initial_Queue_Name,case_distinct_count]
#    hidden: yes
#  }
#
#  measure: CDC_by_name  {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [of_contact.name, case_distinct_count]
#    hidden: yes
#  }
#
#  measure: CDC_by_contactemail  {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [contactemail, case_distinct_count]
#    hidden: yes
#  }
#
#  measure: CDC_by_ecomm_id {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ ecomm_id,case_distinct_count]
#    hidden: yes
#  }
#
#  measure: Avg_First_Response_Time {
#    type: average
#    sql: ${FIRST_RESPONSE_TIME_CASE} ;;
#    drill_fields: [detail*]
#    label: "Avg First Response Time"
#    value_format_name: decimal_1
#  }
#
#  dimension: First_Response_Time_Minutes {
#    type: number
#    sql: ${TABLE}.First_Response_Time_Minutes ;;
#    label: "First Response Time Minutes"
#    description: "To Plot the scatter plot outliers (FRT)"
#  }
#
#  dimension: Case_First_Response_Time_Minutes {
#    type: number
#    sql: ${TABLE}.First_Response_Time_Minutes ;;
#    label: "Case FRT (mins)"
#  }
#
#  measure: AVG_FIRST_RESPONSE_TIME {
#    type: average
#    sql: ${TABLE}.First_Response_Time_Minutes ;;
#    drill_fields: [detail*]
#    label: "Average First Response Time"
#    value_format_name: decimal_1
#    link: {
#      label: "By RHQ"
#      url: "{{ FRT_by_RHQ._link }}"
#    }
#    link: {
#      label: "By Country"
#      url: "{{ FRT_by_Country._link }}"
#    }
#    link: {
#      label: "By Status"
#      url: "{{ FRT_by_Status._link }}"
#    }
#    link: {
#      label: "By Office"
#      url: "{{ FRT_by_Office._link }}"
#    }
#    link: {
#      label: "By Channel"
#      url: "{{ FRT_by_Channel._link }}"
#    }
#    link: {
#      label: "By Customer"
#      url: "{{ FRT_by_Customer._link }}"
#    }
#    link: {
#      label: "By case_age_group"
#      url: "{{ FRT_by_case_age_group._link }}"
#    }
#    link: {
#      label: "By case_owner_name"
#      url: "{{ FRT_by_case_owner_name._link }}"
#    }
#    link: {
#      label: "By Priority"
#      url: "{{ FRT_by_Priority._link }}"
#    }
#    link: {
#      label: "By Customer Group"
#      url: "{{ FRT_by_Customer_Group._link }}"
#    }
#
#    link: {
#      label: "By L2 Intent"
#      url: "{{ FRT_by_L2_Intent._link }}"
#    }
#    link: {
#      label: "By L3 Intent"
#      url: "{{ FRT_by_L3_Intent._link }}"
#    }
#    link: {
#      label: "By Open Date Month"
#      url: "{{ FRT_by_Open_Date_Month._link }}"
#    }
#
#    link: {
#      label: "By Initial Queue Name"
#      url: "{{ FRT_by_Initial_Queue_Name._link }}"
#    }
#
#    link: {
#      label: "By Contact Name"
#      url: "{{ FRT_by_name._link }}"
#    }
#
#    link: {
#      label: "By Contact Email"
#      url: "{{ FRT_by_contactemail._link }}"
#    }
#
#    link: {
#      label: "By eComm ID"
#      url: "{{ FRT_by_ecomm_id._link }}"
#    }
#  }
#
#  measure: FRT_by_RHQ {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ Regional_Head_Office,AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#  measure: FRT_by_case_age_group {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_age_group,AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#  measure: FRT_by_Status {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ status,AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#  measure: FRT_by_case_owner_name {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_owner_name,AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#  measure: FRT_by_Priority {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ priority,AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#  measure: FRT_by_Country {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_country,AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#
#  measure: FRT_by_Office {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_office_code,AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#
#  measure: FRT_by_Channel {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [origin ,AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#  measure: FRT_by_Customer_Group{
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ of_customer_group.cust_grp_and_name,AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#  measure: FRT_by_Customer {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ of_customer.customer_cd_and_name,AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#  measure: FRT_by_L2_Intent {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ sub_category_l2,AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#  measure: FRT_by_L3_Intent {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ subordinate_category_l3,AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#  measure: FRT_by_Open_Date_Month {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [createddate_month ,AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#
#  measure: FRT_by_Initial_Queue_Name {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [Initial_Queue_Name,AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#
#  measure: FRT_by_name  {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [of_contact.name, AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#
#  measure: FRT_by_contactemail  {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [contactemail, AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#
#  measure: FRT_by_ecomm_id {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ ecomm_id,AVG_FIRST_RESPONSE_TIME]
#    hidden: yes
#  }
#
#  measure: AVG_FIRST_CONTACT_RESOLUTION {
#    type: average
#    sql: CASE
#          WHEN ${origin} = 'Chat' and ${TABLE}.is_fcr ='true' THEN 1
#          WHEN ${origin} = 'Chat' and ${TABLE}.is_fcr ='false' THEN 0
#          WHEN ${total_escalation} =0 and ${transfer_reason} is Null and ${active_case} ='No' THEN 1 ELSE 0 END ;;
#    drill_fields: [detail_fcr*]
#    label: "First Contact Resolution Ratio"
#    value_format_name: percent_0
#  }
#
#  measure: NURTURE_RATE {
#    type: average
#    sql: CASE WHEN ${is_nurtured} ='true' THEN 1 ELSE 0 END  ;;
#    drill_fields: [detail*]
#    label: "Nurturing Rate"
#    value_format_name: percent_0
#  }
#  measure: is_contract_customer {
#    type: average
#    label: "Is contract Customer"
#    sql: CASE WHEN ${contract_customer_name} is not null THEN 1 ELSE 0 END   ;;
#    value_format_name: percent_0
#  }
#
#  measure: has_container_number {
#    type: sum
#    label: "Has Container Number"
#    sql: CASE WHEN ${container_number} is not null THEN 1 ELSE 0 END   ;;
#    value_format_name: decimal_0
#  }
#
#  measure: has_booking_number {
#    type: sum
#    label: "Has Booking Number"
#    sql: CASE WHEN ${booking_number} is not null THEN 1 ELSE 0 END   ;;
#    value_format_name: decimal_0
#  }
#
#
#  dimension: Is_Chat_Self_Service {
#    type: string
#    sql: ${TABLE}.Is_Chat_Self_Service ;;
#    label: "Is Chat Self Service"
#    group_label: "Additional Information"
#  }
#
#  dimension: is_resolved_by_automation {
#    label: "Is resolved by automation"
#    type: string
#    sql: CASE WHEN ${case_owner.name}='Platform Integration User' THEN 'Yes' else 'No' END ;;
#  }
#
#  dimension: Automation_Type {
#    label: "Automation Type"
#    type: string
#    drill_fields: [drillfields*]
#    sql: CASE
#      WHEN ${merged_d_d_used}='true' THEN 'D&D'
#      WHEN ${lfd_used}='true' THEN 'LFD'
#      WHEN ${TABLE}.Is_Chat_Self_Service = "true" THEN 'Self-Service'
#      ELSE 'Others'
#      END ;;
#  }
#
#  measure: has_contract_number {
#    type: sum
#    label: "Has Contract Number"
#    sql: CASE WHEN ${contract_number} is not null THEN 1 ELSE 0 END   ;;
#    value_format_name: decimal_0
#  }
#
#  measure: queue_abandonment {
#    type: sum
#    sql: (CASE WHEN ${of_queue.developer_name} is not Null and ${status} not in ('Resolved','Closed') THEN 1 else 0 END) ;;
#    drill_fields: [detail*]
#  }
#
#  measure: queue_abandonment_ratio {
#    type: average
#    sql: (CASE WHEN ${of_queue.developer_name} is not Null and ${status} not in ('Resolved','Closed') THEN 1 else 0 END) ;;
#    value_format_name: percent_0
#  }
#
#  dimension_group: createddate_temp {
#    type: time
#    datatype: datetime
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    label: "Created Date - Do Not Use"
#    sql: ${TABLE}.CreatedDate ;;
#  }
#
#  dimension_group: createddate_filter {
#    type: time
#    datatype: datetime
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    group_label: "Open Date For Filter"
#    label: "Open Date For Filter"
#    sql: ${TABLE}.CreatedDate ;;
#  }
#
#  dimension: BOT_Cases {
#    type: string
#    sql: (CASE WHEN ${Automation_Type}="D&D" OR  ${Automation_Type}="LFD" THEN 'Yes' ELSE 'No' END) ;;
#    label: "BOT Cases"
#    drill_fields: [drillfields*]
#  }
#
#  dimension: case_handle_time_minutes {
#    label: "Case Handle Time Minutes"
#    type: string
#    sql:  ${TABLE}.Case_Handle_Time_Minutes ;;
#  }
#
## Below Dimension is created for DCN-966
#  dimension: is_aht_calculated_excluded {
#    type: string
#    description: "Refined AHT Logic for Open and Resolved dates after 1st Jan 2023"
#    sql: case when ((${createddate_filter_date}>=date(2023,01,01) and ${is_aht_calculated}="Yes") OR (${resolved_date_date}>=date(2023,01,01) and ${is_aht_calculated}="Yes"))
#          OR (${createddate_filter_date}<date(2023,01,01) and (${is_aht_calculated}="No" OR ${is_aht_calculated}="Yes")) then "Yes"
#          else "No"
#          end ;;
#  }
#
#  ### Created for DCN:947
#  parameter: Exclude_Awaiting_Internal_in_AHT{
#    description: "Used for toggle AHT"
#    type: string
#    default_value: "No"
#    allowed_value: {
#      label: "Yes"
#      value: "Yes"
#    }
#    allowed_value: {
#      label: "No"
#      value: "No"
#    }
#  }
#
#  measure: average_handling_time_new {
#    label: "Average Handling Time temp"
#    type: average
#    sql: case WHEN {% parameter Exclude_Awaiting_Internal_in_AHT %} = "Yes" and (${createddate_filter_date}<date(2023,01,01) ) THEN ${TABLE}.CASE_HANDLE_TIME_EXCL_INTERNAL_MINS
#      WHEN {% parameter Exclude_Awaiting_Internal_in_AHT %} = "No" and (${createddate_filter_date}>=date(2023,01,01) ) THEN ${TABLE}.Case_Handle_Time_Minutes
#      else null
#      end;;
#    value_format_name: decimal_1
#    #filters: [is_aht_calculated_excluded: "Yes"]
#  }
#
#  measure: case_handling_time {
#    label: "Case Handle Time (mins)"
#    type: average
#    sql:  ${TABLE}.Case_Handle_Time_Minutes ;;
#    value_format_name: decimal_1
#  }
#
#  measure: avg_handling_time {
#    label: "Avg Handle Time (Mins)"
#    type: number
#    drill_fields: [responsetime_details*]
#    sql: CASE
#          WHEN {% parameter handletime_Param %} = "Chat Transcript" THEN ${chat_handle_time_avg}
#          ELSE  ${average_handling_time_new} END;;
#    value_format_name: decimal_1
#  }
#
#  dimension: Case_Handle_Time_excl_Internal_mins {
#    type: number
#    sql: ${TABLE}.CASE_HANDLE_TIME_EXCL_INTERNAL_MINS ;;
#  }
#
#  measure: average_handling_time {
#    label: "Average Handling Time"
#    type: number
#    drill_fields: [responsetime_details*]
#    sql: CASE
#          WHEN {% parameter handletime_Param %} = "Chat Transcript" THEN ${chat_handle_time_avg}
#          ELSE  ${average_handling_time_new} END;;
#    value_format_name: decimal_1
#
#
#
#    link: {
#      label: "By RHQ"
#      url: "{{ AHT_by_RHQ._link }}"
#    }
#    link: {
#      label: "By Country"
#      url: "{{ AHT_by_Country._link }}"
#    }
#    link: {
#      label: "By Status"
#      url: "{{ AHT_by_Status._link }}"
#    }
#    link: {
#      label: "By Channel"
#      url: "{{ AHT_by_Channel._link }}"
#    }
#    link: {
#      label: "By Customer"
#      url: "{{ AHT_by_Customer._link }}"
#    }
#    link: {
#      label: "By Office"
#      url: "{{ AHT_by_Office._link }}"
#    }
#    link: {
#      label: "By case_age_group"
#      url: "{{ AHT_by_case_age_group._link }}"
#    }
#    link: {
#      label: "By case_owner_name"
#      url: "{{ AHT_by_case_owner_name._link }}"
#    }
#    link: {
#      label: "By Priority"
#      url: "{{ AHT_by_Priority._link }}"
#    }
#    link: {
#      label: "By Customer Group"
#      url: "{{ AHT_by_Customer_Group._link }}"
#    }
#    link: {
#      label: "By L2 Intent"
#      url: "{{ AHT_by_L2_Intent._link }}"
#    }
#    link: {
#      label: "By L3 Intent"
#      url: "{{ AHT_by_L3_Intent._link }}"
#    }
#    link: {
#      label: "By Open Date Month"
#      url: "{{ AHT_by_Open_Date_Month._link }}"
#    }
#    link: {
#      label: "By Initial Queue Name"
#      url: "{{ AHT_by_Initial_Queue_Name._link }}"
#    }
#
#    link: {
#      label: "By Contact Name"
#      url: "{{ AHT_by_name._link }}"
#    }
#
#    link: {
#      label: "By Contact Email"
#      url: "{{ AHT_by_contactemail._link }}"
#    }
#
#    link: {
#      label: "By eComm ID"
#      url: "{{ AHT_by_ecomm_id._link }}"
#    }
#  }
#
#  measure: AHT_by_RHQ {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ Regional_Head_Office,average_handling_time]
#    hidden: yes
#  }
#  measure: AHT_by_case_age_group {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_age_group,average_handling_time]
#    hidden: yes
#  }
#  measure: AHT_by_Status {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ status,average_handling_time]
#    hidden: yes
#  }
#  measure: AHT_by_case_owner_name {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_owner_name,average_handling_time]
#    hidden: yes
#  }
#  measure: AHT_by_Priority {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ priority,average_handling_time]
#    hidden: yes
#  }
#  measure: AHT_by_Country {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_country,average_handling_time]
#    hidden: yes
#  }
#
#  measure: AHT_by_Office {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_office_code,average_handling_time]
#    hidden: yes
#  }
#
#  measure: AHT_by_Channel {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [origin ,average_handling_time]
#    hidden: yes
#  }
#  measure: AHT_by_Customer_Group{
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ of_customer_group.cust_grp_and_name,average_handling_time]
#    hidden: yes
#  }
#  measure: AHT_by_Customer {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ of_customer.customer_cd_and_name,average_handling_time]
#    hidden: yes
#  }
#  measure: AHT_by_L2_Intent {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [sub_category_l2 ,average_handling_time]
#    hidden: yes
#  }
#  measure: AHT_by_L3_Intent {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [subordinate_category_l3 ,average_handling_time]
#    hidden: yes
#  }
#  measure: AHT_by_Open_Date_Month {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [createddate_month ,average_handling_time]
#    hidden: yes
#  }
#
#  measure: AHT_by_Initial_Queue_Name {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ Initial_Queue_Name,average_handling_time]
#    hidden: yes
#  }
#
#  measure: AHT_by_name  {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [of_contact.name, average_handling_time]
#    hidden: yes
#  }
#
#  measure: AHT_by_contactemail  {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [contactemail, average_handling_time]
#    hidden: yes
#  }
#
#  measure: AHT_by_ecomm_id {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ ecomm_id,average_handling_time]
#    hidden: yes
#  }
#
#  dimension : No_KA_Mapping {
#    type: string
#    sql: CASE WHEN ${total_escalation} >0 and ${of_escalation_history_pdt.role} IS NULL THEN 'Yes' ELSE 'No' END ;;
#    label: "No KA Mapping"
#  }
#
#
#  dimension: Initial_Queue_Name {
#    type: string
#    sql:CASE WHEN ${TABLE}.Origin = "Chat"  THEN ${chat_first_queue_name_detail} else ${TABLE}.Initial_Queue_Name END;;
#    label: "Initial Queue Name"
#  }
#
#  dimension: Case_Owned_by_System_Filter {
#    label: "Case Owned by System Filter"
#    type: string
#    sql: CASE WHEN ${case_owner.name}= "Platform Integration User" OR ${case_owner.name}= "CRM System User" OR ${case_owner.name}="Automated Process" THEN 'Yes' else 'No' END ;;
#  }
#
#  dimension: has_leave_message {
#    type: string
#    sql: ${TABLE}.Has_Leave_Message ;;
#    label: "Has Leave Message"
#  }
#
#  dimension: has_leave_message_filter {
#    label: "Has Leave Message Filter"
#    type: string
#    sql: case when ${TABLE}.Has_Leave_Message="true" then "Yes"
#          else "No"
#          end;;
#  }
#
#  measure : L2_mandatory_1 {
#    type: sum
#    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Booking Management' THEN 1 ELSE 0 END) ;;
#    label: "Mandatory L2_1"
#    drill_fields: [drillfields*]
#  }
#
#  measure : L2_mandatory_2 {
#    type: sum
#    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Claims' THEN 1 ELSE 0 END) ;;
#    label: "Mandatory L2_2"
#    drill_fields: [drillfields*]
#  }
#
#  measure : L2_mandatory_3 {
#    type: sum
#    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Disputes' THEN 1 ELSE 0 END) ;;
#    label: "Mandatory L2_3"
#    drill_fields: [drillfields*]
#  }
#
#  measure : L2_mandatory_4 {
#    type: sum
#    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Export Documentation' THEN 1 ELSE 0 END) ;;
#    label: "Mandatory L2_4"
#    drill_fields: [drillfields*]
#  }
#
#  measure : L2_mandatory_5 {
#    type: sum
#    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Import Documentation' THEN 1 ELSE 0 END) ;;
#    label: "Mandatory L2_5"
#    drill_fields: [drillfields*]
#  }
#
#  measure : L2_mandatory_6 {
#    type: sum
#    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Import Management' THEN 1 ELSE 0 END) ;;
#    label: "Mandatory L2_6"
#    drill_fields: [drillfields*]
#  }
#
#  measure : L2_mandatory_7 {
#    type: sum
#    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Invoice & Charges' THEN 1 ELSE 0 END) ;;
#    label: "Mandatory L2_7"
#    drill_fields: [drillfields*]
#  }
#
#  measure : L2_mandatory_8 {
#    type: sum
#    sql: (CASE WHEN ${TABLE}.Is_Booking_Contract_No_Required = 'true' and ${TABLE}.Sub_Category_L2 = 'Last Free Day / Demurrage & Detention' THEN 1 ELSE 0 END) ;;
#    label: "Mandatory L2_8"
#    drill_fields: [drillfields*]
#  }
#
#  measure: all_cases {
#    type: number
#    label: "All Cases"
#    sql: COUNT(DISTINCT CASE WHEN (CASE WHEN ${resolution_reason} IS NULL THEN 'None' ELSE ${resolution_reason} END  IN ('Customer Abandoned Chat', 'Customer Query Un-resolved', 'None', 'Customer Query Resolved')) THEN ${casenumber}  ELSE NULL END) ;;
#    drill_fields: [drillfields*]
#  }
#
#  measure: duplicate_cases {
#    type: number
#    label: "Duplicate Cases"
#    sql: COUNT(DISTINCT CASE WHEN ((CASE WHEN ${resolution_reason} IS NULL THEN 'None' ELSE ${resolution_reason} END) = 'Duplicate') THEN ${casenumber}  ELSE NULL END) ;;
#    drill_fields: [drillfields*]
#  }
#
#  measure: no_action_required_cases {
#    type: number
#    label: "No Action Required Cases"
#    sql: COUNT(DISTINCT CASE WHEN ((CASE WHEN ${resolution_reason} IS NULL THEN 'None' ELSE ${resolution_reason} END) = 'No Action Required') THEN ${casenumber}  ELSE NULL END) ;;
#    drill_fields: [drillfields*]
#  }
#
#  parameter: Geo_Param {
#    type: string
#    allowed_value: {
#      label: "Global"
#      value: "Global"
#    }
#    allowed_value: {
#      label: "RHQ"
#      value: "RHQ"
#    }
#    allowed_value: {
#      label: "Cluster Country"
#      value: "Cluster Country"
#    }
#    allowed_value: {
#      label: "Individual Country"
#      value: "Individual Country"
#    }
#    allowed_value: {
#      label: "Office"
#      value: "Office"
#    }
#    allowed_value: {
#      label: "Channel"
#      value: "Channel"
#    }
#    allowed_value: {
#      label: "Segment"
#      value: "Segment"
#    }
#    allowed_value: {
#      label: "Segment "
#      value: "Segment "
#    }
#    allowed_value: {
#      label: "Agent Role"
#      value: "Agent Role"
#    }
#    allowed_value: {
#      label: "Escalation Role"
#      value: "Escalation Role"
#    }
#    allowed_value: {
#      label: "Office Type"
#      value: "Office Type"
#    }
#    allowed_value: {
#      label: "Service Type"
#      value: "Service Type"
#    }
#  }
#
#
#  dimension: Reference_data {
#    type: string
#    sql: CASE
#          WHEN ${booking_number} is not null THEN 'Booking'
#          WHEN ${contract_number} is not null THEN 'Contract'
#          WHEN ${container_number} is not null THEN 'Container'
#          ELSE 'No Reference Number' END ;;
#    label:"Reference Data"
#
#  }
#
#  dimension: channel_type {
#    type: string
#    sql: (CASE WHEN ${TABLE}.origin="Chat" or ${TABLE}.origin="Web" THEN "Digital" ELSE "Traditional " END) ;;
#    label: "Channel Type"
#    group_label: "Case Information"
#    drill_fields: [drillfields*]
#  }
#
#  measure: deflection_ratio {
#    type: average
#    sql: (CASE WHEN ${origin} in ('Chat' , 'Web') THEN 1 ELSE 0 END);;
#    drill_fields: [detail*]
#    label: "Deflection Ratio"
#    value_format_name: percent_0
#
#
#    link: {
#      label: "By RHQ"
#      url: "{{ deflection_ratio_by_RHQ._link }}"
#    }
#
#    link: {
#      label: "By Country"
#      url: "{{ deflection_ratio_by_Country._link }}"
#    }
#
#    link: {
#      label: "By Status"
#      url: "{{ deflection_ratio_by_Status._link }}"
#    }
#
#    link: {
#      label: "By Channel"
#      url: "{{ deflection_ratio_by_Channel._link }}"
#    }
#
#    link: {
#      label: "By Customer"
#      url: "{{ deflection_ratio_by_Customer._link }}"
#    }
#
#    link: {
#      label: "By Office"
#      url: "{{ deflection_ratio_by_Office._link }}"
#    }
#
#    link: {
#      label: "By case_age_group"
#      url: "{{ deflection_ratio_by_case_age_group._link }}"
#    }
#
#    link: {
#      label: "By case_owner_name"
#      url: "{{ deflection_ratio_by_case_owner_name._link }}"
#    }
#
#    link: {
#      label: "By Priority"
#      url: "{{ deflection_ratio_by_Priority._link }}"
#    }
#
#    link: {
#      label: "By Customer Group"
#      url: "{{ deflection_ratio_by_Customer_Group._link }}"
#    }
#
#    link: {
#      label: "By L2 Intent"
#      url: "{{ deflection_ratio_by_L2_Intent._link }}"
#    }
#
#    link: {
#      label: "By L3 Intent"
#      url: "{{ deflection_ratio_by_L3_Intent._link }}"
#    }
#    link: {
#      label: "By Open Date Month"
#      url: "{{ deflection_ratio_by_Open_Date_Month._link }}"
#    }
#    link: {
#      label: "By Initial Queue Name"
#      url: "{{ deflection_ratio_by_Initial_Queue_Name._link }}"
#    }
#
#    link: {
#      label: "By Contact Name"
#      url: "{{ deflection_ratio_by_name._link }}"
#    }
#
#    link: {
#      label: "By Contact Email"
#      url: "{{ deflection_ratio_by_contactemail._link }}"
#    }
#
#    link: {
#      label: "By eComm ID"
#      url: "{{ deflection_ratio_by_ecomm_id._link }}"
#    }
#  }
#
#  measure: deflection_ratio_by_RHQ {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [Regional_Head_Office,deflection_ratio]
#    hidden: yes
#  }
#
#  measure: deflection_ratio_by_case_age_group {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [case_age_group,deflection_ratio]
#    hidden: yes
#  }
#
#  measure: deflection_ratio_by_Status {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [status,deflection_ratio]
#    hidden: yes
#  }
#
#  measure: deflection_ratio_by_case_owner_name {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [case_owner_name,deflection_ratio]
#    hidden: yes
#  }
#
#  measure: deflection_ratio_by_Priority {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [priority,deflection_ratio]
#    hidden: yes
#  }
#
#  measure: deflection_ratio_by_Country {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [case_country,deflection_ratio]
#    hidden: yes
#  }
#
#  measure: deflection_ratio_by_Office {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [case_office_code,deflection_ratio]
#    hidden: yes
#  }
#
#  measure: deflection_ratio_by_Channel {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [origin,deflection_ratio]
#    hidden: yes
#  }
#
#  measure: deflection_ratio_by_Customer_Group{
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [of_customer_group.cust_grp_and_name,deflection_ratio]
#    hidden: yes
#  }
#
#  measure: deflection_ratio_by_Customer {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [of_customer.customer_cd_and_name,deflection_ratio]
#    hidden: yes
#  }
#
#  measure: deflection_ratio_by_L2_Intent {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [sub_category_l2 ,deflection_ratio]
#    hidden: yes
#  }
#
#  measure: deflection_ratio_by_L3_Intent {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [subordinate_category_l3 ,deflection_ratio]
#    hidden: yes
#  }
#  measure: deflection_ratio_by_Open_Date_Month {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [createddate_month ,deflection_ratio]
#    hidden: yes
#  }
#
#  measure: deflection_ratio_by_Initial_Queue_Name {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [Initial_Queue_Name,deflection_ratio]
#    hidden: yes
#  }
#
#  measure: deflection_ratio_by_name  {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [of_contact.name, deflection_ratio]
#    hidden: yes
#  }
#
#  measure: deflection_ratio_by_contactemail  {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [contactemail, deflection_ratio]
#    hidden: yes
#  }
#
#  measure: deflection_ratio_by_ecomm_id {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ ecomm_id,deflection_ratio]
#    hidden: yes
#  }
#
#  dimension_group: Case_Resolved_Date_Time {
#    type: time
#    datatype: datetime
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Case_Resolved_Date_Time ;;
#    label: "Case Resolved Date Time"
#  }
#
#  dimension: createddate_dynamic {
#    type: date
#    datatype: datetime
#    label: "Open Date Dynamic"
#    sql:
#    CASE
#    WHEN {% parameter timeframe_picker %} = 'Day' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${createddate_raw}),'{{_query._query_timezone}}'),DAY)
#    WHEN {% parameter timeframe_picker %} = 'Week' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${createddate_raw}),'{{_query._query_timezone}}'), WEEK(MONDAY))
#    WHEN {% parameter timeframe_picker %} = 'Month' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${createddate_raw}),'{{_query._query_timezone}}'),MONTH)
#    WHEN {% parameter timeframe_picker %} = 'Quarter' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${createddate_raw}),'{{_query._query_timezone}}'),QUARTER)
#    WHEN {% parameter timeframe_picker %} = 'Year' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${createddate_raw}),'{{_query._query_timezone}}'),YEAR)
#    ELSE NULL
#    END ;;
#    convert_tz: no
#  }
#
#  parameter: timeframe_picker {
#    label: "Date Granularity"
#    type: string
#    allowed_value: { value: "Day" }
#    allowed_value: { value: "Week" }
#    allowed_value: { value: "Month" }
#    allowed_value: { value: "Quarter" }
#    allowed_value: { value: "Year" }
#    default_value: "Month"
#
#  }
#
#  dimension: isWithInBusinessHour {
#    type: string
#    sql: CASE WHEN ${TABLE}.isWithInBusinessHour ='true' THEN 'Yes' ELSE 'No' END ;;
#    label: "With In Business Hour"
#  }
#
#  dimension: is_channel_applicable_for_FRT {
#    type: string
#    sql: (CASE WHEN ${TABLE}.Origin ="Phone"  THEN "No" ELSE "Yes" END) ;;
#    label: : "Is Channel Applicable For FRT"
#    group_label: "Case Information"
#  }
#
#  measure: detractor_percentage{
#    type: average
#    sql: Case WHEN ${nps_group}='Detractors' THEN 1 ELSE 0 END ;;
#    label:"Detractor Percentage"
#    group_label: "Customer Feedback"
#    filters: [nps_group: "-No Rating"]
#    value_format_name: percent_0
#    #hidden: yes
#  }
#
#  measure: promoter_percentage{
#    type: average
#    sql: Case WHEN ${nps_group}='Promoters' THEN 1 ELSE 0 END ;;
#    label:"Promoters Percentage"
#    group_label: "Customer Feedback"
#    filters: [nps_group: "-No Rating"]
#    value_format_name: percent_0
#    #hidden: yes
#  }
#
#  measure: global_nps{
#    type: number
#    sql: (${promoter_percentage} - ${detractor_percentage}) *100 ;;
#    label:"Global NPS"
#    group_label: "Customer Feedback"
#    value_format_name: decimal_0
#    drill_fields: [detail*]
#
#    link: {
#      label: "By RHQ"
#      url: "{{ global_nps_by_RHQ._link }}"
#    }
#    link: {
#      label: "By Country"
#      url: "{{ global_nps_by_Country._link }}"
#    }
#    link: {
#      label: "By Status"
#      url: "{{ global_nps_by_Status._link }}"
#    }
#    link: {
#      label: "By Channel"
#      url: "{{ global_nps_by_Channel._link }}"
#    }
#    link: {
#      label: "By Customer"
#      url: "{{ global_nps_by_Customer._link }}"
#    }
#    link: {
#      label: "By Office"
#      url: "{{ global_nps_by_Office._link }}"
#    }
#    link: {
#      label: "By case_age_group"
#      url: "{{ global_nps_by_case_age_group._link }}"
#    }
#    link: {
#      label: "By case_owner_name"
#      url: "{{ global_nps_by_case_owner_name._link }}"
#    }
#    link: {
#      label: "By Priority"
#      url: "{{ global_nps_by_Priority._link }}"
#    }
#    link: {
#      label: "By Customer Group"
#      url: "{{ global_nps_by_Customer_Group._link }}"
#    }
#    link: {
#      label: "By L2 Intent"
#      url: "{{ global_nps_by_L2_Intent._link }}"
#    }
#    link: {
#      label: "By L3 Intent"
#      url: "{{ global_nps_by_L3_Intent._link }}"
#    }
#    link: {
#      label: "By Open Date Month"
#      url: "{{ global_nps_by_Open_Date_Month._link }}"
#    }
#
#    link: {
#      label: "By Initial Queue Name"
#      url: "{{ global_nps_by_Initial_Queue_Name._link }}"
#    }
#
#
#    link: {
#      label: "By Contact Name"
#      url: "{{ global_nps_by_name._link }}"
#    }
#
#    link: {
#      label: "By Contact Email"
#      url: "{{ global_nps_by_contactemail._link }}"
#    }
#
#    link: {
#      label: "By eComm ID"
#      url: "{{ global_nps_by_ecomm_id._link }}"
#    }
#  }
#
#  measure: global_nps_by_RHQ {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ Regional_Head_Office,global_nps]
#    hidden: yes
#  }
#  measure: global_nps_by_case_age_group {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_age_group,global_nps]
#    hidden: yes
#  }
#  measure: global_nps_by_Status {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ status,global_nps]
#    hidden: yes
#  }
#  measure: global_nps_by_case_owner_name {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_owner_name,global_nps]
#    hidden: yes
#  }
#  measure: global_nps_by_Priority {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ priority,global_nps]
#    hidden: yes
#  }
#  measure: global_nps_by_Country {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_country,global_nps]
#    hidden: yes
#  }
#
#  measure: global_nps_by_Office {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_office_code,global_nps]
#    hidden: yes
#  }
#
#  measure: global_nps_by_Channel {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [origin,global_nps]
#    hidden: yes
#  }
#  measure: global_nps_by_Customer_Group{
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ of_customer_group.cust_grp_and_name,global_nps]
#    hidden: yes
#  }
#  measure: global_nps_by_Customer {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ of_customer.customer_cd_and_name,global_nps]
#    hidden: yes
#  }
#  measure: global_nps_by_L2_Intent {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [sub_category_l2 ,global_nps]
#    hidden: yes
#  }
#  measure: global_nps_by_L3_Intent {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [subordinate_category_l3 ,global_nps]
#    hidden: yes
#  }
#  measure: global_nps_by_Open_Date_Month {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [createddate_month ,global_nps]
#    hidden: yes
#  }
#
#  measure: global_nps_by_Initial_Queue_Name {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [Initial_Queue_Name,global_nps]
#    hidden: yes
#  }
#
#  measure: global_nps_by_name  {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [of_contact.name, global_nps]
#    hidden: yes
#  }
#
#  measure: global_nps_by_contactemail  {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [contactemail, global_nps]
#    hidden: yes
#  }
#
#  measure: global_nps_by_ecomm_id {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ ecomm_id, global_nps]
#    hidden: yes
#  }
#
#  dimension: nps_group {
#    type: string
#    sql: (CASE
#          WHEN ${TABLE}.Case_Net_Promoter_Score <7 THEN 'Detractors'
#          WHEN ${TABLE}.Case_Net_Promoter_Score >=7 and ${TABLE}.Case_Net_Promoter_Score <9 THEN 'Passives'
#          WHEN ${TABLE}.Case_Net_Promoter_Score >=9 THEN 'Promoters'
#          ELSE 'No Rating' END);;
#    label:"NPS Segment"
#    group_label: "Customer Feedback"
#
#  }
#
#  dimension: Case_Net_Promoter_Score {
#    type: string
#    sql: ${TABLE}.Case_Net_Promoter_Score ;;
#    label: "Case Net Promotor Score"
#  }
#
#  dimension: Service_Contract_Customer  {
#    type: string
#    sql: (CASE
#      WHEN ${accountid} is not null AND ${contract_customer_name} is not null THEN 'Both'
#      WHEN ${accountid} is not null THEN 'Service Customer'
#      WHEN ${contract_customer_name} is not null THEN 'Contract Customer'
#      Else 'None' END);;
#    label: "Service or Contract Customer"
#  }
#
#  dimension: case_channel_or_geography_dynamic {
#    type: string
#    label: "Geography Dynamic Backlog History"
#    sql: CASE
#          WHEN {% parameter Customer_Param %} = "RHQ" THEN ${Regional_Head_Office}
#          WHEN {% parameter Customer_Param %} = "Cluster Country" THEN ${case_country}
#          WHEN {% parameter Customer_Param %} = "Individual Country" THEN ${country}
#          WHEN {% parameter Customer_Param %} = "Office" THEN ${office}
#          WHEN {% parameter Customer_Param %} = "Channel" THEN ${origin}
#          WHEN {% parameter Customer_Param %} = "Status" THEN ${of_case_history_status_stat.status}
#          WHEN {% parameter Customer_Param %} = "Segment" THEN ${of_customer_group.key_acct_tp_cd}
#          WHEN {% parameter Customer_Param %} = "Agent Role" THEN ${case_owner.profile_name_service}
#          WHEN {% parameter Customer_Param %} = "Escalation Role" THEN ${of_escalation_history_pdt.role}
#          WHEN {% parameter Customer_Param %} = "Office Type" THEN ${case_owner.officetype}
#          WHEN {% parameter Customer_Param %} = "Service Type" THEN ${type}
#          ELSE "Global" END;;
#    drill_fields: [drillfields*]
#  }
#
#
#  measure: customer_satisfaction_ratio_case_chat {
#    type: number
#    label: "CSAT Case/Chat"
#    sql: case when {% parameter csat_Param %}= "Case Level" then
#         ${Customer_satisfaction_ratio}
#        when {% parameter csat_Param %}= "Chat Transcript"  then
#          ${Customer_chat_satisfaction_ratio}
#          else null
#          end;;
#    value_format_name: percent_0
#    drill_fields: [detail_csat*]
#  }
#
#  dimension: rating_case_chat {
#    type: string
#    label: "Rating Case/Chat"
#    sql: case when {% parameter csat_Param %}= "Case Level" then
#         ${case_rating}
#        when {% parameter csat_Param %}= "Chat Transcript"  then
#          ${chat_case_rating}
#          else null
#          end;;
#    drill_fields: [drillfields*]
#  }
#
#  parameter: csat_Param {
#    type: string
#    allowed_value: {
#      label: "Case Level"
#      value: "Case Level"
#    }
#    allowed_value: {
#      label: "Chat Transcript"
#      value: "Chat Transcript"
#    }
#  }
#
#  measure: all_rating{
#    type: count_distinct
#    sql: Case WHEN ${case_rating}='Good' OR ${case_rating}='Bad'  THEN 1 ELSE 0 END ;;
#    label:"All Rating Case"
#  }
#
#  measure: good_rating{
#    type: count_distinct
#    sql: Case WHEN ${case_rating}='Good'  THEN 1 ELSE 0 END ;;
#    label:"Good Rating Case"
#  }
#
#  measure: difference_rating_case{
#    type: number
#    sql: (${good_rating}/NULLIF(${all_rating}, 0)) ;;
#    label:"Difference Rating Case"
#    drill_fields: [detail*]
#  }
#
#  measure: csat_case_analysis {
#    type: number
#    label: "CSAT Case Analysis"
#    sql: case when {% parameter csat_Param %}= "Case Level" then
#         ${difference_rating_case}
#        when {% parameter csat_Param %}= "Chat Transcript"  then
#          ${difference_rating_chat}
#          else null
#          end;;
#    value_format_name: percent_0
#    drill_fields: [drillfields*]
#  }
#
#
#  dimension: customer_segment_number {
#    type: string
#    sql: CASE
#          WHEN ${of_customer_group.key_acct_tp_cd} ='GKA' THEN '1'
#          WHEN ${of_customer_group.key_acct_tp_cd} ='RKA' THEN '2'
#          WHEN ${of_customer_group.key_acct_tp_cd} ='LKA' THEN '3'
#          ELSE '4' END
#          ;;
#    label: "customer segment number"
#  }
#
#  dimension: customer_segment_number2 {
#    type: string
#    order_by_field: customer_segment_number
#    sql: CASE
#          WHEN ${of_customer_group.key_acct_tp_cd} ='GKA' THEN 'GKA'
#          WHEN ${of_customer_group.key_acct_tp_cd} ='RKA' THEN 'RKA'
#          WHEN ${of_customer_group.key_acct_tp_cd} ='LKA' THEN 'LKA'
#          WHEN ${of_customer_group.key_acct_tp_cd} ='ONECare' THEN 'ONECare'
#          ELSE '∅' END
#          ;;
#    label: "customer segment number2"
#  }
#
#  parameter: Customer_Param {
#    type: string
#    label: "Customer Parameter"
#    allowed_value: {
#      label: "Global"
#      value: "Global"
#    }
#    allowed_value: {
#      label: "RHQ"
#      value: "RHQ"
#    }
#    allowed_value: {
#      label: "Cluster Country"
#      value: "Cluster Country"
#    }
#    allowed_value: {
#      label: "Individual Country"
#      value: "Individual Country"
#    }
#    allowed_value: {
#      label: "Office"
#      value: "Office"
#    }
#    allowed_value: {
#      label: "Channel"
#      value: "Channel"
#    }
#    allowed_value: {
#      label: "Status"
#      value: "Status"
#    }
#    allowed_value: {
#      label: "Segment"
#      value: "Segment"
#    }
#    allowed_value: {
#      label: "Agent Role"
#      value: "Agent Role"
#    }
#    allowed_value: {
#      label: "Escalation Role"
#      value: "Escalation Role"
#    }
#    allowed_value: {
#      label: "Office Type"
#      value: "Office Type"
#    }
#    allowed_value: {
#      label: "Service Type"
#      value: "Service Type"
#    }
#  }
#
#  dimension: label {
#    type: string
#    sql: ${TABLE}.Label ;;
#    label: "Label"
#  }
#
#  measure: Abandoned_ratio {
#    type: average
#    sql: CASE WHEN ${resolution_reason} = 'Customer Abandoned Chat' THEN 1 ELSE 0 END;;
#    drill_fields: [detail*]
#    label: "Abandoned Ratio"
#    value_format_name: percent_0
#  }
#
#
#  measure: Customer_satisfaction_ratio {
#    type: average
#    sql: CASE WHEN ${case_rating} = 'Good' THEN 1 ELSE 0 END;;
#    drill_fields: [detail*]
#    label: "Customer Satisfaction Ratio"
#    filters: [case_rating: "-No Rating"]
#    value_format_name: percent_0
#  }
#
#  measure: Automation_ratio {
#    type: average
#    sql: (CASE WHEN ${is_resolved_by_automation} = 'Yes' and ${Automation_Type} in ('D&D', 'LFD', 'Self-Service') THEN 1 ELSE 0 END);;
#    drill_fields: [detail*]
#    label: "Automation Ratio"
#    value_format_name: percent_0
#  }
#
#  measure: Case_Resolution_ratio {
#    type: average
#    sql: CASE WHEN ${status} in ('Resolved' , 'Closed')  THEN 1 ELSE 0 END;;
#    drill_fields: [detail*]
#    label: "Case Resolution Ratio"
#    value_format_name: percent_0
#  }
#
#  dimension: filter_start{
#    type: date
#    datatype: datetime
#    sql: {% date_start createddate_filter_date %} ;;
#  }
#
#  dimension: filter_end{
#    type: date
#    datatype: datetime
#    sql: {% date_end createddate_filter_date %} ;;
#  }
#
#  dimension : ct_owner_name {
#    type : string
#    sql:  CASE WHEN ${ct_queue.developer_name} is not Null then ${ct_queue.developer_name} else ${ct_owner.name} END;;
#    label : "Owner Name"
#  }
#
#  dimension : ct_owner_name1 {
#    type : string
#    sql:  CASE WHEN ${ct_queue.developer_name} is not Null then ${ct_queue.developer_name} else ${ct_owner.name} END;;
#    label : "Chat Owner Name"
#  }
#
#  parameter: handletime_Param {
#    type: string
#    allowed_value: {
#      label: "Case Level"
#      value: "Case Level"
#    }
#    allowed_value: {
#      label: "Chat Transcript"
#      value: "Chat Transcript"
#    }
#  }
#
#  parameter: responsetime_Param {
#    type: string
#    allowed_value: {
#      label: "Case Level"
#      value: "Case Level"
#    }
#    allowed_value: {
#      label: "Chat Transcript"
#      value: "Chat Transcript"
#    }
#  }
#
#  dimension: Case_Resolved_Date_Time_dynamic {
#    type: date
#    datatype: datetime
#    label: "Resolved Date Dynamic"
#    sql:
#    CASE
#    WHEN {% parameter timeframe_picker %} = 'Day' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${Case_Resolved_Date_Time_raw}),'{{_query._query_timezone}}'),DAY)
#    WHEN {% parameter timeframe_picker %} = 'Week' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${Case_Resolved_Date_Time_raw}),'{{_query._query_timezone}}'), WEEK(MONDAY))
#    WHEN {% parameter timeframe_picker %} = 'Month' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${Case_Resolved_Date_Time_raw}),'{{_query._query_timezone}}'),MONTH)
#    WHEN {% parameter timeframe_picker %} = 'Quarter' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${Case_Resolved_Date_Time_raw}),'{{_query._query_timezone}}'),QUARTER)
#    WHEN {% parameter timeframe_picker %} = 'Year' THEN DATETIME_TRUNC(DATETIME(TIMESTAMP(${Case_Resolved_Date_Time_raw}),'{{_query._query_timezone}}'),YEAR)
#    ELSE NULL
#    END ;;
#    convert_tz: no
#  }
#
#  measure: case_escalation_ratio {
#    type: average
#    sql: CASE WHEN ${total_escalation} >0  THEN 1 ELSE 0 END;;
#    label: "Case Escalation Ratio"
#    drill_fields: [escdetail*]
#    value_format_name: percent_0
#  }
#
#  measure: number_of_escalated_cases{
#    type: count_distinct
#    sql: case when ${total_escalation}>0 then ${casenumber} else null end;;
#    drill_fields: [detail*]
#    label: "Number of Escalated Cases"
#  }
#
#  measure: escalation_ratio {
#    type:number
#    sql: (${number_of_escalated_cases}/${case_distinct_count}) ;;
#    value_format_name: percent_0
#    drill_fields: [detail*]
#  }
#
#  measure: non_esc {
#    type: average
#    sql: case when ${total_escalation}=0 then 1 else 0 end ;;
#    drill_fields: [detail*]
#    value_format_name: percent_0
#  }
#
#
#  measure: global_nps_case_chat {
#    type: number
#    label: "Global NPS Case/Chat"
#    sql: case when {% parameter globalnps_Param %}= "Case Level" then
#         ${global_nps}
#        when {% parameter globalnps_Param %}= "Chat Transcript"  then
#          ${chat_global_nps}
#          else null
#          end;;
#    drill_fields: [detail_csat*]
#  }
#
#  dimension: nps_segment_case_chat {
#    type: string
#    label: "NPS Segment Case/Chat"
#    sql: case when {% parameter globalnps_Param %}= "Case Level" then
#         ${nps_group}
#        when {% parameter globalnps_Param %}= "Chat Transcript"  then
#          ${chat_nps_group}
#          else null
#          end;;
#  }
#
#  parameter: globalnps_Param {
#    type: string
#    allowed_value: {
#      label: "Case Level"
#      value: "Case Level"
#    }
#    allowed_value: {
#      label: "Chat Transcript"
#      value: "Chat Transcript"
#    }
#  }
#
#
#  measure: esc_ratio {
#    type: number
#    sql: 100-${non_esc} ;;
#    drill_fields: [detail*]
#    value_format_name: percent_0
#  }
#
#  dimension: FIRST_RESPONSE_TIME_CASE {
#    type: number
#    label: "FIRST RESPONSE TIME CASE"
#    description: "Identifies First response time for case & chat handle time "
#    sql: case when {% parameter responsetime_Param %}= "Case Level" then
#         ${TABLE}.First_Response_Time_Minutes
#        when {% parameter responsetime_Param %}= "Chat Transcript" and ${Chat_First_Response_Time_Mins} >0 then
#          ${Chat_First_Response_Time_Mins}
#          else null
#          end;;
#  }
#
#  measure: AVG_FIRST_RESPONSE_TIME_NEW {
#    type: average
#    sql: ${FIRST_RESPONSE_TIME_CASE} ;;
#    drill_fields: [responsetime_details*]
#    label: "Average First Response Time New"
#    value_format_name: decimal_1
#    sql_distinct_key: ${FRT_sql_distinct_key} ;;
#
#    link: {
#      label: "By RHQ"
#      url: "{{ FRT_New_by_RHQ._link }}"
#    }
#    link: {
#      label: "By Country"
#      url: "{{ FRT_New_by_Country._link }}"
#    }
#    link: {
#      label: "By Status"
#      url: "{{ FRT_New_by_Status._link }}"
#    }
#    link: {
#      label: "By Office"
#      url: "{{ FRT_New_by_Office._link }}"
#    }
#    link: {
#      label: "By Channel"
#      url: "{{ FRT_New_by_Channel._link }}"
#    }
#    link: {
#      label: "By Customer"
#      url: "{{ FRT_New_by_Customer._link }}"
#    }
#    link: {
#      label: "By case_age_group"
#      url: "{{ FRT_New_by_case_age_group._link }}"
#    }
#    link: {
#      label: "By case_owner_name"
#      url: "{{ FRT_New_by_case_owner_name._link }}"
#    }
#    link: {
#      label: "By Priority"
#      url: "{{ FRT_New_by_Priority._link }}"
#    }
#    link: {
#      label: "By Customer Group"
#      url: "{{ FRT_New_by_Customer_Group._link }}"
#    }
#
#    link: {
#      label: "By L2 Intent"
#      url: "{{ FRT_New_by_L2_Intent._link }}"
#    }
#    link: {
#      label: "By L3 Intent"
#      url: "{{ FRT_New_by_L3_Intent._link }}"
#    }
#    link: {
#      label: "By Open Date Month"
#      url: "{{ FRT_New_by_Open_Date_Month._link }}"
#    }
#
#    link: {
#      label: "By Initial Queue Name"
#      url: "{{ FRT_New_by_Initial_Queue_Name._link }}"
#    }
#
#    link: {
#      label: "By Contact Name"
#      url: "{{ FRT_New_by_name._link }}"
#    }
#
#    link: {
#      label: "By Contact Email"
#      url: "{{ FRT_New_by_contactemail._link }}"
#    }
#
#    link: {
#      label: "By eComm ID"
#      url: "{{ FRT_New_by_ecomm_id._link }}"
#    }
#  }
#
#  measure: FRT_New_by_RHQ {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ Regional_Head_Office,AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#  measure: FRT_New_by_case_age_group {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_age_group,AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#  measure: FRT_New_by_Status {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ status,AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#  measure: FRT_New_by_case_owner_name {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_owner_name,AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#  measure: FRT_New_by_Priority {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ priority,AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#  measure: FRT_New_by_Country {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_country,AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#
#  measure: FRT_New_by_Office {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ case_office_code,AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#
#  measure: FRT_New_by_Channel {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [origin ,AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#  measure: FRT_New_by_Customer_Group{
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ of_customer_group.cust_grp_and_name,AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#  measure: FRT_New_by_Customer {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ of_customer.customer_cd_and_name,AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#  measure: FRT_New_by_L2_Intent {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ sub_category_l2,AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#  measure: FRT_New_by_L3_Intent {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ subordinate_category_l3,AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#  measure: FRT_New_by_Open_Date_Month {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [createddate_month ,AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#
#  measure: FRT_New_by_Initial_Queue_Name {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [Initial_Queue_Name,AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#
#  measure: FRT_New_by_name  {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [of_contact.name, AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#
#  measure: FRT_New_by_contactemail  {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [contactemail, AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#
#  measure: FRT_New_by_ecomm_id {
#    type: count_distinct
#    sql: ${oneforce_id};;
#    drill_fields: [ ecomm_id,AVG_FIRST_RESPONSE_TIME_NEW]
#    hidden: yes
#  }
#
#
#  dimension: original_record_type {
#    type: string
#    sql: ${TABLE}.Original_Record_Type ;;
#    label:"Original Record Type"
#  }
#
#  dimension: ecomm_id {
#    label: "eComm ID"
#    type: string
#    sql: ${TABLE}.Contact_eComm_User_ID ;;
#    drill_fields: [drillfields*]
#  }
#
#  dimension: no_of_times_case_reopen{
#    label: "No of times case reopen"
#    type: number
#    sql: ${TABLE}.No_of_Times_Case_Reopen ;;
#  }
#
#  dimension: is_reopened {
#    label: "Is Reopened"
#    type: string
#    sql: ${TABLE}.Is_Reopened ;;
#  }
#
#
#  dimension: Case_reopened {
#    label: "Case Reopened"
#    type: string
#    sql: case when ${is_reopened}="true" Then "Yes" Else "No" End;;
#  }
#
#  dimension: is_transfer {
#    type: string
#    label: "Is Transfer"
#    sql: ${TABLE}.IsTransfer ;;
#  }
#
#  dimension: total_transfer {
#    type: number
#    label: "Total Transfer"
#    sql:  ${TABLE}.Total_Transfer;;
#    drill_fields: [transferdetail*]
#  }
#
#
#  dimension:group_total_transfer  {
#    type: string
#    label: "Group Total Transfer"
#    sql:  case when   ${TABLE}.Total_Transfer=0 then 'Total Transfers: 0'
#          when   ${TABLE}.Total_Transfer=1 then 'Total Transfers: 01'
#          when   ${TABLE}.Total_Transfer=2 then 'Total Transfers: 02'
#          when   ${TABLE}.Total_Transfer=3 then 'Total Transfers: 03'
#          when   ${TABLE}.Total_Transfer=4 then 'Total Transfers: 04'
#          when   ${TABLE}.Total_Transfer=5 then 'Total Transfers: 05'
#                     when 6<=  ${TABLE}.Total_Transfer and ${TABLE}.Total_Transfer  <=50 then 'Total Transfers: 06-50'
#                     when 51<=  ${TABLE}.Total_Transfer and ${TABLE}.Total_Transfer  <=100 then 'Total Transfers: 51-100'
#                    else 'Total Transfers:100 Above' end
#                     ;;
#  }
#
#
#  measure: Agent {
#    type: number
#    label: "Agent"
#    sql: COUNT(DISTINCT CASE WHEN ((CASE WHEN (CASE WHEN case_owner.FirstName IS NULL THEN case_owner.LastName WHEN case_owner.LastName IS NULL THEN case_owner.FirstName ELSE  concat(case_owner.FirstName," ",case_owner.LastName) END)='Platform Integration User' THEN 'Yes' else 'No' END) = 'No') THEN ${casenumber}  ELSE NULL END)  ;;
#    drill_fields: [drillfields*]
#  }
#
#  measure: DD {
#    type: number
#    label: "D&D"
#    sql:  COUNT(DISTINCT CASE WHEN (((CASE WHEN (CASE WHEN case_owner.FirstName IS NULL THEN case_owner.LastName WHEN case_owner.LastName IS NULL THEN case_owner.FirstName ELSE  concat(case_owner.FirstName," ",case_owner.LastName) END)='Platform Integration User' THEN 'Yes' else 'No' END) = 'Yes')) AND (((CASE
#      WHEN Merged_D_D_Used='true' THEN 'D&D'
#      WHEN LFD_Used='true' THEN 'LFD'
#      WHEN ${Is_Chat_Self_Service} = "true" THEN 'Self-Service'
#      ELSE 'Others'
#      END) = 'D&D')) THEN ${casenumber}  ELSE NULL END) ;;
#    drill_fields: [drillfields*]
#  }
#
#  measure: LFD {
#    type: number
#    label: "LFD"
#    sql: COUNT(DISTINCT CASE WHEN (((CASE WHEN (CASE WHEN case_owner.FirstName IS NULL THEN case_owner.LastName WHEN case_owner.LastName IS NULL THEN case_owner.FirstName ELSE  concat(case_owner.FirstName," ",case_owner.LastName) END)='Platform Integration User' THEN 'Yes' else 'No' END) = 'Yes')) AND (((CASE
#      WHEN Merged_D_D_Used='true' THEN 'D&D'
#      WHEN LFD_Used='true' THEN 'LFD'
#      WHEN ${Is_Chat_Self_Service} = "true" THEN 'Self-Service'
#      ELSE 'Others'
#      END) = 'LFD')) THEN ${casenumber}  ELSE NULL END) ;;
#    drill_fields: [drillfields*]
#  }
#
#  measure: selfservice {
#    type: number
#    label: "Self-Service"
#    sql:  COUNT(DISTINCT CASE WHEN (((CASE WHEN (CASE WHEN case_owner.FirstName IS NULL THEN case_owner.LastName WHEN case_owner.LastName IS NULL THEN case_owner.FirstName ELSE  concat(case_owner.FirstName," ",case_owner.LastName) END)='Platform Integration User' THEN 'Yes' else 'No' END) = 'Yes')) AND (((CASE
#      WHEN Merged_D_D_Used='true' THEN 'D&D'
#      WHEN LFD_Used='true' THEN 'LFD'
#      WHEN ${Is_Chat_Self_Service} = "true" THEN 'Self-Service'
#      ELSE 'Others'
#      END) = 'Self-Service')) THEN ${casenumber}  ELSE NULL END) ;;
#    drill_fields: [drillfields*]
#
#  }
#
#  dimension: intent_key {
#    type: string
#    label: "Intent Key"
#    sql: ${TABLE}.Intent_Key ;;
#  }
#
#  dimension : is_aht_calculated {
#    type: string
#    sql: CASE
#          WHEN ${TABLE}.Is_AHT_Calculated = 'true' THEN 'Yes'
#          WHEN ${TABLE}.Is_AHT_Calculated = 'false' THEN 'No' ELSE NULL END ;;
#    label: "AHT Calculated"
#  }
#
#  dimension: no_reference_reason {
#    label: "No Reference Reason"
#    type: string
#    sql: CASE
#           WHEN ${TABLE}.No_Reference_Reason = 'Not applicable' THEN 'Not applicable'
#           WHEN ${TABLE}.No_Reference_Reason = 'Undetermined from multiple references' THEN 'Undetermined from multiple references'
#           WHEN ${TABLE}.No_Reference_Reason = 'Customer unwilling to provide' THEN 'Customer unwilling to provide'
#           WHEN ${TABLE}.No_Reference_Reason = 'Not yet available' THEN 'Not yet available'
#           ELSE 'None' END ;;
#    drill_fields: [drillfields*]
#
#  }
#
#  #DCN-973/977: including target line
#  dimension: kpi_in_query {
#    type: string
#    sql: CASE WHEN {% if of_case_pdt.AVG_FIRST_RESPONSE_TIME_NEW._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'First Response Time'
#                    WHEN {% if of_case_pdt.Achieved_FRT_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'First Response Time'
#                    WHEN {% if of_case_pdt.AVG_FIRST_CONTACT_RESOLUTION._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'First Contact Resolution'
#                    WHEN {% if of_case_pdt.case_escalation_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'Case Escalation'
#                    WHEN {% if of_case_pdt.average_handling_time._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'Average Handling Time'
#                    WHEN {% if of_case_pdt.Achieved_AHT_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'Average Handling Time'
#                    WHEN {% if of_case_pdt.Abandoned_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'Abandoned Chat Ratio'
#                    WHEN {% if of_case_pdt.customer_satisfaction_ratio_case_chat._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'CSAT'
#                    WHEN {% if of_case_pdt.deflection_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 'Chat + Web Form Usage'
#                    ELSE null END
#          ;;
#  }
#
#  measure: target_for_chat {
#    label: "Chat Target"
#    type: max
#    sql:
#        CASE WHEN ${is_channel_filter} = true
#        THEN (
#              CASE WHEN {% if of_case_pdt.Achieved_FRT_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 0.9
#                   WHEN {% if of_case_pdt.Achieved_AHT_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 0.9
#                   WHEN ${of_service_kpi_target.units} = '%'
#                    THEN ${of_service_kpi_target.kpi_value}/100
#              ELSE ${of_service_kpi_target.kpi_value} END
#             )
#        ELSE NULL END
#        ;;
#    filters: [origin: "Chat"]
#  }
#
#  measure: target_for_web {
#    label: "Web Target"
#    type: max
#    sql:
#        CASE WHEN ${is_channel_filter} = true
#        THEN (
#              CASE WHEN {% if of_case_pdt.Achieved_FRT_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 0.9
#                   WHEN {% if of_case_pdt.Achieved_AHT_ratio._in_query %} 1=1 {% else %} 1=0 {% endif %} THEN 0.9
#                   WHEN ${of_service_kpi_target.units} = '%'
#                    THEN ${of_service_kpi_target.kpi_value}/100
#                ELSE ${of_service_kpi_target.kpi_value} END
#             )
#        ELSE NULL END
#        ;;
#    filters: [origin: "Web"]
#  }
#
#  measure: target_for_ChatWeb_Form_Usage {
#    label: "Chat+Web Form Usage Target"
#    type: max
#    sql:
#
#        CASE WHEN ${of_service_kpi_target.units} = '%'
#        THEN ${of_service_kpi_target.kpi_value}/100
#        ELSE ${of_service_kpi_target.kpi_value} END
#        ;;
#    filters: [origin: "Chat, Web"]
#  }
#
#  dimension: is_channel_filter  {
#    type: yesno
#    hidden: yes
#    sql: {{ of_case_pdt.origin._is_filtered }}  ;;
#  }
#
#  ############## DCN-1004 Target-bar-and-Target-Achievement ##########################
#
#  dimension: Average_Chat_Handling_Time {
#    label: "Avg Chat Handling Time"
#    type: number
#    sql: ${TABLE}.Average_Chat_Handle_Time ;;
#  }
#
#  dimension: HANDLE_TIME_MINS {
#    type: number
#    label: "AHT mins (case/chat)"
#    description: "Identifies Handle time for case & chat"
#    sql: CASE WHEN {% parameter handletime_Param %}= "Case Level"
#                THEN CAST(${TABLE}.Case_Handle_Time_Minutes as float64)
#              WHEN {% parameter handletime_Param %}= "Chat Transcript"
#                THEN CAST(${TABLE}.Average_Chat_Handle_Time as float64)
#          ELSE null
#          END;;
#  }
#
#  measure: Achieved_AHT_ratio {
#    label: "Achieved AHT ratio"
#    type: average
#    sql: CASE WHEN ${HANDLE_TIME_MINS} <= ${of_service_kpi_target.kpi_value}
#                    THEN 1
#              WHEN ${HANDLE_TIME_MINS} > ${of_service_kpi_target.kpi_value}
#                    THEN 0
#                    ELSE NULL
#                    END;;
#    value_format_name: percent_0
#    sql_distinct_key: ${oneforce_id} ;;
#    filters: [origin: "Web,Chat", HANDLE_TIME_MINS: "NOT NULL"]
#    drill_fields: [casenumber,Achieved_AHT_ratio]
#  }
#
#  dimension: Average_Chat_First_Response_Time_Minutes{
#    label: "FRT Chat"
#    type: number
#    sql:  ${TABLE}.Avg_Chat_First_Response_Time_Minutes ;;
#  }
#
#  dimension: FIRST_RESPONSE_TIME_MINS {
#    type: number
#    label: "FRT mins (case/chat)"
#    description: "Identifies First response time for case & chat"
#    sql: CASE WHEN {% parameter responsetime_Param %}= "Case Level"
#                THEN ${TABLE}.First_Response_Time_Minutes
#              WHEN {% parameter responsetime_Param %}= "Chat Transcript"
#                THEN ${TABLE}.Avg_Chat_First_Response_Time_Minutes
#          ELSE null
#          END;;
#  }
#
#  measure: Achieved_FRT_ratio {
#    label: "Achieved FRT ratio"
#    type: average
#    sql: CASE WHEN ${FIRST_RESPONSE_TIME_MINS} <= ${of_service_kpi_target.kpi_value}
#                    THEN 1
#              WHEN ${FIRST_RESPONSE_TIME_MINS} > ${of_service_kpi_target.kpi_value}
#                    THEN 0
#                    ELSE null
#                    END;;
#    value_format_name: percent_0
#    sql_distinct_key: ${oneforce_id} ;;
#    filters: [origin: "Web,Chat", FIRST_RESPONSE_TIME_MINS: "NOT NULL"]
#    drill_fields: [casenumber,Achieved_FRT_ratio]
#  }
############### DCN-1067 Freeze the Chart Format to follow RHQ Selection ##########################
#  dimension: Case_Geo_C_W_Usage {
#    group_label: "Office Hierarchy"
#    label: "Case Geography Chat + WebForm Usage"
#    type: string
#    sql: CASE
#          WHEN {% parameter Geo_Param %} = "RHQ" THEN ${Regional_Head_Office}
#          WHEN {% parameter Geo_Param %} = "Cluster Country" THEN ${case_country}
#          WHEN {% parameter Geo_Param %} = "Individual Country" THEN ${country}
#          WHEN {% parameter Geo_Param %} = "Office" THEN ${office}
#          WHEN {% parameter Geo_Param %} = "Channel" THEN ${Regional_Head_Office}
#          WHEN {% parameter Geo_Param %} = "Segment" THEN ${customer_segment_number}
#          WHEN {% parameter Geo_Param %} = "Segment " THEN ${of_customer_group.key_acct_tp_cd}
#          WHEN {% parameter Geo_Param %} = "Agent Role" THEN ${case_owner.profile_name_service}
#          WHEN {% parameter Geo_Param %} = "Escalation Role" THEN ${Regional_Head_Office}
#          WHEN {% parameter Geo_Param %} = "Office Type" THEN ${Regional_Head_Office}
#          WHEN {% parameter Geo_Param %} = "Service Type" THEN ${Regional_Head_Office}
#          ELSE "Global" END;;
#    drill_fields: [drillfields*]
#  }
#
############### Fields of OF_CHAT_TRANSCRIPT ##########################
#
#  dimension: abandoned {
#    label: "Abandoned After"
#    hidden: yes
#    type: number
#    sql: ${TABLE}.Abandoned ;;
#  }
#
#  dimension: Customer_Abandoned_Chat {
#    label: "Customer Abandoned Chat (true/fales)"
#    description: "Customer chatting BOT and left halfway"
#    type: string
#    sql: ${TABLE}.Customer_Abandoned_Chat ;;
#  }
#
#  dimension: Is_Within_BusinessHour_Chat {
#    type: string
#    sql: CASE WHEN ${TABLE}.Is_Within_BusinessHour_Chat ='true' THEN 'Yes' ELSE 'No' END ;;
#    label: "With In Business Hour"
#  }
#
#  dimension: account_id {
#    label: "Customer Name"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.AccountId ;;
#  }
#
#  dimension: additional_requests {
#    label: "Additional Request"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.Additional_Requests ;;
#  }
#
#  dimension_group: agent_accepted_first_transfer {
#    label: "Agent Accepted First Transfer"
#    hidden: yes
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Agent_Accepted_First_Transfer ;;
#  }
#
#  dimension_group: agent_first_accept_date_time {
#    label: "Agent Accepted First Transfer"
#    hidden: yes
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Agent_First_Accept_Date_Time ;;
#  }
#
#  dimension: Ishandled_by_agent {
#    label: "Is Handled By Agent"
#    type: string
#    sql:  CASE WHEN ${agent_first_accept_date_time_raw} IS NOT NULL OR ${agent_accepted_first_transfer_raw} IS NOT NULL THEN "Yes" ELSE "No" END ;;
#  }
#
#  dimension: chat_handle_time {
#    label: "Chat_Handle_Time (Mins)"
#    hidden: yes
#    type: number
#    sql: ${TABLE}.Chat_Handle_Time ;;
#  }
#
#  dimension: Chat_First_Response_Time_Mins {
#    label: "Chat First Response Time (Mins)"
#    hidden: yes
#    type: number
#    sql: ${TABLE}.Chat_First_Response_Time_Mins ;;
#  }
#
#  dimension: Chat_First_Response_Time_Mins1 {
#    label: "Chat FRT (mins)"
#    hidden: yes
#    type: number
#    sql: ${TABLE}.Chat_First_Response_Time_Mins ;;
#  }
#
#
#  dimension: Chat_First_Response_Time_Mins2 {
#    label: "Chat FRT (if null then zero)"
#    hidden: yes
#    type: number
#    sql: coalesce(${TABLE}.Chat_First_Response_Time_Mins,0) ;;
#  }
#
#  measure: Chat_First_Response_Time_Mins_avg {
#    label: "Avg Chat FRT (mins)"
#    hidden: yes
#    type: average
#    value_format_name: decimal_2
#    filters: [Chat_First_Response_Time_Mins1: ">0"]
#    sql: ${Chat_First_Response_Time_Mins1} ;;
#  }
#
#  measure: average_Chat_First_Response_Time_Mins {
#    label: "Chat Average First Response Time (Mins)"
#    type: average
#    sql: ${Chat_First_Response_Time_Mins};;
#    drill_fields: [detail_1*]
#    value_format_name: decimal_1
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ CLC_by_chat_first_queue_name._link }}"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ CLC_by_contact_name._link }}"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ CLC_by_email._link }}"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ CLC_by_status._link }}"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ CLC_by_chat_duration._link }}"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ CLC_by_chat_case_rating._link }}"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ CLC_by_case_net_promoter_score._link }}"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ CLC_by_intent_l2._link }}"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ CLC_by_intent_l3._link }}"
#    }
#  }
#
#  measure: Chat_without_Agent_Response {
#    label: "Chat without Agent Response"
#    type: count_distinct
#    sql:  ${ct_ONEForce_ID} ;;
#    filters: [Ishandled_by_agent: "Yes", Chat_First_Response_Time_Mins2: "0"]
#    drill_fields: [ct_detail*]
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ CLC_by_chat_first_queue_name._link }}"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ CLC_by_contact_name._link }}"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ CLC_by_email._link }}"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ CLC_by_status._link }}"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ CLC_by_chat_duration._link }}"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ CLC_by_chat_case_rating._link }}"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ CLC_by_case_net_promoter_score._link }}"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ CLC_by_intent_l2._link }}"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ CLC_by_intent_l3._link }}"
#    }
#  }
#
#  dimension: agent_chatting_time_sec {
#    label: "Agent Chatting Time (sec)"
#    hidden: yes
#    type: number
#    sql: ${TABLE}.Agent_Chatting_Time_sec ;;
#  }
#
#  dimension: average_response_time_operator {
#    label: "Agent Response Time"
#    type: number
#    sql: ${TABLE}.AverageResponseTimeOperator ;;
#    value_format_name: decimal_0
#  }
#
#  dimension: response_time_visitor {
#    type: number
#    label: "Visitor Response Time"
#    sql: ${TABLE}.AverageResponseTimeVisitor ;;
#    value_format_name: decimal_0
#  }
#
#  measure: Average_response_time_visitor {
#    type: average
#    sql: ${TABLE}.AverageResponseTimeVisitor ;;
#    label: "Visitor Average Response Time"
#    value_format_name: decimal_1
#    drill_fields: [detail_1*]
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ VART_by_chat_first_queue_name._link }}"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ VART_by_contact_name._link }}"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ VART_by_email._link }}"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ VART_by_status._link }}"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ VART_by_chat_duration._link }}"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ VART_by_case_rating._link }}"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ VART_by_case_net_promoter_score._link }}"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ VART_by_intent_l2._link }}"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ VART_by_intent_l3._link }}"
#    }
#  }
#
#  measure: VART_by_chat_first_queue_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_first_queue_name,Average_response_time_visitor]
#    hidden: yes
#  }
#
#  measure: VART_by_contact_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [contact_name,Average_response_time_visitor]
#    hidden: yes
#  }
#
#  measure: VART_by_email {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [email,Average_response_time_visitor]
#    hidden: yes
#  }
#
#  measure: VART_by_status {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [status,Average_response_time_visitor]
#    hidden: yes
#  }
#
#  measure: VART_by_chat_duration {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_duration,Average_response_time_visitor]
#    hidden: yes
#  }
#
#  measure: VART_by_case_rating {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_rating,Average_response_time_visitor]
#    hidden: yes
#  }
#
#  measure: VART_by_case_net_promoter_score {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_net_promoter_score,Average_response_time_visitor]
#    hidden: yes
#  }
#
#  measure: VART_by_intent_l2 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l2,Average_response_time_visitor]
#    hidden: yes
#  }
#
#  measure: VART_by_intent_l3 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l3,Average_response_time_visitor]
#    hidden: yes
#  }
#
#  measure: response_time_operator {
#    type: average
#    sql: ${TABLE}.AverageResponseTimeOperator ;;
#    label: "Average Agent Response Time"
#    value_format_name: decimal_1
#    drill_fields: [detail_1*]
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ AART_by_chat_first_queue_name._link }}"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ AART_by_contact_name._link }}"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ AART_by_email._link }}"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ AART_by_status._link }}"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ AART_by_chat_duration._link }}"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ AART_by_case_rating._link }}"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ AART_by_case_net_promoter_score._link }}"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ AART_by_intent_l2._link }}"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ AART_by_intent_l3._link }}"
#    }
#  }
#
#  measure: AART_by_chat_first_queue_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_first_queue_name,response_time_operator]
#    hidden: yes
#  }
#
#  measure: AART_by_contact_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [contact_name,response_time_operator]
#    hidden: yes
#  }
#
#  measure: AART_by_email {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [email,response_time_operator]
#    hidden: yes
#  }
#
#  measure: AART_by_status {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [status,response_time_operator]
#    hidden: yes
#  }
#
#  measure: AART_by_chat_duration {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_duration,response_time_operator]
#    hidden: yes
#  }
#
#  measure: AART_by_case_rating {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_rating,response_time_operator]
#    hidden: yes
#  }
#
#  measure: AART_by_case_net_promoter_score {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_net_promoter_score,response_time_operator]
#    hidden: yes
#  }
#
#  measure: AART_by_intent_l2 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l2,response_time_operator]
#    hidden: yes
#  }
#
#  measure: AART_by_intent_l3 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l3,response_time_operator]
#    hidden: yes
#  }
#
#  dimension: body {
#    label: "Body"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.Body ;;
#  }
#
#  dimension: bot_chatting_time_sec {
#    label: "Bot Chatting Time (sec)"
#    hidden: yes
#    type: number
#    sql: ${TABLE}.Bot_Chatting_Time_sec ;;
#  }
#
#  dimension_group: bot_initiated_transfer {
#    label: "Bot Initiated Transfer"
#    hidden: yes
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Bot_Initiated_Transfer ;;
#  }
#
#  dimension_group: bot_transfer_abandoned {
#    label: "Bot Transfer Abandoned"
#    hidden: yes
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.Bot_Transfer_Abandoned ;;
#  }
#
#  dimension: browser {
#    label: "Browser"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.Browser ;;
#  }
#
#  dimension: browser_language {
#    label: "Browser Language"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.BrowserLanguage ;;
#  }
#
#  dimension: calculated_wait_time_sec {
#    label: "Calculated Wait Time (sec)"
#    type: number
#    sql: ${TABLE}.Calculated_Wait_Time_sec ;;
#  }
#
#  dimension: case_id {
#    label: "Case"
#    #hidden: yes
#    type: string
#    sql: ${TABLE}.CaseId ;;
#  }
#
#  dimension: ct_case_number {
#    label: "Case Number"
#    type: number
#    sql: ${TABLE}.ct_Case_Number ;;
#  }
#
#  dimension: chat_case_rating {
#    type: string
#    sql: CASE WHEN ${TABLE}.Chat_Case_Rating IS NULL THEN 'No Rating' ELSE ${TABLE}.Chat_Case_Rating END ;;
#    label: "Chat Case Rating"
#  }
#
#  measure: Customer_chat_satisfaction_ratio {
#    type: average
#    sql: CASE WHEN ${chat_case_rating} = 'Good' THEN 1 ELSE 0 END;;
#    drill_fields: [detail_1*]
#    label: "Customer Chat Satisfaction Ratio"
#    filters: [chat_case_rating:  "-No Rating"]
#    value_format_name: percent_0
#  }
#
#  dimension: ct_case_rating {
#    label: "Case Rating"
#    type: string
#    sql: ${TABLE}.ct_Case_Rating ;;
#  }
#
#  dimension: chat_duration {
#    label: "Chat Duration"
#    #hidden: yes
#    type: number
#    sql: ${TABLE}.ChatDuration ;;
#  }
#
#  dimension: chat_first_queue_name {
#    label: "Chat First Queue Name"
#    type: string
#    #hidden: yes
#    sql: ${TABLE}.Chat_First_Queue_Name ;;
#  }
#
#  dimension: chat_first_queue_name_detail {
#    label: "Chat First Queue Name Detail"
#    type: string
#    sql: ${TABLE}.Chat_First_Queue_Name_Detail ;;
#  }
#
#
#  dimension: chat_key {
#    hidden: yes
#    type: string
#    sql: ${TABLE}.ChatKey ;;
#  }
#
#  dimension: chat_log_additional_recipient {
#    label: "Chat Log Additional Recipient"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.Chat_Log_Additional_Recipient ;;
#  }
#
#  dimension: chat_log_recipient {
#    label: "Chat Log Recipient"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.Chat_Log_Recipient ;;
#  }
#
#  dimension: chat_preferred_language {
#    label: "Chat Preferred Language"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.Chat_Preferred_Language ;;
#  }
#
#  dimension: cms_sso_status {
#    label: "CMS SSO Status"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.CMS_SSO_Status ;;
#  }
#
#  dimension: ct_company_name {
#    label: "Company Name"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.ct_Company_Name ;;
#  }
#
#  dimension: contact_email {
#    label: "Contact_Email"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.Contact_Email ;;
#  }
#
#  dimension: ct_contact_id {
#    label: "Contact Name"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.ct_ContactId ;;
#  }
#
#  dimension: contact_name {
#    label: "Contact_Name"
#    #hidden: yes
#    type: string
#    sql: ${TABLE}.Contact_Name ;;
#  }
#
#  dimension: corporate_office {
#    label: "Corporate Office"
#    type: string
#    sql: ${TABLE}.Corporate_Office ;;
#  }
#
#  dimension: ct_country {
#    label: "Country"
#    type: string
#    #map_layer_name: countries
#    sql: ${TABLE}.ct_Country ;;
#  }
#
#  dimension: ct_created_by_id {
#    label: "Created By"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.ct_CreatedById ;;
#  }
#
#  dimension_group: created {
#    type: time
#    datatype: datetime
#    timeframes: [year, hour_of_day, month, week, week_of_year, month_num, month_name,quarter, date, raw]
#    label: "Created Date"
#    sql: ${TABLE}.ct_CreatedDate ;;
#  }
#
#
## dimension: Date_dynamic {
##   type: string
##   label: "Date Dynamic Chat Transcript"
##   sql:
##    {% if timeframe_picker._parameter_value == 'Day' %} ${created_date}
##    {% elsif timeframe_picker._parameter_value == 'Week' %} ${created_week}
##    {% elsif timeframe_picker._parameter_value == 'Month' %} ${created_month}
##    {% elsif timeframe_picker._parameter_value == 'Quarter' %} ${created_quarter}
##    {% elsif timeframe_picker._parameter_value == 'Year' %} ${created_year}
##    {% else %} null {% endif %} ;;
##   drill_fields: [detail*]
## }
#
#  dimension: Date_dynamic {
#    type: date
#    datatype: datetime
#    label: "Date Dynamic Chat Transcript"
#    sql:
#     {% if timeframe_picker._parameter_value == 'Day' %}   DATETIME_TRUNC(DATETIME(TIMESTAMP(${created_raw}),'{{_query._query_timezone}}'), DAY)
#     {% elsif timeframe_picker._parameter_value == 'Week' %}  DATETIME_TRUNC(DATETIME(TIMESTAMP(${created_raw}),'{{_query._query_timezone}}'), WEEK(MONDAY))
#     {% elsif timeframe_picker._parameter_value == 'Month' %}  DATETIME_TRUNC(DATETIME(TIMESTAMP(${created_raw}),'{{_query._query_timezone}}'),MONTH)
#     {% elsif timeframe_picker._parameter_value == 'Quarter' %}  DATETIME_TRUNC(DATETIME(TIMESTAMP(${created_raw}),'{{_query._query_timezone}}'),QUARTER)
#     {% elsif timeframe_picker._parameter_value == 'Year' %}  DATETIME_TRUNC(DATETIME(TIMESTAMP(${created_raw}),'{{_query._query_timezone}}'),YEAR)
#     {% else %} null {% endif %} ;;
#    convert_tz: no
#  }
#
#  parameter: ct_timeframe_picker {
#    label: "Date Granularity"
#    type: unquoted
#    allowed_value: { value: "Day" }
#    allowed_value: { value: "Week" }
#    allowed_value: { value: "Month" }
#    allowed_value: { value: "Quarter" }
#    allowed_value: { value: "Year" }
#    default_value: "Month"
#  }
#
#  dimension: disable_one_quote {
#    label: "Disable One Quote"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.Disable_One_Quote ;;
#  }
#
#  dimension: ct_e_commerce_user_id {
#    label: "eCommerce UserID"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.ct_eCommerce_UserID ;;
#  }
#
#  dimension: email {
#    label: "Email"
#    #hidden: yes
#    type: string
#    sql: ${TABLE}.Email ;;
#  }
#
#  dimension_group: end {
#    label: "End Time"
#    type: time
#    datatype: datetime
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.EndTime ;;
#  }
#
#  dimension: ended_by {
#    label: "Ended By"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.EndedBy ;;
#  }
#
#  dimension: first_name {
#    label: "First Name"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.First_Name ;;
#  }
#
#  dimension: first_queue_name {
#    label: "First Queue Name"
#    type: string
#    sql: ${TABLE}.First_Queue_Name ;;
#  }
#
#  dimension: first_resolved {
#    label: "First Resolved"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.First_Resolved ;;
#  }
#
#  dimension: ct_has_leave_message {
#    label: "Has Leave Message"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.HasLeaveMessage ;;
#  }
#
#  dimension: intent {
#    label: "intent"
#    type: string
#    sql: ${TABLE}.intent ;;
#  }
#
#  dimension: intent_l1 {
#    label: "Intent_L1"
#    type: string
#    sql: ${TABLE}.Intent_L1 ;;
#  }
#
#  dimension: intent_l2 {
#    label:"Intent_L2"
#    type: string
#    sql: ${TABLE}.Intent_L2 ;;
#  }
#
#  dimension: intent_l3 {
#    label: "Intent_L3"
#    type: string
#    sql: ${TABLE}.Intent_L3 ;;
#  }
#
#  dimension: intent_l4 {
#    label: "Intent_L4"
#    type: string
#    sql: ${TABLE}.Intent_L4 ;;
#  }
#
#  dimension: ip_address {
#    label: "Visitor IP Address"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.IpAddress ;;
#  }
#
#  dimension: is_case_closed {
#    label: "Is Case Closed?"
#    type: string
#    sql: ${TABLE}.Is_Case_Closed ;;
#  }
#
#  dimension: is_chatbot_session {
#    hidden: yes
#    type: string
#    sql: ${TABLE}.IsChatbotSession ;;
#  }
#
#  dimension: ct_is_deleted {
#    hidden: yes
#    type: string
#    sql: ${TABLE}.ct_IsDeleted ;;
#  }
#
#  dimension: ct_is_dummy {
#    hidden: yes
#    type: string
#    sql: ${TABLE}.ct_IsDummy ;;
#  }
#
#  dimension: is_mobile {
#    label: "Is Mobile"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.Is_Mobile ;;
#  }
#
#  dimension: ct_is_need_get_transcript {
#    label: "Is Need Get Transcript"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.ct_Is_Need_Get_Transcript ;;
#  }
#
#  dimension: ct_is_nurtured {
#    label: "Is Nurtured"
#    type: string
#    sql: ${TABLE}.ct_Is_Nurtured ;;
#  }
#
#  dimension: is_queue {
#    label: "Is Queue"
#    type: string
#    sql: ${TABLE}.Is_Queue ;;
#  }
#
#  measure: Queued_Abandonment_Ratio {
#    label: "Queue Abandonement Ratio"
#    type: number
#    sql:  ${Queued_Abandonment_Chats}/(CASE WHEN coalesce(${Queued_Chats},0) = 0 THEN 1 ELSE ${Queued_Chats} END ) ;;
#    drill_fields: [ct_detail*]
#    value_format_name: percent_1
#
#    link: {
#      label: "Show Only {{rendered_value}}"
#      url: "{{ Ratio_Drills._link }}&f[ct_is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ CLC_by_chat_first_queue_name._link }}&f[ct_is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ CLC_by_contact_name._link }}&f[ct_is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ CLC_by_email._link }}&f[ct_is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ CLC_by_status._link }}&f[ct_is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ CLC_by_chat_duration._link }}&f[ct_is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By chat case rating"
#      url: "{{ CLC_by_chat_case_rating._link }}&f[ct_is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ CLC_by_case_net_promoter_score._link }}&f[ct_is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ CLC_by_intent_l2._link }}&f[ct_is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ CLC_by_intent_l3._link }}&f[ct_is_queue]=Abandonment"
#    }
#  }
#
#  measure: customer_left_chat {
#    label: "Customer left chat"
#    description: "Customer queue and left while queuing"
#    type: count_distinct
#    sql: ${ct_ONEForce_ID} ;;
#    #sql: CASE WHEN ${is_queue} ='Abandonment' THEN 1 ELSE 0 END  ;;
#    drill_fields: [ct_detail*]
#    filters: [is_queue: "Abandonment"]
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ CLC_by_chat_first_queue_name._link }}"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ CLC_by_contact_name._link }}"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ CLC_by_email._link }}"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ CLC_by_status._link }}"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ CLC_by_chat_duration._link }}"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ CLC_by_chat_case_rating._link }}"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ CLC_by_case_net_promoter_score._link }}"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ CLC_by_intent_l2._link }}"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ CLC_by_intent_l3._link }}"
#    }
#  }
#
#  measure: Ratio_Drills {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [ct_detail*]
#    hidden: yes
#  }
#
#  measure: CLC_by_chat_first_queue_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_first_queue_name,customer_left_chat]
#    hidden: yes
#  }
#
#  measure: CLC_by_contact_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [contact_name,customer_left_chat]
#    hidden: yes
#  }
#
#  measure: CLC_by_email {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [email,customer_left_chat]
#    hidden: yes
#  }
#
#  measure: CLC_by_status {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [status,customer_left_chat]
#    hidden: yes
#  }
#
#  measure: CLC_by_chat_duration {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_duration,customer_left_chat]
#    hidden: yes
#  }
#
#  measure: CLC_by_chat_case_rating {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_case_rating,customer_left_chat]
#    hidden: yes
#  }
#
#  measure: CLC_by_case_net_promoter_score {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_net_promoter_score,customer_left_chat]
#    hidden: yes
#  }
#
#  measure: CLC_by_intent_l2 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l2,customer_left_chat]
#    hidden: yes
#  }
#
#  measure: CLC_by_intent_l3 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l3,customer_left_chat]
#    hidden: yes
#  }
#
#  measure: chat_resolved_self_service {
#    label: "Chat Resolved by Self Service Function"
#    type: count_distinct
#    sql: ${ct_ONEForce_ID} ;;
#    #sql: CASE WHEN ${of_case.Is_Chat_Self_Service} ='true' THEN 1 ELSE 0 END  ;;
#    filters: [of_case_pdt.Is_Chat_Self_Service: "true"]
#    drill_fields: [ct_detail*]
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ CRSS_by_chat_first_queue_name._link }}"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ CRSS_by_contact_name._link }}"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ CRSS_by_email._link }}"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ CRSS_by_status._link }}"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ CRSS_by_chat_duration._link }}"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ CRSS_by_case_rating._link }}"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ CRSS_by_case_net_promoter_score._link }}"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ CRSS_by_intent_l2._link }}"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ CRSS_by_intent_l3._link }}"
#    }
#  }
#
#  measure: CRSS_by_chat_first_queue_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_first_queue_name,chat_resolved_self_service]
#    hidden: yes
#  }
#
#  measure: CRSS_by_contact_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [contact_name,chat_resolved_self_service]
#    hidden: yes
#  }
#
#  measure: CRSS_by_email {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [email,chat_resolved_self_service]
#    hidden: yes
#  }
#
#  measure: CRSS_by_status {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [status,chat_resolved_self_service]
#    hidden: yes
#  }
#
#  measure: CRSS_by_chat_duration {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_duration,chat_resolved_self_service]
#    hidden: yes
#  }
#
#  measure: CRSS_by_case_rating {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_rating,chat_resolved_self_service]
#    hidden: yes
#  }
#
#  measure: CRSS_by_case_net_promoter_score {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_net_promoter_score,chat_resolved_self_service]
#    hidden: yes
#  }
#
#  measure: CRSS_by_intent_l2 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l2,chat_resolved_self_service]
#    hidden: yes
#  }
#
#  measure: CRSS_by_intent_l3 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l3,chat_resolved_self_service]
#    hidden: yes
#  }
#
#  dimension: janrain_uuid {
#    label: "Janrain UUID"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.Janrain_UUID ;;
#  }
#
#  dimension: ct_language {
#    hidden: yes
#    type: string
#    sql: ${TABLE}.ct_Language ;;
#  }
#
#  dimension: ct_last_modified_by_id {
#    label: "Last Modified By"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.ct_LastModifiedById ;;
#  }
#
#  dimension_group: ct_last_modified {
#    label: "Last Modified Date"
#    hidden: yes
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.ct_LastModifiedDate ;;
#  }
#
#  dimension: last_name {
#    label: "Last Name"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.Last_Name ;;
#  }
#
#  dimension_group: last_referenced {
#    hidden: yes
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.LastReferencedDate ;;
#  }
#
#  dimension_group: last_viewed {
#    hidden: yes
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.LastViewedDate ;;
#  }
#
#  dimension: lead_id {
#    hidden: yes
#    label: "Lead"
#    type: string
#    sql: ${TABLE}.LeadId ;;
#  }
#
#  dimension: lfd_used {
#    label: "LFD Used"
#    type: string
#    sql: ${TABLE}.LFD_Used ;;
#  }
#
#  dimension: live_chat_button_id {
#    label: "Chat Button"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.LiveChatButtonId ;;
#  }
#
#  dimension: live_chat_deployment_id {
#    label: "Deployment"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.LiveChatDeploymentId ;;
#  }
#
#  dimension: live_chat_visitor_id {
#    label: "Chat Visitor"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.LiveChatVisitorId ;;
#  }
#
#  dimension: location {
#    label: "Location"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.Location ;;
#  }
#
#  dimension: max_response_time_operator {
#    label: "Agent Maximum Response Time"
#    hidden: yes
#    type: number
#    sql: ${TABLE}.MaxResponseTimeOperator ;;
#  }
#
#  dimension: max_response_time_visitor {
#    label: "Visitor Maximum Response Time"
#    hidden: yes
#    type: number
#    sql: ${TABLE}.MaxResponseTimeVisitor ;;
#  }
#
#  dimension: merged_d_d_transferred {
#    label: "Merged D&D Transferred"
#    type: string
#    sql: ${TABLE}.Merged_D_D_Transferred ;;
#    hidden: yes
#  }
#
#  dimension: merged_d_d_used {
#    label: "Merged D&D Used"
#    type: string
#    sql: ${TABLE}.Merged_D_D_Used ;;
#  }
#
#  dimension: name {
#    label: "Chat Transcript Name"
#    type: string
#    sql: ${TABLE}.Name ;;
#  }
#
#  measure: name1 {
#    label: "Chat Transcript Name"
#    type: max
#    sql: ${TABLE}.Name ;;
#  }
#
#  measure: name_max {
#    label: "Chat Transcript Name Max"
#    type:string
#    sql: max(${TABLE}.Name) ;;
#  }
#
#  dimension: ct_office {
#    label: "Office"
#    type: string
#    sql: ${TABLE}.ct_Office ;;
#  }
#
#  # dimension: oneforce_id {
#  #   label: "OneForce ID"
#  #   type: string
#  #   sql: ${TABLE}.ONEForce_ID ;;
#  #   primary_key: yes
#  # }
#
#  dimension: operator_message_count {
#    label: "Agent Message Count"
#    hidden: yes
#    type: number
#    sql: ${TABLE}.OperatorMessageCount ;;
#  }
#
#  dimension: ct_origin {
#    label: "Origin"
#    type: string
#    sql: ${TABLE}.ct_Origin ;;
#  }
#
#  dimension: owner_id {
#    label: "Owner"
#    hidden: no
#    type: string
#    sql: ${TABLE}.OwnerId ;;
#  }
#
#  dimension: platform {
#    label: "Platform"
#    type: string
#    sql: ${TABLE}.Platform ;;
#  }
#
#  dimension: queue_wait_time {
#    label: "Queue Wait Time"
#    hidden: yes
#    type: number
#    sql: ${TABLE}.Queue_Wait_Time ;;
#  }
#
#  dimension: ct_reference_number {
#    label: "Reference Number"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.ct_Reference_Number ;;
#  }
#
#  dimension: ct_reference_number_type {
#    label: "Reference Number Type"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.ct_Reference_Number_Type ;;
#  }
#
#  dimension: referrer_uri {
#    label: "Referring Site"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.ReferrerUri ;;
#  }
#
#  dimension_group: request {
#    label: "Request Time"
#    hidden: yes
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.RequestTime ;;
#  }
#
#  dimension: screen_resolution {
#    label: "Screen Resolution"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.ScreenResolution ;;
#  }
#
#  dimension: ct_shipment_number {
#    label: "Shipment Number"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.ct_Shipment_Number ;;
#  }
#
#  dimension: skill_id {
#    label: "Primary Skill"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.SkillId ;;
#  }
#
#  dimension_group: start {
#    label: "Start Time"
#    type: time
#    datatype: datetime
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.StartTime ;;
#  }
#
#  dimension: ct_status {
#    label: "Status"
#    type: string
#    sql: ${TABLE}.Status ;;
#  }
#
#  dimension: supervisor_transcript_body {
#    label: "Supervisor Transcript Body"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.SupervisorTranscriptBody ;;
#  }
#
#  dimension_group: system_modstamp {
#    hidden: yes
#    type: time
#    timeframes: [
#      raw,
#      time,
#      date,
#      week,
#      month,
#      quarter,
#      year
#    ]
#    sql: ${TABLE}.SystemModstamp ;;
#  }
#
#  dimension: transfer_type {
#    label: "TransferType"
#    type: string
#    sql: ${TABLE}.TransferType ;;
#  }
#
#  dimension: transferred_queues {
#    label: "Transferred Queues"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.Transferred_Queues ;;
#  }
#
#  dimension: user_agent {
#    label: "User Agent"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.UserAgent ;;
#  }
#
#  dimension: visitor_message_count {
#    label: "Visitor Message Count"
#    hidden: yes
#    type: number
#    sql: ${TABLE}.VisitorMessageCount ;;
#  }
#
#  dimension: visitor_network {
#    label: "Network"
#    hidden: yes
#    type: string
#    sql: ${TABLE}.VisitorNetwork ;;
#  }
#
#  dimension: wait_time {
#    label: "Wait Time"
#    description: "Wait Time in second"
#    type: number
#    sql: ${TABLE}.WaitTime ;;
#  }
#
#  measure: Average_wait_time {
#    type: average
#    sql: coalesce(${TABLE}.WaitTime,0)+coalesce(${TABLE}.Queue_Wait_Time,0) ;;
#    label: "Customer Waiting Time"
#    description: "Customer Waiting Time in second"
#    value_format_name: decimal_1
#    drill_fields: [detail_1*]
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ CWT_by_chat_first_queue_name._link }}"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ CWT_by_contact_name._link }}"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ CWT_by_email._link }}"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ CWT_by_status._link }}"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ CWT_by_chat_duration._link }}"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ CWT_by_case_rating._link }}"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ CWT_by_case_net_promoter_score._link }}"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ CWT_by_intent_l2._link }}"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ CWT_by_intent_l3._link }}"
#    }
#  }
#
#  measure: CWT_by_chat_first_queue_name {
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_first_queue_name,Average_wait_time]
#    hidden: yes
#  }
#
#  measure: CWT_by_contact_name {
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [contact_name,Average_wait_time]
#    hidden: yes
#  }
#
#  measure: CWT_by_email {
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [email,Average_wait_time]
#    hidden: yes
#  }
#
#  measure: CWT_by_status {
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [status,Average_wait_time]
#    hidden: yes
#  }
#
#  measure: CWT_by_chat_duration {
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_duration,Average_wait_time]
#    hidden: yes
#  }
#
#  measure: CWT_by_case_rating {
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_rating,Average_wait_time]
#    hidden: yes
#  }
#
#  measure: CWT_by_case_net_promoter_score {
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_net_promoter_score,Average_wait_time]
#    hidden: yes
#  }
#
#  measure: CWT_by_intent_l2 {
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l2,Average_wait_time]
#    hidden: yes
#  }
#
#  measure: CWT_by_intent_l3 {
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l3,Average_wait_time]
#    hidden: yes
#  }
#
#  measure: total_chat_handled_by_agents {
#    label: "Total Chat Handled by Agents"
#    type: sum
#    sql: CASE WHEN ${Ishandled_by_agent} = "Yes" THEN 1 ELSE 0 END  ;;
#    drill_fields: [detail_1*]
#
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ count_by_chat_first_queue_name._link }}"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ count_by_contact_name._link }}"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ count_by_email._link }}"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ count_by_status._link }}"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ count_by_chat_duration._link }}"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ count_by_case_rating._link }}"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ count_by_case_net_promoter_score._link }}"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ count_by_intent_l2._link }}"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ count_by_intent_l3._link }}"
#    }
#  }
#
#
#  measure: count_ct {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID} ;;
#    drill_fields: [detail_1*]
#
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ count_by_chat_first_queue_name._link }}"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ count_by_contact_name._link }}"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ count_by_email._link }}"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ count_by_status._link }}"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ count_by_chat_duration._link }}"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ count_by_case_rating._link }}"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ count_by_case_net_promoter_score._link }}"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ count_by_intent_l2._link }}"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ count_by_intent_l3._link }}"
#    }
#  }
#
#  measure: count_by_chat_first_queue_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_first_queue_name,count]
#    hidden: yes
#  }
#
#  measure: count_by_contact_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [contact_name,count]
#    hidden: yes
#  }
#
#  measure: count_by_email {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [email,count]
#    hidden: yes
#  }
#
#  measure: count_by_status {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [status,count]
#    hidden: yes
#  }
#
#  measure: count_by_chat_duration {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_duration,count]
#    hidden: yes
#  }
#
#  measure: count_by_case_rating {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_rating,count]
#    hidden: yes
#  }
#
#  measure: count_by_case_net_promoter_score {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_net_promoter_score,count]
#    hidden: yes
#  }
#
#  measure: count_by_intent_l2 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l2,count]
#    hidden: yes
#  }
#
#  measure: count_by_intent_l3 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l3,count]
#    hidden: yes
#  }
#
#
#  dimension: case_net_promoter_score {
#    label: "Chat Net Promoter Score"
#    type: string
#    sql: ${TABLE}.Case_Net_Promoter_Score ;;
#  }
#
#
#  #dimension: chat_handle_time {
#  #  label: "Chat Handle Time"
#  #  type: string
#  #  sql: ${TABLE}.Chat_Handle_Time ;;
#  #  value_format_name: decimal_1
#  #}
#
#  measure: avg_chat_handle_time {
#    label: "Avg Chat Handle Time (Mins)"
#    type: average
#    sql: ${TABLE}.Chat_Handle_Time ;;
#    filters: [of_case_pdt.origin : "Chat"]
#    drill_fields: [detail_1*]
#    value_format_name: decimal_1
#  }
#
#  measure: chat_handle_time1 {
#    label: "Avg Chat Handle Time (mins)"
#    type: average
#    sql: ${TABLE}.Chat_Handle_Time ;;
#    filters: [of_case_pdt.origin : "Chat"]
#    drill_fields: [detail_1*]
#    value_format_name: decimal_1
#  }
#
#  measure: chat_handle_time_avg {
#    label: "Average Chat Handle Time"
#    type: average
#    sql: ${TABLE}.Chat_Handle_Time ;;
#    filters: [of_case_pdt.origin : "Chat"]
#    drill_fields: [detail_1*]
#    value_format_name: decimal_1
#    filters: [of_case_pdt.is_aht_calculated_excluded: "Yes"]
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ ACHT_by_chat_first_queue_name._link }}"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ ACHT_by_contact_name._link }}"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ ACHT_by_email._link }}"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ ACHT_by_status._link }}"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ ACHT_by_chat_duration._link }}"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ ACHT_by_case_rating._link }}"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ ACHT_by_case_net_promoter_score._link }}"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ ACHT_by_intent_l2._link }}"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ ACHT_by_intent_l3._link }}"
#    }
#  }
#
#  measure: chat_handle_time_avg2 {
#    label: "Average Chat Handle Time (Mins)"
#    type: average
#    sql: ${chat_handle_time} ;;
#    drill_fields: [detail_1*]
#    value_format_name: decimal_1
#    filters: [chat_handle_time: ">0"]
#
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ ACHT_by_chat_first_queue_name._link }}"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ ACHT_by_contact_name._link }}"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ ACHT_by_email._link }}"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ ACHT_by_status._link }}"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ ACHT_by_chat_duration._link }}"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ ACHT_by_case_rating._link }}"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ ACHT_by_case_net_promoter_score._link }}"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ ACHT_by_intent_l2._link }}"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ ACHT_by_intent_l3._link }}"
#    }
#  }
#
#  measure: ACHT_by_chat_first_queue_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_first_queue_name,chat_handle_time_avg]
#    hidden: yes
#  }
#
#  measure: ACHT_by_contact_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [contact_name,chat_handle_time_avg]
#    hidden: yes
#  }
#
#  measure: ACHT_by_email {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [email,chat_handle_time_avg]
#    hidden: yes
#  }
#
#  measure: ACHT_by_status {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [status,chat_handle_time_avg]
#    hidden: yes
#  }
#
#  measure: ACHT_by_chat_duration {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_duration,chat_handle_time_avg]
#    hidden: yes
#  }
#
#  measure: ACHT_by_case_rating {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_rating,chat_handle_time_avg]
#    hidden: yes
#  }
#
#  measure: ACHT_by_case_net_promoter_score {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_net_promoter_score,chat_handle_time_avg]
#    hidden: yes
#  }
#
#  measure: ACHT_by_intent_l2 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l2,chat_handle_time_avg]
#    hidden: yes
#  }
#
#  measure: ACHT_by_intent_l3 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l3,chat_handle_time_avg]
#    hidden: yes
#  }
#
#  measure: ct_owner {
#    type: count_distinct
#    sql: ${ct_owner_name} ;;
#
#  }
#
#  measure: chat_owner {
#    type: count_distinct
#    sql: ${owner_id} ;;
#  }
#
#  measure: chats_per_agent {
#    label: "Chats Per Agent"
#    type: number
#    sql: (${total_chat_handled_by_agents}/${chat_owner}) ;;
#    value_format_name: decimal_2
#    drill_fields: [detail_1*]
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ CPA_by_chat_first_queue_name._link }}"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ CPA_by_contact_name._link }}"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ CPA_by_email._link }}"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ CPA_by_status._link }}"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ CPA_by_chat_duration._link }}"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ CPA_by_case_rating._link }}"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ CPA_by_case_net_promoter_score._link }}"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ CPA_by_intent_l2._link }}"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ CPA_by_intent_l3._link }}"
#    }
#  }
#
#  measure: CPA_by_chat_first_queue_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_first_queue_name,chats_per_agent]
#    hidden: yes
#  }
#
#  measure: CPA_by_contact_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [contact_name,chats_per_agent]
#    hidden: yes
#  }
#
#  measure: CPA_by_email {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [email,chats_per_agent]
#    hidden: yes
#  }
#
#  measure: CPA_by_status {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [status,chats_per_agent]
#    hidden: yes
#  }
#
#  measure: CPA_by_chat_duration {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_duration,chats_per_agent]
#    hidden: yes
#  }
#
#  measure: CPA_by_case_rating {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_rating,chats_per_agent]
#    hidden: yes
#  }
#
#  measure: CPA_by_case_net_promoter_score {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_net_promoter_score,chats_per_agent]
#    hidden: yes
#  }
#
#  measure: CPA_by_intent_l2 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l2,chats_per_agent]
#    hidden: yes
#  }
#
#  measure: CPA_by_intent_l3 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l3,chats_per_agent]
#    hidden: yes
#  }
#
#  measure: days_of_month {
#    type: count_distinct
#    sql: (${created_date}) ;;
#    label: "Days of Month"
#  }
#
#  dimension: Geography_dynamic {
#    type: string
#    label: "Geography Chat Dynamic"
#    drill_fields: [detail_1*]
#    sql: CASE
#          WHEN {% parameter DB_Param %} = "RHQ" THEN ${case_RHQ}
#          WHEN {% parameter DB_Param %} = "Status" THEN ${ct_status}
#          WHEN {% parameter DB_Param %} = "Country" THEN ${ct_country}
#          WHEN {% parameter DB_Param %} = "Office" THEN ${ct_office}
#          WHEN {% parameter DB_Param %} = "Segment " THEN ${of_customer_group.key_acct_tp_cd}
#          ELSE "Global" END;;
#  }
#
#  parameter: DB_Param {
#    type: string
#    label: "Dashboard Parameter"
#
#    allowed_value: {
#      label: "Global"
#      value: "Global"
#    }
#
#    allowed_value: {
#      label: "RHQ"
#      value: "RHQ"
#    }
#
#    allowed_value: {
#      label: "Status"
#      value: "Status"
#    }
#    allowed_value: {
#      label: "Country"
#      value: "Country"
#    }
#    allowed_value: {
#      label: "Office"
#      value: "Office"
#    }
#    allowed_value: {
#      label: "Segment "
#      value: "Segment "
#    }
#  }
#
#  measure: all_rating_chat{
#    type: count_distinct
#    sql: Case WHEN ${chat_case_rating}='Good' OR ${chat_case_rating}='Bad'  THEN 1 ELSE 0 END ;;
#    label:"All Rating Chat"
#  }
#
#  measure: good_rating_chat{
#    type: count_distinct
#    sql: Case WHEN ${chat_case_rating}='Good'  THEN 1 ELSE 0 END ;;
#    label:"Good Rating Chat"
#  }
#
#  measure: difference_rating_chat{
#    type: number
#    sql: (${good_rating_chat}/NULLIF(${all_rating_chat}, 0)) ;;
#    label:"Difference Rating Chat"
#    drill_fields: [detail_1*]
#  }
#
#  dimension: total_chat_transfer {
#    label: "No. of Times Chat is Transferred"
#    type: number
#    sql: ${TABLE}.Total_Chat_Transfer ;;
#  }
#
#  measure: total_abandoned_chat {
#    label: "Total Abandoned Chat"
#    description: "Customer left while either queuing or chatting BOT"
#    type: sum
#    sql: CASE WHEN ${is_queue} ='Abandonment' OR ${Customer_Abandoned_Chat} = 'true' THEN 1 ELSE 0 END  ;;
#    drill_fields: [detail_1*]
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ CLC_by_chat_first_queue_name._link }}"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ CLC_by_contact_name._link }}"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ CLC_by_email._link }}"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ CLC_by_status._link }}"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ CLC_by_chat_duration._link }}"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ CLC_by_chat_case_rating._link }}"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ CLC_by_case_net_promoter_score._link }}"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ CLC_by_intent_l2._link }}"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ CLC_by_intent_l3._link }}"
#    }
#  }
#
#  measure: transferred_chat {
#    label: "Transferred Chat"
#    type: sum
#    sql:  CASE WHEN ${total_chat_transfer} >0 THEN 1 ELSE 0 END ;;
#    drill_fields: [detail_1*]
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ CLC_by_chat_first_queue_name._link }}"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ CLC_by_contact_name._link }}"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ CLC_by_email._link }}"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ CLC_by_status._link }}"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ CLC_by_chat_duration._link }}"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ CLC_by_chat_case_rating._link }}"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ CLC_by_case_net_promoter_score._link }}"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ CLC_by_intent_l2._link }}"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ CLC_by_intent_l3._link }}"
#    }
#  }
#
#  measure: transferred_chat_ratio {
#    label: "Transfer Chat Ratio"
#    type: number
#    sql: (${transferred_chat}/IFNULL(${count},0)) ;;
#    drill_fields: [detail_1*]
#    value_format_name: percent_1
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ CLC_by_chat_first_queue_name._link }}"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ CLC_by_contact_name._link }}"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ CLC_by_email._link }}"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ CLC_by_status._link }}"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ CLC_by_chat_duration._link }}"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ CLC_by_chat_case_rating._link }}"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ CLC_by_case_net_promoter_score._link }}"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ CLC_by_intent_l2._link }}"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ CLC_by_intent_l3._link }}"
#    }
#  }
#
#
#
#  measure: abandone_chat_b4_agent {
#    label: "Abandoned chat before connect agent"
#    type: count_distinct
#    #sql: CASE WHEN ${Customer_Abandoned_Chat} = 'true' THEN 1 ELSE 0 END ;;
#    sql: ${ct_ONEForce_ID} ;;
#    filters: [Customer_Abandoned_Chat: "true"]
#  }
#
#  measure: abandone_chat_b4_agent_ratio {
#    label: "Abandonement before agent Ratio"
#    type: number
#    sql: (${abandone_chat_b4_agent}/IFNULL(${Total_Chats},0)) ;;
#    drill_fields: [ct_detail*]
#    value_format_name: percent_1
#
#    link: {
#      label: "Show Only {{rendered_value}}"
#      url: "{{ Ratio_Drills._link }}&f[Customer_Abandoned_Chat]=true"
#    }
#
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ CLC_by_chat_first_queue_name._link }}&f[Customer_Abandoned_Chat]=true"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ CLC_by_contact_name._link }}&f[Customer_Abandoned_Chat]=true"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ CLC_by_email._link }}&f[Customer_Abandoned_Chat]=true"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ CLC_by_status._link }}&f[Customer_Abandoned_Chat]=true"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ CLC_by_chat_duration._link }}&f[Customer_Abandoned_Chat]=true"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ CLC_by_chat_case_rating._link }}&f[Customer_Abandoned_Chat]=true"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ CLC_by_case_net_promoter_score._link }}&f[Customer_Abandoned_Chat]=true"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ CLC_by_intent_l2._link }}&f[Customer_Abandoned_Chat]=true"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ CLC_by_intent_l3._link }}&f[Customer_Abandoned_Chat]=true"
#    }
#  }
#
#
#  measure: Queued_Abandonment_Chats  {
#    label: "Queued_Abandonment_Chats"
#    type: count_distinct
#    #sql: CASE WHEN ${is_queue} in ('Abandonment') THEN 1 ELSE 0 END  ;;
#    sql: ${ct_ONEForce_ID} ;;
#    filters: [is_queue: "Abandonment"]
#  }
#
#  measure: Queued_Chats  {
#    label: "Queued_Chats"
#    type: count_distinct
#    #sql: CASE WHEN ${is_queue} in ('Abandonment','Queue') THEN 1 ELSE 0 END  ;;
#    sql: ${ct_ONEForce_ID} ;;
#    filters: [is_queue: "Abandonment,Queue"]
#  }
#
#
#  measure: Total_Chats  {
#    label: "Total_Chats"
#    type: count_distinct
#    sql: ${ct_ONEForce_ID} ;;
#  }
#
#  measure: total_queued_chats {
#    label: "Total Queued Chats"
#    type: number
#    sql: (${Queued_Chats}/${Total_Chats}) ;;
#    drill_fields: [ct_detail*]
#    value_format_name: percent_1
#
#    link: {
#      label: "Show Only {{rendered_value}}"
#      url: "{{ Ratio_Drills._link }}&f[ct_is_queue]=Abandonment,Queue"
#    }
#
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ TQC_by_chat_first_queue_name._link }}&f[ct_is_queue]=Abandonment,Queue"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ TQC_by_contact_name._link }}&f[ct_is_queue]=Abandonment,Queue"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ TQC_by_email._link }}&f[ct_is_queue]=Abandonment,Queue"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ TQC_by_status._link }}&f[ct_is_queue]=Abandonment,Queue"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ TQC_by_chat_duration._link }}&f[ct_is_queue]=Abandonment,Queue"
#    }
#
#    link: {
#      label: "By case_rating"
#      url: "{{ TQC_by_case_rating._link }}&f[ct_is_queue]=Abandonment,Queue"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ TQC_by_case_net_promoter_score._link }}&f[ct_is_queue]=Abandonment,Queue"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ TQC_by_intent_l2._link }}&f[ct_is_queue]=Abandonment,Queue"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ TQC_by_intent_l3._link }}&f[ct_is_queue]=Abandonment,Queue"
#    }
#  }
#
#  measure: TQC_by_chat_first_queue_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_first_queue_name,total_queued_chats]
#    hidden: yes
#  }
#
#  measure: TQC_by_contact_name {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [contact_name,total_queued_chats]
#    hidden: yes
#  }
#
#  measure: TQC_by_email {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [email,total_queued_chats]
#    hidden: yes
#  }
#
#  measure: TQC_by_status {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [status,total_queued_chats]
#    hidden: yes
#  }
#
#  measure: TQC_by_chat_duration {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [chat_duration,total_queued_chats]
#    hidden: yes
#  }
#
#  measure: TQC_by_case_rating {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_rating,total_queued_chats]
#    hidden: yes
#  }
#
#  measure: TQC_by_case_net_promoter_score {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [case_net_promoter_score,total_queued_chats]
#    hidden: yes
#  }
#
#  measure: TQC_by_intent_l2 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l2,total_queued_chats]
#    hidden: yes
#  }
#
#  measure: TQC_by_intent_l3 {
#    type: count_distinct
#    sql: ${ct_ONEForce_ID};;
#    drill_fields: [intent_l3,total_queued_chats]
#    hidden: yes
#  }
#
#  dimension:chat_nps_group {
#    type: string
#    sql: (CASE
#          WHEN ${TABLE}.Chat_Case_Net_Promoter_Score<7 THEN 'Detractors'
#          WHEN ${TABLE}.Chat_Case_Net_Promoter_Score>=7 and ${TABLE}.Chat_Case_Net_Promoter_Score<9 THEN 'Passives'
#          WHEN ${TABLE}.Chat_Case_Net_Promoter_Score>=9 THEN 'Promoters'
#          ELSE 'No Rating' END);;
#    label:"Chat NPS Segment"
#
#  }
#
#  dimension: chat_case_net_promoter_score{
#    type: string
#    sql: ${TABLE}.Chat_Case_Net_Promoter_Score;;
#    label: "Chat Net Promotor Score"
#  }
#
#  measure: ct_detractor_percentage{
#    type: average
#    sql: Case WHEN ${chat_nps_group}='Detractors' THEN 1 ELSE 0 END ;;
#    label:"Detractor Percentage"
#    filters: [chat_nps_group: "-No Rating"]
#    value_format_name: percent_0
#    #hidden: yes
#  }
#
#  measure: ct_promoter_percentage{
#    type: average
#    sql: Case WHEN ${chat_nps_group}='Promoters' THEN 1 ELSE 0 END ;;
#    label:"Promoters Percentage"
#    value_format_name: percent_0
#    filters: [chat_nps_group: "-No Rating"]
#    #hidden: yes
#  }
#
#
#  measure: chat_global_nps{
#    type: number
#    sql: (${promoter_percentage} - ${detractor_percentage}) *100 ;;
#    label:"Chat Global NPS"
#    value_format_name: decimal_0
#    drill_fields: [detail_1*]
#  }
#
#
#
#  # ----- Sets of fields for drilling ------
#  set: detail_1{
#    fields: [
#      name,
#      casenumber,
#      ct_owner_name,
#      of_user.name,
#      chat_first_queue_name,
#      intent_l2,
#      intent_l3,
#      ct_customer.name,
#      contact_name,
#      email,
#      status,
#      chat_duration,
#      start_time,
#      end_time,
#      chat_handle_time,
#      Chat_First_Response_Time_Mins,
#      average_response_time_operator,
#      response_time_visitor,
#      chat_case_rating,
#      case_net_promoter_score,
#    ]
#  }
#
#  # ----- Sets of fields for drilling ------
#  set: ct_detail {
#    fields: [
#      name,
#      casenumber,
#      ct_owner_name,
#      name,
#      of_user.name,
#      chat_first_queue_name,
#      intent_l2,
#      intent_l3,
#      ct_customer.name,
#      contact_name,
#      email,
#      status,
#      chat_duration,
#      start_time,
#      end_time,
#      chat_handle_time,
#      Chat_First_Response_Time_Mins,
#      average_response_time_operator,
#      response_time_visitor,
#      chat_case_rating,
#      case_net_promoter_score,
#      is_queue,
#      Customer_Abandoned_Chat
#    ]
#  }
#
#}
#

view: of_case_statistics {

  derived_table: {
    sql:
      SELECT CASEID,
      DATETIME(R_date||' ' ||EndTime) AS Split_LocalTime,
      timestamp(DATETIME(R_date||' ' ||EndTime),TimeZoneSidKey) AS Split_UTC
        from
        (
          SELECT C.ONEForce_Id AS CASEID,C.CaseNumber,C.CreatedDate_Local,C.ClosedDate_Local,R_date,TimeZoneSidKey,
              CASE
                  WHEN R_Day = 1 THEN SundayEndTime
                  WHEN R_Day = 2 THEN MondayEndTime
                  WHEN R_Day = 3 THEN TuesdayEndTime
                  WHEN R_Day = 4 THEN WednesdayEndTime
                  WHEN R_Day = 5 THEN ThursdayEndTime
                  WHEN R_Day = 6 THEN FridayEndTime
                  WHEN R_Day = 7 THEN SaturdayEndTime
              END as EndTime
              FROM
              (
                  SELECT C.ONEForce_Id, C.CaseNumber,
                  DATETIME( TIMESTAMP(C.CreatedDate,"UTC"), BH.TimeZoneSidKey) CreatedDate_Local,
                  DATETIME( TIMESTAMP(coalesce( C.ClosedDate,CURRENT_DATE() ),"UTC"), BH.TimeZoneSidKey) ClosedDate_Local,BH.TimeZoneSidKey,
                  SundayStartTime,MondayStartTime,TuesdayStartTime,WednesdayStartTime,ThursdayStartTime,FridayStartTime,SaturdayStartTime,
                  SundayEndTime,MondayEndTime,TuesdayEndTime,WednesdayEndTime,ThursdayEndTime,FridayEndTime,SaturdayEndTime
                  FROM ${of_case.SQL_TABLE_NAME} C
                  JOIN ${of_business_hours.SQL_TABLE_NAME} BH ON BH.ONEForce_Id=C.BusinessHoursId
              ) AS C
              LEFT JOIN
              (
                SELECT R_date,EXTRACT(DAYOFWEEK FROM R_date) R_Day
                FROM UNNEST(
                  GENERATE_DATE_ARRAY(DATE('2020-01-01'), CURRENT_DATE()-1, INTERVAL 1 DAY)) AS R_date
              ) D ON R_date >= DATE(C.CreatedDate_Local) AND R_date <= DATE(C.ClosedDate_Local)
        )T
      WHERE  EndTime is not null
    ;;
  }

  dimension: case_id {
    hidden: yes
    type: string
    sql: ${TABLE}.CASEID;;
  }

  dimension_group: split_localtime {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Split_LocalTime;;
    label:"Split LocalTime"
    drill_fields: [drillfields*]
  }

  dimension_group: split_utc {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Split_UTC;;
    label:"Split UTC"
  }

  set: drillfields {
    fields: [
      of_case.Regional_Head_Office,
      of_case.case_country,
      of_case.case_office_code,
      of_case.origin,
      of_case.sub_category_l2,
      of_case.subordinate_category_l3,
      of_customer_group.cust_grp_and_name,
      of_customer.customer_cd_and_name,
      of_case_history_owner.owner_name,
      of_case.priority,
      of_case.case_age_group,
      of_case_history_status.status,
    ]
  }
}

view: of_case_transfer_history {
  sql_table_name: `ONEFORCE.OF_CASE_TRANSFER_HISTORY`
    ;;

  dimension: agent_work {
    type: string
    sql: ${TABLE}.Agent_Work ;;
  }

  dimension: case {
    type: string
    sql: ${TABLE}.`Case` ;;
  }

  dimension: created_by_id {
    type: string
    sql: ${TABLE}.CreatedById ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.CreatedDate ;;
  }

  dimension: is_deleted {
    type: string
    sql: ${TABLE}.IsDeleted ;;
  }

  dimension: is_open_case_for_not_transfer_selected {
    type: string
    sql: ${TABLE}.Is_open_case_for_not_transfer_selected ;;
  }

  dimension: last_modified_by_id {
    type: string
    sql: ${TABLE}.LastModifiedById ;;
  }

  dimension_group: last_modified {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.LastModifiedDate ;;
  }

  dimension_group: last_transfer_date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.Last_Transfer_Date_Time ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.Name ;;
  }

  dimension: oneforce_id {
    type: string
    sql: ${TABLE}.ONEForce_ID ;;
    primary_key: yes
  }

  dimension_group: system_modstamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.SystemModstamp ;;
  }

  dimension: transfer_by {
    type: string
    sql: ${TABLE}.Transfer_By ;;
  }

  dimension_group: transfer_date_time {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.Transfer_Date_Time ;;
  }

  dimension: transfer_duration_in_minutes {
    type: number
    sql: ${TABLE}.Transfer_Duration_In_Minutes ;;
  }

  dimension: transfer_from {
    type: string
    sql: ${TABLE}.Transfer_From ;;
  }

  dimension: transfer_from_queue {
    type: string
    sql: ${TABLE}.Transfer_From_Queue ;;
  }

  dimension: transfer_from_queue_id {
    type: string
    sql: ${TABLE}.Transfer_From_Queue_ID ;;
  }

  dimension: transfer_from_user {
    type: string
    sql: ${TABLE}.Transfer_From_User ;;
  }

  dimension: transfer_reason {
    type: string
    sql: ${TABLE}.Transfer_Reason ;;
  }

  dimension: transfer_to {
    type: string
    sql: ${TABLE}.Transfer_To ;;
  }

  dimension: transfer_to_queue {
    type: string
    sql: ${TABLE}.Transfer_To_Queue ;;
  }

  dimension: transfer_to_queue_id {
    type: string
    sql: ${TABLE}.Transfer_To_Queue_ID ;;
  }

  dimension: transfer_to_user {
    type: string
    sql: ${TABLE}.Transfer_To_User ;;
  }

  dimension: transfer_type {
    type: string
    sql: ${TABLE}.Transfer_Type ;;
  }

  dimension: transferred_by_me {
    type: string
    sql: ${TABLE}.Transferred_By_Me ;;
  }

  measure: count {
    type: sum
    drill_fields: [name]
  }

  measure: total_transfer{
    type: sum
    sql: (CASE WHEN ${TABLE}.Transfer_Type ="Assignment" or ${TABLE}.Transfer_Type ="Accept/Transfer Chat"  THEN 1 ELSE 0 END) ;;
    label:"Total Transfer history"
    drill_fields: [transferdetail*]
  }

  measure: avg_transfer_duration_in_minutes {
    type: average
    sql: ${TABLE}.Transfer_Duration_In_Minutes ;;
    label: "Avg Transfer Duration "
    value_format_name: decimal_1
    drill_fields: [transferdetail*]
  }

  dimension: transfer_by_name1 {
    type: string
    sql: ${transfer_by_owner.name} ;;
  }

  dimension: transfer_by_queue {
    type: string
    sql: ${transfer_by_queue.developer_name} ;;
  }

  dimension: transfer_by_name {
    type: string
    sql: case when ${transfer_by_name1} is not null then ${transfer_by_name1} else ${transfer_by_queue} end  ;;
  }

  dimension: transfer_from_name1 {
    type: string
    sql: ${transfer_from_owner.name} ;;
  }

  dimension: transfer_from_queue_name {
    type: string
    sql: ${transfer_from_queue.developer_name} ;;
  }

  dimension: transfer_from_name {
    type: string
    sql: case when ${transfer_from_name1} is not null then ${transfer_from_name1} else ${transfer_from_queue_name} end  ;;
  }

  dimension: transfer_to_name1 {
    type: string
    sql: ${transfer_to.name} ;;
  }

  dimension: transfer_to_queue_name {
    type: string
    sql: ${transfer_to_queue.developer_name} ;;
  }

  dimension: transfer_to_name {
    type: string
    sql: case when ${transfer_to_name1} is not null then ${transfer_to_name1} else ${transfer_to_queue_name} end  ;;
  }

  #measure: case_recipient{
  #type: sum
  #sql: (CASE WHEN ${transfer_queue.ownedbyQueue}="Yes" and ${TABLE}.Transfer_Type ="System Assignment" and ${TABLE}.Transfer_Type ="Accept/Transfer Chat"and ${TABLE}.Transfer_Type ="Assignment"  THEN 1 ELSE 0 END) ;;
  #label:"Case Recipient"
  #drill_fields: [transferdetail*]
  #}


  set: transferdetail {
    fields: [
      of_case.casenumber,
      service_office_hierarchy.country,
      case_owner.officetype,
      of_case.case_owner_name,
      case_transfer_history.transfer_by_name,
      case_transfer_history.transfer_from_name,
      case_transfer_history.transfer_to_name,
      case_transfer_history.transfer_type,
      case_transfer_history.last_transfer_date_time,
      case_transfer_history.transfer_duration_in_minutes,
      case_transfer_history.transfer_reason,
      of_customer.name,
      of_contact.name,
      of_case.contactemail,
      of_case.status,
      of_case.origin,
      of_case.type,
      of_case.reason,
      of_case.sub_category_l2,
      of_case.subordinate_category_l3,
    ]
  }

}

view: of_cgm_target {
  sql_table_name: `ONEFORCE.OF_CGM_TARGET`
    ;;

  dimension: record_id {
    label: "Record Id"  # programmatically added by LookML modifier
    primary_key: yes
    type: string
    sql: ${TABLE}.Record_Id ;;
  }

  dimension: cm_amount {
    label: "CM Amount"  # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.CM_Amount ;;
  }

  dimension: contract_office_code {
    label: "Contract Office Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Contract_Office_Code ;;
  }

  dimension: contract_office_rhq_code {
    label: "Contract Office RHQ Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Contract_Office_RHQ_Code ;;
  }

  dimension: dom_non_dom_flag {
    label: "Dom-NonDom Flag"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Dom_NonDom_Flag ;;
  }

  dimension: por_country_code {
    label: "POR Country Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.POR_Country_Code ;;
  }

  dimension: por_rhq_code {
    label: "POR RHQ Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.POR_RHQ_Code ;;
  }

  dimension: revenue_amount {
    label: "Revenue Amount" # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.Revenue_Amount ;;
  }

  dimension: revenue_lane {
    label: "Revenue Lane" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Revenue_Lane ;;
  }

  dimension: sales_month {
    hidden: yes
    label: "Sales Month"  # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.Sales_Month ;;
  }

  dimension: sales_week {
    hidden: yes
    label: "Sale Week"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Sales_Week ;;
  }

  dimension: service_scope_group {
    label: "Service Scope Group"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Service_Scope_Group ;;
  }

  dimension: teu {
    label: "TEU"  # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.TEU ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }

  set: primary_key {
    fields: [record_id, count]
  }
}

view: of_chat_transcript {
  sql_table_name: `ONEFORCE.OF_CHAT_TRANSCRIPT`
    ;;

  dimension: abandoned {
    label: "Abandoned After"
    hidden: yes
    type: number
    sql: ${TABLE}.Abandoned ;;
  }

  dimension: Customer_Abandoned_Chat {
    label: "Customer Abandoned Chat (true/fales)"
    description: "Customer chatting BOT and left halfway"
    type: string
    sql: ${TABLE}.Customer_Abandoned_Chat ;;
  }

  dimension: isWithInBusinessHour {
    type: string
    sql: CASE WHEN ${TABLE}.Is_Within_BusinessHour_Chat ='true' THEN 'Yes' ELSE 'No' END ;;
    label: "With In Business Hour"
  }

  dimension: account_id {
    label: "Customer Name"
    hidden: yes
    type: string
    sql: ${TABLE}.AccountId ;;
  }

  dimension: additional_requests {
    label: "Additional Request"
    hidden: yes
    type: string
    sql: ${TABLE}.Additional_Requests ;;
  }

  dimension_group: agent_accepted_first_transfer {
    label: "Agent Accepted First Transfer"
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Agent_Accepted_First_Transfer ;;
  }

  dimension_group: agent_first_accept_date_time {
    label: "Agent Accepted First Transfer"
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Agent_First_Accept_Date_Time ;;
  }

  dimension: Ishandled_by_agent {
    label: "Is Handled By Agent"
    type: string
    sql:  CASE WHEN ${agent_first_accept_date_time_raw} IS NOT NULL OR ${agent_accepted_first_transfer_raw} IS NOT NULL THEN "Yes" ELSE "No" END ;;
  }

  dimension: chat_handle_time {
    label: "Chat_Handle_Time (Mins)"
    hidden: yes
    type: number
    sql: ${TABLE}.Chat_Handle_Time ;;
  }

  dimension: Chat_First_Response_Time_Mins {
    label: "Chat First Response Time (Mins)"
    hidden: yes
    type: number
    sql: ${TABLE}.Chat_First_Response_Time_Mins ;;
  }

  dimension: Chat_First_Response_Time_Mins1 {
    label: "Chat FRT (mins)"
    hidden: yes
    type: number
    sql: ${TABLE}.Chat_First_Response_Time_Mins ;;
  }


  dimension: Chat_First_Response_Time_Mins2 {
    label: "Chat FRT (if null then zero)"
    hidden: yes
    type: number
    sql: coalesce(${TABLE}.Chat_First_Response_Time_Mins,0) ;;
  }

  measure: Chat_First_Response_Time_Mins_avg {
    label: "Avg Chat FRT (mins)"
    hidden: yes
    type: average
    value_format_name: decimal_2
    filters: [Chat_First_Response_Time_Mins1: ">0"]
    sql: ${Chat_First_Response_Time_Mins1} ;;
  }

  measure: average_Chat_First_Response_Time_Mins {
    label: "Chat Average First Response Time (Mins)"
    type: average
    sql: ${Chat_First_Response_Time_Mins};;
    drill_fields: [detail*]
    value_format_name: decimal_1
    link: {
      label: "By chat_first_queue_name"
      url: "{{ CLC_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ CLC_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ CLC_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ CLC_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ CLC_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ CLC_by_chat_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ CLC_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ CLC_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ CLC_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ CLC_by_chat_transcript_owner._link }}"
    }
  }

  measure: Chat_without_Agent_Response {
    label: "Chat without Agent Response"
    type: count_distinct
    sql:  ${oneforce_id} ;;
    filters: [Ishandled_by_agent: "Yes", Chat_First_Response_Time_Mins1: "NULL"]
    drill_fields: [ct_detail*]
    link: {
      label: "By chat_first_queue_name"
      url: "{{ CLC_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ CLC_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ CLC_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ CLC_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ CLC_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ CLC_by_chat_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ CLC_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ CLC_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ CLC_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ CLC_by_chat_transcript_owner._link }}"
    }
  }

  dimension: agent_chatting_time_sec {
    label: "Agent Chatting Time (sec)"
    hidden: yes
    type: number
    sql: ${TABLE}.Agent_Chatting_Time_sec ;;
  }

  dimension: average_response_time_operator {
    label: "Agent Response Time"
    type: number
    sql: ${TABLE}.AverageResponseTimeOperator ;;
    value_format_name: decimal_0
  }

  dimension: response_time_visitor {
    type: number
    label: "Visitor Response Time"
    sql: ${TABLE}.AverageResponseTimeVisitor ;;
    value_format_name: decimal_0
  }

  measure: Average_response_time_visitor {
    type: average
    sql: ${TABLE}.AverageResponseTimeVisitor ;;
    label: "Visitor Average Response Time"
    value_format_name: decimal_1
    drill_fields: [detail*]
    link: {
      label: "By chat_first_queue_name"
      url: "{{ VART_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ VART_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ VART_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ VART_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ VART_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ VART_by_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ VART_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ VART_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ VART_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ VART_by_chat_transcript_owner._link }}"
    }
  }

  measure: VART_by_chat_first_queue_name {
    type: count
    drill_fields: [chat_first_queue_name,Average_response_time_visitor]
    hidden: yes
  }

  measure: VART_by_contact_name {
    type: count
    drill_fields: [contact_name,Average_response_time_visitor]
    hidden: yes
  }

  measure: VART_by_email {
    type: count
    drill_fields: [email,Average_response_time_visitor]
    hidden: yes
  }

  measure: VART_by_status {
    type: count
    drill_fields: [status,Average_response_time_visitor]
    hidden: yes
  }

  measure: VART_by_chat_duration {
    type: count
    drill_fields: [chat_duration,Average_response_time_visitor]
    hidden: yes
  }

  measure: VART_by_case_rating {
    type: count
    drill_fields: [case_rating,Average_response_time_visitor]
    hidden: yes
  }

  measure: VART_by_case_net_promoter_score {
    type: count
    drill_fields: [case_net_promoter_score,Average_response_time_visitor]
    hidden: yes
  }

  measure: VART_by_intent_l2 {
    type: count
    drill_fields: [intent_l2,Average_response_time_visitor]
    hidden: yes
  }

  measure: VART_by_intent_l3 {
    type: count
    drill_fields: [intent_l3,Average_response_time_visitor]
    hidden: yes
  }

  measure: VART_by_chat_transcript_owner {
    type: count
    drill_fields: [ct_owner.name,Average_response_time_visitor]
    hidden: yes
  }

  measure: response_time_operator {
    type: average
    sql: ${TABLE}.AverageResponseTimeOperator ;;
    label: "Average Agent Response Time"
    value_format_name: decimal_1
    drill_fields: [detail*]
    link: {
      label: "By chat_first_queue_name"
      url: "{{ AART_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ AART_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ AART_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ AART_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ AART_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ AART_by_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ AART_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ AART_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ AART_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ AART_by_chat_transcript_owner._link }}"
    }
  }

  measure: AART_by_chat_first_queue_name {
    type: count
    drill_fields: [chat_first_queue_name,response_time_operator]
    hidden: yes
  }

  measure: AART_by_contact_name {
    type: count
    drill_fields: [contact_name,response_time_operator]
    hidden: yes
  }

  measure: AART_by_email {
    type: count
    drill_fields: [email,response_time_operator]
    hidden: yes
  }

  measure: AART_by_status {
    type: count
    drill_fields: [status,response_time_operator]
    hidden: yes
  }

  measure: AART_by_chat_duration {
    type: count
    drill_fields: [chat_duration,response_time_operator]
    hidden: yes
  }

  measure: AART_by_case_rating {
    type: count
    drill_fields: [case_rating,response_time_operator]
    hidden: yes
  }

  measure: AART_by_case_net_promoter_score {
    type: count
    drill_fields: [case_net_promoter_score,response_time_operator]
    hidden: yes
  }

  measure: AART_by_intent_l2 {
    type: count
    drill_fields: [intent_l2,response_time_operator]
    hidden: yes
  }

  measure: AART_by_intent_l3 {
    type: count
    drill_fields: [intent_l3,response_time_operator]
    hidden: yes
  }

  measure: AART_by_chat_transcript_owner {
    type: count
    drill_fields: [ct_owner.name,response_time_operator]
    hidden: yes
  }

  dimension: body {
    label: "Body"
    hidden: yes
    type: string
    sql: ${TABLE}.Body ;;
  }

  dimension: bot_chatting_time_sec {
    label: "Bot Chatting Time (sec)"
    hidden: yes
    type: number
    sql: ${TABLE}.Bot_Chatting_Time_sec ;;
  }

  dimension_group: bot_initiated_transfer {
    label: "Bot Initiated Transfer"
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Bot_Initiated_Transfer ;;
  }

  dimension_group: bot_transfer_abandoned {
    label: "Bot Transfer Abandoned"
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Bot_Transfer_Abandoned ;;
  }

  dimension: browser {
    label: "Browser"
    hidden: yes
    type: string
    sql: ${TABLE}.Browser ;;
  }

  dimension: browser_language {
    label: "Browser Language"
    hidden: yes
    type: string
    sql: ${TABLE}.BrowserLanguage ;;
  }

  dimension: calculated_wait_time_sec {
    label: "Calculated Wait Time (sec)"
    type: number
    sql: ${TABLE}.Calculated_Wait_Time_sec ;;
  }

  dimension: case_id {
    label: "Case"
    #hidden: yes
    type: string
    sql: ${TABLE}.CaseId ;;
  }

  dimension: case_number {
    label: "Case Number"
    type: number
    sql: ${TABLE}.Case_Number ;;
  }

  dimension: chat_case_rating {
    type: string
    sql: CASE WHEN ${TABLE}.Chat_Case_Rating IS NULL THEN 'No Rating' ELSE ${TABLE}.Chat_Case_Rating END ;;
    label: "Chat Case Rating"
  }

  measure: Customer_chat_satisfaction_ratio {
    type: average
    sql: CASE WHEN ${chat_case_rating} = 'Good' THEN 1 ELSE 0 END;;
    drill_fields: [detail*]
    label: "Customer Chat Satisfaction Ratio"
    filters: [chat_case_rating:  "-No Rating"]
    value_format_name: percent_0
  }

  dimension: case_rating {
    label: "Case Rating"
    type: string
    sql: ${TABLE}.Case_Rating ;;
  }

  dimension: chat_duration {
    label: "Chat Duration"
    #hidden: yes
    type: number
    sql: ${TABLE}.ChatDuration ;;
  }

  dimension: chat_first_queue_name {
    label: "Chat First Queue Name"
    type: string
    #hidden: yes
    sql: ${TABLE}.Chat_First_Queue_Name ;;
  }

  dimension: chat_first_queue_name_detail {
    label: "Chat First Queue Name Detail"
    type: string
    sql: ${TABLE}.Chat_First_Queue_Name_Detail ;;
  }


  dimension: chat_key {
    hidden: yes
    type: string
    sql: ${TABLE}.ChatKey ;;
  }

  dimension: chat_log_additional_recipient {
    label: "Chat Log Additional Recipient"
    hidden: yes
    type: string
    sql: ${TABLE}.Chat_Log_Additional_Recipient ;;
  }

  dimension: chat_log_recipient {
    label: "Chat Log Recipient"
    hidden: yes
    type: string
    sql: ${TABLE}.Chat_Log_Recipient ;;
  }

  dimension: chat_preferred_language {
    label: "Chat Preferred Language"
    hidden: yes
    type: string
    sql: ${TABLE}.Chat_Preferred_Language ;;
  }

  dimension: cms_sso_status {
    label: "CMS SSO Status"
    hidden: yes
    type: string
    sql: ${TABLE}.CMS_SSO_Status ;;
  }

  dimension: company_name {
    label: "Company Name"
    hidden: yes
    type: string
    sql: ${TABLE}.Company_Name ;;
  }

  dimension: contact_email {
    label: "Contact_Email"
    hidden: yes
    type: string
    sql: ${TABLE}.Contact_Email ;;
  }

  dimension: contact_id {
    label: "Contact Name"
    hidden: yes
    type: string
    sql: ${TABLE}.ContactId ;;
  }

  dimension: contact_name {
    label: "Contact_Name"
    #hidden: yes
    type: string
    sql: ${TABLE}.Contact_Name ;;
  }

  dimension: corporate_office {
    label: "Corporate Office"
    type: string
    sql: ${TABLE}.Corporate_Office ;;
  }

  dimension: country {
    label: "Country"
    type: string
    #map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: created_by_id {
    label: "Created By"
    hidden: yes
    type: string
    sql: ${TABLE}.CreatedById ;;
  }

  dimension_group: created {
    type: time
    datatype: datetime
    timeframes: [year, hour_of_day, month, week, week_of_year, month_num, month_name,quarter, date, raw]
    label: "Created Date"
    sql: ${TABLE}.CreatedDate ;;
  }


# dimension: Date_dynamic {
#   type: string
#   label: "Date Dynamic Chat Transcript"
#   sql:
#    {% if timeframe_picker._parameter_value == 'Day' %} ${created_date}
#    {% elsif timeframe_picker._parameter_value == 'Week' %} ${created_week}
#    {% elsif timeframe_picker._parameter_value == 'Month' %} ${created_month}
#    {% elsif timeframe_picker._parameter_value == 'Quarter' %} ${created_quarter}
#    {% elsif timeframe_picker._parameter_value == 'Year' %} ${created_year}
#    {% else %} null {% endif %} ;;
#   drill_fields: [detail*]
# }

  dimension: Date_dynamic {
    type: date
    datatype: datetime
    label: "Date Dynamic Chat Transcript"
    sql:
     {% if timeframe_picker._parameter_value == 'Day' %}   DATETIME_TRUNC(DATETIME(TIMESTAMP(${created_raw}),'{{_query._query_timezone}}'), DAY)
     {% elsif timeframe_picker._parameter_value == 'Week' %}  DATETIME_TRUNC(DATETIME(TIMESTAMP(${created_raw}),'{{_query._query_timezone}}'), WEEK(MONDAY))
     {% elsif timeframe_picker._parameter_value == 'Month' %}  DATETIME_TRUNC(DATETIME(TIMESTAMP(${created_raw}),'{{_query._query_timezone}}'),MONTH)
     {% elsif timeframe_picker._parameter_value == 'Quarter' %}  DATETIME_TRUNC(DATETIME(TIMESTAMP(${created_raw}),'{{_query._query_timezone}}'),QUARTER)
     {% elsif timeframe_picker._parameter_value == 'Year' %}  DATETIME_TRUNC(DATETIME(TIMESTAMP(${created_raw}),'{{_query._query_timezone}}'),YEAR)
     {% else %} null {% endif %} ;;
    convert_tz: no

    link: {
      label: "Chat Transcript Owner"
      url: "{{ count_by_chat_transcript_owner._link }}"
    }
  }

  parameter: timeframe_picker {
    label: "Date Granularity"
    type: unquoted
    allowed_value: { value: "Day" }
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Quarter" }
    allowed_value: { value: "Year" }
    default_value: "Month"
  }

  dimension: disable_one_quote {
    label: "Disable One Quote"
    hidden: yes
    type: string
    sql: ${TABLE}.Disable_One_Quote ;;
  }

  dimension: e_commerce_user_id {
    label: "eCommerce UserID"
    hidden: yes
    type: string
    sql: ${TABLE}.eCommerce_UserID ;;
  }

  dimension: email {
    label: "Email"
    #hidden: yes
    type: string
    sql: ${TABLE}.Email ;;
  }

  dimension_group: end {
    label: "End Time"
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.EndTime ;;
  }

  dimension: ended_by {
    label: "Ended By"
    hidden: yes
    type: string
    sql: ${TABLE}.EndedBy ;;
  }

  dimension: first_name {
    label: "First Name"
    hidden: yes
    type: string
    sql: ${TABLE}.First_Name ;;
  }

  dimension: first_queue_name {
    label: "First Queue Name"
    type: string
    sql: ${TABLE}.First_Queue_Name ;;
  }

  dimension: first_resolved {
    label: "First Resolved"
    hidden: yes
    type: string
    sql: ${TABLE}.First_Resolved ;;
  }

  dimension: has_leave_message {
    label: "Has Leave Message"
    hidden: yes
    type: string
    sql: ${TABLE}.HasLeaveMessage ;;
  }

  dimension: intent {
    label: "intent"
    type: string
    sql: ${TABLE}.intent ;;
  }

  dimension: intent_l1 {
    label: "Intent_L1"
    type: string
    sql: ${TABLE}.Intent_L1 ;;
  }

  dimension: intent_l2 {
    label:"Intent_L2"
    type: string
    sql: ${TABLE}.Intent_L2 ;;
  }

  dimension: intent_l3 {
    label: "Intent_L3"
    type: string
    sql: ${TABLE}.Intent_L3 ;;
  }

  dimension: intent_l4 {
    label: "Intent_L4"
    type: string
    sql: ${TABLE}.Intent_L4 ;;
  }

  dimension: ip_address {
    label: "Visitor IP Address"
    hidden: yes
    type: string
    sql: ${TABLE}.IpAddress ;;
  }

  dimension: is_case_closed {
    label: "Is Case Closed?"
    type: string
    sql: ${TABLE}.Is_Case_Closed ;;
  }

  dimension: is_chatbot_session {
    hidden: yes
    type: string
    sql: ${TABLE}.IsChatbotSession ;;
  }

  dimension: is_deleted {
    hidden: yes
    type: string
    sql: ${TABLE}.IsDeleted ;;
  }

  dimension: is_dummy {
    hidden: yes
    type: string
    sql: ${TABLE}.IsDummy ;;
  }

  dimension: is_mobile {
    label: "Is Mobile"
    hidden: yes
    type: string
    sql: ${TABLE}.Is_Mobile ;;
  }

  dimension: is_need_get_transcript {
    label: "Is Need Get Transcript"
    hidden: yes
    type: string
    sql: ${TABLE}.Is_Need_Get_Transcript ;;
  }

  dimension: is_nurtured {
    label: "Is Nurtured"
    type: string
    sql: ${TABLE}.Is_Nurtured ;;
  }

  dimension: is_queue {
    label: "Is Queue"
    type: string
    sql: ${TABLE}.Is_Queue ;;
  }

  measure: Queued_Abandonment_Ratio {
    label: "Queue Abandonement Ratio"
    type: average
    sql:   CASE WHEN ${is_queue} ='Abandonment' THEN 1 ELSE 0 END  ;;
    filters: [is_queue: "Abandonment,Queue"]
    drill_fields: [ct_detail*]
    value_format_name: percent_1

    link: {
      label: "Show Only {{rendered_value}}"
      url: "{{ Ratio_Drills._link }}&f[of_chat_transcript.is_queue]=Abandonment"
    }

    link: {
      label: "By chat_first_queue_name"
      url: "{{ CLC_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ CLC_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ CLC_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ CLC_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ CLC_by_chat_duration._link }}"
    }

    link: {
      label: "By chat case rating"
      url: "{{ CLC_by_chat_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ CLC_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ CLC_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ CLC_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ CLC_by_chat_transcript_owner._link }}"
    }
  }

#  measure: Queued_Abandonment_Ratio {
#    label: "Queue Abandonement Ratio"
#    type: number
#    sql:  ${Queued_Abandonment_Chats}/(CASE WHEN coalesce(${Queued_Chats},0) = 0 THEN 1 ELSE ${Queued_Chats} END ) ;;
#    #drill_fields: [ct_detail*]
#    value_format_name: percent_1
#
#    link: {
#      label: "Show {{rendered_value}}"
#      url: "{{ Ratio_Drills._link }}&f[of_chat_transcript.is_queue]=Abandonment,Queue"
#    }
#
#    link: {
#      label: "By chat_first_queue_name"
#      url: "{{ CLC_by_chat_first_queue_name._link }}&f[of_chat_transcript.is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By contact_name"
#      url: "{{ CLC_by_contact_name._link }}&f[of_chat_transcript.is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By email"
#      url: "{{ CLC_by_email._link }}&f[of_chat_transcript.is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By status"
#      url: "{{ CLC_by_status._link }}&f[of_chat_transcript.is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By chat_duration"
#      url: "{{ CLC_by_chat_duration._link }}&f[of_chat_transcript.is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By chat case rating"
#      url: "{{ CLC_by_chat_case_rating._link }}&f[of_chat_transcript.is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By case_net_promoter_score"
#      url: "{{ CLC_by_case_net_promoter_score._link }}&f[of_chat_transcript.is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By intent_l2"
#      url: "{{ CLC_by_intent_l2._link }}&f[of_chat_transcript.is_queue]=Abandonment"
#    }
#
#    link: {
#      label: "By intent_l3"
#      url: "{{ CLC_by_intent_l3._link }}&f[of_chat_transcript.is_queue]=Abandonment"
#    }
#  }

  measure: customer_left_chat {
    label: "Customer left chat"
    description: "Customer queue and left while queuing"
    type: count_distinct
    sql: ${oneforce_id} ;;
    #sql: CASE WHEN ${is_queue} ='Abandonment' THEN 1 ELSE 0 END  ;;
    drill_fields: [ct_detail*]
    filters: [is_queue: "Abandonment"]
    link: {
      label: "By chat_first_queue_name"
      url: "{{ CLC_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ CLC_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ CLC_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ CLC_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ CLC_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ CLC_by_chat_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ CLC_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ CLC_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ CLC_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ CLC_by_chat_transcript_owner._link }}"
    }
  }

  measure: Ratio_Drills {
    type: count
    drill_fields: [ct_detail*]
    hidden: yes
  }

  measure: CLC_by_chat_first_queue_name {
    type: count
    drill_fields: [chat_first_queue_name,customer_left_chat]
    hidden: yes
  }

  measure: CLC_by_contact_name {
    type: count
    drill_fields: [contact_name,customer_left_chat]
    hidden: yes
  }

  measure: CLC_by_email {
    type: count
    drill_fields: [email,customer_left_chat]
    hidden: yes
  }

  measure: CLC_by_status {
    type: count
    drill_fields: [status,customer_left_chat]
    hidden: yes
  }

  measure: CLC_by_chat_duration {
    type: count
    drill_fields: [chat_duration,customer_left_chat]
    hidden: yes
  }

  measure: CLC_by_chat_case_rating {
    type: count
    drill_fields: [chat_case_rating,customer_left_chat]
    hidden: yes
  }

  measure: CLC_by_case_net_promoter_score {
    type: count
    drill_fields: [case_net_promoter_score,customer_left_chat]
    hidden: yes
  }

  measure: CLC_by_intent_l2 {
    type: count
    drill_fields: [intent_l2,customer_left_chat]
    hidden: yes
  }

  measure: CLC_by_intent_l3 {
    type: count
    drill_fields: [intent_l3,customer_left_chat]
    hidden: yes
  }

  measure: CLC_by_chat_transcript_owner {
    type: count
    drill_fields: [ct_owner.name,customer_left_chat]
    hidden: yes
  }

  measure: chat_resolved_self_service {
    label: "Chat Resolved by Self Service Function"
    type: count_distinct
    sql: ${oneforce_id} ;;
    #sql: CASE WHEN ${of_case.Is_Chat_Self_Service} ='true' THEN 1 ELSE 0 END  ;;
    filters: [of_case.Is_Chat_Self_Service: "true"]
    drill_fields: [ct_detail*]
    link: {
      label: "By chat_first_queue_name"
      url: "{{ CRSS_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ CRSS_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ CRSS_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ CRSS_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ CRSS_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ CRSS_by_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ CRSS_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ CRSS_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ CRSS_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ CRSS_by_chat_transcript_owner._link }}"
    }
  }

  measure: CRSS_by_chat_first_queue_name {
    type: count
    drill_fields: [chat_first_queue_name,chat_resolved_self_service]
    hidden: yes
  }

  measure: CRSS_by_contact_name {
    type: count
    drill_fields: [contact_name,chat_resolved_self_service]
    hidden: yes
  }

  measure: CRSS_by_email {
    type: count
    drill_fields: [email,chat_resolved_self_service]
    hidden: yes
  }

  measure: CRSS_by_status {
    type: count
    drill_fields: [status,chat_resolved_self_service]
    hidden: yes
  }

  measure: CRSS_by_chat_duration {
    type: count
    drill_fields: [chat_duration,chat_resolved_self_service]
    hidden: yes
  }

  measure: CRSS_by_case_rating {
    type: count
    drill_fields: [case_rating,chat_resolved_self_service]
    hidden: yes
  }

  measure: CRSS_by_case_net_promoter_score {
    type: count
    drill_fields: [case_net_promoter_score,chat_resolved_self_service]
    hidden: yes
  }

  measure: CRSS_by_intent_l2 {
    type: count
    drill_fields: [intent_l2,chat_resolved_self_service]
    hidden: yes
  }

  measure: CRSS_by_intent_l3 {
    type: count
    drill_fields: [intent_l3,chat_resolved_self_service]
    hidden: yes
  }

  measure: CRSS_by_chat_transcript_owner {
    type: count
    drill_fields: [ct_owner.name,chat_resolved_self_service]
    hidden: yes
  }

  dimension: janrain_uuid {
    label: "Janrain UUID"
    hidden: yes
    type: string
    sql: ${TABLE}.Janrain_UUID ;;
  }

  dimension: language_del {
    hidden: yes
    type: string
    sql: ${TABLE}.Language_del ;;
  }

  dimension: last_modified_by_id {
    label: "Last Modified By"
    hidden: yes
    type: string
    sql: ${TABLE}.LastModifiedById ;;
  }

  dimension_group: last_modified {
    label: "Last Modified Date"
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.LastModifiedDate ;;
  }

  dimension: last_name {
    label: "Last Name"
    hidden: yes
    type: string
    sql: ${TABLE}.Last_Name ;;
  }

  dimension_group: last_referenced {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.LastReferencedDate ;;
  }

  dimension_group: last_viewed {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.LastViewedDate ;;
  }

  dimension: lead_id {
    hidden: yes
    label: "Lead"
    type: string
    sql: ${TABLE}.LeadId ;;
  }

  dimension: lfd_used {
    label: "LFD Used"
    type: string
    sql: ${TABLE}.LFD_Used ;;
  }

  dimension: live_chat_button_id {
    label: "Chat Button"
    hidden: yes
    type: string
    sql: ${TABLE}.LiveChatButtonId ;;
  }

  dimension: live_chat_deployment_id {
    label: "Deployment"
    hidden: yes
    type: string
    sql: ${TABLE}.LiveChatDeploymentId ;;
  }

  dimension: live_chat_visitor_id {
    label: "Chat Visitor"
    hidden: yes
    type: string
    sql: ${TABLE}.LiveChatVisitorId ;;
  }

  dimension: location {
    label: "Location"
    hidden: yes
    type: string
    sql: ${TABLE}.Location ;;
  }

  dimension: max_response_time_operator {
    label: "Agent Maximum Response Time"
    hidden: yes
    type: number
    sql: ${TABLE}.MaxResponseTimeOperator ;;
  }

  dimension: max_response_time_visitor {
    label: "Visitor Maximum Response Time"
    hidden: yes
    type: number
    sql: ${TABLE}.MaxResponseTimeVisitor ;;
  }

  dimension: merged_d_d_transferred {
    label: "Merged D&D Transferred"
    type: string
    sql: ${TABLE}.Merged_D_D_Transferred ;;
    hidden: yes
  }

  dimension: merged_d_d_used {
    label: "Merged D&D Used"
    type: string
    sql: ${TABLE}.Merged_D_D_Used ;;
  }

  dimension: name {
    label: "Chat Transcript Name"
    type: string
    sql: ${TABLE}.Name ;;
  }

  measure: name1 {
    label: "Chat Transcript Name"
    type: max
    sql: ${TABLE}.Name ;;
  }

  measure: name_max {
    label: "Chat Transcript Name Max"
    type:string
    sql: max(${TABLE}.Name) ;;
  }

  dimension: office {
    label: "Office"
    type: string
    sql: ${TABLE}.Office ;;
  }

  dimension: oneforce_id {
    label: "OneForce ID"
    type: string
    sql: ${TABLE}.ONEForce_ID ;;
    primary_key: yes
  }

  dimension: operator_message_count {
    label: "Agent Message Count"
    hidden: yes
    type: number
    sql: ${TABLE}.OperatorMessageCount ;;
  }

  dimension: origin {
    label: "Origin"
    type: string
    sql: ${TABLE}.Origin ;;
  }

  dimension: owner_id {
    label: "Owner"
    hidden: no
    type: string
    sql: ${TABLE}.OwnerId ;;
  }

  dimension: platform {
    label: "Platform"
    type: string
    sql: ${TABLE}.Platform ;;
  }

  dimension: queue_wait_time {
    label: "Queue Wait Time"
    hidden: yes
    type: number
    sql: ${TABLE}.Queue_Wait_Time ;;
  }

  dimension: reference_number {
    label: "Reference Number"
    hidden: yes
    type: string
    sql: ${TABLE}.Reference_Number ;;
  }

  dimension: reference_number_type {
    label: "Reference Number Type"
    hidden: yes
    type: string
    sql: ${TABLE}.Reference_Number_Type ;;
  }

  dimension: referrer_uri {
    label: "Referring Site"
    hidden: yes
    type: string
    sql: ${TABLE}.ReferrerUri ;;
  }

  dimension_group: request {
    label: "Request Time"
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.RequestTime ;;
  }

  dimension: screen_resolution {
    label: "Screen Resolution"
    hidden: yes
    type: string
    sql: ${TABLE}.ScreenResolution ;;
  }

  dimension: shipment_number {
    label: "Shipment Number"
    hidden: yes
    type: string
    sql: ${TABLE}.Shipment_Number ;;
  }

  dimension: skill_id {
    label: "Primary Skill"
    hidden: yes
    type: string
    sql: ${TABLE}.SkillId ;;
  }

  dimension_group: start {
    label: "Start Time"
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.StartTime ;;
  }

  dimension: status {
    label: "Status"
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: supervisor_transcript_body {
    label: "Supervisor Transcript Body"
    hidden: yes
    type: string
    sql: ${TABLE}.SupervisorTranscriptBody ;;
  }

  dimension_group: system_modstamp {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.SystemModstamp ;;
  }

  dimension: transfer_type {
    label: "TransferType"
    type: string
    sql: ${TABLE}.TransferType ;;
  }

  dimension: transferred_queues {
    label: "Transferred Queues"
    hidden: yes
    type: string
    sql: ${TABLE}.Transferred_Queues ;;
  }

  dimension: user_agent {
    label: "User Agent"
    hidden: yes
    type: string
    sql: ${TABLE}.UserAgent ;;
  }

  dimension: visitor_message_count {
    label: "Visitor Message Count"
    hidden: yes
    type: number
    sql: ${TABLE}.VisitorMessageCount ;;
  }

  dimension: visitor_network {
    label: "Network"
    hidden: yes
    type: string
    sql: ${TABLE}.VisitorNetwork ;;
  }

  dimension: wait_time {
    label: "Wait Time"
    description: "Wait Time in second"
    type: number
    sql: ${TABLE}.WaitTime ;;
  }

  measure: Average_wait_time {
    type: average
    sql: coalesce(${TABLE}.WaitTime,0)+coalesce(${TABLE}.Queue_Wait_Time,0) ;;
    label: "Customer Waiting Time"
    description: "Customer Waiting Time in second"
    value_format_name: decimal_1
    drill_fields: [detail*]
    link: {
      label: "By chat_first_queue_name"
      url: "{{ CWT_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ CWT_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ CWT_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ CWT_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ CWT_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ CWT_by_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ CWT_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ CWT_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ CWT_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ CWT_by_chat_transcript_owner._link }}"
    }
  }

  measure: CWT_by_chat_first_queue_name {
    type: count
    drill_fields: [chat_first_queue_name,Average_wait_time]
    hidden: yes
  }

  measure: CWT_by_contact_name {
    type: count
    drill_fields: [contact_name,Average_wait_time]
    hidden: yes
  }

  measure: CWT_by_email {
    type: count
    drill_fields: [email,Average_wait_time]
    hidden: yes
  }

  measure: CWT_by_status {
    type: count
    drill_fields: [status,Average_wait_time]
    hidden: yes
  }

  measure: CWT_by_chat_duration {
    type: count
    drill_fields: [chat_duration,Average_wait_time]
    hidden: yes
  }

  measure: CWT_by_case_rating {
    type: count
    drill_fields: [case_rating,Average_wait_time]
    hidden: yes
  }

  measure: CWT_by_case_net_promoter_score {
    type: count
    drill_fields: [case_net_promoter_score,Average_wait_time]
    hidden: yes
  }

  measure: CWT_by_intent_l2 {
    type: count
    drill_fields: [intent_l2,Average_wait_time]
    hidden: yes
  }

  measure: CWT_by_intent_l3 {
    type: count
    drill_fields: [intent_l3,Average_wait_time]
    hidden: yes
  }

  measure: CWT_by_chat_transcript_owner {
    type: count
    drill_fields: [ct_owner.name,Average_wait_time]
    hidden: yes
  }

  measure: total_chat_handled_by_agents {
    label: "Total Chat Handled by Agents"
    type: sum
    sql: CASE WHEN ${Ishandled_by_agent} = "Yes" THEN 1 ELSE 0 END  ;;
    drill_fields: [detail*]

    link: {
      label: "By chat_first_queue_name"
      url: "{{ count_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ count_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ count_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ count_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ count_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ count_by_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ count_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ count_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ count_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ count_by_chat_transcript_owner._link }}"
    }
  }


  measure: count {
    type: count
    drill_fields: [detail*]

    link: {
      label: "By chat_first_queue_name"
      url: "{{ count_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ count_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ count_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ count_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ count_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ count_by_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ count_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ count_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ count_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ count_by_chat_transcript_owner._link }}"
    }
  }

  measure: count_by_chat_first_queue_name {
    type: count
    drill_fields: [chat_first_queue_name,count]
    hidden: yes
  }

  measure: count_by_contact_name {
    type: count
    drill_fields: [contact_name,count]
    hidden: yes
  }

  measure: count_by_email {
    type: count
    drill_fields: [email,count]
    hidden: yes
  }

  measure: count_by_status {
    type: count
    drill_fields: [status,count]
    hidden: yes
  }

  measure: count_by_chat_duration {
    type: count
    drill_fields: [chat_duration,count]
    hidden: yes
  }

  measure: count_by_case_rating {
    type: count
    drill_fields: [case_rating,count]
    hidden: yes
  }

  measure: count_by_case_net_promoter_score {
    type: count
    drill_fields: [case_net_promoter_score,count]
    hidden: yes
  }

  measure: count_by_intent_l2 {
    type: count
    drill_fields: [intent_l2,count]
    hidden: yes
  }

  measure: count_by_intent_l3 {
    type: count
    drill_fields: [intent_l3,count]
    hidden: yes
  }

  measure: count_by_chat_transcript_owner {
    type: count
    drill_fields: [ct_owner.name,count]
    hidden: yes
  }


  dimension: case_net_promoter_score {
    label: "Chat Net Promoter Score"
    type: string
    sql: ${TABLE}.Case_Net_Promoter_Score ;;
  }


  #dimension: chat_handle_time {
  #  label: "Chat Handle Time"
  #  type: string
  #  sql: ${TABLE}.Chat_Handle_Time ;;
  #  value_format_name: decimal_1
  #}

  measure: avg_chat_handle_time {
    label: "Avg Chat Handle Time (Mins)"
    type: average
    sql: ${TABLE}.Chat_Handle_Time ;;
    filters: [of_case.origin : "Chat"]
    drill_fields: [detail*]
    value_format_name: decimal_1
  }

  measure: chat_handle_time1 {
    label: "Avg Chat Handle Time (mins)"
    type: average
    sql: ${TABLE}.Chat_Handle_Time ;;
    filters: [of_case.origin : "Chat"]
    drill_fields: [detail*]
    value_format_name: decimal_1
  }

  measure: chat_handle_time_avg {
    label: "Average Chat Handle Time"
    type: average
    sql: ${TABLE}.Chat_Handle_Time ;;
    filters: [of_case.origin : "Chat"]
    drill_fields: [detail*]
    value_format_name: decimal_1
    filters: [of_case.is_aht_calculated_excluded: "Yes"]
    link: {
      label: "By chat_first_queue_name"
      url: "{{ ACHT_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ ACHT_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ ACHT_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ ACHT_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ ACHT_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ ACHT_by_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ ACHT_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ ACHT_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ ACHT_by_intent_l3._link }}"
    }
  }

  measure: chat_handle_time_avg2 {
    label: "Average Chat Handle Time (Mins)"
    type: average
    sql: ${chat_handle_time} ;;
    drill_fields: [detail*]
    value_format_name: decimal_1
    filters: [chat_handle_time: ">0"]

    link: {
      label: "By chat_first_queue_name"
      url: "{{ ACHT_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ ACHT_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ ACHT_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ ACHT_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ ACHT_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ ACHT_by_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ ACHT_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ ACHT_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ ACHT_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ ACHT_by_chat_transcript_owner._link }}"
    }
  }

  measure: ACHT_by_chat_first_queue_name {
    type: count
    drill_fields: [chat_first_queue_name,chat_handle_time_avg]
    hidden: yes
  }

  measure: ACHT_by_contact_name {
    type: count
    drill_fields: [contact_name,chat_handle_time_avg]
    hidden: yes
  }

  measure: ACHT_by_email {
    type: count
    drill_fields: [email,chat_handle_time_avg]
    hidden: yes
  }

  measure: ACHT_by_status {
    type: count
    drill_fields: [status,chat_handle_time_avg]
    hidden: yes
  }

  measure: ACHT_by_chat_duration {
    type: count
    drill_fields: [chat_duration,chat_handle_time_avg]
    hidden: yes
  }

  measure: ACHT_by_case_rating {
    type: count
    drill_fields: [case_rating,chat_handle_time_avg]
    hidden: yes
  }

  measure: ACHT_by_case_net_promoter_score {
    type: count
    drill_fields: [case_net_promoter_score,chat_handle_time_avg]
    hidden: yes
  }

  measure: ACHT_by_intent_l2 {
    type: count
    drill_fields: [intent_l2,chat_handle_time_avg]
    hidden: yes
  }

  measure: ACHT_by_intent_l3 {
    type: count
    drill_fields: [intent_l3,chat_handle_time_avg]
    hidden: yes
  }

  measure: ACHT_by_chat_transcript_owner {
    type: count
    drill_fields: [ct_owner.name,chat_handle_time_avg]
    hidden: yes
  }

  measure: ct_owner {
    type: count_distinct
    sql: ${of_case.ct_owner_name} ;;

  }

  measure: chat_owner {
    type: count_distinct
    sql: ${owner_id} ;;
  }

  measure: chats_per_agent {
    label: "Chats Per Agent"
    type: number
    sql: (${total_chat_handled_by_agents}/${chat_owner}) ;;
    value_format_name: decimal_2
    drill_fields: [detail*]
    link: {
      label: "By chat_first_queue_name"
      url: "{{ CPA_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ CPA_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ CPA_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ CPA_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ CPA_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ CPA_by_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ CPA_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ CPA_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ CPA_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ CPA_by_chat_transcript_owner._link }}"
    }
  }

  measure: CPA_by_chat_first_queue_name {
    type: count
    drill_fields: [chat_first_queue_name,chats_per_agent]
    hidden: yes
  }

  measure: CPA_by_contact_name {
    type: count
    drill_fields: [contact_name,chats_per_agent]
    hidden: yes
  }

  measure: CPA_by_email {
    type: count
    drill_fields: [email,chats_per_agent]
    hidden: yes
  }

  measure: CPA_by_status {
    type: count
    drill_fields: [status,chats_per_agent]
    hidden: yes
  }

  measure: CPA_by_chat_duration {
    type: count
    drill_fields: [chat_duration,chats_per_agent]
    hidden: yes
  }

  measure: CPA_by_case_rating {
    type: count
    drill_fields: [case_rating,chats_per_agent]
    hidden: yes
  }

  measure: CPA_by_case_net_promoter_score {
    type: count
    drill_fields: [case_net_promoter_score,chats_per_agent]
    hidden: yes
  }

  measure: CPA_by_intent_l2 {
    type: count
    drill_fields: [intent_l2,chats_per_agent]
    hidden: yes
  }

  measure: CPA_by_intent_l3 {
    type: count
    drill_fields: [intent_l3,chats_per_agent]
    hidden: yes
  }

  measure: CPA_by_chat_transcript_owner {
    type: count
    drill_fields: [ct_owner.name,chats_per_agent]
    hidden: yes
  }

  measure: days_of_month {
    type: count_distinct
    sql: (${created_date}) ;;
    label: "Days of Month"
  }

  dimension: Geography_dynamic {
    type: string
    label: "Geography Chat Dynamic"
    drill_fields: [detail*]
    sql: CASE
          WHEN {% parameter DB_Param %} = "RHQ" THEN ${of_case.case_RHQ}
          WHEN {% parameter DB_Param %} = "Status" THEN ${status}
          WHEN {% parameter DB_Param %} = "Country" THEN ${country}
          WHEN {% parameter DB_Param %} = "Office" THEN ${office}
          WHEN {% parameter DB_Param %} = "Segment " THEN ${of_customer_group.key_acct_tp_cd}
          ELSE "Global" END;;
  }

  parameter: DB_Param {
    type: string
    label: "Dashboard Parameter"

    allowed_value: {
      label: "Global"
      value: "Global"
    }

    allowed_value: {
      label: "RHQ"
      value: "RHQ"
    }

    allowed_value: {
      label: "Status"
      value: "Status"
    }
    allowed_value: {
      label: "Country"
      value: "Country"
    }
    allowed_value: {
      label: "Office"
      value: "Office"
    }
    allowed_value: {
      label: "Segment "
      value: "Segment "
    }
  }

  measure: all_rating_chat{
    type: count_distinct
    sql: Case WHEN ${chat_case_rating}='Good' OR ${chat_case_rating}='Bad'  THEN 1 ELSE 0 END ;;
    label:"All Rating Chat"
  }

  measure: good_rating_chat{
    type: count_distinct
    sql: Case WHEN ${chat_case_rating}='Good'  THEN 1 ELSE 0 END ;;
    label:"Good Rating Chat"
  }

  measure: difference_rating_chat{
    type: number
    sql: (${good_rating_chat}/NULLIF(${all_rating_chat}, 0)) ;;
    label:"Difference Rating Chat"
    drill_fields: [detail*]
  }

  dimension: total_chat_transfer {
    label: "No. of Times Chat is Transferred"
    type: number
    sql: ${TABLE}.Total_Chat_Transfer ;;
  }

  dimension: is_abandoned_chat {
    label: "Is Abandoned Chat?"
    description: "Is Queue = Abandonement OR Customer_Abandoned_Chat is True"
    type: yesno
    sql:  ${is_queue} ='Abandonment' OR ${Customer_Abandoned_Chat} = 'true' ;;
  }

  measure: total_abandoned_chat {
    label: "Total Abandoned Chat"
    description: "Customer left while either queuing or chatting BOT"
    type: count_distinct
    sql: ${oneforce_id};;
    filters: [is_abandoned_chat: "yes"]
    drill_fields: [detail*]
    link: {
      label: "By chat_first_queue_name"
      url: "{{ CLC_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ CLC_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ CLC_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ CLC_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ CLC_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ CLC_by_chat_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ CLC_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ CLC_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ CLC_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ CLC_by_chat_transcript_owner._link }}"
    }
  }

  measure: transferred_chat {
    label: "Transferred Chat"
    type: sum
    sql:  CASE WHEN ${total_chat_transfer} >0 THEN 1 ELSE 0 END ;;
    drill_fields: [detail*]
    link: {
      label: "By chat_first_queue_name"
      url: "{{ CLC_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ CLC_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ CLC_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ CLC_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ CLC_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ CLC_by_chat_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ CLC_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ CLC_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ CLC_by_intent_l3._link }}"
    }
  }

  measure: transferred_chat_ratio {
    label: "Transfer Chat Ratio"
    type: number
    sql: (${transferred_chat}/IFNULL(${count},0)) ;;
    drill_fields: [detail*]
    value_format_name: percent_1
    link: {
      label: "By chat_first_queue_name"
      url: "{{ CLC_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ CLC_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ CLC_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ CLC_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ CLC_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ CLC_by_chat_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ CLC_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ CLC_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ CLC_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ CLC_by_chat_transcript_owner._link }}"
    }
  }



  measure: abandone_chat_b4_agent {
    label: "Abandoned chat before connect agent"
    type: count_distinct
    #sql: CASE WHEN ${Customer_Abandoned_Chat} = 'true' THEN 1 ELSE 0 END ;;
    sql: ${oneforce_id} ;;
    filters: [Customer_Abandoned_Chat: "true"]
  }

  measure: abandone_chat_b4_agent_ratio {
    label: "Abandonement before agent Ratio"
    type: number
    sql: (${abandone_chat_b4_agent}/IFNULL(${Total_Chats},0)) ;;
    drill_fields: [ct_detail*]
    value_format_name: percent_1

    link: {
      label: "Show Only {{rendered_value}}"
      url: "{{ Ratio_Drills._link }}&f[of_chat_transcript.Customer_Abandoned_Chat]=true"
    }

    link: {
      label: "By chat_first_queue_name"
      url: "{{ CLC_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ CLC_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ CLC_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ CLC_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ CLC_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ CLC_by_chat_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ CLC_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ CLC_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ CLC_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ CLC_by_chat_transcript_owner._link }}"
    }
  }

  measure: Queued_Abandonment_Chats  {
    label: "Queued_Abandonment_Chats"
    type: count_distinct
    #sql: CASE WHEN ${is_queue} in ('Abandonment') THEN 1 ELSE 0 END  ;;
    sql: ${oneforce_id} ;;
    filters: [is_queue: "Abandonment"]
  }

  measure: Queued_Chats  {
    label: "Queued_Chats"
    type: count_distinct
    #sql: CASE WHEN ${is_queue} in ('Abandonment','Queue') THEN 1 ELSE 0 END  ;;
    sql: ${oneforce_id} ;;
    filters: [is_queue: "Abandonment,Queue"]
  }


  measure: Total_Chats  {
    label: "Total_Chats"
    type: count_distinct
    sql: ${oneforce_id} ;;
  }

  measure: total_queued_chats {
    label: "Total Queued Chats"
    type: average
    sql: CASE WHEN ${is_queue} in ('Abandonment','Queue') THEN 1 ELSE 0 END ;;
    drill_fields: [ct_detail*]
    filters: [is_queue: "Abandonment,Queue,None"]
    value_format_name: percent_1

    link: {
      label: "Show Only {{rendered_value}}"
      url: "{{ Ratio_Drills._link }}&f[of_chat_transcript.is_queue]=Abandonment,Queue"
    }

    link: {
      label: "By chat_first_queue_name"
      url: "{{ TQC_by_chat_first_queue_name._link }}"
    }

    link: {
      label: "By contact_name"
      url: "{{ TQC_by_contact_name._link }}"
    }

    link: {
      label: "By email"
      url: "{{ TQC_by_email._link }}"
    }

    link: {
      label: "By status"
      url: "{{ TQC_by_status._link }}"
    }

    link: {
      label: "By chat_duration"
      url: "{{ TQC_by_chat_duration._link }}"
    }

    link: {
      label: "By case_rating"
      url: "{{ TQC_by_case_rating._link }}"
    }

    link: {
      label: "By case_net_promoter_score"
      url: "{{ TQC_by_case_net_promoter_score._link }}"
    }

    link: {
      label: "By intent_l2"
      url: "{{ TQC_by_intent_l2._link }}"
    }

    link: {
      label: "By intent_l3"
      url: "{{ TQC_by_intent_l3._link }}"
    }

    link: {
      label: "Chat Transcript Owner"
      url: "{{ TQC_by_chat_transcript_owner._link }}"
    }
  }

  measure: TQC_by_chat_first_queue_name {
    type: count
    drill_fields: [chat_first_queue_name,total_queued_chats]
    hidden: yes
  }

  measure: TQC_by_contact_name {
    type: count
    drill_fields: [contact_name,total_queued_chats]
    hidden: yes
  }

  measure: TQC_by_email {
    type: count
    drill_fields: [email,total_queued_chats]
    hidden: yes
  }

  measure: TQC_by_status {
    type: count
    drill_fields: [status,total_queued_chats]
    hidden: yes
  }

  measure: TQC_by_chat_duration {
    type: count
    drill_fields: [chat_duration,total_queued_chats]
    hidden: yes
  }

  measure: TQC_by_case_rating {
    type: count
    drill_fields: [case_rating,total_queued_chats]
    hidden: yes
  }

  measure: TQC_by_case_net_promoter_score {
    type: count
    drill_fields: [case_net_promoter_score,total_queued_chats]
    hidden: yes
  }

  measure: TQC_by_intent_l2 {
    type: count
    drill_fields: [intent_l2,total_queued_chats]
    hidden: yes
  }

  measure: TQC_by_intent_l3 {
    type: count
    drill_fields: [intent_l3,total_queued_chats]
    hidden: yes
  }

  measure: TQC_by_chat_transcript_owner {
    type: count
    drill_fields: [ct_owner.name,total_queued_chats]
    hidden: yes
  }

  dimension:chat_nps_group {
    type: string
    sql: (CASE
          WHEN ${TABLE}.Chat_Case_Net_Promoter_Score<7 THEN 'Detractors'
          WHEN ${TABLE}.Chat_Case_Net_Promoter_Score>=7 and ${TABLE}.Chat_Case_Net_Promoter_Score<9 THEN 'Passives'
          WHEN ${TABLE}.Chat_Case_Net_Promoter_Score>=9 THEN 'Promoters'
          ELSE 'No Rating' END);;
    label:"Chat NPS Segment"

  }

  dimension: chat_case_net_promoter_score{
    type: string
    sql: ${TABLE}.Chat_Case_Net_Promoter_Score;;
    label: "Chat Net Promotor Score"
  }

  measure: detractor_percentage{
    type: average
    sql: Case WHEN ${chat_nps_group}='Detractors' THEN 1 ELSE 0 END ;;
    label:"Detractor Percentage"
    filters: [chat_nps_group: "-No Rating"]
    value_format_name: percent_0
    #hidden: yes
  }

  measure: promoter_percentage{
    type: average
    sql: Case WHEN ${chat_nps_group}='Promoters' THEN 1 ELSE 0 END ;;
    label:"Promoters Percentage"
    value_format_name: percent_0
    filters: [chat_nps_group: "-No Rating"]
    #hidden: yes
  }


  measure: chat_global_nps{
    type: number
    sql: (${promoter_percentage} - ${detractor_percentage}) *100 ;;
    label:"Chat Global NPS"
    value_format_name: decimal_0
    drill_fields: [detail*]
  }

  dimension: business_scenarios {
    label: "Business Scenarios - Filter"
    type: string
    sql: CASE WHEN (${status} = 'Missed' AND ${case_owner.name} = 'Platform Integration User' AND ${of_case.status} = 'Closed' AND ${of_case.resolution_reason} = 'Customer Abandoned Chat') THEN 'Pre-Chat Form'
              WHEN (${isWithInBusinessHour} = 'No' AND ${status} = 'Completed' AND ${case_owner.name} = 'Platform Integration User' AND ${of_case.status} = 'Closed' AND ${of_case.resolution_reason} = 'Customer Abandoned Chat') THEN 'No Agent available (non-business hour)'
              WHEN (${status} = 'Completed' AND ${case_owner.name} = 'Platform Integration User' AND ${of_case.status} = 'Closed' AND ${of_case.resolution_reason} = 'Customer Abandoned Chat') THEN 'Final Intent Menu/Connecting with Agent'
              WHEN (${status} = 'Completed' AND ${of_case.Case_Owned_by_System_Filter} = 'No' AND ${of_case.status} = 'In Progress' AND ${of_case.resolution_reason} = 'None') THEN 'Before Chat ended by Agent'
              ELSE NULL END;;
  }

  #DCN-1151: Display business scenarios even no data
  dimension: business_scenarios_fill {
    label: "Business Scenarios"
    case: {
      when: {
        sql: ${status} = 'Missed'
            AND ${case_owner.name} = 'Platform Integration User'
            AND ${of_case.status} = 'Closed'
            AND ${of_case.resolution_reason} = 'Customer Abandoned Chat' ;;
        label: "Pre-Chat Form"
      }
      when: {
        sql:  ${isWithInBusinessHour} = 'No'
            AND ${status} = 'Completed'
            AND ${case_owner.name} = 'Platform Integration User'
            AND ${of_case.status} = 'Closed'
            AND ${of_case.resolution_reason} = 'Customer Abandoned Chat';;
        label: "No Agent available (non-business hour)"
      }
      when: {
        sql: ${status} = 'Completed'
            AND ${case_owner.name} = 'Platform Integration User'
            AND ${of_case.status} = 'Closed'
            AND ${of_case.resolution_reason} = 'Customer Abandoned Chat' ;;
        label: "Final Intent Menu/Connecting with Agent"
      }
      when: {
        sql: ${status} = 'Completed'
            AND ${of_case.Case_Owned_by_System_Filter} = 'No'
            AND ${of_case.status} = 'In Progress'
            AND ${of_case.resolution_reason} = 'None' ;;
        label: "Before Chat ended by Agent"
      }
      else: "Others"
    }
    allow_fill: yes
  }

  dimension: segment {
    type: string
    sql: CASE WHEN ${Customer_Abandoned_Chat} = 'true' THEN 'Ongoing Chat with Agent/Menu Page'
      ELSE NULL END;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      name,
      of_case.casenumber,
      of_case.ct_owner_name,
      of_user.name,
      chat_first_queue_name,
      intent_l2,
      intent_l3,
      ct_customer.name,
      contact_name,
      email,
      status,
      chat_duration,
      start_time,
      end_time,
      chat_handle_time,
      Chat_First_Response_Time_Mins,
      average_response_time_operator,
      response_time_visitor,
      chat_case_rating,
      case_net_promoter_score,
    ]
  }

  # ----- Sets of fields for drilling ------
  set: ct_detail {
    fields: [
      name,
      of_case.casenumber,
      of_case.ct_owner_name,
      name,
      of_user.name,
      chat_first_queue_name,
      intent_l2,
      intent_l3,
      ct_customer.name,
      contact_name,
      email,
      status,
      chat_duration,
      start_time,
      end_time,
      chat_handle_time,
      Chat_First_Response_Time_Mins,
      average_response_time_operator,
      response_time_visitor,
      chat_case_rating,
      case_net_promoter_score,
      is_queue,
      Customer_Abandoned_Chat
    ]
  }


}
