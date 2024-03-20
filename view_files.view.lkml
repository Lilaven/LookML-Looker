

view: user_count_n_login_hist {
  derived_table: {
    sql: WITH month_master as (
      SELECT
       Sales_Month as Calendar_Month
      ,Calendar_Quarter
      ,Calendar_Year
      ,parse_date('%Y%m', Sales_Month ) mth_start_date
      ,date_sub( date_add( parse_date('%Y%m', Sales_Month ),interval 1 month), interval 1 day)  mth_end_date
      ,CASE WHEN format_date('%Y%m', current_date() ) = Sales_Month THEN 'Current Month'
            WHEN Sales_Month between format_date('%Y%m', date_sub( date_trunc(current_date(),month), interval 3 month) ) and format_date('%Y%m', date_sub( date_trunc(current_date(),month), interval 1 month) ) THEN 'Last 3 complete months'
            ELSE 'Others' END as month_selection
      ,CASE WHEN format_date('%Y%m', current_date() ) = Sales_Month THEN 1 ELSE 0 END as program_control_current_month
      ,CASE WHEN format_date('%Y%m', date_sub( date_trunc(current_date(),month), interval 1 month) ) = Sales_Month THEN 'Yes' ELSE 'No' END as is_last_mth
      from `ONEFORCE.OF_SALES_WEEK_MASTER` w
      where parse_date('%Y%m', Sales_Month )  >= DATE_TRUNC( IFNULL( {% date_start date_filter %}, DATE '2000-01-01'), MONTH )
      and   date_sub( date_add( parse_date('%Y%m', Sales_Month ),interval 1 month), interval 1 day) <= LAST_DAY( DATE_SUB(IFNULL( {% date_end date_filter %}, DATE '2100-01-01' ), INTERVAL 1 DAY), MONTH )
      group by 1, 2, 3 )
      SELECT mth.Calendar_Month, mth.Calendar_Quarter, mth.Calendar_Year, mth.month_selection, mth.program_control_current_month, mth.is_last_mth,
             usr.ONEForce_Id as UserId, usr.Username, usr.IsActive, usr.CreatedDate as Usr_CreatedDate, usr.LastModifiedDate as Usr_LastModifiedDate,
             usrlastlogon.EverRecordedLastLogon,
             (CASE WHEN hist.UserId is null THEN usr.ONEForce_Id ELSE NULL END) as Not_Logged_UserId,
             hist.UserId Login_UserId, hist.Application, hist.LoginTime, hist.LoginType, hist.LoginUrl,
             usr.country as UserCountry,
             EXTRACT( YEAR from hist.LoginTime) ||'-'|| FORMAT("%02d", EXTRACT( WEEK from hist.LoginTime)) ||' '|| FORMAT_DATE( '%h %d', DATE_TRUNC ( hist.LoginTime, WEEK) ) ||'-'|| FORMAT_DATE( '%h %d', DATE_ADD ( DATE_TRUNC ( hist.LoginTime, WEEK), INTERVAL 6 DAY) ) LoginWeek
      FROM month_master as mth
      LEFT JOIN ${of_user.SQL_TABLE_NAME} as usr on (  EXTRACT(DATE from usr.CreatedDate) <= Mth_End_date  AND
                                                       EXTRACT(DATE from usr.CreatedDate) <= DATE_SUB( IFNULL( {% date_end date_filter %}, DATE '2100-01-01' ), INTERVAL 1 DAY)  AND
                                               ( ( usr.IsActive = 'true' ) OR
                                                 ( usr.IsActive = 'false'
                                                   and EXTRACT(DATE from usr.LastModifiedDate) >= Mth_Start_date
                                                   and EXTRACT(DATE from usr.LastModifiedDate) >= DATE_SUB(IFNULL( {% date_end date_filter %}, DATE '2100-01-01' ), INTERVAL 1 DAY)
                                                 )
                                               )
                                             )
      LEFT JOIN (SELECT UserId , max(LoginTime) EverRecordedLastLogon FROM  `ONEFORCE.OF_USER_LOGIN_HISTORY`
                 GROUP by UserId ) usrlastlogon  on (usr.ONEForce_ID  = usrlastlogon.UserId )
      LEFT JOIN `ONEFORCE.OF_USER_LOGIN_HISTORY` hist on ( usr.ONEForce_ID  = hist.UserId  AND
                                                           DATE(hist.Year,hist.Month,hist.Day) BETWEEN mth_start_date and mth_end_date AND
                                                           DATE(hist.Year,hist.Month,hist.Day) BETWEEN IFNULL( {% date_start date_filter %}, DATE '2000-01-01') and
                                                                                                       DATE_SUB( IFNULL( {% date_end date_filter %}, DATE '2100-01-01' ), INTERVAL 1 DAY)
                                                         )
      --WHERE mth.Calendar_Month in ('202112' )
      --and usr.country in ('CA','BE','TW','UK','AU','BR')
      --limit 50
       ;;
  }

#  parameter: param_month_from {
#    label: "Param Month From"
#    type: string
#    allowed_value: { value: "202112" }
#    allowed_value: { value: "202201" }
#    allowed_value: { value: "202202" }
#    allowed_value: { value: "202203" }
#    default_value: "202202"
#  }

  #parameter: param_month_to {
  #  label: "Param Month To"
  #  type: string
  #  allowed_value: { value: "202112" }
  #  allowed_value: { value: "202201" }
  #  allowed_value: { value: "202202" }
  #  allowed_value: { value: "202203" }
  #  default_value: "202203"
  #}

  #measure: count {
  #  type: count
  #  drill_fields: [detail*]
  #}

  filter: date_filter {
    datatype: date
    type: date
  }

  measure: count_login {
    label: "Login Count"
    type: count_distinct
    sql: ${TABLE}.LoginTime ;;
  }

  measure: login_time_min {
    label: "First Login Time"
    sql: FORMAT_DATETIME( "%F %T", MIN(${TABLE}.LoginTime) ) ;;
  }

  measure: login_time_max {
    label: "Last Login Time"
    sql: FORMAT_DATETIME( "%F %T", MAX(${TABLE}.LoginTime) ) ;;
  }

  measure: no_of_days_since_last_login {
    label: "No of Days Since Last Login (see foot note 1)"
    sql: DATE_DIFF( current_datetime(),  MAX(${TABLE}.LoginTime), DAY);;
    #sql: CASE WHEN MAX(${TABLE}.program_control_current_month) = 1
    #     THEN     DATE_DIFF( current_datetime(),  MAX(${TABLE}.LoginTime), DAY)
    #     ELSE NULL END;;
  }

  measure: count_active_usr {
    label: "Total"
    type: count_distinct
    sql: ${TABLE}.UserId ;;
    drill_fields: [of_user.country, of_user.office_code, of_user.full_name, of_user.username,
                   of_user.profile_name, of_user.user_role_name, count_login,login_time_min,login_time_max,no_of_days_since_last_login]
  }

  measure: count_usr_logged {
    label: "Logged"
    type: count_distinct
    sql: ${TABLE}.Login_UserId ;;
    filters: [login_user_id: "-NULL"]
    drill_fields: [of_user_logged_in.country, of_user_logged_in.office_code, of_user_logged_in.full_name, of_user_logged_in.username,
                   of_user_logged_in.profile_name, of_user_logged_in.user_role_name, count_login,login_time_min,login_time_max,no_of_days_since_last_login]
    }

  measure: count_usr_not_logged_sql {
    label: "Not Logged"
    type: number
    sql: ${count_active_usr} - ${count_usr_logged} ;;
    value_format: "#,##0"
    link: {
      label: "Show All {{rendered_value}}"
      url: "{{ notlogged_drills._link }}&f[user_count_n_login_hist.Zero_Login]=yes"
    }}


  measure: Zero_Login {
    type: yesno
    sql: ${count_login} = 0 ;;
  }

  measure:notlogged_drills {
    type: sum
    sql: 0;;
    drill_fields: [of_user.country, of_user.office_code, of_user.full_name, of_user.username,
        of_user.profile_name, of_user.user_role_name, count_login,login_time_min,login_time_max,no_of_days_since_last_login]
    hidden: yes
  }

  measure: count_usr_not_logged {
    label: "Not Logged(Active-Logged)"
    type: number
    sql: ${count_active_usr} - ${count_usr_logged}  ;;
    drill_fields: [of_user.country, of_user.office_code, of_user.full_name, of_user.username,
      of_user.profile_name, of_user.user_role_name, count_login,login_time_min,login_time_max,no_of_days_since_last_login]
    # filters: [not_login_user_id: "-NULL"] # filter is not support for number type of measure
    # drill_fields: [of_user_not_logged_in.full_name, of_user_not_logged_in.username,count_login,login_time_min,login_time_max]
  }

  #measure: count_usr_not_logged_overall {
  #  label: "Not Logged (overall)"
  #  type: count_distinct
  #  sql: ${TABLE}.UserId ;;
  #  # filters: [not_login_user_id: "-NULL"] # filter is not support for number type of measure
  ##  # drill_fields: [of_user_not_logged_in.full_name, of_user_not_logged_in.username,count_login,login_time_min,login_time_max]
  #  drill_fields: [of_user.full_name, of_user.username,count_login,login_time_min,login_time_max]
  #}

  measure: precentage_logged {
    label: "% of Logged"
    type: number
    sql: case when ${count_active_usr} = 0 then null else ${count_usr_logged} / ${count_active_usr} end ;;
    value_format: "0.0%"
    drill_fields: [of_user.country, of_user.office_code, of_user.full_name, of_user.username,
                   of_user.profile_name, of_user.user_role_name, count_login,login_time_min,login_time_max,no_of_days_since_last_login]
  }

  dimension: calendar_month {
    type: string
    sql: ${TABLE}.Calendar_Month ;;
  }

  dimension: calendar_quarter {
    type: string
    sql: ${TABLE}.Calendar_Quarter ;;
  }

  dimension: calendar_year {
    type: string
    sql: ${TABLE}.Calendar_Year ;;
  }

  dimension: month_selection {
    type: string
    sql: ${TABLE}.month_selection ;;
  }

  dimension: program_control_current_month {
    type: number
    sql: ${TABLE}.program_control_current_month ;;
  }

  dimension: is_last_mth {
    type: string
    sql: ${TABLE}.is_last_mth ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.UserId ;;
  }

  dimension: username {
    label: "Username"
    type: string
    sql: ${TABLE}.Username ;;
  }

  dimension: is_active {
    label: "Is Status Active"
    type: string
    sql: ${TABLE}.IsActive ;;
  }

  dimension_group: usr_acc_created_date {
    type: time
    datatype: datetime
    sql: ${TABLE}.Usr_CreatedDate ;;
  }

  dimension_group: usr_acc_last_modified_date {
    type: time
    datatype: datetime
    sql: ${TABLE}.Usr_LastModifiedDate ;;
  }

  dimension: not_login_user_id {
    type: string
    sql: ${TABLE}.Not_Logged_UserId ;;
  }

  dimension: login_user_id {
    type: string
    sql: ${TABLE}.Login_UserId ;;
  }

  dimension: login_application {
    type: string
    sql: ${TABLE}.Application ;;
  }

  dimension_group: EverRecordedLastLogon {
    label: "Ever Recorded Last Logon"
    type: time
    timeframes: [
      date
    ]
    sql: ${TABLE}.EverRecordedLastLogon ;;
  }

  dimension_group: login_time {
    label: "Login Time"
    type: time
    datatype: datetime
    sql: ${TABLE}.LoginTime ;;
  }

  dimension: login_week_selection {
    type: string
    sql: ${TABLE}.LoginWeek ;;
  }

  dimension: login_type {
    type: string
    sql: ${TABLE}.LoginType ;;
  }

  dimension: login_url {
    type: string
    sql: ${TABLE}.LoginUrl ;;
  }

    dimension: year {
      type: string
      sql: case when ${login_time_week_of_year}=52  and ${login_time_month_num}=1 then ${login_time_year}-1 else ${login_time_year} end ;;
    }

  set: detail {
    fields: [
      calendar_month,
      calendar_quarter,
      calendar_year,
      user_id,
      username,
      is_active,
      usr_acc_created_date_time,
      usr_acc_last_modified_date_time,
      login_application,
      login_time_time,
      login_type,
      login_url
    ]
  }
}


include: "of_user.view"
view: of_user {
  extends: [of_user_raw]

  dimension: tpa_user {
    label: "Is TPA User"
    type: string
    sql: CASE ${TABLE}.TPA_user WHEN 'true' THEN 'Yes' ELSE 'No' END ;;
  }

  dimension: is_crm_trainer {
    label: "Is CRM Trainer"
    type: yesno
    sql: ${crm_trainer} = "true" ;;
  }

  dimension: is_suppressed_in_kpi_dshbrd {
    label: "Suppressed in CRM Usage KPI Dashboard"
    type: yesno
    sql: ${suppressed_in_crm_usage_kpi_dashboard} = "true" ;;
  }

  dimension: current_status{
    label: "Current Status of User Account"
    type: string
    sql: CASE ${TABLE}.isactive WHEN "true" THEN "Active" ELSE "Inactive" END;;
  }

  dimension: user_role_name {
    label: "User Role"
    type: string
    sql: CASE WHEN INSTR( ${TABLE}.User_Role_Name, '-', -1) = 0 THEN ${TABLE}.User_Role_Name
         ELSE TRIM( SUBSTR( ${TABLE}.User_Role_Name, INSTR( ${TABLE}.User_Role_Name, '-', -1 )+1 ) )
         END;;
  }

  dimension: profile_name {
    label: "User Profile"
    type: string
    sql: CASE ${TABLE}.profile_name WHEN 'PT1' THEN 'System Administrator' ELSE ${TABLE}.profile_name  END ;;
  }

  dimension: office_code {
    label: "Office."
    view_label: "User"
    #type: string
    #sql: ${TABLE}.Office_Code ;;
    }

  dimension: country {
    label: "Country"  # programmatically added by LookML modifier
    view_label: "User"
    type: string
    #map_layer_name: countries
    #sql: ${TABLE}.Country ;;
    sql: CASE TRIM( SUBSTR( ${TABLE}.Office_Code, INSTR( ${TABLE}.Office_Code, '-', -1 )+1 ) )
           WHEN 'TSNBB' then 'China North'
           WHEN 'SJWBB' then 'China North'
           WHEN 'DLCBB' then 'China North'
           WHEN 'SHABB' then 'China Central'
           WHEN 'LYGBB' then 'China North'
           WHEN 'NKGBB' then 'China Central'
           WHEN 'SZHBB' then 'China Central'
           WHEN 'HGHBB' then 'China Central'
           WHEN 'JIXBB' then 'China Central'
           WHEN 'NBOBB' then 'China Central'
           WHEN 'HFEBB' then 'China Central'
           WHEN 'FOCBB' then 'HK & China South'
           WHEN 'XMNBB' then 'HK & China South'
           WHEN 'TAOBB' then 'China North'
           WHEN 'CGOBB' then 'China North'
           WHEN 'WUHBB' then 'China Central'
           WHEN 'CANBB' then 'HK & China South'
           WHEN 'SWABA' then 'HK & China South'
           WHEN 'SZPBB' then 'HK & China South'
           WHEN 'ZHOBB' then 'HK & China South'
           WHEN 'ZHUBB' then 'HK & China South'
           WHEN 'CKGBB' then 'China Central'
           WHEN 'CTUBB' then 'China Central'
           WHEN 'SIABB' then 'China North'
           WHEN 'HKGBB' then 'HK & China South'
           WHEN 'HKGHQ' then 'HK & China South'
           WHEN 'MACBA' then 'HK & China South'
        ELSE
          --${TABLE}.Country -- Jack , follow logic in the production version of OF_USER
          TRIM( SUBSTR(${TABLE}.Office_Code, 1, INSTR(${TABLE}.Office_Code, '-')-1 ) )
        END ;;
    drill_fields: [office_code]
  }

  dimension: region_3char {
    label: "Region"
    view_label: "User"
    type: string
    sql:  CASE TRIM( SUBSTR( ${TABLE}.Regional_Head_Office, INSTR( ${TABLE}.Regional_Head_Office, '-', -1 )+1 ) )
          WHEN 'SINHO' THEN 'SINHO' WHEN 'SAOHQ' THEN 'LAM' WHEN 'HKGHQ' THEN 'EAS'
          WHEN 'LONHQ' THEN 'EUA'   WHEN 'RICHQ' THEN 'NAM' WHEN 'SINHQ' THEN 'SAS'
          ELSE NULL END ;;
    drill_fields: [country, office_code]
  }

  dimension: region_3char1 {
    label: "Region1"
    view_label: "User"
    type: string
    sql:  Case WHEN ${region_3char}='SINHO' and  ${office_for_filter}='Singapore - Singapore - SINHO' THEN 'SINHO'
          WHEN ${region_3char}='SINHO' and  ${office_for_filter}!='Singapore - Singapore - SINHO' THEN 'Offshore'
          WHEN ${region_3char}='LAM' THEN 'LAM'
          WHEN ${region_3char}='EAS' THEN 'EAS'
          WHEN ${region_3char}='EUA' THEN 'EUA'
          WHEN ${region_3char}='NAM' THEN 'NAM'
          WHEN ${region_3char}='SAS' THEN 'SAS'  ELSE NULL END ;;
    drill_fields: [country, office_code]
  }

  dimension: Region_order {
    label: "Region Order"
    view_label: "User"
    type: string
    sql:  Case WHEN ${region_3char1}='SINHO' THEN '7'
          WHEN ${region_3char1}='Offshore' THEN '6'
          WHEN ${region_3char1}='LAM' THEN '3'
          WHEN ${region_3char1}='EAS' THEN '1'
          WHEN ${region_3char1}='EUA' THEN '2'
          WHEN ${region_3char1}='NAM' THEN '4'
          WHEN ${region_3char1}='SAS' THEN '5'  ELSE NULL END ;;
    drill_fields: [country, office_code]
  }

   dimension:office_for_filter {
    label: "Office for filter"
    type: string
    sql: ${TABLE}.Office_Code;;
  }


  dimension: is_sales_executive_or_tpa {
    label: "Is Sales Exec or TPA"
    type: yesno
    sql: lower(trim(${profile_name})) in ( "sales executive", "third party agent") ;;
  }

  dimension_group: user_wise_last_logon_date {
    #label: "Ever Recorded Last Logon"
    label: "Last Logon"
    type: time
    timeframes: [
      time,
      date
    ]
    sql: ${TABLE}.LastLoginDate  ;;
    #value_format:
  }
}

view: user_count_n_login_hist_of_user_logged {
  extends: [of_user]

  dimension: office_code {
    label: "Office."  # programmatically added by LookML modifier
    view_label: "User Logged-in"
  }

  dimension: country {
    label: "Country"  # programmatically added by LookML modifier
    view_label: "User Logged-in"
  }

  dimension: region_3char {
    label: "Region"
    view_label: "User Logged-in"
  }
}

view: user_count_n_login_hist_of_user_not_logged {
  extends: [of_user]

  dimension: office_code {
    label: "Office."  # programmatically added by LookML modifier
    view_label: "User Not Logged-in"
  }

  dimension: country {
    label: "Country"  # programmatically added by LookML modifier
    view_label: "User Not Logged-in"
  }

  dimension: region_3char {
    label: "Region"
    view_label: "User Not Logged-in"
  }
}
