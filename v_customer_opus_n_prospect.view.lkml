


view: v_customer_opus_n_prospect {
   sql_table_name: ONEFORCE.V_CUSTOMER_OPUS_N_PROSPECT ;;

  dimension: owner_name {
    label: "Owner Name"
    type: string
    sql: ${TABLE}.of_owner_name ;;
  }

    dimension: owner_office_code {
    label: "Owner Office Code"
    type: string
    sql: ${TABLE}.of_owner_office_code ;;
  }

  dimension: owner_name_or_srep_nm {
    label: "Owner (if CRM then Srep)"
    type: string
    sql: CASE WHEN upper(${owner_office_code}) = 'ZZUNCLAIMED - OFFICE' THEN ${srep_nm} ELSE ${owner_name} END ;;
  }

  dimension: oneforce_id {
    label: "Customer"
    primary_key: yes
    type: string
    sql: ${TABLE}.ONEForce_ID ;;
  }

  dimension: cust_cd {
    hidden: no
    label: "Customer Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CUST_CD ;;
    suggest_persist_for: "4 hour"
  }

  dimension: name {
    label: "Customer Name"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.NAME ;;
    suggest_persist_for: "4 hour"
  }

  dimension: customer_cd_and_name {
    label: "Customer Code & Name"
    type: string
    sql: concat(${cust_cd}, " - ", ${name}) ;;
    suggest_persist_for: "4 hour"
  }

  dimension: cust_cnt_cd {
    label: "Country"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CUST_CNT_CD ;;
    suggest_persist_for: "24 hour"
  }

  dimension: cty_nm {
    label: "City" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CTY_NM ;;
  }

  dimension: post_code {
    label: "Zip/Postal Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.POST_CODE ;;
  }

  dimension: cust_fax {
    label: "Fax"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CUST_FAX ;;
  }

  dimension: cust_eml {
    label: "Email Address"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CUST_EML ;;
  }

  dimension: srep_eml {
    label: "Sales Rep Email"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SREP_EML ;;
  }

  dimension: delt_flg {
    label: "Inactive" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.DELT_FLG ;;
  }

  dimension: cust_grp_hrchy_cd {
    view_label: "Office Information"
    label: "{{ _view._name }}: Office Type Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CUST_GRP_HRCHY_CD ;;
    suggest_persist_for: "24 hour"
  }

  dimension: cust_grp_hrchy_cd_dscr {
    view_label: "Office Information"
    label: "{{ _view._name }}: Office Type"  # programmatically added by LookML modifier
    type: string
    sql:
    CASE WHEN (${cust_grp_hrchy_cd} = 'G') THEN 'Global'
    WHEN (${cust_grp_hrchy_cd} = 'R') THEN 'Regional'
    WHEN (${cust_grp_hrchy_cd} = 'C') THEN 'Country'
    WHEN (${cust_grp_hrchy_cd} = 'I') THEN 'Individual'
    ELSE ${cust_grp_hrchy_cd}
    END
    ;;
    suggest_persist_for: "24 hour"
  }

  dimension: srep_nm {
    label: "Sales Rep Name" # programmatically added by LookML modifier
    type: string
    sql:  initcap(lower(${TABLE}.SREP_NM));;
  }

  dimension: ofc_nm {
    view_label: "Office Information"
    label: "{{ _view._name }}: Sales Person's Office"  # programmatically added by LookML modifier
    type: string
    sql: initcap(lower(${TABLE}.OFC_NM));;
  }

  dimension: ofc_Loc_Cd {
    view_label: "Office Information"
    label: "{{ _view._name }}: Office Code"
    type: string
    sql: ${TABLE}.OFC_CD ;;
  }

  dimension: frt_fwrd {
    label: "Is A Forwarder?"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.FRT_FWRD ;;
  }

  dimension: frt_fwrd_fmc_no {
    label: "Forwarder No."  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.FRT_FWRD_FMC_NO ;;
  }

  dimension: lsr_flg {
    label: "Is a Lessor?" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.LSR_FLG ;;
  }

  dimension: mfr_flg {
    label: "Is a Manufacturer?" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.MFR_FLG ;;
  }

  dimension: shp_agnt_flg {
    label: "Is a Shipping Agent?" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.SHP_AGNT_FLG ;;
  }

  dimension: cust_rgst_no {
    label: "Tax ID" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CUST_RGST_NO ;;
  }

  dimension: cust_grp_id {
    hidden: no
    label: "Customer Group Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CUST_GRP_ID ;;
    suggest_persist_for: "4 hour"
  }

  dimension: cntr_cust_tp_cd {
     label: "Customer Type"  # programmatically added by LookML modifier ...
     type: string
     case: {
       when: {
         sql:${TABLE}.CNTR_CUST_TP_CD = 'B'  ;;
         label: "BCO"
       }
       when: {
         sql:${TABLE}.CNTR_CUST_TP_CD = 'N'  ;;
         label: "NVO"
       }
     }
     alpha_sort: yes
     sql: ${TABLE}.CNTR_CUST_TP_CD ;;
    suggest_persist_for: "24 hour"
  }

  dimension: ofc_cd {
    view_label: "Office Information"
    label: "Sales Rep Office"
    description: "{{ _view._name }}: Admin Office Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.OFC_CD ;;
  }

  dimension: capi_amt {
    label: "Capital Amount" # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.CAPI_AMT ;;
  }

  dimension: capi_curr_cd {
    label: "Capital Currency Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CAPI_CURR_CD ;;
  }

  dimension: nbs_clss_cd1 {
    label: "Customer Sub Typ Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.NBS_CLSS_CD1 ;;
  }

  dimension: finc_sts_lvl_cd {
    label: "Finance Status Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.FINC_STS_LVL_CD ;;
  }

  dimension: indiv_corp_div_cd {
    label: "Firm/Private Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.INDIV_CORP_DIV_CD ;;
  }

  dimension: key_acct_st_eff_dt {
    label: "GCM Account Effective Date" # programmatically added by LookML modifier
    type: date
    datatype: date
    sql: ${TABLE}.KEY_ACCT_ST_EFF_DT ;;
  }

  dimension: key_acct_end_eff_dt {
    label: "GCM Account Exp Date" # programmatically added by LookML modifier
    type: date
    datatype: date
    sql: ${TABLE}.KEY_ACCT_END_EFF_DT ;;
  }

  dimension: key_acct_flg {
    label: "GCM Account"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.KEY_ACCT_FLG ;;
  }

  dimension: cust_div_cd {
    label: "Individual/Group" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CUST_DIV_CD ;;
  }

  dimension: indus_desc {
    label: "Industry Type Code" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.INDUS_DESC ;;
  }

  dimension: loc_cd {
    label: "Location Code"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.LOC_CD ;;
  }

  dimension: mlt_trd_acct_flg {
    label: "Multi Trade Account"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.MLT_TRD_ACCT_FLG ;;
  }

  dimension: nmd_cust_flg {
    label: "Named Customer" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.NMD_CUST_FLG ;;
  }

  dimension: nbs_clss_cd3 {
    label: "Regional Key Account" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.NBS_CLSS_CD3 ;;
  }

  dimension: crm_if_flg {
    label: "Track in CRM" # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.CRM_IF_FLG ;;
  }

  dimension: crnt_vol_knt {
    label: "Yearly Volume (TEU)"  # programmatically added by LookML modifier
    type: number
    sql: ${TABLE}.CRNT_VOL_KNT ;;
  }

  dimension: Is_ungroup_customer {
    type: yesno
    sql: ${cust_grp_id} IS NULL ;;
  }

  # Jack, Jul 28, moved the definition from this view to of_consolidated.cust_nvo_fak_nac
  # dimension: nvo_fak_nac {
  #   label: "NVO: FAK/NAC"
  #   type: string
  #   sql:
  #     CASE WHEN (${cntr_cust_tp_cd} = 'N' and ${name} is not null)
  #           then 'NAC'
  #     WHEN (${cntr_cust_tp_cd} = 'N' and ${name} is not null)
  #           then 'NAC'
  #     WHEN (${cntr_cust_tp_cd} = 'N')
  #           then 'FAK'
  #     ELSE
  #           null
  #     END
  #   ;;
  # }

  # Jack, Jul 28, moved the definition from this view to of_consolidated.cust_bco_fak_nac
  # dimension: bco_fak_nac {
  #   label: "BCO: FAK/NAC"
  #   type: string
  #   sql:
  #     CASE WHEN ${cust_cd} is null
  #           then 'Tariff / Dummy'
  #     WHEN ${cntr_cust_tp_cd} = 'N' and ${name} is not null
  #           then 'NAC'
  #     WHEN ${cntr_cust_tp_cd} = 'N' and ${cust_cd} is not null
  #           then 'NAC'
  #     WHEN ${cntr_cust_tp_cd} = 'N'
  #           then 'FAK'
  #     ELSE 'BCO'
  #     END
  #   ;;
  # }


  dimension: parent_customer_code {
    label: "Parent Customer"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Parent_Customer_Code ;;
    suggest_persist_for: "4 hour"
  }

  dimension_group: of_cre_dt {
    label: "Created Date" # programmatically added by LookML modifier
    type: time
    datatype: datetime
    sql: ${TABLE}.OF_CRE_DT ;;
  }

  dimension_group: of_upd_dt {
    label: "Last Modified Date" # programmatically added by LookML modifier
    type: time
    datatype: datetime
    sql: ${TABLE}.OF_UPD_DT ;;
  }

  dimension: of_cre_usr_id {
    label: "Created By Id"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.OF_CRE_USR_ID ;;
  }

  dimension: of_upd_usr_id {
    label: "Last Modified By Id"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.OF_UPD_USR_ID ;;
  }

  dimension: of_owner_id {
    label: "Owner Id, or Sales Person designated to this customer"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.OF_OWNER_ID ;;
  }

  dimension: Commercial {
    label: "Contract Customer"  # programmatically added by LookML modifier
    type: string
    sql: ${TABLE}.Commercial ;;
  }

  dimension: Contract_Customer_Flag{
    label: "Flag to identify Contract Customer"
    type:  string
    sql:
    CASE when ${Commercial} in ("false","N") THEN "No"
    else "Yes" end;;
  }

  dimension: Cust_grp_comp {
    label: "Customer group completion"
    type: string
    sql:
      CASE WHEN ${cust_grp_id} is null
            THEN 'N'
      ELSE 'Y'
      END
    ;;
  }

  dimension: Delete_Flag {
    label: "Delete Flag"
    type: string
    sql:
      case when ${delt_flg} in ("false","N") THEN "No"
      else     "Yes" end;;
  }

  dimension: primary_contact {
    label: "Primary Contact ONEFroce ID"
    type:  string
  }

  parameter: To_Be_Customer {
    type: unquoted
    allowed_value: {
      label: "No"
      value: "Exclude"
    }
    allowed_value: {
      label:  "Yes"
      value:  "Include"
    }
    default_value: "Include"
    }

  parameter: Blacklist_Customer {
    type: unquoted
    allowed_value: {
      label: "Yes"
      value: "Include"
    }
    allowed_value: {
      label:  "No"
      value:  "Exclude"
    }
    default_value: "Include"
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [name]
  }

  measure: CountDistinct_Costumers {
    label: "Qty Customers"
    hidden: no
    type: count_distinct
    sql: ${cust_cd} ;;
    drill_fields: [cust_cd,name,cust_grp_hrchy_cd_dscr,cntr_cust_tp_cd]
  }

  measure: Qty_Ungroup_Customers {
    label: "Qty_Ungroup_Customers"
    type: count_distinct
    sql: case when ${Cust_grp_comp} = "N" then ${cust_cd} end ;;

  }

  # Sales Process Landing Page ----- Start -------
  measure: CountDistinct_Costumers1 {
    label: "Qty Customers Landing"
    hidden: no
    type: count_distinct
    value_format: "0.0,\" K\""
    sql: ${cust_cd} ;;
    drill_fields: [name,cust_cd,srep_nm,srep_eml,of_office_custom.office_code,of_office_custom.office_name,of_reg_ref.reg_rhq_abbrev,of_reg_ref.reg_rhq_code,of_customer_fy_teu.total_teu,of_customer_fy_teu.total_cm_amt]
  }
  # Sales Process Landing Page ----- End -------


#
# measure:  {
#   label: "Total TEU"
#   type: sum
#   sql:  ;;
# }


  set: primary_key {
    fields: [oneforce_id, count]
  }
}
