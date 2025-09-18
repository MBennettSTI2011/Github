view: github_repository_housing_hub {
  extends: [github_repository_base]
  view_label: "GitHub Housing Hub"

  dimension: repository_url {
    type: string
    sql: CONCAT('https://github.com/', ${repository_full_name}) ;;
    label: "Repository URL"
    description: "Link to the repository on GitHub."
    group_label: "Details"
  }

  dimension: topics {
    type: string
    sql: ${TABLE}.topics ;;
    label: "Topics"
    description: "Comma separated list of repository topics."
    group_label: "Details"
  }

  dimension: stargazers_count {
    type: number
    sql: COALESCE(${TABLE}.stargazers_count, 0) ;;
    label: "Stargazers Count"
    group_label: "Metrics"
  }

  dimension: watchers_count {
    type: number
    sql: COALESCE(${TABLE}.watchers_count, 0) ;;
    label: "Watchers Count"
    group_label: "Metrics"
  }

  dimension: forks_count {
    type: number
    sql: COALESCE(${TABLE}.forks_count, 0) ;;
    label: "Forks Count"
    group_label: "Metrics"
  }

  dimension: open_issues_count {
    type: number
    sql: COALESCE(${TABLE}.open_issues_count, 0) ;;
    label: "Open Issues Count"
    group_label: "Metrics"
  }

  dimension: repository_size_mb {
    type: number
    sql: COALESCE(${TABLE}.size, 0) / 1024.0 ;;
    label: "Repository Size MB"
    description: "Repository size in megabytes based on GitHub reported size."
    group_label: "Metrics"
    value_format_name: decimal_2
  }

  measure: count_repositories {
    type: count_distinct
    sql: ${repository_id} ;;
    label: "Count Repositories"
    value_format_name: decimal_0
    drill_fields: [repository_name, owner_login]
  }

  measure: total_stars {
    type: sum
    sql: COALESCE(${TABLE}.stargazers_count, 0) ;;
    label: "Total Stars"
    value_format_name: decimal_0
    drill_fields: [repository_name, stargazers_count]
  }

  measure: total_forks {
    type: sum
    sql: COALESCE(${TABLE}.forks_count, 0) ;;
    label: "Total Forks"
    value_format_name: decimal_0
    drill_fields: [repository_name, forks_count]
  }

  measure: total_open_issues {
    type: sum
    sql: COALESCE(${TABLE}.open_issues_count, 0) ;;
    label: "Total Open Issues"
    value_format_name: decimal_0
    drill_fields: [repository_name, open_issues_count]
  }

  measure: avg_open_issues {
    type: average
    sql: COALESCE(${open_issues_count}, 0) ;;
    label: "Avg Open Issues"
    value_format_name: decimal_2
  }

  measure: count_private_repositories {
    type: sum
    sql: CASE WHEN COALESCE(${TABLE}.private, 0) = 1 THEN 1 ELSE 0 END ;;
    label: "Count Private Repositories"
    value_format_name: decimal_0
    drill_fields: [repository_name]
  }

  measure: total_watchers {
    type: sum
    sql: COALESCE(${TABLE}.watchers_count, 0) ;;
    label: "Total Watchers"
    value_format_name: decimal_0
    drill_fields: [repository_name, watchers_count]
  }
}
