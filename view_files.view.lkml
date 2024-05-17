include: "of_user.view"


view: of_user {

dimension: crm_trainer { 
    view_label: "User"
    group_item_label: "CRM Trainer"
    label: "CRM Trainer"
    type: string
    sql: ${TABLE}.CRM_TRNR_FLG ;;
  }

  dimension: current_status { 
    view_label: "User"
    group_item_label: "Current Status of User Account"
    label: "Current Status of User Account"
    type: string
    sql: CASE ${TABLE}.ACT_FLG WHEN "true" THEN "Active" ELSE "Inactive" END ;;
  }

  dimension: dynamic_dim_region_country_for_mpr_qbr { 
    view_label: "User"
    group_item_label: "Region"
    label: "Region"
    type: string
    sql: {% if dynamic_param_region_country_for_mpr_qbr._parameter_value == 'country' %}
  ${office_Country_Code}
  {% else %}
  ${regional_head_office_short_nm}
  {% endif %} ;;
  }

view: dmo_usr_ext_login {
  dimension: usr_eml {   
    label: "Email"
    view_label: "User Logged-in"
  }
 }


