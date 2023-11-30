- dashboard: check_poc2
  title: Check Poc2
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''
  query_timezone: UTC
  filters_bar_collapsed: true
  preferred_slug: x1oyb1jqQYYELpQYyLahVq
  elements:
  - title: Avg FRT by Channel
    name: Avg FRT by Channel
    model: oneforce_service
    explore: of_case
    type: looker_bar
    fields: [of_case.origin, of_case.AVG_FIRST_RESPONSE_TIME_NEW, of_case.case_distinct_count]
    filters:
      of_case.is_channel_applicable_for_FRT: 'Yes'
    sorts: [of_case.origin]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: true
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
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: of_case.case_distinct_count,
            id: of_case.case_distinct_count, name: Case}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: '', orientation: bottom,
        series: [{axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW, id: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            name: FRT (Minutes)}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_label: ''
    x_axis_zoom: true
    y_axis_zoom: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    font_size: '12'
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    series_types:
      of_case.AVG_FIRST_RESPONSE_TIME_NEW: line
    series_colors:
      Email - of_case.AVG_FIRST_RESPONSE_TIME: "#00506D"
      Webform - of_case.AVG_FIRST_RESPONSE_TIME: "#AB6E13"
      Chat - of_case.AVG_FIRST_RESPONSE_TIME: "#7f0b4d"
      of_case.count: "#BD0F72"
      of_case.AVG_FIRST_RESPONSE_TIME: "#84C5C3"
      of_case.case_distinct_count: "#BD0F72"
      of_case.AVG_FIRST_RESPONSE_TIME_NEW: "#84C5C3"
    series_labels:
      of_case.case_distinct_count: Case
      of_case.AVG_FIRST_RESPONSE_TIME_NEW: FRT (Minutes)
    label_color: []
    label_rotation: 0
    x_axis_datetime_label: ''
    trend_lines: []
    column_spacing_ratio: 0.2
    color_range: ["#4285F4", "#EA4335", "#FBBC04", "#34A852", "#5F6368"]
    color_by: node
    show_null_points: false
    value_format_override: ''
    show_percent: true
    bar_arm_length: 25
    bar_arm_weight: 50
    bar_spinner_length: 100
    bar_spinner_weight: 50
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    hidden_fields: []
    hidden_points_if_no: []
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
    up_color: false
    down_color: false
    total_color: false
    interpolation: linear
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Average First Response
      Time by Channel<BR><B>How it Helps : </B>To evaluate First Response to Customers
      by Channel<BR>[For Case FRT,  it is measured from Case Creation Date/time to
      First Reply by CCA to Customer]<BR>[For Chat FRT,  the Start Time is now condition-based:<BR>If
      Customer send 1st msg, then that should be the start time<BR>If Agent sends
      a 1st msg before Customer 1st msg, then the start time should be the Automated
      Bot Greeting msg<BR>End Time is always based on:<BR>Agent’s first typed in msg
      (including “Hi” or “Hello”).]<BR><B>Target : </B>By Email: TBD By Phone: TBD
      By Chat: TBD By Web: TBD'
    hidden_pivots: {}
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
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
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Avg FRT by: of_case.avg_FRT_param
      First Response Time: of_case.responsetime_Param
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 0
    col: 15
    width: 9
    height: 6
  - title: FCR Ratio
    name: FCR Ratio
    model: oneforce_service
    explore: of_case
    type: marketplace_viz_liquid_fill_gauge::liquid_fill_gauge-marketplace
    fields: [of_case.AVG_FIRST_CONTACT_RESOLUTION]
    limit: 500
    hidden_fields: []
    hidden_points_if_no: []
    show_view_names: true
    showComparison: false
    minValue: 0
    maxValue: 1
    circleThickness: 0.05
    circleFillGap: 0.05
    circleColor: "#00506D"
    waveHeight: 0.3
    waveCount: 4
    waveRiseTime: 2200
    waveAnimateTime: 2201
    waveRise: true
    waveHeightScaling: true
    waveAnimate: true
    waveColor: "#BD0F72"
    waveOffset: 0
    textVertPosition: 0.49
    textSize: 0.86
    valueCountUp: true
    displayPercent: false
    textColor: "#000000"
    waveTextColor: "#FFFFFF"
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
    note_state: expanded
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>First Contact Resolution
      Ratio - Global Index<BR><B>How it Helps : </B>To evaluate FCR cases resolved
      by CCA Globally<BR>[For non Chat cases, counted as FCR if the case has no transfer
      and escalation activity]<BR>[For Chat cases, counted as FCR if the case has
      no transfer and escalation activity and Created date is the same as Resolved
      date]<BR><B>Target : </B>TBD'
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Resolution Reason: of_case.resolution_reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      Contract Number: of_case.contract_number
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 6
    col: 0
    width: 6
    height: 6
  - title: Escl by Location*
    name: Escl by Location*
    model: oneforce_service
    explore: of_case
    type: looker_donut_multiples
    fields: [of_escalation_history.role, of_case.Case_Geo, of_case.case_distinct_count_drill]
    pivots: [of_escalation_history.role]
    filters:
      of_case.total_escalation: ">0"
    sorts: [of_escalation_history.role, of_case.Case_Geo]
    limit: 500
    show_value_labels: true
    font_size: 12
    charts_across:
    hide_legend: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
        reverse: false
    series_colors:
      Others - of_case.escalated_case_count: "#8b908f"
      S-KAS - of_case.escalated_case_count: "#7f0b4d"
      C-KAS - of_case.escalated_case_count: "#340335"
      S-KAM - of_case.escalated_case_count: "#00506D"
    value_labels: labels
    label_type: labVal
    inner_radius: 70
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
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: of_case.count, id: of_case.count,
            name: Case}], showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    defaults_version: 1
    show_null_points: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    note_state: collapsed
    note_display: hover
    note_text: "<P style=\"text-align:left;\"><B>Metric Name : </B>Escalated Cases\
      \ <BR><B>How it Helps : </B>To evaluate number of escalated cases <BR>[Number\
      \ of cases where Total Escalation>0]<BR><B>Target : </B>S-KAS: TBD S-KAM: TBD\
      \ C-KAS: TBD C-KAM: TBD\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
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
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 24
    col: 6
    width: 18
    height: 6
  - name: '<a target="_blank" style="color:#BD0F72; font-size:1vw"  href="https://onelinecloudlookercom/embed/dashboards-next/1118"><b>Fullscreen?</b></a><p
      style="font-size:1vw">Version: 20231031 </p> '
    type: text
    title_text: '<a target="_blank" style="color:#BD0F72; font-size:1vw"  href="https://oneline.cloud.looker.com/embed/dashboards-next/1118"><b>Fullscreen?</b></a><p
      style="font-size:1vw">Version: 2023.10.31 </p> '
    body_text: ''
    row: 100
    col: 20
    width: 4
    height: 3
  - title: FCR Ratio by Channel*
    name: FCR Ratio by Channel*
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.AVG_FIRST_CONTACT_RESOLUTION, of_case.origin, of_case.Case_Geo]
    pivots: [of_case.origin]
    sorts: [of_case.origin, of_case.Case_Geo]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    show_null_points: false
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: Chat - of_case.AVG_FIRST_CONTACT_RESOLUTION,
            id: Chat - of_case.AVG_FIRST_CONTACT_RESOLUTION, name: Chat}, {axisId: Email
              - of_case.AVG_FIRST_CONTACT_RESOLUTION, id: Email - of_case.AVG_FIRST_CONTACT_RESOLUTION,
            name: Email}, {axisId: Internal - of_case.AVG_FIRST_CONTACT_RESOLUTION,
            id: Internal - of_case.AVG_FIRST_CONTACT_RESOLUTION, name: Internal},
          {axisId: Phone - of_case.AVG_FIRST_CONTACT_RESOLUTION, id: Phone - of_case.AVG_FIRST_CONTACT_RESOLUTION,
            name: Phone}, {axisId: Web - of_case.AVG_FIRST_CONTACT_RESOLUTION, id: Web
              - of_case.AVG_FIRST_CONTACT_RESOLUTION, name: Web}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_label: Country (Case Owner)
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '20'
    hide_legend: false
    series_colors:
      of_case.count: "#BD0F72"
      Email - of_case.AVG_FIRST_CONTACT_RESOLUTION: "#00506D"
      Webform - of_case.AVG_FIRST_CONTACT_RESOLUTION: "#F39200"
      Phone - of_case.AVG_FIRST_CONTACT_RESOLUTION: "#8b908f"
      Web - of_case.AVG_FIRST_CONTACT_RESOLUTION: "#3D7876"
    series_point_styles:
      of_case.AVG_FIRST_CONTACT_RESOLUTION: diamond
      Chat - of_case.AVG_FIRST_CONTACT_RESOLUTION: square
      Webform - of_case.AVG_FIRST_CONTACT_RESOLUTION: square
      Internal - of_case.AVG_FIRST_CONTACT_RESOLUTION: square
      Web - of_case.AVG_FIRST_CONTACT_RESOLUTION: square
    swap_axes: false
    hidden_fields: []
    hidden_points_if_no: []
    showComparison: false
    minValue: 0
    maxValue: 1
    circleThickness: 0.05
    circleFillGap: 0.05
    circleColor: "#178BCA"
    waveHeight: 0.3
    waveCount: 4
    waveRiseTime: 2200
    waveAnimateTime: 2201
    waveRise: true
    waveHeightScaling: true
    waveAnimate: true
    waveColor: "#0ebcdb"
    waveOffset: 0
    textVertPosition: 0.49
    textSize: 0.86
    valueCountUp: true
    displayPercent: true
    textColor: "#000000"
    waveTextColor: "#FFFFFF"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    note_state: expanded
    note_display: hover
    note_text: "<P style=\"text-align:left;\"><B>Metric Name : </B>First Contact Resolution\
      \ Ratio by Channel<BR><B>How it Helps : </B>To evaluate cases resolved by First\
      \ Contact CCA Channelwise<BR>[Case resolution without inter / intra team transfer\
      \ & escalation]<BR><B>Target : </B>By Email: TBD By Phone: TBD By Chat: TBD\
      \ By Web: TBD\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Resolution Reason: of_case.resolution_reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      Contract Number: of_case.contract_number
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 12
    col: 6
    width: 9
    height: 6
  - title: Avg FRT by Location*
    name: Avg FRT by Location*
    model: oneforce_service
    explore: of_case
    type: looker_bar
    fields: [of_case.Case_Geo, of_case.AVG_FIRST_RESPONSE_TIME_NEW, of_case.case_distinct_count]
    filters:
      of_case.is_channel_applicable_for_FRT: 'Yes'
    sorts: [of_case.Case_Geo]
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
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
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
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: of_case.case_distinct_count,
            id: of_case.case_distinct_count, name: Case}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}, {label: '', orientation: bottom,
        series: [{axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW, id: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            name: FRT (Minutes)}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}]
    size_by_field: of_queue_member.queue_size
    x_axis_zoom: true
    y_axis_zoom: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '20'
    hide_legend: false
    font_size: '12'
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    series_types:
      of_case.AVG_FIRST_RESPONSE_TIME_NEW: line
    series_colors:
      of_case.AVG_FIRST_RESPONSE_TIME: "#84C5C3"
      of_queue_member.queue_size: "#7f0b4d"
      of_case.case_distinct_count: "#BD0F72"
      of_case.AVG_FIRST_RESPONSE_TIME_NEW: "#84C5C3"
    series_labels:
      of_case.case_distinct_count: Case
      of_case.AVG_FIRST_RESPONSE_TIME_NEW: FRT (Minutes)
    show_null_points: false
    color_range: ["#4285F4", "#EA4335", "#FBBC04", "#34A852", "#5F6368"]
    color_by: node
    value_format_override: ''
    show_percent: true
    bar_arm_length: 25
    bar_arm_weight: 50
    bar_spinner_length: 100
    bar_spinner_weight: 50
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    hidden_fields: []
    hidden_points_if_no: []
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
    up_color: false
    down_color: false
    total_color: false
    interpolation: linear
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Average First Response
      Time<BR><B>How it Helps : </B>To evaluate First Response to Customers<BR>[For
      Case FRT,  it is measured from Case Creation Date/time to First Reply by CCA
      to Customer]<BR>[For Chat FRT,  the Start Time is now condition-based:<BR>If
      Customer send 1st msg, then that should be the start time<BR>If Agent sends
      a 1st msg before Customer 1st msg, then the start time should be the Automated
      Bot Greeting msg<BR>End Time is always based on:<BR>Agent’s first typed in msg
      (including “Hi” or “Hello”).]<BR><B>Target : </B>TBD'
    hidden_pivots: {}
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
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
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Avg FRT by: of_case.avg_FRT_param
      First Response Time: of_case.responsetime_Param
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 0
    col: 6
    width: 9
    height: 6
  - title: FCR Ratio by Location*
    name: FCR Ratio by Location*
    model: oneforce_service
    explore: of_case
    type: looker_bar
    fields: [of_case.Case_Geo, of_case.first_contact_resolution, of_case.case_distinct_count_fcr]
    pivots: [of_case.first_contact_resolution]
    sorts: [of_case.first_contact_resolution desc, of_case.case_distinct_count_fcr
        desc 0]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: false
    show_y_axis_ticks: false
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
    totals_color: "#CCD3D1"
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: of_case.AVG_FIRST_CONTACT_RESOLUTION,
            id: of_case.AVG_FIRST_CONTACT_RESOLUTION, name: FCR}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, type: linear},
      {label: '', orientation: bottom, series: [{axisId: of_case.case_distinct_count,
            id: of_case.case_distinct_count, name: Case}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}]
    size_by_field: ''
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    font_size: '12'
    series_colors:
      Bad: "#000000"
      Good: "#BD0F72"
      of_case.case_distinct_count: "#F39200"
      of_case.AVG_FIRST_CONTACT_RESOLUTION: "#00506D"
      Yes - of_case.case_distinct_count: "#BD0F72"
      No - of_case.case_distinct_count: "#CCD3D1"
    label_color: []
    column_group_spacing_ratio: 0.1
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: true
    rightAxisLabel: ''
    smoothedBars: false
    isStepped: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    value_labels: labels
    label_type: labPer
    inner_radius: 20
    color_range: ["#4285F4", "#EA4335", "#FBBC04", "#34A852", "#5F6368"]
    color_by: node
    show_null_points: false
    value_format_override: ''
    show_percent: true
    arm_length: 25
    arm_weight: 50
    spinner_length: 100
    spinner_weight: 50
    viz_trellis_by: none
    angle: 90
    cutout: 50
    range_x: 1
    range_y: 1
    up_color: "#BD0F72"
    down_color: "#F39200"
    total_color: "#00506D"
    interpolation: linear
    bar_arm_length: 25
    bar_arm_weight: 50
    bar_spinner_length: 100
    bar_spinner_weight: 50
    defaults_version: 1
    hidden_fields: []
    hidden_points_if_no: []
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
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>First Contact Resolution<BR><B>How
      it Helps : </B>To evaluate FCR cases resolved by CCA<BR>[For non Chat cases,
      counted as FCR if the case has no transfer and escalation activity]<BR>[For
      Chat cases, counted as FCR if the case has no transfer and escalation activity
      and Created date is the same as Resolved date]<BR><B>Target : </B>TBD'
    hidden_pivots: {}
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Resolution Reason: of_case.resolution_reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      Contract Number: of_case.contract_number
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 6
    col: 15
    width: 9
    height: 6
  - title: Open Cases by Priority*
    name: Open Cases by Priority*
    model: oneforce_service
    explore: of_case
    type: looker_donut_multiples
    fields: [of_case.priority, of_case.Case_Geo, of_case.case_distinct_count]
    pivots: [of_case.priority]
    filters:
      of_case.active_case: 'Yes'
    sorts: [of_case.priority, of_case.Case_Geo]
    limit: 500
    column_limit: 50
    show_value_labels: true
    font_size: 14
    charts_across: 3
    hide_legend: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
        reverse: false
    series_colors:
      OD--> - of_case.AVG_FIRST_RESPONSE_TIME: "#CCD3D1"
      LONHQ - of_case.AVG_FIRST_RESPONSE_TIME: "#3D7876"
      SINHO - of_case.AVG_FIRST_RESPONSE_TIME: "#7f0b4d"
      SAOHQ - of_case.AVG_FIRST_RESPONSE_TIME: "#AB6E13"
      High - of_case.case_resolved___null - of_case.count: "#e3eae8"
      Urgent - Yes - of_case.count: "#FFE2B7"
      Medium - of_case.case_resolved___null - of_case.count: "#e3eae8"
      Urgent - No - of_case.count: "#F39200"
      Medium - Yes - of_case.count: "#CFEFEE"
      Medium - No - of_case.count: "#3D7876"
      No - Medium - of_case.count: "#CFEFEE"
      No - Urgent - of_case.count: "#FFE2B7"
      Yes - Medium - of_case.count: "#3D7876"
      Yes - Urgent - of_case.count: "#AB6E13"
      No - High - of_case.count: "#e7dae7"
      Yes - Low - of_case.count: "#8b908f"
      No - Low - of_case.count: "#CCD3D1"
      Yes - High - of_case.count: "#000000"
      High - of_case.count: "#F39200"
      Urgent - of_case.count: "#000000"
      Medium - of_case.count: "#BD0F72"
      Low - of_case.count: "#00506D"
      High - of_case.case_distinct_count: "#F39200"
      Low - of_case.case_distinct_count: "#00506D"
      Medium - of_case.case_distinct_count: "#BD0F72"
      Urgent - of_case.case_distinct_count: "#000000"
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
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
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
    hidden_fields: []
    hidden_points_if_no: []
    note_state: collapsed
    note_display: hover
    note_text: "<P style=\"text-align:left;\"><B>Metric Name : </B>Open Cases by Priority<BR><B>How\
      \ it Helps : </B>To evaluate Open cases by Priority<BR>[Case Status ≠ \"Resolved\"\
      \ & \"Closed\"]<BR><B>Target : </B>Urgent: TBD High: TBD Medium: TBD Low: TBD\t\
      \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
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
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Case status and priority: of_case.case_group_param
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 30
    col: 12
    width: 12
    height: 8
  - title: Age of Open Cases (In Days)*
    name: Age of Open Cases (In Days)*
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [average_of_case_age, of_case.Case_Geo]
    filters:
      of_case.active_case: 'Yes'
    sorts: [of_case.Case_Geo]
    dynamic_fields:
    - category: dimension
      expression: contains(${of_case.contactemail},"@one-line.com")
      label: Is ONE Contact
      value_format:
      value_format_name:
      dimension: is_one_contact
      _kind_hint: dimension
      _type_hint: yesno
    - category: measure
      expression: ''
      label: Average of Case Age
      value_format:
      value_format_name: decimal_0
      based_on: of_case.case_age
      _kind_hint: measure
      measure: average_of_case_age
      type: average
      _type_hint: number
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: true
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
    totals_color: "#808080"
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: of_case.AVG_FIRST_RESPONSE_TIME,
            id: of_case.AVG_FIRST_RESPONSE_TIME, name: Case Average First Response
              Time}, {axisId: of_case.count, id: of_case.count, name: Number Of Cases}],
        showLabels: false, showValues: false, valueFormat: '', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: log}]
    x_axis_label: ''
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: 0
    hide_legend: false
    font_size: '12'
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    series_colors:
      Email - of_case.AVG_FIRST_RESPONSE_TIME: "#00506D"
      Webform - of_case.AVG_FIRST_RESPONSE_TIME: "#AB6E13"
      Chat - of_case.AVG_FIRST_RESPONSE_TIME: "#7f0b4d"
      of_case.count: "#8b908f"
      of_case.AVG_FIRST_RESPONSE_TIME: "#BD0F72"
      Yes - of_case.case_distinct_count: "#3D7876"
      No - of_case.case_distinct_count: "#84C5C3"
    label_color: []
    label_rotation: 0
    x_axis_datetime_label: ''
    trend_lines: []
    column_spacing_ratio: 0.2
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_column_widths:
      average_of_case_age: 143
    series_cell_visualizations:
      average_of_case_age:
        is_active: true
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 1
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: true
    map_value_colors: ["#AB6E13", "#F39200", "#FFE2B7"]
    map_value_scale_clamp_min: 0
    map_value_scale_clamp_max:
    rotation: false
    color_range: ["#4285F4", "#EA4335", "#FBBC04", "#34A852", "#5F6368"]
    color_by: node
    show_null_points: false
    value_format_override: ''
    show_percent: true
    bar_arm_length: 25
    bar_arm_weight: 50
    bar_spinner_length: 100
    bar_spinner_weight: 50
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    hidden_fields: []
    hidden_points_if_no: []
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
    up_color: false
    down_color: false
    total_color: false
    interpolation: linear
    note_state: collapsed
    note_display: hover
    note_text: "<P style=\"text-align:left;\"><B>Metric Name : </B>Age of Open Cases\
      \ (In Days)<BR><B>How it Helps : </B>To evaluate age of Open cases<BR>[Age of\
      \ Open cases from creation to current status ≠ \"close\"]<BR><B>Target : </B>TBD\t\
      \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
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
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 12
    col: 0
    width: 6
    height: 6
  - title: Cases by Status*
    name: Cases by Status*
    model: oneforce_service
    explore: of_case
    type: looker_donut_multiples
    fields: [of_case.status, of_case.case_distinct_count, of_case.Case_Geo]
    pivots: [of_case.status]
    sorts: [of_case.status, of_case.Case_Geo]
    limit: 500
    show_value_labels: true
    font_size: 12
    charts_across: 3
    hide_legend: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
        reverse: false
    series_colors:
      Others - of_case.escalated_case_count: "#8b908f"
      S-KAS - of_case.escalated_case_count: "#7f0b4d"
      C-KAS - of_case.escalated_case_count: "#340335"
      S-KAM - of_case.escalated_case_count: "#00506D"
      Awaiting Customer Response - of_case.case_distinct_count: "#340335"
      Awaiting Internal Team Response - of_case.case_distinct_count: "#7f0b4d"
      In Progress - of_case.case_distinct_count: "#BD0F72"
      New - of_case.case_distinct_count: "#00506D"
      Closed - of_case.case_distinct_count: "#000000"
      Resolved - of_case.case_distinct_count: "#8b908f"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: of_case.count, id: of_case.count,
            name: Case}], showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
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
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: labels
    label_type: labVal
    inner_radius: 70
    defaults_version: 1
    show_null_points: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    note_state: collapsed
    note_display: hover
    note_text: "<P style=\"text-align:left;\"><B>Metric Name : </B>Cases by Status<BR><B>How\
      \ it Helps : </B>To evaluate number of case by Status<BR>[Number of cases with\
      \ Status tags]<BR><B>Target : </B>New: TBD In Progress: TBD Awaiting Internal\
      \ Response: TBD Awaiting Customer Response: TBD Resolved: TBD Close: TBD\t\t\
      \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
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
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Case status and priority: of_case.case_group_param
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 30
    col: 0
    width: 12
    height: 8
  - title: Escl by Role
    name: Escl by Role
    model: oneforce_service
    explore: of_case
    type: looker_pie
    fields: [of_escalation_history.role, of_case.case_distinct_count_drill]
    filters:
      of_case.total_escalation: ">0"
    sorts: [of_escalation_history.role]
    limit: 500
    value_labels: labels
    label_type: labVal
    inner_radius: 50
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
        reverse: false
    series_colors:
      Others - of_case.escalated_case_count: "#8b908f"
      S-KAS - of_case.escalated_case_count: "#7f0b4d"
      C-KAS - of_case.escalated_case_count: "#340335"
      S-KAM - of_case.escalated_case_count: "#00506D"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.escalated_case_count,
            id: of_case.escalated_case_count, name: Number of Escalated Cases}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
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
    hide_legend: true
    legend_position: center
    font_size: '12'
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
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    charts_across: 1
    defaults_version: 1
    show_null_points: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    hide_totals: false
    hide_row_totals: false
    note_state: collapsed
    note_display: hover
    note_text: "<P style=\"text-align:left;\"><B>Metric Name : </B>Escalation by Role\
      \ type Globally<BR><B>How it Helps : </B>To evaluate cases escalated Globally\
      \ by Role<BR>[Number of cases where Total Escalation>0]<BR><B>Target : </B>S-KAS:\
      \ TBD S-KAM: TBD C-KAS: TBD C-KAM: TBD\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\
      \t\t\t\t\t\t\t"
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
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
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 18
    col: 0
    width: 6
    height: 6
  - name: ''
    type: text
    title_text: ''
    body_text: "#####Clear Cache for latest data: \nStep 1: Just click anywhere inside\
      \ the Dashboard and then <BR>Step 2: Press Ctrl+Shift+Enter Key to clear the\
      \ cache and refresh\n\n"
    row: 100
    col: 0
    width: 8
    height: 3
  - title: Open Escalated Cases
    name: Open Escalated Cases
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
    single_value_title: Open Escalated Cases
    value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#BD0F72",
        font_color: !!null '', color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
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
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 3
    col: 0
    width: 6
    height: 3
  - title: FRT
    name: FRT
    model: oneforce_service
    explore: of_case
    type: single_value
    fields: [of_case.AVG_FIRST_RESPONSE_TIME_NEW]
    filters:
      of_case.is_channel_applicable_for_FRT: 'Yes'
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
    single_value_title: Mins (First Response Time)
    value_format: '0.0'
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#BD0F72",
        font_color: !!null '', color_application: {collection_id: one-theme, palette_id: one-theme-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
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
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      First Response Time: of_case.responsetime_Param
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 0
    col: 0
    width: 6
    height: 3
  - title: Case Resolution Reason By Location*
    name: Case Resolution Reason By Location*
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.Case_Geo, of_case.resolution_reason, of_case.case_distinct_count]
    pivots: [of_case.resolution_reason]
    filters:
      of_case.active_case: 'No'
    sorts: [of_case.resolution_reason, of_case.Case_Geo desc]
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
    font_size: '12'
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Case Resolution Reason<BR><B>How
      it Helps : </B>To evaluate cases by Resolution Reason<BR>[Status = "Resolved"
      or "Closed"]<BR><B>Target : </B>TBD'
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
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
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 18
    col: 6
    width: 9
    height: 6
  - title: Un-Resolved Resolution Reasons by Location*
    name: Un-Resolved Resolution Reasons by Location*
    model: oneforce_service
    explore: of_case
    type: looker_grid
    fields: [of_case.Case_Geo, of_case.sub_resolution_reason, of_case.case_distinct_count_drill]
    filters:
      of_case.active_case: 'No'
      resolution_reason_for_filter: Customer Query Un-resolved
    sorts: [of_case.Case_Geo, of_case.sub_resolution_reason]
    limit: 500
    dynamic_fields:
    - category: dimension
      expression: "${of_case.resolution_reason}"
      label: Resolution Reason For Filter
      value_format:
      value_format_name:
      dimension: resolution_reason_for_filter
      _kind_hint: dimension
      _type_hint: string
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
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
      of_case.Case_Geo: RHQ
      of_case.case_distinct_count_drill: Case
    series_column_widths:
      of_case.Case_Geo: 84
      of_case.sub_resolution_reason: 263
    series_cell_visualizations:
      of_case.case_distinct_count_drill:
        is_active: true
        palette:
          palette_id: 8c359f8c-3b71-96ff-4b7d-43f83339f686
          collection_id: one-theme
          custom_colors:
          - "#F0D6E5"
          - "#BD0F72"
          - "#7f0b4d"
    series_value_format:
      of_case.case_distinct_count_drill: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.count, id: Customer’s
              request to close the case - of_case.count, name: Customer’s request
              to close the case}, {axisId: of_case.count, id: New case created - of_case.count,
            name: New case created}, {axisId: of_case.count, id: No resolutions to
              customer’s query - of_case.count, name: No resolutions to customer’s
              query}, {axisId: of_case.count, id: No response from customer - of_case.count,
            name: No response from customer}, {axisId: of_case.count, id: Other -
              of_case.count, name: Other}, {axisId: of_case.count, id: Partially resolved.
              - of_case.count, name: Partially resolved.}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
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
    font_size: '12'
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
    charts_across: 2
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Un-Resolved Resolution
      Reasons<BR><B>How it Helps : </B>To evaluate Un-Resolved cases by Sub Resolution
      Reasons<BR>[Status = "Resolved" or "Closed"]<BR><B>Target : </B>TBD'
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
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
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 12
    col: 15
    width: 9
    height: 6
  - title: Case / Chat Level Volume Per Agent
    name: Case / Chat Level Volume Per Agent
    model: oneforce_service
    explore: of_case
    type: looker_grid
    fields: [of_case.Case_Chat_Owner, of_case.Case_Chat_Volume, of_case.Case_Chat_Handle_Time,
      of_case.Case_Chat_Response_Time, of_case.Case_Chat_Good_Rating]
    filters:
      owned_by_system_or_queue: 'No'
      chat_transcript_owner_name: "-Automated Process"
    sorts: [of_case.Case_Chat_Volume desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: dimension
      expression: " ${case_owner.name}"
      label: Owner Filter
      value_format:
      value_format_name:
      dimension: owner_filter
      _kind_hint: dimension
      _type_hint: string
    - category: dimension
      expression: if(${of_case.Case_Owned_by_System_Filter}= "Yes" OR  ${of_queue.ownedbyQueue}
        = "Yes", "Yes", "No")
      label: owned by system or Queue
      value_format:
      value_format_name:
      dimension: owned_by_system_or_queue
      _kind_hint: dimension
      _type_hint: string
    - category: dimension
      expression: "${ct_owner.name}"
      label: Chat Transcript Owner Name
      value_format:
      value_format_name:
      dimension: chat_transcript_owner_name
      _kind_hint: dimension
      _type_hint: string
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    pinned_columns:
      "$$$_row_numbers_$$$": left
    column_order: ["$$$_row_numbers_$$$", ct_owner.name, of_chat_transcript.count,
      of_chat_transcript.chat_handle_time_avg, of_chat_transcript.response_time_operator,
      csat_good_rating]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    defaults_version: 1
    hidden_fields: []
    hidden_pivots: {}
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
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
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.createddate_filter_date
      Case/Chat Level: of_case.Volume_per_Agent_Param
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 53
    col: 0
    width: 12
    height: 8
  - title: Cases Per Agent
    name: Cases Per Agent
    model: oneforce_service
    explore: of_case
    type: looker_grid
    fields: [of_case.case_owner_name, of_case.case_distinct_count, of_case.AVG_FIRST_RESPONSE_TIME_NEW,
      of_case.average_handling_time, nurturing_rate_with_filter_1, of_case.is_contract_customer,
      of_case.case_distinct_count_drill, closed_cases_count]
    filters:
      owned_by_system_or_queue: 'No'
    sorts: [of_case.case_distinct_count desc]
    limit: 500
    dynamic_fields:
    - category: table_calculation
      expression: "${closed_cases_count}/${of_case.case_distinct_count}"
      label: Closure Ratio %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: closure_ratio_1
      _type_hint: number
      is_disabled: false
    - category: dimension
      expression: ${of_case.case_distinct_count}- ${of_case.active_case}, "Yes"
      label: Closed Cases
      value_format:
      value_format_name:
      dimension: closed_cases_1
      _kind_hint: dimension
      _type_hint:
    - category: measure
      expression:
      label: Closed Cases Count
      value_format:
      value_format_name:
      based_on: of_case.case_distinct_count
      _kind_hint: measure
      measure: closed_cases_count
      type: count_distinct
      _type_hint: count_distinct
      filters:
        of_case.status: Resolved,Closed
    - category: measure
      expression:
      label: Nurturing Rate with Filter
      value_format:
      value_format_name:
      based_on: of_case.NURTURE_RATE
      _kind_hint: measure
      measure: nurturing_rate_with_filter_1
      type: average
      _type_hint: average
      filters:
        of_queue.ownedbyQueue: 'No'
        of_case.Case_Owned_by_System_Filter: 'No'
    - category: dimension
      expression: if(${of_case.Case_Owned_by_System_Filter}= "Yes" OR  ${of_queue.ownedbyQueue}
        = "Yes", "Yes", "No")
      label: owned by system or Queue
      value_format:
      value_format_name:
      dimension: owned_by_system_or_queue
      _kind_hint: dimension
      _type_hint: string
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", of_case.case_owner_name, of_case.case_distinct_count_drill,
      closed_cases_count, of_case.AVG_FIRST_RESPONSE_TIME_NEW, of_case.AVG_FIRST_RESPONSE_TIME,
      of_case.average_handling_time, nurturing_rate_with_filter_1, of_case.is_contract_customer,
      closure_ratio_1]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    series_labels:
      of_case.case_owner_name: Case Owner
      of_case.average_handling_time: Avg AHT (in Mins)
      of_case.is_contract_customer: Contract Customer Ratio %
      of_case.case_distinct_count: Total
      closed_cases_count: Closed
      nurturing_rate_with_filter_1: Case Nurture Ratio %
      of_case.case_distinct_count_drill: Total
      of_case.AVG_FIRST_RESPONSE_TIME_NEW: Avg FRT (in Mins)
    series_value_format:
      of_case.case_distinct_count_drill: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
      closed_cases_count: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
      of_case.AVG_FIRST_RESPONSE_TIME_NEW: '0.0'
    defaults_version: 1
    hidden_fields: [of_case.case_distinct_count]
    hidden_pivots: {}
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
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
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      First Response Time: of_case.responsetime_Param
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 45
    col: 0
    width: 24
    height: 8
  - name: " (2)"
    type: text
    title_text: ''
    body_text: |+
      ######Notes
      * Data shown is in UTC Time Zone<br>
      * *- Charts based on the dynamic filter. Please use the 'View By' option to change the charts dynamically
      * The result shown depends on the filter chosen where the agent is either a "Case owner" or a "Chat owner"

    row: 100
    col: 8
    width: 12
    height: 3
  - title: Avg case handled by distinct case owner
    name: Avg case handled by distinct case owner
    model: oneforce_service
    explore: of_case
    type: looker_line
    fields: [of_case.case_distinct_count, count_of_case_owner_name, of_case.Case_Resolved_Date_Time_dynamic,
      of_case.Case_Geo]
    pivots: [of_case.Case_Geo]
    fill_fields: [of_case.Case_Resolved_Date_Time_dynamic]
    filters:
      of_case.active_case: 'No'
    sorts: [of_case.Case_Geo, of_case.Case_Resolved_Date_Time_dynamic]
    limit: 500
    dynamic_fields:
    - measure: count_of_case_owner_name
      based_on: of_case.case_owner_name
      expression: ''
      label: Count of Case Owner Name
      type: count_distinct
      _kind_hint: measure
      _type_hint: number
    - category: table_calculation
      expression: "${of_case.case_distinct_count}/${count_of_case_owner_name}"
      label: Average case handled by distinct case owner
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_case_handled_by_distinct_case_owner
      _type_hint: number
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
    y_axes: [{label: '', orientation: left, series: [{axisId: average_case_handled_by_distinct_case_owner,
            id: AR - average_case_handled_by_distinct_case_owner, name: AR}, {axisId: average_case_handled_by_distinct_case_owner,
            id: AT - average_case_handled_by_distinct_case_owner, name: AT}, {axisId: average_case_handled_by_distinct_case_owner,
            id: BE - average_case_handled_by_distinct_case_owner, name: BE}, {axisId: average_case_handled_by_distinct_case_owner,
            id: BR - average_case_handled_by_distinct_case_owner, name: BR}, {axisId: average_case_handled_by_distinct_case_owner,
            id: CA - average_case_handled_by_distinct_case_owner, name: CA}, {axisId: average_case_handled_by_distinct_case_owner,
            id: CH - average_case_handled_by_distinct_case_owner, name: CH}, {axisId: average_case_handled_by_distinct_case_owner,
            id: CL - average_case_handled_by_distinct_case_owner, name: CL}, {axisId: average_case_handled_by_distinct_case_owner,
            id: DK - average_case_handled_by_distinct_case_owner, name: DK}, {axisId: average_case_handled_by_distinct_case_owner,
            id: FI - average_case_handled_by_distinct_case_owner, name: FI}, {axisId: average_case_handled_by_distinct_case_owner,
            id: FR - average_case_handled_by_distinct_case_owner, name: FR}, {axisId: average_case_handled_by_distinct_case_owner,
            id: GB - average_case_handled_by_distinct_case_owner, name: GB}, {axisId: average_case_handled_by_distinct_case_owner,
            id: GH - average_case_handled_by_distinct_case_owner, name: GH}, {axisId: average_case_handled_by_distinct_case_owner,
            id: HK - average_case_handled_by_distinct_case_owner, name: HK}, {axisId: average_case_handled_by_distinct_case_owner,
            id: HU - average_case_handled_by_distinct_case_owner, name: HU}, {axisId: average_case_handled_by_distinct_case_owner,
            id: ID - average_case_handled_by_distinct_case_owner, name: ID}, {axisId: average_case_handled_by_distinct_case_owner,
            id: IN - average_case_handled_by_distinct_case_owner, name: IN}, {axisId: average_case_handled_by_distinct_case_owner,
            id: IT - average_case_handled_by_distinct_case_owner, name: IT}, {axisId: average_case_handled_by_distinct_case_owner,
            id: KR - average_case_handled_by_distinct_case_owner, name: KR}, {axisId: average_case_handled_by_distinct_case_owner,
            id: NL - average_case_handled_by_distinct_case_owner, name: NL}, {axisId: average_case_handled_by_distinct_case_owner,
            id: PK - average_case_handled_by_distinct_case_owner, name: PK}, {axisId: average_case_handled_by_distinct_case_owner,
            id: SG - average_case_handled_by_distinct_case_owner, name: SG}, {axisId: average_case_handled_by_distinct_case_owner,
            id: US - average_case_handled_by_distinct_case_owner, name: US}, {axisId: average_case_handled_by_distinct_case_owner,
            id: UY - average_case_handled_by_distinct_case_owner, name: UY}, {axisId: average_case_handled_by_distinct_case_owner,
            id: VN - average_case_handled_by_distinct_case_owner, name: VN}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    defaults_version: 1
    hidden_fields: [of_case.case_distinct_count, count_of_case_owner_name]
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
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
      Dynamic Filter - View By: of_case.Geo_Param
      Service or Contract Customer: of_case.Service_Contract_Customer
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Average case by: of_case.avg_cases_param
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 61
    col: 0
    width: 12
    height: 7
  - title: Avg cases by total agents
    name: Avg cases by total agents
    model: oneforce_service
    explore: of_case
    type: looker_line
    fields: [of_case.case_distinct_count, queue_user_count.user_group_id, of_case.Case_Geo,
      of_case.Case_Resolved_Date_Time_dynamic]
    pivots: [of_case.Case_Geo]
    fill_fields: [of_case.Case_Resolved_Date_Time_dynamic]
    filters:
      of_case.active_case: 'No'
    sorts: [of_case.Case_Geo, of_case.Case_Resolved_Date_Time_dynamic desc]
    limit: 500
    dynamic_fields:
    - category: table_calculation
      expression: "${of_case.case_distinct_count}/${queue_user_count.user_group_id}"
      label: Average cases by total agents
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_cases_by_total_agents
      _type_hint: number
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
    y_axes: [{label: '', orientation: left, series: [{axisId: average_cases_by_total_agents,
            id: Global - average_cases_by_total_agents, name: Global}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    defaults_version: 1
    hidden_fields: [of_case.case_distinct_count, queue_user_count.user_group_id]
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
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
      Dynamic Filter - View By: of_case.Geo_Param
      Service or Contract Customer: of_case.Service_Contract_Customer
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Average case by: of_case.avg_cases_param
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 61
    col: 12
    width: 12
    height: 7
  - title: Case Transfer Per Agent
    name: Case Transfer Per Agent
    model: oneforce_service
    explore: of_case
    type: looker_grid
    fields: [case_transfer_history.transfer_by, case_transfer_history.total_transfer,
      case_transfer_history.avg_transfer_duration_in_minutes, transfer_by_owner.name]
    filters:
      case_transfer_history.transfer_by: "-NULL"
      transfer_by_owner.name: "-%User%"
      case_transfer_history.transfer_type: Accept/Transfer Chat,Assignment
    sorts: [case_transfer_history.total_transfer desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
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
      case_transfer_history.transfer_by: Transfer By Owner
      case_transfer_history.total_transfer: Total Transfer
      case_transfer_history.avg_transfer_duration_in_minutes: Average Transfer Duration
      transfer_by_owner.name: Transfer By Owner
    series_cell_visualizations:
      case_transfer_history.total_transfer:
        is_active: true
        palette:
          palette_id: 9eaf7c7a-3527-3b47-0255-a95313742248
          collection_id: one-theme
          custom_colors:
          - "#F0D6E5"
          - "#BD0F72"
          - "#7f0b4d"
    defaults_version: 1
    hidden_fields: [case_transfer_history.transfer_by]
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Office (Case): of_case.case_office_code
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
      Dynamic Filter - View By: of_case.Geo_Param
      Service or Contract Customer: of_case.Service_Contract_Customer
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.createddate_filter_date
    row: 53
    col: 12
    width: 12
    height: 8
  - title: On-Hold Cases by Sub-Category*
    name: On-Hold Cases by Sub-Category*
    model: oneforce_service
    explore: of_case
    type: looker_bar
    fields: [of_case.Case_Geo, on_hold_reasons.rsn_count, on_hold_reasons.on_hld_rsn]
    pivots: [on_hold_reasons.on_hld_rsn]
    filters:
      of_case.Is_On_Hold: On-Hold Cases
      on_hold_reasons.on_hld_rsn: "-NULL"
    sorts: [of_case.Case_Geo, on_hold_reasons.on_hld_rsn]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: false
    show_y_axis_ticks: false
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
    totals_color: "#CCD3D1"
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: of_case.AVG_FIRST_CONTACT_RESOLUTION,
            id: of_case.AVG_FIRST_CONTACT_RESOLUTION, name: FCR}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, type: linear},
      {label: '', orientation: bottom, series: [{axisId: of_case.case_distinct_count,
            id: of_case.case_distinct_count, name: Case}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}]
    size_by_field: ''
    x_axis_zoom: true
    y_axis_zoom: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    font_size: '12'
    label_value_format: ''
    series_colors:
      Bad: "#000000"
      Good: "#BD0F72"
      of_case.case_distinct_count: "#F39200"
      of_case.AVG_FIRST_CONTACT_RESOLUTION: "#00506D"
      Yes - of_case.case_distinct_count: "#BD0F72"
      No - of_case.case_distinct_count: "#CCD3D1"
      On-Hold Cases - of_case.Transferred_Case_count_distinct: "#F39200"
    label_color: []
    column_group_spacing_ratio: 0.1
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: true
    rightAxisLabel: ''
    smoothedBars: false
    isStepped: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    value_labels: labels
    label_type: labPer
    inner_radius: 20
    color_range: ["#4285F4", "#EA4335", "#FBBC04", "#34A852", "#5F6368"]
    color_by: node
    show_null_points: false
    value_format_override: ''
    show_percent: true
    arm_length: 25
    arm_weight: 50
    spinner_length: 100
    spinner_weight: 50
    viz_trellis_by: none
    angle: 90
    cutout: 50
    range_x: 1
    range_y: 1
    up_color: "#BD0F72"
    down_color: "#F39200"
    total_color: "#00506D"
    interpolation: linear
    bar_arm_length: 25
    bar_arm_weight: 50
    bar_spinner_length: 100
    bar_spinner_weight: 50
    defaults_version: 1
    hidden_fields:
    hidden_points_if_no: []
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
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    hidden_pivots:
      on_hold_reasons.on_hld_rsn___null:
        is_entire_pivot_hidden: true
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Resolution Reason: of_case.resolution_reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      Contract Number: of_case.contract_number
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.On_hold_chart_date_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 75
    col: 8
    width: 8
    height: 7
  - title: On-Hold Cases by Location*
    name: On-Hold Cases by Location*
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.Case_Geo, of_case.Is_On_Hold, of_case.case_distinct_count]
    pivots: [of_case.Is_On_Hold]
    filters:
      of_case.Is_On_Hold: "-NULL"
    sorts: [of_case.Is_On_Hold, of_case.case_distinct_count desc 0]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: false
    show_y_axis_ticks: false
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
    totals_color: "#CCD3D1"
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: of_case.AVG_FIRST_CONTACT_RESOLUTION,
            id: of_case.AVG_FIRST_CONTACT_RESOLUTION, name: FCR}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, type: linear},
      {label: '', orientation: bottom, series: [{axisId: of_case.case_distinct_count,
            id: of_case.case_distinct_count, name: Case}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}]
    size_by_field: ''
    x_axis_zoom: true
    y_axis_zoom: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    font_size: '12'
    label_value_format: ''
    series_colors:
      Bad: "#000000"
      Good: "#BD0F72"
      of_case.case_distinct_count: "#F39200"
      of_case.AVG_FIRST_CONTACT_RESOLUTION: "#00506D"
      Yes - of_case.case_distinct_count: "#BD0F72"
      No - of_case.case_distinct_count: "#CCD3D1"
      On-Hold Cases - of_case.Transferred_Case_count_distinct: "#F39200"
      On-Hold Cases - of_case.case_distinct_count: "#F39200"
    series_labels:
      of_case.case_distinct_count: Case
    label_color: []
    column_group_spacing_ratio: 0.1
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: true
    rightAxisLabel: ''
    smoothedBars: false
    isStepped: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    value_labels: labels
    label_type: labPer
    inner_radius: 20
    color_range: ["#4285F4", "#EA4335", "#FBBC04", "#34A852", "#5F6368"]
    color_by: node
    show_null_points: false
    value_format_override: ''
    show_percent: true
    arm_length: 25
    arm_weight: 50
    spinner_length: 100
    spinner_weight: 50
    viz_trellis_by: none
    angle: 90
    cutout: 50
    range_x: 1
    range_y: 1
    up_color: "#BD0F72"
    down_color: "#F39200"
    total_color: "#00506D"
    interpolation: linear
    bar_arm_length: 25
    bar_arm_weight: 50
    bar_spinner_length: 100
    bar_spinner_weight: 50
    defaults_version: 1
    hidden_fields: []
    hidden_points_if_no: []
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
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    hidden_pivots: {}
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Resolution Reason: of_case.resolution_reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      Contract Number: of_case.contract_number
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.On_hold_chart_date_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 75
    col: 0
    width: 8
    height: 7
  - title: First Response Time (Web) Histogram
    name: First Response Time (Web) Histogram
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.dynamic_FRT_tier, of_case.FRT_tier_count]
    pivots: [of_case.dynamic_FRT_tier]
    filters:
      of_case.FRT_selector: Web
      of_case.dynamic_FRT_tier: "-Undefined,-< 0.1"
    sorts: [of_case.dynamic_FRT_tier]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: pivot_where(${of_case.dynamic_FRT_tier} = "0", null)
      label: Label
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: label
      _type_hint: 'null'
      is_disabled: true
    - category: table_calculation
      label: "% of total"
      value_format:
      value_format_name: percent_0
      calculation_type: percent_of_column_sum
      table_calculation: of_total
      args:
      - of_case.FRT_tier_count
      _kind_hint: measure
      _type_hint: number
    query_timezone: Asia/Ho_Chi_Minh
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: of_total, id: of_total,
            name: "% of total"}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      300 or Above - 11 - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - 10 - of_chat_transcript.count: "#CCD3D1"
      240 to 269 - 09 - of_chat_transcript.count: "#CCD3D1"
      210 to 239 - 08 - of_chat_transcript.count: "#CCD3D1"
      180 to 209 - 07 - of_chat_transcript.count: "#CCD3D1"
      150 to 179 - 06 - of_chat_transcript.count: "#CCD3D1"
      120 to 149 - 05 - of_chat_transcript.count: "#CCD3D1"
      90 to 119 - 04 - of_chat_transcript.count: "#CCD3D1"
      60 to 89 - 03 - of_chat_transcript.count: "#CCD3D1"
      30 to 59 - 02 - of_chat_transcript.count: "#CCD3D1"
      180 to 269 - Web - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - Web - of_chat_transcript.count: "#CCD3D1"
      300 to 359 - Web - of_chat_transcript.count: "#CCD3D1"
      360 to 419 - Web - of_chat_transcript.count: "#CCD3D1"
      480 to 539 - Web - of_chat_transcript.count: "#CCD3D1"
      420 to 479 - Web - of_chat_transcript.count: "#CCD3D1"
      540 to 599 - Web - of_chat_transcript.count: "#CCD3D1"
      60 to 119 - Web - of_chat_transcript.count: "#CCD3D1"
      600 or Above - Web - of_chat_transcript.count: "#CCD3D1"
      150 to 179 - Chat - of_chat_transcript.count: "#CCD3D1"
      180 to 209 - Chat - of_chat_transcript.count: "#CCD3D1"
      210 to 239 - Chat - of_chat_transcript.count: "#CCD3D1"
      240 to 269 - Chat - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - Chat - of_chat_transcript.count: "#CCD3D1"
      30 to 59 - Chat - of_chat_transcript.count: "#CCD3D1"
      300 or Above - Chat - of_chat_transcript.count: "#CCD3D1"
      60 to 89 - Chat - of_chat_transcript.count: "#CCD3D1"
      90 to 119 - Chat - of_chat_transcript.count: "#CCD3D1"
      60 to 89 - 3 - of_chat_transcript.count: "#CCD3D1"
      90 to 119 - 4 - of_chat_transcript.count: "#CCD3D1"
      120 to 149 - 5 - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - 5 - of_chat_transcript.count: "#CCD3D1"
      150 to 179 - 6 - of_chat_transcript.count: "#CCD3D1"
      180 to 209 - 7 - of_chat_transcript.count: "#CCD3D1"
      210 to 239 - 8 - of_chat_transcript.count: "#CCD3D1"
      240 to 269 - 9 - of_chat_transcript.count: "#CCD3D1"
      300 or Above - 10 - of_chat_transcript.count: "#CCD3D1"
      120 to 179 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      180 to 269 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      270 to 299 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      300 to 359 - 6 - of_case.FRT_tier_count: "#CCD3D1"
      360 to 419 - 7 - of_case.FRT_tier_count: "#CCD3D1"
      420 to 479 - 8 - of_case.FRT_tier_count: "#CCD3D1"
      480 to 539 - 9 - of_case.FRT_tier_count: "#CCD3D1"
      540 to 599 - 10 - of_case.FRT_tier_count: "#CCD3D1"
      600 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      60 to 89 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      90 to 119 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      120 to 149 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      150 to 179 - 6 - of_case.FRT_tier_count: "#CCD3D1"
      180 to 209 - 7 - of_case.FRT_tier_count: "#CCD3D1"
      210 to 239 - 8 - of_case.FRT_tier_count: "#CCD3D1"
      240 to 269 - 9 - of_case.FRT_tier_count: "#CCD3D1"
      300 or Above - 10 - of_case.FRT_tier_count: "#CCD3D1"
      300 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      270 to 300 - 10 - of_case.FRT_tier_count: "#CCD3D1"
      301 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      label: "#BD0F72"
      60 to 89 - 3 - test: "#CCD3D1"
      90 to 119 - 4 - test: "#CCD3D1"
      120 to 149 - 5 - test: "#CCD3D1"
      150 to 179 - 6 - test: "#CCD3D1"
      180 to 209 - 7 - test: "#CCD3D1"
      60 to 89 - 3 - of_total: "#CCD3D1"
      90 to 119 - 4 - of_total: "#CCD3D1"
      120 to 149 - 5 - of_total: "#CCD3D1"
      150 to 179 - 6 - of_total: "#CCD3D1"
      180 to 209 - 7 - of_total: "#CCD3D1"
      210 to 239 - 8 - of_total: "#CCD3D1"
      240 to 269 - 9 - of_total: "#CCD3D1"
      270 to 300 - 10 - of_total: "#CCD3D1"
      301 or Above - 11 - of_total: "#CCD3D1"
      120 to 179 - 3 - of_total: "#CCD3D1"
      180 to 269 - 4 - of_total: "#CCD3D1"
      270 to 299 - 5 - of_total: "#CCD3D1"
      300 to 359 - 6 - of_total: "#CCD3D1"
      360 to 419 - 7 - of_total: "#CCD3D1"
      420 to 479 - 8 - of_total: "#CCD3D1"
      480 to 539 - 9 - of_total: "#CCD3D1"
      540 to 599 - 10 - of_total: "#CCD3D1"
      600 or Above - 11 - of_total: "#CCD3D1"
      121 to 180 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      181 to 270 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      271 to 300 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      301 to 360 - 6 - of_case.FRT_tier_count: "#CCD3D1"
      361 to 420 - 7 - of_case.FRT_tier_count: "#CCD3D1"
      421 to 480 - 8 - of_case.FRT_tier_count: "#CCD3D1"
      481 to 540 - 9 - of_case.FRT_tier_count: "#CCD3D1"
      541 to 600 - 10 - of_case.FRT_tier_count: "#CCD3D1"
      601 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      181 to 240 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      301 or Above - 6 - of_case.FRT_tier_count: "#CCD3D1"
      241 to 300 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      ">= 120.1 and < 180.1 - 3 - of_case.FRT_tier_count": "#CCD3D1"
      ">= 300.1 - 6 - of_case.FRT_tier_count": "#CCD3D1"
      ">= 240.1 and < 300.1 - 5 - of_case.FRT_tier_count": "#CCD3D1"
      ">= 180.1 and < 240.1 - 4 - of_case.FRT_tier_count": "#CCD3D1"
    series_labels:
      300 or Above - 10 - of_case.FRT_tier_count: ">= 300 sec"
      240 to 269 - 9 - of_case.FRT_tier_count: 240-269 sec
      0 to 29 - 1 - of_case.FRT_tier_count: 0-29 sec
      30 to 59 - 2 - of_case.FRT_tier_count: 30-59 sec
      60 to 89 - 3 - of_case.FRT_tier_count: 60-89 sec
      90 to 119 - 4 - of_case.FRT_tier_count: 90-119 sec
      301 or Above - 11 - of_case.FRT_tier_count: "> 300 sec"
      120 to 149 - 5 - of_case.FRT_tier_count: 120-149 sec
      150 to 179 - 6 - of_case.FRT_tier_count: 150-179 sec
      180 to 209 - 7 - of_case.FRT_tier_count: 180-209 sec
      210 to 239 - 8 - of_case.FRT_tier_count: 210-239 sec
      270 to 300 - 10 - of_case.FRT_tier_count: 270-300 sec
      0 to 59 - 1 - of_case.FRT_tier_count: 0-59 min
      60 to 119 - 2 - of_case.FRT_tier_count: 60-119 min
      120 to 179 - 3 - of_case.FRT_tier_count: 120-179 min
      180 to 269 - 4 - of_case.FRT_tier_count: 180-269 min
      270 to 299 - 5 - of_case.FRT_tier_count: 270-299 min
      300 to 359 - 6 - of_case.FRT_tier_count: 300-359 min
      360 to 419 - 7 - of_case.FRT_tier_count: 360-419 min
      420 to 479 - 8 - of_case.FRT_tier_count: 420-479 min
      480 to 539 - 9 - of_case.FRT_tier_count: 480-539 min
      540 to 599 - 10 - of_case.FRT_tier_count: 540-599 min
      600 or Above - 11 - of_case.FRT_tier_count: ">= 600 min"
      0 to 29 - 1 - of_total: 0-29 sec
      30 to 59 - 2 - of_total: 30-59 sec
      60 to 89 - 3 - of_total: 60-89 sec
      90 to 119 - 4 - of_total: 90-119 sec
      120 to 149 - 5 - of_total: 120-149 sec
      150 to 179 - 6 - of_total: 150-179 sec
      180 to 209 - 7 - of_total: 180-209 sec
      210 to 239 - 8 - of_total: 210-239 sec
      240 to 269 - 9 - of_total: 240-269 sec
      270 to 300 - 10 - of_total: 270-300 sec
      301 or Above - 11 - of_total: "> 300 sec"
      0 to 59 - 1 - of_total: 0-59 min
      60 to 119 - 2 - of_total: 60-119 min
      120 to 179 - 3 - of_total: 120-179 min
      180 to 269 - 4 - of_total: 180-269 min
      270 to 299 - 5 - of_total: 270-299 min
      300 to 359 - 6 - of_total: 300-359 min
      360 to 419 - 7 - of_total: 360-419 min
      420 to 479 - 8 - of_total: 420-479 min
      480 to 539 - 9 - of_total: 480-539 min
      540 to 599 - 10 - of_total: 540-599 min
      600 or Above - 11 - of_total: ">= 600 min"
      0 to 60 - 1 - of_case.FRT_tier_count: 0-60 min
      61 to 120 - 2 - of_case.FRT_tier_count: 61-120 min
      121 to 180 - 3 - of_case.FRT_tier_count: 121-180 min
      181 to 270 - 4 - of_case.FRT_tier_count: 181-270
      271 to 300 - 5 - of_case.FRT_tier_count: 271-300
      301 to 360 - 6 - of_case.FRT_tier_count: 301-360
      361 to 420 - 7 - of_case.FRT_tier_count: 361-420
      421 to 480 - 8 - of_case.FRT_tier_count: 421-480
      481 to 540 - 9 - of_case.FRT_tier_count: 481-540
      541 to 600 - 10 - of_case.FRT_tier_count: 541-600
      601 or Above - 11 - of_case.FRT_tier_count: "> 600"
      181 to 240 - 4 - of_case.FRT_tier_count: 181-240 min
      241 to 300 - 5 - of_case.FRT_tier_count: 241-300 min
      301 or Above - 6 - of_case.FRT_tier_count: "> 300 min"
      ">= 0.1 and < 60.1 - 1 - of_case.FRT_tier_count": 0-60 min
      ">= 60.1 and < 120.1 - 2 - of_case.FRT_tier_count": 60-120 min
      ">= 120.1 and < 180.1 - 3 - of_case.FRT_tier_count": 120-180 min
      ">= 180.1 and < 240.1 - 4 - of_case.FRT_tier_count": 180-240 min
      ">= 240.1 and < 300.1 - 5 - of_case.FRT_tier_count": 240-300 min
      ">= 300.1 - 6 - of_case.FRT_tier_count": ">300 min"
    reference_lines: []
    trend_lines: []
    column_spacing_ratio: 0.3
    column_group_spacing_ratio: 0.3
    defaults_version: 1
    hidden_pivots:
      601 or Above|FIELD|11:
        is_entire_pivot_hidden: false
    hidden_fields: [of_total]
    hidden_points_if_no: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      <P style="text-align:left;"><B> Magenta Bar (0-60 min) </B> is the Web FRT Global Target
      <P style="text-align:left;">*Recommend to zoom the screen to 100% </P>
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Office (Case): of_case.case_office_code
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
      Dynamic Filter - View By: of_case.Geo_Param
      Service or Contract Customer: of_case.Service_Contract_Customer
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 88
    col: 0
    width: 12
    height: 6
  - title: First Response Time (Chat) Histogram
    name: First Response Time (Chat) Histogram
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.dynamic_FRT_tier, of_case.FRT_tier_count]
    pivots: [of_case.dynamic_FRT_tier]
    filters:
      of_case.FRT_selector: Chat
      of_case.dynamic_FRT_tier: "-Undefined"
    sorts: [of_case.dynamic_FRT_tier]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: pivot_where(${of_case.dynamic_FRT_tier} = "0", null)
      label: Label
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: label
      _type_hint: 'null'
      is_disabled: true
    - category: table_calculation
      label: "% of total"
      value_format:
      value_format_name: percent_0
      calculation_type: percent_of_column_sum
      table_calculation: of_total
      args:
      - of_case.FRT_tier_count
      _kind_hint: measure
      _type_hint: number
    query_timezone: Asia/Ho_Chi_Minh
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.FRT_tier_count,
            id: 0 to 30 - 1 - of_case.FRT_tier_count, name: "&lt;30"}, {axisId: of_case.FRT_tier_count,
            id: 31 to 60 - 2 - of_case.FRT_tier_count, name: 31-60}, {axisId: of_case.FRT_tier_count,
            id: 61 to 90 - 3 - of_case.FRT_tier_count, name: 61-90}, {axisId: of_case.FRT_tier_count,
            id: 91 to 120 - 4 - of_case.FRT_tier_count, name: 91-120}, {axisId: of_case.FRT_tier_count,
            id: 121 to 150 - 5 - of_case.FRT_tier_count, name: 121-150}, {axisId: of_case.FRT_tier_count,
            id: 151 to 180 - 6 - of_case.FRT_tier_count, name: 151-180}, {axisId: of_case.FRT_tier_count,
            id: 181 to 210 - 7 - of_case.FRT_tier_count, name: 181-210}, {axisId: of_case.FRT_tier_count,
            id: 211 to 240 - 8 - of_case.FRT_tier_count, name: 211-240}, {axisId: of_case.FRT_tier_count,
            id: 241 to 270 - 9 - of_case.FRT_tier_count, name: 241-270}, {axisId: of_case.FRT_tier_count,
            id: 271 to 300 - 10 - of_case.FRT_tier_count, name: 271-300}, {axisId: of_case.FRT_tier_count,
            id: 301 or Above - 11 - of_case.FRT_tier_count, name: "&gt;300"}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, type: linear}]
    x_axis_label: ''
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      300 or Above - 11 - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - 10 - of_chat_transcript.count: "#CCD3D1"
      240 to 269 - 09 - of_chat_transcript.count: "#CCD3D1"
      210 to 239 - 08 - of_chat_transcript.count: "#CCD3D1"
      180 to 209 - 07 - of_chat_transcript.count: "#CCD3D1"
      150 to 179 - 06 - of_chat_transcript.count: "#CCD3D1"
      120 to 149 - 05 - of_chat_transcript.count: "#CCD3D1"
      90 to 119 - 04 - of_chat_transcript.count: "#CCD3D1"
      60 to 89 - 03 - of_chat_transcript.count: "#CCD3D1"
      30 to 59 - 02 - of_chat_transcript.count: "#CCD3D1"
      180 to 269 - Web - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - Web - of_chat_transcript.count: "#CCD3D1"
      300 to 359 - Web - of_chat_transcript.count: "#CCD3D1"
      360 to 419 - Web - of_chat_transcript.count: "#CCD3D1"
      480 to 539 - Web - of_chat_transcript.count: "#CCD3D1"
      420 to 479 - Web - of_chat_transcript.count: "#CCD3D1"
      540 to 599 - Web - of_chat_transcript.count: "#CCD3D1"
      60 to 119 - Web - of_chat_transcript.count: "#CCD3D1"
      600 or Above - Web - of_chat_transcript.count: "#CCD3D1"
      150 to 179 - Chat - of_chat_transcript.count: "#CCD3D1"
      180 to 209 - Chat - of_chat_transcript.count: "#CCD3D1"
      210 to 239 - Chat - of_chat_transcript.count: "#CCD3D1"
      240 to 269 - Chat - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - Chat - of_chat_transcript.count: "#CCD3D1"
      30 to 59 - Chat - of_chat_transcript.count: "#CCD3D1"
      300 or Above - Chat - of_chat_transcript.count: "#CCD3D1"
      60 to 89 - Chat - of_chat_transcript.count: "#CCD3D1"
      90 to 119 - Chat - of_chat_transcript.count: "#CCD3D1"
      60 to 89 - 3 - of_chat_transcript.count: "#CCD3D1"
      90 to 119 - 4 - of_chat_transcript.count: "#CCD3D1"
      120 to 149 - 5 - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - 5 - of_chat_transcript.count: "#CCD3D1"
      150 to 179 - 6 - of_chat_transcript.count: "#CCD3D1"
      180 to 209 - 7 - of_chat_transcript.count: "#CCD3D1"
      210 to 239 - 8 - of_chat_transcript.count: "#CCD3D1"
      240 to 269 - 9 - of_chat_transcript.count: "#CCD3D1"
      300 or Above - 10 - of_chat_transcript.count: "#CCD3D1"
      120 to 179 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      180 to 269 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      270 to 299 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      300 to 359 - 6 - of_case.FRT_tier_count: "#CCD3D1"
      360 to 419 - 7 - of_case.FRT_tier_count: "#CCD3D1"
      420 to 479 - 8 - of_case.FRT_tier_count: "#CCD3D1"
      480 to 539 - 9 - of_case.FRT_tier_count: "#CCD3D1"
      540 to 599 - 10 - of_case.FRT_tier_count: "#CCD3D1"
      600 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      60 to 89 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      90 to 119 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      120 to 149 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      150 to 179 - 6 - of_case.FRT_tier_count: "#CCD3D1"
      180 to 209 - 7 - of_case.FRT_tier_count: "#CCD3D1"
      210 to 239 - 8 - of_case.FRT_tier_count: "#CCD3D1"
      240 to 269 - 9 - of_case.FRT_tier_count: "#CCD3D1"
      300 or Above - 10 - of_case.FRT_tier_count: "#CCD3D1"
      300 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      270 to 300 - 10 - of_case.FRT_tier_count: "#CCD3D1"
      301 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      label: "#BD0F72"
      60 to 89 - 3 - test: "#CCD3D1"
      90 to 119 - 4 - test: "#CCD3D1"
      120 to 149 - 5 - test: "#CCD3D1"
      150 to 179 - 6 - test: "#CCD3D1"
      180 to 209 - 7 - test: "#CCD3D1"
      60 to 89 - 3 - of_total: "#CCD3D1"
      90 to 119 - 4 - of_total: "#CCD3D1"
      120 to 149 - 5 - of_total: "#CCD3D1"
      150 to 179 - 6 - of_total: "#CCD3D1"
      180 to 209 - 7 - of_total: "#CCD3D1"
      210 to 239 - 8 - of_total: "#CCD3D1"
      240 to 269 - 9 - of_total: "#CCD3D1"
      270 to 300 - 10 - of_total: "#CCD3D1"
      301 or Above - 11 - of_total: "#CCD3D1"
      120 to 179 - 3 - of_total: "#CCD3D1"
      180 to 269 - 4 - of_total: "#CCD3D1"
      270 to 299 - 5 - of_total: "#CCD3D1"
      300 to 359 - 6 - of_total: "#CCD3D1"
      360 to 419 - 7 - of_total: "#CCD3D1"
      420 to 479 - 8 - of_total: "#CCD3D1"
      480 to 539 - 9 - of_total: "#CCD3D1"
      540 to 599 - 10 - of_total: "#CCD3D1"
      600 or Above - 11 - of_total: "#CCD3D1"
      121 to 180 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      181 to 270 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      271 to 300 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      301 to 360 - 6 - of_case.FRT_tier_count: "#CCD3D1"
      361 to 420 - 7 - of_case.FRT_tier_count: "#CCD3D1"
      421 to 480 - 8 - of_case.FRT_tier_count: "#CCD3D1"
      481 to 540 - 9 - of_case.FRT_tier_count: "#CCD3D1"
      541 to 600 - 10 - of_case.FRT_tier_count: "#CCD3D1"
      601 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      121 to 150 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      91 to 120 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      61 to 90 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      151 to 180 - 6 - of_case.FRT_tier_count: "#CCD3D1"
      181 to 210 - 7 - of_case.FRT_tier_count: "#CCD3D1"
      241 to 270 - 9 - of_case.FRT_tier_count: "#CCD3D1"
      211 to 240 - 8 - of_case.FRT_tier_count: "#CCD3D1"
      271 to 300 - 10 - of_case.FRT_tier_count: "#CCD3D1"
      121 to 180 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      181 to 240 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      61 to 120 - 2 - of_case.FRT_tier_count: "#CCD3D1"
      241 or Above - 6 - of_case.FRT_tier_count: "#CCD3D1"
      61 to 120 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      181 to 240 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      ">= 240.1 - 6 - of_case.FRT_tier_count": "#CCD3D1"
      ">= 180.1 and < 240.1 - 5 - of_case.FRT_tier_count": "#CCD3D1"
      ">= 120.1 and < 180.1 - 4 - of_case.FRT_tier_count": "#CCD3D1"
      ">= 60.1 and < 120.1 - 3 - of_case.FRT_tier_count": "#CCD3D1"
    series_labels:
      300 or Above - 10 - of_case.FRT_tier_count: ">= 300 sec"
      240 to 269 - 9 - of_case.FRT_tier_count: 240-269 sec
      0 to 29 - 1 - of_case.FRT_tier_count: 0-29 sec
      30 to 59 - 2 - of_case.FRT_tier_count: 30-59 sec
      60 to 89 - 3 - of_case.FRT_tier_count: 60-89 sec
      90 to 119 - 4 - of_case.FRT_tier_count: 90-119 sec
      301 or Above - 11 - of_case.FRT_tier_count: ">300"
      120 to 149 - 5 - of_case.FRT_tier_count: 120-149 sec
      150 to 179 - 6 - of_case.FRT_tier_count: 150-179 sec
      180 to 209 - 7 - of_case.FRT_tier_count: 180-209 sec
      210 to 239 - 8 - of_case.FRT_tier_count: 210-239 sec
      270 to 300 - 10 - of_case.FRT_tier_count: 270-300 sec
      0 to 59 - 1 - of_case.FRT_tier_count: 0-59 min
      60 to 119 - 2 - of_case.FRT_tier_count: 60-119 min
      120 to 179 - 3 - of_case.FRT_tier_count: 120-179 min
      180 to 269 - 4 - of_case.FRT_tier_count: 180-269 min
      270 to 299 - 5 - of_case.FRT_tier_count: 270-299 min
      300 to 359 - 6 - of_case.FRT_tier_count: 300-359 min
      360 to 419 - 7 - of_case.FRT_tier_count: 360-419 min
      420 to 479 - 8 - of_case.FRT_tier_count: 420-479 min
      480 to 539 - 9 - of_case.FRT_tier_count: 480-539 min
      540 to 599 - 10 - of_case.FRT_tier_count: 540-599 min
      600 or Above - 11 - of_case.FRT_tier_count: ">= 600 min"
      0 to 29 - 1 - of_total: 0-29 sec
      30 to 59 - 2 - of_total: 30-59 sec
      60 to 89 - 3 - of_total: 60-89 sec
      90 to 119 - 4 - of_total: 90-119 sec
      120 to 149 - 5 - of_total: 120-149 sec
      150 to 179 - 6 - of_total: 150-179 sec
      180 to 209 - 7 - of_total: 180-209 sec
      210 to 239 - 8 - of_total: 210-239 sec
      240 to 269 - 9 - of_total: 240-269 sec
      270 to 300 - 10 - of_total: 270-300 sec
      301 or Above - 11 - of_total: "> 300 sec"
      0 to 59 - 1 - of_total: 0-59 min
      60 to 119 - 2 - of_total: 60-119 min
      120 to 179 - 3 - of_total: 120-179 min
      180 to 269 - 4 - of_total: 180-269 min
      270 to 299 - 5 - of_total: 270-299 min
      300 to 359 - 6 - of_total: 300-359 min
      360 to 419 - 7 - of_total: 360-419 min
      420 to 479 - 8 - of_total: 420-479 min
      480 to 539 - 9 - of_total: 480-539 min
      540 to 599 - 10 - of_total: 540-599 min
      600 or Above - 11 - of_total: ">= 600 min"
      0 to 60 - 1 - of_case.FRT_tier_count: 0-60
      61 to 120 - 2 - of_case.FRT_tier_count: 61-120 sec
      121 to 180 - 3 - of_case.FRT_tier_count: 121-180
      181 to 270 - 4 - of_case.FRT_tier_count: 181-270
      271 to 300 - 5 - of_case.FRT_tier_count: 271-300
      301 to 360 - 6 - of_case.FRT_tier_count: 301-360
      361 to 420 - 7 - of_case.FRT_tier_count: 361-420
      421 to 480 - 8 - of_case.FRT_tier_count: 421-480
      481 to 540 - 9 - of_case.FRT_tier_count: 481-540
      541 to 600 - 10 - of_case.FRT_tier_count: 541-600
      601 or Above - 11 - of_case.FRT_tier_count: "> 600"
      0 to 30 - 1 - of_case.FRT_tier_count: 0-30 sec
      31 to 60 - 2 - of_case.FRT_tier_count: 31-60 sec
      61 to 90 - 3 - of_case.FRT_tier_count: 61-90
      91 to 120 - 4 - of_case.FRT_tier_count: 91-120
      121 to 150 - 5 - of_case.FRT_tier_count: 121-150
      151 to 180 - 6 - of_case.FRT_tier_count: 151-180
      181 to 210 - 7 - of_case.FRT_tier_count: 181-210
      211 to 240 - 8 - of_case.FRT_tier_count: 211-240
      241 to 270 - 9 - of_case.FRT_tier_count: 241-270
      271 to 300 - 10 - of_case.FRT_tier_count: 271-300
      181 to 240 - 4 - of_case.FRT_tier_count: 181-240 sec
      121 to 180 - 4 - of_case.FRT_tier_count: 121-180 sec
      241 or Above - 6 - of_case.FRT_tier_count: "> 240 sec"
      61 to 120 - 3 - of_case.FRT_tier_count: 61-120 sec
      181 to 240 - 5 - of_case.FRT_tier_count: 181-240 sec
      ">= 0.1 and < 30.1 - 1 - of_case.FRT_tier_count": 0-30 sec
      ">= 30.1 and < 60.1 - 2 - of_case.FRT_tier_count": 31-60 sec
      ">= 60.1 and < 120.1 - 3 - of_case.FRT_tier_count": 61-120 sec
      ">= 120.1 and < 180.1 - 4 - of_case.FRT_tier_count": 121-180 sec
      ">= 180.1 and < 240.1 - 5 - of_case.FRT_tier_count": 181-240 sec
      ">= 240.1 - 6 - of_case.FRT_tier_count": ">240 sec"
    reference_lines: []
    trend_lines: []
    column_spacing_ratio: 0.3
    column_group_spacing_ratio: 0.3
    defaults_version: 1
    hidden_pivots:
      301 or Above|FIELD|11:
        is_entire_pivot_hidden: false
    hidden_fields: [of_total]
    hidden_points_if_no: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      <P style="text-align:left;"><B> Magenta Bar (0-30 sec) </B> is the Chat FRT Global Target</P>
      <P style="text-align:left;">*Recommend to zoom the screen to 100% </P>
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Office (Case): of_case.case_office_code
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
      Dynamic Filter - View By: of_case.Geo_Param
      Service or Contract Customer: of_case.Service_Contract_Customer
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 82
    col: 0
    width: 12
    height: 6
  - title: First Response Time (Chat) Histogram - Target Achievement Ratio
    name: First Response Time (Chat) Histogram - Target Achievement Ratio
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.dynamic_FRT_tier, of_case.FRT_tier_count]
    pivots: [of_case.dynamic_FRT_tier]
    filters:
      of_case.FRT_selector: Chat
      of_case.dynamic_FRT_tier: "-Undefined"
    sorts: [of_case.dynamic_FRT_tier]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: pivot_where(${of_case.dynamic_FRT_tier} = "0", null)
      label: Label
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: label
      _type_hint: 'null'
      is_disabled: true
    - category: table_calculation
      label: "% of total"
      value_format:
      value_format_name: percent_1
      calculation_type: percent_of_row
      table_calculation: of_total
      args:
      - of_case.FRT_tier_count
      _kind_hint: measure
      _type_hint: number
    query_timezone: Asia/Ho_Chi_Minh
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: of_total, id: of_total,
            name: "% of total"}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      300 or Above - 11 - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - 10 - of_chat_transcript.count: "#CCD3D1"
      240 to 269 - 09 - of_chat_transcript.count: "#CCD3D1"
      210 to 239 - 08 - of_chat_transcript.count: "#CCD3D1"
      180 to 209 - 07 - of_chat_transcript.count: "#CCD3D1"
      150 to 179 - 06 - of_chat_transcript.count: "#CCD3D1"
      120 to 149 - 05 - of_chat_transcript.count: "#CCD3D1"
      90 to 119 - 04 - of_chat_transcript.count: "#CCD3D1"
      60 to 89 - 03 - of_chat_transcript.count: "#CCD3D1"
      30 to 59 - 02 - of_chat_transcript.count: "#CCD3D1"
      180 to 269 - Web - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - Web - of_chat_transcript.count: "#CCD3D1"
      300 to 359 - Web - of_chat_transcript.count: "#CCD3D1"
      360 to 419 - Web - of_chat_transcript.count: "#CCD3D1"
      480 to 539 - Web - of_chat_transcript.count: "#CCD3D1"
      420 to 479 - Web - of_chat_transcript.count: "#CCD3D1"
      540 to 599 - Web - of_chat_transcript.count: "#CCD3D1"
      60 to 119 - Web - of_chat_transcript.count: "#CCD3D1"
      600 or Above - Web - of_chat_transcript.count: "#CCD3D1"
      150 to 179 - Chat - of_chat_transcript.count: "#CCD3D1"
      180 to 209 - Chat - of_chat_transcript.count: "#CCD3D1"
      210 to 239 - Chat - of_chat_transcript.count: "#CCD3D1"
      240 to 269 - Chat - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - Chat - of_chat_transcript.count: "#CCD3D1"
      30 to 59 - Chat - of_chat_transcript.count: "#CCD3D1"
      300 or Above - Chat - of_chat_transcript.count: "#CCD3D1"
      60 to 89 - Chat - of_chat_transcript.count: "#CCD3D1"
      90 to 119 - Chat - of_chat_transcript.count: "#CCD3D1"
      60 to 89 - 3 - of_chat_transcript.count: "#CCD3D1"
      90 to 119 - 4 - of_chat_transcript.count: "#CCD3D1"
      120 to 149 - 5 - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - 5 - of_chat_transcript.count: "#CCD3D1"
      150 to 179 - 6 - of_chat_transcript.count: "#CCD3D1"
      180 to 209 - 7 - of_chat_transcript.count: "#CCD3D1"
      210 to 239 - 8 - of_chat_transcript.count: "#CCD3D1"
      240 to 269 - 9 - of_chat_transcript.count: "#CCD3D1"
      300 or Above - 10 - of_chat_transcript.count: "#CCD3D1"
      120 to 179 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      180 to 269 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      270 to 299 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      300 to 359 - 6 - of_case.FRT_tier_count: "#CCD3D1"
      360 to 419 - 7 - of_case.FRT_tier_count: "#CCD3D1"
      420 to 479 - 8 - of_case.FRT_tier_count: "#CCD3D1"
      480 to 539 - 9 - of_case.FRT_tier_count: "#CCD3D1"
      540 to 599 - 10 - of_case.FRT_tier_count: "#CCD3D1"
      600 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      60 to 89 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      90 to 119 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      120 to 149 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      150 to 179 - 6 - of_case.FRT_tier_count: "#CCD3D1"
      180 to 209 - 7 - of_case.FRT_tier_count: "#CCD3D1"
      210 to 239 - 8 - of_case.FRT_tier_count: "#CCD3D1"
      240 to 269 - 9 - of_case.FRT_tier_count: "#CCD3D1"
      300 or Above - 10 - of_case.FRT_tier_count: "#CCD3D1"
      300 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      270 to 300 - 10 - of_case.FRT_tier_count: "#CCD3D1"
      301 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      label: "#BD0F72"
      60 to 89 - 3 - test: "#CCD3D1"
      90 to 119 - 4 - test: "#CCD3D1"
      120 to 149 - 5 - test: "#CCD3D1"
      150 to 179 - 6 - test: "#CCD3D1"
      180 to 209 - 7 - test: "#CCD3D1"
      60 to 89 - 3 - of_total: "#CCD3D1"
      90 to 119 - 4 - of_total: "#CCD3D1"
      120 to 149 - 5 - of_total: "#CCD3D1"
      150 to 179 - 6 - of_total: "#CCD3D1"
      180 to 209 - 7 - of_total: "#CCD3D1"
      210 to 239 - 8 - of_total: "#CCD3D1"
      240 to 269 - 9 - of_total: "#CCD3D1"
      270 to 300 - 10 - of_total: "#CCD3D1"
      301 or Above - 11 - of_total: "#CCD3D1"
      120 to 179 - 3 - of_total: "#CCD3D1"
      180 to 269 - 4 - of_total: "#CCD3D1"
      270 to 299 - 5 - of_total: "#CCD3D1"
      300 to 359 - 6 - of_total: "#CCD3D1"
      360 to 419 - 7 - of_total: "#CCD3D1"
      420 to 479 - 8 - of_total: "#CCD3D1"
      480 to 539 - 9 - of_total: "#CCD3D1"
      540 to 599 - 10 - of_total: "#CCD3D1"
      600 or Above - 11 - of_total: "#CCD3D1"
      121 to 180 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      181 to 270 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      271 to 300 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      301 to 360 - 6 - of_case.FRT_tier_count: "#CCD3D1"
      361 to 420 - 7 - of_case.FRT_tier_count: "#CCD3D1"
      421 to 480 - 8 - of_case.FRT_tier_count: "#CCD3D1"
      481 to 540 - 9 - of_case.FRT_tier_count: "#CCD3D1"
      541 to 600 - 10 - of_case.FRT_tier_count: "#CCD3D1"
      601 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      121 to 150 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      91 to 120 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      61 to 90 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      151 to 180 - 6 - of_case.FRT_tier_count: "#CCD3D1"
      181 to 210 - 7 - of_case.FRT_tier_count: "#CCD3D1"
      241 to 270 - 9 - of_case.FRT_tier_count: "#CCD3D1"
      211 to 240 - 8 - of_case.FRT_tier_count: "#CCD3D1"
      271 to 300 - 10 - of_case.FRT_tier_count: "#CCD3D1"
      61 to 90 - 3 - of_total: "#CCD3D1"
      91 to 120 - 4 - of_total: "#CCD3D1"
      121 to 150 - 5 - of_total: "#CCD3D1"
      151 to 180 - 6 - of_total: "#CCD3D1"
      181 to 210 - 7 - of_total: "#CCD3D1"
      211 to 240 - 8 - of_total: "#CCD3D1"
      241 to 270 - 9 - of_total: "#CCD3D1"
      271 to 300 - 10 - of_total: "#CCD3D1"
      121 to 180 - 4 - of_total: "#CCD3D1"
      181 to 240 - 4 - of_total: "#CCD3D1"
      61 to 120 - 2 - of_total: "#CCD3D1"
      241 or Above - 6 - of_total: "#CCD3D1"
      61 to 120 - 3 - of_total: "#CCD3D1"
      181 to 240 - 5 - of_total: "#CCD3D1"
      ">= 240.1 - 6 - of_total": "#CCD3D1"
      ">= 180.1 and < 240.1 - 5 - of_total": "#CCD3D1"
      ">= 120.1 and < 180.1 - 4 - of_total": "#CCD3D1"
      ">= 60.1 and < 120.1 - 3 - of_total": "#CCD3D1"
    series_labels:
      300 or Above - 10 - of_case.FRT_tier_count: ">= 300 sec"
      240 to 269 - 9 - of_case.FRT_tier_count: 240-269 sec
      0 to 29 - 1 - of_case.FRT_tier_count: 0-29 sec
      30 to 59 - 2 - of_case.FRT_tier_count: 30-59 sec
      60 to 89 - 3 - of_case.FRT_tier_count: 60-89 sec
      90 to 119 - 4 - of_case.FRT_tier_count: 90-119 sec
      301 or Above - 11 - of_case.FRT_tier_count: "> 300 sec"
      120 to 149 - 5 - of_case.FRT_tier_count: 120-149 sec
      150 to 179 - 6 - of_case.FRT_tier_count: 150-179 sec
      180 to 209 - 7 - of_case.FRT_tier_count: 180-209 sec
      210 to 239 - 8 - of_case.FRT_tier_count: 210-239 sec
      270 to 300 - 10 - of_case.FRT_tier_count: 270-300 sec
      0 to 59 - 1 - of_case.FRT_tier_count: 0-59 min
      60 to 119 - 2 - of_case.FRT_tier_count: 60-119 min
      120 to 179 - 3 - of_case.FRT_tier_count: 120-179 min
      180 to 269 - 4 - of_case.FRT_tier_count: 180-269 min
      270 to 299 - 5 - of_case.FRT_tier_count: 270-299 min
      300 to 359 - 6 - of_case.FRT_tier_count: 300-359 min
      360 to 419 - 7 - of_case.FRT_tier_count: 360-419 min
      420 to 479 - 8 - of_case.FRT_tier_count: 420-479 min
      480 to 539 - 9 - of_case.FRT_tier_count: 480-539 min
      540 to 599 - 10 - of_case.FRT_tier_count: 540-599 min
      600 or Above - 11 - of_case.FRT_tier_count: ">= 600 min"
      0 to 29 - 1 - of_total: 0-29 sec
      30 to 59 - 2 - of_total: 30-59 sec
      60 to 89 - 3 - of_total: 60-89 sec
      90 to 119 - 4 - of_total: 90-119 sec
      120 to 149 - 5 - of_total: 120-149 sec
      150 to 179 - 6 - of_total: 150-179 sec
      180 to 209 - 7 - of_total: 180-209 sec
      210 to 239 - 8 - of_total: 210-239 sec
      240 to 269 - 9 - of_total: 240-269 sec
      270 to 300 - 10 - of_total: 270-300 sec
      301 or Above - 11 - of_total: "> 300"
      0 to 59 - 1 - of_total: 0-59 min
      60 to 119 - 2 - of_total: 60-119 min
      120 to 179 - 3 - of_total: 120-179 min
      180 to 269 - 4 - of_total: 180-269 min
      270 to 299 - 5 - of_total: 270-299 min
      300 to 359 - 6 - of_total: 300-359 min
      360 to 419 - 7 - of_total: 360-419 min
      420 to 479 - 8 - of_total: 420-479 min
      480 to 539 - 9 - of_total: 480-539 min
      540 to 599 - 10 - of_total: 540-599 min
      600 or Above - 11 - of_total: ">= 600 min"
      0 to 60 - 1 - of_case.FRT_tier_count: 0-60
      61 to 120 - 2 - of_case.FRT_tier_count: 61-120
      121 to 180 - 3 - of_case.FRT_tier_count: 121-180
      181 to 270 - 4 - of_case.FRT_tier_count: 181-270
      271 to 300 - 5 - of_case.FRT_tier_count: 271-300
      301 to 360 - 6 - of_case.FRT_tier_count: 301-360
      361 to 420 - 7 - of_case.FRT_tier_count: 361-420
      421 to 480 - 8 - of_case.FRT_tier_count: 421-480
      481 to 540 - 9 - of_case.FRT_tier_count: 481-540
      541 to 600 - 10 - of_case.FRT_tier_count: 541-600
      601 or Above - 11 - of_case.FRT_tier_count: "> 600"
      0 to 30 - 1 - of_case.FRT_tier_count: 0-30
      31 to 60 - 2 - of_case.FRT_tier_count: 31-60
      61 to 90 - 3 - of_case.FRT_tier_count: 61-90
      91 to 120 - 4 - of_case.FRT_tier_count: 91-120
      121 to 150 - 5 - of_case.FRT_tier_count: 121-150
      151 to 180 - 6 - of_case.FRT_tier_count: 151-180
      181 to 210 - 7 - of_case.FRT_tier_count: 181-210
      211 to 240 - 8 - of_case.FRT_tier_count: 211-240
      241 to 270 - 9 - of_case.FRT_tier_count: 241-270
      271 to 300 - 10 - of_case.FRT_tier_count: 271-300
      0 to 30 - 1 - of_total: 0-30 sec
      31 to 60 - 2 - of_total: 31-60 sec
      61 to 90 - 3 - of_total: 61-90
      91 to 120 - 4 - of_total: 91-120
      121 to 150 - 5 - of_total: 121-150
      151 to 180 - 6 - of_total: 151-180
      181 to 210 - 7 - of_total: 181-120
      211 to 240 - 8 - of_total: 211-240
      241 to 270 - 9 - of_total: 241-270
      271 to 300 - 10 - of_total: 271-300
      61 to 120 - 2 - of_total: 61-120 sec
      121 to 180 - 4 - of_total: 121-180 sec
      181 to 240 - 4 - of_total: 181-240 sec
      241 or Above - 6 - of_total: "> 240 sec"
      61 to 120 - 3 - of_total: 61-120 sec
      181 to 240 - 5 - of_total: 181-240 sec
      ">= 0.1 and < 30.1 - 1 - of_total": 0-30 sec
      ">= 30.1 and < 60.1 - 2 - of_total": 31-60 sec
      ">= 60.1 and < 120.1 - 3 - of_total": 61-120 sec
      ">= 120.1 and < 180.1 - 4 - of_total": 121-180 sec
      ">= 180.1 and < 240.1 - 5 - of_total": 181-240 sec
      ">= 240.1 - 6 - of_total": ">240 sec"
    reference_lines: []
    trend_lines: []
    column_spacing_ratio: 0.3
    column_group_spacing_ratio: 0.3
    defaults_version: 1
    hidden_pivots:
      0 to 30|FIELD|1:
        measure_names: []
      31 to 60|FIELD|2:
        measure_names: []
      301 or Above|FIELD|11:
        is_entire_pivot_hidden: false
    hidden_fields: [of_case.FRT_tier_count]
    hidden_points_if_no: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      <P style="text-align:left;"><B> Magenta Bar (0-30 sec) </B> is the Chat FRT Global Target
      <P style="text-align:left;">*Recommend to zoom the screen to 100% </P>
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Office (Case): of_case.case_office_code
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
      Dynamic Filter - View By: of_case.Geo_Param
      Service or Contract Customer: of_case.Service_Contract_Customer
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 82
    col: 12
    width: 12
    height: 6
  - title: First Response Time (Web) Histogram - Target Achievement Ratio
    name: First Response Time (Web) Histogram - Target Achievement Ratio
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.dynamic_FRT_tier, of_case.FRT_tier_count]
    pivots: [of_case.dynamic_FRT_tier]
    filters:
      of_case.FRT_selector: Web
      of_case.dynamic_FRT_tier: "-Undefined,-< 0.1"
    sorts: [of_case.dynamic_FRT_tier]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: pivot_where(${of_case.dynamic_FRT_tier} = "0", null)
      label: Label
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: label
      _type_hint: 'null'
      is_disabled: true
    - category: table_calculation
      label: "% of total"
      value_format:
      value_format_name: percent_1
      calculation_type: percent_of_row
      table_calculation: of_total
      args:
      - of_case.FRT_tier_count
      _kind_hint: measure
      _type_hint: number
    query_timezone: Asia/Ho_Chi_Minh
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: of_total, id: of_total,
            name: "% of total"}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      300 or Above - 11 - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - 10 - of_chat_transcript.count: "#CCD3D1"
      240 to 269 - 09 - of_chat_transcript.count: "#CCD3D1"
      210 to 239 - 08 - of_chat_transcript.count: "#CCD3D1"
      180 to 209 - 07 - of_chat_transcript.count: "#CCD3D1"
      150 to 179 - 06 - of_chat_transcript.count: "#CCD3D1"
      120 to 149 - 05 - of_chat_transcript.count: "#CCD3D1"
      90 to 119 - 04 - of_chat_transcript.count: "#CCD3D1"
      60 to 89 - 03 - of_chat_transcript.count: "#CCD3D1"
      30 to 59 - 02 - of_chat_transcript.count: "#CCD3D1"
      180 to 269 - Web - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - Web - of_chat_transcript.count: "#CCD3D1"
      300 to 359 - Web - of_chat_transcript.count: "#CCD3D1"
      360 to 419 - Web - of_chat_transcript.count: "#CCD3D1"
      480 to 539 - Web - of_chat_transcript.count: "#CCD3D1"
      420 to 479 - Web - of_chat_transcript.count: "#CCD3D1"
      540 to 599 - Web - of_chat_transcript.count: "#CCD3D1"
      60 to 119 - Web - of_chat_transcript.count: "#CCD3D1"
      600 or Above - Web - of_chat_transcript.count: "#CCD3D1"
      150 to 179 - Chat - of_chat_transcript.count: "#CCD3D1"
      180 to 209 - Chat - of_chat_transcript.count: "#CCD3D1"
      210 to 239 - Chat - of_chat_transcript.count: "#CCD3D1"
      240 to 269 - Chat - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - Chat - of_chat_transcript.count: "#CCD3D1"
      30 to 59 - Chat - of_chat_transcript.count: "#CCD3D1"
      300 or Above - Chat - of_chat_transcript.count: "#CCD3D1"
      60 to 89 - Chat - of_chat_transcript.count: "#CCD3D1"
      90 to 119 - Chat - of_chat_transcript.count: "#CCD3D1"
      60 to 89 - 3 - of_chat_transcript.count: "#CCD3D1"
      90 to 119 - 4 - of_chat_transcript.count: "#CCD3D1"
      120 to 149 - 5 - of_chat_transcript.count: "#CCD3D1"
      270 to 299 - 5 - of_chat_transcript.count: "#CCD3D1"
      150 to 179 - 6 - of_chat_transcript.count: "#CCD3D1"
      180 to 209 - 7 - of_chat_transcript.count: "#CCD3D1"
      210 to 239 - 8 - of_chat_transcript.count: "#CCD3D1"
      240 to 269 - 9 - of_chat_transcript.count: "#CCD3D1"
      300 or Above - 10 - of_chat_transcript.count: "#CCD3D1"
      120 to 179 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      180 to 269 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      270 to 299 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      300 to 359 - 6 - of_case.FRT_tier_count: "#CCD3D1"
      360 to 419 - 7 - of_case.FRT_tier_count: "#CCD3D1"
      420 to 479 - 8 - of_case.FRT_tier_count: "#CCD3D1"
      480 to 539 - 9 - of_case.FRT_tier_count: "#CCD3D1"
      540 to 599 - 10 - of_case.FRT_tier_count: "#CCD3D1"
      600 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      60 to 89 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      90 to 119 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      120 to 149 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      150 to 179 - 6 - of_case.FRT_tier_count: "#CCD3D1"
      180 to 209 - 7 - of_case.FRT_tier_count: "#CCD3D1"
      210 to 239 - 8 - of_case.FRT_tier_count: "#CCD3D1"
      240 to 269 - 9 - of_case.FRT_tier_count: "#CCD3D1"
      300 or Above - 10 - of_case.FRT_tier_count: "#CCD3D1"
      300 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      270 to 300 - 10 - of_case.FRT_tier_count: "#CCD3D1"
      301 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      label: "#BD0F72"
      60 to 89 - 3 - test: "#CCD3D1"
      90 to 119 - 4 - test: "#CCD3D1"
      120 to 149 - 5 - test: "#CCD3D1"
      150 to 179 - 6 - test: "#CCD3D1"
      180 to 209 - 7 - test: "#CCD3D1"
      60 to 89 - 3 - of_total: "#CCD3D1"
      90 to 119 - 4 - of_total: "#CCD3D1"
      120 to 149 - 5 - of_total: "#CCD3D1"
      150 to 179 - 6 - of_total: "#CCD3D1"
      180 to 209 - 7 - of_total: "#CCD3D1"
      210 to 239 - 8 - of_total: "#CCD3D1"
      240 to 269 - 9 - of_total: "#CCD3D1"
      270 to 300 - 10 - of_total: "#CCD3D1"
      301 or Above - 11 - of_total: "#CCD3D1"
      120 to 179 - 3 - of_total: "#CCD3D1"
      180 to 269 - 4 - of_total: "#CCD3D1"
      270 to 299 - 5 - of_total: "#CCD3D1"
      300 to 359 - 6 - of_total: "#CCD3D1"
      360 to 419 - 7 - of_total: "#CCD3D1"
      420 to 479 - 8 - of_total: "#CCD3D1"
      480 to 539 - 9 - of_total: "#CCD3D1"
      540 to 599 - 10 - of_total: "#CCD3D1"
      600 or Above - 11 - of_total: "#CCD3D1"
      121 to 180 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      181 to 270 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      271 to 300 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      301 to 360 - 6 - of_case.FRT_tier_count: "#CCD3D1"
      361 to 420 - 7 - of_case.FRT_tier_count: "#CCD3D1"
      421 to 480 - 8 - of_case.FRT_tier_count: "#CCD3D1"
      481 to 540 - 9 - of_case.FRT_tier_count: "#CCD3D1"
      541 to 600 - 10 - of_case.FRT_tier_count: "#CCD3D1"
      601 or Above - 11 - of_case.FRT_tier_count: "#CCD3D1"
      121 to 150 - 5 - of_case.FRT_tier_count: "#CCD3D1"
      91 to 120 - 4 - of_case.FRT_tier_count: "#CCD3D1"
      61 to 90 - 3 - of_case.FRT_tier_count: "#CCD3D1"
      151 to 180 - 6 - of_case.FRT_tier_count: "#CCD3D1"
      181 to 210 - 7 - of_case.FRT_tier_count: "#CCD3D1"
      241 to 270 - 9 - of_case.FRT_tier_count: "#CCD3D1"
      211 to 240 - 8 - of_case.FRT_tier_count: "#CCD3D1"
      271 to 300 - 10 - of_case.FRT_tier_count: "#CCD3D1"
      61 to 90 - 3 - of_total: "#CCD3D1"
      91 to 120 - 4 - of_total: "#CCD3D1"
      121 to 150 - 5 - of_total: "#CCD3D1"
      151 to 180 - 6 - of_total: "#CCD3D1"
      181 to 210 - 7 - of_total: "#CCD3D1"
      211 to 240 - 8 - of_total: "#CCD3D1"
      241 to 270 - 9 - of_total: "#CCD3D1"
      271 to 300 - 10 - of_total: "#CCD3D1"
      271 to 300 - 5 - of_total: "#CCD3D1"
      601 or Above - 11 - of_total: "#CCD3D1"
      541 to 600 - 10 - of_total: "#CCD3D1"
      481 to 540 - 9 - of_total: "#CCD3D1"
      301 to 360 - 6 - of_total: "#CCD3D1"
      361 to 420 - 7 - of_total: "#CCD3D1"
      421 to 480 - 8 - of_total: "#CCD3D1"
      181 to 270 - 4 - of_total: "#CCD3D1"
      121 to 180 - 3 - of_total: "#CCD3D1"
      0 to 60 - 1 - of_total: "#BD0F72"
      181 to 240 - 4 - of_total: "#CCD3D1"
      241 to 300 - 5 - of_total: "#CCD3D1"
      301 or Above - 6 - of_total: "#CCD3D1"
      ">= 120.1 and < 180.1 - 3 - of_total": "#CCD3D1"
      ">= 180.1 and < 240.1 - 4 - of_total": "#CCD3D1"
      ">= 240.1 and < 300.1 - 5 - of_total": "#CCD3D1"
      ">= 300.1 - 6 - of_total": "#CCD3D1"
    series_labels:
      300 or Above - 10 - of_case.FRT_tier_count: ">= 300 sec"
      240 to 269 - 9 - of_case.FRT_tier_count: 240-269 sec
      0 to 29 - 1 - of_case.FRT_tier_count: 0-29 sec
      30 to 59 - 2 - of_case.FRT_tier_count: 30-59 sec
      60 to 89 - 3 - of_case.FRT_tier_count: 60-89 sec
      90 to 119 - 4 - of_case.FRT_tier_count: 90-119 sec
      301 or Above - 11 - of_case.FRT_tier_count: "> 300 sec"
      120 to 149 - 5 - of_case.FRT_tier_count: 120-149 sec
      150 to 179 - 6 - of_case.FRT_tier_count: 150-179 sec
      180 to 209 - 7 - of_case.FRT_tier_count: 180-209 sec
      210 to 239 - 8 - of_case.FRT_tier_count: 210-239 sec
      270 to 300 - 10 - of_case.FRT_tier_count: 270-300 sec
      0 to 59 - 1 - of_case.FRT_tier_count: 0-59 min
      60 to 119 - 2 - of_case.FRT_tier_count: 60-119 min
      120 to 179 - 3 - of_case.FRT_tier_count: 120-179 min
      180 to 269 - 4 - of_case.FRT_tier_count: 180-269 min
      270 to 299 - 5 - of_case.FRT_tier_count: 270-299 min
      300 to 359 - 6 - of_case.FRT_tier_count: 300-359 min
      360 to 419 - 7 - of_case.FRT_tier_count: 360-419 min
      420 to 479 - 8 - of_case.FRT_tier_count: 420-479 min
      480 to 539 - 9 - of_case.FRT_tier_count: 480-539 min
      540 to 599 - 10 - of_case.FRT_tier_count: 540-599 min
      600 or Above - 11 - of_case.FRT_tier_count: ">= 600 min"
      0 to 29 - 1 - of_total: 0-29 sec
      30 to 59 - 2 - of_total: 30-59 sec
      60 to 89 - 3 - of_total: 60-89 sec
      90 to 119 - 4 - of_total: 90-119 sec
      120 to 149 - 5 - of_total: 120-149 sec
      150 to 179 - 6 - of_total: 150-179 sec
      180 to 209 - 7 - of_total: 180-209 sec
      210 to 239 - 8 - of_total: 210-239 sec
      240 to 269 - 9 - of_total: 240-269 sec
      270 to 300 - 10 - of_total: 270-300 sec
      301 or Above - 11 - of_total: "> 300"
      0 to 59 - 1 - of_total: 0-59 min
      60 to 119 - 2 - of_total: 60-119 min
      120 to 179 - 3 - of_total: 120-179 min
      180 to 269 - 4 - of_total: 180-269 min
      270 to 299 - 5 - of_total: 270-299 min
      300 to 359 - 6 - of_total: 300-359 min
      360 to 419 - 7 - of_total: 360-419 min
      420 to 479 - 8 - of_total: 420-479 min
      480 to 539 - 9 - of_total: 480-539 min
      540 to 599 - 10 - of_total: 540-599 min
      600 or Above - 11 - of_total: ">= 600 min"
      0 to 60 - 1 - of_case.FRT_tier_count: 0-60
      61 to 120 - 2 - of_case.FRT_tier_count: 61-120
      121 to 180 - 3 - of_case.FRT_tier_count: 121-180
      181 to 270 - 4 - of_case.FRT_tier_count: 181-270
      271 to 300 - 5 - of_case.FRT_tier_count: 271-300
      301 to 360 - 6 - of_case.FRT_tier_count: 301-360
      361 to 420 - 7 - of_case.FRT_tier_count: 361-420
      421 to 480 - 8 - of_case.FRT_tier_count: 421-480
      481 to 540 - 9 - of_case.FRT_tier_count: 481-540
      541 to 600 - 10 - of_case.FRT_tier_count: 541-600
      601 or Above - 11 - of_case.FRT_tier_count: "> 600"
      0 to 30 - 1 - of_case.FRT_tier_count: 0-30
      31 to 60 - 2 - of_case.FRT_tier_count: 31-60
      61 to 90 - 3 - of_case.FRT_tier_count: 61-90
      91 to 120 - 4 - of_case.FRT_tier_count: 91-120
      121 to 150 - 5 - of_case.FRT_tier_count: 121-150
      151 to 180 - 6 - of_case.FRT_tier_count: 151-180
      181 to 210 - 7 - of_case.FRT_tier_count: 181-210
      211 to 240 - 8 - of_case.FRT_tier_count: 211-240
      241 to 270 - 9 - of_case.FRT_tier_count: 241-270
      271 to 300 - 10 - of_case.FRT_tier_count: 271-300
      0 to 30 - 1 - of_total: 0-30
      31 to 60 - 2 - of_total: 31-60
      61 to 90 - 3 - of_total: 61-90
      91 to 120 - 4 - of_total: 91-120
      121 to 150 - 5 - of_total: 121-150
      151 to 180 - 6 - of_total: 151-180
      181 to 210 - 7 - of_total: 181-120
      211 to 240 - 8 - of_total: 211-240
      241 to 270 - 9 - of_total: 241-270
      271 to 300 - 10 - of_total: 271-300
      0 to 60 - 1 - of_total: 0-60 min
      61 to 120 - 2 - of_total: 61-120 min
      121 to 180 - 3 - of_total: 121-180 min
      181 to 270 - 4 - of_total: 181-270
      271 to 300 - 5 - of_total: 271-300
      301 to 360 - 6 - of_total: 301-360
      361 to 420 - 7 - of_total: 361-420
      421 to 480 - 8 - of_total: 421-480
      481 to 540 - 9 - of_total: 481-540
      541 to 600 - 10 - of_total: 541-600
      601 or Above - 11 - of_total: "> 600"
      181 to 240 - 4 - of_total: 181-240 min
      241 to 300 - 5 - of_total: 241-300 min
      301 or Above - 6 - of_total: "> 300 min"
      ">= 0.1 and < 60.1 - 1 - of_total": 0-60 min
      ">= 60.1 and < 120.1 - 2 - of_total": 60-120 min
      ">= 120.1 and < 180.1 - 3 - of_total": 120-180 min
      ">= 180.1 and < 240.1 - 4 - of_total": 180-240 min
      ">= 240.1 and < 300.1 - 5 - of_total": 240-300 min
      ">= 300.1 - 6 - of_total": ">300 min"
    reference_lines: []
    trend_lines: []
    column_spacing_ratio: 0.3
    column_group_spacing_ratio: 0.3
    defaults_version: 1
    hidden_pivots:
      0 to 30|FIELD|1:
        measure_names: []
      31 to 60|FIELD|2:
        measure_names: []
      601 or Above|FIELD|11:
        is_entire_pivot_hidden: false
    hidden_fields: [of_case.FRT_tier_count]
    hidden_points_if_no: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      <P style="text-align:left;"><B> Magenta Bar (0-60 min) </B> is the Web FRT Global Target
      <P style="text-align:left;">*Recommend to zoom the screen to 100% </P>
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Office (Case): of_case.case_office_code
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
      Dynamic Filter - View By: of_case.Geo_Param
      Service or Contract Customer: of_case.Service_Contract_Customer
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 88
    col: 12
    width: 12
    height: 6
  - title: On-Hold Cases Handling Time*
    name: On-Hold Cases Handling Time*
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.Case_Geo, of_case.on_hold_wait_time, of_case.non_on_hold_time,
      of_case.total_handling_time]
    sorts: [of_case.Case_Geo]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: false
    show_y_axis_ticks: false
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
    totals_color: "#CCD3D1"
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.non_on_hold_time,
            id: of_case.non_on_hold_time, name: Non-On Hold Time}, {axisId: of_case.on_hold_wait_time,
            id: of_case.on_hold_wait_time, name: On Hold Wait Time}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, type: linear},
      {label: '', orientation: left, series: [{axisId: of_case.total_handling_time,
            id: of_case.total_handling_time, name: Total Handling Time}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, type: linear}]
    size_by_field: ''
    x_axis_zoom: true
    y_axis_zoom: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    font_size: '12'
    label_value_format: ''
    series_types:
      of_case.total_handling_time: line
    series_colors:
      Bad: "#000000"
      Good: "#BD0F72"
      of_case.case_distinct_count: "#F39200"
      of_case.AVG_FIRST_CONTACT_RESOLUTION: "#00506D"
      Yes - of_case.case_distinct_count: "#BD0F72"
      No - of_case.case_distinct_count: "#CCD3D1"
      On-Hold Cases - of_case.Transferred_Case_count_distinct: "#F39200"
      On-Hold Cases - of_case.case_distinct_count: "#F39200"
      of_case.non_on_hold_time: "#BD0F72"
      of_case.on_hold_wait_time: "#CCD3D1"
      of_case.total_handling_time: "#84C5C3"
    label_color: []
    column_group_spacing_ratio: 0.4
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: true
    rightAxisLabel: ''
    smoothedBars: false
    isStepped: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    value_labels: labels
    label_type: labPer
    inner_radius: 20
    color_range: ["#4285F4", "#EA4335", "#FBBC04", "#34A852", "#5F6368"]
    color_by: node
    show_null_points: false
    value_format_override: ''
    show_percent: true
    arm_length: 25
    arm_weight: 50
    spinner_length: 100
    spinner_weight: 50
    viz_trellis_by: none
    angle: 90
    cutout: 50
    range_x: 1
    range_y: 1
    up_color: "#BD0F72"
    down_color: "#F39200"
    total_color: "#00506D"
    interpolation: linear
    bar_arm_length: 25
    bar_arm_weight: 50
    bar_spinner_length: 100
    bar_spinner_weight: 50
    defaults_version: 1
    hidden_fields: []
    hidden_points_if_no: []
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
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    hidden_pivots: {}
    listen:
      Status: of_case.status
      Priority: of_case.priority
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      RHQ (Case): of_case.Regional_Head_Office
      Office (Case): of_case.case_office_code
      Category (L1): of_case.reason
      Resolution Reason: of_case.resolution_reason
      Sub Resolution Reason: of_case.sub_resolution_reason
      Case Number: of_case.casenumber
      Contract Number: of_case.contract_number
      Initial Queue Name: of_case.Initial_Queue_Name
      Web Email: of_case.supplied_email
      Closed Date: of_case.closeddate_date
      Case Resolved Date: of_case.Case_Resolved_Date_Time_date
      Service or Contract Customer: of_case.Service_Contract_Customer
      Dynamic Filter - View By: of_case.Geo_Param
      Service Type: of_case.type
      Date Granularity: of_case.timeframe_picker
      Subtopic (L4): of_case.subordinate_category_l4
      Contact Email: of_case.contactemail
      Original Record Type: of_case.original_record_type
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      eComm ID: of_case.ecomm_id
      Reopened Case: of_case.Case_reopened
      Chat Owner: of_case.ct_owner_name1
      Case Rating: of_case.case_rating
      Has Leave Message: of_case.has_leave_message_filter
      Channel: of_case.origin
      Open Date: of_case.On_hold_chart_date_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 68
    col: 16
    width: 8
    height: 7
  - title: Avg case handled by distinct case owner/total agents
    name: Avg case handled by distinct case owner/total agents
    model: oneforce_service
    explore: of_case
    type: looker_line
    fields: [of_case.case_distinct_count, of_case.Case_Geo, of_case.Case_Resolved_Date_Time_dynamic,
      of_case.avg_cases_val_dynamic]
    pivots: [of_case.Case_Geo]
    fill_fields: [of_case.Case_Resolved_Date_Time_dynamic]
    filters:
      of_case.active_case: 'No'
    sorts: [of_case.Case_Geo, of_case.Case_Resolved_Date_Time_dynamic desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${of_case.case_distinct_count}/${of_case.avg_cases_val_dynamic}"
      label: Average cases
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_cases
      _type_hint: number
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
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: average_cases_by_total_agents,
            id: Global - average_cases_by_total_agents, name: Global}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    defaults_version: 1
    hidden_fields: [of_case.case_distinct_count, of_case.avg_cases_val_dynamic]
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
      Chat Owner: of_case.ct_owner_name1
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Resolution Reason: of_case.resolution_reason
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
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
      Average case by: of_case.avg_cases_param
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 68
    col: 0
    width: 12
    height: 7
  - title: FRT Chat/Web Histogram and Target Achievement Ratio
    name: FRT Chat/Web Histogram and Target Achievement Ratio
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.FRT_tier_count, of_case.dynamic_FRT_tier]
    filters:
      of_case.dynamic_FRT_tier: "-Undefined,-< 0.1"
    sorts: [of_case.dynamic_FRT_tier]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: pivot_where(${of_case.dynamic_FRT_tier} = "0", null)
      label: Label
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: label
      _type_hint: 'null'
      is_disabled: true
    - category: table_calculation
      label: Target Achievement Ratio
      value_format:
      value_format_name: percent_1
      calculation_type: percent_of_column_sum
      table_calculation: target_achievement_ratio
      args:
      - of_case.FRT_tier_count
      _kind_hint: measure
      _type_hint: number
    query_timezone: UTC
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
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.FRT_tier_count,
            id: of_case.FRT_tier_count, name: FRT Tier Count}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, type: linear},
      {label: '', orientation: left, series: [{axisId: target_achievement_ratio, id: target_achievement_ratio,
            name: Target Achievement Ratio}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '1'
    series_types:
      target_achievement_ratio: line
    series_colors:
      label: "#BD0F72"
      ">= 240.1 - 6 - of_total": "#CCD3D1"
      ">= 180.1 and < 240.1 - 5 - of_total": "#CCD3D1"
      ">= 120.1 and < 180.1 - 4 - of_total": "#CCD3D1"
      ">= 60.1 and < 120.1 - 3 - of_total": "#CCD3D1"
      ">= 30.1 and < 60.1 - 2 - of_case.FRT_tier_count": "#CCD3D1"
      ">= 30.1 and < 60.1 - 2 - of_total": "#CCD3D1"
      of_total: "#84C5C3"
      target_achievement_ratio: "#84C5C3"
    series_labels:
      ">= 0.1 and < 30.1 - 1 - of_case.FRT_tier_count": 0-30 sec
      ">= 30.1 and < 60.1 - 2 - of_case.FRT_tier_count": 31-60 sec
      "Dynamic FRT Tier >= 0.1 and < 60.1": "FRT Tier"
      "Dynamic FRT Tier 0-30 sec": "FRT Tier 0-30 sec"
      "FRT Tier Count": "Count (%Target)"
    reference_lines: []
    trend_lines: []
    column_spacing_ratio: 0.3
    column_group_spacing_ratio: 0.3
    defaults_version: 1
    hidden_pivots: {}
    hidden_fields:
    hidden_points_if_no: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      <P style="text-align:left;"><B> Magenta Bar (0-30 sec) </B> is the Chat FRT Global Target
      <P style="text-align:left;">*Recommend to zoom the screen to 100% </P>
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Chat Owner: of_case.ct_owner_name1
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Resolution Reason: of_case.resolution_reason
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
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
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      FRT Histogram: of_case.FRT_selector
    row: 94
    col: 0
    width: 12
    height: 6
  - title: Cases by Status*/Open Cases by Priority*
    name: Cases by Status*/Open Cases by Priority*
    model: oneforce_service
    explore: of_case
    type: looker_donut_multiples
    fields: [of_case.Case_Geo, of_case.case_status_priority_dynamic, of_case.case_cnt_distinct_dynamic]
    pivots: [of_case.case_status_priority_dynamic]
    sorts: [of_case.Case_Geo, of_case.case_status_priority_dynamic]
    limit: 500
    column_limit: 50
    query_timezone: UTC
    show_value_labels: true
    font_size: 12
    charts_across: 3
    hide_legend: false
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
        reverse: false
    series_colors:
      Others - of_case.escalated_case_count: "#8b908f"
      S-KAS - of_case.escalated_case_count: "#7f0b4d"
      C-KAS - of_case.escalated_case_count: "#340335"
      S-KAM - of_case.escalated_case_count: "#00506D"
      Awaiting Customer Response - of_case.case_distinct_count: "#340335"
      Awaiting Internal Team Response - of_case.case_distinct_count: "#7f0b4d"
      In Progress - of_case.case_distinct_count: "#BD0F72"
      New - of_case.case_distinct_count: "#00506D"
      Closed - of_case.case_distinct_count: "#000000"
      Resolved - of_case.case_distinct_count: "#8b908f"
      Awaiting Customer Response - of_case.case_cnt_distinct_dynamic: "#340335"
      Awaiting Internal Team Response - of_case.case_cnt_distinct_dynamic: "#7f0b4d"
      Closed - of_case.case_cnt_distinct_dynamic: "#000000"
      In Progress - of_case.case_cnt_distinct_dynamic: "#BD0F72"
      New - of_case.case_cnt_distinct_dynamic: "#00506D"
      Resolved - of_case.case_cnt_distinct_dynamic: "#8b908f"
      High - of_case.case_cnt_distinct_dynamic: "#F39200"
      Low - of_case.case_cnt_distinct_dynamic: "#00506D"
      Medium - of_case.case_cnt_distinct_dynamic: "#BD0F72"
      Urgent - of_case.case_cnt_distinct_dynamic: "#000000"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: of_case.count, id: of_case.count,
            name: Case}], showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
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
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: labels
    label_type: labVal
    inner_radius: 70
    defaults_version: 1
    show_null_points: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    note_state: collapsed
    note_display: hover
    note_text: "<P style=\"text-align:left;\"><B>Metric Name : </B>Cases by Status<BR><B>How\
      \ it Helps : </B>To evaluate number of case by Status<BR>[Number of cases with\
      \ Status tags]<BR><B>Target : </B>New: TBD In Progress: TBD Awaiting Internal\
      \ Response: TBD Awaiting Customer Response: TBD Resolved: TBD Close: TBD\t\t\
      \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"
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
      Chat Owner: of_case.ct_owner_name1
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Resolution Reason: of_case.resolution_reason
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
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
      Case status and priority: of_case.case_group_param
      First Response Time: of_case.responsetime_Param
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 38
    col: 0
    width: 12
    height: 7
  - title: Avg FRT by Location/Channel*
    name: Avg FRT by Location/Channel*
    model: oneforce_service
    explore: of_case
    type: looker_bar
    fields: [of_case.AVG_FIRST_RESPONSE_TIME_NEW, of_case.case_distinct_count, of_case.Avg_FRT_dynamic]
    filters:
      of_case.is_channel_applicable_for_FRT: 'Yes'
    sorts: [of_case.Avg_FRT_dynamic]
    limit: 500
    column_limit: 50
    query_timezone: UTC
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
    stacking: ''
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
    color_application:
      collection_id: one-theme
      palette_id: one-theme-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: of_case.case_distinct_count,
            id: of_case.case_distinct_count, name: Case}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: '', orientation: bottom,
        series: [{axisId: of_case.AVG_FIRST_RESPONSE_TIME_NEW, id: of_case.AVG_FIRST_RESPONSE_TIME_NEW,
            name: FRT (Minutes)}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}]
    size_by_field: of_queue_member.queue_size
    x_axis_zoom: true
    y_axis_zoom: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '20'
    hide_legend: false
    font_size: '12'
    label_value_format: '[>=1000000]0.0,,"M";[>=1000]0.0,"K";0'
    series_types:
      of_case.AVG_FIRST_RESPONSE_TIME_NEW: line
    series_colors:
      of_case.AVG_FIRST_RESPONSE_TIME: "#84C5C3"
      of_queue_member.queue_size: "#7f0b4d"
      of_case.case_distinct_count: "#BD0F72"
      of_case.AVG_FIRST_RESPONSE_TIME_NEW: "#84C5C3"
    series_labels:
      of_case.case_distinct_count: Case
      of_case.AVG_FIRST_RESPONSE_TIME_NEW: FRT (Minutes)
    show_null_points: false
    color_range: ["#4285F4", "#EA4335", "#FBBC04", "#34A852", "#5F6368"]
    color_by: node
    value_format_override: ''
    show_percent: true
    bar_arm_length: 25
    bar_arm_weight: 50
    bar_spinner_length: 100
    bar_spinner_weight: 50
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    hidden_fields: []
    hidden_points_if_no: []
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
    up_color: false
    down_color: false
    total_color: false
    interpolation: linear
    note_state: collapsed
    note_display: hover
    note_text: '<P style="text-align:left;"><B>Metric Name : </B>Average First Response
      Time<BR><B>How it Helps : </B>To evaluate First Response to Customers<BR>[For
      Case FRT,  it is measured from Case Creation Date/time to First Reply by CCA
      to Customer]<BR>[For Chat FRT,  the Start Time is now condition-based:<BR>If
      Customer send 1st msg, then that should be the start time<BR>If Agent sends
      a 1st msg before Customer 1st msg, then the start time should be the Automated
      Bot Greeting msg<BR>End Time is always based on:<BR>Agent’s first typed in msg
      (including “Hi” or “Hello”).]<BR><B>Target : </B>TBD'
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
      Chat Owner: of_case.ct_owner_name1
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Resolution Reason: of_case.resolution_reason
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
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
      Avg FRT by: of_case.avg_FRT_param
      First Response Time: of_case.responsetime_Param
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Case Owner: case_owner.name
      Customer Segmentation: of_customer_group.key_acct_tp_cd
    row: 6
    col: 6
    width: 9
    height: 6
  - title: FRT Chat/Web Histogram and Target Achievement Ratio (Copy)
    name: FRT Chat/Web Histogram and Target Achievement Ratio (Copy)
    model: oneforce_service
    explore: of_case
    type: looker_column
    fields: [of_case.FRT_tier_count, of_case.dynamic_FRT_tier]
    filters:
      of_case.dynamic_FRT_tier: "-Undefined,-< 0.1"
    sorts: [of_case.dynamic_FRT_tier]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: pivot_where(${of_case.dynamic_FRT_tier} = "0", null)
      label: Label
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: label
      _type_hint: 'null'
      is_disabled: true
    - category: table_calculation
      label: Target Achievement Ratio
      value_format:
      value_format_name: percent_1
      calculation_type: percent_of_column_sum
      table_calculation: target_achievement_ratio
      args:
      - of_case.FRT_tier_count
      _kind_hint: measure
      _type_hint: number
      is_disabled: true
    query_timezone: UTC
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
    y_axes: [{label: '', orientation: left, series: [{axisId: of_case.FRT_tier_count,
            id: of_case.FRT_tier_count, name: FRT Tier Count}], showLabels: false,
        showValues: false, unpinAxis: false, tickDensity: default, type: linear},
      {label: '', orientation: left, series: [{axisId: target_achievement_ratio, id: target_achievement_ratio,
            name: Target Achievement Ratio}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '1'
    series_colors:
      label: "#BD0F72"
      ">= 240.1 - 6 - of_total": "#CCD3D1"
      ">= 180.1 and < 240.1 - 5 - of_total": "#CCD3D1"
      ">= 120.1 and < 180.1 - 4 - of_total": "#CCD3D1"
      ">= 60.1 and < 120.1 - 3 - of_total": "#CCD3D1"
      ">= 30.1 and < 60.1 - 2 - of_case.FRT_tier_count": "#CCD3D1"
      ">= 30.1 and < 60.1 - 2 - of_total": "#CCD3D1"
      of_total: "#84C5C3"
      target_achievement_ratio: "#84C5C3"
    series_labels:
      ">= 0.1 and < 30.1": "0-30 sec"
      ">= 30.1 and < 60.1": "31-60 sec"
      ">= 60.1 and < 120.1": "61-120 sec"
      ">= 120.1 and < 180.1": "121-180 sec"
      ">= 180.1 and < 240.1": "181-240 sec"
      ">= 240.1": ">240 sec"

      ">= 0.1 and < 60.1": "0-60 min"
      ">= 60.1 and < 120.1": "60-120 min"
      ">= 120.1 and < 180.1": "120-180 min"
      ">= 180.1 and < 240.1": "180-240 min"
      ">= 240.1 and < 300.1": "240-300 min"
      ">= 300.1": "> 300 min"

      ">= 240.1 and < 300.1 - Web - FRT_tier_count": "240-300 min1"
      ">= 240.1 and < 300.1 - 5 - Web - of_case.dynamic_FRT_tier": "240-300 min2"


      ">= 240.1 and < 300.1 - 5 - Web - of_case.dynamic_FRT_tier": "240-300 min3"
      ">= 240.1 and < 300.1 - 5 - of_case.FRT_tier_count": "240-300 min"
      ">= 240.1 and < 300.1 - 5 - target_achievement_ratio": "240-300 min"
      "Dynamic FRT Tier &gt;= 240.1 and &lt; 300.1": "> 300 min-3"
      # Dynamic FRT Tier &gt;= 240.1 and &lt; 300.1
      # ">= 300.1 - 6 - of_case.FRT_tier_count": ">300 min"
      ">= 300.1": "> 300 min"
      ">= 300.1 - of_case.FRT_tier_count": "> 300 min-c"
      "Dynamic FRT Tier >= 300.1" : "> 300 min-a"
      "Dynamic FRT Tier >= 300.1" : "> 300 min-b"
      "FRT Tier Count - >= 300.1": "> 300 min-1"
      ">= 300.1 - of_case.FRT_tier_count": "> 300 min-2"
      
      ">= 0.1 and < 30.1 - 1 - of_case.FRT_tier_count": 0-30 sec
      ">= 30.1 and < 60.1 - 2 - of_case.FRT_tier_count": 31-60 sec
      ">= 300.1" : "> 300 min"
      "Dynamic FRT Tier - >= 300.1 - 6 - of_case.FRT_tier_count" : "> 300 min"
      "Dynamic FRT Tier - >= 300.1 - 6 - of_case.FRT_tier_count" : "> 300 min1"
      "of_case.dynamic_FRT_tier - >= 300.1 - of_case.FRT_tier_count" : "> 300 min2"
      "of_case.dynamic_FRT_tier - >= 300.1 - 6 - of_case.FRT_tier_count" : "> 300 min3"
      ">= 300.1 - 6 - of_case.dynamic_FRT_tier" : "> 300 min4"
      ">= 300.1 - of_case.dynamic_FRT_tier" : "> 300 min5"
      "Dynamic FRT Tier >= 300.1 - of_case.dynamic_FRT_tier" : "> 300 min6"
      "Dynamic FRT Tier >= 300.1 - of_case.FRT_tier_count" : "> 300 min7"
    reference_lines: []
    trend_lines: []
    column_spacing_ratio: 0.3
    column_group_spacing_ratio: 0.3
    defaults_version: 1
    hidden_pivots: {}
    hidden_fields:
    hidden_points_if_no: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      <P style="text-align:left;"><B> Magenta Bar (0-30 sec) </B> is the Chat FRT Global Target
      <P style="text-align:left;">*Recommend to zoom the screen to 100% </P>
    listen:
      Channel: of_case.origin
      Status: of_case.status
      RHQ (Case): of_case.Regional_Head_Office
      Cluster Country: of_case.case_country
      Individual Country: of_case.country
      Office (Case): of_case.case_office_code
      Initial Queue Name: of_case.Initial_Queue_Name
      Case Number: of_case.casenumber
      Chat Owner: of_case.ct_owner_name1
      Category (L2): of_case.sub_category_l2
      Topic (L3): of_case.subordinate_category_l3
      First Contact Resolution: of_case.first_contact_resolution
      Resolution Reason: of_case.resolution_reason
      Web Email: of_case.supplied_email
      Date Granularity: of_case.timeframe_picker
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
      Open Date: of_case.createddate_filter_date
      Source of Chat: of_chat_transcript.origin
      Contact Name: of_contact.name
      Role: of_escalation_history.role
      Customer: of_customer.customer_cd_and_name
      Customer Group: of_customer_group.cust_grp_and_name
      Customer Type: of_customer.customer_type
      Country (Case Owner): user_office_hierarchy.country
      RHQ (Case Owner): user_office_hierarchy.regional_head_office_short_nm
      Office (Case Owner): user_office_hierarchy.office_code
      Queue Owner Name: of_queue.developer_name
      Office Type: case_owner.officetype
      Profile: case_owner.profile_name_service
      Sales Team Member: of_sales_team_member.team_role
      Customer Segmentation: of_customer_group.key_acct_tp_cd
      FRT Histogram: of_case.FRT_selector
    row: 94
    col: 12
    width: 12
    height: 6
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
    default_value: ''
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
      options: []
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
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: case_owner.name
  - name: Chat Owner
    title: Chat Owner
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
    field: of_case.ct_owner_name1
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
  - name: Case/Chat Level
    title: Case/Chat Level
    type: field_filter
    default_value: CaseLevel
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_toggles
      display: inline
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.Volume_per_Agent_Param
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
  - name: Avg FRT by
    title: Avg FRT by
    type: field_filter
    default_value: Location
    allow_multiple_values: true
    required: false
    ui_config:
      type: radio_buttons
      display: inline
      options:
      - Location
      - Channel
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.avg_FRT_param
  - name: Case status and priority
    title: Case status and priority
    type: field_filter
    default_value: Cases by Status
    allow_multiple_values: true
    required: false
    ui_config:
      type: radio_buttons
      display: inline
      options:
      - Cases by Status
      - Open Cases by Priority
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.case_group_param
  - name: Average case by
    title: Average case by
    type: field_filter
    default_value: Distinct case owner
    allow_multiple_values: true
    required: false
    ui_config:
      type: radio_buttons
      display: inline
      options:
      - Distinct case owner
      - Total agents
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.avg_cases_param
  - name: FRT Histogram
    title: FRT Histogram
    type: field_filter
    default_value: Chat
    allow_multiple_values: true
    required: false
    ui_config:
      type: radio_buttons
      display: inline
      options:
      - Chat
      - Web
    model: oneforce_service
    explore: of_case
    listens_to_filters: []
    field: of_case.FRT_selector
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
      - 'Segment '
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
