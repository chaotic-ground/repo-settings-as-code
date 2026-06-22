locals {
  dependabot_labels = {
    dependencies   = { color = "0366d6", description = "Pull requests that update a dependency file" }
    docker         = { color = "21ceff", description = "Pull requests that update Docker code" }
    github_actions = { color = "000000", description = "Pull requests that update GitHub Actions code" }
    javascript     = { color = "168700", description = "Pull requests that update JavaScript code" }
    php            = { color = "45229e", description = "Pull requests that update Php code" }
    ruby           = { color = "ce2d2d", description = "Pull requests that update Ruby code" }
  }
}

import {
  id = "repo-settings-as-code:dependencies"
  to = github_issue_label.dependabot["dependencies"]
}
import {
  id = "repo-settings-as-code:github_actions"
  to = github_issue_label.dependabot["github_actions"]
}
resource "github_issue_label" "dependabot" {
  for_each = toset([
    "dependencies",
    "github_actions",
  ])

  repository  = github_repository.this.name
  name        = each.key
  color       = local.dependabot_labels[each.key].color
  description = local.dependabot_labels[each.key].description
}
