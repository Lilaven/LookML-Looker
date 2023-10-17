- dashboard: case_analysis
  title: Case Analysis
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''
  query_timezone: UTC
  filters_bar_collapsed: true
  preferred_slug: exDq0MOEroEIKnEw0CMWIL
  elements:
  - title: Open Urgent and High Priority Cases
    name: Open Urgent and High Priority Cases
    model: oneforce_service
    explore: of_case
    type: single_value
    fields: [of_case.case_distinct_count_drill]
    filters:
      of_case.active_case: 'Yes'
      priority_for_filter: High,Urgent
    limit: 500
    dynamic_fields: [{category: dimension, expression: "${of_case.priority}", label: priority
          for filter, value_format: !!null '', value_format_name: !!null '', dimension: priority_for_filter,
        _kind_hint: dimension, _type_hint: string}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#7f0b4d"
    single_value_title: Open Urgent & High Priority
    value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#BD0F72",
        font_color: !!null '', color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>No. of Open High
      and Urgent Priority Cases<BR><B>How it Helps : </B>To evaluate the no. of Open
      cases by Priority = Urgent and High<BR>[Case Status ≠ "Resolved" & "Closed"]<BR><B>Target
      : </B>Urgent: TBD High: TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 0
    col: 0
    width: 2
    height: 2
  - title: Open
    name: Open
    model: oneforce_service
    explore: of_case
    type: single_value
    fields: [of_case.case_distinct_count_drill]
    filters:
      of_case.active_case: 'Yes'
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#7f0b4d"
    single_value_title: Open
    value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#BD0F72",
        font_color: !!null '', color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>No. of Open Cases<BR><B>How
      it Helps : </B>To evaluate the no. of Open cases<BR>[Case Status ≠ "Resolved"
      & "Closed"]<BR><B>Target : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 0
    col: 2
    width: 2
    height: 2
  - title: Escl Cases
    name: Escl Cases
    model: oneforce_service
    explore: of_case
    type: single_value
    fields: [of_case.case_distinct_count_drill]
    filters:
      of_case.active_case: 'Yes'
      of_case.total_escalation: ">0"
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#7f0b4d"
    single_value_title: Open Escl
    value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#BD0F72",
        font_color: !!null '', color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>No. of Open Escalated
      Cases<BR><B>How it Helps : </B>To evaluate the no.of Open Escalated Cases<BR>[Case
      Status ≠ "Resolved" & "Closed" and Total Escalation is Greater than 0]<BR><B>Target
      : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 0
    col: 8
    width: 3
    height: 2
  - title: Trend by Status
    name: Trend by Status
    model: oneforce_service
    explore: of_case
    type: looker_line
    fields: [of_case.status, of_case.createddate_dynamic, of_case.case_distinct_count]
    pivots: [of_case.status]
    sorts: [of_case.status, of_case.createddate_dynamic]
    limit: 500
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: circle_outline
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: Awaiting Customer Response
              - of_case.count, id: Awaiting Customer Response - of_case.count, name: Awaiting
              Customer Response}, {axisId: Awaiting Internal Team Response - of_case.count,
            id: Awaiting Internal Team Response - of_case.count, name: Awaiting Internal
              Team Response}, {axisId: Closed - of_case.count, id: Closed - of_case.count,
            name: Closed}, {axisId: In Progress - of_case.count, id: In Progress -
              of_case.count, name: In Progress}, {axisId: New - of_case.count, id: New
              - of_case.count, name: New}, {axisId: Resolved - of_case.count, id: Resolved
              - of_case.count, name: Resolved}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    hidden_series: [Awaiting Internal Team Response - of_case.count]
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    series_types: {}
    series_colors:
      Closed - of_case.count: "#8b908f"
      Awaiting Customer Response - of_case.count: "#340335"
      In Progress - of_case.count: "#BD0F72"
      Awaiting Internal Team Response - of_case.count: "#7f0b4d"
      Resolved - of_case.count: "#222b35"
      New - of_case.count: "#00506D"
      Awaiting Customer Response - of_case.case_distinct_count: "#340335"
      Awaiting Internal Team Response - of_case.case_distinct_count: "#7f0b4d"
      Closed - of_case.case_distinct_count: "#8b908f"
      In Progress - of_case.case_distinct_count: "#BD0F72"
      New - of_case.case_distinct_count: "#3D7876"
      Resolved - of_case.case_distinct_count: "#222b35"
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B> Trend by Status<BR><B>How
      it Helps : </B>To evaluate weekly trend of total no. of cases by Status<BR>[ALL
      Case Status]<BR><B>Target : </B>New: TBD In Progress: TBD Awaiting Internal
      Responce: TBD Awaiting Customer Responce: TBD Resolved: TBD Close: TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 45
    col: 0
    width: 8
    height: 7
  - title: Case Closure Ratio by Location*
    name: Case Closure Ratio by Location*
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.active_case, of_case.Case_Geo, of_case.case_distinct_count]
    pivots: [of_case.active_case]
    sorts: [of_case.active_case desc, of_case.Case_Geo desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: true
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: Count, orientation: left, series: [{axisId: No - of_case.count,
            id: No - of_case.count, name: 'No'}, {axisId: Yes - of_case.count, id: Yes
              - of_case.count, name: 'Yes'}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_colors:
      No - of_case.count: "#8b908f"
      Yes - of_case.count: "#BD0F72"
      No - of_case.case_distinct_count: "#BD0F72"
      Yes - of_case.case_distinct_count: "#F39200"
    series_labels:
      No - of_case.count: Closed Cases
      Yes - of_case.count: Open Cases
      No - of_case.case_distinct_count: Closed Cases
      Yes - of_case.case_distinct_count: Open Cases
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Closed Case Ratio<BR><B>How
      it Helps : </B>To evaluate no. of Closed cases vs Total cases<BR>[Case Status
      = "Resolved" & "Closed" vs all other Status]<BR><B>Target : </B>Closed Case
      Ratio: TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 8
    col: 0
    width: 12
    height: 6
  - title: Cases by L2 Intent & Location*
    name: Cases by L2 Intent & Location*
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.sub_category_l2, of_case.Case_Geo, of_case.case_distinct_count]
    pivots: [of_case.Case_Geo]
    filters:
      l2_for_filter: "-NULL"
    sorts: [of_case.Case_Geo, of_case.case_distinct_count desc 0]
    limit: 500
    dynamic_fields: [{category: dimension, expression: "${of_case.sub_category_l2}",
        label: L2 for filter, value_format: !!null '', value_format_name: !!null '',
        dimension: l2_for_filter, _kind_hint: dimension, _type_hint: string}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: HKGHQ - of_case.count,
            id: HKGHQ - of_case.count, name: HKGHQ}, {axisId: LONHQ - of_case.count,
            id: LONHQ - of_case.count, name: LONHQ}, {axisId: RICHQ - of_case.count,
            id: RICHQ - of_case.count, name: RICHQ}, {axisId: SAOHQ - of_case.count,
            id: SAOHQ - of_case.count, name: SAOHQ}, {axisId: SINHQ - of_case.count,
            id: SINHQ - of_case.count, name: SINHQ}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_colors:
      RICHQ - of_case.count: "#3D7876"
      RICHQ - of_case.case_distinct_count: "#3D7876"
    series_labels:
      4 - of_case.case_distinct_count: ONECare
      3 - of_case.case_distinct_count: LKA
      2 - of_case.case_distinct_count: RKA
      1 - of_case.case_distinct_count: GKA
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labPer
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Total Case Volume
      by L2 Intent<BR><B>How it Helps : </B>To evaluate total no. of cases by L2 Intent<BR>[ALL
      Case Status]<BR><B>Target : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 52
    col: 12
    width: 12
    height: 7
  - title: Volume by Location & Channel*
    name: Volume by Location & Channel*
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.Case_Geo, of_case.origin, of_case.case_distinct_count]
    pivots: [of_case.origin]
    sorts: [of_case.origin, of_case.Case_Geo, of_case.case_distinct_count desc 0]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: HKGHQ - of_case.count,
            id: HKGHQ - of_case.count, name: HKGHQ}, {axisId: LONHQ - of_case.count,
            id: LONHQ - of_case.count, name: LONHQ}, {axisId: RICHQ - of_case.count,
            id: RICHQ - of_case.count, name: RICHQ}, {axisId: SAOHQ - of_case.count,
            id: SAOHQ - of_case.count, name: SAOHQ}, {axisId: SINHQ - of_case.count,
            id: SINHQ - of_case.count, name: SINHQ}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    series_types: {}
    series_colors:
      LONHQ - of_case.count: "#8b908f"
      RICHQ - of_case.count: "#00506D"
      SAOHQ - of_case.count: "#AB6E13"
      Internal - of_case.count: "#AB6E13"
      Internal - of_case.case_distinct_count: "#AB6E13"
    value_labels: labels
    label_type: labVal
    inner_radius: 60
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Total Case Volume
      <BR><B>How it Helps : </B>To evaluate total no. of cases<BR>[ALL Case Status]<BR><B>Target
      : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 2
    col: 0
    width: 12
    height: 6
  - title: Open Urgent and High Priority Cases by Customer
    name: Open Urgent and High Priority Cases by Customer
    model: oneforce_service
    explore: of_case
    type: looker_grid
    fields: [of_customer.name, of_case.case_distinct_count_drill]
    filters:
      of_case.active_case: 'Yes'
      customer_name: "-NULL"
      high_priority_for_filter: High,Urgent
    sorts: [of_case.case_distinct_count_drill desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: "${of_customer.name}", label: Customer
          Name, value_format: !!null '', value_format_name: !!null '', dimension: customer_name,
        _kind_hint: dimension, _type_hint: string}, {category: dimension, expression: "${of_case.priority}",
        label: High Priority for filter, value_format: !!null '', value_format_name: !!null '',
        dimension: high_priority_for_filter, _kind_hint: dimension, _type_hint: string}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    series_labels:
      of_case.case_distinct_count_drill: Count
    series_cell_visualizations:
      of_case.count:
        is_active: true
        palette:
          palette_id: 90c952d7-5f79-4b02-5859-c52f38d3587f
          collection_id: one-theme
          custom_colors:
          - "#F0D6E5"
          - "#BD0F72"
          - "#7f0b4d"
      of_case.case_distinct_count_drill:
        is_active: true
        palette:
          palette_id: 043512a0-8b61-c2e0-37d7-99714dfb9fe2
          collection_id: one-theme
          custom_colors:
          - "#F0D6E5"
          - "#BD0F72"
          - "#7f0b4d"
    series_value_format:
      of_case.case_distinct_count_drill: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: of_case.count, id: of_case.count,
            name: Case}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types: {}
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Total no. of Urgent
      and High Priority Cases by Customer<BR><B>How it Helps : </B>To evaluate Top
      Customers by Urgent and High Priority Cases<BR>[ALL Case Status]<BR><B>Target
      : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 59
    col: 0
    width: 12
    height: 7
  - title: Open Cases by Customer Segment & Channel
    name: Open Cases by Customer Segment & Channel
    model: oneforce_service
    explore: of_case
    type: looker_bar
    fields: [of_case.origin, of_customer_group.key_acct_tp_cd, of_case.case_distinct_count]
    pivots: [of_customer_group.key_acct_tp_cd]
    filters:
      of_case.active_case: 'Yes'
    sorts: [of_customer_group.key_acct_tp_cd, of_case.case_distinct_count desc 0]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: circle_outline
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_application: undefined
    y_axes: [{label: '', orientation: bottom, series: [{axisId: GKA - of_case.count,
            id: GKA - of_case.count, name: GKA}, {axisId: LKA - of_case.count, id: LKA
              - of_case.count, name: LKA}, {axisId: ONECare - of_case.count, id: ONECare
              - of_case.count, name: ONECare}, {axisId: RKA - of_case.count, id: RKA
              - of_case.count, name: RKA}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    series_types: {}
    series_colors:
      LKA - of_case.count: "#8b908f"
      ONECare - of_case.count: "#BD0F72"
      RKA - of_case.count: "#84C5C3"
      GKA - of_case.count: "#00506D"
      GKA - of_case.case_distinct_count: "#00506D"
      LKA - of_case.case_distinct_count: "#8b908f"
      ONECare - of_case.case_distinct_count: "#BD0F72"
      RKA - of_case.case_distinct_count: "#84C5C3"
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>No. of Open Cases
      by Customer Segment & Channel<BR><B>How it Helps : </B>To evaluate no. of Open
      cases by Customer Segment, Channelwise<BR>[Case Status ≠ "Resolved" & "Closed"]<BR><B>Target
      : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 33
    col: 0
    width: 12
    height: 6
  - title: Open Escalated Cases by Customer Segment
    name: Open Escalated Cases by Customer Segment
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_customer_group.key_acct_tp_cd, of_case.case_distinct_count_drill]
    filters:
      of_case.active_case: 'Yes'
      of_case.total_escalation: ">0"
    sorts: [of_customer_group.key_acct_tp_cd desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: true
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.count, id: of_case.count,
            name: Case}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    series_types: {}
    series_colors:
      of_case.count: "#F39200"
    series_labels: {}
    color_range: ["#BD0F72", "#CCD3D1", "#340335", "#00506D", "#84C5C3", "#F39200",
      "#7f0b4d", "#8b908f", "#000000", "#222b35", "#3D7876", "#AB6E13", "#F0D6E5",
      "#e3eae8", "#e7dae7", "#c9e3ec", "#CFEFEE", "#FFE2B7"]
    show_null_points: true
    show_percent: true
    defaults_version: 1
    hidden_fields: []
    hidden_points_if_no: []
    value_labels: legend
    label_type: labPer
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    interpolation: linear
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>No. of Open Escalated
      Cases by Customer Segment<BR><B>How it Helps : </B>To evaluate no. of Open cases
      by Customer Segment<BR>[Case Status ≠ "Resolved" & "Closed" and Total Escalation
      is Greater than 0]<BR><B>Target : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 33
    col: 12
    width: 12
    height: 6
  - title: Closed/ Resolved
    name: Closed/ Resolved
    model: oneforce_service
    explore: of_case
    type: single_value
    fields: [of_case.case_distinct_count_drill]
    filters:
      of_case.active_case: 'No'
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#7f0b4d"
    single_value_title: Closed
    value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#BD0F72",
        font_color: !!null '', color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>No. of Closed Cases<BR><B>How
      it Helps : </B>To evaluate the no. of Closed cases<BR>[Case Status = "Resolved"
      & "Closed"]<BR><B>Target : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 0
    col: 4
    width: 2
    height: 2
  - name: '<a target="_blank" style="color:#BD0F72; font-size:1vw"  href="https://onelinecloudlookercom/embed/dashboards/1129"><b>Fullscreen?</b></a><p
      style="font-size:1vw">Version: 20230830 </p>'
    type: text
    title_text: '<a target="_blank" style="color:#BD0F72; font-size:1vw"  href="https://oneline.cloud.looker.com/embed/dashboards/1129"><b>Fullscreen?</b></a><p
      style="font-size:1vw">Version: 2023.08.30 </p>'
    subtitle_text: ''
    body_text: ''
    row: 80
    col: 17
    width: 7
    height: 3
  - title: Top 10 Customers by Cases
    name: Top 10 Customers by Cases
    model: oneforce_service
    explore: of_case
    type: looker_bar
    fields: [of_customer.customer_cd_and_name, of_case.active_case, of_case.case_distinct_count_drill]
    pivots: [of_case.active_case]
    filters:
      has_customer_name: "-NULL"
    sorts: [of_case.active_case, of_case.case_distinct_count_drill desc 0]
    limit: 10
    column_limit: 50
    row_total: right
    dynamic_fields: [{category: dimension, expression: "${of_customer.customer_cd_and_name}",
        label: Has Customer Name, value_format: !!null '', value_format_name: !!null '',
        dimension: has_customer_name, _kind_hint: dimension, _type_hint: string}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: circle_outline
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#000000"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: No - of_case.case_distinct_count_drill,
            id: No - of_case.case_distinct_count_drill, name: 'No'}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, type: linear},
      {label: '', orientation: bottom, series: [{axisId: Yes - of_case.case_distinct_count_drill,
            id: Yes - of_case.case_distinct_count_drill, name: 'Yes'}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, type: linear}]
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    series_types:
      Yes - of_case.count: line
      Yes - of_case.case_distinct_count_drill: line
    series_colors:
      Awaiting Customer Response - of_case.count: "#340335"
      Closed - of_case.count: "#000000"
      New - of_case.count: "#00506D"
      Resolved - of_case.count: "#8b908f"
      Awaiting Internal Team Response - of_case.count: "#7f0b4d"
      In Progress - of_case.count: "#BD0F72"
      No - of_case.count: "#BD0F72"
      Yes - of_case.count: "#84C5C3"
    series_labels:
      No - of_case.count: Closed Cases
      Yes - of_case.count: Open Cases
      No - of_case.case_distinct_count_drill: Closed Cases
      Yes - of_case.case_distinct_count_drill: Open Cases
    label_color: []
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Total Case Volume
      by Top 10 Customers<BR><B>How it Helps : </B>To evaluate total  no. of cases
      by Top 10 Customers<BR>[ALL Case Status]<BR><B>Target : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 59
    col: 12
    width: 12
    height: 7
  - title: Escalation Trend by Channel
    name: Escalation Trend by Channel
    model: oneforce_service
    explore: of_case
    type: looker_line
    fields: [of_case.origin, of_case.createddate_dynamic, of_case.case_distinct_count]
    pivots: [of_case.origin]
    filters:
      of_case.total_escalation: ">0"
    sorts: [of_case.origin, of_case.createddate_dynamic]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle_outline
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.count, id: Chat
              - of_case.count, name: Chat}, {axisId: of_case.count, id: Email - of_case.count,
            name: Email}, {axisId: of_case.count, id: Internal - of_case.count, name: Internal},
          {axisId: of_case.count, id: Phone - of_case.count, name: Phone}, {axisId: of_case.count,
            id: Web - of_case.count, name: Web}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    series_types: {}
    series_colors:
      Chat - of_case.count: "#BD0F72"
      Email - of_case.count: "#00506D"
      Web - of_case.count: "#8b908f"
      Internal - of_case.count: "#000000"
      Phone - of_case.count: "#AB6E13"
      Email - of_case.case_distinct_count: "#00506D"
      Internal - of_case.case_distinct_count: "#000000"
      Phone - of_case.case_distinct_count: "#AB6E13"
      Web - of_case.case_distinct_count: "#8b908f"
    swap_axes: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Escalation Trend
      by Channel<BR><B>How it Helps : </B>To evaluate weekly trend of Escalated cases
      by Channel<BR>[ALL Case Status and Total Escalation is Greater than 0]<BR><B>Target
      : </B>By Email: TBD By Phone: TBD By Chat: TBD By Web: TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 45
    col: 16
    width: 8
    height: 7
  - title: Total Escl (30 Days)
    name: Total Escl (30 Days)
    model: oneforce_service
    explore: of_case
    type: single_value
    fields: [of_case.case_distinct_count_drill]
    filters:
      of_case.createddate_month: 1 months
      of_case.total_escalation: ">0"
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#7f0b4d"
    single_value_title: Total Escl (30 Days)
    value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#BD0F72",
        font_color: '', color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Total Escalated Cases
      (This Month)<BR><B>How it Helps : </B>To evaluate no.of Escalated cases this
      month<BR>[ALL Case Status and Total Escalation is Greater than 0]<BR><B>Target
      : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 0
    col: 11
    width: 3
    height: 2
  - title: Trend by Location*
    name: Trend by Location*
    model: oneforce_service
    explore: of_case
    type: looker_line
    fields: [of_case.Case_Geo, of_case.createddate_dynamic, of_case.case_distinct_count]
    pivots: [of_case.Case_Geo]
    sorts: [of_case.Case_Geo, of_case.createddate_dynamic]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
    y_axes: [{label: Cases, orientation: left, series: [{axisId: of_case.count, id: HKGHQ
              - of_case.count, name: HKGHQ}, {axisId: of_case.count, id: LONHQ - of_case.count,
            name: LONHQ}, {axisId: of_case.count, id: RICHQ - of_case.count, name: RICHQ},
          {axisId: of_case.count, id: SAOHQ - of_case.count, name: SAOHQ}, {axisId: of_case.count,
            id: SINHQ - of_case.count, name: SINHQ}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_label: ''
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    series_types: {}
    series_colors:
      Chat - of_case.count: "#BD0F72"
      Email - of_case.count: "#8b908f"
      Web - of_case.count: "#00506D"
      Internal - of_case.count: "#222b35"
      Phone - of_case.count: "#3D7876"
      LONHQ - of_case.count: "#8b908f"
      SINHQ - of_case.count: "#000000"
      SINHQ - of_case.case_distinct_count: "#000000"
    series_labels:
      1 - of_case.case_distinct_count: GKA
      2 - of_case.case_distinct_count: RKA
      3 - of_case.case_distinct_count: LKA
      4 - of_case.case_distinct_count: ONECare
    leftAxisLabelVisible: true
    leftAxisLabel: ''
    rightAxisLabelVisible: true
    rightAxisLabel: ''
    smoothedBars: true
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: true
    labelColor: "#000000"
    isStepped: true
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B> Trend of Cases<BR><B>How
      it Helps : </B>To evaluate trend of total no. of cases<BR>[ALL Case Status]<BR><B>Target
      : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 45
    col: 8
    width: 8
    height: 7
  - name: ''
    type: text
    title_text: ''
    body_text: "#####Clear Cache for latest data: \nStep 1: Just click anywhere inside\
      \ the Dashboard and then <BR>Step 2: Press Ctrl+Shift+Enter Key to clear the\
      \ cache and refresh\n\n"
    row: 80
    col: 0
    width: 9
    height: 3
  - title: By Intent L2 & L3
    name: By Intent L2 & L3
    model: oneforce_service
    explore: of_case
    type: looker_grid
    fields: [of_case.sub_category_l2, of_case.subordinate_category_l3, of_case.case_distinct_count_drill]
    filters:
      category_l2_for_filter: "-NULL"
    sorts: [of_case.case_distinct_count_drill desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: "${of_case.sub_category_l2}",
        label: Category L2 for filter, value_format: !!null '', value_format_name: !!null '',
        dimension: category_l2_for_filter, _kind_hint: dimension, _type_hint: string}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    series_labels:
      of_case.case_distinct_count: Case
      of_case.case_distinct_count_drill: Case
    series_cell_visualizations:
      of_case.count:
        is_active: true
        palette:
          palette_id: 209471f1-9ec9-5a9b-4c39-2de406ea17a8
          collection_id: one-theme
          custom_colors:
          - "#F0D6E5"
          - "#BD0F72"
          - "#BD0F72"
      of_case.case_distinct_count:
        is_active: true
        palette:
          palette_id: a75bd352-e8c1-a458-e75a-1551151e7835
          collection_id: one-theme
          custom_colors:
          - "#F0D6E5"
          - "#BD0F72"
          - "#BD0F72"
      of_case.case_distinct_count_drill:
        is_active: true
        palette:
          palette_id: 4f884884-09c7-055f-39a5-aeff0e46407c
          collection_id: one-theme
          custom_colors:
          - "#F0D6E5"
          - "#BD0F72"
          - "#7f0b4d"
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#BD0F72",
        font_color: !!null '', color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_value_format:
      of_case.case_distinct_count_drill: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Total Case Volume
      by L2 & L3 Intent<BR><B>How it Helps : </B>To evaluate total no. of cases by
      L2 and L3 Intent<BR>[ALL Case Status]<BR><B>Target : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 52
    col: 0
    width: 12
    height: 7
  - title: Owned by Queue
    name: Owned by Queue
    model: oneforce_service
    explore: of_case
    type: single_value
    fields: [of_case.case_distinct_count_drill]
    filters:
      of_queue.ownedbyQueue: 'Yes'
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#7f0b4d"
    single_value_title: Owned by Queue
    value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#BD0F72",
        font_color: !!null '', color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>No. of Cases owned
      by a Queue name<BR><B>How it Helps : </B>To evaluate no. of cases owned by a
      Queue<BR>[Number of cases which are routed to Queue but not to individual]<BR><B>Target
      : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 0
    col: 14
    width: 2
    height: 2
  - title: Abandoned Chats*
    name: Abandoned Chats*
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.case_distinct_count, of_case.Case_Geo, customer_abandoned_chat]
    pivots: [customer_abandoned_chat]
    filters:
      of_case.active_case: 'No'
      chat_cases: 'Yes'
    sorts: [customer_abandoned_chat, of_case.Case_Geo]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'case (when(${of_case.resolution_reason}="Customer
          Abandoned Chat","Yes"),"No")', label: Customer Abandoned Chat, value_format: !!null '',
        value_format_name: !!null '', dimension: customer_abandoned_chat, _kind_hint: dimension,
        _type_hint: string}, {category: dimension, expression: 'case (when(${of_case.origin}="Chat",
          "Yes"), "No")', label: Chat Cases, value_format: !!null '', value_format_name: !!null '',
        dimension: chat_cases, _kind_hint: dimension, _type_hint: string}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: true
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.case_distinct_count,
            id: of_case.case_distinct_count, name: Case Distinct Count}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_types: {}
    series_colors:
      abandoned_cases: "#84C5C3"
      Yes - of_case.case_distinct_count: "#F39200"
    series_labels:
      No - of_case.case_distinct_count: Other Cases
      Yes - of_case.case_distinct_count: Abandoned Cases
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>No. of Abandoned
      Chats from Customers vs Total Chat Cases<BR><B>How it Helps : </B>To evaluate
      no.of Abandoned Chats cases by Customer vs Total Chat Cases<BR>[Case Status
      = "Resolved" & "Closed", Resolution Reason = "Customer Abandoned Chats", Channel
      = "Chat"]<BR><B>Target : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 39
    col: 0
    width: 8
    height: 6
  - title: Duplicate, No Action vs Total Cases by Location*
    name: Duplicate, No Action vs Total Cases by Location*
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.Case_Geo, of_case.all_cases, of_case.no_action_required_cases,
      of_case.duplicate_cases]
    filters:
      of_case.active_case: 'No'
    sorts: [of_case.Case_Geo]
    limit: 500
    dynamic_fields: [{category: measure, expression: !!null '', label: Duplicate Cases,
        value_format: !!null '', value_format_name: !!null '', based_on: of_case.case_distinct_count,
        _kind_hint: measure, measure: duplicate_cases, type: count_distinct, _type_hint: number,
        filters: {of_case.resolution_reason: Duplicate}}, {category: measure, expression: !!null '',
        label: No Action Required Cases, value_format: !!null '', value_format_name: !!null '',
        based_on: of_case.case_distinct_count, _kind_hint: measure, measure: no_action_required_cases,
        type: count_distinct, _type_hint: number, filters: {of_case.resolution_reason: No
            Action Required}}, {category: measure, expression: !!null '', label: All
          Cases, value_format: !!null '', value_format_name: !!null '', based_on: of_case.case_distinct_count,
        _kind_hint: measure, measure: all_cases, type: count_distinct, _type_hint: number,
        filters: {of_case.resolution_reason: 'Customer Abandoned Chat,Customer Query
            Un-resolved,None,Customer Query Resolved'}}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: true
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: circle_outline
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: No - of_case.case_distinct_count,
            id: No - of_case.case_distinct_count, name: Other Cases}, {axisId: Yes
              - of_case.case_distinct_count, id: Yes - of_case.case_distinct_count,
            name: Duplicate Cases}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_colors:
      duplicate_count: "#84C5C3"
      of_case.case_distinct_count: "#BD0F72"
      Yes - of_case.case_distinct_count: "#8b908f"
      all_cases: "#BD0F72"
      duplicate_cases: "#8b908f"
      no_action_required_cases: "#000000"
      of_case.no_action_required_cases: "#000000"
      of_case.duplicate_cases: "#F39200"
    series_labels:
      of_case.case_distinct_count: Case Count
      No - of_case.case_distinct_count: Other Cases
      Yes - of_case.case_distinct_count: Duplicate Cases
      all_cases: Other Cases
      no_action_required_cases: No Action Required
      of_case.all_cases: Other Cases
      of_case.no_action_required_cases: No Action Required
    series_point_styles:
      duplicate_count: triangle-down
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>No. of Duplicate
      Cases, No Action Required Cases vs Total Cases<BR><B>How it Helps : </B>To evaluate
      no. of Duplicate Cases and No Action Required Cases out of All cases<BR>[Case
      Status = "Resolved" & "Closed" and Resolution Reason = "Duplicate"]<BR><B>Target
      : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 39
    col: 8
    width: 8
    height: 6
  - title: Total
    name: Total
    model: oneforce_service
    explore: of_case
    type: single_value
    fields: [of_case.case_distinct_count_drill]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#7f0b4d"
    single_value_title: Total
    value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#BD0F72",
        font_color: !!null '', color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>No. of Total Cases<BR><B>How
      it Helps : </B>To evaluate the no. of Total cases<BR>[ALL Case Status]<BR><B>Target
      : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 0
    col: 6
    width: 2
    height: 2
  - title: CSAT by Location*
    name: CSAT by Location*
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.Case_Geo, of_case.rating_case_chat, of_case.case_distinct_count_csat]
    pivots: [of_case.rating_case_chat]
    filters: {}
    sorts: [of_case.Case_Geo, of_case.rating_case_chat]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: true
    legend_position: center
    point_style: circle_outline
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.case_distinct_count,
            id: of_case.case_distinct_count, name: Distinct Count}, {axisId: good_rating,
            id: good_rating, name: Good Rating}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hidden_series: [of_case.case_rating___null - of_case.case_distinct_count]
    series_types:
      good_rating: line
    series_colors:
      good_rating: "#84C5C3"
      Good - of_case.case_distinct_count: "#BD0F72"
      Bad - of_case.case_distinct_count: "#F39200"
      of_case.case_rating___null - of_case.case_distinct_count: "#8b908f"
      No Rating - of_case.case_distinct_count: "#8b908f"
      Bad - of_case.case_distinct_count_csat: "#F39200"
      Good - of_case.case_distinct_count_csat: "#BD0F72"
      No Rating - of_case.case_distinct_count_csat: "#8b908f"
    series_labels:
      of_case.case_distinct_count: Case
      of_case.case_rating___null - of_case.case_distinct_count: No Rating
      Good - of_case.case_distinct_count: Good
      Bad - of_case.case_distinct_count: bad
      No Rating - of_case.case_distinct_count: No Rating
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Customer Rating by
      Location <BR><B>How it Helps : </B>To evaluate cases rated Good v/s number of
      cases received <BR><B>Target : </B>TBD'
    hidden_pivots: {}
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      CSAT: of_case.csat_Param
    row: 39
    col: 16
    width: 8
    height: 6
  - title: Case Escalation Ratio by Location*
    name: Case Escalation Ratio by Location*
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.Case_Geo, total_escalation, of_case.case_distinct_count]
    pivots: [total_escalation]
    sorts: [of_case.Case_Geo, total_escalation]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'if(${of_case.total_escalation}
          > 0, "Yes", "No")', label: Total Escalation, value_format: !!null '', value_format_name: !!null '',
        dimension: total_escalation, _kind_hint: dimension, _type_hint: string}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: true
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: false - of_case.count,
            id: false - of_case.count, name: Total Cases}, {axisId: true - of_case.count,
            id: true - of_case.count, name: Escalated Cases}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_colors:
      false - of_case.count: "#BD0F72"
      true - of_case.count: "#F39200"
      Yes - of_case.count: "#F39200"
      Yes - of_case.case_distinct_count: "#F39200"
    series_labels:
      false - of_case.count: Total Cases
      true - of_case.count: Escalated Cases
      No - of_case.count: Total Cases
      Yes - of_case.count: Escalated Cases
      No - of_case.case_distinct_count: Total Cases
      Yes - of_case.case_distinct_count: Escalated Cases
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Case Escalation Ratio<BR><B>How
      it Helps : </B>To evaluate no. of Escalated cases<BR>[ALL Case Status, Total
      Escalation>0]<BR><B>Target : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 8
    col: 12
    width: 12
    height: 6
  - title: Deflection Ratio by Location*
    name: Deflection Ratio by Location*
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.origin, of_case.Case_Geo, of_case.deflection_ratio, of_case.case_distinct_count]
    pivots: [of_case.origin]
    sorts: [of_case.origin, of_case.Case_Geo]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: table_calculation, label: Percent of row, value_format: !!null '',
        value_format_name: percent_0, calculation_type: percent_of_row, table_calculation: percent_of_row,
        args: [of_case.case_distinct_count], _kind_hint: measure, _type_hint: number,
        is_disabled: true}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: percent_of_row, id: Chat
              - percent_of_row, name: Chat}, {axisId: percent_of_row, id: Email -
              percent_of_row, name: Email}, {axisId: percent_of_row, id: Internal
              - percent_of_row, name: Internal}, {axisId: percent_of_row, id: Phone
              - percent_of_row, name: Phone}, {axisId: percent_of_row, id: Web - percent_of_row,
            name: Web}], showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      Web - percent_of_row: "#CCD3D1"
      Email - percent_of_row: "#340335"
      Internal - percent_of_row: "#00506D"
      Phone - percent_of_row: "#84C5C3"
    defaults_version: 1
    hidden_fields: [of_case.deflection_ratio]
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Digital Deflection
      Ratio<BR><B>How it Helps : </B>Measure how many of our Service Support channels
      for Email, Internal and Phone are deflected to Chat and Web channels<BR>[Total
      no. of Each Channel / Total Cases]<BR><B>Target : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 66
    col: 0
    width: 12
    height: 7
  - title: Overall Deflection Ratio
    name: Overall Deflection Ratio
    model: oneforce_service
    explore: of_case
    type: single_value
    fields: [of_case.deflection_ratio]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#7f0b4d"
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#BD0F72",
        font_color: !!null '', color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Ratio of cases that
      are deflected to Chat and Web Channel . Exclude self-service links that are
      routed to a mailbox, forms that is served by our own agents<BR><B>How it Helps
      : </B>To evaluate the Case Deflection ratio to Chat and Web Channel that is
      TRUE Deflection<BR>[Total Chat & Web Cases (exclude "Is Digital Deflection"
      = False cases) / Total Cases]<BR><B>Target : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 0
    col: 16
    width: 3
    height: 2
  - title: Deflection Trend by Location*
    name: Deflection Trend by Location*
    model: oneforce_service
    explore: of_case
    type: looker_line
    fields: [of_case.Case_Geo, of_case.createddate_dynamic, of_case.deflection_ratio]
    pivots: [of_case.Case_Geo]
    sorts: [of_case.createddate_dynamic desc, of_case.Case_Geo]
    limit: 500
    row_total: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.deflection_ratio,
            id: HKGHQ - of_case.deflection_ratio, name: HKGHQ}, {axisId: of_case.deflection_ratio,
            id: LONHQ - of_case.deflection_ratio, name: LONHQ}, {axisId: of_case.deflection_ratio,
            id: RICHQ - of_case.deflection_ratio, name: RICHQ}, {axisId: of_case.deflection_ratio,
            id: SAOHQ - of_case.deflection_ratio, name: SAOHQ}, {axisId: of_case.deflection_ratio,
            id: SINHQ - of_case.deflection_ratio, name: SINHQ}, {axisId: of_case.deflection_ratio,
            id: Row Total - of_case.deflection_ratio, name: Row Total}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_colors:
      LONHQ - of_case.deflection_ratio: "#8b908f"
    series_labels:
      Row Total - of_case.deflection_ratio: Global
      1 - of_case.deflection_ratio: GKA
      2 - of_case.deflection_ratio: RKA
      3 - of_case.deflection_ratio: LKA
      4 - of_case.deflection_ratio: ONECare
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Ratio of cases that
      are deflected to Chat and Web Channel by Trend. Exclude self-service links that
      are routed to a mailbox, forms that is served by our own agents<BR><B>How it
      Helps : </B>To evaluate the trend of Case Deflection ratio to Chat and Web Channel
      <BR>[Total Chat & Web Cases  / Total Cases]<BR><B>Target : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 66
    col: 12
    width: 12
    height: 7
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      ######Notes
      * Data shown is in UTC Time Zone
      * *- Charts based on the dynamic filter. Please use the 'View By' option to change the charts dynamically
      * **- Charts based on the dynamic filter. Please use the 'Transferred Cases By' option to change the charts dynamically
    row: 80
    col: 9
    width: 8
    height: 4
  - title: Overall CSAT Rating
    name: Overall CSAT Rating
    model: oneforce_service
    explore: of_case
    type: single_value
    fields: [of_case.customer_satisfaction_ratio_case_chat]
    filters:
      case_rating_for_filter: ''
      channel_for_filter: ''
      chat_rating_for_filter: ''
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: measure, expression: !!null '', label: All Rating,
        value_format: !!null '', value_format_name: !!null '', based_on: of_case.casenumber,
        _kind_hint: measure, measure: all_rating, type: count_distinct, _type_hint: number,
        filters: {of_chat_transcript.chat_case_rating: 'Good,Bad'}}, {category: measure,
        expression: !!null '', label: Good Rating, value_format: !!null '', value_format_name: !!null '',
        based_on: of_case.casenumber, _kind_hint: measure, measure: good_rating, type: count_distinct,
        _type_hint: number, filters: {of_chat_transcript.chat_case_rating: Good}},
      {category: table_calculation, expression: "${good_rating} / ${all_rating}",
        label: Diff, value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        table_calculation: diff, _type_hint: number, is_disabled: true}, {category: dimension,
        expression: "${of_case.case_rating}", label: Case Rating for Filter, value_format: !!null '',
        value_format_name: !!null '', dimension: case_rating_for_filter, _kind_hint: dimension,
        _type_hint: string}, {category: dimension, expression: "${of_case.origin}",
        label: Channel For Filter, value_format: !!null '', value_format_name: !!null '',
        dimension: channel_for_filter, _kind_hint: dimension, _type_hint: string},
      {category: dimension, expression: "${of_chat_transcript.chat_case_rating}",
        label: Chat Rating for Filter, value_format: !!null '', value_format_name: !!null '',
        dimension: chat_rating_for_filter, _kind_hint: dimension, _type_hint: string}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#7f0b4d"
    conditional_formatting: [{type: greater than, value: 0.5, background_color: "#BD0F72",
        font_color: !!null '', color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0.5, background_color: "#FFE2B7", font_color: !!null '', color_application: {
          collection_id: one-theme, palette_id: one-theme-sequential-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    circleThickness: 0.5
    circleFillGap: 0.5
    textVertPosition: 0.5
    textSize: 0.5
    displayPercent: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_fields: []
    series_types: {}
    hidden_points_if_no: []
    series_labels: {}
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: |-
      <P style="text-align:left;"><B>Metric Name : </B>Overall CSAT Good Rating ratio<BR><B>How it Helps : </B>To evaluate the overall CSAT Good rating ratio<BR>
      [Good CSAT rating / Total Good and Bad Rating in %]<BR><B>Target : </B>TBD
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      CSAT: of_case.csat_Param
    row: 0
    col: 19
    width: 3
    height: 2
  - title: Global NPS
    name: Global NPS
    model: oneforce_service
    explore: of_case
    type: single_value
    fields: [of_case.global_nps_case_chat]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#7f0b4d"
    value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    conditional_formatting: [{type: greater than, value: 0, background_color: "#BD0F72",
        font_color: !!null '', color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: |-
      <P style="text-align:left;"><B>Metric Name : </B>Global Net Promoter Score<BR><B>How it Helps : </B>To measure our Customer Brand Loyalty<BR>
      <BR>
      [NPS Computation:<BR>
      Detractors: NPS Score 1 to 6<BR>
      Passives: NPS Score 7 to 8<BR>
      Promoters: NPS Score 9 to 10<BR><BR>

      Detractors %: No. Of Detractors responses / Total responses (Detractors, Passives, Promoters)<BR>
      Promoters %: No. Of Promoters responses / Total responses (Detractors, Passives, Promoters)<BR>
      <BR>
      NPS : Promoters % - Detractors %]<BR><B>Target : </B>TBD
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      NPS: of_case.globalnps_Param
    row: 0
    col: 22
    width: 2
    height: 2
  - title: NPS by Location*
    name: NPS by Location*
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.Case_Geo, of_case.nps_segment_case_chat, of_case.case_distinct_count_nps]
    pivots: [of_case.nps_segment_case_chat]
    sorts: [of_case.Case_Geo, of_case.nps_segment_case_chat]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: 'case (when(${of_chat_transcript.chat_nps_group}="No
          Rating","Without Rating"),${of_chat_transcript.chat_nps_group})', label: NPS
          Segment, value_format: !!null '', value_format_name: !!null '', dimension: nps_segment,
        _kind_hint: dimension, _type_hint: string}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: Detractors - of_case.case_distinct_count,
            id: Detractors - of_case.case_distinct_count, name: Detractors}, {axisId: No
              Rating - of_case.case_distinct_count, id: No Rating - of_case.case_distinct_count,
            name: No Rating}, {axisId: Passives - of_case.case_distinct_count, id: Passives
              - of_case.case_distinct_count, name: Passives}, {axisId: Promoters -
              of_case.case_distinct_count, id: Promoters - of_case.case_distinct_count,
            name: Promoters}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      Detractors - of_case.case_distinct_count: "#F39200"
      Passives - of_case.case_distinct_count: "#00506D"
      Promoters - of_case.case_distinct_count: "#BD0F72"
      Without Rating - of_case.case_distinct_count: "#CCD3D1"
      Detractors - of_case.case_distinct_count_nps: "#F39200"
      No Rating - of_case.case_distinct_count_nps: "#8b908f"
      Passives - of_case.case_distinct_count_nps: "#00506D"
      Promoters - of_case.case_distinct_count_nps: "#BD0F72"
    series_labels:
      Without Rating - of_case.case_distinct_count: No Rating
    defaults_version: 1
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: |-
      <P style="text-align:left;"><B>Metric Name : </B>Net Promoter Score <BR><B>How it Helps : </B>

      To measure our Customer Brand loyalty using Net Promoter Score <br><br>

      Detractors: NPS Score 1 to 6<br>
      Passives: NPS Score 7 to 8<br>
      Promoters: NPS Score 9 to 10<br><BR><B>Target : </B>TBD
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      NPS: of_case.globalnps_Param
    row: 73
    col: 0
    width: 12
    height: 7
  - title: NPS trend by Location*
    name: NPS trend by Location*
    model: oneforce_service
    explore: of_case
    type: looker_line
    fields: [of_case.Case_Geo, of_case.createddate_dynamic, of_case.global_nps_case_chat]
    pivots: [of_case.Case_Geo]
    sorts: [of_case.createddate_dynamic desc, of_case.Case_Geo]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle_outline
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.global_nps,
            id: HKGHQ - of_case.global_nps, name: HKGHQ}, {axisId: of_case.global_nps,
            id: LONHQ - of_case.global_nps, name: LONHQ}, {axisId: of_case.global_nps,
            id: RICHQ - of_case.global_nps, name: RICHQ}, {axisId: of_case.global_nps,
            id: SAOHQ - of_case.global_nps, name: SAOHQ}, {axisId: of_case.global_nps,
            id: SINHQ - of_case.global_nps, name: SINHQ}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    series_types: {}
    series_colors:
      LONHQ - of_case.global_nps: "#8b908f"
    series_labels:
      1 - of_case.global_nps: GKA
      2 - of_case.global_nps: RKA
      3 - of_case.global_nps: LKA
      4 - of_case.global_nps: ONECare
    defaults_version: 1
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: |-
      <P style="text-align:left;"><B>Metric Name : </B>Net Promoter Score Trend <BR><B>How it Helps : </B>

      To measure the trend of our Customer Brand loyalty using Net Promoter Score <br><br>

      Detractors: NPS Score 1 to 6<br>
      Passives: NPS Score 7 to 8<br>
      Promoters: NPS Score 9 to 10<br><BR><B>Target : </B>TBD
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      NPS: of_case.globalnps_Param
    row: 73
    col: 12
    width: 12
    height: 7
  - title: Chat Transcript Volume*
    name: Chat Transcript Volume*
    model: oneforce_service
    explore: of_case
    type: looker_bar
    fields: [of_case.Case_Geo, sequence, of_chat_transcript.count]
    filters: {}
    sorts: [of_case.Case_Geo]
    limit: 500
    dynamic_fields: [{category: dimension, expression: "if (${of_case.Case_Geo} =\
          \ \"GKA\",1,\n  if (${of_case.Case_Geo} = \"RKA\",2,\n    if (${of_case.Case_Geo}\
          \ = \"LKA\",3,\n      if (${of_case.Case_Geo} = \"ONECare\",4,9))))\n   ",
        label: Sequence, value_format: !!null '', value_format_name: !!null '', dimension: sequence,
        _kind_hint: dimension, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: of_chat_transcript.count,
            id: of_chat_transcript.count, name: Chat Transcript}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    series_types: {}
    defaults_version: 1
    hidden_fields: [sequence]
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Chat Transcript Volume<BR><B>How
      it Helps : </B>To evaluate total no. of chat session volume <BR>[ALL Case Status]<BR><B>Target
      : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 2
    col: 12
    width: 12
    height: 6
  - title: Case Transfer Ratio by Location*
    name: Case Transfer Ratio by Location*
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.Case_Geo, of_case.case_distinct_count1, of_case.transfer_ratio]
    pivots: [of_case.transfer_ratio]
    sorts: [of_case.Case_Geo, of_case.transfer_ratio]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'is_null(${of_case.transfer_reason})',
        label: Transfer Ratio, value_format: !!null '', value_format_name: !!null '',
        dimension: transfer_ratio, _kind_hint: dimension, _type_hint: yesno}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: true
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: false - of_case.count,
            id: false - of_case.count, name: Total Cases}, {axisId: true - of_case.count,
            id: true - of_case.count, name: Escalated Cases}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_colors:
      false - of_case.count: "#BD0F72"
      true - of_case.count: "#F39200"
      Yes - of_case.count: "#F39200"
      Yes - of_case.case_distinct_count: "#F39200"
      No - of_case.case_distinct_count: "#BD0F72"
      Yes - of_case.case_distinct_count1: "#F39200"
    series_labels:
      false - of_case.count: Total Cases
      true - of_case.count: Escalated Cases
      No - of_case.count: Total Cases
      Yes - of_case.count: Escalated Cases
      Yes - of_case.case_distinct_count: Transferred Cases
      No - of_case.case_distinct_count: Total Cases
      Yes - of_case.case_distinct_count1: Transferred Cases
      No - of_case.case_distinct_count1: Total Cases
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Case Transfer Ratio<BR><B>How
      it Helps : </B>To evaluate no. of Transferred cases<BR>[ALL Case Status]<BR><B>Target
      : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 14
    col: 0
    width: 12
    height: 6
  - title: No of Reopened Cases by Location*
    name: No of Reopened Cases by Location*
    model: oneforce_service
    explore: of_case
    type: looker_bar
    fields: [of_case.is_reopened, of_case.Case_Geo, of_case.case_distinct_count]
    pivots: [of_case.is_reopened]
    filters: {}
    sorts: [of_case.is_reopened desc, of_case.Case_Geo]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: of_case.case_distinct_count,
            id: false - of_case.case_distinct_count, name: 'false'}, {axisId: of_case.case_distinct_count,
            id: true - of_case.case_distinct_count, name: 'true'}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_types: {}
    series_colors:
      true - of_case.case_distinct_count: "#F39200"
      false - of_case.case_distinct_count: "#BD0F72"
    series_labels:
      false - of_case.case_distinct_count: Total
      true - of_case.case_distinct_count: Reopened
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>No of Reopened Cases<BR><B>How
      it Helps : </B>To evaluate how many reopened cases<BR>[Reopened refers to a
      case is put back to "In Progress" to "Resolved"]<BR><B>Target : </B>TBD

      '
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 27
    col: 0
    width: 12
    height: 6
  - title: No of Times a Case is Reopened*
    name: No of Times a Case is Reopened*
    model: oneforce_service
    explore: of_case
    type: looker_bar
    fields: [of_case.no_of_times_case_reopen, of_case.count, of_case.Case_Geo]
    pivots: [of_case.no_of_times_case_reopen]
    filters:
      of_case.no_of_times_case_reopen: NOT NULL
    sorts: [of_case.Case_Geo, of_case.count desc 0, of_case.no_of_times_case_reopen]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: of_case.count, id: of_case.count,
            name: Case}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    series_types: {}
    show_null_points: true
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>No of Times a Case
      is Reopened<BR><B>How it Helps : </B>To evaluate how many times a case has been
      reopened<BR>[Reopened refers to a case is put back to "In Progress" to "Resolved"]<BR><B>Target
      : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Open Date: of_case.createddate_filter_date
      Reopened Case: of_case.Case_reopened
      Dynamic Filter - View By: of_case.Geo_Param
      Priority: of_case.priority
      Contact Email: of_case.contactemail
      eComm ID: of_case.ecomm_id
      Contract Number: of_case.contract_number
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Category (L1): of_case.reason
      Subtopic (L4): of_case.subordinate_category_l4
      Service Type: of_case.type
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Original Record Type: of_case.original_record_type
      Has Leave Message: of_case.has_leave_message_filter
      Resolution Reason: of_case.resolution_reason
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 27
    col: 12
    width: 12
    height: 6
  - title: No of Transfer per Case*
    name: No of Transfer per Case*
    model: oneforce_service
    explore: of_case
    type: looker_bar
    fields: [of_case.Case_Geo, of_case.group_total_transfer, of_case.count_transfer]
    pivots: [of_case.group_total_transfer]
    filters:
      of_case.total_transfer: NOT NULL
    sorts: [of_case.group_total_transfer, of_case.count_transfer desc 0]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: 0.0 - of_case.count,
            id: 0.0 - of_case.count, name: '0'}, {axisId: 1.0 - of_case.count, id: 1.0
              - of_case.count, name: '1'}, {axisId: 2.0 - of_case.count, id: 2.0 -
              of_case.count, name: '2'}, {axisId: 3.0 - of_case.count, id: 3.0 - of_case.count,
            name: '3'}, {axisId: 4.0 - of_case.count, id: 4.0 - of_case.count, name: '4'},
          {axisId: 5.0 - of_case.count, id: 5.0 - of_case.count, name: '5'}, {axisId: 6.0
              - of_case.count, id: 6.0 - of_case.count, name: '6'}, {axisId: 7.0 -
              of_case.count, id: 7.0 - of_case.count, name: '7'}, {axisId: 8.0 - of_case.count,
            id: 8.0 - of_case.count, name: '8'}, {axisId: 9.0 - of_case.count, id: 9.0
              - of_case.count, name: '9'}, {axisId: 10.0 - of_case.count, id: 10.0
              - of_case.count, name: '10'}, {axisId: 11.0 - of_case.count, id: 11.0
              - of_case.count, name: '11'}, {axisId: 12.0 - of_case.count, id: 12.0
              - of_case.count, name: '12'}, {axisId: 13.0 - of_case.count, id: 13.0
              - of_case.count, name: '13'}, {axisId: 16.0 - of_case.count, id: 16.0
              - of_case.count, name: '16'}, {axisId: 23.0 - of_case.count, id: 23.0
              - of_case.count, name: '23'}, {axisId: 26.0 - of_case.count, id: 26.0
              - of_case.count, name: '26'}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types: {}
    series_labels:
      'Total Transfers: 01 - of_case.count_transfer': 'Total Transfers: 1'
      'Total Transfers: 02 - of_case.count_transfer': 'Total Transfers: 2'
      'Total Transfers: 03 - of_case.count_transfer': 'Total Transfers: 3'
      'Total Transfers: 04 - of_case.count_transfer': 'Total Transfers: 4'
      'Total Transfers: 05 - of_case.count_transfer': 'Total Transfers: 5'
      'Total Transfers: 06-50 - of_case.count_transfer': 'Total Transfers: 6-50'
    defaults_version: 1
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>No. of Times a Case
      is Transfer<BR><B>How it Helps : </B>To evaluate how many times a case has been
      transferred<BR>[ALL Case Status]<BR><B>Target : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      Priority: of_case.priority
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Resolution Reason: of_case.resolution_reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      Contract Number: of_case.contract_number
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Dynamic Filter - View By: of_case.Geo_Param
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Service Type: of_case.type
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Has Leave Message: of_case.has_leave_message_filter
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
    row: 14
    col: 12
    width: 12
    height: 6
  - title: No of Transferred Cases**
    name: No of Transferred Cases**
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.Transferred_chat_case_Dynamic, of_case.Transferred_Case_count_distinct]
    filters: {}
    sorts: [of_case.Transferred_Case_count_distinct desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.Transferred_Case_count_distinct,
            id: of_case.Transferred_Case_count_distinct, name: Transferred Case Distinct
              Count}], showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types: {}
    series_labels:
      'Total Transfers: 01 - of_case.count_transfer': 'Total Transfers: 1'
      'Total Transfers: 02 - of_case.count_transfer': 'Total Transfers: 2'
      'Total Transfers: 03 - of_case.count_transfer': 'Total Transfers: 3'
      'Total Transfers: 04 - of_case.count_transfer': 'Total Transfers: 4'
      'Total Transfers: 05 - of_case.count_transfer': 'Total Transfers: 5'
      'Total Transfers: 06-50 - of_case.count_transfer': 'Total Transfers: 6-50'
    defaults_version: 1
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>No. of Times a Case
      is Transfer<BR><B>How it Helps : </B>To evaluate how many times a case has been
      transferred<BR>[ALL Case Status]<BR><B>Target : </B>TBD'
    listen:
      Channel: of_case.origin
      Status: of_case.status
      Priority: of_case.priority
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Resolution Reason: of_case.resolution_reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      Contract Number: of_case.contract_number
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Dynamic Filter - View By: of_case.Geo_Param
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Service Type: of_case.type
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Has Leave Message: of_case.has_leave_message_filter
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Role: of_escalation_history.role
      Profile: case_owner.profile_name_service
      Category (L2): of_case.sub_category_l2
      Awaiting Internal Team Response: of_case_history_air.status_case_Analysis
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Transferred Cases By: of_case.Transferred_chat_case_Param
    row: 20
    col: 0
    width: 24
    height: 7
  filters:
  - name: Channel
    title: Channel
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.origin
  - name: Status
    title: Status
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.status
  - name: RHQ (Case)
    title: RHQ (Case)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: [Cluster Country, Office (Case), Individual Country]
    field: of_case.Regional_Head_Office
  - name: Cluster Country
    title: Cluster Country
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: [RHQ (Case), Office (Case), Individual Country]
    field: of_case.case_country
  - name: Individual Country
    title: Individual Country
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: [RHQ (Case), Cluster Country, Office (Case)]
    field: of_case.country
  - name: Office (Case)
    title: Office (Case)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: [RHQ (Case), Cluster Country, Individual Country]
    field: of_case.case_office_code
  - name: Office Type
    title: Office Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: case_owner.officetype
  - name: Initial Queue Name
    title: Initial Queue Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.Initial_Queue_Name
  - name: Case Number
    title: Case Number
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.casenumber
  - name: Case Owner
    title: Case Owner
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: case_owner.name
  - name: Role
    title: Role
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_escalation_history.role
  - name: Profile
    title: Profile
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: case_owner.profile_name_service
  - name: Category (L2)
    title: Category (L2)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: [Category (L1), Topic (L3)]
    field: of_case.sub_category_l2
  - name: Topic (L3)
    title: Topic (L3)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: [Category (L1), Category (L2)]
    field: of_case.subordinate_category_l3
  - name: Awaiting Internal Team Response
    title: Awaiting Internal Team Response
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options:
      - 'Yes'
      - 'No'
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case_history_air.status_case_Analysis
  - name: First Contact Resolution
    title: First Contact Resolution
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options:
      - 'Yes'
      - 'No'
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.first_contact_resolution
  - name: Resolution Reason
    title: Resolution Reason
    type: field_filter
    default_value: Customer Query Resolved,Customer Query Un-resolved,None
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.resolution_reason
  - name: Web Email
    title: Web Email
    type: field_filter
    default_value: "-%@one-line.com%"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.supplied_email
  - name: Open Date
    title: Open Date
    type: field_filter
    default_value: 6 month
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.createddate_filter_date
  - name: Date Granularity
    title: Date Granularity
    type: field_filter
    default_value: Month
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.timeframe_picker
  - name: CSAT
    title: CSAT
    type: field_filter
    default_value: Case Level
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_toggles
      display: inline
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.csat_Param
  - name: NPS
    title: NPS
    type: field_filter
    default_value: Case Level
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_toggles
      display: inline
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.globalnps_Param
  - name: Reopened Case
    title: Reopened Case
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options:
      - 'Yes'
      - 'No'
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.Case_reopened
  - name: Dynamic Filter - View By
    title: Dynamic Filter - View By
    type: field_filter
    default_value: RHQ
    allow_multiple_values: true
    required: false
    ui_config:
      type: radio_buttons
      display: inline
      options:
      - Global
      - Channel
      - RHQ
      - Agent Role
      - Escalation Role
      - 'Segment '
      - Office Type
      - Service Type
      - Office
      - Cluster Country
      - Individual Country
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.Geo_Param
  - name: Transferred Cases By
    title: Transferred Cases By
    type: field_filter
    default_value: User Office
    allow_multiple_values: true
    required: false
    ui_config:
      type: radio_buttons
      display: inline
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.Transferred_chat_case_Param
  - name: RHQ (Case Owner)
    title: RHQ (Case Owner)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: [Office (Case Owner), Country (Case Owner)]
    field: user_office_hierarchy.regional_head_office_short_nm
  - name: Country (Case Owner)
    title: Country (Case Owner)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: [Office (Case Owner), RHQ (Case Owner)]
    field: user_office_hierarchy.country
  - name: Office (Case Owner)
    title: Office (Case Owner)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: [Country (Case Owner), RHQ (Case Owner)]
    field: user_office_hierarchy.office_code
  - name: Source of Chat
    title: Source of Chat
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_chat_transcript.origin
  - name: Queue Owner Name
    title: Queue Owner Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_queue.developer_name
  - name: Customer Segmentation
    title: Customer Segmentation
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_customer_group.key_acct_tp_cd
  - name: Priority
    title: Priority
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: overflow
      options:
      - Urgent
      - High
      - Medium
      - Low
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.priority
  - name: Customer Group
    title: Customer Group
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_customer_group.cust_grp_and_name
  - name: Customer
    title: Customer
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: [Customer Group]
    field: of_customer.customer_cd_and_name
  - name: Contact Name
    title: Contact Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_contact.name
  - name: Contact Email
    title: Contact Email
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.contactemail
  - name: eComm ID
    title: eComm ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.ecomm_id
  - name: Contract Number
    title: Contract Number
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.contract_number
  - name: Case Rating
    title: Case Rating
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.case_rating
  - name: Sales Team Member
    title: Sales Team Member
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_sales_team_member.team_role
  - name: Customer Type
    title: Customer Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: overflow
      options:
      - BCO
      - NVO
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_customer.customer_type
  - name: Service or Contract Customer
    title: Service or Contract Customer
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: overflow
      options:
      - Contract Customer
      - Service Customer
      - Both
      - None
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.Service_Contract_Customer
  - name: Sub Resolution Reason
    title: Sub Resolution Reason
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: [Resolution Reason]
    field: of_case.sub_resolution_reason
  - name: Category (L1)
    title: Category (L1)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.reason
  - name: Subtopic (L4)
    title: Subtopic (L4)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.subordinate_category_l4
  - name: Service Type
    title: Service Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: overflow
      options:
      - Complaint/Feedback
      - Inquiry
      - Service Failure
      - Service Request
      - Internal
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.type
  - name: Closed Date
    title: Closed Date
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: overflow
      options: []
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.closeddate_date
  - name: Case Resolved Date
    title: Case Resolved Date
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: overflow
      options: []
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.Case_Resolved_Date_Time_date
  - name: Original Record Type
    title: Original Record Type
    type: field_filter
    default_value: "-%Duplicate^_Parent^_Case%"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.original_record_type
  - name: Has Leave Message
    title: Has Leave Message
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: overflow
      options:
      - 'Yes'
      - 'No'
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.has_leave_message_filter
