


view: dmo_chat_tc_ext_epx {
  dimension: acpt_tm { 
    view_label: "Chat Transcript Info"
    group_item_label: "Accept Time"
    label: "Accept Time"
  }

  dimension: chat_svey_cmt {   label: "Chat Survey Comment"
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
    group_item_label: "EndUserLanguage"
    label: "EndUserLanguage"
  }

  dimension: inact_chat {   label: "Inactive Chat"
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

  dimension: rerou_bot_flg { 
    view_label: "Chat Transcript Info"
    group_label: "Automation"
    group_item_label: "Is Reroute to Bot?"
    label: "Is Reroute to Bot?"
    sql: ${TABLE}.REROU_BOT_FLG ;;
  }

  dimension: sts_nm { 
    view_label: "Chat Transcript Info"
    group_item_label: "Status"
    label: "Status"
  }

  dimension: xch_rt_bot_aply_clck { 
    view_label: "Chat Transcript Info"
    group_label: "Automation"
    group_item_label: "Exchange Rate Bot Apply Clicks"
    label: "Exchange Rate Bot Apply Clicks"
  }

  dimension: xch_rt_bot_dat_dp { 
    view_label: "Chat Transcript Info"
    group_label: "Automation"
    group_item_label: "Exchange Rate Bot Data Display"
    label: "Exchange Rate Bot Data Display"
  }

 }



view: dmo_case_v_ext_epx {
  dimension: agnt_reopen_case_rsn { 
    view_label: "Case Info"
    group_label: "Reopen"
    group_item_label: "Agent Reopen Case Reason"
    label: "Agent Reopen Case Reason"
  }

  dimension: appld_mcr_nm { 
    view_label: "Case Info"
    group_label: "Automation"
    group_item_label: "Applied Macro Name"
    label: "Applied Macro Name"
  }

  dimension: case_agnt_qlt { 
    view_label: "Case KPI"
    group_label: "CIS"
    group_item_label: "Case Agent Quality"
    label: "Case Agent Quality"
  }

  dimension: case_auto_crt_frm_clsd_case_flg { 
    view_label: "Case Info"
    group_label: "Automation"
    group_item_label: "Is Case auto-create from Closed case"
    label: "Is Case auto-create from Closed case"
    sql: ${TABLE}.CASE_AUTO_CRT_FRM_CLSD_CASE_FLG ;;
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

  dimension: cc_auto_clsd_flg { 
    view_label: "Case Info"
    group_label: "Automation"
    group_item_label: "Is CC Auto Closed?"
    label: "Is CC Auto Closed?"
    sql: ${TABLE}.CC_AUTO_CLSD_FLG ;;
  }

  dimension: cht_bd_bfr_end { 
    view_label: "Case Info"
    group_item_label: "Chat Body Before End"
    label: "Chat Body Before End"
  }

  dimension: cloned_flg { 
    view_label: "Case Info"
    group_label: "Automation"
    group_item_label: "Is Cloned?"
    label: "Is Cloned?"
    sql: ${TABLE}.CLONED_FLG ;;
  }

  dimension: cls_cre_flg { 
    view_label: "Case Info"
    group_label: "Automation"
    group_item_label: "Closed When Created"
    label: "Closed When Created"
    sql: ${TABLE}.CLS_CRE_FLG ;;
  }

  dimension: instnt_cls { 
    view_label: "Case Info"
    group_label: "Automation"
    group_item_label: "Instant Close"
    label: "Instant Close"
  }

  dimension: intnt_self_srvc_tp { 
    view_label: "Case Info"
    group_item_label: "Intent Self Service Type"
    label: "Intent Self Service Type"
  }

  dimension: no_of_times_agn_rpn_clsd_case { 
    view_label: "Case Info"
    group_label: "Reopen"
    group_item_label: "No. of Times Agent Reopen Closed Case"
    label: "No. of Times Agent Reopen Closed Case"
  }

  dimension: reopen_allwd_flg { 
    view_label: "Case Info"
    group_label: "Reopen"
    group_item_label: "Is Reopen Allowed"
    label: "Is Reopen Allowed"
    sql: ${TABLE}.REOPEN_ALLWD_FLG ;;
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
    sql: ${TABLE}.RESPNS_FLG ;;
  }

  dimension: rsd_frm_web_frm_flg { 
    view_label: "Case Info"
    group_label: "Web"
    group_item_label: "Is raised from Web Form?"
    label: "Is raised from Web Form?"
    sql: ${TABLE}.RSD_FRM_WEB_FRM_FLG ;;
  }

  dimension: running_usr_for_mcr { 
    view_label: "Case Info"
    group_label: "Automation"
    group_item_label: "Running User for Macro"
    label: "Running User for Macro"
  }

  dimension: slf_srvc_case_clsr_rsn { 
    view_label: "Case Info"
    group_label: "Web"
    group_item_label: "Web Self-Service Case Closure Reason"
    label: "Web Self-Service Case Closure Reason"
  }

  dimension: updt_by_cms_wb_frm_flg { 
    view_label: "Case Info"
    group_label: "Web"
    group_item_label: "Is Updated By CMS Web Form"
    label: "Is Updated By CMS Web Form"
    sql: ${TABLE}.UPDT_BY_CMS_WB_FRM_FLG ;;
  }

 }



view: dmo_case_v_ext_epx_2 {
  dimension: agnt_reopen_case_rsn {   label: "Agent Reopen Case Reason"
    sql: ${TABLE}.AGNT_REOPEN_CASE_RSN ;;
  }

  dimension: appld_mcr_nm {   label: "Applied Macro Name"
    sql: ${TABLE}.APPLD_MCR_NM ;;
  }

  dimension: case_agnt_qlt {   label: "Case Agent Quality"
    sql: ${TABLE}.CASE_AGNT_QLT ;;
  }

  dimension: case_auto_crt_frm_clsd_case_flg {   label: "Is Case auto-create from Closed case"
  }

  dimension: case_srvc_qlt {   label: "Case Service Quality"
    sql: ${TABLE}.CASE_SRVC_QLT ;;
  }

  dimension: case_sstm_qlt {   label: "Case System Quality"
    sql: ${TABLE}.CASE_SSTM_QLT ;;
  }

  dimension: cc_auto_clsd_flg {   label: "Is CC Auto Closed?"
  }

  dimension: cht_bd_bfr_end {   label: "Chat Body Before End"
    sql: ${TABLE}.CHT_BD_BFR_END ;;
  }

  dimension: cloned_flg {   label: "Is Cloned?"
    sql: ${TABLE}.CLONED_FLG ;;
  }

  dimension: cls_cre_flg {   label: "Closed When Created"
  }

  dimension: instnt_cls {   label: "Instant Close"
  }

  dimension: intnt_self_srvc_tp {   label: "Intent Self Service Type"
    sql: ${TABLE}.INTNT_SELF_SRVC_TP ;;
  }

  dimension: no_of_times_agn_rpn_clsd_case {   label: "No. of Times Agent Reopen Closed Case"
    sql: ${TABLE}.NO_OF_TIMES_AGN_RPN_CLSD_CASE ;;
  }

  dimension: reopen_allwd_flg {   label: "Is Reopen Allowed"
    sql: ${TABLE}.REOPEN_ALLWD_FLG ;;
  }

  dimension: req_tp {   label: "Requestor Type"
    sql: ${TABLE}.REQ_TP ;;
  }

  dimension: respns_flg {   label: "Response Flag"
    sql: ${TABLE}.RESPNS_FLG ;;
  }

  dimension: rsd_frm_web_frm_flg {   label: "Is raised from Web Form?"
    sql: ${TABLE}.RSD_FRM_WEB_FRM_FLG ;;
  }

  dimension: running_usr_for_mcr {   label: "Running User for Macro"
    sql: ${TABLE}.RUNNING_USR_FOR_MCR ;;
  }

  dimension: slf_srvc_case_clsr_rsn {   label: "Web Self-Service Case Closure Reason"
    sql: ${TABLE}.SLF_SRVC_CASE_CLSR_RSN ;;
  }

  dimension: updt_by_cms_wb_frm_flg {   label: "Is Updated By CMS Web Form"
    sql: ${TABLE}.UPDT_BY_CMS_WB_FRM_FLG ;;
  }

 }



view: dmo_chat_tc_ext_epx_2 {
  dimension: acpt_tm {   label: "Accept Time"
    sql: ${TABLE}.ACPT_TM ;;
  }

  dimension: cms_sso_sts {   label: "CMS SSO Status"
    sql: ${TABLE}.CMS_SSO_STS ;;
  }

  dimension: ct_nm {   label: "Transcript Name"
    sql: ${TABLE}.CT_NM ;;
  }

  dimension: dnd_lgn_vrf_sts {   label: "DND Login Verify status"
    sql: ${TABLE}.DND_LGN_VRF_STS ;;
  }

  dimension: end_usr_lang {   label: "EndUserLanguage"
  }

  dimension: inq_tp {   label: "Inquiry Type"
    sql: ${TABLE}.INQ_TP ;;
  }

  dimension: mrg_d_d_clck {   label: "Merged D&D Clicked"
    sql: ${TABLE}.MRG_D_D_CLCK ;;
  }

  dimension: mrg_d_d_trns {   label: "Merged D&D Transferred"
    sql: ${TABLE}.MRG_D_D_TRNS ;;
  }

  dimension: rerou_bot_flg {   label: "Is Reroute to Bot?"
    sql: ${TABLE}.REROU_BOT_FLG ;;
  }

  dimension: sts_nm {   label: "Status"
    sql: ${TABLE}.STS_NM ;;
  }

  dimension: xch_rt_bot_aply_clck {   label: "Exchange Rate Bot Apply Clicks"
    sql: ${TABLE}.XCH_RT_BOT_APLY_CLCK ;;
  }

  dimension: xch_rt_bot_dat_dp {   label: "Exchange Rate Bot Data Display"
    sql: ${TABLE}.XCH_RT_BOT_DAT_DP ;;
  }

 }

