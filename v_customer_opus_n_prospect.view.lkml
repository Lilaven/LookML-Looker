view: v_customer_opus_n_prospect {
      sql_table_name: `ONEFORCE.V_CUSTOMER_OPUS_N_PROSPECT` ;;

  dimension: owner_name {
    label: "Owner Name"
    type: string
    sql: ${TABLE}.of_owner_name ;; }

    dimension: owner_office_code {
    label: "Owner Office Code"
    type: string
    sql: ${TABLE}.of_owner_office_code ;;}
}
