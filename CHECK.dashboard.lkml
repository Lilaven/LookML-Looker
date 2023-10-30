- dashboard: service_kpi_landing_page_lilacopy
  title: Service KPI Landing Page (lilacopy)
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''
  query_timezone: UTC
  filters_bar_collapsed: true
  preferred_slug: 84w0MSBqbSDdJQyZb0OgJN
  elements:
  - title: Open Urgent & High
    name: Open Urgent & High
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.case_distinct_count_drill]
    filters:
      of_case.active_case: 'Yes'
      priority_for_filter: High,Urgent
    limit: 500
    dynamic_fields: [{category: dimension, expression: "${of_case.priority}", label: priority
          for filter, value_format: !!null '', value_format_name: !!null '', dimension: priority_for_filter,
        _kind_hint: dimension, _type_hint: string}]
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '16'
    orientation: auto
    style_of_case.case_distinct_count_drill: "#7f0b4d"
    show_title_of_case.case_distinct_count_drill: false
    title_placement_of_case.case_distinct_count_drill: above
    value_format_of_case.case_distinct_count_drill: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
    custom_color: "#BD0F72"
    single_value_title: Open Urgent & High Priority
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: 6c27c30e-5523-4080-82ae-272146e699d0,
          palette_id: 25b877bc-c7a8-4ed0-a0ef-5ba64ca3658d}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 0
    listen:
      Date Granularity: of_case.timeframe_picker
      Web Email: of_case.supplied_email
      Open Date: of_case.createddate_filter_date
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 11
    col: 21
    width: 3
    height: 3
  - title: Open
    name: Open
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.case_distinct_count_drill]
    filters:
      of_case.active_case: 'Yes'
    limit: 500
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '16'
    orientation: auto
    style_of_case.case_distinct_count_drill: "#7f0b4d"
    show_title_of_case.case_distinct_count_drill: false
    title_placement_of_case.case_distinct_count_drill: above
    value_format_of_case.case_distinct_count_drill: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
    custom_color: "#BD0F72"
    single_value_title: Open
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 0
    listen:
      Date Granularity: of_case.timeframe_picker
      Web Email: of_case.supplied_email
      Open Date: of_case.createddate_filter_date
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 8
    col: 21
    width: 3
    height: 3
  - title: Open Escl
    name: Open Escl
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.case_distinct_count_drill]
    filters:
      of_case.active_case: 'Yes'
      of_case.total_escalation: ">0"
    limit: 500
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '16'
    orientation: auto
    style_of_case.case_distinct_count_drill: "#7f0b4d"
    show_title_of_case.case_distinct_count_drill: false
    title_placement_of_case.case_distinct_count_drill: above
    value_format_of_case.case_distinct_count_drill: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
    custom_color: "#BD0F72"
    single_value_title: Open Escl
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 0
    series_types: {}
    listen:
      Date Granularity: of_case.timeframe_picker
      Web Email: of_case.supplied_email
      Open Date: of_case.createddate_filter_date
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 17
    col: 21
    width: 3
    height: 3
  - title: Closed
    name: Closed
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.case_distinct_count_drill]
    filters:
      of_case.active_case: 'No'
    limit: 500
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '16'
    orientation: auto
    style_of_case.case_distinct_count_drill: "#7f0b4d"
    show_title_of_case.case_distinct_count_drill: false
    title_placement_of_case.case_distinct_count_drill: above
    value_format_of_case.case_distinct_count_drill: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
    custom_color: "#BD0F72"
    single_value_title: Closed
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: legacy, palette_id: legacy_sequential3},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 0
    listen:
      Date Granularity: of_case.timeframe_picker
      Web Email: of_case.supplied_email
      Open Date: of_case.createddate_filter_date
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 5
    col: 21
    width: 3
    height: 3
  - title: Volume
    name: Volume
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.case_distinct_count, of_case.createddate_dynamic, of_case.Case_Geo]
    pivots: [of_case.Case_Geo]
    sorts: [of_case.createddate_dynamic, of_case.Case_Geo]
    limit: 500
    row_total: right
    dynamic_fields: [{category: dimension, expression: "case(\n  when(${of_case.dynamic_dim_landing}=\"\
          GKA\",\"1\"),\n  when(${of_case.dynamic_dim_landing}=\"RKA\",\"2\"),\n \
          \ when(${of_case.dynamic_dim_landing}=\"LKA\",\"3\"),\n  when(${of_case.dynamic_dim_landing}=\"\
          ONECare\",\"4\"),\n  ${of_case.dynamic_dim_landing})", label: New Dimension,
        value_format: !!null '', value_format_name: !!null '', dimension: new_dimension,
        _kind_hint: measure, _type_hint: string}]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: Chat - of_case.case_distinct_count,
            id: Chat - of_case.case_distinct_count, name: Chat}, {axisId: Email -
              of_case.case_distinct_count, id: Email - of_case.case_distinct_count,
            name: Email}, {axisId: Internal - of_case.case_distinct_count, id: Internal
              - of_case.case_distinct_count, name: Internal}, {axisId: Phone - of_case.case_distinct_count,
            id: Phone - of_case.case_distinct_count, name: Phone}, {axisId: Web -
              of_case.case_distinct_count, id: Web - of_case.case_distinct_count,
            name: Web}], showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    series_types:
      Row Total - of_case.case_distinct_count: line
    series_colors:
      HKGHQ - of_case.case_distinct_count: "#db72af"
      LONHQ - of_case.case_distinct_count: "#00506D"
      RICHQ - of_case.case_distinct_count: "#84C5C3"
      SAOHQ - of_case.case_distinct_count: "#BD0F72"
      SINHQ - of_case.case_distinct_count: "#8b908f"
      Row Total - of_case.case_distinct_count: "#F39200"
    series_labels:
      Row Total - of_case.case_distinct_count: Total
      1 - of_case.case_distinct_count: GKA
      2 - of_case.case_distinct_count: RKA
      3 - of_case.case_distinct_count: LKA
      4 - of_case.case_distinct_count: ONECare
      HKGHQ - of_case.case_distinct_count: HKGHQ
      LONHQ - of_case.case_distinct_count: LONHQ
      RICHQ - of_case.case_distinct_count: RICHQ
      SAOHQ - of_case.case_distinct_count: SAOHQ
      SINHQ - of_case.case_distinct_count: SINHQ
      Global - of_case.case_distinct_count: Global
      Unclaimed - of_case.case_distinct_count: Unclaimed
      Chat - of_case.case_distinct_count: Chat
      Email - of_case.case_distinct_count: Email
      Manual - of_case.case_distinct_count: Manual
      Web - of_case.case_distinct_count: Web
      Phone - of_case.case_distinct_count: Phone
      CCA - of_case.case_distinct_count: CCA
      CCS - of_case.case_distinct_count: CCS
      Others - of_case.case_distinct_count: Others
      Sales Executive - of_case.case_distinct_count: Sales Executive
      C-KAM - of_case.case_distinct_count: C-KAM
      C-KAS - of_case.case_distinct_count: C-KAS
      No KA Mapping - of_case.case_distinct_count: No KA Mapping
      ONECare Queue - of_case.case_distinct_count: ONECare Queue
      S-KAM - of_case.case_distinct_count: S-KAM
      S-KAS - of_case.case_distinct_count: S-KAS
      Onshore - of_case.case_distinct_count: Onshore
      Offshore - of_case.case_distinct_count: Offshore
      Complaint/Feedback - of_case.case_distinct_count: Complaint/Feedback
      Complex - of_case.case_distinct_count: Complex
      General Information - of_case.case_distinct_count: General Information
      Inquiry - of_case.case_distinct_count: Inquiry
      Internal - of_case.case_distinct_count: Internal
      Service Request - of_case.case_distinct_count: Service Request
      Service Failure - of_case.case_distinct_count: Service Failure
      Transactional - of_case.case_distinct_count: Transactional
      No Action Required - of_case.case_distinct_count: No Action Required
      Internal Request - of_case.case_distinct_count: Internal Request
      GKA - of_case.case_distinct_count: GKA
      LKA - of_case.case_distinct_count: LKA
      ONECare - of_case.case_distinct_count: ONECare
      RKA - of_case.case_distinct_count: RKA
      AE - of_case.case_distinct_count: AE
      AR - of_case.case_distinct_count: AR
      AT & HU - of_case.case_distinct_count: AT & HU
      AU - of_case.case_distinct_count: AU
      BD - of_case.case_distinct_count: BD
      BR - of_case.case_distinct_count: BR
      BE - of_case.case_distinct_count: BE
      CH - of_case.case_distinct_count: CH
      CL - of_case.case_distinct_count: CL
      CN - of_case.case_distinct_count: CN
      CO - of_case.case_distinct_count: CO
      DE - of_case.case_distinct_count: DE
      CZ & SK - of_case.case_distinct_count: CZ & SK
      EC - of_case.case_distinct_count: EC
      DK - of_case.case_distinct_count: DK
      EG - of_case.case_distinct_count: EG
      ES - of_case.case_distinct_count: ES
      LK - of_case.case_distinct_count: LK
      IT - of_case.case_distinct_count: IT
      FI - of_case.case_distinct_count: FI
      FR - of_case.case_distinct_count: FR
      GB - of_case.case_distinct_count: GB
      GH - of_case.case_distinct_count: GH
      HK & SCN - of_case.case_distinct_count: HK & SCN
      ID - of_case.case_distinct_count: ID
      IL - of_case.case_distinct_count: IL
      IN - of_case.case_distinct_count: IN
      JP - of_case.case_distinct_count: JP
      KR - of_case.case_distinct_count: KR
      MA - of_case.case_distinct_count: MA
      MM - of_case.case_distinct_count: MM
      MX - of_case.case_distinct_count: MX
      MY - of_case.case_distinct_count: MY
      TR - of_case.case_distinct_count: TR
      TW - of_case.case_distinct_count: TW
      TH - of_case.case_distinct_count: TH
      SE & NO - of_case.case_distinct_count: SE & NO
      NG - of_case.case_distinct_count: NG
      NL - of_case.case_distinct_count: NL
      NZ - of_case.case_distinct_count: NZ
      PA - of_case.case_distinct_count: PA
      PE - of_case.case_distinct_count: PE
      PH - of_case.case_distinct_count: PH
      PK - of_case.case_distinct_count: PK
      PL - of_case.case_distinct_count: PL
      PT - of_case.case_distinct_count: PT
      SG - of_case.case_distinct_count: SG
      US - of_case.case_distinct_count: US
      UY - of_case.case_distinct_count: UY
      ZA - of_case.case_distinct_count: ZA
      CA - of_case.case_distinct_count: CA
      CI - of_case.case_distinct_count: CI
      AT - of_case.case_distinct_count: AT
      CZ - of_case.case_distinct_count: CZ
      IE - of_case.case_distinct_count: IE
      SK - of_case.case_distinct_count: SK
      VN - of_case.case_distinct_count: VN
      NO - of_case.case_distinct_count: 'NO'
      AS - of_case.case_distinct_count: AS
      BG - of_case.case_distinct_count: BG
      CR - of_case.case_distinct_count: CR
      CY - of_case.case_distinct_count: CY
      DZ - of_case.case_distinct_count: DZ
      EE - of_case.case_distinct_count: EE
      FJ - of_case.case_distinct_count: FJ
      GE - of_case.case_distinct_count: GE
      GR - of_case.case_distinct_count: GR
      GT - of_case.case_distinct_count: GT
      HK - of_case.case_distinct_count: HK
      HN - of_case.case_distinct_count: HN
      HR - of_case.case_distinct_count: HR
      HU - of_case.case_distinct_count: HU
      KE - of_case.case_distinct_count: KE
      KH - of_case.case_distinct_count: KH
      KI - of_case.case_distinct_count: KI
      LB - of_case.case_distinct_count: LB
      LT - of_case.case_distinct_count: LT
      LS - of_case.case_distinct_count: LS
      LV - of_case.case_distinct_count: LV
      MO - of_case.case_distinct_count: MO
      MT - of_case.case_distinct_count: MT
      NI - of_case.case_distinct_count: NI
      PF - of_case.case_distinct_count: PF
      RO - of_case.case_distinct_count: RO
      SA - of_case.case_distinct_count: SA
      SB - of_case.case_distinct_count: SB
      SI - of_case.case_distinct_count: SI
      SN - of_case.case_distinct_count: SN
      SV - of_case.case_distinct_count: SV
      TG - of_case.case_distinct_count: TG
      TJ - of_case.case_distinct_count: TJ
      TN - of_case.case_distinct_count: TN
      TO - of_case.case_distinct_count: TO
      TT - of_case.case_distinct_count: TT
      UA - of_case.case_distinct_count: UA
      VU - of_case.case_distinct_count: VU
      WS - of_case.case_distinct_count: WS
      ZW - of_case.case_distinct_count: ZW
      ZZ - of_case.case_distinct_count: ZZ
      AARBB - of_case.case_distinct_count: AARBB
      ABJBB - of_case.case_distinct_count: ABJBB
      ADLBB - of_case.case_distinct_count: ADLBB
      AKLBB - of_case.case_distinct_count: AKLBB
      ALGBB - of_case.case_distinct_count: ALGBB
      ALJBA - of_case.case_distinct_count: ALJBA
      ALYBB - of_case.case_distinct_count: ALYBB
      AMDBB - of_case.case_distinct_count: AMDBB
      ANRBB - of_case.case_distinct_count: ANRBB
      APWBA - of_case.case_distinct_count: APWBA
      ASHBA - of_case.case_distinct_count: ASHBA
      ATLBB - of_case.case_distinct_count: ATLBB
      BASBB - of_case.case_distinct_count: BASBB
      BCNBB - of_case.case_distinct_count: BCNBB
      BDOBB - of_case.case_distinct_count: BDOBB
      BELBB - of_case.case_distinct_count: BELBB
      BEYBA - of_case.case_distinct_count: BEYBA
      BIOBB - of_case.case_distinct_count: BIOBB
      BKKBB - of_case.case_distinct_count: BKKBB
      BLRBB - of_case.case_distinct_count: BLRBB
      BNDBB - of_case.case_distinct_count: BNDBB
      BNEBB - of_case.case_distinct_count: BNEBB
      BOGBB - of_case.case_distinct_count: BOGBB
      BOIBB - of_case.case_distinct_count: BOIBB
      BOSBB - of_case.case_distinct_count: BOSBB
      BREBB - of_case.case_distinct_count: BREBB
      BTMBB - of_case.case_distinct_count: BTMBB
      BUDBB - of_case.case_distinct_count: BUDBB
      BUEBB - of_case.case_distinct_count: BUEBB
      CAIBB - of_case.case_distinct_count: CAIBB
      CANBB - of_case.case_distinct_count: CANBB
      CASBA - of_case.case_distinct_count: CASBA
      CCPBB - of_case.case_distinct_count: CCPBB
      CCUBB - of_case.case_distinct_count: CCUBB
      CEBBB - of_case.case_distinct_count: CEBBB
      CGOBB - of_case.case_distinct_count: CGOBB
      CGPBB - of_case.case_distinct_count: CGPBB
      CGYBB - of_case.case_distinct_count: CGYBB
      CHCBB - of_case.case_distinct_count: CHCBB
      CHIBB - of_case.case_distinct_count: CHIBB
      CKGBB - of_case.case_distinct_count: CKGBB
      CLLBB - of_case.case_distinct_count: CLLBB
      CMBBB - of_case.case_distinct_count: CMBBB
      CNDBA - of_case.case_distinct_count: CNDBA
      COKBB - of_case.case_distinct_count: COKBB
      CPTBB - of_case.case_distinct_count: CPTBB
      CTUBB - of_case.case_distinct_count: CTUBB
      CWBBB - of_case.case_distinct_count: CWBBB
      DACBB - of_case.case_distinct_count: DACBB
      DADBB - of_case.case_distinct_count: DADBB
      DAMBB - of_case.case_distinct_count: DAMBB
      DARBA - of_case.case_distinct_count: DARBA
      DELBB - of_case.case_distinct_count: DELBB
      DKRBA - of_case.case_distinct_count: DKRBA
      DLCBB - of_case.case_distinct_count: DLCBB
      DMNBA - of_case.case_distinct_count: DMNBA
      DPSBB - of_case.case_distinct_count: DPSBB
      DUBBA - of_case.case_distinct_count: DUBBA
      DURBB - of_case.case_distinct_count: DURBB
      DUSBB - of_case.case_distinct_count: DUSBB
      DVOBB - of_case.case_distinct_count: DVOBB
      DXBBB - of_case.case_distinct_count: DXBBB
      EDKBB - of_case.case_distinct_count: EDKBB
      ELSBB - of_case.case_distinct_count: ELSBB
      FOCBB - of_case.case_distinct_count: FOCBB
      FREBB - of_case.case_distinct_count: FREBB
      GDLBB - of_case.case_distinct_count: GDLBB
      GDNBB - of_case.case_distinct_count: GDNBB
      GDYBB - of_case.case_distinct_count: GDYBB
      GESBB - of_case.case_distinct_count: GESBB
      GINBB - of_case.case_distinct_count: GINBB
      GOABB - of_case.case_distinct_count: GOABB
      GOTBB - of_case.case_distinct_count: GOTBB
      GUABA - of_case.case_distinct_count: GUABA
      GYEBB - of_case.case_distinct_count: GYEBB
      HALBB - of_case.case_distinct_count: HALBB
      HAMBB - of_case.case_distinct_count: HAMBB
      HANBB - of_case.case_distinct_count: HANBB
      HELBB - of_case.case_distinct_count: HELBB
      HFABA - of_case.case_distinct_count: HFABA
      HFEBB - of_case.case_distinct_count: HFEBB
      HGHBB - of_case.case_distinct_count: HGHBB
      HIRBA - of_case.case_distinct_count: HIRBA
      HKGBB - of_case.case_distinct_count: HKGBB
      HKTBA - of_case.case_distinct_count: HKTBA
      HOUBB - of_case.case_distinct_count: HOUBB
      HPHBB - of_case.case_distinct_count: HPHBB
      HREBA - of_case.case_distinct_count: HREBA
      HYDBB - of_case.case_distinct_count: HYDBB
      ICDBB - of_case.case_distinct_count: ICDBB
      IPSBB - of_case.case_distinct_count: IPSBB
      IQQBB - of_case.case_distinct_count: IQQBB
      ISTBA - of_case.case_distinct_count: ISTBA
      ISTBB - of_case.case_distinct_count: ISTBB
      ITJBB - of_case.case_distinct_count: ITJBB
      IZMBA - of_case.case_distinct_count: IZMBA
      IZMBB - of_case.case_distinct_count: IZMBB
      JEDBA - of_case.case_distinct_count: JEDBA
      JHBBB - of_case.case_distinct_count: JHBBB
      JKTBB - of_case.case_distinct_count: JKTBB
      JMNBB - of_case.case_distinct_count: JMNBB
      JNBBB - of_case.case_distinct_count: JNBBB
      KHHBB - of_case.case_distinct_count: KHHBB
      KHIBB - of_case.case_distinct_count: KHIBB
      KHLBB - of_case.case_distinct_count: KHLBB
      KLPBA - of_case.case_distinct_count: KLPBA
      KOPBA - of_case.case_distinct_count: KOPBA
      LAXBB - of_case.case_distinct_count: LAXBB
      LCBBB - of_case.case_distinct_count: LCBBB
      LEHBB - of_case.case_distinct_count: LEHBB
      LEXBB - of_case.case_distinct_count: LEXBB
      LFWBA - of_case.case_distinct_count: LFWBA
      LHEBB - of_case.case_distinct_count: LHEBB
      LIMBB - of_case.case_distinct_count: LIMBB
      LISBB - of_case.case_distinct_count: LISBB
      LIVBB - of_case.case_distinct_count: LIVBB
      LMSBA - of_case.case_distinct_count: LMSBA
      LONBB - of_case.case_distinct_count: LONBB
      LOSBB - of_case.case_distinct_count: LOSBB
      LUHBB - of_case.case_distinct_count: LUHBB
      LYGBB - of_case.case_distinct_count: LYGBB
      MAABB - of_case.case_distinct_count: MAABB
      MACBB - of_case.case_distinct_count: MACBB
      MADBB - of_case.case_distinct_count: MADBB
      MAOBB - of_case.case_distinct_count: MAOBB
      MBABA - of_case.case_distinct_count: MBABA
      MECBA - of_case.case_distinct_count: MECBA
      MELBB - of_case.case_distinct_count: MELBB
      MERBA - of_case.case_distinct_count: MERBA
      MERBB - of_case.case_distinct_count: MERBB
      MESBB - of_case.case_distinct_count: MESBB
      MEXBB - of_case.case_distinct_count: MEXBB
      MIBOS - of_case.case_distinct_count: MIBOS
      MIHOS - of_case.case_distinct_count: MIHOS
      MITBB - of_case.case_distinct_count: MITBB
      MNGBA - of_case.case_distinct_count: MNGBA
      MNLBB - of_case.case_distinct_count: MNLBB
      MOWBB - of_case.case_distinct_count: MOWBB
      MRSBB - of_case.case_distinct_count: MRSBB
      MSUBA - of_case.case_distinct_count: MSUBA
      MTABA - of_case.case_distinct_count: MTABA
      MTYBB - of_case.case_distinct_count: MTYBB
      MUMBB - of_case.case_distinct_count: MUMBB
      MVDBB - of_case.case_distinct_count: MVDBB
      NBOBB - of_case.case_distinct_count: NBOBB
      NGOBB - of_case.case_distinct_count: NGOBB
      NKGBB - of_case.case_distinct_count: NKGBB
      NSABB - of_case.case_distinct_count: NSABB
      NVSBA - of_case.case_distinct_count: NVSBA
      NYCBB - of_case.case_distinct_count: NYCBB
      ODSBA - of_case.case_distinct_count: ODSBA
      OPOBB - of_case.case_distinct_count: OPOBB
      OSABB - of_case.case_distinct_count: OSABB
      PAIBB - of_case.case_distinct_count: PAIBB
      PANBA - of_case.case_distinct_count: PANBA
      PANBB - of_case.case_distinct_count: PANBB
      PAVBB - of_case.case_distinct_count: PAVBB
      PENBB - of_case.case_distinct_count: PENBB
      PIRAEU - of_case.case_distinct_count: PIRAE
      PKGBB - of_case.case_distinct_count: PKGBB
      PLMBB - of_case.case_distinct_count: PLMBB
      PLZBB - of_case.case_distinct_count: PLZBB
      PNHBA - of_case.case_distinct_count: PNHBA
      PNQBB - of_case.case_distinct_count: PNQBB
      PPGBA - of_case.case_distinct_count: PPGBA
      PPTBA - of_case.case_distinct_count: PPTBA
      PRGBB - of_case.case_distinct_count: PRGBB
      PSDBB - of_case.case_distinct_count: PSDBB
      PTIBA - of_case.case_distinct_count: PTIBA
      PTSBA - of_case.case_distinct_count: PTSBA
      PUSBB - of_case.case_distinct_count: PUSBB
      QITBA - of_case.case_distinct_count: QITBA
      RHUBA - of_case.case_distinct_count: RHUBA
      RICBB - of_case.case_distinct_count: RICBB
      RIXBA - of_case.case_distinct_count: RIXBA
      RJKBA - of_case.case_distinct_count: RJKBA
      RTMBB - of_case.case_distinct_count: RTMBB
      SALBA - of_case.case_distinct_count: SALBA
      SAOBB - of_case.case_distinct_count: SAOBB
      SCLBB - of_case.case_distinct_count: SCLBB
      SEABB - of_case.case_distinct_count: SEABB
      SELBB - of_case.case_distinct_count: SELBB
      SFOBB - of_case.case_distinct_count: SFOBB
      SFSBB - of_case.case_distinct_count: SFSBB
      SGNBB - of_case.case_distinct_count: SGNBB
      SGZBB - of_case.case_distinct_count: SGZBB
      SHABB - of_case.case_distinct_count: SHABB
      SIABB - of_case.case_distinct_count: SIABB
      SINBB - of_case.case_distinct_count: SINBB
      SINHO - of_case.case_distinct_count: SINHO
      SJOBA - of_case.case_distinct_count: SJOBA
      SJWBB - of_case.case_distinct_count: SJWBB
      SKGBA - of_case.case_distinct_count: SKGBA
      SMZBA - of_case.case_distinct_count: SMZBA
      SOUBB - of_case.case_distinct_count: SOUBB
      SPBBB - of_case.case_distinct_count: SPBBB
      SPROS - of_case.case_distinct_count: SPROS
      SRGBB - of_case.case_distinct_count: SRGBB
      SSZBB - of_case.case_distinct_count: SSZBB
      STRBB - of_case.case_distinct_count: STRBB
      SUBBB - of_case.case_distinct_count: SUBBB
      SUDBB - of_case.case_distinct_count: SUDBB
      SUVBA - of_case.case_distinct_count: SUVBA
      SUZBB - of_case.case_distinct_count: SUZBB
      SYDBB - of_case.case_distinct_count: SYDBB
      SZHBB - of_case.case_distinct_count: SZHBB
      SZPBB - of_case.case_distinct_count: SZPBB
      TAOBB - of_case.case_distinct_count: TAOBB
      TBUBA - of_case.case_distinct_count: TBUBA
      TEMBB - of_case.case_distinct_count: TEMBB
      TGCBA - of_case.case_distinct_count: TGCBA
      TLLBA - of_case.case_distinct_count: TLLBA
      TLVBA - of_case.case_distinct_count: TLVBA
      TORBB - of_case.case_distinct_count: TORBB
      TPEBB - of_case.case_distinct_count: TPEBB
      TPPBB - of_case.case_distinct_count: TPPBB
      TRWBA - of_case.case_distinct_count: TRWBA
      TSNBB - of_case.case_distinct_count: TSNBB
      TUNBA - of_case.case_distinct_count: TUNBA
      TUTBB - of_case.case_distinct_count: TUTBB
      TXGBB - of_case.case_distinct_count: TXGBB
      TYOBB - of_case.case_distinct_count: TYOBB
      VANBB - of_case.case_distinct_count: VANBB
      VAPBB - of_case.case_distinct_count: VAPBB
      VARBA - of_case.case_distinct_count: VARBA
      VGOBB - of_case.case_distinct_count: VGOBB
      VLCBB - of_case.case_distinct_count: VLCBB
      VLIBA - of_case.case_distinct_count: VLIBA
      VNABB - of_case.case_distinct_count: VNABB
      VTZBB - of_case.case_distinct_count: VTZBB
      VVABB - of_case.case_distinct_count: VVABB
      WGZOS - of_case.case_distinct_count: WGZOS
      WMLOS - of_case.case_distinct_count: WMLOS
      WNKOS - of_case.case_distinct_count: WNKOS
      WUHBB - of_case.case_distinct_count: WUHBB
      XMNBB - of_case.case_distinct_count: XMNBB
      YGNBB - of_case.case_distinct_count: YGNBB
      ZHOBB - of_case.case_distinct_count: ZHOBB
      ZHUBB - of_case.case_distinct_count: ZHUBB
      ZLOBB - of_case.case_distinct_count: ZLOBB
      of_case.Case_Geo___null - of_case.case_distinct_count: "∅"
    show_null_points: true
    interpolation: monotone
    value_labels: labels
    label_type: labVal
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: |-
      <P style="text-align:left;"><B>Metric Name : </B>Total Case Volume<BR><B>How it Helps : </B>To analyze the trend and pattern on our Case Volume by Open Date
      <BR>[ALL Case Status]
    listen:
      Date Granularity: of_case.timeframe_picker
      Web Email: of_case.supplied_email
      Open Date: of_case.createddate_filter_date
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 5
    col: 0
    width: 10
    height: 9
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |
      <p style="font-size:medium;font-weight: bold;text-align: center;">
          <a target="_blank"  style="color:#BD0F72;" href="https://oneline.cloud.looker.com/embed/dashboards/1225">Fullscreen?</a><br>
          Version: 2023.10.17 <br>
          <a target="_blank" href="https://drive.google.com/file/d/1R7D06xLdWpojlgweseYSWU2SUOdMaOBl/view">HTG - Service KPI Workflow - Metrics</a></p>
    row: 76
    col: 19
    width: 4
    height: 3
  - title: Queue-Owned
    name: Queue-Owned
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.case_distinct_count_drill]
    filters:
      of_queue.ownedbyQueue: 'Yes'
    limit: 500
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '16'
    orientation: auto
    style_of_case.case_distinct_count_drill: "#7f0b4d"
    show_title_of_case.case_distinct_count_drill: false
    title_placement_of_case.case_distinct_count_drill: above
    value_format_of_case.case_distinct_count_drill: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
    custom_color: "#BD0F72"
    single_value_title: Owned by Queue
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: 6c27c30e-5523-4080-82ae-272146e699d0,
          palette_id: 25b877bc-c7a8-4ed0-a0ef-5ba64ca3658d}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 0
    listen:
      Date Granularity: of_case.timeframe_picker
      Web Email: of_case.supplied_email
      Open Date: of_case.createddate_filter_date
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 14
    col: 21
    width: 3
    height: 3
  - title: Chat + Webform Usage
    name: Chat + Webform Usage
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.deflection_ratio, previous_deflection_ratio]
    limit: 500
    dynamic_fields: [{category: measure, expression: 'trunc_months (${of_case.filter_start}
          ) = trunc_months ( ${of_case.createddate_date})', label: Previous Deflection
          Ratio, value_format: !!null '', value_format_name: !!null '', based_on: of_case.deflection_ratio,
        filter_expression: 'trunc_months (${of_case.filter_start} ) = trunc_months
          ( ${of_case.createddate_date})', _kind_hint: measure, measure: previous_deflection_ratio,
        type: average, _type_hint: number, filters: {}}]
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '16'
    orientation: auto
    style_of_case.deflection_ratio: "#7f0b4d"
    show_title_of_case.deflection_ratio: false
    title_placement_of_case.deflection_ratio: above
    value_format_of_case.deflection_ratio: ''
    show_comparison_previous_deflection_ratio: true
    comparison_style_previous_deflection_ratio: percentage_change
    comparison_show_label_previous_deflection_ratio: true
    pos_is_bad_previous_deflection_ratio: false
    comparison_label_previous_deflection_ratio: vs Prev
    comparison_label_placement_previous_deflection_ratio: below
    comp_value_format_previous_deflection_ratio: ''
    style_current_deflection_ratio: "#7f0b4d"
    show_title_current_deflection_ratio: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
    custom_color: "#BD0F72"
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: 6c27c30e-5523-4080-82ae-272146e699d0,
          palette_id: 25b877bc-c7a8-4ed0-a0ef-5ba64ca3658d}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    showComparison: false
    minValue: 0
    maxValue: 1
    circleThickness: 0.05
    circleFillGap: 0.05
    circleColor: "#555555"
    waveHeight: 0.3
    waveCount: 4
    waveRiseTime: 2350
    waveAnimateTime: 2151
    waveRise: true
    waveHeightScaling: true
    waveAnimate: true
    waveColor: "#7f0b4d"
    waveOffset: 0
    textVertPosition: 0.5
    textSize: 0.89
    valueCountUp: true
    displayPercent: false
    textColor: "#000000"
    waveTextColor: "#FFFFFF"
    defaults_version: 0
    series_types: {}
    listen:
      Date Granularity: of_case.timeframe_picker
      Web Email: of_case.supplied_email
      Open Date: of_case.createddate_filter_date
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 1
    col: 15
    width: 3
    height: 4
  - name: " (2)"
    type: text
    title_text: ''
    body_text: "#####Clear Cache for latest data: \nStep 1: Just click anywhere inside\
      \ the Dashboard and then <BR>Step 2: Press Ctrl+Shift+Enter Key to clear the\
      \ cache and refresh"
    row: 76
    col: 0
    width: 6
    height: 3
  - title: CSAT
    name: CSAT
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.customer_satisfaction_ratio_case_chat, previous_satisfaction_ratio]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: measure, expression: 'trunc_months (${of_case.filter_start}
          ) = trunc_months ( ${of_case.createddate_date})', label: Previous Satisfaction
          Ratio, value_format: !!null '', value_format_name: !!null '', based_on: of_case.Customer_satisfaction_ratio,
        filter_expression: 'trunc_months (${of_case.filter_start} ) = trunc_months
          ( ${of_case.createddate_date})', _kind_hint: measure, measure: previous_satisfaction_ratio,
        type: average, _type_hint: number, filters: {}}, {category: dimension, expression: "${of_case.case_rating}",
        label: Case Rating for Filter, value_format: !!null '', value_format_name: !!null '',
        dimension: case_rating_for_filter, _kind_hint: dimension, _type_hint: string},
      {category: dimension, expression: "${of_case.origin}", label: Channel For Filter,
        value_format: !!null '', value_format_name: !!null '', dimension: channel_for_filter,
        _kind_hint: dimension, _type_hint: string}, {category: dimension, expression: "${of_chat_transcript.chat_case_rating}",
        label: Chat Rating for Filter, value_format: !!null '', value_format_name: !!null '',
        dimension: chat_rating_for_filter, _kind_hint: dimension, _type_hint: string}]
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: '16'
    orientation: auto
    style_of_case.customer_satisfaction_ratio_case_chat: "#7f0b4d"
    show_title_of_case.customer_satisfaction_ratio_case_chat: false
    title_override_of_case.customer_satisfaction_ratio_case_chat: Previous Satisfaction
      Ratio
    title_placement_of_case.customer_satisfaction_ratio_case_chat: above
    value_format_of_case.customer_satisfaction_ratio_case_chat: ''
    show_comparison_previous_satisfaction_ratio: true
    comparison_style_previous_satisfaction_ratio: percentage_change
    comparison_show_label_previous_satisfaction_ratio: true
    pos_is_bad_previous_satisfaction_ratio: false
    comparison_label_previous_satisfaction_ratio: vs Prev
    comparison_label_placement_previous_satisfaction_ratio: below
    style_previous_satisfaction_ratio: "#7f0b4d"
    show_title_previous_satisfaction_ratio: false
    title_placement_previous_satisfaction_ratio: above
    value_format_previous_satisfaction_ratio: ''
    show_comparison_of_case.Customer_satisfaction_ratio: true
    comparison_style_of_case.Customer_satisfaction_ratio: percentage_change
    comparison_show_label_of_case.Customer_satisfaction_ratio: true
    pos_is_bad_of_case.Customer_satisfaction_ratio: false
    comparison_label_of_case.Customer_satisfaction_ratio: vs Prev
    comparison_label_placement_of_case.Customer_satisfaction_ratio: below
    comp_value_format_of_case.Customer_satisfaction_ratio: ''
    style_of_case.Customer_satisfaction_ratio: "#7f0b4d"
    show_title_of_case.Customer_satisfaction_ratio: false
    title_placement_of_case.Customer_satisfaction_ratio: above
    value_format_of_case.Customer_satisfaction_ratio: ''
    show_comparison_of_chat_transcript.Customer_chat_satisfaction_ratio: true
    comparison_style_of_chat_transcript.Customer_chat_satisfaction_ratio: percentage_change
    comparison_show_label_of_chat_transcript.Customer_chat_satisfaction_ratio: true
    comparison_label_of_chat_transcript.Customer_chat_satisfaction_ratio: vs Prev
    comparison_label_placement_of_chat_transcript.Customer_chat_satisfaction_ratio: below
    comp_value_format_previous_satisfaction_ratio: ''
    style_current_satisfaction_ratio: "#7f0b4d"
    show_title_current_satisfaction_ratio: false
    title_placement_current_satisfaction_ratio: above
    value_format_current_satisfaction_ratio: ''
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
    custom_color: "#BD0F72"
    conditional_formatting: [{type: greater than, value: 0.5, background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: 6c27c30e-5523-4080-82ae-272146e699d0,
          palette_id: 25b877bc-c7a8-4ed0-a0ef-5ba64ca3658d}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: less than, value: 0.5, background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: 6c27c30e-5523-4080-82ae-272146e699d0,
          palette_id: 25b877bc-c7a8-4ed0-a0ef-5ba64ca3658d}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    showComparison: false
    minValue: 0
    maxValue: 1
    circleThickness: 0.05
    circleFillGap: 0.05
    circleColor: "#555555"
    waveHeight: 0.3
    waveCount: 4
    waveRiseTime: 2350
    waveAnimateTime: 2151
    waveRise: true
    waveHeightScaling: true
    waveAnimate: true
    waveColor: "#7f0b4d"
    waveOffset: 0
    textVertPosition: 0.5
    textSize: 0.89
    valueCountUp: true
    displayPercent: false
    textColor: "#000000"
    waveTextColor: "#FFFFFF"
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
    defaults_version: 0
    series_types: {}
    font_size: 12
    hidden_pivots: {}
    listen:
      Date Granularity: of_case.timeframe_picker
      Web Email: of_case.supplied_email
      Open Date: of_case.createddate_filter_date
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      CSAT: of_case.csat_Param
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 1
    col: 12
    width: 3
    height: 4
  - title: FCR
    name: FCR
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.AVG_FIRST_CONTACT_RESOLUTION, previous_fcr]
    limit: 500
    dynamic_fields: [{category: measure, expression: 'trunc_months (${of_case.filter_start}
          ) = trunc_months ( ${of_case.createddate_date})', label: Previous FCR, value_format: !!null '',
        value_format_name: !!null '', based_on: of_case.AVG_FIRST_CONTACT_RESOLUTION,
        filter_expression: 'trunc_months (${of_case.filter_start} ) = trunc_months
          ( ${of_case.createddate_date})', _kind_hint: measure, measure: previous_fcr,
        type: average, _type_hint: number, filters: {}}]
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '16'
    orientation: auto
    style_of_case.AVG_FIRST_CONTACT_RESOLUTION: "#7f0b4d"
    show_title_of_case.AVG_FIRST_CONTACT_RESOLUTION: false
    title_placement_of_case.AVG_FIRST_CONTACT_RESOLUTION: above
    value_format_of_case.AVG_FIRST_CONTACT_RESOLUTION: ''
    show_comparison_previous_fcr: true
    comparison_style_previous_fcr: percentage_change
    comparison_show_label_previous_fcr: true
    pos_is_bad_previous_fcr: false
    comparison_label_previous_fcr: vs Prev
    comparison_label_placement_previous_fcr: below
    comp_value_format_previous_fcr: ''
    style_current_fcr: "#7f0b4d"
    show_title_current_fcr: false
    title_placement_current_fcr: above
    value_format_current_fcr: ''
    style_previous_fcr: "#3A4245"
    show_title_previous_fcr: true
    title_placement_previous_fcr: above
    value_format_previous_fcr: ''
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
    custom_color: "#BD0F72"
    conditional_formatting: [{type: greater than, value: 0, background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    showComparison: false
    minValue: 0
    maxValue: 1
    circleThickness: 0.05
    circleFillGap: 0.05
    circleColor: "#555555"
    waveHeight: 0.1
    waveCount: 4
    waveRiseTime: 2350
    waveAnimateTime: 2151
    waveRise: true
    waveHeightScaling: true
    waveAnimate: true
    waveColor: "#7f0b4d"
    waveOffset: 0
    textVertPosition: 0.5
    textSize: 0.89
    valueCountUp: true
    displayPercent: false
    textColor: "#000000"
    waveTextColor: "#FFFFFF"
    series_types: {}
    defaults_version: 0
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 1
    col: 6
    width: 3
    height: 4
  - title: Nurturing Ratio
    name: Nurturing Ratio
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.NURTURE_RATE, previous_nurturing_rate]
    limit: 500
    dynamic_fields: [{category: measure, expression: 'trunc_months (${of_case.filter_start}
          ) = trunc_months ( ${of_case.createddate_date})', label: Previous Nurturing
          Rate, value_format: !!null '', value_format_name: !!null '', based_on: of_case.NURTURE_RATE,
        filter_expression: 'trunc_months (${of_case.filter_start} ) = trunc_months
          ( ${of_case.createddate_date})', _kind_hint: measure, measure: previous_nurturing_rate,
        type: average, _type_hint: number, filters: {}}]
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '16'
    orientation: auto
    style_of_case.NURTURE_RATE: "#7f0b4d"
    show_title_of_case.NURTURE_RATE: false
    title_placement_of_case.NURTURE_RATE: above
    value_format_of_case.NURTURE_RATE: ''
    show_comparison_previous_nurturing_rate: true
    comparison_style_previous_nurturing_rate: percentage_change
    comparison_show_label_previous_nurturing_rate: true
    pos_is_bad_previous_nurturing_rate: false
    comparison_label_previous_nurturing_rate: vs Prev
    comparison_label_placement_previous_nurturing_rate: below
    comp_value_format_previous_nurturing_rate: ''
    style_current_nurturing_rate: "#7f0b4d"
    show_title_current_nurturing_rate: false
    title_placement_current_nurturing_rate: above
    value_format_current_nurturing_rate: ''
    style_previous_nurturing_rate: "#3A4245"
    show_title_previous_nurturing_rate: true
    title_placement_previous_nurturing_rate: above
    value_format_previous_nurturing_rate: ''
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
    custom_color: "#BD0F72"
    conditional_formatting: [{type: greater than, value: 0, background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    showComparison: false
    minValue: 0
    maxValue: 1
    circleThickness: 0.05
    circleFillGap: 0.05
    circleColor: "#555555"
    waveHeight: 0.1
    waveCount: 4
    waveRiseTime: 2400
    waveAnimateTime: 2151
    waveRise: true
    waveHeightScaling: true
    waveAnimate: true
    waveColor: "#7f0b4d"
    waveOffset: 0
    textVertPosition: 0.5
    textSize: 0.89
    valueCountUp: true
    displayPercent: false
    textColor: "#000000"
    waveTextColor: "#FFFFFF"
    series_types: {}
    defaults_version: 0
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 1
    col: 21
    width: 3
    height: 4
  - title: AHT (mins)
    name: AHT (mins)
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.average_handling_time, previous_aht]
    limit: 500
    dynamic_fields: [{category: measure, expression: 'trunc_months (${of_case.filter_start}
          ) = trunc_months ( ${of_case.createddate_date})', label: Previous AHT, value_format: !!null '',
        value_format_name: !!null '', based_on: of_case.average_handling_time_new,
        filter_expression: 'trunc_months (${of_case.filter_start} ) = trunc_months
          ( ${of_case.createddate_date})', _kind_hint: measure, measure: previous_aht,
        type: average, _type_hint: number}]
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '16'
    orientation: auto
    style_of_case.average_handling_time: "#7f0b4d"
    show_title_of_case.average_handling_time: false
    title_placement_of_case.average_handling_time: above
    value_format_of_case.average_handling_time: '0.0'
    show_comparison_previous_aht: true
    comparison_style_previous_aht: percentage_change
    comparison_show_label_previous_aht: true
    pos_is_bad_previous_aht: true
    comparison_label_previous_aht: vs Prev
    comparison_label_placement_previous_aht: below
    style_of_case.average_handling_time_new: "#7f0b4d"
    show_title_of_case.average_handling_time_new: false
    title_placement_of_case.average_handling_time_new: above
    comp_value_format_previous_aht: ''
    style_current_aht: "#7f0b4d"
    show_title_current_aht: false
    title_placement_current_aht: above
    value_format_current_aht: ''
    style_previous_aht: "#3A4245"
    show_title_previous_aht: true
    title_placement_previous_aht: above
    value_format_previous_aht: ''
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
    custom_color: "#BD0F72"
    conditional_formatting: [{type: greater than, value: 0, background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: 6c27c30e-5523-4080-82ae-272146e699d0,
          palette_id: 25b877bc-c7a8-4ed0-a0ef-5ba64ca3658d}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 0
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Exclude Awaiting Internal AHT: of_case.Exclude_Awaiting_Internal_in_AHT
      Handling Time: of_case.handletime_Param
      AHT Calculated: of_case.is_aht_calculated
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 1
    col: 3
    width: 3
    height: 4
  - title: FRT (mins)
    name: FRT (mins)
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.AVG_FIRST_RESPONSE_TIME_NEW, previous_frt]
    filters:
      of_case.is_channel_applicable_for_FRT: 'Yes'
    limit: 500
    dynamic_fields: [{category: measure, expression: 'trunc_months (${of_case.filter_start}
          ) = trunc_months ( ${of_case.createddate_date})', label: Previous FRT, value_format: !!null '',
        value_format_name: !!null '', based_on: of_case.AVG_FIRST_RESPONSE_TIME, filter_expression: 'trunc_months
          (${of_case.filter_start} ) = trunc_months ( ${of_case.createddate_date})',
        _kind_hint: measure, measure: previous_frt, type: average, _type_hint: number,
        filters: {}}]
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '16'
    orientation: auto
    style_of_case.AVG_FIRST_RESPONSE_TIME_NEW: "#7f0b4d"
    show_title_of_case.AVG_FIRST_RESPONSE_TIME_NEW: false
    title_placement_of_case.AVG_FIRST_RESPONSE_TIME_NEW: above
    value_format_of_case.AVG_FIRST_RESPONSE_TIME_NEW: '0.0'
    show_comparison_previous_frt: true
    comparison_style_previous_frt: percentage_change
    comparison_show_label_previous_frt: true
    pos_is_bad_previous_frt: true
    comparison_label_previous_frt: vs Prev
    comparison_label_placement_previous_frt: below
    style_of_case.AVG_FIRST_RESPONSE_TIME: "#7f0b4d"
    show_title_of_case.AVG_FIRST_RESPONSE_TIME: false
    title_placement_of_case.AVG_FIRST_RESPONSE_TIME: above
    value_format_of_case.AVG_FIRST_RESPONSE_TIME: ''
    comp_value_format_previous_frt: ''
    style_current_frt: "#7f0b4d"
    show_title_current_frt: false
    title_override_current_frt: FRT (Mins)
    title_placement_current_frt: above
    value_format_current_frt: ''
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
    custom_color: "#BD0F72"
    comparison_label: Prev Mon
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: 6c27c30e-5523-4080-82ae-272146e699d0,
          palette_id: 25b877bc-c7a8-4ed0-a0ef-5ba64ca3658d}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 0
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      First Response Time: of_case.responsetime_Param
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 1
    col: 18
    width: 3
    height: 4
  - title: Avg First Response Time (mins)
    name: Avg First Response Time (mins)
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.createddate_dynamic, of_case.Case_Geo, of_case.AVG_FIRST_RESPONSE_TIME_NEW,
      of_case.target_for_chat, of_case.target_for_web]
    pivots: [of_case.Case_Geo]
    filters:
      of_case.is_channel_applicable_for_FRT: 'Yes'
    sorts: [of_case.createddate_dynamic, of_case.Case_Geo]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields: [{category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_web})),-10))',
        label: Global Target (Web), value_format: !!null '', value_format_name: decimal_1,
        _kind_hint: supermeasure, table_calculation: global_target_web, _type_hint: number},
      {category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_chat})),-10))

          ', label: Global Target (Chat), value_format: !!null '', value_format_name: decimal_1,
        _kind_hint: supermeasure, table_calculation: global_target_chat, _type_hint: number}]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: Row Total - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: Total}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: HKGHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: HKGHQ}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: LONHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: LONHQ}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: RICHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: RICHQ}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: SAOHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: SAOHQ}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: SINHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: SINHQ}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: Unclaimed - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: Unclaimed -
              Case Average First Response Time New}, {axisId: of_case.dynamic_reference,
            id: Row Total - of_case.dynamic_reference, name: FY 23 - Global Target}],
        showLabels: false, showValues: false, minValue: 0, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    label_value_format: ''
    series_types:
      Row Total - of_case.AVG_FIRST_RESPONSE_TIME: line
      Row Total - of_case.AVG_FIRST_RESPONSE_TIME_NEW: line
      global_target: line
      hkghq_target: line
      lonhq_target: line
      richq_target: line
      sinhq_target: line
      saohq_target: line
      hkghq: line
      lonhq: line
      richq: line
      sinhq: line
      saohq: line
      global: line
      Row Total - of_case.dynamic_reference: line
      global_target_web: line
      global_target_chat: line
    series_colors:
      Row Total - of_case.AVG_FIRST_RESPONSE_TIME: "#F39200"
      HKGHQ - of_case.AVG_FIRST_RESPONSE_TIME: "#db72af"
      LONHQ - of_case.AVG_FIRST_RESPONSE_TIME: "#00506D"
      RICHQ - of_case.AVG_FIRST_RESPONSE_TIME: "#84C5C3"
      SAOHQ - of_case.AVG_FIRST_RESPONSE_TIME: "#BD0F72"
      SINHQ - of_case.AVG_FIRST_RESPONSE_TIME: "#8b908f"
      HKGHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: "#db72af"
      LONHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: "#00506D"
      RICHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: "#84C5C3"
      SAOHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: "#BD0F72"
      SINHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: "#8b908f"
      Row Total - of_case.AVG_FIRST_RESPONSE_TIME_NEW: "#F39200"
      global_target: "#f277aa"
      global: "#340335"
      Row Total - of_case.dynamic_reference: "#340335"
      global_target_chat: "#70AD47"
      global_target_web: "#00B050"
    series_labels:
      Row Total - of_case.AVG_FIRST_RESPONSE_TIME: Total
      1 - of_case.AVG_FIRST_RESPONSE_TIME: GKA
      2 - of_case.AVG_FIRST_RESPONSE_TIME: RKA
      3 - of_case.AVG_FIRST_RESPONSE_TIME: LKA
      4 - of_case.AVG_FIRST_RESPONSE_TIME: ONECare
      1 - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GKA
      2 - of_case.AVG_FIRST_RESPONSE_TIME_NEW: RKA
      3 - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LKA
      4 - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ONECare
      Row Total - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Total
      HKGHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HKGHQ
      LONHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LONHQ
      RICHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: RICHQ
      SAOHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SAOHQ
      SINHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SINHQ
      Global - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Global
      Chat - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Chat
      Email - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Email
      Manual - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Manual
      Web - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Web
      Phone - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Phone
      CCA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CCA
      CCS - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CCS
      Others - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Others
      Sales Executive - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Sales Executive
      C-KAM - of_case.AVG_FIRST_RESPONSE_TIME_NEW: C-KAM
      C-KAS - of_case.AVG_FIRST_RESPONSE_TIME_NEW: C-KAS
      No KA Mapping - of_case.AVG_FIRST_RESPONSE_TIME_NEW: No KA Mapping
      ONECare Queue - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ONECare Queue
      S-KAM - of_case.AVG_FIRST_RESPONSE_TIME_NEW: S-KAM
      S-KAS - of_case.AVG_FIRST_RESPONSE_TIME_NEW: S-KAS
      Onshore - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Onshore
      Offshore - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Offshore
      Complaint/Feedback - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Complaint/Feedback
      Complex - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Complex
      General Information - of_case.AVG_FIRST_RESPONSE_TIME_NEW: General Information
      Inquiry - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Inquiry
      Internal - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Internal
      Service Request - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Service Request
      Service Failure - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Service Failure
      Transactional - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Transactional
      No Action Required - of_case.AVG_FIRST_RESPONSE_TIME_NEW: No Action Required
      Internal Request - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Internal Request
      GKA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GKA
      LKA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LKA
      ONECare - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ONECare
      RKA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: RKA
      AE - of_case.AVG_FIRST_RESPONSE_TIME_NEW: AE
      AR - of_case.AVG_FIRST_RESPONSE_TIME_NEW: AR
      AT & HU - of_case.AVG_FIRST_RESPONSE_TIME_NEW: AT & HU
      AU - of_case.AVG_FIRST_RESPONSE_TIME_NEW: AU
      BD - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BD
      BR - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BR
      BE - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BE
      CH - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CH
      CL - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CL
      CN - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CN
      CO - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CO
      DE - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DE
      CZ & SK - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CZ & SK
      EC - of_case.AVG_FIRST_RESPONSE_TIME_NEW: EC
      DK - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DK
      EG - of_case.AVG_FIRST_RESPONSE_TIME_NEW: EG
      ES - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ES
      LK - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LK
      IT - of_case.AVG_FIRST_RESPONSE_TIME_NEW: IT
      FI - of_case.AVG_FIRST_RESPONSE_TIME_NEW: FI
      FR - of_case.AVG_FIRST_RESPONSE_TIME_NEW: FR
      GB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GB
      GH - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GH
      HK & SCN - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HK & SCN
      ID - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ID
      IL - of_case.AVG_FIRST_RESPONSE_TIME_NEW: IL
      IN - of_case.AVG_FIRST_RESPONSE_TIME_NEW: IN
      JP - of_case.AVG_FIRST_RESPONSE_TIME_NEW: JP
      KR - of_case.AVG_FIRST_RESPONSE_TIME_NEW: KR
      MA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MA
      MM - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MM
      MX - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MX
      MY - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MY
      TR - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TR
      TW - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TW
      TH - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TH
      SE & NO - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SE & NO
      NG - of_case.AVG_FIRST_RESPONSE_TIME_NEW: NG
      NL - of_case.AVG_FIRST_RESPONSE_TIME_NEW: NL
      NZ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: NZ
      PA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PA
      PE - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PE
      PH - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PH
      PK - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PK
      PL - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PL
      PT - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PT
      SG - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SG
      US - of_case.AVG_FIRST_RESPONSE_TIME_NEW: US
      UY - of_case.AVG_FIRST_RESPONSE_TIME_NEW: UY
      ZA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ZA
      CA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CA
      CI - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CI
      AT - of_case.AVG_FIRST_RESPONSE_TIME_NEW: AT
      CZ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CZ
      IE - of_case.AVG_FIRST_RESPONSE_TIME_NEW: IE
      SK - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SK
      VN - of_case.AVG_FIRST_RESPONSE_TIME_NEW: VN
      NO - of_case.AVG_FIRST_RESPONSE_TIME_NEW: 'NO'
      AS - of_case.AVG_FIRST_RESPONSE_TIME_NEW: AS
      BG - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BG
      CR - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CR
      CY - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CY
      DZ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DZ
      EE - of_case.AVG_FIRST_RESPONSE_TIME_NEW: EE
      FJ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: FJ
      GE - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GE
      GR - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GR
      GT - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GT
      HK - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HK
      HN - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HN
      HR - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HR
      HU - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HU
      KE - of_case.AVG_FIRST_RESPONSE_TIME_NEW: KE
      KH - of_case.AVG_FIRST_RESPONSE_TIME_NEW: KH
      KI - of_case.AVG_FIRST_RESPONSE_TIME_NEW: KI
      LB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LB
      LT - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LT
      LS - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LS
      LV - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LV
      MO - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MO
      MT - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MT
      NI - of_case.AVG_FIRST_RESPONSE_TIME_NEW: NI
      PF - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PF
      RO - of_case.AVG_FIRST_RESPONSE_TIME_NEW: RO
      SA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SA
      SB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SB
      SI - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SI
      SN - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SN
      SV - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SV
      TG - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TG
      TJ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TJ
      TN - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TN
      TO - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TO
      TT - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TT
      UA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: UA
      VU - of_case.AVG_FIRST_RESPONSE_TIME_NEW: VU
      WS - of_case.AVG_FIRST_RESPONSE_TIME_NEW: WS
      ZW - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ZW
      ZZ - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ZZ
      AARBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: AARBB
      ABJBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ABJBB
      ADLBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ADLBB
      AKLBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: AKLBB
      ALGBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ALGBB
      ALJBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ALJBA
      ALYBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ALYBB
      AMDBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: AMDBB
      ANRBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ANRBB
      APWBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: APWBA
      ASHBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ASHBA
      ATLBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ATLBB
      BASBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BASBB
      BCNBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BCNBB
      BDOBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BDOBB
      BELBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BELBB
      BEYBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BEYBA
      BIOBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BIOBB
      BKKBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BKKBB
      BLRBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BLRBB
      BNDBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BNDBB
      BNEBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BNEBB
      BOGBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BOGBB
      BOIBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BOIBB
      BOSBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BOSBB
      BREBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BREBB
      BTMBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BTMBB
      BUDBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BUDBB
      BUEBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: BUEBB
      CAIBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CAIBB
      CANBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CANBB
      CASBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CASBA
      CCPBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CCPBB
      CCUBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CCUBB
      CEBBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CEBBB
      CGOBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CGOBB
      CGPBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CGPBB
      CGYBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CGYBB
      CHCBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CHCBB
      CHIBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CHIBB
      CKGBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CKGBB
      CLLBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CLLBB
      CMBBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CMBBB
      CNDBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CNDBA
      COKBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: COKBB
      CPTBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CPTBB
      CTUBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CTUBB
      CWBBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: CWBBB
      DACBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DACBB
      DADBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DADBB
      DAMBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DAMBB
      DARBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DARBA
      DELBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DELBB
      DKRBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DKRBA
      DLCBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DLCBB
      DMNBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DMNBA
      DPSBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DPSBB
      DUBBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DUBBA
      DURBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DURBB
      DUSBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DUSBB
      DVOBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DVOBB
      DXBBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: DXBBB
      EDKBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: EDKBB
      ELSBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ELSBB
      FOCBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: FOCBB
      FREBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: FREBB
      GDLBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GDLBB
      GDNBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GDNBB
      GDYBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GDYBB
      GESBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GESBB
      GINBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GINBB
      GOABB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GOABB
      GOTBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GOTBB
      GUABA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GUABA
      GYEBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: GYEBB
      HALBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HALBB
      HAMBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HAMBB
      HANBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HANBB
      HELBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HELBB
      HFABA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HFABA
      HFEBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HFEBB
      HGHBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HGHBB
      HIRBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HIRBA
      HKGBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HKGBB
      HKTBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HKTBA
      HOUBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HOUBB
      HPHBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HPHBB
      HREBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HREBA
      HYDBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: HYDBB
      ICDBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ICDBB
      IPSBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: IPSBB
      IQQBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: IQQBB
      ISTBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ISTBA
      ISTBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ISTBB
      ITJBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ITJBB
      IZMBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: IZMBA
      IZMBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: IZMBB
      JEDBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: JEDBA
      JHBBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: JHBBB
      JKTBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: JKTBB
      JMNBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: JMNBB
      JNBBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: JNBBB
      KHHBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: KHHBB
      KHIBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: KHIBB
      KHLBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: KHLBB
      KLPBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: KLPBA
      KOPBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: KOPBA
      LAXBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LAXBB
      LCBBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LCBBB
      LEHBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LEHBB
      LEXBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LEXBB
      LFWBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LFWBA
      LHEBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LHEBB
      LIMBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LIMBB
      LISBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LISBB
      LIVBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LIVBB
      LMSBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LMSBA
      LONBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LONBB
      LOSBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LOSBB
      LUHBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LUHBB
      LYGBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: LYGBB
      MAABB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MAABB
      MACBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MACBB
      MADBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MADBB
      MAOBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MAOBB
      MBABA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MBABA
      MECBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MECBA
      MELBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MELBB
      MERBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MERBA
      MERBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MERBB
      MESBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MESBB
      MEXBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MEXBB
      MIBOS - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MIBOS
      MIHOS - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MIHOS
      MITBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MITBB
      MNGBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MNGBA
      MNLBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MNLBB
      MOWBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MOWBB
      MRSBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MRSBB
      MSUBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MSUBA
      MTABA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MTABA
      MTYBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MTYBB
      MUMBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MUMBB
      MVDBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: MVDBB
      NBOBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: NBOBB
      NGOBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: NGOBB
      NKGBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: NKGBB
      NSABB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: NSABB
      NVSBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: NVSBA
      NYCBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: NYCBB
      ODSBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ODSBA
      OPOBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: OPOBB
      OSABB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: OSABB
      PAIBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PAIBB
      PANBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PANBA
      PANBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PANBB
      PAVBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PAVBB
      PENBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PENBB
      PIRAEU - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PIRAE
      PKGBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PKGBB
      PLMBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PLMBB
      PLZBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PLZBB
      PNHBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PNHBA
      PNQBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PNQBB
      PPGBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PPGBA
      PPTBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PPTBA
      PRGBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PRGBB
      PSDBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PSDBB
      PTIBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PTIBA
      PTSBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PTSBA
      PUSBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: PUSBB
      QITBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: QITBA
      RHUBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: RHUBA
      RICBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: RICBB
      RIXBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: RIXBA
      RJKBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: RJKBA
      RTMBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: RTMBB
      SALBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SALBA
      SAOBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SAOBB
      SCLBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SCLBB
      SEABB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SEABB
      SELBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SELBB
      SFOBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SFOBB
      SFSBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SFSBB
      SGNBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SGNBB
      SGZBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SGZBB
      SHABB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SHABB
      SIABB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SIABB
      SINBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SINBB
      SINHO - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SINHO
      SJOBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SJOBA
      SJWBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SJWBB
      SKGBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SKGBA
      SMZBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SMZBA
      SOUBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SOUBB
      SPBBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SPBBB
      SPROS - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SPROS
      SRGBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SRGBB
      SSZBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SSZBB
      STRBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: STRBB
      SUBBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SUBBB
      SUDBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SUDBB
      SUVBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SUVBA
      SUZBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SUZBB
      SYDBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SYDBB
      SZHBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SZHBB
      SZPBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: SZPBB
      TAOBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TAOBB
      TBUBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TBUBA
      TEMBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TEMBB
      TGCBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TGCBA
      TLLBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TLLBA
      TLVBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TLVBA
      TORBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TORBB
      TPEBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TPEBB
      TPPBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TPPBB
      TRWBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TRWBA
      TSNBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TSNBB
      TUNBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TUNBA
      TUTBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TUTBB
      TXGBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TXGBB
      TYOBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: TYOBB
      VANBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: VANBB
      VAPBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: VAPBB
      VARBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: VARBA
      VGOBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: VGOBB
      VLCBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: VLCBB
      VLIBA - of_case.AVG_FIRST_RESPONSE_TIME_NEW: VLIBA
      VNABB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: VNABB
      VTZBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: VTZBB
      VVABB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: VVABB
      WGZOS - of_case.AVG_FIRST_RESPONSE_TIME_NEW: WGZOS
      WMLOS - of_case.AVG_FIRST_RESPONSE_TIME_NEW: WMLOS
      WNKOS - of_case.AVG_FIRST_RESPONSE_TIME_NEW: WNKOS
      WUHBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: WUHBB
      XMNBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: XMNBB
      YGNBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: YGNBB
      ZHOBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ZHOBB
      ZHUBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ZHUBB
      ZLOBB - of_case.AVG_FIRST_RESPONSE_TIME_NEW: ZLOBB
      of_case.Case_Geo___null - of_case.AVG_FIRST_RESPONSE_TIME_NEW: "∅"
      global: FY 23 Global Target
      Row Total - of_case.dynamic_reference: FY 23 - Global Target
      Unclaimed - of_case.AVG_FIRST_RESPONSE_TIME_NEW: Unclaimed
      global_target_chat: FY2023 Global Uniform Target (Chat)
      global_target_web: FY2023 Global Uniform Target (Web)
    series_point_styles:
      global: auto
      global_target_chat: diamond
    show_null_points: true
    interpolation: monotone
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Average First Response
      Time<BR><B>How it Helps : </B>Average time it takes for CCA/CCS to provide initial
      response to the Customer issues<BR>[For Case FRT,  it is measured from Case
      Creation Date/time to First Reply by CCA to Customer]<BR>[For Chat FRT,  the
      Start Time is now condition-based:<BR>If Customer send 1st msg, then that should
      be the start time<BR>If Agent sends a 1st msg before Customer 1st msg, then
      the start time should be the Automated Bot Greeting msg<BR>End Time is always
      based on:<BR>Agent’s first typed in msg (including “Hi” or “Hello”).]<BR><B>Filter
      Tips : </B><BR>Channel = Chat, First Response Time = Chat Transcript<BR>Channel
      is not = Chat, First Response Time = Case Level<BR>'
    hidden_pivots:
      '1':
        measure_names: []
      Global:
        measure_names: []
      HKGHQ:
        measure_names: []
      LONHQ:
        measure_names: []
      RICHQ:
        measure_names: []
      SAOHQ:
        measure_names: []
      SINHQ:
        measure_names: []
      Unclaimed:
        measure_names: []
    hidden_fields: [of_case.target_measure_for_WEB2, of_case.target_measure_for_Chat2,
      of_case.target_for_chat, of_case.target_for_web]
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      First Response Time: of_case.responsetime_Param
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 14
    col: 0
    width: 21
    height: 9
  - title: First Contact Resolution
    name: First Contact Resolution
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.AVG_FIRST_CONTACT_RESOLUTION, of_case.createddate_dynamic, of_case.Case_Geo,
      of_case.target_for_chat, of_case.target_for_web]
    pivots: [of_case.Case_Geo]
    sorts: [of_case.createddate_dynamic, of_case.Case_Geo]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields: [{category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_web})),-10))',
        label: Global Target (Web), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target_web, _type_hint: number},
      {category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_chat})),-10))

          ', label: Global Target (Chat), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target_chat, _type_hint: number}]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.AVG_FIRST_CONTACT_RESOLUTION,
            id: HKGHQ - of_case.AVG_FIRST_CONTACT_RESOLUTION, name: HKGHQ}, {axisId: of_case.AVG_FIRST_CONTACT_RESOLUTION,
            id: LONHQ - of_case.AVG_FIRST_CONTACT_RESOLUTION, name: LONHQ}, {axisId: of_case.AVG_FIRST_CONTACT_RESOLUTION,
            id: RICHQ - of_case.AVG_FIRST_CONTACT_RESOLUTION, name: RICHQ}, {axisId: of_case.AVG_FIRST_CONTACT_RESOLUTION,
            id: SAOHQ - of_case.AVG_FIRST_CONTACT_RESOLUTION, name: SAOHQ}, {axisId: of_case.AVG_FIRST_CONTACT_RESOLUTION,
            id: SINHQ - of_case.AVG_FIRST_CONTACT_RESOLUTION, name: SINHQ}, {axisId: of_case.AVG_FIRST_CONTACT_RESOLUTION,
            id: Row Total - of_case.AVG_FIRST_CONTACT_RESOLUTION, name: Total}, {
            axisId: of_case.AVG_FIRST_CONTACT_RESOLUTION, id: Unclaimed - of_case.AVG_FIRST_CONTACT_RESOLUTION,
            name: Unclaimed}, {axisId: global, id: global, name: FY 23 Global Target}],
        showLabels: false, showValues: false, minValue: 0, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      Row Total - of_case.AVG_FIRST_CONTACT_RESOLUTION: line
      global_target: line
      hkghq_target: line
      lonhq_target: line
      richq_target: line
      saohq_target: line
      sinhq_target: line
      hkghq: line
      lonhq: line
      richq: line
      saohq: line
      sinhq: line
      global: line
      Row Total - of_case.dynamic_reference: line
      Unclaimed - global: line
      global_target_web: line
      global_target_chat: line
    series_colors:
      Row Total - of_case.AVG_FIRST_CONTACT_RESOLUTION: "#F39200"
      HKGHQ - of_case.AVG_FIRST_CONTACT_RESOLUTION: "#db72af"
      LONHQ - of_case.AVG_FIRST_CONTACT_RESOLUTION: "#00506D"
      RICHQ - of_case.AVG_FIRST_CONTACT_RESOLUTION: "#84C5C3"
      SAOHQ - of_case.AVG_FIRST_CONTACT_RESOLUTION: "#BD0F72"
      SINHQ - of_case.AVG_FIRST_CONTACT_RESOLUTION: "#8b908f"
      global: "#340335"
      global_target_chat: "#70AD47"
      global_target_web: "#00B050"
    series_labels:
      Row Total - of_case.AVG_FIRST_CONTACT_RESOLUTION: Total
      1 - of_case.AVG_FIRST_CONTACT_RESOLUTION: GKA
      2 - of_case.AVG_FIRST_CONTACT_RESOLUTION: RKA
      3 - of_case.AVG_FIRST_CONTACT_RESOLUTION: LKA
      4 - of_case.AVG_FIRST_CONTACT_RESOLUTION: ONECare
      Global - of_case.AVG_FIRST_CONTACT_RESOLUTION: Global
      HKGHQ - of_case.AVG_FIRST_CONTACT_RESOLUTION: HKGHQ
      LONHQ - of_case.AVG_FIRST_CONTACT_RESOLUTION: LONHQ
      RICHQ - of_case.AVG_FIRST_CONTACT_RESOLUTION: RICHQ
      SAOHQ - of_case.AVG_FIRST_CONTACT_RESOLUTION: SAOHQ
      SINHQ - of_case.AVG_FIRST_CONTACT_RESOLUTION: SINHQ
      Chat - of_case.AVG_FIRST_CONTACT_RESOLUTION: Chat
      Email - of_case.AVG_FIRST_CONTACT_RESOLUTION: Email
      Manual - of_case.AVG_FIRST_CONTACT_RESOLUTION: Manual
      Web - of_case.AVG_FIRST_CONTACT_RESOLUTION: Web
      Phone - of_case.AVG_FIRST_CONTACT_RESOLUTION: Phone
      global: FY 23 Global Target
      Row Total - of_case.dynamic_reference: Target
      Unclaimed - global: Target
      Unclaimed - of_case.AVG_FIRST_CONTACT_RESOLUTION: Unclaimed
      global_target_chat: FY2023 Global Uniform Target (Chat)
      global_target_web: FY2023 Global Uniform Target (Web)
      CCA - of_case.AVG_FIRST_CONTACT_RESOLUTION: CCA
      CCS - of_case.AVG_FIRST_CONTACT_RESOLUTION: CCS
      Others - of_case.AVG_FIRST_CONTACT_RESOLUTION: Others
      Sales Executive - of_case.AVG_FIRST_CONTACT_RESOLUTION: Sales Executive
      C-KAM - of_case.AVG_FIRST_CONTACT_RESOLUTION: C-KAM
      C-KAS - of_case.AVG_FIRST_CONTACT_RESOLUTION: C-KAS
      No KA Mapping - of_case.AVG_FIRST_CONTACT_RESOLUTION: No KA Mapping
      ONECare Queue - of_case.AVG_FIRST_CONTACT_RESOLUTION: ONECare Queue
      S-KAM - of_case.AVG_FIRST_CONTACT_RESOLUTION: S-KAM
      S-KAS - of_case.AVG_FIRST_CONTACT_RESOLUTION: S-KAS
      Onshore - of_case.AVG_FIRST_CONTACT_RESOLUTION: Onshore
      Offshore - of_case.AVG_FIRST_CONTACT_RESOLUTION: Offshore
      Complaint/Feedback - of_case.AVG_FIRST_CONTACT_RESOLUTION: Complaint/Feedback
      Complex - of_case.AVG_FIRST_CONTACT_RESOLUTION: Complex
      General Information - of_case.AVG_FIRST_CONTACT_RESOLUTION: General Information
      Inquiry - of_case.AVG_FIRST_CONTACT_RESOLUTION: Inquiry
      Internal - of_case.AVG_FIRST_CONTACT_RESOLUTION: Internal
      Service Request - of_case.AVG_FIRST_CONTACT_RESOLUTION: Service Request
      Service Failure - of_case.AVG_FIRST_CONTACT_RESOLUTION: Service Failure
      Transactional - of_case.AVG_FIRST_CONTACT_RESOLUTION: Transactional
      No Action Required - of_case.AVG_FIRST_CONTACT_RESOLUTION: No Action Required
      Internal Request - of_case.AVG_FIRST_CONTACT_RESOLUTION: Internal Request
      GKA - of_case.AVG_FIRST_CONTACT_RESOLUTION: GKA
      LKA - of_case.AVG_FIRST_CONTACT_RESOLUTION: LKA
      ONECare - of_case.AVG_FIRST_CONTACT_RESOLUTION: ONECare
      RKA - of_case.AVG_FIRST_CONTACT_RESOLUTION: RKA
      AE - of_case.AVG_FIRST_CONTACT_RESOLUTION: AE
      AR - of_case.AVG_FIRST_CONTACT_RESOLUTION: AR
      AT & HU - of_case.AVG_FIRST_CONTACT_RESOLUTION: AT & HU
      AU - of_case.AVG_FIRST_CONTACT_RESOLUTION: AU
      BD - of_case.AVG_FIRST_CONTACT_RESOLUTION: BD
      BR - of_case.AVG_FIRST_CONTACT_RESOLUTION: BR
      BE - of_case.AVG_FIRST_CONTACT_RESOLUTION: BE
      CH - of_case.AVG_FIRST_CONTACT_RESOLUTION: CH
      CL - of_case.AVG_FIRST_CONTACT_RESOLUTION: CL
      CN - of_case.AVG_FIRST_CONTACT_RESOLUTION: CN
      CO - of_case.AVG_FIRST_CONTACT_RESOLUTION: CO
      DE - of_case.AVG_FIRST_CONTACT_RESOLUTION: DE
      CZ & SK - of_case.AVG_FIRST_CONTACT_RESOLUTION: CZ & SK
      EC - of_case.AVG_FIRST_CONTACT_RESOLUTION: EC
      DK - of_case.AVG_FIRST_CONTACT_RESOLUTION: DK
      EG - of_case.AVG_FIRST_CONTACT_RESOLUTION: EG
      ES - of_case.AVG_FIRST_CONTACT_RESOLUTION: ES
      LK - of_case.AVG_FIRST_CONTACT_RESOLUTION: LK
      IT - of_case.AVG_FIRST_CONTACT_RESOLUTION: IT
      FI - of_case.AVG_FIRST_CONTACT_RESOLUTION: FI
      FR - of_case.AVG_FIRST_CONTACT_RESOLUTION: FR
      GB - of_case.AVG_FIRST_CONTACT_RESOLUTION: GB
      GH - of_case.AVG_FIRST_CONTACT_RESOLUTION: GH
      HK & SCN - of_case.AVG_FIRST_CONTACT_RESOLUTION: HK & SCN
      ID - of_case.AVG_FIRST_CONTACT_RESOLUTION: ID
      IL - of_case.AVG_FIRST_CONTACT_RESOLUTION: IL
      IN - of_case.AVG_FIRST_CONTACT_RESOLUTION: IN
      JP - of_case.AVG_FIRST_CONTACT_RESOLUTION: JP
      KR - of_case.AVG_FIRST_CONTACT_RESOLUTION: KR
      MA - of_case.AVG_FIRST_CONTACT_RESOLUTION: MA
      MM - of_case.AVG_FIRST_CONTACT_RESOLUTION: MM
      MX - of_case.AVG_FIRST_CONTACT_RESOLUTION: MX
      MY - of_case.AVG_FIRST_CONTACT_RESOLUTION: MY
      TR - of_case.AVG_FIRST_CONTACT_RESOLUTION: TR
      TW - of_case.AVG_FIRST_CONTACT_RESOLUTION: TW
      TH - of_case.AVG_FIRST_CONTACT_RESOLUTION: TH
      SE & NO - of_case.AVG_FIRST_CONTACT_RESOLUTION: SE & NO
      NG - of_case.AVG_FIRST_CONTACT_RESOLUTION: NG
      NL - of_case.AVG_FIRST_CONTACT_RESOLUTION: NL
      NZ - of_case.AVG_FIRST_CONTACT_RESOLUTION: NZ
      PA - of_case.AVG_FIRST_CONTACT_RESOLUTION: PA
      PE - of_case.AVG_FIRST_CONTACT_RESOLUTION: PE
      PH - of_case.AVG_FIRST_CONTACT_RESOLUTION: PH
      PK - of_case.AVG_FIRST_CONTACT_RESOLUTION: PK
      PL - of_case.AVG_FIRST_CONTACT_RESOLUTION: PL
      PT - of_case.AVG_FIRST_CONTACT_RESOLUTION: PT
      SG - of_case.AVG_FIRST_CONTACT_RESOLUTION: SG
      US - of_case.AVG_FIRST_CONTACT_RESOLUTION: US
      UY - of_case.AVG_FIRST_CONTACT_RESOLUTION: UY
      ZA - of_case.AVG_FIRST_CONTACT_RESOLUTION: ZA
      CA - of_case.AVG_FIRST_CONTACT_RESOLUTION: CA
      CI - of_case.AVG_FIRST_CONTACT_RESOLUTION: CI
      AT - of_case.AVG_FIRST_CONTACT_RESOLUTION: AT
      CZ - of_case.AVG_FIRST_CONTACT_RESOLUTION: CZ
      IE - of_case.AVG_FIRST_CONTACT_RESOLUTION: IE
      SK - of_case.AVG_FIRST_CONTACT_RESOLUTION: SK
      VN - of_case.AVG_FIRST_CONTACT_RESOLUTION: VN
      NO - of_case.AVG_FIRST_CONTACT_RESOLUTION: 'NO'
      AS - of_case.AVG_FIRST_CONTACT_RESOLUTION: AS
      BG - of_case.AVG_FIRST_CONTACT_RESOLUTION: BG
      CR - of_case.AVG_FIRST_CONTACT_RESOLUTION: CR
      CY - of_case.AVG_FIRST_CONTACT_RESOLUTION: CY
      DZ - of_case.AVG_FIRST_CONTACT_RESOLUTION: DZ
      EE - of_case.AVG_FIRST_CONTACT_RESOLUTION: EE
      FJ - of_case.AVG_FIRST_CONTACT_RESOLUTION: FJ
      GE - of_case.AVG_FIRST_CONTACT_RESOLUTION: GE
      GR - of_case.AVG_FIRST_CONTACT_RESOLUTION: GR
      GT - of_case.AVG_FIRST_CONTACT_RESOLUTION: GT
      HK - of_case.AVG_FIRST_CONTACT_RESOLUTION: HK
      HN - of_case.AVG_FIRST_CONTACT_RESOLUTION: HN
      HR - of_case.AVG_FIRST_CONTACT_RESOLUTION: HR
      HU - of_case.AVG_FIRST_CONTACT_RESOLUTION: HU
      KE - of_case.AVG_FIRST_CONTACT_RESOLUTION: KE
      KH - of_case.AVG_FIRST_CONTACT_RESOLUTION: KH
      KI - of_case.AVG_FIRST_CONTACT_RESOLUTION: KI
      LB - of_case.AVG_FIRST_CONTACT_RESOLUTION: LB
      LT - of_case.AVG_FIRST_CONTACT_RESOLUTION: LT
      LS - of_case.AVG_FIRST_CONTACT_RESOLUTION: LS
      LV - of_case.AVG_FIRST_CONTACT_RESOLUTION: LV
      MO - of_case.AVG_FIRST_CONTACT_RESOLUTION: MO
      MT - of_case.AVG_FIRST_CONTACT_RESOLUTION: MT
      NI - of_case.AVG_FIRST_CONTACT_RESOLUTION: NI
      PF - of_case.AVG_FIRST_CONTACT_RESOLUTION: PF
      RO - of_case.AVG_FIRST_CONTACT_RESOLUTION: RO
      SA - of_case.AVG_FIRST_CONTACT_RESOLUTION: SA
      SB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SB
      SI - of_case.AVG_FIRST_CONTACT_RESOLUTION: SI
      SN - of_case.AVG_FIRST_CONTACT_RESOLUTION: SN
      SV - of_case.AVG_FIRST_CONTACT_RESOLUTION: SV
      TG - of_case.AVG_FIRST_CONTACT_RESOLUTION: TG
      TJ - of_case.AVG_FIRST_CONTACT_RESOLUTION: TJ
      TN - of_case.AVG_FIRST_CONTACT_RESOLUTION: TN
      TO - of_case.AVG_FIRST_CONTACT_RESOLUTION: TO
      TT - of_case.AVG_FIRST_CONTACT_RESOLUTION: TT
      UA - of_case.AVG_FIRST_CONTACT_RESOLUTION: UA
      VU - of_case.AVG_FIRST_CONTACT_RESOLUTION: VU
      WS - of_case.AVG_FIRST_CONTACT_RESOLUTION: WS
      ZW - of_case.AVG_FIRST_CONTACT_RESOLUTION: ZW
      ZZ - of_case.AVG_FIRST_CONTACT_RESOLUTION: ZZ
      AARBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: AARBB
      ABJBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: ABJBB
      ADLBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: ADLBB
      AKLBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: AKLBB
      ALGBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: ALGBB
      ALJBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: ALJBA
      ALYBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: ALYBB
      AMDBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: AMDBB
      ANRBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: ANRBB
      APWBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: APWBA
      ASHBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: ASHBA
      ATLBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: ATLBB
      BASBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BASBB
      BCNBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BCNBB
      BDOBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BDOBB
      BELBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BELBB
      BEYBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: BEYBA
      BIOBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BIOBB
      BKKBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BKKBB
      BLRBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BLRBB
      BNDBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BNDBB
      BNEBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BNEBB
      BOGBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BOGBB
      BOIBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BOIBB
      BOSBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BOSBB
      BREBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BREBB
      BTMBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BTMBB
      BUDBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BUDBB
      BUEBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: BUEBB
      CAIBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CAIBB
      CANBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CANBB
      CASBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: CASBA
      CCPBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CCPBB
      CCUBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CCUBB
      CEBBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CEBBB
      CGOBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CGOBB
      CGPBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CGPBB
      CGYBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CGYBB
      CHCBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CHCBB
      CHIBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CHIBB
      CKGBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CKGBB
      CLLBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CLLBB
      CMBBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CMBBB
      CNDBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: CNDBA
      COKBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: COKBB
      CPTBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CPTBB
      CTUBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CTUBB
      CWBBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: CWBBB
      DACBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: DACBB
      DADBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: DADBB
      DAMBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: DAMBB
      DARBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: DARBA
      DELBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: DELBB
      DKRBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: DKRBA
      DLCBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: DLCBB
      DMNBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: DMNBA
      DPSBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: DPSBB
      DUBBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: DUBBA
      DURBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: DURBB
      DUSBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: DUSBB
      DVOBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: DVOBB
      DXBBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: DXBBB
      EDKBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: EDKBB
      ELSBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: ELSBB
      FOCBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: FOCBB
      FREBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: FREBB
      GDLBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: GDLBB
      GDNBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: GDNBB
      GDYBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: GDYBB
      GESBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: GESBB
      GINBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: GINBB
      GOABB - of_case.AVG_FIRST_CONTACT_RESOLUTION: GOABB
      GOTBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: GOTBB
      GUABA - of_case.AVG_FIRST_CONTACT_RESOLUTION: GUABA
      GYEBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: GYEBB
      HALBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: HALBB
      HAMBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: HAMBB
      HANBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: HANBB
      HELBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: HELBB
      HFABA - of_case.AVG_FIRST_CONTACT_RESOLUTION: HFABA
      HFEBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: HFEBB
      HGHBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: HGHBB
      HIRBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: HIRBA
      HKGBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: HKGBB
      HKTBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: HKTBA
      HOUBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: HOUBB
      HPHBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: HPHBB
      HREBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: HREBA
      HYDBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: HYDBB
      ICDBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: ICDBB
      IPSBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: IPSBB
      IQQBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: IQQBB
      ISTBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: ISTBA
      ISTBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: ISTBB
      ITJBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: ITJBB
      IZMBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: IZMBA
      IZMBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: IZMBB
      JEDBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: JEDBA
      JHBBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: JHBBB
      JKTBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: JKTBB
      JMNBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: JMNBB
      JNBBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: JNBBB
      KHHBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: KHHBB
      KHIBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: KHIBB
      KHLBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: KHLBB
      KLPBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: KLPBA
      KOPBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: KOPBA
      LAXBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: LAXBB
      LCBBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: LCBBB
      LEHBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: LEHBB
      LEXBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: LEXBB
      LFWBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: LFWBA
      LHEBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: LHEBB
      LIMBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: LIMBB
      LISBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: LISBB
      LIVBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: LIVBB
      LMSBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: LMSBA
      LONBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: LONBB
      LOSBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: LOSBB
      LUHBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: LUHBB
      LYGBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: LYGBB
      MAABB - of_case.AVG_FIRST_CONTACT_RESOLUTION: MAABB
      MACBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: MACBB
      MADBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: MADBB
      MAOBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: MAOBB
      MBABA - of_case.AVG_FIRST_CONTACT_RESOLUTION: MBABA
      MECBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: MECBA
      MELBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: MELBB
      MERBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: MERBA
      MERBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: MERBB
      MESBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: MESBB
      MEXBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: MEXBB
      MIBOS - of_case.AVG_FIRST_CONTACT_RESOLUTION: MIBOS
      MIHOS - of_case.AVG_FIRST_CONTACT_RESOLUTION: MIHOS
      MITBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: MITBB
      MNGBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: MNGBA
      MNLBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: MNLBB
      MOWBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: MOWBB
      MRSBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: MRSBB
      MSUBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: MSUBA
      MTABA - of_case.AVG_FIRST_CONTACT_RESOLUTION: MTABA
      MTYBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: MTYBB
      MUMBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: MUMBB
      MVDBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: MVDBB
      NBOBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: NBOBB
      NGOBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: NGOBB
      NKGBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: NKGBB
      NSABB - of_case.AVG_FIRST_CONTACT_RESOLUTION: NSABB
      NVSBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: NVSBA
      NYCBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: NYCBB
      ODSBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: ODSBA
      OPOBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: OPOBB
      OSABB - of_case.AVG_FIRST_CONTACT_RESOLUTION: OSABB
      PAIBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: PAIBB
      PANBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: PANBA
      PANBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: PANBB
      PAVBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: PAVBB
      PENBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: PENBB
      PIRAEU - of_case.AVG_FIRST_CONTACT_RESOLUTION: PIRAE
      PKGBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: PKGBB
      PLMBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: PLMBB
      PLZBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: PLZBB
      PNHBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: PNHBA
      PNQBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: PNQBB
      PPGBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: PPGBA
      PPTBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: PPTBA
      PRGBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: PRGBB
      PSDBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: PSDBB
      PTIBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: PTIBA
      PTSBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: PTSBA
      PUSBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: PUSBB
      QITBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: QITBA
      RHUBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: RHUBA
      RICBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: RICBB
      RIXBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: RIXBA
      RJKBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: RJKBA
      RTMBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: RTMBB
      SALBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: SALBA
      SAOBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SAOBB
      SCLBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SCLBB
      SEABB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SEABB
      SELBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SELBB
      SFOBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SFOBB
      SFSBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SFSBB
      SGNBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SGNBB
      SGZBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SGZBB
      SHABB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SHABB
      SIABB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SIABB
      SINBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SINBB
      SINHO - of_case.AVG_FIRST_CONTACT_RESOLUTION: SINHO
      SJOBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: SJOBA
      SJWBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SJWBB
      SKGBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: SKGBA
      SMZBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: SMZBA
      SOUBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SOUBB
      SPBBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SPBBB
      SPROS - of_case.AVG_FIRST_CONTACT_RESOLUTION: SPROS
      SRGBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SRGBB
      SSZBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SSZBB
      STRBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: STRBB
      SUBBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SUBBB
      SUDBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SUDBB
      SUVBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: SUVBA
      SUZBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SUZBB
      SYDBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SYDBB
      SZHBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SZHBB
      SZPBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: SZPBB
      TAOBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: TAOBB
      TBUBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: TBUBA
      TEMBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: TEMBB
      TGCBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: TGCBA
      TLLBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: TLLBA
      TLVBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: TLVBA
      TORBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: TORBB
      TPEBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: TPEBB
      TPPBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: TPPBB
      TRWBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: TRWBA
      TSNBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: TSNBB
      TUNBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: TUNBA
      TUTBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: TUTBB
      TXGBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: TXGBB
      TYOBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: TYOBB
      VANBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: VANBB
      VAPBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: VAPBB
      VARBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: VARBA
      VGOBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: VGOBB
      VLCBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: VLCBB
      VLIBA - of_case.AVG_FIRST_CONTACT_RESOLUTION: VLIBA
      VNABB - of_case.AVG_FIRST_CONTACT_RESOLUTION: VNABB
      VTZBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: VTZBB
      VVABB - of_case.AVG_FIRST_CONTACT_RESOLUTION: VVABB
      WGZOS - of_case.AVG_FIRST_CONTACT_RESOLUTION: WGZOS
      WMLOS - of_case.AVG_FIRST_CONTACT_RESOLUTION: WMLOS
      WNKOS - of_case.AVG_FIRST_CONTACT_RESOLUTION: WNKOS
      WUHBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: WUHBB
      XMNBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: XMNBB
      YGNBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: YGNBB
      ZHOBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: ZHOBB
      ZHUBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: ZHUBB
      ZLOBB - of_case.AVG_FIRST_CONTACT_RESOLUTION: ZLOBB
      of_case.Case_Geo___null - of_case.AVG_FIRST_CONTACT_RESOLUTION: "∅"
    series_point_styles:
      global_target_chat: diamond
    show_null_points: true
    interpolation: monotone
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>First Contact Resolution<BR><B>How
      it Helps : </B>To track the percentage of incoming cases resolved without further
      support from other team members.<BR>[For non-Chat Cases, counted as FCR if the
      case has no transfer and escalation activity]<BR>[For Chat cases, counted as
      FCR if the case has no transfer and escalation activity and Created date is
      the same as Resolved date]'
    hidden_fields: [of_case.target_measure_for_Chat2, of_case.target_measure_for_WEB2,
      of_case.target_for_web, of_case.target_for_chat]
    hidden_pivots:
      Global:
        measure_names: []
      HKGHQ:
        measure_names:
        - global
      LONHQ:
        measure_names:
        - global
      RICHQ:
        measure_names:
        - global
      SAOHQ:
        measure_names:
        - global
      SINHQ:
        measure_names:
        - global
      Unclaimed:
        measure_names:
        - global
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 50
    col: 0
    width: 11
    height: 9
  - title: Customer Satisfaction Ratio
    name: Customer Satisfaction Ratio
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.createddate_dynamic, of_case.Case_Geo, of_case.customer_satisfaction_ratio_case_chat,
      of_case.target_for_chat, of_case.target_for_web]
    pivots: [of_case.Case_Geo]
    sorts: [of_case.createddate_dynamic, of_case.Case_Geo]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields: [{category: measure, expression: !!null '', label: Good Rating,
        value_format: !!null '', value_format_name: !!null '', based_on: of_case.case_distinct_count,
        _kind_hint: measure, measure: good_rating, type: count_distinct, _type_hint: number,
        filters: {of_case.case_rating: Good}}, {category: measure, expression: !!null '',
        label: Good & Bad Rating, value_format: !!null '', value_format_name: !!null '',
        based_on: of_case.case_distinct_count, _kind_hint: measure, measure: good_bad_rating,
        type: count_distinct, _type_hint: number, filters: {of_case.case_rating: 'Good,Bad'}},
      {category: table_calculation, expression: "${good_rating}/${good_bad_rating}",
        label: Customer Satisfaction Ratio, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: customer_satisfaction_ratio, _type_hint: number,
        is_disabled: true}, {category: dimension, expression: "${of_case.origin}",
        label: Channel For Filter, value_format: !!null '', value_format_name: !!null '',
        dimension: channel_for_filter, _kind_hint: dimension, _type_hint: string},
      {category: dimension, expression: "${of_case.case_rating}", label: Case Rating
          for Filter, value_format: !!null '', value_format_name: !!null '', dimension: case_rating_for_filter,
        _kind_hint: dimension, _type_hint: string}, {category: dimension, expression: "${of_chat_transcript.chat_case_rating}",
        label: Chat case rating for filter, value_format: !!null '', value_format_name: !!null '',
        dimension: chat_case_rating_for_filter, _kind_hint: dimension, _type_hint: string},
      {category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_chat})),-10))',
        label: Global Target (Chat), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target_chat, _type_hint: number},
      {category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_web})),-10))',
        label: Global Target (Web), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target_web, _type_hint: number}]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.Customer_satisfaction_ratio,
            id: Global - of_case.Customer_satisfaction_ratio, name: Global - Case
              Customer Satisfaction Ratio}, {axisId: of_case.Customer_satisfaction_ratio,
            id: Row Total - of_case.Customer_satisfaction_ratio, name: Total}, {axisId: global_target,
            id: global_target, name: Global Target}, {axisId: hkghq_target, id: hkghq_target,
            name: HKGHQ Target}, {axisId: lonhq_target, id: lonhq_target, name: LONHQ
              Target}, {axisId: richq_target, id: richq_target, name: RICHQ Target},
          {axisId: saohq_target, id: saohq_target, name: SAOHQ Target}, {axisId: sinhq_target,
            id: sinhq_target, name: SINHQ Target}], showLabels: false, showValues: false,
        minValue: 0, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      Row Total - of_case.Customer_satisfaction_ratio: line
      global_target: line
      hkghq_target: line
      lonhq_target: line
      richq_target: line
      saohq_target: line
      sinhq_target: line
      Row Total - of_case.customer_satisfaction_ratio_case_chat: line
      Row Total - of_case.dynamic_reference: line
      global: line
      global_target_chat: line
      global_target_web: line
    series_colors:
      Row Total - of_case.Customer_satisfaction_ratio: "#F39200"
      HKGHQ - of_case.Customer_satisfaction_ratio: "#db72af"
      LONHQ - of_case.Customer_satisfaction_ratio: "#00506D"
      RICHQ - of_case.Customer_satisfaction_ratio: "#84C5C3"
      SAOHQ - of_case.Customer_satisfaction_ratio: "#BD0F72"
      SINHQ - of_case.Customer_satisfaction_ratio: "#8b908f"
      Row Total - of_case.customer_satisfaction_ratio_case_chat: "#F39200"
      HKGHQ - of_case.customer_satisfaction_ratio_case_chat: "#db72af"
      LONHQ - of_case.customer_satisfaction_ratio_case_chat: "#00506D"
      RICHQ - of_case.customer_satisfaction_ratio_case_chat: "#84C5C3"
      SAOHQ - of_case.customer_satisfaction_ratio_case_chat: "#BD0F72"
      SINHQ - of_case.customer_satisfaction_ratio_case_chat: "#8b908f"
      Unclaimed - of_case.customer_satisfaction_ratio_case_chat: "#AB6E13"
      global_target_web: "#00B050"
      global_target_chat: "#70AD47"
    series_labels:
      Row Total - of_case.Customer_satisfaction_ratio: Total
      1 - of_case.Customer_satisfaction_ratio: GKA
      2 - of_case.Customer_satisfaction_ratio: RKA
      3 - of_case.Customer_satisfaction_ratio: LKA
      4 - of_case.Customer_satisfaction_ratio: ONECare
      Global - of_case.Customer_satisfaction_ratio: Global
      HKGHQ - of_case.Customer_satisfaction_ratio: HKGHQ
      LONHQ - of_case.Customer_satisfaction_ratio: LONHQ
      RICHQ - of_case.Customer_satisfaction_ratio: RICHQ
      SAOHQ - of_case.Customer_satisfaction_ratio: SAOHQ
      SINHQ - of_case.Customer_satisfaction_ratio: SINHQ
      Row Total - of_case.customer_satisfaction_ratio_case_chat: Total
      Row Total - of_case.dynamic_reference: Target
      HKGHQ - of_case.customer_satisfaction_ratio_case_chat: HKGHQ
      LONHQ - of_case.customer_satisfaction_ratio_case_chat: LONHQ
      RICHQ - of_case.customer_satisfaction_ratio_case_chat: RICHQ
      SAOHQ - of_case.customer_satisfaction_ratio_case_chat: SAOHQ
      SINHQ - of_case.customer_satisfaction_ratio_case_chat: SINHQ
      Unclaimed - of_case.customer_satisfaction_ratio_case_chat: Unclaimed
      Global - of_case.customer_satisfaction_ratio_case_chat: Global
      global: Target
      global_target_chat: FY2023 Global Uniform Target (Chat)
      global_target_web: FY2023 Global Uniform Target (Web)
      Chat - of_case.customer_satisfaction_ratio_case_chat: Chat
      Email - of_case.customer_satisfaction_ratio_case_chat: Email
      Manual - of_case.customer_satisfaction_ratio_case_chat: Manual
      Web - of_case.customer_satisfaction_ratio_case_chat: Web
      Phone - of_case.customer_satisfaction_ratio_case_chat: Phone
      1 - of_case.customer_satisfaction_ratio_case_chat: GKA
      2 - of_case.customer_satisfaction_ratio_case_chat: RKA
      3 - of_case.customer_satisfaction_ratio_case_chat: LKA
      4 - of_case.customer_satisfaction_ratio_case_chat: ONECare
      CCA - of_case.customer_satisfaction_ratio_case_chat: CCA
      CCS - of_case.customer_satisfaction_ratio_case_chat: CCS
      Others - of_case.customer_satisfaction_ratio_case_chat: Others
      Sales Executive - of_case.customer_satisfaction_ratio_case_chat: Sales Executive
      C-KAM - of_case.customer_satisfaction_ratio_case_chat: C-KAM
      C-KAS - of_case.customer_satisfaction_ratio_case_chat: C-KAS
      No KA Mapping - of_case.customer_satisfaction_ratio_case_chat: No KA Mapping
      ONECare Queue - of_case.customer_satisfaction_ratio_case_chat: ONECare Queue
      S-KAM - of_case.customer_satisfaction_ratio_case_chat: S-KAM
      S-KAS - of_case.customer_satisfaction_ratio_case_chat: S-KAS
      Onshore - of_case.customer_satisfaction_ratio_case_chat: Onshore
      Offshore - of_case.customer_satisfaction_ratio_case_chat: Offshore
      Complaint/Feedback - of_case.customer_satisfaction_ratio_case_chat: Complaint/Feedback
      Complex - of_case.customer_satisfaction_ratio_case_chat: Complex
      General Information - of_case.customer_satisfaction_ratio_case_chat: General
        Information
      Inquiry - of_case.customer_satisfaction_ratio_case_chat: Inquiry
      Internal - of_case.customer_satisfaction_ratio_case_chat: Internal
      Service Request - of_case.customer_satisfaction_ratio_case_chat: Service Request
      Service Failure - of_case.customer_satisfaction_ratio_case_chat: Service Failure
      Transactional - of_case.customer_satisfaction_ratio_case_chat: Transactional
      No Action Required - of_case.customer_satisfaction_ratio_case_chat: No Action
        Required
      Internal Request - of_case.customer_satisfaction_ratio_case_chat: Internal Request
      GKA - of_case.customer_satisfaction_ratio_case_chat: GKA
      LKA - of_case.customer_satisfaction_ratio_case_chat: LKA
      ONECare - of_case.customer_satisfaction_ratio_case_chat: ONECare
      RKA - of_case.customer_satisfaction_ratio_case_chat: RKA
      AE - of_case.customer_satisfaction_ratio_case_chat: AE
      AR - of_case.customer_satisfaction_ratio_case_chat: AR
      AT & HU - of_case.customer_satisfaction_ratio_case_chat: AT & HU
      AU - of_case.customer_satisfaction_ratio_case_chat: AU
      BD - of_case.customer_satisfaction_ratio_case_chat: BD
      BR - of_case.customer_satisfaction_ratio_case_chat: BR
      BE - of_case.customer_satisfaction_ratio_case_chat: BE
      CH - of_case.customer_satisfaction_ratio_case_chat: CH
      CL - of_case.customer_satisfaction_ratio_case_chat: CL
      CN - of_case.customer_satisfaction_ratio_case_chat: CN
      CO - of_case.customer_satisfaction_ratio_case_chat: CO
      DE - of_case.customer_satisfaction_ratio_case_chat: DE
      CZ & SK - of_case.customer_satisfaction_ratio_case_chat: CZ & SK
      EC - of_case.customer_satisfaction_ratio_case_chat: EC
      DK - of_case.customer_satisfaction_ratio_case_chat: DK
      EG - of_case.customer_satisfaction_ratio_case_chat: EG
      ES - of_case.customer_satisfaction_ratio_case_chat: ES
      LK - of_case.customer_satisfaction_ratio_case_chat: LK
      IT - of_case.customer_satisfaction_ratio_case_chat: IT
      FI - of_case.customer_satisfaction_ratio_case_chat: FI
      FR - of_case.customer_satisfaction_ratio_case_chat: FR
      GB - of_case.customer_satisfaction_ratio_case_chat: GB
      GH - of_case.customer_satisfaction_ratio_case_chat: GH
      HK & SCN - of_case.customer_satisfaction_ratio_case_chat: HK & SCN
      ID - of_case.customer_satisfaction_ratio_case_chat: ID
      IL - of_case.customer_satisfaction_ratio_case_chat: IL
      IN - of_case.customer_satisfaction_ratio_case_chat: IN
      JP - of_case.customer_satisfaction_ratio_case_chat: JP
      KR - of_case.customer_satisfaction_ratio_case_chat: KR
      MA - of_case.customer_satisfaction_ratio_case_chat: MA
      MM - of_case.customer_satisfaction_ratio_case_chat: MM
      MX - of_case.customer_satisfaction_ratio_case_chat: MX
      MY - of_case.customer_satisfaction_ratio_case_chat: MY
      TR - of_case.customer_satisfaction_ratio_case_chat: TR
      TW - of_case.customer_satisfaction_ratio_case_chat: TW
      TH - of_case.customer_satisfaction_ratio_case_chat: TH
      SE & NO - of_case.customer_satisfaction_ratio_case_chat: SE & NO
      NG - of_case.customer_satisfaction_ratio_case_chat: NG
      NL - of_case.customer_satisfaction_ratio_case_chat: NL
      NZ - of_case.customer_satisfaction_ratio_case_chat: NZ
      PA - of_case.customer_satisfaction_ratio_case_chat: PA
      PE - of_case.customer_satisfaction_ratio_case_chat: PE
      PH - of_case.customer_satisfaction_ratio_case_chat: PH
      PK - of_case.customer_satisfaction_ratio_case_chat: PK
      PL - of_case.customer_satisfaction_ratio_case_chat: PL
      PT - of_case.customer_satisfaction_ratio_case_chat: PT
      SG - of_case.customer_satisfaction_ratio_case_chat: SG
      US - of_case.customer_satisfaction_ratio_case_chat: US
      UY - of_case.customer_satisfaction_ratio_case_chat: UY
      ZA - of_case.customer_satisfaction_ratio_case_chat: ZA
      CA - of_case.customer_satisfaction_ratio_case_chat: CA
      CI - of_case.customer_satisfaction_ratio_case_chat: CI
      AT - of_case.customer_satisfaction_ratio_case_chat: AT
      CZ - of_case.customer_satisfaction_ratio_case_chat: CZ
      IE - of_case.customer_satisfaction_ratio_case_chat: IE
      SK - of_case.customer_satisfaction_ratio_case_chat: SK
      VN - of_case.customer_satisfaction_ratio_case_chat: VN
      NO - of_case.customer_satisfaction_ratio_case_chat: 'NO'
      AS - of_case.customer_satisfaction_ratio_case_chat: AS
      BG - of_case.customer_satisfaction_ratio_case_chat: BG
      CR - of_case.customer_satisfaction_ratio_case_chat: CR
      CY - of_case.customer_satisfaction_ratio_case_chat: CY
      DZ - of_case.customer_satisfaction_ratio_case_chat: DZ
      EE - of_case.customer_satisfaction_ratio_case_chat: EE
      FJ - of_case.customer_satisfaction_ratio_case_chat: FJ
      GE - of_case.customer_satisfaction_ratio_case_chat: GE
      GR - of_case.customer_satisfaction_ratio_case_chat: GR
      GT - of_case.customer_satisfaction_ratio_case_chat: GT
      HK - of_case.customer_satisfaction_ratio_case_chat: HK
      HN - of_case.customer_satisfaction_ratio_case_chat: HN
      HR - of_case.customer_satisfaction_ratio_case_chat: HR
      HU - of_case.customer_satisfaction_ratio_case_chat: HU
      KE - of_case.customer_satisfaction_ratio_case_chat: KE
      KH - of_case.customer_satisfaction_ratio_case_chat: KH
      KI - of_case.customer_satisfaction_ratio_case_chat: KI
      LB - of_case.customer_satisfaction_ratio_case_chat: LB
      LT - of_case.customer_satisfaction_ratio_case_chat: LT
      LS - of_case.customer_satisfaction_ratio_case_chat: LS
      LV - of_case.customer_satisfaction_ratio_case_chat: LV
      MO - of_case.customer_satisfaction_ratio_case_chat: MO
      MT - of_case.customer_satisfaction_ratio_case_chat: MT
      NI - of_case.customer_satisfaction_ratio_case_chat: NI
      PF - of_case.customer_satisfaction_ratio_case_chat: PF
      RO - of_case.customer_satisfaction_ratio_case_chat: RO
      SA - of_case.customer_satisfaction_ratio_case_chat: SA
      SB - of_case.customer_satisfaction_ratio_case_chat: SB
      SI - of_case.customer_satisfaction_ratio_case_chat: SI
      SN - of_case.customer_satisfaction_ratio_case_chat: SN
      SV - of_case.customer_satisfaction_ratio_case_chat: SV
      TG - of_case.customer_satisfaction_ratio_case_chat: TG
      TJ - of_case.customer_satisfaction_ratio_case_chat: TJ
      TN - of_case.customer_satisfaction_ratio_case_chat: TN
      TO - of_case.customer_satisfaction_ratio_case_chat: TO
      TT - of_case.customer_satisfaction_ratio_case_chat: TT
      UA - of_case.customer_satisfaction_ratio_case_chat: UA
      VU - of_case.customer_satisfaction_ratio_case_chat: VU
      WS - of_case.customer_satisfaction_ratio_case_chat: WS
      ZW - of_case.customer_satisfaction_ratio_case_chat: ZW
      ZZ - of_case.customer_satisfaction_ratio_case_chat: ZZ
      AARBB - of_case.customer_satisfaction_ratio_case_chat: AARBB
      ABJBB - of_case.customer_satisfaction_ratio_case_chat: ABJBB
      ADLBB - of_case.customer_satisfaction_ratio_case_chat: ADLBB
      AKLBB - of_case.customer_satisfaction_ratio_case_chat: AKLBB
      ALGBB - of_case.customer_satisfaction_ratio_case_chat: ALGBB
      ALJBA - of_case.customer_satisfaction_ratio_case_chat: ALJBA
      ALYBB - of_case.customer_satisfaction_ratio_case_chat: ALYBB
      AMDBB - of_case.customer_satisfaction_ratio_case_chat: AMDBB
      ANRBB - of_case.customer_satisfaction_ratio_case_chat: ANRBB
      APWBA - of_case.customer_satisfaction_ratio_case_chat: APWBA
      ASHBA - of_case.customer_satisfaction_ratio_case_chat: ASHBA
      ATLBB - of_case.customer_satisfaction_ratio_case_chat: ATLBB
      BASBB - of_case.customer_satisfaction_ratio_case_chat: BASBB
      BCNBB - of_case.customer_satisfaction_ratio_case_chat: BCNBB
      BDOBB - of_case.customer_satisfaction_ratio_case_chat: BDOBB
      BELBB - of_case.customer_satisfaction_ratio_case_chat: BELBB
      BEYBA - of_case.customer_satisfaction_ratio_case_chat: BEYBA
      BIOBB - of_case.customer_satisfaction_ratio_case_chat: BIOBB
      BKKBB - of_case.customer_satisfaction_ratio_case_chat: BKKBB
      BLRBB - of_case.customer_satisfaction_ratio_case_chat: BLRBB
      BNDBB - of_case.customer_satisfaction_ratio_case_chat: BNDBB
      BNEBB - of_case.customer_satisfaction_ratio_case_chat: BNEBB
      BOGBB - of_case.customer_satisfaction_ratio_case_chat: BOGBB
      BOIBB - of_case.customer_satisfaction_ratio_case_chat: BOIBB
      BOSBB - of_case.customer_satisfaction_ratio_case_chat: BOSBB
      BREBB - of_case.customer_satisfaction_ratio_case_chat: BREBB
      BTMBB - of_case.customer_satisfaction_ratio_case_chat: BTMBB
      BUDBB - of_case.customer_satisfaction_ratio_case_chat: BUDBB
      BUEBB - of_case.customer_satisfaction_ratio_case_chat: BUEBB
      CAIBB - of_case.customer_satisfaction_ratio_case_chat: CAIBB
      CANBB - of_case.customer_satisfaction_ratio_case_chat: CANBB
      CASBA - of_case.customer_satisfaction_ratio_case_chat: CASBA
      CCPBB - of_case.customer_satisfaction_ratio_case_chat: CCPBB
      CCUBB - of_case.customer_satisfaction_ratio_case_chat: CCUBB
      CEBBB - of_case.customer_satisfaction_ratio_case_chat: CEBBB
      CGOBB - of_case.customer_satisfaction_ratio_case_chat: CGOBB
      CGPBB - of_case.customer_satisfaction_ratio_case_chat: CGPBB
      CGYBB - of_case.customer_satisfaction_ratio_case_chat: CGYBB
      CHCBB - of_case.customer_satisfaction_ratio_case_chat: CHCBB
      CHIBB - of_case.customer_satisfaction_ratio_case_chat: CHIBB
      CKGBB - of_case.customer_satisfaction_ratio_case_chat: CKGBB
      CLLBB - of_case.customer_satisfaction_ratio_case_chat: CLLBB
      CMBBB - of_case.customer_satisfaction_ratio_case_chat: CMBBB
      CNDBA - of_case.customer_satisfaction_ratio_case_chat: CNDBA
      COKBB - of_case.customer_satisfaction_ratio_case_chat: COKBB
      CPTBB - of_case.customer_satisfaction_ratio_case_chat: CPTBB
      CTUBB - of_case.customer_satisfaction_ratio_case_chat: CTUBB
      CWBBB - of_case.customer_satisfaction_ratio_case_chat: CWBBB
      DACBB - of_case.customer_satisfaction_ratio_case_chat: DACBB
      DADBB - of_case.customer_satisfaction_ratio_case_chat: DADBB
      DAMBB - of_case.customer_satisfaction_ratio_case_chat: DAMBB
      DARBA - of_case.customer_satisfaction_ratio_case_chat: DARBA
      DELBB - of_case.customer_satisfaction_ratio_case_chat: DELBB
      DKRBA - of_case.customer_satisfaction_ratio_case_chat: DKRBA
      DLCBB - of_case.customer_satisfaction_ratio_case_chat: DLCBB
      DMNBA - of_case.customer_satisfaction_ratio_case_chat: DMNBA
      DPSBB - of_case.customer_satisfaction_ratio_case_chat: DPSBB
      DUBBA - of_case.customer_satisfaction_ratio_case_chat: DUBBA
      DURBB - of_case.customer_satisfaction_ratio_case_chat: DURBB
      DUSBB - of_case.customer_satisfaction_ratio_case_chat: DUSBB
      DVOBB - of_case.customer_satisfaction_ratio_case_chat: DVOBB
      DXBBB - of_case.customer_satisfaction_ratio_case_chat: DXBBB
      EDKBB - of_case.customer_satisfaction_ratio_case_chat: EDKBB
      ELSBB - of_case.customer_satisfaction_ratio_case_chat: ELSBB
      FOCBB - of_case.customer_satisfaction_ratio_case_chat: FOCBB
      FREBB - of_case.customer_satisfaction_ratio_case_chat: FREBB
      GDLBB - of_case.customer_satisfaction_ratio_case_chat: GDLBB
      GDNBB - of_case.customer_satisfaction_ratio_case_chat: GDNBB
      GDYBB - of_case.customer_satisfaction_ratio_case_chat: GDYBB
      GESBB - of_case.customer_satisfaction_ratio_case_chat: GESBB
      GINBB - of_case.customer_satisfaction_ratio_case_chat: GINBB
      GOABB - of_case.customer_satisfaction_ratio_case_chat: GOABB
      GOTBB - of_case.customer_satisfaction_ratio_case_chat: GOTBB
      GUABA - of_case.customer_satisfaction_ratio_case_chat: GUABA
      GYEBB - of_case.customer_satisfaction_ratio_case_chat: GYEBB
      HALBB - of_case.customer_satisfaction_ratio_case_chat: HALBB
      HAMBB - of_case.customer_satisfaction_ratio_case_chat: HAMBB
      HANBB - of_case.customer_satisfaction_ratio_case_chat: HANBB
      HELBB - of_case.customer_satisfaction_ratio_case_chat: HELBB
      HFABA - of_case.customer_satisfaction_ratio_case_chat: HFABA
      HFEBB - of_case.customer_satisfaction_ratio_case_chat: HFEBB
      HGHBB - of_case.customer_satisfaction_ratio_case_chat: HGHBB
      HIRBA - of_case.customer_satisfaction_ratio_case_chat: HIRBA
      HKGBB - of_case.customer_satisfaction_ratio_case_chat: HKGBB
      HKTBA - of_case.customer_satisfaction_ratio_case_chat: HKTBA
      HOUBB - of_case.customer_satisfaction_ratio_case_chat: HOUBB
      HPHBB - of_case.customer_satisfaction_ratio_case_chat: HPHBB
      HREBA - of_case.customer_satisfaction_ratio_case_chat: HREBA
      HYDBB - of_case.customer_satisfaction_ratio_case_chat: HYDBB
      ICDBB - of_case.customer_satisfaction_ratio_case_chat: ICDBB
      IPSBB - of_case.customer_satisfaction_ratio_case_chat: IPSBB
      IQQBB - of_case.customer_satisfaction_ratio_case_chat: IQQBB
      ISTBA - of_case.customer_satisfaction_ratio_case_chat: ISTBA
      ISTBB - of_case.customer_satisfaction_ratio_case_chat: ISTBB
      ITJBB - of_case.customer_satisfaction_ratio_case_chat: ITJBB
      IZMBA - of_case.customer_satisfaction_ratio_case_chat: IZMBA
      IZMBB - of_case.customer_satisfaction_ratio_case_chat: IZMBB
      JEDBA - of_case.customer_satisfaction_ratio_case_chat: JEDBA
      JHBBB - of_case.customer_satisfaction_ratio_case_chat: JHBBB
      JKTBB - of_case.customer_satisfaction_ratio_case_chat: JKTBB
      JMNBB - of_case.customer_satisfaction_ratio_case_chat: JMNBB
      JNBBB - of_case.customer_satisfaction_ratio_case_chat: JNBBB
      KHHBB - of_case.customer_satisfaction_ratio_case_chat: KHHBB
      KHIBB - of_case.customer_satisfaction_ratio_case_chat: KHIBB
      KHLBB - of_case.customer_satisfaction_ratio_case_chat: KHLBB
      KLPBA - of_case.customer_satisfaction_ratio_case_chat: KLPBA
      KOPBA - of_case.customer_satisfaction_ratio_case_chat: KOPBA
      LAXBB - of_case.customer_satisfaction_ratio_case_chat: LAXBB
      LCBBB - of_case.customer_satisfaction_ratio_case_chat: LCBBB
      LEHBB - of_case.customer_satisfaction_ratio_case_chat: LEHBB
      LEXBB - of_case.customer_satisfaction_ratio_case_chat: LEXBB
      LFWBA - of_case.customer_satisfaction_ratio_case_chat: LFWBA
      LHEBB - of_case.customer_satisfaction_ratio_case_chat: LHEBB
      LIMBB - of_case.customer_satisfaction_ratio_case_chat: LIMBB
      LISBB - of_case.customer_satisfaction_ratio_case_chat: LISBB
      LIVBB - of_case.customer_satisfaction_ratio_case_chat: LIVBB
      LMSBA - of_case.customer_satisfaction_ratio_case_chat: LMSBA
      LONBB - of_case.customer_satisfaction_ratio_case_chat: LONBB
      LOSBB - of_case.customer_satisfaction_ratio_case_chat: LOSBB
      LUHBB - of_case.customer_satisfaction_ratio_case_chat: LUHBB
      LYGBB - of_case.customer_satisfaction_ratio_case_chat: LYGBB
      MAABB - of_case.customer_satisfaction_ratio_case_chat: MAABB
      MACBB - of_case.customer_satisfaction_ratio_case_chat: MACBB
      MADBB - of_case.customer_satisfaction_ratio_case_chat: MADBB
      MAOBB - of_case.customer_satisfaction_ratio_case_chat: MAOBB
      MBABA - of_case.customer_satisfaction_ratio_case_chat: MBABA
      MECBA - of_case.customer_satisfaction_ratio_case_chat: MECBA
      MELBB - of_case.customer_satisfaction_ratio_case_chat: MELBB
      MERBA - of_case.customer_satisfaction_ratio_case_chat: MERBA
      MERBB - of_case.customer_satisfaction_ratio_case_chat: MERBB
      MESBB - of_case.customer_satisfaction_ratio_case_chat: MESBB
      MEXBB - of_case.customer_satisfaction_ratio_case_chat: MEXBB
      MIBOS - of_case.customer_satisfaction_ratio_case_chat: MIBOS
      MIHOS - of_case.customer_satisfaction_ratio_case_chat: MIHOS
      MITBB - of_case.customer_satisfaction_ratio_case_chat: MITBB
      MNGBA - of_case.customer_satisfaction_ratio_case_chat: MNGBA
      MNLBB - of_case.customer_satisfaction_ratio_case_chat: MNLBB
      MOWBB - of_case.customer_satisfaction_ratio_case_chat: MOWBB
      MRSBB - of_case.customer_satisfaction_ratio_case_chat: MRSBB
      MSUBA - of_case.customer_satisfaction_ratio_case_chat: MSUBA
      MTABA - of_case.customer_satisfaction_ratio_case_chat: MTABA
      MTYBB - of_case.customer_satisfaction_ratio_case_chat: MTYBB
      MUMBB - of_case.customer_satisfaction_ratio_case_chat: MUMBB
      MVDBB - of_case.customer_satisfaction_ratio_case_chat: MVDBB
      NBOBB - of_case.customer_satisfaction_ratio_case_chat: NBOBB
      NGOBB - of_case.customer_satisfaction_ratio_case_chat: NGOBB
      NKGBB - of_case.customer_satisfaction_ratio_case_chat: NKGBB
      NSABB - of_case.customer_satisfaction_ratio_case_chat: NSABB
      NVSBA - of_case.customer_satisfaction_ratio_case_chat: NVSBA
      NYCBB - of_case.customer_satisfaction_ratio_case_chat: NYCBB
      ODSBA - of_case.customer_satisfaction_ratio_case_chat: ODSBA
      OPOBB - of_case.customer_satisfaction_ratio_case_chat: OPOBB
      OSABB - of_case.customer_satisfaction_ratio_case_chat: OSABB
      PAIBB - of_case.customer_satisfaction_ratio_case_chat: PAIBB
      PANBA - of_case.customer_satisfaction_ratio_case_chat: PANBA
      PANBB - of_case.customer_satisfaction_ratio_case_chat: PANBB
      PAVBB - of_case.customer_satisfaction_ratio_case_chat: PAVBB
      PENBB - of_case.customer_satisfaction_ratio_case_chat: PENBB
      PIRAEU - of_case.customer_satisfaction_ratio_case_chat: PIRAE
      PKGBB - of_case.customer_satisfaction_ratio_case_chat: PKGBB
      PLMBB - of_case.customer_satisfaction_ratio_case_chat: PLMBB
      PLZBB - of_case.customer_satisfaction_ratio_case_chat: PLZBB
      PNHBA - of_case.customer_satisfaction_ratio_case_chat: PNHBA
      PNQBB - of_case.customer_satisfaction_ratio_case_chat: PNQBB
      PPGBA - of_case.customer_satisfaction_ratio_case_chat: PPGBA
      PPTBA - of_case.customer_satisfaction_ratio_case_chat: PPTBA
      PRGBB - of_case.customer_satisfaction_ratio_case_chat: PRGBB
      PSDBB - of_case.customer_satisfaction_ratio_case_chat: PSDBB
      PTIBA - of_case.customer_satisfaction_ratio_case_chat: PTIBA
      PTSBA - of_case.customer_satisfaction_ratio_case_chat: PTSBA
      PUSBB - of_case.customer_satisfaction_ratio_case_chat: PUSBB
      QITBA - of_case.customer_satisfaction_ratio_case_chat: QITBA
      RHUBA - of_case.customer_satisfaction_ratio_case_chat: RHUBA
      RICBB - of_case.customer_satisfaction_ratio_case_chat: RICBB
      RIXBA - of_case.customer_satisfaction_ratio_case_chat: RIXBA
      RJKBA - of_case.customer_satisfaction_ratio_case_chat: RJKBA
      RTMBB - of_case.customer_satisfaction_ratio_case_chat: RTMBB
      SALBA - of_case.customer_satisfaction_ratio_case_chat: SALBA
      SAOBB - of_case.customer_satisfaction_ratio_case_chat: SAOBB
      SCLBB - of_case.customer_satisfaction_ratio_case_chat: SCLBB
      SEABB - of_case.customer_satisfaction_ratio_case_chat: SEABB
      SELBB - of_case.customer_satisfaction_ratio_case_chat: SELBB
      SFOBB - of_case.customer_satisfaction_ratio_case_chat: SFOBB
      SFSBB - of_case.customer_satisfaction_ratio_case_chat: SFSBB
      SGNBB - of_case.customer_satisfaction_ratio_case_chat: SGNBB
      SGZBB - of_case.customer_satisfaction_ratio_case_chat: SGZBB
      SHABB - of_case.customer_satisfaction_ratio_case_chat: SHABB
      SIABB - of_case.customer_satisfaction_ratio_case_chat: SIABB
      SINBB - of_case.customer_satisfaction_ratio_case_chat: SINBB
      SINHO - of_case.customer_satisfaction_ratio_case_chat: SINHO
      SJOBA - of_case.customer_satisfaction_ratio_case_chat: SJOBA
      SJWBB - of_case.customer_satisfaction_ratio_case_chat: SJWBB
      SKGBA - of_case.customer_satisfaction_ratio_case_chat: SKGBA
      SMZBA - of_case.customer_satisfaction_ratio_case_chat: SMZBA
      SOUBB - of_case.customer_satisfaction_ratio_case_chat: SOUBB
      SPBBB - of_case.customer_satisfaction_ratio_case_chat: SPBBB
      SPROS - of_case.customer_satisfaction_ratio_case_chat: SPROS
      SRGBB - of_case.customer_satisfaction_ratio_case_chat: SRGBB
      SSZBB - of_case.customer_satisfaction_ratio_case_chat: SSZBB
      STRBB - of_case.customer_satisfaction_ratio_case_chat: STRBB
      SUBBB - of_case.customer_satisfaction_ratio_case_chat: SUBBB
      SUDBB - of_case.customer_satisfaction_ratio_case_chat: SUDBB
      SUVBA - of_case.customer_satisfaction_ratio_case_chat: SUVBA
      SUZBB - of_case.customer_satisfaction_ratio_case_chat: SUZBB
      SYDBB - of_case.customer_satisfaction_ratio_case_chat: SYDBB
      SZHBB - of_case.customer_satisfaction_ratio_case_chat: SZHBB
      SZPBB - of_case.customer_satisfaction_ratio_case_chat: SZPBB
      TAOBB - of_case.customer_satisfaction_ratio_case_chat: TAOBB
      TBUBA - of_case.customer_satisfaction_ratio_case_chat: TBUBA
      TEMBB - of_case.customer_satisfaction_ratio_case_chat: TEMBB
      TGCBA - of_case.customer_satisfaction_ratio_case_chat: TGCBA
      TLLBA - of_case.customer_satisfaction_ratio_case_chat: TLLBA
      TLVBA - of_case.customer_satisfaction_ratio_case_chat: TLVBA
      TORBB - of_case.customer_satisfaction_ratio_case_chat: TORBB
      TPEBB - of_case.customer_satisfaction_ratio_case_chat: TPEBB
      TPPBB - of_case.customer_satisfaction_ratio_case_chat: TPPBB
      TRWBA - of_case.customer_satisfaction_ratio_case_chat: TRWBA
      TSNBB - of_case.customer_satisfaction_ratio_case_chat: TSNBB
      TUNBA - of_case.customer_satisfaction_ratio_case_chat: TUNBA
      TUTBB - of_case.customer_satisfaction_ratio_case_chat: TUTBB
      TXGBB - of_case.customer_satisfaction_ratio_case_chat: TXGBB
      TYOBB - of_case.customer_satisfaction_ratio_case_chat: TYOBB
      VANBB - of_case.customer_satisfaction_ratio_case_chat: VANBB
      VAPBB - of_case.customer_satisfaction_ratio_case_chat: VAPBB
      VARBA - of_case.customer_satisfaction_ratio_case_chat: VARBA
      VGOBB - of_case.customer_satisfaction_ratio_case_chat: VGOBB
      VLCBB - of_case.customer_satisfaction_ratio_case_chat: VLCBB
      VLIBA - of_case.customer_satisfaction_ratio_case_chat: VLIBA
      VNABB - of_case.customer_satisfaction_ratio_case_chat: VNABB
      VTZBB - of_case.customer_satisfaction_ratio_case_chat: VTZBB
      VVABB - of_case.customer_satisfaction_ratio_case_chat: VVABB
      WGZOS - of_case.customer_satisfaction_ratio_case_chat: WGZOS
      WMLOS - of_case.customer_satisfaction_ratio_case_chat: WMLOS
      WNKOS - of_case.customer_satisfaction_ratio_case_chat: WNKOS
      WUHBB - of_case.customer_satisfaction_ratio_case_chat: WUHBB
      XMNBB - of_case.customer_satisfaction_ratio_case_chat: XMNBB
      YGNBB - of_case.customer_satisfaction_ratio_case_chat: YGNBB
      ZHOBB - of_case.customer_satisfaction_ratio_case_chat: ZHOBB
      ZHUBB - of_case.customer_satisfaction_ratio_case_chat: ZHUBB
      ZLOBB - of_case.customer_satisfaction_ratio_case_chat: ZLOBB
      of_case.Case_Geo___null - of_case.customer_satisfaction_ratio_case_chat: "∅"
    series_point_styles:
      global_target_chat: diamond
    show_null_points: true
    interpolation: monotone
    defaults_version: 1
    hidden_fields: [of_case.target_measure_for_Chat2, of_case.target_measure_for_WEB2,
      of_case.target_for_web, of_case.target_for_chat]
    note_state: collapsed
    note_display: hover
    note_text: |-
      <P style="text-align:left;"><B>Metric Name : </B>Customer Satisfaction Ratio<BR><B>How it Helps : </B>Measure how well our Customers are satisfied with the service that they receive from our agents and Platform Integration User bot

      <BR>[Good CSAT rating / Total Good and Bad Rating in %]
    hidden_pivots:
      HKGHQ:
        measure_names: []
      LONHQ:
        measure_names: []
      RICHQ:
        measure_names: []
      SAOHQ:
        measure_names: []
      SINHQ:
        measure_names: []
      Unclaimed:
        measure_names: []
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      CSAT: of_case.csat_Param
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 59
    col: 0
    width: 11
    height: 9
  - title: 'Case Resolution Ratio '
    name: 'Case Resolution Ratio '
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.createddate_dynamic, of_case.Case_Resolution_ratio, of_case.Case_Geo]
    pivots: [of_case.Case_Geo]
    sorts: [of_case.createddate_dynamic, of_case.dynamic_dim_landing]
    limit: 500
    row_total: right
    dynamic_fields: [{category: measure, expression: !!null '', label: Resolved &
          Closed Cases, value_format: !!null '', value_format_name: !!null '', based_on: of_case.case_distinct_count,
        _kind_hint: measure, measure: resolved_closed_cases, type: count_distinct,
        _type_hint: number, filters: {of_case.status: 'Resolved,Closed'}}, {category: measure,
        expression: !!null '', label: Total Cases, value_format: !!null '', value_format_name: !!null '',
        based_on: of_case.case_distinct_count, _kind_hint: measure, measure: total_cases,
        type: count_distinct, _type_hint: number}, {category: table_calculation, expression: "${resolved_closed_cases}/${total_cases}",
        label: Case Resolution Ratio, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: case_resolution_ratio, _type_hint: number,
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
    stacking: ''
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
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: Chat - case_resolution_ratio,
            id: Chat - case_resolution_ratio, name: Chat}, {axisId: Email - case_resolution_ratio,
            id: Email - case_resolution_ratio, name: Email}, {axisId: Internal - case_resolution_ratio,
            id: Internal - case_resolution_ratio, name: Internal}, {axisId: Phone
              - case_resolution_ratio, id: Phone - case_resolution_ratio, name: Phone},
          {axisId: Web - case_resolution_ratio, id: Web - case_resolution_ratio, name: Web}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types:
      Row Total - of_case.Case_Resolution_ratio: line
    series_colors:
      Row Total - of_case.Case_Resolution_ratio: "#F39200"
      HKGHQ - of_case.Case_Resolution_ratio: "#db72af"
      LONHQ - of_case.Case_Resolution_ratio: "#00506D"
      RICHQ - of_case.Case_Resolution_ratio: "#84C5C3"
      SAOHQ - of_case.Case_Resolution_ratio: "#BD0F72"
      SINHQ - of_case.Case_Resolution_ratio: "#8b908f"
    series_labels:
      Row Total - of_case.Case_Resolution_ratio: Total
      1 - of_case.Case_Resolution_ratio: GKA
      2 - of_case.Case_Resolution_ratio: RKA
      3 - of_case.Case_Resolution_ratio: LKA
      4 - of_case.Case_Resolution_ratio: ONECare
      HKGHQ - of_case.Case_Resolution_ratio: HKGHQ
      LONHQ - of_case.Case_Resolution_ratio: LONHQ
      RICHQ - of_case.Case_Resolution_ratio: RICHQ
      SAOHQ - of_case.Case_Resolution_ratio: SAOHQ
      SINHQ - of_case.Case_Resolution_ratio: SINHQ
      Global - of_case.Case_Resolution_ratio: Global
      Unclaimed - of_case.Case_Resolution_ratio: Unclaimed
      Chat - of_case.Case_Resolution_ratio: Chat
      Email - of_case.Case_Resolution_ratio: Email
      Manual - of_case.Case_Resolution_ratio: Manual
      Web - of_case.Case_Resolution_ratio: Web
      Phone - of_case.Case_Resolution_ratio: Phone
      CCA - of_case.Case_Resolution_ratio: CCA
      CCS - of_case.Case_Resolution_ratio: CCS
      Others - of_case.Case_Resolution_ratio: Others
      Sales Executive - of_case.Case_Resolution_ratio: Sales Executive
      C-KAM - of_case.Case_Resolution_ratio: C-KAM
      C-KAS - of_case.Case_Resolution_ratio: C-KAS
      No KA Mapping - of_case.Case_Resolution_ratio: No KA Mapping
      ONECare Queue - of_case.Case_Resolution_ratio: ONECare Queue
      S-KAM - of_case.Case_Resolution_ratio: S-KAM
      S-KAS - of_case.Case_Resolution_ratio: S-KAS
      Onshore - of_case.Case_Resolution_ratio: Onshore
      Offshore - of_case.Case_Resolution_ratio: Offshore
      Complaint/Feedback - of_case.Case_Resolution_ratio: Complaint/Feedback
      Complex - of_case.Case_Resolution_ratio: Complex
      General Information - of_case.Case_Resolution_ratio: General Information
      Inquiry - of_case.Case_Resolution_ratio: Inquiry
      Internal - of_case.Case_Resolution_ratio: Internal
      Service Request - of_case.Case_Resolution_ratio: Service Request
      Service Failure - of_case.Case_Resolution_ratio: Service Failure
      Transactional - of_case.Case_Resolution_ratio: Transactional
      No Action Required - of_case.Case_Resolution_ratio: No Action Required
      Internal Request - of_case.Case_Resolution_ratio: Internal Request
      GKA - of_case.Case_Resolution_ratio: GKA
      LKA - of_case.Case_Resolution_ratio: LKA
      ONECare - of_case.Case_Resolution_ratio: ONECare
      RKA - of_case.Case_Resolution_ratio: RKA
      AE - of_case.Case_Resolution_ratio: AE
      AR - of_case.Case_Resolution_ratio: AR
      AT & HU - of_case.Case_Resolution_ratio: AT & HU
      AU - of_case.Case_Resolution_ratio: AU
      BD - of_case.Case_Resolution_ratio: BD
      BR - of_case.Case_Resolution_ratio: BR
      BE - of_case.Case_Resolution_ratio: BE
      CH - of_case.Case_Resolution_ratio: CH
      CL - of_case.Case_Resolution_ratio: CL
      CN - of_case.Case_Resolution_ratio: CN
      CO - of_case.Case_Resolution_ratio: CO
      DE - of_case.Case_Resolution_ratio: DE
      CZ & SK - of_case.Case_Resolution_ratio: CZ & SK
      EC - of_case.Case_Resolution_ratio: EC
      DK - of_case.Case_Resolution_ratio: DK
      EG - of_case.Case_Resolution_ratio: EG
      ES - of_case.Case_Resolution_ratio: ES
      LK - of_case.Case_Resolution_ratio: LK
      IT - of_case.Case_Resolution_ratio: IT
      FI - of_case.Case_Resolution_ratio: FI
      FR - of_case.Case_Resolution_ratio: FR
      GB - of_case.Case_Resolution_ratio: GB
      GH - of_case.Case_Resolution_ratio: GH
      HK & SCN - of_case.Case_Resolution_ratio: HK & SCN
      ID - of_case.Case_Resolution_ratio: ID
      IL - of_case.Case_Resolution_ratio: IL
      IN - of_case.Case_Resolution_ratio: IN
      JP - of_case.Case_Resolution_ratio: JP
      KR - of_case.Case_Resolution_ratio: KR
      MA - of_case.Case_Resolution_ratio: MA
      MM - of_case.Case_Resolution_ratio: MM
      MX - of_case.Case_Resolution_ratio: MX
      MY - of_case.Case_Resolution_ratio: MY
      TR - of_case.Case_Resolution_ratio: TR
      TW - of_case.Case_Resolution_ratio: TW
      TH - of_case.Case_Resolution_ratio: TH
      SE & NO - of_case.Case_Resolution_ratio: SE & NO
      NG - of_case.Case_Resolution_ratio: NG
      NL - of_case.Case_Resolution_ratio: NL
      NZ - of_case.Case_Resolution_ratio: NZ
      PA - of_case.Case_Resolution_ratio: PA
      PE - of_case.Case_Resolution_ratio: PE
      PH - of_case.Case_Resolution_ratio: PH
      PK - of_case.Case_Resolution_ratio: PK
      PL - of_case.Case_Resolution_ratio: PL
      PT - of_case.Case_Resolution_ratio: PT
      SG - of_case.Case_Resolution_ratio: SG
      US - of_case.Case_Resolution_ratio: US
      UY - of_case.Case_Resolution_ratio: UY
      ZA - of_case.Case_Resolution_ratio: ZA
      CA - of_case.Case_Resolution_ratio: CA
      CI - of_case.Case_Resolution_ratio: CI
      AT - of_case.Case_Resolution_ratio: AT
      CZ - of_case.Case_Resolution_ratio: CZ
      IE - of_case.Case_Resolution_ratio: IE
      SK - of_case.Case_Resolution_ratio: SK
      VN - of_case.Case_Resolution_ratio: VN
      NO - of_case.Case_Resolution_ratio: 'NO'
      AS - of_case.Case_Resolution_ratio: AS
      BG - of_case.Case_Resolution_ratio: BG
      CR - of_case.Case_Resolution_ratio: CR
      CY - of_case.Case_Resolution_ratio: CY
      DZ - of_case.Case_Resolution_ratio: DZ
      EE - of_case.Case_Resolution_ratio: EE
      FJ - of_case.Case_Resolution_ratio: FJ
      GE - of_case.Case_Resolution_ratio: GE
      GR - of_case.Case_Resolution_ratio: GR
      GT - of_case.Case_Resolution_ratio: GT
      HK - of_case.Case_Resolution_ratio: HK
      HN - of_case.Case_Resolution_ratio: HN
      HR - of_case.Case_Resolution_ratio: HR
      HU - of_case.Case_Resolution_ratio: HU
      KE - of_case.Case_Resolution_ratio: KE
      KH - of_case.Case_Resolution_ratio: KH
      KI - of_case.Case_Resolution_ratio: KI
      LB - of_case.Case_Resolution_ratio: LB
      LT - of_case.Case_Resolution_ratio: LT
      LS - of_case.Case_Resolution_ratio: LS
      LV - of_case.Case_Resolution_ratio: LV
      MO - of_case.Case_Resolution_ratio: MO
      MT - of_case.Case_Resolution_ratio: MT
      NI - of_case.Case_Resolution_ratio: NI
      PF - of_case.Case_Resolution_ratio: PF
      RO - of_case.Case_Resolution_ratio: RO
      SA - of_case.Case_Resolution_ratio: SA
      SB - of_case.Case_Resolution_ratio: SB
      SI - of_case.Case_Resolution_ratio: SI
      SN - of_case.Case_Resolution_ratio: SN
      SV - of_case.Case_Resolution_ratio: SV
      TG - of_case.Case_Resolution_ratio: TG
      TJ - of_case.Case_Resolution_ratio: TJ
      TN - of_case.Case_Resolution_ratio: TN
      TO - of_case.Case_Resolution_ratio: TO
      TT - of_case.Case_Resolution_ratio: TT
      UA - of_case.Case_Resolution_ratio: UA
      VU - of_case.Case_Resolution_ratio: VU
      WS - of_case.Case_Resolution_ratio: WS
      ZW - of_case.Case_Resolution_ratio: ZW
      ZZ - of_case.Case_Resolution_ratio: ZZ
      AARBB - of_case.Case_Resolution_ratio: AARBB
      ABJBB - of_case.Case_Resolution_ratio: ABJBB
      ADLBB - of_case.Case_Resolution_ratio: ADLBB
      AKLBB - of_case.Case_Resolution_ratio: AKLBB
      ALGBB - of_case.Case_Resolution_ratio: ALGBB
      ALJBA - of_case.Case_Resolution_ratio: ALJBA
      ALYBB - of_case.Case_Resolution_ratio: ALYBB
      AMDBB - of_case.Case_Resolution_ratio: AMDBB
      ANRBB - of_case.Case_Resolution_ratio: ANRBB
      APWBA - of_case.Case_Resolution_ratio: APWBA
      ASHBA - of_case.Case_Resolution_ratio: ASHBA
      ATLBB - of_case.Case_Resolution_ratio: ATLBB
      BASBB - of_case.Case_Resolution_ratio: BASBB
      BCNBB - of_case.Case_Resolution_ratio: BCNBB
      BDOBB - of_case.Case_Resolution_ratio: BDOBB
      BELBB - of_case.Case_Resolution_ratio: BELBB
      BEYBA - of_case.Case_Resolution_ratio: BEYBA
      BIOBB - of_case.Case_Resolution_ratio: BIOBB
      BKKBB - of_case.Case_Resolution_ratio: BKKBB
      BLRBB - of_case.Case_Resolution_ratio: BLRBB
      BNDBB - of_case.Case_Resolution_ratio: BNDBB
      BNEBB - of_case.Case_Resolution_ratio: BNEBB
      BOGBB - of_case.Case_Resolution_ratio: BOGBB
      BOIBB - of_case.Case_Resolution_ratio: BOIBB
      BOSBB - of_case.Case_Resolution_ratio: BOSBB
      BREBB - of_case.Case_Resolution_ratio: BREBB
      BTMBB - of_case.Case_Resolution_ratio: BTMBB
      BUDBB - of_case.Case_Resolution_ratio: BUDBB
      BUEBB - of_case.Case_Resolution_ratio: BUEBB
      CAIBB - of_case.Case_Resolution_ratio: CAIBB
      CANBB - of_case.Case_Resolution_ratio: CANBB
      CASBA - of_case.Case_Resolution_ratio: CASBA
      CCPBB - of_case.Case_Resolution_ratio: CCPBB
      CCUBB - of_case.Case_Resolution_ratio: CCUBB
      CEBBB - of_case.Case_Resolution_ratio: CEBBB
      CGOBB - of_case.Case_Resolution_ratio: CGOBB
      CGPBB - of_case.Case_Resolution_ratio: CGPBB
      CGYBB - of_case.Case_Resolution_ratio: CGYBB
      CHCBB - of_case.Case_Resolution_ratio: CHCBB
      CHIBB - of_case.Case_Resolution_ratio: CHIBB
      CKGBB - of_case.Case_Resolution_ratio: CKGBB
      CLLBB - of_case.Case_Resolution_ratio: CLLBB
      CMBBB - of_case.Case_Resolution_ratio: CMBBB
      CNDBA - of_case.Case_Resolution_ratio: CNDBA
      COKBB - of_case.Case_Resolution_ratio: COKBB
      CPTBB - of_case.Case_Resolution_ratio: CPTBB
      CTUBB - of_case.Case_Resolution_ratio: CTUBB
      CWBBB - of_case.Case_Resolution_ratio: CWBBB
      DACBB - of_case.Case_Resolution_ratio: DACBB
      DADBB - of_case.Case_Resolution_ratio: DADBB
      DAMBB - of_case.Case_Resolution_ratio: DAMBB
      DARBA - of_case.Case_Resolution_ratio: DARBA
      DELBB - of_case.Case_Resolution_ratio: DELBB
      DKRBA - of_case.Case_Resolution_ratio: DKRBA
      DLCBB - of_case.Case_Resolution_ratio: DLCBB
      DMNBA - of_case.Case_Resolution_ratio: DMNBA
      DPSBB - of_case.Case_Resolution_ratio: DPSBB
      DUBBA - of_case.Case_Resolution_ratio: DUBBA
      DURBB - of_case.Case_Resolution_ratio: DURBB
      DUSBB - of_case.Case_Resolution_ratio: DUSBB
      DVOBB - of_case.Case_Resolution_ratio: DVOBB
      DXBBB - of_case.Case_Resolution_ratio: DXBBB
      EDKBB - of_case.Case_Resolution_ratio: EDKBB
      ELSBB - of_case.Case_Resolution_ratio: ELSBB
      FOCBB - of_case.Case_Resolution_ratio: FOCBB
      FREBB - of_case.Case_Resolution_ratio: FREBB
      GDLBB - of_case.Case_Resolution_ratio: GDLBB
      GDNBB - of_case.Case_Resolution_ratio: GDNBB
      GDYBB - of_case.Case_Resolution_ratio: GDYBB
      GESBB - of_case.Case_Resolution_ratio: GESBB
      GINBB - of_case.Case_Resolution_ratio: GINBB
      GOABB - of_case.Case_Resolution_ratio: GOABB
      GOTBB - of_case.Case_Resolution_ratio: GOTBB
      GUABA - of_case.Case_Resolution_ratio: GUABA
      GYEBB - of_case.Case_Resolution_ratio: GYEBB
      HALBB - of_case.Case_Resolution_ratio: HALBB
      HAMBB - of_case.Case_Resolution_ratio: HAMBB
      HANBB - of_case.Case_Resolution_ratio: HANBB
      HELBB - of_case.Case_Resolution_ratio: HELBB
      HFABA - of_case.Case_Resolution_ratio: HFABA
      HFEBB - of_case.Case_Resolution_ratio: HFEBB
      HGHBB - of_case.Case_Resolution_ratio: HGHBB
      HIRBA - of_case.Case_Resolution_ratio: HIRBA
      HKGBB - of_case.Case_Resolution_ratio: HKGBB
      HKTBA - of_case.Case_Resolution_ratio: HKTBA
      HOUBB - of_case.Case_Resolution_ratio: HOUBB
      HPHBB - of_case.Case_Resolution_ratio: HPHBB
      HREBA - of_case.Case_Resolution_ratio: HREBA
      HYDBB - of_case.Case_Resolution_ratio: HYDBB
      ICDBB - of_case.Case_Resolution_ratio: ICDBB
      IPSBB - of_case.Case_Resolution_ratio: IPSBB
      IQQBB - of_case.Case_Resolution_ratio: IQQBB
      ISTBA - of_case.Case_Resolution_ratio: ISTBA
      ISTBB - of_case.Case_Resolution_ratio: ISTBB
      ITJBB - of_case.Case_Resolution_ratio: ITJBB
      IZMBA - of_case.Case_Resolution_ratio: IZMBA
      IZMBB - of_case.Case_Resolution_ratio: IZMBB
      JEDBA - of_case.Case_Resolution_ratio: JEDBA
      JHBBB - of_case.Case_Resolution_ratio: JHBBB
      JKTBB - of_case.Case_Resolution_ratio: JKTBB
      JMNBB - of_case.Case_Resolution_ratio: JMNBB
      JNBBB - of_case.Case_Resolution_ratio: JNBBB
      KHHBB - of_case.Case_Resolution_ratio: KHHBB
      KHIBB - of_case.Case_Resolution_ratio: KHIBB
      KHLBB - of_case.Case_Resolution_ratio: KHLBB
      KLPBA - of_case.Case_Resolution_ratio: KLPBA
      KOPBA - of_case.Case_Resolution_ratio: KOPBA
      LAXBB - of_case.Case_Resolution_ratio: LAXBB
      LCBBB - of_case.Case_Resolution_ratio: LCBBB
      LEHBB - of_case.Case_Resolution_ratio: LEHBB
      LEXBB - of_case.Case_Resolution_ratio: LEXBB
      LFWBA - of_case.Case_Resolution_ratio: LFWBA
      LHEBB - of_case.Case_Resolution_ratio: LHEBB
      LIMBB - of_case.Case_Resolution_ratio: LIMBB
      LISBB - of_case.Case_Resolution_ratio: LISBB
      LIVBB - of_case.Case_Resolution_ratio: LIVBB
      LMSBA - of_case.Case_Resolution_ratio: LMSBA
      LONBB - of_case.Case_Resolution_ratio: LONBB
      LOSBB - of_case.Case_Resolution_ratio: LOSBB
      LUHBB - of_case.Case_Resolution_ratio: LUHBB
      LYGBB - of_case.Case_Resolution_ratio: LYGBB
      MAABB - of_case.Case_Resolution_ratio: MAABB
      MACBB - of_case.Case_Resolution_ratio: MACBB
      MADBB - of_case.Case_Resolution_ratio: MADBB
      MAOBB - of_case.Case_Resolution_ratio: MAOBB
      MBABA - of_case.Case_Resolution_ratio: MBABA
      MECBA - of_case.Case_Resolution_ratio: MECBA
      MELBB - of_case.Case_Resolution_ratio: MELBB
      MERBA - of_case.Case_Resolution_ratio: MERBA
      MERBB - of_case.Case_Resolution_ratio: MERBB
      MESBB - of_case.Case_Resolution_ratio: MESBB
      MEXBB - of_case.Case_Resolution_ratio: MEXBB
      MIBOS - of_case.Case_Resolution_ratio: MIBOS
      MIHOS - of_case.Case_Resolution_ratio: MIHOS
      MITBB - of_case.Case_Resolution_ratio: MITBB
      MNGBA - of_case.Case_Resolution_ratio: MNGBA
      MNLBB - of_case.Case_Resolution_ratio: MNLBB
      MOWBB - of_case.Case_Resolution_ratio: MOWBB
      MRSBB - of_case.Case_Resolution_ratio: MRSBB
      MSUBA - of_case.Case_Resolution_ratio: MSUBA
      MTABA - of_case.Case_Resolution_ratio: MTABA
      MTYBB - of_case.Case_Resolution_ratio: MTYBB
      MUMBB - of_case.Case_Resolution_ratio: MUMBB
      MVDBB - of_case.Case_Resolution_ratio: MVDBB
      NBOBB - of_case.Case_Resolution_ratio: NBOBB
      NGOBB - of_case.Case_Resolution_ratio: NGOBB
      NKGBB - of_case.Case_Resolution_ratio: NKGBB
      NSABB - of_case.Case_Resolution_ratio: NSABB
      NVSBA - of_case.Case_Resolution_ratio: NVSBA
      NYCBB - of_case.Case_Resolution_ratio: NYCBB
      ODSBA - of_case.Case_Resolution_ratio: ODSBA
      OPOBB - of_case.Case_Resolution_ratio: OPOBB
      OSABB - of_case.Case_Resolution_ratio: OSABB
      PAIBB - of_case.Case_Resolution_ratio: PAIBB
      PANBA - of_case.Case_Resolution_ratio: PANBA
      PANBB - of_case.Case_Resolution_ratio: PANBB
      PAVBB - of_case.Case_Resolution_ratio: PAVBB
      PENBB - of_case.Case_Resolution_ratio: PENBB
      PIRAEU - of_case.Case_Resolution_ratio: PIRAE
      PKGBB - of_case.Case_Resolution_ratio: PKGBB
      PLMBB - of_case.Case_Resolution_ratio: PLMBB
      PLZBB - of_case.Case_Resolution_ratio: PLZBB
      PNHBA - of_case.Case_Resolution_ratio: PNHBA
      PNQBB - of_case.Case_Resolution_ratio: PNQBB
      PPGBA - of_case.Case_Resolution_ratio: PPGBA
      PPTBA - of_case.Case_Resolution_ratio: PPTBA
      PRGBB - of_case.Case_Resolution_ratio: PRGBB
      PSDBB - of_case.Case_Resolution_ratio: PSDBB
      PTIBA - of_case.Case_Resolution_ratio: PTIBA
      PTSBA - of_case.Case_Resolution_ratio: PTSBA
      PUSBB - of_case.Case_Resolution_ratio: PUSBB
      QITBA - of_case.Case_Resolution_ratio: QITBA
      RHUBA - of_case.Case_Resolution_ratio: RHUBA
      RICBB - of_case.Case_Resolution_ratio: RICBB
      RIXBA - of_case.Case_Resolution_ratio: RIXBA
      RJKBA - of_case.Case_Resolution_ratio: RJKBA
      RTMBB - of_case.Case_Resolution_ratio: RTMBB
      SALBA - of_case.Case_Resolution_ratio: SALBA
      SAOBB - of_case.Case_Resolution_ratio: SAOBB
      SCLBB - of_case.Case_Resolution_ratio: SCLBB
      SEABB - of_case.Case_Resolution_ratio: SEABB
      SELBB - of_case.Case_Resolution_ratio: SELBB
      SFOBB - of_case.Case_Resolution_ratio: SFOBB
      SFSBB - of_case.Case_Resolution_ratio: SFSBB
      SGNBB - of_case.Case_Resolution_ratio: SGNBB
      SGZBB - of_case.Case_Resolution_ratio: SGZBB
      SHABB - of_case.Case_Resolution_ratio: SHABB
      SIABB - of_case.Case_Resolution_ratio: SIABB
      SINBB - of_case.Case_Resolution_ratio: SINBB
      SINHO - of_case.Case_Resolution_ratio: SINHO
      SJOBA - of_case.Case_Resolution_ratio: SJOBA
      SJWBB - of_case.Case_Resolution_ratio: SJWBB
      SKGBA - of_case.Case_Resolution_ratio: SKGBA
      SMZBA - of_case.Case_Resolution_ratio: SMZBA
      SOUBB - of_case.Case_Resolution_ratio: SOUBB
      SPBBB - of_case.Case_Resolution_ratio: SPBBB
      SPROS - of_case.Case_Resolution_ratio: SPROS
      SRGBB - of_case.Case_Resolution_ratio: SRGBB
      SSZBB - of_case.Case_Resolution_ratio: SSZBB
      STRBB - of_case.Case_Resolution_ratio: STRBB
      SUBBB - of_case.Case_Resolution_ratio: SUBBB
      SUDBB - of_case.Case_Resolution_ratio: SUDBB
      SUVBA - of_case.Case_Resolution_ratio: SUVBA
      SUZBB - of_case.Case_Resolution_ratio: SUZBB
      SYDBB - of_case.Case_Resolution_ratio: SYDBB
      SZHBB - of_case.Case_Resolution_ratio: SZHBB
      SZPBB - of_case.Case_Resolution_ratio: SZPBB
      TAOBB - of_case.Case_Resolution_ratio: TAOBB
      TBUBA - of_case.Case_Resolution_ratio: TBUBA
      TEMBB - of_case.Case_Resolution_ratio: TEMBB
      TGCBA - of_case.Case_Resolution_ratio: TGCBA
      TLLBA - of_case.Case_Resolution_ratio: TLLBA
      TLVBA - of_case.Case_Resolution_ratio: TLVBA
      TORBB - of_case.Case_Resolution_ratio: TORBB
      TPEBB - of_case.Case_Resolution_ratio: TPEBB
      TPPBB - of_case.Case_Resolution_ratio: TPPBB
      TRWBA - of_case.Case_Resolution_ratio: TRWBA
      TSNBB - of_case.Case_Resolution_ratio: TSNBB
      TUNBA - of_case.Case_Resolution_ratio: TUNBA
      TUTBB - of_case.Case_Resolution_ratio: TUTBB
      TXGBB - of_case.Case_Resolution_ratio: TXGBB
      TYOBB - of_case.Case_Resolution_ratio: TYOBB
      VANBB - of_case.Case_Resolution_ratio: VANBB
      VAPBB - of_case.Case_Resolution_ratio: VAPBB
      VARBA - of_case.Case_Resolution_ratio: VARBA
      VGOBB - of_case.Case_Resolution_ratio: VGOBB
      VLCBB - of_case.Case_Resolution_ratio: VLCBB
      VLIBA - of_case.Case_Resolution_ratio: VLIBA
      VNABB - of_case.Case_Resolution_ratio: VNABB
      VTZBB - of_case.Case_Resolution_ratio: VTZBB
      VVABB - of_case.Case_Resolution_ratio: VVABB
      WGZOS - of_case.Case_Resolution_ratio: WGZOS
      WMLOS - of_case.Case_Resolution_ratio: WMLOS
      WNKOS - of_case.Case_Resolution_ratio: WNKOS
      WUHBB - of_case.Case_Resolution_ratio: WUHBB
      XMNBB - of_case.Case_Resolution_ratio: XMNBB
      YGNBB - of_case.Case_Resolution_ratio: YGNBB
      ZHOBB - of_case.Case_Resolution_ratio: ZHOBB
      ZHUBB - of_case.Case_Resolution_ratio: ZHUBB
      ZLOBB - of_case.Case_Resolution_ratio: ZLOBB
      of_case.Case_Geo___null - of_case.Case_Resolution_ratio: "∅"
    show_null_points: true
    interpolation: monotone
    hidden_fields: []
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: "<P style=\"text-align:left;\"><B>Metric Name : </B>Case Resolution\
      \ Ratio<BR><B>How it Helps : </B>To analyze the trend and pattern of how well\
      \ our agents can eventually resolve or close the case in a timely manner\n<BR>[Case\
      \ Status = \"Resolved\" & \"Closed\" vs all other Status]\t\t\t\t\t\t\t\t\t\t\
      \t\t\t\t\t\t\t\t\t\n"
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 68
    col: 0
    width: 22
    height: 8
  - title: 'Resolution Ratio '
    name: 'Resolution Ratio '
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.Case_Resolution_ratio, previous_resolution_ratio]
    limit: 500
    dynamic_fields: [{category: measure, expression: 'trunc_months (${of_case.filter_start}
          ) = trunc_months ( ${of_case.createddate_date})', label: Previous Resolution
          Ratio, value_format: !!null '', value_format_name: !!null '', based_on: of_case.Case_Resolution_ratio,
        filter_expression: 'trunc_months (${of_case.filter_start} ) = trunc_months
          ( ${of_case.createddate_date})', _kind_hint: measure, measure: previous_resolution_ratio,
        type: average, _type_hint: number, filters: {}}]
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: '16'
    orientation: auto
    style_of_case.Case_Resolution_ratio: "#7f0b4d"
    show_title_of_case.Case_Resolution_ratio: false
    title_placement_of_case.Case_Resolution_ratio: above
    value_format_of_case.Case_Resolution_ratio: ''
    show_comparison_previous_resolution_ratio: true
    comparison_style_previous_resolution_ratio: percentage_change
    comparison_show_label_previous_resolution_ratio: true
    pos_is_bad_previous_resolution_ratio: false
    comparison_label_previous_resolution_ratio: vs Prev
    comparison_label_placement_previous_resolution_ratio: below
    comp_value_format_previous_resolution_ratio: ''
    style_current_resolution_ratio: "#7f0b4d"
    show_title_current_resolution_ratio: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
    custom_color: "#BD0F72"
    conditional_formatting: [{type: greater than, value: 0, background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: 6c27c30e-5523-4080-82ae-272146e699d0,
          palette_id: dcfbcfd3-50be-453f-badd-e340864c3b1a}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    showComparison: false
    minValue: 0
    maxValue: 1
    circleThickness: 0.05
    circleFillGap: 0.05
    circleColor: "#555555"
    waveHeight: 0.1
    waveCount: 4
    waveRiseTime: 2450
    waveAnimateTime: 2051
    waveRise: true
    waveHeightScaling: true
    waveAnimate: true
    waveColor: "#7f0b4d"
    waveOffset: 0
    textVertPosition: 0.5
    textSize: 0.89
    valueCountUp: true
    displayPercent: false
    textColor: "#000000"
    waveTextColor: "#FFFFFF"
    x_axis_gridlines: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: Chat - case_resolution_ratio,
            id: Chat - case_resolution_ratio, name: Chat}, {axisId: Email - case_resolution_ratio,
            id: Email - case_resolution_ratio, name: Email}, {axisId: Internal - case_resolution_ratio,
            id: Internal - case_resolution_ratio, name: Internal}, {axisId: Phone
              - case_resolution_ratio, id: Phone - case_resolution_ratio, name: Phone},
          {axisId: Web - case_resolution_ratio, id: Web - case_resolution_ratio, name: Web}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_colors:
      Email - case_resolution_ratio: "#8b908f"
      Phone - case_resolution_ratio: "#84C5C3"
      Web - case_resolution_ratio: "#00506D"
    defaults_version: 0
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 1
    col: 9
    width: 3
    height: 4
  - title: Abandoned Chat Ratio
    name: Abandoned Chat Ratio
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.createddate_dynamic, of_case.case_distinct_count, of_case.Abandoned_ratio,
      of_case.Case_Geo, of_case.target_for_chat]
    pivots: [of_case.Case_Geo]
    filters:
      of_case.active_case: 'No'
      chat_cases: 'Yes'
    sorts: [of_case.createddate_dynamic, of_case.Case_Geo]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields: [{category: dimension, expression: 'case (when(${of_case.origin}="Chat",
          "Yes"), "No")', label: Chat Cases, value_format: !!null '', value_format_name: !!null '',
        dimension: chat_cases, _kind_hint: dimension, _type_hint: string}, {category: measure,
        expression: !!null '', label: Abandoned Chat, value_format: !!null '', value_format_name: !!null '',
        based_on: of_case.case_distinct_count, _kind_hint: measure, measure: abandoned_chat,
        type: count_distinct, _type_hint: number, filters: {of_case.resolution_reason: Customer
            Abandoned Chat}}, {category: table_calculation, expression: "${abandoned_chat}/${of_case.case_distinct_count}",
        label: Abandoned Ratio, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: abandoned_ratio, _type_hint: number,
        is_disabled: true}, {category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_chat})),-10))

          ', label: Global Target (Chat), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target_chat, _type_hint: number}]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.Abandoned_ratio,
            id: Global - of_case.Abandoned_ratio, name: Global - Case Abandoned Ratio},
          {axisId: of_case.Abandoned_ratio, id: Row Total - of_case.Abandoned_ratio,
            name: Total}, {axisId: global_target, id: global_target, name: Global
              Target}, {axisId: hkghq_target, id: hkghq_target, name: HKGHQ Target},
          {axisId: lonhq_target, id: lonhq_target, name: LONHQ Target}, {axisId: richq_target,
            id: richq_target, name: RICHQ Target}, {axisId: saohq_target, id: saohq_target,
            name: SAOHQ Target}, {axisId: sinhq_target, id: sinhq_target, name: SINHQ
              Target}], showLabels: false, showValues: false, minValue: 0, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      Row Total - of_case.Abandoned_ratio: line
      global_target: line
      hkghq_target: line
      lonhq_target: line
      richq_target: line
      saohq_target: line
      sinhq_target: line
      global: line
      Row Total - of_case.dynamic_reference: line
      global_target_chat: line
      global_target_web: line
    series_colors:
      Row Total - of_case.Abandoned_ratio: "#F39200"
      HKGHQ - of_case.Abandoned_ratio: "#db72af"
      LONHQ - of_case.Abandoned_ratio: "#00506D"
      RICHQ - of_case.Abandoned_ratio: "#84C5C3"
      SAOHQ - of_case.Abandoned_ratio: "#BD0F72"
      SINHQ - of_case.Abandoned_ratio: "#8b908f"
      global: "#340335"
      global_target_chat: "#70AD47"
      global_target_web: "#00B050"
    series_labels:
      Row Total - of_case.Abandoned_ratio: Total
      1 - of_case.Abandoned_ratio: GKA
      2 - of_case.Abandoned_ratio: RKA
      3 - of_case.Abandoned_ratio: LKA
      4 - of_case.Abandoned_ratio: ONECare
      Global - of_case.Abandoned_ratio: Global
      HKGHQ - of_case.Abandoned_ratio: HKGHQ
      LONHQ - of_case.Abandoned_ratio: LONHQ
      RICHQ - of_case.Abandoned_ratio: RICHQ
      SAOHQ - of_case.Abandoned_ratio: SAOHQ
      SINHQ - of_case.Abandoned_ratio: SINHQ
      global: FY 23 Global Target
      Row Total - of_case.dynamic_reference: Target
      Unclaimed - of_case.Abandoned_ratio: Unclaimed
      global_target_chat: FY2023 Global Uniform Target
      Chat - of_case.Abandoned_ratio: Chat
      Email - of_case.Abandoned_ratio: Email
      Manual - of_case.Abandoned_ratio: Manual
      Web - of_case.Abandoned_ratio: Web
      Phone - of_case.Abandoned_ratio: Phone
      CCA - of_case.Abandoned_ratio: CCA
      CCS - of_case.Abandoned_ratio: CCS
      Others - of_case.Abandoned_ratio: Others
      Sales Executive - of_case.Abandoned_ratio: Sales Executive
      C-KAM - of_case.Abandoned_ratio: C-KAM
      C-KAS - of_case.Abandoned_ratio: C-KAS
      No KA Mapping - of_case.Abandoned_ratio: No KA Mapping
      ONECare Queue - of_case.Abandoned_ratio: ONECare Queue
      S-KAM - of_case.Abandoned_ratio: S-KAM
      S-KAS - of_case.Abandoned_ratio: S-KAS
      Onshore - of_case.Abandoned_ratio: Onshore
      Offshore - of_case.Abandoned_ratio: Offshore
      Complaint/Feedback - of_case.Abandoned_ratio: Complaint/Feedback
      Complex - of_case.Abandoned_ratio: Complex
      General Information - of_case.Abandoned_ratio: General Information
      Inquiry - of_case.Abandoned_ratio: Inquiry
      Internal - of_case.Abandoned_ratio: Internal
      Service Request - of_case.Abandoned_ratio: Service Request
      Service Failure - of_case.Abandoned_ratio: Service Failure
      Transactional - of_case.Abandoned_ratio: Transactional
      No Action Required - of_case.Abandoned_ratio: No Action Required
      Internal Request - of_case.Abandoned_ratio: Internal Request
      GKA - of_case.Abandoned_ratio: GKA
      LKA - of_case.Abandoned_ratio: LKA
      ONECare - of_case.Abandoned_ratio: ONECare
      RKA - of_case.Abandoned_ratio: RKA
      AE - of_case.Abandoned_ratio: AE
      AR - of_case.Abandoned_ratio: AR
      AT & HU - of_case.Abandoned_ratio: AT & HU
      AU - of_case.Abandoned_ratio: AU
      BD - of_case.Abandoned_ratio: BD
      BR - of_case.Abandoned_ratio: BR
      BE - of_case.Abandoned_ratio: BE
      CH - of_case.Abandoned_ratio: CH
      CL - of_case.Abandoned_ratio: CL
      CN - of_case.Abandoned_ratio: CN
      CO - of_case.Abandoned_ratio: CO
      DE - of_case.Abandoned_ratio: DE
      CZ & SK - of_case.Abandoned_ratio: CZ & SK
      EC - of_case.Abandoned_ratio: EC
      DK - of_case.Abandoned_ratio: DK
      EG - of_case.Abandoned_ratio: EG
      ES - of_case.Abandoned_ratio: ES
      LK - of_case.Abandoned_ratio: LK
      IT - of_case.Abandoned_ratio: IT
      FI - of_case.Abandoned_ratio: FI
      FR - of_case.Abandoned_ratio: FR
      GB - of_case.Abandoned_ratio: GB
      GH - of_case.Abandoned_ratio: GH
      HK & SCN - of_case.Abandoned_ratio: HK & SCN
      ID - of_case.Abandoned_ratio: ID
      IL - of_case.Abandoned_ratio: IL
      IN - of_case.Abandoned_ratio: IN
      JP - of_case.Abandoned_ratio: JP
      KR - of_case.Abandoned_ratio: KR
      MA - of_case.Abandoned_ratio: MA
      MM - of_case.Abandoned_ratio: MM
      MX - of_case.Abandoned_ratio: MX
      MY - of_case.Abandoned_ratio: MY
      TR - of_case.Abandoned_ratio: TR
      TW - of_case.Abandoned_ratio: TW
      TH - of_case.Abandoned_ratio: TH
      SE & NO - of_case.Abandoned_ratio: SE & NO
      NG - of_case.Abandoned_ratio: NG
      NL - of_case.Abandoned_ratio: NL
      NZ - of_case.Abandoned_ratio: NZ
      PA - of_case.Abandoned_ratio: PA
      PE - of_case.Abandoned_ratio: PE
      PH - of_case.Abandoned_ratio: PH
      PK - of_case.Abandoned_ratio: PK
      PL - of_case.Abandoned_ratio: PL
      PT - of_case.Abandoned_ratio: PT
      SG - of_case.Abandoned_ratio: SG
      US - of_case.Abandoned_ratio: US
      UY - of_case.Abandoned_ratio: UY
      ZA - of_case.Abandoned_ratio: ZA
      CA - of_case.Abandoned_ratio: CA
      CI - of_case.Abandoned_ratio: CI
      AT - of_case.Abandoned_ratio: AT
      CZ - of_case.Abandoned_ratio: CZ
      IE - of_case.Abandoned_ratio: IE
      SK - of_case.Abandoned_ratio: SK
      VN - of_case.Abandoned_ratio: VN
      NO - of_case.Abandoned_ratio: 'NO'
      AS - of_case.Abandoned_ratio: AS
      BG - of_case.Abandoned_ratio: BG
      CR - of_case.Abandoned_ratio: CR
      CY - of_case.Abandoned_ratio: CY
      DZ - of_case.Abandoned_ratio: DZ
      EE - of_case.Abandoned_ratio: EE
      FJ - of_case.Abandoned_ratio: FJ
      GE - of_case.Abandoned_ratio: GE
      GR - of_case.Abandoned_ratio: GR
      GT - of_case.Abandoned_ratio: GT
      HK - of_case.Abandoned_ratio: HK
      HN - of_case.Abandoned_ratio: HN
      HR - of_case.Abandoned_ratio: HR
      HU - of_case.Abandoned_ratio: HU
      KE - of_case.Abandoned_ratio: KE
      KH - of_case.Abandoned_ratio: KH
      KI - of_case.Abandoned_ratio: KI
      LB - of_case.Abandoned_ratio: LB
      LT - of_case.Abandoned_ratio: LT
      LS - of_case.Abandoned_ratio: LS
      LV - of_case.Abandoned_ratio: LV
      MO - of_case.Abandoned_ratio: MO
      MT - of_case.Abandoned_ratio: MT
      NI - of_case.Abandoned_ratio: NI
      PF - of_case.Abandoned_ratio: PF
      RO - of_case.Abandoned_ratio: RO
      SA - of_case.Abandoned_ratio: SA
      SB - of_case.Abandoned_ratio: SB
      SI - of_case.Abandoned_ratio: SI
      SN - of_case.Abandoned_ratio: SN
      SV - of_case.Abandoned_ratio: SV
      TG - of_case.Abandoned_ratio: TG
      TJ - of_case.Abandoned_ratio: TJ
      TN - of_case.Abandoned_ratio: TN
      TO - of_case.Abandoned_ratio: TO
      TT - of_case.Abandoned_ratio: TT
      UA - of_case.Abandoned_ratio: UA
      VU - of_case.Abandoned_ratio: VU
      WS - of_case.Abandoned_ratio: WS
      ZW - of_case.Abandoned_ratio: ZW
      ZZ - of_case.Abandoned_ratio: ZZ
      AARBB - of_case.Abandoned_ratio: AARBB
      ABJBB - of_case.Abandoned_ratio: ABJBB
      ADLBB - of_case.Abandoned_ratio: ADLBB
      AKLBB - of_case.Abandoned_ratio: AKLBB
      ALGBB - of_case.Abandoned_ratio: ALGBB
      ALJBA - of_case.Abandoned_ratio: ALJBA
      ALYBB - of_case.Abandoned_ratio: ALYBB
      AMDBB - of_case.Abandoned_ratio: AMDBB
      ANRBB - of_case.Abandoned_ratio: ANRBB
      APWBA - of_case.Abandoned_ratio: APWBA
      ASHBA - of_case.Abandoned_ratio: ASHBA
      ATLBB - of_case.Abandoned_ratio: ATLBB
      BASBB - of_case.Abandoned_ratio: BASBB
      BCNBB - of_case.Abandoned_ratio: BCNBB
      BDOBB - of_case.Abandoned_ratio: BDOBB
      BELBB - of_case.Abandoned_ratio: BELBB
      BEYBA - of_case.Abandoned_ratio: BEYBA
      BIOBB - of_case.Abandoned_ratio: BIOBB
      BKKBB - of_case.Abandoned_ratio: BKKBB
      BLRBB - of_case.Abandoned_ratio: BLRBB
      BNDBB - of_case.Abandoned_ratio: BNDBB
      BNEBB - of_case.Abandoned_ratio: BNEBB
      BOGBB - of_case.Abandoned_ratio: BOGBB
      BOIBB - of_case.Abandoned_ratio: BOIBB
      BOSBB - of_case.Abandoned_ratio: BOSBB
      BREBB - of_case.Abandoned_ratio: BREBB
      BTMBB - of_case.Abandoned_ratio: BTMBB
      BUDBB - of_case.Abandoned_ratio: BUDBB
      BUEBB - of_case.Abandoned_ratio: BUEBB
      CAIBB - of_case.Abandoned_ratio: CAIBB
      CANBB - of_case.Abandoned_ratio: CANBB
      CASBA - of_case.Abandoned_ratio: CASBA
      CCPBB - of_case.Abandoned_ratio: CCPBB
      CCUBB - of_case.Abandoned_ratio: CCUBB
      CEBBB - of_case.Abandoned_ratio: CEBBB
      CGOBB - of_case.Abandoned_ratio: CGOBB
      CGPBB - of_case.Abandoned_ratio: CGPBB
      CGYBB - of_case.Abandoned_ratio: CGYBB
      CHCBB - of_case.Abandoned_ratio: CHCBB
      CHIBB - of_case.Abandoned_ratio: CHIBB
      CKGBB - of_case.Abandoned_ratio: CKGBB
      CLLBB - of_case.Abandoned_ratio: CLLBB
      CMBBB - of_case.Abandoned_ratio: CMBBB
      CNDBA - of_case.Abandoned_ratio: CNDBA
      COKBB - of_case.Abandoned_ratio: COKBB
      CPTBB - of_case.Abandoned_ratio: CPTBB
      CTUBB - of_case.Abandoned_ratio: CTUBB
      CWBBB - of_case.Abandoned_ratio: CWBBB
      DACBB - of_case.Abandoned_ratio: DACBB
      DADBB - of_case.Abandoned_ratio: DADBB
      DAMBB - of_case.Abandoned_ratio: DAMBB
      DARBA - of_case.Abandoned_ratio: DARBA
      DELBB - of_case.Abandoned_ratio: DELBB
      DKRBA - of_case.Abandoned_ratio: DKRBA
      DLCBB - of_case.Abandoned_ratio: DLCBB
      DMNBA - of_case.Abandoned_ratio: DMNBA
      DPSBB - of_case.Abandoned_ratio: DPSBB
      DUBBA - of_case.Abandoned_ratio: DUBBA
      DURBB - of_case.Abandoned_ratio: DURBB
      DUSBB - of_case.Abandoned_ratio: DUSBB
      DVOBB - of_case.Abandoned_ratio: DVOBB
      DXBBB - of_case.Abandoned_ratio: DXBBB
      EDKBB - of_case.Abandoned_ratio: EDKBB
      ELSBB - of_case.Abandoned_ratio: ELSBB
      FOCBB - of_case.Abandoned_ratio: FOCBB
      FREBB - of_case.Abandoned_ratio: FREBB
      GDLBB - of_case.Abandoned_ratio: GDLBB
      GDNBB - of_case.Abandoned_ratio: GDNBB
      GDYBB - of_case.Abandoned_ratio: GDYBB
      GESBB - of_case.Abandoned_ratio: GESBB
      GINBB - of_case.Abandoned_ratio: GINBB
      GOABB - of_case.Abandoned_ratio: GOABB
      GOTBB - of_case.Abandoned_ratio: GOTBB
      GUABA - of_case.Abandoned_ratio: GUABA
      GYEBB - of_case.Abandoned_ratio: GYEBB
      HALBB - of_case.Abandoned_ratio: HALBB
      HAMBB - of_case.Abandoned_ratio: HAMBB
      HANBB - of_case.Abandoned_ratio: HANBB
      HELBB - of_case.Abandoned_ratio: HELBB
      HFABA - of_case.Abandoned_ratio: HFABA
      HFEBB - of_case.Abandoned_ratio: HFEBB
      HGHBB - of_case.Abandoned_ratio: HGHBB
      HIRBA - of_case.Abandoned_ratio: HIRBA
      HKGBB - of_case.Abandoned_ratio: HKGBB
      HKTBA - of_case.Abandoned_ratio: HKTBA
      HOUBB - of_case.Abandoned_ratio: HOUBB
      HPHBB - of_case.Abandoned_ratio: HPHBB
      HREBA - of_case.Abandoned_ratio: HREBA
      HYDBB - of_case.Abandoned_ratio: HYDBB
      ICDBB - of_case.Abandoned_ratio: ICDBB
      IPSBB - of_case.Abandoned_ratio: IPSBB
      IQQBB - of_case.Abandoned_ratio: IQQBB
      ISTBA - of_case.Abandoned_ratio: ISTBA
      ISTBB - of_case.Abandoned_ratio: ISTBB
      ITJBB - of_case.Abandoned_ratio: ITJBB
      IZMBA - of_case.Abandoned_ratio: IZMBA
      IZMBB - of_case.Abandoned_ratio: IZMBB
      JEDBA - of_case.Abandoned_ratio: JEDBA
      JHBBB - of_case.Abandoned_ratio: JHBBB
      JKTBB - of_case.Abandoned_ratio: JKTBB
      JMNBB - of_case.Abandoned_ratio: JMNBB
      JNBBB - of_case.Abandoned_ratio: JNBBB
      KHHBB - of_case.Abandoned_ratio: KHHBB
      KHIBB - of_case.Abandoned_ratio: KHIBB
      KHLBB - of_case.Abandoned_ratio: KHLBB
      KLPBA - of_case.Abandoned_ratio: KLPBA
      KOPBA - of_case.Abandoned_ratio: KOPBA
      LAXBB - of_case.Abandoned_ratio: LAXBB
      LCBBB - of_case.Abandoned_ratio: LCBBB
      LEHBB - of_case.Abandoned_ratio: LEHBB
      LEXBB - of_case.Abandoned_ratio: LEXBB
      LFWBA - of_case.Abandoned_ratio: LFWBA
      LHEBB - of_case.Abandoned_ratio: LHEBB
      LIMBB - of_case.Abandoned_ratio: LIMBB
      LISBB - of_case.Abandoned_ratio: LISBB
      LIVBB - of_case.Abandoned_ratio: LIVBB
      LMSBA - of_case.Abandoned_ratio: LMSBA
      LONBB - of_case.Abandoned_ratio: LONBB
      LOSBB - of_case.Abandoned_ratio: LOSBB
      LUHBB - of_case.Abandoned_ratio: LUHBB
      LYGBB - of_case.Abandoned_ratio: LYGBB
      MAABB - of_case.Abandoned_ratio: MAABB
      MACBB - of_case.Abandoned_ratio: MACBB
      MADBB - of_case.Abandoned_ratio: MADBB
      MAOBB - of_case.Abandoned_ratio: MAOBB
      MBABA - of_case.Abandoned_ratio: MBABA
      MECBA - of_case.Abandoned_ratio: MECBA
      MELBB - of_case.Abandoned_ratio: MELBB
      MERBA - of_case.Abandoned_ratio: MERBA
      MERBB - of_case.Abandoned_ratio: MERBB
      MESBB - of_case.Abandoned_ratio: MESBB
      MEXBB - of_case.Abandoned_ratio: MEXBB
      MIBOS - of_case.Abandoned_ratio: MIBOS
      MIHOS - of_case.Abandoned_ratio: MIHOS
      MITBB - of_case.Abandoned_ratio: MITBB
      MNGBA - of_case.Abandoned_ratio: MNGBA
      MNLBB - of_case.Abandoned_ratio: MNLBB
      MOWBB - of_case.Abandoned_ratio: MOWBB
      MRSBB - of_case.Abandoned_ratio: MRSBB
      MSUBA - of_case.Abandoned_ratio: MSUBA
      MTABA - of_case.Abandoned_ratio: MTABA
      MTYBB - of_case.Abandoned_ratio: MTYBB
      MUMBB - of_case.Abandoned_ratio: MUMBB
      MVDBB - of_case.Abandoned_ratio: MVDBB
      NBOBB - of_case.Abandoned_ratio: NBOBB
      NGOBB - of_case.Abandoned_ratio: NGOBB
      NKGBB - of_case.Abandoned_ratio: NKGBB
      NSABB - of_case.Abandoned_ratio: NSABB
      NVSBA - of_case.Abandoned_ratio: NVSBA
      NYCBB - of_case.Abandoned_ratio: NYCBB
      ODSBA - of_case.Abandoned_ratio: ODSBA
      OPOBB - of_case.Abandoned_ratio: OPOBB
      OSABB - of_case.Abandoned_ratio: OSABB
      PAIBB - of_case.Abandoned_ratio: PAIBB
      PANBA - of_case.Abandoned_ratio: PANBA
      PANBB - of_case.Abandoned_ratio: PANBB
      PAVBB - of_case.Abandoned_ratio: PAVBB
      PENBB - of_case.Abandoned_ratio: PENBB
      PIRAEU - of_case.Abandoned_ratio: PIRAE
      PKGBB - of_case.Abandoned_ratio: PKGBB
      PLMBB - of_case.Abandoned_ratio: PLMBB
      PLZBB - of_case.Abandoned_ratio: PLZBB
      PNHBA - of_case.Abandoned_ratio: PNHBA
      PNQBB - of_case.Abandoned_ratio: PNQBB
      PPGBA - of_case.Abandoned_ratio: PPGBA
      PPTBA - of_case.Abandoned_ratio: PPTBA
      PRGBB - of_case.Abandoned_ratio: PRGBB
      PSDBB - of_case.Abandoned_ratio: PSDBB
      PTIBA - of_case.Abandoned_ratio: PTIBA
      PTSBA - of_case.Abandoned_ratio: PTSBA
      PUSBB - of_case.Abandoned_ratio: PUSBB
      QITBA - of_case.Abandoned_ratio: QITBA
      RHUBA - of_case.Abandoned_ratio: RHUBA
      RICBB - of_case.Abandoned_ratio: RICBB
      RIXBA - of_case.Abandoned_ratio: RIXBA
      RJKBA - of_case.Abandoned_ratio: RJKBA
      RTMBB - of_case.Abandoned_ratio: RTMBB
      SALBA - of_case.Abandoned_ratio: SALBA
      SAOBB - of_case.Abandoned_ratio: SAOBB
      SCLBB - of_case.Abandoned_ratio: SCLBB
      SEABB - of_case.Abandoned_ratio: SEABB
      SELBB - of_case.Abandoned_ratio: SELBB
      SFOBB - of_case.Abandoned_ratio: SFOBB
      SFSBB - of_case.Abandoned_ratio: SFSBB
      SGNBB - of_case.Abandoned_ratio: SGNBB
      SGZBB - of_case.Abandoned_ratio: SGZBB
      SHABB - of_case.Abandoned_ratio: SHABB
      SIABB - of_case.Abandoned_ratio: SIABB
      SINBB - of_case.Abandoned_ratio: SINBB
      SINHO - of_case.Abandoned_ratio: SINHO
      SJOBA - of_case.Abandoned_ratio: SJOBA
      SJWBB - of_case.Abandoned_ratio: SJWBB
      SKGBA - of_case.Abandoned_ratio: SKGBA
      SMZBA - of_case.Abandoned_ratio: SMZBA
      SOUBB - of_case.Abandoned_ratio: SOUBB
      SPBBB - of_case.Abandoned_ratio: SPBBB
      SPROS - of_case.Abandoned_ratio: SPROS
      SRGBB - of_case.Abandoned_ratio: SRGBB
      SSZBB - of_case.Abandoned_ratio: SSZBB
      STRBB - of_case.Abandoned_ratio: STRBB
      SUBBB - of_case.Abandoned_ratio: SUBBB
      SUDBB - of_case.Abandoned_ratio: SUDBB
      SUVBA - of_case.Abandoned_ratio: SUVBA
      SUZBB - of_case.Abandoned_ratio: SUZBB
      SYDBB - of_case.Abandoned_ratio: SYDBB
      SZHBB - of_case.Abandoned_ratio: SZHBB
      SZPBB - of_case.Abandoned_ratio: SZPBB
      TAOBB - of_case.Abandoned_ratio: TAOBB
      TBUBA - of_case.Abandoned_ratio: TBUBA
      TEMBB - of_case.Abandoned_ratio: TEMBB
      TGCBA - of_case.Abandoned_ratio: TGCBA
      TLLBA - of_case.Abandoned_ratio: TLLBA
      TLVBA - of_case.Abandoned_ratio: TLVBA
      TORBB - of_case.Abandoned_ratio: TORBB
      TPEBB - of_case.Abandoned_ratio: TPEBB
      TPPBB - of_case.Abandoned_ratio: TPPBB
      TRWBA - of_case.Abandoned_ratio: TRWBA
      TSNBB - of_case.Abandoned_ratio: TSNBB
      TUNBA - of_case.Abandoned_ratio: TUNBA
      TUTBB - of_case.Abandoned_ratio: TUTBB
      TXGBB - of_case.Abandoned_ratio: TXGBB
      TYOBB - of_case.Abandoned_ratio: TYOBB
      VANBB - of_case.Abandoned_ratio: VANBB
      VAPBB - of_case.Abandoned_ratio: VAPBB
      VARBA - of_case.Abandoned_ratio: VARBA
      VGOBB - of_case.Abandoned_ratio: VGOBB
      VLCBB - of_case.Abandoned_ratio: VLCBB
      VLIBA - of_case.Abandoned_ratio: VLIBA
      VNABB - of_case.Abandoned_ratio: VNABB
      VTZBB - of_case.Abandoned_ratio: VTZBB
      VVABB - of_case.Abandoned_ratio: VVABB
      WGZOS - of_case.Abandoned_ratio: WGZOS
      WMLOS - of_case.Abandoned_ratio: WMLOS
      WNKOS - of_case.Abandoned_ratio: WNKOS
      WUHBB - of_case.Abandoned_ratio: WUHBB
      XMNBB - of_case.Abandoned_ratio: XMNBB
      YGNBB - of_case.Abandoned_ratio: YGNBB
      ZHOBB - of_case.Abandoned_ratio: ZHOBB
      ZHUBB - of_case.Abandoned_ratio: ZHUBB
      ZLOBB - of_case.Abandoned_ratio: ZLOBB
      of_case.Case_Geo___null - of_case.Abandoned_ratio: "∅"
    series_point_styles:
      global_target_chat: diamond
    show_null_points: true
    interpolation: monotone
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
    defaults_version: 1
    hidden_fields: [of_case.case_distinct_count, of_case.target_measure_for_Chat2,
      of_case.target_for_chat]
    note_state: collapsed
    note_display: hover
    note_text: |-
      <P style="text-align:left;"><B>Metric Name : </B>Abandoned Chat Ratio<BR><B>How it Helps : </B>To analyze the trend and pattern of Chat cases that are abandoned by Customers
      <BR>[Cases with Resolution Reason marked as "Customer Abandoned Chats" / Total Chat cases]
    hidden_pivots:
      Global:
        measure_names: []
      HKGHQ:
        measure_names: []
      LONHQ:
        measure_names: []
      RICHQ:
        measure_names: []
      SAOHQ:
        measure_names: []
      SINHQ:
        measure_names: []
      Unclaimed:
        measure_names: []
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
      Is Within Business Hour (Abandoned Chat Ratio): of_case.isWithInBusinessHour
    row: 59
    col: 11
    width: 11
    height: 9
  - title: 'Total Escl '
    name: 'Total Escl '
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.case_distinct_count_drill]
    filters:
      of_case.total_escalation: ">0"
    limit: 500
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '16'
    orientation: auto
    style_of_case.case_distinct_count_drill: "#7f0b4d"
    show_title_of_case.case_distinct_count_drill: false
    title_placement_of_case.case_distinct_count_drill: above
    value_format_of_case.case_distinct_count_drill: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
    custom_color: "#BD0F72"
    single_value_title: Total Escl (30 Days)
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: 6c27c30e-5523-4080-82ae-272146e699d0,
          palette_id: 25b877bc-c7a8-4ed0-a0ef-5ba64ca3658d}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 0
    listen:
      Date Granularity: of_case.timeframe_picker
      Web Email: of_case.supplied_email
      Open Date: of_case.createddate_filter_date
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 20
    col: 21
    width: 3
    height: 3
  - title: Avg Handling Time (mins)
    name: Avg Handling Time (mins)
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.createddate_dynamic, of_case.average_handling_time, of_case.Case_Geo,
      of_case.target_for_chat, of_case.target_for_web]
    pivots: [of_case.Case_Geo]
    sorts: [of_case.createddate_dynamic, of_case.Case_Geo]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields: [{category: table_calculation, expression: 'coalesce(pivot_where(${of_case.Case_Geo}="Global",if(is_null(${of_case.dynamic_reference}),-5,${of_case.dynamic_reference})),-5)',
        label: Global, value_format: !!null '', value_format_name: decimal_1, _kind_hint: supermeasure,
        table_calculation: global, _type_hint: number, is_disabled: true}, {category: table_calculation,
        expression: 'max(coalesce(max(pivot_row(${of_case.target_for_chat})),-10))',
        label: Global Target (Chat), value_format: !!null '', value_format_name: decimal_1,
        _kind_hint: supermeasure, table_calculation: global_target_chat, _type_hint: number},
      {category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_web})),-10))',
        label: Global Target (Web), value_format: !!null '', value_format_name: decimal_1,
        _kind_hint: supermeasure, table_calculation: global_target_web, _type_hint: number}]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.average_handling_time,
            id: Global - of_case.average_handling_time, name: Global}, {axisId: of_case.average_handling_time,
            id: Row Total - of_case.average_handling_time, name: Total}, {axisId: global_target,
            id: global_target, name: Global Target}, {axisId: hkghq_target, id: hkghq_target,
            name: HKGHQ Target}, {axisId: lonhq_target, id: lonhq_target, name: LONHQ
              Target}, {axisId: richq_target, id: richq_target, name: RICHQ Target},
          {axisId: saohq_target, id: saohq_target, name: SAOHQ Target}, {axisId: sinhq_target,
            id: sinhq_target, name: SINHQ Target}], showLabels: false, showValues: false,
        minValue: 0, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    label_value_format: ''
    series_types:
      Row Total - of_case.average_handling_time: line
      global_target: line
      hkghq_target: line
      lonhq_target: line
      richq_target: line
      saohq_target: line
      sinhq_target: line
      Row Total - of_case.new_aht: line
      hkghq: line
      lonhq: line
      richq: line
      sinhq: line
      saohq: line
      global: line
      global_target_chat: line
      global_target_web: line
    series_colors:
      HKGHQ - of_case.average_handling_time: "#db72af"
      LONHQ - of_case.average_handling_time: "#00506D"
      RICHQ - of_case.average_handling_time: "#84C5C3"
      SAOHQ - of_case.average_handling_time: "#BD0F72"
      SINHQ - of_case.average_handling_time: "#8b908f"
      Row Total - of_case.average_handling_time: "#F39200"
      global: "#340335"
      Row Total - of_case.dynamic_reference: "#340335"
      global_target_web: "#00B050"
      global_target_chat: "#70AD47"
    series_labels:
      Row Total - of_case.average_handling_time: Total
      1 - of_case.average_handling_time: GKA
      2 - of_case.average_handling_time: RKA
      3 - of_case.average_handling_time: LKA
      4 - of_case.average_handling_time: ONECare
      Global - of_case.average_handling_time: Global
      HKGHQ - of_case.average_handling_time: HKGHQ
      LONHQ - of_case.average_handling_time: LONHQ
      RICHQ - of_case.average_handling_time: RICHQ
      SAOHQ - of_case.average_handling_time: SAOHQ
      SINHQ - of_case.average_handling_time: SINHQ
      global: FY 23 Global Target (Chat)
      Row Total - of_case.dynamic_reference: FY 23 - Target
      Unclaimed - of_case.average_handling_time: Unclaimed
      Chat - of_case.average_handling_time: Chat
      Email - of_case.average_handling_time: Email
      Manual - of_case.average_handling_time: Manual
      Web - of_case.average_handling_time: Web
      Phone - of_case.average_handling_time: Phone
      global_target_web: FY2023 Global Uniform Target (Web)
      global_target_chat: FY2023 Global Uniform Target (Chat)
      CCA - of_case.average_handling_time: CCA
      CCS - of_case.average_handling_time: CCS
      Others - of_case.average_handling_time: Others
      Sales Executive - of_case.average_handling_time: Sales Executive
      C-KAM - of_case.average_handling_time: C-KAM
      C-KAS - of_case.average_handling_time: C-KAS
      No KA Mapping - of_case.average_handling_time: No KA Mapping
      ONECare Queue - of_case.average_handling_time: ONECare Queue
      S-KAM - of_case.average_handling_time: S-KAM
      S-KAS - of_case.average_handling_time: S-KAS
      Onshore - of_case.average_handling_time: Onshore
      Offshore - of_case.average_handling_time: Offshore
      Complaint/Feedback - of_case.average_handling_time: Complaint/Feedback
      Complex - of_case.average_handling_time: Complex
      General Information - of_case.average_handling_time: General Information
      Inquiry - of_case.average_handling_time: Inquiry
      Internal - of_case.average_handling_time: Internal
      Service Request - of_case.average_handling_time: Service Request
      Service Failure - of_case.average_handling_time: Service Failure
      Transactional - of_case.average_handling_time: Transactional
      No Action Required - of_case.average_handling_time: No Action Required
      Internal Request - of_case.average_handling_time: Internal Request
      GKA - of_case.average_handling_time: GKA
      LKA - of_case.average_handling_time: LKA
      ONECare - of_case.average_handling_time: ONECare
      RKA - of_case.average_handling_time: RKA
      AE - of_case.average_handling_time: AE
      AR - of_case.average_handling_time: AR
      AT & HU - of_case.average_handling_time: AT & HU
      AU - of_case.average_handling_time: AU
      BD - of_case.average_handling_time: BD
      BR - of_case.average_handling_time: BR
      BE - of_case.average_handling_time: BE
      CH - of_case.average_handling_time: CH
      CL - of_case.average_handling_time: CL
      CN - of_case.average_handling_time: CN
      CO - of_case.average_handling_time: CO
      DE - of_case.average_handling_time: DE
      CZ & SK - of_case.average_handling_time: CZ & SK
      EC - of_case.average_handling_time: EC
      DK - of_case.average_handling_time: DK
      EG - of_case.average_handling_time: EG
      ES - of_case.average_handling_time: ES
      LK - of_case.average_handling_time: LK
      IT - of_case.average_handling_time: IT
      FI - of_case.average_handling_time: FI
      FR - of_case.average_handling_time: FR
      GB - of_case.average_handling_time: GB
      GH - of_case.average_handling_time: GH
      HK & SCN - of_case.average_handling_time: HK & SCN
      ID - of_case.average_handling_time: ID
      IL - of_case.average_handling_time: IL
      IN - of_case.average_handling_time: IN
      JP - of_case.average_handling_time: JP
      KR - of_case.average_handling_time: KR
      MA - of_case.average_handling_time: MA
      MM - of_case.average_handling_time: MM
      MX - of_case.average_handling_time: MX
      MY - of_case.average_handling_time: MY
      TR - of_case.average_handling_time: TR
      TW - of_case.average_handling_time: TW
      TH - of_case.average_handling_time: TH
      SE & NO - of_case.average_handling_time: SE & NO
      NG - of_case.average_handling_time: NG
      NL - of_case.average_handling_time: NL
      NZ - of_case.average_handling_time: NZ
      PA - of_case.average_handling_time: PA
      PE - of_case.average_handling_time: PE
      PH - of_case.average_handling_time: PH
      PK - of_case.average_handling_time: PK
      PL - of_case.average_handling_time: PL
      PT - of_case.average_handling_time: PT
      SG - of_case.average_handling_time: SG
      US - of_case.average_handling_time: US
      UY - of_case.average_handling_time: UY
      ZA - of_case.average_handling_time: ZA
      CA - of_case.average_handling_time: CA
      CI - of_case.average_handling_time: CI
      AT - of_case.average_handling_time: AT
      CZ - of_case.average_handling_time: CZ
      IE - of_case.average_handling_time: IE
      SK - of_case.average_handling_time: SK
      VN - of_case.average_handling_time: VN
      NO - of_case.average_handling_time: 'NO'
      AS - of_case.average_handling_time: AS
      BG - of_case.average_handling_time: BG
      CR - of_case.average_handling_time: CR
      CY - of_case.average_handling_time: CY
      DZ - of_case.average_handling_time: DZ
      EE - of_case.average_handling_time: EE
      FJ - of_case.average_handling_time: FJ
      GE - of_case.average_handling_time: GE
      GR - of_case.average_handling_time: GR
      GT - of_case.average_handling_time: GT
      HK - of_case.average_handling_time: HK
      HN - of_case.average_handling_time: HN
      HR - of_case.average_handling_time: HR
      HU - of_case.average_handling_time: HU
      KE - of_case.average_handling_time: KE
      KH - of_case.average_handling_time: KH
      KI - of_case.average_handling_time: KI
      LB - of_case.average_handling_time: LB
      LT - of_case.average_handling_time: LT
      LS - of_case.average_handling_time: LS
      LV - of_case.average_handling_time: LV
      MO - of_case.average_handling_time: MO
      MT - of_case.average_handling_time: MT
      NI - of_case.average_handling_time: NI
      PF - of_case.average_handling_time: PF
      RO - of_case.average_handling_time: RO
      SA - of_case.average_handling_time: SA
      SB - of_case.average_handling_time: SB
      SI - of_case.average_handling_time: SI
      SN - of_case.average_handling_time: SN
      SV - of_case.average_handling_time: SV
      TG - of_case.average_handling_time: TG
      TJ - of_case.average_handling_time: TJ
      TN - of_case.average_handling_time: TN
      TO - of_case.average_handling_time: TO
      TT - of_case.average_handling_time: TT
      UA - of_case.average_handling_time: UA
      VU - of_case.average_handling_time: VU
      WS - of_case.average_handling_time: WS
      ZW - of_case.average_handling_time: ZW
      ZZ - of_case.average_handling_time: ZZ
      AARBB - of_case.average_handling_time: AARBB
      ABJBB - of_case.average_handling_time: ABJBB
      ADLBB - of_case.average_handling_time: ADLBB
      AKLBB - of_case.average_handling_time: AKLBB
      ALGBB - of_case.average_handling_time: ALGBB
      ALJBA - of_case.average_handling_time: ALJBA
      ALYBB - of_case.average_handling_time: ALYBB
      AMDBB - of_case.average_handling_time: AMDBB
      ANRBB - of_case.average_handling_time: ANRBB
      APWBA - of_case.average_handling_time: APWBA
      ASHBA - of_case.average_handling_time: ASHBA
      ATLBB - of_case.average_handling_time: ATLBB
      BASBB - of_case.average_handling_time: BASBB
      BCNBB - of_case.average_handling_time: BCNBB
      BDOBB - of_case.average_handling_time: BDOBB
      BELBB - of_case.average_handling_time: BELBB
      BEYBA - of_case.average_handling_time: BEYBA
      BIOBB - of_case.average_handling_time: BIOBB
      BKKBB - of_case.average_handling_time: BKKBB
      BLRBB - of_case.average_handling_time: BLRBB
      BNDBB - of_case.average_handling_time: BNDBB
      BNEBB - of_case.average_handling_time: BNEBB
      BOGBB - of_case.average_handling_time: BOGBB
      BOIBB - of_case.average_handling_time: BOIBB
      BOSBB - of_case.average_handling_time: BOSBB
      BREBB - of_case.average_handling_time: BREBB
      BTMBB - of_case.average_handling_time: BTMBB
      BUDBB - of_case.average_handling_time: BUDBB
      BUEBB - of_case.average_handling_time: BUEBB
      CAIBB - of_case.average_handling_time: CAIBB
      CANBB - of_case.average_handling_time: CANBB
      CASBA - of_case.average_handling_time: CASBA
      CCPBB - of_case.average_handling_time: CCPBB
      CCUBB - of_case.average_handling_time: CCUBB
      CEBBB - of_case.average_handling_time: CEBBB
      CGOBB - of_case.average_handling_time: CGOBB
      CGPBB - of_case.average_handling_time: CGPBB
      CGYBB - of_case.average_handling_time: CGYBB
      CHCBB - of_case.average_handling_time: CHCBB
      CHIBB - of_case.average_handling_time: CHIBB
      CKGBB - of_case.average_handling_time: CKGBB
      CLLBB - of_case.average_handling_time: CLLBB
      CMBBB - of_case.average_handling_time: CMBBB
      CNDBA - of_case.average_handling_time: CNDBA
      COKBB - of_case.average_handling_time: COKBB
      CPTBB - of_case.average_handling_time: CPTBB
      CTUBB - of_case.average_handling_time: CTUBB
      CWBBB - of_case.average_handling_time: CWBBB
      DACBB - of_case.average_handling_time: DACBB
      DADBB - of_case.average_handling_time: DADBB
      DAMBB - of_case.average_handling_time: DAMBB
      DARBA - of_case.average_handling_time: DARBA
      DELBB - of_case.average_handling_time: DELBB
      DKRBA - of_case.average_handling_time: DKRBA
      DLCBB - of_case.average_handling_time: DLCBB
      DMNBA - of_case.average_handling_time: DMNBA
      DPSBB - of_case.average_handling_time: DPSBB
      DUBBA - of_case.average_handling_time: DUBBA
      DURBB - of_case.average_handling_time: DURBB
      DUSBB - of_case.average_handling_time: DUSBB
      DVOBB - of_case.average_handling_time: DVOBB
      DXBBB - of_case.average_handling_time: DXBBB
      EDKBB - of_case.average_handling_time: EDKBB
      ELSBB - of_case.average_handling_time: ELSBB
      FOCBB - of_case.average_handling_time: FOCBB
      FREBB - of_case.average_handling_time: FREBB
      GDLBB - of_case.average_handling_time: GDLBB
      GDNBB - of_case.average_handling_time: GDNBB
      GDYBB - of_case.average_handling_time: GDYBB
      GESBB - of_case.average_handling_time: GESBB
      GINBB - of_case.average_handling_time: GINBB
      GOABB - of_case.average_handling_time: GOABB
      GOTBB - of_case.average_handling_time: GOTBB
      GUABA - of_case.average_handling_time: GUABA
      GYEBB - of_case.average_handling_time: GYEBB
      HALBB - of_case.average_handling_time: HALBB
      HAMBB - of_case.average_handling_time: HAMBB
      HANBB - of_case.average_handling_time: HANBB
      HELBB - of_case.average_handling_time: HELBB
      HFABA - of_case.average_handling_time: HFABA
      HFEBB - of_case.average_handling_time: HFEBB
      HGHBB - of_case.average_handling_time: HGHBB
      HIRBA - of_case.average_handling_time: HIRBA
      HKGBB - of_case.average_handling_time: HKGBB
      HKTBA - of_case.average_handling_time: HKTBA
      HOUBB - of_case.average_handling_time: HOUBB
      HPHBB - of_case.average_handling_time: HPHBB
      HREBA - of_case.average_handling_time: HREBA
      HYDBB - of_case.average_handling_time: HYDBB
      ICDBB - of_case.average_handling_time: ICDBB
      IPSBB - of_case.average_handling_time: IPSBB
      IQQBB - of_case.average_handling_time: IQQBB
      ISTBA - of_case.average_handling_time: ISTBA
      ISTBB - of_case.average_handling_time: ISTBB
      ITJBB - of_case.average_handling_time: ITJBB
      IZMBA - of_case.average_handling_time: IZMBA
      IZMBB - of_case.average_handling_time: IZMBB
      JEDBA - of_case.average_handling_time: JEDBA
      JHBBB - of_case.average_handling_time: JHBBB
      JKTBB - of_case.average_handling_time: JKTBB
      JMNBB - of_case.average_handling_time: JMNBB
      JNBBB - of_case.average_handling_time: JNBBB
      KHHBB - of_case.average_handling_time: KHHBB
      KHIBB - of_case.average_handling_time: KHIBB
      KHLBB - of_case.average_handling_time: KHLBB
      KLPBA - of_case.average_handling_time: KLPBA
      KOPBA - of_case.average_handling_time: KOPBA
      LAXBB - of_case.average_handling_time: LAXBB
      LCBBB - of_case.average_handling_time: LCBBB
      LEHBB - of_case.average_handling_time: LEHBB
      LEXBB - of_case.average_handling_time: LEXBB
      LFWBA - of_case.average_handling_time: LFWBA
      LHEBB - of_case.average_handling_time: LHEBB
      LIMBB - of_case.average_handling_time: LIMBB
      LISBB - of_case.average_handling_time: LISBB
      LIVBB - of_case.average_handling_time: LIVBB
      LMSBA - of_case.average_handling_time: LMSBA
      LONBB - of_case.average_handling_time: LONBB
      LOSBB - of_case.average_handling_time: LOSBB
      LUHBB - of_case.average_handling_time: LUHBB
      LYGBB - of_case.average_handling_time: LYGBB
      MAABB - of_case.average_handling_time: MAABB
      MACBB - of_case.average_handling_time: MACBB
      MADBB - of_case.average_handling_time: MADBB
      MAOBB - of_case.average_handling_time: MAOBB
      MBABA - of_case.average_handling_time: MBABA
      MECBA - of_case.average_handling_time: MECBA
      MELBB - of_case.average_handling_time: MELBB
      MERBA - of_case.average_handling_time: MERBA
      MERBB - of_case.average_handling_time: MERBB
      MESBB - of_case.average_handling_time: MESBB
      MEXBB - of_case.average_handling_time: MEXBB
      MIBOS - of_case.average_handling_time: MIBOS
      MIHOS - of_case.average_handling_time: MIHOS
      MITBB - of_case.average_handling_time: MITBB
      MNGBA - of_case.average_handling_time: MNGBA
      MNLBB - of_case.average_handling_time: MNLBB
      MOWBB - of_case.average_handling_time: MOWBB
      MRSBB - of_case.average_handling_time: MRSBB
      MSUBA - of_case.average_handling_time: MSUBA
      MTABA - of_case.average_handling_time: MTABA
      MTYBB - of_case.average_handling_time: MTYBB
      MUMBB - of_case.average_handling_time: MUMBB
      MVDBB - of_case.average_handling_time: MVDBB
      NBOBB - of_case.average_handling_time: NBOBB
      NGOBB - of_case.average_handling_time: NGOBB
      NKGBB - of_case.average_handling_time: NKGBB
      NSABB - of_case.average_handling_time: NSABB
      NVSBA - of_case.average_handling_time: NVSBA
      NYCBB - of_case.average_handling_time: NYCBB
      ODSBA - of_case.average_handling_time: ODSBA
      OPOBB - of_case.average_handling_time: OPOBB
      OSABB - of_case.average_handling_time: OSABB
      PAIBB - of_case.average_handling_time: PAIBB
      PANBA - of_case.average_handling_time: PANBA
      PANBB - of_case.average_handling_time: PANBB
      PAVBB - of_case.average_handling_time: PAVBB
      PENBB - of_case.average_handling_time: PENBB
      PIRAEU - of_case.average_handling_time: PIRAE
      PKGBB - of_case.average_handling_time: PKGBB
      PLMBB - of_case.average_handling_time: PLMBB
      PLZBB - of_case.average_handling_time: PLZBB
      PNHBA - of_case.average_handling_time: PNHBA
      PNQBB - of_case.average_handling_time: PNQBB
      PPGBA - of_case.average_handling_time: PPGBA
      PPTBA - of_case.average_handling_time: PPTBA
      PRGBB - of_case.average_handling_time: PRGBB
      PSDBB - of_case.average_handling_time: PSDBB
      PTIBA - of_case.average_handling_time: PTIBA
      PTSBA - of_case.average_handling_time: PTSBA
      PUSBB - of_case.average_handling_time: PUSBB
      QITBA - of_case.average_handling_time: QITBA
      RHUBA - of_case.average_handling_time: RHUBA
      RICBB - of_case.average_handling_time: RICBB
      RIXBA - of_case.average_handling_time: RIXBA
      RJKBA - of_case.average_handling_time: RJKBA
      RTMBB - of_case.average_handling_time: RTMBB
      SALBA - of_case.average_handling_time: SALBA
      SAOBB - of_case.average_handling_time: SAOBB
      SCLBB - of_case.average_handling_time: SCLBB
      SEABB - of_case.average_handling_time: SEABB
      SELBB - of_case.average_handling_time: SELBB
      SFOBB - of_case.average_handling_time: SFOBB
      SFSBB - of_case.average_handling_time: SFSBB
      SGNBB - of_case.average_handling_time: SGNBB
      SGZBB - of_case.average_handling_time: SGZBB
      SHABB - of_case.average_handling_time: SHABB
      SIABB - of_case.average_handling_time: SIABB
      SINBB - of_case.average_handling_time: SINBB
      SINHO - of_case.average_handling_time: SINHO
      SJOBA - of_case.average_handling_time: SJOBA
      SJWBB - of_case.average_handling_time: SJWBB
      SKGBA - of_case.average_handling_time: SKGBA
      SMZBA - of_case.average_handling_time: SMZBA
      SOUBB - of_case.average_handling_time: SOUBB
      SPBBB - of_case.average_handling_time: SPBBB
      SPROS - of_case.average_handling_time: SPROS
      SRGBB - of_case.average_handling_time: SRGBB
      SSZBB - of_case.average_handling_time: SSZBB
      STRBB - of_case.average_handling_time: STRBB
      SUBBB - of_case.average_handling_time: SUBBB
      SUDBB - of_case.average_handling_time: SUDBB
      SUVBA - of_case.average_handling_time: SUVBA
      SUZBB - of_case.average_handling_time: SUZBB
      SYDBB - of_case.average_handling_time: SYDBB
      SZHBB - of_case.average_handling_time: SZHBB
      SZPBB - of_case.average_handling_time: SZPBB
      TAOBB - of_case.average_handling_time: TAOBB
      TBUBA - of_case.average_handling_time: TBUBA
      TEMBB - of_case.average_handling_time: TEMBB
      TGCBA - of_case.average_handling_time: TGCBA
      TLLBA - of_case.average_handling_time: TLLBA
      TLVBA - of_case.average_handling_time: TLVBA
      TORBB - of_case.average_handling_time: TORBB
      TPEBB - of_case.average_handling_time: TPEBB
      TPPBB - of_case.average_handling_time: TPPBB
      TRWBA - of_case.average_handling_time: TRWBA
      TSNBB - of_case.average_handling_time: TSNBB
      TUNBA - of_case.average_handling_time: TUNBA
      TUTBB - of_case.average_handling_time: TUTBB
      TXGBB - of_case.average_handling_time: TXGBB
      TYOBB - of_case.average_handling_time: TYOBB
      VANBB - of_case.average_handling_time: VANBB
      VAPBB - of_case.average_handling_time: VAPBB
      VARBA - of_case.average_handling_time: VARBA
      VGOBB - of_case.average_handling_time: VGOBB
      VLCBB - of_case.average_handling_time: VLCBB
      VLIBA - of_case.average_handling_time: VLIBA
      VNABB - of_case.average_handling_time: VNABB
      VTZBB - of_case.average_handling_time: VTZBB
      VVABB - of_case.average_handling_time: VVABB
      WGZOS - of_case.average_handling_time: WGZOS
      WMLOS - of_case.average_handling_time: WMLOS
      WNKOS - of_case.average_handling_time: WNKOS
      WUHBB - of_case.average_handling_time: WUHBB
      XMNBB - of_case.average_handling_time: XMNBB
      YGNBB - of_case.average_handling_time: YGNBB
      ZHOBB - of_case.average_handling_time: ZHOBB
      ZHUBB - of_case.average_handling_time: ZHUBB
      ZLOBB - of_case.average_handling_time: ZLOBB
      of_case.Case_Geo___null - of_case.average_handling_time: "∅"
    series_point_styles:
      global_target_chat: diamond
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [of_case.target_measure_for_Chat2, of_case.target_measure_for_WEB2,
      of_case.target_for_chat, of_case.target_for_web]
    hidden_pivots:
      Global:
        measure_names: []
      HKGHQ:
        measure_names: []
      LONHQ:
        measure_names: []
      RICHQ:
        measure_names: []
      SAOHQ:
        measure_names: []
      SINHQ:
        measure_names: []
      Unclaimed:
        measure_names: []
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Average Handling
      Time<BR><B>How it Helps : </B>Average Case Handle time for Agent to work on
      the case in the end-to-end cycle of Customer''s case<BR>[AHT = Time from Case
      Status "In Progress" to "Resolved" excluding Non-Biz Hrs, Awaiting Customer
      Response, On-Hold Waiting Time]<BR><B>Filter Tips : </B><BR>Handling Time =
      Case Level<BR>'
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Exclude Awaiting Internal AHT: of_case.Exclude_Awaiting_Internal_in_AHT
      Handling Time: of_case.handletime_Param
      AHT Calculated: of_case.is_aht_calculated
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 32
    col: 0
    width: 21
    height: 9
  - title: Total Volume
    name: Total Volume
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.case_distinct_count_drill]
    limit: 500
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '16'
    orientation: auto
    style_of_case.case_distinct_count_drill: "#7f0b4d"
    show_title_of_case.case_distinct_count_drill: false
    title_placement_of_case.case_distinct_count_drill: above
    value_format_of_case.case_distinct_count_drill: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
    custom_color: "#BD0F72"
    single_value_title: Total
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: legacy, palette_id: legacy_sequential3},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 0
    listen:
      Date Granularity: of_case.timeframe_picker
      Web Email: of_case.supplied_email
      Open Date: of_case.createddate_filter_date
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 1
    col: 0
    width: 3
    height: 4
  - name: " (3)"
    type: text
    title_text: ''
    body_text: |-
      #####Notes
      * Data shown is in UTC Time Zone
    row: 80
    col: 0
    width: 7
    height: 2
  - title: Contract Customer Association
    name: Contract Customer Association
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.is_contract_customer]
    limit: 500
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '16'
    orientation: auto
    style_of_case.is_contract_customer: "#7f0b4d"
    show_title_of_case.is_contract_customer: false
    title_placement_of_case.is_contract_customer: above
    value_format_of_case.is_contract_customer: ''
    show_comparison_previous_contract_customer: false
    comparison_style_previous_contract_customer: percentage_change
    comparison_show_label_previous_contract_customer: true
    comparison_label_previous_contract_customer: vs Prev
    comparison_label_placement_previous_contract_customer: below
    style_previous_contract_customer: "#3A4245"
    show_title_previous_contract_customer: true
    title_placement_previous_contract_customer: above
    value_format_previous_contract_customer: ''
    series_types: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 0
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Priority: of_case.priority
      Category (L1): of_case.reason
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 23
    col: 21
    width: 3
    height: 3
  - title: Abandoned Chats
    name: Abandoned Chats
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.Abandoned_ratio]
    filters:
      of_case.active_case: 'No'
      chat_cases: 'Yes'
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'case (when(${of_case.origin}="Chat",
          "Yes"), "No")', label: Chat Cases, value_format: !!null '', value_format_name: !!null '',
        dimension: chat_cases, _kind_hint: dimension, _type_hint: string}]
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '16'
    orientation: auto
    style_of_case.Abandoned_ratio: "#7f0b4d"
    show_title_of_case.Abandoned_ratio: false
    title_placement_of_case.Abandoned_ratio: above
    value_format_of_case.Abandoned_ratio: ''
    show_comparison_previous_abandoned_ratio: false
    comparison_style_previous_abandoned_ratio: percentage_change
    comparison_show_label_previous_abandoned_ratio: true
    pos_is_bad_previous_abandoned_ratio: false
    comparison_label_previous_abandoned_ratio: vs Prev
    comparison_label_placement_previous_abandoned_ratio: below
    style_previous_abandoned_ratio: "#3A4245"
    show_title_previous_abandoned_ratio: true
    title_placement_previous_abandoned_ratio: above
    value_format_previous_abandoned_ratio: ''
    series_types: {}
    defaults_version: 0
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Priority: of_case.priority
      Category (L1): of_case.reason
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 26
    col: 21
    width: 3
    height: 3
  - title: BOT & Self Service
    name: BOT & Self Service
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [of_case.Automation_ratio]
    limit: 500
    dynamic_fields: [{category: measure, expression: !!null '', label: BOT & Self-Service,
        value_format: !!null '', value_format_name: !!null '', based_on: of_case.case_distinct_count,
        _kind_hint: measure, measure: bot_self_service, type: count_distinct, _type_hint: number,
        filters: {of_case.is_resolved_by_automation: 'Yes', of_case.Automation_Type: 'Self-Service,D&D,LFD'}},
      {category: measure, expression: 'trunc_months (${of_case.filter_start} ) = trunc_months
          ( ${of_case.createddate_date})', label: Previous BOT & Self-Service, value_format: !!null '',
        value_format_name: !!null '', based_on: of_case.case_distinct_count, filter_expression: 'trunc_months
          (${of_case.filter_start} ) = trunc_months ( ${of_case.createddate_date})',
        _kind_hint: measure, measure: previous_bot_self_service, type: count_distinct,
        _type_hint: number, filters: {of_case.is_resolved_by_automation: 'Yes', of_case.Automation_Type: 'Self-Service,D&D,LFD'}},
      {category: dimension, expression: 'case (when(${of_case.origin}="Chat", "Yes"),
          "No")', label: Chat Cases, value_format: !!null '', value_format_name: !!null '',
        dimension: chat_cases, _kind_hint: dimension, _type_hint: string}]
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: '16'
    orientation: auto
    style_of_case.Automation_ratio: "#7f0b4d"
    show_title_of_case.Automation_ratio: false
    title_placement_of_case.Automation_ratio: above
    value_format_of_case.Automation_ratio: ''
    show_comparison_previous_automation_ratio: true
    comparison_style_previous_automation_ratio: percentage_change
    comparison_show_label_previous_automation_ratio: true
    comparison_label_previous_automation_ratio: vs Prev
    comparison_label_placement_previous_automation_ratio: below
    style_previous_automation_ratio: "#3A4245"
    show_title_previous_automation_ratio: true
    title_placement_previous_automation_ratio: above
    value_format_previous_automation_ratio: ''
    style_bot_self_service: "#7f0b4d"
    show_title_bot_self_service: false
    title_placement_bot_self_service: above
    show_comparison_previous_bot_self_service: true
    comparison_style_previous_bot_self_service: percentage_change
    comparison_show_label_previous_bot_self_service: true
    pos_is_bad_previous_bot_self_service: true
    comparison_label_previous_bot_self_service: vs Prev
    comparison_label_placement_previous_bot_self_service: below
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
    defaults_version: 0
    series_types: {}
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Priority: of_case.priority
      Category (L1): of_case.reason
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 29
    col: 21
    width: 3
    height: 3
  - title: Top 5 Intents
    name: Top 5 Intents
    model: oneforce_service
    explore: of_case
    type: looker_grid
    fields: [of_case.case_distinct_count_drill, of_case.sub_category_l2]
    sorts: [of_case.case_distinct_count_drill desc]
    limit: 5
    dynamic_fields: [{category: table_calculation, expression: "concat( \"1.\",offset(${of_case.sub_category_l2},0),\n\
          \  \"2.\",offset(${of_case.sub_category_l2},1),\n  \"3.\",offset(${of_case.sub_category_l2},2),\n\
          \  \"4.\",offset(${of_case.sub_category_l2},3),\n  \"5.\",offset(${of_case.sub_category_l2},4)\
          \ )", label: New Calculation, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: new_calculation, _type_hint: string}]
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    series_labels:
      of_case.sub_category_l2: L2 Intents
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#ffffff",
        font_color: "#BD0F72", color_application: {collection_id: 6c27c30e-5523-4080-82ae-272146e699d0,
          palette_id: 25b877bc-c7a8-4ed0-a0ef-5ba64ca3658d}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    hidden_fields: [of_case.case_distinct_count_drill, new_calculation]
    hidden_points_if_no: []
    font_size_main: '16'
    orientation: auto
    style_of_case.case_distinct_count_drill: "#7f0b4d"
    show_title_of_case.case_distinct_count_drill: false
    title_placement_of_case.case_distinct_count_drill: above
    value_format_of_case.case_distinct_count_drill: ''
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    custom_color: "#BD0F72"
    single_value_title: Total Escl (30 Days)
    series_types: {}
    defaults_version: 1
    listen:
      Date Granularity: of_case.timeframe_picker
      Web Email: of_case.supplied_email
      Open Date: of_case.createddate_filter_date
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Service or Contract Customer: of_case.Service_Contract_Customer
      Sub Resolution Reason: of_case.sub_resolution_reason
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 32
    col: 21
    width: 3
    height: 4
  - name: " (4)"
    type: text
    title_text: ''
    body_text: |-
      #####Notes
      * Each Case may have multiple Chat Transcripts, therefore these filters give users different perspectives on handling time and First Response Time.
      * At the Handling Time Filter, by default, it is Case Level, but when the user clicks on "Chat Transcript", it will affect AHT-related charts to reference from "Chat Handle Time (mins)" in the Chat Transcript Object.
      * At the First Response Level filter, by default, it is Case Level, but when the user clicks on "Chat Transcript", it will affect FRT-related charts to reference from "Chat First Response Time (mins)" in the Chat Transcript object.
    row: 76
    col: 6
    width: 13
    height: 4
  - title: Case Escalation Ratio
    name: Case Escalation Ratio
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.createddate_dynamic, of_case.case_distinct_count, of_case.number_of_escalated_cases,
      of_case.case_escalation_ratio, of_case.Case_Geo, of_case.target_for_chat, of_case.target_for_web]
    pivots: [of_case.Case_Geo]
    sorts: [of_case.Case_Geo, of_case.case_escalation_ratio desc 0]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields: [{category: dimension, expression: 'if(${of_case.total_escalation}
          > 0, "Yes", "No")', label: Total Escalation, value_format: !!null '', value_format_name: !!null '',
        dimension: total_escalation, _kind_hint: dimension, _type_hint: string}, {
        category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_web})),-10))',
        label: Global Target (Web), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target_web, _type_hint: number},
      {category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_chat})),-10))',
        label: Global Target (Chat), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target_chat, _type_hint: number}]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.case_escalation_ratio,
            id: HKGHQ - of_case.case_escalation_ratio, name: HKGHQ}, {axisId: of_case.case_escalation_ratio,
            id: LONHQ - of_case.case_escalation_ratio, name: LONHQ}, {axisId: of_case.case_escalation_ratio,
            id: RICHQ - of_case.case_escalation_ratio, name: RICHQ}, {axisId: of_case.case_escalation_ratio,
            id: SAOHQ - of_case.case_escalation_ratio, name: SAOHQ}, {axisId: of_case.case_escalation_ratio,
            id: SINHQ - of_case.case_escalation_ratio, name: SINHQ}, {axisId: of_case.case_escalation_ratio,
            id: Row Total - of_case.case_escalation_ratio, name: Total}, {axisId: global_target,
            id: global_target, name: Global Target}, {axisId: hkghq_target, id: hkghq_target,
            name: HKGHQ Target}, {axisId: lonhq_target, id: lonhq_target, name: LONHQ
              Target}, {axisId: richq_target, id: richq_target, name: RICHQ Target},
          {axisId: saohq_target, id: saohq_target, name: SAOHQ Target}, {axisId: sinhq_target,
            id: sinhq_target, name: SINHQ Target}], showLabels: false, showValues: false,
        minValue: 0, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    label_value_format: 0.0%
    series_types:
      Row Total - of_case.Escalation_ratio: line
      Row Total - of_case.case_escalation_ratio: line
      sinhq_target: line
      saohq_target: line
      richq_target: line
      lonhq_target: line
      hkghq_target: line
      global_target: line
      global: line
      Row Total - of_case.dynamic_reference: line
      global_target_web: line
      global_target_chat: line
    series_colors:
      Yes - of_case.case_distinct_count: "#8b908f"
      Row Total - of_case.Escalation_ratio: "#F39200"
      HKGHQ - of_case.Escalation_ratio: "#db72af"
      LONHQ - of_case.Escalation_ratio: "#00506D"
      RICHQ - of_case.Escalation_ratio: "#84C5C3"
      SAOHQ - of_case.Escalation_ratio: "#BD0F72"
      SINHQ - of_case.Escalation_ratio: "#8b908f"
      HKGHQ - of_case.case_escalation_ratio: "#db72af"
      LONHQ - of_case.case_escalation_ratio: "#00506D"
      RICHQ - of_case.case_escalation_ratio: "#84C5C3"
      SAOHQ - of_case.case_escalation_ratio: "#BD0F72"
      SINHQ - of_case.case_escalation_ratio: "#8b908f"
      Row Total - of_case.case_escalation_ratio: "#F39200"
      global_target_chat: "#70AD47"
      global_target_web: "#00B050"
    series_labels:
      No - of_case.case_distinct_count: Total Cases
      Yes - of_case.case_distinct_count: Escalated Cases
      Row Total - of_case.Escalation_ratio: Total
      1 - of_case.case_escalation_ratio: GKA
      2 - of_case.case_escalation_ratio: RKA
      3 - of_case.case_escalation_ratio: LKA
      4 - of_case.case_escalation_ratio: ONECare
      Row Total - of_case.case_escalation_ratio: Total
      SINHQ - of_case.case_escalation_ratio: SINHQ
      SAOHQ - of_case.case_escalation_ratio: SAOHQ
      RICHQ - of_case.case_escalation_ratio: RICHQ
      LONHQ - of_case.case_escalation_ratio: LONHQ
      HKGHQ - of_case.case_escalation_ratio: HKGHQ
      Global - of_case.case_escalation_ratio: Global
      global: FY 23 Global Target
      Row Total - of_case.dynamic_reference: Target
      Unclaimed - of_case.case_escalation_ratio: Unclaimed
      global_target_web: FY2023 Global Uniform Target (Web)
      global_target_chat: FY2023 Global Uniform Target (Chat)
      Chat - of_case.case_escalation_ratio: Chat
      Email - of_case.case_escalation_ratio: Email
      Manual - of_case.case_escalation_ratio: Manual
      Web - of_case.case_escalation_ratio: Web
      Phone - of_case.case_escalation_ratio: Phone
      CCA - of_case.case_escalation_ratio: CCA
      CCS - of_case.case_escalation_ratio: CCS
      Others - of_case.case_escalation_ratio: Others
      Sales Executive - of_case.case_escalation_ratio: Sales Executive
      C-KAM - of_case.case_escalation_ratio: C-KAM
      C-KAS - of_case.case_escalation_ratio: C-KAS
      No KA Mapping - of_case.case_escalation_ratio: No KA Mapping
      ONECare Queue - of_case.case_escalation_ratio: ONECare Queue
      S-KAM - of_case.case_escalation_ratio: S-KAM
      S-KAS - of_case.case_escalation_ratio: S-KAS
      Onshore - of_case.case_escalation_ratio: Onshore
      Offshore - of_case.case_escalation_ratio: Offshore
      Complaint/Feedback - of_case.case_escalation_ratio: Complaint/Feedback
      Complex - of_case.case_escalation_ratio: Complex
      General Information - of_case.case_escalation_ratio: General Information
      Inquiry - of_case.case_escalation_ratio: Inquiry
      Internal - of_case.case_escalation_ratio: Internal
      Service Request - of_case.case_escalation_ratio: Service Request
      Service Failure - of_case.case_escalation_ratio: Service Failure
      Transactional - of_case.case_escalation_ratio: Transactional
      No Action Required - of_case.case_escalation_ratio: No Action Required
      Internal Request - of_case.case_escalation_ratio: Internal Request
      GKA - of_case.case_escalation_ratio: GKA
      LKA - of_case.case_escalation_ratio: LKA
      ONECare - of_case.case_escalation_ratio: ONECare
      RKA - of_case.case_escalation_ratio: RKA
      AE - of_case.case_escalation_ratio: AE
      AR - of_case.case_escalation_ratio: AR
      AT & HU - of_case.case_escalation_ratio: AT & HU
      AU - of_case.case_escalation_ratio: AU
      BD - of_case.case_escalation_ratio: BD
      BR - of_case.case_escalation_ratio: BR
      BE - of_case.case_escalation_ratio: BE
      CH - of_case.case_escalation_ratio: CH
      CL - of_case.case_escalation_ratio: CL
      CN - of_case.case_escalation_ratio: CN
      CO - of_case.case_escalation_ratio: CO
      DE - of_case.case_escalation_ratio: DE
      CZ & SK - of_case.case_escalation_ratio: CZ & SK
      EC - of_case.case_escalation_ratio: EC
      DK - of_case.case_escalation_ratio: DK
      EG - of_case.case_escalation_ratio: EG
      ES - of_case.case_escalation_ratio: ES
      LK - of_case.case_escalation_ratio: LK
      IT - of_case.case_escalation_ratio: IT
      FI - of_case.case_escalation_ratio: FI
      FR - of_case.case_escalation_ratio: FR
      GB - of_case.case_escalation_ratio: GB
      GH - of_case.case_escalation_ratio: GH
      HK & SCN - of_case.case_escalation_ratio: HK & SCN
      ID - of_case.case_escalation_ratio: ID
      IL - of_case.case_escalation_ratio: IL
      IN - of_case.case_escalation_ratio: IN
      JP - of_case.case_escalation_ratio: JP
      KR - of_case.case_escalation_ratio: KR
      MA - of_case.case_escalation_ratio: MA
      MM - of_case.case_escalation_ratio: MM
      MX - of_case.case_escalation_ratio: MX
      MY - of_case.case_escalation_ratio: MY
      TR - of_case.case_escalation_ratio: TR
      TW - of_case.case_escalation_ratio: TW
      TH - of_case.case_escalation_ratio: TH
      SE & NO - of_case.case_escalation_ratio: SE & NO
      NG - of_case.case_escalation_ratio: NG
      NL - of_case.case_escalation_ratio: NL
      NZ - of_case.case_escalation_ratio: NZ
      PA - of_case.case_escalation_ratio: PA
      PE - of_case.case_escalation_ratio: PE
      PH - of_case.case_escalation_ratio: PH
      PK - of_case.case_escalation_ratio: PK
      PL - of_case.case_escalation_ratio: PL
      PT - of_case.case_escalation_ratio: PT
      SG - of_case.case_escalation_ratio: SG
      US - of_case.case_escalation_ratio: US
      UY - of_case.case_escalation_ratio: UY
      ZA - of_case.case_escalation_ratio: ZA
      CA - of_case.case_escalation_ratio: CA
      CI - of_case.case_escalation_ratio: CI
      AT - of_case.case_escalation_ratio: AT
      CZ - of_case.case_escalation_ratio: CZ
      IE - of_case.case_escalation_ratio: IE
      SK - of_case.case_escalation_ratio: SK
      VN - of_case.case_escalation_ratio: VN
      NO - of_case.case_escalation_ratio: 'NO'
      AS - of_case.case_escalation_ratio: AS
      BG - of_case.case_escalation_ratio: BG
      CR - of_case.case_escalation_ratio: CR
      CY - of_case.case_escalation_ratio: CY
      DZ - of_case.case_escalation_ratio: DZ
      EE - of_case.case_escalation_ratio: EE
      FJ - of_case.case_escalation_ratio: FJ
      GE - of_case.case_escalation_ratio: GE
      GR - of_case.case_escalation_ratio: GR
      GT - of_case.case_escalation_ratio: GT
      HK - of_case.case_escalation_ratio: HK
      HN - of_case.case_escalation_ratio: HN
      HR - of_case.case_escalation_ratio: HR
      HU - of_case.case_escalation_ratio: HU
      KE - of_case.case_escalation_ratio: KE
      KH - of_case.case_escalation_ratio: KH
      KI - of_case.case_escalation_ratio: KI
      LB - of_case.case_escalation_ratio: LB
      LT - of_case.case_escalation_ratio: LT
      LS - of_case.case_escalation_ratio: LS
      LV - of_case.case_escalation_ratio: LV
      MO - of_case.case_escalation_ratio: MO
      MT - of_case.case_escalation_ratio: MT
      NI - of_case.case_escalation_ratio: NI
      PF - of_case.case_escalation_ratio: PF
      RO - of_case.case_escalation_ratio: RO
      SA - of_case.case_escalation_ratio: SA
      SB - of_case.case_escalation_ratio: SB
      SI - of_case.case_escalation_ratio: SI
      SN - of_case.case_escalation_ratio: SN
      SV - of_case.case_escalation_ratio: SV
      TG - of_case.case_escalation_ratio: TG
      TJ - of_case.case_escalation_ratio: TJ
      TN - of_case.case_escalation_ratio: TN
      TO - of_case.case_escalation_ratio: TO
      TT - of_case.case_escalation_ratio: TT
      UA - of_case.case_escalation_ratio: UA
      VU - of_case.case_escalation_ratio: VU
      WS - of_case.case_escalation_ratio: WS
      ZW - of_case.case_escalation_ratio: ZW
      ZZ - of_case.case_escalation_ratio: ZZ
      AARBB - of_case.case_escalation_ratio: AARBB
      ABJBB - of_case.case_escalation_ratio: ABJBB
      ADLBB - of_case.case_escalation_ratio: ADLBB
      AKLBB - of_case.case_escalation_ratio: AKLBB
      ALGBB - of_case.case_escalation_ratio: ALGBB
      ALJBA - of_case.case_escalation_ratio: ALJBA
      ALYBB - of_case.case_escalation_ratio: ALYBB
      AMDBB - of_case.case_escalation_ratio: AMDBB
      ANRBB - of_case.case_escalation_ratio: ANRBB
      APWBA - of_case.case_escalation_ratio: APWBA
      ASHBA - of_case.case_escalation_ratio: ASHBA
      ATLBB - of_case.case_escalation_ratio: ATLBB
      BASBB - of_case.case_escalation_ratio: BASBB
      BCNBB - of_case.case_escalation_ratio: BCNBB
      BDOBB - of_case.case_escalation_ratio: BDOBB
      BELBB - of_case.case_escalation_ratio: BELBB
      BEYBA - of_case.case_escalation_ratio: BEYBA
      BIOBB - of_case.case_escalation_ratio: BIOBB
      BKKBB - of_case.case_escalation_ratio: BKKBB
      BLRBB - of_case.case_escalation_ratio: BLRBB
      BNDBB - of_case.case_escalation_ratio: BNDBB
      BNEBB - of_case.case_escalation_ratio: BNEBB
      BOGBB - of_case.case_escalation_ratio: BOGBB
      BOIBB - of_case.case_escalation_ratio: BOIBB
      BOSBB - of_case.case_escalation_ratio: BOSBB
      BREBB - of_case.case_escalation_ratio: BREBB
      BTMBB - of_case.case_escalation_ratio: BTMBB
      BUDBB - of_case.case_escalation_ratio: BUDBB
      BUEBB - of_case.case_escalation_ratio: BUEBB
      CAIBB - of_case.case_escalation_ratio: CAIBB
      CANBB - of_case.case_escalation_ratio: CANBB
      CASBA - of_case.case_escalation_ratio: CASBA
      CCPBB - of_case.case_escalation_ratio: CCPBB
      CCUBB - of_case.case_escalation_ratio: CCUBB
      CEBBB - of_case.case_escalation_ratio: CEBBB
      CGOBB - of_case.case_escalation_ratio: CGOBB
      CGPBB - of_case.case_escalation_ratio: CGPBB
      CGYBB - of_case.case_escalation_ratio: CGYBB
      CHCBB - of_case.case_escalation_ratio: CHCBB
      CHIBB - of_case.case_escalation_ratio: CHIBB
      CKGBB - of_case.case_escalation_ratio: CKGBB
      CLLBB - of_case.case_escalation_ratio: CLLBB
      CMBBB - of_case.case_escalation_ratio: CMBBB
      CNDBA - of_case.case_escalation_ratio: CNDBA
      COKBB - of_case.case_escalation_ratio: COKBB
      CPTBB - of_case.case_escalation_ratio: CPTBB
      CTUBB - of_case.case_escalation_ratio: CTUBB
      CWBBB - of_case.case_escalation_ratio: CWBBB
      DACBB - of_case.case_escalation_ratio: DACBB
      DADBB - of_case.case_escalation_ratio: DADBB
      DAMBB - of_case.case_escalation_ratio: DAMBB
      DARBA - of_case.case_escalation_ratio: DARBA
      DELBB - of_case.case_escalation_ratio: DELBB
      DKRBA - of_case.case_escalation_ratio: DKRBA
      DLCBB - of_case.case_escalation_ratio: DLCBB
      DMNBA - of_case.case_escalation_ratio: DMNBA
      DPSBB - of_case.case_escalation_ratio: DPSBB
      DUBBA - of_case.case_escalation_ratio: DUBBA
      DURBB - of_case.case_escalation_ratio: DURBB
      DUSBB - of_case.case_escalation_ratio: DUSBB
      DVOBB - of_case.case_escalation_ratio: DVOBB
      DXBBB - of_case.case_escalation_ratio: DXBBB
      EDKBB - of_case.case_escalation_ratio: EDKBB
      ELSBB - of_case.case_escalation_ratio: ELSBB
      FOCBB - of_case.case_escalation_ratio: FOCBB
      FREBB - of_case.case_escalation_ratio: FREBB
      GDLBB - of_case.case_escalation_ratio: GDLBB
      GDNBB - of_case.case_escalation_ratio: GDNBB
      GDYBB - of_case.case_escalation_ratio: GDYBB
      GESBB - of_case.case_escalation_ratio: GESBB
      GINBB - of_case.case_escalation_ratio: GINBB
      GOABB - of_case.case_escalation_ratio: GOABB
      GOTBB - of_case.case_escalation_ratio: GOTBB
      GUABA - of_case.case_escalation_ratio: GUABA
      GYEBB - of_case.case_escalation_ratio: GYEBB
      HALBB - of_case.case_escalation_ratio: HALBB
      HAMBB - of_case.case_escalation_ratio: HAMBB
      HANBB - of_case.case_escalation_ratio: HANBB
      HELBB - of_case.case_escalation_ratio: HELBB
      HFABA - of_case.case_escalation_ratio: HFABA
      HFEBB - of_case.case_escalation_ratio: HFEBB
      HGHBB - of_case.case_escalation_ratio: HGHBB
      HIRBA - of_case.case_escalation_ratio: HIRBA
      HKGBB - of_case.case_escalation_ratio: HKGBB
      HKTBA - of_case.case_escalation_ratio: HKTBA
      HOUBB - of_case.case_escalation_ratio: HOUBB
      HPHBB - of_case.case_escalation_ratio: HPHBB
      HREBA - of_case.case_escalation_ratio: HREBA
      HYDBB - of_case.case_escalation_ratio: HYDBB
      ICDBB - of_case.case_escalation_ratio: ICDBB
      IPSBB - of_case.case_escalation_ratio: IPSBB
      IQQBB - of_case.case_escalation_ratio: IQQBB
      ISTBA - of_case.case_escalation_ratio: ISTBA
      ISTBB - of_case.case_escalation_ratio: ISTBB
      ITJBB - of_case.case_escalation_ratio: ITJBB
      IZMBA - of_case.case_escalation_ratio: IZMBA
      IZMBB - of_case.case_escalation_ratio: IZMBB
      JEDBA - of_case.case_escalation_ratio: JEDBA
      JHBBB - of_case.case_escalation_ratio: JHBBB
      JKTBB - of_case.case_escalation_ratio: JKTBB
      JMNBB - of_case.case_escalation_ratio: JMNBB
      JNBBB - of_case.case_escalation_ratio: JNBBB
      KHHBB - of_case.case_escalation_ratio: KHHBB
      KHIBB - of_case.case_escalation_ratio: KHIBB
      KHLBB - of_case.case_escalation_ratio: KHLBB
      KLPBA - of_case.case_escalation_ratio: KLPBA
      KOPBA - of_case.case_escalation_ratio: KOPBA
      LAXBB - of_case.case_escalation_ratio: LAXBB
      LCBBB - of_case.case_escalation_ratio: LCBBB
      LEHBB - of_case.case_escalation_ratio: LEHBB
      LEXBB - of_case.case_escalation_ratio: LEXBB
      LFWBA - of_case.case_escalation_ratio: LFWBA
      LHEBB - of_case.case_escalation_ratio: LHEBB
      LIMBB - of_case.case_escalation_ratio: LIMBB
      LISBB - of_case.case_escalation_ratio: LISBB
      LIVBB - of_case.case_escalation_ratio: LIVBB
      LMSBA - of_case.case_escalation_ratio: LMSBA
      LONBB - of_case.case_escalation_ratio: LONBB
      LOSBB - of_case.case_escalation_ratio: LOSBB
      LUHBB - of_case.case_escalation_ratio: LUHBB
      LYGBB - of_case.case_escalation_ratio: LYGBB
      MAABB - of_case.case_escalation_ratio: MAABB
      MACBB - of_case.case_escalation_ratio: MACBB
      MADBB - of_case.case_escalation_ratio: MADBB
      MAOBB - of_case.case_escalation_ratio: MAOBB
      MBABA - of_case.case_escalation_ratio: MBABA
      MECBA - of_case.case_escalation_ratio: MECBA
      MELBB - of_case.case_escalation_ratio: MELBB
      MERBA - of_case.case_escalation_ratio: MERBA
      MERBB - of_case.case_escalation_ratio: MERBB
      MESBB - of_case.case_escalation_ratio: MESBB
      MEXBB - of_case.case_escalation_ratio: MEXBB
      MIBOS - of_case.case_escalation_ratio: MIBOS
      MIHOS - of_case.case_escalation_ratio: MIHOS
      MITBB - of_case.case_escalation_ratio: MITBB
      MNGBA - of_case.case_escalation_ratio: MNGBA
      MNLBB - of_case.case_escalation_ratio: MNLBB
      MOWBB - of_case.case_escalation_ratio: MOWBB
      MRSBB - of_case.case_escalation_ratio: MRSBB
      MSUBA - of_case.case_escalation_ratio: MSUBA
      MTABA - of_case.case_escalation_ratio: MTABA
      MTYBB - of_case.case_escalation_ratio: MTYBB
      MUMBB - of_case.case_escalation_ratio: MUMBB
      MVDBB - of_case.case_escalation_ratio: MVDBB
      NBOBB - of_case.case_escalation_ratio: NBOBB
      NGOBB - of_case.case_escalation_ratio: NGOBB
      NKGBB - of_case.case_escalation_ratio: NKGBB
      NSABB - of_case.case_escalation_ratio: NSABB
      NVSBA - of_case.case_escalation_ratio: NVSBA
      NYCBB - of_case.case_escalation_ratio: NYCBB
      ODSBA - of_case.case_escalation_ratio: ODSBA
      OPOBB - of_case.case_escalation_ratio: OPOBB
      OSABB - of_case.case_escalation_ratio: OSABB
      PAIBB - of_case.case_escalation_ratio: PAIBB
      PANBA - of_case.case_escalation_ratio: PANBA
      PANBB - of_case.case_escalation_ratio: PANBB
      PAVBB - of_case.case_escalation_ratio: PAVBB
      PENBB - of_case.case_escalation_ratio: PENBB
      PIRAEU - of_case.case_escalation_ratio: PIRAE
      PKGBB - of_case.case_escalation_ratio: PKGBB
      PLMBB - of_case.case_escalation_ratio: PLMBB
      PLZBB - of_case.case_escalation_ratio: PLZBB
      PNHBA - of_case.case_escalation_ratio: PNHBA
      PNQBB - of_case.case_escalation_ratio: PNQBB
      PPGBA - of_case.case_escalation_ratio: PPGBA
      PPTBA - of_case.case_escalation_ratio: PPTBA
      PRGBB - of_case.case_escalation_ratio: PRGBB
      PSDBB - of_case.case_escalation_ratio: PSDBB
      PTIBA - of_case.case_escalation_ratio: PTIBA
      PTSBA - of_case.case_escalation_ratio: PTSBA
      PUSBB - of_case.case_escalation_ratio: PUSBB
      QITBA - of_case.case_escalation_ratio: QITBA
      RHUBA - of_case.case_escalation_ratio: RHUBA
      RICBB - of_case.case_escalation_ratio: RICBB
      RIXBA - of_case.case_escalation_ratio: RIXBA
      RJKBA - of_case.case_escalation_ratio: RJKBA
      RTMBB - of_case.case_escalation_ratio: RTMBB
      SALBA - of_case.case_escalation_ratio: SALBA
      SAOBB - of_case.case_escalation_ratio: SAOBB
      SCLBB - of_case.case_escalation_ratio: SCLBB
      SEABB - of_case.case_escalation_ratio: SEABB
      SELBB - of_case.case_escalation_ratio: SELBB
      SFOBB - of_case.case_escalation_ratio: SFOBB
      SFSBB - of_case.case_escalation_ratio: SFSBB
      SGNBB - of_case.case_escalation_ratio: SGNBB
      SGZBB - of_case.case_escalation_ratio: SGZBB
      SHABB - of_case.case_escalation_ratio: SHABB
      SIABB - of_case.case_escalation_ratio: SIABB
      SINBB - of_case.case_escalation_ratio: SINBB
      SINHO - of_case.case_escalation_ratio: SINHO
      SJOBA - of_case.case_escalation_ratio: SJOBA
      SJWBB - of_case.case_escalation_ratio: SJWBB
      SKGBA - of_case.case_escalation_ratio: SKGBA
      SMZBA - of_case.case_escalation_ratio: SMZBA
      SOUBB - of_case.case_escalation_ratio: SOUBB
      SPBBB - of_case.case_escalation_ratio: SPBBB
      SPROS - of_case.case_escalation_ratio: SPROS
      SRGBB - of_case.case_escalation_ratio: SRGBB
      SSZBB - of_case.case_escalation_ratio: SSZBB
      STRBB - of_case.case_escalation_ratio: STRBB
      SUBBB - of_case.case_escalation_ratio: SUBBB
      SUDBB - of_case.case_escalation_ratio: SUDBB
      SUVBA - of_case.case_escalation_ratio: SUVBA
      SUZBB - of_case.case_escalation_ratio: SUZBB
      SYDBB - of_case.case_escalation_ratio: SYDBB
      SZHBB - of_case.case_escalation_ratio: SZHBB
      SZPBB - of_case.case_escalation_ratio: SZPBB
      TAOBB - of_case.case_escalation_ratio: TAOBB
      TBUBA - of_case.case_escalation_ratio: TBUBA
      TEMBB - of_case.case_escalation_ratio: TEMBB
      TGCBA - of_case.case_escalation_ratio: TGCBA
      TLLBA - of_case.case_escalation_ratio: TLLBA
      TLVBA - of_case.case_escalation_ratio: TLVBA
      TORBB - of_case.case_escalation_ratio: TORBB
      TPEBB - of_case.case_escalation_ratio: TPEBB
      TPPBB - of_case.case_escalation_ratio: TPPBB
      TRWBA - of_case.case_escalation_ratio: TRWBA
      TSNBB - of_case.case_escalation_ratio: TSNBB
      TUNBA - of_case.case_escalation_ratio: TUNBA
      TUTBB - of_case.case_escalation_ratio: TUTBB
      TXGBB - of_case.case_escalation_ratio: TXGBB
      TYOBB - of_case.case_escalation_ratio: TYOBB
      VANBB - of_case.case_escalation_ratio: VANBB
      VAPBB - of_case.case_escalation_ratio: VAPBB
      VARBA - of_case.case_escalation_ratio: VARBA
      VGOBB - of_case.case_escalation_ratio: VGOBB
      VLCBB - of_case.case_escalation_ratio: VLCBB
      VLIBA - of_case.case_escalation_ratio: VLIBA
      VNABB - of_case.case_escalation_ratio: VNABB
      VTZBB - of_case.case_escalation_ratio: VTZBB
      VVABB - of_case.case_escalation_ratio: VVABB
      WGZOS - of_case.case_escalation_ratio: WGZOS
      WMLOS - of_case.case_escalation_ratio: WMLOS
      WNKOS - of_case.case_escalation_ratio: WNKOS
      WUHBB - of_case.case_escalation_ratio: WUHBB
      XMNBB - of_case.case_escalation_ratio: XMNBB
      YGNBB - of_case.case_escalation_ratio: YGNBB
      ZHOBB - of_case.case_escalation_ratio: ZHOBB
      ZHUBB - of_case.case_escalation_ratio: ZHUBB
      ZLOBB - of_case.case_escalation_ratio: ZLOBB
      of_case.Case_Geo___null - of_case.case_escalation_ratio: "∅"
    series_point_styles:
      global_target_chat: diamond
    show_null_points: true
    interpolation: monotone
    defaults_version: 1
    hidden_fields: [of_case.case_distinct_count, of_case.number_of_escalated_cases,
      of_case.target_measure_for_Chat2, of_case.target_measure_for_WEB2, of_case.target_for_chat,
      of_case.target_for_web]
    hidden_pivots:
      Global:
        measure_names: []
      HKGHQ:
        measure_names: []
      LONHQ:
        measure_names: []
      RICHQ:
        measure_names: []
      SAOHQ:
        measure_names: []
      SINHQ:
        measure_names: []
      Unclaimed:
        measure_names: []
    note_state: collapsed
    note_display: hover
    note_text: "<P style=\"text-align:left;\"><B>Metric Name : </B>Case Escalation\
      \ Ratio<BR><B>How it Helps : </B>To evaluate no. of Escalated cases\n<BR>[ALL\
      \ Case Status, Total Escalation>0 vs Total Case]\t\t\t\t\t\t\t\t\t\t\t\t\t\t\
      \t\t\t\t\t\n"
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Sub Resolution Reason: of_case.sub_resolution_reason
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Priority: of_case.priority
      Category (L1): of_case.reason
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 50
    col: 11
    width: 11
    height: 9
  - title: Chat + WebForm Usage
    name: Chat + WebForm Usage
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.createddate_dynamic, of_case.deflection_ratio, of_case.target_for_ChatWeb_Form_Usage,
      of_case.Case_Geo_C_W_Usage]
    pivots: [of_case.Case_Geo_C_W_Usage]
    filters:
      of_case.origin: ''
      case_owner.name: ''
      of_sales_team_member.team_role: ''
      of_customer_group.key_acct_tp_cd: ''
      of_customer_group.cust_grp_and_name: ''
      of_customer.customer_cd_and_name: ''
      of_escalation_history.role: ''
      case_owner.profile_name_service: ''
      of_customer.customer_type: ''
      of_case_history_air.status_case_Analysis: ''
      of_chat_transcript.origin: ''
      of_queue.developer_name: ''
      case_owner.officetype: ''
      of_contact.name: ''
      user_office_hierarchy.regional_head_office_short_nm: ''
      user_office_hierarchy.office_code: ''
      user_office_hierarchy.country: ''
      of_case.Case_Geo_C_W_Usage: "-Others,-Sales Executive,-No KA Mapping,-ONECare\
        \ Queue"
    sorts: [of_case.createddate_dynamic, of_case.Case_Geo_C_W_Usage]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields: [{category: measure, expression: !!null '', label: Automation,
        value_format: !!null '', value_format_name: !!null '', based_on: of_case.case_distinct_count,
        _kind_hint: measure, measure: automation, type: count_distinct, _type_hint: number,
        filters: {of_case.is_resolved_by_automation: 'Yes', of_case.Automation_Type: 'D&D,LFD,Self-Service'}},
      {category: table_calculation, expression: "${automation}/${of_case.case_distinct_count}",
        label: Automation Ratio, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: automation_ratio, _type_hint: number,
        is_disabled: true}, {category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_ChatWeb_Form_Usage})),-10))

          ', label: Global Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target, _type_hint: number}]
    query_timezone: UTC
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
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.deflection_ratio,
            id: HKGHQ - of_case.deflection_ratio, name: HKGHQ - Case Deflection Ratio},
          {axisId: of_case.dynamic_reference, id: HKGHQ - of_case.dynamic_reference,
            name: HKGHQ - Case DYNAMIC REFERENCE}, {axisId: of_case.deflection_ratio,
            id: LONHQ - of_case.deflection_ratio, name: LONHQ - Case Deflection Ratio},
          {axisId: of_case.dynamic_reference, id: LONHQ - of_case.dynamic_reference,
            name: LONHQ - Case DYNAMIC REFERENCE}, {axisId: of_case.deflection_ratio,
            id: RICHQ - of_case.deflection_ratio, name: RICHQ - Case Deflection Ratio},
          {axisId: of_case.dynamic_reference, id: RICHQ - of_case.dynamic_reference,
            name: RICHQ - Case DYNAMIC REFERENCE}, {axisId: of_case.deflection_ratio,
            id: SAOHQ - of_case.deflection_ratio, name: SAOHQ - Case Deflection Ratio},
          {axisId: of_case.dynamic_reference, id: SAOHQ - of_case.dynamic_reference,
            name: SAOHQ - Case DYNAMIC REFERENCE}, {axisId: of_case.deflection_ratio,
            id: SINHQ - of_case.deflection_ratio, name: SINHQ - Case Deflection Ratio},
          {axisId: of_case.dynamic_reference, id: SINHQ - of_case.dynamic_reference,
            name: SINHQ - Case DYNAMIC REFERENCE}, {axisId: of_case.deflection_ratio,
            id: Row Total - of_case.deflection_ratio, name: Row Total - Case Deflection
              Ratio}, {axisId: of_case.dynamic_reference, id: Row Total - of_case.dynamic_reference,
            name: Row Total - Case DYNAMIC REFERENCE}, {axisId: global, id: global,
            name: FY 23 Global Target}], showLabels: false, showValues: false, minValue: 0,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      Row Total - of_case.Automation_ratio: line
      Row Total - of_case.deflection_ratio: line
      global: line
      global_target_chat: line
      global_target_web: line
      global_target: line
    series_colors:
      Row Total - of_case.Automation_ratio: "#F39200"
      HKGHQ - of_case.Automation_ratio: "#db72af"
      LONHQ - of_case.Automation_ratio: "#00506D"
      RICHQ - of_case.Automation_ratio: "#84C5C3"
      SAOHQ - of_case.Automation_ratio: "#BD0F72"
      SINHQ - of_case.Automation_ratio: "#8b908f"
      global: "#340335"
      Row Total - of_case.dynamic_reference: "#F39200"
      global_target_chat: "#70AD47"
      global_target_web: "#00B050"
      Unclaimed - of_case.deflection_ratio: "#F39200"
      LONHQ - of_case.deflection_ratio: "#00506D"
      RICHQ - of_case.deflection_ratio: "#84C5C3"
      SAOHQ - of_case.deflection_ratio: "#BD0F72"
      SINHQ - of_case.deflection_ratio: "#8b908f"
      HKGHQ - of_case.deflection_ratio: "#db72af"
      Row Total - of_case.deflection_ratio: "#F39200"
      global_target: "#70AD47"
    series_labels:
      Row Total - of_case.Automation_ratio: Total
      1 - of_case.Automation_ratio: GKA
      2 - of_case.Automation_ratio: RKA
      3 - of_case.Automation_ratio: LKA
      4 - of_case.Automation_ratio: ONECare
      global: FY 23 Global Target
      HKGHQ - of_case.deflection_ratio: HKGHQ
      LONHQ - of_case.deflection_ratio: LONHQ
      RICHQ - of_case.deflection_ratio: RICHQ
      SAOHQ - of_case.deflection_ratio: SAOHQ
      SINHQ - of_case.deflection_ratio: SINHQ
      Row Total - of_case.deflection_ratio: Total
      Unclaimed - of_case.deflection_ratio: Unclaimed
      global_target_chat: FY2025 Global Uniform Target
      Global - of_case.deflection_ratio: Global
      Chat - of_case.deflection_ratio: Chat
      Email - of_case.deflection_ratio: Email
      Manual - of_case.deflection_ratio: Manual
      Web - of_case.deflection_ratio: Web
      Phone - of_case.deflection_ratio: Phone
      1 - of_case.deflection_ratio: GKA
      2 - of_case.deflection_ratio: RKA
      3 - of_case.deflection_ratio: LKA
      4 - of_case.deflection_ratio: ONECare
      CCA - of_case.deflection_ratio: CCA
      CCS - of_case.deflection_ratio: CCS
      Others - of_case.deflection_ratio: Others
      Sales Executive - of_case.deflection_ratio: Sales Executive
      C-KAM - of_case.deflection_ratio: C-KAM
      C-KAS - of_case.deflection_ratio: C-KAS
      No KA Mapping - of_case.deflection_ratio: No KA Mapping
      ONECare Queue - of_case.deflection_ratio: ONECare Queue
      S-KAM - of_case.deflection_ratio: S-KAM
      S-KAS - of_case.deflection_ratio: S-KAS
      Onshore - of_case.deflection_ratio: Onshore
      Offshore - of_case.deflection_ratio: Offshore
      Complaint/Feedback - of_case.deflection_ratio: Complaint/Feedback
      Complex - of_case.deflection_ratio: Complex
      General Information - of_case.deflection_ratio: General Information
      Inquiry - of_case.deflection_ratio: Inquiry
      Internal - of_case.deflection_ratio: Internal
      Service Request - of_case.deflection_ratio: Service Request
      Service Failure - of_case.deflection_ratio: Service Failure
      Transactional - of_case.deflection_ratio: Transactional
      No Action Required - of_case.deflection_ratio: No Action Required
      Internal Request - of_case.deflection_ratio: Internal Request
      GKA - of_case.deflection_ratio: GKA
      LKA - of_case.deflection_ratio: LKA
      ONECare - of_case.deflection_ratio: ONECare
      RKA - of_case.deflection_ratio: RKA
      AE - of_case.deflection_ratio: AE
      AR - of_case.deflection_ratio: AR
      AT & HU - of_case.deflection_ratio: AT & HU
      AU - of_case.deflection_ratio: AU
      BD - of_case.deflection_ratio: BD
      BR - of_case.deflection_ratio: BR
      BE - of_case.deflection_ratio: BE
      CH - of_case.deflection_ratio: CH
      CL - of_case.deflection_ratio: CL
      CN - of_case.deflection_ratio: CN
      CO - of_case.deflection_ratio: CO
      DE - of_case.deflection_ratio: DE
      CZ & SK - of_case.deflection_ratio: CZ & SK
      EC - of_case.deflection_ratio: EC
      DK - of_case.deflection_ratio: DK
      EG - of_case.deflection_ratio: EG
      ES - of_case.deflection_ratio: ES
      LK - of_case.deflection_ratio: LK
      IT - of_case.deflection_ratio: IT
      FI - of_case.deflection_ratio: FI
      FR - of_case.deflection_ratio: FR
      GB - of_case.deflection_ratio: GB
      GH - of_case.deflection_ratio: GH
      HK & SCN - of_case.deflection_ratio: HK & SCN
      ID - of_case.deflection_ratio: ID
      IL - of_case.deflection_ratio: IL
      IN - of_case.deflection_ratio: IN
      JP - of_case.deflection_ratio: JP
      KR - of_case.deflection_ratio: KR
      MA - of_case.deflection_ratio: MA
      MM - of_case.deflection_ratio: MM
      MX - of_case.deflection_ratio: MX
      MY - of_case.deflection_ratio: MY
      TR - of_case.deflection_ratio: TR
      TW - of_case.deflection_ratio: TW
      TH - of_case.deflection_ratio: TH
      SE & NO - of_case.deflection_ratio: SE & NO
      NG - of_case.deflection_ratio: NG
      NL - of_case.deflection_ratio: NL
      NZ - of_case.deflection_ratio: NZ
      PA - of_case.deflection_ratio: PA
      PE - of_case.deflection_ratio: PE
      PH - of_case.deflection_ratio: PH
      PK - of_case.deflection_ratio: PK
      PL - of_case.deflection_ratio: PL
      PT - of_case.deflection_ratio: PT
      SG - of_case.deflection_ratio: SG
      US - of_case.deflection_ratio: US
      UY - of_case.deflection_ratio: UY
      ZA - of_case.deflection_ratio: ZA
      CA - of_case.deflection_ratio: CA
      CI - of_case.deflection_ratio: CI
      AT - of_case.deflection_ratio: AT
      CZ - of_case.deflection_ratio: CZ
      IE - of_case.deflection_ratio: IE
      SK - of_case.deflection_ratio: SK
      VN - of_case.deflection_ratio: VN
      NO - of_case.deflection_ratio: 'NO'
      AS - of_case.deflection_ratio: AS
      BG - of_case.deflection_ratio: BG
      CR - of_case.deflection_ratio: CR
      CY - of_case.deflection_ratio: CY
      DZ - of_case.deflection_ratio: DZ
      EE - of_case.deflection_ratio: EE
      FJ - of_case.deflection_ratio: FJ
      GE - of_case.deflection_ratio: GE
      GR - of_case.deflection_ratio: GR
      GT - of_case.deflection_ratio: GT
      HK - of_case.deflection_ratio: HK
      HN - of_case.deflection_ratio: HN
      HR - of_case.deflection_ratio: HR
      HU - of_case.deflection_ratio: HU
      KE - of_case.deflection_ratio: KE
      KH - of_case.deflection_ratio: KH
      KI - of_case.deflection_ratio: KI
      LB - of_case.deflection_ratio: LB
      LT - of_case.deflection_ratio: LT
      LS - of_case.deflection_ratio: LS
      LV - of_case.deflection_ratio: LV
      MO - of_case.deflection_ratio: MO
      MT - of_case.deflection_ratio: MT
      NI - of_case.deflection_ratio: NI
      PF - of_case.deflection_ratio: PF
      RO - of_case.deflection_ratio: RO
      SA - of_case.deflection_ratio: SA
      SB - of_case.deflection_ratio: SB
      SI - of_case.deflection_ratio: SI
      SN - of_case.deflection_ratio: SN
      SV - of_case.deflection_ratio: SV
      TG - of_case.deflection_ratio: TG
      TJ - of_case.deflection_ratio: TJ
      TN - of_case.deflection_ratio: TN
      TO - of_case.deflection_ratio: TO
      TT - of_case.deflection_ratio: TT
      UA - of_case.deflection_ratio: UA
      VU - of_case.deflection_ratio: VU
      WS - of_case.deflection_ratio: WS
      ZW - of_case.deflection_ratio: ZW
      ZZ - of_case.deflection_ratio: ZZ
      AARBB - of_case.deflection_ratio: AARBB
      ABJBB - of_case.deflection_ratio: ABJBB
      ADLBB - of_case.deflection_ratio: ADLBB
      AKLBB - of_case.deflection_ratio: AKLBB
      ALGBB - of_case.deflection_ratio: ALGBB
      ALJBA - of_case.deflection_ratio: ALJBA
      ALYBB - of_case.deflection_ratio: ALYBB
      AMDBB - of_case.deflection_ratio: AMDBB
      ANRBB - of_case.deflection_ratio: ANRBB
      APWBA - of_case.deflection_ratio: APWBA
      ASHBA - of_case.deflection_ratio: ASHBA
      ATLBB - of_case.deflection_ratio: ATLBB
      BASBB - of_case.deflection_ratio: BASBB
      BCNBB - of_case.deflection_ratio: BCNBB
      BDOBB - of_case.deflection_ratio: BDOBB
      BELBB - of_case.deflection_ratio: BELBB
      BEYBA - of_case.deflection_ratio: BEYBA
      BIOBB - of_case.deflection_ratio: BIOBB
      BKKBB - of_case.deflection_ratio: BKKBB
      BLRBB - of_case.deflection_ratio: BLRBB
      BNDBB - of_case.deflection_ratio: BNDBB
      BNEBB - of_case.deflection_ratio: BNEBB
      BOGBB - of_case.deflection_ratio: BOGBB
      BOIBB - of_case.deflection_ratio: BOIBB
      BOSBB - of_case.deflection_ratio: BOSBB
      BREBB - of_case.deflection_ratio: BREBB
      BTMBB - of_case.deflection_ratio: BTMBB
      BUDBB - of_case.deflection_ratio: BUDBB
      BUEBB - of_case.deflection_ratio: BUEBB
      CAIBB - of_case.deflection_ratio: CAIBB
      CANBB - of_case.deflection_ratio: CANBB
      CASBA - of_case.deflection_ratio: CASBA
      CCPBB - of_case.deflection_ratio: CCPBB
      CCUBB - of_case.deflection_ratio: CCUBB
      CEBBB - of_case.deflection_ratio: CEBBB
      CGOBB - of_case.deflection_ratio: CGOBB
      CGPBB - of_case.deflection_ratio: CGPBB
      CGYBB - of_case.deflection_ratio: CGYBB
      CHCBB - of_case.deflection_ratio: CHCBB
      CHIBB - of_case.deflection_ratio: CHIBB
      CKGBB - of_case.deflection_ratio: CKGBB
      CLLBB - of_case.deflection_ratio: CLLBB
      CMBBB - of_case.deflection_ratio: CMBBB
      CNDBA - of_case.deflection_ratio: CNDBA
      COKBB - of_case.deflection_ratio: COKBB
      CPTBB - of_case.deflection_ratio: CPTBB
      CTUBB - of_case.deflection_ratio: CTUBB
      CWBBB - of_case.deflection_ratio: CWBBB
      DACBB - of_case.deflection_ratio: DACBB
      DADBB - of_case.deflection_ratio: DADBB
      DAMBB - of_case.deflection_ratio: DAMBB
      DARBA - of_case.deflection_ratio: DARBA
      DELBB - of_case.deflection_ratio: DELBB
      DKRBA - of_case.deflection_ratio: DKRBA
      DLCBB - of_case.deflection_ratio: DLCBB
      DMNBA - of_case.deflection_ratio: DMNBA
      DPSBB - of_case.deflection_ratio: DPSBB
      DUBBA - of_case.deflection_ratio: DUBBA
      DURBB - of_case.deflection_ratio: DURBB
      DUSBB - of_case.deflection_ratio: DUSBB
      DVOBB - of_case.deflection_ratio: DVOBB
      DXBBB - of_case.deflection_ratio: DXBBB
      EDKBB - of_case.deflection_ratio: EDKBB
      ELSBB - of_case.deflection_ratio: ELSBB
      FOCBB - of_case.deflection_ratio: FOCBB
      FREBB - of_case.deflection_ratio: FREBB
      GDLBB - of_case.deflection_ratio: GDLBB
      GDNBB - of_case.deflection_ratio: GDNBB
      GDYBB - of_case.deflection_ratio: GDYBB
      GESBB - of_case.deflection_ratio: GESBB
      GINBB - of_case.deflection_ratio: GINBB
      GOABB - of_case.deflection_ratio: GOABB
      GOTBB - of_case.deflection_ratio: GOTBB
      GUABA - of_case.deflection_ratio: GUABA
      GYEBB - of_case.deflection_ratio: GYEBB
      HALBB - of_case.deflection_ratio: HALBB
      HAMBB - of_case.deflection_ratio: HAMBB
      HANBB - of_case.deflection_ratio: HANBB
      HELBB - of_case.deflection_ratio: HELBB
      HFABA - of_case.deflection_ratio: HFABA
      HFEBB - of_case.deflection_ratio: HFEBB
      HGHBB - of_case.deflection_ratio: HGHBB
      HIRBA - of_case.deflection_ratio: HIRBA
      HKGBB - of_case.deflection_ratio: HKGBB
      HKTBA - of_case.deflection_ratio: HKTBA
      HOUBB - of_case.deflection_ratio: HOUBB
      HPHBB - of_case.deflection_ratio: HPHBB
      HREBA - of_case.deflection_ratio: HREBA
      HYDBB - of_case.deflection_ratio: HYDBB
      ICDBB - of_case.deflection_ratio: ICDBB
      IPSBB - of_case.deflection_ratio: IPSBB
      IQQBB - of_case.deflection_ratio: IQQBB
      ISTBA - of_case.deflection_ratio: ISTBA
      ISTBB - of_case.deflection_ratio: ISTBB
      ITJBB - of_case.deflection_ratio: ITJBB
      IZMBA - of_case.deflection_ratio: IZMBA
      IZMBB - of_case.deflection_ratio: IZMBB
      JEDBA - of_case.deflection_ratio: JEDBA
      JHBBB - of_case.deflection_ratio: JHBBB
      JKTBB - of_case.deflection_ratio: JKTBB
      JMNBB - of_case.deflection_ratio: JMNBB
      JNBBB - of_case.deflection_ratio: JNBBB
      KHHBB - of_case.deflection_ratio: KHHBB
      KHIBB - of_case.deflection_ratio: KHIBB
      KHLBB - of_case.deflection_ratio: KHLBB
      KLPBA - of_case.deflection_ratio: KLPBA
      KOPBA - of_case.deflection_ratio: KOPBA
      LAXBB - of_case.deflection_ratio: LAXBB
      LCBBB - of_case.deflection_ratio: LCBBB
      LEHBB - of_case.deflection_ratio: LEHBB
      LEXBB - of_case.deflection_ratio: LEXBB
      LFWBA - of_case.deflection_ratio: LFWBA
      LHEBB - of_case.deflection_ratio: LHEBB
      LIMBB - of_case.deflection_ratio: LIMBB
      LISBB - of_case.deflection_ratio: LISBB
      LIVBB - of_case.deflection_ratio: LIVBB
      LMSBA - of_case.deflection_ratio: LMSBA
      LONBB - of_case.deflection_ratio: LONBB
      LOSBB - of_case.deflection_ratio: LOSBB
      LUHBB - of_case.deflection_ratio: LUHBB
      LYGBB - of_case.deflection_ratio: LYGBB
      MAABB - of_case.deflection_ratio: MAABB
      MACBB - of_case.deflection_ratio: MACBB
      MADBB - of_case.deflection_ratio: MADBB
      MAOBB - of_case.deflection_ratio: MAOBB
      MBABA - of_case.deflection_ratio: MBABA
      MECBA - of_case.deflection_ratio: MECBA
      MELBB - of_case.deflection_ratio: MELBB
      MERBA - of_case.deflection_ratio: MERBA
      MERBB - of_case.deflection_ratio: MERBB
      MESBB - of_case.deflection_ratio: MESBB
      MEXBB - of_case.deflection_ratio: MEXBB
      MIBOS - of_case.deflection_ratio: MIBOS
      MIHOS - of_case.deflection_ratio: MIHOS
      MITBB - of_case.deflection_ratio: MITBB
      MNGBA - of_case.deflection_ratio: MNGBA
      MNLBB - of_case.deflection_ratio: MNLBB
      MOWBB - of_case.deflection_ratio: MOWBB
      MRSBB - of_case.deflection_ratio: MRSBB
      MSUBA - of_case.deflection_ratio: MSUBA
      MTABA - of_case.deflection_ratio: MTABA
      MTYBB - of_case.deflection_ratio: MTYBB
      MUMBB - of_case.deflection_ratio: MUMBB
      MVDBB - of_case.deflection_ratio: MVDBB
      NBOBB - of_case.deflection_ratio: NBOBB
      NGOBB - of_case.deflection_ratio: NGOBB
      NKGBB - of_case.deflection_ratio: NKGBB
      NSABB - of_case.deflection_ratio: NSABB
      NVSBA - of_case.deflection_ratio: NVSBA
      NYCBB - of_case.deflection_ratio: NYCBB
      ODSBA - of_case.deflection_ratio: ODSBA
      OPOBB - of_case.deflection_ratio: OPOBB
      OSABB - of_case.deflection_ratio: OSABB
      PAIBB - of_case.deflection_ratio: PAIBB
      PANBA - of_case.deflection_ratio: PANBA
      PANBB - of_case.deflection_ratio: PANBB
      PAVBB - of_case.deflection_ratio: PAVBB
      PENBB - of_case.deflection_ratio: PENBB
      PIRAEU - of_case.deflection_ratio: PIRAE
      PKGBB - of_case.deflection_ratio: PKGBB
      PLMBB - of_case.deflection_ratio: PLMBB
      PLZBB - of_case.deflection_ratio: PLZBB
      PNHBA - of_case.deflection_ratio: PNHBA
      PNQBB - of_case.deflection_ratio: PNQBB
      PPGBA - of_case.deflection_ratio: PPGBA
      PPTBA - of_case.deflection_ratio: PPTBA
      PRGBB - of_case.deflection_ratio: PRGBB
      PSDBB - of_case.deflection_ratio: PSDBB
      PTIBA - of_case.deflection_ratio: PTIBA
      PTSBA - of_case.deflection_ratio: PTSBA
      PUSBB - of_case.deflection_ratio: PUSBB
      QITBA - of_case.deflection_ratio: QITBA
      RHUBA - of_case.deflection_ratio: RHUBA
      RICBB - of_case.deflection_ratio: RICBB
      RIXBA - of_case.deflection_ratio: RIXBA
      RJKBA - of_case.deflection_ratio: RJKBA
      RTMBB - of_case.deflection_ratio: RTMBB
      SALBA - of_case.deflection_ratio: SALBA
      SAOBB - of_case.deflection_ratio: SAOBB
      SCLBB - of_case.deflection_ratio: SCLBB
      SEABB - of_case.deflection_ratio: SEABB
      SELBB - of_case.deflection_ratio: SELBB
      SFOBB - of_case.deflection_ratio: SFOBB
      SFSBB - of_case.deflection_ratio: SFSBB
      SGNBB - of_case.deflection_ratio: SGNBB
      SGZBB - of_case.deflection_ratio: SGZBB
      SHABB - of_case.deflection_ratio: SHABB
      SIABB - of_case.deflection_ratio: SIABB
      SINBB - of_case.deflection_ratio: SINBB
      SINHO - of_case.deflection_ratio: SINHO
      SJOBA - of_case.deflection_ratio: SJOBA
      SJWBB - of_case.deflection_ratio: SJWBB
      SKGBA - of_case.deflection_ratio: SKGBA
      SMZBA - of_case.deflection_ratio: SMZBA
      SOUBB - of_case.deflection_ratio: SOUBB
      SPBBB - of_case.deflection_ratio: SPBBB
      SPROS - of_case.deflection_ratio: SPROS
      SRGBB - of_case.deflection_ratio: SRGBB
      SSZBB - of_case.deflection_ratio: SSZBB
      STRBB - of_case.deflection_ratio: STRBB
      SUBBB - of_case.deflection_ratio: SUBBB
      SUDBB - of_case.deflection_ratio: SUDBB
      SUVBA - of_case.deflection_ratio: SUVBA
      SUZBB - of_case.deflection_ratio: SUZBB
      SYDBB - of_case.deflection_ratio: SYDBB
      SZHBB - of_case.deflection_ratio: SZHBB
      SZPBB - of_case.deflection_ratio: SZPBB
      TAOBB - of_case.deflection_ratio: TAOBB
      TBUBA - of_case.deflection_ratio: TBUBA
      TEMBB - of_case.deflection_ratio: TEMBB
      TGCBA - of_case.deflection_ratio: TGCBA
      TLLBA - of_case.deflection_ratio: TLLBA
      TLVBA - of_case.deflection_ratio: TLVBA
      TORBB - of_case.deflection_ratio: TORBB
      TPEBB - of_case.deflection_ratio: TPEBB
      TPPBB - of_case.deflection_ratio: TPPBB
      TRWBA - of_case.deflection_ratio: TRWBA
      TSNBB - of_case.deflection_ratio: TSNBB
      TUNBA - of_case.deflection_ratio: TUNBA
      TUTBB - of_case.deflection_ratio: TUTBB
      TXGBB - of_case.deflection_ratio: TXGBB
      TYOBB - of_case.deflection_ratio: TYOBB
      VANBB - of_case.deflection_ratio: VANBB
      VAPBB - of_case.deflection_ratio: VAPBB
      VARBA - of_case.deflection_ratio: VARBA
      VGOBB - of_case.deflection_ratio: VGOBB
      VLCBB - of_case.deflection_ratio: VLCBB
      VLIBA - of_case.deflection_ratio: VLIBA
      VNABB - of_case.deflection_ratio: VNABB
      VTZBB - of_case.deflection_ratio: VTZBB
      VVABB - of_case.deflection_ratio: VVABB
      WGZOS - of_case.deflection_ratio: WGZOS
      WMLOS - of_case.deflection_ratio: WMLOS
      WNKOS - of_case.deflection_ratio: WNKOS
      WUHBB - of_case.deflection_ratio: WUHBB
      XMNBB - of_case.deflection_ratio: XMNBB
      YGNBB - of_case.deflection_ratio: YGNBB
      ZHOBB - of_case.deflection_ratio: ZHOBB
      ZHUBB - of_case.deflection_ratio: ZHUBB
      ZLOBB - of_case.deflection_ratio: ZLOBB
      of_case.Case_Geo___null - of_case.deflection_ratio: "∅"
      global_target: FY2025 Global Uniform Target
    series_point_styles:
      global_target_chat: diamond
      global_target: diamond
    show_null_points: true
    interpolation: monotone
    defaults_version: 1
    hidden_fields: [of_case.target_measure_for_Chat2, of_case.target_for_ChatWeb_Form_Usage]
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Chat + WebForm Usage
      <BR><B>How it Helps : </B>Measure how well our Customers are satisfied with
      the service that they receive from our agents and Platform Integration User
      bot<BR>[Total no. of Chat & Web / Total cases]'
    hidden_pivots: {}
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Resolution Reason: of_case.resolution_reason
      Case Number: of_case.casenumber
      Contract Number: of_case.contract_number
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Sub Resolution Reason: of_case.sub_resolution_reason
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Priority: of_case.priority
      Category (L1): of_case.reason
      Service Type: of_case.type
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Has Leave Message: of_case.has_leave_message_filter
    row: 5
    col: 10
    width: 11
    height: 9
  - title: Chat FRT Target Achievement
    name: Chat FRT Target Achievement
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.createddate_dynamic, of_case.Case_Geo, of_case.target_for_chat,
      of_case.Achieved_FRT_ratio]
    pivots: [of_case.Case_Geo]
    filters:
      of_case.is_channel_applicable_for_FRT: 'Yes'
      channel_filter: Chat
    sorts: [of_case.createddate_dynamic, of_case.Case_Geo]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields: [{category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_web})),-10))',
        label: Global Target (Web), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target_web, _type_hint: number,
        is_disabled: true}, {category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_chat})),-10))

          ', label: Global Target (Chat), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target_chat, _type_hint: number},
      {category: dimension, expression: "${of_case.origin}", label: Channel Filter,
        value_format: !!null '', value_format_name: !!null '', dimension: channel_filter,
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
    stacking: ''
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
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: Row Total - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: Total}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: HKGHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: HKGHQ}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: LONHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: LONHQ}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: RICHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: RICHQ}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: SAOHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: SAOHQ}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: SINHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: SINHQ}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: Unclaimed - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: Unclaimed -
              Case Average First Response Time New}, {axisId: of_case.dynamic_reference,
            id: Row Total - of_case.dynamic_reference, name: FY 23 - Global Target}],
        showLabels: false, showValues: false, minValue: 0, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: false
    label_value_format: ''
    series_types:
      Row Total - of_case.AVG_FIRST_RESPONSE_TIME: line
      Row Total - of_case.AVG_FIRST_RESPONSE_TIME_NEW: line
      global_target: line
      hkghq_target: line
      lonhq_target: line
      richq_target: line
      sinhq_target: line
      saohq_target: line
      hkghq: line
      lonhq: line
      richq: line
      sinhq: line
      saohq: line
      global: line
      Row Total - of_case.dynamic_reference: line
      global_target_web: line
      global_target_chat: line
      Row Total - of_case.Achieved_FRT_ratio: line
    series_colors:
      HKGHQ - of_case.Achieved_FRT_ratio: "#db72af"
      LONHQ - of_case.Achieved_FRT_ratio: "#00506D"
      RICHQ - of_case.Achieved_FRT_ratio: "#84C5C3"
      SAOHQ - of_case.Achieved_FRT_ratio: "#BD0F72"
      SINHQ - of_case.Achieved_FRT_ratio: "#8b908f"
      Row Total - of_case.Achieved_FRT_ratio: "#F39200"
      global_target: "#f277aa"
      global: "#340335"
      global_target_chat: "#70AD47"
      global_target_web: "#00B050"
    series_labels:
      1 - of_case.Achieved_FRT_ratio: GKA
      2 - of_case.Achieved_FRT_ratio: RKA
      3 - of_case.Achieved_FRT_ratio: LKA
      4 - of_case.Achieved_FRT_ratio: ONECare
      Row Total - of_case.Achieved_FRT_ratio: Total
      HKGHQ - of_case.Achieved_FRT_ratio: HKGHQ
      LONHQ - of_case.Achieved_FRT_ratio: LONHQ
      RICHQ - of_case.Achieved_FRT_ratio: RICHQ
      SAOHQ - of_case.Achieved_FRT_ratio: SAOHQ
      SINHQ - of_case.Achieved_FRT_ratio: SINHQ
      Global - of_case.Achieved_FRT_ratio: Global
      Chat - of_case.Achieved_FRT_ratio: Chat
      Email - of_case.Achieved_FRT_ratio: Email
      Manual - of_case.Achieved_FRT_ratio: Manual
      Web - of_case.Achieved_FRT_ratio: Web
      Phone - of_case.Achieved_FRT_ratio: Phone
      CCA - of_case.Achieved_FRT_ratio: CCA
      CCS - of_case.Achieved_FRT_ratio: CCS
      Others - of_case.Achieved_FRT_ratio: Others
      Sales Executive - of_case.Achieved_FRT_ratio: Sales Executive
      C-KAM - of_case.Achieved_FRT_ratio: C-KAM
      C-KAS - of_case.Achieved_FRT_ratio: C-KAS
      No KA Mapping - of_case.Achieved_FRT_ratio: No KA Mapping
      ONECare Queue - of_case.Achieved_FRT_ratio: ONECare Queue
      S-KAM - of_case.Achieved_FRT_ratio: S-KAM
      S-KAS - of_case.Achieved_FRT_ratio: S-KAS
      Onshore - of_case.Achieved_FRT_ratio: Onshore
      Offshore - of_case.Achieved_FRT_ratio: Offshore
      Complaint/Feedback - of_case.Achieved_FRT_ratio: Complaint/Feedback
      Complex - of_case.Achieved_FRT_ratio: Complex
      General Information - of_case.Achieved_FRT_ratio: General Information
      Inquiry - of_case.Achieved_FRT_ratio: Inquiry
      Internal - of_case.Achieved_FRT_ratio: Internal
      Service Request - of_case.Achieved_FRT_ratio: Service Request
      Service Failure - of_case.Achieved_FRT_ratio: Service Failure
      Transactional - of_case.Achieved_FRT_ratio: Transactional
      No Action Required - of_case.Achieved_FRT_ratio: No Action Required
      Internal Request - of_case.Achieved_FRT_ratio: Internal Request
      GKA - of_case.Achieved_FRT_ratio: GKA
      LKA - of_case.Achieved_FRT_ratio: LKA
      ONECare - of_case.Achieved_FRT_ratio: ONECare
      RKA - of_case.Achieved_FRT_ratio: RKA
      AE - of_case.Achieved_FRT_ratio: AE
      AR - of_case.Achieved_FRT_ratio: AR
      AT & HU - of_case.Achieved_FRT_ratio: AT & HU
      AU - of_case.Achieved_FRT_ratio: AU
      BD - of_case.Achieved_FRT_ratio: BD
      BR - of_case.Achieved_FRT_ratio: BR
      BE - of_case.Achieved_FRT_ratio: BE
      CH - of_case.Achieved_FRT_ratio: CH
      CL - of_case.Achieved_FRT_ratio: CL
      CN - of_case.Achieved_FRT_ratio: CN
      CO - of_case.Achieved_FRT_ratio: CO
      DE - of_case.Achieved_FRT_ratio: DE
      CZ & SK - of_case.Achieved_FRT_ratio: CZ & SK
      EC - of_case.Achieved_FRT_ratio: EC
      DK - of_case.Achieved_FRT_ratio: DK
      EG - of_case.Achieved_FRT_ratio: EG
      ES - of_case.Achieved_FRT_ratio: ES
      LK - of_case.Achieved_FRT_ratio: LK
      IT - of_case.Achieved_FRT_ratio: IT
      FI - of_case.Achieved_FRT_ratio: FI
      FR - of_case.Achieved_FRT_ratio: FR
      GB - of_case.Achieved_FRT_ratio: GB
      GH - of_case.Achieved_FRT_ratio: GH
      HK & SCN - of_case.Achieved_FRT_ratio: HK & SCN
      ID - of_case.Achieved_FRT_ratio: ID
      IL - of_case.Achieved_FRT_ratio: IL
      IN - of_case.Achieved_FRT_ratio: IN
      JP - of_case.Achieved_FRT_ratio: JP
      KR - of_case.Achieved_FRT_ratio: KR
      MA - of_case.Achieved_FRT_ratio: MA
      MM - of_case.Achieved_FRT_ratio: MM
      MX - of_case.Achieved_FRT_ratio: MX
      MY - of_case.Achieved_FRT_ratio: MY
      TR - of_case.Achieved_FRT_ratio: TR
      TW - of_case.Achieved_FRT_ratio: TW
      TH - of_case.Achieved_FRT_ratio: TH
      SE & NO - of_case.Achieved_FRT_ratio: SE & NO
      NG - of_case.Achieved_FRT_ratio: NG
      NL - of_case.Achieved_FRT_ratio: NL
      NZ - of_case.Achieved_FRT_ratio: NZ
      PA - of_case.Achieved_FRT_ratio: PA
      PE - of_case.Achieved_FRT_ratio: PE
      PH - of_case.Achieved_FRT_ratio: PH
      PK - of_case.Achieved_FRT_ratio: PK
      PL - of_case.Achieved_FRT_ratio: PL
      PT - of_case.Achieved_FRT_ratio: PT
      SG - of_case.Achieved_FRT_ratio: SG
      US - of_case.Achieved_FRT_ratio: US
      UY - of_case.Achieved_FRT_ratio: UY
      ZA - of_case.Achieved_FRT_ratio: ZA
      CA - of_case.Achieved_FRT_ratio: CA
      CI - of_case.Achieved_FRT_ratio: CI
      AT - of_case.Achieved_FRT_ratio: AT
      CZ - of_case.Achieved_FRT_ratio: CZ
      IE - of_case.Achieved_FRT_ratio: IE
      SK - of_case.Achieved_FRT_ratio: SK
      VN - of_case.Achieved_FRT_ratio: VN
      NO - of_case.Achieved_FRT_ratio: 'NO'
      AS - of_case.Achieved_FRT_ratio: AS
      BG - of_case.Achieved_FRT_ratio: BG
      CR - of_case.Achieved_FRT_ratio: CR
      CY - of_case.Achieved_FRT_ratio: CY
      DZ - of_case.Achieved_FRT_ratio: DZ
      EE - of_case.Achieved_FRT_ratio: EE
      FJ - of_case.Achieved_FRT_ratio: FJ
      GE - of_case.Achieved_FRT_ratio: GE
      GR - of_case.Achieved_FRT_ratio: GR
      GT - of_case.Achieved_FRT_ratio: GT
      HK - of_case.Achieved_FRT_ratio: HK
      HN - of_case.Achieved_FRT_ratio: HN
      HR - of_case.Achieved_FRT_ratio: HR
      HU - of_case.Achieved_FRT_ratio: HU
      KE - of_case.Achieved_FRT_ratio: KE
      KH - of_case.Achieved_FRT_ratio: KH
      KI - of_case.Achieved_FRT_ratio: KI
      LB - of_case.Achieved_FRT_ratio: LB
      LT - of_case.Achieved_FRT_ratio: LT
      LS - of_case.Achieved_FRT_ratio: LS
      LV - of_case.Achieved_FRT_ratio: LV
      MO - of_case.Achieved_FRT_ratio: MO
      MT - of_case.Achieved_FRT_ratio: MT
      NI - of_case.Achieved_FRT_ratio: NI
      PF - of_case.Achieved_FRT_ratio: PF
      RO - of_case.Achieved_FRT_ratio: RO
      SA - of_case.Achieved_FRT_ratio: SA
      SB - of_case.Achieved_FRT_ratio: SB
      SI - of_case.Achieved_FRT_ratio: SI
      SN - of_case.Achieved_FRT_ratio: SN
      SV - of_case.Achieved_FRT_ratio: SV
      TG - of_case.Achieved_FRT_ratio: TG
      TJ - of_case.Achieved_FRT_ratio: TJ
      TN - of_case.Achieved_FRT_ratio: TN
      TO - of_case.Achieved_FRT_ratio: TO
      TT - of_case.Achieved_FRT_ratio: TT
      UA - of_case.Achieved_FRT_ratio: UA
      VU - of_case.Achieved_FRT_ratio: VU
      WS - of_case.Achieved_FRT_ratio: WS
      ZW - of_case.Achieved_FRT_ratio: ZW
      ZZ - of_case.Achieved_FRT_ratio: ZZ
      AARBB - of_case.Achieved_FRT_ratio: AARBB
      ABJBB - of_case.Achieved_FRT_ratio: ABJBB
      ADLBB - of_case.Achieved_FRT_ratio: ADLBB
      AKLBB - of_case.Achieved_FRT_ratio: AKLBB
      ALGBB - of_case.Achieved_FRT_ratio: ALGBB
      ALJBA - of_case.Achieved_FRT_ratio: ALJBA
      ALYBB - of_case.Achieved_FRT_ratio: ALYBB
      AMDBB - of_case.Achieved_FRT_ratio: AMDBB
      ANRBB - of_case.Achieved_FRT_ratio: ANRBB
      APWBA - of_case.Achieved_FRT_ratio: APWBA
      ASHBA - of_case.Achieved_FRT_ratio: ASHBA
      ATLBB - of_case.Achieved_FRT_ratio: ATLBB
      BASBB - of_case.Achieved_FRT_ratio: BASBB
      BCNBB - of_case.Achieved_FRT_ratio: BCNBB
      BDOBB - of_case.Achieved_FRT_ratio: BDOBB
      BELBB - of_case.Achieved_FRT_ratio: BELBB
      BEYBA - of_case.Achieved_FRT_ratio: BEYBA
      BIOBB - of_case.Achieved_FRT_ratio: BIOBB
      BKKBB - of_case.Achieved_FRT_ratio: BKKBB
      BLRBB - of_case.Achieved_FRT_ratio: BLRBB
      BNDBB - of_case.Achieved_FRT_ratio: BNDBB
      BNEBB - of_case.Achieved_FRT_ratio: BNEBB
      BOGBB - of_case.Achieved_FRT_ratio: BOGBB
      BOIBB - of_case.Achieved_FRT_ratio: BOIBB
      BOSBB - of_case.Achieved_FRT_ratio: BOSBB
      BREBB - of_case.Achieved_FRT_ratio: BREBB
      BTMBB - of_case.Achieved_FRT_ratio: BTMBB
      BUDBB - of_case.Achieved_FRT_ratio: BUDBB
      BUEBB - of_case.Achieved_FRT_ratio: BUEBB
      CAIBB - of_case.Achieved_FRT_ratio: CAIBB
      CANBB - of_case.Achieved_FRT_ratio: CANBB
      CASBA - of_case.Achieved_FRT_ratio: CASBA
      CCPBB - of_case.Achieved_FRT_ratio: CCPBB
      CCUBB - of_case.Achieved_FRT_ratio: CCUBB
      CEBBB - of_case.Achieved_FRT_ratio: CEBBB
      CGOBB - of_case.Achieved_FRT_ratio: CGOBB
      CGPBB - of_case.Achieved_FRT_ratio: CGPBB
      CGYBB - of_case.Achieved_FRT_ratio: CGYBB
      CHCBB - of_case.Achieved_FRT_ratio: CHCBB
      CHIBB - of_case.Achieved_FRT_ratio: CHIBB
      CKGBB - of_case.Achieved_FRT_ratio: CKGBB
      CLLBB - of_case.Achieved_FRT_ratio: CLLBB
      CMBBB - of_case.Achieved_FRT_ratio: CMBBB
      CNDBA - of_case.Achieved_FRT_ratio: CNDBA
      COKBB - of_case.Achieved_FRT_ratio: COKBB
      CPTBB - of_case.Achieved_FRT_ratio: CPTBB
      CTUBB - of_case.Achieved_FRT_ratio: CTUBB
      CWBBB - of_case.Achieved_FRT_ratio: CWBBB
      DACBB - of_case.Achieved_FRT_ratio: DACBB
      DADBB - of_case.Achieved_FRT_ratio: DADBB
      DAMBB - of_case.Achieved_FRT_ratio: DAMBB
      DARBA - of_case.Achieved_FRT_ratio: DARBA
      DELBB - of_case.Achieved_FRT_ratio: DELBB
      DKRBA - of_case.Achieved_FRT_ratio: DKRBA
      DLCBB - of_case.Achieved_FRT_ratio: DLCBB
      DMNBA - of_case.Achieved_FRT_ratio: DMNBA
      DPSBB - of_case.Achieved_FRT_ratio: DPSBB
      DUBBA - of_case.Achieved_FRT_ratio: DUBBA
      DURBB - of_case.Achieved_FRT_ratio: DURBB
      DUSBB - of_case.Achieved_FRT_ratio: DUSBB
      DVOBB - of_case.Achieved_FRT_ratio: DVOBB
      DXBBB - of_case.Achieved_FRT_ratio: DXBBB
      EDKBB - of_case.Achieved_FRT_ratio: EDKBB
      ELSBB - of_case.Achieved_FRT_ratio: ELSBB
      FOCBB - of_case.Achieved_FRT_ratio: FOCBB
      FREBB - of_case.Achieved_FRT_ratio: FREBB
      GDLBB - of_case.Achieved_FRT_ratio: GDLBB
      GDNBB - of_case.Achieved_FRT_ratio: GDNBB
      GDYBB - of_case.Achieved_FRT_ratio: GDYBB
      GESBB - of_case.Achieved_FRT_ratio: GESBB
      GINBB - of_case.Achieved_FRT_ratio: GINBB
      GOABB - of_case.Achieved_FRT_ratio: GOABB
      GOTBB - of_case.Achieved_FRT_ratio: GOTBB
      GUABA - of_case.Achieved_FRT_ratio: GUABA
      GYEBB - of_case.Achieved_FRT_ratio: GYEBB
      HALBB - of_case.Achieved_FRT_ratio: HALBB
      HAMBB - of_case.Achieved_FRT_ratio: HAMBB
      HANBB - of_case.Achieved_FRT_ratio: HANBB
      HELBB - of_case.Achieved_FRT_ratio: HELBB
      HFABA - of_case.Achieved_FRT_ratio: HFABA
      HFEBB - of_case.Achieved_FRT_ratio: HFEBB
      HGHBB - of_case.Achieved_FRT_ratio: HGHBB
      HIRBA - of_case.Achieved_FRT_ratio: HIRBA
      HKGBB - of_case.Achieved_FRT_ratio: HKGBB
      HKTBA - of_case.Achieved_FRT_ratio: HKTBA
      HOUBB - of_case.Achieved_FRT_ratio: HOUBB
      HPHBB - of_case.Achieved_FRT_ratio: HPHBB
      HREBA - of_case.Achieved_FRT_ratio: HREBA
      HYDBB - of_case.Achieved_FRT_ratio: HYDBB
      ICDBB - of_case.Achieved_FRT_ratio: ICDBB
      IPSBB - of_case.Achieved_FRT_ratio: IPSBB
      IQQBB - of_case.Achieved_FRT_ratio: IQQBB
      ISTBA - of_case.Achieved_FRT_ratio: ISTBA
      ISTBB - of_case.Achieved_FRT_ratio: ISTBB
      ITJBB - of_case.Achieved_FRT_ratio: ITJBB
      IZMBA - of_case.Achieved_FRT_ratio: IZMBA
      IZMBB - of_case.Achieved_FRT_ratio: IZMBB
      JEDBA - of_case.Achieved_FRT_ratio: JEDBA
      JHBBB - of_case.Achieved_FRT_ratio: JHBBB
      JKTBB - of_case.Achieved_FRT_ratio: JKTBB
      JMNBB - of_case.Achieved_FRT_ratio: JMNBB
      JNBBB - of_case.Achieved_FRT_ratio: JNBBB
      KHHBB - of_case.Achieved_FRT_ratio: KHHBB
      KHIBB - of_case.Achieved_FRT_ratio: KHIBB
      KHLBB - of_case.Achieved_FRT_ratio: KHLBB
      KLPBA - of_case.Achieved_FRT_ratio: KLPBA
      KOPBA - of_case.Achieved_FRT_ratio: KOPBA
      LAXBB - of_case.Achieved_FRT_ratio: LAXBB
      LCBBB - of_case.Achieved_FRT_ratio: LCBBB
      LEHBB - of_case.Achieved_FRT_ratio: LEHBB
      LEXBB - of_case.Achieved_FRT_ratio: LEXBB
      LFWBA - of_case.Achieved_FRT_ratio: LFWBA
      LHEBB - of_case.Achieved_FRT_ratio: LHEBB
      LIMBB - of_case.Achieved_FRT_ratio: LIMBB
      LISBB - of_case.Achieved_FRT_ratio: LISBB
      LIVBB - of_case.Achieved_FRT_ratio: LIVBB
      LMSBA - of_case.Achieved_FRT_ratio: LMSBA
      LONBB - of_case.Achieved_FRT_ratio: LONBB
      LOSBB - of_case.Achieved_FRT_ratio: LOSBB
      LUHBB - of_case.Achieved_FRT_ratio: LUHBB
      LYGBB - of_case.Achieved_FRT_ratio: LYGBB
      MAABB - of_case.Achieved_FRT_ratio: MAABB
      MACBB - of_case.Achieved_FRT_ratio: MACBB
      MADBB - of_case.Achieved_FRT_ratio: MADBB
      MAOBB - of_case.Achieved_FRT_ratio: MAOBB
      MBABA - of_case.Achieved_FRT_ratio: MBABA
      MECBA - of_case.Achieved_FRT_ratio: MECBA
      MELBB - of_case.Achieved_FRT_ratio: MELBB
      MERBA - of_case.Achieved_FRT_ratio: MERBA
      MERBB - of_case.Achieved_FRT_ratio: MERBB
      MESBB - of_case.Achieved_FRT_ratio: MESBB
      MEXBB - of_case.Achieved_FRT_ratio: MEXBB
      MIBOS - of_case.Achieved_FRT_ratio: MIBOS
      MIHOS - of_case.Achieved_FRT_ratio: MIHOS
      MITBB - of_case.Achieved_FRT_ratio: MITBB
      MNGBA - of_case.Achieved_FRT_ratio: MNGBA
      MNLBB - of_case.Achieved_FRT_ratio: MNLBB
      MOWBB - of_case.Achieved_FRT_ratio: MOWBB
      MRSBB - of_case.Achieved_FRT_ratio: MRSBB
      MSUBA - of_case.Achieved_FRT_ratio: MSUBA
      MTABA - of_case.Achieved_FRT_ratio: MTABA
      MTYBB - of_case.Achieved_FRT_ratio: MTYBB
      MUMBB - of_case.Achieved_FRT_ratio: MUMBB
      MVDBB - of_case.Achieved_FRT_ratio: MVDBB
      NBOBB - of_case.Achieved_FRT_ratio: NBOBB
      NGOBB - of_case.Achieved_FRT_ratio: NGOBB
      NKGBB - of_case.Achieved_FRT_ratio: NKGBB
      NSABB - of_case.Achieved_FRT_ratio: NSABB
      NVSBA - of_case.Achieved_FRT_ratio: NVSBA
      NYCBB - of_case.Achieved_FRT_ratio: NYCBB
      ODSBA - of_case.Achieved_FRT_ratio: ODSBA
      OPOBB - of_case.Achieved_FRT_ratio: OPOBB
      OSABB - of_case.Achieved_FRT_ratio: OSABB
      PAIBB - of_case.Achieved_FRT_ratio: PAIBB
      PANBA - of_case.Achieved_FRT_ratio: PANBA
      PANBB - of_case.Achieved_FRT_ratio: PANBB
      PAVBB - of_case.Achieved_FRT_ratio: PAVBB
      PENBB - of_case.Achieved_FRT_ratio: PENBB
      PIRAEU - of_case.Achieved_FRT_ratio: PIRAE
      PKGBB - of_case.Achieved_FRT_ratio: PKGBB
      PLMBB - of_case.Achieved_FRT_ratio: PLMBB
      PLZBB - of_case.Achieved_FRT_ratio: PLZBB
      PNHBA - of_case.Achieved_FRT_ratio: PNHBA
      PNQBB - of_case.Achieved_FRT_ratio: PNQBB
      PPGBA - of_case.Achieved_FRT_ratio: PPGBA
      PPTBA - of_case.Achieved_FRT_ratio: PPTBA
      PRGBB - of_case.Achieved_FRT_ratio: PRGBB
      PSDBB - of_case.Achieved_FRT_ratio: PSDBB
      PTIBA - of_case.Achieved_FRT_ratio: PTIBA
      PTSBA - of_case.Achieved_FRT_ratio: PTSBA
      PUSBB - of_case.Achieved_FRT_ratio: PUSBB
      QITBA - of_case.Achieved_FRT_ratio: QITBA
      RHUBA - of_case.Achieved_FRT_ratio: RHUBA
      RICBB - of_case.Achieved_FRT_ratio: RICBB
      RIXBA - of_case.Achieved_FRT_ratio: RIXBA
      RJKBA - of_case.Achieved_FRT_ratio: RJKBA
      RTMBB - of_case.Achieved_FRT_ratio: RTMBB
      SALBA - of_case.Achieved_FRT_ratio: SALBA
      SAOBB - of_case.Achieved_FRT_ratio: SAOBB
      SCLBB - of_case.Achieved_FRT_ratio: SCLBB
      SEABB - of_case.Achieved_FRT_ratio: SEABB
      SELBB - of_case.Achieved_FRT_ratio: SELBB
      SFOBB - of_case.Achieved_FRT_ratio: SFOBB
      SFSBB - of_case.Achieved_FRT_ratio: SFSBB
      SGNBB - of_case.Achieved_FRT_ratio: SGNBB
      SGZBB - of_case.Achieved_FRT_ratio: SGZBB
      SHABB - of_case.Achieved_FRT_ratio: SHABB
      SIABB - of_case.Achieved_FRT_ratio: SIABB
      SINBB - of_case.Achieved_FRT_ratio: SINBB
      SINHO - of_case.Achieved_FRT_ratio: SINHO
      SJOBA - of_case.Achieved_FRT_ratio: SJOBA
      SJWBB - of_case.Achieved_FRT_ratio: SJWBB
      SKGBA - of_case.Achieved_FRT_ratio: SKGBA
      SMZBA - of_case.Achieved_FRT_ratio: SMZBA
      SOUBB - of_case.Achieved_FRT_ratio: SOUBB
      SPBBB - of_case.Achieved_FRT_ratio: SPBBB
      SPROS - of_case.Achieved_FRT_ratio: SPROS
      SRGBB - of_case.Achieved_FRT_ratio: SRGBB
      SSZBB - of_case.Achieved_FRT_ratio: SSZBB
      STRBB - of_case.Achieved_FRT_ratio: STRBB
      SUBBB - of_case.Achieved_FRT_ratio: SUBBB
      SUDBB - of_case.Achieved_FRT_ratio: SUDBB
      SUVBA - of_case.Achieved_FRT_ratio: SUVBA
      SUZBB - of_case.Achieved_FRT_ratio: SUZBB
      SYDBB - of_case.Achieved_FRT_ratio: SYDBB
      SZHBB - of_case.Achieved_FRT_ratio: SZHBB
      SZPBB - of_case.Achieved_FRT_ratio: SZPBB
      TAOBB - of_case.Achieved_FRT_ratio: TAOBB
      TBUBA - of_case.Achieved_FRT_ratio: TBUBA
      TEMBB - of_case.Achieved_FRT_ratio: TEMBB
      TGCBA - of_case.Achieved_FRT_ratio: TGCBA
      TLLBA - of_case.Achieved_FRT_ratio: TLLBA
      TLVBA - of_case.Achieved_FRT_ratio: TLVBA
      TORBB - of_case.Achieved_FRT_ratio: TORBB
      TPEBB - of_case.Achieved_FRT_ratio: TPEBB
      TPPBB - of_case.Achieved_FRT_ratio: TPPBB
      TRWBA - of_case.Achieved_FRT_ratio: TRWBA
      TSNBB - of_case.Achieved_FRT_ratio: TSNBB
      TUNBA - of_case.Achieved_FRT_ratio: TUNBA
      TUTBB - of_case.Achieved_FRT_ratio: TUTBB
      TXGBB - of_case.Achieved_FRT_ratio: TXGBB
      TYOBB - of_case.Achieved_FRT_ratio: TYOBB
      VANBB - of_case.Achieved_FRT_ratio: VANBB
      VAPBB - of_case.Achieved_FRT_ratio: VAPBB
      VARBA - of_case.Achieved_FRT_ratio: VARBA
      VGOBB - of_case.Achieved_FRT_ratio: VGOBB
      VLCBB - of_case.Achieved_FRT_ratio: VLCBB
      VLIBA - of_case.Achieved_FRT_ratio: VLIBA
      VNABB - of_case.Achieved_FRT_ratio: VNABB
      VTZBB - of_case.Achieved_FRT_ratio: VTZBB
      VVABB - of_case.Achieved_FRT_ratio: VVABB
      WGZOS - of_case.Achieved_FRT_ratio: WGZOS
      WMLOS - of_case.Achieved_FRT_ratio: WMLOS
      WNKOS - of_case.Achieved_FRT_ratio: WNKOS
      WUHBB - of_case.Achieved_FRT_ratio: WUHBB
      XMNBB - of_case.Achieved_FRT_ratio: XMNBB
      YGNBB - of_case.Achieved_FRT_ratio: YGNBB
      ZHOBB - of_case.Achieved_FRT_ratio: ZHOBB
      ZHUBB - of_case.Achieved_FRT_ratio: ZHUBB
      ZLOBB - of_case.Achieved_FRT_ratio: ZLOBB
      of_case.Case_Geo___null - of_case.Achieved_FRT_ratio: "∅"
      global: FY 23 Global Target
      Unclaimed - of_case.Achieved_FRT_ratio: Unclaimed
      global_target_chat: FY2023 Global Uniform Target (Chat)
      global_target_web: FY2023 Global Uniform Target (Web)
    series_point_styles:
      global: auto
      global_target_chat: diamond
    show_null_points: true
    interpolation: monotone
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Average First Response
      Time<BR><B>How it Helps : </B>Shows how many % of cases achieve the target.<BR><B>Filter
      Tips : </B><BR>Channel = Chat, First Response Time = Chat Transcript<BR>'
    hidden_pivots:
      '1':
        measure_names: []
      Global:
        measure_names: []
      HKGHQ:
        measure_names: []
      LONHQ:
        measure_names: []
      RICHQ:
        measure_names: []
      SAOHQ:
        measure_names: []
      SINHQ:
        measure_names: []
      Unclaimed:
        measure_names: []
    hidden_fields: [of_case.target_measure_for_WEB2, of_case.target_measure_for_Chat2,
      of_case.target_for_chat]
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      First Response Time: of_case.responsetime_Param
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 23
    col: 0
    width: 10
    height: 9
  - title: Chat AHT Target Achievement
    name: Chat AHT Target Achievement
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.createddate_dynamic, of_case.Case_Geo, of_case.target_for_chat,
      of_case.Achieved_AHT_ratio]
    pivots: [of_case.Case_Geo]
    filters:
      channel_filter: Chat
    sorts: [of_case.createddate_dynamic, of_case.Case_Geo]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields: [{category: table_calculation, expression: 'coalesce(pivot_where(${of_case.Case_Geo}="Global",if(is_null(${of_case.dynamic_reference}),-5,${of_case.dynamic_reference})),-5)',
        label: Global, value_format: !!null '', value_format_name: decimal_1, _kind_hint: supermeasure,
        table_calculation: global, _type_hint: number, is_disabled: true}, {category: table_calculation,
        expression: 'max(coalesce(max(pivot_row(${of_case.target_for_chat})),-10))',
        label: Global Target (Chat), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target_chat, _type_hint: number},
      {category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_web})),-10))',
        label: Global Target (Web), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target_web, _type_hint: number,
        is_disabled: true}, {category: dimension, expression: "${of_case.origin}",
        label: Channel Filter, value_format: !!null '', value_format_name: !!null '',
        dimension: channel_filter, _kind_hint: dimension, _type_hint: string}]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.average_handling_time,
            id: Global - of_case.average_handling_time, name: Global}, {axisId: of_case.average_handling_time,
            id: Row Total - of_case.average_handling_time, name: Total}, {axisId: global_target,
            id: global_target, name: Global Target}, {axisId: hkghq_target, id: hkghq_target,
            name: HKGHQ Target}, {axisId: lonhq_target, id: lonhq_target, name: LONHQ
              Target}, {axisId: richq_target, id: richq_target, name: RICHQ Target},
          {axisId: saohq_target, id: saohq_target, name: SAOHQ Target}, {axisId: sinhq_target,
            id: sinhq_target, name: SINHQ Target}], showLabels: false, showValues: false,
        minValue: 0, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    label_value_format: ''
    series_types:
      Row Total - of_case.average_handling_time: line
      global_target: line
      hkghq_target: line
      lonhq_target: line
      richq_target: line
      saohq_target: line
      sinhq_target: line
      Row Total - of_case.new_aht: line
      hkghq: line
      lonhq: line
      richq: line
      sinhq: line
      saohq: line
      global: line
      global_target_chat: line
      global_target_web: line
      Row Total - of_case.Achieved_AHT_ratio: line
    series_colors:
      HKGHQ - of_case.Achieved_AHT_ratio: "#db72af"
      LONHQ - of_case.Achieved_AHT_ratio: "#00506D"
      RICHQ - of_case.Achieved_AHT_ratio: "#84C5C3"
      SAOHQ - of_case.Achieved_AHT_ratio: "#BD0F72"
      SINHQ - of_case.Achieved_AHT_ratio: "#8b908f"
      Row Total - of_case.Achieved_AHT_ratio: "#F39200"
      global_target: "#f277aa"
      global: "#340335"
      global_target_chat: "#70AD47"
      global_target_web: "#00B050"
    series_labels:
      1 - of_case.Achieved_AHT_ratio: GKA
      2 - of_case.Achieved_AHT_ratio: RKA
      3 - of_case.Achieved_AHT_ratio: LKA
      4 - of_case.Achieved_AHT_ratio: ONECare
      Row Total - of_case.Achieved_AHT_ratio: Total
      HKGHQ - of_case.Achieved_AHT_ratio: HKGHQ
      LONHQ - of_case.Achieved_AHT_ratio: LONHQ
      RICHQ - of_case.Achieved_AHT_ratio: RICHQ
      SAOHQ - of_case.Achieved_AHT_ratio: SAOHQ
      SINHQ - of_case.Achieved_AHT_ratio: SINHQ
      Global - of_case.Achieved_AHT_ratio: Global
      Chat - of_case.Achieved_AHT_ratio: Chat
      Email - of_case.Achieved_AHT_ratio: Email
      Manual - of_case.Achieved_AHT_ratio: Manual
      Web - of_case.Achieved_AHT_ratio: Web
      Phone - of_case.Achieved_AHT_ratio: Phone
      CCA - of_case.Achieved_AHT_ratio: CCA
      CCS - of_case.Achieved_AHT_ratio: CCS
      Others - of_case.Achieved_AHT_ratio: Others
      Sales Executive - of_case.Achieved_AHT_ratio: Sales Executive
      C-KAM - of_case.Achieved_AHT_ratio: C-KAM
      C-KAS - of_case.Achieved_AHT_ratio: C-KAS
      No KA Mapping - of_case.Achieved_AHT_ratio: No KA Mapping
      ONECare Queue - of_case.Achieved_AHT_ratio: ONECare Queue
      S-KAM - of_case.Achieved_AHT_ratio: S-KAM
      S-KAS - of_case.Achieved_AHT_ratio: S-KAS
      Onshore - of_case.Achieved_AHT_ratio: Onshore
      Offshore - of_case.Achieved_AHT_ratio: Offshore
      Complaint/Feedback - of_case.Achieved_AHT_ratio: Complaint/Feedback
      Complex - of_case.Achieved_AHT_ratio: Complex
      General Information - of_case.Achieved_AHT_ratio: General Information
      Inquiry - of_case.Achieved_AHT_ratio: Inquiry
      Internal - of_case.Achieved_AHT_ratio: Internal
      Service Request - of_case.Achieved_AHT_ratio: Service Request
      Service Failure - of_case.Achieved_AHT_ratio: Service Failure
      Transactional - of_case.Achieved_AHT_ratio: Transactional
      No Action Required - of_case.Achieved_AHT_ratio: No Action Required
      Internal Request - of_case.Achieved_AHT_ratio: Internal Request
      GKA - of_case.Achieved_AHT_ratio: GKA
      LKA - of_case.Achieved_AHT_ratio: LKA
      ONECare - of_case.Achieved_AHT_ratio: ONECare
      RKA - of_case.Achieved_AHT_ratio: RKA
      AE - of_case.Achieved_AHT_ratio: AE
      AR - of_case.Achieved_AHT_ratio: AR
      AT & HU - of_case.Achieved_AHT_ratio: AT & HU
      AU - of_case.Achieved_AHT_ratio: AU
      BD - of_case.Achieved_AHT_ratio: BD
      BR - of_case.Achieved_AHT_ratio: BR
      BE - of_case.Achieved_AHT_ratio: BE
      CH - of_case.Achieved_AHT_ratio: CH
      CL - of_case.Achieved_AHT_ratio: CL
      CN - of_case.Achieved_AHT_ratio: CN
      CO - of_case.Achieved_AHT_ratio: CO
      DE - of_case.Achieved_AHT_ratio: DE
      CZ & SK - of_case.Achieved_AHT_ratio: CZ & SK
      EC - of_case.Achieved_AHT_ratio: EC
      DK - of_case.Achieved_AHT_ratio: DK
      EG - of_case.Achieved_AHT_ratio: EG
      ES - of_case.Achieved_AHT_ratio: ES
      LK - of_case.Achieved_AHT_ratio: LK
      IT - of_case.Achieved_AHT_ratio: IT
      FI - of_case.Achieved_AHT_ratio: FI
      FR - of_case.Achieved_AHT_ratio: FR
      GB - of_case.Achieved_AHT_ratio: GB
      GH - of_case.Achieved_AHT_ratio: GH
      HK & SCN - of_case.Achieved_AHT_ratio: HK & SCN
      ID - of_case.Achieved_AHT_ratio: ID
      IL - of_case.Achieved_AHT_ratio: IL
      IN - of_case.Achieved_AHT_ratio: IN
      JP - of_case.Achieved_AHT_ratio: JP
      KR - of_case.Achieved_AHT_ratio: KR
      MA - of_case.Achieved_AHT_ratio: MA
      MM - of_case.Achieved_AHT_ratio: MM
      MX - of_case.Achieved_AHT_ratio: MX
      MY - of_case.Achieved_AHT_ratio: MY
      TR - of_case.Achieved_AHT_ratio: TR
      TW - of_case.Achieved_AHT_ratio: TW
      TH - of_case.Achieved_AHT_ratio: TH
      SE & NO - of_case.Achieved_AHT_ratio: SE & NO
      NG - of_case.Achieved_AHT_ratio: NG
      NL - of_case.Achieved_AHT_ratio: NL
      NZ - of_case.Achieved_AHT_ratio: NZ
      PA - of_case.Achieved_AHT_ratio: PA
      PE - of_case.Achieved_AHT_ratio: PE
      PH - of_case.Achieved_AHT_ratio: PH
      PK - of_case.Achieved_AHT_ratio: PK
      PL - of_case.Achieved_AHT_ratio: PL
      PT - of_case.Achieved_AHT_ratio: PT
      SG - of_case.Achieved_AHT_ratio: SG
      US - of_case.Achieved_AHT_ratio: US
      UY - of_case.Achieved_AHT_ratio: UY
      ZA - of_case.Achieved_AHT_ratio: ZA
      CA - of_case.Achieved_AHT_ratio: CA
      CI - of_case.Achieved_AHT_ratio: CI
      AT - of_case.Achieved_AHT_ratio: AT
      CZ - of_case.Achieved_AHT_ratio: CZ
      IE - of_case.Achieved_AHT_ratio: IE
      SK - of_case.Achieved_AHT_ratio: SK
      VN - of_case.Achieved_AHT_ratio: VN
      NO - of_case.Achieved_AHT_ratio: 'NO'
      AS - of_case.Achieved_AHT_ratio: AS
      BG - of_case.Achieved_AHT_ratio: BG
      CR - of_case.Achieved_AHT_ratio: CR
      CY - of_case.Achieved_AHT_ratio: CY
      DZ - of_case.Achieved_AHT_ratio: DZ
      EE - of_case.Achieved_AHT_ratio: EE
      FJ - of_case.Achieved_AHT_ratio: FJ
      GE - of_case.Achieved_AHT_ratio: GE
      GR - of_case.Achieved_AHT_ratio: GR
      GT - of_case.Achieved_AHT_ratio: GT
      HK - of_case.Achieved_AHT_ratio: HK
      HN - of_case.Achieved_AHT_ratio: HN
      HR - of_case.Achieved_AHT_ratio: HR
      HU - of_case.Achieved_AHT_ratio: HU
      KE - of_case.Achieved_AHT_ratio: KE
      KH - of_case.Achieved_AHT_ratio: KH
      KI - of_case.Achieved_AHT_ratio: KI
      LB - of_case.Achieved_AHT_ratio: LB
      LT - of_case.Achieved_AHT_ratio: LT
      LS - of_case.Achieved_AHT_ratio: LS
      LV - of_case.Achieved_AHT_ratio: LV
      MO - of_case.Achieved_AHT_ratio: MO
      MT - of_case.Achieved_AHT_ratio: MT
      NI - of_case.Achieved_AHT_ratio: NI
      PF - of_case.Achieved_AHT_ratio: PF
      RO - of_case.Achieved_AHT_ratio: RO
      SA - of_case.Achieved_AHT_ratio: SA
      SB - of_case.Achieved_AHT_ratio: SB
      SI - of_case.Achieved_AHT_ratio: SI
      SN - of_case.Achieved_AHT_ratio: SN
      SV - of_case.Achieved_AHT_ratio: SV
      TG - of_case.Achieved_AHT_ratio: TG
      TJ - of_case.Achieved_AHT_ratio: TJ
      TN - of_case.Achieved_AHT_ratio: TN
      TO - of_case.Achieved_AHT_ratio: TO
      TT - of_case.Achieved_AHT_ratio: TT
      UA - of_case.Achieved_AHT_ratio: UA
      VU - of_case.Achieved_AHT_ratio: VU
      WS - of_case.Achieved_AHT_ratio: WS
      ZW - of_case.Achieved_AHT_ratio: ZW
      ZZ - of_case.Achieved_AHT_ratio: ZZ
      AARBB - of_case.Achieved_AHT_ratio: AARBB
      ABJBB - of_case.Achieved_AHT_ratio: ABJBB
      ADLBB - of_case.Achieved_AHT_ratio: ADLBB
      AKLBB - of_case.Achieved_AHT_ratio: AKLBB
      ALGBB - of_case.Achieved_AHT_ratio: ALGBB
      ALJBA - of_case.Achieved_AHT_ratio: ALJBA
      ALYBB - of_case.Achieved_AHT_ratio: ALYBB
      AMDBB - of_case.Achieved_AHT_ratio: AMDBB
      ANRBB - of_case.Achieved_AHT_ratio: ANRBB
      APWBA - of_case.Achieved_AHT_ratio: APWBA
      ASHBA - of_case.Achieved_AHT_ratio: ASHBA
      ATLBB - of_case.Achieved_AHT_ratio: ATLBB
      BASBB - of_case.Achieved_AHT_ratio: BASBB
      BCNBB - of_case.Achieved_AHT_ratio: BCNBB
      BDOBB - of_case.Achieved_AHT_ratio: BDOBB
      BELBB - of_case.Achieved_AHT_ratio: BELBB
      BEYBA - of_case.Achieved_AHT_ratio: BEYBA
      BIOBB - of_case.Achieved_AHT_ratio: BIOBB
      BKKBB - of_case.Achieved_AHT_ratio: BKKBB
      BLRBB - of_case.Achieved_AHT_ratio: BLRBB
      BNDBB - of_case.Achieved_AHT_ratio: BNDBB
      BNEBB - of_case.Achieved_AHT_ratio: BNEBB
      BOGBB - of_case.Achieved_AHT_ratio: BOGBB
      BOIBB - of_case.Achieved_AHT_ratio: BOIBB
      BOSBB - of_case.Achieved_AHT_ratio: BOSBB
      BREBB - of_case.Achieved_AHT_ratio: BREBB
      BTMBB - of_case.Achieved_AHT_ratio: BTMBB
      BUDBB - of_case.Achieved_AHT_ratio: BUDBB
      BUEBB - of_case.Achieved_AHT_ratio: BUEBB
      CAIBB - of_case.Achieved_AHT_ratio: CAIBB
      CANBB - of_case.Achieved_AHT_ratio: CANBB
      CASBA - of_case.Achieved_AHT_ratio: CASBA
      CCPBB - of_case.Achieved_AHT_ratio: CCPBB
      CCUBB - of_case.Achieved_AHT_ratio: CCUBB
      CEBBB - of_case.Achieved_AHT_ratio: CEBBB
      CGOBB - of_case.Achieved_AHT_ratio: CGOBB
      CGPBB - of_case.Achieved_AHT_ratio: CGPBB
      CGYBB - of_case.Achieved_AHT_ratio: CGYBB
      CHCBB - of_case.Achieved_AHT_ratio: CHCBB
      CHIBB - of_case.Achieved_AHT_ratio: CHIBB
      CKGBB - of_case.Achieved_AHT_ratio: CKGBB
      CLLBB - of_case.Achieved_AHT_ratio: CLLBB
      CMBBB - of_case.Achieved_AHT_ratio: CMBBB
      CNDBA - of_case.Achieved_AHT_ratio: CNDBA
      COKBB - of_case.Achieved_AHT_ratio: COKBB
      CPTBB - of_case.Achieved_AHT_ratio: CPTBB
      CTUBB - of_case.Achieved_AHT_ratio: CTUBB
      CWBBB - of_case.Achieved_AHT_ratio: CWBBB
      DACBB - of_case.Achieved_AHT_ratio: DACBB
      DADBB - of_case.Achieved_AHT_ratio: DADBB
      DAMBB - of_case.Achieved_AHT_ratio: DAMBB
      DARBA - of_case.Achieved_AHT_ratio: DARBA
      DELBB - of_case.Achieved_AHT_ratio: DELBB
      DKRBA - of_case.Achieved_AHT_ratio: DKRBA
      DLCBB - of_case.Achieved_AHT_ratio: DLCBB
      DMNBA - of_case.Achieved_AHT_ratio: DMNBA
      DPSBB - of_case.Achieved_AHT_ratio: DPSBB
      DUBBA - of_case.Achieved_AHT_ratio: DUBBA
      DURBB - of_case.Achieved_AHT_ratio: DURBB
      DUSBB - of_case.Achieved_AHT_ratio: DUSBB
      DVOBB - of_case.Achieved_AHT_ratio: DVOBB
      DXBBB - of_case.Achieved_AHT_ratio: DXBBB
      EDKBB - of_case.Achieved_AHT_ratio: EDKBB
      ELSBB - of_case.Achieved_AHT_ratio: ELSBB
      FOCBB - of_case.Achieved_AHT_ratio: FOCBB
      FREBB - of_case.Achieved_AHT_ratio: FREBB
      GDLBB - of_case.Achieved_AHT_ratio: GDLBB
      GDNBB - of_case.Achieved_AHT_ratio: GDNBB
      GDYBB - of_case.Achieved_AHT_ratio: GDYBB
      GESBB - of_case.Achieved_AHT_ratio: GESBB
      GINBB - of_case.Achieved_AHT_ratio: GINBB
      GOABB - of_case.Achieved_AHT_ratio: GOABB
      GOTBB - of_case.Achieved_AHT_ratio: GOTBB
      GUABA - of_case.Achieved_AHT_ratio: GUABA
      GYEBB - of_case.Achieved_AHT_ratio: GYEBB
      HALBB - of_case.Achieved_AHT_ratio: HALBB
      HAMBB - of_case.Achieved_AHT_ratio: HAMBB
      HANBB - of_case.Achieved_AHT_ratio: HANBB
      HELBB - of_case.Achieved_AHT_ratio: HELBB
      HFABA - of_case.Achieved_AHT_ratio: HFABA
      HFEBB - of_case.Achieved_AHT_ratio: HFEBB
      HGHBB - of_case.Achieved_AHT_ratio: HGHBB
      HIRBA - of_case.Achieved_AHT_ratio: HIRBA
      HKGBB - of_case.Achieved_AHT_ratio: HKGBB
      HKTBA - of_case.Achieved_AHT_ratio: HKTBA
      HOUBB - of_case.Achieved_AHT_ratio: HOUBB
      HPHBB - of_case.Achieved_AHT_ratio: HPHBB
      HREBA - of_case.Achieved_AHT_ratio: HREBA
      HYDBB - of_case.Achieved_AHT_ratio: HYDBB
      ICDBB - of_case.Achieved_AHT_ratio: ICDBB
      IPSBB - of_case.Achieved_AHT_ratio: IPSBB
      IQQBB - of_case.Achieved_AHT_ratio: IQQBB
      ISTBA - of_case.Achieved_AHT_ratio: ISTBA
      ISTBB - of_case.Achieved_AHT_ratio: ISTBB
      ITJBB - of_case.Achieved_AHT_ratio: ITJBB
      IZMBA - of_case.Achieved_AHT_ratio: IZMBA
      IZMBB - of_case.Achieved_AHT_ratio: IZMBB
      JEDBA - of_case.Achieved_AHT_ratio: JEDBA
      JHBBB - of_case.Achieved_AHT_ratio: JHBBB
      JKTBB - of_case.Achieved_AHT_ratio: JKTBB
      JMNBB - of_case.Achieved_AHT_ratio: JMNBB
      JNBBB - of_case.Achieved_AHT_ratio: JNBBB
      KHHBB - of_case.Achieved_AHT_ratio: KHHBB
      KHIBB - of_case.Achieved_AHT_ratio: KHIBB
      KHLBB - of_case.Achieved_AHT_ratio: KHLBB
      KLPBA - of_case.Achieved_AHT_ratio: KLPBA
      KOPBA - of_case.Achieved_AHT_ratio: KOPBA
      LAXBB - of_case.Achieved_AHT_ratio: LAXBB
      LCBBB - of_case.Achieved_AHT_ratio: LCBBB
      LEHBB - of_case.Achieved_AHT_ratio: LEHBB
      LEXBB - of_case.Achieved_AHT_ratio: LEXBB
      LFWBA - of_case.Achieved_AHT_ratio: LFWBA
      LHEBB - of_case.Achieved_AHT_ratio: LHEBB
      LIMBB - of_case.Achieved_AHT_ratio: LIMBB
      LISBB - of_case.Achieved_AHT_ratio: LISBB
      LIVBB - of_case.Achieved_AHT_ratio: LIVBB
      LMSBA - of_case.Achieved_AHT_ratio: LMSBA
      LONBB - of_case.Achieved_AHT_ratio: LONBB
      LOSBB - of_case.Achieved_AHT_ratio: LOSBB
      LUHBB - of_case.Achieved_AHT_ratio: LUHBB
      LYGBB - of_case.Achieved_AHT_ratio: LYGBB
      MAABB - of_case.Achieved_AHT_ratio: MAABB
      MACBB - of_case.Achieved_AHT_ratio: MACBB
      MADBB - of_case.Achieved_AHT_ratio: MADBB
      MAOBB - of_case.Achieved_AHT_ratio: MAOBB
      MBABA - of_case.Achieved_AHT_ratio: MBABA
      MECBA - of_case.Achieved_AHT_ratio: MECBA
      MELBB - of_case.Achieved_AHT_ratio: MELBB
      MERBA - of_case.Achieved_AHT_ratio: MERBA
      MERBB - of_case.Achieved_AHT_ratio: MERBB
      MESBB - of_case.Achieved_AHT_ratio: MESBB
      MEXBB - of_case.Achieved_AHT_ratio: MEXBB
      MIBOS - of_case.Achieved_AHT_ratio: MIBOS
      MIHOS - of_case.Achieved_AHT_ratio: MIHOS
      MITBB - of_case.Achieved_AHT_ratio: MITBB
      MNGBA - of_case.Achieved_AHT_ratio: MNGBA
      MNLBB - of_case.Achieved_AHT_ratio: MNLBB
      MOWBB - of_case.Achieved_AHT_ratio: MOWBB
      MRSBB - of_case.Achieved_AHT_ratio: MRSBB
      MSUBA - of_case.Achieved_AHT_ratio: MSUBA
      MTABA - of_case.Achieved_AHT_ratio: MTABA
      MTYBB - of_case.Achieved_AHT_ratio: MTYBB
      MUMBB - of_case.Achieved_AHT_ratio: MUMBB
      MVDBB - of_case.Achieved_AHT_ratio: MVDBB
      NBOBB - of_case.Achieved_AHT_ratio: NBOBB
      NGOBB - of_case.Achieved_AHT_ratio: NGOBB
      NKGBB - of_case.Achieved_AHT_ratio: NKGBB
      NSABB - of_case.Achieved_AHT_ratio: NSABB
      NVSBA - of_case.Achieved_AHT_ratio: NVSBA
      NYCBB - of_case.Achieved_AHT_ratio: NYCBB
      ODSBA - of_case.Achieved_AHT_ratio: ODSBA
      OPOBB - of_case.Achieved_AHT_ratio: OPOBB
      OSABB - of_case.Achieved_AHT_ratio: OSABB
      PAIBB - of_case.Achieved_AHT_ratio: PAIBB
      PANBA - of_case.Achieved_AHT_ratio: PANBA
      PANBB - of_case.Achieved_AHT_ratio: PANBB
      PAVBB - of_case.Achieved_AHT_ratio: PAVBB
      PENBB - of_case.Achieved_AHT_ratio: PENBB
      PIRAEU - of_case.Achieved_AHT_ratio: PIRAE
      PKGBB - of_case.Achieved_AHT_ratio: PKGBB
      PLMBB - of_case.Achieved_AHT_ratio: PLMBB
      PLZBB - of_case.Achieved_AHT_ratio: PLZBB
      PNHBA - of_case.Achieved_AHT_ratio: PNHBA
      PNQBB - of_case.Achieved_AHT_ratio: PNQBB
      PPGBA - of_case.Achieved_AHT_ratio: PPGBA
      PPTBA - of_case.Achieved_AHT_ratio: PPTBA
      PRGBB - of_case.Achieved_AHT_ratio: PRGBB
      PSDBB - of_case.Achieved_AHT_ratio: PSDBB
      PTIBA - of_case.Achieved_AHT_ratio: PTIBA
      PTSBA - of_case.Achieved_AHT_ratio: PTSBA
      PUSBB - of_case.Achieved_AHT_ratio: PUSBB
      QITBA - of_case.Achieved_AHT_ratio: QITBA
      RHUBA - of_case.Achieved_AHT_ratio: RHUBA
      RICBB - of_case.Achieved_AHT_ratio: RICBB
      RIXBA - of_case.Achieved_AHT_ratio: RIXBA
      RJKBA - of_case.Achieved_AHT_ratio: RJKBA
      RTMBB - of_case.Achieved_AHT_ratio: RTMBB
      SALBA - of_case.Achieved_AHT_ratio: SALBA
      SAOBB - of_case.Achieved_AHT_ratio: SAOBB
      SCLBB - of_case.Achieved_AHT_ratio: SCLBB
      SEABB - of_case.Achieved_AHT_ratio: SEABB
      SELBB - of_case.Achieved_AHT_ratio: SELBB
      SFOBB - of_case.Achieved_AHT_ratio: SFOBB
      SFSBB - of_case.Achieved_AHT_ratio: SFSBB
      SGNBB - of_case.Achieved_AHT_ratio: SGNBB
      SGZBB - of_case.Achieved_AHT_ratio: SGZBB
      SHABB - of_case.Achieved_AHT_ratio: SHABB
      SIABB - of_case.Achieved_AHT_ratio: SIABB
      SINBB - of_case.Achieved_AHT_ratio: SINBB
      SINHO - of_case.Achieved_AHT_ratio: SINHO
      SJOBA - of_case.Achieved_AHT_ratio: SJOBA
      SJWBB - of_case.Achieved_AHT_ratio: SJWBB
      SKGBA - of_case.Achieved_AHT_ratio: SKGBA
      SMZBA - of_case.Achieved_AHT_ratio: SMZBA
      SOUBB - of_case.Achieved_AHT_ratio: SOUBB
      SPBBB - of_case.Achieved_AHT_ratio: SPBBB
      SPROS - of_case.Achieved_AHT_ratio: SPROS
      SRGBB - of_case.Achieved_AHT_ratio: SRGBB
      SSZBB - of_case.Achieved_AHT_ratio: SSZBB
      STRBB - of_case.Achieved_AHT_ratio: STRBB
      SUBBB - of_case.Achieved_AHT_ratio: SUBBB
      SUDBB - of_case.Achieved_AHT_ratio: SUDBB
      SUVBA - of_case.Achieved_AHT_ratio: SUVBA
      SUZBB - of_case.Achieved_AHT_ratio: SUZBB
      SYDBB - of_case.Achieved_AHT_ratio: SYDBB
      SZHBB - of_case.Achieved_AHT_ratio: SZHBB
      SZPBB - of_case.Achieved_AHT_ratio: SZPBB
      TAOBB - of_case.Achieved_AHT_ratio: TAOBB
      TBUBA - of_case.Achieved_AHT_ratio: TBUBA
      TEMBB - of_case.Achieved_AHT_ratio: TEMBB
      TGCBA - of_case.Achieved_AHT_ratio: TGCBA
      TLLBA - of_case.Achieved_AHT_ratio: TLLBA
      TLVBA - of_case.Achieved_AHT_ratio: TLVBA
      TORBB - of_case.Achieved_AHT_ratio: TORBB
      TPEBB - of_case.Achieved_AHT_ratio: TPEBB
      TPPBB - of_case.Achieved_AHT_ratio: TPPBB
      TRWBA - of_case.Achieved_AHT_ratio: TRWBA
      TSNBB - of_case.Achieved_AHT_ratio: TSNBB
      TUNBA - of_case.Achieved_AHT_ratio: TUNBA
      TUTBB - of_case.Achieved_AHT_ratio: TUTBB
      TXGBB - of_case.Achieved_AHT_ratio: TXGBB
      TYOBB - of_case.Achieved_AHT_ratio: TYOBB
      VANBB - of_case.Achieved_AHT_ratio: VANBB
      VAPBB - of_case.Achieved_AHT_ratio: VAPBB
      VARBA - of_case.Achieved_AHT_ratio: VARBA
      VGOBB - of_case.Achieved_AHT_ratio: VGOBB
      VLCBB - of_case.Achieved_AHT_ratio: VLCBB
      VLIBA - of_case.Achieved_AHT_ratio: VLIBA
      VNABB - of_case.Achieved_AHT_ratio: VNABB
      VTZBB - of_case.Achieved_AHT_ratio: VTZBB
      VVABB - of_case.Achieved_AHT_ratio: VVABB
      WGZOS - of_case.Achieved_AHT_ratio: WGZOS
      WMLOS - of_case.Achieved_AHT_ratio: WMLOS
      WNKOS - of_case.Achieved_AHT_ratio: WNKOS
      WUHBB - of_case.Achieved_AHT_ratio: WUHBB
      XMNBB - of_case.Achieved_AHT_ratio: XMNBB
      YGNBB - of_case.Achieved_AHT_ratio: YGNBB
      ZHOBB - of_case.Achieved_AHT_ratio: ZHOBB
      ZHUBB - of_case.Achieved_AHT_ratio: ZHUBB
      ZLOBB - of_case.Achieved_AHT_ratio: ZLOBB
      of_case.Case_Geo___null - of_case.Achieved_AHT_ratio: "∅"
      global: FY 23 Global Target
      Unclaimed - of_case.Achieved_AHT_ratio: Unclaimed
      global_target_chat: FY2023 Global Uniform Target (Chat)
      global_target_web: FY2023 Global Uniform Target (Web)
    series_point_styles:
      global_target_chat: diamond
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [of_case.target_measure_for_Chat2, of_case.target_measure_for_WEB2,
      of_case.target_for_chat]
    hidden_pivots:
      Global:
        measure_names: []
      HKGHQ:
        measure_names: []
      LONHQ:
        measure_names: []
      RICHQ:
        measure_names: []
      SAOHQ:
        measure_names: []
      SINHQ:
        measure_names: []
      Unclaimed:
        measure_names: []
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Average Handling
      Time<BR><B>How it Helps : </B>Shows how many % of cases achieve the target.<BR><B>Filter
      Tips : </B><BR>Handling Time = Case Level<BR>'
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Exclude Awaiting Internal AHT: of_case.Exclude_Awaiting_Internal_in_AHT
      Handling Time: of_case.handletime_Param
      AHT Calculated: of_case.is_aht_calculated
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 41
    col: 0
    width: 11
    height: 9
  - title: Web AHT Target Achievement
    name: Web AHT Target Achievement
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.createddate_dynamic, of_case.Case_Geo, of_case.target_for_web,
      of_case.Achieved_AHT_ratio]
    pivots: [of_case.Case_Geo]
    filters:
      channel_filter: Web
    sorts: [of_case.createddate_dynamic, of_case.Case_Geo]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields: [{category: table_calculation, expression: 'coalesce(pivot_where(${of_case.Case_Geo}="Global",if(is_null(${of_case.dynamic_reference}),-5,${of_case.dynamic_reference})),-5)',
        label: Global, value_format: !!null '', value_format_name: decimal_1, _kind_hint: supermeasure,
        table_calculation: global, _type_hint: number, is_disabled: true}, {category: table_calculation,
        expression: 'max(coalesce(max(pivot_row(${of_case.target_for_chat})),-10))',
        label: Global Target (Chat), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target_chat, _type_hint: number,
        is_disabled: true}, {category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_web})),-10))',
        label: Global Target (Web), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target_web, _type_hint: number},
      {category: dimension, expression: "${of_case.origin}", label: Channel Filter,
        value_format: !!null '', value_format_name: !!null '', dimension: channel_filter,
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
    stacking: ''
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
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.average_handling_time,
            id: Global - of_case.average_handling_time, name: Global}, {axisId: of_case.average_handling_time,
            id: Row Total - of_case.average_handling_time, name: Total}, {axisId: global_target,
            id: global_target, name: Global Target}, {axisId: hkghq_target, id: hkghq_target,
            name: HKGHQ Target}, {axisId: lonhq_target, id: lonhq_target, name: LONHQ
              Target}, {axisId: richq_target, id: richq_target, name: RICHQ Target},
          {axisId: saohq_target, id: saohq_target, name: SAOHQ Target}, {axisId: sinhq_target,
            id: sinhq_target, name: SINHQ Target}], showLabels: false, showValues: false,
        minValue: 0, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    label_value_format: ''
    series_types:
      Row Total - of_case.average_handling_time: line
      global_target: line
      hkghq_target: line
      lonhq_target: line
      richq_target: line
      saohq_target: line
      sinhq_target: line
      Row Total - of_case.new_aht: line
      hkghq: line
      lonhq: line
      richq: line
      sinhq: line
      saohq: line
      global: line
      global_target_chat: line
      global_target_web: line
      Row Total - of_case.Achieved_AHT_ratio: line
    series_colors:
      HKGHQ - of_case.Achieved_AHT_ratio: "#db72af"
      LONHQ - of_case.Achieved_AHT_ratio: "#00506D"
      RICHQ - of_case.Achieved_AHT_ratio: "#84C5C3"
      SAOHQ - of_case.Achieved_AHT_ratio: "#BD0F72"
      SINHQ - of_case.Achieved_AHT_ratio: "#8b908f"
      Row Total - of_case.Achieved_AHT_ratio: "#F39200"
      global_target: "#f277aa"
      global: "#340335"
      global_target_chat: "#70AD47"
      global_target_web: "#00B050"
    series_labels:
      1 - of_case.Achieved_AHT_ratio: GKA
      2 - of_case.Achieved_AHT_ratio: RKA
      3 - of_case.Achieved_AHT_ratio: LKA
      4 - of_case.Achieved_AHT_ratio: ONECare
      Row Total - of_case.Achieved_AHT_ratio: Total
      HKGHQ - of_case.Achieved_AHT_ratio: HKGHQ
      LONHQ - of_case.Achieved_AHT_ratio: LONHQ
      RICHQ - of_case.Achieved_AHT_ratio: RICHQ
      SAOHQ - of_case.Achieved_AHT_ratio: SAOHQ
      SINHQ - of_case.Achieved_AHT_ratio: SINHQ
      Global - of_case.Achieved_AHT_ratio: Global
      Chat - of_case.Achieved_AHT_ratio: Chat
      Email - of_case.Achieved_AHT_ratio: Email
      Manual - of_case.Achieved_AHT_ratio: Manual
      Web - of_case.Achieved_AHT_ratio: Web
      Phone - of_case.Achieved_AHT_ratio: Phone
      CCA - of_case.Achieved_AHT_ratio: CCA
      CCS - of_case.Achieved_AHT_ratio: CCS
      Others - of_case.Achieved_AHT_ratio: Others
      Sales Executive - of_case.Achieved_AHT_ratio: Sales Executive
      C-KAM - of_case.Achieved_AHT_ratio: C-KAM
      C-KAS - of_case.Achieved_AHT_ratio: C-KAS
      No KA Mapping - of_case.Achieved_AHT_ratio: No KA Mapping
      ONECare Queue - of_case.Achieved_AHT_ratio: ONECare Queue
      S-KAM - of_case.Achieved_AHT_ratio: S-KAM
      S-KAS - of_case.Achieved_AHT_ratio: S-KAS
      Onshore - of_case.Achieved_AHT_ratio: Onshore
      Offshore - of_case.Achieved_AHT_ratio: Offshore
      Complaint/Feedback - of_case.Achieved_AHT_ratio: Complaint/Feedback
      Complex - of_case.Achieved_AHT_ratio: Complex
      General Information - of_case.Achieved_AHT_ratio: General Information
      Inquiry - of_case.Achieved_AHT_ratio: Inquiry
      Internal - of_case.Achieved_AHT_ratio: Internal
      Service Request - of_case.Achieved_AHT_ratio: Service Request
      Service Failure - of_case.Achieved_AHT_ratio: Service Failure
      Transactional - of_case.Achieved_AHT_ratio: Transactional
      No Action Required - of_case.Achieved_AHT_ratio: No Action Required
      Internal Request - of_case.Achieved_AHT_ratio: Internal Request
      GKA - of_case.Achieved_AHT_ratio: GKA
      LKA - of_case.Achieved_AHT_ratio: LKA
      ONECare - of_case.Achieved_AHT_ratio: ONECare
      RKA - of_case.Achieved_AHT_ratio: RKA
      AE - of_case.Achieved_AHT_ratio: AE
      AR - of_case.Achieved_AHT_ratio: AR
      AT & HU - of_case.Achieved_AHT_ratio: AT & HU
      AU - of_case.Achieved_AHT_ratio: AU
      BD - of_case.Achieved_AHT_ratio: BD
      BR - of_case.Achieved_AHT_ratio: BR
      BE - of_case.Achieved_AHT_ratio: BE
      CH - of_case.Achieved_AHT_ratio: CH
      CL - of_case.Achieved_AHT_ratio: CL
      CN - of_case.Achieved_AHT_ratio: CN
      CO - of_case.Achieved_AHT_ratio: CO
      DE - of_case.Achieved_AHT_ratio: DE
      CZ & SK - of_case.Achieved_AHT_ratio: CZ & SK
      EC - of_case.Achieved_AHT_ratio: EC
      DK - of_case.Achieved_AHT_ratio: DK
      EG - of_case.Achieved_AHT_ratio: EG
      ES - of_case.Achieved_AHT_ratio: ES
      LK - of_case.Achieved_AHT_ratio: LK
      IT - of_case.Achieved_AHT_ratio: IT
      FI - of_case.Achieved_AHT_ratio: FI
      FR - of_case.Achieved_AHT_ratio: FR
      GB - of_case.Achieved_AHT_ratio: GB
      GH - of_case.Achieved_AHT_ratio: GH
      HK & SCN - of_case.Achieved_AHT_ratio: HK & SCN
      ID - of_case.Achieved_AHT_ratio: ID
      IL - of_case.Achieved_AHT_ratio: IL
      IN - of_case.Achieved_AHT_ratio: IN
      JP - of_case.Achieved_AHT_ratio: JP
      KR - of_case.Achieved_AHT_ratio: KR
      MA - of_case.Achieved_AHT_ratio: MA
      MM - of_case.Achieved_AHT_ratio: MM
      MX - of_case.Achieved_AHT_ratio: MX
      MY - of_case.Achieved_AHT_ratio: MY
      TR - of_case.Achieved_AHT_ratio: TR
      TW - of_case.Achieved_AHT_ratio: TW
      TH - of_case.Achieved_AHT_ratio: TH
      SE & NO - of_case.Achieved_AHT_ratio: SE & NO
      NG - of_case.Achieved_AHT_ratio: NG
      NL - of_case.Achieved_AHT_ratio: NL
      NZ - of_case.Achieved_AHT_ratio: NZ
      PA - of_case.Achieved_AHT_ratio: PA
      PE - of_case.Achieved_AHT_ratio: PE
      PH - of_case.Achieved_AHT_ratio: PH
      PK - of_case.Achieved_AHT_ratio: PK
      PL - of_case.Achieved_AHT_ratio: PL
      PT - of_case.Achieved_AHT_ratio: PT
      SG - of_case.Achieved_AHT_ratio: SG
      US - of_case.Achieved_AHT_ratio: US
      UY - of_case.Achieved_AHT_ratio: UY
      ZA - of_case.Achieved_AHT_ratio: ZA
      CA - of_case.Achieved_AHT_ratio: CA
      CI - of_case.Achieved_AHT_ratio: CI
      AT - of_case.Achieved_AHT_ratio: AT
      CZ - of_case.Achieved_AHT_ratio: CZ
      IE - of_case.Achieved_AHT_ratio: IE
      SK - of_case.Achieved_AHT_ratio: SK
      VN - of_case.Achieved_AHT_ratio: VN
      NO - of_case.Achieved_AHT_ratio: 'NO'
      AS - of_case.Achieved_AHT_ratio: AS
      BG - of_case.Achieved_AHT_ratio: BG
      CR - of_case.Achieved_AHT_ratio: CR
      CY - of_case.Achieved_AHT_ratio: CY
      DZ - of_case.Achieved_AHT_ratio: DZ
      EE - of_case.Achieved_AHT_ratio: EE
      FJ - of_case.Achieved_AHT_ratio: FJ
      GE - of_case.Achieved_AHT_ratio: GE
      GR - of_case.Achieved_AHT_ratio: GR
      GT - of_case.Achieved_AHT_ratio: GT
      HK - of_case.Achieved_AHT_ratio: HK
      HN - of_case.Achieved_AHT_ratio: HN
      HR - of_case.Achieved_AHT_ratio: HR
      HU - of_case.Achieved_AHT_ratio: HU
      KE - of_case.Achieved_AHT_ratio: KE
      KH - of_case.Achieved_AHT_ratio: KH
      KI - of_case.Achieved_AHT_ratio: KI
      LB - of_case.Achieved_AHT_ratio: LB
      LT - of_case.Achieved_AHT_ratio: LT
      LS - of_case.Achieved_AHT_ratio: LS
      LV - of_case.Achieved_AHT_ratio: LV
      MO - of_case.Achieved_AHT_ratio: MO
      MT - of_case.Achieved_AHT_ratio: MT
      NI - of_case.Achieved_AHT_ratio: NI
      PF - of_case.Achieved_AHT_ratio: PF
      RO - of_case.Achieved_AHT_ratio: RO
      SA - of_case.Achieved_AHT_ratio: SA
      SB - of_case.Achieved_AHT_ratio: SB
      SI - of_case.Achieved_AHT_ratio: SI
      SN - of_case.Achieved_AHT_ratio: SN
      SV - of_case.Achieved_AHT_ratio: SV
      TG - of_case.Achieved_AHT_ratio: TG
      TJ - of_case.Achieved_AHT_ratio: TJ
      TN - of_case.Achieved_AHT_ratio: TN
      TO - of_case.Achieved_AHT_ratio: TO
      TT - of_case.Achieved_AHT_ratio: TT
      UA - of_case.Achieved_AHT_ratio: UA
      VU - of_case.Achieved_AHT_ratio: VU
      WS - of_case.Achieved_AHT_ratio: WS
      ZW - of_case.Achieved_AHT_ratio: ZW
      ZZ - of_case.Achieved_AHT_ratio: ZZ
      AARBB - of_case.Achieved_AHT_ratio: AARBB
      ABJBB - of_case.Achieved_AHT_ratio: ABJBB
      ADLBB - of_case.Achieved_AHT_ratio: ADLBB
      AKLBB - of_case.Achieved_AHT_ratio: AKLBB
      ALGBB - of_case.Achieved_AHT_ratio: ALGBB
      ALJBA - of_case.Achieved_AHT_ratio: ALJBA
      ALYBB - of_case.Achieved_AHT_ratio: ALYBB
      AMDBB - of_case.Achieved_AHT_ratio: AMDBB
      ANRBB - of_case.Achieved_AHT_ratio: ANRBB
      APWBA - of_case.Achieved_AHT_ratio: APWBA
      ASHBA - of_case.Achieved_AHT_ratio: ASHBA
      ATLBB - of_case.Achieved_AHT_ratio: ATLBB
      BASBB - of_case.Achieved_AHT_ratio: BASBB
      BCNBB - of_case.Achieved_AHT_ratio: BCNBB
      BDOBB - of_case.Achieved_AHT_ratio: BDOBB
      BELBB - of_case.Achieved_AHT_ratio: BELBB
      BEYBA - of_case.Achieved_AHT_ratio: BEYBA
      BIOBB - of_case.Achieved_AHT_ratio: BIOBB
      BKKBB - of_case.Achieved_AHT_ratio: BKKBB
      BLRBB - of_case.Achieved_AHT_ratio: BLRBB
      BNDBB - of_case.Achieved_AHT_ratio: BNDBB
      BNEBB - of_case.Achieved_AHT_ratio: BNEBB
      BOGBB - of_case.Achieved_AHT_ratio: BOGBB
      BOIBB - of_case.Achieved_AHT_ratio: BOIBB
      BOSBB - of_case.Achieved_AHT_ratio: BOSBB
      BREBB - of_case.Achieved_AHT_ratio: BREBB
      BTMBB - of_case.Achieved_AHT_ratio: BTMBB
      BUDBB - of_case.Achieved_AHT_ratio: BUDBB
      BUEBB - of_case.Achieved_AHT_ratio: BUEBB
      CAIBB - of_case.Achieved_AHT_ratio: CAIBB
      CANBB - of_case.Achieved_AHT_ratio: CANBB
      CASBA - of_case.Achieved_AHT_ratio: CASBA
      CCPBB - of_case.Achieved_AHT_ratio: CCPBB
      CCUBB - of_case.Achieved_AHT_ratio: CCUBB
      CEBBB - of_case.Achieved_AHT_ratio: CEBBB
      CGOBB - of_case.Achieved_AHT_ratio: CGOBB
      CGPBB - of_case.Achieved_AHT_ratio: CGPBB
      CGYBB - of_case.Achieved_AHT_ratio: CGYBB
      CHCBB - of_case.Achieved_AHT_ratio: CHCBB
      CHIBB - of_case.Achieved_AHT_ratio: CHIBB
      CKGBB - of_case.Achieved_AHT_ratio: CKGBB
      CLLBB - of_case.Achieved_AHT_ratio: CLLBB
      CMBBB - of_case.Achieved_AHT_ratio: CMBBB
      CNDBA - of_case.Achieved_AHT_ratio: CNDBA
      COKBB - of_case.Achieved_AHT_ratio: COKBB
      CPTBB - of_case.Achieved_AHT_ratio: CPTBB
      CTUBB - of_case.Achieved_AHT_ratio: CTUBB
      CWBBB - of_case.Achieved_AHT_ratio: CWBBB
      DACBB - of_case.Achieved_AHT_ratio: DACBB
      DADBB - of_case.Achieved_AHT_ratio: DADBB
      DAMBB - of_case.Achieved_AHT_ratio: DAMBB
      DARBA - of_case.Achieved_AHT_ratio: DARBA
      DELBB - of_case.Achieved_AHT_ratio: DELBB
      DKRBA - of_case.Achieved_AHT_ratio: DKRBA
      DLCBB - of_case.Achieved_AHT_ratio: DLCBB
      DMNBA - of_case.Achieved_AHT_ratio: DMNBA
      DPSBB - of_case.Achieved_AHT_ratio: DPSBB
      DUBBA - of_case.Achieved_AHT_ratio: DUBBA
      DURBB - of_case.Achieved_AHT_ratio: DURBB
      DUSBB - of_case.Achieved_AHT_ratio: DUSBB
      DVOBB - of_case.Achieved_AHT_ratio: DVOBB
      DXBBB - of_case.Achieved_AHT_ratio: DXBBB
      EDKBB - of_case.Achieved_AHT_ratio: EDKBB
      ELSBB - of_case.Achieved_AHT_ratio: ELSBB
      FOCBB - of_case.Achieved_AHT_ratio: FOCBB
      FREBB - of_case.Achieved_AHT_ratio: FREBB
      GDLBB - of_case.Achieved_AHT_ratio: GDLBB
      GDNBB - of_case.Achieved_AHT_ratio: GDNBB
      GDYBB - of_case.Achieved_AHT_ratio: GDYBB
      GESBB - of_case.Achieved_AHT_ratio: GESBB
      GINBB - of_case.Achieved_AHT_ratio: GINBB
      GOABB - of_case.Achieved_AHT_ratio: GOABB
      GOTBB - of_case.Achieved_AHT_ratio: GOTBB
      GUABA - of_case.Achieved_AHT_ratio: GUABA
      GYEBB - of_case.Achieved_AHT_ratio: GYEBB
      HALBB - of_case.Achieved_AHT_ratio: HALBB
      HAMBB - of_case.Achieved_AHT_ratio: HAMBB
      HANBB - of_case.Achieved_AHT_ratio: HANBB
      HELBB - of_case.Achieved_AHT_ratio: HELBB
      HFABA - of_case.Achieved_AHT_ratio: HFABA
      HFEBB - of_case.Achieved_AHT_ratio: HFEBB
      HGHBB - of_case.Achieved_AHT_ratio: HGHBB
      HIRBA - of_case.Achieved_AHT_ratio: HIRBA
      HKGBB - of_case.Achieved_AHT_ratio: HKGBB
      HKTBA - of_case.Achieved_AHT_ratio: HKTBA
      HOUBB - of_case.Achieved_AHT_ratio: HOUBB
      HPHBB - of_case.Achieved_AHT_ratio: HPHBB
      HREBA - of_case.Achieved_AHT_ratio: HREBA
      HYDBB - of_case.Achieved_AHT_ratio: HYDBB
      ICDBB - of_case.Achieved_AHT_ratio: ICDBB
      IPSBB - of_case.Achieved_AHT_ratio: IPSBB
      IQQBB - of_case.Achieved_AHT_ratio: IQQBB
      ISTBA - of_case.Achieved_AHT_ratio: ISTBA
      ISTBB - of_case.Achieved_AHT_ratio: ISTBB
      ITJBB - of_case.Achieved_AHT_ratio: ITJBB
      IZMBA - of_case.Achieved_AHT_ratio: IZMBA
      IZMBB - of_case.Achieved_AHT_ratio: IZMBB
      JEDBA - of_case.Achieved_AHT_ratio: JEDBA
      JHBBB - of_case.Achieved_AHT_ratio: JHBBB
      JKTBB - of_case.Achieved_AHT_ratio: JKTBB
      JMNBB - of_case.Achieved_AHT_ratio: JMNBB
      JNBBB - of_case.Achieved_AHT_ratio: JNBBB
      KHHBB - of_case.Achieved_AHT_ratio: KHHBB
      KHIBB - of_case.Achieved_AHT_ratio: KHIBB
      KHLBB - of_case.Achieved_AHT_ratio: KHLBB
      KLPBA - of_case.Achieved_AHT_ratio: KLPBA
      KOPBA - of_case.Achieved_AHT_ratio: KOPBA
      LAXBB - of_case.Achieved_AHT_ratio: LAXBB
      LCBBB - of_case.Achieved_AHT_ratio: LCBBB
      LEHBB - of_case.Achieved_AHT_ratio: LEHBB
      LEXBB - of_case.Achieved_AHT_ratio: LEXBB
      LFWBA - of_case.Achieved_AHT_ratio: LFWBA
      LHEBB - of_case.Achieved_AHT_ratio: LHEBB
      LIMBB - of_case.Achieved_AHT_ratio: LIMBB
      LISBB - of_case.Achieved_AHT_ratio: LISBB
      LIVBB - of_case.Achieved_AHT_ratio: LIVBB
      LMSBA - of_case.Achieved_AHT_ratio: LMSBA
      LONBB - of_case.Achieved_AHT_ratio: LONBB
      LOSBB - of_case.Achieved_AHT_ratio: LOSBB
      LUHBB - of_case.Achieved_AHT_ratio: LUHBB
      LYGBB - of_case.Achieved_AHT_ratio: LYGBB
      MAABB - of_case.Achieved_AHT_ratio: MAABB
      MACBB - of_case.Achieved_AHT_ratio: MACBB
      MADBB - of_case.Achieved_AHT_ratio: MADBB
      MAOBB - of_case.Achieved_AHT_ratio: MAOBB
      MBABA - of_case.Achieved_AHT_ratio: MBABA
      MECBA - of_case.Achieved_AHT_ratio: MECBA
      MELBB - of_case.Achieved_AHT_ratio: MELBB
      MERBA - of_case.Achieved_AHT_ratio: MERBA
      MERBB - of_case.Achieved_AHT_ratio: MERBB
      MESBB - of_case.Achieved_AHT_ratio: MESBB
      MEXBB - of_case.Achieved_AHT_ratio: MEXBB
      MIBOS - of_case.Achieved_AHT_ratio: MIBOS
      MIHOS - of_case.Achieved_AHT_ratio: MIHOS
      MITBB - of_case.Achieved_AHT_ratio: MITBB
      MNGBA - of_case.Achieved_AHT_ratio: MNGBA
      MNLBB - of_case.Achieved_AHT_ratio: MNLBB
      MOWBB - of_case.Achieved_AHT_ratio: MOWBB
      MRSBB - of_case.Achieved_AHT_ratio: MRSBB
      MSUBA - of_case.Achieved_AHT_ratio: MSUBA
      MTABA - of_case.Achieved_AHT_ratio: MTABA
      MTYBB - of_case.Achieved_AHT_ratio: MTYBB
      MUMBB - of_case.Achieved_AHT_ratio: MUMBB
      MVDBB - of_case.Achieved_AHT_ratio: MVDBB
      NBOBB - of_case.Achieved_AHT_ratio: NBOBB
      NGOBB - of_case.Achieved_AHT_ratio: NGOBB
      NKGBB - of_case.Achieved_AHT_ratio: NKGBB
      NSABB - of_case.Achieved_AHT_ratio: NSABB
      NVSBA - of_case.Achieved_AHT_ratio: NVSBA
      NYCBB - of_case.Achieved_AHT_ratio: NYCBB
      ODSBA - of_case.Achieved_AHT_ratio: ODSBA
      OPOBB - of_case.Achieved_AHT_ratio: OPOBB
      OSABB - of_case.Achieved_AHT_ratio: OSABB
      PAIBB - of_case.Achieved_AHT_ratio: PAIBB
      PANBA - of_case.Achieved_AHT_ratio: PANBA
      PANBB - of_case.Achieved_AHT_ratio: PANBB
      PAVBB - of_case.Achieved_AHT_ratio: PAVBB
      PENBB - of_case.Achieved_AHT_ratio: PENBB
      PIRAEU - of_case.Achieved_AHT_ratio: PIRAE
      PKGBB - of_case.Achieved_AHT_ratio: PKGBB
      PLMBB - of_case.Achieved_AHT_ratio: PLMBB
      PLZBB - of_case.Achieved_AHT_ratio: PLZBB
      PNHBA - of_case.Achieved_AHT_ratio: PNHBA
      PNQBB - of_case.Achieved_AHT_ratio: PNQBB
      PPGBA - of_case.Achieved_AHT_ratio: PPGBA
      PPTBA - of_case.Achieved_AHT_ratio: PPTBA
      PRGBB - of_case.Achieved_AHT_ratio: PRGBB
      PSDBB - of_case.Achieved_AHT_ratio: PSDBB
      PTIBA - of_case.Achieved_AHT_ratio: PTIBA
      PTSBA - of_case.Achieved_AHT_ratio: PTSBA
      PUSBB - of_case.Achieved_AHT_ratio: PUSBB
      QITBA - of_case.Achieved_AHT_ratio: QITBA
      RHUBA - of_case.Achieved_AHT_ratio: RHUBA
      RICBB - of_case.Achieved_AHT_ratio: RICBB
      RIXBA - of_case.Achieved_AHT_ratio: RIXBA
      RJKBA - of_case.Achieved_AHT_ratio: RJKBA
      RTMBB - of_case.Achieved_AHT_ratio: RTMBB
      SALBA - of_case.Achieved_AHT_ratio: SALBA
      SAOBB - of_case.Achieved_AHT_ratio: SAOBB
      SCLBB - of_case.Achieved_AHT_ratio: SCLBB
      SEABB - of_case.Achieved_AHT_ratio: SEABB
      SELBB - of_case.Achieved_AHT_ratio: SELBB
      SFOBB - of_case.Achieved_AHT_ratio: SFOBB
      SFSBB - of_case.Achieved_AHT_ratio: SFSBB
      SGNBB - of_case.Achieved_AHT_ratio: SGNBB
      SGZBB - of_case.Achieved_AHT_ratio: SGZBB
      SHABB - of_case.Achieved_AHT_ratio: SHABB
      SIABB - of_case.Achieved_AHT_ratio: SIABB
      SINBB - of_case.Achieved_AHT_ratio: SINBB
      SINHO - of_case.Achieved_AHT_ratio: SINHO
      SJOBA - of_case.Achieved_AHT_ratio: SJOBA
      SJWBB - of_case.Achieved_AHT_ratio: SJWBB
      SKGBA - of_case.Achieved_AHT_ratio: SKGBA
      SMZBA - of_case.Achieved_AHT_ratio: SMZBA
      SOUBB - of_case.Achieved_AHT_ratio: SOUBB
      SPBBB - of_case.Achieved_AHT_ratio: SPBBB
      SPROS - of_case.Achieved_AHT_ratio: SPROS
      SRGBB - of_case.Achieved_AHT_ratio: SRGBB
      SSZBB - of_case.Achieved_AHT_ratio: SSZBB
      STRBB - of_case.Achieved_AHT_ratio: STRBB
      SUBBB - of_case.Achieved_AHT_ratio: SUBBB
      SUDBB - of_case.Achieved_AHT_ratio: SUDBB
      SUVBA - of_case.Achieved_AHT_ratio: SUVBA
      SUZBB - of_case.Achieved_AHT_ratio: SUZBB
      SYDBB - of_case.Achieved_AHT_ratio: SYDBB
      SZHBB - of_case.Achieved_AHT_ratio: SZHBB
      SZPBB - of_case.Achieved_AHT_ratio: SZPBB
      TAOBB - of_case.Achieved_AHT_ratio: TAOBB
      TBUBA - of_case.Achieved_AHT_ratio: TBUBA
      TEMBB - of_case.Achieved_AHT_ratio: TEMBB
      TGCBA - of_case.Achieved_AHT_ratio: TGCBA
      TLLBA - of_case.Achieved_AHT_ratio: TLLBA
      TLVBA - of_case.Achieved_AHT_ratio: TLVBA
      TORBB - of_case.Achieved_AHT_ratio: TORBB
      TPEBB - of_case.Achieved_AHT_ratio: TPEBB
      TPPBB - of_case.Achieved_AHT_ratio: TPPBB
      TRWBA - of_case.Achieved_AHT_ratio: TRWBA
      TSNBB - of_case.Achieved_AHT_ratio: TSNBB
      TUNBA - of_case.Achieved_AHT_ratio: TUNBA
      TUTBB - of_case.Achieved_AHT_ratio: TUTBB
      TXGBB - of_case.Achieved_AHT_ratio: TXGBB
      TYOBB - of_case.Achieved_AHT_ratio: TYOBB
      VANBB - of_case.Achieved_AHT_ratio: VANBB
      VAPBB - of_case.Achieved_AHT_ratio: VAPBB
      VARBA - of_case.Achieved_AHT_ratio: VARBA
      VGOBB - of_case.Achieved_AHT_ratio: VGOBB
      VLCBB - of_case.Achieved_AHT_ratio: VLCBB
      VLIBA - of_case.Achieved_AHT_ratio: VLIBA
      VNABB - of_case.Achieved_AHT_ratio: VNABB
      VTZBB - of_case.Achieved_AHT_ratio: VTZBB
      VVABB - of_case.Achieved_AHT_ratio: VVABB
      WGZOS - of_case.Achieved_AHT_ratio: WGZOS
      WMLOS - of_case.Achieved_AHT_ratio: WMLOS
      WNKOS - of_case.Achieved_AHT_ratio: WNKOS
      WUHBB - of_case.Achieved_AHT_ratio: WUHBB
      XMNBB - of_case.Achieved_AHT_ratio: XMNBB
      YGNBB - of_case.Achieved_AHT_ratio: YGNBB
      ZHOBB - of_case.Achieved_AHT_ratio: ZHOBB
      ZHUBB - of_case.Achieved_AHT_ratio: ZHUBB
      ZLOBB - of_case.Achieved_AHT_ratio: ZLOBB
      of_case.Case_Geo___null - of_case.Achieved_AHT_ratio: "∅"
      global: FY 23 Global Target
      Unclaimed - of_case.Achieved_AHT_ratio: Unclaimed
      global_target_chat: FY2023 Global Uniform Target (Chat)
      global_target_web: FY2023 Global Uniform Target (Web)
    series_point_styles:
      global_target_chat: diamond
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [of_case.target_measure_for_Chat2, of_case.target_measure_for_WEB2,
      of_case.target_for_web]
    hidden_pivots:
      Global:
        measure_names: []
      HKGHQ:
        measure_names: []
      LONHQ:
        measure_names: []
      RICHQ:
        measure_names: []
      SAOHQ:
        measure_names: []
      SINHQ:
        measure_names: []
      Unclaimed:
        measure_names: []
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Average Handling
      Time<BR><B>How it Helps : </B>Shows how many % of cases achieve the target.<BR><B>Filter
      Tips : </B><BR>Handling Time = Case Level<BR>'
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      Exclude Awaiting Internal AHT: of_case.Exclude_Awaiting_Internal_in_AHT
      Handling Time: of_case.handletime_Param
      AHT Calculated: of_case.is_aht_calculated
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 41
    col: 11
    width: 11
    height: 9
  - title: Web FRT Target Achievement
    name: Web FRT Target Achievement
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.createddate_dynamic, of_case.Case_Geo, of_case.target_for_web,
      of_case.Achieved_FRT_ratio]
    pivots: [of_case.Case_Geo]
    filters:
      of_case.is_channel_applicable_for_FRT: 'Yes'
      channel_filter: Web
    sorts: [of_case.createddate_dynamic, of_case.Case_Geo]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields: [{category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_web})),-10))',
        label: Global Target (Web), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target_web, _type_hint: number},
      {category: table_calculation, expression: 'max(coalesce(max(pivot_row(${of_case.target_for_chat})),-10))

          ', label: Global Target (Chat), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: global_target_chat, _type_hint: number,
        is_disabled: true}, {category: dimension, expression: "${of_case.origin}",
        label: Channel Filter, value_format: !!null '', value_format_name: !!null '',
        dimension: channel_filter, _kind_hint: dimension, _type_hint: string}]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: Row Total - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: Total}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: HKGHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: HKGHQ}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: LONHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: LONHQ}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: RICHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: RICHQ}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: SAOHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: SAOHQ}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: SINHQ - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: SINHQ}, {axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            id: Unclaimed - of_case.AVG_FIRST_RESPONSE_TIME_NEW, name: Unclaimed -
              Case Average First Response Time New}, {axisId: of_case.dynamic_reference,
            id: Row Total - of_case.dynamic_reference, name: FY 23 - Global Target}],
        showLabels: false, showValues: false, minValue: 0, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: false
    label_value_format: ''
    series_types:
      Row Total - of_case.AVG_FIRST_RESPONSE_TIME: line
      Row Total - of_case.AVG_FIRST_RESPONSE_TIME_NEW: line
      global_target: line
      hkghq_target: line
      lonhq_target: line
      richq_target: line
      sinhq_target: line
      saohq_target: line
      hkghq: line
      lonhq: line
      richq: line
      sinhq: line
      saohq: line
      global: line
      Row Total - of_case.dynamic_reference: line
      global_target_web: line
      global_target_chat: line
      Row Total - of_case.Achieved_FRT_ratio: line
    series_colors:
      HKGHQ - of_case.Achieved_FRT_ratio: "#db72af"
      LONHQ - of_case.Achieved_FRT_ratio: "#00506D"
      RICHQ - of_case.Achieved_FRT_ratio: "#84C5C3"
      SAOHQ - of_case.Achieved_FRT_ratio: "#BD0F72"
      SINHQ - of_case.Achieved_FRT_ratio: "#8b908f"
      Row Total - of_case.Achieved_FRT_ratio: "#F39200"
      global_target: "#f277aa"
      global: "#340335"
      global_target_chat: "#70AD47"
      global_target_web: "#00B050"
    series_labels:
      1 - of_case.Achieved_FRT_ratio: GKA
      2 - of_case.Achieved_FRT_ratio: RKA
      3 - of_case.Achieved_FRT_ratio: LKA
      4 - of_case.Achieved_FRT_ratio: ONECare
      Row Total - of_case.Achieved_FRT_ratio: Total
      HKGHQ - of_case.Achieved_FRT_ratio: HKGHQ
      LONHQ - of_case.Achieved_FRT_ratio: LONHQ
      RICHQ - of_case.Achieved_FRT_ratio: RICHQ
      SAOHQ - of_case.Achieved_FRT_ratio: SAOHQ
      SINHQ - of_case.Achieved_FRT_ratio: SINHQ
      Global - of_case.Achieved_FRT_ratio: Global
      Chat - of_case.Achieved_FRT_ratio: Chat
      Email - of_case.Achieved_FRT_ratio: Email
      Manual - of_case.Achieved_FRT_ratio: Manual
      Web - of_case.Achieved_FRT_ratio: Web
      Phone - of_case.Achieved_FRT_ratio: Phone
      CCA - of_case.Achieved_FRT_ratio: CCA
      CCS - of_case.Achieved_FRT_ratio: CCS
      Others - of_case.Achieved_FRT_ratio: Others
      Sales Executive - of_case.Achieved_FRT_ratio: Sales Executive
      C-KAM - of_case.Achieved_FRT_ratio: C-KAM
      C-KAS - of_case.Achieved_FRT_ratio: C-KAS
      No KA Mapping - of_case.Achieved_FRT_ratio: No KA Mapping
      ONECare Queue - of_case.Achieved_FRT_ratio: ONECare Queue
      S-KAM - of_case.Achieved_FRT_ratio: S-KAM
      S-KAS - of_case.Achieved_FRT_ratio: S-KAS
      Onshore - of_case.Achieved_FRT_ratio: Onshore
      Offshore - of_case.Achieved_FRT_ratio: Offshore
      Complaint/Feedback - of_case.Achieved_FRT_ratio: Complaint/Feedback
      Complex - of_case.Achieved_FRT_ratio: Complex
      General Information - of_case.Achieved_FRT_ratio: General Information
      Inquiry - of_case.Achieved_FRT_ratio: Inquiry
      Internal - of_case.Achieved_FRT_ratio: Internal
      Service Request - of_case.Achieved_FRT_ratio: Service Request
      Service Failure - of_case.Achieved_FRT_ratio: Service Failure
      Transactional - of_case.Achieved_FRT_ratio: Transactional
      No Action Required - of_case.Achieved_FRT_ratio: No Action Required
      Internal Request - of_case.Achieved_FRT_ratio: Internal Request
      GKA - of_case.Achieved_FRT_ratio: GKA
      LKA - of_case.Achieved_FRT_ratio: LKA
      ONECare - of_case.Achieved_FRT_ratio: ONECare
      RKA - of_case.Achieved_FRT_ratio: RKA
      AE - of_case.Achieved_FRT_ratio: AE
      AR - of_case.Achieved_FRT_ratio: AR
      AT & HU - of_case.Achieved_FRT_ratio: AT & HU
      AU - of_case.Achieved_FRT_ratio: AU
      BD - of_case.Achieved_FRT_ratio: BD
      BR - of_case.Achieved_FRT_ratio: BR
      BE - of_case.Achieved_FRT_ratio: BE
      CH - of_case.Achieved_FRT_ratio: CH
      CL - of_case.Achieved_FRT_ratio: CL
      CN - of_case.Achieved_FRT_ratio: CN
      CO - of_case.Achieved_FRT_ratio: CO
      DE - of_case.Achieved_FRT_ratio: DE
      CZ & SK - of_case.Achieved_FRT_ratio: CZ & SK
      EC - of_case.Achieved_FRT_ratio: EC
      DK - of_case.Achieved_FRT_ratio: DK
      EG - of_case.Achieved_FRT_ratio: EG
      ES - of_case.Achieved_FRT_ratio: ES
      LK - of_case.Achieved_FRT_ratio: LK
      IT - of_case.Achieved_FRT_ratio: IT
      FI - of_case.Achieved_FRT_ratio: FI
      FR - of_case.Achieved_FRT_ratio: FR
      GB - of_case.Achieved_FRT_ratio: GB
      GH - of_case.Achieved_FRT_ratio: GH
      HK & SCN - of_case.Achieved_FRT_ratio: HK & SCN
      ID - of_case.Achieved_FRT_ratio: ID
      IL - of_case.Achieved_FRT_ratio: IL
      IN - of_case.Achieved_FRT_ratio: IN
      JP - of_case.Achieved_FRT_ratio: JP
      KR - of_case.Achieved_FRT_ratio: KR
      MA - of_case.Achieved_FRT_ratio: MA
      MM - of_case.Achieved_FRT_ratio: MM
      MX - of_case.Achieved_FRT_ratio: MX
      MY - of_case.Achieved_FRT_ratio: MY
      TR - of_case.Achieved_FRT_ratio: TR
      TW - of_case.Achieved_FRT_ratio: TW
      TH - of_case.Achieved_FRT_ratio: TH
      SE & NO - of_case.Achieved_FRT_ratio: SE & NO
      NG - of_case.Achieved_FRT_ratio: NG
      NL - of_case.Achieved_FRT_ratio: NL
      NZ - of_case.Achieved_FRT_ratio: NZ
      PA - of_case.Achieved_FRT_ratio: PA
      PE - of_case.Achieved_FRT_ratio: PE
      PH - of_case.Achieved_FRT_ratio: PH
      PK - of_case.Achieved_FRT_ratio: PK
      PL - of_case.Achieved_FRT_ratio: PL
      PT - of_case.Achieved_FRT_ratio: PT
      SG - of_case.Achieved_FRT_ratio: SG
      US - of_case.Achieved_FRT_ratio: US
      UY - of_case.Achieved_FRT_ratio: UY
      ZA - of_case.Achieved_FRT_ratio: ZA
      CA - of_case.Achieved_FRT_ratio: CA
      CI - of_case.Achieved_FRT_ratio: CI
      AT - of_case.Achieved_FRT_ratio: AT
      CZ - of_case.Achieved_FRT_ratio: CZ
      IE - of_case.Achieved_FRT_ratio: IE
      SK - of_case.Achieved_FRT_ratio: SK
      VN - of_case.Achieved_FRT_ratio: VN
      NO - of_case.Achieved_FRT_ratio: 'NO'
      AS - of_case.Achieved_FRT_ratio: AS
      BG - of_case.Achieved_FRT_ratio: BG
      CR - of_case.Achieved_FRT_ratio: CR
      CY - of_case.Achieved_FRT_ratio: CY
      DZ - of_case.Achieved_FRT_ratio: DZ
      EE - of_case.Achieved_FRT_ratio: EE
      FJ - of_case.Achieved_FRT_ratio: FJ
      GE - of_case.Achieved_FRT_ratio: GE
      GR - of_case.Achieved_FRT_ratio: GR
      GT - of_case.Achieved_FRT_ratio: GT
      HK - of_case.Achieved_FRT_ratio: HK
      HN - of_case.Achieved_FRT_ratio: HN
      HR - of_case.Achieved_FRT_ratio: HR
      HU - of_case.Achieved_FRT_ratio: HU
      KE - of_case.Achieved_FRT_ratio: KE
      KH - of_case.Achieved_FRT_ratio: KH
      KI - of_case.Achieved_FRT_ratio: KI
      LB - of_case.Achieved_FRT_ratio: LB
      LT - of_case.Achieved_FRT_ratio: LT
      LS - of_case.Achieved_FRT_ratio: LS
      LV - of_case.Achieved_FRT_ratio: LV
      MO - of_case.Achieved_FRT_ratio: MO
      MT - of_case.Achieved_FRT_ratio: MT
      NI - of_case.Achieved_FRT_ratio: NI
      PF - of_case.Achieved_FRT_ratio: PF
      RO - of_case.Achieved_FRT_ratio: RO
      SA - of_case.Achieved_FRT_ratio: SA
      SB - of_case.Achieved_FRT_ratio: SB
      SI - of_case.Achieved_FRT_ratio: SI
      SN - of_case.Achieved_FRT_ratio: SN
      SV - of_case.Achieved_FRT_ratio: SV
      TG - of_case.Achieved_FRT_ratio: TG
      TJ - of_case.Achieved_FRT_ratio: TJ
      TN - of_case.Achieved_FRT_ratio: TN
      TO - of_case.Achieved_FRT_ratio: TO
      TT - of_case.Achieved_FRT_ratio: TT
      UA - of_case.Achieved_FRT_ratio: UA
      VU - of_case.Achieved_FRT_ratio: VU
      WS - of_case.Achieved_FRT_ratio: WS
      ZW - of_case.Achieved_FRT_ratio: ZW
      ZZ - of_case.Achieved_FRT_ratio: ZZ
      AARBB - of_case.Achieved_FRT_ratio: AARBB
      ABJBB - of_case.Achieved_FRT_ratio: ABJBB
      ADLBB - of_case.Achieved_FRT_ratio: ADLBB
      AKLBB - of_case.Achieved_FRT_ratio: AKLBB
      ALGBB - of_case.Achieved_FRT_ratio: ALGBB
      ALJBA - of_case.Achieved_FRT_ratio: ALJBA
      ALYBB - of_case.Achieved_FRT_ratio: ALYBB
      AMDBB - of_case.Achieved_FRT_ratio: AMDBB
      ANRBB - of_case.Achieved_FRT_ratio: ANRBB
      APWBA - of_case.Achieved_FRT_ratio: APWBA
      ASHBA - of_case.Achieved_FRT_ratio: ASHBA
      ATLBB - of_case.Achieved_FRT_ratio: ATLBB
      BASBB - of_case.Achieved_FRT_ratio: BASBB
      BCNBB - of_case.Achieved_FRT_ratio: BCNBB
      BDOBB - of_case.Achieved_FRT_ratio: BDOBB
      BELBB - of_case.Achieved_FRT_ratio: BELBB
      BEYBA - of_case.Achieved_FRT_ratio: BEYBA
      BIOBB - of_case.Achieved_FRT_ratio: BIOBB
      BKKBB - of_case.Achieved_FRT_ratio: BKKBB
      BLRBB - of_case.Achieved_FRT_ratio: BLRBB
      BNDBB - of_case.Achieved_FRT_ratio: BNDBB
      BNEBB - of_case.Achieved_FRT_ratio: BNEBB
      BOGBB - of_case.Achieved_FRT_ratio: BOGBB
      BOIBB - of_case.Achieved_FRT_ratio: BOIBB
      BOSBB - of_case.Achieved_FRT_ratio: BOSBB
      BREBB - of_case.Achieved_FRT_ratio: BREBB
      BTMBB - of_case.Achieved_FRT_ratio: BTMBB
      BUDBB - of_case.Achieved_FRT_ratio: BUDBB
      BUEBB - of_case.Achieved_FRT_ratio: BUEBB
      CAIBB - of_case.Achieved_FRT_ratio: CAIBB
      CANBB - of_case.Achieved_FRT_ratio: CANBB
      CASBA - of_case.Achieved_FRT_ratio: CASBA
      CCPBB - of_case.Achieved_FRT_ratio: CCPBB
      CCUBB - of_case.Achieved_FRT_ratio: CCUBB
      CEBBB - of_case.Achieved_FRT_ratio: CEBBB
      CGOBB - of_case.Achieved_FRT_ratio: CGOBB
      CGPBB - of_case.Achieved_FRT_ratio: CGPBB
      CGYBB - of_case.Achieved_FRT_ratio: CGYBB
      CHCBB - of_case.Achieved_FRT_ratio: CHCBB
      CHIBB - of_case.Achieved_FRT_ratio: CHIBB
      CKGBB - of_case.Achieved_FRT_ratio: CKGBB
      CLLBB - of_case.Achieved_FRT_ratio: CLLBB
      CMBBB - of_case.Achieved_FRT_ratio: CMBBB
      CNDBA - of_case.Achieved_FRT_ratio: CNDBA
      COKBB - of_case.Achieved_FRT_ratio: COKBB
      CPTBB - of_case.Achieved_FRT_ratio: CPTBB
      CTUBB - of_case.Achieved_FRT_ratio: CTUBB
      CWBBB - of_case.Achieved_FRT_ratio: CWBBB
      DACBB - of_case.Achieved_FRT_ratio: DACBB
      DADBB - of_case.Achieved_FRT_ratio: DADBB
      DAMBB - of_case.Achieved_FRT_ratio: DAMBB
      DARBA - of_case.Achieved_FRT_ratio: DARBA
      DELBB - of_case.Achieved_FRT_ratio: DELBB
      DKRBA - of_case.Achieved_FRT_ratio: DKRBA
      DLCBB - of_case.Achieved_FRT_ratio: DLCBB
      DMNBA - of_case.Achieved_FRT_ratio: DMNBA
      DPSBB - of_case.Achieved_FRT_ratio: DPSBB
      DUBBA - of_case.Achieved_FRT_ratio: DUBBA
      DURBB - of_case.Achieved_FRT_ratio: DURBB
      DUSBB - of_case.Achieved_FRT_ratio: DUSBB
      DVOBB - of_case.Achieved_FRT_ratio: DVOBB
      DXBBB - of_case.Achieved_FRT_ratio: DXBBB
      EDKBB - of_case.Achieved_FRT_ratio: EDKBB
      ELSBB - of_case.Achieved_FRT_ratio: ELSBB
      FOCBB - of_case.Achieved_FRT_ratio: FOCBB
      FREBB - of_case.Achieved_FRT_ratio: FREBB
      GDLBB - of_case.Achieved_FRT_ratio: GDLBB
      GDNBB - of_case.Achieved_FRT_ratio: GDNBB
      GDYBB - of_case.Achieved_FRT_ratio: GDYBB
      GESBB - of_case.Achieved_FRT_ratio: GESBB
      GINBB - of_case.Achieved_FRT_ratio: GINBB
      GOABB - of_case.Achieved_FRT_ratio: GOABB
      GOTBB - of_case.Achieved_FRT_ratio: GOTBB
      GUABA - of_case.Achieved_FRT_ratio: GUABA
      GYEBB - of_case.Achieved_FRT_ratio: GYEBB
      HALBB - of_case.Achieved_FRT_ratio: HALBB
      HAMBB - of_case.Achieved_FRT_ratio: HAMBB
      HANBB - of_case.Achieved_FRT_ratio: HANBB
      HELBB - of_case.Achieved_FRT_ratio: HELBB
      HFABA - of_case.Achieved_FRT_ratio: HFABA
      HFEBB - of_case.Achieved_FRT_ratio: HFEBB
      HGHBB - of_case.Achieved_FRT_ratio: HGHBB
      HIRBA - of_case.Achieved_FRT_ratio: HIRBA
      HKGBB - of_case.Achieved_FRT_ratio: HKGBB
      HKTBA - of_case.Achieved_FRT_ratio: HKTBA
      HOUBB - of_case.Achieved_FRT_ratio: HOUBB
      HPHBB - of_case.Achieved_FRT_ratio: HPHBB
      HREBA - of_case.Achieved_FRT_ratio: HREBA
      HYDBB - of_case.Achieved_FRT_ratio: HYDBB
      ICDBB - of_case.Achieved_FRT_ratio: ICDBB
      IPSBB - of_case.Achieved_FRT_ratio: IPSBB
      IQQBB - of_case.Achieved_FRT_ratio: IQQBB
      ISTBA - of_case.Achieved_FRT_ratio: ISTBA
      ISTBB - of_case.Achieved_FRT_ratio: ISTBB
      ITJBB - of_case.Achieved_FRT_ratio: ITJBB
      IZMBA - of_case.Achieved_FRT_ratio: IZMBA
      IZMBB - of_case.Achieved_FRT_ratio: IZMBB
      JEDBA - of_case.Achieved_FRT_ratio: JEDBA
      JHBBB - of_case.Achieved_FRT_ratio: JHBBB
      JKTBB - of_case.Achieved_FRT_ratio: JKTBB
      JMNBB - of_case.Achieved_FRT_ratio: JMNBB
      JNBBB - of_case.Achieved_FRT_ratio: JNBBB
      KHHBB - of_case.Achieved_FRT_ratio: KHHBB
      KHIBB - of_case.Achieved_FRT_ratio: KHIBB
      KHLBB - of_case.Achieved_FRT_ratio: KHLBB
      KLPBA - of_case.Achieved_FRT_ratio: KLPBA
      KOPBA - of_case.Achieved_FRT_ratio: KOPBA
      LAXBB - of_case.Achieved_FRT_ratio: LAXBB
      LCBBB - of_case.Achieved_FRT_ratio: LCBBB
      LEHBB - of_case.Achieved_FRT_ratio: LEHBB
      LEXBB - of_case.Achieved_FRT_ratio: LEXBB
      LFWBA - of_case.Achieved_FRT_ratio: LFWBA
      LHEBB - of_case.Achieved_FRT_ratio: LHEBB
      LIMBB - of_case.Achieved_FRT_ratio: LIMBB
      LISBB - of_case.Achieved_FRT_ratio: LISBB
      LIVBB - of_case.Achieved_FRT_ratio: LIVBB
      LMSBA - of_case.Achieved_FRT_ratio: LMSBA
      LONBB - of_case.Achieved_FRT_ratio: LONBB
      LOSBB - of_case.Achieved_FRT_ratio: LOSBB
      LUHBB - of_case.Achieved_FRT_ratio: LUHBB
      LYGBB - of_case.Achieved_FRT_ratio: LYGBB
      MAABB - of_case.Achieved_FRT_ratio: MAABB
      MACBB - of_case.Achieved_FRT_ratio: MACBB
      MADBB - of_case.Achieved_FRT_ratio: MADBB
      MAOBB - of_case.Achieved_FRT_ratio: MAOBB
      MBABA - of_case.Achieved_FRT_ratio: MBABA
      MECBA - of_case.Achieved_FRT_ratio: MECBA
      MELBB - of_case.Achieved_FRT_ratio: MELBB
      MERBA - of_case.Achieved_FRT_ratio: MERBA
      MERBB - of_case.Achieved_FRT_ratio: MERBB
      MESBB - of_case.Achieved_FRT_ratio: MESBB
      MEXBB - of_case.Achieved_FRT_ratio: MEXBB
      MIBOS - of_case.Achieved_FRT_ratio: MIBOS
      MIHOS - of_case.Achieved_FRT_ratio: MIHOS
      MITBB - of_case.Achieved_FRT_ratio: MITBB
      MNGBA - of_case.Achieved_FRT_ratio: MNGBA
      MNLBB - of_case.Achieved_FRT_ratio: MNLBB
      MOWBB - of_case.Achieved_FRT_ratio: MOWBB
      MRSBB - of_case.Achieved_FRT_ratio: MRSBB
      MSUBA - of_case.Achieved_FRT_ratio: MSUBA
      MTABA - of_case.Achieved_FRT_ratio: MTABA
      MTYBB - of_case.Achieved_FRT_ratio: MTYBB
      MUMBB - of_case.Achieved_FRT_ratio: MUMBB
      MVDBB - of_case.Achieved_FRT_ratio: MVDBB
      NBOBB - of_case.Achieved_FRT_ratio: NBOBB
      NGOBB - of_case.Achieved_FRT_ratio: NGOBB
      NKGBB - of_case.Achieved_FRT_ratio: NKGBB
      NSABB - of_case.Achieved_FRT_ratio: NSABB
      NVSBA - of_case.Achieved_FRT_ratio: NVSBA
      NYCBB - of_case.Achieved_FRT_ratio: NYCBB
      ODSBA - of_case.Achieved_FRT_ratio: ODSBA
      OPOBB - of_case.Achieved_FRT_ratio: OPOBB
      OSABB - of_case.Achieved_FRT_ratio: OSABB
      PAIBB - of_case.Achieved_FRT_ratio: PAIBB
      PANBA - of_case.Achieved_FRT_ratio: PANBA
      PANBB - of_case.Achieved_FRT_ratio: PANBB
      PAVBB - of_case.Achieved_FRT_ratio: PAVBB
      PENBB - of_case.Achieved_FRT_ratio: PENBB
      PIRAEU - of_case.Achieved_FRT_ratio: PIRAE
      PKGBB - of_case.Achieved_FRT_ratio: PKGBB
      PLMBB - of_case.Achieved_FRT_ratio: PLMBB
      PLZBB - of_case.Achieved_FRT_ratio: PLZBB
      PNHBA - of_case.Achieved_FRT_ratio: PNHBA
      PNQBB - of_case.Achieved_FRT_ratio: PNQBB
      PPGBA - of_case.Achieved_FRT_ratio: PPGBA
      PPTBA - of_case.Achieved_FRT_ratio: PPTBA
      PRGBB - of_case.Achieved_FRT_ratio: PRGBB
      PSDBB - of_case.Achieved_FRT_ratio: PSDBB
      PTIBA - of_case.Achieved_FRT_ratio: PTIBA
      PTSBA - of_case.Achieved_FRT_ratio: PTSBA
      PUSBB - of_case.Achieved_FRT_ratio: PUSBB
      QITBA - of_case.Achieved_FRT_ratio: QITBA
      RHUBA - of_case.Achieved_FRT_ratio: RHUBA
      RICBB - of_case.Achieved_FRT_ratio: RICBB
      RIXBA - of_case.Achieved_FRT_ratio: RIXBA
      RJKBA - of_case.Achieved_FRT_ratio: RJKBA
      RTMBB - of_case.Achieved_FRT_ratio: RTMBB
      SALBA - of_case.Achieved_FRT_ratio: SALBA
      SAOBB - of_case.Achieved_FRT_ratio: SAOBB
      SCLBB - of_case.Achieved_FRT_ratio: SCLBB
      SEABB - of_case.Achieved_FRT_ratio: SEABB
      SELBB - of_case.Achieved_FRT_ratio: SELBB
      SFOBB - of_case.Achieved_FRT_ratio: SFOBB
      SFSBB - of_case.Achieved_FRT_ratio: SFSBB
      SGNBB - of_case.Achieved_FRT_ratio: SGNBB
      SGZBB - of_case.Achieved_FRT_ratio: SGZBB
      SHABB - of_case.Achieved_FRT_ratio: SHABB
      SIABB - of_case.Achieved_FRT_ratio: SIABB
      SINBB - of_case.Achieved_FRT_ratio: SINBB
      SINHO - of_case.Achieved_FRT_ratio: SINHO
      SJOBA - of_case.Achieved_FRT_ratio: SJOBA
      SJWBB - of_case.Achieved_FRT_ratio: SJWBB
      SKGBA - of_case.Achieved_FRT_ratio: SKGBA
      SMZBA - of_case.Achieved_FRT_ratio: SMZBA
      SOUBB - of_case.Achieved_FRT_ratio: SOUBB
      SPBBB - of_case.Achieved_FRT_ratio: SPBBB
      SPROS - of_case.Achieved_FRT_ratio: SPROS
      SRGBB - of_case.Achieved_FRT_ratio: SRGBB
      SSZBB - of_case.Achieved_FRT_ratio: SSZBB
      STRBB - of_case.Achieved_FRT_ratio: STRBB
      SUBBB - of_case.Achieved_FRT_ratio: SUBBB
      SUDBB - of_case.Achieved_FRT_ratio: SUDBB
      SUVBA - of_case.Achieved_FRT_ratio: SUVBA
      SUZBB - of_case.Achieved_FRT_ratio: SUZBB
      SYDBB - of_case.Achieved_FRT_ratio: SYDBB
      SZHBB - of_case.Achieved_FRT_ratio: SZHBB
      SZPBB - of_case.Achieved_FRT_ratio: SZPBB
      TAOBB - of_case.Achieved_FRT_ratio: TAOBB
      TBUBA - of_case.Achieved_FRT_ratio: TBUBA
      TEMBB - of_case.Achieved_FRT_ratio: TEMBB
      TGCBA - of_case.Achieved_FRT_ratio: TGCBA
      TLLBA - of_case.Achieved_FRT_ratio: TLLBA
      TLVBA - of_case.Achieved_FRT_ratio: TLVBA
      TORBB - of_case.Achieved_FRT_ratio: TORBB
      TPEBB - of_case.Achieved_FRT_ratio: TPEBB
      TPPBB - of_case.Achieved_FRT_ratio: TPPBB
      TRWBA - of_case.Achieved_FRT_ratio: TRWBA
      TSNBB - of_case.Achieved_FRT_ratio: TSNBB
      TUNBA - of_case.Achieved_FRT_ratio: TUNBA
      TUTBB - of_case.Achieved_FRT_ratio: TUTBB
      TXGBB - of_case.Achieved_FRT_ratio: TXGBB
      TYOBB - of_case.Achieved_FRT_ratio: TYOBB
      VANBB - of_case.Achieved_FRT_ratio: VANBB
      VAPBB - of_case.Achieved_FRT_ratio: VAPBB
      VARBA - of_case.Achieved_FRT_ratio: VARBA
      VGOBB - of_case.Achieved_FRT_ratio: VGOBB
      VLCBB - of_case.Achieved_FRT_ratio: VLCBB
      VLIBA - of_case.Achieved_FRT_ratio: VLIBA
      VNABB - of_case.Achieved_FRT_ratio: VNABB
      VTZBB - of_case.Achieved_FRT_ratio: VTZBB
      VVABB - of_case.Achieved_FRT_ratio: VVABB
      WGZOS - of_case.Achieved_FRT_ratio: WGZOS
      WMLOS - of_case.Achieved_FRT_ratio: WMLOS
      WNKOS - of_case.Achieved_FRT_ratio: WNKOS
      WUHBB - of_case.Achieved_FRT_ratio: WUHBB
      XMNBB - of_case.Achieved_FRT_ratio: XMNBB
      YGNBB - of_case.Achieved_FRT_ratio: YGNBB
      ZHOBB - of_case.Achieved_FRT_ratio: ZHOBB
      ZHUBB - of_case.Achieved_FRT_ratio: ZHUBB
      ZLOBB - of_case.Achieved_FRT_ratio: ZLOBB
      of_case.Case_Geo___null - of_case.Achieved_FRT_ratio: "∅"
      global: FY 23 Global Target
      Unclaimed - of_case.Achieved_FRT_ratio: Unclaimed
      global_target_chat: FY2023 Global Uniform Target (Chat)
      global_target_web: FY2023 Global Uniform Target (Web)
    series_point_styles:
      global: auto
      global_target_chat: diamond
    show_null_points: true
    interpolation: monotone
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Average First Response
      Time<BR><B>How it Helps : </B>Shows how many % of cases achieve the target.<BR><B>Filter
      Tips : </B><BR>Channel = Web, First Response Time = Case Level<BR>'
    hidden_pivots:
      '1':
        measure_names: []
      Global:
        measure_names: []
      HKGHQ:
        measure_names: []
      LONHQ:
        measure_names: []
      RICHQ:
        measure_names: []
      SAOHQ:
        measure_names: []
      SINHQ:
        measure_names: []
      Unclaimed:
        measure_names: []
    hidden_fields: [of_case.target_measure_for_WEB2, of_case.target_measure_for_Chat2,
      of_case.target_for_web]
    listen:
      Status: of_case.status
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Open Date: of_case.createddate_filter_date
      Category (L1): of_case.reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      First Contact Resolution: of_case.first_contact_resolution
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Case Rating: of_case.case_rating
      Date Granularity: of_case.timeframe_picker
      Service or Contract Customer: of_case.Service_Contract_Customer
      Priority: of_case.priority
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Office Type: case_owner.officetype
      Case Owner: case_owner.name
      Profile: case_owner.profile_name_service
      Subtopic (L4): of_case.subordinate_category_l4
      Resolution Reason: of_case.resolution_reason
      Source of Chat: of_chat_transcript.origin
      Queue Owner Name: of_queue.developer_name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      Customer Group: of_customer_group.cust_grp_and_name
      Customer: of_customer.customer_cd_and_name
      Contact Name: of_contact.name
      Contract Number: of_case.contract_number
      Sales Team Member: of_sales_team_member.team_role
      Customer Type: of_customer.customer_type
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Country (Case Owner): user_office_hierarchy.country
      Office (Case Owner): user_office_hierarchy.office_code
      Has Leave Message: of_case.has_leave_message_filter
      Required Awaiting Internal Response: of_case_history_air.status_case_Analysis
      First Response Time: of_case.responsetime_Param
      Role: of_escalation_history.role
      Channel: of_case.origin
      Do not use(Dynamic Filter): of_case.Case_Geo
    row: 23
    col: 10
    width: 11
    height: 9
  - type: button
    name: button_16806
    rich_content_json: '{"text":"Link to Service KPI Definition","description":"","newTab":true,"alignment":"right","size":"medium","style":"FILLED","color":"#BD0F72","href":"https://docs.google.com/spreadsheets/d/1iV5sa_Bivxi6L8VDA1l4tsT3uclPjERkcxh9lTbFTuI/edit#gid=1240332461"}'
    row: 0
    col: 0
    width: 24
    height: 1
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
      options: []
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.status
  - name: RHQ (Case)
    title: RHQ (Case)
    type: field_filter
    default_value: HKGHQ,LONHQ,RICHQ,SAOHQ,SINHQ
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: [Cluster Country, Individual Country, Office (Case)]
    field: of_case.Regional_Head_Office
  - name: Cluster Country
    title: Cluster Country
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: oneforce_service
    explore: of_case
    listens_to_filters: [RHQ (Case), Individual Country, Office (Case)]
    field: of_case.case_country
  - name: Individual Country
    title: Individual Country
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
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
      options: []
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
      options: []
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
      options: []
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
      options: []
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
      options: []
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
      options: []
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
      options: []
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
      options: []
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.timeframe_picker
  - name: Handling Time
    title: Handling Time
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
    field: of_case.handletime_Param
  - name: First Response Time
    title: First Response Time
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
    field: of_case.responsetime_Param
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
  - name: Exclude Awaiting Internal AHT
    title: Exclude Awaiting Internal AHT
    type: field_filter
    default_value: 'No'
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_toggles
      display: inline
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.Exclude_Awaiting_Internal_in_AHT
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
      - Segment
      - Agent Role
      - Escalation Role
      - Office Type
      - Service Type
      - Office
      - Cluster Country
      - Individual Country
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.Geo_Param
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
      options: []
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
      options: []
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
      options: []
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
  - name: Required Awaiting Internal Response
    title: Required Awaiting Internal Response
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
    field: of_case_history_air.status_case_Analysis
  - name: Customer Group
    title: Customer Group
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: overflow
      options: []
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
      options: []
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
      options: []
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
      options: []
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
      options: []
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
      options: []
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
      options: []
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
      options: []
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
      options: []
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
      options: []
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
      options: []
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.original_record_type
  - name: AHT Calculated
    title: AHT Calculated
    type: field_filter
    default_value: 'Yes'
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
    field: of_case.is_aht_calculated
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
  - name: Do not use(Dynamic Filter)
    title: Do not use(Dynamic Filter)
    type: field_filter
    default_value: "-Others,-Sales Executive,-No KA Mapping,-ONECare Queue"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: overflow
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.Case_Geo
  - name: Is Within Business Hour (Abandoned Chat Ratio)
    title: Is Within Business Hour (Abandoned Chat Ratio)
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
    field: of_case.isWithInBusinessHour
