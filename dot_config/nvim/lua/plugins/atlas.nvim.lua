---@module "atlas"
return {
  "emrearmagan/atlas.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional but recommended
    "MeanderingProgrammer/render-markdown.nvim", -- optional but recommended
    -- "esmuellert/codediff.nvim", -- optional (PullRequest diff)
    -- "sindrets/diffview.nvim", -- optional; or "dlyongemallo/diffview-plus.nvim"
  },
  keys = {
    { "<leader>gp", "<cmd>Atlas pulls<CR>", desc = "Atlas - Open pull requests" },
    { "<leader>gc", "<cmd>Atlas create pr<CR>", desc = "Atlas - Create PR" },
  },
  -- See Configuration below
  ---@type AtlasConfig
  opts = {
    providers = {
      ---@type AtlasGitHubConfig
      github = {
        enabled = true,
        -- token = os.getenv("GITHUB_TOKEN"),
        username = "bmarden",
      },
    },
    pulls = {
      -- delete_notes = false, -- Delete local PR notes after approval or merge.
      default_merge_method = "squash",
      default_delete_branch = false,
      git_transport = "ssh", -- "https" or "ssh" for Atlas-managed Git remotes.

      -- Replaces the built-in Conventional Comments templates.
      -- comment_templates = {
      --   insert_mode = true, -- Enter Insert mode after applying a template.
      --   items = {
      --     { label = "Suggestion", text = "suggestion: " },
      --     { label = "Issue", text = "issue: " },
      --     { label = "Nitpick", text = "nitpick: " },
      --   },
      -- },

      diff = {
        -- Any command that accepts explicit <base>...<head> Git revisions.
        comment_display = "virtual_lines", -- "virtual_lines" or compact "virtual_text" hints.
        review_panel = {
          hidden = true, -- Set false to show the review panel when a diff opens.
          height = 10,
        },

        -- AtlasDiff options; external viewers use their own configuration.
        layout = "inline", -- "inline" or "side-by-side".
        compact = true, -- Start with only changed hunks and surrounding context visible.
        compact_context_lines = 3, -- Context lines shown around hunks in compact mode.
        lsp = {
          enabled = true,
          link = {
            "node_modules",
            ".venv",
          },
        },
        explorer = {
          grouped = true, -- Group changed files by directory.
          hidden = false,
          show_commits = false, -- Set true to show commits below changed files initially.
          width = 40,
          initial_focus = "explorer", -- "explorer" or "diff".
          preview = false, -- Show a file as soon as the explorer cursor moves onto it.
          ignore = { ".git/**", ".jj/**" },
        },
      },
      repo_config = {
        -- Maps `workspace/repo` to local paths. Used for checkout, diffs, and custom actions.
        paths = {
          ["Amenity-Health/*"] = "~/code/*",
        },
        -- settings = {
        --   ["your-workspace/atlas"] = {
        --     readme = "README.md", -- optional, defaults to README.md
        --     pr_template = ".github/pull_request_template.md", -- optional, defaults to .github/pull_request_template.md
        --   },
        -- },
      },
      ---@type AtlasGitHubPullsConfig
      github = {
        ---@type AtlasGitHubViewConfig[]
        views = {
          {
            name = "Repo",
            key = "1",
            layout = "grouped",
            -- search = "repo:your-org/your-repo",
            current_repo = true,
          },
          {
            name = "Team",
            key = "2",
            layout = "compact",
            search = "org:amenity-health sort:updated-desc",
          },
          {
            name = "My PRs",
            key = "3",
            layout = "plain", -- "compact", "grouped", or "plain"
            search = "author:@me sort:updated-desc",
          },
        },
        bookmarks = {
          key = "S", -- default
          label = "Search", -- default
          items = {
            ["Drafts"] = "is:pr is:draft author:@me",
            ["Review requested"] = "is:pr team-review-requested-user:@me state:open archived:false sort:updated-desc",
            ["Recently merged"] = "is:pr is:merged author:@me sort:updated-desc",
            -- ["Review requested"] = "is:pr is:open review-requested:@me",
          },
        },
      },
    },
    keymaps = {
      pulls = {
        review = {
          diff = {
            add_note = "<localleader>n",
          },
        },
      },
    },
  },
}
