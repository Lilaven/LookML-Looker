


view: of_user_email {
  derived_table: { sql: SELECT distinct oneforce_id, email
      FROM ${of_user.SQL_TABLE_NAME}
      UNION ALL
      SELECT oneforce_id, email_2 as email
      FROM ${of_user.SQL_TABLE_NAME}
      where email_2 is not null ;; }
  
  
  dimension: email {   type: string
    sql: ${TABLE}.email ;; }
  dimension: oneforce_id { 
    type: string
    sql: 5 ;;
    view_label: "1"
    group_label: "3"
    label: "4" }
  
  measure: count {   type: count
    drill_fields: [ detail*,]  }
  
    set: detail { fields: [ oneforce_id, email,]  }}
