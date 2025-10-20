view: github_repository_base {
  extension: required
  sql_table_name: staccato_github.repositories ;;

  dimension: repository_id {
    type: number
    sql: ${TABLE}.id ;;
    primary_key: yes
    label: "Repository ID"
    group_label: "Identifiers"
  }

  dimension: repository_name {
    type: string
    sql: ${TABLE}.name ;;
    label: "Repository Name"
    group_label: "Identifiers"
  }

  dimension: repository_full_name {
    type: string
    sql: ${TABLE}.full_name ;;
    label: "Repository Full Name"
    description: "Owner and repository name combined."
    group_label: "Identifiers"
  }

  dimension: owner_login {
    type: string
    sql: ${TABLE}.owner_login ;;
    label: "Owner Login"
    group_label: "Ownership"
  }

  dimension: owner_type {
    type: string
    sql: ${TABLE}.owner_type ;;
    label: "Owner Type"
    description: "Type of the repository owner such as User or Organization."
    group_label: "Ownership"
  }

  dimension: is_private {
    type: yesno
    sql: ${TABLE}.private ;;
    label: "Is Private"
    group_label: "Status"
  }

  dimension: repository_description {
    type: string
    sql: ${TABLE}.description ;;
    label: "Repository Description"
    group_label: "Details"
  }

  dimension_group: created {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_at ;;
    label: "Created"
    group_label: "Timeline"
  }

  dimension_group: pushed {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.pushed_at ;;
    label: "Last Push"
    description: "Timestamp of the latest push event on the repository."
    group_label: "Timeline"
  }

  dimension_group: updated {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.updated_at ;;
    label: "Updated"
    group_label: "Timeline"
  }

  dimension: default_branch {
    type: string
    sql: ${TABLE}.default_branch ;;
    label: "Default Branch"
    group_label: "Details"
  }

  dimension: homepage_url {
    type: string
    sql: ${TABLE}.homepage ;;
    label: "Homepage URL"
    description: "Repository homepage configured in GitHub."
    group_label: "Details"
  }

  dimension: primary_language {
    type: string
    sql: ${TABLE}.language ;;
    label: "Primary Language"
    description: "Primary programming language reported by GitHub."
    group_label: "Details"
  }
}
