---
- dashboard: experiments_summary_template
  title: Experiments Summary Template
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: RYT1vnAlsyn5SUUzrHgznC
  elements:
  - title: OEC - Daily Average - Treatment
    name: OEC - Daily Average - Treatment
    model: travelperk
    explore: d_experiment
    type: single_value
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.total_metric_value, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: oec
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: treatment
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
    sorts: [f_experiment_user_metrics_daily.dt_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: In-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: in_experiment_daily_average
      _type_hint: number
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="pre-experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: Pre-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: pre_experiment_daily_average
      _type_hint: number
    - category: table_calculation
      expression: |-
        (${in_experiment_daily_average}
          /
        ${pre_experiment_daily_average})

        - 1
      label: In-Experiment Change
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
      table_calculation: in_experiment_change
      _type_hint: number
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, f_experiment_user_metrics_daily.dt_date,
      f_experiment_user_metrics_daily.total_metric_value, pre_experiment_daily_average]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    defaults_version: 1
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 18
    col: 0
    width: 9
    height: 5
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"p","children":[{"text":""}],"id":"ni66q"},{"type":"h1","children":[{"text":"Overall
      Evaluation Criterion (OEC):","bold":true}],"align":"center","id":"e5pfa"},{"type":"p","children":[{"text":""}],"id":"lqx3i"},{"type":"h3","children":[{"text":"The
      key metric used to make the decision of whether the experiment is successful
      or not","italic":true,"color":"hsl(0, 0%, 44%)"}],"align":"center","id":"63hov"},{"type":"p","children":[{"text":""}],"id":"ufvxe"}]'
    rich_content_json: '{"format":"slate"}'
    row: 14
    col: 0
    width: 16
    height: 4
  - title: OEC Metric
    name: OEC Metric
    model: travelperk
    explore: d_experiment
    type: single_value
    fields: [f_experiment_user_metrics_daily.metric_name]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: oec
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: treatment
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
    sorts: [f_experiment_user_metrics_daily.metric_name]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |-
        concat(
          upper(substring(replace(${f_experiment_user_metrics_daily.metric_name},"_", " "),1,1))
          , substring(replace(${f_experiment_user_metrics_daily.metric_name},"_", " "),2,
            length(replace(${f_experiment_user_metrics_daily.metric_name},"_", " ")))
          )
      label: Metric Name
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: metric_name
      _type_hint: string
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [f_experiment_user_metrics_daily.metric_name]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    defaults_version: 1
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 14
    col: 16
    width: 8
    height: 4
  - title: OEC - Daily Average - Control
    name: OEC - Daily Average - Control
    model: travelperk
    explore: d_experiment
    type: single_value
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.total_metric_value, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: oec
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
    sorts: [f_experiment_user_metrics_daily.dt_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: In-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: in_experiment_daily_average
      _type_hint: number
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="pre-experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: Pre-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: pre_experiment_daily_average
      _type_hint: number
    - category: table_calculation
      expression: |-
        (${in_experiment_daily_average}
          /
        ${pre_experiment_daily_average})

        - 1
      label: In-Experiment Change
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
      table_calculation: in_experiment_change
      _type_hint: number
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, f_experiment_user_metrics_daily.dt_date,
      f_experiment_user_metrics_daily.total_metric_value, pre_experiment_daily_average]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: ''
    orientation: auto
    style_in_experiment_daily_average: "#626262"
    show_title_in_experiment_daily_average: true
    title_placement_in_experiment_daily_average: above
    value_format_in_experiment_daily_average: ''
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    comparison_show_label_pre_experiment_daily_average: true
    pos_is_bad_pre_experiment_daily_average: false
    comparison_label_placement_pre_experiment_daily_average: below
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    defaults_version: 1
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 23
    col: 0
    width: 9
    height: 5
  - title: OEC - Daily
    name: OEC - Daily
    model: travelperk
    explore: d_experiment
    type: looker_line
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      f_experiment_user_metrics_daily.total_metric_value, d_user_experiment_assignment.assignment]
    pivots: [d_user_experiment_assignment.assignment]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: oec
      d_user_experiment_assignment.assignment: treatment,control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
    sorts: [d_user_experiment_assignment.assignment desc, f_experiment_user_metrics_daily.dt_date
        desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: if(${f_experiment_user_metrics_daily.time_period}="experiment",(${f_experiment_user_metrics_daily.total_metric_value}),0)
      label: Experiment Period
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: experiment_period
      _type_hint: number
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    y_axes: [{label: '', orientation: left, series: [{axisId: f_experiment_user_metrics_daily.total_metric_value,
            id: treatment - f_experiment_user_metrics_daily.total_metric_value, name: treatment
              - 📈 Experiment Metrics Total Metric Value}, {axisId: f_experiment_user_metrics_daily.total_metric_value,
            id: control - f_experiment_user_metrics_daily.total_metric_value, name: control
              - 📈 Experiment Metrics Total Metric Value}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: experiment_period, id: treatment - experiment_period,
            name: treatment - Experiment Period}, {axisId: experiment_period, id: control
              - experiment_period, name: control - Experiment Period}], showLabels: false,
        showValues: false, maxValue: 0.2, minValue: 0.1, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: true
    font_size: 12px
    series_types:
      treatment - experiment_period: area
      control - experiment_period: area
    series_colors:
      weekly_difference_against_control: "#5245ed"
      experiment_period: "#9fdee0"
      treatment - f_experiment_user_metrics_daily.total_metric_value: "#5245ed"
      control - f_experiment_user_metrics_daily.total_metric_value: "#a3a3a3"
      treatment - experiment_period: "#9fdee0"
      control - experiment_period: transparent
    series_labels: {}
    label_color: []
    reference_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period]
    hidden_points_if_no: []
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 18
    col: 9
    width: 15
    height: 6
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: ' <h1 id="guardrail_metrics" style="font-size:30px; margin: 10px; color:White">
      <center> </center> </h1> '
    row: 28
    col: 0
    width: 24
    height: 2
  - name: " (3)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"p","children":[{"text":""}],"id":"wkg43"},{"type":"h1","children":[{"text":"Guardrail
      Metric 1","bold":true}],"align":"center","id":"pb2dz"},{"type":"p","children":[{"text":""}],"id":"y0svg"},{"type":"h3","children":[{"text":"These
      are important metrics that we track to make sure they don’t significantly worsen
      due to the experiment","italic":true,"color":"hsl(0, 0%, 44%)"}],"align":"center","id":"k40ta"}]'
    rich_content_json: '{"format":"slate"}'
    row: 30
    col: 0
    width: 16
    height: 4
  - title: Guardrail Metric 1
    name: Guardrail Metric 1
    model: travelperk
    explore: d_experiment
    type: single_value
    fields: [f_experiment_user_metrics_daily.metric_name]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: guardrail
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: treatment
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '1'
    sorts: [f_experiment_user_metrics_daily.metric_name]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |-
        concat(
          upper(substring(replace(${f_experiment_user_metrics_daily.metric_name},"_", " "),1,1))
          , substring(replace(${f_experiment_user_metrics_daily.metric_name},"_", " "),2,
            length(replace(${f_experiment_user_metrics_daily.metric_name},"_", " ")))
          )
      label: Metric Name
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: metric_name
      _type_hint: string
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [f_experiment_user_metrics_daily.metric_name]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    defaults_version: 1
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 30
    col: 16
    width: 8
    height: 4
  - title: Guardrail 1 - Daily Average - Treatment
    name: Guardrail 1 - Daily Average - Treatment
    model: travelperk
    explore: d_experiment
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.total_metric_value, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: guardrail
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: treatment
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '1'
    sorts: [f_experiment_user_metrics_daily.dt_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: In-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: in_experiment_daily_average
      _type_hint: number
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="pre-experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: Pre-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: pre_experiment_daily_average
      _type_hint: number
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, f_experiment_user_metrics_daily.dt_date,
      f_experiment_user_metrics_daily.total_metric_value]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: ''
    orientation: auto
    style_in_experiment_daily_average: "#776fdf"
    show_title_in_experiment_daily_average: true
    title_placement_in_experiment_daily_average: above
    value_format_in_experiment_daily_average: ''
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    comparison_show_label_pre_experiment_daily_average: true
    pos_is_bad_pre_experiment_daily_average: false
    comparison_label_placement_pre_experiment_daily_average: below
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 34
    col: 0
    width: 9
    height: 4
  - title: Guardrail 1 - Weekly Diff vs Control
    name: Guardrail 1 - Weekly Diff vs Control
    model: travelperk
    explore: d_experiment
    type: looker_column
    fields: [f_experiment_user_metrics_daily.dt_week, f_experiment_user_metrics_daily.metric_name,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format, f_experiment_user_metrics_daily.total_metric_value,
      d_user_experiment_assignment.assignment, d_experiment.experiment_start_date]
    pivots: [d_user_experiment_assignment.assignment]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: guardrail
      d_user_experiment_assignment.assignment: treatment,control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '1'
    sorts: [d_user_experiment_assignment.assignment desc, f_experiment_user_metrics_daily.dt_week]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: pivot_where(${d_user_experiment_assignment.assignment}="treatment",${f_experiment_user_metrics_daily.total_metric_value})
        - pivot_where(${d_user_experiment_assignment.assignment}="control",${f_experiment_user_metrics_daily.total_metric_value})
      label: Weekly Difference Against Control
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: weekly_difference_against_control
      _type_hint: number
    - category: table_calculation
      expression: if(${f_experiment_user_metrics_daily.dt_week}>=${d_experiment.experiment_start_date},sum(pivot_row(${f_experiment_user_metrics_daily.total_metric_value})),0)
      label: Experiment Period
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: experiment_period
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: weekly_difference_against_control,
            id: weekly_difference_against_control, name: Weekly Difference Against
              Control}], showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: '', orientation: right, series: [
          {axisId: experiment_period, id: experiment_period, name: Experiment Period}],
        showLabels: false, showValues: false, maxValue: 0.2, minValue: 0.1, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    font_size: 16px
    series_types:
      experiment_period: area
    series_colors:
      weekly_difference_against_control: "#776fdf"
      experiment_period: "#9fdee0"
    series_labels: {}
    label_color: ["#ffffff", transparent]
    reference_lines: []
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.total_metric_value, d_experiment.experiment_start_date]
    hidden_points_if_no: []
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 38
    col: 0
    width: 9
    height: 5
  - title: Guardrail 1 - Daily Average - Control
    name: Guardrail 1 - Daily Average - Control
    model: travelperk
    explore: d_experiment
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.total_metric_value, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: guardrail
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '1'
    sorts: [f_experiment_user_metrics_daily.dt_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: In-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: in_experiment_daily_average
      _type_hint: number
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="pre-experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: Pre-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: pre_experiment_daily_average
      _type_hint: number
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, f_experiment_user_metrics_daily.dt_date,
      f_experiment_user_metrics_daily.total_metric_value]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: ''
    orientation: auto
    style_in_experiment_daily_average: "#626262"
    show_title_in_experiment_daily_average: true
    title_placement_in_experiment_daily_average: above
    value_format_in_experiment_daily_average: ''
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    comparison_show_label_pre_experiment_daily_average: true
    pos_is_bad_pre_experiment_daily_average: false
    comparison_label_placement_pre_experiment_daily_average: below
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 43
    col: 0
    width: 9
    height: 4
  - name: " (4)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: ''
    row: 47
    col: 0
    width: 24
    height: 1
  - name: " (Copy)"
    type: text
    title_text: " (Copy)"
    subtitle_text: ''
    body_text: '[{"type":"p","children":[{"text":""}],"id":"wkg43"},{"type":"h1","children":[{"text":"Guardrail
      Metric 2","bold":true}],"align":"center","id":"pb2dz"},{"type":"p","children":[{"text":""}],"id":"y0svg"},{"type":"h3","children":[{"text":"These
      are important metrics that we track to make sure they don’t significantly worsen
      due to the experiment","italic":true,"color":"hsl(0, 0%, 44%)"}],"align":"center","id":"k40ta"}]'
    rich_content_json: '{"format":"slate"}'
    row: 48
    col: 0
    width: 16
    height: 4
  - title: Guardrail Metric 2
    name: Guardrail Metric 2
    model: travelperk
    explore: d_experiment
    type: single_value
    fields: [f_experiment_user_metrics_daily.metric_name]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: guardrail
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: treatment
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '2'
    sorts: [f_experiment_user_metrics_daily.metric_name]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |-
        concat(
          upper(substring(replace(${f_experiment_user_metrics_daily.metric_name},"_", " "),1,1))
          , substring(replace(${f_experiment_user_metrics_daily.metric_name},"_", " "),2,
            length(replace(${f_experiment_user_metrics_daily.metric_name},"_", " ")))
          )
      label: Metric Name
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: metric_name
      _type_hint: string
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [f_experiment_user_metrics_daily.metric_name]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    defaults_version: 1
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 48
    col: 16
    width: 8
    height: 4
  - title: Guardrail 1 - Daily
    name: Guardrail 1 - Daily
    model: travelperk
    explore: d_experiment
    type: looker_column
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      f_experiment_user_metrics_daily.total_metric_value, d_user_experiment_assignment.assignment]
    pivots: [d_user_experiment_assignment.assignment]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: guardrail
      d_user_experiment_assignment.assignment: treatment,control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '1'
    sorts: [d_user_experiment_assignment.assignment desc, f_experiment_user_metrics_daily.dt_date
        desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: if(${f_experiment_user_metrics_daily.time_period}="experiment",(${f_experiment_user_metrics_daily.total_metric_value}),0)
      label: Experiment Period
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: experiment_period
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
    trellis: pivot
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: f_experiment_user_metrics_daily.total_metric_value,
            id: treatment - f_experiment_user_metrics_daily.total_metric_value, name: treatment
              - 📈 Experiment Metrics Total Metric Value}, {axisId: f_experiment_user_metrics_daily.total_metric_value,
            id: control - f_experiment_user_metrics_daily.total_metric_value, name: control
              - 📈 Experiment Metrics Total Metric Value}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: experiment_period, id: treatment - experiment_period,
            name: treatment - Experiment Period}, {axisId: experiment_period, id: control
              - experiment_period, name: control - Experiment Period}], showLabels: false,
        showValues: false, maxValue: 0.2, minValue: 0.1, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: true
    font_size: 12px
    series_types:
      experiment_period: area
      treatment - experiment_period: area
      control - experiment_period: area
    series_colors:
      weekly_difference_against_control: "#5245ed"
      experiment_period: "#9fdee0"
      treatment - f_experiment_user_metrics_daily.total_metric_value: "#776fdf"
      control - f_experiment_user_metrics_daily.total_metric_value: "#a3a3a3"
      treatment - experiment_period: "#9fdee0"
      control - experiment_period: "#9fdee0"
    series_labels: {}
    label_color: []
    reference_lines: []
    show_null_points: true
    interpolation: linear
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period]
    hidden_points_if_no: []
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 34
    col: 9
    width: 15
    height: 13
  - name: " (5)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: ''
    row: 65
    col: 0
    width: 24
    height: 1
  - name: " (Copy 3)"
    type: text
    title_text: " (Copy 3)"
    subtitle_text: ''
    body_text: '[{"type":"p","children":[{"text":""}],"id":"wkg43"},{"type":"h1","children":[{"text":"Guardrail
      Metric 3","bold":true}],"align":"center","id":"pb2dz"},{"type":"p","children":[{"text":""}],"id":"y0svg"},{"type":"h3","children":[{"text":"These
      are important metrics that we track to make sure they don’t significantly worsen
      due to the experiment","italic":true,"color":"hsl(0, 0%, 44%)"}],"align":"center","id":"k40ta"}]'
    rich_content_json: '{"format":"slate"}'
    row: 66
    col: 0
    width: 16
    height: 4
  - title: Guardrail 2 - Daily Average - Treatment
    name: Guardrail 2 - Daily Average - Treatment
    model: travelperk
    explore: d_experiment
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.total_metric_value, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: guardrail
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: treatment
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '2'
    sorts: [f_experiment_user_metrics_daily.dt_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: In-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: in_experiment_daily_average
      _type_hint: number
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="pre-experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: Pre-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: pre_experiment_daily_average
      _type_hint: number
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, f_experiment_user_metrics_daily.dt_date,
      f_experiment_user_metrics_daily.total_metric_value]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: ''
    orientation: auto
    style_in_experiment_daily_average: "#776fdf"
    show_title_in_experiment_daily_average: true
    title_placement_in_experiment_daily_average: above
    value_format_in_experiment_daily_average: ''
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    comparison_show_label_pre_experiment_daily_average: true
    pos_is_bad_pre_experiment_daily_average: false
    comparison_label_placement_pre_experiment_daily_average: below
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 52
    col: 0
    width: 9
    height: 4
  - title: Guardrail 2 - Weekly Diff vs Control
    name: Guardrail 2 - Weekly Diff vs Control
    model: travelperk
    explore: d_experiment
    type: looker_column
    fields: [f_experiment_user_metrics_daily.dt_week, f_experiment_user_metrics_daily.metric_name,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format, f_experiment_user_metrics_daily.total_metric_value,
      d_user_experiment_assignment.assignment, d_experiment.experiment_start_date]
    pivots: [d_user_experiment_assignment.assignment]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: guardrail
      d_user_experiment_assignment.assignment: treatment,control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '2'
    sorts: [d_user_experiment_assignment.assignment desc, f_experiment_user_metrics_daily.dt_week]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: pivot_where(${d_user_experiment_assignment.assignment}="treatment",${f_experiment_user_metrics_daily.total_metric_value})
        - pivot_where(${d_user_experiment_assignment.assignment}="control",${f_experiment_user_metrics_daily.total_metric_value})
      label: Weekly Difference Against Control
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: weekly_difference_against_control
      _type_hint: number
    - category: table_calculation
      expression: if(${f_experiment_user_metrics_daily.dt_week}>=${d_experiment.experiment_start_date},sum(pivot_row(${f_experiment_user_metrics_daily.total_metric_value})),0)
      label: Experiment Period
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: experiment_period
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: weekly_difference_against_control,
            id: weekly_difference_against_control, name: Weekly Difference Against
              Control}], showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: '', orientation: right, series: [
          {axisId: experiment_period, id: experiment_period, name: Experiment Period}],
        showLabels: false, showValues: false, maxValue: 0.2, minValue: 0.1, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    font_size: 16px
    series_types:
      experiment_period: area
    series_colors:
      weekly_difference_against_control: "#776fdf"
      experiment_period: "#9fdee0"
    series_labels: {}
    label_color: ["#ffffff", transparent]
    reference_lines: []
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.total_metric_value, d_experiment.experiment_start_date]
    hidden_points_if_no: []
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 56
    col: 0
    width: 9
    height: 5
  - title: Guardrail 2 - Daily
    name: Guardrail 2 - Daily
    model: travelperk
    explore: d_experiment
    type: looker_column
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      f_experiment_user_metrics_daily.total_metric_value, d_user_experiment_assignment.assignment]
    pivots: [d_user_experiment_assignment.assignment]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: guardrail
      d_user_experiment_assignment.assignment: treatment,control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '2'
    sorts: [d_user_experiment_assignment.assignment desc, f_experiment_user_metrics_daily.dt_date
        desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: if(${f_experiment_user_metrics_daily.time_period}="experiment",(${f_experiment_user_metrics_daily.total_metric_value}),0)
      label: Experiment Period
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: experiment_period
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
    trellis: pivot
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: f_experiment_user_metrics_daily.total_metric_value,
            id: treatment - f_experiment_user_metrics_daily.total_metric_value, name: treatment
              - 📈 Experiment Metrics Total Metric Value}, {axisId: f_experiment_user_metrics_daily.total_metric_value,
            id: control - f_experiment_user_metrics_daily.total_metric_value, name: control
              - 📈 Experiment Metrics Total Metric Value}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: experiment_period, id: treatment - experiment_period,
            name: treatment - Experiment Period}, {axisId: experiment_period, id: control
              - experiment_period, name: control - Experiment Period}], showLabels: false,
        showValues: false, maxValue: 0.2, minValue: 0.1, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: true
    font_size: 12px
    series_types:
      experiment_period: area
      treatment - experiment_period: area
      control - experiment_period: area
    series_colors:
      weekly_difference_against_control: "#5245ed"
      experiment_period: "#9fdee0"
      treatment - f_experiment_user_metrics_daily.total_metric_value: "#776fdf"
      control - f_experiment_user_metrics_daily.total_metric_value: "#a3a3a3"
      treatment - experiment_period: "#9fdee0"
      control - experiment_period: "#9fdee0"
    series_labels: {}
    label_color: []
    reference_lines: []
    show_null_points: true
    interpolation: linear
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period]
    hidden_points_if_no: []
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 52
    col: 9
    width: 15
    height: 13
  - title: Guardrail 2 - Daily Average - Control
    name: Guardrail 2 - Daily Average - Control
    model: travelperk
    explore: d_experiment
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.total_metric_value, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: guardrail
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '2'
    sorts: [f_experiment_user_metrics_daily.dt_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: In-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: in_experiment_daily_average
      _type_hint: number
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="pre-experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: Pre-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: pre_experiment_daily_average
      _type_hint: number
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, f_experiment_user_metrics_daily.dt_date,
      f_experiment_user_metrics_daily.total_metric_value]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: ''
    orientation: auto
    style_in_experiment_daily_average: "#626262"
    show_title_in_experiment_daily_average: true
    title_placement_in_experiment_daily_average: above
    value_format_in_experiment_daily_average: ''
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    comparison_show_label_pre_experiment_daily_average: true
    pos_is_bad_pre_experiment_daily_average: false
    comparison_label_placement_pre_experiment_daily_average: below
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 61
    col: 0
    width: 9
    height: 4
  - title: Guardrail Metric 3
    name: Guardrail Metric 3
    model: travelperk
    explore: d_experiment
    type: single_value
    fields: [f_experiment_user_metrics_daily.metric_name]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: guardrail
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: treatment
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '3'
    sorts: [f_experiment_user_metrics_daily.metric_name]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |-
        concat(
          upper(substring(replace(${f_experiment_user_metrics_daily.metric_name},"_", " "),1,1))
          , substring(replace(${f_experiment_user_metrics_daily.metric_name},"_", " "),2,
            length(replace(${f_experiment_user_metrics_daily.metric_name},"_", " ")))
          )
      label: Metric Name
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: metric_name
      _type_hint: string
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [f_experiment_user_metrics_daily.metric_name]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    defaults_version: 1
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 66
    col: 16
    width: 8
    height: 4
  - title: Guardrail 3 - Daily Average - Treatment
    name: Guardrail 3 - Daily Average - Treatment
    model: travelperk
    explore: d_experiment
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.total_metric_value, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: guardrail
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: treatment
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '3'
    sorts: [f_experiment_user_metrics_daily.dt_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: In-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: in_experiment_daily_average
      _type_hint: number
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="pre-experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: Pre-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: pre_experiment_daily_average
      _type_hint: number
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, f_experiment_user_metrics_daily.dt_date,
      f_experiment_user_metrics_daily.total_metric_value]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: ''
    orientation: auto
    style_in_experiment_daily_average: "#776fdf"
    show_title_in_experiment_daily_average: true
    title_placement_in_experiment_daily_average: above
    value_format_in_experiment_daily_average: ''
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    comparison_show_label_pre_experiment_daily_average: true
    pos_is_bad_pre_experiment_daily_average: false
    comparison_label_placement_pre_experiment_daily_average: below
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 70
    col: 0
    width: 9
    height: 4
  - name: " (6)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<div style=\"border-bottom: solid 1px #133097;\">\n    \n    </div>\n\
      <div>\n    <nav style=\"font-size: 18px; padding: 0px 10px 10 10px; height:\
      \ 60px;\">\n    <div style=\"margin-right: 3px; padding: 5px 15px; float: left;\
      \ line-height: 30px;\" >Sections:</div>\n      <a style=\"margin-right: 3px;\
      \ padding: 5px 15px; border-bottom: solid 1px #133097; border-left: solid 1px\
      \ #133097; border-right: solid 1px #133097; border-radius: 0px 0px 5px 5px;\
      \ float: left; line-height: 30px;background-color: honeydew; color: #000000;\"\
      \ href=\"#overall_evaluation_criterion\"> \U0001f9ea Overall Evaluation Criterion\
      \ </a>\n      <a style=\"margin-right: 3px; padding: 5px 15px; border-bottom:\
      \ solid 1px #133097; border-left: solid 1px #133097; border-right: solid 1px\
      \ #133097; border-radius: 0px 0px 5px 5px; float: left; line-height: 30px; background-color:\
      \ cornsilk; color: #000000;\" href=\"#guardrail_metrics\"> \U0001f6a7 Guardrail\
      \ Metrics </a>\n      <a style=\"margin-right: 3px; padding: 5px 15px; border-bottom:\
      \ solid 1px #133097; border-left: solid 1px #133097; border-right: solid 1px\
      \ #133097; border-radius: 0px 0px 5px 5px; float: left; line-height: 30px;background-color:\
      \ lightcyan; color: #000000;\" href=\"#expected_impact_metrics\"> \U0001f3a2\
      \  Expected Impact Metrics </a>\n          <a style=\"margin-right: 3px; padding:\
      \ 5px 15px; border-bottom: solid 1px #133097; border-left: solid 1px #133097;\
      \ border-right: solid 1px #133097; border-radius: 0px 0px 5px 5px; float: left;\
      \ line-height: 30px;background-color: lavender; color: #000000;\" href=\"#monitoring_metrics\"\
      >  \U0001f52d Monitoring Metrics </a>\n  \n    </nav>\n    \n    </div>"
    row: 11
    col: 0
    width: 24
    height: 2
  - title: Guardrail 3 - Weekly Diff vs Control
    name: Guardrail 3 - Weekly Diff vs Control
    model: travelperk
    explore: d_experiment
    type: looker_column
    fields: [f_experiment_user_metrics_daily.dt_week, f_experiment_user_metrics_daily.metric_name,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format, f_experiment_user_metrics_daily.total_metric_value,
      d_user_experiment_assignment.assignment, d_experiment.experiment_start_date]
    pivots: [d_user_experiment_assignment.assignment]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: guardrail
      d_user_experiment_assignment.assignment: treatment,control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '3'
    sorts: [d_user_experiment_assignment.assignment desc, f_experiment_user_metrics_daily.dt_week]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: pivot_where(${d_user_experiment_assignment.assignment}="treatment",${f_experiment_user_metrics_daily.total_metric_value})
        - pivot_where(${d_user_experiment_assignment.assignment}="control",${f_experiment_user_metrics_daily.total_metric_value})
      label: Weekly Difference Against Control
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: weekly_difference_against_control
      _type_hint: number
    - category: table_calculation
      expression: if(${f_experiment_user_metrics_daily.dt_week}>=${d_experiment.experiment_start_date},sum(pivot_row(${f_experiment_user_metrics_daily.total_metric_value})),0)
      label: Experiment Period
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: experiment_period
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: weekly_difference_against_control,
            id: weekly_difference_against_control, name: Weekly Difference Against
              Control}], showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: '', orientation: right, series: [
          {axisId: experiment_period, id: experiment_period, name: Experiment Period}],
        showLabels: false, showValues: false, maxValue: 0.2, minValue: 0.1, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    font_size: 16px
    series_types:
      experiment_period: area
    series_colors:
      weekly_difference_against_control: "#776fdf"
      experiment_period: "#9fdee0"
    series_labels: {}
    label_color: ["#ffffff", transparent]
    reference_lines: []
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.total_metric_value, d_experiment.experiment_start_date]
    hidden_points_if_no: []
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 74
    col: 0
    width: 9
    height: 5
  - title: Guardrail 3 - Daily Average - Control
    name: Guardrail 3 - Daily Average - Control
    model: travelperk
    explore: d_experiment
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.total_metric_value, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: guardrail
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '3'
    sorts: [f_experiment_user_metrics_daily.dt_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: In-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: in_experiment_daily_average
      _type_hint: number
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="pre-experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: Pre-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: pre_experiment_daily_average
      _type_hint: number
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, f_experiment_user_metrics_daily.dt_date,
      f_experiment_user_metrics_daily.total_metric_value]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: ''
    orientation: auto
    style_in_experiment_daily_average: "#626262"
    show_title_in_experiment_daily_average: true
    title_placement_in_experiment_daily_average: above
    value_format_in_experiment_daily_average: ''
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    comparison_show_label_pre_experiment_daily_average: true
    pos_is_bad_pre_experiment_daily_average: false
    comparison_label_placement_pre_experiment_daily_average: below
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 79
    col: 0
    width: 9
    height: 4
  - title: Guardrail 3 - Daily
    name: Guardrail 3 - Daily
    model: travelperk
    explore: d_experiment
    type: looker_column
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      f_experiment_user_metrics_daily.total_metric_value, d_user_experiment_assignment.assignment]
    pivots: [d_user_experiment_assignment.assignment]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: guardrail
      d_user_experiment_assignment.assignment: treatment,control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '3'
    sorts: [d_user_experiment_assignment.assignment desc, f_experiment_user_metrics_daily.dt_date
        desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: if(${f_experiment_user_metrics_daily.time_period}="experiment",(${f_experiment_user_metrics_daily.total_metric_value}),0)
      label: Experiment Period
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: experiment_period
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
    trellis: pivot
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: f_experiment_user_metrics_daily.total_metric_value,
            id: treatment - f_experiment_user_metrics_daily.total_metric_value, name: treatment
              - 📈 Experiment Metrics Total Metric Value}, {axisId: f_experiment_user_metrics_daily.total_metric_value,
            id: control - f_experiment_user_metrics_daily.total_metric_value, name: control
              - 📈 Experiment Metrics Total Metric Value}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: experiment_period, id: treatment - experiment_period,
            name: treatment - Experiment Period}, {axisId: experiment_period, id: control
              - experiment_period, name: control - Experiment Period}], showLabels: false,
        showValues: false, maxValue: 0.2, minValue: 0.1, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: true
    font_size: 12px
    series_types:
      experiment_period: area
      treatment - experiment_period: area
      control - experiment_period: area
    series_colors:
      weekly_difference_against_control: "#5245ed"
      experiment_period: "#9fdee0"
      treatment - f_experiment_user_metrics_daily.total_metric_value: "#776fdf"
      control - f_experiment_user_metrics_daily.total_metric_value: "#a3a3a3"
      treatment - experiment_period: "#9fdee0"
      control - experiment_period: "#9fdee0"
    series_labels: {}
    label_color: []
    reference_lines: []
    show_null_points: true
    interpolation: linear
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period]
    hidden_points_if_no: []
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 70
    col: 9
    width: 15
    height: 13
  - name: " (7)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: ' <h1 id="overall_evaluation_criterion" style="font-size:30px; margin:
      10px; color:White"> <center> </center> </h1> '
    row: 13
    col: 0
    width: 24
    height: 1
  - name: " (8)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "  <h1 style=\"font-size:30px; margin: 10px; background-color:honeydew;\"\
      > <center> \U0001f9ea Experiment Dashboard </center> </h1> \n\n\n <h1 style=\"\
      font-size:35px; margin: 10px;\"> </h1> \n\n <h1 style=\"font-size:20px; margin:\
      \ 0px; background-color:whitesmoke;\"> \n<i> <center> Please revise the <a href=\"\
      link_to_documentation\"\
      > Experiment Documentation </a> on Notion before interpreting results below.\
      \ </center></i> </h1>"
    row: 0
    col: 0
    width: 11
    height: 4
  - title: Experiment Name
    name: Experiment Name
    model: travelperk
    explore: d_experiment
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [d_experiment.experiment_id, d_experiment.experiment_name, d_experiment.experiment_description]
    filters:
      d_experiment.experiment_id: PEEK-1
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |-
        concat(
          ${d_experiment.experiment_id}
          , ": "
          , upper(substring(replace(${d_experiment.experiment_name},"_", " "),1,1))
          , substring(replace(${d_experiment.experiment_name},"_", " "),2,
            length(replace(${d_experiment.experiment_name},"_", " ")))
          )
      label: Experiment Name
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: experiment_name
      _type_hint: string
    - category: table_calculation
      expression: "${d_experiment.experiment_description}"
      label: Description
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: description
      _type_hint: string
    hidden_fields: [d_experiment.experiment_id, d_experiment.experiment_name, d_experiment.experiment_description]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    show_title_experiment_name: false
    show_comparison_description: true
    comparison_style_description: value
    comparison_show_label_description: false
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    y_axes: []
    title_hidden: true
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 0
    col: 11
    width: 7
    height: 4
  - name: " (9)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: ' <h1 id="expected_impact_metrics" style="font-size:30px; margin: 10px;
      color:White"> <center> </center> </h1> '
    row: 83
    col: 0
    width: 24
    height: 2
  - name: " (Copy 2)"
    type: text
    title_text: " (Copy 2)"
    subtitle_text: ''
    body_text: '[{"type":"p","children":[{"text":""}],"id":"wkg43"},{"type":"h1","children":[{"text":"Expected
      Impact Metric 1","bold":true}],"align":"center","id":"pb2dz"},{"type":"p","children":[{"text":""}],"id":"y0svg"},{"type":"h3","align":"center","children":[{"text":"These
      represent potential changes in measurements due to the change but ","italic":true,"color":"hsl(0,
      0%, 44%)"},{"text":"should not block","italic":true,"bold":true,"color":"hsl(0,
      0%, 44%)"},{"text":" the implementation.","italic":true,"color":"hsl(0, 0%,
      44%)"}],"id":"4knqb"}]'
    rich_content_json: '{"format":"slate"}'
    row: 85
    col: 0
    width: 16
    height: 4
  - title: Expected Impact Metric 1
    name: Expected Impact Metric 1
    model: travelperk
    explore: d_experiment
    type: single_value
    fields: [f_experiment_user_metrics_daily.metric_name]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: '"expected_impact"'
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: treatment
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '1'
    sorts: [f_experiment_user_metrics_daily.metric_name]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |-
        concat(
          upper(substring(replace(${f_experiment_user_metrics_daily.metric_name},"_", " "),1,1))
          , substring(replace(${f_experiment_user_metrics_daily.metric_name},"_", " "),2,
            length(replace(${f_experiment_user_metrics_daily.metric_name},"_", " ")))
          )
      label: Metric Name
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: metric_name
      _type_hint: string
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [f_experiment_user_metrics_daily.metric_name]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    defaults_version: 1
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 85
    col: 16
    width: 8
    height: 4
  - title: Expected Impact 1 - Daily
    name: Expected Impact 1 - Daily
    model: travelperk
    explore: d_experiment
    type: looker_column
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      f_experiment_user_metrics_daily.total_metric_value, d_user_experiment_assignment.assignment]
    pivots: [d_user_experiment_assignment.assignment]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: '"expected_impact"'
      d_user_experiment_assignment.assignment: treatment,control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '1'
    sorts: [d_user_experiment_assignment.assignment desc, f_experiment_user_metrics_daily.dt_date
        desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: if(${f_experiment_user_metrics_daily.time_period}="experiment",(${f_experiment_user_metrics_daily.total_metric_value}),0)
      label: Experiment Period
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: experiment_period
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
    trellis: pivot
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: f_experiment_user_metrics_daily.total_metric_value,
            id: treatment - f_experiment_user_metrics_daily.total_metric_value, name: treatment
              - 📈 Experiment Metrics Total Metric Value}, {axisId: f_experiment_user_metrics_daily.total_metric_value,
            id: control - f_experiment_user_metrics_daily.total_metric_value, name: control
              - 📈 Experiment Metrics Total Metric Value}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: experiment_period, id: treatment - experiment_period,
            name: treatment - Experiment Period}, {axisId: experiment_period, id: control
              - experiment_period, name: control - Experiment Period}], showLabels: false,
        showValues: false, maxValue: 0.2, minValue: 0.1, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: true
    font_size: 12px
    series_types:
      experiment_period: area
      treatment - experiment_period: area
      control - experiment_period: area
    series_colors:
      weekly_difference_against_control: "#5245ed"
      experiment_period: "#9fdee0"
      treatment - f_experiment_user_metrics_daily.total_metric_value: "#776fdf"
      control - f_experiment_user_metrics_daily.total_metric_value: "#a3a3a3"
      treatment - experiment_period: "#9fdee0"
      control - experiment_period: "#9fdee0"
    series_labels: {}
    label_color: []
    reference_lines: []
    show_null_points: true
    interpolation: linear
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period]
    hidden_points_if_no: []
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 89
    col: 9
    width: 15
    height: 13
  - title: Expected Impact 1 - Daily Average - Treatment
    name: Expected Impact 1 - Daily Average - Treatment
    model: travelperk
    explore: d_experiment
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.total_metric_value, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: '"expected_impact"'
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: treatment
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '1'
    sorts: [f_experiment_user_metrics_daily.dt_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: In-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: in_experiment_daily_average
      _type_hint: number
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="pre-experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: Pre-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: pre_experiment_daily_average
      _type_hint: number
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, f_experiment_user_metrics_daily.dt_date,
      f_experiment_user_metrics_daily.total_metric_value]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: ''
    orientation: auto
    style_in_experiment_daily_average: "#776fdf"
    show_title_in_experiment_daily_average: true
    title_placement_in_experiment_daily_average: above
    value_format_in_experiment_daily_average: ''
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    comparison_show_label_pre_experiment_daily_average: true
    pos_is_bad_pre_experiment_daily_average: false
    comparison_label_placement_pre_experiment_daily_average: below
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 89
    col: 0
    width: 9
    height: 4
  - title: Expected Impact 1 - Weekly Diff vs Control
    name: Expected Impact 1 - Weekly Diff vs Control
    model: travelperk
    explore: d_experiment
    type: looker_column
    fields: [f_experiment_user_metrics_daily.dt_week, f_experiment_user_metrics_daily.metric_name,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format, f_experiment_user_metrics_daily.total_metric_value,
      d_user_experiment_assignment.assignment, d_experiment.experiment_start_date]
    pivots: [d_user_experiment_assignment.assignment]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: '"expected_impact"'
      d_user_experiment_assignment.assignment: treatment,control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '1'
    sorts: [d_user_experiment_assignment.assignment desc, f_experiment_user_metrics_daily.dt_week]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: pivot_where(${d_user_experiment_assignment.assignment}="treatment",${f_experiment_user_metrics_daily.total_metric_value})
        - pivot_where(${d_user_experiment_assignment.assignment}="control",${f_experiment_user_metrics_daily.total_metric_value})
      label: Weekly Difference Against Control
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: weekly_difference_against_control
      _type_hint: number
    - category: table_calculation
      expression: if(${f_experiment_user_metrics_daily.dt_week}>=${d_experiment.experiment_start_date},sum(pivot_row(${f_experiment_user_metrics_daily.total_metric_value})),0)
      label: Experiment Period
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: experiment_period
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: weekly_difference_against_control,
            id: weekly_difference_against_control, name: Weekly Difference Against
              Control}], showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: '', orientation: right, series: [
          {axisId: experiment_period, id: experiment_period, name: Experiment Period}],
        showLabels: false, showValues: false, maxValue: 0.2, minValue: 0.1, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    font_size: 16px
    series_types:
      experiment_period: area
    series_colors:
      weekly_difference_against_control: "#776fdf"
      experiment_period: "#9fdee0"
    series_labels: {}
    label_color: ["#ffffff", transparent]
    reference_lines: []
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.total_metric_value, d_experiment.experiment_start_date]
    hidden_points_if_no: []
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 93
    col: 0
    width: 9
    height: 5
  - name: " (10)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: ' <h1 id="monitoring_metrics" style="font-size:30px; margin: 10px;
      color:White"> <center> </center> </h1> '
    row: 102
    col: 0
    width: 24
    height: 2
  - title: Expected Impact 1 - Daily Average - Control
    name: Expected Impact 1 - Daily Average - Control
    model: travelperk
    explore: d_experiment
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.total_metric_value, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: '"expected_impact"'
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '1'
    sorts: [f_experiment_user_metrics_daily.dt_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: In-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: in_experiment_daily_average
      _type_hint: number
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="pre-experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: Pre-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: pre_experiment_daily_average
      _type_hint: number
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, f_experiment_user_metrics_daily.dt_date,
      f_experiment_user_metrics_daily.total_metric_value]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: ''
    orientation: auto
    style_in_experiment_daily_average: "#626262"
    show_title_in_experiment_daily_average: true
    title_placement_in_experiment_daily_average: above
    value_format_in_experiment_daily_average: ''
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    comparison_show_label_pre_experiment_daily_average: true
    pos_is_bad_pre_experiment_daily_average: false
    comparison_label_placement_pre_experiment_daily_average: below
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 98
    col: 0
    width: 9
    height: 4
  - name: " (Copy 4)"
    type: text
    title_text: " (Copy 4)"
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Monitoring Metrics 1","bold":true}],"align":"center","id":"ojuru"},{"type":"p","children":[{"text":""}],"id":"jgw9e"},{"type":"h3","align":"center","children":[{"text":"These
      are metrics whose evolution we are interested in monitoring, but over whose
      change we cannot compute statistic significance (as it would take too long to
      collect significant results). They are included for additional context but not
      for decision making.","italic":true,"color":"hsl(0, 0%, 44%)"}],"id":"fmi33"}]'
    rich_content_json: '{"format":"slate"}'
    row: 104
    col: 0
    width: 16
    height: 4
  - title: Monitoring Metric 1
    name: Monitoring Metric 1
    model: travelperk
    explore: d_experiment
    type: single_value
    fields: [f_experiment_user_metrics_daily.metric_name]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: monitoring
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: treatment
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '1'
    sorts: [f_experiment_user_metrics_daily.metric_name]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |-
        concat(
          upper(substring(replace(${f_experiment_user_metrics_daily.metric_name},"_", " "),1,1))
          , substring(replace(${f_experiment_user_metrics_daily.metric_name},"_", " "),2,
            length(replace(${f_experiment_user_metrics_daily.metric_name},"_", " ")))
          )
      label: Metric Name
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: metric_name
      _type_hint: string
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [f_experiment_user_metrics_daily.metric_name]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    defaults_version: 1
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 104
    col: 16
    width: 8
    height: 4
  - title: Monitoring 1 - Daily Average - Treatment
    name: Monitoring 1 - Daily Average - Treatment
    model: travelperk
    explore: d_experiment
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.total_metric_value, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: monitoring
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: treatment
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '1'
    sorts: [f_experiment_user_metrics_daily.dt_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: In-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: in_experiment_daily_average
      _type_hint: number
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="pre-experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: Pre-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: pre_experiment_daily_average
      _type_hint: number
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, f_experiment_user_metrics_daily.dt_date,
      f_experiment_user_metrics_daily.total_metric_value]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: ''
    orientation: auto
    style_in_experiment_daily_average: "#776fdf"
    show_title_in_experiment_daily_average: true
    title_placement_in_experiment_daily_average: above
    value_format_in_experiment_daily_average: ''
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    comparison_show_label_pre_experiment_daily_average: true
    pos_is_bad_pre_experiment_daily_average: false
    comparison_label_placement_pre_experiment_daily_average: below
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 108
    col: 0
    width: 9
    height: 4
  - title: Monitoring 1 - Weekly Diff vs Control
    name: Monitoring 1 - Weekly Diff vs Control
    model: travelperk
    explore: d_experiment
    type: looker_column
    fields: [f_experiment_user_metrics_daily.dt_week, f_experiment_user_metrics_daily.metric_name,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format, f_experiment_user_metrics_daily.total_metric_value,
      d_user_experiment_assignment.assignment, d_experiment.experiment_start_date]
    pivots: [d_user_experiment_assignment.assignment]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: monitoring
      d_user_experiment_assignment.assignment: treatment,control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '1'
    sorts: [d_user_experiment_assignment.assignment desc, f_experiment_user_metrics_daily.dt_week]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: pivot_where(${d_user_experiment_assignment.assignment}="treatment",${f_experiment_user_metrics_daily.total_metric_value})
        - pivot_where(${d_user_experiment_assignment.assignment}="control",${f_experiment_user_metrics_daily.total_metric_value})
      label: Weekly Difference Against Control
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: weekly_difference_against_control
      _type_hint: number
    - category: table_calculation
      expression: if(${f_experiment_user_metrics_daily.dt_week}>=${d_experiment.experiment_start_date},sum(pivot_row(${f_experiment_user_metrics_daily.total_metric_value})),0)
      label: Experiment Period
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: experiment_period
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: weekly_difference_against_control,
            id: weekly_difference_against_control, name: Weekly Difference Against
              Control}], showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: '', orientation: right, series: [
          {axisId: experiment_period, id: experiment_period, name: Experiment Period}],
        showLabels: false, showValues: false, maxValue: 0.2, minValue: 0.1, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    font_size: 16px
    series_types:
      experiment_period: area
    series_colors:
      weekly_difference_against_control: "#776fdf"
      experiment_period: "#9fdee0"
    series_labels: {}
    label_color: ["#ffffff", transparent]
    reference_lines: []
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.total_metric_value, d_experiment.experiment_start_date]
    hidden_points_if_no: []
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 112
    col: 0
    width: 9
    height: 5
  - title: Monitoring 1 - Daily
    name: Monitoring 1 - Daily
    model: travelperk
    explore: d_experiment
    type: looker_column
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      f_experiment_user_metrics_daily.total_metric_value, d_user_experiment_assignment.assignment]
    pivots: [d_user_experiment_assignment.assignment]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: monitoring
      d_user_experiment_assignment.assignment: treatment,control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '1'
    sorts: [d_user_experiment_assignment.assignment desc, f_experiment_user_metrics_daily.dt_date
        desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: if(${f_experiment_user_metrics_daily.time_period}="experiment",(${f_experiment_user_metrics_daily.total_metric_value}),0)
      label: Experiment Period
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: experiment_period
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
    trellis: pivot
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: f_experiment_user_metrics_daily.total_metric_value,
            id: treatment - f_experiment_user_metrics_daily.total_metric_value, name: treatment
              - 📈 Experiment Metrics Total Metric Value}, {axisId: f_experiment_user_metrics_daily.total_metric_value,
            id: control - f_experiment_user_metrics_daily.total_metric_value, name: control
              - 📈 Experiment Metrics Total Metric Value}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: experiment_period, id: treatment - experiment_period,
            name: treatment - Experiment Period}, {axisId: experiment_period, id: control
              - experiment_period, name: control - Experiment Period}], showLabels: false,
        showValues: false, maxValue: 0.2, minValue: 0.1, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: true
    font_size: 12px
    series_types:
      experiment_period: area
      treatment - experiment_period: area
      control - experiment_period: area
    series_colors:
      weekly_difference_against_control: "#5245ed"
      experiment_period: "#9fdee0"
      treatment - f_experiment_user_metrics_daily.total_metric_value: "#776fdf"
      control - f_experiment_user_metrics_daily.total_metric_value: "#a3a3a3"
      treatment - experiment_period: "#9fdee0"
      control - experiment_period: "#9fdee0"
    series_labels: {}
    label_color: []
    reference_lines: []
    show_null_points: true
    interpolation: linear
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period]
    hidden_points_if_no: []
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 108
    col: 9
    width: 15
    height: 13
  - title: Monitoring 1 - Daily Average - Control
    name: Monitoring 1 - Daily Average - Control
    model: travelperk
    explore: d_experiment
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.total_metric_value, f_experiment_user_metrics_daily.metric_calculation,
      f_experiment_user_metrics_daily.metric_format]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: monitoring
      f_experiment_user_metrics_daily.dt_day_of_week: "-Saturday,-Sunday"
      d_user_experiment_assignment.assignment: control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
      d_experiment_metrics.metric_rank: '1'
    sorts: [f_experiment_user_metrics_daily.dt_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: In-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: in_experiment_daily_average
      _type_hint: number
    - category: table_calculation
      expression: mean(if(${f_experiment_user_metrics_daily.time_period}="pre-experiment",${f_experiment_user_metrics_daily.total_metric_value},null))
      label: Pre-Experiment Daily Average
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: pre_experiment_daily_average
      _type_hint: number
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, f_experiment_user_metrics_daily.dt_date,
      f_experiment_user_metrics_daily.total_metric_value]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: ''
    orientation: auto
    style_in_experiment_daily_average: "#626262"
    show_title_in_experiment_daily_average: true
    title_placement_in_experiment_daily_average: above
    value_format_in_experiment_daily_average: ''
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    comparison_show_label_pre_experiment_daily_average: true
    pos_is_bad_pre_experiment_daily_average: false
    comparison_label_placement_pre_experiment_daily_average: below
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    y_axes: []
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 117
    col: 0
    width: 9
    height: 4
  - title: OEC - Daily Difference
    name: OEC - Daily Difference
    model: travelperk
    explore: d_experiment
    type: looker_line
    fields: [f_experiment_user_metrics_daily.dt_date, f_experiment_user_metrics_daily.time_period,
      f_experiment_user_metrics_daily.metric_name, d_experiment_metrics.metric_type,
      f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      f_experiment_user_metrics_daily.total_metric_value, d_user_experiment_assignment.assignment]
    pivots: [d_user_experiment_assignment.assignment]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: oec
      d_user_experiment_assignment.assignment: treatment,control
      f_experiment_user_metrics_daily.dt_date: before 0 days ago
    sorts: [d_user_experiment_assignment.assignment desc, f_experiment_user_metrics_daily.dt_date
        desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |-
        pivot_where(
          ${d_user_experiment_assignment.assignment}="treatment"
          , ${f_experiment_user_metrics_daily.total_metric_value}
        )
        -
        pivot_where(
          ${d_user_experiment_assignment.assignment}="control"
          , ${f_experiment_user_metrics_daily.total_metric_value}
        )
      label: Difference Against Control
      value_format:
      value_format_name:
      _kind_hint: supermeasure
      table_calculation: difference_against_control
      _type_hint: number
      is_disabled: false
    - category: table_calculation
      expression: if(${f_experiment_user_metrics_daily.time_period}="experiment",sum(pivot_row(${f_experiment_user_metrics_daily.total_metric_value})),0)
      label: Experiment Period
      value_format:
      value_format_name:
      _kind_hint: supermeasure
      table_calculation: experiment_period
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    y_axes: [{label: '', orientation: left, series: [{axisId: experiment_period, id: experiment_period,
            name: Experiment Period}], showLabels: false, showValues: false, maxValue: 0.2,
        minValue: 0.1, unpinAxis: false, tickDensity: default, type: linear}, {label: '',
        orientation: left, series: [{axisId: difference_against_control, id: difference_against_control,
            name: Difference Against Control}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: true
    font_size: 12px
    series_types:
      treatment - experiment_period: area
      control - experiment_period: area
      difference_against_control: area
      experiment_period: area
    series_colors:
      weekly_difference_against_control: "#5245ed"
      experiment_period: "#9fdee0"
      treatment - f_experiment_user_metrics_daily.total_metric_value: "#5245ed"
      control - f_experiment_user_metrics_daily.total_metric_value: "#a3a3a3"
      treatment - experiment_period: "#9fdee0"
      control - experiment_period: transparent
      difference_against_control: "#5245ed"
    series_labels: {}
    label_color: []
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#000000",
        line_value: '0', label: ''}]
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [f_experiment_user_metrics_daily.metric_calculation, f_experiment_user_metrics_daily.metric_format,
      d_experiment_metrics.metric_type, f_experiment_user_metrics_daily.metric_name,
      f_experiment_user_metrics_daily.time_period, f_experiment_user_metrics_daily.total_metric_value]
    hidden_points_if_no: []
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 24
    col: 9
    width: 15
    height: 4
  - title: "[Treatment vs Control] All Metrics Significance"
    name: "[Treatment vs Control] All Metrics Significance"
    model: travelperk
    explore: d_experiment
    type: looker_grid
    fields: [f_experiment_user_metrics.metric_name, d_experiment_metrics.metric_type,
      f_experiment_user_metrics.metric_calculation, f_experiment_user_metrics.metric_format,
      d_experiment_metrics.metric_rank, d_user_experiment_assignment.count, d_user_experiment_assignment.assignment,
      f_experiment_user_metrics.total_metric_value, f_experiment_user_metrics.average_metric_value,
      f_experiment_user_metrics.variance_metric_value, f_experiment_user_metrics.number_of_samples,
      f_experiment_user_metrics.standard_deviation_metric_value]
    pivots: [d_user_experiment_assignment.assignment]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: ''
      d_user_experiment_assignment.assignment: treatment,control
      f_experiment_user_metrics.has_interactions: 'Yes'
    sorts: [d_user_experiment_assignment.assignment desc, d_experiment_metrics.metric_type
        desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |-
        (pivot_where(
          ${d_user_experiment_assignment.assignment} = "treatment"
          , ${f_experiment_user_metrics.average_metric_value}
        )
        -
        pivot_where(
          ${d_user_experiment_assignment.assignment} = "control"
          , ${f_experiment_user_metrics.average_metric_value}
        ))
        /
        pivot_where(
          ${d_user_experiment_assignment.assignment} = "control"
          , ${f_experiment_user_metrics.average_metric_value}
        )
      label: Average Metric Increase
      value_format:
      value_format_name: percent_2
      _kind_hint: supermeasure
      table_calculation: average_metric_increase
      _type_hint: number
    - category: table_calculation
      expression: "sqrt(\n  (\n    pivot_where(\n      ${d_user_experiment_assignment.assignment}\
        \ = \"treatment\"\n      , ${f_experiment_user_metrics.variance_metric_value}\n\
        \    )\n    / \n    pivot_where(\n      ${d_user_experiment_assignment.assignment}\
        \ = \"treatment\"\n      , ${f_experiment_user_metrics.number_of_samples}\n\
        \    )\n  ) \n  + \n  (\n    pivot_where(\n      ${d_user_experiment_assignment.assignment}\
        \ = \"control\"\n      , ${f_experiment_user_metrics.variance_metric_value}\n\
        \    )\n    / \n    pivot_where(\n      ${d_user_experiment_assignment.assignment}\
        \ = \"control\"\n      , ${f_experiment_user_metrics.number_of_samples}\n\
        \    )\n  ) \n)"
      label: Standard Error
      value_format:
      value_format_name:
      _kind_hint: supermeasure
      table_calculation: standard_error
      _type_hint: number
    - category: table_calculation
      expression: |-
        (pivot_where(
          ${d_user_experiment_assignment.assignment} = "treatment"
          , ${f_experiment_user_metrics.average_metric_value}
        )
        -
        pivot_where(
          ${d_user_experiment_assignment.assignment} = "control"
          , ${f_experiment_user_metrics.average_metric_value}
        ))

        /
        ${standard_error}
      label: Z-Score
      value_format:
      value_format_name:
      _kind_hint: supermeasure
      table_calculation: z_score
      _type_hint: number
    - category: table_calculation
      expression: norm_dist(${z_score},0,1,yes)
      label: P-Value
      value_format:
      value_format_name:
      _kind_hint: supermeasure
      table_calculation: p_value
      _type_hint: number
    - category: table_calculation
      expression: |-
        if(${p_value}<0.05,
          concat("Significantly "
            , if(
              ${z_score} < 0
              , "Down"
              , "Up"
            ))
            ,"Insignificant"
          )
      label: Significance
      value_format:
      value_format_name:
      _kind_hint: supermeasure
      table_calculation: significance
      _type_hint: string
    - category: table_calculation
      expression: "1.0 * (\n  pivot_where(\n    ${d_user_experiment_assignment.assignment}\
        \ = \"treatment\"\n    , ${f_experiment_user_metrics.average_metric_value}\n\
        \  )- pivot_where(\n    ${d_user_experiment_assignment.assignment} = \"control\"\
        \n    , ${f_experiment_user_metrics.average_metric_value}\n  )) /\nsqrt(\n\
        \  (power(pivot_where(\n    ${d_user_experiment_assignment.assignment} = \"\
        treatment\"\n    , ${f_experiment_user_metrics.standard_deviation_metric_value}\n\
        \  ),2) / \n    pivot_where(\n    ${d_user_experiment_assignment.assignment}\
        \ = \"treatment\"\n    , ${f_experiment_user_metrics.number_of_samples}\n\
        \  )) + (power(pivot_where(\n    ${d_user_experiment_assignment.assignment}\
        \ = \"control\"\n    , ${f_experiment_user_metrics.standard_deviation_metric_value}\n\
        \  ),2) / pivot_where(\n    ${d_user_experiment_assignment.assignment} = \"\
        control\"\n    , ${f_experiment_user_metrics.number_of_samples}\n  ))\n  )"
      label: T-Score
      value_format:
      value_format_name:
      _kind_hint: supermeasure
      table_calculation: t_score
      _type_hint: number
    - category: table_calculation
      expression: |-
        case(
          when(abs(${t_score}) > 3.291, "(7) .0005 sig. level")
          , when(abs(${t_score}) > 3.091, "(6) .001 sig. level")
          , when(abs(${t_score}) > 2.576, "(5) .005 sig. level")
          , when(abs(${t_score}) > 2.326, "(4) .01 sig. level")
          , when(abs(${t_score}) > 1.960, "(3) .025 sig. level")
          , when(abs(${t_score}) > 1.645, "(2) .05 sig. level")
          , when(abs(${t_score}) > 1.282, "(1) .1 sig. level")
          , "(0) Insignificant"
        )
      label: T-Test Significance
      value_format:
      value_format_name:
      _kind_hint: supermeasure
      table_calculation: t_test_significance
      _type_hint: string
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels: {}
    series_cell_visualizations:
      f_experiment_user_metrics_daily.total_metric_value:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#62bad4",
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_diverging2,
          options: {steps: 5, constraints: {min: {type: minimum}, mid: {type: number,
                value: 0}, max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [average_metric_increase]}]
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
    trellis: pivot
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: f_experiment_user_metrics_daily.total_metric_value,
            id: treatment - f_experiment_user_metrics_daily.total_metric_value, name: treatment
              - 📈 Experiment Metrics Total Metric Value}, {axisId: f_experiment_user_metrics_daily.total_metric_value,
            id: control - f_experiment_user_metrics_daily.total_metric_value, name: control
              - 📈 Experiment Metrics Total Metric Value}], showLabels: false, showValues: false,
        unpinAxis: false, tickDensity: default, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: experiment_period, id: treatment - experiment_period,
            name: treatment - Experiment Period}, {axisId: experiment_period, id: control
              - experiment_period, name: control - Experiment Period}], showLabels: false,
        showValues: false, maxValue: 0.2, minValue: 0.1, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: true
    font_size: 12px
    series_colors:
      weekly_difference_against_control: "#5245ed"
      experiment_period: "#9fdee0"
      treatment - f_experiment_user_metrics_daily.total_metric_value: "#5245ed"
      control - f_experiment_user_metrics_daily.total_metric_value: "#a3a3a3"
      treatment - experiment_period: "#9fdee0"
      control - experiment_period: "#9fdee0"
    label_color: []
    reference_lines: []
    show_null_points: true
    interpolation: linear
    hidden_fields: [d_experiment_metrics.metric_rank, d_user_experiment_assignment.count,
      standard_error, z_score, p_value, t_score, significance, f_experiment_user_metrics.variance_metric_value,
      f_experiment_user_metrics.standard_deviation_metric_value, f_experiment_user_metrics.number_of_samples,
      f_experiment_user_metrics.metric_calculation, f_experiment_user_metrics.metric_format]
    hidden_points_if_no: []
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
    defaults_version: 1
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 4
    col: 0
    width: 24
    height: 7
  - title: Days Running
    name: Days Running
    model: travelperk
    explore: d_experiment
    type: single_value
    fields: [d_experiment.experiment_id, d_experiment.experiment_name, d_experiment.experiment_description,
      d_experiment.experiment_start_date, d_experiment.experiment_end_date, d_experiment.experiment_status]
    filters:
      d_experiment.experiment_id: PEEK-1
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "diff_days(${d_experiment.experiment_start_date}, \n  if(${d_experiment.experiment_end_date}\
        \ > now()\n    , now()\n    , ${d_experiment.experiment_end_date}\n    )\n\
        \  )"
      label: Days Running
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: days_running
      _type_hint: number
    - category: table_calculation
      expression: "${d_experiment.experiment_status}"
      label: Status
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: status
      _type_hint: string
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [d_experiment.experiment_id, d_experiment.experiment_name, d_experiment.experiment_description,
      d_experiment.experiment_start_date, d_experiment.experiment_end_date, d_experiment.experiment_status]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    show_title_d_experiment.experiment_status: false
    show_title_days_running: true
    show_title_experiment_name: false
    show_comparison_description: true
    comparison_style_description: value
    comparison_show_label_description: false
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    defaults_version: 1
    y_axes: []
    title_hidden: true
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 0
    col: 18
    width: 3
    height: 4
  - title: Number of Users
    name: Number of Users
    model: travelperk
    explore: d_experiment
    type: single_value
    fields: [d_experiment.experiment_id, d_experiment.experiment_name, d_experiment.experiment_description,
      d_experiment.experiment_start_date, d_experiment.experiment_end_date, f_experiment_user_metrics.number_of_samples]
    filters:
      d_experiment.experiment_id: PEEK-1
      d_experiment_metrics.metric_type: oec
      d_user_experiment_assignment.assignment: treatment
      f_experiment_user_metrics.has_interactions: 'Yes'
    sorts: [d_experiment.experiment_start_date desc]
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
    hidden_fields: [d_experiment.experiment_id, d_experiment.experiment_name, d_experiment.experiment_description,
      d_experiment.experiment_start_date, d_experiment.experiment_end_date]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    show_title_experiment_name: false
    show_comparison_description: true
    comparison_style_description: value
    comparison_show_label_description: false
    style_in_experiment_daily_average: "#5245ed"
    show_comparison_pre_experiment_daily_average: true
    comparison_style_pre_experiment_daily_average: percentage_change
    pos_is_bad_pre_experiment_daily_average: false
    show_comparison_in_experiment_daily_average: true
    comparison_style_in_experiment_daily_average: percentage_change
    hidden_pivots: {}
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
    defaults_version: 1
    y_axes: []
    title_hidden: true
    listen:
      Experiment Name: d_experiment.experiment_name
    row: 0
    col: 21
    width: 3
    height: 4
  filters:
  - name: Experiment Name
    title: Experiment Name
    type: field_filter
    default_value: '"remove_hotel_attachment_page"'
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: travelperk
    explore: d_experiment
    listens_to_filters: []
    field: d_experiment.experiment_name
