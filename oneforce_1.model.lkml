connection: "one_force"

# include all the views
include: "/views/**/*.view"
include: "/models/entities/of_consolidated_explore_data_tests.lkml"
include: "/models/entities/datagroups.lkml"
include: "/dashboards/enterprise_dashboards/*.dashboard.lookml"

persist_with: oneforce_default_datagroup


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

