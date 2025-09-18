explore: github_pull_request_housing_hub {
  label: "GitHub Pull Requests"
  description: "Housing hub explore for pull request lifecycle, velocity, and code metrics."

  set: pull_request_efficiency {
    fields: [github_pull_request_housing_hub.count_pull_requests,
             github_pull_request_housing_hub.count_merged_pull_requests,
             github_pull_request_housing_hub.avg_time_to_merge_hours,
             github_pull_request_housing_hub.total_additions,
             github_pull_request_housing_hub.total_deletions,
             github_repository_housing_hub.repository_name]
  }

  join: github_repository_housing_hub {
    type: left_outer
    relationship: many_to_one
    sql_on: ${github_pull_request_housing_hub.repository_id} = ${github_repository_housing_hub.repository_id} ;;
  }

  join: geo_housing_hub {
    type: left_outer
    relationship: many_to_one
    sql_on: ${github_repository_housing_hub.owner_login} = ${geo_housing_hub.owner_login} ;;
  }
}
