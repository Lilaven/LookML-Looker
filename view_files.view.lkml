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

 }



view: dmo_usr_ext_login {
  dimension: crm_trnr_flg { 
    view_label: "User"
    group_item_label: "CRM Trainer"
    label: "CRM Trainer"
    sql: ${TABLE}.CRM_TRNR_FLG  ;;
  }

  dimension: mngr_id { 
    view_label: "User"
    group_item_label: "Manager ID"
    label: "Manager ID"
    sql: ${TABLE}.MNGR_ID  ;;
  }

  dimension: of_id_pk { 
    view_label: "User"
    group_item_label: "ONEForce ID"
    label: "ONEForce ID"
    sql: ${TABLE}.OF_ID  ;;
  }

  dimension: spps_crm_usg_kpi_db_flg { 
    view_label: "User"
    group_item_label: "Suppressed in CRM Usage KPI Dashboard"
    label: "Suppressed in CRM Usage KPI Dashboard"
    sql: ${TABLE}.SPRS_CRM_USG_KPI_DB_FLG  ;;
  }

  dimension: usr_eml { 
    view_label: "User"
    group_item_label: "Email"
    label: "Email"
    sql: ${TABLE}.USR_EML  ;;
  }

  dimension: usr_nm { 
    view_label: "User"
    group_item_label: "Account User Name"
    label: "Account User Name"
    sql: ${TABLE}.USR_NM  ;;
  }

  
  dimension_group: crdate { 
    view_label: "User"
    group_label: "Created Date (Local)"
    group_item_label: "{%- assign fieldsname = _field._name | split: '_dt_' | first | append:'_dt_' -%}
	{%- assign timeframe = _field._name | remove: fieldsname  -%}
	{%- case timeframe %}
	{%- when 'time' %}01. Date Time
	{%- when 'date' %}02. Date
	{%- when 'week_of_year' %}03. Week of Year
	{%- when 'month_num' %}04. Month
	{%- when 'quarter_of_year' %}05. Calendar Quarter
	{%- when 'fiscal_quarter_of_year' %}06. Fiscal Quarter
	{%- when 'year' %}07. Calendar Year
	{%- when 'fiscal_year' %}08. Fiscal Year
	{%- else %}{{timeframe}}{% endcase -%}"
    label: "Created"
    type: time
    timeframes: 
	[raw,
	time,
	date,
	week_of_year,
	month_num,
	quarter_of_year,
	fiscal_quarter_of_year,
	year,
	fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.CRE_DT   ;;
  }

 }

