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
    hidden: no
    view_label: "User Login History"
    group_label: "Calendar"
    group_item_label: "Calendar Month"
    label: "Calendar Month"
    type: string
    sql: ${TABLE}.Calendar_Month  ;;
   }
  dimension: calendar_quarter { 
    hidden: no
    view_label: "User Login History"
    group_label: "Calendar"
    group_item_label: "Calendar Quarter"
    label: "Calendar Quarter"
    type: string
    sql: ${TABLE}.Calendar_Quarter  ;;
   }
  dimension: calendar_year { 
    hidden: no
    view_label: "User Login History"
    group_label: "Calendar"
    group_item_label: "Calendar Year"
    label: "Calendar Year"
    type: string
    sql: ${TABLE}.Calendar_Year  ;;
   }
  dimension: is_active { 
    hidden: no
    view_label: "User Login History"
    group_item_label: "Is Active (Yes/No)"
    label: "Is Active"
    type: string
    sql: ${TABLE}.IsActive  ;;
   }
  dimension: is_last_mth { 
    hidden: no
    view_label: "User Login History"
    group_item_label: "Is Last Month (Yes/No)"
    label: "Is Last Month"
    type: string
    sql: ${TABLE}.is_last_mth  ;;
   }
  dimension: login_application { 
    hidden: no
    view_label: "User Login History"
    group_item_label: "Login Application"
    label: "Login Application"
    type: string
    sql: ${TABLE}.Application  ;;
   }
  dimension: login_type { 
    hidden: no
    view_label: "User Login History"
    group_item_label: "Login Type"
    label: "Login Type"
    type: string
    sql: ${TABLE}.LoginType  ;;
   }
  dimension: login_url { 
    hidden: no
    view_label: "User Login History"
    group_item_label: "Login URL"
    label: "Login URL"
    type: string
    sql: ${TABLE}.LoginUrl  ;;
   }
  dimension: login_user_id { 
    hidden: no
    view_label: "User Login History"
    group_item_label: "Login User ID"
    label: "Login User ID"
    type: string
    sql: ${TABLE}.Login_UserId  ;;
   }
  dimension: login_week_selection { 
    hidden: no
    view_label: "User Login History"
    group_item_label: "Login Week Selection"
    label: "Login Week Selection"
    type: string
    sql: ${TABLE}.LoginWeek  ;;
   }
  dimension: month_selection { 
    hidden: no
    view_label: "User Login History"
    group_item_label: "Month Selection"
    label: "Month Selection"
    type: string
    sql: ${TABLE}.month_selection  ;;
   }
  dimension: not_login_user_id { 
    hidden: no
    view_label: "User Login History"
    group_item_label: "Not Login User ID"
    label: "Not Login User ID"
    type: string
    sql: ${TABLE}.Not_Logged_UserId  ;;
   }
  dimension: program_control_current_month { 
    hidden: no
    view_label: "User Login History"
    group_item_label: "Program Control Current Month"
    label: "Program Control Current Month"
    type: number
    sql: ${TABLE}.program_control_current_month  ;;
   }
  dimension: user_id { 
    hidden: no
    view_label: "User Login History"
    group_item_label: "User ID"
    label: "User ID"
    type: string
    sql: ${TABLE}.UserId  ;;
   }
  dimension: username { 
    hidden: no
    view_label: "User Login History"
    group_item_label: "Username"
    label: "User Name"
    type: string
    sql: ${TABLE}.Username  ;;
   }
  dimension: year { 
    hidden: no
    view_label: "User Login History"
    group_label: "Calendar"
    group_item_label: "Adjusted Year"
    label: "Adjusted Year"
    type: string
    sql: case when ${login_time_week_of_year}=52  and ${login_time_month_num}=1 then ${login_time_year}-1 else ${login_time_year} end  ;;
   }
  
  dimension_group: EverRecordedLastLogon { 
    hidden: no
    view_label: "User Login History"
    group_label: "Ever Recorded Last Logon Date (Local)"
    group_item_label: "{%- assign timeframe = _field._name | remove: 'user_count_n_login_hist.EverRecordedLastLogon_' | replace: '_',' ' | capitalize -%}
  {%- case timeframe %}
  {%- when 'Time' %}01. Date Time
  {%- when 'Date' %}02. Date
  {%- when 'Week of year' %}03. Week of Year
  {%- when 'Month num' %}04. Month
  {%- when 'Quarter of year' %}05. Calendar Quarter
  {%- when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {%- when 'Year' %}07. Calendar Year
  {%- when 'Fiscal year' %}08. Fiscal Year
  {%- else %}{{timeframe}}{% endcase -%}"
    label: "Ever Recorded Last Logon"
    type: time
    timeframes: 
[raw,
  time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.EverRecordedLastLogon  ;;
   }
  dimension_group: login { 
    hidden: no
    view_label: "User Login History"
    group_label: "Login Date (Local)"
    group_item_label: "{%- assign timeframe = _field._name | remove: 'user_count_n_login_hist.login_' | replace: '_',' ' | capitalize -%}
  {%- case timeframe %}
  {%- when 'Time' %}01. Date Time
  {%- when 'Date' %}02. Date
  {%- when 'Week of year' %}03. Week of Year
  {%- when 'Month num' %}04. Month
  {%- when 'Quarter of year' %}05. Calendar Quarter
  {%- when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {%- when 'Year' %}07. Calendar Year
  {%- when 'Fiscal year' %}08. Fiscal Year
  {%- else %}{{timeframe}}{% endcase -%}"
    label: "Login"
    type: time
    timeframes: 
[raw,
  time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.LoginTime  ;;
   }
  dimension_group: login_time { 
    label: "Login Time"
    type: time
    datatype: datetime
    sql: ${TABLE}.LoginTime ;;
    timeframes: [raw
  ,year
  ,quarter
  ,month
  ,week
  ,date
  ,day_of_week
  ,hour
  ,hour_of_day
  ,minute
  ,time
  ,time_of_day]
   }
  dimension_group: usr_acc_created_date { 
    hidden: no
    view_label: "User Login History"
    group_label: "Account Created Date (Local)"
    group_item_label: "{%- assign timeframe = _field._name | remove: 'user_count_n_login_hist.usr_acc_created_date_' | replace: '_',' ' | capitalize -%}
  {%- case timeframe %}
  {%- when 'Time' %}01. Date Time
  {%- when 'Date' %}02. Date
  {%- when 'Week of year' %}03. Week of Year
  {%- when 'Month num' %}04. Month
  {%- when 'Quarter of year' %}05. Calendar Quarter
  {%- when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {%- when 'Year' %}07. Calendar Year
  {%- when 'Fiscal year' %}08. Fiscal Year
  {%- else %}{{timeframe}}{% endcase -%}"
    label: "Account Created"
    type: time
    timeframes: 
[raw,
  time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.Usr_CreatedDate  ;;
   }
  dimension_group: usr_acc_last_modified_date { 
    hidden: no
    view_label: "User Login History"
    group_label: "Account Last Modified Date (Local)"
    group_item_label: "{%- assign timeframe = _field._name | remove: 'user_count_n_login_hist.usr_acc_last_modified_date_' | replace: '_',' ' | capitalize -%}
  {%- case timeframe %}
  {%- when 'Time' %}01. Date Time
  {%- when 'Date' %}02. Date
  {%- when 'Week of year' %}03. Week of Year
  {%- when 'Month num' %}04. Month
  {%- when 'Quarter of year' %}05. Calendar Quarter
  {%- when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {%- when 'Year' %}07. Calendar Year
  {%- when 'Fiscal year' %}08. Fiscal Year
  {%- else %}{{timeframe}}{% endcase -%}"
    label: "Account Last Modified"
    type: time
    timeframes: 
[raw,
  time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: ${TABLE}.Usr_LastModifiedDate  ;;
   }
  
  measure: Zero_Login { 
    hidden: no
    view_label: "Measure"
    group_item_label: "Zero Login (Yes / No)"
    label: "Zero Login"
    type: yesno
    sql: ${count_login} = 0  ;;
   }
  measure: count_active_usr { 
    drill_fields: [ of_user.country, of_user.office_code, of_user.full_name, of_user.username, of_user.profile_name, of_user.user_role_name, count_login, login_time_min, login_time_max, no_of_days_since_last_login, ] 
    hidden: no
    view_label: "Measure"
    group_item_label: "Total"
    label: "Total"
    type: count_distinct
    sql: ${TABLE}.UserId  ;;
   }
  measure: count_login { 
    hidden: no
    view_label: "Measure"
    group_item_label: "Login Count"
    label: "Login Count"
    type: count_distinct
    sql: ${TABLE}.LoginTime  ;;
   }
  measure: count_usr_logged { 
    filters__all: [ [ { login_user_id: -NULL
   } ]  ] 
    drill_fields: [ of_user_logged_in.country, of_user_logged_in.office_code, of_user_logged_in.full_name, of_user_logged_in.username, of_user_logged_in.profile_name, of_user_logged_in.user_role_name, count_login, login_time_min, login_time_max, no_of_days_since_last_login, ] 
    hidden: no
    view_label: "Measure"
    group_item_label: "Logged"
    label: "Logged"
    type: count_distinct
    sql: ${TABLE}.Login_UserId  ;;
   }
  measure: count_usr_not_logged { 
    drill_fields: [ of_user.country, of_user.office_code, of_user.full_name, of_user.username, of_user.profile_name, of_user.user_role_name, count_login, login_time_min, login_time_max, no_of_days_since_last_login, ] 
    hidden: no
    view_label: "Measure"
    group_item_label: "Not Logged (Active-Logged)"
    label: "Not Logged(Active-Logged)"
    type: number
    sql: ${count_active_usr} - ${count_usr_logged}   ;;
   }
  measure: count_usr_not_logged_sql { 
    
link: { label: "Show All {{rendered_value}}"
  url: "{{ notlogged_drills._link }}&f[user_count_n_login_hist.Zero_Login]=yes"
   }
    hidden: no
    view_label: "Measure"
    group_item_label: "Not Logged"
    label: "Not Logged"
    type: number
    value_format: "#,##0"
    sql: ${count_active_usr} - ${count_usr_logged}  ;;
   }
  measure: login_time_max { 
    hidden: no
    view_label: "Measure"
    group_item_label: "Last Login Time"
    label: "Last Login"
    type: string
    sql: FORMAT_DATETIME( "%F %T", MAX(${TABLE}.LoginTime) )  ;;
   }
  measure: login_time_min { 
    hidden: no
    view_label: "Measure"
    group_item_label: "First Login Time"
    label: "First Login"
    type: string
    sql: FORMAT_DATETIME( "%F %T", MIN(${TABLE}.LoginTime) )  ;;
   }
  measure: no_of_days_since_last_login { 
    hidden: no
    view_label: "Measure"
    group_item_label: "Number of Days Since Last Login"
    label: "Number of Days Since Last Login"
    type: string
    sql: DATE_DIFF( current_datetime(),  MAX(${TABLE}.LoginTime), DAY) ;;
   }
  measure: notlogged_drills { 
    drill_fields: [ of_user.country, of_user.office_code, of_user.full_name, of_user.username, of_user.profile_name, of_user.user_role_name, count_login, login_time_min, login_time_max, no_of_days_since_last_login, ] 
    hidden: no
    view_label: "Measure"
    group_item_label: "Not Logged Drills"
    label: "Not Logged Drills"
    type: sum
    sql: 0 ;;
   }
  measure: precentage_logged { 
    drill_fields: [ of_user.country, of_user.office_code, of_user.full_name, of_user.username, of_user.profile_name, of_user.user_role_name, count_login, login_time_min, login_time_max, no_of_days_since_last_login, ] 
    hidden: no
    view_label: "Measure"
    group_item_label: "% of Logged"
    label: "% of Logged"
    type: number
    value_format: "0.00%"
    sql: case when ${count_active_usr} = 0 then null else ${count_usr_logged} / ${count_active_usr} end  ;;
   }
  set: detail { fields: [ calendar_month, calendar_quarter, calendar_year, user_id, username, is_active, usr_acc_created_date_time, usr_acc_last_modified_date_time, login_application, login_time_time, login_type, login_url, ] 
   }
  }


view: of_user {
  extends__all: [ [ of_user_raw, ]  ]
  dimension: Region_order { 
    drill_fields: [ country, office_code, ] 
    hidden: no
    view_label: "User"
    group_item_label: "Region Order"
    label: "Region Order"
    type: string
    sql: Case WHEN ${region_3char1}='SINHO' THEN '7'
  WHEN ${region_3char1}='Offshore' THEN '6'
  WHEN ${region_3char1}='LAM' THEN '3'
  WHEN ${region_3char1}='EAS' THEN '1'
  WHEN ${region_3char1}='EUA' THEN '2'
  WHEN ${region_3char1}='NAM' THEN '4'
  WHEN ${region_3char1}='SAS' THEN '5'  ELSE NULL END  ;;
   }
  dimension: city { 
    hidden: no
    view_label: "User"
    group_item_label: "City"
    label: "City"
    type: string
    sql: ${TABLE}.CTY_DESC ;;
   }
  dimension: country { 
    drill_fields: [ office_code, ] 
    hidden: no
    view_label: "User"
    group_item_label: "Country"
    label: "Country"
    type: string
    sql: CASE TRIM( SUBSTR( ${TABLE}.OFC_CD, INSTR( ${TABLE}.OFC_CD, '-', -1 )+1 ) )
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
  TRIM( SUBSTR(${TABLE}.OFC_CD, 1, INSTR(${TABLE}.OFC_CD, '-')-1 ) )
        END  ;;
   }
  dimension: crm_trainer { 
    hidden: no
    view_label: "User"
    group_item_label: "CRM Trainer"
    label: "CRM Trainer"
    type: string
    sql: ${TABLE}.CRM_TRNR_FLG ;;
   }
  dimension: current_status { 
    hidden: no
    view_label: "User"
    group_item_label: "Current Status of User Account"
    label: "Current Status of User Account"
    type: string
    sql: CASE ${TABLE}.ACT_FLG WHEN "true" THEN "Active" ELSE "Inactive" END ;;
   }
  dimension: dynamic_dim_region_country_for_mpr_qbr { 
    hidden: no
    view_label: "User"
    group_item_label: "Region"
    label: "Region"
    type: string
    sql: {% if dynamic_param_region_country_for_mpr_qbr._parameter_value == 'country' %}
  ${office_Country_Code}
  {% else %}
  ${regional_head_office_short_nm}
  {% endif %} ;;
   }
  dimension: email { 
    hidden: no
    view_label: "User"
    group_item_label: "Email"
    label: "Email"
    type: string
    sql: ${TABLE}.USR_EML ;;
   }
  dimension: first_name { 
    hidden: no
    view_label: "User"
    group_item_label: "First Name"
    label: "First Name"
    type: string
    sql: ${TABLE}.FRST_NM ;;
   }
  dimension: full_name { 
    hidden: no
    view_label: "User"
    group_item_label: "Full Name"
    label: "Full Name"
    type: string
    sql: concat(${first_name}," ",${last_name})  ;;
   }
  dimension: full_name1 { 
    hidden: no
    view_label: "User"
    group_item_label: "GAM"
    label: "GAM"
    type: string
    sql: concat(${first_name}," ",${last_name})  ;;
   }
  dimension: is_crm_trainer { 
    hidden: no
    view_label: "User"
    group_label: "Nature"
    group_item_label: "Is CRM Trainer (Yes/No)"
    label: "Is CRM Trainer"
    type: yesno
    sql: ${crm_trainer} = "true"  ;;
   }
  dimension: is_sales_executive_or_tpa { 
    hidden: no
    view_label: "User"
    group_label: "Nature"
    group_item_label: "Is Sales Exec or TPA (Yes/No)"
    label: "Is Sales Exec or TPA"
    type: yesno
    sql: lower(trim(${profile_name})) in ( "sales executive", "third party agent")  ;;
   }
  dimension: is_salesuser { 
    hidden: no
    view_label: "User"
    group_label: "Nature"
    group_item_label: "Is Sales User (Yes/No)"
    label: "Is Sale User"
    type: yesno
    sql: lower(trim(${profile_name})) in ("third party agent", "sales executive")  ;;
   }
  dimension: is_suppressed_in_kpi_dshbrd { 
    hidden: no
    view_label: "User"
    group_item_label: "Is Suppressed in CRM Usage KPI Dashboard"
    label: "Is Suppressed in CRM Usage KPI Dashboard"
    type: yesno
    sql: ${suppressed_in_crm_usage_kpi_dashboard} = "true"  ;;
   }
  dimension: isactive_y_n { 
    hidden: no
    view_label: "User"
    group_label: "Nature"
    group_item_label: "Is Active (Yes/No)"
    label: "Is Active"
    type: yesno
    sql: ${isactive} = 'true'  ;;
   }
  dimension: last_name { 
    hidden: no
    view_label: "User"
    group_item_label: "Last Name"
    label: "Last Name"
    type: string
    sql: ${TABLE}.LST_NM ;;
   }
  dimension: looker_group_id { 
    hidden: no
    view_label: "User"
    group_item_label: "Looker Group ID"
    label: "Looker Group ID"
    type: string
    sql: ${TABLE}.LKR_GRP_ID ;;
   }
  dimension: manager_id { 
    hidden: no
    view_label: "User"
    group_item_label: "Manager ID"
    label: "Manager ID"
    type: string
    sql: ${TABLE}.MNGR_ID ;;
   }
  dimension: name { 
    hidden: no
    view_label: "User"
    group_item_label: "of_user: Name"
    label: "of_user: Name"
    type: string
    sql: CASE WHEN ${first_name} IS NULL THEN ${last_name} WHEN ${last_name} IS NULL THEN ${first_name} ELSE  concat(${first_name}," ",${last_name}) END ;;
   }
  dimension: office_Country_Code { 
    hidden: no
    view_label: "Office Information"
    group_item_label: "of_user: Office Country Name"
    label: "of_user: Office Country Name"
    type: string
    sql: CASE TRIM( SUBSTR( ${TABLE}.OFC_CD, INSTR( ${TABLE}.OFC_CD, '-', -1 )+1 ) )
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
  TRIM( SUBSTR (${TABLE}.OFC_CD, 1, STRPOS(${TABLE}.OFC_CD, '-') -2))
        END  ;;
   }
  dimension: office_code { 
    hidden: no
    view_label: "User"
    group_item_label: "Office"
    label: "Office"
    type: string
    sql: ${TABLE}.OFC_CD ;;
   }
  dimension: office_code_new { 
    hidden: no
    view_label: "User"
    group_item_label: "of_user: Office Code"
    label: "of_user: Office Code"
    type: string
    sql: `ONEFORCE.offshore_ofc_cd_conv`(${TABLE}.OFC_CD_NO)   ;;
   }
  dimension: office_code_number { 
    hidden: no
    view_label: "Office Information"
    group_item_label: "of_user: Office Code Number"
    label: "of_user: Office Code Number"
    type: string
    sql: LTRIM(RTRIM(SUBSTR(${office_code}, LENGTH(${office_code}) - 5, 6)))   ;;
   }
  dimension: office_for_filter { 
    hidden: no
    view_label: "User"
    group_item_label: "Office for filter"
    label: "Office for filter"
    type: string
    sql: ${TABLE}.OFC_CD ;;
   }
  dimension: officetype { 
    hidden: no
    view_label: "User"
    group_item_label: "Office Type"
    label: "Office Type"
    type: string
    sql: IFNULL(${TABLE}.OFC_TP_NM,'Others')  ;;
   }
  dimension: oneforce_id { 
    hidden: no
    view_label: "User"
    group_item_label: "ONEForce ID"
    label: "ONEForce ID"
    type: string
    sql: ${TABLE}.OF_ID ;;
   }
  dimension: parent_office { 
    hidden: no
    view_label: "Office Information"
    group_item_label: "of_user: Parent Office"
    label: "of_user: Parent Office"
    type: string
    sql: ${TABLE}.PRNT_OFC_CD ;;
   }
  dimension: profile_id { 
    hidden: no
    view_label: "User"
    group_item_label: "Profile ID"
    label: "Profile ID"
    type: string
    sql: ${TABLE}.PRFL_ID ;;
   }
  dimension: profile_name { 
    hidden: no
    view_label: "User"
    group_item_label: "User Profile"
    label: "User Profile"
    type: string
    sql: CASE ${TABLE}.PRFL_NM WHEN 'PT1' THEN 'System Administrator' ELSE ${TABLE}.PRFL_NM END  ;;
   }
  dimension: profile_name_service { 
    hidden: no
    view_label: "User"
    group_item_label: "Profile Name for Service"
    label: "Profile Name for Service"
    type: string
    sql: CASE
  WHEN ${TABLE}.PRFL_NM ='Customer Care Agent' THEN 'CCA'
  WHEN ${TABLE}.PRFL_NM = 'Customer Care Supervisor' THEN 'CCS'
  WHEN ${TABLE}.PRFL_NM IN ('Sales Executive','TPA (Service Cloud) CCS','TPA (Service Cloud) CCA') THEN ${TABLE}.PRFL_NM
  ELSE "Others" END  ;;
   }
  dimension: region_3char { 
    drill_fields: [ country, office_code, ] 
    hidden: no
    view_label: "User"
    group_item_label: "Region"
    label: "Region"
    type: string
    sql: CASE TRIM( SUBSTR( ${TABLE}.RGN_HD_OFC_CD, INSTR( ${TABLE}.RGN_HD_OFC_CD, '-', -1 )+1 ) )
  WHEN 'SINHO' THEN 'SINHO' WHEN 'SAOHQ' THEN 'LAM' WHEN 'HKGHQ' THEN 'EAS'
  WHEN 'LONHQ' THEN 'EUA'   WHEN 'RICHQ' THEN 'NAM' WHEN 'SINHQ' THEN 'SAS'
  ELSE NULL END  ;;
   }
  dimension: region_3char1 { 
    drill_fields: [ country, office_code, ] 
    hidden: no
    view_label: "User"
    group_item_label: "Region1"
    label: "Region1"
    type: string
    sql: Case WHEN ${region_3char}='SINHO' and  ${office_for_filter}='Singapore - Singapore - SINHO' THEN 'SINHO'
  WHEN ${region_3char}='SINHO' and  ${office_for_filter}!='Singapore - Singapore - SINHO' THEN 'Offshore'
  WHEN ${region_3char}='LAM' THEN 'LAM'
  WHEN ${region_3char}='EAS' THEN 'EAS'
  WHEN ${region_3char}='EUA' THEN 'EUA'
  WHEN ${region_3char}='NAM' THEN 'NAM'
  WHEN ${region_3char}='SAS' THEN 'SAS'  ELSE NULL END  ;;
   }
  dimension: regional_head_office { 
    hidden: no
    view_label: "Office Information"
    group_item_label: "of_user: Regional Head Office"
    label: "of_user: Regional Head Office"
    type: string
    sql: ${TABLE}.RGN_HD_OFC_CD ;;
   }
  dimension: regional_head_office1 { 
    hidden: no
    view_label: "Office Information"
    group_item_label: "of_user: Regional Head Office"
    label: "of_user: Regional Head Office"
    type: string
    sql: case when ${regional_head_office}='Brazil - Sao Paulo - SAOHQ' then 'LAM'
    when ${regional_head_office}='Singapore - Singapore - SINHQ' then 'SAS'
    when ${regional_head_office}='United Kingdom - London - LONHQ' then 'EUA'
    when ${regional_head_office}='Hong Kong - Hong Kong - HKGHQ' then 'EAS'
    when ${regional_head_office}='United States - Richmond - RICHQ' then 'NAM'
    when ${regional_head_office}='Unclaimed - RHQ' then 'Nil'
    when ${regional_head_office}='Singapore - Singapore - SINHO' then 'SINHO' else Null End
     ;;
   }
  dimension: regional_head_office_5char { 
    hidden: no
    view_label: "Office Information"
    group_item_label: "of_user: Region code"
    label: "of_user: Region code"
    type: string
    sql: case when ${TABLE}.RGN_HD_OFC_CD is not null then RIGHT(${TABLE}.RGN_HD_OFC_CD, 5)
      else "Unclaimed Region" end ;;
   }
  dimension: regional_head_office_new { 
    hidden: no
    view_label: "User"
    group_item_label: "RHQ"
    label: "RHQ"
    type: string
    sql: case
  when ${regional_head_office}='Brazil - Sao Paulo - SAOHQ' THEN 'SAOHQ'
  when ${regional_head_office}='Hong Kong - Hong Kong - HKGHQ' THEN 'HKGHQ'
  when ${regional_head_office}='United Kingdom - London - LONHQ' THEN 'LONHQ'
  when ${regional_head_office}='United States - Richmond - RICHQ' THEN 'RICHQ'
  when ${regional_head_office}='Singapore - Singapore - SINHQ' THEN 'SINHQ'
  else "Unclaimed" end ;;
   }
  dimension: regional_head_office_order { 
    hidden: no
    view_label: "Office Information"
    group_item_label: "of_user: Regional Head Office Order"
    label: "of_user: Regional Head Office Order"
    type: string
    sql: case when ${regional_head_office1}='LAM : SAOHQ' then '1'
  when ${regional_head_office1}='SAS : SINHQ' then '2'
  when ${regional_head_office1}='EUA : LONHQ' then '3'
  when ${regional_head_office1}='EAS : HKGHQ' then '4'
  when ${regional_head_office1}='NAM : RICHQ' then '5'
  when ${regional_head_office1}='SINHO' then '6' else Null End
  ;;
   }
  dimension: regional_head_office_short_nm { 
    hidden: no
    view_label: "Office Information"
    group_item_label: "of_user: Regional Head Office Short Name"
    label: "of_user: Regional Head Office Short Name"
    type: string
    sql: case when ${TABLE}.RGN_HD_OFC_CD is not null then trim(substr(${TABLE}.RGN_HD_OFC_CD, instr(${TABLE}.RGN_HD_OFC_CD,'-')+1))
      else "Unclaimed Region" end ;;
   }
  dimension: sales_person { 
    hidden: no
    view_label: "User"
    group_item_label: "Sales Peson"
    label: "Sales Peson"
    type: string
    sql: ${full_name}  ;;
   }
  dimension: sales_service_user_profile { 
    hidden: no
    view_label: "User"
    group_item_label: "Sales or Service User Profile"
    label: "Sales or Service User Profile"
    type: string
    sql: CASE
  WHEN {% parameter Profile_Param %} = "Service" and  ${TABLE}.PRFL_NM IN ('Customer Care Agent', 'Customer Care Supervisor', 'Sales Executive', 'TPA (Service Cloud) CCS', 'TPA (Service Cloud) CCA') THEN 'Yes'
  WHEN {% parameter Profile_Param %} = "Sales" and ${TABLE}.PRFL_NM IN ('Third Party Agent', 'Sales Executive') THEN 'Yes'
  WHEN {% parameter Profile_Param %} = "All" THEN 'Yes'
  ELSE 'No' END ;;
   }
  dimension: srep_group { 
    hidden: no
    view_label: "User"
    group_item_label: "Srep Group"
    label: "Srep Group"
    type: string
    sql: case when Initcap(${full_name}) in
  ( "Akie Crabdree", "Ayako Sheinkopf", "Ayumi Soobratty","Kaori Usui",
  "Kenichi Nemoto","Masahiro Yamanaka", "Masami Rusting","Masanao Shimazu",
  "Mizuki Ro","Shuntaro Honzawa", "Teruyo Okumura","Tetsuo Sonobe",
  "Yasushi Suzuki","Yoshihiro Nomura","Yuki Ishii","Maria Bodnar",
  "Karen Usui" ) then "JPN"
  when Initcap(${full_name}) in
  ( "George Douglass", "Katie Brown", "Kevin Rodriguez", "Rob Rawson",
  "Wilma McCord", "Tim Walsh", "Tom Smart", "Mark Kendall" ) then "GKA"
  when upper(trim(${office_code_number})) in ("CHIBB") then "CRO"
  when upper(trim(${office_code_number})) in ("NYCBB", "TORBB") then "ERO"
  when upper(trim(${office_code_number})) in ("ATLBB") then "SRO"
  when upper(trim(${office_code_number})) in ("BOIBB", "LAXBB", "SEABB", "VANBB") then "WRO"
  else
  "Others"
  end  ;;
   }
  dimension: sub_region { 
    hidden: no
    view_label: "User"
    group_item_label: "Sub Region"
    label: "Sub Region"
    type: string
    sql: ${TABLE}.SUB_RGN_CD ;;
   }
  dimension: suppressed_in_crm_usage_kpi_dashboard { 
    hidden: no
    view_label: "User"
    group_item_label: "Suppressed in CRM Usage KPI Dashboard"
    label: "Suppressed in CRM Usage KPI Dashboard"
    type: string
    sql: ${TABLE}.SPRS_CRM_USG_KPI_DB_FLG ;;
   }
  dimension: suppressed_user_filter { 
    hidden: no
    view_label: "User"
    group_label: "Nature"
    group_item_label: "Is Suppressed User (Yes/No)"
    label: "Is Suppressed User"
    type: yesno
    sql: ${suppressed_in_crm_usage_kpi_dashboard} = "true"  ;;
   }
  dimension: title { 
    hidden: no
    view_label: "User"
    group_item_label: "Title"
    label: "Title"
    type: string
    sql: ${TABLE}.USR_TIT_NM ;;
   }
  dimension: tpa_user { 
    hidden: no
    view_label: "User"
    group_label: "Nature"
    group_item_label: "Is TPA User (Yes/No)"
    label: "Is TPA User"
    type: string
    sql: CASE ${TABLE}.N3PTY_USR_FLG WHEN 'true' THEN 'Yes' ELSE 'No' END  ;;
   }
  dimension: user_office { 
    hidden: no
    view_label: "User"
    group_item_label: "Office"
    label: "Office"
    type: string
    sql: {% if US_Spcl_Grouping._parameter_value == "Yes" %} ${srep_group}
  {% else %} ${office_code_number}
  {% endif %}
       ;;
   }
  dimension: user_role_id { 
    hidden: no
    view_label: "User"
    group_item_label: "User Role ID"
    label: "User Role ID"
    type: string
    sql: ${TABLE}.USR_ROLE_ID ;;
   }
  dimension: user_role_name { 
    hidden: no
    view_label: "User"
    group_item_label: "User Role Name"
    label: "User Role Name"
    type: string
    sql: CASE WHEN INSTR( ${TABLE}.USR_ROLE_NM, '-', -1) = 0 THEN ${TABLE}.USR_ROLE_NM
  ELSE TRIM( SUBSTR( ${TABLE}.USR_ROLE_NM, INSTR( ${TABLE}.USR_ROLE_NM, '-', -1 )+1 ) )
  END ;;
   }
  dimension: username { 
    hidden: no
    view_label: "User"
    group_item_label: "User Name"
    label: "User Name"
    type: string
    sql: ${TABLE}.USR_NM ;;
   }
  dimension: username_ofqa { 
    hidden: no
    view_label: "User"
    group_item_label: "User Name (OFQA)"
    label: "User Name (OFQA)"
    type: string
    sql: ${TABLE}.USR_NM || '.ofqa'  ;;
   }
  
  dimension_group: createddate { 
    hidden: no
    view_label: "User"
    group_label: "Created Date (Local)"
    group_item_label: "{%- assign timeframe = _field._name | remove: 'of_user.createddate_' | replace: '_',' ' | capitalize -%}
  {%- case timeframe %}
  {%- when 'Time' %}01. Date Time
  {%- when 'Date' %}02. Date
  {%- when 'Week of year' %}03. Week of Year
  {%- when 'Month num' %}04. Month
  {%- when 'Quarter of year' %}05. Calendar Quarter
  {%- when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {%- when 'Year' %}07. Calendar Year
  {%- when 'Fiscal year' %}08. Fiscal Year
  {%- else %}{{timeframe}}{% endcase -%}"
    label: "Created"
    type: time
    timeframes: 
[raw,
  time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: timestamp(${TABLE}.CRE_DT)  ;;
   }
  dimension_group: lastlogindate { 
    hidden: no
    view_label: "User"
    group_label: "Last Login Date (Local)"
    group_item_label: "{%- assign timeframe = _field._name | remove: 'of_user.lastlogindate_' | replace: '_',' ' | capitalize -%}
  {%- case timeframe %}
  {%- when 'Time' %}01. Date Time
  {%- when 'Date' %}02. Date
  {%- when 'Week of year' %}03. Week of Year
  {%- when 'Month num' %}04. Month
  {%- when 'Quarter of year' %}05. Calendar Quarter
  {%- when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {%- when 'Year' %}07. Calendar Year
  {%- when 'Fiscal year' %}08. Fiscal Year
  {%- else %}{{timeframe}}{% endcase -%}"
    label: "Last Login"
    type: time
    timeframes: 
[raw,
  time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: timestamp(${TABLE}.LST_LGN_DT)  ;;
   }
  dimension_group: lastmodifieddate { 
    hidden: no
    view_label: "User"
    group_label: "Last Modified Date (Local)"
    group_item_label: "{%- assign timeframe = _field._name | remove: 'of_user.lastmodifieddate_' | replace: '_',' ' | capitalize -%}
  {%- case timeframe %}
  {%- when 'Time' %}01. Date Time
  {%- when 'Date' %}02. Date
  {%- when 'Week of year' %}03. Week of Year
  {%- when 'Month num' %}04. Month
  {%- when 'Quarter of year' %}05. Calendar Quarter
  {%- when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {%- when 'Year' %}07. Calendar Year
  {%- when 'Fiscal year' %}08. Fiscal Year
  {%- else %}{{timeframe}}{% endcase -%}"
    label: "Last Modified"
    type: time
    timeframes: 
[raw,
  time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    datatype: datetime
    convert_tz: no
    sql: timestamp(${TABLE}.UPD_DT)  ;;
   }
  dimension_group: user_wise_last_logon_date { 
    label: "Last Logon"
    type: time
    timeframes: [ time, date, ] 
    sql: ${TABLE}.LastLoginDate ;;
   }
  
  measure: count { 
    hidden: no
    view_label: "Measure"
    group_item_label: "Count"
    label: "Count"
    type: count_distinct
    sql: ${TABLE}.OF_ID ;;
   }
  measure: salesuser_count { 
    hidden: no
    view_label: "Measure"
    group_item_label: "Sales User Count"
    label: "Sales User Count"
    type: number
    sql: COUNT (DISTINCT CASE WHEN lower(trim(${profile_name})) = "sales executive" THEN ${oneforce_id} END)  ;;
   }
  measure: user_count { 
    hidden: no
    view_label: "Measure"
    group_item_label: "User Count"
    label: "User Count"
    type: number
    sql: COUNT (distinct ${oneforce_id} )  ;;
   }
  
  
  }


view: user_count_n_login_hist_of_user_logged {
  extends__all: [ [ of_user, ]  ]
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


view: user_count_n_login_hist_of_user_not_logged {
  extends__all: [ [ of_user, ]  ]
  dimension: country {   label: "Country"
    view_label: "User Not Logged-in"
   }
  dimension: office_code {   label: "Office."
    view_label: "User Not Logged-in"
   }
  dimension: region_3char {   label: "Region"
    view_label: "User Not Logged-in"
   }
  }
