view: github_pull_request_base {
  extension: required
  sql_table_name: staccato_github.pull_requests ;;
  primary_key: pull_request_id

  dimension: pull_request_id {
    type: number
    sql: ${TABLE}.id ;;
    label: "Pull Request ID"
    group_label: "Identifiers"
  }

  dimension: pull_request_number {
    type: number
    sql: ${TABLE}.number ;;
    label: "Pull Request Number"
    group_label: "Identifiers"
  }

  dimension: repository_id {
    type: number
    sql: ${TABLE}.base_repository_id ;;
    label: "Repository ID"
    group_label: "Relationships"
  }

  dimension: head_repository_id {
    type: number
    sql: ${TABLE}.head_repository_id ;;
    label: "Head Repository ID"
    description: "Repository id for the source branch."
    group_label: "Relationships"
  }

  dimension: pull_request_title {
    type: string
    sql: ${TABLE}.title ;;
    label: "Pull Request Title"
    group_label: "Details"
  }

  dimension: pull_request_state {
    type: string
    sql: ${TABLE}.state ;;
    label: "Pull Request State"
    group_label: "Status"
  }

  dimension: is_draft {
    type: yesno
    sql: ${TABLE}.is_draft ;;
    label: "Is Draft"
    group_label: "Status"
  }

  dimension: is_locked {
    type: yesno
    sql: ${TABLE}.locked ;;
    label: "Is Locked"
    group_label: "Status"
  }

  dimension: author_login {
    type: string
    sql: ${TABLE}.user_login ;;
    label: "Author Login"
    description: "Login of the user who opened the pull request."
    group_label: "People"
  }

  dimension: merged_by_login {
    type: string
    sql: ${TABLE}.merged_by_login ;;
    label: "Merged By Login"
    description: "Login of the user who merged the pull request."
    group_label: "People"
  }

  dimension: additions_count {
    type: number
    sql: COALESCE(${TABLE}.additions, 0) ;;
    label: "Additions Count"
    group_label: "Code Metrics"
  }

  dimension: deletions_count {
    type: number
    sql: COALESCE(${TABLE}.deletions, 0) ;;
    label: "Deletions Count"
    group_label: "Code Metrics"
  }

  dimension: changed_files_count {
    type: number
    sql: COALESCE(${TABLE}.changed_files, 0) ;;
    label: "Changed Files Count"
    group_label: "Code Metrics"
  }

  dimension: comments_count {
    type: number
    sql: COALESCE(${TABLE}.comments, 0) ;;
    label: "Comments Count"
    group_label: "Engagement"
  }

  dimension: review_comments_count {
    type: number
    sql: COALESCE(${TABLE}.review_comments, 0) ;;
    label: "Review Comments Count"
    group_label: "Engagement"
  }

  dimension_group: created {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_at ;;
    label: "Created"
    group_label: "Timeline"
  }

  dimension_group: updated {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.updated_at ;;
    label: "Updated"
    group_label: "Timeline"
  }

  dimension_group: closed {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.closed_at ;;
    label: "Closed"
    group_label: "Timeline"
  }

  dimension_group: merged {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.merged_at ;;
    label: "Merged"
    description: "Timestamp when the pull request was merged."
    group_label: "Timeline"
  }
}
