return {
  "leoluz/nvim-dap-go",
  lazy = true,
  opts = {
    dap_configurations = {
      {
        type = "go",
        name = "Debug Member Backend API",
        request = "launch",
        program = "${workspaceFolder}/cmd/api",
        outputMode = "remote",
      },
    },
  },
}
