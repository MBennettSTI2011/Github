view: +pull_request {
  dimension_group: created {
    label: "Created"
    group_label: "Timeline"
    description: "Timestamp when the pull request was opened."
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: merged {
    label: "Merged"
    group_label: "Timeline"
    description: "Timestamp when the pull request was merged."
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.merged_at ;;
  }

  dimension_group: updated {
    label: "Updated"
    group_label: "Timeline"
    description: "Timestamp when the pull request was last updated."
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: state {
    label: "State"
    group_label: "Lifecycle"
    description: "Current state reported by GitHub for the pull request."
    type: string
    sql: COALESCE(${TABLE}.state, 'unknown') ;;
  }

  dimension: merge_status {
    label: "Merge Status"
    group_label: "Lifecycle"
    description: "Classifies pull requests based on merge and close activity."
    type: string
    sql: CASE
      WHEN ${is_merged} THEN 'Merged'
      WHEN ${state} = 'closed' THEN 'Closed Without Merge'
      ELSE 'Open'
    END ;;
  }

  measure: total_pull_requests {
    label: "Total Pull Requests"
    group_label: "Totals"
    description: "Counts all pull requests regardless of status."
    type: count
    value_format_name: decimal_0
    drill_fields: [id]
  }

  measure: total_merged_pull_requests {
    label: "Total Merged Pull Requests"
    group_label: "Totals"
    description: "Counts pull requests that have been merged."
    type: count
    value_format_name: decimal_0
    filters: [merge_status: "Merged"]
    drill_fields: [id]
  }

  measure: total_open_pull_requests {
    label: "Total Open Pull Requests"
    group_label: "Totals"
    description: "Counts active pull requests that remain open."
    type: count
    value_format_name: decimal_0
    filters: [merge_status: "Open"]
    drill_fields: [id]
  }

  measure: avg_merge_time_hours {
    label: "Avg Merge Time (Hours)"
    group_label: "Performance"
    description: "Average hours between pull request creation and merge."
    type: average
    value_format_name: decimal_1
    sql: CASE
      WHEN ${is_merged} THEN CAST(DATEDIFF(hour, ${created_raw}, ${merged_raw}) AS DECIMAL(18, 2))
    END ;;
  }
}
