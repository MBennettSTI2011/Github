###################################################################################
# This is a read-only file! Its contents can be edited through the Marketplace UI #
# See the docs at: https://cloud.google.com/looker/docs/data-modeling/marketplace              #
###################################################################################

marketplace_ref: {
  listing: "github-v2"
  version: "2.0.3"
  models: ["block-github-v2"]
  override_constant: CONNECTION_NAME { value:"github-connection" }
  override_constant: GITHUB_SCHEMA { value:"source_github" }
  override_constant: COMPANY_DOMAIN { value:"highspew" }
}
