view: dmo_case_v_ext_epx {
  extends: [dmo_case]

  ###---------- SR0374537: Remove Leave a Message ----------###
  ############## SR0381908: Modify Chat Channel ##############
  dimension: cs_ori {
    hidden: no
    view_label: "Case Info"
    group_item_label: "Channel"
    label: "Case Channel"
    # sql: CASE WHEN ${TABLE}.CS_ORI IN ("Chat", "Web") AND ${dmo_leave_a_msg_cs.is_cht_leave_msg} = "true" THEN "Leave A Message"
    #   ELSE ${TABLE}.CS_ORI END ;;
    sql: CASE WHEN ${dmo_leave_a_msg_cs.is_cht_leave_msg} = "true" THEN "Chat" ELSE ${TABLE}.CS_ORI END ;;
  }

  ### PI4V2-23038: SR0392396 - Request to group Case Channels
  dimension: cs_cnl_grp {
    hidden: no
    view_label: "Case Info"
    group_label: ""
    group_item_label: "Channel Group"
    label: "Case Channel Group"
  }

  #PI4V2-22656: Combine Case & Chat FRT as Case/Chat FRT test
  dimension: cs_ori_combine {
    hidden: no
    view_label: "Case Info"
    group_item_label: "Channel"
    label: "Case/Chat Channel"
    # sql: CASE WHEN ${TABLE}.CS_ORI IN ("Chat", "Web") AND ${dmo_leave_a_msg_cs.is_cht_leave_msg} = "true" THEN "Leave A Message"
    #   ELSE ${TABLE}.CS_ORI END ;;
    sql: CASE WHEN ${dmo_chat_tc_ext_epx.hs_lv_mess_flg} = "Yes" THEN "Chat" ELSE ${TABLE}.CS_ORI END ;;
  }

  dimension: cs_stt {
    hidden: no
    view_label: "Case Info"
    group_item_label: "Status"
    label: "Case Status"
  }

  dimension: cs_prio {
    hidden: no
    view_label: "Case Info"
    group_item_label: "Priority"
    label: "Case Priority"
  }

  dimension: cs_no {
    hidden: no
    view_label: "Case Info"
    group_item_label: "Number"
    label: "Case Number"
    link: {
      label: "ONE Force Case Details"
      url: "https://one-line.lightning.force.com/lightning/r/Case/{{ of_id_pk._value }}/view"
      icon_url: "http://www.google.com/s2/favicons?domain=https://one-line.lightning.force.com/lightning/page/home"
    }
  }

  dimension: cs_age {
    hidden: no
    view_label: "Case Info"
    group_item_label: "Age"
    label: "Case Age"
  }

  dimension: cs_desc {
    hidden: no
    view_label: "Case Info"
    group_item_label: "Description"
    label: "Case Description"
  }

  dimension: org_rec_tp {
    hidden: no
    view_label: "Case Info"
    group_item_label: "Original Record Type"
    label: "Case Original Record Type"
  }

  dimension: cs_tp {
    hidden: no
    view_label: "Case Info"
    group_item_label: "Service Type"
    label: "Case Service Type"
  }

  dimension: kpi {
    hidden: no
    view_label: "Case Info"
    group_item_label: "KPI"
    label: "Case KPI"
  }

  dimension: spl_eml {
    hidden: no
    view_label: "Case Info"
    group_item_label: "Web Email"
    label: "Case Web Email"
  }

  dimension: spl_eml_grp {
    hidden: no
    view_label: "Case Info"
    group_item_label: "Web Email Group"
    label: "Case Web Email Group"
  }

  dimension: is_active {
    hidden: no
    view_label: "Case Info"
    group_label: "Nature"
    group_item_label: "Is Active (Yes/No)"
    label: "Is Case Active ?"
  }

  dimension: is_cus_tlk_bot_using_nlp {
    hidden: no
    view_label: "Case Info"
    group_label: "Nature"
    group_item_label: "Is Customer Talk With Bot Using NLP (Yes/No)"
    label: "Is Customer Talk With Bot Using NLP ?"
  }

  dimension: is_rsvld_by_auto {
    view_label: "Case Info"
    group_label: "Nature"
    group_item_label: "Is Resolved By Automation (Yes/No)"
    label: "Is Resolved By Automation ?"
    type: string
    sql: CASE WHEN ${dmo_case_owner.usr_nm} = 'Platform Integration User' THEN 'Yes' ELSE 'No' END ;;
  }

  dimension: is_reopened {
    hidden: no
    view_label: "Case Info"
    group_label: "Nature"
    group_item_label: "Is Reopened (Yes/No)"
    label: "Is Case Reopened ?"
  }

  dimension: is_fcr_yn {
    hidden: no
    view_label: "Case Info"
    group_label: "Nature"
    group_item_label: "Is FCR (Yes/No)"
    label: "Is Case FCR ?"
  }

  dimension: is_ntrd_yn {
    hidden: no
    view_label: "Case Info"
    group_label: "Nature"
    group_item_label: "Is Nurtured (Yes/No)"
    label: "Is Case Nurtured ?"
  }

  dimension: is_esc_yn {
    hidden: no
    view_label: "Case Info"
    group_label: "Nature"
    group_item_label: "Is Escalated (Yes/No)"
    label: "Is Case Escalated ?"
  }

  dimension: is_cre_in_outage {
    hidden: no
    view_label: "Case Info"
    group_label: "Nature"
    group_item_label: "Is Created In Outage (Yes/No)"
    label: "Is Created In Outage"
  }

  dimension: chat_slf_svc_flg {
    hidden: no
    view_label: "Case Info"
    group_label: "Nature"
    group_item_label: "Is Chat Self Service (Yes/No)"
    label: "Is Chat Self Service"

  }

  dimension: cs_subj {
    hidden: no
    view_label: "Case Info"
    group_item_label: "Subject"
    label: "Case Subject"
  }

  # dimension_group: cre_dt_tz {
  #   view_label: "Case Info"
  #   group_label: "Open Date (TZ)"
  #   group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_case_v_ext_epx.cre_dt_tz_' | replace: '_',' ' | capitalize %} {% case timeframe %}
  #   {% when 'Time'%}01. Date Time
  #   {% when 'Hour of day'%}02. Hour of the Day
  #   {% when 'Date'%}03. Date
  #   {% when 'Week of year'%}04. Week of Year
  #   {% when 'Month num'%}05. Month Number
  #   {% when 'Month name'%}06. Month Name
  #   {% when 'Quarter of year' %}07. Calendar Quarter
  #   {% when 'Fiscal quarter of year' %}08. Fiscal Quarter
  #   {% when 'Year' %}09. Calendar Year
  #   {% when 'Fiscal year' %}10. Fiscal Year
  #   {% else %}{{ timeframe}}{% endcase %}"
  #   label: "Case Open Date Time (TZ)"
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     hour_of_day,
  #     date,
  #     week_of_year,
  #     month_num,
  #     month_name,
  #     quarter_of_year,
  #     year,
  #     fiscal_quarter_of_year,
  #     fiscal_year
  #   ]
  #   datatype: datetime
  #   # We would like to keep convert_tz: yes due to business requirement
  #   convert_tz: yes
  #   sql: ${TABLE}.CRE_DT ;;
  # }

  dimension_group: cre_dt_utc {
    view_label: "Case Info"
    group_label: "Open Date (UTC)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_case_v_ext_epx.cre_dt_utc_' | replace: '_',' ' | capitalize %} {% case timeframe %}
    {% when 'Time'%}01. Date Time
    {% when 'Hour of day'%}02. Hour of the Day
    {% when 'Date'%}03. Date
    {% when 'Day of week'%}04. Day of Week
    {% when 'Week of year'%}05. Week of Year
    {% when 'Month num'%}06. Month Number
    {% when 'Month name'%}07. Month Name
    {% when 'Quarter of year' %}08. Calendar Quarter
    {% when 'Fiscal quarter of year' %}09. Fiscal Quarter
    {% when 'Year' %}10. Calendar Year
    {% when 'Fiscal year' %}11. Fiscal Year
    {% else %}{{ timeframe}}{% endcase %}"
    label: "Case Open UTC"
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      month_name,
      quarter_of_year,
      year,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.CRE_DT ;;
  }

### PI4V2-22689: Explore Experience Enhancement - Development
  filter: cre_dt_lab_date_opfilter {
    view_label: " ⚙️ Optimised Filters"
    group_label: "🗂️ Case Open Date (Local)"
    group_item_label: "⚡Date"
    label: "Case Open Date (Local)"
    description: "#OptimisedFilters"
    type: date_time
    datatype: datetime
    convert_tz: no
    default_value: "3 days"
    sql: {% condition cre_dt_lab_date_opfilter %} ${cre_dt_lc_raw} {% endcondition %} ;;
  }

  filter: cre_dt_lab_datetime_opfilter {
    view_label: " ⚙️ Optimised Filters"
    group_label: "🗂️ Case Open Date (Local)"
    group_item_label: "⚡Date Time"
    label: "Case Open Date Time (Local)"
    description: "#OptimisedFilters"
    type: date_time
    datatype: datetime
    convert_tz: no
    default_value: "24 hours"
    sql: {% condition cre_dt_lab_datetime_opfilter %} ${cre_dt_lc_raw} {% endcondition %} ;;
  }

  filter: cre_dt_lab_fiscal_year_opfilter {
    view_label: " ⚙️ Optimised Filters"
    group_label: "🗂️ Case Open Date (Local)"
    group_item_label: "⚡Fiscal Year"
    label: "Case Open Fiscal Year (Local)"
    description: "#OptimisedFilters"
    type: date_time
    datatype: datetime
    convert_tz: no
    default_value: "1 fiscal years"
    sql: {% condition cre_dt_lab_fiscal_year_opfilter %} ${cre_dt_lc_raw} {% endcondition %} ;;
  }

  filter: cre_dt_lab_year_opfilter {
    view_label: " ⚙️ Optimised Filters"
    group_label: "🗂️ Case Open Date (Local)"
    group_item_label: "⚡Calendar Year"
    label: "Case Open Calendar Year (Local)"
    description: "#OptimisedFilters"
    type: date_time
    datatype: datetime
    convert_tz: no
    default_value: "1 years"
    sql: {% condition cre_dt_lab_year_opfilter %} ${cre_dt_lc_raw} {% endcondition %} ;;
  }

  #PI4V2-21336
  dimension_group: cre_dt_lc {
    view_label: "Case Info"
    group_label: "Open Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_case_v_ext_epx.cre_dt_lc_' | replace: '_',' ' | capitalize %} {% case timeframe %}
    {% when 'Time'%}   ⚡01. Date Time
    {% when 'Hour of day'%}   02. Hour of the Day
    {% when 'Date'%}  ⚡03. Date
    {% when 'Day of week'%}  04. Day of Week
    {% when 'Week of year'%}  05. Week of Year
    {% when 'Month num'%}  06. Month Number
    {% when 'Month name'%}  07. Month Name
    {% when 'Quarter of year' %}  08. Calendar Quarter
    {% when 'Fiscal quarter of year' %}  09. Fiscal Quarter
    {% when 'Year' %} ⚡10. Calendar Year
    {% when 'Fiscal year' %}⚡11. Fiscal Year
    {% else %}{{ timeframe}}{% endcase %}"
    label: "Case Open Local"
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      month_name,
      quarter_of_year,
      year,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    datatype: datetime
    convert_tz: no
    description: "{% assign timeframe = _field._name | remove: 'dmo_case_v_ext_epx.cre_dt_lc_' | replace: '_',' ' | capitalize %} {% case timeframe %}
    {% when 'Time'%}#OptimisedFilters
    {% when 'Date'%}#OptimisedFilters
    {% when 'Year' %}#OptimisedFilters
    {% when 'Fiscal year' %}#OptimisedFilters
    {% else %}{% endcase %}"
    sql: DATETIME_ADD(${TABLE}.CRE_DT, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  # dimension_group: cls_dt_tz {
  #   view_label: "Case Info"
  #   group_label: "Closed Date (TZ)"
  #   group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_case_v_ext_epx.cls_dt_tz_' | replace: '_',' ' | capitalize %} {% case timeframe %}
  #   {% when 'Time'%}01. Date Time
  #   {% when 'Hour of day'%}02. Hour of the Day
  #   {% when 'Date'%}03. Date
  #   {% when 'Week of year'%}04. Week of Year
  #   {% when 'Month num'%}05. Month
  #   {% when 'Quarter of year' %}06. Calendar Quarter
  #   {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
  #   {% when 'Year' %}08. Calendar Year
  #   {% when 'Fiscal year' %}09. Fiscal Year
  #   {% else %}{{ timeframe}}{% endcase %}"
  #   label: "Case Closed Date Time (TZ)"
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     hour_of_day,
  #     date,
  #     week_of_year,
  #     month_num,
  #     quarter_of_year,
  #     year,
  #     fiscal_quarter_of_year,
  #     fiscal_year
  #   ]
  #   datatype: datetime
  #   # We would like to keep convert_tz: yes due to business requirement
  #   convert_tz: yes
  #   sql: ${TABLE}.CLS_DT ;;
  # }

  dimension_group: cls_dt_utc {
    view_label: "Case Info"
    group_label: "Closed Date (UTC)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_case_v_ext_epx.cls_dt_utc_' | replace: '_',' ' | capitalize %} {% case timeframe %}
    {% when 'Time'%}01. Date Time
    {% when 'Hour of day'%}02. Hour of the Day
    {% when 'Date'%}03. Date
    {% when 'Day of week'%}04. Day of Week
    {% when 'Week of year'%}05. Week of Year
    {% when 'Month num'%}06. Month
    {% when 'Quarter of year' %}07. Calendar Quarter
    {% when 'Fiscal quarter of year' %}08. Fiscal Quarter
    {% when 'Year' %}09. Calendar Year
    {% when 'Fiscal year' %}10. Fiscal Year
    {% else %}{{ timeframe}}{% endcase %}"
    label: "Case Closed UTC"
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      year,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.CLS_DT ;;
  }

  #PI4V2-21336
  dimension_group: cls_dt_lc {
    view_label: "Case Info"
    group_label: "Closed Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_case_v_ext_epx.cls_dt_lc_' | replace: '_',' ' | capitalize %} {% case timeframe %}
    {% when 'Time'%}01. Date Time
    {% when 'Hour of day'%}02. Hour of the Day
    {% when 'Date'%}03. Date
    {% when 'Day of week'%}04. Day of Week
    {% when 'Week of year'%}05. Week of Year
    {% when 'Month num'%}06. Month
    {% when 'Quarter of year' %}07. Calendar Quarter
    {% when 'Fiscal quarter of year' %}08. Fiscal Quarter
    {% when 'Year' %}09. Calendar Year
    {% when 'Fiscal year' %}10. Fiscal Year
    {% else %}{{ timeframe}}{% endcase %}"
    label: "Case Closed Local"
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      year,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    datatype: datetime
    convert_tz: no
    sql: DATETIME_ADD(${TABLE}.CLS_DT, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  #PI4V2-21448
  dimension_group: n1st_res_dt {
    view_label: "Case Info"
    group_label: "First Response Date Time (Local)"
    group_item_label: "@{time_frames}"
    label: "First Response Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "First Response Date Time in Local Time Zone"
    sql: DATETIME_ADD(${TABLE}.N1ST_RES_DT_TM, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension_group: n1st_res_gdt {
    view_label: "Case Info"
    group_label: "First Response Date Time (UTC)"
    group_item_label: "@{time_frames}"
    label: "First Response UTC"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "First Response Date Time in UTC"
    sql: ${TABLE}.N1ST_RES_DT_TM ;;
  }

  dimension_group: lst_rspn_dt {
    view_label: "Case Info"
    group_label: "Last Response Date Time (Local)"
    group_item_label: "@{time_frames}"
    label: "Last Response Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "Last Response Date Time in Local Time Zone"
    sql: DATETIME_ADD(${TABLE}.LST_RSPN_DT, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension_group: lst_rspn_gdt {
    view_label: "Case Info"
    group_label: "Last Response Date Time (UTC)"
    group_item_label: "@{time_frames}"
    label: "Last Response UTC"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "Last Response Date Time in UTC"
    sql: ${TABLE}.LST_RSPN_DT ;;
  }

  dimension: office_code {
    view_label: "Case Info"
    group_label: "Service Office"
    group_item_label: "01. Office Code"
    label: "Case Office Code"
    type: string
    sql: CASE WHEN ${ofc_cd} IN ('MIBOS', 'MIHOS', 'WNKOS', 'SPROS', 'WGZOS') THEN REPLACE(${ofc_cd}, "OS", "")
              WHEN ${ofc_cd} = 'WMLOS' THEN 'MIM'
              ELSE ${ofc_cd} END ;;
  }

  dimension: cnt_cd {
    hidden: no
    view_label: "Customer Info"
    group_label: "Customer Case Origin"
    group_item_label: "03. Country Code"
    label: "Origin Country Code"
  }

  # SR0318528: Remove because Case Office Type in OF doesn't go by the office, but the user
  # dimension: office_type {
  #   view_label: "Case Information"
  #   group_label: "Origin"
  #   group_item_label: "15. Office Type"
  #   label: "Case Office Type"
  #   sql: ${dmo_case_owner.ofc_tp_nm} ;;
  # }

  dimension: rhq_cd_svc {
    view_label: "Case Info"
    group_label: "Service Office"
    group_item_label: "18. Office RHQ (Service)"
    label: "Case RHQ (Service)"
    description: "Historical RHQ at the time the case was opened."
    sql: coalesce(
      -- take regional head office from CASE table
      CASE WHEN ${rgn} IS NOT NULL THEN (CASE WHEN ${rgn} ="EUA" THEN "LONHQ"
                                              WHEN ${rgn} ="NAM" THEN "RICHQ"
                                              WHEN ${rgn} ="SAS" THEN "SINHQ"
                                              WHEN ${rgn} ="LAT" THEN "SAOHQ"
                                              WHEN ${rgn} ="EAS" THEN "HKGHQ"
                                              WHEN ${rgn} ="WAS" THEN "DXBHQ"
                                              ELSE null END)
          -- if case created before 2024-04-01
          WHEN ${TABLE}.CRE_DT < DATE("2024-04-01")
            THEN (CASE
                    -- take value from previous Queue regional head office
                    WHEN ${dmo_queue.prvs_rhq_cd} is not Null THEN  substr(${dmo_queue.prvs_rhq_cd},-5)
                    -- take value from previous Case Owner regional head office, except "Unclaimed - RHQ" & "SINHO"
                    WHEN ${dmo_user_svc.prvs_rhq_cd} is not Null
                      AND  substr(${dmo_user_svc.prvs_rhq_cd},-2) != "HO"
                      AND ${dmo_user_svc.prvs_rhq_cd} != "Unclaimed - RHQ" THEN substr(${dmo_user_svc.prvs_rhq_cd},-5)
                    -- if no value, return "Unclaimed"
                    ELSE "Unclaimed" END)
           -- WHEN of_case.CreatedDate >= DATE("2024-04-01") will fall under ELSE clause
            ELSE  (CASE
                    -- take value from current Queue regional head office
                    WHEN ${dmo_queue.rhq_cd} is not Null THEN  substr(${dmo_queue.rhq_cd},-5)
                    -- take value from current Case Owner regional head office, except "Unclaimed - RHQ" & "SINHO"
                    WHEN ${dmo_user_svc.rhq_cd} is not Null
                      AND  substr(${dmo_user_svc.rhq_cd},-2) != "HO"
                      AND ${dmo_user_svc.rhq_cd} != "Unclaimed - RHQ" THEN substr(${dmo_user_svc.rhq_cd},-5)
                    -- if no value, return "Unclaimed"
                    ELSE "Unclaimed" END)
          END,"Unclaimed") ;;
  }

  dimension: clst_cnt {
    hidden: no
    view_label: "Customer Info"
    group_label: "Customer Case Origin"
    group_item_label: "09. Cluster Country Code"
    label: "Origin Cluster Country"
    sql: CASE WHEN ${cnt_cd} IN ('AT','HU') THEN "AT & HU"
              WHEN ${cnt_cd} IN ('CZ','SK') THEN "CZ & SK"
              WHEN ${cnt_cd} IN ('SE','NO') THEN "SE & NO"
              ELSE ${dmc_origin.sub_cnt_cd} END ;;
  }

  dimension: indv_cnt {
    hidden: no
    view_label: "Customer Info"
    group_label: "Customer Case Origin"
    group_item_label: "01. Sub Country Code"
    label: "Origin Sub Country Code"
  }

  dimension: indv_cnt_nm {
    hidden: no
    view_label: "Customer Info"
    group_label: "Customer Case Origin"
    group_item_label: "02. Sub Country Name"
    label: "Origin Sub Country Name"
  }

  dimension: cs_rtn {
    hidden: no
    view_label: "Case Info"
    group_label: "Feedback"
    group_item_label: "01. Rating"
    label: "Case Rating"
  }

  dimension: cs_nt_pr {
    hidden: no
    view_label: "Case Info"
    group_label: "Feedback"
    group_item_label: "02. Net Promoter Score"
    label: "Case Net Promoter Score"
  }

  dimension: nps_segment {
    hidden: no
    view_label: "Case Info"
    group_label: "Feedback"
    group_item_label: "03. NPS Segment"
    label: "Case NPS Segment"
  }

  dimension: cs_rsn {
    hidden: no
    view_label: "Case Info"
    group_label: "Intents"
    group_item_label: "01. Category (L1)"
    label: "Case Intents Category (L1)"
  }

  dimension: sub_cat_l2 {
    hidden: no
    view_label: "Case Info"
    group_label: "Intents"
    group_item_label: "02. Category (L2)"
    label: "Case Intents Category (L2)"
  }

  dimension: subdnt_cat_l3 {
    hidden: no
    view_label: "Case Info"
    group_label: "Intents"
    group_item_label: "03. Topic (L3)"
    label: "Case Intents Topic (L3)"
  }

  dimension: sbdnt_cat_l4 {
    hidden: no
    view_label: "Case Info"
    group_label: "Intents"
    group_item_label: "04. Sub Topic (L4)"
    label: "Case Intents Sub Topic (L4)"
  }

  dimension: cntc_no {
    hidden: no
    view_label: "Case Info"
    group_label: "Reference"
    group_item_label: "Contract Number"
    label: "Case Contract Number"
  }

  dimension: bkg_no {
    hidden: no
    view_label: "Case Info"
    group_label: "Reference"
    group_item_label: "Booking Number"
    label: "Case Booking Number"
  }

  dimension: cntr_no {
    hidden: no
    view_label: "Case Info"
    group_label: "Reference"
    group_item_label: "Container Number"
    label: "Case Container Number"
  }

  dimension: entered_reference {
    hidden: no
    view_label: "Case Info"
    group_label: "Reference"
    group_item_label: "What Entered"
    label: "Case What Reference Entered"
  }

  dimension: no_ref_rsn_nw {
    hidden: no
    view_label: "Case Info"
    group_label: "Reference"
    group_item_label: "No Reason"
    label: "Case No Reference Reason"
  }

  dimension: is_bkg_no_vld {
    hidden: no
    view_label: "Case Info"
    group_label: "Reference"
    group_item_label: "Is Booking Number Valid (Yes/No)"
    label: "Is Case Booking Number Valid ?"
  }

  dimension: is_cntc_no_vld {
    hidden: no
    view_label: "Case Info"
    group_label: "Reference"
    group_item_label: "Is Contract Number Valid (Yes/No)"
    label: "Is Case Contract Number Valid ?"
  }

  dimension: is_cntc_cust_nm_nt {
    hidden: no
    view_label: "Case Info"
    group_label: "Reference"
    group_item_label: "Is Contract Customer Entered (Yes/No)"
    label: "Is Case Contract Customer Entered ?"
  }

  dimension: resln_rsn_nw {
    hidden: no
    view_label: "Case Info"
    group_label: "Resolution"
    group_item_label: "Reason"
    label: "Case Resolution Reason"
  }

#SR0382888-Request for Group Label  (Case ResoIution Reason) ### PI4V2-24644
  dimension: rsn_group {
    view_label: "Case Info"
    group_label: "Resolution"
    group_item_label: "Reason Group"
    label: "Case Resolution Reason Group"
    type: string
    sql: CASE
          WHEN ${resln_rsn_nw} IN ('Customer Query Resolved', 'Customer Query Un-resolved', 'None') THEN 'Customer Query'
          WHEN ${resln_rsn_nw} IN ('Valid HIT', 'Invalid HIT', 'Verified as Non-DG', 'Verified as DG') THEN 'DG Verification'
          WHEN ${resln_rsn_nw} IN ('Cancelled', 'Rejected') THEN 'Cancel/Reject'
          WHEN ${resln_rsn_nw} = 'Customer Abandoned Chat' THEN 'Customer Abandonment'
          WHEN ${resln_rsn_nw} = 'Customer Dispute Resolved' THEN 'Customer Disputes'
          WHEN ${resln_rsn_nw} IN ('Duplicate', 'No Action Required', 'No Action Required - Spam') THEN 'Excluded Cases'
        END ;;
  }

  dimension: sub_resln_rsn {
    hidden: no
    view_label: "Case Info"
    group_label: "Resolution"
    group_item_label: "Sub Reason"
    label: "Case Sub Resolution Reason"
  }

  # dimension_group: cs_rslvd_dt_tm_tz {
  #   view_label: "Case Info"
  #   group_label: "Resolved Date (TZ)"
  #   group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_case_v_ext_epx.cs_rslvd_dt_tm_tz_' | replace: '_',' ' | capitalize %} {% case timeframe %}
  #   {% when 'Time'%}01. Date Time
  #   {% when 'Hour of day'%}02. Hour of the Day
  #   {% when 'Date'%}03. Date
  #   {% when 'Week of year'%}04. Week of Year
  #   {% when 'Month num'%}05. Month
  #   {% when 'Quarter of year' %}06. Calendar Quarter
  #   {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
  #   {% when 'Year' %}08. Calendar Year
  #   {% when 'Fiscal year' %}09. Fiscal Year
  #   {% else %}{{ timeframe}}{% endcase %}"
  #   label: "Case Resolved Date Time (TZ)"
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     hour_of_day,
  #     date,
  #     week_of_year,
  #     month_num,
  #     quarter_of_year,
  #     year,
  #     fiscal_quarter_of_year,
  #     fiscal_year
  #   ]
  #   datatype: datetime
  #   # We would like to keep convert_tz: yes due to business requirement
  #   convert_tz: yes
  #   sql: ${TABLE}.CS_RSLVD_DT_TM ;;
  # }

  ### PI4V2-23956 ###
  dimension_group: cs_rslvd_dt_adj {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week_of_year,
      month_num,
      quarter_of_year,
      year,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    datatype: datetime
    convert_tz: no
    sql: CASE WHEN ${TABLE}.CS_RSLVD_DT_TM IS NULL AND ${no_of_times_agn_rpn_clsd_case} = 0 THEN ${n1st_cs_rsolv_gdt_raw}
              WHEN ${TABLE}.CS_RSLVD_DT_TM IS NULL AND ${no_of_times_agn_rpn_clsd_case} > 0 THEN ${lst_rspn_gdt_raw}
              ELSE ${TABLE}.CS_RSLVD_DT_TM END ;;
  }

  dimension_group: cs_rslvd_dt_tm_utc {
    view_label: "Case Info"
    group_label: "Resolved Date (UTC)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_case_v_ext_epx.cs_rslvd_dt_tm_utc_' | replace: '_',' ' | capitalize %} {% case timeframe %}
    {% when 'Time'%}01. Date Time
    {% when 'Hour of day'%}02. Hour of the Day
    {% when 'Date'%}03. Date
    {% when 'Week of year'%}04. Week of Year
    {% when 'Month num'%}05. Month
    {% when 'Quarter of year' %}06. Calendar Quarter
    {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
    {% when 'Year' %}08. Calendar Year
    {% when 'Fiscal year' %}09. Fiscal Year
    {% else %}{{ timeframe}}{% endcase %}"
    label: "Case Resolved Date Time (UTC)"
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week_of_year,
      month_num,
      quarter_of_year,
      year,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    datatype: datetime
    convert_tz: no
    sql: ${cs_rslvd_dt_adj_raw} ;;
  }

  dimension_group: cs_rslvd_dt_tm_lc {
    view_label: "Case Info"
    group_label: "Resolved Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_case_v_ext_epx.cs_rslvd_dt_tm_lc_' | replace: '_',' ' | capitalize %} {% case timeframe %}
    {% when 'Time'%}01. Date Time
    {% when 'Hour of day'%}02. Hour of the Day
    {% when 'Date'%}03. Date
    {% when 'Week of year'%}04. Week of Year
    {% when 'Month num'%}05. Month
    {% when 'Quarter of year' %}06. Calendar Quarter
    {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
    {% when 'Year' %}08. Calendar Year
    {% when 'Fiscal year' %}09. Fiscal Year
    {% else %}{{ timeframe}}{% endcase %}"
    label: "Case Resolved Date Time (Local)"
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week_of_year,
      month_num,
      quarter_of_year,
      year,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    datatype: datetime
    convert_tz: no
    sql: DATETIME_ADD(${cs_rslvd_dt_adj_raw}, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  ### PI4V2-21990 ###
  dimension: open_to_lst_rslv_mid {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Open to (Last) Resolved Mid Duration"
    label: "Open to (Last) Resolved Mid Duration"
    type: number
    sql: COALESCE(${dmo_case_dur_mid_cs.cre_cs_rslvd_adj_hours},0) ;;
  }

  #For not all day holiday
  dimension: open_to_lst_rslv_half_hol_mid_1 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Open to Resolved Half Holiday Mid 1"
    label: "Open to Resolved Half Holiday Mid 1"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} < ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} >= ${cs_rslvd_dt_tm_lc_raw} THEN 0

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} < ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} < ${cs_rslvd_dt_tm_lc_raw}
         THEN DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${dmc_crm_bh_hol_start.hol_end_dt_raw}, SECOND)/86400

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} < ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} > ${dmc_crm_bh_hol_start.day_end_dt_raw} THEN 0

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${cs_rslvd_dt_tm_lc_raw}
         THEN DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${dmc_crm_bh_hol_start.day_st_dt_raw}, SECOND)/86400

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} < ${cs_rslvd_dt_tm_lc_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} >= ${cs_rslvd_dt_tm_lc_raw}
         THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.hol_st_dt_raw},${dmc_crm_bh_hol_start.day_st_dt_raw}, SECOND)/86400

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} < ${cs_rslvd_dt_tm_lc_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} < ${cs_rslvd_dt_tm_lc_raw}
         THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.hol_st_dt_raw},${dmc_crm_bh_hol_start.day_st_dt_raw}, SECOND)/86400
        + DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${dmc_crm_bh_hol_start.hol_end_dt_raw}, SECOND)/86400

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} > ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${cs_rslvd_dt_tm_lc_raw} <= ${dmc_crm_bh_hol_start.hol_st_dt_raw}
         THEN DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${dmc_crm_bh_hol_start.day_st_dt_raw}, SECOND)/86400

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} > ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${cs_rslvd_dt_tm_lc_raw} > ${dmc_crm_bh_hol_start.hol_st_dt_raw}
         THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.hol_st_dt_raw},${dmc_crm_bh_hol_start.day_st_dt_raw}, SECOND)/86400
         END ;;
  }

  dimension: open_to_lst_rslv_half_hol_mid_2 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Open to Resolved Half Holiday Mid 2"
    label: "Open to Resolved Half Holiday Mid 2"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} < ${dmc_crm_bh_hol_start.day_st_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} >= ${cre_dt_lc_raw}
        THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.day_end_dt_raw},${dmc_crm_bh_hol_start.hol_end_dt_raw}, SECOND)/86400

        WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} < ${dmc_crm_bh_hol_start.day_st_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} < ${cre_dt_lc_raw}
        THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.day_end_dt_raw},${cre_dt_lc_raw}, SECOND)/86400

        WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} < ${dmc_crm_bh_hol_start.day_st_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} > ${dmc_crm_bh_hol_start.day_end_dt_raw} THEN 0

        WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${cre_dt_lc_raw}
        THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.day_end_dt_raw},${cre_dt_lc_raw}, SECOND)/86400

        WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} > ${cre_dt_lc_raw}
        AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} <= ${cre_dt_lc_raw}
        THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.day_end_dt_raw},${dmc_crm_bh_hol_start.hol_end_dt_raw}, SECOND)/86400

        WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} > ${cre_dt_lc_raw}
        AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} > ${cre_dt_lc_raw}
        THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.day_end_dt_raw},${dmc_crm_bh_hol_start.hol_end_dt_raw}, SECOND)/86400
        + DATETIME_DIFF(${dmc_crm_bh_hol_start.hol_st_dt_raw},${cre_dt_lc_raw}, SECOND)/86400

        WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} > ${dmc_crm_bh_hol_start.day_end_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} <= ${cre_dt_lc_raw} THEN 0

        WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} > ${dmc_crm_bh_hol_start.day_end_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} > ${cre_dt_lc_raw}
        THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.hol_st_dt_raw},${cre_dt_lc_raw}, SECOND)/86400
        END ;;
  }

  dimension: open_to_lst_rslv_half_hol_mid_3 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Open to Resolved Half Holiday Mid 3"
    label: "Open to Resolved Half Holiday Mid 3"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} < ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} >= ${cs_rslvd_dt_tm_lc_raw}
         THEN 0

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} < ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} < ${cre_dt_lc_raw}
         THEN DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${cre_dt_lc_raw}, SECOND)/86400

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} < ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} >= ${cre_dt_lc_raw}
         THEN DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${dmc_crm_bh_hol_start.hol_end_dt_raw}, SECOND)/86400

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} < ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} > ${dmc_crm_bh_hol_start.day_end_dt_raw} THEN 0

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${cre_dt_lc_raw}
          THEN DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${cre_dt_lc_raw}, SECOND)/86400

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${cs_rslvd_dt_tm_lc_raw}
          THEN DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${cre_dt_lc_raw}, SECOND)/86400

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} > ${cs_rslvd_dt_tm_lc_raw}
          AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} <= ${cre_dt_lc_raw} THEN 0

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} > ${cs_rslvd_dt_tm_lc_raw}
          AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} > ${cre_dt_lc_raw}
         THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.hol_st_dt_raw},${cre_dt_lc_raw}, SECOND)/86400

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${cs_rslvd_dt_tm_lc_raw}
          AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} <= ${cre_dt_lc_raw}
         THEN DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${dmc_crm_bh_hol_start.hol_end_dt_raw}, SECOND)/86400

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${cs_rslvd_dt_tm_lc_raw}
          AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} > ${cre_dt_lc_raw}
         THEN DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${dmc_crm_bh_hol_start.hol_end_dt_raw}, SECOND)/86400
           + DATETIME_DIFF(${dmc_crm_bh_hol_start.hol_st_dt_raw},${cre_dt_lc_raw}, SECOND)/86400

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} > ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${cs_rslvd_dt_tm_lc_raw}
         THEN DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${cre_dt_lc_raw}, SECOND)/86400

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} > ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} <= ${cre_dt_lc_raw}
         THEN 0

         WHEN ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} > ${dmc_crm_bh_hol_start.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} < ${cs_rslvd_dt_tm_lc_raw}
          AND ${dmc_crm_bh_hol_start.hol_st_dt_raw} >= ${cre_dt_lc_raw}
         THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.hol_st_dt_raw},${cre_dt_lc_raw}, SECOND)/86400
    END ;;
  }

  dimension: open_to_lst_rslv_half_hol_start {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Open to Resolved Half Holiday Start"
    label: "Open to Resolved Half Holiday Start"
    type: number
    sql:
    CASE WHEN ${cre_dt_lc_raw} <= ${dmc_crm_bh_hol_start.hol_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.day_end_dt_raw} < ${dmc_crm_bh_hol_start.hol_end_dt_raw}
         THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.hol_st_dt_raw},${cre_dt_lc_raw}, SECOND)/86400

         WHEN ${cre_dt_lc_raw} <= ${dmc_crm_bh_hol_start.hol_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.day_end_dt_raw} >= ${dmc_crm_bh_hol_start.hol_end_dt_raw}
         THEN ${dmc_crm_bh_hol_start.adjusted_hours}/24 - DATETIME_DIFF(${cre_dt_lc_raw},${dmc_crm_bh_hol_start.day_st_dt_raw}, SECOND)/86400

         WHEN ${cre_dt_lc_raw} > ${dmc_crm_bh_hol_start.hol_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.day_end_dt_raw} < ${dmc_crm_bh_hol_start.hol_end_dt_raw} THEN 0

         WHEN ${cre_dt_lc_raw} > ${dmc_crm_bh_hol_start.hol_st_dt_raw}
          AND ${dmc_crm_bh_hol_start.day_end_dt_raw} >= ${dmc_crm_bh_hol_start.hol_end_dt_raw}
          AND ${cre_dt_lc_raw} <= ${dmc_crm_bh_hol_start.hol_end_dt_raw}
         THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.day_end_dt_raw},${dmc_crm_bh_hol_start.hol_end_dt_raw}, SECOND)/86400

        WHEN ${cre_dt_lc_raw} > ${dmc_crm_bh_hol_start.hol_end_dt_raw}
        AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
        THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.day_end_dt_raw},${cre_dt_lc_raw}, SECOND)/86400
    END ;;
  }

  dimension: open_to_lst_rslv_half_hol_end {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Open to Resolved Half Holiday End"
    label: "Open to Resolved Half Holiday End"
    type: number
    sql:
    CASE WHEN ${cs_rslvd_dt_tm_lc_raw} <= ${dmc_crm_bh_hol_end.hol_st_dt_raw}
         THEN DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${dmc_crm_bh_hol_end.day_st_dt_raw}, SECOND)/86400

         WHEN ${cs_rslvd_dt_tm_lc_raw} > ${dmc_crm_bh_hol_end.hol_st_dt_raw}
          AND ${dmc_crm_bh_hol_end.day_end_dt_raw} <= ${dmc_crm_bh_hol_end.hol_end_dt_raw} THEN ${dmc_crm_bh_hol_end.adjusted_hours}/24

         WHEN ${cs_rslvd_dt_tm_lc_raw} > ${dmc_crm_bh_hol_end.hol_st_dt_raw}
          AND ${dmc_crm_bh_hol_end.day_end_dt_raw} > ${dmc_crm_bh_hol_end.hol_end_dt_raw}
          AND ${cs_rslvd_dt_tm_lc_raw} <= ${dmc_crm_bh_hol_end.hol_end_dt_raw}
         THEN DATETIME_DIFF(${dmc_crm_bh_hol_end.hol_st_dt_raw},${cre_dt_lc_raw}, SECOND)/86400

         WHEN ${cs_rslvd_dt_tm_lc_raw} > ${dmc_crm_bh_hol_end.hol_end_dt_raw}
         THEN ${dmc_crm_bh_hol_end.adjusted_hours}/24 - DATETIME_DIFF(${dmc_crm_bh_hol_end.day_end_dt_raw},${cs_rslvd_dt_tm_lc_raw}, SECOND)/86400
    END ;;
  }

  dimension: dur_of_open_to_lst_rslv_days {
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "Dur of Open to (Last) Resolved (Days)"
    label: "Dur of Open to (Last) Resolved (Days)"
    type: number
    sql:
    CASE WHEN ${cre_dt_lc_date} IS NULL THEN NULL
        WHEN ${cs_rslvd_dt_tm_lc_date} IS NULL THEN NULL
        WHEN ${cre_dt_lc_date} = ${cs_rslvd_dt_tm_lc_date} THEN DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${cre_dt_lc_raw}, SECOND)/86400

        WHEN DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${cre_dt_lc_raw}, DAY) = 1 THEN
        (CASE WHEN ${dmc_crm_bh_hol_start.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_start.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_start.hol_end_dt_raw} IS NULL) THEN 0
              WHEN ${dmc_crm_bh_hol_start.day_st_dt_raw} = ${dmc_crm_bh_hol_start.day_end_dt_raw} THEN 0
              WHEN ${cre_dt_lc_raw} < ${dmc_crm_bh_hol_start.day_st_dt_raw} THEN ${dmc_crm_bh_hol_start.adjusted_hours}/24
              WHEN ${cre_dt_lc_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw} AND ${cre_dt_lc_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
               AND ${dmc_crm_bh_hol_start.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} IS NOT NULL THEN ${open_to_lst_rslv_half_hol_start}
              WHEN ${cre_dt_lc_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw} AND ${cre_dt_lc_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
              THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.day_end_dt_raw},${cre_dt_lc_raw},SECOND)/86400
              WHEN ${cre_dt_lc_raw} > ${dmc_crm_bh_hol_start.day_end_dt_raw} THEN 0
        END +
        CASE WHEN ${dmc_crm_bh_hol_end.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_end.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_end.hol_end_dt_raw} IS NULL) THEN 0
             WHEN ${dmc_crm_bh_hol_end.day_st_dt_raw} = ${dmc_crm_bh_hol_end.day_end_dt_raw} THEN 0
             WHEN ${cs_rslvd_dt_tm_lc_raw} > ${dmc_crm_bh_hol_end.day_end_dt_raw} THEN ${dmc_crm_bh_hol_end.adjusted_hours}/24
             WHEN ${cs_rslvd_dt_tm_lc_raw} >= ${dmc_crm_bh_hol_end.day_st_dt_raw} AND ${cs_rslvd_dt_tm_lc_raw} <= ${dmc_crm_bh_hol_end.day_end_dt_raw}
              AND ${dmc_crm_bh_hol_end.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_end.hol_end_dt_raw} IS NOT NULL THEN ${open_to_lst_rslv_half_hol_end}
             WHEN ${cs_rslvd_dt_tm_lc_raw} >= ${dmc_crm_bh_hol_end.day_st_dt_raw} AND ${cs_rslvd_dt_tm_lc_raw} <= ${dmc_crm_bh_hol_end.day_end_dt_raw}
             THEN DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${dmc_crm_bh_hol_end.day_st_dt_raw},SECOND)/86400
             WHEN ${cs_rslvd_dt_tm_lc_raw} < ${dmc_crm_bh_hol_end.day_st_dt_raw} THEN 0
        END)
        ELSE
        (CASE WHEN ${dmc_crm_bh_hol_start.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_start.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_start.hol_end_dt_raw} IS NULL) THEN 0
              WHEN ${dmc_crm_bh_hol_start.day_st_dt_raw} = ${dmc_crm_bh_hol_start.day_end_dt_raw} THEN 0
              WHEN ${cre_dt_lc_raw} < ${dmc_crm_bh_hol_start.day_st_dt_raw} THEN ${dmc_crm_bh_hol_start.adjusted_hours}/24
              WHEN ${cre_dt_lc_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw} AND ${cre_dt_lc_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
               AND ${dmc_crm_bh_hol_start.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_start.hol_end_dt_raw} IS NOT NULL THEN ${open_to_lst_rslv_half_hol_start}
              WHEN ${cre_dt_lc_raw} >= ${dmc_crm_bh_hol_start.day_st_dt_raw} AND ${cre_dt_lc_raw} <= ${dmc_crm_bh_hol_start.day_end_dt_raw}
              THEN DATETIME_DIFF(${dmc_crm_bh_hol_start.day_end_dt_raw},${cre_dt_lc_raw},SECOND)/86400
              WHEN ${cre_dt_lc_raw} > ${dmc_crm_bh_hol_start.day_end_dt_raw} THEN 0
        END +
        CASE WHEN ${dmc_crm_bh_hol_end.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_end.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_end.hol_end_dt_raw} IS NULL) THEN 0
             WHEN ${dmc_crm_bh_hol_end.day_st_dt_raw} = ${dmc_crm_bh_hol_end.day_end_dt_raw} THEN 0
             WHEN ${cs_rslvd_dt_tm_lc_raw} > ${dmc_crm_bh_hol_end.day_end_dt_raw} THEN ${dmc_crm_bh_hol_end.adjusted_hours}/24
             WHEN ${cs_rslvd_dt_tm_lc_raw} >= ${dmc_crm_bh_hol_end.day_st_dt_raw} AND ${cs_rslvd_dt_tm_lc_raw} <= ${dmc_crm_bh_hol_end.day_end_dt_raw}
              AND ${dmc_crm_bh_hol_end.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_end.hol_end_dt_raw} IS NOT NULL THEN ${open_to_lst_rslv_half_hol_end}
             WHEN ${cs_rslvd_dt_tm_lc_raw} >= ${dmc_crm_bh_hol_end.day_st_dt_raw} AND ${cs_rslvd_dt_tm_lc_raw} <= ${dmc_crm_bh_hol_end.day_end_dt_raw}
             THEN DATETIME_DIFF(${cs_rslvd_dt_tm_lc_raw},${dmc_crm_bh_hol_end.day_st_dt_raw},SECOND)/86400
             WHEN ${cs_rslvd_dt_tm_lc_raw} < ${dmc_crm_bh_hol_end.day_st_dt_raw} THEN 0
        END +
        ${open_to_lst_rslv_mid}/24)
    END ;;
    value_format_name: decimal_3
  }

  measure: dur_of_open_to_lst_rslv_tm {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Open to (Last) Resolved (hh:mm:ss)"
    label: "Duration of Open to (Last) Resolved (hh:mm:ss)"
    type: average
    sql:  ${dur_of_open_to_lst_rslv_days} ;;
    value_format: "[hh]:mm:ss"
  }

  ### PI4V2-22138 ###
  ### First to Last Response Time
  dimension_group: n1st_res_lst_rspn_sdur_dt {
    hidden: yes
    view_label: "Case Info"
    group_label: "First to Last Response Time Start"
    group_item_label: "@{time_frames}"
    label: "First to Last Response Time Start"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: CASE WHEN ${n1st_res_gdt_raw} < ${lst_rspn_gdt_raw} THEN ${n1st_res_dt_raw} ELSE ${lst_rspn_dt_raw} END ;;

  }

  dimension_group: n1st_res_lst_rspn_edur_dt {
    hidden: yes
    view_label: "Case Info"
    group_label: "First to Last Response Time End"
    group_item_label: "@{time_frames}"
    label: "First to Last Response Time End"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: CASE WHEN ${n1st_res_gdt_raw} < ${lst_rspn_gdt_raw} THEN ${lst_rspn_dt_raw} ELSE ${n1st_res_dt_raw} END ;;
  }

  dimension: n1st_res_lst_rspn_mid {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First to Last Response Time Mid Duration"
    label: "First to Last Response Time Mid Duration"
    type: number
    sql: COALESCE(${dmo_case_dur_mid_cs.n1st_res_lst_rspn_adj_hours},0) ;;
  }

  #For not all day holiday
  dimension: n1st_res_lst_rspn_half_hol_mid_1 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First to Last Response Time Half Holiday Mid 1"
    label: "First to Last Response Time Half Holiday Mid 1"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} >= ${n1st_res_lst_rspn_edur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} < ${n1st_res_lst_rspn_edur_dt_raw}
      THEN DATETIME_DIFF(${n1st_res_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${n1st_res_lst_rspn_edur_dt_raw}
      THEN DATETIME_DIFF(${n1st_res_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} < ${n1st_res_lst_rspn_edur_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} >= ${n1st_res_lst_rspn_edur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} < ${n1st_res_lst_rspn_edur_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} < ${n1st_res_lst_rspn_edur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${n1st_res_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${n1st_res_lst_rspn_edur_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw}
      THEN DATETIME_DIFF(${n1st_res_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${n1st_res_lst_rspn_edur_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: n1st_res_lst_rspn_half_hol_mid_2 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First to Last Response Time Half Holiday Mid 2"
    label: "First to Last Response Time Half Holiday Mid 2"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
        AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
        AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} >= ${n1st_res_lst_rspn_sdur_dt_raw}
        THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} < ${n1st_res_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${n1st_res_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} > ${n1st_res_lst_rspn_sdur_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} <= ${n1st_res_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} > ${n1st_res_lst_rspn_sdur_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} > ${n1st_res_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} <= ${n1st_res_lst_rspn_sdur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} > ${n1st_res_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: n1st_res_lst_rspn_half_hol_mid_3 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First to Last Response Time Half Holiday Mid 3"
    label: "First to Last Response Time Half Holiday Mid 3"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} >= ${n1st_res_lst_rspn_edur_dt_raw}
         THEN 0

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} < ${n1st_res_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${n1st_res_lst_rspn_edur_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} >= ${n1st_res_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${n1st_res_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${n1st_res_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${n1st_res_lst_rspn_edur_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${n1st_res_lst_rspn_edur_dt_raw}
      THEN DATETIME_DIFF(${n1st_res_lst_rspn_edur_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} > ${n1st_res_lst_rspn_edur_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} <= ${n1st_res_lst_rspn_sdur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} > ${n1st_res_lst_rspn_edur_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} > ${n1st_res_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${n1st_res_lst_rspn_edur_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} <= ${n1st_res_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${n1st_res_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${n1st_res_lst_rspn_edur_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} > ${n1st_res_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${n1st_res_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${n1st_res_lst_rspn_edur_dt_raw}
      THEN DATETIME_DIFF(${n1st_res_lst_rspn_edur_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} <= ${n1st_res_lst_rspn_sdur_dt_raw}
      THEN 0

      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} < ${n1st_res_lst_rspn_edur_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw} >= ${n1st_res_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: n1st_res_lst_rspn_half_hol_start {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First to Last Response Time Half Holiday Start"
    label: "First to Last Response Time Half Holiday Start"
    type: number
    sql:
    CASE WHEN ${n1st_res_lst_rspn_sdur_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw}
          AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw}
         THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${n1st_res_lst_rspn_sdur_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw}
      THEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.adjusted_hours}/24 - DATETIME_DIFF(${n1st_res_lst_rspn_sdur_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${n1st_res_lst_rspn_sdur_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} THEN 0

      WHEN ${n1st_res_lst_rspn_sdur_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw}
      AND ${n1st_res_lst_rspn_sdur_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${n1st_res_lst_rspn_sdur_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: n1st_res_lst_rspn_half_hol_end {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First to Last Response Time Half Holiday End"
    label: "First to Last Response Time Half Holiday End"
    type: number
    sql:
    CASE WHEN ${n1st_res_lst_rspn_edur_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.hol_st_dt_raw}
         THEN DATETIME_DIFF(${n1st_res_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_st_dt_raw}, SECOND)/86400

      WHEN ${n1st_res_lst_rspn_edur_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_end_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.hol_end_dt_raw} THEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.adjusted_hours}/24

      WHEN ${n1st_res_lst_rspn_edur_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_end_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.hol_end_dt_raw}
      AND ${n1st_res_lst_rspn_edur_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.hol_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.hol_st_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${n1st_res_lst_rspn_edur_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.hol_end_dt_raw}
      THEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.adjusted_hours}/24 - DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_end_dt_raw},${n1st_res_lst_rspn_edur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: dur_of_n1st_res_lst_rspn_days {
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "Dur of First to Last Response (Days)"
    label: "Dur of First to Last Response (Days)"
    type: number
    sql:CASE WHEN ${n1st_res_lst_rspn_sdur_dt_raw} IS NULL THEN NULL
      WHEN ${n1st_res_lst_rspn_edur_dt_raw} IS NULL THEN NULL
      WHEN ${n1st_res_lst_rspn_edur_dt_date} = ${n1st_res_lst_rspn_sdur_dt_date} THEN DATETIME_DIFF(${lst_rspn_dt_raw},${n1st_res_dt_raw}, SECOND)/86400
      WHEN DATETIME_DIFF(${n1st_res_lst_rspn_edur_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw}, DAY) = 1 THEN
      (CASE WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_n1st_res_lst_rspn_st.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw} = ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw} THEN 0
      WHEN ${n1st_res_lst_rspn_sdur_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw} THEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.adjusted_hours}/24
      WHEN ${n1st_res_lst_rspn_sdur_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw} AND ${n1st_res_lst_rspn_sdur_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} IS NOT NULL THEN ${n1st_res_lst_rspn_half_hol_start}
      WHEN ${n1st_res_lst_rspn_sdur_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw} AND ${n1st_res_lst_rspn_sdur_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw},SECOND)/86400
      WHEN ${n1st_res_lst_rspn_sdur_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw} THEN 0
      END +
      CASE WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_st_dt_raw} = ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_end_dt_raw} THEN 0
      WHEN ${n1st_res_lst_rspn_edur_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_end_dt_raw} THEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.adjusted_hours}/24
      WHEN ${n1st_res_lst_rspn_edur_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_st_dt_raw} AND ${n1st_res_lst_rspn_edur_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.hol_end_dt_raw} IS NOT NULL THEN ${n1st_res_lst_rspn_half_hol_end}
      WHEN ${n1st_res_lst_rspn_edur_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_st_dt_raw} AND ${n1st_res_lst_rspn_edur_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_end_dt_raw}
      THEN DATETIME_DIFF(${n1st_res_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_st_dt_raw},SECOND)/86400
      WHEN ${n1st_res_lst_rspn_edur_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_st_dt_raw} THEN 0
      END)*(CASE WHEN ${lst_rspn_gdt_raw} < ${n1st_res_gdt_raw} THEN -1 ELSE 1 END)
      ELSE
      (CASE WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_n1st_res_lst_rspn_st.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw} = ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw} THEN 0
      WHEN ${n1st_res_lst_rspn_sdur_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw} THEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.adjusted_hours}/24
      WHEN ${n1st_res_lst_rspn_sdur_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw} AND ${n1st_res_lst_rspn_sdur_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.hol_end_dt_raw} IS NOT NULL THEN ${n1st_res_lst_rspn_half_hol_start}
      WHEN ${n1st_res_lst_rspn_sdur_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_st_dt_raw} AND ${n1st_res_lst_rspn_sdur_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw},${n1st_res_lst_rspn_sdur_dt_raw},SECOND)/86400
      WHEN ${n1st_res_lst_rspn_sdur_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_st.day_end_dt_raw} THEN 0
      END +
      CASE WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_st_dt_raw} = ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_end_dt_raw} THEN 0
      WHEN ${n1st_res_lst_rspn_edur_dt_raw} > ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_end_dt_raw} THEN ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.adjusted_hours}/24
      WHEN ${n1st_res_lst_rspn_edur_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_st_dt_raw} AND ${n1st_res_lst_rspn_edur_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.hol_end_dt_raw} IS NOT NULL THEN ${n1st_res_lst_rspn_half_hol_end}
      WHEN ${n1st_res_lst_rspn_edur_dt_raw} >= ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_st_dt_raw} AND ${n1st_res_lst_rspn_edur_dt_raw} <= ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_end_dt_raw}
      THEN DATETIME_DIFF(${n1st_res_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_st_dt_raw},SECOND)/86400
      WHEN ${n1st_res_lst_rspn_edur_dt_raw} < ${dmc_crm_bh_hol_n1st_res_lst_rspn_ed.day_st_dt_raw} THEN 0
      END +
      ${n1st_res_lst_rspn_mid}/24)*(CASE WHEN ${lst_rspn_gdt_raw} < ${n1st_res_gdt_raw} THEN -1 ELSE 1 END)
       END ;;
    value_format_name: decimal_3
  }

  measure: dur_of_n1st_res_lst_rspn_tm {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First to Last Response (hh:mm:ss)"
    label: "Duration of First to Last Response (hh:mm:ss)"
    type: average
    sql:  ${dur_of_n1st_res_lst_rspn_days} ;;
    value_format: "[hh]:mm:ss"
  }

  ### Agent Last Response Time
  dimension_group: rspn_flg_trakr_lst_rspn_sdur_dt {
    hidden: yes
    view_label: "Case Info"
    group_label: "Agent Last Response Time Start"
    group_item_label: "@{time_frames}"
    label: "Agent Last Response Time Start"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: CASE WHEN ${rspn_flg_trakr_gdt_raw} < ${lst_rspn_gdt_raw} THEN ${rspn_flg_trakr_dt_raw} ELSE ${lst_rspn_dt_raw} END ;;
  }

  dimension_group: rspn_flg_trakr_lst_rspn_edur_dt {
    hidden: yes
    view_label: "Case Info"
    group_label: "Agent Last Response Time End"
    group_item_label: "@{time_frames}"
    label: "Agent Last Response Time End"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: CASE WHEN ${rspn_flg_trakr_gdt_raw} < ${lst_rspn_gdt_raw} THEN ${lst_rspn_dt_raw} ELSE ${rspn_flg_trakr_dt_raw} END ;;
  }

  dimension: rspn_flg_trakr_lst_rspn_mid {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Agent Last Response Time Mid Duration"
    label: "Agent Last Response Time Mid Duration"
    type: number
    sql: COALESCE(${dmo_case_dur_mid_cs.rspn_flg_trakr_lst_rspn_adj_hours},0) ;;
  }

  #For not all day holiday
  dimension: rspn_flg_trakr_lst_rspn_half_hol_mid_1 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Agent Last Response Time Half Holiday Mid 1"
    label: "Agent Last Response Time Half Holiday Mid 1"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} >= ${rspn_flg_trakr_lst_rspn_edur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} < ${rspn_flg_trakr_lst_rspn_edur_dt_raw}
      THEN DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${rspn_flg_trakr_lst_rspn_edur_dt_raw}
      THEN DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} < ${rspn_flg_trakr_lst_rspn_edur_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} >= ${rspn_flg_trakr_lst_rspn_edur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} < ${rspn_flg_trakr_lst_rspn_edur_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} < ${rspn_flg_trakr_lst_rspn_edur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${rspn_flg_trakr_lst_rspn_edur_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw}
      THEN DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${rspn_flg_trakr_lst_rspn_edur_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: rspn_flg_trakr_lst_rspn_half_hol_mid_2 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Agent Last Response Time Half Holiday Mid 2"
    label: "Agent Last Response Time Half Holiday Mid 2"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
        AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
        AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} >= ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
        THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} < ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} > ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} <= ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} > ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} > ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} <= ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} > ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: rspn_flg_trakr_lst_rspn_half_hol_mid_3 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Agent Last Response Time Half Holiday Mid 3"
    label: "Agent Last Response Time Half Holiday Mid 3"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} >= ${rspn_flg_trakr_lst_rspn_edur_dt_raw}
         THEN 0

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} < ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_edur_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} >= ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_edur_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${rspn_flg_trakr_lst_rspn_edur_dt_raw}
      THEN DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_edur_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} > ${rspn_flg_trakr_lst_rspn_edur_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} <= ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} > ${rspn_flg_trakr_lst_rspn_edur_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} > ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${rspn_flg_trakr_lst_rspn_edur_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} <= ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${rspn_flg_trakr_lst_rspn_edur_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} > ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${rspn_flg_trakr_lst_rspn_edur_dt_raw}
      THEN DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_edur_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} <= ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
      THEN 0

      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} < ${rspn_flg_trakr_lst_rspn_edur_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw} >= ${rspn_flg_trakr_lst_rspn_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: rspn_flg_trakr_lst_rspn_half_hol_start {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Agent Last Response Time Half Holiday Start"
    label: "Agent Last Response Time Half Holiday Start"
    type: number
    sql:
    CASE WHEN ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw}
          AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw}
         THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw}
      THEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.adjusted_hours}/24 - DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_sdur_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} THEN 0

      WHEN ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw}
      AND ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: rspn_flg_trakr_lst_rspn_half_hol_end {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Agent Last Response Time Half Holiday End"
    label: "Agent Last Response Time Half Holiday End"
    type: number
    sql:
    CASE WHEN ${rspn_flg_trakr_lst_rspn_edur_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.hol_st_dt_raw}
         THEN DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_st_dt_raw}, SECOND)/86400

      WHEN ${rspn_flg_trakr_lst_rspn_edur_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_end_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.hol_end_dt_raw} THEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.adjusted_hours}/24

      WHEN ${rspn_flg_trakr_lst_rspn_edur_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_end_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.hol_end_dt_raw}
      AND ${rspn_flg_trakr_lst_rspn_edur_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.hol_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.hol_st_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw}, SECOND)/86400

      WHEN ${rspn_flg_trakr_lst_rspn_edur_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.hol_end_dt_raw}
      THEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.adjusted_hours}/24 - DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_end_dt_raw},${rspn_flg_trakr_lst_rspn_edur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: dur_of_rspn_flg_trakr_lst_rspn_days {
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "Dur of Agent Last Response (Days)"
    label: "Dur of Agent Last Response (Days)"
    type: number
    sql:CASE WHEN ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} IS NULL THEN NULL
      WHEN ${rspn_flg_trakr_lst_rspn_edur_dt_raw} IS NULL THEN NULL
      WHEN ${rspn_flg_trakr_lst_rspn_edur_dt_date} = ${rspn_flg_trakr_lst_rspn_sdur_dt_date} THEN DATETIME_DIFF(${lst_rspn_dt_raw},${rspn_flg_trakr_dt_raw}, SECOND)/86400
      WHEN DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_edur_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw}, DAY) = 1 THEN
      (CASE WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw} = ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw} THEN 0
      WHEN ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw} THEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.adjusted_hours}/24
      WHEN ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw} AND ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} IS NOT NULL THEN ${rspn_flg_trakr_lst_rspn_half_hol_start}
      WHEN ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw} AND ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw},SECOND)/86400
      WHEN ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw} THEN 0
      END +
      CASE WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_st_dt_raw} = ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_end_dt_raw} THEN 0
      WHEN ${rspn_flg_trakr_lst_rspn_edur_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_end_dt_raw} THEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.adjusted_hours}/24
      WHEN ${rspn_flg_trakr_lst_rspn_edur_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_st_dt_raw} AND ${rspn_flg_trakr_lst_rspn_edur_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.hol_end_dt_raw} IS NOT NULL THEN ${rspn_flg_trakr_lst_rspn_half_hol_end}
      WHEN ${rspn_flg_trakr_lst_rspn_edur_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_st_dt_raw} AND ${rspn_flg_trakr_lst_rspn_edur_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_end_dt_raw}
      THEN DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_st_dt_raw},SECOND)/86400
      WHEN ${rspn_flg_trakr_lst_rspn_edur_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_st_dt_raw} THEN 0
      END)*(CASE WHEN ${lst_rspn_gdt_raw} < ${rspn_flg_trakr_gdt_raw} THEN -1 ELSE 1 END)
      ELSE
      (CASE WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw} = ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw} THEN 0
      WHEN ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw} THEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.adjusted_hours}/24
      WHEN ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw} AND ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.hol_end_dt_raw} IS NOT NULL THEN ${rspn_flg_trakr_lst_rspn_half_hol_start}
      WHEN ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_st_dt_raw} AND ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw},${rspn_flg_trakr_lst_rspn_sdur_dt_raw},SECOND)/86400
      WHEN ${rspn_flg_trakr_lst_rspn_sdur_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_st.day_end_dt_raw} THEN 0
      END +
      CASE WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_st_dt_raw} = ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_end_dt_raw} THEN 0
      WHEN ${rspn_flg_trakr_lst_rspn_edur_dt_raw} > ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_end_dt_raw} THEN ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.adjusted_hours}/24
      WHEN ${rspn_flg_trakr_lst_rspn_edur_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_st_dt_raw} AND ${rspn_flg_trakr_lst_rspn_edur_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.hol_end_dt_raw} IS NOT NULL THEN ${rspn_flg_trakr_lst_rspn_half_hol_end}
      WHEN ${rspn_flg_trakr_lst_rspn_edur_dt_raw} >= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_st_dt_raw} AND ${rspn_flg_trakr_lst_rspn_edur_dt_raw} <= ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_end_dt_raw}
      THEN DATETIME_DIFF(${rspn_flg_trakr_lst_rspn_edur_dt_raw},${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_st_dt_raw},SECOND)/86400
      WHEN ${rspn_flg_trakr_lst_rspn_edur_dt_raw} < ${dmc_crm_bh_hol_rspn_flg_trakr_lst_rspn_ed.day_st_dt_raw} THEN 0
      END +
      ${rspn_flg_trakr_lst_rspn_mid}/24)*(CASE WHEN ${lst_rspn_gdt_raw} < ${rspn_flg_trakr_gdt_raw} THEN -1 ELSE 1 END)
       END ;;
    value_format_name: decimal_3
  }

  measure: dur_of_rspn_flg_trakr_lst_rspn_tm {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Agent Last Response (hh:mm:ss)"
    label: "Duration of Agent Last Response (hh:mm:ss)"
    type: average
    sql:  ${dur_of_rspn_flg_trakr_lst_rspn_days} ;;
    value_format: "[hh]:mm:ss"
  }

  ### Open to First In Progress Time
  dimension_group: cre_cs_in_prog_sdur_dt {
    hidden: yes
    view_label: "Case Info"
    group_label: "Open to First In Progress Time Start"
    group_item_label: "@{time_frames}"
    label: "Open to First In Progress Time Start"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: CASE WHEN ${cre_dt_utc_raw} < ${cs_in_prog_gdt_raw} THEN ${cre_dt_lc_raw} ELSE ${cs_in_prog_dt_raw} END ;;
  }

  dimension_group: cre_cs_in_prog_edur_dt {
    hidden: yes
    view_label: "Case Info"
    group_label: "Open to First In Progress Time End"
    group_item_label: "@{time_frames}"
    label: "Open to First In Progress Time End"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: CASE WHEN ${cre_dt_utc_raw} < ${cs_in_prog_gdt_raw} THEN ${cs_in_prog_dt_raw} ELSE ${cre_dt_lc_raw} END ;;
  }

  dimension: cre_cs_in_prog_mid {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Open to First In Progress Time Mid Duration"
    label: "Open to First In Progress Time Mid Duration"
    type: number
    sql: COALESCE(${dmo_case_dur_mid_cs.cre_cs_in_prog_adj_hours},0) ;;
  }

  #For not all day holiday
  dimension: cre_cs_in_prog_half_hol_mid_1 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Open to First In Progress Time Half Holiday Mid 1"
    label: "Open to First In Progress Time Half Holiday Mid 1"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} >= ${cre_cs_in_prog_edur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} < ${cre_cs_in_prog_edur_dt_raw}
      THEN DATETIME_DIFF(${cre_cs_in_prog_edur_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${cre_cs_in_prog_edur_dt_raw}
      THEN DATETIME_DIFF(${cre_cs_in_prog_edur_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} < ${cre_cs_in_prog_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} >= ${cre_cs_in_prog_edur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} < ${cre_cs_in_prog_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} < ${cre_cs_in_prog_edur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${cre_cs_in_prog_edur_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${cre_cs_in_prog_edur_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw}
      THEN DATETIME_DIFF(${cre_cs_in_prog_edur_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${cre_cs_in_prog_edur_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: cre_cs_in_prog_half_hol_mid_2 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Open to First In Progress Time Half Holiday Mid 2"
    label: "Open to First In Progress Time Half Holiday Mid 2"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
        AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
        AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} >= ${cre_cs_in_prog_sdur_dt_raw}
        THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} < ${cre_cs_in_prog_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw},${cre_cs_in_prog_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${cre_cs_in_prog_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw},${cre_cs_in_prog_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} > ${cre_cs_in_prog_sdur_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} <= ${cre_cs_in_prog_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} > ${cre_cs_in_prog_sdur_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} > ${cre_cs_in_prog_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw},${cre_cs_in_prog_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} <= ${cre_cs_in_prog_sdur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} > ${cre_cs_in_prog_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw},${cre_cs_in_prog_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: cre_cs_in_prog_half_hol_mid_3 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Open to First In Progress Time Half Holiday Mid 3"
    label: "Open to First In Progress Time Half Holiday Mid 3"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} >= ${cre_cs_in_prog_edur_dt_raw}
         THEN 0

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} < ${cre_cs_in_prog_sdur_dt_raw}
      THEN DATETIME_DIFF(${cre_cs_in_prog_edur_dt_raw},${cre_cs_in_prog_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} >= ${cre_cs_in_prog_sdur_dt_raw}
      THEN DATETIME_DIFF(${cre_cs_in_prog_edur_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${cre_cs_in_prog_sdur_dt_raw}
      THEN DATETIME_DIFF(${cre_cs_in_prog_edur_dt_raw},${cre_cs_in_prog_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${cre_cs_in_prog_edur_dt_raw}
      THEN DATETIME_DIFF(${cre_cs_in_prog_edur_dt_raw},${cre_cs_in_prog_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} > ${cre_cs_in_prog_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} <= ${cre_cs_in_prog_sdur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} > ${cre_cs_in_prog_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} > ${cre_cs_in_prog_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw},${cre_cs_in_prog_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${cre_cs_in_prog_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} <= ${cre_cs_in_prog_sdur_dt_raw}
      THEN DATETIME_DIFF(${cre_cs_in_prog_edur_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${cre_cs_in_prog_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} > ${cre_cs_in_prog_sdur_dt_raw}
      THEN DATETIME_DIFF(${cre_cs_in_prog_edur_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw},${cre_cs_in_prog_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${cre_cs_in_prog_edur_dt_raw}
      THEN DATETIME_DIFF(${cre_cs_in_prog_edur_dt_raw},${cre_cs_in_prog_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} <= ${cre_cs_in_prog_sdur_dt_raw}
      THEN 0

      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} < ${cre_cs_in_prog_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw} >= ${cre_cs_in_prog_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw},${cre_cs_in_prog_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: cre_cs_in_prog_half_hol_start {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Open to First In Progress Time Half Holiday Start"
    label: "Open to First In Progress Time Half Holiday Start"
    type: number
    sql:
    CASE WHEN ${cre_cs_in_prog_sdur_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw}
          AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw}
         THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw},${cre_cs_in_prog_sdur_dt_raw}, SECOND)/86400

      WHEN ${cre_cs_in_prog_sdur_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw}
      THEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.adjusted_hours}/24 - DATETIME_DIFF(${cre_cs_in_prog_sdur_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${cre_cs_in_prog_sdur_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} THEN 0

      WHEN ${cre_cs_in_prog_sdur_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw}
      AND ${cre_cs_in_prog_sdur_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${cre_cs_in_prog_sdur_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw},${cre_cs_in_prog_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: cre_cs_in_prog_half_hol_end {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Open to First In Progress Time Half Holiday End"
    label: "Open to First In Progress Time Half Holiday End"
    type: number
    sql:
    CASE WHEN ${cre_cs_in_prog_edur_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_ed.hol_st_dt_raw}
         THEN DATETIME_DIFF(${cre_cs_in_prog_edur_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_st_dt_raw}, SECOND)/86400

      WHEN ${cre_cs_in_prog_edur_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_ed.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_end_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_ed.hol_end_dt_raw} THEN ${dmc_crm_bh_hol_cre_cs_in_prog_ed.adjusted_hours}/24

      WHEN ${cre_cs_in_prog_edur_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_ed.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_end_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_ed.hol_end_dt_raw}
      AND ${cre_cs_in_prog_edur_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_ed.hol_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_ed.hol_st_dt_raw},${cre_cs_in_prog_sdur_dt_raw}, SECOND)/86400

      WHEN ${cre_cs_in_prog_edur_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_ed.hol_end_dt_raw}
      THEN ${dmc_crm_bh_hol_cre_cs_in_prog_ed.adjusted_hours}/24 - DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_end_dt_raw},${cre_cs_in_prog_edur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: dur_of_cre_cs_in_prog_days {
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "Dur of Open to First In Progress (Days)"
    label: "Dur of Open to First In Progress (Days)"
    type: number
    sql:CASE WHEN ${cre_cs_in_prog_sdur_dt_raw} IS NULL THEN NULL
      WHEN ${cre_cs_in_prog_edur_dt_raw} IS NULL THEN NULL
      WHEN ${cre_cs_in_prog_edur_dt_date} = ${cre_cs_in_prog_sdur_dt_date} THEN DATETIME_DIFF(${cs_in_prog_dt_raw},${cre_dt_lc_raw}, SECOND)/86400
      WHEN DATETIME_DIFF(${cre_cs_in_prog_edur_dt_raw},${cre_cs_in_prog_sdur_dt_raw}, DAY) = 1 THEN
      (CASE WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_cre_cs_in_prog_st.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw} = ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw} THEN 0
      WHEN ${cre_cs_in_prog_sdur_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw} THEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.adjusted_hours}/24
      WHEN ${cre_cs_in_prog_sdur_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw} AND ${cre_cs_in_prog_sdur_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} IS NOT NULL THEN ${cre_cs_in_prog_half_hol_start}
      WHEN ${cre_cs_in_prog_sdur_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw} AND ${cre_cs_in_prog_sdur_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw},${cre_cs_in_prog_sdur_dt_raw},SECOND)/86400
      WHEN ${cre_cs_in_prog_sdur_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw} THEN 0
      END +
      CASE WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_ed.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_cre_cs_in_prog_ed.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_cre_cs_in_prog_ed.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_st_dt_raw} = ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_end_dt_raw} THEN 0
      WHEN ${cre_cs_in_prog_edur_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_end_dt_raw} THEN ${dmc_crm_bh_hol_cre_cs_in_prog_ed.adjusted_hours}/24
      WHEN ${cre_cs_in_prog_edur_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_st_dt_raw} AND ${cre_cs_in_prog_edur_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_ed.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_cre_cs_in_prog_ed.hol_end_dt_raw} IS NOT NULL THEN ${cre_cs_in_prog_half_hol_end}
      WHEN ${cre_cs_in_prog_edur_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_st_dt_raw} AND ${cre_cs_in_prog_edur_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_end_dt_raw}
      THEN DATETIME_DIFF(${cre_cs_in_prog_edur_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_st_dt_raw},SECOND)/86400
      WHEN ${cre_cs_in_prog_edur_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_st_dt_raw} THEN 0
      END)*(CASE WHEN ${cs_in_prog_gdt_raw} < ${cre_dt_utc_raw} THEN -1 ELSE 1 END)
      ELSE
      (CASE WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_cre_cs_in_prog_st.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw} = ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw} THEN 0
      WHEN ${cre_cs_in_prog_sdur_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw} THEN ${dmc_crm_bh_hol_cre_cs_in_prog_st.adjusted_hours}/24
      WHEN ${cre_cs_in_prog_sdur_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw} AND ${cre_cs_in_prog_sdur_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_cre_cs_in_prog_st.hol_end_dt_raw} IS NOT NULL THEN ${cre_cs_in_prog_half_hol_start}
      WHEN ${cre_cs_in_prog_sdur_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_st_dt_raw} AND ${cre_cs_in_prog_sdur_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw},${cre_cs_in_prog_sdur_dt_raw},SECOND)/86400
      WHEN ${cre_cs_in_prog_sdur_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_st.day_end_dt_raw} THEN 0
      END +
      CASE WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_ed.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_cre_cs_in_prog_ed.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_cre_cs_in_prog_ed.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_st_dt_raw} = ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_end_dt_raw} THEN 0
      WHEN ${cre_cs_in_prog_edur_dt_raw} > ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_end_dt_raw} THEN ${dmc_crm_bh_hol_cre_cs_in_prog_ed.adjusted_hours}/24
      WHEN ${cre_cs_in_prog_edur_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_st_dt_raw} AND ${cre_cs_in_prog_edur_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cre_cs_in_prog_ed.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_cre_cs_in_prog_ed.hol_end_dt_raw} IS NOT NULL THEN ${cre_cs_in_prog_half_hol_end}
      WHEN ${cre_cs_in_prog_edur_dt_raw} >= ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_st_dt_raw} AND ${cre_cs_in_prog_edur_dt_raw} <= ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_end_dt_raw}
      THEN DATETIME_DIFF(${cre_cs_in_prog_edur_dt_raw},${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_st_dt_raw},SECOND)/86400
      WHEN ${cre_cs_in_prog_edur_dt_raw} < ${dmc_crm_bh_hol_cre_cs_in_prog_ed.day_st_dt_raw} THEN 0
      END +
      ${cre_cs_in_prog_mid}/24)*(CASE WHEN ${cs_in_prog_gdt_raw} < ${cre_dt_utc_raw} THEN -1 ELSE 1 END)
       END ;;
    value_format_name: decimal_3
  }

  measure: dur_of_cre_cs_in_prog_tm {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Open to First In Progress (hh:mm:ss)"
    label: "Duration of Open to First In Progress (hh:mm:ss)"
    type: average
    sql:  ${dur_of_cre_cs_in_prog_days} ;;
    value_format: "[hh]:mm:ss"
  }

  ### First In Progress to First Response Time
  dimension_group: cs_in_prog_n1st_res_sdur_dt {
    hidden: yes
    view_label: "Case Info"
    group_label: "First In Progress to First Response Time Start"
    group_item_label: "@{time_frames}"
    label: "First In Progress to First Response Time Start"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: CASE WHEN ${cs_in_prog_gdt_raw} < ${n1st_res_gdt_raw} THEN ${cs_in_prog_dt_raw} ELSE ${n1st_res_dt_raw} END ;;
  }

  dimension_group: cs_in_prog_n1st_res_edur_dt {
    hidden: yes
    view_label: "Case Info"
    group_label: "First In Progress to First Response Time End"
    group_item_label: "@{time_frames}"
    label: "First In Progress to First Response Time End"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: CASE WHEN ${cs_in_prog_gdt_raw} < ${n1st_res_gdt_raw} THEN ${n1st_res_dt_raw} ELSE ${cs_in_prog_dt_raw} END ;;
  }

  dimension: cs_in_prog_n1st_res_mid {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First In Progress to First Response Time Mid Duration"
    label: "First In Progress to First Response Time Mid Duration"
    type: number
    sql: COALESCE(${dmo_case_dur_mid_cs.cs_in_prog_n1st_res_adj_hours},0) ;;
  }

  #For not all day holiday
  dimension: cs_in_prog_n1st_res_half_hol_mid_1 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First In Progress to First Response Time Half Holiday Mid 1"
    label: "First In Progress to First Response Time Half Holiday Mid 1"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} >= ${cs_in_prog_n1st_res_edur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} < ${cs_in_prog_n1st_res_edur_dt_raw}
      THEN DATETIME_DIFF(${cs_in_prog_n1st_res_edur_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${cs_in_prog_n1st_res_edur_dt_raw}
      THEN DATETIME_DIFF(${cs_in_prog_n1st_res_edur_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} < ${cs_in_prog_n1st_res_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} >= ${cs_in_prog_n1st_res_edur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} < ${cs_in_prog_n1st_res_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} < ${cs_in_prog_n1st_res_edur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${cs_in_prog_n1st_res_edur_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${cs_in_prog_n1st_res_edur_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw}
      THEN DATETIME_DIFF(${cs_in_prog_n1st_res_edur_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${cs_in_prog_n1st_res_edur_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: cs_in_prog_n1st_res_half_hol_mid_2 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First In Progress to First Response Time Half Holiday Mid 2"
    label: "First In Progress to First Response Time Half Holiday Mid 2"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
        AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
        AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} >= ${cs_in_prog_n1st_res_sdur_dt_raw}
        THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} < ${cs_in_prog_n1st_res_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${cs_in_prog_n1st_res_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} > ${cs_in_prog_n1st_res_sdur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} <= ${cs_in_prog_n1st_res_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} > ${cs_in_prog_n1st_res_sdur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} > ${cs_in_prog_n1st_res_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} <= ${cs_in_prog_n1st_res_sdur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} > ${cs_in_prog_n1st_res_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: cs_in_prog_n1st_res_half_hol_mid_3 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First In Progress to First Response Time Half Holiday Mid 3"
    label: "First In Progress to First Response Time Half Holiday Mid 3"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} >= ${cs_in_prog_n1st_res_edur_dt_raw}
         THEN 0

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} < ${cs_in_prog_n1st_res_sdur_dt_raw}
      THEN DATETIME_DIFF(${cs_in_prog_n1st_res_edur_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} >= ${cs_in_prog_n1st_res_sdur_dt_raw}
      THEN DATETIME_DIFF(${cs_in_prog_n1st_res_edur_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${cs_in_prog_n1st_res_sdur_dt_raw}
      THEN DATETIME_DIFF(${cs_in_prog_n1st_res_edur_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${cs_in_prog_n1st_res_edur_dt_raw}
      THEN DATETIME_DIFF(${cs_in_prog_n1st_res_edur_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} > ${cs_in_prog_n1st_res_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} <= ${cs_in_prog_n1st_res_sdur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} > ${cs_in_prog_n1st_res_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} > ${cs_in_prog_n1st_res_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${cs_in_prog_n1st_res_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} <= ${cs_in_prog_n1st_res_sdur_dt_raw}
      THEN DATETIME_DIFF(${cs_in_prog_n1st_res_edur_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${cs_in_prog_n1st_res_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} > ${cs_in_prog_n1st_res_sdur_dt_raw}
      THEN DATETIME_DIFF(${cs_in_prog_n1st_res_edur_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${cs_in_prog_n1st_res_edur_dt_raw}
      THEN DATETIME_DIFF(${cs_in_prog_n1st_res_edur_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} <= ${cs_in_prog_n1st_res_sdur_dt_raw}
      THEN 0

      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} < ${cs_in_prog_n1st_res_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw} >= ${cs_in_prog_n1st_res_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: cs_in_prog_n1st_res_half_hol_start {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First In Progress to First Response Time Half Holiday Start"
    label: "First In Progress to First Response Time Half Holiday Start"
    type: number
    sql:
    CASE WHEN ${cs_in_prog_n1st_res_sdur_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw}
          AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw}
         THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw}, SECOND)/86400

      WHEN ${cs_in_prog_n1st_res_sdur_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw}
      THEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.adjusted_hours}/24 - DATETIME_DIFF(${cs_in_prog_n1st_res_sdur_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${cs_in_prog_n1st_res_sdur_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} THEN 0

      WHEN ${cs_in_prog_n1st_res_sdur_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw}
      AND ${cs_in_prog_n1st_res_sdur_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${cs_in_prog_n1st_res_sdur_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: cs_in_prog_n1st_res_half_hol_end {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First In Progress to First Response Time Half Holiday End"
    label: "First In Progress to First Response Time Half Holiday End"
    type: number
    sql:
    CASE WHEN ${cs_in_prog_n1st_res_edur_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.hol_st_dt_raw}
         THEN DATETIME_DIFF(${cs_in_prog_n1st_res_edur_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_st_dt_raw}, SECOND)/86400

      WHEN ${cs_in_prog_n1st_res_edur_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_end_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.hol_end_dt_raw} THEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.adjusted_hours}/24

      WHEN ${cs_in_prog_n1st_res_edur_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_end_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.hol_end_dt_raw}
      AND ${cs_in_prog_n1st_res_edur_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.hol_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.hol_st_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw}, SECOND)/86400

      WHEN ${cs_in_prog_n1st_res_edur_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.hol_end_dt_raw}
      THEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.adjusted_hours}/24 - DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_end_dt_raw},${cs_in_prog_n1st_res_edur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: dur_of_cs_in_prog_n1st_res_days {
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "Dur of First In Progress to First Response (Days)"
    label: "Dur of First In Progress to First Response (Days)"
    type: number
    sql:CASE WHEN ${cs_in_prog_n1st_res_sdur_dt_raw} IS NULL THEN NULL
      WHEN ${cs_in_prog_n1st_res_edur_dt_raw} IS NULL THEN NULL
      WHEN ${cs_in_prog_n1st_res_edur_dt_date} = ${cs_in_prog_n1st_res_sdur_dt_date} THEN DATETIME_DIFF(${n1st_res_dt_raw},${cs_in_prog_dt_raw}, SECOND)/86400
      WHEN DATETIME_DIFF(${cs_in_prog_n1st_res_edur_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw}, DAY) = 1 THEN
      (CASE WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw} = ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw} THEN 0
      WHEN ${cs_in_prog_n1st_res_sdur_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw} THEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.adjusted_hours}/24
      WHEN ${cs_in_prog_n1st_res_sdur_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw} AND ${cs_in_prog_n1st_res_sdur_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} IS NOT NULL THEN ${cs_in_prog_n1st_res_half_hol_start}
      WHEN ${cs_in_prog_n1st_res_sdur_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw} AND ${cs_in_prog_n1st_res_sdur_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw},SECOND)/86400
      WHEN ${cs_in_prog_n1st_res_sdur_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw} THEN 0
      END +
      CASE WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_st_dt_raw} = ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_end_dt_raw} THEN 0
      WHEN ${cs_in_prog_n1st_res_edur_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_end_dt_raw} THEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.adjusted_hours}/24
      WHEN ${cs_in_prog_n1st_res_edur_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_st_dt_raw} AND ${cs_in_prog_n1st_res_edur_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.hol_end_dt_raw} IS NOT NULL THEN ${cs_in_prog_n1st_res_half_hol_end}
      WHEN ${cs_in_prog_n1st_res_edur_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_st_dt_raw} AND ${cs_in_prog_n1st_res_edur_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_end_dt_raw}
      THEN DATETIME_DIFF(${cs_in_prog_n1st_res_edur_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_st_dt_raw},SECOND)/86400
      WHEN ${cs_in_prog_n1st_res_edur_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_st_dt_raw} THEN 0
      END)*(CASE WHEN ${n1st_res_gdt_raw} < ${cs_in_prog_gdt_raw} THEN -1 ELSE 1 END)
      ELSE
      (CASE WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw} = ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw} THEN 0
      WHEN ${cs_in_prog_n1st_res_sdur_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw} THEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.adjusted_hours}/24
      WHEN ${cs_in_prog_n1st_res_sdur_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw} AND ${cs_in_prog_n1st_res_sdur_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.hol_end_dt_raw} IS NOT NULL THEN ${cs_in_prog_n1st_res_half_hol_start}
      WHEN ${cs_in_prog_n1st_res_sdur_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_st_dt_raw} AND ${cs_in_prog_n1st_res_sdur_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw},${cs_in_prog_n1st_res_sdur_dt_raw},SECOND)/86400
      WHEN ${cs_in_prog_n1st_res_sdur_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_st.day_end_dt_raw} THEN 0
      END +
      CASE WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_st_dt_raw} = ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_end_dt_raw} THEN 0
      WHEN ${cs_in_prog_n1st_res_edur_dt_raw} > ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_end_dt_raw} THEN ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.adjusted_hours}/24
      WHEN ${cs_in_prog_n1st_res_edur_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_st_dt_raw} AND ${cs_in_prog_n1st_res_edur_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.hol_end_dt_raw} IS NOT NULL THEN ${cs_in_prog_n1st_res_half_hol_end}
      WHEN ${cs_in_prog_n1st_res_edur_dt_raw} >= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_st_dt_raw} AND ${cs_in_prog_n1st_res_edur_dt_raw} <= ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_end_dt_raw}
      THEN DATETIME_DIFF(${cs_in_prog_n1st_res_edur_dt_raw},${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_st_dt_raw},SECOND)/86400
      WHEN ${cs_in_prog_n1st_res_edur_dt_raw} < ${dmc_crm_bh_hol_cs_in_prog_n1st_res_ed.day_st_dt_raw} THEN 0
      END +
      ${cs_in_prog_n1st_res_mid}/24)*(CASE WHEN ${n1st_res_gdt_raw} < ${cs_in_prog_gdt_raw} THEN -1 ELSE 1 END)
       END ;;
    value_format_name: decimal_3
  }

  measure: dur_of_cs_in_prog_n1st_res_tm {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First In Progress to First Response (hh:mm:ss)"
    label: "Duration of First In Progress to First Response (hh:mm:ss)"
    type: average
    sql:  ${dur_of_cs_in_prog_n1st_res_days} ;;
    value_format: "[hh]:mm:ss"
  }

  ### Resolved to Closed Time
  dimension_group: cs_rslvd_cls_sdur_dt {
    hidden: yes
    view_label: "Case Info"
    group_label: "Resolved to Closed Time Start"
    group_item_label: "@{time_frames}"
    label: "Resolved to Closed Time Start"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: CASE WHEN ${cs_rslvd_dt_tm_utc_raw} < ${cls_dt_utc_raw} THEN ${cs_rslvd_dt_tm_lc_raw} ELSE ${cls_dt_lc_raw} END ;;
  }

  dimension_group: cs_rslvd_cls_edur_dt {
    hidden: yes
    view_label: "Case Info"
    group_label: "Resolved to Closed Time End"
    group_item_label: "@{time_frames}"
    label: "Resolved to Closed Time End"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: CASE WHEN ${cs_rslvd_dt_tm_utc_raw} < ${cls_dt_utc_raw} THEN ${cls_dt_lc_raw} ELSE ${cs_rslvd_dt_tm_lc_raw} END ;;
  }

  dimension: cs_rslvd_cls_mid {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Resolved to Closed Time Mid Duration"
    label: "Resolved to Closed Time Mid Duration"
    type: number
    sql: COALESCE(${dmo_case_dur_mid_cs.cs_rslvd_cls_adj_hours},0) ;;
  }

  #For not all day holiday
  dimension: cs_rslvd_cls_half_hol_mid_1 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Resolved to Closed Time Half Holiday Mid 1"
    label: "Resolved to Closed Time Half Holiday Mid 1"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} >= ${cs_rslvd_cls_edur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} < ${cs_rslvd_cls_edur_dt_raw}
      THEN DATETIME_DIFF(${cs_rslvd_cls_edur_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${cs_rslvd_cls_edur_dt_raw}
      THEN DATETIME_DIFF(${cs_rslvd_cls_edur_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} < ${cs_rslvd_cls_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} >= ${cs_rslvd_cls_edur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} < ${cs_rslvd_cls_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} < ${cs_rslvd_cls_edur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${cs_rslvd_cls_edur_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${cs_rslvd_cls_edur_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw}
      THEN DATETIME_DIFF(${cs_rslvd_cls_edur_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${cs_rslvd_cls_edur_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: cs_rslvd_cls_half_hol_mid_2 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Resolved to Closed Time Half Holiday Mid 2"
    label: "Resolved to Closed Time Half Holiday Mid 2"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
        AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
        AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} >= ${cs_rslvd_cls_sdur_dt_raw}
        THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} < ${cs_rslvd_cls_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw},${cs_rslvd_cls_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${cs_rslvd_cls_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw},${cs_rslvd_cls_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} > ${cs_rslvd_cls_sdur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} <= ${cs_rslvd_cls_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} > ${cs_rslvd_cls_sdur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} > ${cs_rslvd_cls_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw},${cs_rslvd_cls_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} <= ${cs_rslvd_cls_sdur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} > ${cs_rslvd_cls_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw},${cs_rslvd_cls_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: cs_rslvd_cls_half_hol_mid_3 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Resolved to Closed Time Half Holiday Mid 3"
    label: "Resolved to Closed Time Half Holiday Mid 3"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} >= ${cs_rslvd_cls_edur_dt_raw}
         THEN 0

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} < ${cs_rslvd_cls_sdur_dt_raw}
      THEN DATETIME_DIFF(${cs_rslvd_cls_edur_dt_raw},${cs_rslvd_cls_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} >= ${cs_rslvd_cls_sdur_dt_raw}
      THEN DATETIME_DIFF(${cs_rslvd_cls_edur_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${cs_rslvd_cls_sdur_dt_raw}
      THEN DATETIME_DIFF(${cs_rslvd_cls_edur_dt_raw},${cs_rslvd_cls_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${cs_rslvd_cls_edur_dt_raw}
      THEN DATETIME_DIFF(${cs_rslvd_cls_edur_dt_raw},${cs_rslvd_cls_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} > ${cs_rslvd_cls_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} <= ${cs_rslvd_cls_sdur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} > ${cs_rslvd_cls_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} > ${cs_rslvd_cls_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw},${cs_rslvd_cls_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${cs_rslvd_cls_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} <= ${cs_rslvd_cls_sdur_dt_raw}
      THEN DATETIME_DIFF(${cs_rslvd_cls_edur_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${cs_rslvd_cls_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} > ${cs_rslvd_cls_sdur_dt_raw}
      THEN DATETIME_DIFF(${cs_rslvd_cls_edur_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw},${cs_rslvd_cls_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${cs_rslvd_cls_edur_dt_raw}
      THEN DATETIME_DIFF(${cs_rslvd_cls_edur_dt_raw},${cs_rslvd_cls_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} <= ${cs_rslvd_cls_sdur_dt_raw}
      THEN 0

      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} < ${cs_rslvd_cls_edur_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw} >= ${cs_rslvd_cls_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw},${cs_rslvd_cls_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: cs_rslvd_cls_half_hol_start {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Resolved to Closed Time Half Holiday Start"
    label: "Resolved to Closed Time Half Holiday Start"
    type: number
    sql:
    CASE WHEN ${cs_rslvd_cls_sdur_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw}
          AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw}
         THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw},${cs_rslvd_cls_sdur_dt_raw}, SECOND)/86400

      WHEN ${cs_rslvd_cls_sdur_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw}
      THEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.adjusted_hours}/24 - DATETIME_DIFF(${cs_rslvd_cls_sdur_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${cs_rslvd_cls_sdur_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} THEN 0

      WHEN ${cs_rslvd_cls_sdur_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw}
      AND ${cs_rslvd_cls_sdur_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${cs_rslvd_cls_sdur_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw},${cs_rslvd_cls_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: cs_rslvd_cls_half_hol_end {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Resolved to Closed Time Half Holiday End"
    label: "Resolved to Closed Time Half Holiday End"
    type: number
    sql:
    CASE WHEN ${cs_rslvd_cls_edur_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_ed.hol_st_dt_raw}
         THEN DATETIME_DIFF(${cs_rslvd_cls_edur_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_st_dt_raw}, SECOND)/86400

      WHEN ${cs_rslvd_cls_edur_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_ed.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_end_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_ed.hol_end_dt_raw} THEN ${dmc_crm_bh_hol_cs_rslvd_cls_ed.adjusted_hours}/24

      WHEN ${cs_rslvd_cls_edur_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_ed.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_end_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_ed.hol_end_dt_raw}
      AND ${cs_rslvd_cls_edur_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_ed.hol_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_ed.hol_st_dt_raw},${cs_rslvd_cls_sdur_dt_raw}, SECOND)/86400

      WHEN ${cs_rslvd_cls_edur_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_ed.hol_end_dt_raw}
      THEN ${dmc_crm_bh_hol_cs_rslvd_cls_ed.adjusted_hours}/24 - DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_end_dt_raw},${cs_rslvd_cls_edur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: dur_of_cs_rslvd_cls_days {
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "Dur of Resolved to Closed (Days)"
    label: "Dur of Resolved to Closed (Days)"
    type: number
    sql:CASE WHEN ${cs_rslvd_cls_sdur_dt_raw} IS NULL THEN NULL
      WHEN ${cs_rslvd_cls_edur_dt_raw} IS NULL THEN NULL
      WHEN ${cs_rslvd_cls_edur_dt_date} = ${cs_rslvd_cls_sdur_dt_date} THEN DATETIME_DIFF(${cls_dt_lc_raw},${cs_rslvd_dt_tm_lc_raw}, SECOND)/86400
      WHEN DATETIME_DIFF(${cs_rslvd_cls_edur_dt_raw},${cs_rslvd_cls_sdur_dt_raw}, DAY) = 1 THEN
      (CASE WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_cs_rslvd_cls_st.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw} = ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw} THEN 0
      WHEN ${cs_rslvd_cls_sdur_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw} THEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.adjusted_hours}/24
      WHEN ${cs_rslvd_cls_sdur_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw} AND ${cs_rslvd_cls_sdur_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} IS NOT NULL THEN ${cs_rslvd_cls_half_hol_start}
      WHEN ${cs_rslvd_cls_sdur_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw} AND ${cs_rslvd_cls_sdur_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw},${cs_rslvd_cls_sdur_dt_raw},SECOND)/86400
      WHEN ${cs_rslvd_cls_sdur_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw} THEN 0
      END +
      CASE WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_ed.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_cs_rslvd_cls_ed.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_cs_rslvd_cls_ed.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_st_dt_raw} = ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_end_dt_raw} THEN 0
      WHEN ${cs_rslvd_cls_edur_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_end_dt_raw} THEN ${dmc_crm_bh_hol_cs_rslvd_cls_ed.adjusted_hours}/24
      WHEN ${cs_rslvd_cls_edur_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_st_dt_raw} AND ${cs_rslvd_cls_edur_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_ed.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_cs_rslvd_cls_ed.hol_end_dt_raw} IS NOT NULL THEN ${cs_rslvd_cls_half_hol_end}
      WHEN ${cs_rslvd_cls_edur_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_st_dt_raw} AND ${cs_rslvd_cls_edur_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_end_dt_raw}
      THEN DATETIME_DIFF(${cs_rslvd_cls_edur_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_st_dt_raw},SECOND)/86400
      WHEN ${cs_rslvd_cls_edur_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_st_dt_raw} THEN 0
      END)*(CASE WHEN ${cls_dt_utc_raw} < ${cs_rslvd_dt_tm_utc_raw} THEN -1 ELSE 1 END)
      ELSE
      (CASE WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_cs_rslvd_cls_st.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw} = ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw} THEN 0
      WHEN ${cs_rslvd_cls_sdur_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw} THEN ${dmc_crm_bh_hol_cs_rslvd_cls_st.adjusted_hours}/24
      WHEN ${cs_rslvd_cls_sdur_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw} AND ${cs_rslvd_cls_sdur_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_cs_rslvd_cls_st.hol_end_dt_raw} IS NOT NULL THEN ${cs_rslvd_cls_half_hol_start}
      WHEN ${cs_rslvd_cls_sdur_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_st_dt_raw} AND ${cs_rslvd_cls_sdur_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw},${cs_rslvd_cls_sdur_dt_raw},SECOND)/86400
      WHEN ${cs_rslvd_cls_sdur_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_st.day_end_dt_raw} THEN 0
      END +
      CASE WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_ed.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_cs_rslvd_cls_ed.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_cs_rslvd_cls_ed.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_st_dt_raw} = ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_end_dt_raw} THEN 0
      WHEN ${cs_rslvd_cls_edur_dt_raw} > ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_end_dt_raw} THEN ${dmc_crm_bh_hol_cs_rslvd_cls_ed.adjusted_hours}/24
      WHEN ${cs_rslvd_cls_edur_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_st_dt_raw} AND ${cs_rslvd_cls_edur_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_cs_rslvd_cls_ed.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_cs_rslvd_cls_ed.hol_end_dt_raw} IS NOT NULL THEN ${cs_rslvd_cls_half_hol_end}
      WHEN ${cs_rslvd_cls_edur_dt_raw} >= ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_st_dt_raw} AND ${cs_rslvd_cls_edur_dt_raw} <= ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_end_dt_raw}
      THEN DATETIME_DIFF(${cs_rslvd_cls_edur_dt_raw},${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_st_dt_raw},SECOND)/86400
      WHEN ${cs_rslvd_cls_edur_dt_raw} < ${dmc_crm_bh_hol_cs_rslvd_cls_ed.day_st_dt_raw} THEN 0
      END +
      ${cs_rslvd_cls_mid}/24)*(CASE WHEN ${cls_dt_utc_raw} < ${cs_rslvd_dt_tm_utc_raw} THEN -1 ELSE 1 END)
       END ;;
    value_format_name: decimal_3
  }

  measure: dur_of_cs_rslvd_cls_tm {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Resolved to Closed (hh:mm:ss)"
    label: "Duration of Resolved to Closed (hh:mm:ss)"
    type: average
    sql:  ${dur_of_cs_rslvd_cls_days} ;;
    value_format: "[hh]:mm:ss"
  }

  ### First Closed to First Reopened
  dimension_group: frst_cls_frst_reop_sdur_dt {
    hidden: yes
    view_label: "Case Info"
    group_label: "First Closed to First Reopened Time Start"
    group_item_label: "@{time_frames}"
    label: "First Closed to First Reopened Time Start"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: CASE WHEN ${dmo_case_his_1st_cls.frst_cls_gdt_raw} < ${dmo_case_his_1st_ropn.frst_reop_gdt_raw}
              THEN ${dmo_case_his_1st_cls.frst_cls_dt_raw} ELSE ${dmo_case_his_1st_ropn.frst_reop_dt_raw} END ;;
  }

  dimension_group: frst_cls_frst_reop_edur_dt {
    hidden: yes
    view_label: "Case Info"
    group_label: "First Closed to First Reopened Time End"
    group_item_label: "@{time_frames}"
    label: "First Closed to First Reopened Time End"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: CASE WHEN ${dmo_case_his_1st_cls.frst_cls_gdt_raw} < ${dmo_case_his_1st_ropn.frst_reop_gdt_raw}
              THEN ${dmo_case_his_1st_ropn.frst_reop_dt_raw} ELSE ${dmo_case_his_1st_cls.frst_cls_dt_raw} END ;;
  }

  dimension: frst_cls_frst_reop_mid {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First Closed to First Reopened Time Mid Duration"
    label: "First Closed to First Reopened Time Mid Duration"
    type: number
    sql: COALESCE(${dmo_case_dur_mid_cs.frst_cls_frst_reop_adj_hours},0) ;;
  }

  #For not all day holiday
  dimension: frst_cls_frst_reop_half_hol_mid_1 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First Closed to First Reopened Time Half Holiday Mid 1"
    label: "First Closed to First Reopened Time Half Holiday Mid 1"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} >= ${frst_cls_frst_reop_edur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} < ${frst_cls_frst_reop_edur_dt_raw}
      THEN DATETIME_DIFF(${frst_cls_frst_reop_edur_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${frst_cls_frst_reop_edur_dt_raw}
      THEN DATETIME_DIFF(${frst_cls_frst_reop_edur_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} < ${frst_cls_frst_reop_edur_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} >= ${frst_cls_frst_reop_edur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} < ${frst_cls_frst_reop_edur_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} < ${frst_cls_frst_reop_edur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${frst_cls_frst_reop_edur_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${frst_cls_frst_reop_edur_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw}
      THEN DATETIME_DIFF(${frst_cls_frst_reop_edur_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${frst_cls_frst_reop_edur_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: frst_cls_frst_reop_half_hol_mid_2 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First Closed to First Reopened Time Half Holiday Mid 2"
    label: "First Closed to First Reopened Time Half Holiday Mid 2"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
        AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
        AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} >= ${frst_cls_frst_reop_sdur_dt_raw}
        THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} < ${frst_cls_frst_reop_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw},${frst_cls_frst_reop_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${frst_cls_frst_reop_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw},${frst_cls_frst_reop_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} > ${frst_cls_frst_reop_sdur_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} <= ${frst_cls_frst_reop_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} > ${frst_cls_frst_reop_sdur_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} > ${frst_cls_frst_reop_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw},${frst_cls_frst_reop_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} <= ${frst_cls_frst_reop_sdur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} > ${frst_cls_frst_reop_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw},${frst_cls_frst_reop_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: frst_cls_frst_reop_half_hol_mid_3 {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First Closed to First Reopened Time Half Holiday Mid 3"
    label: "First Closed to First Reopened Time Half Holiday Mid 3"
    type: number
    sql:
    CASE WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
          AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
          AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} >= ${frst_cls_frst_reop_edur_dt_raw}
         THEN 0

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} < ${frst_cls_frst_reop_sdur_dt_raw}
      THEN DATETIME_DIFF(${frst_cls_frst_reop_edur_dt_raw},${frst_cls_frst_reop_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} >= ${frst_cls_frst_reop_sdur_dt_raw}
      THEN DATETIME_DIFF(${frst_cls_frst_reop_edur_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${frst_cls_frst_reop_sdur_dt_raw}
      THEN DATETIME_DIFF(${frst_cls_frst_reop_edur_dt_raw},${frst_cls_frst_reop_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${frst_cls_frst_reop_edur_dt_raw}
      THEN DATETIME_DIFF(${frst_cls_frst_reop_edur_dt_raw},${frst_cls_frst_reop_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} > ${frst_cls_frst_reop_edur_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} <= ${frst_cls_frst_reop_sdur_dt_raw} THEN 0

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} > ${frst_cls_frst_reop_edur_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} > ${frst_cls_frst_reop_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw},${frst_cls_frst_reop_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${frst_cls_frst_reop_edur_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} <= ${frst_cls_frst_reop_sdur_dt_raw}
      THEN DATETIME_DIFF(${frst_cls_frst_reop_edur_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${frst_cls_frst_reop_edur_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} > ${frst_cls_frst_reop_sdur_dt_raw}
      THEN DATETIME_DIFF(${frst_cls_frst_reop_edur_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw}, SECOND)/86400
      + DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw},${frst_cls_frst_reop_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${frst_cls_frst_reop_edur_dt_raw}
      THEN DATETIME_DIFF(${frst_cls_frst_reop_edur_dt_raw},${frst_cls_frst_reop_sdur_dt_raw}, SECOND)/86400

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} <= ${frst_cls_frst_reop_sdur_dt_raw}
      THEN 0

      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} < ${frst_cls_frst_reop_edur_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw} >= ${frst_cls_frst_reop_sdur_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw},${frst_cls_frst_reop_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: frst_cls_frst_reop_half_hol_start {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First Closed to First Reopened Time Half Holiday Start"
    label: "First Closed to First Reopened Time Half Holiday Start"
    type: number
    sql:
    CASE WHEN ${frst_cls_frst_reop_sdur_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw}
          AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw}
         THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw},${frst_cls_frst_reop_sdur_dt_raw}, SECOND)/86400

      WHEN ${frst_cls_frst_reop_sdur_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw}
      THEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.adjusted_hours}/24 - DATETIME_DIFF(${frst_cls_frst_reop_sdur_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw}, SECOND)/86400

      WHEN ${frst_cls_frst_reop_sdur_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} THEN 0

      WHEN ${frst_cls_frst_reop_sdur_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw}
      AND ${frst_cls_frst_reop_sdur_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw}, SECOND)/86400

      WHEN ${frst_cls_frst_reop_sdur_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw},${frst_cls_frst_reop_sdur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: frst_cls_frst_reop_half_hol_end {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First Closed to First Reopened Time Half Holiday End"
    label: "First Closed to First Reopened Time Half Holiday End"
    type: number
    sql:
    CASE WHEN ${frst_cls_frst_reop_edur_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.hol_st_dt_raw}
         THEN DATETIME_DIFF(${frst_cls_frst_reop_edur_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_st_dt_raw}, SECOND)/86400

      WHEN ${frst_cls_frst_reop_edur_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_end_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.hol_end_dt_raw} THEN ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.adjusted_hours}/24

      WHEN ${frst_cls_frst_reop_edur_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.hol_st_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_end_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.hol_end_dt_raw}
      AND ${frst_cls_frst_reop_edur_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.hol_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_ed.hol_st_dt_raw},${frst_cls_frst_reop_sdur_dt_raw}, SECOND)/86400

      WHEN ${frst_cls_frst_reop_edur_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.hol_end_dt_raw}
      THEN ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.adjusted_hours}/24 - DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_end_dt_raw},${frst_cls_frst_reop_edur_dt_raw}, SECOND)/86400
      END ;;
  }

  dimension: dur_of_frst_cls_frst_reop_days {
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "Dur of First Closed to First Reopened (Days)"
    label: "Dur of First Closed to First Reopened (Days)"
    type: number
    sql:CASE WHEN ${frst_cls_frst_reop_sdur_dt_raw} IS NULL THEN NULL
      WHEN ${frst_cls_frst_reop_edur_dt_raw} IS NULL THEN NULL
      WHEN ${frst_cls_frst_reop_edur_dt_date} = ${frst_cls_frst_reop_sdur_dt_date} THEN DATETIME_DIFF(${dmo_case_his_1st_ropn.frst_reop_dt_raw},${dmo_case_his_1st_cls.frst_cls_dt_raw}, SECOND)/86400
      WHEN DATETIME_DIFF(${frst_cls_frst_reop_edur_dt_raw},${frst_cls_frst_reop_sdur_dt_raw}, DAY) = 1 THEN
      (CASE WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_frst_cls_frst_reop_st.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw} = ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw} THEN 0
      WHEN ${frst_cls_frst_reop_sdur_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw} THEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.adjusted_hours}/24
      WHEN ${frst_cls_frst_reop_sdur_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw} AND ${frst_cls_frst_reop_sdur_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} IS NOT NULL THEN ${frst_cls_frst_reop_half_hol_start}
      WHEN ${frst_cls_frst_reop_sdur_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw} AND ${frst_cls_frst_reop_sdur_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw},${frst_cls_frst_reop_sdur_dt_raw},SECOND)/86400
      WHEN ${frst_cls_frst_reop_sdur_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw} THEN 0
      END +
      CASE WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_frst_cls_frst_reop_ed.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_st_dt_raw} = ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_end_dt_raw} THEN 0
      WHEN ${frst_cls_frst_reop_edur_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_end_dt_raw} THEN ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.adjusted_hours}/24
      WHEN ${frst_cls_frst_reop_edur_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_st_dt_raw} AND ${frst_cls_frst_reop_edur_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.hol_end_dt_raw} IS NOT NULL THEN ${frst_cls_frst_reop_half_hol_end}
      WHEN ${frst_cls_frst_reop_edur_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_st_dt_raw} AND ${frst_cls_frst_reop_edur_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_end_dt_raw}
      THEN DATETIME_DIFF(${frst_cls_frst_reop_edur_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_st_dt_raw},SECOND)/86400
      WHEN ${frst_cls_frst_reop_edur_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_st_dt_raw} THEN 0
      END)*(CASE WHEN ${dmo_case_his_1st_ropn.frst_reop_gdt_raw} < ${dmo_case_his_1st_cls.frst_cls_gdt_raw} THEN -1 ELSE 1 END)
      ELSE
      (CASE WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_frst_cls_frst_reop_st.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw} = ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw} THEN 0
      WHEN ${frst_cls_frst_reop_sdur_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw} THEN ${dmc_crm_bh_hol_frst_cls_frst_reop_st.adjusted_hours}/24
      WHEN ${frst_cls_frst_reop_sdur_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw} AND ${frst_cls_frst_reop_sdur_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_frst_cls_frst_reop_st.hol_end_dt_raw} IS NOT NULL THEN ${frst_cls_frst_reop_half_hol_start}
      WHEN ${frst_cls_frst_reop_sdur_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_st_dt_raw} AND ${frst_cls_frst_reop_sdur_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw}
      THEN DATETIME_DIFF(${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw},${frst_cls_frst_reop_sdur_dt_raw},SECOND)/86400
      WHEN ${frst_cls_frst_reop_sdur_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_st.day_end_dt_raw} THEN 0
      END +
      CASE WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.is_hol_dt} = 'Yes' AND (${dmc_crm_bh_hol_frst_cls_frst_reop_ed.is_all_dy_hol} = 'Yes' OR ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.hol_end_dt_raw} IS NULL) THEN 0
      WHEN ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_st_dt_raw} = ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_end_dt_raw} THEN 0
      WHEN ${frst_cls_frst_reop_edur_dt_raw} > ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_end_dt_raw} THEN ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.adjusted_hours}/24
      WHEN ${frst_cls_frst_reop_edur_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_st_dt_raw} AND ${frst_cls_frst_reop_edur_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_end_dt_raw}
      AND ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.is_hol_dt} = 'Yes' AND ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.hol_end_dt_raw} IS NOT NULL THEN ${frst_cls_frst_reop_half_hol_end}
      WHEN ${frst_cls_frst_reop_edur_dt_raw} >= ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_st_dt_raw} AND ${frst_cls_frst_reop_edur_dt_raw} <= ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_end_dt_raw}
      THEN DATETIME_DIFF(${frst_cls_frst_reop_edur_dt_raw},${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_st_dt_raw},SECOND)/86400
      WHEN ${frst_cls_frst_reop_edur_dt_raw} < ${dmc_crm_bh_hol_frst_cls_frst_reop_ed.day_st_dt_raw} THEN 0
      END +
      ${frst_cls_frst_reop_mid}/24)*(CASE WHEN ${dmo_case_his_1st_ropn.frst_reop_gdt_raw} < ${dmo_case_his_1st_cls.frst_cls_gdt_raw} THEN -1 ELSE 1 END)
       END ;;
    value_format_name: decimal_3
  }

  measure: dur_of_frst_cls_frst_reop_tm {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "First Closed to First Reopened (hh:mm:ss)"
    label: "Duration of First Closed to First Reopened (hh:mm:ss)"
    type: average
    sql:  ${dur_of_frst_cls_frst_reop_days} ;;
    value_format: "[hh]:mm:ss"
  }

  ### PI4V2-21622 + PI4V2-21963 ###

  dimension: trns_mnl_by_agn_flg {
    hidden: yes
    view_label: "Case Info"
    group_label: "Nature"
    group_item_label: "Transfer Manually By Agent"
    label: "Transfer Manually By Agent"
    type: string
    sql: ${TABLE}.TRNS_MNL_BY_AGN_FLG ;;
  }

  dimension: is_trns_mnl_by_agn {
    view_label: "Case Info"
    group_label: "Nature"
    group_item_label: "Is Transfer Manually By Agent (Yes/No)"
    label: "Is Transfer Manually By Agent"
    type: string
    sql: CASE WHEN ${trns_mnl_by_agn_flg} = "true" THEN "Yes" ELSE "No" END ;;
  }

  ### PI4V2-22540 ###
  ### PI4V2-23198: Update Case/Queue Owner Hierarchy for CA explore ###
  dimension: cs_que_owner_of_id_pk {
    view_label: "Case Info"
    group_label: "Owner"
    group_item_label: "01. ID"
    label: "Case/Queue Owner ID"
    type: string
    sql: COALESCE(${dmo_case_owner.of_id_pk}, ${dmo_queue_owner.of_id_pk}) ;;
  }

  dimension: cs_que_owner_usr_nm {
    view_label: "Case Info"
    group_label: "Owner"
    group_item_label: "02. Name"
    label: "Case/Queue Owner Name"
    type: string
    sql: COALESCE(${dmo_case_owner.usr_nm}, ${dmo_queue_owner.usr_nm}) ;;
  }

  dimension: cs_que_owner_usr_role_nm {
    view_label: "Case Info"
    group_label: "Owner"
    group_item_label: "03. Role"
    label: "Case/Queue Owner User Role"
    type: string
    sql: COALESCE(${dmo_case_owner.usr_role_nm}, ${dmo_queue_owner.usr_role_nm}) ;;
  }

  dimension: cs_que_owner_prfl_nm {
    view_label: "Case Info"
    group_label: "Owner"
    group_item_label: "04. Profile"
    label: "Case/Queue Owner User Profile"
    type: string
    sql: COALESCE(${dmo_case_owner.prfl_nm}, ${dmo_queue_owner.prfl_nm}) ;;
  }

  dimension: cs_que_owner_ofc_cd_no {
    view_label: "Case Info"
    group_label: "Owner"
    group_item_label: "05. Office Code"
    label: "Case/Queue Owner Office Code"
    type: string
    sql: COALESCE(${dmo_case_owner.ofc_cd_no}, ${dmo_queue_owner.ofc_cd_no}) ;;
  }

  dimension: cs_que_owner_ofc_eng_nm {
    view_label: "Case Info"
    group_label: "Owner"
    group_item_label: "06. Office Name"
    label: "Case/Queue Owner Office Name"
    type: string
    sql: COALESCE(${dmo_case_owner.ofc_eng_nm}, ${dmo_queue_owner.ofc_eng_nm}) ;;
  }

  # dimension: cs_que_owner_loc_cd {
  #   view_label: "Case Info"
  #   group_label: "Owner"
  #   group_item_label: "07. Office Location Code"
  #   label: "Case/Queue Owner Location Code"
  #   type: string
  #   sql: COALESCE(${dmo_case_owner.loc_cd}, ${dmo_queue_owner.loc_cd}) ;;
  # }

  # dimension: cs_que_owner_loc_nm {
  #   view_label: "Case Info"
  #   group_label: "Owner"
  #   group_item_label: "08. Office Location Name"
  #   label: "Case/Queue Owner Location Name"
  #   type: string
  #   sql: COALESCE(${dmo_case_owner.loc_nm}, ${dmo_queue_owner.loc_nm}) ;;
  # }

  # dimension: cs_que_owner_ste_cd {
  #   view_label: "Case Info"
  #   group_label: "Owner"
  #   group_item_label: "09. Office State Code"
  #   label: "Case/Queue Owner State Code"
  #   type: string
  #   sql: COALESCE(${dmo_case_owner.ste_cd}, ${dmo_queue_owner.ste_cd}) ;;
  # }

  # dimension: cs_que_owner_ste_nm {
  #   view_label: "Case Info"
  #   group_label: "Owner"
  #   group_item_label: "10. Office State Name"
  #   label: "Case/Queue Owner State Name"
  #   type: string
  #   sql: COALESCE(${dmo_case_owner.ste_nm}, ${dmo_queue_owner.ste_nm}) ;;
  # }

  dimension: cs_que_owner_sub_cnt_cd {
    view_label: "Case Info"
    group_label: "Owner"
    group_item_label: "07. Office Sub Country Code"
    label: "Case/Queue Owner Sub Country Code"
    type: string
    sql: COALESCE(${dmo_case_owner.sub_cnt_cd}, ${dmo_queue_owner.sub_cnt_cd}) ;;
  }

  dimension: cs_que_owner_sub_cnt_nm {
    view_label: "Case Info"
    group_label: "Owner"
    group_item_label: "08. Office Sub Country Name"
    label: "Case/Queue Owner Sub Country Name"
    type: string
    sql: COALESCE(${dmo_case_owner.sub_cnt_nm}, ${dmo_queue_owner.sub_cnt_nm}) ;;
  }

  dimension: cs_que_owner_cnt_cd {
    view_label: "Case Info"
    group_label: "Owner"
    group_item_label: "09. Office Country Code"
    label: "Case/Queue Owner Country Code"
    type: string
    sql: COALESCE(${dmo_case_owner.cnt_cd}, ${dmo_queue_owner.cnt_cd}) ;;
  }

  dimension: cs_que_owner_cnt_nm {
    view_label: "Case Info"
    group_label: "Owner"
    group_item_label: "10. Office Country Name"
    label: "Case/Queue Owner Country Name"
    type: string
    sql: COALESCE(${dmo_case_owner.cnt_nm}, ${dmo_queue_owner.cnt_nm}) ;;
  }

  # dimension: cs_que_owner_rgn_cd {
  #   view_label: "Case Info"
  #   group_label: "Owner"
  #   group_item_label: "15. Office Region Code"
  #   label: "Case/Queue Owner Region Code"
  #   type: string
  #   sql: COALESCE(${dmo_case_owner.rgn_cd}, ${dmo_queue_owner.rgn_cd}) ;;
  # }

  # dimension: cs_que_owner_rgn_nm {
  #   view_label: "Case Info"
  #   group_label: "Owner"
  #   group_item_label: "16. Office Region Name"
  #   label: "Case/Queue Owner Region Name"
  #   type: string
  #   sql: COALESCE(${dmo_case_owner.rgn_nm}, ${dmo_queue_owner.rgn_nm}) ;;
  # }

  # dimension: cs_que_owner_sconti_cd {
  #   view_label: "Case Info"
  #   group_label: "Owner"
  #   group_item_label: "17. Office Subcontinent Code"
  #   label: "Case/Queue Owner Subcontinent Code"
  #   type: string
  #   sql: COALESCE(${dmo_case_owner.sconti_cd}, ${dmo_queue_owner.sconti_cd}) ;;
  # }

  # dimension: cs_que_owner_sconti_nm {
  #   view_label: "Case Info"
  #   group_label: "Owner"
  #   group_item_label: "18. Office Subcontinent Name"
  #   label: "Case/Queue Owner Subcontinent Name"
  #   type: string
  #   sql: COALESCE(${dmo_case_owner.sconti_nm}, ${dmo_queue_owner.sconti_nm}) ;;
  # }

  # dimension: cs_que_owner_conti_cd {
  #   view_label: "Case Info"
  #   group_label: "Owner"
  #   group_item_label: "19. Office Continent Code"
  #   label: "Case/Queue Owner Continent Code"
  #   type: string
  #   sql: COALESCE(${dmo_case_owner.conti_cd}, ${dmo_queue_owner.conti_cd}) ;;
  # }

  # dimension: cs_que_owner_conti_nm {
  #   view_label: "Case Info"
  #   group_label: "Owner"
  #   group_item_label: "20. Office Continent Name"
  #   label: "Case/Queue Owner Continent Name"
  #   type: string
  #   sql: COALESCE(${dmo_case_owner.conti_nm}, ${dmo_queue_owner.conti_nm}) ;;
  # }

  dimension: cs_que_owner_rhq_cd {
    view_label: "Case Info"
    group_label: "Owner"
    group_item_label: "11. Office RHQ"
    label: "Case/Queue Owner Office RHQ"
    type: string
    sql: COALESCE(${dmo_case_owner.rhq_cd}, ${dmo_queue_owner.rhq_cd}, "Unclaimed") ;;
  }

  dimension: cs_que_owner_ofc_tp_nm {
    view_label: "Case Info"
    group_label: "Owner"
    group_item_label: "12. Office Type"
    label: "Case/Queue Owner Office Type"
    type: string
    sql: COALESCE(${dmo_case_owner.ofc_tp_nm}, ${dmo_queue_owner.ofc_tp_nm}) ;;
  }

  ### PI4V2-22994
  dimension: cs_que_owner_mngr_nm {
    view_label: "Case Info"
    group_label: "Owner"
    group_item_label: "13. Manager Name"
    label: "Case/Queue Owner Manager Name"
    type: string
    sql: COALESCE(${dmo_case_owner.mngr_nm}, ${dmo_queue_owner.mngr_nm});;
  }

  dimension: cs_que_owner_mngr_one_eml {
    view_label: "Case Info"
    group_label: "Owner"
    group_item_label: "14. Manager Email"
    label: "Case/Queue Owner Manager Email"
    type: string
    sql: COALESCE(${dmo_case_owner.mngr_one_eml}, ${dmo_queue_owner.mngr_one_eml});;
  }

  ### PI4V2-23522 ###
  dimension: cs_que_owner_tp {
    view_label: "Case Info"
    group_label: "Owner"
    group_item_label: "15. Owner Type"
    label: "Case/Queue Owner Type"
    type: string
    sql: CASE WHEN ${cs_own_id} LIKE "00G%" THEN "Queue"
              WHEN ${cs_que_owner_usr_nm} LIKE "%User%" OR ${cs_que_owner_usr_nm} LIKE "%Automated%" THEN "Bot"
              ELSE "Agent" END ;;
  }

  dimension_group: assg_dt {
    view_label: "Case Info"
    group_label: "First Assigned Date Time (Local)"
    group_item_label: "@{time_frames}"
    label: "First Assigned Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "This field is automatically set when a case gets assigned to a user and status is set to 'In Progress' for the first time."
    sql: DATETIME_ADD(${TABLE}.ASSG_DT, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension_group: assg_gdt {
    view_label: "Case Info"
    group_label: "First Assigned Date Time (UTC)"
    group_item_label: "@{time_frames}"
    label: "First Assigned UTC"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "This field is automatically set when a case gets assigned to a user and status is set to 'In Progress' for the first time."
    sql: ${TABLE}.ASSG_DT ;;
  }

  dimension_group: cs_in_prog_dt {
    view_label: "Case Info"
    group_label: "First In Progress Date Time (Local)"
    group_item_label: "@{time_frames}"
    label: "First In Progress Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description:"Datetime when the Case status is updated to \"In Progress\" for the first time."
    sql: DATETIME_ADD(${TABLE}.CS_IN_PROG_DT, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension_group: cs_in_prog_gdt {
    view_label: "Case Info"
    group_label: "First In Progress Date Time (UTC)"
    group_item_label: "@{time_frames}"
    label: "First In Progress UTC"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "Datetime when the Case status is updated to \"In Progress\" for the first time."
    sql: ${TABLE}.CS_IN_PROG_DT ;;
  }

  dimension_group: n1st_cs_rsolv_dt {
    view_label: "Case Info"
    group_label: "First Case Resolved Date Time (Local)"
    group_item_label: "@{time_frames}"
    label: "First Case Resolved Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "Datetime when the case is first updated to resolved status."
    sql: DATETIME_ADD(${TABLE}.N1ST_CS_RSOLV_DT, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension_group: n1st_cs_rsolv_gdt {
    view_label: "Case Info"
    group_label: "First Case Resolved Date Time (UTC)"
    group_item_label: "@{time_frames}"
    label: "First Case Resolved UTC"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "Datetime when the case is first updated to resolved status."
    sql: ${TABLE}.N1ST_CS_RSOLV_DT ;;
  }

  dimension_group: nrtr_dt {
    view_label: "Case Info"
    group_label: "Nurture Date Time (Local)"
    group_item_label: "@{time_frames}"
    label: "Nurture Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "Datetime when the Case has been nurtured."
    sql: DATETIME_ADD(${TABLE}.NRTR_DT, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension_group: nrtr_gdt {
    view_label: "Case Info"
    group_label: "Nurture Date Time (UTC)"
    group_item_label: "@{time_frames}"
    label: "Nurture UTC"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "Datetime when the Case has been nurtured."
    sql: ${TABLE}.NRTR_DT ;;
  }

  dimension_group: on_hld_end_dt {
    view_label: "Case Info"
    group_label: "Last On-Hold Date Time (Local)"
    group_item_label: "@{time_frames}"
    label: "Last On-Hold Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "Datetime when Case Status was updated back to In Progress from being On Hold."
    sql: DATETIME_ADD(${TABLE}.ON_HLD_END_DT_TM, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension_group: on_hld_end_gdt {
    view_label: "Case Info"
    group_label: "Last On-Hold Date Time (UTC)"
    group_item_label: "@{time_frames}"
    label: "Last On-Hold UTC"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "Datetime when Case Status was updated back to In Progress from being On Hold."
    sql: ${TABLE}.ON_HLD_END_DT_TM ;;
  }

  dimension_group: on_hld_st_dt {
    view_label: "Case Info"
    group_label: "First On-Hold Date Time (Local)"
    group_item_label: "@{time_frames}"
    label: "First On-Hold Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "Datetime when Case Status was put On Hold"
    sql: DATETIME_ADD(${TABLE}.ON_HLD_ST_DT_TM, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension_group: on_hld_st_gdt {
    view_label: "Case Info"
    group_label: "First On-Hold Date Time (UTC)"
    group_item_label: "@{time_frames}"
    label: "First On-Hold UTC"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "Datetime when Case Status was put On Hold"
    sql: ${TABLE}.ON_HLD_ST_DT_TM ;;
  }

  dimension_group: rspn_flg_trakr_dt {
    view_label: "Case Info"
    group_label: "Last Response Flag Tracker Date Time (Local)"
    group_item_label: "@{time_frames}"
    label: "Last Response Flag Tracker Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "Datetime when the last response flag was triggered."
    sql: DATETIME_ADD(${TABLE}.RSPN_FLG_DT_TRAKR, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension_group: rspn_flg_trakr_gdt {
    view_label: "Case Info"
    group_label: "Last Response Flag Tracker Date Time (UTC)"
    group_item_label: "@{time_frames}"
    label: "Last Response Flag Tracker UTC"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "Datetime when the last response flag was triggered."
    sql: ${TABLE}.RSPN_FLG_DT_TRAKR ;;
  }

  dimension: on_hld_stt_tm_min {
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "Total On Hold Status Time (Mins)"
    label: "Total On Hold Status Time (Mins)"
    type: number
    description: "Duration from On-hold Start Date/Time to On-hold End Date/Time"
    sql: ${TABLE}.ON_HLD_STT_TM_MIN ;;
  }

  measure: average_of_on_hld_stt_tm_min_per_cs {
    view_label: " Measures"
    group_label: "Others"
    group_item_label: "Average On Hold Status Time per Case (Mins)"
    label: "Average On Hold Status Time per Case (Mins)"
    type: number
    description: "Average duration from On-hold Start Date/Time to On-hold End Date/Time per case."
    value_format_name: decimal_1
    sql: SUM(${on_hld_stt_tm_min})/${cs_no_vol} ;;
  }

  measure: average_of_on_hld_stt_tm_min_per_onhold_sts {
    view_label: " Measures"
    group_label: "Others"
    group_item_label: "Average On Hold Status Time per On Hold Occurrence (Mins)"
    label: "Average On Hold Status Time per On Hold Occurrence (Mins)"
    type: number
    description: "Average duration from On-hold Start Date/Time to On-hold End Date/Time per On Hold Occurrence"
    value_format_name: decimal_1
    sql: SUM(${on_hld_stt_tm_min})/SUM(${no_tm_cs_hld}) ;;
  }

  dimension: trns_rsn {
    hidden: no
    view_label: "Current Transfer"
    group_item_label: "Reason"
    label: "Current Transfer Reason"
  }

  dimension: trns_rsn_oth {
    hidden: no
    view_label: "Current Transfer"
    group_item_label: "Reason (Others)"
    label: "Current Transfer Reason (Others)"
  }

  dimension: esc_rsn {
    hidden: yes
    view_label: "Current Escalation"
    group_item_label: "Escalation Reason"
    label: "Current Escalation Reason"
  }

  dimension: acc_id {
    hidden: no
    view_label: "Customer Information"
    group_label: "Service"
    group_item_label: "Code"
    label: "Service Customer Code"
  }

  dimension: cntc_cust_nm {
    hidden: no
    view_label: "Customer Information"
    group_label: "Contract"
    group_item_label: "  Code"
    label: "Contract Customer Code"
  }

  dimension: cntc_id {
    hidden: yes
    view_label: "Customer Information"
    group_label: "Contact"
    group_item_label: "Contact Code"
    label: "Contact Name"
  }

  dimension: cntc_ec_urs_id {
    hidden: no
    view_label: "Case Info"
    group_item_label: "eComm ID"
    label: "eComm ID"
  }

  dimension: auto_tp {
    view_label: "Case Info"
    group_item_label: "Automation Type"
    label: "Automation Type"
    type: string
    sql: CASE WHEN ${chat_slf_svc_flg} = "Yes" THEN 'Self-Service' ELSE 'Others' END ;;
  }

  dimension: no_tm_cs_hld {
    hidden: no
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "No. of Time Case On-hold"
    label: "No. of Time Case On-hold"
  }

  dimension: count_of_qstn_intn_num {
    hidden: no
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "Number of Questions"
    label: "Number of Questions"
    type: number
    sql: ${TABLE}.COUNT_OF_QSTN_INTN_NUM ;;
  }

  dimension: with_bus_hrs_flg {
    hidden: no
    view_label: "Case Info"
    group_label: "Nature"
    group_item_label: "Is Within Business Hour (Yes/No)"
    label: "Is Within Business Hour"
  }

  dimension: cmplxt {
    hidden: no
    view_label: "Case Info"
    group_label: "Nature"
    group_item_label: "Complexity"
    label: "Complexity"
  }

  measure: not_nurtured_ratio {
    hidden: no
    view_label: " Measures"
    group_label: "Nurturing"
    group_item_label: "Not Nurtured Ratio"
    label: "Case Not Nutured Ratio"
  }

  measure: nurtured_ratio {
    hidden: no
    view_label: " Measures"
    group_label: "Nurturing"
    group_item_label: "Nurtured Ratio"
    label: "Case Nurtured Ratio"
  }

  measure: cntc_cust_ratio {
    hidden: no
    view_label: " Measures"
    group_label: "Others"
    group_item_label: "Contract Customer Ratio"
    label: "Contract Customer Ratio"
  }

  dimension: n1st_res_tm_min {
    hidden: no
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "First Response Time (Mins)"
    label: "Case FRT (Mins)"
  }

  ### PI4V2-22656: Combine Case & Chat FRT as Case/Chat FRT
  dimension: n1st_res_tm_min_cs_chat {
    view_label: " Measures"
    group_label: "FRT (Mins)"
    group_item_label: "Case/Chat FRT"
    label: "Case/Chat FRT (Mins)"
    type: number
    sql: CASE
        WHEN ${dmo_chat_tc_ext_epx.chat_n1st_res_dt_mns} <= ${n1st_res_tm_min}
        OR ${n1st_res_tm_min} is null THEN ${dmo_chat_tc_ext_epx.chat_n1st_res_dt_mns}
        ELSE ${n1st_res_tm_min}
        END;;
    value_format_name: decimal_1
  }

  dimension: avg_chat_n1st_res_tm_min {
    hidden: no
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "Average Chat First Response Time (Mins)"
    label: "Average Chat FRT (Mins)"
  }

  dimension: cs_hdl_tm_min {
    hidden: no
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "Case Handle Time (Mins)"
    label: "Case HT (Mins)"
  }

  dimension: cs_hdl_tm_ex_inter_min {
    hidden: no
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "Case Handle Time Excl Internal (Mins)"
    label: "Case HT Excl Internal (Mins)"
  }

  dimension: avg_chat_hdl_tm {
    hidden: no
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "Average Chat Handle Time (Mins)"
    label: "Average Chat HT (Mins)"
  }

  dimension: tt_trns {
    hidden: no
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "Total Transfer"
    label: "Case Total Transfer"
  }

  dimension: tt_esc {
    hidden: no
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "Total Escalation"
    label: "Case Total Escalation"
  }

  measure: cs_no_vol {
    hidden: no
    view_label: " Measures"
    group_label: "Volume"
    group_item_label: "Case"
    label: "Case Volume"
  }

  measure: sub_cat_l2_bkg_vol {
    hidden: no
    view_label: " Measures"
    group_label: "Volume"
    group_item_label: "Booking Management (L2)"
    label: "Booking Management (L2) Volume"
  }

  measure: sub_cat_l2_clm_vol {
    hidden: no
    view_label: " Measures"
    group_label: "Volume"
    group_item_label: "Claims (L2)"
    label: "Claims (L2) Volume"
  }

  measure: sub_cat_l2_dspt_vol {
    hidden: no
    view_label: " Measures"
    group_label: "Volume"
    group_item_label: "Disputes (L2)"
    label: "Disputes (L2) Volume"
  }

  measure: sub_cat_l2_exp_doc_vol {
    hidden: no
    view_label: " Measures"
    group_label: "Volume"
    group_item_label: "Export Documentation (L2)"
    label: "Export Documentation (L2) Volume"
  }

  measure: sub_cat_l2_imp_doc_vol {
    hidden: no
    view_label: " Measures"
    group_label: "Volume"
    group_item_label: "Import Documentation (L2)"
    label: "Import Documentation (L2) Volume"
  }

  measure: sub_cat_l2_imp_mng_vol {
    hidden: no
    view_label: " Measures"
    group_label: "Volume"
    group_item_label: "Import Management (L2)"
    label: "Import Management (L2) Volume"
  }

  measure: sub_cat_l2_invc_chrg_vol {
    hidden: no
    view_label: " Measures"
    group_label: "Volume"
    group_item_label: "Invoice & Charges (L2)"
    label: "Invoice & Charges (L2) Volume"
  }

  measure: sub_cat_l2_lst_fred_demr_dett_vol {
    hidden: no
    view_label: " Measures"
    group_label: "Volume"
    group_item_label: "Last FreeDay/ Demurrage & Detention (L2)"
    label: "Last FreeDay/ Demurrage & Detention (L2) Volume"
  }

  measure: avrg_cs_n1st_res_tm_min {
    hidden: no
    view_label: " Measures"
    group_label: "Customer Experience (CX) KPI"
    group_item_label: "Average Case First Response Time (Mins)"
    label: "Average Case FRT (Mins)"
  }

  measure: avrg_chat_n1st_res_tm_min {
    hidden: no
    view_label: " Measures"
    group_label: "Customer Experience (CX) KPI"
    group_item_label: "Average Chat First Response Time (Mins)"
    label: "Average Chat FRT (Mins)"
  }

  measure: avrg_cs_hdl_tm_min {
    hidden: no
    view_label: " Measures"
    group_label: "Standard Operating Metrics (SOM)"
    group_item_label: "Average Case Handle Time (Mins)"
    label: "Average Case HT (Mins)"
  }

  measure: avrg_chat_hdl_tm {
    hidden: no
    view_label: " Measures"
    group_label: "Handling Time"
    group_item_label: "Average Chat Handle Time (Mins)"
    label: "Average Chat HT (Mins)"
  }

  measure: avg_of_cs_acpt_tm_min {
    view_label: " Measures"
    group_label: "Others"
    group_item_label: "Acceptance Time (Mins)"
    label: "Average Case Acceptance Time (Mins)"
    type: average
    sql: ${cs_acpt_tm_min} ;;
    value_format_name: decimal_1
  }

  measure: avg_of_awt_cust_res_tm_mins {
    view_label: " Measures"
    group_label: "Response Time"
    group_item_label: "Awaiting Customer Response Time (Mins)"
    label: "Average Case Awaiting Customer Response Time (Mins)"
    type: average
    sql: ${awt_cust_res_tm_mins} ;;
    value_format_name: decimal_1
  }

  measure: avg_of_awt_inter_tm_tm_min {
    view_label: " Measures"
    group_label: "Handling Time"
    group_item_label: "Awaiting Internal Team Time (Mins)"
    label: "Average Case Awaiting Internal Team Time (Mins)"
    type: average
    sql: ${awt_inter_tm_tm_min} ;;
    value_format_name: decimal_1
  }

  # 90th Percentile AHT
  measure: 90th_cs_aht {
    view_label: " Measures"
    group_label: "Handling Time"
    label: "90th Percentile Case AHT (Mins)"
    type: number
    sql: APPROX_QUANTILES(${cs_hdl_tm_min},100)[OFFSET(90)] ;;
  }

  # AHT ratio
  ###---------- SR0374537: Remove Leave a Message ----------###
  measure: cs_aht_ratio {
    view_label: " Measures"
    group_label: "Handling Time"
    label: "Achieved Case AHT Ratio"
    type: average
    sql: CASE
              WHEN ${cs_hdl_tm_min} <= ${dmo_svc_kpi_trgts_aht.kpi_val} THEN 1
              WHEN ${cs_hdl_tm_min} > ${dmo_svc_kpi_trgts_aht.kpi_val} THEN 0 ELSE NULL END ;;
    filters: [cs_ori: "Web,Chat", cs_hdl_tm_min: "NOT NULL"]
    value_format_name: percent_0
  }

  measure: cht_aht_ratio {
    view_label: " Measures"
    group_label: "Handling Time"
    label: "Achieved Chat AHT Ratio"
    type: average
    sql: CASE
              WHEN ${avg_chat_hdl_tm} <= ${dmo_svc_kpi_trgts_aht.kpi_val} THEN 1
              WHEN ${avg_chat_hdl_tm} > ${dmo_svc_kpi_trgts_aht.kpi_val} THEN 0 ELSE NULL END ;;
    filters: [cs_ori: "Web,Chat", avg_chat_hdl_tm: "NOT NULL"]
    value_format_name: percent_0
  }

  # FRT ratio
  ###---------- SR0374537: Remove Leave a Message ----------###
  measure: cs_frt_ratio {
    view_label: " Measures"
    group_label: "Response Time"
    label: "Achieved Case FRT Ratio"
    type: average
    sql: CASE
              WHEN ${n1st_res_tm_min} <= ${dmo_svc_kpi_trgts_frt.kpi_val} THEN 1
              WHEN ${n1st_res_tm_min} > ${dmo_svc_kpi_trgts_frt.kpi_val} THEN 0 ELSE NULL END ;;
    filters: [cs_ori: "Web,Chat", n1st_res_tm_min: "NOT NULL"]
    value_format_name: percent_0
  }

  measure: cht_frt_ratio {
    view_label: " Measures"
    group_label: "Response Time"
    label: "Achieved Chat FRT Ratio"
    type: average
    sql: CASE
              WHEN ${avg_chat_n1st_res_tm_min} <= ${dmo_svc_kpi_trgts_frt.kpi_val} THEN 1
              WHEN ${avg_chat_n1st_res_tm_min} > ${dmo_svc_kpi_trgts_frt.kpi_val} THEN 0 ELSE NULL END ;;
    filters: [cs_ori: "Web,Chat", avg_chat_n1st_res_tm_min: "NOT NULL"]
    value_format_name: percent_0
  }
  #PI4V2-22656: Combine Case & Chat FRT as Case/Chat FRT test
  dimension: cs_cht_frt_ratio_num {
    hidden: yes
    view_label: " Measures"
    group_label: "Response Time"
    label: "Achieved Case/Chat FRT Number"
    type: number
    sql:
      CASE
      WHEN ${cs_ori_combine} IN ('Web', 'Chat')
           AND ${n1st_res_tm_min_cs_chat} IS NOT NULL
           AND ${n1st_res_tm_min_cs_chat} <= ${dmo_svc_kpi_trgts_combine_frt.kpi_val} THEN 1
      WHEN ${cs_ori_combine} IN ('Web', 'Chat')
           AND ${n1st_res_tm_min_cs_chat} IS NOT NULL
           AND ${n1st_res_tm_min_cs_chat} > ${dmo_svc_kpi_trgts_combine_frt.kpi_val} THEN 0
    END ;;
    # filters: [cs_ori_combine: "Web,Chat",n1st_res_tm_min_cs_chat: "NOT NULL"] # Apply filter on the combined FRT
  }

  measure: cs_cht_frt_ratio {
    view_label: " Measures"
    group_label: "Customer Experience (CX) KPI"
    label: "FRT Target Achievement Rate"
    type: number
    sql: SAFE_DIVIDE(COUNT(CASE WHEN ${frt_target_achvd} = "Yes" THEN 1 ELSE NULL END), NULLIF(COUNT(${frt_target_achvd}), 0));;
    value_format_name: percent_1
  }

  # dimension: frt_met_flag {
  #   label: "FRT Met Flag"
  #   type: number
  #   sql:
  #   CASE
  #     WHEN ${n1st_res_tm_min_cs_chat} <= ${dmo_svc_kpi_trgts_combine_frt.kpi_val} THEN 1
  #     WHEN ${n1st_res_tm_min_cs_chat} > ${dmo_svc_kpi_trgts_combine_frt.kpi_val} THEN 0
  #   END ;;
  # }

  # Escalation Ratio
  measure: esc_ratio {
    view_label: " Measures"
    group_label: "Standard Operating Metrics (SOM)"
    label: "Case Escalation Ratio"
    type: average
    sql: CASE WHEN ${tt_esc} > 0 THEN 1 ELSE 0 END;;
    value_format_name: percent_0
  }

  # CSAT Ratio
  measure: csat_ratio {
    view_label: " Measures"
    group_label: "Customer Experience (CX) KPI"
    label: "Case CIS"
    type: average
    sql: CASE WHEN ${cs_rtn} = 'Good' THEN 1
      WHEN ${cs_rtn} = 'Bad' THEN 0 ELSE NULL END ;;
    value_format_name: percent_0
  }

  # Deflection Ratio
  ###---------- SR0374537: Remove Leave a Message ----------###
  measure: defl_ratio {
    view_label: " Measures"
    group_label: "Standard Operating Metrics (SOM)"
    label: "Chat & Web Usage"
    type: average
    sql: CASE WHEN ${cs_ori} in ('Chat' , 'Web') THEN 1 ELSE 0 END ;;
    value_format_name: percent_0
  }

  ##### Additional dimensions &  measures ########
  dimension: is_own_by_que {
    view_label: "Case Info"
    group_label: "Nature"
    group_item_label: "Is Owned by Queue (Yes/No)"
    label: "Is Case Owned by Queue ?"
    type: string
    sql: CASE WHEN ${dmo_queue.dev_nm} is not null THEN 'Yes' ELSE 'No' END ;;
  }

  dimension: is_own_by_sys {
    view_label: "Case Info"
    group_label: "Nature"
    group_item_label: "Is Owned by System (Yes/No)"
    label: "Is Case Owned by System ?"
    type: string
    sql: CASE WHEN ${dmo_case_owner.usr_nm} = "Platform Integration User"
             OR ${dmo_case_owner.usr_nm} = "CRM System User"
             OR ${dmo_case_owner.usr_nm} = "Automated Process"
        THEN 'Yes' ELSE 'No' END ;;
  }

  dimension: cs_wht_cust_entered {
    view_label: "Case Info"
    group_item_label: "What Customer Entered"
    label: "Case What Customer Entered"
    type: string
    sql: CASE WHEN ${acc_id} is not null AND ${cntc_cust_nm} is not null THEN "Both"
             WHEN ${acc_id} is not null THEN "Service"
             WHEN ${cntc_cust_nm} is not null THEN "Contract"
        ELSE 'None' END ;;
  }

  dimension: cs_init_que_nm {
    view_label: "Case Info"
    group_item_label: "Initial Queue Name"
    label: "Case Initial Queue Name"
    type: string
    sql: ${init_que_nm} ;;
  }

  ### PI4V2-20379 ###
  dimension: merge_init_que_nm {
    view_label: "Case Info"
    group_item_label: "Earliest Case/Chat Queue"
    label: "Earliest Case/Chat Queue"
    type: string
    description: "The initial queue of cases or the initial queue of chat if the initial queue of cases is null."
    sql: CASE WHEN ${cs_init_que_nm} is null THEN ${dmo_chat_tc_1st.chat_n1_st_que_dtl}
              ELSE ${cs_init_que_nm} END ;;
  }

  #OF 3.0 - Dispute

  dimension: dspt_rmk {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Remarks"
    label: "Dispute Remarks"
  }

  dimension: dspt_tp {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Type"
    label: "Dispute Type"
  }

  dimension: dspt_rsn {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Reason"
    label: "Dispute Reason"
  }

  dimension: dspt_sub_rsn {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Sub-reason"
    label: "Dispute Sub-reason"
  }

  dimension: inv_amt {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Invoice Amount"
    label: "Invoice Amount"
  }

  dimension: tt_crrct_amt_auto_calc {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Total Correct Amount (Auto-calculated)"
    label: "Total Correct Amount (Auto-calculated)"
  }

  dimension: tt_dspt_amt_auto_calc {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Total Dispute Amount (Auto-calculated)"
    label: "Total Dispute Amount (Auto-calculated)"
  }

  dimension: inv_tp {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Invoice Type"
    label: "Invoice Type"
  }

  dimension: cust_ref_no {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Customer Reference No."
    label: "Customer Reference No."
  }

  dimension: bnd_tp {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Bound Type"
    label: "Bound Type"
  }

  dimension: dspt_curr {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Invoice Currency"
    label: "Dispute Invoice Currency"
  }

  dimension: inv_no {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Invoice Number"
    label: "Invoice Number"
  }

  dimension: sap_dspt_cs_id {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Case ID"
    label: "SAP Dispute Case ID"
  }

  dimension_group: dspt_cs_cre_sap_tms_tz {
    hidden: no
    view_label: "Dispute Info"
    group_label: "Dispute Case Created (TZ)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_case_v_ext_epx.dspt_cs_cre_sap_tms_tz_' | replace: '_',' ' | capitalize %} {% case timeframe %}
    {% when 'Time'%}01. Date Time
    {% when 'Hour of day'%}02. Hour of the Day
    {% when 'Date'%}03. Date
    {% when 'Week of year'%}04. Week of Year
    {% when 'Month num'%}05. Month
    {% when 'Quarter of year' %}06. Calendar Quarter
    {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
    {% when 'Year' %}08. Calendar Year
    {% when 'Fiscal year' %}09. Fiscal Year
    {% else %}{{ timeframe}}{% endcase %}"
    label: "Dispute Case Created in SAP Timestamp (TZ)"
  }

  dimension_group: dspt_cs_cre_sap_tms_utc {
    hidden: no
    view_label: "Dispute Info"
    group_label: "Dispute Case Created (UTC)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_case_v_ext_epx.dspt_cs_cre_sap_tms_utc_' | replace: '_',' ' | capitalize %} {% case timeframe %}
    {% when 'Time'%}01. Date Time
    {% when 'Hour of day'%}02. Hour of the Day
    {% when 'Date'%}03. Date
    {% when 'Week of year'%}04. Week of Year
    {% when 'Month num'%}05. Month
    {% when 'Quarter of year' %}06. Calendar Quarter
    {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
    {% when 'Year' %}08. Calendar Year
    {% when 'Fiscal year' %}09. Fiscal Year
    {% else %}{{ timeframe}}{% endcase %}"
    label: "Dispute Case Created in SAP Timestamp (UTC)"
  }

  ### PI4V2-24455 ####
  dimension_group: dspt_cs_cre_sap_tms_dt {
    view_label: "Dispute Info"
    group_label: "Dispute Case Created (Local)"
    group_item_label: "@{time_frames}"
    label: "Dispute Case Created in SAP Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: timestamp
    convert_tz: no
    sql: TIMESTAMP_ADD(${TABLE}.DSPT_CS_CRE_SAP_TMS, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension_group: dspt_cs_upd_sap_tms_dt {
    view_label: "Dispute Info"
    group_label: "Dispute Case Updated (Local)"
    group_item_label: "@{time_frames}"
    label: "Dispute Case Updated in SAP Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: timestamp
    convert_tz: no
    sql: TIMESTAMP_ADD(${TABLE}.DSPT_CS_UPD_SAP_TMS, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension: dspt_cs_not_cre_sap {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Not Created in SAP (Yes/No)"
    label: "Dispute Case Not Created in SAP?"
  }

  dimension: sap_sync_msg {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "SAP Sync Message"
    label: "Dispute SAP Sync Message"
  }

  dimension_group: dspt_cs_upd_sap_tms_tz {
    hidden: no
    view_label: "Dispute Info"
    group_label: "Dispute Case Updated (TZ)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_case_v_ext_epx.dspt_cs_upd_sap_tms_tz_' | replace: '_',' ' | capitalize %} {% case timeframe %}
    {% when 'Time'%}01. Date Time
    {% when 'Hour of day'%}02. Hour of the Day
    {% when 'Date'%}03. Date
    {% when 'Week of year'%}04. Week of Year
    {% when 'Month num'%}05. Month
    {% when 'Quarter of year' %}06. Calendar Quarter
    {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
    {% when 'Year' %}08. Calendar Year
    {% when 'Fiscal year' %}09. Fiscal Year
    {% else %}{{ timeframe}}{% endcase %}"
    label: "Dispute Case Updated in SAP Timestamp (TZ)"
  }

  dimension_group: dspt_cs_upd_sap_tms_utc {
    hidden: no
    view_label: "Dispute Info"
    group_label: "Dispute Case Updated (UTC)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_case_v_ext_epx.dspt_cs_upd_sap_tms_utc_' | replace: '_',' ' | capitalize %} {% case timeframe %}
    {% when 'Time'%}01. Date Time
    {% when 'Hour of day'%}02. Hour of the Day
    {% when 'Date'%}03. Date
    {% when 'Week of year'%}04. Week of Year
    {% when 'Month num'%}05. Month
    {% when 'Quarter of year' %}06. Calendar Quarter
    {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
    {% when 'Year' %}08. Calendar Year
    {% when 'Fiscal year' %}09. Fiscal Year
    {% else %}{{ timeframe}}{% endcase %}"
    label: "Dispute Case Updated in SAP Timestamp (UTC)"
  }

  dimension: dspt_cs_not_upd_sap {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Not Updated in SAP (Yes/No)"
    label: "Dispute Case Not Updated in SAP?"
  }

  dimension: dspt_tt_elps_days {
    hidden: no
    view_label: "Dispute Info"
    group_item_label: "Total Elapsed Days"
    label: "Dispute Total Elapsed Days"
    value_format_name: decimal_1
  }

  measure: avg_of_dspt_tt_elps_days {
    view_label: " Measures"
    group_label: "Others"
    group_item_label: "Total Elapsed Days"
    label: "Average Dispute Total Elapsed Days"
    type: average
    sql: ${dspt_tt_elps_days} ;;
    value_format_name: decimal_1
  }

  dimension: rsltn_rmrks {
    hidden: no
    view_label: "Case Info"
    group_label: "Resolution"
    group_item_label: "Remarks"
    label: "Case Resolution Remarks"
  }

  dimension: inv_dspt_cstn_prty {
    hidden: no
    view_label: "Dispute Info"
    group_label: "Causation"
    group_item_label: "Party"
    label: "Invoice Dispute Causation Party"
  }

  dimension: inv_dspt_cstn_rsn {
    hidden: no
    view_label: "Dispute Info"
    group_label: "Causation"
    group_item_label: "Reason"
    label: "Invoice Dispute Causation Reason"
  }

  dimension: inv_dspt_cstn_rmrks {
    hidden: no
    view_label: "Dispute Info"
    group_label: "Causation"
    group_item_label: "Remarks"
    label: "Invoice Dispute Causation Remarks"
  }

  #End of OF 3.0 - Dispute

  # Abandoned: PI4V2-22254

  measure: abdn_cases {
    view_label: " Measures"
    group_label: "Volume"
    group_item_label: "Abandoned Chat"
    label: "Abandoned Chat Volume"
    type: count_distinct
    sql: ${cs_no} ;;
    filters: [cs_ori: "Chat", resln_rsn_nw: "Customer Abandoned Chat"]
  }

  measure: abdnd_chat_ratio {
    view_label: " Measures"
    group_label: "Customer Experience (CX) KPI"
    group_item_label: "Abandoned Chat Ratio"
    label: "Abandoned Chat Ratio"
    type: average
    sql: CASE WHEN ${resln_rsn_nw} = 'Customer Abandoned Chat' THEN 1 ELSE 0 END ;;
    value_format_name: percent_1
    filters: [cs_ori: "Chat"]
  }

  # End of Abandoned

  # Ownership Info: PI4V2-21905

  dimension: lst_cs_owner {
    view_label: "Case Ownership"
    label: "Last Case Owner"
    type: string
    sql:  CASE WHEN ${is_own_by_que} = 'Yes' THEN 'Queue Owner' ELSE 'Case Owner' END ;;
  }

  dimension: owner_tp {
    view_label: "Case Ownership"
    label: "Ownership Type"
    type: string
    sql: CASE WHEN ${is_own_by_que} = 'Yes' THEN 'Queue'
              WHEN ${is_own_by_sys} = 'Yes' THEN 'System'
              ELSE 'Owner' END ;;
  }

  dimension: init_chat_cs_que_nm {
    view_label: "Case Ownership"
    label: "Initial Chat/Case Queue Name"
    type: string
    sql: CASE WHEN ${cs_ori} = 'Chat' THEN ${dmo_chat_tc_1st.chat_n1_st_que_dtl}
              ELSE ${cs_init_que_nm} END ;;
  }

  # End of Ownership Info

  ### PI4V2-23522 ###
  dimension: cs_res_func {
    view_label: "Case KPI"
    group_label: "Ownership"
    label: "Case Responsible Function"
    type: string
    sql: CASE WHEN ${sub_cat_l2} = "eCom Tech Support" THEN "Ecom" ELSE "Service" END ;;
  }

  dimension: frt_res_rl {
    view_label: "Case KPI"
    group_label: "First Response"
    label: "FRT Responsible Role"
    type: string
    sql: CASE WHEN ${dmo_case_his_owner_cnt.no_agnt_ownr} = 0 THEN "GHQ"
              WHEN ${dmo_chat_tc_ext_epx.hs_lv_mess_flg} = "Yes" AND ${dmo_chat_tc_ext_epx.is_wthn_bsnshr_chat} = "Yes" THEN "CCA/CSM"
              WHEN ${dmo_case_his_owner_cnt.no_agnt_ownr} > 0 THEN "CCA"
              WHEN ${dmo_case_his_owner_cnt.no_agnt_ownr} IS NULL THEN NULL
              ELSE "Error" END ;;
  }

  dimension: csat_res_rl {
    view_label: "Case KPI"
    group_label: "CIS"
    label: "CIS Responsible Role"
    type: string
    sql: CASE WHEN ${dmo_case_his_owner_cnt.no_agnt_ownr} = 0 THEN "GHQ"
              WHEN ${dmo_case_his_owner_cnt.no_agnt_ownr} = 1 THEN "CCA"
              WHEN ${dmo_case_his_owner_cnt.no_agnt_ownr} > 1 THEN "CSM"
              WHEN ${dmo_case_his_owner_cnt.no_agnt_ownr} IS NULL THEN NULL
              ELSE "Error" END ;;
  }

  ### PI4V2-24313 ###
  dimension: frt_st_pnt {
    view_label: "Case KPI"
    group_label: "First Response"
    group_item_label: "FRT Start Point"
    label: "FRT Start Point"
    type: string
    sql: CASE WHEN ${dmo_eml_msg_ct.frst_cust_gdt_raw} = ${dmo_chat_tc_ext_epx.chat_n1st_cust_msg_dt_raw} THEN "1st Customer Chat Msg"
              WHEN ${dmo_eml_msg_ct.frst_cust_gdt_raw} = ${dmo_chat_tc_ext_epx.ed_tm_gdt_raw} THEN "Chat Closed"
              WHEN ${dmo_eml_msg_ct.frst_cust_gdt_raw} = ${dmo_eml_msg_ct.frst_eml_rcvd_gdt_raw} THEN "1st Email Received"
              WHEN ${dmo_eml_msg_ct.frst_cust_gdt_raw} = ${cre_dt_utc_raw} THEN "Case Opened"
              ELSE NULL END;;
  }

  dimension: frt_ed_pnt {
    view_label: "Case KPI"
    group_label: "First Response"
    group_item_label: "FRT End Point"
    label: "FRT End Point"
    type: string
    sql: CASE WHEN ${dmo_eml_msg_ct.frst_rspnd_gdt_raw} = ${dmo_eml_msg_ct.frst_eml_to_cust_gdt_raw} THEN "1st Email to Customer"
              WHEN ${dmo_eml_msg_ct.frst_rspnd_gdt_raw} = ${dmo_chat_tc_ext_epx.chat_n1st_res_dt_raw} THEN "Chat Response"
              ELSE NULL END;;
  }

  dimension: frt_target_mns {
    view_label: "Case KPI"
    group_label: "First Response"
    group_item_label: "FRT Target (Mins)"
    label: "FRT Target (Mins)"
    type: number
    sql: CASE WHEN ${dmo_eml_msg_ct.frst_rspnd_dt_raw} IS NULL THEN NULL
              WHEN ${dmo_eml_msg_ct.frst_cust_dt_raw} IS NULL THEN NULL
              WHEN ${cs_ori} = "Chat" AND ${dmo_chat_tc_ext_epx.is_wthn_bsnshr_chat} = "Yes" THEN 0.5
              WHEN ${cs_ori} = "Web"
                OR (${dmo_chat_tc_ext_epx.is_wthn_bsnshr_chat} = "No" AND ${dmo_chat_tc_ext_epx.hs_lv_mess_flg} = "Yes") THEN 60
              WHEN ${cs_ori} = "Email" THEN 120
              ELSE NULL END;;
  }

  dimension: frt_target_achvd {
    view_label: "Case KPI"
    group_label: "First Response"
    group_item_label: "FRT Target Achieved"
    label: "FRT Target Achieved"
    type: string
    sql: CASE WHEN ${dmo_eml_msg_ct.frst_rspnd_dt_raw} IS NULL THEN NULL
              WHEN ${dmo_eml_msg_ct.frst_cust_dt_raw} IS NULL THEN NULL
              WHEN ${frt_target_mns} IS NULL THEN NULL
              WHEN ${dmo_eml_msg_ct.ovrl_frst_rsp_tm_dur}*1440 <= ${frt_target_mns} THEN "Yes"
              ELSE "No" END;;
  }

  dimension: is_authen_req {
    view_label: "Case KPI"
    group_item_label: "Is Authentication Required? (Yes/No)"
    label: "Is Authentication Required"
    type: string
    sql: CASE WHEN ${TABLE}.AUTHEN_REQ_FLG = 'true' THEN "Yes" ELSE "No" END;;
  }

  ### PI4V2-23956 + PI4V2-24978
  dimension: cnnt_agnt_wt_tm {
    view_label: " Measures"
    group_label: "Chat Transcript Info"
    group_item_label: "Connecting To Agent Wait Time (Sec)"
    label: "Connecting To Agent Wait Time (Sec)"
    type: number
    sql: DATETIME_DIFF(${dmo_chat_tc_ext_epx.agnt_n1st_acpt_dt_raw}, ${dmo_chat_tc_ext_epx.bot_init_trns_gdt_raw}, SECOND) ;;
  }

  measure: average_of_cnnt_agnt_wt_tm {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "Connecting To Agent Wait Time (hh:mm:ss)"
    label: "Connecting To Agent Wait Time (hh:mm:ss)"
    type: average
    sql: DATETIME_DIFF(${dmo_chat_tc_ext_epx.agnt_n1st_acpt_dt_raw}, ${dmo_chat_tc_ext_epx.bot_init_trns_gdt_raw}, SECOND)/86400 ;;
    value_format: "[hh]:mm:ss"
  }

  ### PI4V2-24978
  dimension: in_que_wt_tm {
    view_label: " Measures"
    group_label: "Chat Transcript Info"
    group_item_label: "In-Queue Wait Time (Sec)"
    label: "In-Queue Wait Time (Sec)"
    type: number
    sql: DATETIME_DIFF(CASE WHEN ${dmo_chat_tc_ext_epx.agnt_n1st_acpt_dt_raw} IS NULL THEN ${dmo_chat_tc_ext_epx.ed_tm_gdt_raw} ELSE ${dmo_chat_tc_ext_epx.agnt_n1st_acpt_dt_raw} END,${dmo_chat_tc_ext_epx.bot_init_trns_gdt_raw}, SECOND) ;;
  }

  measure: average_of_in_que_wt_tm {
    view_label: " Measures"
    group_label: "Duration"
    group_item_label: "In-Queue Wait Time (hh:mm:ss)"
    label: "In-Queue Wait Time (hh:mm:ss)"
    type: average
    sql: DATETIME_DIFF(CASE WHEN ${dmo_chat_tc_ext_epx.agnt_n1st_acpt_dt_raw} IS NULL THEN ${dmo_chat_tc_ext_epx.ed_tm_gdt_raw} ELSE ${dmo_chat_tc_ext_epx.agnt_n1st_acpt_dt_raw} END,${dmo_chat_tc_ext_epx.bot_init_trns_gdt_raw}, SECOND)/86400 ;;
    value_format: "[hh]:mm:ss"
  }

  dimension: agnt_reopen_case_rsn {
    view_label: "Case Info"
    group_label: "Reopen"
    group_item_label: "Agent Reopen Case Reason"
    label: "Agent Reopen Case Reason"
  }

  dimension: is_reopen_allwd {
    view_label: "Case Info"
    group_label: "Reopen"
    group_item_label: "Is Reopen Allowed (Yes/No)"
    label: "Is Reopen Allowed"
    sql: CASE WHEN ${reopen_allwd_flg} = "true" THEN "Yes" ELSE "No" END ;;
  }

  dimension: no_of_times_agn_rpn_clsd_case {
    view_label: "Case Info"
    group_label: "Reopen"
    group_item_label: "No. of Times Agent Reopen Closed Case"
    label: "No. of Times Agent Reopen Closed Case"
  }

  dimension: appld_mcr_nm {
    view_label: "Case Info"
    group_label: "Automation"
    group_item_label: "Applied Macro Name"
    label: "Applied Macro Name"
  }

  dimension: running_usr_for_mcr {
    view_label: "Case Info"
    group_label: "Automation"
    group_item_label: "Running User for Macro"
    label: "Running User for Macro"
  }

  dimension: is_case_auto_crt_frm_clsd_case {
    view_label: "Case Info"
    group_label: "Automation"
    group_item_label: "Is Case auto-create from Closed case (Yes/No)"
    label: "Is Case auto-create from Closed case"
    sql: CASE WHEN ${case_auto_crt_frm_clsd_case_flg} = "true" THEN "Yes" ELSE "No" END ;;
  }

  dimension: is_cc_auto_clsd {
    view_label: "Case Info"
    group_label: "Automation"
    group_item_label: "Is CC Auto Closed (Yes/No)"
    label: "Is CC Auto Closed"
    sql: CASE WHEN ${cc_auto_clsd_flg} = "true" THEN "Yes" ELSE "No" END ;;
  }

  dimension: is_cloned {
    view_label: "Case Info"
    group_label: "Automation"
    group_item_label: "Is Cloned (Yes/No)"
    label: "Is Cloned"
    sql: CASE WHEN ${cloned_flg} = "true" THEN "Yes" ELSE "No" END ;;
  }

  dimension: is_cls_cre {
    view_label: "Case Info"
    group_label: "Automation"
    group_item_label: "Is Closed When Created (Yes/No)"
    label: "Is Closed When Created"
    sql: CASE WHEN ${cls_cre_flg} = "true" THEN "Yes" ELSE "No" END ;;
  }

  dimension: is_instnt_cls {
    view_label: "Case Info"
    group_label: "Automation"
    group_item_label: "Is Instant Close (Yes/No)"
    label: "Is Instant Close"
    sql: CASE WHEN ${instnt_cls} = "true" THEN "Yes" ELSE "No" END ;;
  }

  dimension: case_agnt_qlt {
    view_label: "Case KPI"
    group_label: "CIS"
    group_item_label: "Case Agent Quality"
    label: "Case Agent Quality"
  }

  dimension: case_srvc_qlt {
    view_label: "Case KPI"
    group_label: "CIS"
    group_item_label: "Case Service Quality"
    label: "Case Service Quality"
  }

  dimension: case_sstm_qlt {
    view_label: "Case KPI"
    group_label: "CIS"
    group_item_label: "Case System Quality"
    label: "Case System Quality"
  }

  dimension: cht_bd_bfr_end {
    view_label: "Case Info"
    group_item_label: "Chat Body Before End"
    label: "Chat Body Before End"
  }

  dimension: intnt_self_srvc_tp {
    view_label: "Case Info"
    group_item_label: "Intent Self Service Type"
    label: "Intent Self Service Type"
  }

  dimension: req_tp {
    view_label: "Case Info"
    group_item_label: "Requestor Type"
    label: "Requestor Type"
  }

  dimension: respns_flg {
    view_label: "Case Info"
    group_item_label: "Response Flag"
    label: "Response Flag"
  }

  dimension: is_rsd_frm_web_frm {
    view_label: "Case Info"
    group_label: "Web"
    group_item_label: "Is Raised from Web Form (Yes/No)"
    label: "Is Raised from Web Form"
    sql: CASE WHEN ${rsd_frm_web_frm_flg} = "true" THEN "Yes" ELSE "No" END ;;
  }

  dimension: slf_srvc_case_clsr_rsn {
    view_label: "Case Info"
    group_label: "Web"
    group_item_label: "Web Self-Service Case Closure Reason"
    label: "Web Self-Service Case Closure Reason"
  }

  dimension: is_updt_by_cms_wb_frm {
    view_label: "Case Info"
    group_label: "Web"
    group_item_label: "Is Updated By CMS Web Form (Yes/No)"
    label: "Is Updated By CMS Web Form"
    sql: CASE WHEN ${updt_by_cms_wb_frm_flg} = "true" THEN "Yes" ELSE "No" END ;;
  }

  measure: percent_of_total_of_cs_no_vol {
    view_label: " Measures"
    group_label: "Volume"
    group_item_label: "Proportion of Case Vol (%)"
    label: "Proportion of Case Vol (%)"
    type: percent_of_total
    sql: ${cs_no_vol}  ;;
    # value_format: "0.0\%"
  }

}

view: dmc_period_ca_exp_cre_dt_utc {
  extends: [dmc_period]

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "Open Date (UTC)"
    group_item_label: "12. Week of Year (YYYY/WW)"
    label: "Case Open UTC Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "Open Date (UTC)"
    group_item_label: "13. Month (YYYY/MM)"
    label: "Case Open UTC Month (YYYY/MM)"
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "Open Date (UTC)"
    group_item_label: "14. Calendar Quarter (YYYY/QQ)"
    label: "Case Open UTC Calendar Quarter (YYYY/QQ)"
  }

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "Open Date (UTC)"
    group_item_label: "15. Fiscal Quarter (YYYY/QQ)"
    label: "Case Open UTC Fiscal Quarter (YYYY/QQ)"
  }
}

view: dmc_period_ca_exp_cre_dt_lc {
  extends: [dmc_period]

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "Open Date (Local)"
    group_item_label: "12. Week of Year (YYYY/WW)"
    label: "Case Open Local Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "Open Date (Local)"
    group_item_label: "13. Month (YYYY/MM)"
    label: "Case Open Local Month (YYYY/MM)"
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "Open Date (Local)"
    group_item_label: "14. Calendar Quarter (YYYY/QQ)"
    label: "Case Open Local Calendar Quarter (YYYY/QQ)"
  }

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "Open Date (Local)"
    group_item_label: "15. Fiscal Quarter (YYYY/QQ)"
    label: "Case Open Local Fiscal Quarter (YYYY/QQ)"
  }
}

view: dmc_period_ca_exp_cls_dt_utc {
  extends: [dmc_period]

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "Closed Date (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Case Closed UTC Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "Closed Date (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Case Closed UTC Month (YYYY/MM)"
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "Closed Date (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Case Closed UTC Calendar Quarter (YYYY/QQ)"
  }

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "Closed Date (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Case Closed UTC Fiscal Quarter (YYYY/QQ)"
  }
}

view: dmc_period_ca_exp_cls_dt_lc {
  extends: [dmc_period]

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "Closed Date (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Case Closed Local Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "Closed Date (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Case Closed Local Month (YYYY/MM)"
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "Closed Date (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Case Closed Local Calendar Quarter (YYYY/QQ)"
  }

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "Closed Date (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Case Closed Local Fiscal Quarter (YYYY/QQ)"
  }
}

view: dmc_period_n1st_res_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "First Response Date Time (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "First Response Local Fiscal Quarter (YYYY/QQ)"
    description: "First Response Date Time in Local Time Zone"
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "First Response Date Time (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "First Response Local Week of Year (YYYY/WW)"
    description: "First Response Date Time in Local Time Zone"
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "First Response Date Time (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "First Response Local Month (YYYY/MM)"
    description: "First Response Date Time in Local Time Zone"
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "First Response Date Time (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "First Response Local Calendar Quarter (YYYY/QQ)"
    description: "First Response Date Time in Local Time Zone"
  }

}

view: dmc_period_n1st_res_gdt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "First Response Date Time (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "First Response UTC Fiscal Quarter (YYYY/QQ)"
    description: "First Response Date Time in UTC"
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "First Response Date Time (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "First Response UTC Week of Year (YYYY/WW)"
    description: "First Response Date Time in UTC"
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "First Response Date Time (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "First Response UTC Month (YYYY/MM)"
    description: "First Response Date Time in UTC"
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "First Response Date Time (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "First Response UTC Calendar Quarter (YYYY/QQ)"
    description: "First Response Date Time in UTC"
  }

}

view: dmc_period_lst_rspn_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "Last Response Date Time (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Last Response Local Fiscal Quarter (YYYY/QQ)"
    description: "Last Response Date Time in Local Time Zone"
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "Last Response Date Time (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Last Response Local Week of Year (YYYY/WW)"
    description: "Last Response Date Time in Local Time Zone"
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "Last Response Date Time (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Last Response Local Month (YYYY/MM)"
    description: "Last Response Date Time in Local Time Zone"
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "Last Response Date Time (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Last Response Local Calendar Quarter (YYYY/QQ)"
    description: "Last Response Date Time in Local Time Zone"
  }

}

view: dmc_period_lst_rspn_gdt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "Last Response Date Time (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Last Response UTC Fiscal Quarter (YYYY/QQ)"
    description: "Last Response Date Time in UTC"
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "Last Response Date Time (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Last Response UTC Week of Year (YYYY/WW)"
    description: "Last Response Date Time in UTC"
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "Last Response Date Time (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Last Response UTC Month (YYYY/MM)"
    description: "Last Response Date Time in UTC"
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "Last Response Date Time (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Last Response UTC Calendar Quarter (YYYY/QQ)"
    description: "Last Response Date Time in UTC"
  }

}

view: dmc_period_frst_acpt_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "Agent First Work Accepted Datetime (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Agent First Work Accepted Local Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "Agent First Work Accepted Datetime (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Agent First Work Accepted Local Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "Agent First Work Accepted Datetime (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Agent First Work Accepted Local Month (YYYY/MM)"
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "Agent First Work Accepted Datetime (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Agent First Work Accepted Local Calendar Quarter (YYYY/QQ)"
  }

}

view: dmc_period_frst_acpt_gdt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "Agent First Work Accepted Datetime (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Agent First Work Accepted UTC Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "Agent First Work Accepted Datetime (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Agent First Work Accepted UTC Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "Agent First Work Accepted Datetime (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Agent First Work Accepted UTC Month (YYYY/MM)"
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "Agent First Work Accepted Datetime (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Agent First Work Accepted UTC Calendar Quarter (YYYY/QQ)"
  }

}

view: dmc_period_cs_in_prog_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "First In Progress Date Time (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "First In Progress Local Fiscal Quarter (YYYY/QQ)"
    description: "Datetime when the Case status is updated to \"In Progress\" for the first time."
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "First In Progress Date Time (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "First In Progress Local Week of Year (YYYY/WW)"
    description: "Datetime when the Case status is updated to \"In Progress\" for the first time."
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "First In Progress Date Time (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "First In Progress Local Month (YYYY/MM)"
    description: "Datetime when the Case status is updated to \"In Progress\" for the first time."
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "First In Progress Date Time (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "First In Progress Local Calendar Quarter (YYYY/QQ)"
    description: "Datetime when the Case status is updated to \"In Progress\" for the first time."
  }

}

view: dmc_period_cs_in_prog_gdt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "First In Progress Date Time (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "First In Progress UTC Fiscal Quarter (YYYY/QQ)"
    description: "Datetime when the Case status is updated to \"In Progress\" for the first time."
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "First In Progress Date Time (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "First In Progress UTC Week of Year (YYYY/WW)"
    description: "Datetime when the Case status is updated to \"In Progress\" for the first time."
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "First In Progress Date Time (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "First In Progress UTC Month (YYYY/MM)"
    description: "Datetime when the Case status is updated to \"In Progress\" for the first time."
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "First In Progress Date Time (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "First In Progress UTC Calendar Quarter (YYYY/QQ)"
    description: "Datetime when the Case status is updated to \"In Progress\" for the first time."
  }

}

view: dmc_period_nrtr_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "Nurture Date Time (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Nurture Local Fiscal Quarter (YYYY/QQ)"
    description: "Datetime when the Case has been nurtured."
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "Nurture Date Time (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Nurture Local Week of Year (YYYY/WW)"
    description: "Datetime when the Case has been nurtured."
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "Nurture Date Time (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Nurture Local Month (YYYY/MM)"
    description: "Datetime when the Case has been nurtured."
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "Nurture Date Time (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Nurture Local Calendar Quarter (YYYY/QQ)"
    description: "Datetime when the Case has been nurtured."
  }

}

view: dmc_period_nrtr_gdt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "Nurture Date Time (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Nurture UTC Fiscal Quarter (YYYY/QQ)"
    description: "Datetime when the Case has been nurtured."
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "Nurture Date Time (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Nurture UTC Week of Year (YYYY/WW)"
    description: "Datetime when the Case has been nurtured."
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "Nurture Date Time (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Nurture UTC Month (YYYY/MM)"
    description: "Datetime when the Case has been nurtured."
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "Nurture Date Time (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Nurture UTC Calendar Quarter (YYYY/QQ)"
    description: "Datetime when the Case has been nurtured."
  }

}

view: dmc_period_on_hld_st_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "First On-Hold Date Time (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "First On-Hold Local Fiscal Quarter (YYYY/QQ)"
    description: "Datetime when Case Status was put On Hold"
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "First On-Hold Date Time (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "First On-Hold Local Week of Year (YYYY/WW)"
    description: "Datetime when Case Status was put On Hold"
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "First On-Hold Date Time (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "First On-Hold Local Month (YYYY/MM)"
    description: "Datetime when Case Status was put On Hold"
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "First On-Hold Date Time (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "First On-Hold Local Calendar Quarter (YYYY/QQ)"
    description: "Datetime when Case Status was put On Hold"
  }

}

view: dmc_period_on_hld_st_gdt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "First On-Hold Date Time (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "First On-Hold UTC Fiscal Quarter (YYYY/QQ)"
    description: "Datetime when Case Status was put On Hold"
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "First On-Hold Date Time (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "First On-Hold UTC Week of Year (YYYY/WW)"
    description: "Datetime when Case Status was put On Hold"
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "First On-Hold Date Time (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "First On-Hold UTC Month (YYYY/MM)"
    description: "Datetime when Case Status was put On Hold"
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "First On-Hold Date Time (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "First On-Hold UTC Calendar Quarter (YYYY/QQ)"
    description: "Datetime when Case Status was put On Hold"
  }

}

view: dmc_period_on_hld_end_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "Last On-Hold Date Time (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Last On-Hold Local Fiscal Quarter (YYYY/QQ)"
    description: "Datetime when Case Status was updated back to In Progress from being On Hold."
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "Last On-Hold Date Time (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Last On-Hold Local Week of Year (YYYY/WW)"
    description: "Datetime when Case Status was updated back to In Progress from being On Hold."
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "Last On-Hold Date Time (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Last On-Hold Local Month (YYYY/MM)"
    description: "Datetime when Case Status was updated back to In Progress from being On Hold."
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "Last On-Hold Date Time (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Last On-Hold Local Calendar Quarter (YYYY/QQ)"
    description: "Datetime when Case Status was updated back to In Progress from being On Hold."
  }

}

view: dmc_period_on_hld_end_gdt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "Last On-Hold Date Time (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Last On-Hold UTC Fiscal Quarter (YYYY/QQ)"
    description: "Datetime when Case Status was updated back to In Progress from being On Hold."
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "Last On-Hold Date Time (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Last On-Hold UTC Week of Year (YYYY/WW)"
    description: "Datetime when Case Status was updated back to In Progress from being On Hold."
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "Last On-Hold Date Time (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Last On-Hold UTC Month (YYYY/MM)"
    description: "Datetime when Case Status was updated back to In Progress from being On Hold."
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "Last On-Hold Date Time (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Last On-Hold UTC Calendar Quarter (YYYY/QQ)"
    description: "Datetime when Case Status was updated back to In Progress from being On Hold."
  }

}

view: dmc_period_n1st_cs_rsolv_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "First Case Resolved Date Time (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "First Case Resolved Local Fiscal Quarter (YYYY/QQ)"
    description: "Datetime when the case is first updated to resolved status."
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "First Case Resolved Date Time (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "First Case Resolved Local Week of Year (YYYY/WW)"
    description: "Datetime when the case is first updated to resolved status."
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "First Case Resolved Date Time (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "First Case Resolved Local Month (YYYY/MM)"
    description: "Datetime when the case is first updated to resolved status."
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "First Case Resolved Date Time (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "First Case Resolved Local Calendar Quarter (YYYY/QQ)"
    description: "Datetime when the case is first updated to resolved status."
  }

}

view: dmc_period_n1st_cs_rsolv_gdt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "First Case Resolved Date Time (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "First Case Resolved UTC Fiscal Quarter (YYYY/QQ)"
    description: "Datetime when the case is first updated to resolved status."
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "First Case Resolved Date Time (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "First Case Resolved UTC Week of Year (YYYY/WW)"
    description: "Datetime when the case is first updated to resolved status."
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "First Case Resolved Date Time (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "First Case Resolved UTC Month (YYYY/MM)"
    description: "Datetime when the case is first updated to resolved status."
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "First Case Resolved Date Time (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "First Case Resolved UTC Calendar Quarter (YYYY/QQ)"
    description: "Datetime when the case is first updated to resolved status."
  }

}

view: dmc_period_rspn_flg_trakr_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "Last Response Flag Tracker Date Time (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Last Response Flag Tracker Local Fiscal Quarter (YYYY/QQ)"
    description: "Datetime when the last response flag was triggered."
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "Last Response Flag Tracker Date Time (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Last Response Flag Tracker Local Week of Year (YYYY/WW)"
    description: "Datetime when the last response flag was triggered."
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "Last Response Flag Tracker Date Time (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Last Response Flag Tracker Local Month (YYYY/MM)"
    description: "Datetime when the last response flag was triggered."
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "Last Response Flag Tracker Date Time (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Last Response Flag Tracker Local Calendar Quarter (YYYY/QQ)"
    description: "Datetime when the last response flag was triggered."
  }

}

view: dmc_period_rspn_flg_trakr_gdt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "Last Response Flag Tracker Date Time (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Last Response Flag Tracker UTC Fiscal Quarter (YYYY/QQ)"
    description: "Datetime when the last response flag was triggered."
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "Last Response Flag Tracker Date Time (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Last Response Flag Tracker UTC Week of Year (YYYY/WW)"
    description: "Datetime when the last response flag was triggered."
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "Last Response Flag Tracker Date Time (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Last Response Flag Tracker UTC Month (YYYY/MM)"
    description: "Datetime when the last response flag was triggered."
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "Last Response Flag Tracker Date Time (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Last Response Flag Tracker UTC Calendar Quarter (YYYY/QQ)"
    description: "Datetime when the last response flag was triggered."
  }

}

view: dmc_period_assg_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "First Assigned Date Time (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "First Assigned Local Fiscal Quarter (YYYY/QQ)"
    description: "This field is automatically set when a case gets assigned to a user and status is set to 'In Progress' for the first time."
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "First Assigned Date Time (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "First Assigned Local Week of Year (YYYY/WW)"
    description: "This field is automatically set when a case gets assigned to a user and status is set to 'In Progress' for the first time."
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "First Assigned Date Time (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "First Assigned Local Month (YYYY/MM)"
    description: "This field is automatically set when a case gets assigned to a user and status is set to 'In Progress' for the first time."
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "First Assigned Date Time (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "First Assigned Local Calendar Quarter (YYYY/QQ)"
    description: "This field is automatically set when a case gets assigned to a user and status is set to 'In Progress' for the first time."
  }

}

view: dmc_period_assg_gdt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case Info"
    group_label: "First Assigned Date Time (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "First Assigned UTC Fiscal Quarter (YYYY/QQ)"
    description: "This field is automatically set when a case gets assigned to a user and status is set to 'In Progress' for the first time."
  }

  dimension: iso_yrwk_desc {
    view_label: "Case Info"
    group_label: "First Assigned Date Time (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "First Assigned UTC Week of Year (YYYY/WW)"
    description: "This field is automatically set when a case gets assigned to a user and status is set to 'In Progress' for the first time."
  }

  dimension: yrmon_desc {
    view_label: "Case Info"
    group_label: "First Assigned Date Time (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "First Assigned UTC Month (YYYY/MM)"
    description: "This field is automatically set when a case gets assigned to a user and status is set to 'In Progress' for the first time."
  }

  dimension: yrqtr_desc {
    view_label: "Case Info"
    group_label: "First Assigned Date Time (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "First Assigned UTC Calendar Quarter (YYYY/QQ)"
    description: "This field is automatically set when a case gets assigned to a user and status is set to 'In Progress' for the first time."
  }

}

view: dmc_period_bot_init_trns_ldt_ca {
  extends: [dmc_period]

  dimension: iso_yrwk_desc {
    view_label: "Chat Transcript Info"
    group_label: "Bot Initiated Transfer Date (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Bot Initiated Transfer Local Week of Year (YYYY/WW)"
    description: "Bot Initiated Transfer timestamp refers to the time it starts to connect to an Agent."
  }

  dimension: yrmon_desc {
    view_label: "Chat Transcript Info"
    group_label: "Bot Initiated Transfer Date (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Bot Initiated Transfer Local Month (YYYY/MM)"
    description: "Bot Initiated Transfer timestamp refers to the time it starts to connect to an Agent."
  }

  dimension: yrqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Bot Initiated Transfer Date (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Bot Initiated Transfer Local Calendar Quarter (YYYY/QQ)"
    description: "Bot Initiated Transfer timestamp refers to the time it starts to connect to an Agent."
  }

  dimension: accqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Bot Initiated Transfer Date (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Bot Initiated Transfer Local Fiscal Quarter (YYYY/QQ)"
    description: "Bot Initiated Transfer timestamp refers to the time it starts to connect to an Agent."
  }
}

view: dmc_period_bot_init_trns_gdt_ca {
  extends: [dmc_period]

  dimension: iso_yrwk_desc {
    view_label: "Chat Transcript Info"
    group_label: "Bot Initiated Transfer Date (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Bot Initiated Transfer UTC Week of Year (YYYY/WW)"
    description: "Bot Initiated Transfer timestamp refers to the time it starts to connect to an Agent."
  }

  dimension: yrmon_desc {
    view_label: "Chat Transcript Info"
    group_label: "Bot Initiated Transfer Date (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Bot Initiated Transfer UTC Month (YYYY/MM)"
    description: "Bot Initiated Transfer timestamp refers to the time it starts to connect to an Agent."
  }

  dimension: yrqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Bot Initiated Transfer Date (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Bot Initiated Transfer UTC Calendar Quarter (YYYY/QQ)"
    description: "Bot Initiated Transfer timestamp refers to the time it starts to connect to an Agent."
  }

  dimension: accqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Bot Initiated Transfer Date (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Bot Initiated Transfer UTC Fiscal Quarter (YYYY/QQ)"
    description: "Bot Initiated Transfer timestamp refers to the time it starts to connect to an Agent."
  }
}


view: dmc_period_lst_ct_trns_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Last Chat Transferred Datetime (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Last Chat Transferred Local Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc {
    view_label: "Chat Transcript Info"
    group_label: "Last Chat Transferred Datetime (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Last Chat Transferred Local Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc {
    view_label: "Chat Transcript Info"
    group_label: "Last Chat Transferred Datetime (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Last Chat Transferred Local Month (YYYY/MM)"
  }

  dimension: yrqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Last Chat Transferred Datetime (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Last Chat Transferred Local Calendar Quarter (YYYY/QQ)"
  }

}

view: dmc_period_lst_ct_trns_gdt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Last Chat Transferred Datetime (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Last Chat Transferred UTC Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc {
    view_label: "Chat Transcript Info"
    group_label: "Last Chat Transferred Datetime (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Last Chat Transferred UTC Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc {
    view_label: "Chat Transcript Info"
    group_label: "Last Chat Transferred Datetime (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Last Chat Transferred UTC Month (YYYY/MM)"
  }

  dimension: yrqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Last Chat Transferred Datetime (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Last Chat Transferred UTC Calendar Quarter (YYYY/QQ)"
  }
}

view: dmc_period_1st_cs_trns_his_trns_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Case First Transfer"
    group_label: "Transfer Date (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "First Transfer Local Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc {
    view_label: "Case First Transfer"
    group_label: "Transfer Date (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "First Transfer Local Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc {
    view_label: "Case First Transfer"
    group_label: "Transfer Date (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "First Transfer Local Month (YYYY/MM)"
  }

  dimension: yrqtr_desc {
    view_label: "Case First Transfer"
    group_label: "Transfer Date (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "First Transfer Local Calendar Quarter (YYYY/QQ)"
  }
}

view: dmc_period_chat_auto_grt_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat Auto Greeting Date (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Chat Auto Greeting Fiscal Quarter (YYYY/QQ)"
    description: "Datetime of the first automated greeting sent to the customer when the chat is connected"
  }

  dimension: iso_yrwk_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat Auto Greeting Date (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Chat Auto Greeting Week of Year (YYYY/WW)"
    description: "Datetime of the first automated greeting sent to the customer when the chat is connected"
  }

  dimension: yrmon_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat Auto Greeting Date (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Chat Auto Greeting Month (YYYY/MM)"
    description: "Datetime of the first automated greeting sent to the customer when the chat is connected"
  }

  dimension: yrqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat Auto Greeting Date (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Chat Auto Greeting Calendar Quarter (YYYY/QQ)"
    description: "Datetime of the first automated greeting sent to the customer when the chat is connected"
  }
}

view: dmc_period_chat_n1st_cust_msg_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Customer Message Date (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Chat First Customer Message Fiscal Quarter (YYYY/QQ)"
    description: "Datetime of the customer's first message sent to a live agent"
  }

  dimension: iso_yrwk_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Customer Message Date (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Chat First Customer Message Week of Year (YYYY/WW)"
    description: "Datetime of the customer's first message sent to a live agent"
  }

  dimension: yrmon_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Customer Message Date (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Chat First Customer Message Month (YYYY/MM)"
    description: "Datetime of the customer's first message sent to a live agent"
  }

  dimension: yrqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Customer Message Date (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Chat First Customer Message Calendar Quarter (YYYY/QQ)"
    description: "Datetime of the customer's first message sent to a live agent"
  }
}

view: dmc_period_chat_n1st_res_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Response Date (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Chat First Response Fiscal Quarter (YYYY/QQ)"
    description: "Datetime of the agent's 1st reply to customer's 1st message"
  }

  dimension: iso_yrwk_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Response Date (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Chat First Response Week of Year (YYYY/WW)"
    description: "Datetime of the agent's 1st reply to customer's 1st message"
  }

  dimension: yrmon_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Response Date (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Chat First Response Month (YYYY/MM)"
    description: "Datetime of the agent's 1st reply to customer's 1st message"
  }

  dimension: yrqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Response Date (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Chat First Response Calendar Quarter (YYYY/QQ)"
    description: "Datetime of the agent's 1st reply to customer's 1st message"
  }
}

view: dmc_period_chat_n1st_res_gdt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Response Date (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Chat First Response Fiscal Quarter (YYYY/QQ)"
    description: "Datetime of the agent's 1st reply to customer's 1st message"
  }

  dimension: iso_yrwk_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Response Date (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Chat First Response Week of Year (YYYY/WW)"
    description: "Datetime of the agent's 1st reply to customer's 1st message"
  }

  dimension: yrmon_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Response Date (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Chat First Response Month (YYYY/MM)"
    description: "Datetime of the agent's 1st reply to customer's 1st message"
  }

  dimension: yrqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Response Date (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Chat First Response Calendar Quarter (YYYY/QQ)"
    description: "Datetime of the agent's 1st reply to customer's 1st message"
  }
}

view: dmc_period_chat_n1st_cust_msg_gdt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Customer Message Date (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Chat First Customer Message Fiscal Quarter (YYYY/QQ)"
    description: "Datetime of the customer's first message sent to a live agent"
  }

  dimension: iso_yrwk_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Customer Message Date (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Chat First Customer Message Week of Year (YYYY/WW)"
    description: "Datetime of the customer's first message sent to a live agent"
  }

  dimension: yrmon_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Customer Message Date (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Chat First Customer Message Month (YYYY/MM)"
    description: "Datetime of the customer's first message sent to a live agent"
  }

  dimension: yrqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat First Customer Message Date (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Chat First Customer Message Calendar Quarter (YYYY/QQ)"
    description: "Datetime of the customer's first message sent to a live agent"
  }
}

view: dmc_period_chat_auto_grt_gdt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat Auto Greeting Date (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Chat Auto Greeting Fiscal Quarter (YYYY/QQ)"
    description: "Datetime of the first automated greeting sent to the customer when the chat is connected"
  }

  dimension: iso_yrwk_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat Auto Greeting Date (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Chat Auto Greeting Week of Year (YYYY/WW)"
    description: "Datetime of the first automated greeting sent to the customer when the chat is connected"
  }

  dimension: yrmon_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat Auto Greeting Date (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Chat Auto Greeting Month (YYYY/MM)"
    description: "Datetime of the first automated greeting sent to the customer when the chat is connected"
  }

  dimension: yrqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Chat Auto Greeting Date (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Chat Auto Greeting Calendar Quarter (YYYY/QQ)"
    description: "Datetime of the first automated greeting sent to the customer when the chat is connected"
  }
}

view: dmc_period_ca_exp_acpt_tm_gdt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Accept Time (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Accept UTC Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc {
    view_label: "Chat Transcript Info"
    group_label: "Accept Time (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Accept UTC Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc {
    view_label: "Chat Transcript Info"
    group_label: "Accept Time (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Accept UTC Month (YYYY/MM)"
  }

  dimension: yrqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Accept Time (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Accept UTC Calendar Quarter (YYYY/QQ)"
  }

}

view: dmc_period_ca_exp_acpt_tm_dt {
  extends: [dmc_period]

  dimension: accqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Accept Time (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Accept Local Fiscal Quarter (YYYY/QQ)"
  }

  dimension: iso_yrwk_desc {
    view_label: "Chat Transcript Info"
    group_label: "Accept Time (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Accept Local Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc {
    view_label: "Chat Transcript Info"
    group_label: "Accept Time (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Accept Local Month (YYYY/MM)"
  }

  dimension: yrqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Accept Time (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Accept Local Calendar Quarter (YYYY/QQ)"
  }
}

view: dmc_period_agn_lst_msg_ldt {
  extends: [dmc_period]

  dimension: iso_yrwk_desc {
    view_label: "Chat Transcript Info"
    group_label: "Agent's Last Chat Message Datetime (Local)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Agent's Last Chat Message Datetime Local Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc {
    view_label: "Chat Transcript Info"
    group_label: "Agent's Last Chat Message Datetime (Local)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Agent's Last Chat Message Datetime Local Month (YYYY/MM)"
  }

  dimension: yrqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Agent's Last Chat Message Datetime (Local)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Agent's Last Chat Message Datetime Local Calendar Quarter (YYYY/QQ)"
  }

  dimension: accqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Agent's Last Chat Message Datetime (Local)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Agent's Last Chat Message Datetime Local Fiscal Quarter (YYYY/QQ)"
  }
}

view: dmc_period_agn_lst_msg_gdt {
  extends: [dmc_period]

  dimension: iso_yrwk_desc {
    view_label: "Chat Transcript Info"
    group_label: "Agent's Last Chat Message Datetime (UTC)"
    group_item_label: "11. Week of Year (YYYY/WW)"
    label: "Agent's Last Chat Message Datetime UTC Week of Year (YYYY/WW)"
  }

  dimension: yrmon_desc {
    view_label: "Chat Transcript Info"
    group_label: "Agent's Last Chat Message Datetime (UTC)"
    group_item_label: "12. Month (YYYY/MM)"
    label: "Agent's Last Chat Message Datetime UTC Month (YYYY/MM)"
  }

  dimension: yrqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Agent's Last Chat Message Datetime (UTC)"
    group_item_label: "13. Calendar Quarter (YYYY/QQ)"
    label: "Agent's Last Chat Message Datetime UTC Calendar Quarter (YYYY/QQ)"
  }

  dimension: accqtr_desc {
    view_label: "Chat Transcript Info"
    group_label: "Agent's Last Chat Message Datetime (UTC)"
    group_item_label: "14. Fiscal Quarter (YYYY/QQ)"
    label: "Agent's Last Chat Message Datetime UTC Fiscal Quarter (YYYY/QQ)"
  }
}

view: dmo_agn_wrk_ca {
  extends: [dmo_agn_wrk]

  dimension_group: frst_acpt_dt {
    view_label: "Case Info"
    group_label: "Agent First Work Accepted Datetime (Local)"
    group_item_label: "@{time_frames}"
    label: "Agent First Work Accepted Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: DATETIME_ADD(${TABLE}.FRST_ACPT_DT, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension_group: frst_acpt_gdt {
    view_label: "Case Info"
    group_label: "Agent First Work Accepted Datetime (UTC)"
    group_item_label: "@{time_frames}"
    label: "Agent First Work Accepted UTC"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.FRST_ACPT_DT ;;
  }


}

view: dmo_case_his_owner_cnt {
  derived_table: {
    sql:
        WITH SUB_CS_HIS AS
        (SELECT H.CS_ID, H.CRE_DT, H.OF_ID, H.NEW_VAL, H.OLD_VAL
              , CASE WHEN H.NEW_VAL LIKE "00G%" THEN NULL
                     WHEN LOWER(U.USR_NM) LIKE "%user%" OR LOWER(U.USR_NM) LIKE "%automated%" THEN NULL ELSE H.NEW_VAL END AGNT_OWNER_ID
              , CASE WHEN H.NEW_VAL LIKE "00G%" THEN NULL
                     WHEN LOWER(U.USR_NM) LIKE "%user%" OR LOWER(U.USR_NM) LIKE "%automated%" THEN NULL ELSE U.USR_NM END AGNT_OWNER_NM
         FROM `@{bq_project}@{bq_business}.DMO_CASE_HIS_V` H
         LEFT JOIN ${dmo_usr_que_owner_svc.SQL_TABLE_NAME} U
         ON H.NEW_VAL = U.OF_ID
         WHERE H.FLD = "Owner" AND SUBSTR(H.NEW_VAL,1,2) = "00" AND SUBSTR(H.OLD_VAL,1,2) = "00")
        , SUB_OWNER AS
        (SELECT H.CS_ID, H.CRE_DT, H.OF_ID, H.NEW_VAL, H.OLD_VAL, H.AGNT_OWNER_ID, H.AGNT_OWNER_NM
              , MAX(H.CRE_DT) OVER (PARTITION BY H.CS_ID) LST_TM
              , MIN(H.CRE_DT) OVER (PARTITION BY H.CS_ID) FRST_TM
        FROM SUB_CS_HIS H
        WHERE H.AGNT_OWNER_ID IS NOT NULL)
        SELECT H.CS_ID
               ,COUNT(DISTINCT H.AGNT_OWNER_ID) NO_AGNT_OWNR -- count owners exclude Bot/Queue
               ,STRING_AGG(DISTINCT H.AGNT_OWNER_NM, ", ") AGNT_OWNR
               ,STRING_AGG(CASE WHEN H.FRST_TM = H.CRE_DT THEN H.AGNT_OWNER_NM END, ", ") FRST_AGNT_OWNR
               ,STRING_AGG(CASE WHEN H.LST_TM = H.CRE_DT THEN H.AGNT_OWNER_NM END, ", ") LST_AGNT_OWNR
         FROM SUB_OWNER H
         GROUP BY 1
        ;;
  }

  measure: count {
    hidden: yes
    type: count
  }

  dimension: cs_id_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.CS_ID ;;
  }

  dimension: no_agnt_ownr {
    view_label: " Measures"
    group_label: "Case Info"
    group_item_label: "No. of Agent Owned"
    label: "No. of Agent Owned"
    type: number
    sql: ${TABLE}.NO_AGNT_OWNR ;;
  }

  ### PI4V2-23956 ###
  dimension: agnt_ownr {
    view_label: "Case Info"
    group_label: "Ownership"
    group_item_label: "List of Agents Owned"
    label: "List of Agents Owned"
    type: string
    sql: ${TABLE}.AGNT_OWNR ;;
  }

  dimension: frst_agnt_ownr {
    view_label: "Case Info"
    group_label: "Ownership"
    group_item_label: "1st Agent Owned"
    label: "1st Agent Owned"
    type: string
    sql: ${TABLE}.FRST_AGNT_OWNR ;;
  }

  dimension: lst_agnt_ownr {
    view_label: "Case Info"
    group_label: "Ownership"
    group_item_label: "Last Agent Owned"
    label: "Last Agent Owned"
    type: string
    sql: ${TABLE}.LST_AGNT_OWNR ;;
  }

}

view: dmo_cntc_svc {
  label: "Customer Information"

  derived_table: {
    sql:
        SELECT
          OF_ID,
          CUST_CNTC_NM,
          CUST_CNTC_EML
        FROM `@{bq_project}@{bq_business}.DMO_CNTC_V` ;;
  }

  dimension: of_id_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.OF_ID ;;
  }

  dimension: cust_cntc_nm {
    group_item_label: "Name"
    label: "Contact Name"
    type: string
    sql: ${TABLE}.CUST_CNTC_NM ;;
  }

  dimension: cust_cntc_eml {
    group_item_label: "Email"
    label: "Contact Email"
    type: string
    sql: ${TABLE}.CUST_CNTC_EML ;;
  }

  dimension: is_ONE_eml {
    group_item_label: "Is ONE Email (Yes/No)"
    label: "Is ONE Email ?"
    type: string
    sql: CASE WHEN ${TABLE}.CUST_CNTC_EML LIKE "%@one-line.com%" THEN 'Yes' ELSE 'No' END;;
  }

  measure: count {
    hidden: yes
    type: count
  }
}

view: dmo_chat_tc_ext_epx {
  extends: [dmo_chat_tc_lst]

  view_label: "Chat Transcript Info"

  dimension: ori_nm {
    hidden: no
    group_item_label: "Source"
    label: "Source of Chat"
  }

  dimension: hs_lv_mess_flg {
    hidden: no
    group_label: "Nature"
    group_item_label: "Is Message Left (Yes/No)"
    label: "Is Message Left ?"
  }

  dimension: chat_cs_rtng {
    hidden: no
    group_label: "Feedback"
    group_item_label: "01. Rating"
    label: "Chat Rating"
  }

  dimension: mrg_d_d_usd_flg {
    hidden: no
    group_item_label: "Merged D&D Used"
    label: "Merged D&D Used"
  }

  dimension: lft_usd_flg {
    hidden: no
    group_item_label: "LFD Used"
    label: "LFD Used"
  }

  dimension: ofc_cd {
    hidden: no
    group_label: "Origin"
    group_item_label: "01. Office Code"
    label: "Chat Office Code"
  }

  dimension: rhq_cd {
    hidden: no
    group_label: "Origin"
    group_item_label: "18. Office RHQ (Service)"
    label: "Chat Office RHQ (Service)"
    type: string
    description: "Historical case-level RHQ at the time the case was opened."
    sql: CASE WHEN ${cre_dt_date} < DATE(2024,04,01) THEN COALESCE(${dmc_ofc_hrc_ct.prvs_rhq_cd},${dmc_ofc_hrc_ct.rhq_cd},"Unclaimed")
              WHEN ${cre_dt_date} >= DATE(2024,04,01) THEN COALESCE(${dmc_ofc_hrc_ct.rhq_cd},"Unclaimed") END ;;
  }

  #SR0320143
  dimension: chat_n1_st_que_dtl {
    hidden: no
    group_item_label: "Initial Queue Name"
    label: "Chat Initial Queue Name"
  }

  dimension: chat_auto_tp {
    group_item_label: "Automation Type"
    label: "Chat Automation Type"
    type: string
    sql: CASE WHEN ${mrg_d_d_usd_flg} = 'true' then 'D&D'
              WHEN ${xch_rt_bot_dat_dp} = 'true' THEN 'ExR'
              WHEN ${lft_usd_flg} = 'true' then 'LFD'
              ELSE 'Others' END;;
  }

  # 90th Percentile AHT
  measure: 90th_cht_aht {
    view_label: " Measures"
    group_label: "Handling Time"
    label: "90th Percentile Chat AHT (Mins)"
    type: number
    sql: APPROX_QUANTILES(${chat_hdl_tm},100)[OFFSET(90)] ;;
  }

  measure: count {
    hidden: no
    view_label: " Measures"
    group_label: "Volume"
    group_item_label: "Chat"
    label: "Chat Volume"
  }

  # SRSR0337415
  # Is Within Business hours (Yes/No)
  dimension: wthn_bsnshr_chat_flg {
    hidden:  yes
    group_item_label: "Within Business Hour"
    label: "Chat Within Business Hour"
    type: string
    sql: ${TABLE}.WTHN_BSNSHR_CHAT_FLG ;;
  }

  dimension: is_wthn_bsnshr_chat {
    group_label: "Nature"
    group_item_label: "Is Within Business Hour (Yes/No)"
    label: "Is Chat Within Business Hour"
    type: string
    sql: CASE WHEN ${TABLE}.WTHN_BSNSHR_CHAT_FLG ='true' THEN "Yes" ELSE "No" END ;;
  }

  # Agent Chatting Time (Sec)
  dimension: agnt_chat_tm_sec {
    view_label: " Measures"
    group_label: "Chat Transcript Info"
    group_item_label: "Agent Chatting Time (Sec)"
    label: "Agent Chatting Time (Sec)"
    type: number
    description: "The total amount of time that it took an agent to chat with visitor."
    sql: ${TABLE}.AGNT_CHAT_TM_SEC ;;
  }

  ####SR0375910
  dimension_group: chat_auto_grt_dt {
    hidden: no
    # view_label: "Chat Transcript"
    group_label: "Chat Auto Greeting Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Chat Auto Greeting (UTC)"
    type: time
    description: "Datetime of the first automated greeting sent to the customer when the chat is connected"
    convert_tz: no
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    sql: ${TABLE}.CHAT_AUTO_GRT_DT_TM ;;
  }

  dimension_group: chat_auto_grt_dt_tm_lc {
    hidden: no
    # view_label: "Chat Transcript"
    group_label: "Chat Auto Greeting Date (Local)"
   group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_chat_tc_ext_epx.chat_auto_grt_dt_tm_lc_' | replace: '_',' ' | capitalize %}{% case timeframe %}
    {% when 'Time'%}01. Date Time
    {% when 'Hour of day'%}02. Hour of the Day
    {% when 'Date'%}03. Date
    {% when 'Day of week' %}04. Day of Week
    {% when 'Week of year'%}05. Week of Year
    {% when 'Month num'%}06. Month
    {% when 'Quarter of year' %}07. Calendar Quarter
    {% when 'Fiscal quarter of year' %}08. Fiscal Quarter
    {% when 'Year' %}09. Calendar Year
    {% when 'Fiscal year' %}10. Fiscal Year
    {% else %}{{ timeframe}}{% endcase %}"
    label: "Chat Auto Greeting (Local)"
    type: time
    description: "Datetime of the first automated greeting sent to the customer when the chat is connected"
    convert_tz: no
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    sql: DATETIME_ADD(${TABLE}.CHAT_AUTO_GRT_DT_TM, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension_group: chat_n1st_cust_msg_dt {
    hidden: no
    # view_label: "Chat Transcript"
    group_label: "Chat First Customer Message Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Chat First Customer Message (UTC)"
    type: time
    description: "Datetime of the customer's first message sent to a live agent"
    convert_tz: no
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    sql: ${TABLE}.CHAT_N1ST_CUST_MSG_DT_TM ;;
  }

  dimension_group: chat_n1st_cust_msg_dt_tm_lc {
    hidden: no
    # view_label: "Chat Transcript"
    group_label: "Chat First Customer Message Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_chat_tc_ext_epx.chat_n1st_cust_msg_dt_tm_lc_' | replace: '_',' ' | capitalize %} {% case timeframe %}
    {% when 'Time'%}01. Date Time
    {% when 'Hour of day'%}02. Hour of the Day
    {% when 'Date'%}03. Date
    {% when 'Day of week' %}04. Day of Week
    {% when 'Week of year'%}05. Week of Year
    {% when 'Month num'%}06. Month
    {% when 'Quarter of year' %}07. Calendar Quarter
    {% when 'Fiscal quarter of year' %}08. Fiscal Quarter
    {% when 'Year' %}09. Calendar Year
    {% when 'Fiscal year' %}10. Fiscal Year
    {% else %}{{ timeframe}}{% endcase %}"
    label: "Chat First Customer Message (Local)"
    type: time
    description: "Datetime of the customer's first message sent to a live agent"
    convert_tz: no
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    sql: DATETIME_ADD(${TABLE}.CHAT_N1ST_CUST_MSG_DT_TM, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension_group: chat_n1st_res_dt {
    hidden: no
    # view_label: "Chat Transcript"
    group_label: "Chat First Response Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Chat First Response (UTC)"
    type: time
    description: "Datetime of the agent's 1st reply to customer's 1st message"
    convert_tz: no
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    sql: ${TABLE}.CHAT_N1ST_RES_DT_TM ;;
  }

  dimension_group: chat_n1st_res_dt_tm_lc {
    hidden: no
    # view_label: "Chat Transcript"
    group_label: "Chat First Response Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_chat_tc_ext_epx.chat_n1st_res_dt_tm_lc_' | replace: '_',' ' | capitalize %} {% case timeframe %}
    {% when 'Time'%}01. Date Time
    {% when 'Hour of day'%}02. Hour of the Day
    {% when 'Date'%}03. Date
    {% when 'Day of week' %}04. Day of Week
    {% when 'Week of year'%}05. Week of Year
    {% when 'Month num'%}06. Month
    {% when 'Quarter of year' %}07. Calendar Quarter
    {% when 'Fiscal quarter of year' %}08. Fiscal Quarter
    {% when 'Year' %}09. Calendar Year
    {% when 'Fiscal year' %}10. Fiscal Year
    {% else %}{{ timeframe}}{% endcase %}"
    label: "Chat First Response (Local)"
    type: time
    description: "Datetime of the agent's 1st reply to customer's 1st message"
    convert_tz: no
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    sql: DATETIME_ADD(${TABLE}.CHAT_N1ST_RES_DT_TM, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }

  dimension: chat_n1st_res_dt_mns {
    hidden: yes
    view_label: " Measures"
    group_label: "Chat-Level"
    group_item_label: "First Response Time (Mins)"
    label: "Chat First Response Time (Mins)"
    type: number
    description: "The time an agent first response to a chat request."
    sql: ${TABLE}.CHAT_N1ST_RES_DT_MNS ;;
  }

  dimension: is_hdl_by_agt {
    hidden: yes
    group_item_label: "Is Handled By Agent"
    label: "Is Handled By Agent"
    type: string
    sql:  CASE WHEN ${agnt_n1st_acpt_dt_raw} IS NOT NULL OR ${agnt_acpt_n1st_trns_dt_raw} IS NOT NULL THEN "Yes" ELSE "No" END ;;
  }

  dimension: is_wthout_agt_rsp {
    group_label: "Nature"
    group_item_label: "Is Without Agent Response (Yes/No)"
    label: "Is Without Agent Response"
    type: string
    sql:  CASE WHEN ${is_hdl_by_agt} = "Yes" AND ${chat_n1st_res_dt_mns} is null THEN "Yes" ELSE "No" END;;
  }

  ### PI4V2-21622 ###

  dimension: tt_chat_trns {
    view_label: " Measures"
    group_label: "Chat Transcript Info"
    group_item_label: "Total Chat Transfer"
    label: "Total Chat Transfer"
    type: number
    description: "Count of Transferred Chat Cases"
    sql: ${TABLE}.TT_CHAT_TRNS ;;
  }

  ### PI4V2-23046 ###

  dimension: sts_nm {
    #view_label: "Chat Information"
    group_item_label: "Status"
    label: "Chat Status"
    description: "Completed or Missed. A missed chat was requested but not answered"
  }

  dimension: dat_src {
    #view_label: "Chat Information"
    group_item_label: "Data Source"
    label: "Data Source"
    type: string
    sql: ${TABLE}.DAT_SRC ;;
  }

  dimension: ed_by {
    #view_label: "Chat Information"
    group_item_label: "Ended By"
    label: "Chat Ended by "
    type: string
    description: "Indicates which party ended the chat"
    sql: ${TABLE}.ED_BY ;;
  }

  dimension_group: cre_dt {
    #view_label: "Chat Information"
    group_label: "Created Date (Local)"
    group_item_label: "@{time_frames}"
    label: "Chat Created (Local)"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: DATETIME_ADD(${TABLE}.CRE_DT, INTERVAL ${dmc_ofc_time_gmt_ct.gmt_hrs} MINUTE) ;;
  }

  dimension_group: cre_gdt {
    #view_label: "Chat Information"
    group_label: "Created Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Chat Created (UTC)"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.CRE_DT ;;
  }

  dimension: trns_tp {
    #view_label: "Chat Information"
    group_item_label: "Transfer Type"
    label: "Transfer Type"
    sql: ${TABLE}.TRNS_TP ;;
  }

  dimension: is_cntdwn {
    #view_label: "Chat Information"
    group_label: "Nature"
    group_item_label: "Is Countdown (Yes/No)"
    label: "Is Countdown"
    type: string
    description: "This flag is to indicate whether the Chat was closed by End Chat Timeout button."
    sql: CASE WHEN ${TABLE}.CNTDWN_FLG = 'true' THEN 'Yes' ELSE 'No' END;;
  }

  dimension_group: ed_tm_gdt {
    #view_label: "Chat Information"
    group_label: "End Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Chat End (UTC)"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.ED_TM ;;
  }

  dimension_group: ed_tm_dt {
    #view_label: "Chat Information"
    group_label: "End Date (Local)"
    group_item_label: "@{time_frames}"
    label: "Chat End (Local)"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: DATETIME_ADD(${TABLE}.ED_TM, INTERVAL ${dmc_ofc_time_gmt_ct.gmt_hrs} MINUTE);;
  }

  ### PI4V2-24769: Request to add local timestamps for Agent Accepted First Transfer Date
  dimension_group: agnt_acpt_n1st_trns_ldt {
    #view_label: "Chat Information"
    group_label: "Agent Accepted First Transfer Date (Local)"
    group_item_label: "@{time_frames}"
    label: "Agent Accepted First Transfer (Local)"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: DATETIME_ADD(${TABLE}.AGNT_ACPT_N1ST_TRNS, INTERVAL ${dmc_ofc_time_gmt_ct.gmt_hrs} MINUTE) ;;
  }

  dimension_group: agnt_acpt_n1st_trns_dt {
    #view_label: "Chat Information"
    group_label: "Agent Accepted First Transfer Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Agent Accepted First Transfer (UTC)"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.AGNT_ACPT_N1ST_TRNS ;;
  }

  ### PI4V2-24769: Request to add local timestamps for Agent First Accept Date
  dimension_group: agnt_n1st_acpt_ldt {
    #view_label: "Chat Information"
    group_label: "Agent First Accept Date (Local)"
    group_item_label: "@{time_frames}"
    label: "Agent First Accept (Local)"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: DATETIME_ADD(${TABLE}.AGNT_N1ST_ACPT_DT_TM, INTERVAL ${dmc_ofc_time_gmt_ct.gmt_hrs} MINUTE) ;;
  }

  dimension_group: agnt_n1st_acpt_dt {
    #view_label: "Chat Information"
    group_label: "Agent First Accept Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Agent First Accept (UTC)"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.AGNT_N1ST_ACPT_DT_TM ;;
  }

  dimension_group: bot_init_trns_ldt {
    #view_label: "Chat Information"
    group_label: "Bot Initiated Transfer Date (Local)"
    group_item_label: "@{time_frames}"
    label: "Bot Initiated Transfer Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "Bot Initiated Transfer timestamp refers to the time it starts to connect to an Agent."
    sql: DATETIME_ADD(${TABLE}.BOT_INIT_TRNS, INTERVAL ${dmc_ofc_time_gmt_ct.gmt_hrs} MINUTE) ;;
  }

  dimension_group: bot_init_trns_gdt {
    #view_label: "Chat Information"
    group_label: "Bot Initiated Transfer Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Bot Initiated Transfer UTC"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    description: "Bot Initiated Transfer timestamp refers to the time it starts to connect to an Agent."
    sql: ${TABLE}.BOT_INIT_TRNS ;;
  }

  ### PI4V2-24769: Add UTC/Local timestamps for Agent's Last Chat Message Datetime and Customer's Last Chat Message Datetime
  dimension_group: agn_lst_msg_ldt {
    #view_label: "Chat Information"
    group_label: "Agent's Last Chat Message Datetime (Local)"
    group_item_label: "@{time_frames}"
    label: "Agent's Last Chat Message Datetime Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: DATETIME_ADD(${TABLE}.AGN_LST_MSG_DT_TM, INTERVAL ${dmc_ofc_time_gmt_ct.gmt_hrs} MINUTE) ;;
  }

  dimension_group: agn_lst_msg_gdt {
    #view_label: "Chat Information"
    group_label: "Agent's Last Chat Message Datetime (UTC)"
    group_item_label: "@{time_frames}"
    label: "Agent's Last Chat Message Datetime UTC"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.AGN_LST_MSG_DT_TM ;;
  }

  dimension_group: cust_lst_msg_ldt {
    #view_label: "Chat Information"
    group_label: "Customer's Last Chat Message Datetime (Local)"
    group_item_label: "@{time_frames}"
    label: "Customer's Last Chat Message Datetime Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: DATETIME_ADD(${TABLE}.CUST_LST_MSG_DT_TM, INTERVAL ${dmc_ofc_time_gmt_ct.gmt_hrs} MINUTE) ;;
  }

  dimension_group: cust_lst_msg_gdt {
    #view_label: "Chat Information"
    group_label: "Customer's Last Chat Message Datetime (UTC)"
    group_item_label: "@{time_frames}"
    label: "Customer's Last Chat Message Datetime UTC"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.CUST_LST_MSG_DT_TM ;;
  }

  ### PI4V2-23522 ###
  dimension: ct_end_loc_nm {
    view_label: "Case KPI"
    group_label: "Abandonment"
    group_item_label: "Chat Ended Location"
    label: "Chat Ended Location"
    type: string
    sql: CASE WHEN ${bot_chat_tm_sec} IS NULL AND ${dmo_case_v_ext_epx.cs_no} IS NULL THEN "010. No Connection"
              WHEN ${dmo_case_v_ext_epx.cs_no} IS NULL THEN "020. Menu Navigation"
              WHEN ${dmo_case_v_ext_epx.cs_no} IS NOT NULL AND ${bot_init_trns_gdt_raw} IS NULL THEN "030. End of Intent Before Queuing"
              WHEN ${bot_init_trns_gdt_raw} IS NOT NULL AND ${agnt_n1st_acpt_dt_raw} IS NULL THEN "040. Queuing"
              WHEN ${agnt_n1st_acpt_dt_raw} IS NOT NULL AND (${chat_n1st_res_dt_raw} IS NULL OR ${chat_n1st_cust_msg_dt_raw} IS NULL) THEN "050. Start of Agent Chat"
              WHEN ${chat_n1st_cust_msg_dt_raw} IS NOT NULL AND ${chat_n1st_res_dt_raw} IS NOT NULL THEN "060. End of Agent Chat"
              ELSE "999. Others" END ;;
  }

  dimension: ct_end_loc_cd {
    view_label: "Case KPI"
    group_label: "Abandonment"
    group_item_label: "Chat Ended Location Code"
    label: "Chat Ended Location Code"
    type: number
    description: "The average time that it took an agent to respond to a chat visitor’s message"
    sql: CAST(SUBSTR(${ct_end_loc_nm},1,3) AS INT64) ;;
  }

  dimension: ct_end_rs_nm {
    view_label: "Case KPI"
    group_label: "Abandonment"
    group_item_label: "Chat Ended Reason"
    label: "Chat Ended Reason"
    type: string
    sql: CASE WHEN ${ed_by} = "System" THEN "System - Inactive/Error"
              WHEN ${dmo_case_v_ext_epx.cs_no} IS NULL THEN "Failed to Reach ONE Service"
              WHEN ${dmo_case_v_ext_epx.chat_slf_svc_flg} = "Yes" AND ${bot_init_trns_gdt_raw} IS NULL THEN "Self-Serviced"
              WHEN ${is_wthn_bsnshr_chat} = "No" AND ${agnt_n1st_acpt_dt_raw} IS NULL AND ${bot_init_trns_gdt_raw} IS NULL THEN "No Agent - Out of Biz Hrs"
              WHEN ${is_wthn_bsnshr_chat} = "Yes" AND ${agnt_n1st_acpt_dt_raw} IS NULL AND ${bot_init_trns_gdt_raw} IS NULL THEN "No Agent - During Biz Hrs"
              WHEN ${ct_end_loc_nm} = "040. Queuing" THEN "Stopped Queuing"
              WHEN ${is_cntdwn} = "Yes" OR ${ed_by} = "Bot" THEN "Customer Stopped Responding"
              WHEN ${chat_n1st_cust_msg_dt_raw} IS NULL AND ${agnt_n1st_acpt_dt_raw} IS NOT NULL THEN "No 1st Response From Customer"
              WHEN ${chat_n1st_cust_msg_dt_raw} IS NOT NULL AND ${chat_n1st_res_dt_raw} IS NULL THEN "No 1st Response From Agent"
              WHEN DATETIME_DIFF(${ed_tm_gdt_raw}, ${dmo_case_trns_n_escl_lst_trns_ct.lst_ct_trns_gdt_raw}, SECOND) < 60 THEN "Possibly Due to Transfer(s)"
              WHEN ${dmo_case_v_ext_epx.resln_rsn_nw} = "Customer Abandoned Chat" THEN "Agent-Judged Abandonment"
              ELSE "Others - Presumed Resolved" END ;;
  }

  dimension: ct_end_rs_grp {
    view_label: "Case KPI"
    group_label: "Abandonment"
    group_item_label: "Chat Ended Reason Group"
    label: "Chat Ended Reason Group"
    type: string
    sql: CASE WHEN ${ct_end_rs_nm} IN ("Failed to Reach ONE Service","No Agent - During Biz Hrs","No Agent - Out of Biz Hrs","Stopped Queuing","No 1st Response From Agent","Agent Stopped Responding","Possibly Due to Transfer(s)") THEN "Abandoned"
              WHEN ${ct_end_rs_nm} IN ("Customer Stopped Responding", "No 1st Response From Customer") THEN "Customer No Response"
              ELSE ${ct_end_rs_nm} END ;;
  }

  dimension: abdn_res_rl {
    view_label: "Case KPI"
    group_label: "Abandonment"
    group_item_label: "Abandonment Responsible Role"
    label: "Abandonment Responsible Role"
    type: string
    sql: CASE WHEN ${ct_end_rs_nm} IN ("No Agent - Out of Biz Hrs", "System - Inactive/Error", "Failed to Reach ONE Service") THEN "GHQ"
              WHEN ${ct_end_rs_nm} = "No Agent - During Biz Hrs" THEN "GHQ/CSM"
              WHEN  ${ct_end_rs_nm} = "Stopped Queuing" THEN "CSM"
              ELSE "CCA" END ;;
  }

  measure: count_of_abdn_ct_cs {
    view_label: " Measures"
    group_label: "Customer Experience (CX) KPI"
    group_item_label: "Count of Abandoned Chat Cases"
    label: "Count of Abandoned Chat Cases"
    type: count_distinct
    sql: ${dmo_case_v_ext_epx.cs_no} ;;
    filters: [ct_end_rs_grp: "Abandoned"]
  }

  measure: count_of_ct_cs {
    view_label: " Measures"
    group_label: "Customer Experience (CX) KPI"
    group_item_label: "Count of Chat Cases"
    label: "Count of Chat Cases"
    type: count_distinct
    sql: ${dmo_case_v_ext_epx.cs_no} ;;
    filters: [dmo_case_v_ext_epx.cs_ori: "Chat"]
  }

  measure: number_of_abdn_ct_cs_per_ct_cs {
    view_label: " Measures"
    group_label: "Customer Experience (CX) KPI"
    group_item_label: "Abandoned Chat Cases Rate"
    label: "Abandoned Chat Cases Rate"
    type: number
    sql: SAFE_DIVIDE(${count_of_abdn_ct_cs},${count_of_ct_cs}) ;;
    value_format_name: percent_1
  }

  dimension: avg_res_tm_opt {
    view_label: " Measures"
    group_label: "Chat Transcript Info"
    group_item_label: "Agent Average Response Time (Sec)"
    label: "Agent Average Response Time (Sec)"
    type: number
    description: "The average time that it took an agent to respond to a chat visitor’s message"
    sql: ${TABLE}.AVG_RES_TM_OPT ;;
  }

  dimension: avg_res_tm_vstr {
    view_label: " Measures"
    group_label: "Chat Transcript Info"
    group_item_label: "Visitor Average Response Time (Sec)"
    label: "Visitor Average Response Time (Sec)"
    type: number
    description: "The average time that it took a visitor to respond to an agent comment"
    sql: ${TABLE}.AVG_RES_TM_VSTR ;;
  }

  dimension: mx_res_tm_opt {
    view_label: " Measures"
    group_label: "Chat Transcript Info"
    group_item_label: "Agent Maximum Response Time (Sec)"
    label: "Agent Maximum Response Time (Sec)"
    type: number
    description: "The maximum time it took an agent to respond to a chat visitor’s message"
    sql: ${TABLE}.MX_RES_TM_OPT ;;
  }

  dimension: bot_chat_tm_sec {
    view_label: " Measures"
    group_label: "Chat Transcript Info"
    group_item_label: "BOT Chatting Time (Sec)"
    label: "BOT Chatting Time (Sec)"
    type: number
    description: "The total amount of time that it took a BOT to chat with visitor."
    sql: ${TABLE}.BOT_CHAT_TM_SEC ;;
  }

  dimension: vst_wt_tm {
    view_label: " Measures"
    group_label: "Chat Transcript Info"
    group_item_label: "Visitor Wait Time (Sec)"
    label: "Visitor Wait Time (Sec)"
    type: number
    description: "Sum of BOT Wait Time and Queue Wait Time. The total amount of time a visitor was waiting to connect to agent. "
    sql: COALESCE(${TABLE}.WT_TM,0) + COALESCE(${TABLE}.QUE_WT_TM,0) ;;
  }

  dimension: chat_hdl_tm_mins {
    view_label: " Measures"
    group_label: "Chat Transcript Info"
    group_item_label: "Handle Time (Mins)"
    label: "Chat Handle Time (Mins)"
    type: number
    description: "The total handling time of a chat request"
    sql: ${TABLE}.CHAT_HDL_TM ;;
  }

  dimension: ttl_clck_cntdwn {
    hidden: no
    view_label: " Measures"
    group_label: "Chat Transcript Info"
    group_item_label: "No of Countdown Clicked"
    label: "No of Countdown Clicked"
    description: "Number of time the Agent clicked on \"Send Timeout\" button"
  }

  dimension: opt_mess_cnt {
    view_label: " Measures"
    group_label: "Chat Transcript Info"
    group_item_label: "Count of Agent Messages"
    label: "Count of Agent Messages"
    type: number
    description: "The number of messages an agent sent during the chat"
    sql: ${TABLE}.OPT_MESS_CNT ;;
  }

  dimension: vstr_mes_cnt {
    view_label: " Measures"
    group_label: "Chat Transcript Info"
    group_item_label: "Count of Visitor Messages"
    label: "Count of Visitor Messages"
    type: number
    description: "The number of messages a visitor sent during the chat"
    sql: ${TABLE}.VSTR_MES_CNT ;;
  }


  ### PI4V2-23956 ###
  dimension_group: acpt_tm_gdt {
    view_label: "Chat Transcript Info"
    group_label: "Accept Time (UTC)"
    group_item_label: "@{time_frames}"
    label: "Accept UTC"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.ACPT_TM ;;
  }

  dimension_group: acpt_tm_dt {
    view_label: "Chat Transcript Info"
    group_label: "Accept Time (Local)"
    group_item_label: "@{time_frames}"
    label: "Accept Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: DATETIME_ADD(${TABLE}.ACPT_TM, INTERVAL ${dmc_ofc_time_gmt_ct.gmt_hrs} MINUTE) ;;
  }

  dimension: chat_svey_cmt {
    view_label: "Chat Transcript Info"
    label: "Chat Survey Comment"
  }

  dimension: cms_sso_sts {
    view_label: "Chat Transcript Info"
    group_label: "Automation"
    group_item_label: "CMS SSO Status"
    label: "CMS SSO Status"
  }

  dimension: ct_nm {
    view_label: "Chat Transcript Info"
    group_item_label: "Transcript Name"
    label: "Transcript Name"
  }

  dimension: dnd_lgn_vrf_sts {
    view_label: "Chat Transcript Info"
    group_label: "Automation"
    group_item_label: "DND Login Verify status"
    label: "DND Login Verify status"
  }

  dimension: end_usr_lang {
    view_label: "Chat Transcript Info"
    group_item_label: "End User Language"
    label: "End User Language"
  }

  dimension: is_inact_chat {
    view_label: "Chat Transcript Info"
    group_item_label: "Is Inactive Chat (Yes/No)"
    label: "Is Inactive Chat"
    sql: CASE WHEN ${inact_chat} = "true" THEN "Yes"
              WHEN ${inact_chat} = "false" THEN "No"
              ELSE ${inact_chat} END ;;
  }

  dimension: inq_tp {
    view_label: "Chat Transcript Info"
    group_item_label: "Inquiry Type"
    label: "Inquiry Type"
  }

  dimension: mrg_d_d_clck {
    view_label: "Chat Transcript Info"
    group_label: "Automation"
    group_item_label: "Merged D&D Clicked"
    label: "Merged D&D Clicked"
  }

  dimension: mrg_d_d_trns {
    view_label: "Chat Transcript Info"
    group_label: "Automation"
    group_item_label: "Merged D&D Transferred"
    label: "Merged D&D Transferred"
  }

  dimension: is_rerou_bot {
    view_label: "Chat Transcript Info"
    group_label: "Automation"
    group_item_label: "Is Reroute to Bot? (Yes/No)"
    label: "Is Reroute to Bot?"
    sql: CASE WHEN ${rerou_bot_flg} = "true" THEN "Yes"
              WHEN ${rerou_bot_flg} = "false" THEN "No"
              ELSE ${rerou_bot_flg} END ;;
  }


  dimension: xch_rt_bot_aply_clck {
    view_label: "Chat Transcript Info"
    group_label: "Automation"
    group_item_label: "Exchange Rate Bot Apply Clicks"
    label: "Exchange Rate Bot Apply Clicks"
  }

  dimension: xch_rt_bot_dat_dp {
    hidden: no
    view_label: "Chat Transcript Info"
    group_label: "Automation"
    group_item_label: "Exchange Rate Bot Data Display"
    label: "Exchange Rate Bot Data Display"
  }

}

view: dmo_case_trns_n_escl_lst_trns_ct {
  ### PI4V2-23522 ###
  derived_table: {
    sql:
    SELECT CS_ID, MAX(TRNS_N_ESCL_DT_TM) LST_TRNS_DT
    FROM ${dmo_case_trns_n_escl_his.SQL_TABLE_NAME}
    WHERE TRNS_N_ESCL_TP = "Accept/Transfer Chat"
    GROUP BY 1;;
  }

  dimension: cs_id_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.CS_ID ;;
  }

  measure: count {
    hidden: yes
    type: count
  }

  dimension_group: lst_ct_trns_gdt {
    view_label: "Chat Transcript Info"
    group_label: "Last Chat Transferred Datetime (UTC)"
    group_item_label: "@{time_frames}"
    label: "Last Chat Transferred UTC"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.LST_TRNS_DT ;;
  }

  dimension_group: lst_ct_trns_dt {
    view_label: "Chat Transcript Info"
    group_label: "Last Chat Transferred Datetime (Local)"
    group_item_label: "@{time_frames}"
    label: "Last Chat Transferred Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: DATETIME_ADD(${TABLE}.LST_TRNS_DT, INTERVAL ${dmc_ofc_time_gmt_ct.gmt_hrs} MINUTE) ;;
  }

}

view: dmo_1st_case_trns_his_epx {
  extends: [dmo_1st_case_trns_his]

  dimension: trns_tp {
    hidden: no
    view_label: "Case First Transfer"
    group_item_label: "Type"
    label: "First Transfer Type"
  }

  dimension: trns_rsn {
    hidden: no
    view_label: "Case First Transfer"
    group_item_label: "Reason"
    label: "First Transfer Reason"
  }

  #SR0351491
  dimension: trf_his_nm {
    hidden: no
    view_label: "Case First Transfer"
    group_item_label: "Transfer Name"
    label: "First Transfer Name"
  }

  # dimension_group: trns_dt_tm_tz {
  #   hidden: no
  #   view_label: "Case First Transfer"
  #   group_label: "Transfer Date (TZ)"
  #   group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_1st_case_trns_his_epx.trns_dt_tm_tz_' | replace: '_',' ' | capitalize %} {% case timeframe %}
  #   {% when 'Time'%}01. Date Time
  #   {% when 'Hour of day'%}02. Hour of the Day
  #   {% when 'Date'%}03. Date
  #   {% when 'Week of year'%}04. Week of Year
  #   {% when 'Month num'%}05. Month
  #   {% when 'Quarter of year' %}06. Calendar Quarter
  #   {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
  #   {% when 'Year' %}08. Calendar Year
  #   {% when 'Fiscal year' %}09. Fiscal Year
  #   {% else %}{{ timeframe}}{% endcase %}"
  #   label: "First Transfer Date (TZ)"
  #   # We would like to keep convert_tz: yes due to business requirement
  #   convert_tz: yes
  # }

  dimension_group: trns_dt_tm_utc {
    hidden: no
    view_label: "Case First Transfer"
    group_label: "Transfer Date (UTC)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'dmo_1st_case_trns_his_epx.trns_dt_tm_utc_' | replace: '_',' ' | capitalize %} {% case timeframe %}
    {% when 'Time'%}01. Date Time
    {% when 'Hour of day'%}02. Hour of the Day
    {% when 'Date'%}03. Date
    {% when 'Week of year'%}04. Week of Year
    {% when 'Month num'%}05. Month
    {% when 'Quarter of year' %}06. Calendar Quarter
    {% when 'Fiscal quarter of year' %}07. Fiscal Quarter
    {% when 'Year' %}08. Calendar Year
    {% when 'Fiscal year' %}09. Fiscal Year
    {% else %}{{ timeframe}}{% endcase %}"
    label: "First Transfer Date (UTC)"
  }

  ### PI4V2-24455 ####
  dimension_group: trns_dt {
    view_label: "Case First Transfer"
    group_label: "Transfer Date (Local)"
    group_item_label: "@{time_frames}"
    label: "First Transfer Local"
    type: time
    timeframes:
    [raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week_of_year,
      month_num,
      quarter_of_year,
      fiscal_quarter_of_year,
      year,
      fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: DATETIME_ADD(${TABLE}.trns_dt_tm, INTERVAL ${dmc_ofc_time_gmt.gmt_hrs} MINUTE) ;;
  }
}


view: dmo_case_cmt {
  derived_table: {
    sql:
    SELECT
      CS_PRNT_ID,
      CMTS AS LST_CMTS
    FROM
      (
      SELECT
        CS_PRNT_ID,
        CRE_DT,
        ROW_NUMBER() OVER (PARTITION BY CS_PRNT_ID ORDER BY CRE_DT DESC) AS RowNum,
        CMTS
      FROM `@{bq_project}@{bq_business}.DMO_CASE_CMT_V`
      WHERE CS_PRNT_ID IS NOT NULL
      )
    WHERE RowNum = 1
    ;;
  }

  dimension: cs_prnt_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.CS_PRNT_ID ;;
  }

  dimension: lst_cmts {
    hidden: no
    group_item_label: "Latest Case Comments"
    label: "Latest Case Comments"
    type: string
    sql: ${TABLE}.LST_CMTS ;;
  }

  measure: count {
    hidden: yes
    type: count
  }

}
