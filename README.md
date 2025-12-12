# GitHub Housing Hub LookML

## Project Overview
- **Business purpose:** Provide a Housing Hub foundation for GitHub repository health, pull request velocity, and issue management so departmental “chambers” can reuse a common semantic layer.
- **Technical scope:** Single model (`github_housing_hub`) that includes explores, base views, and refinements; depends on the `StaccatoDW_HousingHub` project for shared geography and housing components.
- **Connection & schema:** Uses the `staccatodw` connection targeting the `staccato_github` schema for core GitHub tables.

## Models
| Model | Description | Includes |
| --- | --- | --- |
| `github_housing_hub` | Hub model exposing GitHub repository, pull request, and issue explores built on the Housing Hub pattern. | `views/**/*.view.lkml`, `explores/**/*.explore.lkml`

## Explores
### `github_repository_housing_hub`
- **Business focus:** Repository footprint, ownership, and engagement baselines for downstream chambers.
- **Technical notes:**
  - Base view: `github_repository_base`.
  - Joins: `geo_housing_hub` (many_to_one, left_outer) to enrich repository owners with geographic context from the Housing Hub dependency.
  - Sets: `repository_insights` grouping repository totals and owner metadata.

### `github_pull_request_housing_hub`
- **Business focus:** Pull request lifecycle efficiency, merge throughput, and code change volumes.
- **Technical notes:**
  - Base view: `github_pull_request_base` with refinements applied from `github__pull_request_base` and `pull_request` overlays.
  - Joins: `github_repository_housing_hub` (many_to_one, left_outer) for repository context; `geo_housing_hub` (many_to_one, left_outer) for owner geography.
  - Sets: `pull_request_efficiency` covering counts, merge velocity, and code churn metrics.

### `github_issue_housing_hub`
- **Business focus:** Issue backlog health, closure performance, and owner-level aggregation.
- **Technical notes:**
  - Base view: `github_issue_base` with lifecycle and performance refinements from `github_issue_base` and `github_issue_housing_hub` overlays.
  - Joins: `github_repository_housing_hub` (many_to_one, left_outer) for repository linkage; `geo_housing_hub` (many_to_one, left_outer) for owner geography.
  - Sets: `issue_performance` grouping counts, closure timing, and repository owner metadata.

## Views and Refinements
### Base Views (Housing Hub)
| View | Primary Key | Purpose | Key Fields |
| --- | --- | --- | --- |
| `github_repository_base` | `repository_id` | Core repository metadata for Housing Hub joins. | Owner login/type, privacy flag, default branch, primary language, created/pushed/updated dates. |
| `github_pull_request_base` | `pull_request_id` | Pull request lifecycle and code change detail. | Draft/locked flags, additions/deletions, file counts, comment counts, author/merger logins, created/updated/closed/merged dates. |
| `github_issue_base` | `issue_id` | Issue lifecycle foundation. | Issue number/title/state, locked flag, author/assignee logins, milestone and labels, comments count, created/updated/closed timestamps. |

### Refinements and Overlays
| Refinement View | Purpose | Notable Fields |
| --- | --- | --- |
| `github__pull_request_base` (refinement) | Adds date dimensions, merge status, and performance metrics on the base pull request view. | `is_merged`, `merge_duration_days`, `count_pull_requests`, `count_merged_pull_requests`, `total_additions`, `total_deletions`, `avg_merge_duration_days`. |
| `pull_request` (overlay) | Adds richer timeline dimensions and lifecycle labeling for PRs. | `created`, `merged`, `updated` dimension_groups; `merge_status`; `total_pull_requests`, `total_merged_pull_requests`, `total_open_pull_requests`, `avg_merge_time_hours`. |
| `github_issue_base` (refinement) | Extends issue base with status and resolution metrics. | `is_open`, `resolution_time_days`, `count_issues`, `count_open_issues`, `avg_resolution_time_days`. |
| `github_issue_housing_hub` (overlay) | Adds lifecycle categorization and performance measures. | `hours_open`, `status_category`, `open_duration_category`, `total_issues`, `total_open_issues`, `total_closed_issues`, `avg_time_to_close_hours`, `avg_time_to_close_days`. |

## Dashboards
- No LookML dashboards are currently defined in this repository. Analytics are intended to be built on the explores above or within downstream chamber projects.

## Dependencies and Reuse
- Relies on the `StaccatoDW_HousingHub` local dependency for shared geography (`geo_housing_hub`) and any cross-chamber patterns.
- Housing Hub structure enables departmental chamber models to extend these explores while keeping consistent naming, grouping, and measure logic.

## Usage Notes
- Naming follows lowercase_with_underscores with primary keys defined on every view.
- Date handling uses Looker `dimension_group` patterns; timeframes include raw/date/week/month/year where applicable.
- Measures use explicit formatting (`value_format_name`) and yes/no flags are typed as `yesno` in line with Housing Hub conventions.
