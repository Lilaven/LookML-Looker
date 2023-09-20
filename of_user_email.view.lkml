


view: of_user_email {
  derived_table: { sql: SELECT distinct oneforce_id, email
      FROM ${of_user.SQL_TABLE_NAME}
      UNION ALL
      SELECT oneforce_id, email_2 as email
      FROM ${of_user.SQL_TABLE_NAME}
      where email_2 is not null ;; }
  
  
  dimension: email { 
    type: string
    sql: ${TABLE}.email  ;;
    view_label: "User Email"
    group_item_label: "Email"
    label: "Email" }
  dimension: new_test_field { 
    view_label: "User Email"
    group_item_label: "Test field"
    label: "Test field"
    type: string
    sql: ${TABLE}.oneforce_id  ;; }
  dimension: oneforce_id { 
    type: string
    sql: ${TABLE}.oneforce_id  ;;
    view_label: "User Email"
    group_item_label: "Oneforce ID"
    label: "Oneforce ID" }
  dimension_group: lastlogindate { 
    timeframes: [time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Sales Rep"
    group_label: "Last Login Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_user_email.lastlogindate_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Date'%}02. Date
  {% when 'Week of year'%}03. Week of Year
  {% when 'Month num'%}04. Month
  {% when 'Quarter of year' %}05. Calendar Quarter
  {% when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {% when 'Year' %}07. Calendar Year
  {% when 'Fiscal year' %}08. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Test last Login"
    convert_tz: no
    sql: timestamp(${TABLE}.LastLoginDate)  ;; }
  measure: count {   type: count
    drill_fields: [ detail*,]  }
  measure: total_teu { 
    view_label: "Measure"
    group_item_label: "Total Teu"
    label: "Test total Teu"
    type: sum
    description: "TEU till last completed month in the specified fiscal year"
    value_format: "#,##0.00"
    sql: coalesce(${teu},0) ;; }
  
    set: detail { fields: [ oneforce_id, email,]  }}


view: usr {
  sql_table_name: public.users ;;
  
  
  dimension: email {  }
  dimension: id {  }
  dimension_group: created {   timeframes: [ raw, date, month, year,] 
    type: time }
  
  }


view: usr_profile {
  derived_table: { explore_source: _eav_flattener { 
    column: user_id {     field: _eav_flattener.user_id }
    column: org_id {     field: _eav_flattener.org_id } } }
  
  
  dimension: org_id {  }
  dimension: user_id {  }
  
  
  }
