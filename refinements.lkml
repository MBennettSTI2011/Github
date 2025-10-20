include: "//github-v2/**/*.view.lkml"
include: "//github-v2/**/*.explore.lkml"
include: "//github-v2/**/*.model.lkml"
include: "refinements/**/*.lkml"

view: github__pull_request_base {
  dimension_group: created {
    label: "Created Date"
    group_label: "Dates"
    type: time
    datatype: datetime
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: merged {
    label: "Merged Date"
    group_label: "Dates"
    type: time
    datatype: datetime
    timeframes: [date, week, month, year]
    sql: ${TABLE}.merged_at ;;
  }

  dimension_group: closed {
    label: "Closed Date"
    group_label: "Dates"
    type: time
    datatype: datetime
    timeframes: [date, week, month, year]
    sql: ${TABLE}.closed_at ;;
  }

  dimension: is_merged {
    label: "Is Merged"
    group_label: "Status"
    type: yesno
    sql: CASE WHEN ${TABLE}.merged_at IS NOT NULL THEN 1 ELSE 0 END ;;
  }

  dimension: merge_duration_days {
    label: "Merge Duration Days"
    description: "Number of days between creation and merge for merged pull requests."
    group_label: "Performance"
    type: number
    value_format_name: decimal_1
    sql: CASE
      WHEN ${TABLE}.merged_at IS NOT NULL
        THEN DATEDIFF(day, ${TABLE}.created_at, ${TABLE}.merged_at)
      ELSE NULL
    END ;;
  }

  measure: count_pull_requests {
    label: "Count Pull Requests"
    group_label: "Totals"
    type: count
    value_format_name: decimal_0
  }

  measure: count_merged_pull_requests {
    label: "Count Merged Pull Requests"
    group_label: "Totals"
    type: count
    filters: [is_merged: "yes"]
    value_format_name: decimal_0
  }

  measure: total_additions {
    label: "Total Additions"
    group_label: "Code Changes"
    type: sum
    sql: COALESCE(${TABLE}.additions, 0) ;;
    value_format_name: decimal_0
  }

  measure: total_deletions {
    label: "Total Deletions"
    group_label: "Code Changes"
    type: sum
    sql: COALESCE(${TABLE}.deletions, 0) ;;
    value_format_name: decimal_0
  }

  measure: avg_merge_duration_days {
    label: "Average Merge Duration Days"
    group_label: "Performance"
    type: average
    sql: ${merge_duration_days} ;;
    value_format_name: decimal_1
  }
}

view: github_issue_base {
  dimension_group: created {
    label: "Created Date"
    group_label: "Dates"
    type: time
    datatype: datetime
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: closed {
    label: "Closed Date"
    group_label: "Dates"
    type: time
    datatype: datetime
    timeframes: [date, week, month, year]
    sql: ${TABLE}.closed_at ;;
  }

  dimension: is_open {
    label: "Is Open"
    group_label: "Status"
    type: yesno
    sql: CASE WHEN ${TABLE}.state = 'open' THEN 1 ELSE 0 END ;;
  }

  dimension: resolution_time_days {
    label: "Resolution Time Days"
    description: "Number of days between issue creation and closure."
    group_label: "Performance"
    type: number
    value_format_name: decimal_1
    sql: CASE
      WHEN ${TABLE}.closed_at IS NOT NULL
        THEN DATEDIFF(day, ${TABLE}.created_at, ${TABLE}.closed_at)
      ELSE NULL
    END ;;
  }

  measure: count_issues {
    label: "Count Issues"
    group_label: "Totals"
    type: count
    value_format_name: decimal_0
  }

  measure: count_open_issues {
    label: "Count Open Issues"
    group_label: "Totals"
    type: count
    filters: [is_open: "yes"]
    value_format_name: decimal_0
  }

  measure: avg_resolution_time_days {
    label: "Average Resolution Time Days"
    group_label: "Performance"
    type: average
    sql: ${resolution_time_days} ;;
    value_format_name: decimal_1
  }
}
