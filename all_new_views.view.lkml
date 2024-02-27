


view: of_case {
  dimension: account_id { 
    view_label: "Case Information"
    group_item_label: "Account ID"
    label: "Account ID"
    type: string
    sql: ${TABLE}.AccountId ;; }
  dimension: case_age { 
    view_label: "Case Information"
    group_item_label: "Case Age"
    label: "Case Age"
    type: number
    sql: ${TABLE}.Case_Age ;; }
  dimension: case_age_group { 
    view_label: "Case Information"
    group_item_label: "Case Age Group"
    label: "Case Age Group"
    type: number
    sql: CASE
      WHEN ${TABLE}.Case_Age <=2 THEN "1-2 Days"
      WHEN ${TABLE}.Case_Age >2 and ${TABLE}.Case_Age <=5 THEN "3-5 Days"
      WHEN ${TABLE}.Case_Age >5 and ${TABLE}.Case_Age <=10 THEN "6-10 Days"
      WHEN ${TABLE}.Case_Age >10 and ${TABLE}.Case_Age <=20 THEN "11-20 Days"
      ELSE "More than 20 Days" END  ;; }
  dimension: case_channel_or_geography_dynamic { 
    view_label: "Case Information"
    group_item_label: "Geography Dynamic Backlog History"
    label: "Geography Dynamic Backlog History"
    type: string
    sql: CASE
  WHEN {% parameter Customer_Param %} = "RHQ" THEN ${RHQ}
  WHEN {% parameter Customer_Param %} = "Cluster Country" THEN ${cluster_country}
  WHEN {% parameter Customer_Param %} = "Individual Country" THEN ${individual_country}
  WHEN {% parameter Customer_Param %} = "Office" THEN ${office_code}
  WHEN {% parameter Customer_Param %} = "Channel" THEN ${origin}
  WHEN {% parameter Customer_Param %} = "Status" THEN ${of_case_history_status_stat.status}
  WHEN {% parameter Customer_Param %} = "Segment" THEN ${key_acct_tp_cd}
  WHEN {% parameter Customer_Param %} = "Agent Role" THEN ${profile_name_service}
  WHEN {% parameter Customer_Param %} = "Escalation Role" THEN ${escl_role}
  WHEN {% parameter Customer_Param %} = "Office Type" THEN ${office_type}
  WHEN {% parameter Customer_Param %} = "Service Type" THEN ${service_type}
  ELSE "Global" END ;; }
  dimension: case_first_response_time_mins { 
    view_label: "Measures"
    group_label: "First Response Time"
    group_item_label: "Case FRT (mins)"
    label: "Case FRT (mins)"
    type: number
    sql: ${TABLE}.First_Response_Time_Minutes ;; }
  dimension: case_net_promoter_score { 
    view_label: "Case Information"
    group_item_label: "Case Net Promotor Score"
    label: "Case Net Promotor Score"
    type: number
    sql: ${TABLE}.Case_Net_Promoter_Score ;; }
  dimension: case_number { 
    view_label: "Case Information"
    group_item_label: "Case Number"
    label: "Case Number"
    type: string
    sql: ${TABLE}.CaseNumber ;; }
  dimension: case_owner_last_name { 
    view_label: "Owner Information"
    group_item_label: "Last Name"
    label: "Last Name"
    type: string
    sql: ${TABLE}.case_owner_last_name ;; }
  dimension: case_owner_name { 
    view_label: "Owner Information"
    group_item_label: "Name"
    label: "Name"
    type: string
    sql: ${TABLE}.case_owner_name ;; }
  dimension: case_rating { 
    view_label: "Measures"
    group_label: "CSAT"
    group_item_label: "Case Rating"
    label: "Case Rating"
    type: string
    sql: CASE WHEN ${TABLE}.case_rating IS NULL THEN 'No Rating' ELSE ${TABLE}.case_rating END ;; }
  dimension: case_reopened { 
    view_label: "Case Information"
    group_item_label: "Case Reopened"
    label: "Case Reopened"
    type: string
    sql: CASE WHEN ${is_reopened} = "true" THEN "Yes" ELSE "No" END ;; }
  dimension: cluster_country { 
    view_label: "Case Information"
    group_label: "Service Office Information"
    group_item_label: "Cluster Country"
    label: "Cluster Country"
    type: string
    sql: ${TABLE}.cluster_country ;; }
  dimension: contact_email { 
    view_label: "Case Information"
    group_item_label: "Contact Email"
    label: "Contact Email"
    type: string
    sql: ${TABLE}.ContactEmail ;; }
  dimension: contract_number { 
    view_label: "Case Information"
    group_item_label: "Contract Number"
    label: "Contract Number"
    type: string
    sql: ${TABLE}.Contract_Number ;; }
  dimension: country { 
    view_label: "Case Information"
    group_item_label: "Country"
    label: "Country"
    type: string
    sql: ${TABLE}.Country ;; }
  dimension: country_code_case_owner { 
    view_label: "Owner Information"
    group_label: "Office Information"
    group_item_label: "Country Code"
    label: "Country Code"
    type: string
    sql: ${TABLE}.country_code_case_owner ;; }
  dimension: ct_owner_name1 { 
    view_label: "Case Information"
    group_item_label: "Chat Owner Name"
    label: "Chat Owner Name"
    type: string
    sql: CASE WHEN ${ct_queue.developer_name} is not Null then ${ct_queue.developer_name} else ${ct_owner.name} END ;; }
  dimension: ecomm_id { 
    view_label: "Case Information"
    group_item_label: "eComm ID"
    label: "eComm ID"
    type: string
    sql: ${TABLE}.Contact_eComm_User_ID ;; }
  dimension: escl_role { 
    view_label: "Case Information"
    group_item_label: "Current Escalation Role"
    label: "Current Escalation Role"
    type: string
    sql: ${TABLE}.escl_role ;; }
  dimension: first_contact_resolution { 
    view_label: "Measures"
    group_item_label: "First Contact Resolution"
    label: "Is Case FCR (Yes/No)"
    type: string
    sql: CASE
  WHEN ${origin} = 'Chat' and ${TABLE}.is_fcr ='true' THEN 'Yes'
  WHEN ${origin} = 'Chat' and ${TABLE}.is_fcr ='false' THEN 'No'
  WHEN ${total_escalation} =0 and ${transfer_reason} is Null and ${active_case} = 'No' THEN 'Yes' ELSE 'No' END  ;; }
  dimension: has_leave_message { 
    view_label: "Case Information"
    group_item_label: "Has Leave Message"
    label: "Has Leave Message"
    type: string
    sql: CASE WHEN ${TABLE}.Has_Leave_Message = "true" then "Yes" ELSE "No" END ;; }
  dimension: individual_country { 
    view_label: "Case Information"
    group_label: "Service Office Information"
    group_item_label: "Individual Country"
    label: "Individual Country"
    type: string
    sql: ${TABLE}.individual_country ;; }
  dimension: initial_queue_name { 
    view_label: "Case Information"
    group_item_label: "Initial Queue Name"
    label: "Initial Queue Name"
    type: string
    sql: CASE WHEN ${origin} = "Chat"  THEN ${of_chat_transcript_v2.chat_first_queue_name} else ${TABLE}.Initial_Queue_Name END ;; }
  dimension: is_service_or_contract_customer { 
    view_label: "Case Information"
    group_item_label: "Service or Contract Customer"
    label: "Service or Contract Customer"
    type: string
    sql: (CASE
      WHEN ${account_id} is not null AND ${contract_customer_name} is not null THEN 'Both'
      WHEN ${account_id} is not null THEN 'Service Customer'
      WHEN ${contract_customer_name} is not null THEN 'Contract Customer'
      Else 'None' END) ;; }
  dimension: key_acct_tp_cd { 
    view_label: "Case Information"
    group_item_label: "Key Account Type Code"
    label: "Key Account Type Code"
    type: string
    sql: ${TABLE}.key_acct_tp_cd ;; }
  dimension: key_acct_tp_cd_ord { 
    view_label: "Case Information"
    group_item_label: "Key Acct Tp Cd Ord"
    label: "Key Acct Tp Cd Ord"
    type: number
    sql: CASE
      WHEN ${TABLE}.KEY_ACCT_TP_CD ='GKA' THEN 1
      WHEN ${TABLE}.KEY_ACCT_TP_CD ='RKA' THEN 2
      WHEN ${TABLE}.KEY_ACCT_TP_CD ='LKA' THEN 3
      WHEN ${TABLE}.KEY_ACCT_TP_CD ='SME' THEN 4
      ELSE 4 END  ;; }
  dimension: label { 
    view_label: "Case Information"
    group_item_label: "Label"
    label: "Label"
    type: string
    sql: ${TABLE}.Label ;; }
  dimension: nps_group { 
    view_label: "Case Information"
    group_item_label: "NPS Segment"
    label: "NPS Segment"
    type: string
    sql: (CASE
  WHEN ${TABLE}.Case_Net_Promoter_Score <7 THEN 'Detractors'
  WHEN ${TABLE}.Case_Net_Promoter_Score >=7 and ${TABLE}.Case_Net_Promoter_Score <9 THEN 'Passives'
  WHEN ${TABLE}.Case_Net_Promoter_Score >=9 THEN 'Promoters'
  ELSE 'No Rating' END)  ;; }
  dimension: office_code { 
    view_label: "Case Information"
    group_label: "Service Office Information"
    group_item_label: "Office Code"
    label: "Office Code"
    type: string
    sql: `ONEFORCE.offshore_ofc_cd_conv`(${TABLE}.Office) ;; }
  dimension: office_code_case_owner { 
    view_label: "Owner Information"
    group_label: "Office Information"
    group_item_label: "Office Code"
    label: "Office Code"
    type: string
    sql: ${TABLE}.office_code_case_owner ;; }
  dimension: office_type { 
    view_label: "Case Information"
    group_label: "Service Office Information"
    group_item_label: "Office Type"
    label: "Office Type"
    type: string
    sql: COALESCE(${TABLE}.office_type, "Others") ;; }
  dimension: origin { 
    view_label: "Case Information"
    group_item_label: "Channel"
    label: "Channel"
    type: string
    sql: ${TABLE}.Origin ;; }
  dimension: original_record_type { 
    view_label: "Case Information"
    group_item_label: "Original Record Type"
    label: "Original Record Type"
    type: string
    sql: ${TABLE}.Original_Record_Type ;; }
  dimension: priority { 
    view_label: "Case Information"
    group_item_label: "Priority"
    label: "Priority"
    type: string
    sql: ${TABLE}.Priority ;; }
  dimension: profile_name_service { 
    view_label: "Case Information"
    group_item_label: "Profile Name Service"
    label: "Profile Name Service"
    type: string
    sql: ${TABLE}.profile_name_service ;; }
  dimension: reason { 
    view_label: "Case Information"
    group_label: "Intents"
    group_item_label: "Category (L1)"
    label: "Category (L1)"
    type: string
    sql: ${TABLE}.Reason ;; }
  dimension: rhq { 
    view_label: "Case Information"
    group_label: "Service Office Information"
    group_item_label: "RHQ"
    label: "RHQ"
    type: string
    sql: ${TABLE}.RHQ ;; }
  dimension: rhq_case_owner { 
    view_label: "Owner Information"
    group_label: "Office Information"
    group_item_label: "RHQ"
    label: "RHQ"
    type: string
    sql: ${TABLE}.rhq_case_owner ;; }
  dimension: service_type { 
    view_label: "Case Information"
    group_item_label: "Service Type"
    label: "Service Type"
    type: string
    sql: ${TABLE}.type ;; }
  dimension: status { 
    view_label: "Case Information"
    group_item_label: "Status"
    label: "Status"
    type: string
    sql: ${TABLE}.Status ;; }
  dimension: sub_category_l2 { 
    view_label: "Case Information"
    group_label: "Intents"
    group_item_label: "Category (L2)"
    label: "Category (L2)"
    type: string
    sql: ${TABLE}.Sub_Category_L2 ;; }
  dimension: subordinate_category_l3 { 
    view_label: "Case Information"
    group_label: "Intents"
    group_item_label: "Topic (L3)"
    label: "Topic (L3)"
    type: string
    sql: ${TABLE}.Subordinate_Category_L3 ;; }
  dimension: subordinate_category_l4 { 
    view_label: "Case Information"
    group_label: "Intents"
    group_item_label: "Subtopic (L3)"
    label: "Subtopic (L3)"
    type: string
    sql: ${TABLE}.Subordinate_Category_L4 ;; }
  dimension: supplied_email { 
    view_label: "Case Information"
    group_item_label: "Web Email"
    label: "Web Email"
    type: string
    sql: ${TABLE}.SuppliedEmail ;; }
  dimension_group: closed_date { 
    timeframes: [raw,
  time,
  hour_of_day,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Case Information"
    group_label: "Close Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_case.closed_date_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Hour of day'%}02. Hour of the Day
  {% when 'Date'%}03. Date
  {% when 'Week of year'%}04. Week of Year
  {% when 'Month num'%}05. Month
  {% when 'Quarter of year' %}06. Calendar Quarter
  {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
  {% when 'Year' %}08. Calendar Year
  {% when 'Fiscal year' %}09. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Close"
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.ClosedDate ;; }
  dimension_group: created_date { 
    timeframes: [raw,
  time,
  hour_of_day,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Case Information"
    group_label: "Open Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_case.created_date_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Hour of day'%}02. Hour of the Day
  {% when 'Date'%}03. Date
  {% when 'Week of year'%}04. Week of Year
  {% when 'Month num'%}05. Month
  {% when 'Quarter of year' %}06. Calendar Quarter
  {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
  {% when 'Year' %}08. Calendar Year
  {% when 'Fiscal year' %}09. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Open"
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.CreatedDate ;; }
  dimension_group: resolved_date { 
    timeframes: [raw,
  time,
  hour_of_day,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Case Information"
    group_label: "Resolved Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_case.resolved_date_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Hour of day'%}02. Hour of the Day
  {% when 'Date'%}03. Date
  {% when 'Week of year'%}04. Week of Year
  {% when 'Month num'%}05. Month
  {% when 'Quarter of year' %}06. Calendar Quarter
  {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
  {% when 'Year' %}08. Calendar Year
  {% when 'Fiscal year' %}09. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Resolved"
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.DateTimeResolved ;; }
  measure: case_distinct_count { 
    view_label: "Measure"
    group_item_label: "Case Distinct Count"
    label: "Case Distinct Count"
    type: count_distinct
    sql: ${case_number} ;; }
  measure: case_handling_time_avg { 
    view_label: "Measure"
    group_item_label: "Case Handle Time (mins)"
    label: "Case Handle (mins)"
    type: average_distinct
    sql: ${TABLE}.Case_Handle_Time_Minutes ;; }
  }


view: of_queue {
  dimension: country_queue { 
    view_label: "Queue"
    group_item_label: "County Code Queue"
    label: "County Code Queue"
    type: string
    sql: ${TABLE}.country_queue ;; }
  dimension: created_by { 
    view_label: "Queue"
    group_item_label: "Created By"
    label: "Created By"
    type: string
    sql: ${TABLE}.CreatedById ;; }
  dimension: developer_name { 
    view_label: "Queue"
    group_item_label: "Queue Name"
    label: "Queue Name"
    type: string
    sql: ${TABLE}.DeveloperName ;; }
  dimension: modified_by { 
    view_label: "Queue"
    group_item_label: "Modified By"
    label: "Modified By"
    type: string
    sql: ${TABLE}.LastModifiedById ;; }
  dimension: office_queue { 
    view_label: "Queue"
    group_item_label: "Office Code Queue"
    label: "Office Code Queue"
    type: string
    sql: ${TABLE}.office_queue ;; }
  dimension: oneforce_id { 
    view_label: "Queue"
    group_item_label: "OneForce ID"
    label: "OneForce ID"
    type: string
    sql: ${TABLE}.ONEForce_ID ;; }
  dimension: ownedby_queue { 
    view_label: "Case"
    group_item_label: "Case Owned by Queue"
    label: "Case Owned by Queue"
    type: string
    sql: ${TABLE}.ownedByQueue ;; }
  dimension: owner_id { 
    view_label: "Queue"
    group_item_label: "Owner ID"
    label: "Owner ID"
    type: string
    sql: ${TABLE}.OwnerId ;; }
  dimension: queue_email { 
    view_label: "Queue"
    group_item_label: "Queue Email"
    label: "Queue Email"
    type: string
    sql: ${TABLE}.Email ;; }
  
  
  }


view: of_case_history_user_name {
  dimension: name { 
    view_label: "Case History Owner"
    group_item_label: "Name"
    label: "Name"
    type: string
    sql: ${TABLE}.User_Name ;; }
  
  
  }


view: of_case_history_queue_name {
  dimension: developer_name { 
    view_label: "Case History Owner"
    group_item_label: "Queue Name"
    label: "Queue Name"
    type: string
    sql: ${TABLE}.DeveloperName ;; }
  
  
  }


view: of_case_history_owner_stat {
  dimension: case_id { 
    view_label: "Case Owner History"
    group_item_label: "Case ID"
    label: "Case ID"
    type: string
    sql: ${TABLE}.CASEID ;; }
  dimension: cnt_cd { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "09. Office Country Code"
    label: "Case Owner Office Country Code"
    sql: ${TABLE}.CNT_CD  ;; }
  dimension: cnt_nm { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "10. Office Country Name"
    label: "Case Owner Office Country Name"
    sql: ${TABLE}.CNT_NM  ;; }
  dimension: conti_cd { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "13. Office Continent Code"
    label: "Case Owner Office Continent Code"
    sql: ${TABLE}.CONTI_CD  ;; }
  dimension: conti_nm { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "14. Office Continent Name"
    label: "Case Owner Office Continent Name"
    sql: ${TABLE}.CONTI_NM  ;; }
  dimension: loc_cd { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "05. Office Location Code"
    label: "Case Owner Office Location Code"
    sql: ${TABLE}.LOC_CD  ;; }
  dimension: loc_nm { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "06. Office Location Name"
    label: "Case Owner Office Location Name"
    sql: ${TABLE}.LOC_NM  ;; }
  dimension: of_id_pk { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "01. Owner ID"
    label: "Case Owner ID"
    type: string
    sql: ${TABLE}.OF_ID  ;; }
  dimension: ofc_cd_no { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "03. Office Code"
    label: "Case Owner Office Code"
    sql: ${TABLE}.OFC_CD_NO  ;; }
  dimension: ofc_eng_nm { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "04. Office Name"
    label: "Case Owner Office Name"
    sql: ${TABLE}.OFC_ENG_NM  ;; }
  dimension: ofc_tp_nm { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "16. Office Type"
    label: "Case Owner Office Type"
    sql: ${TABLE}.OFC_TP_NM  ;; }
  dimension: owner_type { 
    view_label: "Case Owner History"
    group_item_label: "Owner Type"
    label: "Case Owner Type"
    type: string
    sql: CASE WHEN ${of_case_history_queue_name.developer_name} is NULL THEN 'Individual' ELSE 'Queue' END ;; }
  dimension: rgn_cd { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "07. Office Region Code"
    label: "Case Owner Office Region Code"
    sql: ${TABLE}.RGN_CD  ;; }
  dimension: rgn_nm { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "08. Office Region Name"
    label: "Case Owner Office Region Name"
    sql: ${TABLE}.RGN_NM  ;; }
  dimension: rhq_cd { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "15. Office RHQ"
    label: "Case Owner Office RHQ"
    sql: CASE WHEN ${TABLE}.RHQ_CD IS NOT NULL THEN RIGHT(${TABLE}.RHQ_CD, 5) ELSE "Unclaimed" END  ;; }
  dimension: sconti_cd { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "11. Office Subcontinent Code"
    label: "Case Owner Office Subcontinent Code"
    sql: ${TABLE}.SCONTI_CD  ;; }
  dimension: sconti_nm { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "12. Office Subcontinent Name"
    label: "Case Owner Office Subcontinent Name"
    sql: ${TABLE}.SCONTI_NM  ;; }
  dimension: usr_nm { 
    view_label: "Case Owner History"
    group_label: "Owner"
    group_item_label: "02. Owner Name"
    label: "Case Owner Name"
    sql: ${TABLE}.USR_NM  ;; }
  dimension_group: end_date { 
    timeframes: [raw,
  time,
  hour_of_day,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Case Owner History"
    group_label: "End Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_case_history_owner_stat.end_date_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Hour of day'%}02. Hour of the Day
  {% when 'Date'%}03. Date
  {% when 'Week of year'%}04. Week of Year
  {% when 'Month num'%}05. Month
  {% when 'Quarter of year' %}06. Calendar Quarter
  {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
  {% when 'Year' %}08. Calendar Year
  {% when 'Fiscal year' %}09. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "End"
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.ENDDATE ;; }
  dimension_group: start_date { 
    timeframes: [raw,
  time,
  hour_of_day,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Case Owner History"
    group_label: "Start Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_case_history_owner_stat.start_date_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Hour of day'%}02. Hour of the Day
  {% when 'Date'%}03. Date
  {% when 'Week of year'%}04. Week of Year
  {% when 'Month num'%}05. Month
  {% when 'Quarter of year' %}06. Calendar Quarter
  {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
  {% when 'Year' %}08. Calendar Year
  {% when 'Fiscal year' %}09. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Start"
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.STARTDATE ;; }
  
  }


view: of_case_history_status_stat {
  dimension: case_id { 
    view_label: "Case Status History"
    group_item_label: "Case ID"
    label: "Case ID"
    type: string
    sql: ${TABLE}.CASEID ;; }
  dimension: status { 
    view_label: "Case Status History"
    group_item_label: "Status"
    label: "Status"
    type: string
    sql: ${TABLE}.STATUS ;; }
  dimension_group: end_date { 
    timeframes: [raw,
  time,
  hour_of_day,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Case Status History"
    group_label: "End Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_case_history_status_stat.end_date_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Hour of day'%}02. Hour of the Day
  {% when 'Date'%}03. Date
  {% when 'Week of year'%}04. Week of Year
  {% when 'Month num'%}05. Month
  {% when 'Quarter of year' %}06. Calendar Quarter
  {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
  {% when 'Year' %}08. Calendar Year
  {% when 'Fiscal year' %}09. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "End"
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.ENDDATE ;; }
  dimension_group: start_date { 
    timeframes: [raw,
  time,
  hour_of_day,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Case Status History"
    group_label: "Start Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_case_history_status_stat.start_date_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Hour of day'%}02. Hour of the Day
  {% when 'Date'%}03. Date
  {% when 'Week of year'%}04. Week of Year
  {% when 'Month num'%}05. Month
  {% when 'Quarter of year' %}06. Calendar Quarter
  {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
  {% when 'Year' %}08. Calendar Year
  {% when 'Fiscal year' %}09. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Start"
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.STARTDATE ;; }
  
  }


view: of_case_statistics_v2 {
  dimension: case_id { 
    view_label: "Case History Time"
    group_item_label: "Case ID"
    label: "Case ID"
    type: string
    sql: ${TABLE}.CASEID ;; }
  dimension_group: split_localtime { 
    timeframes: [raw,
  time,
  hour_of_day,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Case History Time"
    group_label: "Split Local Time Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_case_statistics_v2.split_localtime_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Hour of day'%}02. Hour of the Day
  {% when 'Date'%}03. Date
  {% when 'Week of year'%}04. Week of Year
  {% when 'Month num'%}05. Month
  {% when 'Quarter of year' %}06. Calendar Quarter
  {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
  {% when 'Year' %}08. Calendar Year
  {% when 'Fiscal year' %}09. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Split Local"
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.Split_LocalTime ;; }
  dimension_group: split_utc { 
    timeframes: [raw,
  time,
  hour_of_day,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Case History Time"
    group_label: "Split UTC Date (UTC)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_case_statistics_v2.split_utc_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Hour of day'%}02. Hour of the Day
  {% when 'Date'%}03. Date
  {% when 'Week of year'%}04. Week of Year
  {% when 'Month num'%}05. Month
  {% when 'Quarter of year' %}06. Calendar Quarter
  {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
  {% when 'Year' %}08. Calendar Year
  {% when 'Fiscal year' %}09. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Split UTC"
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.Split_UTC ;; }
  
  }


view: of_sales_team_member {
  dimension: team_role { 
    view_label: "Case Owner Information"
    group_item_label: "Team Member Role"
    label: "Team Member Role"
    type: string
    sql: ${TABLE}.Team_Role ;; }
  
  
  }


view: of_chat_transcript_v2 {
  dimension: chat_first_queue_name { 
    view_label: "Chat Transcript"
    group_item_label: "Chat First Queue Name"
    label: "Chat First Queue Name"
    type: string
    sql: ${TABLE}.Chat_First_Queue_Name_Detail ;; }
  dimension: chat_first_response_time_mins { 
    view_label: "Chat Transcript"
    group_item_label: "Chat FRT (Mins)"
    label: "Chat FRT (Mins)"
    type: number
    sql: ${TABLE}.Chat_First_Response_Time_Mins ;; }
  dimension: origin { 
    view_label: "Chat Transcript"
    group_item_label: "Origin"
    label: "Origin"
    type: string
    sql: ${TABLE}.Origin ;; }
  
  measure: chat_first_response_time_mins_avg { 
    view_label: "Measure"
    group_item_label: "Avg Chat FRT (mins)"
    label: "Avg Chat FRT (mins)"
    type: average_distinct
    sql: ${chat_first_response_time_mins} ;; }
  measure: chat_handle_time1 { 
    view_label: "Measure"
    group_item_label: "Avg Chat Handle Time (mins)"
    label: "Avg Chat Handle (mins)"
    type: average_distinct
    sql: ${TABLE}.Chat_Handle_Time ;; }
  }


view: ct_owner {
  dimension: name { 
    view_label: "Chat Transcript Owner"
    group_item_label: "Name"
    label: "Name"
    type: string
    sql: ${TABLE}.User_Name ;; }
  
  
  }


view: ct_queue {
  dimension: developer_name { 
    view_label: "Chat Transcript Owner"
    group_item_label: "Queue Name"
    label: "Queue Name"
    type: string
    sql: ${TABLE}.DeveloperName ;; }
  
  
  }


view: of_contact {
  dimension: email { 
    view_label: "Contact Details"
    group_item_label: "Contact Email"
    label: "Contact Email"
    type: string
    sql: ${TABLE}.email ;; }
  dimension: name { 
    view_label: "Contact Details"
    group_item_label: "Contact Name"
    label: "Contact Name"
    type: string
    sql: ${TABLE}.name ;; }
  
  
  }


view: of_customer {
  dimension: cust_cd_and_name { 
    view_label: "Customer"
    group_item_label: "Customer"
    label: "Customer"
    type: string
    sql: CONCAT(${TABLE}.cust_cd, "-", ${TABLE}.name) ;; }
  dimension: cust_grp_and_name { 
    view_label: "Customer"
    group_item_label: "Customer Group"
    label: "Customer Group"
    type: string
    sql: CONCAT(${TABLE}.cust_grp_id, "-", ${TABLE}.cust_grp_nm) ;; }
  dimension: cust_grp_id { 
    view_label: "Customer"
    group_item_label: "Customer Group ID"
    label: "Customer Group ID"
    type: string
    sql: ${TABLE}.cust_grp_id ;; }
  dimension: cust_grp_nm { 
    view_label: "Customer"
    group_item_label: "Customer Group Name"
    label: "Customer Group Name"
    type: string
    sql: ${TABLE}.cust_grp_nm ;; }
  dimension: customer_type { 
    view_label: "Customer"
    group_item_label: "Customer Type"
    label: "Customer Type"
    type: string
    sql: CASE WHEN ${cntr_cust_tp_cd} = "B" THEN "BCO"
      WHEN ${cntr_cust_tp_cd} = "N" THEN "NVO" ELSE Null END  ;; }
  dimension: grp_oneforce_id { 
    view_label: "Customer"
    group_item_label: "Customer Group Oneforce ID"
    label: "Customer Group Oneforce ID"
    type: string
    sql: ${TABLE}.grp_oneforce_id ;; }
  dimension: name { 
    view_label: "Customer"
    group_item_label: "Customer Name"
    label: "Customer Name"
    type: string
    sql: ${TABLE}.name ;; }
  
  
  }


view: leave_a_message_cases {
  dimension: case_id { 
    view_label: "Leave A Message Cases"
    group_item_label: "Case ID"
    label: "Case ID"
    type: string
    sql: ${TABLE}.CaseId ;; }
  dimension: is_first_chat_leave_a_message { 
    view_label: "Leave A Message Cases"
    group_item_label: "Is First Chat Leave A Message"
    label: "Is First Chat Leave A Message"
    type: string
    sql: ${TABLE}.Is_Chat_Leave_a_Message ;; }
  
  
  }
