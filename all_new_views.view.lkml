


view: of_user_logged_in {
  dimension: country { 
    view_label: "User Logged-in"
    group_item_label: "Country"
    label: "Country"
    type: string
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
        END  ;;
  }

  dimension: full_name { 
    view_label: "User Logged-in"
    group_item_label: "Full Name"
    label: "Full Name"
    type: string
    sql: concat(${first_name}," ",${last_name})  ;;
  }

  dimension: office_code { 
    view_label: "User Logged-in"
    group_item_label: "Office"
    label: "Office"
    type: string
    sql: ${TABLE}.Office_Code  ;;
  }

  dimension: profile_name { 
    view_label: "User Logged-in"
    group_item_label: "User Profile"
    label: "User Profile"
    type: string
    sql: CASE ${TABLE}.profile_name WHEN 'PT1' THEN 'System Administrator' ELSE ${TABLE}.profile_name  END  ;;
  }

  dimension: user_role_name { 
    view_label: "User Logged-in"
    group_item_label: "User Role"
    label: "User Role"
    type: string
    sql: CASE WHEN INSTR( ${TABLE}.User_Role_Name, '-', -1) = 0 THEN ${TABLE}.User_Role_Name
  ELSE TRIM( SUBSTR( ${TABLE}.User_Role_Name, INSTR( ${TABLE}.User_Role_Name, '-', -1 )+1 ) )
  END ;;
  }

  dimension: username { 
    view_label: "User Logged-in"
    group_item_label: "Username"
    label: "Username"
    type: string
    sql: ${TABLE}.Username  ;;
  }

  
  dimension_group: createddate { 
    view_label: "User Logged-in"
    group_label: "Created Date (Local)"
    group_item_label: "{%- assign timeframe = _field._name | remove: 'of_user_logged_in.createddate_' | replace: '_',' ' | capitalize -%}
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
    sql: timestamp(${TABLE}.createddate)  ;;
  }

  dimension_group: lastlogindate { 
    view_label: "User Logged-in"
    group_label: "Last Login Date (Local)"
    group_item_label: "{%- assign timeframe = _field._name | remove: 'of_user_logged_in.lastlogindate_' | replace: '_',' ' | capitalize -%}
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
    sql: timestamp(${TABLE}.LastLoginDate)  ;;
  }

  dimension_group: lastmodifieddate { 
    view_label: "User Logged-in"
    group_label: "Last Modified Date (Local)"
    group_item_label: "{%- assign timeframe = _field._name | remove: 'of_user_logged_in.lastmodifieddate_' | replace: '_',' ' | capitalize -%}
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
    sql: timestamp(${TABLE}.lastmodifieddate)  ;;
  }

  
  measure: count { 
    view_label: "Measure"
    group_item_label: "Count"
    label: "Count"
    type: count_distinct
    sql: of_user_logged_in.ONEForce_ID  ;;
  }

  
  
 }



view: of_user_not_logged_in {
  dimension: country { 
    view_label: "User Not Logged-in"
    group_item_label: "Country"
    label: "Country"
    type: string
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
        END  ;;
  }

  dimension: full_name { 
    view_label: "User Not Logged-in"
    group_item_label: "Full Name"
    label: "Full Name"
    type: string
    sql: concat(${first_name}," ",${last_name})  ;;
  }

  dimension: office_code { 
    view_label: "User Not Logged-in"
    group_item_label: "Office"
    label: "Office"
    type: string
    sql: ${TABLE}.Office_Code  ;;
  }

  dimension: profile_name { 
    view_label: "User Not Logged-in"
    group_item_label: "User Profile"
    label: "User Profile"
    type: string
    sql: CASE ${TABLE}.profile_name WHEN 'PT1' THEN 'System Administrator' ELSE ${TABLE}.profile_name  END  ;;
  }

  dimension: user_role_name { 
    view_label: "User Not Logged-in"
    group_item_label: "User Role"
    label: "User Role"
    type: string
    sql: CASE WHEN INSTR( ${TABLE}.User_Role_Name, '-', -1) = 0 THEN ${TABLE}.User_Role_Name
  ELSE TRIM( SUBSTR( ${TABLE}.User_Role_Name, INSTR( ${TABLE}.User_Role_Name, '-', -1 )+1 ) )
  END ;;
  }

  dimension: username { 
    view_label: "User Not Logged-in"
    group_item_label: "Username"
    label: "Username"
    type: string
    sql: ${TABLE}.Username  ;;
  }

  
  dimension_group: createddate { 
    view_label: "User Not Logged-in"
    group_label: "Created Date (Local)"
    group_item_label: "{%- assign timeframe = _field._name | remove: 'of_user_not_logged_in.createddate_' | replace: '_',' ' | capitalize -%}
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
    sql: timestamp(${TABLE}.createddate)  ;;
  }

  dimension_group: lastlogindate { 
    view_label: "User Not Logged-in"
    group_label: "Last Login Date (Local)"
    group_item_label: "{%- assign timeframe = _field._name | remove: 'of_user_not_logged_in.lastlogindate_' | replace: '_',' ' | capitalize -%}
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
    sql: timestamp(${TABLE}.LastLoginDate)  ;;
  }

  dimension_group: lastmodifieddate { 
    view_label: "User Not Logged-in"
    group_label: "Last Modified Date (Local)"
    group_item_label: "{%- assign timeframe = _field._name | remove: 'of_user_not_logged_in.lastmodifieddate_' | replace: '_',' ' | capitalize -%}
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
    sql: timestamp(${TABLE}.lastmodifieddate)  ;;
  }

  
  measure: count { 
    view_label: "Measure"
    group_item_label: "Count"
    label: "Count"
    type: count_distinct
    sql: of_user_not_logged_in.ONEForce_ID  ;;
  }

  
  
 }

