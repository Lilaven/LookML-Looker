


view: of_user {
  sql_table_name: `ONEFORCE.OF_USER` ;;
  dimension: city { 
    label: "City"
    type: string
    sql: ${TABLE}.City ;;
  }

  dimension: country { 
    label: "Country"
    type: string
    sql: ${TABLE}.Country ;;
  }

  dimension: oneforce_id { 
    label: "ONEForce Id"
    primary_key: yes
    type: string
    sql: ${TABLE}.ONEForce_ID ;;
  }

  measure: salesuser_count { 
    type: number
    sql: COUNT (DISTINCT CASE WHEN lower(trim(${profile_name})) = "sales executive" THEN ${oneforce_id} END) ;;
    drill_fields: [ first_name, username, last_name, ] 
  }

  measure: user_count { 
    type: number
    sql: COUNT (distinct ${oneforce_id} ) ;;
    drill_fields: [ drillfields*, ] 
  }

  
  
 }

