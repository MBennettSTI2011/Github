explore: github_issue_housing_hub {
  label: "GitHub Issues"
  description: "Housing hub explore for GitHub issues with repository context."

  set: issue_performance {
    fields: [github_issue_housing_hub.count_issues,
             github_issue_housing_hub.count_open_issues,
             github_issue_housing_hub.count_closed_issues,
             github_issue_housing_hub.avg_time_to_close_days,
             github_repository_housing_hub.repository_name,
             github_repository_housing_hub.owner_login]
  }

  join: github_repository_housing_hub {
    type: left_outer
    relationship: many_to_one
    sql_on: ${github_issue_housing_hub.repository_id} = ${github_repository_housing_hub.repository_id} ;;
  }

  join: geo_housing_hub {
    type: left_outer
    relationship: many_to_one
    sql_on: ${github_repository_housing_hub.owner_login} = ${geo_housing_hub.owner_login} ;;
    fields: [geo_housing_hub.owner_location, geo_housing_hub.owner_location_name]
  }
}
