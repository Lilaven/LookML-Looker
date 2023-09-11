


view: dml_trsp_cost {
  dimension: bkg_no { 
    view_label: "Contact: Role-based"
    group_item_label: "Role Tile"
    label: "Role Tile"
    type: string }
  
  
  }


view: of_contract_customer_contact {
  dimension: accountid { 
    view_label: "Contract Customer Contact"
    group_item_label: "Accountid"
    label: "Accountid"
    type: string
    sql: ${TABLE}.accountid  ;; }
  dimension: business_phone_country_code { 
    view_label: "Contract Customer Contact"
    group_item_label: "Business Phone Country Code"
    label: "Business Phone Country Code"
    type: string
    sql: ${TABLE}.business_phone_country_code  ;; }
  dimension: business_phone_extension { 
    view_label: "Contract Customer Contact"
    group_item_label: "Business Phone Extension"
    label: "Business Phone Extension"
    type: string
    sql: ${TABLE}.business_phone_extension  ;; }
  dimension: contact_method { 
    view_label: "Contract Customer Contact"
    group_item_label: "Contact Method"
    label: "Contact Method"
    type: string
    sql: ${TABLE}.contact_method  ;; }
  dimension: createdbyid { 
    view_label: "Contract Customer Contact"
    group_item_label: "Createdbyid"
    label: "Createdbyid"
    type: string
    sql: ${TABLE}.createdbyid  ;; }
  dimension: cust_cd { 
    view_label: "Contract Customer Contact"
    group_item_label: "Cust Cd"
    label: "Cust Cd"
    type: string
    sql: ${TABLE}.cust_cd  ;; }
  dimension: cust_name { 
    view_label: "Contract Customer Contact"
    group_item_label: "Cust Name"
    label: "Cust Name"
    type: string
    sql: ${TABLE}.cust_name  ;; }
  dimension: customer_contact { 
    view_label: "Contract Customer Contact"
    group_item_label: "Customer Contact"
    label: "Customer Contact"
    type: string
    sql: concat(${accountid},'-',${oneforce_id})  ;; }
  dimension: decision_maker { 
    view_label: "Contract Customer Contact"
    group_item_label: "Decision Maker"
    label: "Decision Maker"
    type: string
    sql: ${TABLE}.decision_maker  ;; }
  dimension: department { 
    view_label: "Contract Customer Contact"
    group_item_label: "Department"
    label: "Department"
    type: string
    sql: ${TABLE}.department  ;; }
  dimension: do_not_call { 
    view_label: "Contract Customer Contact"
    group_item_label: "Do Not Call"
    label: "Do Not Call"
    type: string
    sql: ${TABLE}.do_not_call  ;; }
  dimension: email { 
    view_label: "Contract Customer Contact"
    group_item_label: "Email"
    label: "Email"
    type: string
    sql: ${TABLE}.email  ;; }
  dimension: fax { 
    view_label: "Contract Customer Contact"
    group_item_label: "Fax"
    label: "Fax"
    type: string
    sql: ${TABLE}.fax  ;; }
  dimension: fax_country_code { 
    view_label: "Contract Customer Contact"
    group_item_label: "Fax Country Code"
    label: "Fax Country Code"
    type: string
    sql: ${TABLE}.fax_country_code  ;; }
  dimension: group_handled_by { 
    view_label: "Contract Customer Contact"
    group_item_label: "Group Handled By"
    label: "Group Handled By"
    type: string
    sql: ${TABLE}.group_handled_by  ;; }
  dimension: hasoptedoutofemail { 
    view_label: "Contract Customer Contact"
    group_item_label: "Hasoptedoutofemail"
    label: "Hasoptedoutofemail"
    type: string
    sql: ${TABLE}.hasoptedoutofemail  ;; }
  dimension: hasoptedoutoffax { 
    view_label: "Contract Customer Contact"
    group_item_label: "Hasoptedoutoffax"
    label: "Hasoptedoutoffax"
    type: string
    sql: ${TABLE}.hasoptedoutoffax  ;; }
  dimension: inactive { 
    view_label: "Contract Customer Contact"
    group_item_label: "Inactive (Yes / No)"
    label: "Inactive"
    type: yesno
    sql: ${TABLE}.inactive  ;; }
  dimension: info__track { 
    view_label: "Contract Customer Contact"
    group_item_label: "Info Track"
    label: "Info Track"
    type: string
    sql: case when ${max_pc} is not null and "{% parameter pc_or_dm %}" = "PC"  THEN "PC"
  when ${max_dm} is not null and "{% parameter pc_or_dm %}" = "DM"  THEN "DM"
  else null end  ;; }
  dimension: is_group_id { 
    view_label: "Contract Customer Contact"
    group_item_label: "Is Group ID"
    label: "Is Group ID"
    type: string
    sql: ${TABLE}.is_group_id  ;; }
  dimension: is_primary_contact { 
    view_label: "Contract Customer Contact"
    group_item_label: "Is Primary Contact"
    label: "Is Primary Contact"
    type: string
    sql: ${TABLE}.is_primary_contact  ;; }
  dimension: lastmodifiedbyid { 
    view_label: "Contract Customer Contact"
    group_item_label: "Lastmodifiedbyid"
    label: "Lastmodifiedbyid"
    type: string
    sql: ${TABLE}.lastmodifiedbyid  ;; }
  dimension: mailingcity { 
    view_label: "Contract Customer Contact"
    group_item_label: "Mailingcity"
    label: "Mailingcity"
    type: string
    sql: ${TABLE}.mailingcity  ;; }
  dimension: mailingcountrycode { 
    view_label: "Contract Customer Contact"
    group_item_label: "Mailingcountrycode"
    label: "Mailingcountrycode"
    type: string
    sql: ${TABLE}.mailingcountrycode  ;; }
  dimension: mailingpostalcode { 
    view_label: "Contract Customer Contact"
    group_item_label: "Mailingpostalcode"
    label: "Mailingpostalcode"
    type: string
    sql: ${TABLE}.mailingpostalcode  ;; }
  dimension: mailingstatecode { 
    view_label: "Contract Customer Contact"
    group_item_label: "Mailingstatecode"
    label: "Mailingstatecode"
    type: string
    sql: ${TABLE}.mailingstatecode  ;; }
  dimension: max_dm { 
    view_label: "Contract Customer Contact"
    group_item_label: "Max Dm"
    label: "Max Dm"
    type: string
    sql: ${TABLE}.max_dm  ;; }
  dimension: max_pc { 
    view_label: "Contract Customer Contact"
    group_item_label: "Max Pc"
    label: "Max Pc"
    type: string
    sql: ${TABLE}.max_pc  ;; }
  dimension: mobile_phone_country_code { 
    view_label: "Contract Customer Contact"
    group_item_label: "Mobile Phone Country Code"
    label: "Mobile Phone Country Code"
    type: string
    sql: ${TABLE}.mobile_phone_country_code  ;; }
  dimension: mobilephone { 
    view_label: "Contract Customer Contact"
    group_item_label: "Mobilephone"
    label: "Mobilephone"
    type: string
    sql: ${TABLE}.mobilephone  ;; }
  dimension: name { 
    view_label: "Contract Customer Contact"
    group_item_label: "Name"
    label: "Name"
    type: string
    sql: ${TABLE}.name  ;; }
  dimension: one_non_crm_user { 
    view_label: "Contract Customer Contact"
    group_item_label: "One Non Crm User"
    label: "One Non Crm User"
    type: string
    sql: ${TABLE}.one_non_crm_user  ;; }
  dimension: oneforce_id { 
    view_label: "Contract Customer Contact"
    group_item_label: "Oneforce ID"
    label: "Oneforce ID"
    type: string
    sql: ${TABLE}.oneforce_id  ;; }
  dimension: ownerid { 
    view_label: "Contract Customer Contact"
    group_item_label: "Ownerid"
    label: "Ownerid"
    type: string
    sql: ${TABLE}.ownerid  ;; }
  dimension: phone { 
    view_label: "Contract Customer Contact"
    group_item_label: "Phone"
    label: "Phone"
    type: string
    sql: ${TABLE}.phone  ;; }
  dimension: preferred_language { 
    view_label: "Contract Customer Contact"
    group_item_label: "Preferred Language"
    label: "Preferred Language"
    type: string
    sql: ${TABLE}.preferred_language  ;; }
  dimension: preferred_name { 
    view_label: "Contract Customer Contact"
    group_item_label: "Preferred Name"
    label: "Preferred Name"
    type: string
    sql: ${TABLE}.preferred_name  ;; }
  dimension: role { 
    view_label: "Contract Customer Contact"
    group_item_label: "Role"
    label: "Role"
    type: string
    sql: ${TABLE}.role  ;; }
  dimension: role__tile { 
    view_label: "Contact: Role-based"
    group_item_label: "Role Tile"
    label: "Role Tile"
    type: string
    sql: case when "{% parameter pc_or_dm %}" = "PC"  then "Primary Contact"
  when "{% parameter pc_or_dm %}" = "DM"  then "Decision Maker"
  else "Complete Information" end ;; }
  dimension: status_satisfies_filter { 
    view_label: "Contract Customer Contact"
    group_item_label: "Status Satisfies Filter (Yes / No)"
    label: "Status Satisfies Filter"
    type: yesno
    sql: "{% parameter pc_or_dm %}" = ${Info_Track}  ;; }
  dimension: title { 
    view_label: "Contract Customer Contact"
    group_item_label: "Title"
    label: "Title"
    type: string
    sql: ${TABLE}.title  ;; }
  dimension_group: createddate { 
    timeframes: [time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Contract Customer Contact"
    group_label: "Created Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_contract_customer_contact.createddate_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Date'%}02. Date
  {% when 'Week of year'%}03. Week of Year
  {% when 'Month num'%}04. Month
  {% when 'Quarter of year' %}05. Calendar Quarter
  {% when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {% when 'Year' %}07. Calendar Year
  {% when 'Fiscal year' %}08. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Created"
    convert_tz: no
    sql: ${TABLE}.createddate  ;; }
  dimension_group: lastmodifieddate { 
    timeframes: [time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Contract Customer Contact"
    group_label: "Last Modified Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_contract_customer_contact.lastmodifieddate_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Date'%}02. Date
  {% when 'Week of year'%}03. Week of Year
  {% when 'Month num'%}04. Month
  {% when 'Quarter of year' %}05. Calendar Quarter
  {% when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {% when 'Year' %}07. Calendar Year
  {% when 'Fiscal year' %}08. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Last Modified"
    convert_tz: no
    sql: ${TABLE}.lastmodifieddate  ;; }
  measure: count { 
    view_label: "Measure"
    group_item_label: "Count"
    label: "Count"
    type: count }
  measure: miss_and_p_cor_dm { 
    view_label: "Measure"
    group_item_label: "Miss And Completed"
    label: "Miss And Completed"
    type: count_distinct
    {field=of_contract_customer_contact.status_satisfies_filter, condition=yes, no}
    sql: ${cust_cd}  ;; }
  measure: percent_of__miss_information { 
    view_label: "Contact: Role-based"
    group_item_label: "Percent of MissInformation"
    label: "Percent of MissInformation"
    type: number
    description: "Percentage of customers without decision maker or Primary Contact, Based on the Parameter W/O PRIMARY CONTACT OR DECISION MAKER (pc_or_dm parameter field)"
    value_format: "#,##0%"
    sql: ${Total_MissInformation} / (${Total_PCorDMInformation} + ${Total_MissInformation})  ;; }
  measure: percent_of__total_p_cor_dm { 
    view_label: "Contact: Role-based"
    group_item_label: "Percent of Total PCorDM"
    label: "Percent of Total PCorDM"
    type: number
    description: "Percentage of customers having decision maker or Primary Contact, Based on the Parameter W/O PRIMARY CONTACT OR DECISION MAKER (pc_or_dm parameter field)"
    value_format: "#,##0%"
    sql: ${Total_PCorDMInformation} / (${Total_PCorDMInformation} + ${Total_MissInformation})  ;; }
  measure: total__miss_information { 
    view_label: "Measure"
    group_item_label: " Without Primary Contact
      "
    label: " Without Primary Contact
      "
    type: count_distinct
    description: "Count customers without decision maker or Primary Contact, Based on the Parameter W/O PRIMARY CONTACT OR DECISION MAKER (pc_or_dm parameter field)"
    {field=of_contract_customer_contact.status_satisfies_filter, condition=no}
    sql: ${cust_cd}  ;; }
  measure: total__miss_information1 { 
    view_label: "Measure"
    group_item_label: " Without Primary Contact
    "
    label: " Without Primary Contact
    "
    type: count_distinct
    description: "Count customers without decision maker or Primary Contact, Based on the Parameter W/O PRIMARY CONTACT OR DECISION MAKER (pc_or_dm parameter field)"
    value_format: "0.0," K""
    {condition=no, field=of_contract_customer_contact.status_satisfies_filter}
    sql: ${cust_cd}  ;; }
  measure: total__miss_information__count { 
    view_label: "Measure"
    group_item_label: " Without Primary Contact Count
      "
    label: " Without Primary Contact Count
      "
    type: count_distinct
    description: "Count customers without decision maker or Primary Contact, Based on the Parameter W/O PRIMARY CONTACT OR DECISION MAKER (pc_or_dm parameter field)"
    {condition=no, field=of_contract_customer_contact.status_satisfies_filter}
    sql: ${cust_cd}  ;; }
  measure: total_p_cor_dm_information { 
    view_label: "Measure"
    group_item_label: " With Primary Contact
      "
    label: " With Primary Contact
      "
    type: count_distinct
    description: "Count customers having decision maker or Primary Contact, Based on the Parameter W/O PRIMARY CONTACT OR DECISION MAKER (pc_or_dm parameter field)"
    value_format: "[<1000]0;[>=1000]0.0,"K""
    {condition=yes, field=of_contract_customer_contact.status_satisfies_filter}
    sql: ${cust_cd}  ;; }
  measure: total_p_cor_dm_information1 { 
    view_label: "Measure"
    group_item_label: " With Primary Contact
    "
    label: " With Primary Contact
    "
    type: count_distinct
    description: "Count customers having decision maker or Primary Contact, Based on the Parameter W/O PRIMARY CONTACT OR DECISION MAKER (pc_or_dm parameter field)"
    {condition=yes, field=of_contract_customer_contact.status_satisfies_filter}
    sql: ${cust_cd}  ;; }
  }


view: v_customer_opus_n_prospect {
  dimension: capi_amt { 
    view_label: "Contract Customers"
    group_item_label: "Capital Amount"
    label: "Capital Amount"
    type: number
    sql: ${TABLE}.CAPI_AMT  ;; }
  dimension: capi_curr_cd { 
    view_label: "Contract Customers"
    group_item_label: "Capital Currency Code"
    label: "Capital Currency Code"
    type: string
    sql: ${TABLE}.CAPI_CURR_CD  ;; }
  dimension: cntr_cust_tp_cd { 
    view_label: "Contract Customers"
    group_item_label: "Customer Type"
    label: "Customer Type"
    type: string
    sql: ${TABLE}.CNTR_CUST_TP_CD  ;; }
  dimension: commercial { 
    view_label: "Contract Customers"
    group_item_label: "Contract Customer"
    label: "Contract Customer"
    type: string
    sql: ${TABLE}.Commercial  ;; }
  dimension: contract__customer__flag { 
    view_label: "Contract Customers"
    group_item_label: "Flag to identify Contract Customer"
    label: "Flag to identify Contract Customer"
    type: string
    sql: CASE when ${Commercial} in ("false","N") THEN "No"
    else "Yes" end ;; }
  dimension: crm_if_flg { 
    view_label: "Contract Customers"
    group_item_label: "Track in CRM"
    label: "Track in CRM"
    type: string
    sql: ${TABLE}.CRM_IF_FLG  ;; }
  dimension: crnt_vol_knt { 
    view_label: "Contract Customers"
    group_item_label: "Yearly Volume (TEU)"
    label: "Yearly Volume (TEU)"
    type: number
    sql: ${TABLE}.CRNT_VOL_KNT  ;; }
  dimension: cty_nm { 
    view_label: "Contract Customers"
    group_item_label: "City"
    label: "City"
    type: string
    sql: ${TABLE}.CTY_NM  ;; }
  dimension: cust_cd { 
    view_label: "Contract Customers"
    group_item_label: "Customer Code"
    label: "Customer Code"
    type: string
    sql: ${TABLE}.CUST_CD  ;; }
  dimension: cust_cnt_cd { 
    view_label: "Contract Customers"
    group_item_label: "Country"
    label: "Country"
    type: string
    sql: ${TABLE}.CUST_CNT_CD  ;; }
  dimension: cust_div_cd { 
    view_label: "Contract Customers"
    group_item_label: "Individual/Group"
    label: "Individual/Group"
    type: string
    sql: ${TABLE}.CUST_DIV_CD  ;; }
  dimension: cust_eml { 
    view_label: "Contract Customers"
    group_item_label: "Email Address"
    label: "Email Address"
    type: string
    sql: ${TABLE}.CUST_EML  ;; }
  dimension: cust_fax { 
    view_label: "Contract Customers"
    group_item_label: "Fax"
    label: "Fax"
    type: string
    sql: ${TABLE}.CUST_FAX  ;; }
  dimension: cust_grp_comp { 
    view_label: "Contract Customers"
    group_item_label: "Customer group completion"
    label: "Customer group completion"
    type: string
    sql: CASE WHEN ${cust_grp_id} is null
  THEN 'N'
      ELSE 'Y'
      END
     ;; }
  dimension: cust_grp_hrchy_cd { 
    view_label: "Office Information"
    group_item_label: "v_customer_opus_n_prospect: Office Type Code"
    label: "v_customer_opus_n_prospect: Office Type Code"
    type: string
    sql: ${TABLE}.CUST_GRP_HRCHY_CD  ;; }
  dimension: cust_grp_hrchy_cd_dscr { 
    view_label: "Office Information"
    group_item_label: "v_customer_opus_n_prospect: Office Type"
    label: "v_customer_opus_n_prospect: Office Type"
    type: string
    sql: CASE WHEN (${cust_grp_hrchy_cd} = 'G') THEN 'Global'
    WHEN (${cust_grp_hrchy_cd} = 'R') THEN 'Regional'
    WHEN (${cust_grp_hrchy_cd} = 'C') THEN 'Country'
    WHEN (${cust_grp_hrchy_cd} = 'I') THEN 'Individual'
    ELSE ${cust_grp_hrchy_cd}
    END
     ;; }
  dimension: cust_grp_id { 
    view_label: "Contract Customers"
    group_item_label: "Customer Group Code"
    label: "Customer Group Code"
    type: string
    sql: ${TABLE}.CUST_GRP_ID  ;; }
  dimension: cust_rgst_no { 
    view_label: "Contract Customers"
    group_item_label: "Tax ID"
    label: "Tax ID"
    type: string
    sql: ${TABLE}.CUST_RGST_NO  ;; }
  dimension: customer_cd_and_name { 
    view_label: "Contract Customers"
    group_item_label: "Customer Code & Name"
    label: "Customer Code & Name"
    type: string
    sql: concat(${cust_cd}, " - ", ${name})  ;; }
  dimension: delete__flag { 
    view_label: "Contract Customers"
    group_item_label: "Delete Flag"
    label: "Delete Flag"
    type: string
    sql: case when ${delt_flg} in ("false","N") THEN "No"
      else     "Yes" end ;; }
  dimension: delt_flg { 
    view_label: "Contract Customers"
    group_item_label: "Inactive"
    label: "Inactive"
    type: string
    sql: ${TABLE}.DELT_FLG  ;; }
  dimension: finc_sts_lvl_cd { 
    view_label: "Contract Customers"
    group_item_label: "Finance Status Code"
    label: "Finance Status Code"
    type: string
    sql: ${TABLE}.FINC_STS_LVL_CD  ;; }
  dimension: frt_fwrd { 
    view_label: "Contract Customers"
    group_item_label: "Is A Forwarder?"
    label: "Is A Forwarder?"
    type: string
    sql: ${TABLE}.FRT_FWRD  ;; }
  dimension: frt_fwrd_fmc_no { 
    view_label: "Contract Customers"
    group_item_label: "Forwarder No."
    label: "Forwarder No."
    type: string
    sql: ${TABLE}.FRT_FWRD_FMC_NO  ;; }
  dimension: indiv_corp_div_cd { 
    view_label: "Contract Customers"
    group_item_label: "Firm/Private Code"
    label: "Firm/Private Code"
    type: string
    sql: ${TABLE}.INDIV_CORP_DIV_CD  ;; }
  dimension: indus_desc { 
    view_label: "Contract Customers"
    group_item_label: "Industry Type Code"
    label: "Industry Type Code"
    type: string
    sql: ${TABLE}.INDUS_DESC  ;; }
  dimension: is_ungroup_customer { 
    view_label: "Contract Customers"
    group_item_label: "Is Ungroup Customer (Yes / No)"
    label: "Is Ungroup Customer"
    type: yesno
    sql: ${cust_grp_id} IS NULL  ;; }
  dimension: key_acct_end_eff_dt { 
    view_label: "Contract Customers"
    group_item_label: "GCM Account Exp Date"
    label: "GCM Account Exp Date"
    type: date
    sql: ${TABLE}.KEY_ACCT_END_EFF_DT  ;; }
  dimension: key_acct_flg { 
    view_label: "Contract Customers"
    group_item_label: "GCM Account"
    label: "GCM Account"
    type: string
    sql: ${TABLE}.KEY_ACCT_FLG  ;; }
  dimension: key_acct_st_eff_dt { 
    view_label: "Contract Customers"
    group_item_label: "GCM Account Effective Date"
    label: "GCM Account Effective Date"
    type: date
    sql: ${TABLE}.KEY_ACCT_ST_EFF_DT  ;; }
  dimension: loc_cd { 
    view_label: "Contract Customers"
    group_item_label: "Location Code"
    label: "Location Code"
    type: string
    sql: ${TABLE}.LOC_CD  ;; }
  dimension: lsr_flg { 
    view_label: "Contract Customers"
    group_item_label: "Is a Lessor?"
    label: "Is a Lessor?"
    type: string
    sql: ${TABLE}.LSR_FLG  ;; }
  dimension: mfr_flg { 
    view_label: "Contract Customers"
    group_item_label: "Is a Manufacturer?"
    label: "Is a Manufacturer?"
    type: string
    sql: ${TABLE}.MFR_FLG  ;; }
  dimension: mlt_trd_acct_flg { 
    view_label: "Contract Customers"
    group_item_label: "Multi Trade Account"
    label: "Multi Trade Account"
    type: string
    sql: ${TABLE}.MLT_TRD_ACCT_FLG  ;; }
  dimension: name { 
    view_label: "Contract Customers"
    group_item_label: "Customer Name"
    label: "Customer Name"
    type: string
    sql: ${TABLE}.NAME  ;; }
  dimension: nbs_clss_cd1 { 
    view_label: "Contract Customers"
    group_item_label: "Customer Sub Typ Code"
    label: "Customer Sub Typ Code"
    type: string
    sql: ${TABLE}.NBS_CLSS_CD1  ;; }
  dimension: nbs_clss_cd3 { 
    view_label: "Contract Customers"
    group_item_label: "Regional Key Account"
    label: "Regional Key Account"
    type: string
    sql: ${TABLE}.NBS_CLSS_CD3  ;; }
  dimension: nmd_cust_flg { 
    view_label: "Contract Customers"
    group_item_label: "Named Customer"
    label: "Named Customer"
    type: string
    sql: ${TABLE}.NMD_CUST_FLG  ;; }
  dimension: of_cre_usr_id { 
    view_label: "Contract Customers"
    group_item_label: "Created By Id"
    label: "Created By Id"
    type: string
    sql: ${TABLE}.OF_CRE_USR_ID  ;; }
  dimension: of_owner_id { 
    view_label: "Contract Customers"
    group_item_label: "Owner Id, or Sales Person designated to this customer"
    label: "Owner Id, or Sales Person designated to this customer"
    type: string
    sql: ${TABLE}.OF_OWNER_ID  ;; }
  dimension: of_upd_usr_id { 
    view_label: "Contract Customers"
    group_item_label: "Last Modified By Id"
    label: "Last Modified By Id"
    type: string
    sql: ${TABLE}.OF_UPD_USR_ID  ;; }
  dimension: ofc__loc__cd { 
    view_label: "Office Information"
    group_item_label: "v_customer_opus_n_prospect: Office Code"
    label: "v_customer_opus_n_prospect: Office Code"
    type: string
    sql: ${TABLE}.OFC_CD  ;; }
  dimension: ofc_cd { 
    view_label: "Office Information"
    group_item_label: "Sales Rep Office"
    label: "Sales Rep Office"
    type: string
    description: "v_customer_opus_n_prospect: Admin Office Code"
    sql: ${TABLE}.OFC_CD  ;; }
  dimension: ofc_nm { 
    view_label: "Office Information"
    group_item_label: "v_customer_opus_n_prospect: Sales Person's Office"
    label: "v_customer_opus_n_prospect: Sales Person's Office"
    type: string
    sql: initcap(lower(${TABLE}.OFC_NM)) ;; }
  dimension: oneforce_id { 
    view_label: "Contract Customers"
    group_item_label: "Customer"
    label: "Customer"
    type: string
    sql: ${TABLE}.ONEForce_ID  ;; }
  dimension: owner_name { 
    view_label: "Contract Customers"
    group_item_label: "Owner Name"
    label: "Owner Name"
    type: string
    sql: ${TABLE}.of_owner_name  ;; }
  dimension: owner_name_or_srep_nm { 
    view_label: "Contract Customers"
    group_item_label: "Owner (if CRM then Srep)"
    label: "Owner (if CRM then Srep)"
    type: string
    sql: CASE WHEN upper(${owner_office_code}) = 'ZZUNCLAIMED - OFFICE' THEN ${srep_nm} ELSE ${owner_name} END  ;; }
  dimension: owner_office_code { 
    view_label: "Contract Customers"
    group_item_label: "Owner Office Code"
    label: "Owner Office Code"
    type: string
    sql: ${TABLE}.of_owner_office_code  ;; }
  dimension: parent_customer_code { 
    view_label: "Contract Customers"
    group_item_label: "Parent Customer"
    label: "Parent Customer"
    type: string
    sql: ${TABLE}.Parent_Customer_Code  ;; }
  dimension: post_code { 
    view_label: "Contract Customers"
    group_item_label: "Zip/Postal Code"
    label: "Zip/Postal Code"
    type: string
    sql: ${TABLE}.POST_CODE  ;; }
  dimension: primary_contact { 
    view_label: "Contract Customers"
    group_item_label: "Primary Contact ONEFroce ID"
    label: "Primary Contact ONEFroce ID"
    type: string
    sql: v_customer_opus_n_prospect.primary_contact ;; }
  dimension: shp_agnt_flg { 
    view_label: "Contract Customers"
    group_item_label: "Is a Shipping Agent?"
    label: "Is a Shipping Agent?"
    type: string
    sql: ${TABLE}.SHP_AGNT_FLG  ;; }
  dimension: srep_eml { 
    view_label: "Contract Customers"
    group_item_label: "Sales Rep Email"
    label: "Sales Rep Email"
    type: string
    sql: ${TABLE}.SREP_EML  ;; }
  dimension: srep_nm { 
    view_label: "Contract Customers"
    group_item_label: "Sales Rep Name"
    label: "Sales Rep Name"
    type: string
    sql: initcap(lower(${TABLE}.SREP_NM)) ;; }
  dimension_group: of_cre_dt { 
    timeframes: [time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Contract Customers"
    group_label: "Created Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'v_customer_opus_n_prospect.of_cre_dt_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Date'%}02. Date
  {% when 'Week of year'%}03. Week of Year
  {% when 'Month num'%}04. Month
  {% when 'Quarter of year' %}05. Calendar Quarter
  {% when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {% when 'Year' %}07. Calendar Year
  {% when 'Fiscal year' %}08. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Created"
    convert_tz: no
    sql: ${TABLE}.OF_CRE_DT  ;; }
  dimension_group: of_upd_dt { 
    timeframes: [time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Contract Customers"
    group_label: "Last Modified Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'v_customer_opus_n_prospect.of_upd_dt_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Date'%}02. Date
  {% when 'Week of year'%}03. Week of Year
  {% when 'Month num'%}04. Month
  {% when 'Quarter of year' %}05. Calendar Quarter
  {% when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {% when 'Year' %}07. Calendar Year
  {% when 'Fiscal year' %}08. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Last Modified"
    convert_tz: no
    sql: ${TABLE}.OF_UPD_DT  ;; }
  measure: count { 
    view_label: "Measure"
    group_item_label: "Count"
    label: "Count"
    type: count }
  measure: count_distinct__costumers { 
    view_label: "Measure"
    group_item_label: "Qty Customers"
    label: "Qty Customers"
    type: count_distinct
    sql: ${cust_cd}  ;; }
  measure: count_distinct__costumers1 { 
    view_label: "Measure"
    group_item_label: "Qty Customers Landing"
    label: "Qty Customers Landing"
    type: count_distinct
    value_format: "0.0," K""
    sql: ${cust_cd}  ;; }
  measure: qty__ungroup__customers { 
    view_label: "Measure"
    group_item_label: "Qty_Ungroup_Customers"
    label: "Qty_Ungroup_Customers"
    type: count_distinct
    sql: case when ${Cust_grp_comp} = "N" then ${cust_cd} end  ;; }
  }


view: of_customer_group {
  dimension: bklst_cust_flg { 
    view_label: "Customer Group"
    group_item_label: "Blacklist"
    label: "Blacklist"
    type: string
    sql: ${TABLE}.BKLST_CUST_FLG  ;; }
  dimension: bklst_cust_rsn { 
    view_label: "Customer Group"
    group_item_label: "Blacklist Reason"
    label: "Blacklist Reason"
    type: string
    sql: ${TABLE}.BKLST_CUST_RSN  ;; }
  dimension: cust_grp_and_name { 
    view_label: "Customer Group"
    group_item_label: "Customer Group & Name"
    label: "Customer Group & Name"
    type: string
    sql: concat(${cust_grp_id}, " - ", ${cust_grp_nm})  ;; }
  dimension: cust_grp_and_name_filtered { 
    view_label: "Customer Group"
    group_item_label: "Customer Group & Name (Exc)"
    label: "Customer Group & Name (Exc)"
    type: string
    sql: case when ${delt_flg} = 'Y' then null
    else concat(${cust_grp_id}, " - ", ${cust_grp_nm}) end  ;; }
  dimension: cust_grp_id { 
    view_label: "Customer Group"
    group_item_label: "Customer Group Code"
    label: "Customer Group Code"
    type: string
    sql: ${TABLE}.CUST_GRP_ID  ;; }
  dimension: cust_grp_nm { 
    view_label: "Customer Group"
    group_item_label: "Customer Group Name"
    label: "Customer Group Name"
    type: string
    sql: ${TABLE}.CUST_GRP_NM  ;; }
  dimension: delt_flg { 
    view_label: "Customer Group"
    group_item_label: "Deletion Flag"
    label: "Deletion Flag"
    type: string
    sql: ${TABLE}.DELT_FLG  ;; }
  dimension: global_account_manager { 
    view_label: "Customer Group"
    group_item_label: "Global Account Manager"
    label: "Global Account Manager"
    type: string
    sql: ${TABLE}.global_account_manager  ;; }
  dimension: global_customer_type { 
    view_label: "Customer Group"
    group_item_label: "Customer Type (BCO/NVO)"
    label: "Customer Type (BCO/NVO)"
    type: string
    sql: CASE WHEN ${cust_grp_id} IS NULL THEN NULL
  ELSE ( Case when ${TABLE}.global_customer_type = 'B' then 'BCO' Else 'NVO' END )
  END   ;; }
  dimension: global_customer_type_ord { 
    view_label: "Customer Group"
    group_item_label: "Global Customer Type Ord"
    label: "Global Customer Type Ord"
    type: number
    sql: case when ${TABLE}.global_customer_type = 'B' then 1 else 2 end ;; }
  dimension: is_gka { 
    view_label: "Customer Group"
    group_item_label: "Is Gka"
    label: "Is Gka"
    type: string
    sql: CASE WHEN ${key_acct_tp_cd} = 'GKA' THEN 'GKA' ELSE 'Non-GKA' END  ;; }
  dimension: key_acct_cnt_cd { 
    view_label: "Customer Group"
    group_item_label: "Key Account Country Code"
    label: "Key Account Country Code"
    type: string
    description: "GAM's country (if not available, sales rep's country of global child customer)"
    sql: ${TABLE}.srep_cnt_cd  ;; }
  dimension: key_acct_cnt_name { 
    view_label: "Customer Group"
    group_item_label: "Key Account Country"
    label: "Key Account Country"
    type: string
    description: "GAM's country (if not available, sales rep's country of global child customer)"
    sql: ${TABLE}.srep_cnt_nm  ;; }
  dimension: key_acct_flg { 
    view_label: "Customer Group"
    group_item_label: "GKA"
    label: "GKA"
    type: string
    sql: ${TABLE}.KEY_ACCT_FLG  ;; }
  dimension: key_acct_rgn_cd { 
    view_label: "Customer Group"
    group_item_label: "Key Account Region"
    label: "Key Account Region"
    type: string
    description: "GAM's region (if not available, sales rep's region of global child customer)"
    sql: ${TABLE}.srep_region  ;; }
  dimension: key_acct_tp_cd { 
    view_label: "Customer Group"
    group_item_label: "Key Account Type"
    label: "Key Account Type"
    type: string
    sql: CASE
      WHEN ${TABLE}.KEY_ACCT_TP_CD ='GKA' THEN 'GKA'
      WHEN ${TABLE}.KEY_ACCT_TP_CD ='RKA' THEN 'RKA'
      WHEN ${TABLE}.KEY_ACCT_TP_CD ='LKA' THEN 'LKA'
      WHEN ${TABLE}.KEY_ACCT_TP_CD ='SME' THEN 'ONECare'
      ELSE (CASE WHEN ${cust_grp_id} IS NULL THEN NULL ELSE 'ONECare' END)
      END  ;; }
  dimension: key_acct_tp_cd_ord { 
    view_label: "Customer Group"
    group_item_label: "Key Acct Tp Cd Ord"
    label: "Key Acct Tp Cd Ord"
    type: number
    sql: CASE
      WHEN ${TABLE}.KEY_ACCT_TP_CD ='GKA' THEN 1
      WHEN ${TABLE}.KEY_ACCT_TP_CD ='RKA' THEN 2
      WHEN ${TABLE}.KEY_ACCT_TP_CD ='LKA' THEN 3
      WHEN ${TABLE}.KEY_ACCT_TP_CD ='SME' THEN 4
      ELSE 4
      END  ;; }
  dimension: nbs_clss_cd1 { 
    view_label: "Customer Group"
    group_item_label: "Nbs Clss Cd1"
    label: "Nbs Clss Cd1"
    type: string
    sql: ${TABLE}.NBS_CLSS_CD1  ;; }
  dimension: nbs_clss_cd2 { 
    view_label: "Customer Group"
    group_item_label: "Nbs Clss Cd2"
    label: "Nbs Clss Cd2"
    type: string
    sql: ${TABLE}.NBS_CLSS_CD2  ;; }
  dimension: nbs_clss_cd3 { 
    view_label: "Customer Group"
    group_item_label: "Nbs Clss Cd3"
    label: "Nbs Clss Cd3"
    type: string
    sql: ${TABLE}.NBS_CLSS_CD3  ;; }
  dimension: ofc_cd { 
    view_label: "Office Information"
    group_item_label: "Control Office Code"
    label: "Control Office Code"
    type: string
    sql: ${TABLE}.OFC_CD  ;; }
  dimension: oneforce_id { 
    view_label: "Customer Group"
    group_item_label: "ONEForce Id"
    label: "ONEForce Id"
    type: string
    sql: ${TABLE}.ONEForce_ID  ;; }
  dimension: srep_email { 
    view_label: "Customer Group"
    group_item_label: "Sale Rep Email"
    label: "Sale Rep Email"
    type: string
    sql: ${TABLE}.SREP_EMAIL  ;; }
  dimension: srep_nm { 
    view_label: "Customer Group"
    group_item_label: "Sale Rep Name"
    label: "Sale Rep Name"
    type: string
    sql: ${TABLE}.SREP_NM  ;; }
  dimension: srep_ofc_cd { 
    view_label: "Customer Group"
    group_item_label: "Sale Rep Office"
    label: "Sale Rep Office"
    type: string
    sql: ${TABLE}.SREP_OFC_CD ;; }
  dimension: vbs_clss_cd { 
    view_label: "Customer Group"
    group_item_label: "Value based segmentation class"
    label: "Value based segmentation class"
    type: string
    sql: ${TABLE}.VBS_CLSS_CD  ;; }
  
  measure: count { 
    view_label: "Measure"
    group_item_label: "Count"
    label: "Count"
    type: count_distinct
    sql: of_customer_group.CUST_GRP_ID  ;; }
  }


view: of_customer_owner {
  dimension: city { 
    view_label: "Customer Owner"
    group_item_label: "City"
    label: "City"
    type: string
    sql: ${TABLE}.City  ;; }
  dimension: country { 
    view_label: "Customer Owner"
    group_item_label: "Country"
    label: "Country"
    type: string
    sql: ${TABLE}.Country  ;; }
  dimension: crm_trainer { 
    view_label: "Customer Owner"
    group_item_label: "CRM Trainer"
    label: "CRM Trainer"
    type: string
    sql: ${TABLE}.CRM_Trainer  ;; }
  dimension: email { 
    view_label: "Customer Owner"
    group_item_label: "Email"
    label: "Email"
    type: string
    sql: ${TABLE}.Email  ;; }
  dimension: email_2 { 
    view_label: "Customer Owner"
    group_item_label: "Email 2"
    label: "Email 2"
    type: string
    sql: ${TABLE}.Email_2  ;; }
  dimension: email_4_join_with_cust { 
    view_label: "Customer Owner"
    group_item_label: "Email 4 Join with Cust"
    label: "Email 4 Join with Cust"
    type: string
    sql: CASE WHEN ${TABLE}.TPA_user = 'true' THEN ${TABLE}.Email_2 ELSE ${TABLE}.Email END    ;; }
  dimension: first_name { 
    view_label: "Customer Owner"
    group_item_label: "FirstName"
    label: "FirstName"
    type: string
    sql: ${TABLE}.FirstName  ;; }
  dimension: full_name { 
    view_label: "Customer Owner"
    group_item_label: "Full Name"
    label: "Full Name"
    type: string
    sql: concat(${first_name}," ",${last_name})  ;; }
  dimension: full_name1 { 
    view_label: "Customer Owner"
    group_item_label: "GAM"
    label: "GAM"
    type: string
    sql: concat(${first_name}," ",${last_name})  ;; }
  dimension: geography_dynamic { 
    view_label: "Customer Owner"
    group_item_label: "Geography Dynamic Adoption DB"
    label: "Geography Dynamic Adoption DB"
    type: string
    sql: CASE
  WHEN {% parameter DB_Param %} = "RHQ" THEN ${regional_head_office_new}
  WHEN {% parameter DB_Param %} = "Country" THEN ${country}
  WHEN {% parameter DB_Param %} = "Office Code" THEN ${office_code}
  WHEN {% parameter DB_Param %} = "User Role" THEN ${user_role_name}
  WHEN {% parameter DB_Param %} = "Agent Role" THEN ${profile_name_service}
  WHEN {% parameter DB_Param %} = "Office Type" THEN ${officetype}
  ELSE "Global" END ;; }
  dimension: geography_dynamic1 { 
    view_label: "Customer Owner"
    group_item_label: "Geography Dynamic Adoption DB"
    label: "Geography Dynamic Adoption DB"
    type: string
    sql: CASE
  WHEN {% parameter DB_Param %} = "RHQ" THEN ${regional_head_office1}
  WHEN {% parameter DB_Param %} = "Country" THEN ${country}
  WHEN {% parameter DB_Param %} = "Office Code" THEN ${office_code}
  WHEN {% parameter DB_Param %} = "User Role" THEN ${user_role_name}
  WHEN {% parameter DB_Param %} = "Agent Role" THEN ${profile_name_service}
  WHEN {% parameter DB_Param %} = "Office Type" THEN ${officetype}
  ELSE "Global" END ;; }
  dimension: geography_dynamic2 { 
    view_label: "Customer Owner"
    group_item_label: "Geography Dynamic Adoption DB"
    label: "Geography Dynamic Adoption DB"
    type: string
    sql: CASE
  WHEN {% parameter DB_Param2 %} = "RHQ" THEN ${regional_head_office_5char}
  WHEN {% parameter DB_Param2%} = "Country" THEN ${country}
  WHEN {% parameter DB_Param2 %} = "Office" THEN ${office_code}
  WHEN {% parameter DB_Param2 %} = "User Role" THEN ${user_role_name}
  WHEN {% parameter DB_Param2 %} = "User Profile" THEN ${profile_name}
  WHEN {% parameter DB_Param2 %} = "Office Type" THEN ${officetype}
  ELSE "Global" END ;; }
  dimension: is_salesuser { 
    view_label: "Customer Owner"
    group_item_label: "Is Salesuser (Yes / No)"
    label: "Is Salesuser"
    type: yesno
    sql: lower(trim(${profile_name})) in ("third party agent", "sales executive")  ;; }
  dimension: isactive { 
    view_label: "Customer Owner"
    group_item_label: "Isactive"
    label: "Isactive"
    type: string
    sql: ${TABLE}.isactive  ;; }
  dimension: last_name { 
    view_label: "Customer Owner"
    group_item_label: "LastName"
    label: "LastName"
    type: string
    sql: ${TABLE}.LastName  ;; }
  dimension: manager_id { 
    view_label: "Customer Owner"
    group_item_label: "ManagerId"
    label: "ManagerId"
    type: string
    sql: ${TABLE}.ManagerId  ;; }
  dimension: name { 
    view_label: "Customer Owner"
    group_item_label: "of_customer_owner: Name"
    label: "of_customer_owner: Name"
    type: string
    sql: CASE WHEN ${first_name} IS NULL THEN ${last_name} WHEN ${last_name} IS NULL THEN ${first_name} ELSE  concat(${first_name}," ",${last_name}) END ;; }
  dimension: office__country__code { 
    view_label: "Office Information"
    group_item_label: "of_customer_owner: Office Country Name"
    label: "of_customer_owner: Office Country Name"
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
  TRIM( SUBSTR (${TABLE}.Office_Code, 1, STRPOS(${TABLE}.Office_Code, '-') -2))
        END  ;; }
  dimension: office_code { 
    view_label: "Office Information"
    group_item_label: "of_customer_owner: Office Code"
    label: "of_customer_owner: Office Code"
    type: string
    sql: ${TABLE}.Office_Code  ;; }
  dimension: office_code_new { 
    view_label: "Customer Owner"
    group_item_label: "of_customer_owner: Office Code"
    label: "of_customer_owner: Office Code"
    type: string
    sql: ${TABLE}.Office_Code_Number   ;; }
  dimension: office_code_number { 
    view_label: "Office Information"
    group_item_label: "of_customer_owner: Office Code Number"
    label: "of_customer_owner: Office Code Number"
    type: string
    sql: LTRIM(RTRIM(SUBSTR(${office_code}, LENGTH(${office_code}) - 5, 6)))   ;; }
  dimension: officetype { 
    view_label: "Customer Owner"
    group_item_label: "Office Type"
    label: "Office Type"
    type: string
    sql: IFNULL(${TABLE}.OfficeType,'Others')  ;; }
  dimension: oneforce_id { 
    view_label: "Customer Owner"
    group_item_label: "ONEForce Id"
    label: "ONEForce Id"
    type: string
    sql: ${TABLE}.ONEForce_ID  ;; }
  dimension: parent_office { 
    view_label: "Office Information"
    group_item_label: "of_customer_owner: Parent Office"
    label: "of_customer_owner: Parent Office"
    type: string
    sql: ${TABLE}.Parent_Office  ;; }
  dimension: profile_id { 
    view_label: "Customer Owner"
    group_item_label: "ProfileId"
    label: "ProfileId"
    type: string
    sql: ${TABLE}.ProfileId  ;; }
  dimension: profile_name { 
    view_label: "Customer Owner"
    group_item_label: "Profile Name"
    label: "Profile Name"
    type: string
    sql: ${TABLE}.profile_name  ;; }
  dimension: profile_name_service { 
    view_label: "Customer Owner"
    group_item_label: "Profile Name for Service"
    label: "Profile Name for Service"
    type: string
    sql: CASE
  WHEN ${TABLE}.profile_name='Customer Care Agent' THEN 'CCA'
  WHEN ${TABLE}.profile_name= 'Customer Care Supervisor' THEN 'CCS'
  WHEN ${TABLE}.profile_name IN ('Sales Executive','TPA (Service Cloud) CCS','TPA (Service Cloud) CCA') THEN ${TABLE}.profile_name
  ELSE "Others" END  ;; }
  dimension: regional_head_office { 
    view_label: "Office Information"
    group_item_label: "of_customer_owner: Regional Head Office"
    label: "of_customer_owner: Regional Head Office"
    type: string
    sql: ${TABLE}.Regional_Head_Office  ;; }
  dimension: regional_head_office1 { 
    view_label: "Office Information"
    group_item_label: "of_customer_owner: Regional Head Office"
    label: "of_customer_owner: Regional Head Office"
    type: string
    sql: case when ${regional_head_office}='Brazil - Sao Paulo - SAOHQ' then 'LAM'
    when ${regional_head_office}='Singapore - Singapore - SINHQ' then 'SAS'
    when ${regional_head_office}='United Kingdom - London - LONHQ' then 'EUA'
    when ${regional_head_office}='Hong Kong - Hong Kong - HKGHQ' then 'EAS'
    when ${regional_head_office}='United States - Richmond - RICHQ' then 'NAM'
    when ${regional_head_office}='Unclaimed - RHQ' then 'Nil'
    when ${regional_head_office}='Singapore - Singapore - SINHO' then 'SINHO' else Null End
     ;; }
  dimension: regional_head_office_5char { 
    view_label: "Office Information"
    group_item_label: "of_customer_owner: Region code"
    label: "of_customer_owner: Region code"
    type: string
    sql: case when ${TABLE}.Regional_Head_Office is not null then RIGHT(${TABLE}.Regional_Head_Office, 5)
      else "Unclaimed Region" end ;; }
  dimension: regional_head_office_new { 
    view_label: "Customer Owner"
    group_item_label: "RHQ"
    label: "RHQ"
    type: string
    sql: case
  when ${regional_head_office}='Brazil - Sao Paulo - SAOHQ' THEN 'SAOHQ'
  when ${regional_head_office}='Hong Kong - Hong Kong - HKGHQ' THEN 'HKGHQ'
  when ${regional_head_office}='United Kingdom - London - LONHQ' THEN 'LONHQ'
  when ${regional_head_office}='United States - Richmond - RICHQ' THEN 'RICHQ'
  when ${regional_head_office}='Singapore - Singapore - SINHQ' THEN 'SINHQ'
  else "Unclaimed" end ;; }
  dimension: regional_head_office_order { 
    view_label: "Office Information"
    group_item_label: "of_customer_owner: Regional Head Office Order"
    label: "of_customer_owner: Regional Head Office Order"
    type: string
    sql: case when ${regional_head_office1}='LAM : SAOHQ' then '1'
  when ${regional_head_office1}='SAS : SINHQ' then '2'
  when ${regional_head_office1}='EUA : LONHQ' then '3'
  when ${regional_head_office1}='EAS : HKGHQ' then '4'
  when ${regional_head_office1}='NAM : RICHQ' then '5'
  when ${regional_head_office1}='SINHO' then '6' else Null End
  ;; }
  dimension: regional_head_office_short_nm { 
    view_label: "Office Information"
    group_item_label: "of_customer_owner: Regional Head Office Short Name"
    label: "of_customer_owner: Regional Head Office Short Name"
    type: string
    sql: case when ${TABLE}.Regional_Head_Office is not null then trim(substr(${TABLE}.Regional_Head_Office, instr(${TABLE}.Regional_Head_Office,'-')+1))
      else "Unclaimed Region" end ;; }
  dimension: sales_person { 
    view_label: "Customer Owner"
    group_item_label: "Sales Peson"
    label: "Sales Peson"
    type: string
    sql: ${full_name}  ;; }
  dimension: sales_service_user_profile { 
    view_label: "Customer Owner"
    group_item_label: "Sales or Service User Profile"
    label: "Sales or Service User Profile"
    type: string
    sql: CASE
  WHEN {% parameter Profile_Param %} = "Service" and  ${TABLE}.profile_name IN ('Customer Care Agent', 'Customer Care Supervisor', 'Sales Executive', 'TPA (Service Cloud) CCS', 'TPA (Service Cloud) CCA') THEN 'Yes'
  WHEN {% parameter Profile_Param %} = "Sales" and ${TABLE}.profile_name IN ('Third Party Agent', 'Sales Executive') THEN 'Yes'
  WHEN {% parameter Profile_Param %} = "All" THEN 'Yes'
  ELSE 'No' END ;; }
  dimension: srep_group { 
    view_label: "Customer Owner"
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
  end  ;; }
  dimension: sub_region { 
    view_label: "Customer Owner"
    group_item_label: "Sub Region"
    label: "Sub Region"
    type: string
    sql: ${TABLE}.Sub_Region  ;; }
  dimension: suppressed_in_crm_usage_kpi_dashboard { 
    view_label: "Customer Owner"
    group_item_label: "Suppressed in CRM Usage KPI Dashboard"
    label: "Suppressed in CRM Usage KPI Dashboard"
    type: string
    sql: ${TABLE}.Suppressed_in_CRM_Usage_KPI_Dashboard  ;; }
  dimension: title { 
    view_label: "Customer Owner"
    group_item_label: "Title"
    label: "Title"
    type: string
    sql: ${TABLE}.Title  ;; }
  dimension: tpa_user { 
    view_label: "Customer Owner"
    group_item_label: "Is TPA User"
    label: "Is TPA User"
    type: string
    sql: ${TABLE}.TPA_user  ;; }
  dimension: user_office { 
    view_label: "Customer Owner"
    group_item_label: " Office
    "
    label: " Office
    "
    type: string
    sql: {% if US_Spcl_Grouping._parameter_value == "Yes" %} ${srep_group}
  {% else %} ${office_code_number}
  {% endif %}
       ;; }
  dimension: user_role_id { 
    view_label: "Customer Owner"
    group_item_label: "UserRoleId"
    label: "UserRoleId"
    type: string
    sql: ${TABLE}.UserRoleId  ;; }
  dimension: user_role_name { 
    view_label: "Customer Owner"
    group_item_label: "User Role Name"
    label: "User Role Name"
    type: string
    sql: ${TABLE}.User_Role_Name  ;; }
  dimension: username { 
    view_label: "Customer Owner"
    group_item_label: "Username"
    label: "Username"
    type: string
    sql: ${TABLE}.Username  ;; }
  dimension: username_ofqa { 
    view_label: "Customer Owner"
    group_item_label: "Username-OFQA"
    label: "Username-OFQA"
    type: string
    sql: ${TABLE}.Username || '.ofqa'  ;; }
  dimension_group: createddate { 
    timeframes: [time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Customer Owner"
    group_label: "Created Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_customer_owner.createddate_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Date'%}02. Date
  {% when 'Week of year'%}03. Week of Year
  {% when 'Month num'%}04. Month
  {% when 'Quarter of year' %}05. Calendar Quarter
  {% when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {% when 'Year' %}07. Calendar Year
  {% when 'Fiscal year' %}08. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Created"
    convert_tz: no
    sql: timestamp(${TABLE}.createddate)  ;; }
  dimension_group: lastlogindate { 
    timeframes: [time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Customer Owner"
    group_label: "Last Login Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_customer_owner.lastlogindate_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Date'%}02. Date
  {% when 'Week of year'%}03. Week of Year
  {% when 'Month num'%}04. Month
  {% when 'Quarter of year' %}05. Calendar Quarter
  {% when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {% when 'Year' %}07. Calendar Year
  {% when 'Fiscal year' %}08. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Last Login"
    convert_tz: no
    sql: timestamp(${TABLE}.LastLoginDate)  ;; }
  dimension_group: lastmodifieddate { 
    timeframes: [time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Customer Owner"
    group_label: "Last Modified Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_customer_owner.lastmodifieddate_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Date'%}02. Date
  {% when 'Week of year'%}03. Week of Year
  {% when 'Month num'%}04. Month
  {% when 'Quarter of year' %}05. Calendar Quarter
  {% when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {% when 'Year' %}07. Calendar Year
  {% when 'Fiscal year' %}08. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Last Modified"
    convert_tz: no
    sql: timestamp(${TABLE}.lastmodifieddate)  ;; }
  measure: count { 
    view_label: "Measure"
    group_item_label: "Count"
    label: "Count"
    type: count_distinct
    sql: of_customer_owner.ONEForce_ID  ;; }
  measure: salesuser_count { 
    view_label: "Customer Owner"
    group_item_label: "Salesuser Count"
    label: "Salesuser Count"
    type: number
    sql: COUNT (DISTINCT CASE WHEN lower(trim(${profile_name})) = "sales executive" THEN ${oneforce_id} END)  ;; }
  measure: user_count { 
    view_label: "Customer Owner"
    group_item_label: "User Count"
    label: "User Count"
    type: number
    sql: COUNT (distinct ${oneforce_id} )  ;; }
  }


view: of_customer_fy_teu {
  dimension: cm_amt { 
    view_label: "FY TEU"
    group_item_label: "Cm Amt"
    label: "Cm Amt"
    type: number
    sql: ${TABLE}.cm_amt  ;; }
  dimension: cust_cd { 
    view_label: "FY TEU"
    group_item_label: "Cust Cd"
    label: "Cust Cd"
    type: string
    sql: ${TABLE}.cust_cd  ;; }
  dimension: cust_grp_id { 
    view_label: "FY TEU"
    group_item_label: "Cust Grp ID"
    label: "Cust Grp ID"
    type: string
    sql: ${TABLE}.cust_grp_id  ;; }
  dimension: cust_grp_nm { 
    view_label: "FY TEU"
    group_item_label: "Cust Grp Nm"
    label: "Cust Grp Nm"
    type: string
    sql: ${TABLE}.cust_grp_nm  ;; }
  dimension: cust_nm { 
    view_label: "FY TEU"
    group_item_label: "Cust Nm"
    label: "Cust Nm"
    type: string
    sql: ${TABLE}.cust_nm  ;; }
  dimension: is_ungroup { 
    view_label: "FY TEU"
    group_item_label: "Is Ungroup (Yes / No)"
    label: "Is Ungroup"
    type: yesno
    sql: ${cust_grp_id} IS NULL  ;; }
  dimension: primkey { 
    view_label: "FY TEU"
    group_item_label: "Primkey"
    label: "Primkey"
    type: string
    sql: ${TABLE}.primkey  ;; }
  dimension: sales_week { 
    view_label: "FY TEU"
    group_item_label: "Sales Week"
    label: "Sales Week"
    type: string
    sql: ${TABLE}.sales_week  ;; }
  dimension: teu { 
    view_label: "FY TEU"
    group_item_label: "Teu"
    label: "Teu"
    type: number
    sql: ${TABLE}.teu  ;; }
  
  measure: count { 
    view_label: "Measure"
    group_item_label: "Count"
    label: "Count"
    type: count }
  measure: total_cm_amt { 
    view_label: "Measure"
    group_item_label: "Total Cm Amt"
    label: "Total Cm Amt"
    type: sum
    description: "CM till last completed month in the specified fiscal year"
    value_format: "#,##0.00"
    sql: coalesce(${cm_amt},0)  ;; }
  measure: total_cm_amt_group { 
    view_label: "Measure"
    group_item_label: "Total Cm Amt Group"
    label: "Total Cm Amt Group"
    type: sum
    value_format: "#,##0.00"
    {condition=no, field=of_customer_fy_teu.is_ungroup}
    sql: coalesce(${cm_amt},0)  ;; }
  measure: total_cm_amt_ungroup { 
    view_label: "Measure"
    group_item_label: "Total Cm Amt Ungroup"
    label: "Total Cm Amt Ungroup"
    type: sum
    value_format: "#,##0.00"
    {condition=yes, field=of_customer_fy_teu.is_ungroup}
    sql: coalesce(${cm_amt},0)  ;; }
  measure: total_teu { 
    view_label: "Measure"
    group_item_label: "Total Teu"
    label: "Total Teu"
    type: sum
    description: "TEU till last completed month in the specified fiscal year"
    value_format: "#,##0.00"
    sql: coalesce(${teu},0) ;; }
  measure: total_teu_group { 
    view_label: "Measure"
    group_item_label: "Total Teu Group"
    label: "Total Teu Group"
    type: sum
    value_format: "#,##0.00"
    {condition=no, field=of_customer_fy_teu.is_ungroup}
    sql: coalesce(${teu},0) ;; }
  measure: total_teu_ungroup { 
    view_label: "Measure"
    group_item_label: "Total Teu Ungroup"
    label: "Total Teu Ungroup"
    type: sum
    value_format: "#,##0.00"
    {field=of_customer_fy_teu.is_ungroup, condition=yes}
    sql: coalesce(${teu},0) ;; }
  }


view: of_customer {
  dimension: bklst_cust_flg { 
    view_label: "OPUS Customer"
    group_item_label: "Bklst Cust Flg"
    label: "Bklst Cust Flg"
    type: string
    sql: ${TABLE}.bklst_cust_flg  ;; }
  dimension: cust_cd { 
    view_label: "OPUS Customer"
    group_item_label: "Customer Code"
    label: "Customer Code"
    type: string
    sql: ${TABLE}.CUST_CD  ;; }
  dimension: sanc_flg { 
    view_label: "OPUS Customer"
    group_item_label: "Sanc Flg"
    label: "Sanc Flg"
    type: string
    sql: ${TABLE}.SANC_FLG  ;; }
  
  
  }


view: of_svc_contract {
  dimension: ctrt_dur_tp_cd { 
    view_label: "SC/RFA"
    group_item_label: "Contract Period Type"
    label: "Contract Period Type"
    type: string
    sql: # -- Arul OPUS Direct Link -- Start 28-- Released Jul-2021
      CASE
        WHEN ${TABLE}.CTRT_DUR_TP_CD  = 'L' THEN 'Long'
        WHEN ${TABLE}.CTRT_DUR_TP_CD  = 'M' THEN 'Medium'
        WHEN ${TABLE}.CTRT_DUR_TP_CD  = 'S' THEN 'Short'
        ELSE ${TABLE}.CTRT_DUR_TP_CD
    END
     ;; }
  dimension: ctrt_eff_dt_in_date { 
    view_label: "SC/RFA"
    group_item_label: "Contract Effective Date"
    label: "Contract Effective Date"
    type: date
    sql: ${ctrt_eff_dt_date}  ;; }
  dimension: ctrt_exp_dt_in_date { 
    view_label: "SC/RFA"
    group_item_label: "Contract Expiry Date"
    label: "Contract Expiry Date"
    type: date
    sql: ${ctrt_exp_dt_date}  ;; }
  dimension: cust_cd { 
    view_label: "SC/RFA"
    group_item_label: "Account.Customer Code "
    label: "Account.Customer Code "
    type: string
    sql: ${TABLE}.CUST_CD  ;; }
  dimension: days_to_expiry { 
    view_label: "SC/RFA"
    group_label: "Duration Days to expire"
    group_item_label: "Days"
    label: "Days Days to expire"
    type: duration_day
    sql: Start:
CURRENT_DATE() 

End:
${ctrt_exp_dt_date} ;; }
  dimension: expiry_indicator { 
    view_label: "SC/RFA"
    group_item_label: "Expiry Indicator"
    label: "Expiry Indicator"
    type: string
    sql: CASE WHEN ${days_to_expiry} is null then null
      WHEN ${days_to_expiry} < 0 THEN 'Expired'
      WHEN ${days_to_expiry} < 7 THEN '7 Days before expiration'
      WHEN ${days_to_expiry} < 14 THEN '14 Days before expiration'
      WHEN ${days_to_expiry} < 21 THEN '21 Days before expiration'
      ELSE 'Active'
      END
   ;; }
  dimension: expiry_indicator2 { 
    view_label: "SC/RFA"
    group_item_label: "Expiry Indicator2"
    label: "Expiry Indicator2"
    type: string
    sql: CASE
      WHEN ${days_to_expiry} is null THEN '> 90'
      WHEN ${days_to_expiry} < 0     THEN 'Expired'
      WHEN ${days_to_expiry} <= 30   THEN '0 - 30'
      WHEN ${days_to_expiry} <= 60   THEN '31 - 60'
      WHEN ${days_to_expiry} <= 90   THEN '61 - 90'
  ELSE '> 90'
      END
   ;; }
  dimension: expiry_indicator2_ord { 
    view_label: "SC/RFA"
    group_item_label: "Expiry Indicator2 Ord"
    label: "Expiry Indicator2 Ord"
    type: number
    sql: CASE
      WHEN ${days_to_expiry} is null then 5
      WHEN ${days_to_expiry} < 0   THEN 1
      WHEN ${days_to_expiry} <= 30 THEN 2
      WHEN ${days_to_expiry} <= 60 THEN 3
      WHEN ${days_to_expiry} <= 90 THEN 4
      ELSE 5
      END
   ;; }
  dimension: gamt_flg { 
    view_label: "SC/RFA"
    group_item_label: "Exempt Flag"
    label: "Exempt Flag"
    type: string
    sql: ${TABLE}.GAMT_FLG  ;; }
  dimension: hours_to_expiry { 
    view_label: "SC/RFA"
    group_label: "Duration Days to expire"
    group_item_label: "Hours"
    label: "Hours Days to expire"
    type: duration_hour
    sql: Start:
CURRENT_DATE() 

End:
${ctrt_exp_dt_date} ;; }
  dimension: is_non_oq_contract { 
    view_label: "SC/RFA"
    group_item_label: "Is Non-ONEQuote Contract"
    label: "Is Non-ONEQuote Contract"
    type: number
    sql: ${TABLE}.is_non_oq_contract  ;; }
  dimension: is_one__quote { 
    view_label: "SC/RFA"
    group_item_label: "Is ONE Quote? (Yes / No)"
    label: "Is ONE Quote"
    type: yesno
    sql: ${number_non_oq_contract} = 0  ;; }
  dimension: minutes_to_expiry { 
    view_label: "Measure"
    group_label: "Duration Days to expire"
    group_item_label: "Minutes"
    label: "Minutes Days to expire"
    type: duration_minute
    sql: Start:
CURRENT_DATE() 

End:
${ctrt_exp_dt_date} ;; }
  dimension: months_to_expiry { 
    view_label: "SC/RFA"
    group_label: "Duration Days to expire"
    group_item_label: "Months"
    label: "Months Days to expire"
    type: duration_month
    sql: Start:
CURRENT_DATE() 

End:
${ctrt_exp_dt_date} ;; }
  dimension: number_non_oq_contract { 
    view_label: "SC/RFA"
    group_item_label: "Number of Non-ONEQuote contracts"
    label: "Number of Non-ONEQuote contracts"
    type: number
    sql: ${TABLE}.number_non_oq_contract  ;; }
  dimension: ofc_cd { 
    view_label: "Office Information"
    group_item_label: "Request Office "
    label: "Request Office "
    type: string
    sql: ${TABLE}.OFC_CD  ;; }
  dimension: oneforce_id { 
    view_label: "SC/RFA"
    group_item_label: "ONEForce Id"
    label: "ONEForce Id"
    type: string
    sql: ${TABLE}.ONEForce_ID  ;; }
  dimension: period_typ_cd { 
    view_label: "SC/RFA"
    group_item_label: "Period Typ Cd"
    label: "Period Typ Cd"
    type: string
    sql: ${TABLE}.CTRT_DUR_TP_CD  ;; }
  dimension: quarters_to_expiry { 
    view_label: "SC/RFA"
    group_label: "Duration Days to expire"
    group_item_label: "Quarters"
    label: "Quarters Days to expire"
    type: duration_quarter
    sql: Start:
CURRENT_DATE() 

End:
${ctrt_exp_dt_date} ;; }
  dimension: sc_rfa_no { 
    view_label: "SC/RFA"
    group_item_label: "SVC / RFA No."
    label: "SVC / RFA No."
    type: string
    sql: ${TABLE}.SC_RFA_NO  ;; }
  dimension: sc_rfa_typ { 
    view_label: "SC/RFA"
    group_item_label: "Contract Type Code"
    label: "Contract Type Code"
    type: string
    sql: ${TABLE}.SC_RFA_TYP  ;; }
  dimension: sc_rfa_typ_dscr { 
    view_label: "SC/RFA"
    group_item_label: "Contract Type (RFA vs S/C)"
    label: "Contract Type (RFA vs S/C)"
    type: string
    sql: CASE
WHEN of_svc_contract.SC_RFA_TYP = 'R' THEN 'RFA'
WHEN of_svc_contract.SC_RFA_TYP = 'S' THEN 'S/C'
WHEN of_svc_contract.SC_RFA_TYP = 'T' THEN 'Tariff'
ELSE 'Other'
END ;; }
  dimension: seconds_to_expiry { 
    view_label: "SC/RFA"
    group_label: "Duration Days to expire"
    group_item_label: "Seconds"
    label: "Seconds Days to expire"
    type: duration_second
    sql: Start:
CURRENT_DATE() 

End:
${ctrt_exp_dt_date} ;; }
  dimension: srep_cd { 
    view_label: "SC/RFA"
    group_item_label: "Sales Rep Code "
    label: "Sales Rep Code "
    type: string
    sql: ${TABLE}.SREP_CD  ;; }
  dimension: srep_eml { 
    view_label: "SC/RFA"
    group_item_label: "Sales Rep Email "
    label: "Sales Rep Email "
    type: string
    sql: ${TABLE}.SREP_EML  ;; }
  dimension: srep_nm { 
    view_label: "SC/RFA"
    group_item_label: "Sales Rep Name "
    label: "Sales Rep Name "
    type: string
    sql: ${TABLE}.SREP_NM  ;; }
  dimension: sts_cd { 
    view_label: "SC/RFA"
    group_item_label: "Status"
    label: "Status"
    type: string
    sql: ${TABLE}.STS_CD  ;; }
  dimension: tgr_src_flg { 
    view_label: "SC/RFA"
    group_item_label: "Source of Quote"
    label: "Source of Quote"
    type: string
    sql: ${TABLE}.TGR_SRC_FLG  ;; }
  dimension: trf_ctrt_flg { 
    view_label: "SC/RFA"
    group_item_label: "Tariff Flag"
    label: "Tariff Flag"
    type: string
    sql: ${TABLE}.TRF_CTRT_FLG  ;; }
  dimension: via_one__quote { 
    view_label: "SC/RFA"
    group_item_label: "Via ONE Quote"
    label: "Via ONE Quote"
    type: string
    sql: case
      when LEFT(${TABLE}.SC_RFA_NO, 3) = "KTR" THEN "Y"
      when regexp_contains(substr(${TABLE}.SC_RFA_NO,1,3) , r'^[RS][1234567890JQ][ABCDEFGHIJ]$') THEN "Y"
      ELSE "N"
      END
     ;; }
  dimension: via_one__quote_yesno { 
    view_label: "SC/RFA"
    group_item_label: "Via ONE Quote (Yes/No)"
    label: "Via ONE Quote (Yes/No)"
    type: string
    sql: case ${via_ONE_Quote} when 'Y' then 'Yes' else  'No' end  ;; }
  dimension: weeks_to_expiry { 
    view_label: "SC/RFA"
    group_label: "Duration Days to expire"
    group_item_label: "Weeks"
    label: "Weeks Days to expire"
    type: duration_week
    sql: Start:
CURRENT_DATE() 

End:
${ctrt_exp_dt_date} ;; }
  dimension: years_to_expiry { 
    view_label: "SC/RFA"
    group_label: "Duration Days to expire"
    group_item_label: "Years"
    label: "Years Days to expire"
    type: duration_year
    sql: Start:
CURRENT_DATE() 

End:
${ctrt_exp_dt_date} ;; }
  dimension_group: cre_dt { 
    timeframes: [time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "SC/RFA"
    group_label: "Created Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_svc_contract.cre_dt_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Date'%}02. Date
  {% when 'Week of year'%}03. Week of Year
  {% when 'Month num'%}04. Month
  {% when 'Quarter of year' %}05. Calendar Quarter
  {% when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {% when 'Year' %}07. Calendar Year
  {% when 'Fiscal year' %}08. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Created"
    convert_tz: no
    sql: ${TABLE}.CRE_DT  ;; }
  dimension_group: ctrt_eff_dt { 
    timeframes: [time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "SC/RFA"
    group_label: "Start Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_svc_contract.ctrt_eff_dt_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Date'%}02. Date
  {% when 'Week of year'%}03. Week of Year
  {% when 'Month num'%}04. Month
  {% when 'Quarter of year' %}05. Calendar Quarter
  {% when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {% when 'Year' %}07. Calendar Year
  {% when 'Fiscal year' %}08. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Start"
    convert_tz: no
    sql: ${TABLE}.CTRT_EFF_DT  ;; }
  dimension_group: ctrt_exp_dt { 
    timeframes: [time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "SC/RFA"
    group_label: "End Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_svc_contract.ctrt_exp_dt_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Date'%}02. Date
  {% when 'Week of year'%}03. Week of Year
  {% when 'Month num'%}04. Month
  {% when 'Quarter of year' %}05. Calendar Quarter
  {% when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {% when 'Year' %}07. Calendar Year
  {% when 'Fiscal year' %}08. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "End"
    convert_tz: no
    sql: ${TABLE}.CTRT_EXP_DT  ;; }
  measure: count { 
    view_label: "Measure"
    group_item_label: "Count"
    label: "Count"
    type: count }
  }


view: of_office_custom {
  dimension: inactive { 
    view_label: "Office Information"
    group_item_label: "of_office_custom: Inactive"
    label: "of_office_custom: Inactive"
    type: string
    sql: ${TABLE}.Inactive  ;; }
  dimension: location_code { 
    view_label: "Office Information"
    group_item_label: "of_office_custom: Location Code"
    label: "of_office_custom: Location Code"
    type: string
    sql: ${TABLE}.Location_Code  ;; }
  dimension: office_code { 
    view_label: "Office Information"
    group_item_label: "of_office_custom: Code"
    label: "of_office_custom: Code"
    type: string
    sql: ${TABLE}.Office_Code  ;; }
  dimension: office_name { 
    view_label: "Office Information"
    group_item_label: "of_office_custom: Name"
    label: "of_office_custom: Name"
    type: string
    sql: initcap(lower(${TABLE}.Office_Name))  ;; }
  
  measure: count { 
    view_label: "Measure"
    group_item_label: "of_office_custom: Count"
    label: "of_office_custom: Count"
    type: count_distinct
    sql: of_office_custom.Office_Code  ;; }
  }


view: of_user {
  dimension: city { 
    view_label: "Sales Rep"
    group_item_label: "City"
    label: "City"
    type: string
    sql: ${TABLE}.City  ;; }
  dimension: country { 
    view_label: "Sales Rep"
    group_item_label: "Country"
    label: "Country"
    type: string
    sql: ${TABLE}.Country  ;; }
  dimension: crm_trainer { 
    view_label: "Sales Rep"
    group_item_label: "CRM Trainer"
    label: "CRM Trainer"
    type: string
    sql: ${TABLE}.CRM_Trainer  ;; }
  dimension: email { 
    view_label: "Sales Rep"
    group_item_label: "Email"
    label: "Email"
    type: string
    sql: ${TABLE}.Email  ;; }
  dimension: email_2 { 
    view_label: "Sales Rep"
    group_item_label: "Email 2"
    label: "Email 2"
    type: string
    sql: ${TABLE}.Email_2  ;; }
  dimension: email_4_join_with_cust { 
    view_label: "Sales Rep"
    group_item_label: "Email 4 Join with Cust"
    label: "Email 4 Join with Cust"
    type: string
    sql: CASE WHEN ${TABLE}.TPA_user = 'true' THEN ${TABLE}.Email_2 ELSE ${TABLE}.Email END    ;; }
  dimension: first_name { 
    view_label: "Sales Rep"
    group_item_label: "FirstName"
    label: "FirstName"
    type: string
    sql: ${TABLE}.FirstName  ;; }
  dimension: full_name { 
    view_label: "Sales Rep"
    group_item_label: "Full Name"
    label: "Full Name"
    type: string
    sql: concat(${first_name}," ",${last_name})  ;; }
  dimension: full_name1 { 
    view_label: "Sales Rep"
    group_item_label: "GAM"
    label: "GAM"
    type: string
    sql: concat(${first_name}," ",${last_name})  ;; }
  dimension: geography_dynamic { 
    view_label: "Sales Rep"
    group_item_label: "Geography Dynamic Adoption DB"
    label: "Geography Dynamic Adoption DB"
    type: string
    sql: CASE
  WHEN {% parameter DB_Param %} = "RHQ" THEN ${regional_head_office_new}
  WHEN {% parameter DB_Param %} = "Country" THEN ${country}
  WHEN {% parameter DB_Param %} = "Office Code" THEN ${office_code}
  WHEN {% parameter DB_Param %} = "User Role" THEN ${user_role_name}
  WHEN {% parameter DB_Param %} = "Agent Role" THEN ${profile_name_service}
  WHEN {% parameter DB_Param %} = "Office Type" THEN ${officetype}
  ELSE "Global" END ;; }
  dimension: geography_dynamic1 { 
    view_label: "Sales Rep"
    group_item_label: "Geography Dynamic Adoption DB"
    label: "Geography Dynamic Adoption DB"
    type: string
    sql: CASE
  WHEN {% parameter DB_Param %} = "RHQ" THEN ${regional_head_office1}
  WHEN {% parameter DB_Param %} = "Country" THEN ${country}
  WHEN {% parameter DB_Param %} = "Office Code" THEN ${office_code}
  WHEN {% parameter DB_Param %} = "User Role" THEN ${user_role_name}
  WHEN {% parameter DB_Param %} = "Agent Role" THEN ${profile_name_service}
  WHEN {% parameter DB_Param %} = "Office Type" THEN ${officetype}
  ELSE "Global" END ;; }
  dimension: geography_dynamic2 { 
    view_label: "Sales Rep"
    group_item_label: "Geography Dynamic Adoption DB"
    label: "Geography Dynamic Adoption DB"
    type: string
    sql: CASE
  WHEN {% parameter DB_Param2 %} = "RHQ" THEN ${regional_head_office_5char}
  WHEN {% parameter DB_Param2%} = "Country" THEN ${country}
  WHEN {% parameter DB_Param2 %} = "Office" THEN ${office_code}
  WHEN {% parameter DB_Param2 %} = "User Role" THEN ${user_role_name}
  WHEN {% parameter DB_Param2 %} = "User Profile" THEN ${profile_name}
  WHEN {% parameter DB_Param2 %} = "Office Type" THEN ${officetype}
  ELSE "Global" END ;; }
  dimension: is_salesuser { 
    view_label: "Sales Rep"
    group_item_label: "Is Salesuser (Yes / No)"
    label: "Is Salesuser"
    type: yesno
    sql: lower(trim(${profile_name})) in ("third party agent", "sales executive")  ;; }
  dimension: isactive { 
    view_label: "Sales Rep"
    group_item_label: "Isactive"
    label: "Isactive"
    type: string
    sql: ${TABLE}.isactive  ;; }
  dimension: last_name { 
    view_label: "Sales Rep"
    group_item_label: "LastName"
    label: "LastName"
    type: string
    sql: ${TABLE}.LastName  ;; }
  dimension: manager_id { 
    view_label: "Sales Rep"
    group_item_label: "ManagerId"
    label: "ManagerId"
    type: string
    sql: ${TABLE}.ManagerId  ;; }
  dimension: name { 
    view_label: "Sales Rep"
    group_item_label: "of_user: Name"
    label: "of_user: Name"
    type: string
    sql: CASE WHEN ${first_name} IS NULL THEN ${last_name} WHEN ${last_name} IS NULL THEN ${first_name} ELSE  concat(${first_name}," ",${last_name}) END ;; }
  dimension: office__country__code { 
    view_label: "Office Information"
    group_item_label: "of_user: Office Country Name"
    label: "of_user: Office Country Name"
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
  TRIM( SUBSTR (${TABLE}.Office_Code, 1, STRPOS(${TABLE}.Office_Code, '-') -2))
        END  ;; }
  dimension: office_code { 
    view_label: "Office Information"
    group_item_label: "of_user: Office Code"
    label: "of_user: Office Code"
    type: string
    sql: ${TABLE}.Office_Code  ;; }
  dimension: office_code_new { 
    view_label: "Sales Rep"
    group_item_label: "of_user: Office Code"
    label: "of_user: Office Code"
    type: string
    sql: ${TABLE}.Office_Code_Number   ;; }
  dimension: office_code_number { 
    view_label: "Office Information"
    group_item_label: "of_user: Office Code Number"
    label: "of_user: Office Code Number"
    type: string
    sql: LTRIM(RTRIM(SUBSTR(${office_code}, LENGTH(${office_code}) - 5, 6)))   ;; }
  dimension: officetype { 
    view_label: "Sales Rep"
    group_item_label: "Office Type"
    label: "Office Type"
    type: string
    sql: IFNULL(${TABLE}.OfficeType,'Others')  ;; }
  dimension: oneforce_id { 
    view_label: "Sales Rep"
    group_item_label: "ONEForce Id"
    label: "ONEForce Id"
    type: string
    sql: ${TABLE}.ONEForce_ID  ;; }
  dimension: parent_office { 
    view_label: "Office Information"
    group_item_label: "of_user: Parent Office"
    label: "of_user: Parent Office"
    type: string
    sql: ${TABLE}.Parent_Office  ;; }
  dimension: profile_id { 
    view_label: "Sales Rep"
    group_item_label: "ProfileId"
    label: "ProfileId"
    type: string
    sql: ${TABLE}.ProfileId  ;; }
  dimension: profile_name { 
    view_label: "Sales Rep"
    group_item_label: "Profile Name"
    label: "Profile Name"
    type: string
    sql: ${TABLE}.profile_name  ;; }
  dimension: profile_name_service { 
    view_label: "Sales Rep"
    group_item_label: "Profile Name for Service"
    label: "Profile Name for Service"
    type: string
    sql: CASE
  WHEN ${TABLE}.profile_name='Customer Care Agent' THEN 'CCA'
  WHEN ${TABLE}.profile_name= 'Customer Care Supervisor' THEN 'CCS'
  WHEN ${TABLE}.profile_name IN ('Sales Executive','TPA (Service Cloud) CCS','TPA (Service Cloud) CCA') THEN ${TABLE}.profile_name
  ELSE "Others" END  ;; }
  dimension: regional_head_office { 
    view_label: "Office Information"
    group_item_label: "of_user: Regional Head Office"
    label: "of_user: Regional Head Office"
    type: string
    sql: ${TABLE}.Regional_Head_Office  ;; }
  dimension: regional_head_office1 { 
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
     ;; }
  dimension: regional_head_office_5char { 
    view_label: "Office Information"
    group_item_label: "of_user: Region code"
    label: "of_user: Region code"
    type: string
    sql: case when ${TABLE}.Regional_Head_Office is not null then RIGHT(${TABLE}.Regional_Head_Office, 5)
      else "Unclaimed Region" end ;; }
  dimension: regional_head_office_new { 
    view_label: "Sales Rep"
    group_item_label: "RHQ"
    label: "RHQ"
    type: string
    sql: case
  when ${regional_head_office}='Brazil - Sao Paulo - SAOHQ' THEN 'SAOHQ'
  when ${regional_head_office}='Hong Kong - Hong Kong - HKGHQ' THEN 'HKGHQ'
  when ${regional_head_office}='United Kingdom - London - LONHQ' THEN 'LONHQ'
  when ${regional_head_office}='United States - Richmond - RICHQ' THEN 'RICHQ'
  when ${regional_head_office}='Singapore - Singapore - SINHQ' THEN 'SINHQ'
  else "Unclaimed" end ;; }
  dimension: regional_head_office_order { 
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
  ;; }
  dimension: regional_head_office_short_nm { 
    view_label: "Office Information"
    group_item_label: "of_user: Regional Head Office Short Name"
    label: "of_user: Regional Head Office Short Name"
    type: string
    sql: case when ${TABLE}.Regional_Head_Office is not null then trim(substr(${TABLE}.Regional_Head_Office, instr(${TABLE}.Regional_Head_Office,'-')+1))
      else "Unclaimed Region" end ;; }
  dimension: sales_person { 
    view_label: "Sales Rep"
    group_item_label: "Sales Peson"
    label: "Sales Peson"
    type: string
    sql: ${full_name}  ;; }
  dimension: sales_service_user_profile { 
    view_label: "Sales Rep"
    group_item_label: "Sales or Service User Profile"
    label: "Sales or Service User Profile"
    type: string
    sql: CASE
  WHEN {% parameter Profile_Param %} = "Service" and  ${TABLE}.profile_name IN ('Customer Care Agent', 'Customer Care Supervisor', 'Sales Executive', 'TPA (Service Cloud) CCS', 'TPA (Service Cloud) CCA') THEN 'Yes'
  WHEN {% parameter Profile_Param %} = "Sales" and ${TABLE}.profile_name IN ('Third Party Agent', 'Sales Executive') THEN 'Yes'
  WHEN {% parameter Profile_Param %} = "All" THEN 'Yes'
  ELSE 'No' END ;; }
  dimension: srep_group { 
    view_label: "Sales Rep"
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
  end  ;; }
  dimension: sub_region { 
    view_label: "Sales Rep"
    group_item_label: "Sub Region"
    label: "Sub Region"
    type: string
    sql: ${TABLE}.Sub_Region  ;; }
  dimension: suppressed_in_crm_usage_kpi_dashboard { 
    view_label: "Sales Rep"
    group_item_label: "Suppressed in CRM Usage KPI Dashboard"
    label: "Suppressed in CRM Usage KPI Dashboard"
    type: string
    sql: ${TABLE}.Suppressed_in_CRM_Usage_KPI_Dashboard  ;; }
  dimension: title { 
    view_label: "Sales Rep"
    group_item_label: "Title"
    label: "Title"
    type: string
    sql: ${TABLE}.Title  ;; }
  dimension: tpa_user { 
    view_label: "Sales Rep"
    group_item_label: "Is TPA User"
    label: "Is TPA User"
    type: string
    sql: ${TABLE}.TPA_user  ;; }
  dimension: user_office { 
    view_label: "Sales Rep"
    group_item_label: " Office
    "
    label: " Office
    "
    type: string
    sql: {% if US_Spcl_Grouping._parameter_value == "Yes" %} ${srep_group}
  {% else %} ${office_code_number}
  {% endif %}
       ;; }
  dimension: user_role_id { 
    view_label: "Sales Rep"
    group_item_label: "UserRoleId"
    label: "UserRoleId"
    type: string
    sql: ${TABLE}.UserRoleId  ;; }
  dimension: user_role_name { 
    view_label: "Sales Rep"
    group_item_label: "User Role Name"
    label: "User Role Name"
    type: string
    sql: ${TABLE}.User_Role_Name  ;; }
  dimension: username { 
    view_label: "Sales Rep"
    group_item_label: "Username"
    label: "Username"
    type: string
    sql: ${TABLE}.Username  ;; }
  dimension: username_ofqa { 
    view_label: "Sales Rep"
    group_item_label: "Username-OFQA"
    label: "Username-OFQA"
    type: string
    sql: ${TABLE}.Username || '.ofqa'  ;; }
  dimension_group: createddate { 
    timeframes: [time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Sales Rep"
    group_label: "Created Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_user.createddate_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Date'%}02. Date
  {% when 'Week of year'%}03. Week of Year
  {% when 'Month num'%}04. Month
  {% when 'Quarter of year' %}05. Calendar Quarter
  {% when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {% when 'Year' %}07. Calendar Year
  {% when 'Fiscal year' %}08. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Created"
    convert_tz: no
    sql: timestamp(${TABLE}.createddate)  ;; }
  dimension_group: lastlogindate { 
    timeframes: [time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Sales Rep"
    group_label: "Last Login Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_user.lastlogindate_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Date'%}02. Date
  {% when 'Week of year'%}03. Week of Year
  {% when 'Month num'%}04. Month
  {% when 'Quarter of year' %}05. Calendar Quarter
  {% when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {% when 'Year' %}07. Calendar Year
  {% when 'Fiscal year' %}08. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Last Login"
    convert_tz: no
    sql: timestamp(${TABLE}.LastLoginDate)  ;; }
  dimension_group: lastmodifieddate { 
    timeframes: [time,
  date,
  week_of_year,
  month_num,
  quarter_of_year,
  fiscal_quarter_of_year,
  year,
  fiscal_year]
    type: time
    view_label: "Sales Rep"
    group_label: "Last Modified Date (Local)"
    group_item_label: "{% assign timeframe = _field._name | remove: 'of_user.lastmodifieddate_' | replace: '_',' ' | capitalize %}
  {% case timeframe%}
  {% when 'Time'%}01. Date Time
  {% when 'Date'%}02. Date
  {% when 'Week of year'%}03. Week of Year
  {% when 'Month num'%}04. Month
  {% when 'Quarter of year' %}05. Calendar Quarter
  {% when 'Fiscal quarter of year' %}06. Fiscal Quarter
  {% when 'Year' %}07. Calendar Year
  {% when 'Fiscal year' %}08. Fiscal Year
  {% else %}{{timeframe}}{% endcase %}"
    label: "Last Modified"
    convert_tz: no
    sql: timestamp(${TABLE}.lastmodifieddate)  ;; }
  measure: count { 
    view_label: "Measure"
    group_item_label: "Count"
    label: "Count"
    type: count }
  measure: salesuser_count { 
    view_label: "Sales Rep"
    group_item_label: "Salesuser Count"
    label: "Salesuser Count"
    type: number
    sql: COUNT (DISTINCT CASE WHEN lower(trim(${profile_name})) = "sales executive" THEN ${oneforce_id} END)  ;; }
  measure: user_count { 
    view_label: "Sales Rep"
    group_item_label: "User Count"
    label: "User Count"
    type: number
    sql: COUNT (distinct ${oneforce_id} )  ;; }
  }


view: of_country {
  dimension: country_code { 
    view_label: "Sales Rep Country"
    group_item_label: "Country Code"
    label: "Country Code"
    type: string
    sql: ${TABLE}.Country_Code  ;; }
  dimension: country_name { 
    view_label: "Sales Rep Country"
    group_item_label: "Country Name
  "
    label: "Country Name
  "
    type: string
    sql: ${TABLE}.Country_Name  ;; }
  dimension: currency_code { 
    view_label: "Sales Rep Country"
    group_item_label: "Currency Code"
    label: "Currency Code"
    type: string
    sql: ${TABLE}.Currency_Code  ;; }
  dimension: dummy { 
    view_label: "Sales Rep Country"
    group_item_label: "Dummy"
    label: "Dummy"
    type: string
    sql: DUMMY'  ;; }
  dimension: eu_country_flag { 
    view_label: "Sales Rep Country"
    group_item_label: "Eu Country Flag"
    label: "Eu Country Flag"
    type: string
    sql: ${TABLE}.EU_Country_Flag  ;; }
  dimension: inactive { 
    view_label: "Sales Rep Country"
    group_item_label: "Inactive"
    label: "Inactive"
    type: string
    sql: ${TABLE}.Inactive  ;; }
  dimension: oneforce_id { 
    view_label: "Sales Rep Country"
    group_item_label: "Oneforce ID"
    label: "Oneforce ID"
    type: string
    sql: ${TABLE}.ONEForce_ID  ;; }
  dimension: sub_continent_code { 
    view_label: "Sales Rep Country"
    group_item_label: "Sub Continent Code"
    label: "Sub Continent Code"
    type: string
    sql: ${TABLE}.Sub_Continent_Code  ;; }
  
  measure: count { 
    view_label: "Measure"
    group_item_label: "Count"
    label: "Count"
    type: count_distinct
    sql: of_country.Country_Code  ;; }
  }


view: of_reg_ref {
  dimension: cust_cnt_cd { 
    view_label: "Sales Rep Region"
    group_item_label: "Customer country"
    label: "Customer country"
    type: string
    description: "Customer Country adm"
    sql: ${TABLE}.CUST_CNT_CD  ;; }
  dimension: dummy { 
    view_label: "Sales Rep Region"
    group_item_label: "Dummy"
    label: "Dummy"
    type: string
    sql: DUMMY'  ;; }
  dimension: reg_cust_cnt_cd { 
    view_label: "Sales Rep Region"
    group_item_label: "Reg Cust Cnt Cd"
    label: "Reg Cust Cnt Cd"
    type: string
    sql: ${TABLE}.REG_CUST_CNT_CD  ;; }
  dimension: reg_nm1 { 
    view_label: "Sales Rep Region"
    group_item_label: "Region Name"
    label: "Region Name"
    type: string
    sql: ${TABLE}.REG_NM1  ;; }
  dimension: reg_nm2 { 
    view_label: "Sales Rep Region"
    group_item_label: "Reg Nm2"
    label: "Reg Nm2"
    type: string
    sql: ${TABLE}.REG_NM2  ;; }
  dimension: reg_rhq_abbrev { 
    view_label: "Sales Rep Region"
    group_item_label: "Region Abbrev"
    label: "Region Abbrev"
    type: string
    sql: CASE
WHEN of_reg_ref.reg_cust_cnt_cd = "BR"  THEN 'LAM'
WHEN of_reg_ref.reg_cust_cnt_cd = "US"  THEN 'NAM'
WHEN of_reg_ref.reg_cust_cnt_cd = "HK"  THEN 'EAS'
WHEN of_reg_ref.reg_cust_cnt_cd = "SG"  THEN 'SAS'
WHEN of_reg_ref.reg_cust_cnt_cd = "GB"  THEN 'EUA'

END ;; }
  dimension: reg_rhq_code { 
    view_label: "Sales Rep Region"
    group_item_label: "RHQ"
    label: "RHQ"
    type: string
    sql: CASE
WHEN of_reg_ref.reg_cust_cnt_cd = "BR"  THEN 'SAOHQ'
WHEN of_reg_ref.reg_cust_cnt_cd = "US"  THEN 'RICHQ'
WHEN of_reg_ref.reg_cust_cnt_cd = "HK"  THEN 'HKGHQ'
WHEN of_reg_ref.reg_cust_cnt_cd = "SG"  THEN 'SINHQ'
WHEN of_reg_ref.reg_cust_cnt_cd = "GB"  THEN 'LONHQ'

END ;; }
  dimension: reg_rhq_name { 
    view_label: "Sales Rep Region"
    group_item_label: "Reg Rhq Name"
    label: "Reg Rhq Name"
    type: string
    sql: CASE
WHEN of_reg_ref.reg_cust_cnt_cd = "BR" THEN 'Brazil - Sao Paulo - SAOHQ'
WHEN of_reg_ref.reg_cust_cnt_cd = "US" THEN 'United States - Richmond - RICHQ'
WHEN of_reg_ref.reg_cust_cnt_cd = "HK" THEN 'Hong Kong - Hong Kong - HKGHQ'
WHEN of_reg_ref.reg_cust_cnt_cd = "SG" THEN 'Singapore - Singapore - SINHQ'
WHEN of_reg_ref.reg_cust_cnt_cd = "GB" THEN 'United Kingdom - London - LONHQ'

END ;; }
  
  
  }


view: of_sales_week_master {
  dimension: calendar_year { 
    view_label: "Sales Week Master"
    group_item_label: "Calendar Year"
    label: "Calendar Year"
    type: string
    sql: ${TABLE}.Calendar_Year  ;; }
  dimension: fiscal_year { 
    view_label: "Sales Week Master"
    group_item_label: "Fiscal Year"
    label: "Fiscal Year"
    type: string
    sql: ${TABLE}.Fiscal_Year  ;; }
  dimension: sales_month { 
    view_label: "Sales Week Master"
    group_item_label: "Sales Month"
    label: "Sales Month"
    type: string
    sql: ${TABLE}.Sales_Month  ;; }
  dimension: sales_week { 
    view_label: "Sales Week Master"
    group_item_label: "Sales Week"
    label: "Sales Week"
    type: string
    sql: ${TABLE}.Sales_Week  ;; }
  
  
  }
