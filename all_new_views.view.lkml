


view: dmo_usr_ext {
  dimension: current_status { 
    view_label: "User"
    group_item_label: "Account Status"
    label: "Account Status"
    sql: CASE ${TABLE}.ACT_FLG WHEN "true" THEN "Active" ELSE "Inactive" END  ;;
  }

 }

