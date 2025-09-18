view: geo_housing_hub {
  derived_table: {
    sql:
      SELECT
        r.owner_login,
        r.owner_type,
        MAX(r.owner_location) AS owner_location,
        MAX(r.owner_latitude) AS owner_latitude,
        MAX(r.owner_longitude) AS owner_longitude
      FROM staccato_github.repositories AS r
      GROUP BY r.owner_login, r.owner_type ;;
    sql_trigger_value: SELECT CONVERT(VARCHAR(19), GETDATE(), 120) ;;
  }
  primary_key: owner_login

  dimension: owner_login {
    type: string
    sql: ${TABLE}.owner_login ;;
    label: "Owner Login"
    group_label: "Identifiers"
  }

  dimension: owner_type {
    type: string
    sql: ${TABLE}.owner_type ;;
    label: "Owner Type"
    description: "User or organization classification of the owner."
    group_label: "Details"
  }

  dimension: owner_location_name {
    type: string
    sql: ${TABLE}.owner_location ;;
    label: "Owner Location Name"
    group_label: "Location"
  }

  dimension: owner_latitude {
    type: number
    sql: ${TABLE}.owner_latitude ;;
    label: "Owner Latitude"
    group_label: "Location"
    value_format_name: decimal_4
  }

  dimension: owner_longitude {
    type: number
    sql: ${TABLE}.owner_longitude ;;
    label: "Owner Longitude"
    group_label: "Location"
    value_format_name: decimal_4
  }

  dimension: owner_location {
    type: location
    sql_latitude: ${owner_latitude}
    sql_longitude: ${owner_longitude}
    label: "Owner Location"
    description: "Geographic location of the repository owner based on profile settings."
    group_label: "Location"
  }

  measure: count_owners {
    type: count_distinct
    sql: ${owner_login} ;;
    label: "Count Owners"
    value_format_name: decimal_0
    drill_fields: [owner_login, owner_location_name]
  }
}
