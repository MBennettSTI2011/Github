view: github_issue_housing_hub {
  extends: [github_issue_base]
  view_label: "GitHub Housing Hub"

  dimension: issue_url {
    type: string
    sql: ${TABLE}.html_url ;;
    label: "Issue URL"
    description: "Link to the issue on GitHub."
    group_label: "Details"
  }

  dimension: time_to_close_days {
    type: number
    sql: CASE
          WHEN ${closed_raw} IS NULL THEN NULL
          ELSE DATEDIFF(day, ${created_raw}, ${closed_raw})
        END ;;
    label: "Time To Close Days"
    description: "Number of days from creation to closure for closed issues."
    group_label: "Timeline"
    value_format_name: decimal_1
  }

  dimension: pull_request_url {
    type: string
    sql: ${TABLE}.pull_request_url ;;
    label: "Pull Request URL"
    description: "API URL if the issue is associated to a pull request."
    group_label: "Details"
  }

  measure: count_issues {
    type: count_distinct
    sql: ${issue_id} ;;
    label: "Count Issues"
    value_format_name: decimal_0
    drill_fields: [issue_number, issue_title]
  }

  measure: total_comments {
    type: sum
    sql: COALESCE(${TABLE}.comments, 0) ;;
    label: "Total Comments"
    value_format_name: decimal_0
    drill_fields: [issue_number, comments_count]
  }

  measure: count_closed_issues {
    type: sum
    sql: CASE WHEN LOWER(${TABLE}.state) = 'closed' THEN 1 ELSE 0 END ;;
    label: "Count Closed Issues"
    value_format_name: decimal_0
    drill_fields: [issue_number, issue_state]
  }

  measure: count_open_issues {
    type: sum
    sql: CASE WHEN LOWER(${TABLE}.state) = 'open' THEN 1 ELSE 0 END ;;
    label: "Count Open Issues"
    value_format_name: decimal_0
    drill_fields: [issue_number, issue_state]
  }

  measure: avg_time_to_close_days {
    type: average
    sql: ${time_to_close_days} ;;
    label: "Avg Time To Close Days"
    value_format_name: decimal_1
  }

  measure: count_pull_request_issues {
    type: sum
    sql: CASE WHEN ${TABLE}.pull_request_url IS NOT NULL THEN 1 ELSE 0 END ;;
    label: "Count Pull Request Issues"
    value_format_name: decimal_0
    drill_fields: [issue_number]
  }
}
