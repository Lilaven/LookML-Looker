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
