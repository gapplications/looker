#### EXAMPLE FOR METRIC TREE VISUALISATION ####

view: commercial_tree_diagram {
  sql_table_name: #########
    ;;

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      day_of_month,
      day_of_week_index,
      month_num,
      day_of_year
    ]
    sql: ${TABLE}.date ;;
  }

  dimension: measure {
    type: string
    sql: ${TABLE}.measure ;;
  }

  dimension: value_calc {
    type: string
    sql: ${TABLE}.value_calc ;;
  }

  dimension: value_number_format {
    type: string
    sql: ${TABLE}.value_number_format ;;
  }

  dimension: parent_measure {
    type: string
    sql: ${TABLE}.parent_measure ;;
  }

  measure: single_value {
    type: sum
    sql: ${TABLE}.single_value ;;
  }

  measure: numerator {
    type: sum
    sql: ${TABLE}.numerator ;;
  }

  measure: denominator {
    type: sum
    sql: ${TABLE}.denominator ;;
  }

  measure: single_value_chosen_period {
    type: sum
    sql: ${TABLE}.single_value ;;
    filters: [
      periods_ago: "0"
    ]
  }

  measure: single_value_previous_period {
    type: sum
    sql: ${TABLE}.single_value ;;
    filters: [
      periods_ago: "1"
    ]
  }

  measure: numerator_value_chosen_period {
    type: sum
    sql: ${TABLE}.numerator ;;
    filters: [
      periods_ago: "0"
    ]
  }

  measure: numerator_value_previous_period {
    type: sum
    sql: ${TABLE}.numerator ;;
    filters: [
      periods_ago: "1"
    ]
  }

  measure: denominator_value_chosen_period {
    type: sum
    sql: ${TABLE}.denominator ;;
    filters: [
      periods_ago: "0"
    ]
  }

  measure: denominator_value_previous_period {
    type: sum
    sql: ${TABLE}.denominator ;;
    filters: [
      periods_ago: "1"
    ]
  }

  ##########################
  ### Period Over Period ###
  ##########################

  dimension: max_date {
    label: "Max Date"
    description: "Max date in the data source"
    convert_tz: no
    type: date
    sql:
      ( SELECT CAST(MAX(date) as DATE) FROM ###########
      ) ;;
  }

  dimension: date_day_of_quarter {
    hidden: yes
    sql: DATE_DIFF(${date_date}, DATE_TRUNC(${date_date}, QUARTER), DAY)
    ;;
  }

  parameter: period_comparison {
    group_label: "Period Over Period"
    type: unquoted
    allowed_value: {
      label: "Same Period Last Year"
      value: "last_year"
    }
    allowed_value: {
      label: "Previous Period"
      value: "previous_period"
    }
  }

  parameter: period_select {
    group_label: "Period Over Period"
    type: unquoted
    allowed_value: {
      label: "Current Week"
      value: "WEEK"
    }
    allowed_value: {
      label: "Current Month"
      value: "MONTH"
    }
    allowed_value: {
      label: "Current Quarter"
      value: "QUARTER"
    }
    allowed_value: {
      label: "Current Year"
      value: "YEAR"
    }
    allowed_value: {
      label: "Last Week"
      value: "LAST_WEEK"
    }
    allowed_value: {
      label: "Last Month"
      value: "LAST_MONTH"
    }
    allowed_value: {
      label: "Last Quarter"
      value: "LAST_QUARTER"
    }
    allowed_value: {
      label: "Last Year"
      value: "LAST_YEAR"
    }
    allowed_value: {
      label: "Max Date"
      value: "YESTERDAY"
    }
    allowed_value: {
      label: "12 Months Rolling"
      value: "12_MONTHS"
    }
    allowed_value: {
      label: "Custom Date Range"
      value: "CUSTOM"
    }
    allowed_value: {
      label: "Custom Date Range - LFL Weeks"
      value: "CUSTOM_WEEK"
    }
  }

  filter: date_range {
    group_label: "Period Over Period"
    label: "Custom Date Range Picker"
    type: date
    convert_tz: no
  }

  parameter: periodtodate_or_total {
    group_label: "Period Over Period"
    type: unquoted
    allowed_value: {
      label: "PTD"
      value: "ptd"
    }
    allowed_value: {
      label: "Total"
      value: "total"
    }
  }

  dimension: is_period_to_date_or_total {
    group_label: "Period Over Period"
    type: yesno
    sql:
      {% if periodtodate_or_total._parameter_value == 'total'
        or period_select._parameter_value == 'CUSTOM'
        or period_select._parameter_value == 'CUSTOM_WEEK'
        or period_select._parameter_value == 'LAST_WEEK'
        or period_select._parameter_value == 'LAST_MONTH'
        or period_select._parameter_value == 'LAST_QUARTER'
        or period_select._parameter_value == 'LAST_YEAR'
        or period_select._parameter_value == '12_MONTHS'
        or period_select._parameter_value == 'YESTERDAY' %}
          1
      {% elsif period_select._parameter_value == 'WEEK' %}
          CASE
            WHEN FORMAT_DATE("%u",${date_date})
              <= FORMAT_DATE("%u",${max_date})
            THEN 1 ELSE 0
          END
      {% elsif period_select._parameter_value == 'MONTH' %}
          CASE
            WHEN (EXTRACT(DAY FROM ${date_date}))
              <= (EXTRACT(DAY FROM ${max_date}))
            THEN 1 ELSE 0
          END
      {% elsif period_select._parameter_value == 'QUARTER' %}
          CASE
            WHEN DATE_DIFF(${date_date}, DATE_TRUNC(${date_date}, QUARTER), DAY)
              <= DATE_DIFF(${max_date}, DATE_TRUNC(${max_date}, QUARTER), DAY)
            then 1 ELSE 0
          END
      {% elsif period_select._parameter_value == 'YEAR' %}
          CASE
            WHEN DATE_DIFF(${date_date}, DATE_TRUNC(${date_date}, YEAR), DAY)
              <= DATE_DIFF(${max_date}, DATE_TRUNC(${max_date}, YEAR), DAY)
            THEN 1 ELSE 0
          END
      {% endif %}
      = 1
      ;;
  }

  dimension: period_breakdown {
    type: number
    group_label: "Period Over Period"
    sql:
      {% if period_select._parameter_value == 'LAST_MONTH'
        or period_select._parameter_value == 'MONTH'%}
      ${date_day_of_month}
      {% elsif period_select._parameter_value == 'WEEK'
        or period_select._parameter_value == 'LAST_WEEK'
        or period_select._parameter_value == 'CUSTOM_WEEK' %}
      ${date_day_of_week_index}
      {% elsif period_select._parameter_value == 'YEAR'
        or period_select._parameter_value == 'LAST_YEAR'
        or period_select._parameter_value == '12_MONTHS' %}
      ${date_month_num}
      {% elsif period_select._parameter_value == 'YESTERDAY'
        or period_select._parameter_value == 'MAX_DATE'
        or period_select._parameter_value == 'CUSTOM' %}
      ${date_day_of_year}
      {% elsif period_select._parameter_value == 'QUARTER'
        or period_select._parameter_value == 'LAST_QUARTER' %}
      ${date_day_of_quarter}
      {% endif %}
      ;;
  }

  dimension: period_dates {
    group_label: "Period Over Period"
    type: string
    sql:
      {% if period_select._parameter_value == 'CUSTOM'
        or period_select._parameter_value == 'YESTERDAY' %}
          ${date_date}
      {% elsif period_select._parameter_value == 'WEEK'
        or period_select._parameter_value == 'CUSTOM_WEEK'
        or period_select._parameter_value == 'LAST_WEEK' %}
          ${date_week}
      {% elsif period_select._parameter_value == 'MONTH'
        or period_select._parameter_value == 'LAST_MONTH'
        or period_select._parameter_value == 'QUARTER'
        or period_select._parameter_value == 'LAST_QUARTER'
        or period_select._parameter_value == '12_MONTHS'
        or period_select._parameter_value == 'YEAR'
        or period_select._parameter_value == 'LAST_YEAR' %}
          ${date_month}
      {% endif %}
      ;;
  }

  dimension: periods_ago {
    group_label: "Period Over Period"
    type: number
    sql:
      -- Replace date_date with whatever the date field is in the explore
      {% if period_comparison._parameter_value == "last_year" %}
        {% if period_select._parameter_value == 'WEEK' %}
          (CASE
            WHEN EXTRACT(ISOWEEK FROM CAST(${date_date} AS DATE)) = EXTRACT(ISOWEEK FROM CAST(${max_date} AS DATE))
            THEN (EXTRACT(YEAR FROM CAST(${max_date} AS DATE))) - (EXTRACT(YEAR FROM CAST(${date_date} AS DATE)))
            ELSE NULL
          END)
        {% elsif period_select._parameter_value == 'LAST_WEEK' %}
          (CASE
            WHEN EXTRACT(ISOWEEK FROM CAST(${date_date} AS DATE)) = EXTRACT(ISOWEEK FROM CAST(TIMESTAMP(DATE_SUB(DATE_TRUNC(${max_date},ISOWEEK), INTERVAL 1 DAY)) AS DATE))
            THEN (EXTRACT(YEAR FROM CAST(TIMESTAMP(DATE_SUB(DATE_TRUNC(${max_date},ISOWEEK), INTERVAL 1 DAY)) AS DATE))) - (EXTRACT(YEAR FROM CAST(${date_date} AS DATE)))
            ELSE NULL
          END)
        {% elsif period_select._parameter_value == 'MONTH' %}
          (CASE
            WHEN
              EXTRACT(MONTH FROM CAST(${date_date} AS DATE)) = EXTRACT(MONTH FROM CAST(${max_date} AS DATE))
            THEN (EXTRACT(YEAR FROM CAST(${max_date} AS DATE))) - (EXTRACT(YEAR FROM CAST(${date_date} AS DATE)))
            ELSE NULL
          END)
        {% elsif period_select._parameter_value == 'LAST_MONTH' %}
          (CASE
            WHEN EXTRACT(MONTH FROM CAST(${date_date} AS DATE)) = EXTRACT(MONTH FROM CAST(TIMESTAMP(DATE_SUB(DATE_TRUNC(${max_date},MONTH), INTERVAL 1 DAY)) AS DATE))
            THEN (EXTRACT(YEAR FROM CAST(TIMESTAMP(DATE_SUB(DATE_TRUNC(${max_date},MONTH), INTERVAL 1 DAY)) AS DATE))) - (EXTRACT(YEAR FROM CAST(${date_date} AS DATE)))
            ELSE NULL
          END)
        {% elsif period_select._parameter_value == 'QUARTER' %}
          (CASE
            WHEN
              EXTRACT(QUARTER FROM CAST(${date_date} AS DATE)) = EXTRACT(QUARTER FROM CAST(${max_date} AS DATE))
            THEN (EXTRACT(YEAR FROM CAST(${max_date} AS DATE))) - (EXTRACT(YEAR FROM CAST(${date_date} AS DATE)))
            ELSE NULL
          END)
        {% elsif period_select._parameter_value == 'LAST_QUARTER' %}
          (CASE
            WHEN EXTRACT(QUARTER FROM CAST(${date_date} AS DATE)) = EXTRACT(QUARTER FROM CAST(TIMESTAMP(DATE_SUB(DATE_TRUNC(${max_date},QUARTER), INTERVAL 1 DAY)) AS DATE))
            THEN (EXTRACT(YEAR FROM CAST(TIMESTAMP(DATE_SUB(DATE_TRUNC(${max_date},QUARTER), INTERVAL 1 DAY)) AS DATE))) - (EXTRACT(YEAR FROM CAST(${date_date} AS DATE)))
            ELSE NULL
          END)
        {% elsif period_select._parameter_value == 'YEAR' %}
          DATE_DIFF( ${max_date}, ${date_date}, YEAR)
        {% elsif period_select._parameter_value == 'LAST_YEAR' %}
          DATE_DIFF(DATE_SUB(DATE_TRUNC(${max_date},YEAR), INTERVAL 1 DAY), ${date_date}, YEAR)
        {% elsif period_select._parameter_value == '12_MONTHS' %}
          CAST(FLOOR(DATE_DIFF(${max_date}, ${date_date}, DAY)/
            CASE
              WHEN (MOD(${date_year},4) = 0 AND MOD(${date_year},100) <> 0)
                OR MOD(${date_year},400) = 0
              THEN 366
              ELSE 365
            END) AS INT64)
        {% elsif period_select._parameter_value == 'YESTERDAY' %}
          (CASE
            WHEN EXTRACT(DAYOFWEEK FROM CAST(${date_date} AS DATE)) = EXTRACT(DAYOFWEEK FROM CAST(${max_date} AS DATE))
              AND EXTRACT(WEEK FROM CAST(${date_date} AS DATE)) = EXTRACT(WEEK FROM CAST(${max_date} AS DATE))
            THEN (EXTRACT(YEAR FROM CAST(${max_date} AS DATE))) - (EXTRACT(YEAR FROM CAST(${date_date} AS DATE)))
            ELSE NULL
          END)
        {% elsif period_select._parameter_value == 'CUSTOM' %}
          (CASE
            WHEN
              CAST(${date_date} AS DATE) >= CAST({% date_end date_range %} AS DATE)
            THEN
              -CAST(
                CASE
                  WHEN (DATE_DIFF( CAST(${date_date} AS DATE), CAST({% date_start date_range %} AS DATE), DAY)/
                    CASE
                      WHEN (MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),4) = 0 AND MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),100) <> 0)
                        OR MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),400) = 0
                      THEN 366
                      ELSE 365
                    END)
                    -FLOOR(DATE_DIFF( CAST(${date_date} AS DATE), CAST({% date_start date_range %} AS DATE), DAY)/
                      CASE
                        WHEN (MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),4) = 0 AND MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),100) <> 0)
                          OR MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),400) = 0
                        THEN 366
                        ELSE 365
                      END)
                      <=
                      (DATE_DIFF( CAST({% date_end date_range %} AS DATE), CAST({% date_start date_range %} AS DATE), DAY)/
                        CASE
                          WHEN (MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),4) = 0 AND MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),100) <> 0)
                            OR MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),400) = 0
                          THEN 366
                          ELSE 365
                        END)
                  THEN
                    FLOOR(DATE_DIFF( CAST(${date_date} AS DATE), CAST({% date_start date_range %} AS DATE), DAY)/
                      CASE
                        WHEN (MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),4) = 0 AND MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),100) <> 0)
                          OR MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),400) = 0
                        THEN 366
                        ELSE 365
                      END)
                  ELSE NULL
                  END
              AS INT64)
            ELSE
              CAST(
              CASE
                  WHEN ROUND(((DATE_DIFF( CAST({% date_end date_range %} AS DATE), CAST(${date_date} AS DATE), DAY)/
                    CASE
                      WHEN (MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),4) = 0 AND MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),100) <> 0)
                        OR MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),400) = 0
                      THEN 366
                      ELSE 365
                    END)
                      -FLOOR(DATE_DIFF( CAST({% date_end date_range %} AS DATE), CAST(${date_date} AS DATE), DAY)/
                        CASE
                          WHEN (MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),4) = 0 AND MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),100) <> 0)
                            OR MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),400) = 0
                          THEN 366
                          ELSE 365
                        END)),8)
                      <=
                      ROUND((DATE_DIFF( CAST({% date_end date_range %} AS DATE), CAST({% date_start date_range %} AS DATE), DAY)/
                        CASE
                          WHEN (MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),4) = 0 AND MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),100) <> 0)
                            OR MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),400) = 0
                          THEN 366
                          ELSE 365
                        END),8)
                  THEN
                    FLOOR(DATE_DIFF( CAST({% date_end date_range %} AS DATE), CAST(${date_date} AS DATE), DAY)/
                    (CASE
                      WHEN DATE_DIFF( CAST({% date_end date_range %} AS DATE),CAST({% date_start date_range %} AS DATE), DAY)<
                        CASE
                          WHEN (MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),4) = 0 AND MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),100) <> 0)
                            OR MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),400) = 0
                          THEN 366
                          ELSE 365
                        END
                      THEN
                        CASE
                          WHEN (MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),4) = 0 AND MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),100) <> 0)
                            OR MOD(EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE)),400) = 0
                          THEN 366
                          ELSE 365
                        END
                      ELSE DATE_DIFF( CAST({% date_end date_range %} AS DATE),CAST({% date_start date_range %} AS DATE), DAY)
                    END))
                  ELSE NULL
                  END
              AS INT64)
            END)
          {% elsif period_select._parameter_value == 'CUSTOM_WEEK' %}
            CAST(
              CASE
                  WHEN EXTRACT(ISOWEEK FROM CAST(${date_date} AS DATE))
                      = EXTRACT(ISOWEEK FROM CAST({% date_end date_range %} AS DATE))
                      OR
                      EXTRACT(ISOWEEK FROM CAST(${date_date} AS DATE))
                      = EXTRACT(ISOWEEK FROM CAST({% date_start date_range %} AS DATE))
                  THEN
                    EXTRACT(YEAR FROM CAST({% date_start date_range %} AS DATE))
                    -
                    EXTRACT(YEAR FROM CAST(${date_date} AS DATE))
                  ELSE NULL
                  END
               AS INT64)
        {% endif %}
      {% elsif period_comparison._parameter_value == "previous_period" %}
        {% if period_select._parameter_value == 'YEAR' %}
          DATE_DIFF( ${max_date}, ${date_date}, YEAR)
        {% elsif period_select._parameter_value == 'LAST_YEAR' %}
          DATE_DIFF(DATE_SUB(DATE_TRUNC(${max_date},YEAR), INTERVAL 1 DAY), ${date_date}, YEAR)
        {% elsif period_select._parameter_value == 'MONTH' %}
          DATE_DIFF( ${max_date}, ${date_date}, MONTH)
        {% elsif period_select._parameter_value == 'LAST_MONTH' %}
          DATE_DIFF( DATE_SUB(DATE_TRUNC(${max_date},MONTH), INTERVAL 1 DAY), ${date_date}, MONTH)
        {% elsif period_select._parameter_value == 'QUARTER' %}
          DATE_DIFF( ${max_date}, ${date_date}, QUARTER)
        {% elsif period_select._parameter_value == 'LAST_QUARTER' %}
          DATE_DIFF( DATE_SUB(DATE_TRUNC(${max_date},QUARTER), INTERVAL 1 DAY), ${date_date}, QUARTER)
        {% elsif period_select._parameter_value == 'WEEK' %}
          DATE_DIFF( ${max_date}, ${date_date}, ISOWEEK)
        {% elsif period_select._parameter_value == 'LAST_WEEK' %}
          DATE_DIFF( DATE_SUB(DATE_TRUNC(${max_date},ISOWEEK), INTERVAL 1 DAY), ${date_date}, ISOWEEK)
        {% elsif period_select._parameter_value == 'YESTERDAY' %}
          DATE_DIFF(${max_date}, ${date_date}, DAY)
        {% elsif period_select._parameter_value == '12_MONTHS' %}
          CAST(FLOOR(DATE_DIFF(${max_date}, ${date_date}, DAY)/
            CASE
              WHEN (MOD(${date_year},4) = 0 AND MOD(${date_year},100) <> 0)
                OR MOD(${date_year},400) = 0
              THEN 366
              ELSE 365
            END) AS INT64)
        {% elsif period_select._parameter_value == 'CUSTOM' %}
          (CASE
            WHEN
              CAST(${date_date} AS DATE) >= CAST({% date_end date_range %} AS DATE)
            THEN
              -CAST(CEILING(
                DATE_DIFF( CAST(${date_date} AS DATE), CAST({% date_end date_range %} AS DATE), DAY)
                /
                (DATE_DIFF( CAST({% date_end date_range %} AS DATE), CAST({% date_start date_range %} AS DATE), DAY)+1)
                ) AS INT64)
            ELSE
              CAST(FLOOR(
                DATE_DIFF( CAST({% date_end date_range %} AS DATE),CAST(${date_date} AS DATE), DAY)
                /
                (DATE_DIFF( CAST({% date_end date_range %} AS DATE), CAST({% date_start date_range %} AS DATE), DAY)+1)
                ) AS INT64)
            END)
        {% elsif period_select._parameter_value == 'CUSTOM_WEEK' %}
            DATE_DIFF( CAST({% date_start date_range %} AS DATE) , CAST(${date_date} AS DATE) , WEEK)
          {% endif %}
      {% endif %}
    ;;
  }

  measure: selected_period_dates {
    group_label: "Period Over Period"
    sql:
      CONCAT(
        "This dashboard is showing: "
        , MIN(
            CASE
              WHEN ${periods_ago} = 0
              THEN ${date_date}
            END)
        , " - "
        , MAX(
            CASE
              WHEN ${periods_ago} = 0
              THEN ${date_date}
            END)
        , ", comparing against: "
        , MIN(
            CASE
              WHEN ${periods_ago} = 1
              THEN ${date_date}
            END)
        , " - "
        , MAX(
            CASE
              WHEN ${periods_ago} = 1
              THEN ${date_date}
            END)
      )
      ;;
    html: <p style="font-size:26px">{{ value }}</p> ;;
  }
}
