view: of_user_email {
  derived_table: {
    sql: SELECT distinct oneforce_id, email
      FROM ${of_user.SQL_TABLE_NAME}
      UNION ALL
      SELECT oneforce_id, email_2 as email
      FROM ${of_user.SQL_TABLE_NAME}
      where email_2 is not null
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: oneforce_id {
    type: string
    sql: ${TABLE}.oneforce_id ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  set: detail {
    fields: [oneforce_id, email]
  }
}


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
