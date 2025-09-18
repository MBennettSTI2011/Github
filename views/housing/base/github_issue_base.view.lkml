view: github_issue_base {
  extension: required
  sql_table_name: staccato_github.issues ;;
  primary_key: issue_id

  dimension: issue_id {
    type: number
    sql: ${TABLE}.id ;;
    label: "Issue ID"
    group_label: "Identifiers"
  }

  dimension: issue_number {
    type: number
    sql: ${TABLE}.number ;;
    label: "Issue Number"
    group_label: "Identifiers"
  }

  dimension: repository_id {
    type: number
    sql: ${TABLE}.repository_id ;;
    label: "Repository ID"
    group_label: "Relationships"
  }

  dimension: issue_title {
    type: string
    sql: ${TABLE}.title ;;
    label: "Issue Title"
    group_label: "Details"
  }

  dimension: issue_state {
    type: string
    sql: ${TABLE}.state ;;
    label: "Issue State"
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
    description: "Login of the user who created the issue."
    group_label: "People"
  }

  dimension: assignee_login {
    type: string
    sql: ${TABLE}.assignee_login ;;
    label: "Assignee Login"
    description: "Login of the current assignee."
    group_label: "People"
  }

  dimension: comments_count {
    type: number
    sql: COALESCE(${TABLE}.comments, 0) ;;
    label: "Comments Count"
    group_label: "Engagement"
  }

  dimension: milestone_title {
    type: string
    sql: ${TABLE}.milestone_title ;;
    label: "Milestone Title"
    group_label: "Details"
  }

  dimension: issue_labels {
    type: string
    sql: ${TABLE}.labels ;;
    label: "Issue Labels"
    description: "Comma separated list of labels applied to the issue."
    group_label: "Details"
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
    description: "Timestamp when the issue was closed."
    group_label: "Timeline"
  }
}
