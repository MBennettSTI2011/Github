explore: github_repository_housing_hub {
  label: "GitHub Repositories"
  description: "Central hub explore for repository level metrics and ownership context."

  set: repository_insights {
    fields: [github_repository_housing_hub.count_repositories,
             github_repository_housing_hub.total_stars,
             github_repository_housing_hub.total_forks,
             github_repository_housing_hub.total_open_issues,
             github_repository_housing_hub.owner_login,
             github_repository_housing_hub.repository_name,
             github_repository_housing_hub.primary_language]
  }

  join: geo_housing_hub {
    type: left_outer
    relationship: many_to_one
    sql_on: ${github_repository_housing_hub.owner_login} = ${geo_housing_hub.owner_login} ;;
  }
}
