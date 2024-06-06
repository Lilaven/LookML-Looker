include: "of_user.view"


view: user_count_n_login_hist {
  derived_table: { sql: WITH month_master as (
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
      --limit 50 ;;
  }

  filter: date_filter {   datatype: date
    type: date
  }

  
  dimension: calendar_month { 
    view_label: "User Login History"
    group_label: "Calendar"
    group_item_label: "Calendar Month"
    label: "Calendar Month"
    type: string
    sql: ${TABLE}.Calendar_Month  ;;
  }

 
  
  measure: count_usr_logged { 
    filters: [login_user_id: -NULL] 
    drill_fields: [ of_user_logged_in.country, of_user_logged_in.office_code, of_user_logged_in.full_name, of_user_logged_in.username, of_user_logged_in.profile_name, of_user_logged_in.user_role_name, count_login, login_time_min, login_time_max, no_of_days_since_last_login, ] 
    view_label: "Measure"
    group_item_label: "Logged"
    label: "Logged"
    type: count_distinct
    sql: ${TABLE}.Login_UserId  ;;
  }

  measure: count_usr_not_logged_sql { 
    
link: { label: "Show All {{rendered_value}}"
  url: "{{ notlogged_drills._link }}&f[user_count_n_login_hist.Zero_Login]=yes"
 }


    view_label: "Measure"
    group_item_label: "Not Logged"
    label: "Not Logged"
    type: number
    value_format: "#,##0"
    sql: ${count_active_usr} - ${count_usr_logged}  ;;
  }
}
  

view: user_count_n_login_hist_of_user_logged {
  extends: [of_user ]
  dimension: country {   label: "Country"
    view_label: "User Logged-in"
  }

  dimension: office_code {   label: "Office."
    view_label: "User Logged-in"
  }

  dimension: region_3char {   label: "Region"
    view_label: "User Logged-in"
  }

 }

