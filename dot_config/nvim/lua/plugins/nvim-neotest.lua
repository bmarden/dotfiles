return {
  "nvim-neotest/neotest",
  dependencies = {
    -- adapters
    { "fredrikaverpil/neotest-golang" },
  },
  opts = {
    adapters = {
      ["neotest-golang"] = {
        runner = "gotestsum",
        -- args = { "-coverprofile=" .. vim.fn.getcwd() .. "/coverage/coverage.out" },
      },
    },
  },
}
