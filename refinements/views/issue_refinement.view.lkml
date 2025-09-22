view: +github_issue_housing_hub {
  dimension: hours_open {
    label: "Hours Open"
    group_label: "Lifecycle"
    description: "The number of hours the issue has been open."
    type: number
    sql: DATEDIFF(hour, ${created_raw}, GETDATE()) ;;
  }

  dimension: status_category {
    label: "Status Category"
    group_label: "Lifecycle"
    description: "Summarizes the issue's lifecycle state."
    type: string
    sql: CASE
      WHEN COALESCE(${issue_state}, 'unknown') = 'open' THEN 'Open'
      WHEN COALESCE(${issue_state}, 'unknown') = 'closed' THEN 'Closed'
      ELSE 'Unknown'
    END ;;
  }

  dimension: open_duration_category {
    label: "Open Duration Category"
    group_label: "Lifecycle"
    description: "Buckets issue age based on hours open."
    type: string
    sql: CASE
      WHEN COALESCE(${hours_open}, 0) < 72 THEN 'Under 3 Days'
      WHEN COALESCE(${hours_open}, 0) < 168 THEN '3 Days to Under 1 Week'
      WHEN COALESCE(${hours_open}, 0) < 336 THEN '1 Week to Under 2 Weeks'
      ELSE '2 Weeks Or More'
    END ;;
  }

  measure: total_issues {
    label: "Total Issues"
    group_label: "Totals"
    description: "Counts all issues regardless of their state."
    type: count
    value_format_name: decimal_0
    drill_fields: [issue_id]
  }

  measure: total_open_issues {
    label: "Total Open Issues"
    group_label: "Totals"
    description: "Counts issues that remain open."
    type: count
    value_format_name: decimal_0
    filters: [status_category: "Open"]
    drill_fields: [issue_id]
  }

  measure: total_closed_issues {
    label: "Total Closed Issues"
    group_label: "Totals"
    description: "Counts issues that have been closed."
    type: count
    value_format_name: decimal_0
    filters: [status_category: "Closed"]
    drill_fields: [issue_id]
  }

  measure: avg_time_to_close_hours {
    label: "Avg Time To Close (Hours)"
    group_label: "Performance"
    description: "Average hours required to close an issue."
    type: average
    value_format_name: decimal_1
    sql: CASE
      WHEN ${status_category} = 'Closed' THEN CAST(DATEDIFF(hour, ${created_raw}, ${closed_raw}) AS DECIMAL(18, 2))
    END ;;
  }

  measure: avg_time_to_close_days {
    label: "Avg Time To Close (Days)"
    group_label: "Performance"
    description: "Average days required to close an issue."
    type: average
    value_format_name: decimal_1
    sql: CASE
      WHEN ${status_category} = 'Closed' THEN DATEDIFF(hour, ${created_raw}, ${closed_raw}) / 24.0
    END ;;
  }
}
