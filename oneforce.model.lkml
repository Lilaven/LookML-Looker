connection: "one_force"

# include all the views
include: "/views/**/*.view"
include: "/models/entities/of_consolidated_explore_data_tests.lkml"
include: "/models/entities/datagroups.lkml"
include: "/dashboards/enterprise_dashboards/*.dashboard.lookml"

persist_with: oneforce_default_datagroup

explore: of_region {}

explore: of_sales_week_master {
  join: na_landing_last_n_week {
    type: inner
    relationship: one_to_one
    sql_on: ${of_sales_week_master.sales_week} = ${na_landing_last_n_week.sales_week} ;;
  }
}

explore: dashboard_performance {
  from: of_lkr_dbpfmc
  label: "Looker Dashboard Adoption"
  always_filter: {filters:[dashboard_performance.email: "-NULL"]}

  join: of_user {
    view_label: "User Dashboard Details"
    from :  of_user
    type: left_outer
    sql_on: ${of_user.oneforce_id} = ${dashboard_performance.of_user_oneforce_id} ;;
    relationship: one_to_one
  }

  join: of_country {
    view_label: "User Dashboard Details"
    fields: [country_name]
    type: left_outer
    sql_on: ${of_user.country} = ${of_country.country_code} ;;
    relationship: many_to_one
  }

  join: of_dashboard_group {
    from : of_lkr_db
    type: left_outer
    sql_on: ${of_dashboard_group.id} = ${dashboard_performance.id_user_defined_only} ;;
    relationship: many_to_one
  }

  join: of_lkr_dbpfmc_rowtot_sort {
    view_label: "Row Total Sort"
    type: inner
    relationship: many_to_one
    sql_on: ${dashboard_performance.email_full_name} = ${of_lkr_dbpfmc_rowtot_sort.email_full_name};;
  }
}

explore: global_cva_completion_2_mth_master{}

explore: global_cva_completion_2_1_inner {
  from: global_cva_completion_2_1_inner{}

  join: v_customer_opus_n_prospect {
    view_label: "Customer"
    type: left_outer
    sql_on: ${global_cva_completion_2_1_inner.cust_cd} = ${v_customer_opus_n_prospect.cust_cd};;
    relationship: many_to_one
  }

  join: of_customer_group {
    view_label: "Customer Group"
    type: left_outer
    #sql_on: ${v_customer_opus_n_prospect.cust_grp_id} = ${of_customer_group.cust_grp_id} ;;
    sql_on: ${global_cva_completion_2_1_inner.cust_grp_id} = ${of_customer_group.cust_grp_id} ;;
    relationship: many_to_one
  }

  join: gam_mapping {
    type: left_outer
    sql_on: ${global_cva_completion_2_1_inner.cust_grp_id} = ${gam_mapping.customer_grp_id};;
    relationship: many_to_one
  }

  join: gam {
    from: of_user2
    view_label: "GAM"
    type: left_outer
    sql_on: ${gam_mapping.gam_usr_id} = ${gam.oneforce_id};;
    relationship: many_to_one
  }

  join: of_svc_scp_grp2 {
    view_label: "Service Scope Group"
    type: left_outer
    sql_on: ${global_cva_completion_2_1_inner.service_scope_group_code} = ${of_svc_scp_grp2.service_scope_group_code};;
    relationship: many_to_one
  }

  join: of_svc_scp_grp_cat {
    view_label: "Service Scope Group Category"
    type: left_outer
    sql_on: ${global_cva_completion_2_1_inner.service_scope_group_code} = ${of_svc_scp_grp_cat.svc_scp_grp} ;;
    relationship: many_to_one
  }

  join: of_dom_ndom {
    view_label: "Dom Non-Dom"
    type: left_outer
    sql_on: ${global_cva_completion_2_1_inner.dominant_flag} = ${of_dom_ndom.dominant_flag};;
    relationship: many_to_one
  }

  join: of_svc_contract {
    view_label: "Svc/RFA Contract"
    type: left_outer
    sql_on: ${global_cva_completion_2_1_inner.sc_rfa_no} = ${of_svc_contract.sc_rfa_no} ;;
    relationship: many_to_one
  }

#  join: contract_office {
#    view_label: "Contract Office"
#    from: of_office
#    type: left_outer
#    sql_on: ${of_svc_contract.ofc_cd} = ${contract_office.office_code} ;;
#    relationship: many_to_one
#  }
#
#  join: contract_office_location {
#    view_label: "Contract Office Location"
#    from: of_location
#    type: left_outer
#    sql_on: ${contract_office.location_code} = ${contract_office_location.location_code} ;;
#    relationship: many_to_one
#  }
#
#  join: contract_office_country {
#    view_label: "Contract Office Country"
#    from: of_country
#    type: left_outer
#    sql_on: ${contract_office_location.country_code} = ${contract_office_country.country_code} ;;
#    relationship: many_to_one
#  }
#
#  join: contract_office_region {
#    view_label: "Contract Office RHQ"
#    from: of_reg_ref
#    type: left_outer
#    sql_on: ${contract_office_region.cust_cnt_cd} = ${contract_office_country.country_code};;
#    relationship: many_to_one
#  }
#
#  join: ckam_mapping {
#    from: ckam_mapping_one_per_country
#    type: left_outer
#    sql_on: ${global_cva_completion_2_1_inner.cust_grp_id}   = ${ckam_mapping.customer_grp_id} and
#            ${contract_office_location.country_code}         = ${ckam_mapping.contract_country_code}
#            ;;
#    relationship: many_to_one
#  }

  join: ckam_usr {
    view_label: "CKAM"
    from: of_user2
    type: left_outer
    #sql_on: ${ckam_mapping.ckam_sales_person} = ${ckam_usr.oneforce_id} ;;
    sql_on: ${global_cva_completion_2_1_inner.ckam_sales_person} = ${ckam_usr.oneforce_id} ;;
    relationship: many_to_one
  }


} # global_cva_completion_2_1_inner

explore: global_cva_completion_2_1{

  join: v_customer_opus_n_prospect {
    view_label: "Customer"
    type: left_outer
    sql_on: ${global_cva_completion_2_1.cust_cd} = ${v_customer_opus_n_prospect.cust_cd};;
    relationship: many_to_one
  }
  join: of_customer_group {
    view_label: "Customer Group"
    type: left_outer
    sql_on: ${global_cva_completion_2_1.cust_grp_id} = ${of_customer_group.cust_grp_id} ;;
    relationship: many_to_one
  }

  join: of_customer_grp_4_cvamon   {
    type: left_outer
    sql_on: ${global_cva_completion_2_1.cust_cd} = ${of_customer_grp_4_cvamon.cust_cd} ;;
    relationship: many_to_one
  }

  #DCN-1048, June 14th 2023
  join: of_customer {
    view_label: "Customer 2"
    type: left_outer
    sql_on: ${global_cva_completion_2_1.cust_cd} = ${of_customer.cust_cd};;
    relationship: many_to_one
  }

  # join: of_svc_contract_dtl {
  #   view_label: "Service Contract Detail"
  #   type: left_outer
  #   sql_on: ${global_cva_completion_2_1.sc_rfa_no} = ${of_svc_contract.sc_rfa_no} ;;
  #   relationship: many_to_one
  # }
  ######

  join: gam_mapping {
    type: left_outer
    sql_on: ${global_cva_completion_2_1.cust_grp_id} = ${gam_mapping.customer_grp_id};;
    relationship: many_to_one
  }

  join: gam {
    from: of_user2
    view_label: "GAM"
    type: left_outer
    sql_on: ${gam_mapping.gam_usr_id} = ${gam.oneforce_id};;
    relationship: many_to_one
  }

  join: of_svc_scp_grp2 {
    view_label: "Service Scope Group"
    type: left_outer
    sql_on: ${global_cva_completion_2_1.service_scope_group_code} = ${of_svc_scp_grp2.service_scope_group_code};;
    relationship: many_to_one
  }

  join: of_svc_scp_grp_cat {
    view_label: "Service Scope Group Category"
    type: left_outer
    sql_on: ${global_cva_completion_2_1.service_scope_group_code} = ${of_svc_scp_grp_cat.svc_scp_grp} ;;
    relationship: many_to_one
  }

  join: of_dom_ndom {
    view_label: "Dom Non-Dom"
    type: left_outer
    sql_on: ${global_cva_completion_2_1.dominant_flag} = ${of_dom_ndom.dominant_flag};;
    relationship: many_to_one
  }

  join: of_svc_contract {
    view_label: "Svc/RFA Contract"
    type: left_outer
    sql_on: ${global_cva_completion_2_1.sc_rfa_no} = ${of_svc_contract.sc_rfa_no} ;;
    relationship: many_to_one
  }

#  join: contract_office {
#    view_label: "Contract Office"
#    from: of_office
#    type: left_outer
#    sql_on: ${of_svc_contract.ofc_cd} = ${contract_office.office_code} ;;
#    relationship: many_to_one
#  }
#
#  join: contract_office_location {
#    view_label: "Contract Office Location"
#    from: of_location
#    type: left_outer
#    sql_on: ${contract_office.location_code} = ${contract_office_location.location_code} ;;
#    relationship: many_to_one
#  }
#
#  join: contract_office_country {
#    view_label: "Contract Office Country"
#    from: of_country
#    type: left_outer
#    sql_on: ${contract_office_location.country_code} = ${contract_office_country.country_code} ;;
#    relationship: many_to_one
#  }
#
#  join: contract_office_region {
#    view_label: "Contract Office RHQ"
#    from: of_reg_ref
#    type: left_outer
#    sql_on: ${contract_office_region.cust_cnt_cd} = ${contract_office_country.country_code};;
#    relationship: many_to_one
#  }
#
#  join: ckam_mapping {
#    from: ckam_mapping_one_per_country
#    type: left_outer
#    sql_on: ${global_cva_completion_2_1.cust_grp_id}  = ${ckam_mapping.customer_grp_id} and
#            ${contract_office_location.country_code}  = ${ckam_mapping.contract_country_code} ;;
#    relationship: many_to_one
#  }
#
  join: ckam_usr {
    view_label: "CKAM"
    from: of_user2
    type: left_outer
    sql_on: ${global_cva_completion_2_1.ckam_sales_person} = ${ckam_usr.oneforce_id} ;;
    relationship: many_to_one
  }
} #-- global_cva_completion_2_1 --

explore: global_cva_status_options{}

explore: global_cva {
  from: v_customer_opus_n_prospect
  #always_filter: {filters:[cust_grp_hrchy_cd: "G"]}

  join: of_customer_group {
    view_label: "Customer Group"
    type: left_outer
    sql_on: ${global_cva.cust_grp_id} = ${of_customer_group.cust_grp_id} ;;
    relationship: many_to_one
  }

  join: global_cva_completion {
    view_label: "Global CVA Completion"
    type: left_outer
    sql_on: ${global_cva_completion.cust_cd} = ${global_cva.cust_cd} ;;
    relationship: many_to_one
  }

  join: of_svc_contract {
    view_label: "SC/RFA Contract"
    type: left_outer
    sql_on: ${global_cva_completion.sc_rfa_no} = ${of_svc_contract.sc_rfa_no} ;;
    relationship: many_to_one
  }

  join: of_svc_scp {
    view_label: "Service Scope"
    type: left_outer
    sql_on: ${global_cva_completion.service_scope} = ${of_svc_scp.service_scope_code};;
    relationship: many_to_one
  }

  join: of_svc_scp_grp {
    view_label: "Service Scope Group"
    type: left_outer
    sql_on: ${of_svc_scp.service_scope_group_code} = ${of_svc_scp_grp.service_scope_group_code};;
    relationship: many_to_one
  }

  join: global_cva_gam {
    type: left_outer
    sql_on: ${of_customer_group.oneforce_id} = ${global_cva_gam.customer_group};;
    relationship: many_to_one
  }

  join: of_user {
    view_label: "Gam"
    type: left_outer
    sql_on: ${global_cva_gam.sales_person} = ${of_user.oneforce_id};;
    relationship: many_to_one
  }

  join: of_office_custom{
    view_label: "Gam Office"
    type:left_outer
    sql_on: right(${of_user.office_code},5) = ${of_office_custom.office_code} ;;
    relationship: many_to_one
  }

  join: of_location{
    view_label: "Gam Location"
    type:left_outer
    sql_on: ${of_location.location_code} = ${of_office_custom.location_code} ;;
    relationship: many_to_one
  }

  join: of_country {
    view_label: "Gam Country"
    type:left_outer
    sql_on: ${of_country.country_code} = LEFT(${of_location.location_code},2) ;;
    relationship: many_to_one
  }


  join: of_reg_ref {
    view_label: "Gam Region"
    type: left_outer
    sql_on: left(${of_office_custom.location_code},2) = ${of_reg_ref.cust_cnt_cd} ;;
    relationship: many_to_one
  }

}

explore: na_budget_trade_type {}

explore: of_user_test {
  from: of_user

  join: of_sales_week_master {
    type: left_outer
    sql_on: (${of_user_test.isactive} = 'true'  and ${of_user_test.createddate_date} <= ${of_sales_week_master.week_start_date} ) or
            (${of_user_test.isactive} = 'false' and ${of_user_test.lastmodifieddate_date} >= ${of_sales_week_master.week_end_date}) ;;
    relationship: many_to_one
  }
}

explore: of_sales_team_member_contract_country {}

explore: na_user {}

explore: of_sales_user_weekly {}

explore: of_user {

  join: of_event {
    type: left_outer
    #sql_on: ${of_user.oneforce_id} = ${of_event.created_by_id} and lower(${of_user.profile_name}) in ("third party agent", "sales executive") and ${of_event.what_id} is not null;;
    sql_on: lower( ${of_user.profile_name} ) in ("third party agent", "sales executive")  and ${of_event.what_id} is not null
            and ${of_event.participant} like
             {% if of_event.Sales_Actv_Partpn._parameter_value == "Creator" %} CONCAT(${of_user.oneforce_id},",%")
             {% elsif of_event.Sales_Actv_Partpn._parameter_value == "Parent" %} CONCAT(${of_user.oneforce_id},",%")
             {% elsif of_event.Sales_Actv_Partpn._parameter_value == "Assignee" %} CONCAT("%,",${of_user.oneforce_id})
             {% elsif of_event.Sales_Actv_Partpn._parameter_value == "Either" %} CONCAT("%",${of_user.oneforce_id},"%")
             {% else %} CONCAT(${of_user.oneforce_id},",%")
             {% endif %}
            ;;
    relationship: one_to_many
  }


  join: of_user_manager {
    view_label: "Sales User Manager"
    from: of_user
    type: left_outer
    sql_on: ${of_user.manager_id} = ${of_user_manager.oneforce_id} ;;
    relationship: one_to_many
  }

  join: of_user1 {
    view_label: "Created-By user"
    from: of_user
    type: left_outer
    sql_on: ${of_user1.oneforce_id} = ${of_event.created_by_id} ;;
    relationship: one_to_many
  }

  join: v_customer_opus_n_prospect {
    type: left_outer
    sql_on: ${of_event.what_id} = ${v_customer_opus_n_prospect.oneforce_id};;
    relationship: one_to_many
  }

  join: of_event_Manager1 {
    view_label: "Created-by Manager"
    from: of_sales_user_manager
    type: left_outer
    sql_on: ${of_event_Manager1.oneforce_id} = ${of_user1.manager_id} ;;
    relationship: one_to_many
  }

  join: of_user2 {
    view_label: "Assigned-to user"
    from: of_user
    type: left_outer
    sql_on: ${of_user2.oneforce_id} = ${of_event.owner_id} ;;
    relationship: one_to_many
  }

  join: of_event_Manager2 {
    view_label: "Assigned-to Manager"
    from: of_sales_user_manager
    type: left_outer
    sql_on: ${of_event_Manager2.oneforce_id} = ${of_user2.manager_id} ;;
    relationship: one_to_many
  }

  join: of_sales_week_master {
    type: left_outer
    sql_on: ${of_event.start_date_date} between DATE(${of_sales_week_master.week_start_date}) and DATE(${of_sales_week_master.week_end_date})  ;;
    relationship: many_to_one
  }

  join: event_of_calendar {
    from: of_calendar_week
    type: left_outer
    #sql_on: cast(EXTRACT(MONTH FROM ${of_event.start_date_date}) as string)  = ${event_of_calendar.calendar_month} and
    #        cast(EXTRACT(YEAR FROM ${of_event.start_date_date})  as string) = ${event_of_calendar.calendar_year};;
    sql_on: ${of_event.start_date_date} BETWEEN  event_of_calendar.isoweek_start_date and event_of_calendar.isoweek_end_date ;;
    relationship: many_to_one
  }

  join: event_of_calendar2 {
    from: of_calendar_week
    required_joins: [event_of_calendar]
    view_label: "Calendar2 - Month Count"
    type: left_outer
    sql_on: ${event_of_calendar2.isoweek_start_date} = ${event_of_calendar.isoweek_start_date} ;;
    relationship: many_to_one
  }

  join: of_sales_week_user {
    view_label: "Sales User Count"
    #sql_on: ${of_sales_week_master.sales_week} = ${of_sales_week_user.sales_week} ;;
    sql_on: ${of_event.start_date_week} = FORMAT_TIMESTAMP('%F',${of_sales_week_user.isoweek_start_date}) ;;
    relationship: many_to_one
  }

   join: of_sales_user_weekly {
    from: of_user
     required_joins: [event_of_calendar]
     type: left_outer
     sql_on: (( ${of_sales_user_weekly.isactive} = 'true' and ${of_sales_user_weekly.createddate_date} <= ${event_of_calendar.isoweek_end_date} )
               or
               ( ${of_sales_user_weekly.isactive} = 'false' and  ${event_of_calendar.isoweek_start_date} between ${of_sales_user_weekly.createddate_date} and ${of_sales_user_weekly.lastmodifieddate_date} )
              )  and lower(${of_sales_user_weekly.profile_name}) in ("third party agent", "sales executive")
              and 1 =
             {% if of_user.office_code_number._is_filtered == false and
               of_user.office_Country_Code._is_filtered == false and
               of_user.regional_head_office_short_nm._is_filtered == false and
               of_user.full_name._is_filtered == false and
               of_event_Manager1.full_name._is_filtered == false %} 0
             {% else %} 1
             {% endif %}
             and {% condition of_user.office_code_number %} ${of_sales_user_weekly.office_code_number} {% endcondition %}
             and {% condition of_user.office_Country_Code %} ${of_sales_user_weekly.office_Country_Code} {% endcondition %}
             and ${of_sales_user_weekly.regional_head_office_short_nm} like
             {% if of_user.regional_head_office_short_nm._is_filtered %} ${of_user.regional_head_office_short_nm}
             {% else %} '%'
             {% endif %}
             and ${of_sales_user_weekly.oneforce_id} like
             {% if of_user.full_name._is_filtered %} ${of_user.oneforce_id}
             {% else %} '%'
             {% endif %}
             and coalesce(${of_sales_user_weekly.manager_id} ,'xx') like
             {% if of_event_Manager1.full_name._is_filtered %} ${of_user.manager_id}
             {% else %} '%'
             {% endif %} ;;
     relationship:  one_to_many
   }

#and ${of_sales_user_weekly.office_Country_Code} like
#             {% if of_user.office_Country_Code._is_filtered %} ${of_user.office_Country_Code}
#             {% else %} '%'
#             {% endif %}

  join: of_sales_user_global {
   # required_joins: [of_event]
    type: left_outer
    sql_on:  ${of_sales_user_global.isoweek_start_date_date} = ${event_of_calendar.isoweek_start_date}
            and 1 =
            {% if of_user.office_code_number._is_filtered == false and
              of_user.office_Country_Code._is_filtered == false and
              of_user.regional_head_office_short_nm._is_filtered == false and
              of_user.full_name._is_filtered == false and
              of_event_Manager1.full_name._is_filtered == false %} 1
            {% else %} 0
            {% endif %}  ;;
    relationship:  one_to_many
  }

    ### TASK ###
  join: of_task {
    type: left_outer
  #  sql_on: ${of_user.oneforce_id} = ${of_task.created_by_id} and lower(${of_user.profile_name}) in ("third party agent", "sales executive") ;;
     sql_on: lower( ${of_user.profile_name} ) in ("third party agent", "sales executive")
             and ${of_task.participant} like
             {% if of_task.Sales_Actv_Partpn._parameter_value == "Creator" %} CONCAT(${of_user.oneforce_id},",%")
             {% elsif of_task.Sales_Actv_Partpn._parameter_value == "Parent" %} CONCAT(${of_user.oneforce_id},",",${of_user.oneforce_id})
             {% elsif of_task.Sales_Actv_Partpn._parameter_value == "Assignee" %} CONCAT("%,",${of_user.oneforce_id})
             {% elsif of_task.Sales_Actv_Partpn._parameter_value == "Either" %} CONCAT("%",${of_user.oneforce_id},"%")
             {% else %} CONCAT(${of_user.oneforce_id},",%")
             {% endif %} ;;
    relationship: one_to_many
  }

  join: of_task_user1 {
    from: of_user
    view_label: "Task Created-by user"
    type: left_outer
    sql_on: ${of_task_user1.oneforce_id} = ${of_task.created_by_id} ;;
    relationship: one_to_many
  }

  join: of_task_Manager1 {
    view_label: "Task Created-by Manager"
    from: of_sales_user_manager
    type: left_outer
    sql_on: ${of_task_Manager1.oneforce_id} = ${of_user.manager_id} ;;
    relationship: one_to_many
  }

  join: of_task_user2 {
    from: of_user
    view_label: "Task Assigned-to user"
    type: left_outer
    sql_on: ${of_task_user2.oneforce_id} = ${of_task.owner_id} ;;
    relationship: one_to_many
  }

  join: of_task_Manager2 {
    view_label: "Task Assinged-to Manager"
    from: of_sales_user_manager
    type: left_outer
    sql_on: ${of_task_Manager2.oneforce_id} = ${of_task_user2.manager_id} ;;
    relationship: one_to_many
  }

  join: task_v_customer_opus_n_prospect {
    from: v_customer_opus_n_prospect
    type: left_outer
    sql_on: ${of_task.what_id} = ${task_v_customer_opus_n_prospect.oneforce_id};;
    relationship: one_to_many
  }

  join: of_sales_week_master2 {
   view_label: "Task Sales Week Master"
   from: of_sales_week_master
   type: left_outer
   sql_on: ${of_task.created_date} between ${of_sales_week_master2.week_start_date} and ${of_sales_week_master2.week_end_date}  ;;
   relationship: many_to_one
  }

  join: task_of_calendar {
    from: of_calendar_week
    view_label: "Task Calendar"
    type: left_outer
    #sql_on: cast(EXTRACT(MONTH FROM ${of_task.created_date}) as string)  = ${task_of_calendar.calendar_month} and
    #        cast(EXTRACT(YEAR FROM ${of_task.created_date})  as string) = ${task_of_calendar.calendar_year};;
    sql_on: ${of_task.created_date} BETWEEN  task_of_calendar.isoweek_start_date and task_of_calendar.isoweek_end_date ;;
    relationship: many_to_one
  }

  join: task_of_calendar2 {
    from: of_calendar_week
    required_joins: [task_of_calendar]
    view_label: "Task Calendar2 - Month Count"
    type: left_outer
    sql_on: ${task_of_calendar2.isoweek_start_date} = ${task_of_calendar.isoweek_start_date} ;;
    relationship: many_to_one
  }

  join: of_sales_week_user3 {
    from: of_sales_week_user
    view_label: "Task Sales User Count"
    #sql_on: ${of_sales_week_master.sales_week} = ${of_sales_week_user.sales_week} ;;
    sql_on: ${of_task.created_date} = FORMAT_TIMESTAMP('%F',${of_sales_week_user3.isoweek_start_date}) ;;
    relationship: many_to_one
  }

  join: of_sales_user_weekly3  {
    from: of_user
    required_joins: [task_of_calendar]
    view_label: "Task Sales User Weekly"
    type: left_outer
    # use filter condition for office to enable SQL to get user count of all input offices rather thanjust the office with activity creation.
    sql_on: (( ${of_sales_user_weekly3.isactive} = 'true' and ${of_sales_user_weekly3.createddate_date} <= ${task_of_calendar.isoweek_end_date} )
               or
             ( ${of_sales_user_weekly3.isactive} = 'false' and  ${task_of_calendar.isoweek_start_date} between ${of_sales_user_weekly3.createddate_date} and ${of_sales_user_weekly3.lastmodifieddate_date} )
            )  and lower(${of_sales_user_weekly3.profile_name}) in ("third party agent", "sales executive")
              and {% condition of_user.office_code_number %} ${of_sales_user_weekly3.office_code_number} {% endcondition %}
              and {% condition of_user.office_Country_Code %} ${of_sales_user_weekly3.office_Country_Code} {% endcondition %}
              and ${of_sales_user_weekly3.regional_head_office_short_nm} like
              {% if of_user.regional_head_office_short_nm._is_filtered %} ${of_user.regional_head_office_short_nm} {% else %} '%'
              {% endif %}
              and coalesce(${of_sales_user_weekly3.manager_id},'xx') like
              {% if of_task_Manager1.full_name._is_filtered %} ${of_user.manager_id} {% else %} '%'
              {% endif %}
              and ${of_sales_user_weekly3.oneforce_id} like
              {% if of_user.full_name._is_filtered %} ${of_user.oneforce_id} {% else %} '%'
              {% endif %}
              and 1 =
             {% if of_user.office_code_number._is_filtered == false and
               of_user.office_Country_Code._is_filtered == false and
               of_user.regional_head_office_short_nm._is_filtered == false and
               of_user.full_name._is_filtered == false and
               of_task_Manager1.full_name._is_filtered == false %} 0
             {% else %} 1
             {% endif %}
             ;;
    relationship:  one_to_many
  }

  join: of_sales_user_global2 {
    from: of_sales_user_global
    view_label: "Task Sales User Global"
   # required_joins: [of_task]
    type: left_outer
    sql_on:  ${of_sales_user_global2.isoweek_start_date_date} = ${task_of_calendar.isoweek_start_date}
              and 1 =
              {% if of_user.office_code_number._is_filtered == false and
                of_user.office_Country_Code._is_filtered == false and
                of_user.regional_head_office_short_nm._is_filtered == false and
                of_user.full_name._is_filtered == false and
                of_task_Manager1.full_name._is_filtered == false %} 1
              {% else %} 0
              {% endif %}  ;;
    relationship:  one_to_many
  }

}

explore: tender_contract_calendar_2022 {
  from: of_sales_week_master
  sql_always_where: ${calendar_year} >= '2022' ;;

  join: tender_contract_current {
    type: left_outer
    sql_on: ${tender_contract_calendar_2022.calendar_year} = ${tender_contract_current.calendar_year} ;;
    relationship: many_to_many
  }
}

explore: tender_contract_calendar_2021 {
  from: of_sales_week_master
  sql_always_where: ${calendar_year} >= '2022' ;;
}


explore: of_svc_scp_grp_picklist {
  from: of_svc_scp_grp
  fields: [service_scope_group_code, service_scope_group_code_and_name]
}

explore: tender_nomination {

  #view_label: "Current Year"
  #from: tender_contract_current

  join: of_customer_group {
    view_label: "Customer Group"
    type: left_outer
    sql_on: ${tender_nomination.cust_grp_id} = ${of_customer_group.cust_grp_id} ;;
    relationship: many_to_one
  }

  join: v_customer_opus_n_prospect {
    view_label: "Customer Individual"
    type:inner
    sql_on: ${v_customer_opus_n_prospect.cust_cd} = trim(${of_customer_group.cust_grp_id},'G-') ;;
    relationship: many_to_one

  }

  join: of_sales_team_member {
    view_label: "Gam Mapping"
    type: left_outer
    sql_on: ${of_customer_group.global_account_manager} = ${of_sales_team_member.sales_person} and upper(${of_sales_team_member.team_role}) LIKE 'GLOBAL ACCOUNT MANAGER (GAM)' and inactive = 'false'  ;;
    relationship: many_to_one
  }

  join: of_user {
    view_label: "Gam"
    required_joins: [of_sales_team_member]
    type:left_outer
    #sql_on: trim(lower(${of_customer_group.srep_email})) = trim(lower(${of_user.email})) ;; #DCN-552, Jack, 2022 Mar 14
    #sql_on: trim(lower(${of_customer_group.srep_email})) = trim(lower(${of_user.email_4_join_with_cust})) ;; #DCN-552, Jack, 2022 Mar 14
    sql_on: ${of_customer_group.global_account_manager} = ${of_user.oneforce_id} and ${of_sales_team_member.sales_person} = ${of_user.oneforce_id} ;;
    relationship: many_to_one
  }

  join: of_office_custom{
    view_label: "Gam"
    type:left_outer
    #sql_on: ${v_customer_opus_n_prospect.ofc_cd} = ${of_office.office_code} ;;
    sql_on: RIGHT(${of_user.office_code},5) = ${of_office_custom.office_code} ;;
    relationship: many_to_one
  }

  join: of_reg_ref {
    view_label: "Gam"
    type: left_outer
    sql_on: left(${of_office_custom.location_code},2) = ${of_reg_ref.cust_cnt_cd} ;;
    relationship: many_to_one
  }

}

explore: cust_priority_list {

  join: v_customer_opus_n_prospect {
    view_label: "Customer OPUS"
    type:inner
    sql_on: ${v_customer_opus_n_prospect.cust_cd} = ${cust_priority_list.cust_cd} ;;
    relationship: many_to_one

  }

  join: of_user {
    view_label: "Sales Rep"
    type:left_outer
    sql_on: ${v_customer_opus_n_prospect.of_owner_id} = ${of_user.oneforce_id} ;;
    relationship: many_to_one
  }

  join: of_office_custom{
    view_label: "Office Information"
    type:left_outer
    #sql_on: ${v_customer_opus_n_prospect.ofc_cd} = ${of_office.office_code} ;;
    sql_on: RIGHT(${of_user.office_code},5) = ${of_office_custom.office_code} ;;
    relationship: many_to_one
  }

  join: of_reg_ref {
    view_label: "Office Information"
    type: left_outer
    sql_on: left(${of_office_custom.location_code},2) = ${of_reg_ref.cust_cnt_cd} ;;
    relationship: many_to_one
  }

 #join: of_actuals {
 #  view_label: "Actuals"
 #  type: inner
 #  sql_on: ${v_customer_opus_n_prospect.cust_cd} = ${of_actuals.cnt_cust_cd} ;;
 #  relationship: one_to_many
 #}

  join: of_contact {
    view_label: "Customer Contact Information"
    type: left_outer
    sql_on: ${v_customer_opus_n_prospect.oneforce_id} = ${of_contact.account_id} ;;
    relationship: one_to_many
  }

  join: of_customer_group {
    view_label: "Customer Group"
    type: left_outer
    sql_on: ${v_customer_opus_n_prospect.cust_grp_id} = ${of_customer_group.cust_grp_id} ;;
    relationship: many_to_one
  }
}

explore: v_customer_opus_n_prospect {
  view_label: "Contract Customers"
  # change for DCN-526 to show contract customer regardless of lifting
  always_join: [of_svc_contract, of_customer]


  join: of_svc_contract {
    view_label: "SC/RFA"
    type:inner
    sql_on: ${v_customer_opus_n_prospect.cust_cd} =  ${of_svc_contract.cust_cd} ;;
    relationship: one_to_many
  }

  # end change for DCN-526

  join: of_user_email {
   view_label: "User Email"
   type: left_outer
   sql_on:  lower(trim(${v_customer_opus_n_prospect.srep_eml})) = lower(trim(${of_user_email.email})) ;;
   relationship: many_to_one
 }

  join: of_customer_owner {
    from: of_user
    view_label: "Customer Owner"
    type: left_outer
    sql_on:  ${v_customer_opus_n_prospect.of_owner_id} = ${of_customer_owner.oneforce_id} ;;
    relationship: many_to_one
  }

  join: of_user {
    view_label: "Sales Rep"
    type:left_outer
    #sql_on: lower(trim(${v_customer_opus_n_prospect.srep_eml})) = lower(trim(${of_user.email})) ;; #DCN-552, Jack, 2022 Mar 14
    #sql_on: lower(trim(${v_customer_opus_n_prospect.srep_eml})) = lower(trim(${of_user.email_4_join_with_cust})) ;; #DCN-552, Jack, 2022 Mar 14
    #sql_on: ${v_customer_opus_n_prospect.of_owner_id} = ${of_user.oneforce_id} ;; #DCN-552-followup, Jack, 2022 Mar 23
    sql_on: ${of_user.oneforce_id} = ${of_user_email.oneforce_id} ;;
    relationship: one_to_many
  }

  join: of_office_custom{
    view_label: "Sales Rep Office"
    required_joins: [of_user,of_customer_owner]
    type:left_outer
    #sql_on: ${v_customer_opus_n_prospect.ofc_cd} = ${of_office.office_code} ;;
    #sql_on: ${of_office_custom.office_code} = coalesce((case when of_user.office_code = 'zzUnclaimed - Office' then null else RIGHT(of_user.office_code,5) end),RIGHT(upper(${v_customer_opus_n_prospect.srep_nm}),5));;
    sql_on:  ${of_office_custom.office_code} = coalesce(
                  (case when of_customer_owner.office_code <> 'zzUnclaimed - Office' then RIGHT(of_customer_owner.office_code,5)
                   else (case when of_user.office_code = 'zzUnclaimed - Office' then null
                        when upper(${v_customer_opus_n_prospect.srep_nm}) like 'SALES REP - ONECARE%' then concat(upper(substring(v_customer_opus_n_prospect.srep_eml,4,3)),'BB')
                        else RIGHT(of_user.office_code,5) end) end )
                          ,RIGHT(upper(${v_customer_opus_n_prospect.srep_nm}),5));;
    relationship: many_to_one
  }

  join: of_country {
    view_label: "Sales Rep Country"
    type: left_outer
    sql_on: left(${of_office_custom.location_code},2) = ${of_country.country_code} ;;
    relationship: many_to_one
  }

  join: of_reg_ref {
    view_label: "Sales Rep Region"
    type: left_outer
    sql_on: left(${of_office_custom.location_code},2) = ${of_reg_ref.cust_cnt_cd} ;;
    relationship: many_to_one
  }


  join: of_customer_fy_teu {
    view_label: "FY TEU"
    type: left_outer
    sql_on: ${v_customer_opus_n_prospect.cust_cd} = ${of_customer_fy_teu.cust_cd};;
    relationship: one_to_many
        #and ${of_customer_fy_teu.fiscal_year} = "FY2020";;
  }

  join: of_sales_week_master {
    view_label: "Sales Week Master"
    fields: [of_sales_week_master.fiscal_year, of_sales_week_master.calendar_year, of_sales_week_master.sales_month, of_sales_week_master.sales_week]
    type: left_outer
    sql_on: ${of_customer_fy_teu.sales_week} = ${of_sales_week_master.sales_week};;
    relationship: one_to_many
    #and ${of_customer_fy_teu.fiscal_year} = "FY2020";;
  }

  join: of_customer {
    view_label: "OPUS Customer"
    fields: [of_customer.cust_cd, of_customer.bklst_cust_flg, of_customer.sanc_flg]
    type: inner
    sql_on: ${v_customer_opus_n_prospect.cust_cd} = ${of_customer.cust_cd}
    and coalesce(modi_cust_cd2, 'EMPTY') = {% if v_customer_opus_n_prospect.To_Be_Customer._parameter_value == 'Exclude' %} 'EMPTY'
    {% else %} coalesce(modi_cust_cd2, 'EMPTY')
    {% endif %}
    and coalesce(of_customer.bklst_cust_flg, 'N') = {% if v_customer_opus_n_prospect.Blacklist_Customer._parameter_value == 'Exclude' %} 'N'
    {% else %} coalesce(of_customer.bklst_cust_flg, 'N')
    {% endif %} ;;
    relationship: one_to_one
  }

# join: of_contact {
#   view_label: "Customer Contact Information"
#   type: left_outer
#   sql_on: ${v_customer_opus_n_prospect.oneforce_id} = ${of_contact.account_id} ;;
#   relationship: one_to_many
# }

  join: of_contract_customer_contact {
    view_label: "Contract Customer Contact"
    type: left_outer
    sql_on: ${v_customer_opus_n_prospect.cust_cd} = ${of_contract_customer_contact.cust_cd} ;;
    relationship: one_to_many
  }

  #join: of_primary_contact {
  #  view_label: "Primary Contact"
  #  type: left_outer
  #  sql_on: ${v_customer_opus_n_prospect.oneforce_id} = ${of_primary_contact.customer_oneforce_id} ;;
  #  relationship: one_to_many
  #}

  join: of_customer_group {
    view_label: "Customer Group"
    type: left_outer
    sql_on: ${v_customer_opus_n_prospect.cust_grp_id} = ${of_customer_group.cust_grp_id} ;;
    relationship: many_to_one
  }
}

explore: grp_cust_list {}

explore: ka_mapping {

  view_label: "KA Actuals"
  view_name: ka_actuals
  from: ka_actuals

  join: of_reg_ref {
    view_label: "Contract and Service Country"
    type: inner
    sql_on: ${ka_actuals.ctry_cd} = ${of_reg_ref.cust_cnt_cd};;
    relationship: one_to_one
  }

  join: of_country {
    view_label: "Contract and Service Country"
    type: inner
    sql_on: ${of_reg_ref.cust_cnt_cd}= ${of_country.country_code};;
    relationship: one_to_one
  }

  join: of_ckam_skam_4 {
    view_label: "Sales Mapping"
    type: left_outer
    sql_on: ${of_ckam_skam_4.role} = ${ka_actuals.role_reqd}
          and ${of_ckam_skam_4.country_code} = ${ka_actuals.ctry_cd}
          and ${of_ckam_skam_4.customer_group} =  ${ka_actuals.oneforce_id} ;;
    relationship:  one_to_many
  }

  join: ka_actuals_vol {
    view_label: "Contract Volume and Lifting"
    type: left_outer
    sql_on:  ${ka_actuals_vol.cust_grp_id}= ${ka_actuals.cust_grp_id}
          and  ${ka_actuals_vol.ctry_cd}        like case when ${ka_actuals.role_reqd} = 'GAM' then '%' else ${ka_actuals.ctry_cd} end
          and  ${ka_actuals_vol.office_code}    like case when ${ka_actuals.role_reqd} = 'GAM' then '%' else ${ka_actuals.ofc_cd} end
          and  ${ka_actuals_vol.svc_cont_no}    like case when ${ka_actuals.role_reqd} = 'GAM' then '%' else ${ka_actuals.svc_cont_no} end
          and ${ka_actuals_vol.role} = ${ka_actuals.role_reqd};;
    relationship: many_to_one
  }

  join: ka_actuals_teu_dtl {
    view_label: "Contract Volume and Lifting"
    type: left_outer
    sql_on:  ${ka_actuals_teu_dtl.cust_grp_id}= ${ka_actuals.cust_grp_id}
          and  ${ka_actuals_teu_dtl.ctry_cd}= ${ka_actuals.ctry_cd}
          and   ${ka_actuals_teu_dtl.office_code}= ${ka_actuals.ofc_cd}
          and  ${ka_actuals_teu_dtl.svc_cont_no}= ${ka_actuals.svc_cont_no};;
    relationship: many_to_one
  }

  join: ka_actuals_gam {
    view_label: "GAM"
    type: left_outer
    sql_on: ${ka_actuals_gam.cust_grp_id} = ${ka_actuals.cust_grp_id} and ${ka_actuals_gam.rownum} = 1;;
    relationship: many_to_one
  }

  join: KA_country {
    view_label: "Key Account Country"
    from:  of_country
    type:  left_outer
    sql_on: ${ka_actuals.key_acct_country} = ${KA_country.country_code} ;;
    relationship: many_to_one
  }

  join: Key_Acct_Reg_Ref {
    view_label: "Key Account Locations"
    from:  of_reg_ref
    type:  left_outer
    sql_on: ${KA_country.country_code} = ${Key_Acct_Reg_Ref.cust_cnt_cd} ;;
    relationship: many_to_one
  }

  # join: of_consolidated {
  #   view_label: "GKA volume"
  #   type:  left_outer
  #   sql_on: ${of_consolidated.consolidated_cnt_cust_grp_cd} = ${ka_actuals.cust_grp_id} ;;
  #   sql_where: ${of_consolidated.record_type}='Booking' and ${of_consolidated.week} >= 202014 and ${of_consolidated.week} <= 202113 ;;
  #   fields: [of_consolidated.consolidated_cnt_cust_grp_cd,of_consolidated.record_type,of_consolidated.week,of_consolidated.total_teu,of_consolidated.target_selector,of_consolidated.teu]
  #   relationship: many_to_one
  # }
}

explore: of_user2 {}

explore: of_sales_week_master2 {}

explore: of_consolidated2 {
  always_filter: {filters:[rec_typ_n_bkg_sts_cd: "BKG:F,BKG:S,BKG:W,PLN,TGT"]}
  sql_always_where: ${of_consolidated2.record_type} is not null ;;
  join: POR_location {
    type: left_outer
    sql_on: ${of_consolidated2.por_cd} = ${POR_location.location_code} ;;
    relationship: many_to_one
  }

  join: POR_country {
    type: left_outer
    sql_on: ${of_consolidated2.ori_cnt} = ${POR_country.country_code} ;;  #DCN1009
    relationship: many_to_one
  }

  join: POR_reg_ref {
    view_label: "POR RHQ"
    from: of_reg_ref
    type: left_outer
    sql_on: ${POR_country.country_code} = ${POR_reg_ref.cust_cnt_cd} ;;    #DCN1009
    relationship: many_to_one
  }

  join: DEL_location {
    type: left_outer
    sql_on: ${of_consolidated2.del_cd} = ${DEL_location.location_code} ;;
    relationship: many_to_one
  }

  join: DEL_country {
    type: left_outer
    sql_on: ${DEL_location.country_code} = ${DEL_country.country_code} ;;
    relationship: many_to_one
  }
  join: DEL_reg_ref {
    view_label: "DEL RHQ"
    from: of_reg_ref
    type: left_outer
    sql_on: ${DEL_location.country_code} = ${DEL_reg_ref.cust_cnt_cd} ;;
    relationship: many_to_one
  }

  join: first_POL_location {
    type: left_outer
    sql_on: ${of_consolidated2.n1st_pol_cd} = ${first_POL_location.location_code} ;;
    relationship: many_to_one
  }

  join: first_POL_country {
    type: left_outer
    sql_on: ${first_POL_location.country_code} = ${first_POL_country.country_code} ;;
    relationship: many_to_one
  }

  join: final_POD_location {
    type: left_outer
    sql_on: ${of_consolidated2.final_pod_cd} = ${final_POD_location.location_code} ;;
    relationship: many_to_one
  }

  join: final_POD_country {
    type: left_outer
    sql_on: ${final_POD_location.country_code} = ${final_POD_country.country_code} ;;
    relationship: many_to_one
  }

  join: v_customer_opus_n_prospect {
    view_label: "Customer"
    type: left_outer
    sql_on: ${of_consolidated2.consolidated_cnt_cust_cd} = ${v_customer_opus_n_prospect.cust_cd} AND
            ${of_consolidated2.consolidated_cnt_cust_cd} IS NOT NULL ;;
    relationship: many_to_one
  }

  join: cust_owner {
    from: of_user2
    view_label: "Customer Owner"
    type: left_outer
    sql_on: ${v_customer_opus_n_prospect.of_owner_id} = ${cust_owner.oneforce_id}  ;;
    relationship: many_to_one
  }

  join: of_customer_group {
    view_label: "Customer Group"
    #from: of_customer_group_for_consol2
    from: of_customer_group
    type: left_outer
    sql_on: ${of_consolidated2.consolidated_cnt_cust_grp_cd} = ${of_customer_group.cust_grp_id} ;;
    relationship: many_to_one
  }

  join: of_svc_scp {
    view_label: "Service Scope"
    type: left_outer
    sql_on: ${of_consolidated2.svc_scp_cd} = ${of_svc_scp.service_scope_code} ;;
    relationship: many_to_one
  }

  join: of_svc_scp_grp {
    view_label: "Service Scope Group"
    type: left_outer
    sql_on: ${of_consolidated2.svc_scp_grp_cd} = ${of_svc_scp_grp.service_scope_group_code} AND ${of_consolidated2.svc_scp_grp_cd} IS NOT NULL ;;
    relationship: many_to_one
  }

  join: of_svc_scp_grp_cat {
    view_label: "Service Scope Group Category"
    type: left_outer
    sql_on: ${of_svc_scp_grp.service_scope_group_code} = ${of_svc_scp_grp_cat.svc_scp_grp} ;;
    relationship: many_to_one
  }

  # improve later in BigQuery by matching data type, int was used for partitioning
  join: of_sales_week_master {
    from:  of_sales_week_master2
    view_label: "Sales Week Master"
    type: left_outer
    sql_on: ${of_consolidated2.week} = ${of_sales_week_master.sales_week} ;;
    relationship: many_to_one
  }

  join: of_svc_contract {
    view_label: "Svc/RFA Contract"
    type: left_outer
    sql_on: ${of_consolidated2.svc_cont_no} = ${of_svc_contract.sc_rfa_no} ;;
    relationship: many_to_one
  }

  join: contract_office {
    view_label: "Contract Office Information"
    from: of_office
    type: left_outer
    sql_on: ${of_consolidated2.ctrt_prop_ofc_cd} = ${contract_office.office_code} ;;
    relationship: many_to_one
  }

  join: contract_office_location {
    view_label: "Contract Office Information"
    from: of_location
    type: left_outer
    sql_on: ${contract_office.location_code} = ${contract_office_location.location_code} ;;
    relationship: many_to_one
  }

  join: contract_office_country {
    view_label: "Contract Office Information"
    from: of_country
    type: left_outer
    sql_on: ${contract_office_location.country_code} = ${contract_office_country.country_code} ;;
    relationship: many_to_one
  }

  join: contract_office_region {
    view_label: "Contract Office Information"
    from: of_reg_ref
    type: left_outer
    sql_on: ${contract_office_region.cust_cnt_cd} = ${contract_office_country.country_code};;
    relationship: many_to_one
  }

  # added by YH on 27 May 2023 for booking data for CVA prep
  join: of_svc_contract_dtl {
    view_label: "Svc/RFA Contract Detail"
    type: left_outer
    sql_on: ${of_consolidated2.svc_cont_no} = ${of_svc_contract_dtl.sc_rfa_no} and
      ${of_consolidated2.svc_scp_cd}  = ${of_svc_contract_dtl.svc_scp_cd};;
    relationship:  many_to_one
  }

  join: service_scope_office {
    view_label: "Service Scope Office Information"
    from: of_office
    type: left_outer
    sql_on: ${of_svc_contract_dtl.scp_ofc_cd} = ${service_scope_office.office_code} ;;
    relationship: many_to_one
  }

  join: service_scope_office_location {
    view_label: "Service Scope Office Information"
    from: of_location
    type: left_outer
    sql_on: ${service_scope_office.location_code} = ${service_scope_office_location.location_code} ;;
    relationship: many_to_one
  }

  join: service_scope_office_country {
    view_label: "Service Scope Office Information"
    from: of_country
    type: left_outer
    sql_on: ${service_scope_office_location.country_code} = ${service_scope_office_country.country_code} ;;
    relationship: many_to_one
  }

  join: service_scope_office_region {
    view_label: "Service Scope Office Information"
    from: of_reg_ref
    type: left_outer
    sql_on: ${service_scope_office_region.cust_cnt_cd} = ${service_scope_office_country.country_code};;
    relationship: many_to_one
  }
  # end of YH changes on 30 May 2023 for booking data for CVA prep

  join: of_cif_fob {
    view_label: "SYM CIF/FOB"
    type: left_outer
    sql_on: ${of_cif_fob.modi_svc_grp_cd} = ${of_consolidated2.svc_scp_grp_cd}
            and ${of_cif_fob.dmnt_flg} = (CASE WHEN ${of_consolidated2.dominant_flg} = 'DOM' THEN 'Y' ELSE 'N' END)
            and ${of_cif_fob.ofc_cd} = ${of_consolidated2.ctrt_prop_ofc_cd};;
    relationship: many_to_one
  }

  join: bkg_cncl_reason {
    type: left_outer
    sql_on: ${of_consolidated2.bkg_cxl_rsn_cd} = ${bkg_cncl_reason.code} AND ${of_consolidated2.bkg_sts_cd} = 'X' ;;
    relationship: many_to_one
  }

  join: bkg_cxl_sub_rsn {
    type: left_outer
    sql_on: ${of_consolidated2.bkg_cxl_sub_rsn_cd} = ${bkg_cxl_sub_rsn.bkg_cxl_sub_rsn_cd} AND ${of_consolidated2.bkg_sts_cd} = 'X' ;;
    relationship: many_to_one
  }

  join: of_dep_sched_smry2 {
    view_label: "Deployment Schedule Summary"
    type: left_outer
    sql_on: ${of_dep_sched_smry2.sales_week}        = ${of_sales_week_master.sales_week}         and
            ${of_dep_sched_smry2.trade_code}        = ${of_svc_scp_grp.service_scope_group_code} and
            ${of_dep_sched_smry2.dominant_leg_flag} = 'Y' and
            ${of_consolidated2.svc_scp_grp_cd} IS NOT NULL and
            ${of_consolidated2.record_type}    = 'Target'
            ;;
    relationship: many_to_many
  }

  join: gam_mapping {
    type: left_outer
    sql_on: ${of_consolidated2.consolidated_cnt_cust_grp_cd} = ${gam_mapping.customer_grp_id};;
    relationship: many_to_one
  }

  join: gam {
    from: of_user2
    view_label: "GAM"
    type: left_outer
    sql_on: ${gam_mapping.gam_usr_id} = ${gam.oneforce_id};;
    relationship: many_to_one
  }

  join: ram_mapping {
    type: left_outer
    sql_on: ${of_consolidated2.consolidated_cnt_cust_grp_cd} = ${ram_mapping.customer_grp_id}  and
            ${of_consolidated2.ctrt_prop_rhq_code}           = ${ram_mapping.ram_usr_rhq_code} ;;
    relationship: many_to_one
  }

  join: ram_usr {
    view_label: "RAM (mapped using contract RHQ)"
    from: of_user2
    type: left_outer
    sql_on: ${ram_mapping.ram_usr_id} = ${ram_usr.oneforce_id}  ;;
    relationship: many_to_one
  }

  #join: ckam_mapping {
  #  from: of_sales_team_member_contract_country
  #  type: left_outer
  #  sql_on: ${of_consolidated2.consolidated_cnt_cust_grp_cd} = ${ckam_mapping.cust_grp_id} and
  #          ${of_consolidated2.ctrt_prop_ctry_code}          = ${ckam_mapping.contract_country_code} and
  #          ${ckam_mapping.team_role}                        = 'Contract Key Account Manager (C-KAM)'
  #          ;;
  #  relationship: many_to_many
  #}

  join: ckam_mapping {
    from: ckam_mapping_one_per_office
    type: left_outer
    sql_on: ${of_consolidated2.consolidated_cnt_cust_grp_cd} = ${ckam_mapping.customer_grp_id} and
            ${of_consolidated2.ctrt_prop_ctry_code}          = ${ckam_mapping.contract_country_code} and
            ${of_consolidated2.ctrt_prop_ofc_cd}             = ${ckam_mapping.contract_office_code}
            ;;
    relationship: many_to_one
  }

  join: ckam_usr {
    view_label: "CKAM (mapped using contract country)"
    from: of_user
    type: left_outer
    sql_on: ${of_consolidated2.ckam_sales_person} = ${ckam_usr.oneforce_id} ;;
    relationship: many_to_one
  }

  join: svc_scp_srep_usr {
    view_label: "Service Scope Srep User"
    from: of_user
    type: left_outer
    sql_on: ${of_svc_contract_dtl.srep_eml} = ${svc_scp_srep_usr.username} ;;
    relationship: many_to_one
  }

  join: of_yard_mty_pkup {
    view_label: "Empty Return Pickup Yard"
    from: of_yard
    type: left_outer
    sql_on: ${of_consolidated2.mty_pkup_yd_cd} = ${of_yard_mty_pkup.yd_cd} ;;
    relationship: many_to_one
  }

  join: of_lcn_mty_pkup {
    view_label: "Empty Return Pickup Location"
    from: of_location
    type: left_outer
    sql_on: ${of_yard_mty_pkup.loc_cd} = ${of_lcn_mty_pkup.location_code} ;;
    relationship: many_to_one
  }

  join: of_yard_rtn_pkup {
    view_label: "Empty Return Return Yard"
    from: of_yard
    type: left_outer
    sql_on: ${of_consolidated2.mty_rtn_yd_cd} = ${of_yard_rtn_pkup.yd_cd} ;;
    relationship: many_to_one
  }

  join: of_lcn_mty_rtn {
    view_label: "Empty Return Return Location"
    from: of_location
    type: left_outer
    sql_on: ${of_yard_rtn_pkup.loc_cd} = ${of_lcn_mty_rtn.location_code} ;;
    relationship: many_to_one
  }

  #WH DCN-1110 : Add CKAM Country Name
  join: ckam_country {
    view_label: "CKAM (mapped using contract country)"
    from: of_country
    type: left_outer
    sql_on: UPPER(${ckam_usr.country}) = ${ckam_country.country_name} ;;
    relationship: many_to_one
  }

}

#DCN-848
#explore: of_opp_vs_bkg {
#  extends: [of_consolidated2]
#  view_name: of_consolidated2
#  from:  of_opp_vs_bkg
#  always_filter: {filters:[rec_typ_n_bkg_sts_cd: "BKG:F,BKG:S,BKG:W,PLN,TGT,OPP"]}
#}



explore: of_consolidated {
  view_label: "Actuals + Bookings + Plan + Target"
  view_name: of_consolidated
  from:  of_consolidated


  # improve later in BigQuery by matching data type, int was used for partitioning
  join: of_sales_week_master {
    view_label: "Sales Week Master"
    type: left_outer
    sql_on: ${of_consolidated.week} = cast(${of_sales_week_master.sales_week} as int64) ;;
    relationship: many_to_one
  }

  #NA dashboard : to join with na_landing_last_n_week
  join: na_landing_last_n_week {
    type: inner
    relationship: one_to_one
    sql_on: ${of_sales_week_master.sales_week} = ${na_landing_last_n_week.sales_week} ;;
  }

  # Route Information
  join: actual_empty_pick_up_location {
    type: left_outer
    sql_on: ${of_consolidated.act_mty_pkup_scc_cd} = ${actual_empty_pick_up_location.location_code} ;;
    relationship: many_to_one
  }
  join: actual_empty_pick_up_region {
    type: left_outer
    sql_on: ${actual_empty_pick_up_location.region_code} = ${actual_empty_pick_up_region.code} ;;
    relationship: many_to_one
  }
  join: actual_empty_pick_up_country {
    type: left_outer
    sql_on: ${actual_empty_pick_up_location.country_code} = ${actual_empty_pick_up_country.country_code} ;;
    relationship: many_to_one
  }
  join: actual_empty_return_location {
    type: left_outer
    sql_on: ${of_consolidated.mty_rtn_scc_cd} = ${actual_empty_return_location.location_code};;
    relationship: many_to_one
  }
  join: actual_empty_return_region {
    type: left_outer
    sql_on: ${actual_empty_return_location.region_code} = ${actual_empty_return_region.code} ;;
    relationship: many_to_one
  }
  join: actual_empty_return_country {
    type: left_outer
    sql_on: ${actual_empty_return_location.country_code} = ${actual_empty_return_country.country_code} ;;
    relationship: many_to_one
  }
  join: estimated_empty_pick_up_location {
    type: left_outer
    sql_on: ${of_consolidated.mty_pkup_scc_cd} = ${estimated_empty_pick_up_location.location_code} ;;
    relationship: many_to_one
  }
  join: estimated_empty_pick_up_region {
    type: left_outer
    sql_on: ${estimated_empty_pick_up_location.region_code} = ${estimated_empty_pick_up_region.code} ;;
    relationship: many_to_one
  }
  join: estimated_empty_pick_up_country {
    type: left_outer
    sql_on: ${estimated_empty_pick_up_location.country_code} = ${estimated_empty_pick_up_country.country_code} ;;
    relationship: many_to_one
  }
  join: estimated_empty_return_location {
    type: left_outer
    sql_on: ${of_consolidated.bkg_mty_rtn_scc_cd} = ${estimated_empty_return_location.location_code} ;;
    relationship: many_to_one
  }
  join: estimated_empty_return_region {
    type: left_outer
    sql_on: ${estimated_empty_return_location.region_code} = ${estimated_empty_return_region.code} ;;
    relationship: many_to_one
  }
  join: estimated_empty_return_country {
    type: left_outer
    sql_on: ${estimated_empty_return_location.country_code} = ${estimated_empty_return_country.country_code} ;;
    relationship: many_to_one
  }
  join: first_POD_location {
    type: left_outer
    sql_on: ${of_consolidated.n1st_pod_cd} = ${first_POD_location.location_code} ;;
    relationship: many_to_one
  }
  join: first_POD_region {
    type: left_outer
    sql_on: ${first_POD_location.region_code} = ${first_POD_region.code} ;;
    relationship: many_to_one
  }
  join: first_POD_country {
    type: left_outer
    sql_on: ${first_POD_location.country_code} = ${first_POD_country.country_code} ;;
    relationship: many_to_one
  }
  join: first_POL_location {
    type: left_outer
    sql_on: ${of_consolidated.n1st_pol_cd} = ${first_POL_location.location_code} ;;
    relationship: many_to_one
  }
  join: first_POL_region {
    type: left_outer
    sql_on: ${first_POL_location.region_code} = ${first_POL_region.code} ;;
    relationship: many_to_one
  }
  join: first_POL_country {
    type: left_outer
    sql_on: ${first_POL_location.country_code} = ${first_POL_country.country_code} ;;
    relationship: many_to_one
  }
  join: final_POD_location {
    type: left_outer
    sql_on: ${of_consolidated.final_pod_cd} = ${final_POD_location.location_code} ;;
    relationship: many_to_one
  }
  join: final_POL_region {
    type: left_outer
    sql_on: ${final_POD_location.region_code} = ${final_POL_region.code} ;;
    relationship: many_to_one
  }
  join: final_POL_country {
    type: left_outer
    sql_on: ${final_POD_location.country_code} = ${final_POL_country.country_code} ;;
    relationship: many_to_one
  }
  join: trunk_POD_location {
    type: left_outer
    sql_on: ${of_consolidated.pod_loc_cd} = ${trunk_POD_location.location_code} ;;
    relationship: many_to_one
  }
  join: trunk_POD_region {
    type: left_outer
    sql_on: ${trunk_POD_location.region_code} = ${trunk_POD_region.code} ;;
    relationship: many_to_one
  }
  join: trunk_POD_country {
    type: left_outer
    sql_on: ${trunk_POD_location.country_code} = ${trunk_POD_country.country_code} ;;
    relationship: many_to_one
  }
  join: trunk_POL_location {
    type: left_outer
    sql_on: ${of_consolidated.pol_loc_cd} = ${trunk_POL_location.location_code} ;;
    relationship: many_to_one
  }
  join: trunk_POL_region {
    type: left_outer
    sql_on: ${trunk_POL_location.region_code} = ${trunk_POL_region.code} ;;
    relationship: many_to_one
  }
  join: trunk_POL_country {
    type: left_outer
    sql_on: ${trunk_POL_location.country_code} = ${trunk_POL_country.country_code} ;;
    relationship: many_to_one
  }
  join: DEL_location {
    type: left_outer
    sql_on: ${of_consolidated.del_cd} = ${DEL_location.location_code} ;;
    relationship: many_to_one
  }
  join: DEL_region {
    type: left_outer
    sql_on: ${DEL_location.region_code} = ${DEL_region.code} ;;
    relationship: many_to_one
  }
  join: DEL_country {
    type: left_outer
    sql_on: ${DEL_location.country_code} = ${DEL_country.country_code} ;;
    relationship: many_to_one
  }
  join: DEL_reg_ref {
    view_label: "DEL RHQ"
    from: of_reg_ref
    type: left_outer
    sql_on: ${DEL_location.country_code} = ${DEL_reg_ref.cust_cnt_cd} ;;
    relationship: many_to_one
  }
  join: POR_location {
    type: left_outer
    sql_on: ${of_consolidated.por_cd} = ${POR_location.location_code} ;;
    relationship: many_to_one
  }
  join: POR_region {
    type: left_outer
    sql_on: ${POR_location.region_code} = ${POR_region.code} ;;
    relationship: many_to_one
  }
  join: POR_reg_ref {
    view_label: "POR RHQ"
    from: of_reg_ref
    type: left_outer
    sql_on: ${POR_location.country_code} = ${POR_reg_ref.cust_cnt_cd} ;;
    relationship: many_to_one
  }
  join: POR_country {
    type: left_outer
    sql_on: ${POR_location.country_code} = ${POR_country.country_code} ;;
    relationship: many_to_one
  }
  # Office Information
  join: bkg_office {
    view_label: "Office Information"
    from: of_office
    type: left_outer
    sql_on: ${of_consolidated.bkg_ofc_cd} = ${bkg_office.office_code} ;;
    relationship: many_to_one
  }
  join: bkg_office_location {
    view_label: "Office Information"
    from:  of_location
    type: left_outer
    sql_on: ${bkg_office.location_code} = ${bkg_office_location.location_code} ;;
    relationship: many_to_one
  }
  join: bkg_office_country {
    view_label: "Office Information"
    from: of_country
    sql_on: ${bkg_office_location.country_code} = ${bkg_office_country.country_code} ;;
    relationship: many_to_one
  }
  join: bkg_office_region {
    view_label: "Office Information"
    from: of_region
    type: left_outer
    sql_on: ${bkg_office_location.region_code} = ${bkg_office_region.code} ;;
    relationship: many_to_one
  }
  join: of_commodity {
    view_label: "Commodity"
    type: left_outer
    sql_on: ${of_consolidated.cmdt_cd} = ${of_commodity.commodity_code} ;;
    relationship: many_to_one
  }

  join: of_svc_scp {
    view_label: "Service Scope"
    type: left_outer
    sql_on: ${of_consolidated.svc_scp_cd} = ${of_svc_scp.service_scope_code} ;;
    relationship: many_to_one
  }

  join: of_svc_scp_grp {
    view_label: "Service Scope Group"
    type: left_outer
    sql_on: ${of_consolidated.svc_scp_grp_cd} = ${of_svc_scp_grp.service_scope_group_code} AND ${of_consolidated.svc_scp_grp_cd} IS NOT NULL ;;
    relationship: many_to_one
  }
  join: of_cntr_tpsz {
    view_label: "Equipment"
    type: left_outer
    sql_on: ${of_consolidated.consolidated_cntr_tpsz} = ${of_cntr_tpsz.type_size_code} ;;
    relationship: many_to_one
  }
  join: equipment_category {
    view_label: "Equipment Category"
    type: left_outer
    sql_on: ${of_cntr_tpsz.type_size_code} = ${equipment_category.equipment_type_size} ;;
    relationship: many_to_one
  }
  join: v_customer_opus_n_prospect {
    view_label: "Customer"
    type: left_outer
    sql_on: ${of_consolidated.consolidated_cnt_cust_cd} = ${v_customer_opus_n_prospect.cust_cd}
      AND ${of_consolidated.consolidated_cnt_cust_cd} IS NOT NULL ;;
    relationship: many_to_one
  }
  join: of_sales_team_members {
    view_label: "Sales Team Members"
    from: of_sales_team_member
    type: left_outer
    sql_on: ${v_customer_opus_n_prospect.oneforce_id} = ${of_sales_team_members.customer} and ${of_sales_team_members.inactive} = 'false' ;;
    relationship: one_to_many
  }
  join: of_sales_team_member_user {
    view_label: "Sales Team Member"
    from: of_user
    type: left_outer
    sql_on: ${of_sales_team_members.sales_person} = ${of_sales_team_member_user.oneforce_id} ;;
    relationship: many_to_one
  }
  join: of_customer_group {
    view_label: "Customer Group"
    type: left_outer
    sql_on: ${of_consolidated.consolidated_cnt_cust_grp_cd} = ${of_customer_group.cust_grp_id} ;;
    relationship: many_to_one
  }
  join: of_customer_owner {
    view_label: "Customer Owner"
    from: of_user
    type: left_outer
    sql_on: ${v_customer_opus_n_prospect.of_owner_id} = ${of_customer_owner.oneforce_id} ;;
    relationship: many_to_one
  }
  join: of_one_team_membership {
    view_label: "Team Membership"
    type: left_outer
    sql_on: ${of_customer_owner.oneforce_id} = ${of_one_team_membership.team_member} ;;
    relationship: one_to_many
  }
  join: of_one_team {
    view_label: "Teams"
    type: left_outer
    sql_on: ${of_one_team_membership.team} = ${of_one_team.oneforce_id} ;;
    relationship: many_to_one
  }

  #by Jack, when sudoing as Wallce, Jul 12
  join: of_svc_contract {
    view_label: "Service Contract"
    type: left_outer
    sql_on: ${of_consolidated.svc_cont_no} = ${of_svc_contract.sc_rfa_no} ;;
    relationship: many_to_one
  }

  join: ram{
    view_label: "Ram"
    from: of_user
    type: left_outer
    sql_on: ${of_consolidated.ram} = ${ram.oneforce_id} ;;
    relationship: many_to_one
  }

  #add by LeeYH on 25-Jul-2022 for DCN-744
  join: of_one_team_membership_ram {
    view_label: "Ram's Team"
    from:  of_one_team_membership
    type: left_outer
    sql_on: ${ram.oneforce_id} = ${of_one_team_membership_ram.team_member} ;;
    relationship: one_to_many
  }
  join: of_one_team_ram {
    view_label: "Ram's Team"
    from: of_one_team
    type: left_outer
    sql_on: ${of_one_team_membership_ram.team} = ${of_one_team_ram.oneforce_id} ;;
    relationship: many_to_one
  }

  join: of_dep_sched_smry {
    view_label: "Deployment Schedule Summary"
    type: full_outer
    sql_on: ${of_dep_sched_smry.sales_week} = ${of_sales_week_master.sales_week}
            and ${of_dep_sched_smry.trade_code} =  ${of_svc_scp_grp.service_scope_group_code} and ${of_consolidated.svc_scp_grp_cd} IS NOT NULL
            and ${of_consolidated.record_type} = 'Target'
            and ${of_dep_sched_smry.dominant_leg_flag} ='Y';;
    relationship: many_to_many
  }

  join: of_sales_team_member {
    view_label: "Gam Mapping"
    type: left_outer
    sql_on: ${of_customer_group.global_account_manager} = ${of_sales_team_member.sales_person} and upper(${of_sales_team_member.team_role}) LIKE 'GLOBAL ACCOUNT MANAGER (GAM)'
            and ${of_sales_team_member.inactive}  = 'false' ;;
    relationship: many_to_one
  }

  join: gam {
    view_label: "Gam"
    from: of_user
    required_joins: [of_sales_team_member]
    type: left_outer
    sql_on: ${of_customer_group.global_account_manager} = ${gam.oneforce_id} and ${of_sales_team_member.sales_person} = ${gam.oneforce_id}
            and ${of_sales_team_member.inactive} = 'false' ;;
    #sql_on: ${of_customer_group.global_account_manager} = ${gam.oneforce_id} ;;
    relationship: many_to_one
  }

  join: gam_manager {
    view_label: "Gam Manager"
    from: of_user
    type: left_outer
    sql_on: ${gam.manager_id} = ${gam_manager.oneforce_id} ;;
    relationship: many_to_one
  }
  join: gam_office {
    view_label: "Gam Office"
    from: of_office
    type: left_outer
    sql_on: ${gam.office_code_number} = ${gam_office.office_code} ;;
    relationship: many_to_one
}

  join: of_one_team_membership_gam {
    view_label: "Gam's Team"
    from:  of_one_team_membership
    type: left_outer
    sql_on: ${gam.oneforce_id} = ${of_one_team_membership_gam.team_member} ;;
    relationship: one_to_many
  }
  join: of_one_team_gam {
    view_label: "Gam's Team"
    from: of_one_team
    type: left_outer
    sql_on: ${of_one_team_membership_gam.team} = ${of_one_team_gam.oneforce_id} ;;
    relationship: many_to_one
  }

  # add by Helen on 12-Oct-2021
  join: contract_office {
    view_label: "Contract Office Information"
    from: of_office
    type: left_outer
    sql_on: ${of_consolidated.ctrt_prop_ofc_cd} = ${contract_office.office_code} ;;
    relationship: many_to_one
  }

  join: contract_office_location {
    view_label: "Contract Office Information"
    from: of_location
    type: left_outer
    sql_on: ${contract_office.location_code} = ${contract_office_location.location_code} ;;
    relationship: many_to_one
  }

  join: contract_office_country {
    view_label: "Contract_Office Information"
    from: of_country
    type: left_outer
    sql_on: ${contract_office_location.country_code} = ${contract_office_country.country_code} ;;
    relationship: many_to_one
  }

  # add by Helen for DCN-469
  join: contract_office_region {
    view_label: "Contract Office Information"
    from: of_reg_ref
    type: left_outer
    sql_on: ${contract_office_region.cust_cnt_cd} = ${contract_office_country.country_code};;
    relationship: many_to_one
  }

  join: contract_salesrep {
    view_label: "Contract Sales Rep"
    from: of_user
    type: left_outer
    #sql_on: lower(trim(${contract_salesrep.email})) = lower(trim(${of_consolidated.ctrt_prop_srep_eml}));; #DCN-552, Jack, 2022 Mar 14
    sql_on: lower(trim(${contract_salesrep.email_4_join_with_cust})) = lower(trim(${of_consolidated.ctrt_prop_srep_eml}));;  #DCN-552, Jack, 2022 Mar 14
    relationship: many_to_one
  }

  join: contract_salesrep_office {
    view_label: "Contract Sales Rep"
    from: of_office_custom
    required_joins: [contract_salesrep]
    type: left_outer
    sql_on: ${contract_salesrep_office.office_code} = coalesce(RIGHT(contract_salesrep.office_code,5),RIGHT(${of_consolidated.ctrt_prop_srep_nm},5));;
    relationship: many_to_one
  }

  # end add by Helen for DCN-469

  join: of_cif_fob {
    view_label: "SYM CIF/FOB"
    type: left_outer
    sql_on: ${of_cif_fob.modi_svc_grp_cd} = ${of_consolidated.svc_scp_grp_cd}
            and ${of_cif_fob.dmnt_flg} = (CASE WHEN ${of_consolidated.dominant_flg} = 'DOM' THEN 'Y' ELSE 'N' END)
            and ${of_cif_fob.ofc_cd} = ${of_consolidated.ctrt_prop_ofc_cd};;
    relationship: many_to_one
  }
  # end add by Helen on 12-Oct-2021

  join: ap_submission_office {
    view_label: "AP Submission Office"
    from:  of_office
    type: left_outer
    sql_on: ${of_consolidated.ctrt_scp_srep_ofc_cd} = ${ap_submission_office.office_code} ;;
    relationship: many_to_one
  }
  join: ap_submission_location {
    view_label: "AP Submission Country Code"
    from:  of_location
    type: left_outer
    sql_on: ${ap_submission_office.location_code} = ${ap_submission_location.location_code} ;;
    relationship: many_to_one
  }
  join: ap_submission_country {
    view_label: "AP Submission Country"
    from: of_country
    sql_on: ${ap_submission_location.country_code} = ${ap_submission_country.country_code} ;;
    relationship: many_to_one
  }

  join: loading_office {
    view_label: "Loading Office"
    from:  of_office
    type: left_outer
    sql_on: ${of_consolidated.ob_sls_ofc_cd} = ${loading_office.office_code} ;;
    relationship: many_to_one
  }
  join: loading_country_code {
    view_label: "Loading Country Code"
    from:  of_location
    type: left_outer
    sql_on: ${loading_office.location_code} = ${loading_country_code.location_code} ;;
    relationship: many_to_one
  }
  join: loading_country {
    view_label: "Loading Country"
    from: of_country
    #sql_on: ${loading_country_code.country_code} = ${loading_country.country_code} ;; -- change for dcn618
    sql_on: case when ${of_consolidated.record_type} = 'Target' then ${of_consolidated.ori_cnt} else ${loading_country_code.country_code} end = ${loading_country.country_code}  ;;
    relationship: many_to_one
  }
  join: of_user {
    view_label: "User"
    from: of_user
    type: left_outer
    #sql_on: trim(lower(${of_svc_contract.srep_eml})) = trim(lower(${of_user.email})) ;; #DCN-552, Jack, 2022 Mar 14
    sql_on: trim(lower(${of_svc_contract.srep_eml})) = trim(lower(${of_user.email_4_join_with_cust})) ;;  #DCN-552, Jack, 2022 Mar 14
    #relationship: one_to_many # Jack Jun -16 correct it from one_to_many to many_to_one
    relationship: many_to_one
  }

  ## DCN-741 NA dashboard -- introduce CVA into NA dashboard
  join: na_user_sales_rep_in_contract_n_budget {
    view_label: "Sales Rep in Contract and Budget"
    type: left_outer
    relationship: many_to_one
    sql_on: ${of_consolidated.na_dashboard_sls_person} = ${na_user_sales_rep_in_contract_n_budget.oneforce_id} ;;
  }

  ## DCN-854 Service Scope Level Sales Rep
  join: na_user_scrfa_main_sls_rep {
    from:  na_user_sales_rep_in_contract_n_budget
    type: left_outer
    relationship: many_to_one
    sql_on: trim(lower(${of_svc_contract.srep_eml})) = trim(lower(${na_user_scrfa_main_sls_rep.email_4_join_with_cust})) ;;
  }

  join: na_user_scrfa_dtl_sls_rep {
    from:  na_user_sales_rep_in_contract_n_budget
    type: left_outer
    relationship: many_to_one
    sql_on: ${of_consolidated.na_dashboard_sls_person} = ${na_user_scrfa_dtl_sls_rep.oneforce_id} ;;
  }


##  ## Add by Zoe 6 Dec 2021 ##
## join: Key_Account_country_SYM{
##   view_label: "Key Account Country SYM"
##   from:  of_country
##   type:  left_outer
##   sql_on: ${of_customer_group.key_acct_cnt_cd} = ${Key_Account_country_SYM.country_code} ;;
##   relationship: many_to_one
## }

}

explore: customer_volume_performance {
  extends: [of_consolidated]
  sql_always_where: ${of_consolidated.record_type} != 'Plan' ;;

  join: of_dep_sched_smry {
    view_label: "Deployment Schedule Summary"
    type: full_outer
    sql_on: ${of_dep_sched_smry.sales_week} = ${of_sales_week_master.sales_week}
            and ${of_dep_sched_smry.trade_code} =  ${of_svc_scp_grp.service_scope_group_code} and ${of_consolidated.svc_scp_grp_cd} IS NOT NULL
            and ${of_consolidated.record_type} = 'Target'
            and ${of_dep_sched_smry.dominant_leg_flag} ='Y';;
    relationship: many_to_many
  }

  join: service_contract_sales_rep {
    view_label: "Service Contract Sales Rep"
    from: of_user
    type: left_outer
    # sql_on: trim(lower(${of_svc_contract.srep_eml})) = trim(lower(${service_contract_sales_rep.email})) ;; #DCN-552, Jack, 2022 Mar 14
    sql_on: trim(lower(${of_svc_contract.srep_eml})) = trim(lower(${service_contract_sales_rep.email_4_join_with_cust})) ;; #DCN-552, Jack, 2022 Mar 14
    #relationship: one_to_many # Jack Jun -16 correct it from one_to_many to many_to_one
    relationship: many_to_one
  }

  join: loading_office {
    view_label: "Loading Office"
    from:  of_office
    type: left_outer
    sql_on: ${of_consolidated.ob_sls_ofc_cd} = ${loading_office.office_code} ;;
    relationship: many_to_one
  }
  join: loading_country_code {
    view_label: "Loading Office Loocation"
    from:  of_location
    type: left_outer
    sql_on: ${loading_office.location_code} = ${loading_country_code.location_code} ;;
    relationship: many_to_one
  }
  join: loading_country {
    view_label: "Loading Office Country"
    from: of_country
    type: left_outer
    sql_on: ${loading_country_code.country_code} = ${loading_country.country_code} ;;
    relationship: many_to_one
  }

  # join: of_actuals {
  #   view_label: "Actuals"
  #   type: left_outer
  #   sql_on:  ${of_consolidated.bkg_no} = ${of_actuals.bkg_no}
  #     AND ${of_consolidated.consolidated_cntr_tpsz} = ${of_actuals.cntr_tpsz_cd}
  #     AND ${of_consolidated.record_type} = 'Actual';;
  #   relationship: one_to_one
  #   fields: [of_actuals.non_consolidated*]
  # }
  # join: of_booking {
  #   view_label: "Booking"
  #   type: left_outer
  #   sql_on:  ${of_consolidated.bkg_no} = ${of_booking.bkg_no}
  #     AND ${of_consolidated.consolidated_cntr_tpsz} = ${of_booking.cntr_tpsz}
  #     AND ${of_consolidated.record_type} = 'Booking';;
  #   relationship: one_to_one
  #   fields: [of_booking.non_consolidated*]
  # }
}

explore: key_account_performance {
  extends: [of_consolidated]

  #join: of_vsl_svc_lane {
  #  type: left_outer
  #  sql_on: ${of_consolidated.slane_cd} = ${of_vsl_svc_lane.service_lane_code} ;;
  #  relationship: many_to_one
  #}
  #join: gam {
  #  from: of_user
  #  type: left_outer
  #  sql_on: ${of_customer_group.global_account_manager} = ${gam.oneforce_id} ;;
  #  relationship: many_to_one
  #}
  #join: gam_manager {
  #  from: of_user
  #  type: left_outer
  #  sql_on: ${gam.manager_id} = ${gam_manager.oneforce_id} ;;
  #  relationship: many_to_one
  #}
  #join: gam_office {
  #  from: of_office
  #  type: left_outer
  #  sql_on: ${gam.office_code_number} = ${gam_office.office_code} ;;
  #  relationship: many_to_one
  #}
  #join: of_one_team_membership {
  #  type: left_outer
  #  sql_on: ${gam.oneforce_id} = ${of_one_team_membership.team_member} ;;
  #  relationship: one_to_many
  #}
  #join: of_one_team {
  #  view_label: "GAM's Team"
  #  type: left_outer
  #  sql_on: ${of_one_team_membership.team} = ${of_one_team.oneforce_id} ;;
  #  relationship: many_to_one
  #}
  #join: ram{
  #  from: of_user
  #  type: left_outer
  #  sql_on: ${of_consolidated.ram} = ${ram.oneforce_id} ;;
  #  relationship: many_to_one
  #}
  # join: of_dep_sched_smry {
  #   view_label: "Deployment Schedule Summary"
  #   type: full_outer
  #   sql_on: ${of_dep_sched_smry.sales_week} = ${of_sales_week_master.sales_week}
  #           and ${of_dep_sched_smry.trade_code} =  ${of_svc_scp_grp.service_scope_group_code} and ${of_consolidated.svc_scp_grp_cd} IS NOT NULL
  #           and ${of_consolidated.record_type} = 'Target'
  #           and ${of_dep_sched_smry.dominant_leg_flag} ='Y';;
  #   relationship: many_to_many
  # }
}

explore: of_booking {
  label: "Bookings"

  join: of_sales_week_master {
    view_label: "Sales Week Master"
    type: left_outer
    sql_on: ${of_booking.week} = cast(${of_sales_week_master.sales_week} as int64) ;;
    relationship: many_to_one
  }
  join: v_booking_cancellation_teu_drop {
    type: inner
    #    sql_on: ${of_booking.bkg_no} = ${v_booking_cancellation_teu_drop.base_bkg_no} ;;
    # Jack, DCN-515
    sql_on: ${of_booking.bkg_no} = ${v_booking_cancellation_teu_drop.bkg_no} AND ${of_booking.cntr_tpsz} = ${v_booking_cancellation_teu_drop.cntr_tpsz}   ;;
    relationship: one_to_one
  }
  join: bkg_cncl_reason {
    type: left_outer
    sql_on: ${of_booking.bkg_cxl_rsn_cd} = ${bkg_cncl_reason.code} AND ${of_booking.bkg_sts_cd} = 'X';;
    relationship: many_to_one
  }
  join: of_vsl_svc_lane {
    view_label: "Vessel Service Lane"
    type: left_outer
    sql_on: ${of_booking.slane_cd} = ${of_vsl_svc_lane.service_lane_code} ;;
    relationship: many_to_one
  }
  join: of_svc_scp {
    view_label: "Service Scope"
    type: left_outer
    sql_on: ${of_booking.svc_scp_cd} = ${of_svc_scp.service_scope_code} ;;
    relationship: many_to_one
  }
  join: of_svc_scp_grp {
    view_label: "Service Scope Group"
    type: left_outer
    sql_on: ${of_svc_scp.service_scope_group_code} = ${of_svc_scp_grp.service_scope_group_code};;
    relationship: many_to_one
  }
  join: of_cntr_tpsz {
    view_label: "Equipment Type Size"
    type: left_outer
    sql_on: ${of_booking.cntr_tpsz} = ${of_cntr_tpsz.type_size_code} ;;
    relationship: many_to_one
  }
  join: v_customer_opus_n_prospect {
    view_label: "Customer"
    type: left_outer
    sql_on: ${of_booking.ctrt_cust_cd} = ${v_customer_opus_n_prospect.cust_cd}
      AND ${v_customer_opus_n_prospect.cust_cd} IS NOT NULL  ;;
    relationship: many_to_one
  }
  join: of_customer_group {
    view_label: "Customer Group"
    type: left_outer
    sql_on: ${v_customer_opus_n_prospect.cust_grp_id} = ${of_customer_group.cust_grp_id} ;;
    relationship: many_to_one
  }
  join: of_salesperson {
    from: of_user
    type: left_outer
    # sql_on: trim(lower(${v_customer_opus_n_prospect.srep_eml})) = trim(lower(${of_salesperson.email})) ;; #DCN-552, Jack, 2022 Mar 14
    # sql_on: trim(lower(${v_customer_opus_n_prospect.srep_eml})) = trim(lower(${of_salesperson.email_4_join_with_cust})) ;; #DCN-552, Jack, 2022 Mar 14
    sql_on: ${v_customer_opus_n_prospect.of_owner_id} = ${of_salesperson.oneforce_id} ;; #DCN-552-followup, Jack, 2022 Mar 23
    relationship: one_to_many
  }
  join: of_one_team_membership {
    view_label: "Team Membership"
    type: left_outer
    sql_on: ${of_salesperson.oneforce_id} = ${of_one_team_membership.team_member} ;;
    relationship: one_to_many
  }
  join: of_one_team {
    view_label: "Team Master"
    type: left_outer
    sql_on: ${of_one_team_membership.team} = ${of_one_team.oneforce_id} ;;
    relationship: many_to_one
  }
  # Office Information
  join: bkg_office {
    from: of_office
    type: left_outer
    sql_on: ${of_booking.bkg_ofc_cd} = ${bkg_office.office_code} ;;
    relationship: many_to_one
  }
  join: bkg_office_location {
    view_label: "Office Information"
    from:  of_location
    type: left_outer
    sql_on: ${bkg_office.location_code} = ${bkg_office_location.location_code} ;;
    relationship: many_to_one
  }
  join: bkg_office_country {
    view_label: "Office Information"
    from: of_country
    sql_on: ${bkg_office_location.country_code} = ${bkg_office_country.country_code} ;;
    relationship: many_to_one
  }
  join: bkg_office_region {
    view_label: "Office Information"
    from: of_region
    type: left_outer
    sql_on: ${bkg_office_location.region_code} = ${bkg_office_region.code} ;;
    relationship: many_to_one
  }
  join: contract_office {
    from:  of_office
    type: left_outer
    sql_on: ${of_booking.ctrt_prop_ofc_cd} = ${contract_office.office_code} ;;
    relationship: many_to_one
  }
  join: contract_office_location {
    from:  of_location
    type: left_outer
    sql_on: ${contract_office.location_code} = ${contract_office_location.location_code} ;;
    relationship: many_to_one
  }
  join: contract_office_region {
    view_label: "Office Information"
    from: of_region
    type: left_outer
    sql_on: ${contract_office_location.region_code} = ${contract_office_region.code} ;;
    relationship: many_to_one
  }
  join: contract_office_country {
    from: of_country
    sql_on: ${contract_office_location.country_code} = ${contract_office_country.country_code} ;;
    relationship: many_to_one
  }
  # Route Information
  join: actual_empty_pick_up_location {
    type: left_outer
    sql_on: ${of_booking.act_mty_pkup_scc_cd} = ${actual_empty_pick_up_location.location_code} ;;
    relationship: many_to_one
  }
  join: actual_empty_pick_up_region {
    type: left_outer
    sql_on: ${actual_empty_pick_up_location.region_code} = ${actual_empty_pick_up_region.code} ;;
    relationship: many_to_one
  }
  join: actual_empty_pick_up_country {
    type: left_outer
    sql_on: ${actual_empty_pick_up_location.country_code} = ${actual_empty_pick_up_country.country_code} ;;
    relationship: many_to_one
  }
  join: actual_empty_return_location {
    type: left_outer
    sql_on: ${of_booking.mty_rtn_scc_cd} = ${actual_empty_return_location.location_code};;
    relationship: many_to_one
  }
  join: actual_empty_return_region {
    type: left_outer
    sql_on: ${actual_empty_return_location.region_code} = ${actual_empty_return_region.code} ;;
    relationship: many_to_one
  }
  join: actual_empty_return_country {
    type: left_outer
    sql_on: ${actual_empty_return_location.country_code} = ${actual_empty_return_country.country_code} ;;
    relationship: many_to_one
  }
  join: estimated_empty_pick_up_location {
    type: left_outer
    sql_on: ${of_booking.mty_pkup_scc_cd} = ${estimated_empty_pick_up_location.location_code} ;;
    relationship: many_to_one
  }
  join: estimated_empty_pick_up_region {
    type: left_outer
    sql_on: ${estimated_empty_pick_up_location.region_code} = ${estimated_empty_pick_up_region.code} ;;
    relationship: many_to_one
  }
  join: estimated_empty_pick_up_country {
    type: left_outer
    sql_on: ${estimated_empty_pick_up_location.country_code} = ${estimated_empty_pick_up_country.country_code} ;;
    relationship: many_to_one
  }
  join: estimated_empty_return_location {
    type: left_outer
    sql_on: ${of_booking.bkg_mty_rtn_scc_cd} = ${estimated_empty_return_location.location_code} ;;
    relationship: many_to_one
  }
  join: estimated_empty_return_region {
    type: left_outer
    sql_on: ${estimated_empty_return_location.region_code} = ${estimated_empty_return_region.code} ;;
    relationship: many_to_one
  }
  join: estimated_empty_return_country {
    type: left_outer
    sql_on: ${estimated_empty_return_location.country_code} = ${estimated_empty_return_country.country_code} ;;
    relationship: many_to_one
  }
  join: first_POD_location {
    type: left_outer
    sql_on: ${of_booking.n1st_pod_cd} = ${first_POD_location.location_code} ;;
    relationship: many_to_one
  }
  join: first_POD_region {
    type: left_outer
    sql_on: ${first_POD_location.region_code} = ${first_POD_region.code} ;;
    relationship: many_to_one
  }
  join: first_POD_country {
    type: left_outer
    sql_on: ${first_POD_location.country_code} = ${first_POD_country.country_code} ;;
    relationship: many_to_one
  }
  join: first_POL_location {
    type: left_outer
    sql_on: ${of_booking.n1st_pol_cd} = ${first_POL_location.location_code} ;;
    relationship: many_to_one
  }
  join: first_POL_region {
    type: left_outer
    sql_on: ${first_POL_location.region_code} = ${first_POL_region.code} ;;
    relationship: many_to_one
  }
  join: first_POL_country {
    type: left_outer
    sql_on: ${first_POL_location.country_code} = ${first_POL_country.country_code} ;;
    relationship: many_to_one
  }
  join: final_POD_location {
    type: left_outer
    sql_on: ${of_booking.final_pod_cd} = ${final_POD_location.location_code} ;;
    relationship: many_to_one
  }
  join: final_POL_region {
    type: left_outer
    sql_on: ${final_POD_location.region_code} = ${final_POL_region.code} ;;
    relationship: many_to_one
  }
  join: final_POL_country {
    type: left_outer
    sql_on: ${final_POD_location.country_code} = ${final_POL_country.country_code} ;;
    relationship: many_to_one
  }
  join: trunk_POD_location {
    type: left_outer
    sql_on: ${of_booking.pod_loc_cd} = ${trunk_POD_location.location_code} ;;
    relationship: many_to_one
  }
  join: trunk_POD_region {
    type: left_outer
    sql_on: ${trunk_POD_location.region_code} = ${trunk_POD_region.code} ;;
    relationship: many_to_one
  }
  join: trunk_POD_country {
    type: left_outer
    sql_on: ${trunk_POD_location.country_code} = ${trunk_POD_country.country_code} ;;
    relationship: many_to_one
  }
  join: trunk_POL_location {
    type: left_outer
    sql_on: ${of_booking.pol_loc_cd} = ${trunk_POL_location.location_code} ;;
    relationship: many_to_one
  }
  join: trunk_POL_region {
    type: left_outer
    sql_on: ${trunk_POL_location.region_code} = ${trunk_POL_region.code} ;;
    relationship: many_to_one
  }
  join: trunk_POL_country {
    type: left_outer
    sql_on: ${trunk_POL_location.country_code} = ${trunk_POL_country.country_code} ;;
    relationship: many_to_one
  }
  join: DEL_location {
    type: left_outer
    sql_on: ${of_booking.del_cd} = ${DEL_location.location_code} ;;
    relationship: many_to_one
  }
  join: DEL_region {
    type: left_outer
    sql_on: ${DEL_location.region_code} = ${DEL_region.code} ;;
    relationship: many_to_one
  }
  join: DEL_country {
    type: left_outer
    sql_on: ${DEL_location.country_code} = ${DEL_country.country_code} ;;
    relationship: many_to_one
  }
  join: POR_location {
    type: left_outer
    sql_on: ${of_booking.por_cd} = ${POR_location.location_code} ;;
    relationship: many_to_one
  }
  join: POR_region {
    type: left_outer
    sql_on: ${POR_location.region_code} = ${POR_region.code} ;;
    relationship: many_to_one
  }
  join: POR_country {
    type: left_outer
    sql_on: ${POR_location.country_code} = ${POR_country.country_code} ;;
    relationship: many_to_one
  }
  join: of_svc_contract { # -- Arul OPUS Direct Link -- Start 28-Jul-2021
    type: left_outer
    view_label: "SVC/RFA Contract"
    sql_on: ${of_booking.svc_cont_no} =${of_svc_contract.sc_rfa_no} ;;
    relationship: many_to_one
    # -- Arul OPUS Direct Link -- End 28-Jul-2021
  }
}


# Modifed by Yeehao for Account Plan 24-08-2022
explore: account_plan {
  label: "Account Plan"
  extends: [of_consolidated]
  # sql_always_where: ${of_consolidated.record_type} != 'Target' OR (${of_consolidated.record_type} = 'Target' AND ${v_customer_opus_n_prospect.cust_grp_hrchy_cd} = 'G')  ;;
  ##sql_always_having: ${of_consolidated.total_plan_teu} >0 ;;

  always_join: [of_plan_week]
  join: of_plan_week {
    view_label: "Plan Week"
    type: inner
    sql_on: ${of_plan_week.sales_week} =cast(${of_sales_week_master.sales_week} as int64) ;;
    relationship: one_to_one
  }

  ## Added by DCN-741 NA sales user landing page ##
  join: service_contract_customer {
    view_label: "SVC/RFA Customer"
    from: v_customer_opus_n_prospect
    type: left_outer
    sql_on: ${of_svc_contract.cust_cd} = ${service_contract_customer.cust_cd} ;;
    relationship: many_to_one
  }

  join: of_customer_group {
    view_label: "Customer Group Code"
    type: left_outer
    sql_on: ${of_consolidated.consolidated_cnt_cust_grp_cd} = ${of_customer_group.cust_grp_id} ;;
    relationship: many_to_one
  }
  join: of_svc_contract {
    type: left_outer
    view_label: "SVC/RFA Contract"
    sql_on: ${of_consolidated.svc_cont_no} =${of_svc_contract.sc_rfa_no} ;;
    relationship: many_to_one
  }

  join: of_account_plan_rowtot_sort {
    view_label: "Row Total Sort"
    type: inner
    relationship: many_to_one
    sql_on: ${of_consolidated.consolidated_cnt_cust_grp_cd} = ${of_account_plan_rowtot_sort.cust_grp_id};;
  }

}

explore: poc_explore {
  label: "POC Explore"
  extends: [of_consolidated]
  sql_always_where: ${of_consolidated.record_type} != 'Target' OR (${of_consolidated.record_type} = 'Target' AND ${v_customer_opus_n_prospect.cust_grp_hrchy_cd} = 'G') ;;

  #always_join: [of_plan_week]
  join: of_plan_week {
    view_label: "Plan Week"
    type: inner
    sql_on: ${of_plan_week.sales_week} =cast(${of_sales_week_master.sales_week} as int64) ;;
    relationship: one_to_one
  }
  join: loading_location {
    view_label: "Loading Office"
    from: of_location
    type: left_outer
    sql_on: ${of_consolidated.ob_sls_ofc_cd} = ${loading_location.sales_ofc_code} ;;
    relationship: many_to_one
  }
  join: loading_country {
    view_label: "Loading Country"
    from: of_country
    type: left_outer
    sql_on: ${loading_location.country_code} = ${loading_country.country_code} ;;
    relationship: many_to_one
  }
  join: ap_submission_location {
    view_label: "AP Submission Office"
    from: of_location
    type: left_outer
    sql_on: ${of_consolidated.ctrt_scp_srep_ofc_cd} = ${ap_submission_location.sales_ofc_code} ;;
    relationship: many_to_one
  }
  join: ap_submission_country {
    view_label: "AP Submission Country"
    from: of_country
    type: left_outer
    sql_on: ${ap_submission_location.country_code} = ${ap_submission_country.country_code} ;;
    relationship: many_to_one
  }
  join: of_customer_group {
    view_label: "Customer Group Code"
    type: left_outer
    sql_on: ${of_consolidated.consolidated_cnt_cust_grp_cd} = ${of_customer_group.cust_grp_id} ;;
    relationship: many_to_one
  }
  join: of_svc_contract {
    type: left_outer
    view_label: "SVC/RFA Contract"
    sql_on: ${of_consolidated.svc_cont_no} =${of_svc_contract.sc_rfa_no} ;;
    relationship: many_to_one
  }
  join: of_dep_sched_smry {
    view_label: "Deployment Schedule Summary"
    type: full_outer
    sql_on: ${of_dep_sched_smry.sales_week} = ${of_sales_week_master.sales_week}
            and ${of_dep_sched_smry.trade_code} =  ${of_svc_scp_grp.service_scope_group_code} and ${of_consolidated.svc_scp_grp_cd} IS NOT NULL
            and ${of_consolidated.record_type} = 'Target'
            and ${of_dep_sched_smry.dominant_leg_flag} ='Y';;
    relationship: many_to_many
  }
}

explore: actuals_and_target {
  extends: [of_consolidated]
  sql_always_where: ${of_consolidated.record_type} NOT IN ('Plan', 'Booking') ;;
}

explore: of_consolidated_actuals_cgm_target {
  fields: [ALL_FIELDS*, -of_svc_scp_grp.trade_group_and_dom_flag]
  description: "Union of CGM, Salesperson Budget (defined by sym team, gtl), and Actuals.
  There are two types of cgm denoted by sub_record_type"

  join: v_customer_opus_n_prospect {
    view_label: "Customer"
    type: left_outer
    sql_on: ${of_consolidated_actuals_cgm_target.consolidated_cnt_cust_cd} = ${v_customer_opus_n_prospect.cust_cd}
      AND ${of_consolidated_actuals_cgm_target.consolidated_cnt_cust_cd} IS NOT NULL ;;
    relationship: many_to_one
  }

  #Add GKA/RKA/SME Label #Zoe Jun -22
  join: of_customer_group {
    view_label: "Customer G"
    type: left_outer
    sql_on: ${v_customer_opus_n_prospect.cust_grp_id} = ${of_customer_group.cust_grp_id} ;;
    relationship:many_to_one
  }

  join: of_salesperson {
    from: of_user
    type: left_outer
    # sql_on: trim(lower(${v_customer_opus_n_prospect.srep_eml})) = trim(lower(${of_salesperson.email})) ;; #DCN-552, Jack, 2022 Mar 14
    # sql_on: trim(lower(${v_customer_opus_n_prospect.srep_eml})) = trim(lower(${of_salesperson.email_4_join_with_cust})) ;; #DCN-552, Jack, 2022 Mar 14
    sql_on: ${v_customer_opus_n_prospect.of_owner_id} = ${of_salesperson.oneforce_id} ;; #DCN-552-followup, Jack, 2022 Mar 23
    #relationship: one_to_many # Jack Jun -16 correct it from one_to_many to many_to_one
    relationship: many_to_one
  }
  join: of_one_team_membership {
    view_label: "Team Membership"
    type: left_outer
    sql_on: ${of_salesperson.oneforce_id} = ${of_one_team_membership.team_member} ;;
    relationship: one_to_many
  }
  join: of_one_team {
    view_label: "Team Master"
    type: left_outer
    sql_on: ${of_one_team_membership.team} = ${of_one_team.oneforce_id} ;;
    relationship: many_to_one
  }
  join: contract_office {
    from:  of_office
    type: left_outer
    sql_on: ${of_consolidated_actuals_cgm_target.ctrt_prop_ofc_cd} = ${contract_office.office_code} ;;
    relationship: many_to_one
  }
  join: contract_office_location {
    from:  of_location
    type: left_outer
    sql_on: ${contract_office.location_code} = ${contract_office_location.location_code} ;;
    relationship: many_to_one
  }
  join: contract_office_country {
    from: CGM_Ctrt_country
    # change by helen on 20210818
    #sql_on: ${contract_office_location.country_code} = ${contract_office_country.country_code} ;;
    sql_on: ${of_consolidated_actuals_cgm_target.ctrt_cnt_cd} = ${contract_office_country.country_code} ;;
    # end change by helen on 20210818
    relationship: many_to_one
  }
  join: contract_office_region2 {
    view_label: "Office Information2 "
    from:  of_reg_ref
    type: left_outer
    sql_on: ${contract_office_country.country_code_2} = ${contract_office_region2.cust_cnt_cd} ;;
    relationship: many_to_one
  }
  join: contract_office_region {
    view_label: "Office Information (do not use)"
    from: of_region
    type: left_outer
    sql_on: ${contract_office_location.region_code} = ${contract_office_region.code} ;;
    relationship: many_to_one
  }
  join: of_svc_scp_grp {
    view_label: "Service Scope Group"
    type: left_outer
    sql_on: ${of_consolidated_actuals_cgm_target.svc_scp_grp_cd} = ${of_svc_scp_grp.service_scope_group_code} AND ${of_consolidated_actuals_cgm_target.svc_scp_grp_cd} IS NOT NULL ;;
    relationship: many_to_one
  }

  ## 24 Aug - Zoe Cheung ##
  join: of_svc_scp_lane_3digit {
    view_label: "Service Scope"
    from: of_svc_scp_lane
    type: left_outer
    sql_on: ${of_consolidated_actuals_cgm_target.slane_cd} = ${of_svc_scp_lane_3digit.service_lane_code} AND ${of_consolidated_actuals_cgm_target.slane_cd} IS NOT NULL ;;
    relationship: many_to_one
  }
  join: of_sales_week_master {
    view_label: "Sales Week Master"
    type: left_outer
    sql_on: ${of_consolidated_actuals_cgm_target.week} = cast(${of_sales_week_master.sales_week} as int64) ;;
    relationship: many_to_one
  }

  # change from POR_country to CGM_POR_country on 20210726 by Helen
  #join: POR_country {
  join: CGM_POR_country {
    type: left_outer
    sql_on: ${of_consolidated_actuals_cgm_target.por_cnt_cd} = ${CGM_POR_country.country_code} ;; # change on 20210726 by Helen
    relationship: many_to_one
  }

  join: CGM_POR_country_region {
    view_label: "POR Information"
    from: of_reg_ref
    type: left_outer
    sql_on: ${CGM_POR_country_region.cust_cnt_cd} = ${CGM_POR_country.country_code_2} ;;
    relationship: many_to_one
  }

  join: of_cntr_tpsz {
    type: left_outer
    sql_on: ${of_consolidated_actuals_cgm_target.consolidated_cntr_tpsz} = ${of_cntr_tpsz.type_size_code} ;;
    relationship: many_to_one
  }
}

explore: cm_monitor {
  extends: [of_consolidated]

  join: svc_contract_eff_wk_mth_qtr_yr {
    #from:  of_sales_week_master, Jack Jul 20, use of_sales_week_n_day_master, instead of of_sales_week_master
    from:  of_sales_week_n_day_master
    view_label: "Service Contract Eff Week, Mth, Qtr & Yr"
    type: left_outer
    sql_on: ${of_svc_contract.ctrt_eff_dt_date} = ${svc_contract_eff_wk_mth_qtr_yr.calendar_date}   ;;
    relationship: many_to_one
  }

  join: svc_contract_exp_wk_mth_qtr_yr {
    #from:  of_sales_week_master, Jack Jul 20, use of_sales_week_n_day_master, instead of of_sales_week_master
    from:  of_sales_week_n_day_master
    view_label: "Service Contract Exp Week, Mth, Qtr & Yr"
    type: left_outer
    #sql_on: ${of_svc_contract.ctrt_exp_dt_date} between ${svc_contract_exp_wk_mth_qtr_yr.week_start_date} and ${svc_contract_exp_wk_mth_qtr_yr.week_end_date}   ;;
    sql_on: ${of_svc_contract.ctrt_exp_dt_date} = ${svc_contract_exp_wk_mth_qtr_yr.calendar_date}   ;;
    relationship: many_to_one
  }

  join: svc_contract_ofc {
    from: of_office
    view_label: "Service Contract Req Ofc Dtls"
    type:  left_outer
    sql_on: ${of_svc_contract.ofc_cd} = ${svc_contract_ofc.office_code}  ;;
    relationship: many_to_one
  }

  join: svc_contract_ofc_lcn {
    from:  of_location
    view_label: "Service Contract Req Ofc Dtls"
    type:  left_outer
    sql_on: ${svc_contract_ofc.location_code} = ${svc_contract_ofc_lcn.location_code}  ;;
    relationship: many_to_one
  }

  join: svc_contract_ofc_country {
    from:  of_country
    view_label: "Service Contract Req Ofc Dtls"
    type:  left_outer
    sql_on: ${svc_contract_ofc_lcn.country_code} = ${svc_contract_ofc_country.country_code}  ;;
    relationship: many_to_one
  }

  join: svc_contract_ofc_rhq {
    from:  of_reg_ref
    view_label: "Service Contract Req Ofc Dtls"
    type:  left_outer
    sql_on: ${svc_contract_ofc_lcn.country_code} = ${svc_contract_ofc_rhq.cust_cnt_cd}  ;;
    relationship: many_to_one
  }

  join: ref_commodity {
    from:  of_commodity
    view_label: "Rep. Commodity"
    type: left_outer
    sql_on: ${of_commodity.parent_commodity_code} = ${ref_commodity.commodity_code}  ;;
    relationship: many_to_one
  }

#  join: svc_contract_req_ofc {
#    from:  of_office
#    view_label: "Service Contract Req Off Dtls"
#    type: left_outer
#    sql_on: ${of_svc_contract.ofc_cd} = ${of_office.office_code}   ;;
#    relationship: many_to_one
#  }
}

explore: ecom_evnt_ntfc_log {
  view_label: "ecom_log"
  view_name: ecom
  from: of_ecom_evnt_ntfc_log

  join: of_svc_contract {
    type: left_outer
    view_label: "SVC/RFA Contract"
    sql_on: ${ecom.sc_rfa_no} =${of_svc_contract.sc_rfa_no} ;;
    relationship: many_to_one
  }

  join: v_customer_opus_n_prospect {
    view_label: "Customer"
    type: left_outer
    sql_on: ${of_svc_contract.cust_cd} = ${v_customer_opus_n_prospect.cust_cd};;
    relationship: many_to_one
  }
  join: of_customer_group {
    view_label: "Customer Group"
    type: left_outer
    sql_on: ${v_customer_opus_n_prospect.cust_grp_id} = ${of_customer_group.cust_grp_id} ;;
    relationship: many_to_one
  }
}

explore: outstanding_account_receivable{
  view_label: "Outstanding & Overdue Tracker"
  view_name: outstanding
  from:  of_clear_ots

  join: of_svc_contract {
    type: left_outer
    view_label: "SVC/RFA Contract"
    sql_on: ${outstanding.sc_no} =${of_svc_contract.sc_rfa_no} ;;
    relationship: many_to_one
  }
  join: v_customer_opus_n_prospect {
    view_label: "Customer"
    type: left_outer
    sql_on: ${outstanding.cust_code} = ${v_customer_opus_n_prospect.cust_cd};;
    relationship: many_to_one
  }
  join: of_customer_group {
    view_label: "Customer Group"
    type: left_outer
    sql_on: ${v_customer_opus_n_prospect.cust_grp_id} = ${of_customer_group.cust_grp_id} ;;
    relationship: many_to_one
  }
  join: of_clear_ots_dtl {
    view_label: "Outstanding & Overdue Tracker Details"
    type: left_outer
    sql_on: ${outstanding.rhq_cd} = ${of_clear_ots_dtl.rhq_cd} and
            ${outstanding.ots_ofc_cd} = ${of_clear_ots_dtl.ots_ofc_cd} and
            ${outstanding.bl_no} = ${of_clear_ots_dtl.bl_no} and
            ${outstanding.inv_no} = ${of_clear_ots_dtl.inv_no} ;;
    relationship: many_to_one
  }
}

#explore: user_count_n_login_hist_mth_selection {}

explore: user_count_n_login_hist {
  view_label: "User Count & Login History"
  view_name: user_count_n_login_hist
  from:  user_count_n_login_hist

  join: of_user {
    from:  user_count_n_login_hist_of_user
    view_label: "User"
    type: left_outer
    sql_on: ${user_count_n_login_hist.user_id} = ${of_user.oneforce_id};;
    relationship: many_to_one
  }

  join: of_user_logged_in {
    from:  user_count_n_login_hist_of_user_logged
    view_label: "User Logged-in"
    type: left_outer
    sql_on: ${user_count_n_login_hist.login_user_id} = ${of_user_logged_in.oneforce_id};;
    relationship: many_to_one
  }

  join: of_user_not_logged_in {
    from:  user_count_n_login_hist_of_user_not_logged
    view_label: "User Not Logged-in"
    type: left_outer
    sql_on: ${user_count_n_login_hist.not_login_user_id} = ${of_user_not_logged_in.oneforce_id} ;;

    relationship: many_to_one
  }
}

explore: qbr_monitor {
  view_label: "QBR Monitor"

  join: mpr_qbr_quarter_master{
    view_label: "Quarter Master"
    type: inner
    sql_on: ${qbr_monitor.calendar_quarter} = ${mpr_qbr_quarter_master.calendar_quarter};;
    relationship: many_to_one
  }

  join: ckam_skam_master {
    type: left_outer
    sql_on: ${qbr_monitor.sales_person} = ${ckam_skam_master.sales_person} and
            ${qbr_monitor.contract_country} = ${ckam_skam_master.kam_country_code} and
            ${qbr_monitor.cust_grp_oneforce_id} = ${ckam_skam_master.customer_group};;
    relationship: many_to_one
  }

  join: of_user {
    from:  mpr_qbr_monitor_of_user
    view_label: "User"
    type: left_outer
    sql_on: ${ckam_skam_master.sales_person} = ${of_user.oneforce_id};;
    relationship: many_to_one
  }

  join: of_user_mgr {
    from:  mpr_qbr_monitor_of_user_mgr
    view_label: "User's Manager"
    type: left_outer
    sql_on: ${of_user.manager_id} = ${of_user_mgr.oneforce_id};;
    relationship: many_to_one
  }

  join: of_customer_group {
    view_label: "Customer Group"
    type: left_outer
    sql_on: ${ckam_skam_master.customer_group} = ${of_customer_group.oneforce_id};;
    relationship: many_to_one
  }

  #join: of_user {
  #  from:  mpr_qbr_monitor_of_user
  #  view_label: "User"
  #  type: left_outer
  #  sql_on: ${qbr_monitor.sales_person} = ${of_user.oneforce_id};;
  #  relationship: many_to_one
  #}

  #join: of_customer_group {
  #  view_label: "Customer Group Matthew Test"
  #  type: left_outer
  #  sql_on: ${qbr_monitor.cust_grp_oneforce_id} = ${of_customer_group.oneforce_id} ;;
  #  relationship: many_to_one
  #}

  join: of_svc_contract {
    type: left_outer
    view_label: "SVC/RFA No in CKAM/SKAM Registration"
    sql_on: ${qbr_monitor.svc_rfa_oneforce_id} =${of_svc_contract.oneforce_id} ;;
    relationship: many_to_one
  }

  join: is_missed_selection {
    type: inner
    view_label: "Is Missed Selection"
    sql_on: ${qbr_monitor.is_missed} =${is_missed_selection.is_missed} ;;
    relationship: many_to_one
  }

  join: is_fulfilled_selection {
    type: inner
    view_label: "Is Fulfilled Selection"
    sql_on: ${qbr_monitor.is_fulfilled} =${is_fulfilled_selection.is_fulfilled} ;;
    relationship: many_to_one
  }

  join: of_country {
    type: left_outer
    view_label: "Service / Contract Country"
    sql_on: ${qbr_monitor.contract_country} = ${of_country.country_code} ;;
    relationship: many_to_one
  }
}

explore: mpr_monitor {
  view_label: "MPR Monitor"

  join: mpr_qbr_quarter_master{
    view_label: "Quarter Master"
    type: inner
    sql_on: ${mpr_monitor.calendar_quarter} = ${mpr_qbr_quarter_master.calendar_quarter};;
    relationship: many_to_one
  }

  join: ckam_skam_master {
    type: left_outer
    sql_on: ${mpr_monitor.sales_person} = ${ckam_skam_master.sales_person} and
            ${mpr_monitor.kam_country} = ${ckam_skam_master.kam_country_code} and
            ${mpr_monitor.cust_grp_oneforce_id} = ${ckam_skam_master.customer_group};;
    relationship: many_to_one
  }

  join: of_user {
    from:  mpr_qbr_monitor_of_user
    view_label: "User"
    type: left_outer
    sql_on: ${ckam_skam_master.sales_person} = ${of_user.oneforce_id};;
    relationship: many_to_one
  }

  #DCN-662 : start
  join: of_user_mgr {
    from:  mpr_qbr_monitor_of_user_mgr
    view_label: "User's Manager"
    type: left_outer
    sql_on: ${of_user.manager_id} = ${of_user_mgr.oneforce_id};;
    relationship: many_to_one
  }
  #DCN-662 : end

  join: of_customer_group {
    view_label: "Customer Group"
    type: left_outer
    sql_on: ${ckam_skam_master.customer_group} = ${of_customer_group.oneforce_id};;
    relationship: many_to_one
  }

  #join: of_user {
  #  from:  mpr_qbr_monitor_of_user
  #  view_label: "User"
  #  type: left_outer
  #  sql_on: ${mpr_monitor.sales_person} = ${of_user.oneforce_id};;
  #  relationship: many_to_one
  #}
  #
  #join: of_customer_group {
  #  view_label: "Customer Group"
  #  type: left_outer
  #  sql_on: ${mpr_monitor.cust_grp_oneforce_id} = ${of_customer_group.oneforce_id} ;;
  #  relationship: many_to_one
  #}

  join: of_svc_contract {
    type: left_outer
    view_label: "SVC/RFA No in CKAM/SKAM Registration"
    sql_on: ${mpr_monitor.svc_rfa_oneforce_id} =${of_svc_contract.oneforce_id} ;;
    relationship: many_to_one
  }

  join: is_missed_selection {
    type: inner
    view_label: "Is Missed Selection"
    sql_on: ${mpr_monitor.is_missed} =${is_missed_selection.is_missed} ;;
    relationship: many_to_one
  }

  join: is_fulfilled_selection {
    type: inner
    view_label: "Is Fulfilled Selection"
    sql_on: ${mpr_monitor.is_fulfilled} =${is_fulfilled_selection.is_fulfilled} ;;
    relationship: many_to_one
  }

  join: of_country {
    type: left_outer
    view_label: "Service / Contract Country"
    sql_on: ${mpr_monitor.kam_country} = ${of_country.country_code} ;;
    relationship: many_to_one
  }

}

explore: duplicate_cust_grp {
  label: "Duplicate Customer Group"

  join: of_user {
    from: of_user_duplicate_cust_grp
    type: left_outer
    view_label: "Child Customer Sales Person"
    sql_on: ${duplicate_cust_grp.child_cust_owner_id} = ${of_user.oneforce_id} ;;
    relationship: many_to_one
  }
}

explore: of_poc2 {
  view_label: "POC Explore 2"
  view_name: of_sales_week_n_day_master
  from:  of_sales_week_n_day_master
}


## NA dashboard <start>
explore: of_vsl_svc_lane{}

explore: of_svc_scp {
  join: of_svc_scp_grp {
    view_label: "Service Scope Group"
    fields: [of_svc_scp_grp.service_scope_group_code, of_svc_scp_grp.service_scope_group_code_and_name]
    type: left_outer
    sql_on: ${of_svc_scp.service_scope_group_code} = ${of_svc_scp_grp.service_scope_group_code};;
    relationship: many_to_one
  }
}

explore: na_customer {
  label: "NA Dashboard Customers"
  from: v_customer_opus_n_prospect

  join: of_customer_group {
    view_label: "Customer Group"
    type: left_outer
    sql_on: ${na_customer.cust_grp_id} = ${of_customer_group.cust_grp_id} ;;
    relationship: many_to_one
  }
}

explore: of_dom_ndom {}

explore: of_bound {}

explore: na_cargo_type {}

explore: of_opp_query {
  label: "Oppurtunity Query (NA Dashboard)"
  from: of_opp_query

  join: na_user_opp {
    type: left_outer
    view_label: "User"
    sql_on: ${of_opp_query.opp_owner_id} = ${na_user_opp.oneforce_id} ;;
    relationship: many_to_one
  }

  join: of_svc_scp {
    type: left_outer
    view_label: "Service Scope"
    sql_on: ${of_opp_query.opp_svc_scp_cd} = ${of_svc_scp.service_scope_code} ;;
    relationship: many_to_one
  }

  join: of_svc_scp_grp {
    view_label: "Service Scope Group"
    type: left_outer
    sql_on: ${of_svc_scp.service_scope_group_code} = ${of_svc_scp_grp.service_scope_group_code};;
    relationship: many_to_one
  }

  join: of_sales_week_master {
    view_label: "Sales Week Master"
    fields: [of_sales_week_master.fiscal_year, of_sales_week_master.fiscal_year_new_fmt, of_sales_week_master.calendar_year, of_sales_week_master.sales_month, of_sales_week_master.sales_week, of_sales_week_master.sales_month_new_fmt, of_sales_week_master.sales_week_new_fmt, of_sales_week_master.calendar_quarter_new_fmt, of_sales_week_master.Timeline, of_sales_week_master.Timeline_New_Fmt, of_sales_week_master.timeframe_picker]
    type: left_outer
    sql_on: ${of_opp_query.opp_sales_week} = ${of_sales_week_master.sales_week};;
    relationship: many_to_one
  }

  #NA dashboard : to join with na_landing_last_n_week
  join: na_landing_last_n_week {
    type: inner
    relationship: one_to_one
    sql_on: ${of_sales_week_master.sales_week} = ${na_landing_last_n_week.sales_week} ;;
  }

  join: v_customer_opus_n_prospect {
    view_label: "Opp Customer"
    type:  left_outer
    sql_on: ${of_opp_query.opp_account_id} = ${v_customer_opus_n_prospect.oneforce_id};;
    relationship: many_to_one
  }

  join: of_customer_group {
    view_label: "Opp Customer Group"
    type: left_outer
    relationship: many_to_one
    sql_on: ${v_customer_opus_n_prospect.cust_grp_id} = ${of_customer_group.cust_grp_id};;
  }

  join: of_svc_contract {
    view_label: "Service Contract"
    type: left_outer
    relationship: many_to_one
    sql_on: ${of_opp_query.opp_contract_id} = ${of_svc_contract.oneforce_id};;
  }

}

explore: na_case_inquiry_kam {
  label: "Case Query (KAM, NA Dashboard)"
  from: na_case_inquiry_kam

  #join: of_user {
  #  type: left_outer
  #  view_label: "Case Owner"
  #  sql_on: ${na_case_inquiry.case_ownerid} = ${of_user.oneforce_id} ;;
  #  relationship: many_to_one
  #}

  join: na_user {
    type: left_outer
    relationship: many_to_one
    view_label: "CKAM/SKAM"
    sql_on: ${na_case_inquiry_kam.case_kam} = ${na_user.oneforce_id} ;;
  }

  join: of_sales_week_master {
    view_label: "Sales Week Master"
    fields: [of_sales_week_master.fiscal_year, of_sales_week_master.fiscal_year_new_fmt, of_sales_week_master.calendar_year, of_sales_week_master.sales_month, of_sales_week_master.sales_month_new_fmt, of_sales_week_master.sales_week, of_sales_week_master.sales_week_new_fmt, of_sales_week_master.calendar_quarter_new_fmt, of_sales_week_master.Timeline, of_sales_week_master.Timeline_New_Fmt, of_sales_week_master.timeframe_picker]
    type: left_outer
    sql_on: ${na_case_inquiry_kam.case_sales_week} = ${of_sales_week_master.sales_week};;
    relationship: many_to_one
  }

  join: na_landing_last_n_week {
    type: inner
    relationship: one_to_one
    sql_on: ${of_sales_week_master.sales_week} = ${na_landing_last_n_week.sales_week} ;;
  }

  join: of_customer {
    view_label: "Case Customer"
    type:  left_outer
    sql_on: ${na_case_inquiry_kam.case_cust_cd} = ${of_customer.cust_cd};;
    relationship: many_to_one
  }

  join: of_customer_group {
    view_label: "Case Customer Group"
    type: left_outer
    relationship: many_to_one
    sql_on: ${of_customer.cust_grp_id} = ${of_customer_group.cust_grp_id};;
  }
}

explore: na_case_inquiry {
  label: "Case Query (Owner, NA Dashboard)"
  from: na_case_inquiry

  #join: of_user {
  #  type: left_outer
  #  view_label: "Case Owner"
  #  sql_on: ${na_case_inquiry.case_ownerid} = ${of_user.oneforce_id} ;;
  #  relationship: many_to_one
  #}

  join: na_user {
    type: left_outer
    relationship: many_to_one
    view_label: "Case Owner"
    sql_on: ${na_case_inquiry.case_ownerid} = ${na_user.oneforce_id} ;;
  }

  join: of_sales_week_master {
    view_label: "Sales Week Master"
    fields: [of_sales_week_master.fiscal_year, of_sales_week_master.fiscal_year_new_fmt, of_sales_week_master.calendar_year, of_sales_week_master.sales_month, of_sales_week_master.sales_month_new_fmt, of_sales_week_master.sales_week, of_sales_week_master.sales_week_new_fmt, of_sales_week_master.calendar_quarter_new_fmt, of_sales_week_master.Timeline, of_sales_week_master.Timeline_New_Fmt, of_sales_week_master.timeframe_picker]
    type: left_outer
    sql_on: ${na_case_inquiry.case_sales_week} = ${of_sales_week_master.sales_week};;
    relationship: many_to_one
  }

  join: na_landing_last_n_week {
    type: inner
    relationship: one_to_one
    sql_on: ${of_sales_week_master.sales_week} = ${na_landing_last_n_week.sales_week} ;;
  }

  join: of_customer {
    view_label: "Case Customer"
    type:  left_outer
    sql_on: ${na_case_inquiry.case_cust_cd} = ${of_customer.cust_cd};;
    relationship: many_to_one
  }

  join: of_customer_group {
    view_label: "Case Customer Group"
    type: left_outer
    relationship: many_to_one
    sql_on: ${of_customer.cust_grp_id} = ${of_customer_group.cust_grp_id};;
  }
}

explore: na_event_query {
  label: "Event Query (NA Dashboard)"
  from: na_event_query

  join: na_user_evnt {
    type: left_outer
    view_label: "User"
    sql_on: ${na_event_query.evnt_owner_id} = ${na_user_evnt.oneforce_id} ;;
    relationship: many_to_one
  }

  join: of_sales_week_master {
    view_label: "Sales Week Master"
    fields: [of_sales_week_master.fiscal_year, of_sales_week_master.fiscal_year_new_fmt, of_sales_week_master.calendar_year, of_sales_week_master.sales_month, of_sales_week_master.sales_month_new_fmt, of_sales_week_master.sales_week, of_sales_week_master.sales_week_new_fmt, of_sales_week_master.calendar_quarter_new_fmt, of_sales_week_master.Timeline, of_sales_week_master.Timeline_New_Fmt, of_sales_week_master.timeframe_picker]
    type: left_outer
    sql_on: ${na_event_query.evnt_sales_week} = ${of_sales_week_master.sales_week};;
    relationship: many_to_one
  }

  join: na_landing_last_n_week {
    type: inner
    relationship: one_to_one
    sql_on: ${of_sales_week_master.sales_week} = ${na_landing_last_n_week.sales_week} ;;
  }

  join: of_svc_scp_grp {
    view_label: "Service Scope Group"
    fields: [of_svc_scp_grp.service_scope_group_code, of_svc_scp_grp.service_scope_group_code_and_name]
    type: left_outer
    sql_on: ${na_event_query.svc_scp_grp_cd} = ${of_svc_scp_grp.service_scope_group_code};;
    relationship: many_to_one
  }

  join: v_customer_opus_n_prospect {
    view_label: "Customer"
    type: left_outer
    sql_on: ${na_event_query.evnt_cust_cd} = ${v_customer_opus_n_prospect.cust_cd};;
    relationship: many_to_one
  }

  join: of_customer_group {
    view_label: "Customer Group"
    type: left_outer
    sql_on: ${na_event_query.evnt_cust_grp_id} = ${of_customer_group.cust_grp_id};;
    relationship: many_to_one
  }

}

explore: na_bkg_vs_budget_qry {
  label: "Budget Perfomance Query (NA Dashboard)"
  from: na_bkg_vs_budget_qry

  join: na_user {
    view_label: "User"
    type: left_outer
    relationship: many_to_one
    sql_on: ${na_bkg_vs_budget_qry.usr_id} = ${na_user.oneforce_id} ;;
  }

  join: of_sales_week_master {
    view_label: "Sales Week Master"
    fields: [of_sales_week_master.fiscal_year, of_sales_week_master.calendar_year, of_sales_week_master.sales_month, of_sales_week_master.sales_week, of_sales_week_master.Timeline, of_sales_week_master.timeframe_picker]
    type: left_outer
    sql_on: ${na_bkg_vs_budget_qry.sales_week} = ${of_sales_week_master.sales_week};;
    relationship: many_to_one
  }

  join: of_svc_scp_grp {
    view_label: "Service Scope Group"
    fields: [of_svc_scp_grp.service_scope_group_code, of_svc_scp_grp.service_scope_group_code_and_name]
    type: left_outer
    sql_on: ${na_bkg_vs_budget_qry.service_scope_group} = ${of_svc_scp_grp.service_scope_group_code};;
    relationship: many_to_one
  }

  join: v_customer_opus_n_prospect {
    view_label: "Contract Customer"
    type: left_outer
    relationship: many_to_one
    sql_on: ${na_bkg_vs_budget_qry.cust_cd} = ${v_customer_opus_n_prospect.cust_cd};;
  }

  join: of_customer_group {
    view_label: "Contract Customer Group"
    type: left_outer
    relationship: many_to_one
    sql_on: ${v_customer_opus_n_prospect.cust_grp_id} = ${of_customer_group.cust_grp_id};;
  }

}

explore: of_opp_vs_bkg {}

explore: Of_opp_verus_bkg{
  from: of_opp_and_opp_dtl
  label: "Opportunity Vs Booking"
  view_label: "Opportunity Line"

# DCN-1016 - start

    join: of_sales_week_master {
    view_label: "Sales Week Master"
    # from: of_sales_week_master
    fields: [of_sales_week_master.fiscal_year_new_fmt, of_sales_week_master.calendar_year, of_sales_week_master.sales_month_new_fmt, of_sales_week_master.sales_week_new_fmt]
    type: left_outer
    sql_on: ${Of_opp_verus_bkg.opp_createddate_filter_date} between ${of_sales_week_master.week_start_date} and ${of_sales_week_master.week_end_date}  ;;
    relationship: many_to_one
  }

  join: of_customer_group {
    type: left_outer
    relationship: many_to_one
    fields: [of_customer_group.key_acct_tp_cd]
    sql_on: ${v_customer_opus_n_prospect.cust_grp_id} = ${of_customer_group.cust_grp_id} ;;
    }
# DCN-1016 - end

    join: of_product2 {
      type: left_outer
      sql_on: ${Of_opp_verus_bkg.t_slan_cd} =  ${of_product2.product_code};;
      fields: [of_product2.oneforce_id]
      relationship: many_to_one
    }

    join: of_campaign {
    type: full_outer
    view_label: "Campaign"
    sql_on: ${of_campaign.oneforce_id} = ${Of_opp_verus_bkg.opp_campaign_id}
              AND (${of_campaign.service_lane} IS NULL OR ${of_campaign.service_lane} = ${of_product2.oneforce_id})    --DCN-1079s
              AND (${of_campaign.service_scope_group} IS NULL OR ${of_campaign.service_scope_group} = ${Of_opp_verus_bkg.opp_svc_scp_grp_cd})
              AND (${of_campaign.service_scope} IS NULL OR ${of_campaign.service_scope} = ${Of_opp_verus_bkg.opp_svc_scp_cd})
              AND (${of_campaign.origin} IS NULL OR ${of_campaign.origin} = ${Of_opp_verus_bkg.origin})
              AND (${of_campaign.origin_country} IS NULL OR ${of_campaign.origin_country} = ${Origin.country_code})
              AND (${of_campaign.destination} IS NULL OR ${of_campaign.destination} = ${Of_opp_verus_bkg.opp_destination})
              AND (${of_campaign.destination_country} IS NULL OR ${of_campaign.destination_country} = ${Destination.country_code})
              AND (${of_campaign.equipment_type} IS NULL OR instr(${of_campaign.equipment_type}, ${Of_opp_verus_bkg.opp_equipment_type}) > 0)
            --  AND (${of_campaign.commodity} IS NULL OR ${of_campaign.commodity} = ${Of_opp_verus_bkg.opp_commodity});;
    relationship: many_to_one
    }


    join: of_svc_contract {
    view_label: "Service Contract"
    type: left_outer
    relationship: many_to_one
    sql_on: ${Of_opp_verus_bkg.opp_contract_id} = ${of_svc_contract.oneforce_id};;
  }

    join: v_customer_opus_n_prospect {
    view_label: "Customer"
    type: left_outer
    sql_on: ${Of_opp_verus_bkg.opp_account_id} = ${v_customer_opus_n_prospect.oneforce_id} ;;
    relationship: many_to_one
  }

    join: Destination {
    from: DEL_location
    view_label: "Destination"
    type: left_outer
      sql_on:${Of_opp_verus_bkg.opp_destination} = ${Destination.location_name};;
    relationship: many_to_one
    # fields: [Destination.location_name, Destination.location_code_and_name]
  }

    join: Origin {
    from: POR_location
    view_label: "Origin"
    type: left_outer
    sql_on:${Of_opp_verus_bkg.origin} = ${Origin.location_name};;
    relationship: many_to_one
    #fields: [Origin.location_name, Origin.location_code_and_name]
  }

  join: Pol {
    from: of_location
    view_label: "Port of Loading"
    type: left_outer
    sql_on:${Of_opp_verus_bkg.opp_pol} = ${Pol.oneforce_id};;
    relationship: many_to_one
  }

  join: Pod {
    from: of_location
    view_label: "Port of Discharge"
    type: left_outer
    sql_on:${Of_opp_verus_bkg.opp_pod} = ${Pod.oneforce_id};;
    relationship: many_to_one
  }

  join: of_svc_scp {
    view_label: "Service Scope & Group"
    type: left_outer
    sql_on: ${Of_opp_verus_bkg.opp_svc_scp_cd} = ${of_svc_scp.service_scope_code} ;;
    relationship: many_to_one
  }

  join: of_cntr_tpsz {
    view_label: "Equipment"
    type: left_outer
    sql_on: ${Of_opp_verus_bkg.opp_equipment_type} = ${of_cntr_tpsz.type_size_code} ;;
    relationship: many_to_one
  }

  join: of_opp_vs_bkg {
    view_label: "Bookings"
    type: left_outer
    relationship: many_to_many
    sql_on: ${of_opp_vs_bkg.svc_cont_no} = ${of_svc_contract.sc_rfa_no} and
            ${of_opp_vs_bkg.consolidated_cnt_cust_cd} = ${v_customer_opus_n_prospect.cust_cd} and
            ${of_opp_vs_bkg.svc_scp_cd} = ${Of_opp_verus_bkg.opp_svc_scp_cd} and
            ${of_opp_vs_bkg.svc_scp_grp_cd} = ${Of_opp_verus_bkg.opp_svc_scp_grp_cd} and
            --(${Of_opp_verus_bkg.opp_commodity} is null or instr(${Of_opp_verus_bkg.opp_commodity},${of_opp_vs_bkg.cmdt_cd}) > 0) and --DCN-1089
            ((${Of_opp_verus_bkg.origin} is null or ${Of_opp_verus_bkg.opp_destination} is null) or
              (${of_opp_vs_bkg.por_cd} = ${Origin.location_code} and ${of_opp_vs_bkg.del_cd} = ${Destination.location_code})) and
            (${Pol.location_code} is null or ${of_opp_vs_bkg.pol_loc_cd} = ${Pol.location_code}) and
            (${Pod.location_code} is null or ${of_opp_vs_bkg.pod_loc_cd} = ${Pod.location_code}) and
            (${Of_opp_verus_bkg.opp_nac_code} is null or ${Of_opp_verus_bkg.opp_nac_code} = ${of_opp_vs_bkg.actual_cust_cd}) and
            (${Of_opp_verus_bkg.opp_equipment_type} is null or ${Of_opp_verus_bkg.opp_equipment_type} = ${of_opp_vs_bkg.consolidated_cntr_tpsz}) and
            case when ${of_svc_contract.sc_rfa_typ} = 'S' then ${of_opp_vs_bkg.cgo_rcv_dt_date} else ${of_opp_vs_bkg.lodg_due_dt_date}end
             between ${Of_opp_verus_bkg.db_eff_from} and ${Of_opp_verus_bkg.db_eff_to}
            and (${Of_opp_verus_bkg.t_slan_cd} = 'ALL' or ${Of_opp_verus_bkg.t_slan_cd} = ${of_opp_vs_bkg.t_slan_cd})
          ;;
  }

}

explore: of_sstm_country_split_join_with_customer_group {}

# explore: Of_opportunities {
#   label: "Opportunity"
#   from: of_opp_query

#   join: of_campaign {
#     type: left_outer
#     view_label: "Campaign"
#     sql_on: ${Of_opportunities.opp_campaign_id} = ${of_campaign.oneforce_id} ;;
#     relationship: one_to_many
#   }

#   join: of_svc_contract {
#     view_label: "Service Contract"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${Of_opportunities.opp_contract_id} = ${of_svc_contract.oneforce_id};;
#   }

#   join: v_customer_opus_n_prospect {
#     view_label: "Customer"
#     type: left_outer
#     sql_on: ${Of_opportunities.opp_account_id} = ${v_customer_opus_n_prospect.oneforce_id} ;;
#     relationship: many_to_one
#   }

#   join: Destination {
#     from: of_location
#     view_label: "Location"
#     type: left_outer
#     sql_on:${Of_opportunities.opp_destination} = ${Destination.location_name};;
#     relationship: many_to_one
#   }

#   join: Origin {
#     from: of_location
#     view_label: "Origin"
#     type: left_outer
#     sql_on:${Of_opportunities.origin} = ${Origin.location_name};;
#     relationship: many_to_one
#   }

#   join: Pol {
#     from: of_location
#     view_label: "Pol"
#     type: left_outer
#     sql_on:${Of_opportunities.opp_pol} = ${Pol.oneforce_id};;
#     relationship: many_to_one
#   }

#   join: Pod {
#     from: of_location
#     view_label: "Pod"
#     type: left_outer
#     sql_on:${Of_opportunities.opp_pod} = ${Pod.oneforce_id};;
#     relationship: many_to_one
#   }

#   join: of_opp_vs_bkg {
#     view_label: "Bookings"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${of_opp_vs_bkg.svc_cont_no} = ${of_svc_contract.sc_rfa_no} and
#             ${of_opp_vs_bkg.consolidated_cnt_cust_cd} = ${v_customer_opus_n_prospect.cust_cd} and
#             ${of_opp_vs_bkg.svc_scp_cd} = ${Of_opportunities.opp_svc_scp_cd} and
#             ${of_opp_vs_bkg.ori_cnt} = ${Origin.country_code} and
#             ${of_opp_vs_bkg.pol_loc_cd} = ${Pol.location_code} and
#             ${of_opp_vs_bkg.pod_loc_cd} = ${Pod.location_code} and
#             ${of_opp_vs_bkg.del_cd} =${Destination.location_code} ;;
#   }

#   }

explore: na_dashboard_param { }

## NA dashboard <end>


#Dummy changes to force a webhook sync 2022-3-18 10:08am HK time

#explore: of_consolidated_tmp_dcn515 {
#  view_name: of_consolidated_tmp_dcn515
#  from:  of_consolidated_tmp_dcn515
#
#  # improve later in BigQuery by matching data type, int was used for partitioning
#  join: of_sales_week_master {
#    view_label: "Sales Week Master"
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.week} = cast(${of_sales_week_master.sales_week} as int64) ;;
#    relationship: many_to_one
#  }
#  # Route Information
#  join: actual_empty_pick_up_location {
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.act_mty_pkup_scc_cd} = ${actual_empty_pick_up_location.location_code} ;;
#    relationship: many_to_one
#  }
#  join: actual_empty_pick_up_region {
#    type: left_outer
#    sql_on: ${actual_empty_pick_up_location.region_code} = ${actual_empty_pick_up_region.code} ;;
#    relationship: many_to_one
#  }
#  join: actual_empty_pick_up_country {
#    type: left_outer
#    sql_on: ${actual_empty_pick_up_location.country_code} = ${actual_empty_pick_up_country.country_code} ;;
#    relationship: many_to_one
#  }
#  join: actual_empty_return_location {
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.mty_rtn_scc_cd} = ${actual_empty_return_location.location_code};;
#    relationship: many_to_one
#  }
#  join: actual_empty_return_region {
#    type: left_outer
#    sql_on: ${actual_empty_return_location.region_code} = ${actual_empty_return_region.code} ;;
#    relationship: many_to_one
#  }
#  join: actual_empty_return_country {
#    type: left_outer
#    sql_on: ${actual_empty_return_location.country_code} = ${actual_empty_return_country.country_code} ;;
#    relationship: many_to_one
#  }
#  join: estimated_empty_pick_up_location {
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.mty_pkup_scc_cd} = ${estimated_empty_pick_up_location.location_code} ;;
#    relationship: many_to_one
#  }
#  join: estimated_empty_pick_up_region {
#    type: left_outer
#    sql_on: ${estimated_empty_pick_up_location.region_code} = ${estimated_empty_pick_up_region.code} ;;
#    relationship: many_to_one
#  }
#  join: estimated_empty_pick_up_country {
#    type: left_outer
#    sql_on: ${estimated_empty_pick_up_location.country_code} = ${estimated_empty_pick_up_country.country_code} ;;
#    relationship: many_to_one
#  }
#  join: estimated_empty_return_location {
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.bkg_mty_rtn_scc_cd} = ${estimated_empty_return_location.location_code} ;;
#    relationship: many_to_one
#  }
#  join: estimated_empty_return_region {
#    type: left_outer
#    sql_on: ${estimated_empty_return_location.region_code} = ${estimated_empty_return_region.code} ;;
#    relationship: many_to_one
#  }
#  join: estimated_empty_return_country {
#    type: left_outer
#    sql_on: ${estimated_empty_return_location.country_code} = ${estimated_empty_return_country.country_code} ;;
#    relationship: many_to_one
#  }
#  join: first_POD_location {
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.n1st_pod_cd} = ${first_POD_location.location_code} ;;
#    relationship: many_to_one
#  }
#  join: first_POD_region {
#    type: left_outer
#    sql_on: ${first_POD_location.region_code} = ${first_POD_region.code} ;;
#    relationship: many_to_one
#  }
#  join: first_POD_country {
#    type: left_outer
#    sql_on: ${first_POD_location.country_code} = ${first_POD_country.country_code} ;;
#    relationship: many_to_one
#  }
#  join: first_POL_location {
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.n1st_pol_cd} = ${first_POL_location.location_code} ;;
#    relationship: many_to_one
#  }
#  join: first_POL_region {
#    type: left_outer
#    sql_on: ${first_POL_location.region_code} = ${first_POL_region.code} ;;
#    relationship: many_to_one
#  }
#  join: first_POL_country {
#    type: left_outer
#    sql_on: ${first_POL_location.country_code} = ${first_POL_country.country_code} ;;
#    relationship: many_to_one
#  }
#  join: final_POD_location {
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.final_pod_cd} = ${final_POD_location.location_code} ;;
#    relationship: many_to_one
#  }
#  join: final_POL_region {
#    type: left_outer
#    sql_on: ${final_POD_location.region_code} = ${final_POL_region.code} ;;
#    relationship: many_to_one
#  }
#  join: final_POL_country {
#    type: left_outer
#    sql_on: ${final_POD_location.country_code} = ${final_POL_country.country_code} ;;
#    relationship: many_to_one
#  }
#  join: trunk_POD_location {
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.pod_loc_cd} = ${trunk_POD_location.location_code} ;;
#    relationship: many_to_one
#  }
#  join: trunk_POD_region {
#    type: left_outer
#    sql_on: ${trunk_POD_location.region_code} = ${trunk_POD_region.code} ;;
#    relationship: many_to_one
#  }
#  join: trunk_POD_country {
#    type: left_outer
#    sql_on: ${trunk_POD_location.country_code} = ${trunk_POD_country.country_code} ;;
#    relationship: many_to_one
#  }
#  join: trunk_POL_location {
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.pol_loc_cd} = ${trunk_POL_location.location_code} ;;
#    relationship: many_to_one
#  }
#  join: trunk_POL_region {
#    type: left_outer
#    sql_on: ${trunk_POL_location.region_code} = ${trunk_POL_region.code} ;;
#    relationship: many_to_one
#  }
#  join: trunk_POL_country {
#    type: left_outer
#    sql_on: ${trunk_POL_location.country_code} = ${trunk_POL_country.country_code} ;;
#    relationship: many_to_one
#  }
#  join: DEL_location {
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.del_cd} = ${DEL_location.location_code} ;;
#    relationship: many_to_one
#  }
#  join: DEL_region {
#    type: left_outer
#    sql_on: ${DEL_location.region_code} = ${DEL_region.code} ;;
#    relationship: many_to_one
#  }
#  join: DEL_country {
#    type: left_outer
#    sql_on: ${DEL_location.country_code} = ${DEL_country.country_code} ;;
#    relationship: many_to_one
#  }
#  join: POR_location {
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.por_cd} = ${POR_location.location_code} ;;
#    relationship: many_to_one
#  }
#  join: POR_region {
#    type: left_outer
#    sql_on: ${POR_location.region_code} = ${POR_region.code} ;;
#    relationship: many_to_one
#  }
#  join: POR_country {
#    type: left_outer
#    sql_on: ${POR_location.country_code} = ${POR_country.country_code} ;;
#    relationship: many_to_one
#  }
#  # Office Information
#  join: bkg_office {
#    view_label: "Office Information"
#    from: of_office
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.bkg_ofc_cd} = ${bkg_office.office_code} ;;
#    relationship: many_to_one
#  }
#  join: bkg_office_location {
#    view_label: "Office Information"
#    from:  of_location
#    type: left_outer
#    sql_on: ${bkg_office.location_code} = ${bkg_office_location.location_code} ;;
#    relationship: many_to_one
#  }
#  join: bkg_office_country {
#    view_label: "Office Information"
#    from: of_country
#    sql_on: ${bkg_office_location.country_code} = ${bkg_office_country.country_code} ;;
#    relationship: many_to_one
#  }
#  join: bkg_office_region {
#    view_label: "Office Information"
#    from: of_region
#    type: left_outer
#    sql_on: ${bkg_office_location.region_code} = ${bkg_office_region.code} ;;
#    relationship: many_to_one
#  }
#  join: of_commodity {
#    view_label: "Commodity"
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.cmdt_cd} = ${of_commodity.commodity_code} ;;
#    relationship: many_to_one
#  }
#
#  join: of_svc_scp {
#    view_label: "Service Scope"
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.svc_scp_cd} = ${of_svc_scp.service_scope_code} ;;
#    relationship: many_to_one
#  }
#
#  join: of_svc_scp_grp {
#    view_label: "Service Scope Group"
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.svc_scp_grp_cd} = ${of_svc_scp_grp.service_scope_group_code} AND ${of_consolidated_tmp_dcn515.svc_scp_grp_cd} IS NOT NULL ;;
#    relationship: many_to_one
#  }
#  join: of_cntr_tpsz {
#    view_label: "Equipment"
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.consolidated_cntr_tpsz} = ${of_cntr_tpsz.type_size_code} ;;
#    relationship: many_to_one
#  }
#  join: equipment_category {
#    view_label: "Equipment Category"
#    type: left_outer
#    sql_on: ${of_cntr_tpsz.type_size_code} = ${equipment_category.equipment_type_size} ;;
#    relationship: many_to_one
#  }
#  join: v_customer_opus_n_prospect {
#    view_label: "Customer"
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.consolidated_cnt_cust_cd} = ${v_customer_opus_n_prospect.cust_cd}
#      AND ${of_consolidated_tmp_dcn515.consolidated_cnt_cust_cd} IS NOT NULL ;;
#    relationship: many_to_one
#  }
#  join: of_sales_team_members {
#    view_label: "Sales Team Members"
#    from: of_sales_team_member
#    type: left_outer
#    sql_on: ${v_customer_opus_n_prospect.oneforce_id} = ${of_sales_team_members.customer} ;;
#    relationship: one_to_many
#  }
#  join: of_sales_team_member_user {
#    view_label: "Sales Team Member"
#    from: of_user
#    type: left_outer
#    sql_on: ${of_sales_team_members.sales_person} = ${of_sales_team_member_user.oneforce_id} ;;
#    relationship: many_to_one
#  }
#  join: of_customer_group {
#    view_label: "Customer Group"
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.consolidated_cnt_cust_grp_cd} = ${of_customer_group.cust_grp_id} ;;
#    relationship: many_to_one
#  }
#  join: of_customer_owner {
#    view_label: "Customer Owner"
#    from: of_user
#    type: left_outer
#    sql_on: ${v_customer_opus_n_prospect.of_owner_id} = ${of_customer_owner.oneforce_id} ;;
#    relationship: many_to_one
#  }
#  join: of_one_team_membership {
#    view_label: "Team Membership"
#    type: left_outer
#    sql_on: ${of_customer_owner.oneforce_id} = ${of_one_team_membership.team_member} ;;
#    relationship: one_to_many
#  }
#  join: of_one_team {
#    view_label: "Teams"
#    type: left_outer
#    sql_on: ${of_one_team_membership.team} = ${of_one_team.oneforce_id} ;;
#    relationship: many_to_one
#  }
#
#  #by Jack, when sudoing as Wallce, Jul 12
#  join: of_svc_contract {
#    view_label: "Service Contract"
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.svc_cont_no} = ${of_svc_contract.sc_rfa_no} ;;
#    relationship: many_to_one
#  }
#
#  join: ram{
#    view_label: "Ram"
#    from: of_user
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.ram} = ${ram.oneforce_id} ;;
#    relationship: many_to_one
#  }
#
#  join: of_dep_sched_smry {
#    view_label: "Deployment Schedule Summary"
#    type: full_outer
#    sql_on: ${of_dep_sched_smry.sales_week} = ${of_sales_week_master.sales_week}
#            and ${of_dep_sched_smry.trade_code} =  ${of_svc_scp_grp.service_scope_group_code} and ${of_consolidated_tmp_dcn515.svc_scp_grp_cd} IS NOT NULL
#            and ${of_consolidated_tmp_dcn515.record_type} = 'Target'
#            and ${of_dep_sched_smry.dominant_leg_flag} ='Y';;
#    relationship: many_to_many
#  }
#
#  join: gam {
#    view_label: "Gam"
#    from: of_user
#    type: left_outer
#    sql_on: ${of_customer_group.global_account_manager} = ${gam.oneforce_id} ;;
#    relationship: many_to_one
#  }
#  join: gam_manager {
#    view_label: "Gam"
#    from: of_user
#    type: left_outer
#    sql_on: ${gam.manager_id} = ${gam_manager.oneforce_id} ;;
#    relationship: many_to_one
#  }
#  join: gam_office {
#    view_label: "Gam"
#    from: of_office
#    type: left_outer
#    sql_on: ${gam.office_code_number} = ${gam_office.office_code} ;;
#    relationship: many_to_one
#  }
#
#  join: of_one_team_membership_gam {
#    view_label: "Gam's Team"
#    from:  of_one_team_membership
#    type: left_outer
#    sql_on: ${gam.oneforce_id} = ${of_one_team_membership_gam.team_member} ;;
#    relationship: one_to_many
#  }
#  join: of_one_team_gam {
#    view_label: "Gam's Team"
#    from: of_one_team
#    type: left_outer
#    sql_on: ${of_one_team_membership_gam.team} = ${of_one_team_gam.oneforce_id} ;;
#    relationship: many_to_one
#  }
#
#  # add by Helen on 12-Oct-2021
#  join: contract_office {
#    view_label: "Contract Office Information"
#    from: of_office
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.ctrt_prop_ofc_cd} = ${contract_office.office_code} ;;
#    relationship: many_to_one
#  }
#
#  join: contract_office_location {
#    view_label: "Contract Office Information"
#    from: of_location
#    type: left_outer
#    sql_on: ${contract_office.location_code} = ${contract_office_location.location_code} ;;
#    relationship: many_to_one
#  }
#
#  join: contract_office_country {
#    view_label: "Contract_Office Information"
#    from: of_country
#    type: left_outer
#    sql_on: ${contract_office_location.country_code} = ${contract_office_country.country_code} ;;
#    relationship: many_to_one
#  }
#
#  join: of_cif_fob {
#    view_label: "SYM CIF/FOB"
#    type: left_outer
#    sql_on: ${of_cif_fob.modi_svc_grp_cd} = ${of_consolidated_tmp_dcn515.svc_scp_grp_cd}
#            and ${of_cif_fob.dmnt_flg} = (CASE WHEN ${of_consolidated_tmp_dcn515.dominant_flg} = 'DOM' THEN 'Y' ELSE 'N' END)
#            and ${of_cif_fob.ofc_cd} = ${of_consolidated_tmp_dcn515.ctrt_prop_ofc_cd};;
#    relationship: many_to_one
#  }
#  # end add by Helen on 12-Oct-2021
#
#  join: ap_submission_office {
#    view_label: "AP Submission Office"
#    from:  of_office
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.ctrt_scp_srep_ofc_cd} = ${ap_submission_office.office_code} ;;
#    relationship: many_to_one
#  }
#  join: ap_submission_location {
#    view_label: "AP Submission Country Code"
#    from:  of_location
#    type: left_outer
#    sql_on: ${ap_submission_office.location_code} = ${ap_submission_location.location_code} ;;
#    relationship: many_to_one
#  }
#  join: ap_submission_country {
#    view_label: "AP Submission Country"
#    from: of_country
#    sql_on: ${ap_submission_location.country_code} = ${ap_submission_country.country_code} ;;
#    relationship: many_to_one
#  }
#
#  join: loading_office {
#    view_label: "Loading Office"
#    from:  of_office
#    type: left_outer
#    sql_on: ${of_consolidated_tmp_dcn515.ob_sls_ofc_cd} = ${loading_office.office_code} ;;
#    relationship: many_to_one
#  }
#  join: loading_country_code {
#    view_label: "Loading Country Code"
#    from:  of_location
#    type: left_outer
#    sql_on: ${loading_office.location_code} = ${loading_country_code.location_code} ;;
#    relationship: many_to_one
#  }
#  join: loading_country {
#    view_label: "Loading Country"
#    from: of_country
#    sql_on: ${loading_country_code.country_code} = ${loading_country.country_code} ;;
#    relationship: many_to_one
#  }
#  join: of_user {
#    from: of_user
#    type: left_outer
#    sql_on: trim(lower(${of_svc_contract.srep_eml})) = trim(lower(${of_user.email})) ;;
#    #relationship: one_to_many # Jack Jun -16 correct it from one_to_many to many_to_one
#    relationship: many_to_one
#  }
#
#}


#explore: customer_volume_performance_tmp_dcn515 {
#  extends: [of_consolidated_tmp_dcn515]
#  sql_always_where: ${of_consolidated_tmp_dcn515.record_type} != 'Plan' ;;
#
#  join: of_dep_sched_smry {
#    view_label: "Deployment Schedule Summary"
#    type: full_outer
#    sql_on: ${of_dep_sched_smry.sales_week} = ${of_sales_week_master.sales_week}
#            and ${of_dep_sched_smry.trade_code} =  ${of_svc_scp_grp.service_scope_group_code} and ${of_consolidated_tmp_dcn515.svc_scp_grp_cd} IS NOT NULL
#            and ${of_consolidated_tmp_dcn515.record_type} = 'Target'
#            and ${of_dep_sched_smry.dominant_leg_flag} ='Y';;
#    relationship: many_to_many
#  }
#
# join: service_contract_sales_rep {
#   view_label: "Service Contract Sales Rep"
#   from: of_user
#   type: left_outer
#   sql_on: trim(lower(${of_svc_contract.srep_eml})) = trim(lower(${service_contract_sales_rep.email})) ;;
#   #relationship: one_to_many # Jack Jun -16 correct it from one_to_many to many_to_one
#   relationship: many_to_one
# }

# join: loading_office {
#   view_label: "Loading Office"
#   from:  of_office
#   type: left_outer
#   sql_on: ${of_consolidated_tmp_dcn515.ob_sls_ofc_cd} = ${loading_office.office_code} ;;
#   relationship: many_to_one
# }
# join: loading_country_code {
#   view_label: "Loading Office Loocation"
#   from:  of_location
#   type: left_outer
#   sql_on: ${loading_office.location_code} = ${loading_country_code.location_code} ;;
#   relationship: many_to_one
# }
# join: loading_country {
#   view_label: "Loading Office Country"
#   from: of_country
#   type: left_outer
#   sql_on: ${loading_country_code.country_code} = ${loading_country.country_code} ;;
#   relationship: many_to_one
#  }

  # join: of_actuals {
  #   view_label: "Actuals"
  #   type: left_outer
  #   sql_on:  ${of_consolidated.bkg_no} = ${of_actuals.bkg_no}
  #     AND ${of_consolidated.consolidated_cntr_tpsz} = ${of_actuals.cntr_tpsz_cd}
  #     AND ${of_consolidated.record_type} = 'Actual';;
  #   relationship: one_to_one
  #   fields: [of_actuals.non_consolidated*]
  # }
  # join: of_booking {
  #   view_label: "Booking"
  #   type: left_outer
  #   sql_on:  ${of_consolidated.bkg_no} = ${of_booking.bkg_no}
  #     AND ${of_consolidated.consolidated_cntr_tpsz} = ${of_booking.cntr_tpsz}
  #     AND ${of_consolidated.record_type} = 'Booking';;
  #   relationship: one_to_one
  #   fields: [of_booking.non_consolidated*]
  # }
#}


# How to handle incremental refresh - deleting record and inserting it
# Is it known?
