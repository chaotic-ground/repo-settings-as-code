# Dependabot's labels, with the colours and descriptions it uses when it
# auto-creates them. A repository whose dependabot.yml sets a custom `labels:`
# must declare them up front, because Dependabot does not create labels it was
# told to use; it only auto-creates the defaults. The full set lives here so it
# can be reused: copy this file into another repo's OpenTofu config and set
# `enabled` to the labels that repo's dependabot.yml references.
#
# For a repo where Dependabot has not created these yet, drop the import blocks
# below and OpenTofu will create them; keep an import block for any label that
# already exists (as the two here do).
locals {
  dependabot_labels = {
    dependencies   = { color = "0366d6", description = "Pull requests that update a dependency file" }
    docker         = { color = "21ceff", description = "Pull requests that update Docker code" }
    github_actions = { color = "000000", description = "Pull requests that update GitHub Actions code" }
    javascript     = { color = "168700", description = "Pull requests that update JavaScript code" }
    php            = { color = "45229e", description = "Pull requests that update Php code" }
    ruby           = { color = "ce2d2d", description = "Pull requests that update Ruby code" }
  }

  # The labels this repository's dependabot.yml uses.
  enabled_dependabot_labels = ["dependencies", "github_actions"]
}

resource "github_issue_label" "dependabot" {
  for_each = toset(local.enabled_dependabot_labels)

  repository  = github_repository.this.name
  name        = each.key
  color       = local.dependabot_labels[each.key].color
  description = local.dependabot_labels[each.key].description
}

import {
  id = "repo-settings-as-code:dependencies"
  to = github_issue_label.dependabot["dependencies"]
}
import {
  id = "repo-settings-as-code:github_actions"
  to = github_issue_label.dependabot["github_actions"]
}
