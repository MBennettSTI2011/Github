view: github_pull_request_housing_hub {
  extends: [github_pull_request_base]
  view_label: "GitHub Housing Hub"

  dimension: pull_request_url {
    type: string
    sql: ${TABLE}.html_url ;;
    label: "Pull Request URL"
    description: "Link to the pull request on GitHub."
    group_label: "Details"
  }

  dimension: head_ref {
    type: string
    sql: ${TABLE}.head_ref ;;
    label: "Head Ref"
    description: "Source branch name for the pull request."
    group_label: "Details"
  }

  dimension: base_ref {
    type: string
    sql: ${TABLE}.base_ref ;;
    label: "Base Ref"
    description: "Target branch for the pull request merge."
    group_label: "Details"
  }

  dimension: is_merged {
    type: yesno
    sql: CASE WHEN ${merged_raw} IS NULL THEN 0 ELSE 1 END ;;
    label: "Is Merged"
    group_label: "Status"
  }

  dimension: time_to_merge_hours {
    type: number
    sql: CASE
          WHEN ${merged_raw} IS NULL THEN NULL
          ELSE CAST(DATEDIFF(hour, ${created_raw}, ${merged_raw}) AS DECIMAL(18, 2))
        END ;;
    label: "Time To Merge Hours"
    description: "Number of hours from creation to merge for merged pull requests."
    group_label: "Timeline"
    value_format_name: decimal_2
  }

  dimension: time_open_hours {
    type: number
    sql: CASE
          WHEN ${closed_raw} IS NULL THEN CAST(DATEDIFF(hour, ${created_raw}, GETDATE()) AS DECIMAL(18, 2))
          ELSE CAST(DATEDIFF(hour, ${created_raw}, ${closed_raw}) AS DECIMAL(18, 2))
        END ;;
    label: "Time Open Hours"
    description: "Hours a pull request has been open based on current or closed time."
    group_label: "Timeline"
    value_format_name: decimal_2
  }

  measure: count_pull_requests {
    type: count_distinct
    sql: ${pull_request_id} ;;
    label: "Count Pull Requests"
    value_format_name: decimal_0
    drill_fields: [pull_request_number, pull_request_title]
  }

  measure: count_open_pull_requests {
    type: sum
    sql: CASE WHEN LOWER(${TABLE}.state) = 'open' THEN 1 ELSE 0 END ;;
    label: "Count Open Pull Requests"
    value_format_name: decimal_0
    drill_fields: [pull_request_number, pull_request_state]
  }

  measure: count_closed_pull_requests {
    type: sum
    sql: CASE WHEN LOWER(${TABLE}.state) = 'closed' THEN 1 ELSE 0 END ;;
    label: "Count Closed Pull Requests"
    value_format_name: decimal_0
    drill_fields: [pull_request_number, pull_request_state]
  }

  measure: count_merged_pull_requests {
    type: sum
    sql: CASE WHEN ${merged_raw} IS NOT NULL THEN 1 ELSE 0 END ;;
    label: "Count Merged Pull Requests"
    value_format_name: decimal_0
    drill_fields: [pull_request_number, merged]
  }

  measure: total_additions {
    type: sum
    sql: COALESCE(${TABLE}.additions, 0) ;;
    label: "Total Additions"
    value_format_name: decimal_0
    drill_fields: [pull_request_number, additions_count]
  }

  measure: total_deletions {
    type: sum
    sql: COALESCE(${TABLE}.deletions, 0) ;;
    label: "Total Deletions"
    value_format_name: decimal_0
    drill_fields: [pull_request_number, deletions_count]
  }

  measure: total_changed_files {
    type: sum
    sql: COALESCE(${TABLE}.changed_files, 0) ;;
    label: "Total Changed Files"
    value_format_name: decimal_0
    drill_fields: [pull_request_number, changed_files_count]
  }

  measure: total_comments {
    type: sum
    sql: COALESCE(${TABLE}.comments, 0) ;;
    label: "Total Comments"
    value_format_name: decimal_0
    drill_fields: [pull_request_number, comments_count]
  }

  measure: total_review_comments {
    type: sum
    sql: COALESCE(${TABLE}.review_comments, 0) ;;
    label: "Total Review Comments"
    value_format_name: decimal_0
    drill_fields: [pull_request_number, review_comments_count]
  }

  measure: avg_time_to_merge_hours {
    type: average
    sql: ${time_to_merge_hours} ;;
    label: "Avg Time To Merge Hours"
    value_format_name: decimal_2
  }

  measure: avg_time_open_hours {
    type: average
    sql: ${time_open_hours} ;;
    label: "Avg Time Open Hours"
    value_format_name: decimal_2
  }
}
