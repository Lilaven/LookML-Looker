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
