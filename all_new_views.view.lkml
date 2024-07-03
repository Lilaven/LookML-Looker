


view: dmc_contract_customer {
  dimension: cnt_nm { 
    view_label: "Customer Information"
    group_label: "Contract Group Customer"
    group_item_label: "Country Code"
    label: "Customer Group Country Code"
  }

  dimension: cust_nm { 
    view_label: "Customer Information"
    group_label: "Contract Customer"
    group_item_label: "Name"
    label: "Contract Customer Name"
  }

  dimension: indus_desc { 
    view_label: "Customer Information"
    group_label: "Contract Group Customer"
    group_item_label: "Industry Description"
    label: "Customer Group Industry Description"
  }

 }



view: dmo_chat_tc_v_ext_epx {
  dimension: agnt_chat_tm_sec { 
    view_label: "Measures"
    group_label: "Chat-Level"
    group_item_label: "Agent Chatting Time (Sec)"
    label: "Agent Chatting Time (Sec)"
    description: "The total amount of time that it took an agent to chat with visitor."
    sql: ${TABLE}.AGNT_CHAT_TM_SEC ;;
  }

  dimension: avg_agt_rsp_tm { 
    view_label: "Measures"
    group_label: "Chat-Level"
    group_item_label: "Agent Average Response Time (Sec)"
    label: "Agent Average Response Time (Sec)"
    description: "The average time that it took an agent to respond to a chat visitor’s message"
    sql: ${TABLE}.AVG_AGT_RSP_TM ;;
  }

  dimension: avg_res_tm_vstr { 
    view_label: "Measures"
    group_label: "Chat-Level"
    group_item_label: "Visitor Average Response Time (Sec)"
    label: "Visitor Average Response Time (Sec)"
    description: "The average time that it took a visitor to respond to an agent comment"
    sql: ${TABLE}.AVG_RES_TM_VSTR ;;
  }

  dimension: bot_chat_tm_sec { 
    view_label: "Measures"
    group_label: "Chat-Level"
    group_item_label: "BOT Chatting Time (Sec)"
    label: "BOT Chatting Time (Sec)"
    description: "The total amount of time that it took a BOT to chat with visitor."
    sql: ${TABLE}.BOT_CHAT_TM_SEC ;;
  }

  dimension: chat_cs_rtng { 
    view_label: "Chat Information"
    group_label: "Feedback"
    group_item_label: "01. Rating"
    label: "Chat Rating"
    sql: ${TABLE}.CHAT_CS_RTNG  ;;
  }

  dimension: chat_dur { 
    view_label: "Measures"
    group_label: "Chat-Level"
    group_item_label: "Duration (Sec)"
    label: "Chat Duration (Sec)"
    description: "The total duration of the chat in seconds"
    sql: ${TABLE}.CHAT_DUR ;;
  }

  dimension: chat_n1st_que_dtl { 
    view_label: "Chat Information"
    group_item_label: "Initial Queue"
    label: "Chat Initial Queue"
  }

  dimension: chat_n1st_trfr_flg { 
    view_label: "Chat Information"
    group_label: "Nature"
    group_item_label: "Is Chat First Transfer (Yes/No)"
    label: "Is Chat First Transfer"
  }

  dimension: cnntd_to_agn { 
    view_label: "Chat Information"
    group_label: "Nature"
    group_item_label: "Is Connected to Agent (Yes/No)"
    label: "Is Connected to Agent"
    description: "Indicates a chat request was connected to agent. "
    sql: ${TABLE}.CNNTD_TO_AGN ;;
  }

  dimension: cnt_cd { 
    view_label: "Chat Information"
    group_label: "Origin"
    group_item_label: "07. Office Country Code"
    label: "Chat Country Code"
  }

  dimension: cntc_nm { 
    view_label: "Chat Information"
    group_label: "Contact"
    group_item_label: "Contact Name"
    label: "Chat Contact Name"
  }

  dimension: ct_nm { 
    view_label: "Chat Information"
    group_item_label: "Transcript Name"
    label: "Chat Transcript Name"
  }

  dimension: ed_by { 
    view_label: "Chat Information"
    group_item_label: "Ended By"
    label: "Chat Ended by "
    description: "Indicates which party ended the chat"
  }

  dimension: hs_lv_mess { 
    view_label: "Chat Information"
    group_label: "Nature"
    group_item_label: "Is Message Left (Yes/No)"
    label: "Has Leave Message"
  }

  dimension: is_ONE_eml { 
    view_label: "Chat Information"
    group_label: "Contact"
    group_item_label: "Is ONE Email (Yes/No)"
    label: "Chat Is ONE Email (Yes/No)"
    sql: ${TABLE}.CUST_CNTC_EML = "@one-line.com"  ;;
  }

  dimension: is_abd_agt_unvlb { 
    view_label: "Chat Information"
    group_label: "Nature"
    group_item_label: "Is Abandoned for agent unavailablity (non-business hour)"
    label: "Is Abandoned for agent unavailablity (non-business hour)"
    description: "Chosen an intent that directly connected to an agent but no agents are available due to non-business hours. Leave a message option is presented but customer did not submit request and close off the window."
    sql: CASE WHEN ${TABLE}.ITNT is not null 
AND ${TABLE}.CNNTD_TO_AGN = 'true'  
AND ${TABLE}.WTHN_BSNSHR_CHAT_FLG = 'false' 
AND ${TABLE}.IS_CHT_LEAVE_MSG = 'false' THEN 'Yes' ELSE 'No' END ;;
  }

  dimension: is_abd_bf_ct_ed { 
    view_label: "Chat Information"
    group_label: "Nature"
    group_item_label: "Is Abandoned before chat end by agent"
    label: "Is Abandoned before chat end by agent"
    description: "Customer is connected to agent. Before a chat is ended by agent, customer decided to drop out from the chat regardless whether there is an ongoing conversation with agent or no conversation at all from either side."
    sql: CASE WHEN ${TABLE}.CNNTD_TO_AGN = 'true'  
AND ${TABLE}.ED_BY = 'Visitor' 
AND ${TABLE}.CUST_ABDND_CH_FLG = 'true' 
AND ${TABLE}.ED_TM > ${TABLE}.AGNT_ACPT_N1ST_TRNS THEN 'Yes' ELSE 'No' END ;;
  }

  dimension: is_abd_fn_mn_cnt_agt { 
    view_label: "Chat Information"
    group_label: "Nature"
    group_item_label: "Is Abandoned at Final Intent Menu or Connecting with Agent"
    label: "Is Abandoned at Final Intent Menu or Connecting with Agent"
    description: "(i) Pure Chatbot interaction. At the final menu intent selection (either self help link or transfer to agent directly), customer did not click anything and close the chat window  OR (ii) Chosen an intent that directly connected to an agent and while trying to establish connection to an agent, customer left the chat without connnected to an agent."
    sql: CASE WHEN ${TABLE}.CHB_SESS_FLG = 'true' AND ${TABLE}.CNNTD_TO_AGN = 'false'  AND ${TABLE}.ED_BY = 'Visitor' THEN 'Yes' 
WHEN ${TABLE}.ED_BY = 'Visitor' AND ${TABLE}.BOT_INIT_TRNS is not null AND  ${TABLE}.BOT_TRNS_ABDND is not null AND ( ${TABLE}.ED_TM < ${TABLE}.AGNT_ACPT_N1ST_TRNS OR ${TABLE}.AGNT_ACPT_N1ST_TRNS is null) THEN 'Yes'
ELSE 'No' END ;;
  }

  dimension: is_abd_pre_chat { 
    view_label: "Chat Information"
    group_label: "Nature"
    group_item_label: "Is Abandoned at Pre-Chat Form "
    label: "Is Abandoned at Pre-Chat Form "
    description: "Customer provided consent & click "Start Chat". Chatbot interaction is engaged however customer left the chat before the menu is displayed."
    sql: CASE WHEN ${TABLE}.CHB_SESS_FLG = 'true' 
AND (COALESCE(${TABLE}.BOT_CHAT_TM_SEC,0) = 0)
AND ${TABLE}.ED_BY = 'Visitor' THEN 'Yes' ELSE 'No' END ;;
  }

  dimension: is_que_flg_abdn { 
    view_label: "Chat Information"
    group_label: "Nature"
    group_item_label: "Is Queue abandoned (Yes/No) "
    label: "Is Queue Abandoned"
    description: "Indicates visitor abandoned chat while queueing"
    sql: CASE WHEN ${TABLE}.QUE_FLG = 'Abandonment' THEN 'Yes" ELSE 'No' END ;;
  }

  dimension: is_que_stt { 
    view_label: "Chat Information"
    group_item_label: "Is-Queue Status"
    label: "Is-Queue Status"
    description: "Indicate whether chat request status was in queue and the status
Queue - Queued and Connected to Agent
Abandonment - Queued and Abandon 
None - Not in Queue"
    sql: ${TABLE}.QUE_FLG ;;
  }

  dimension: is_wthout_agt_rsp { 
    view_label: "Chat Information"
    group_label: "Nature"
    group_item_label: "Is Without Agent Repsonse (Yes/No)"
    label: "Is Without Agent Repsonse"
    description: "Indicates a chat request connected to agent is without agent response."
    sql: CASE WHEN ${TABLE}.CNNTD_TO_AGN = 'true' AND ${TABLE}.AGNT_CHAT_TM_SEC <=0 THEN 'Yes' ELSE 'No' END ;;
  }

  dimension: lft_usd_flg { 
    view_label: "Chat Information"
    group_label: "Nature"
    group_item_label: "Is LFD Used (Yes/No)"
    label: "Is LFD Used"
    sql: ${TABLE}.LFT_USD_FLG  ;;
  }

  dimension: min_chat_n1st_res_dt_mns { 
    view_label: "Measures"
    group_label: "Chat-Level"
    group_item_label: "First Response Time (Mins)"
    label: "Chat First Response Time (Mins)"
    description: "The time an agent first repsonse to a chat request."
    sql: ${TABLE}.CHAT_N1ST_RES_DT_MNS ;;
  }

  dimension: mrg_d_d_usd_flg { 
    view_label: "Chat Information"
    group_label: "Nature"
    group_item_label: "Is Merged D&D Used (Yes/No)"
    label: "Is Merged D&D Used"
    sql: ${TABLE}.MRG_D_D_USD_FLG  ;;
  }

  dimension: mx_res_tm_opt { 
    view_label: "Measures"
    group_label: "Chat-Level"
    group_item_label: "Agent Maximum Response Time (Sec)"
    label: "Agent Maximum Response Time (Sec)"
    description: "The maximum time it took an agent to respond to a chat visitor’s message"
    sql: ${TABLE}.MX_RES_TM_OPT ;;
  }

  dimension: ofc_cd { 
    view_label: "Chat Information"
    group_label: "Origin"
    group_item_label: "01. Office Code"
    label: "Chat Office Code"
  }

  dimension: ori_nm { 
    view_label: "Chat Information"
    group_item_label: "Source"
    label: "Source of Chat"
    sql: ${TABLE}.ORI_NM  ;;
  }

  dimension: own_eml { 
    view_label: "Chat Information"
    group_label: "Contact"
    group_item_label: "Contact Email"
    label: "Chat Contact Email"
  }

  dimension: que_wt_tm { 
    view_label: "Measures"
    group_label: "Chat-Level"
    group_item_label: "Queue Wait Time (Sec)"
    label: "Queue Wait Time (Sec)"
    description: "The total amount of time a chat request was waiting in queue to be connected to agent"
    sql: ${TABLE}.QUE_WT_TM ;;
  }

  dimension: sts_nm { 
    view_label: "Chat Information"
    group_item_label: "Status"
    label: "Chat Status"
    description: "Completed or Missed. A missed chat was requested but not answered"
  }

  dimension: trns_tp { 
    view_label: "Chat Information"
    group_item_label: "Transfer Type"
    label: "Transfer Type"
    sql: ${TABLE}.TRNS_TP ;;
  }

  dimension: tt_chat_hdl_tm { 
    view_label: "Measures"
    group_label: "Chat-Level"
    group_item_label: "Handle Time (Mins)"
    label: "Chat Handle Time (Mins)"
    description: "The total handling time of a chat request"
    sql: ${TABLE}.CHAT_HDL_TM ;;
  }

  dimension: tt_chat_trns { 
    view_label: "Measures"
    group_label: "Chat-Level"
    group_item_label: "Count of Transfer"
    label: "Count of Transfer"
    description: "The number of times a chat is transferred to different party."
    sql: ${TABLE}.TT_CHAT_TRNS ;;
  }

  dimension: vst_wt_tm { 
    view_label: "Measures"
    group_label: "Chat-Level"
    group_item_label: "Visitor Wait Time (Sec)"
    label: "Visitor Wait Time (Sec)"
    description: "Sum of BOT Wait Time and Queue Wait Time. The total amount of time a visitor was waiting to connect to agent. "
    sql: ${TABLE}.CAL_WT_TM_SEC ;;
  }

  dimension: wt_tm { 
    view_label: "Measures"
    group_label: "Chat-Level"
    group_item_label: "BOT Wait Time (Sec)"
    label: "BOT Wait Time (Sec)"
    description: "The total amount of time a chat request was waiting to be connected to BOT"
    sql: ${TABLE}.WT_TM ;;
  }

  dimension: wthn_bsnshr_chat_flg { 
    view_label: "Chat Information"
    group_label: "Nature"
    group_item_label: "Is WithIn Business Hour (Yes/No)"
    label: "Is WithIn Business Hour"
  }

  
  dimension_group: agnt_acpt_n1st_trns_dt { 
    view_label: "Chat Information"
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

  dimension_group: agnt_n1st_acpt_dt { 
    view_label: "Chat Information"
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

  dimension_group: chat_n1st_res_dt { 
    view_label: "Chat Information"
    group_label: "First Response Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Chat First Response (UTC)"
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
    sql: ${TABLE}.CHAT_N1ST_RES_DT_TM ;;
  }

  dimension_group: cre_dt { 
    view_label: "Chat Information"
    group_label: "Created Date (TZ)"
    group_item_label: "@{time_frames}"
    label: "Chat Created Day Week (TZ)"
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

  dimension_group: cre_gdt { 
    view_label: "Chat Information"
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

  dimension_group: ed_tm_dt { 
    view_label: "Chat Information"
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

  dimension_group: st_tm_dt { 
    view_label: "Chat Information"
    group_label: "Start Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Chat Start (UTC)"
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
    sql: ${TABLE}.ST_TM ;;
  }

  
  measure: 90_cs_frst_rsp_tm { 
    view_label: "Measures"
    group_label: "Response Time"
    group_item_label: "90th Percentile Case First Response Time"
    label: "90th Percentile Chat Case First Response Time"
    sql: ${n1st_res_tm_min}[offset(90)] ;;
  }

  measure: 90_ct_frst_rsp_tm { 
    view_label: "Measures"
    group_label: "Response Time"
    group_item_label: "90th Percentile Chat First Response Time"
    label: "90th Percentile Chat Transcript First Response Time"
    sql: ${avg_chat_n1st_res_tm_min}[offset(90)] ;;
  }

  measure: 90_pc_cs_hdl_tm { 
    view_label: "Measures"
    group_label: "Handling Time"
    group_item_label: "90th Percentile Case Handle Time"
    label: "90th Percentile Chat Case Handle Time"
    sql: ${cs_hdl_tm_min}[offset(90)] ;;
  }

  measure: 90_pc_ct_hdl_tm { 
    view_label: "Measures"
    group_label: "Handling Time"
    group_item_label: "90th Percentile Chat Handle Time"
    label: "90th Percentile Chat Transcript Handle Time"
    sql: ${avg_chat_hdl_tm}[offset(90)] ;;
  }

  measure: avg_of_avg_agt_rsp_tm { 
    view_label: "Measures"
    group_label: "Response Time"
    group_item_label: "Agent Average Repsonse Time (Sec)"
    label: "Agent Average Repsonse Time (Sec)"
    sql: ${avg_agt_rsp_tm} ;;
  }

  measure: avg_of_avg_res_tm_vstr { 
    view_label: "Measures"
    group_label: "Response Time"
    group_item_label: "Visitor Average Response Time (Sec)"
    label: "Visitor Average Response Time (Sec)"
    sql: ${avg_cust_rsp_tm} ;;
  }

  measure: avg_of_chat_dur { 
    view_label: "Measures"
    group_label: "Handling Time"
    group_item_label: "Chat Average Duration (Sec)"
    label: "Chat Average Duration (Sec)"
    sql: ${chat_dur} ;;
  }

  measure: avg_of_que_wt_tm { 
    view_label: "Measures"
    group_label: "Wait Time"
    group_item_label: "Queue Average Wait Time (Sec)"
    label: "Queue Average Wait Time (Sec)"
    sql: ${que_wt_tm} ;;
  }

  measure: avg_of_vst_wt_tm { 
    view_label: "Measures"
    group_label: "Wait Time"
    group_item_label: "Visitor Average Wait Time (Sec)"
    label: "Visitor Average Wait Time (Sec)"
    sql: ${cal_wt_tm_sec} ;;
  }

  measure: avg_of_wt_tm { 
    view_label: "Measures"
    group_label: "Wait Time"
    group_item_label: "BOT Average Wait Time (Sec)"
    label: "BOT Average Wait Time (Sec)"
    sql: ${wt_tm} ;;
  }

  measure: cnt_ct { 
    view_label: "Measures"
    group_label: "Volume"
    group_item_label: "Count of chats"
    label: "Count of chats"
    sql: ${TABLE}.OF_ID ;;
  }

  measure: count_of_abd_ct { 
    view_label: "Measures"
    group_label: "Volume"
    group_item_label: "Count of abandoned chats"
    label: "Count of abandoned chats"
    description: "The total amount of abandoned chats"
    sql: ${of_id_pk}  ;;
  }

  measure: count_of_abd_ct_bf_cnt_agt { 
    view_label: "Measures"
    group_label: "Volume"
    group_item_label: "Count of abandoned chats before connect to agent"
    label: "Count of abandoned chats before connect to agent"
    description: "The total amount of abandoned chats before connecting to agent"
    sql: ${of_id_pk}  ;;
  }

  measure: count_of_cnt_agt { 
    view_label: "Measures"
    group_label: "Volume"
    group_item_label: "Count of agent connected chats"
    label: "Count of agent connected chats"
    description: "The total amount of chats connected to agent."
    sql: ${of_id_pk}  ;;
  }

  measure: count_of_cnt_agt_rspd { 
    view_label: "Measures"
    group_label: "Volume"
    group_item_label: "Count of agent connected chats without agent response"
    label: "Count of agent connected chats without agent response"
    description: "The total number of chats connected to agent without agent repsonse over total chats"
    sql: ${of_id_pk}  ;;
  }

  measure: count_of_ct_per_agt { 
    view_label: "Measures"
    group_label: "Volume"
    group_item_label: "Count of chats per agent"
    label: "Count of chats per agent"
    description: "Count of chats connected to agent / Count of distinct agents"
    sql: ${of_id_pk}  ;;
  }

  measure: count_of_ct_slf_svc_rsl { 
    view_label: "Measures"
    group_label: "Volume"
    group_item_label: "Count of chats self service resolved"
    label: "Count of chats self service resolved"
    description: "The total amount of chats that visitor resolved by self-service"
    sql: ${of_id_pk}  ;;
  }

  measure: count_of_opt_mess_cnt { 
    view_label: "Measures"
    group_label: "Volume"
    group_item_label: "Count of agent messages "
    label: "Count of agent messages "
    description: "The number of messages an agent sent during the chat"
    sql: ${of_id_pk}  ;;
  }

  measure: count_of_que_abd_ct { 
    view_label: "Measures"
    group_label: "Volume"
    group_item_label: "Count of queued abandoned chats"
    label: "Count of queued abandoned chats"
    description: "The total amount of abandoned chats while queueing"
    sql: ${of_id_pk}  ;;
  }

  measure: count_of_que_ct { 
    view_label: "Measures"
    group_label: "Volume"
    group_item_label: "Count of queued chats"
    label: "Count of queued chats"
    description: "The total amount of queued chats"
    sql: ${of_id_pk}  ;;
  }

  measure: count_of_vstr_mes_cnt { 
    view_label: "Measures"
    group_label: "Volume"
    group_item_label: "Count of visitor messages"
    label: "Count of visitor messages"
    description: "The number of messages a visitor sent during the chat"
    sql: ${of_id_pk}  ;;
  }

  measure: que_abd_rt { 
    view_label: "Measures"
    group_label: "Volume"
    group_item_label: "Queued abandoned ratio"
    label: "Chat queued abandoned ratio"
    description: "The total number of queued abondaned chats over total queued chats"
    sql: ${count_of_que_abd_ct}/${count_of_que_ct} ;;
  }

  measure: que_rt { 
    view_label: "Measures"
    group_label: "Volume"
    group_item_label: "Queued ratio"
    label: "Chat queued ratio"
    description: "The total number of queued chats over total chats"
    sql: ${count_of_que_ct}/${cnt_ct} ;;
  }

  measure: trans_rt { 
    view_label: "Measures"
    group_label: "Volume"
    group_item_label: "Transfer ratio"
    label: "Chat transfer ratio"
    description: "The total number of transferred chat over total chats"
    sql: ${tt_chat_trns}/${cnt_ct} ;;
  }

  
  
 }



view: dmo_cntc_svc {
  dimension: eml { 
    view_label: "Customer Information"
    group_label: "Contact"
    group_item_label: "Contact Email"
    label: "Contact Email"
  }

  dimension: is_ONE_eml { 
    view_label: "Customer Information"
    group_label: "Contact"
    group_item_label: "Is ONE Email (Yes/No)"
    label: "Is ONE Email (Yes/No)"
    sql: ${TABLE}.CUST_CNTC_EML = "@one-line.com"  ;;
  }

  dimension: nm { 
    view_label: "Customer Information"
    group_label: "Contact"
    group_item_label: "Contact Name"
    label: "Contact Name"
  }

 }



view: dmc_origin {
  dimension: cnt_nm { 
    view_label: "Chat Information"
    group_label: "Origin"
    group_item_label: "08. Office Country Name"
    label: "Chat Country Name"
  }

  dimension: conti_cd { 
    view_label: "Chat Information"
    group_label: "Origin"
    group_item_label: "11. Office Continent Code"
    label: "Chat Continent Code"
  }

  dimension: conti_nm { 
    view_label: "Chat Information"
    group_label: "Origin"
    group_item_label: "12. Office Continent Name"
    label: "Chat Continent Name"
  }

  dimension: loc_cd { 
    view_label: "Chat Information"
    group_label: "Origin"
    group_item_label: "03. Office Location Code"
    label: "Chat Location Code"
  }

  dimension: loc_nm { 
    view_label: "Chat Information"
    group_label: "Origin"
    group_item_label: "04. Office Location Name"
    label: "Chat Location Name"
  }

  dimension: ofc_eng_nm { 
    view_label: "Chat Information"
    group_label: "Origin"
    group_item_label: "02. Office Name"
    label: "Chat Office Name"
  }

  dimension: rgn_cd { 
    view_label: "Chat Information"
    group_label: "Origin"
    group_item_label: "05. Office Region Code"
    label: "Chat Region Code"
  }

  dimension: rgn_nm { 
    view_label: "Chat Information"
    group_label: "Origin"
    group_item_label: "06. Office Region Name"
    label: "Chat Region Name"
  }

  dimension: rhq_cd { 
    view_label: "Chat Information"
    group_label: "Origin"
    group_item_label: "13. Office RHQ"
    label: "Chat RHQ"
  }

  dimension: sconti_cd { 
    view_label: "Chat Information"
    group_label: "Origin"
    group_item_label: "09. Office Subcontinent Code"
    label: "Chat Subcontinent Code"
  }

  dimension: sconti_nm { 
    view_label: "Chat Information"
    group_label: "Origin"
    group_item_label: "10. Office Subcontinent Name"
    label: "Chat Subcontinent Name"
  }

 }



view: dmo_case_v_ct_exp {
  dimension: acc_id { 
    view_label: "Customer Information"
    group_label: "Service Customer"
    group_item_label: "Code"
    label: "Service Customer Code"
    sql: ${TABLE}.ACC_ID  ;;
  }

  dimension: avg_chat_n1st_res_tm_min { 
    view_label: "Measures"
    group_label: "Case-Level"
    group_item_label: "Chat transcript Average First Response Time (Mins) "
    label: "Chat transcript Average First Response Time (Mins) "
    description: "calculated average first response time for associated chat transcripts"
    sql: ${TABLE}.AVG_CHAT_N1ST_RES_TM_MIN  ;;
  }

  dimension: bkg_no { 
    view_label: "Case Information"
    group_label: "Reference"
    group_item_label: "Booking Number"
    label: "Case Booking Number"
  }

  dimension: chat_slf_svc_flg { 
    view_label: "Case Information"
    group_label: "Case Nature"
    group_item_label: "Is Chat Self Service (Yes/No)"
    label: "Case Is Chat Self Service (Yes/No)"
  }

  dimension: clst_cnt_cd { 
    view_label: "Case Information"
    group_label: "Origin"
    group_item_label: "04. Cluster Country Code"
    label: "Case Cluster Country"
    sql: CASE WHEN ${TABLE}.CLST_CNT_CD = 'AT' THEN 'AT & HU'
  WHEN ${TABLE}.CNT_NM = 'CZECH' THEN 'CZ & SK'
  WHEN ${ofc_cd} IN ('FOCBB','XMNBB','CANBB','SWABA','SZPBB','ZHOBB','ZHUBB','HKGBB','HKGHQ','MACBA') THEN 'HK & SCN'
  WHEN ${TABLE}.CLST_CNT_CD = 'SE' THEN 'SE & NO'
  WHEN ${TABLE}.CLST_CNT_CD = 'CN' THEN 'NCCN' ELSE ${TABLE}.CLST_CNT_CD END ;;
  }

  dimension: cmplxt { 
    view_label: "Case Information"
    group_item_label: "Complexity"
    label: "Complexity"
    sql: ${TABLE}.CMPLXT  ;;
  }

  dimension: cnt_nm { 
    view_label: "Case Information"
    group_label: "Origin"
    group_item_label: "05. Office Country Name"
    label: "Case Country Name"
    sql: COALESCE(${TABLE}.OFC_NM,${TABLE}.CS_OWN_OFC_NM) ;;
  }

  dimension: cntc_cust_nm { 
    view_label: "Customer Information"
    group_label: "Contract Customer"
    group_item_label: "Code"
    label: "Contract Customer Code"
  }

  dimension: cntc_ec_urs_id { 
    view_label: "Customer Information"
    group_label: "eComm"
    group_item_label: "eComm ID"
    label: "eComm ID"
  }

  dimension: cntc_no { 
    view_label: "Case Information"
    group_label: "Reference"
    group_item_label: "Contract Number"
    label: "Case Contract Number"
  }

  dimension: cntr_no { 
    view_label: "Case Information"
    group_label: "Reference"
    group_item_label: "Container Number"
    label: "Case Container Number"
  }

  dimension: count_of_qstn_intn_num { 
    view_label: "Measures"
    group_label: "Case-Level"
    group_item_label: "Count of Questions/Intents"
    label: "Count of Questions/Intents"
    sql: ${TABLE}.COUNT_OF_QSTN_INTN_NUM  ;;
  }

  dimension: cs_age { 
    view_label: "Case Information"
    group_item_label: "Age"
    label: "Case Age"
  }

  dimension: cs_hdl_tm_ex_inter_min { 
    view_label: "Measures"
    group_label: "Case-Level"
    group_item_label: "Handle Time Excl Internal (Mins)"
    label: "Handle Time Excl Internal (Mins)"
    description: "Case-level handle time after deducting internal wait time"
    sql: ${TABLE}.CS_HDL_TM_EX_INTER_MIN  ;;
  }

  dimension: cs_hdl_tm_min { 
    view_label: "Measures"
    group_label: "Case-Level"
    group_item_label: "Handle Time (Mins)"
    label: "Handle Time (Mins)"
    description: "Case-level handle time"
    sql: ${TABLE}.CS_HDL_TM_MIN  ;;
  }

  dimension: cs_init_que_nm { 
    view_label: "Case Information"
    group_item_label: "Initial Queue"
    label: "Case Initial Queue"
  }

  dimension: cs_no { 
    view_label: "Case Information"
    group_item_label: "Number"
    label: "Case Number"
  }

  dimension: cs_nt_pr { 
    view_label: "Case Information"
    group_label: "Feedback"
    group_item_label: "02. Net Promoter Score"
    label: "Case Net Promoter Score"
  }

  dimension: cs_ori { 
    view_label: "Case Information"
    group_item_label: "Channel"
    label: "Case Channel"
  }

  dimension: cs_own_cnt_cd { 
    view_label: "Case Information"
    group_label: "Owner"
    group_item_label: "07. Office Country Code"
    label: "Case Owner Country Code"
  }

  dimension: cs_own_cnt_nm { 
    view_label: "Case Information"
    group_label: "Owner"
    group_item_label: "08. Office Country Name"
    label: "Case Owner Country Name"
  }

  dimension: cs_own_id { 
    view_label: "Case Information"
    group_label: "Owner"
    group_item_label: "01. User ID"
    label: "Case Owner ID"
  }

  dimension: cs_own_ofc_cd { 
    view_label: "Case Information"
    group_label: "Owner"
    group_item_label: "05. Office Code"
    label: "Case Owner Office Code"
  }

  dimension: cs_own_ofc_nm { 
    view_label: "Case Information"
    group_label: "Owner"
    group_item_label: "06. Office Name"
    label: "Case Owner Office Name"
  }

  dimension: cs_own_ofc_tp { 
    view_label: "Case Information"
    group_label: "Owner"
    group_item_label: "10. Office Type"
    label: "Case Owner Office Type"
  }

  dimension: cs_own_rhq_cd { 
    view_label: "Case Information"
    group_label: "Owner"
    group_item_label: "09. Office RHQ"
    label: "Case Owner Office RHQ"
  }

  dimension: cs_prio { 
    view_label: "Case Information"
    group_item_label: "Priority"
    label: "Case Priority"
  }

  dimension: cs_rsn { 
    view_label: "Case Information"
    group_label: "Intents"
    group_item_label: "01. Category (L1)"
    label: "Case Intents Category (L1)"
  }

  dimension: cs_rtn { 
    view_label: "Case Information"
    group_label: "Feedback"
    group_item_label: "01. Rating"
    label: "Case Rating"
  }

  dimension: cs_stt { 
    view_label: "Case Information"
    group_item_label: "Status"
    label: "Case Status"
  }

  dimension: cs_tp { 
    view_label: "Case Information"
    group_item_label: "Service Type"
    label: "Case Service Type"
  }

  dimension: entered_reference { 
    view_label: "Case Information"
    group_label: "Reference"
    group_item_label: "What Entered"
    label: "Case What Reference Entered"
    description: "What type of reference is entered in the case"
  }

  dimension: hs_lv_mess_flg { 
    view_label: "Case Information"
    group_label: "Case Nature"
    group_item_label: "Is Message Left (Yes/No)"
    label: "Case Is Message Left (Yes/No)"
  }

  dimension: indv_cnt_cd { 
    view_label: "Case Information"
    group_label: "Origin"
    group_item_label: "03. Individual Country Code"
    label: "Case Individual Country"
    sql: CASE WHEN of_case.CNT_CD = 'HK' THEN 'HK & SCN'
  WHEN of_case.CNT_CD ='CN' THEN 'NCCN' ELSE of_case.CNT_CD END ;;
  }

  dimension: is_active { 
    view_label: "Case Information"
    group_label: "Case Nature"
    group_item_label: "Is Active (Yes/No)"
    label: "Case Is Active (Yes/No)"
  }

  dimension: is_bkg_no_vld { 
    view_label: "Case Information"
    group_label: "Reference"
    group_item_label: "Is Booking Number Valid (Yes/No)"
    label: "Case Is Booking Number Valid (Yes/No)"
  }

  dimension: is_cntc_cust_nm_nt { 
    view_label: "Case Information"
    group_label: "Reference"
    group_item_label: "Is Contract Customer Entered (Yes/No)"
    label: "Case Is Contract Customer Entered (Yes/No)"
  }

  dimension: is_cntc_no_vld { 
    view_label: "Case Information"
    group_label: "Reference"
    group_item_label: "Is Contract Number Valid (Yes/No)"
    label: "Case Is Contract Number Valid (Yes/No)"
  }

  dimension: is_esc_yn { 
    view_label: "Case Information"
    group_label: "Case Nature"
    group_item_label: "Is Escalated (Yes/No)"
    label: "Case Is Escalated (Yes/No)"
  }

  dimension: is_fcr_yn { 
    view_label: "Case Information"
    group_label: "Case Nature"
    group_item_label: "Is FCR (Yes/No)"
    label: "Case Is FCR (Yes/No)"
  }

  dimension: is_ntrd_yn { 
    view_label: "Case Information"
    group_label: "Case Nature"
    group_item_label: "Is Nurtured (Yes/No)"
    label: "Case Is Nurtured (Yes/No)"
  }

  dimension: is_own_by_que { 
    view_label: "Case Information"
    group_label: "Case Nature"
    group_item_label: "Is Owned by Queue (Yes/No)"
    label: "Case Is Owned by Queue (Yes/No)"
  }

  dimension: is_own_by_sys { 
    view_label: "Case Information"
    group_label: "Case Nature"
    group_item_label: "Is Owned by System (Yes/No)"
    label: "Case Is Owned by System (Yes/No)"
  }

  dimension: is_reopened { 
    view_label: "Case Information"
    group_label: "Case Nature"
    group_item_label: "Is Reopened (Yes/No)"
    label: "Case Is Reopened (Yes/No)"
  }

  dimension: n1st_res_tm_min { 
    view_label: "Measures"
    group_label: "Case-Level"
    group_item_label: "First Response Time (Mins)"
    label: "First Response Time"
    description: "Case-level first response time"
    sql: ${TABLE}.N1ST_RES_TM_MIN  ;;
  }

  dimension: no_ref_rsn_nw { 
    view_label: "Case Information"
    group_label: "Reference"
    group_item_label: "No Reason"
    label: "Case No Reference Reason"
    description: "Reason of not entering reference in the case"
  }

  dimension: nps_segment { 
    view_label: "Case Information"
    group_label: "Feedback"
    group_item_label: "03. NPS Segment"
    label: "Case NPS Segment"
    description: "Promoters - Net Promoter Score of 9 and 10 
Detractors - Net Promoter Score score of 0 to 6
Passives -  Net Promoter Score score of 7 and 8
No Rating - Net Promoter Score is unavailable"
  }

  dimension: ofc_cd { 
    view_label: "Case Information"
    group_label: "Origin"
    group_item_label: "01. Office Code"
    label: "Case Office Code"
    sql: COALESCE(CASE
  WHEN ${TABLE}.OFC_CD IN ('MIBOS', 'MIHOS', 'WNKOS', 'SPROS', 'WGZOS') THEN REPLACE(${TABLE}.OFC_CD, "OS", "")
  WHEN ${TABLE}.OFC_CD = 'WMLOS' THEN 'MIM'
  ELSE ${TABLE}.OFC_CD END, ${TABLE}.CS_OWN_OFC_CD) ;;
  }

  dimension: ofc_nm { 
    view_label: "Case Information"
    group_label: "Origin"
    group_item_label: "02. Office Name"
    label: "Case Office Name"
    sql: COALESCE(${TABLE}.OFC_NM,${TABLE}.CS_OWN_OFC_NM) ;;
  }

  dimension: ofc_tp_nm { 
    view_label: "Case Information"
    group_label: "Origin"
    group_item_label: "07. Office Type"
    label: "Case Office Type"
    sql: ${TABLE}.OFC_TP_NM  ;;
  }

  dimension: org_rec_tp { 
    view_label: "Case Information"
    group_item_label: "Original Record Type"
    label: "Case Original Record Type"
  }

  dimension: prfl_nm { 
    view_label: "Case Information"
    group_label: "Owner"
    group_item_label: "04. User Profile"
    label: "Case Owner Profile"
    sql: CASE WHEN ${TABLE}.PRFL_NM = 'Customer Care Agent' THEN 'CCA'
  WHEN ${TABLE}.PRFL_NM = 'Customer Care Supervisor' THEN 'CCS'
  WHEN ${TABLE}.PRFL_NM IN ('Sales Executive','TPA (Service Cloud) CCS','TPA (Service Cloud) CCA') THEN ${TABLE}.PRFL_NM
  ELSE 'Others' END  ;;
  }

  dimension: resln_rsn_nw { 
    view_label: "Case Information"
    group_label: "Resolution"
    group_item_label: "Resolution Reason"
    label: "Case Resolution Reason"
  }

  dimension: rhq_cd { 
    view_label: "Case Information"
    group_label: "Origin"
    group_item_label: "06. Office RHQ"
    label: "Case RHQ"
    sql: CASE WHEN ${TABLE}.RHQ_CD IS NOT NULL THEN RIGHT(${TABLE}.RHQ_CD, 5) ELSE "Unclaimed" END  ;;
  }

  dimension: sbdnt_cat_l4 { 
    view_label: "Case Information"
    group_label: "Intents"
    group_item_label: "04. Sub Topic (L4)"
    label: "Case Intents Sub Topic (L4)"
  }

  dimension: spl_eml { 
    view_label: "Case Information"
    group_item_label: "Web Email"
    label: "Case Web Email"
  }

  dimension: sub_cat_l2 { 
    view_label: "Case Information"
    group_label: "Intents"
    group_item_label: "02. Category (L2)"
    label: "Case Intents Category (L2)"
  }

  dimension: sub_resln_rsn { 
    view_label: "Case Information"
    group_label: "Resolution"
    group_item_label: "Sub Resolution Reason"
    label: "Case Sub Resolution Reason"
  }

  dimension: subdnt_cat_l3 { 
    view_label: "Case Information"
    group_label: "Intents"
    group_item_label: "03. Topic (L3)"
    label: "Case Intents Topic (L3)"
  }

  dimension: usr_nm { 
    view_label: "Case Information"
    group_label: "Owner"
    group_item_label: "02. User Name"
    label: "Case Owner Name"
    sql: ${TABLE}.USR_NM  ;;
  }

  dimension: usr_role_nm { 
    view_label: "Case Information"
    group_label: "Owner"
    group_item_label: "03. User Role"
    label: "Case Owner Role"
    sql: ${TABLE}.USR_ROLE_NM  ;;
  }

  
  dimension_group: cls_dt { 
    view_label: "Case Information"
    group_label: "Closed Date (TZ)"
    group_item_label: "@{time_frames}"
    label: "Case Closed (TZ)"
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
    sql: ${TABLE}.CLS_DT ;;
  }

  dimension_group: cls_gdt { 
    view_label: "Case Information"
    group_label: "Closed Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Case Closed (UTC)"
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
    sql: ${TABLE}.CLS_DT ;;
  }

  dimension_group: cre_dt { 
    view_label: "Case Information"
    group_label: "Open Date (TZ)"
    group_item_label: "@{time_frames}"
    label: "Case Open (TZ)"
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

  dimension_group: cre_gdt { 
    view_label: "Case Information"
    group_label: "Open Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Case Open (UTC)"
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

  dimension_group: cs_rslvd_dt { 
    view_label: "Case Information"
    group_label: "Resolved Date (TZ)"
    group_item_label: "@{time_frames}"
    label: "Case Resolved (TZ)"
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
    sql: ${TABLE}.CS_RSLVD_DT_TM ;;
  }

  dimension_group: cs_rslvd_gdt { 
    view_label: "Case Information"
    group_label: "Resolved Date (UTC)"
    group_item_label: "@{time_frames}"
    label: "Case Resolved (UTC)"
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
    sql: ${TABLE}.CS_RSLVD_DT_TM ;;
  }

  
  measure: avrg_chat_hdl_tm { 
    view_label: "Measures"
    group_label: "Handling Time"
    group_item_label: "Chat-transcript level Average Handle Time (Mins)"
    label: "Chat-transcript level Average Handle Time (Mins)"
    sql: ${avg_chat_hdl_tm}  ;;
  }

  measure: avrg_chat_n1st_res_tm_min { 
    view_label: "Measures"
    group_label: "Response Time"
    group_item_label: "Chat-transcript level Average First Response Time (Mins)"
    label: "Chat-transcript level Average First Response Time (Mins)"
    sql: ${avg_chat_n1st_res_tm_min}  ;;
  }

  measure: avrg_cs_hdl_tm_min { 
    view_label: "Measures"
    group_label: "Handling Time"
    group_item_label: "Case-level Average Handle Time (Mins)"
    label: "Case-level Average Handle Time (Mins)"
    sql: ${cs_hdl_tm_min}  ;;
  }

  measure: avrg_cs_n1st_res_tm_min { 
    view_label: "Measures"
    group_label: "Response Time"
    group_item_label: "Case-level Average First Response Time (Mins)"
    label: "Case-level Average First Response Time (Mins)"
    sql: ${n1st_res_tm_min}  ;;
  }

  measure: cs_no_vol { 
    view_label: "Measures"
    group_label: "Volume"
    group_item_label: "Count of cases"
    label: "Count of cases"
    sql: ${cs_no}  ;;
  }

  
  
 }



view: dmo_case_v_ext_epx {
  dimension: avg_chat_hdl_tm { 
    view_label: "Measures"
    group_label: "Case-Level"
    group_item_label: "Chat transcript Average Handle Time (Mins) "
    label: "Chat transcript Average Handle Time (Mins) "
    description: "calculated average handle time for associated chat transcripts"
    sql: CAST(${TABLE}.AVG_CHAT_HDL_TM as FLOAT64) ;;
  }

 }



view: dmo_crm_cust_grp_svc {
  dimension: cntr_cust_tp_cd { 
    view_label: "Customer Information"
    group_label: "Contract Group Customer"
    group_item_label: "Type Name"
    label: "NVO/BCO"
  }

  dimension: cust_grp_id { 
    view_label: "Customer Information"
    group_label: "Contract Group Customer"
    group_item_label: "Code"
    label: "Customer Group Code"
  }

  dimension: cust_grp_nm { 
    view_label: "Customer Information"
    group_label: "Contract Group Customer"
    group_item_label: "Name"
    label: "Customer Group Name"
  }

  dimension: is_GKA_acct { 
    view_label: "Customer Information"
    group_label: "Contract Group Customer"
    group_item_label: "Is GKA Account (Yes/No)"
    label: "Customer Is GKA (Yes/No)"
  }

  dimension: is_LKA_acct { 
    view_label: "Customer Information"
    group_label: "Contract Group Customer"
    group_item_label: "Is LKA Account (Yes/No)"
    label: "Customer Is LKA (Yes/No)"
  }

  dimension: is_ONECare_acct { 
    view_label: "Customer Information"
    group_label: "Contract Group Customer"
    group_item_label: "Is ONECare Account (Yes/No)"
    label: "Customer Is ONECare (Yes/No)"
  }

  dimension: is_RKA_acct { 
    view_label: "Customer Information"
    group_label: "Contract Group Customer"
    group_item_label: "Is RKA Account (Yes/No)"
    label: "Customer Is RKA (Yes/No)"
  }

  dimension: key_acct_tp_cd { 
    view_label: "Customer Information"
    group_label: "Contract Group Customer"
    group_item_label: "Key Account Type Code"
    label: "Key Account Type Code"
  }

 }



view: dmc_service_customer {
  dimension: cust_nm { 
    view_label: "Customer Information"
    group_label: "Service Customer"
    group_item_label: "Name"
    label: "Service Customer Name"
    sql: ${TABLE}.CUST_NM  ;;
  }

 }



view: chat_transcript_owner {
  dimension: cnt_cd { 
    view_label: "Chat Information"
    group_label: "Owner"
    group_item_label: "07. Office Country Code"
    label: "Chat Owner Country Code"
  }

  dimension: cnt_nm { 
    view_label: "Chat Information"
    group_label: "Owner"
    group_item_label: "08. Office Country Name"
    label: "Chat Owner Country Name"
  }

  dimension: of_id { 
    view_label: "Chat Information"
    group_label: "Owner"
    group_item_label: "01. User ID"
    label: "Chat Owner ID"
  }

  dimension: ofc_cd_no { 
    view_label: "Chat Information"
    group_label: "Owner"
    group_item_label: "05. Office Code"
    label: "Chat Owner Office Code"
  }

  dimension: ofc_eng_nm { 
    view_label: "Chat Information"
    group_label: "Owner"
    group_item_label: "06. Office Name"
    label: "Chat Owner Office Name"
  }

  dimension: ofc_tp { 
    view_label: "Chat Information"
    group_label: "Owner"
    group_item_label: "10. Office Type"
    label: "Chat Owner Office Type"
  }

  dimension: prfl_nm { 
    view_label: "Chat Information"
    group_label: "Owner"
    group_item_label: "04. User Profile"
    label: "Chat Owner Profile"
  }

  dimension: rhq_cd { 
    view_label: "Chat Information"
    group_label: "Owner"
    group_item_label: "09. Office RHQ"
    label: "Chat Owner RHQ (5 digits)"
  }

  dimension: usr_nm { 
    view_label: "Chat Information"
    group_label: "Owner"
    group_item_label: "02. User Name"
    label: "Chat Owner Name"
    description: "The name of the transcript owner. By default, the owner is the user who originally created the transcript (for example, the agent who answered the chat)."
  }

  dimension: usr_role_nm { 
    view_label: "Chat Information"
    group_label: "Owner"
    group_item_label: "03. User Role"
    label: "Chat Owner Role"
  }

 }

