view: of_user {
  sql_table_name:  `ONEFORCE.OF_USER` ;;

  dimension: oneforce_id {
    label: "ONEForce Id"  
    primary_key: yes
    type: string
    sql: ${TABLE}.ONEForce_ID ;;
  }

  dimension: city {
    label: "City" 
    type: string
    sql: ${TABLE}.City ;;
  }
  dimension: country {
    label: "Country"  
    type: string
    #map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  measure: salesuser_count {
    type: number
    sql: COUNT (DISTINCT CASE WHEN lower(trim(${profile_name})) = "sales executive" THEN ${oneforce_id} END) ;;
    drill_fields: [first_name, username, last_name]
  }

  measure: user_count {
    type: number
    sql: COUNT (distinct ${oneforce_id} ) ;;
    filters: [city: "-NULL"]
    drill_fields: [drillfields*]
  }
}
  

view: user_count_n_login_hist_of_user_logged {
  extends: [of_user]

  dimension: country {   
    label: "Country"
    view_label: "User Logged-in"
  }

  dimension: office_code {   
    label: "Office."
    view_label: "User Logged-in"
  }

  dimension: region_3char {   
    label: "Region"
    view_label: "User Logged-in"
  }

 }

