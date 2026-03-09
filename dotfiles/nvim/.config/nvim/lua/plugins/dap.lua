return {
	{
		"jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = { "local-lua-debugger-vscode" },
  },
		config = function()
			require("mason-nvim-dap").setup({
				automatic_installation = true,
			  ensure_installed = { "local-lua-debugger-vscode" },
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = { "jay-babu/mason-nvim-dap.nvim" }, -- ensure correct processing order
    config = function()
      local dap = require("dap")
      -- define the debug adapter
      dap.adapters["local-lua"] = {
        type = "executable",
        command = "node", -- assuming you have node installed
        args = {
          "~/.local/share/nvim/mason/packages/local-lua-debugger-vscode/extension/extension/debugAdapter.js",
        },
      }

      -- Define the launch configuration for Love2D
      dap.configurations.lua = {
        {
          name = "Debug Love2D Project",
          type = "local-lua",
          request = "launch",
          cwd = "${workspaceFolder}", -- Start from your project root
          program = {
            command = "love",
          },
          args = { "." },
          -- scriptRoots = { "${workspaceFolder}" } -- may be needed depending on adapter
        },
      }

    end
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dapui = require("dapui")
      dapui.setup()
    end
	},
}

-- {
-- 	{
-- 		"mfussenegger/nvim-dap",
-- 		config = function()
-- 			local dap = require("dap")
-- 			dap.adapters["local-lua"] = {
-- 				type = "executable",
-- 				command = "node", -- or the command to run your specific debug adapter
-- 				args = {
-- 					-- Example path, adjust as necessary:
-- 					-- "/usr/lib/node_modules/local-lua-debugger-vscode/extension/debugAdapter.js"
-- 					-- Or if installed globally, npm might resolve it:
-- 					vim.fn.expand("~/.npm-global/lib/node_modules/local-lua-debugger-vscode/extension/debugAdapter.js"),
-- 				},
-- 				-- enrich_config is often needed to set the correct extension path for the debugger to find its 'lldebugger' module.
-- 				enrich_config = function(config, on_config)
-- 					-- Example path, adjust as necessary:
-- 					-- config.extensionPath = "/usr/lib/node_modules/local-lua-debugger-vscode/"
-- 					config.extensionPath = vim.fn.expand("~/.npm-global/lib/node_modules/local-lua-debugger-vscode/")
-- 					on_config(config)
-- 				end,
-- 			}
-- 			dap.configurations.lua = {
-- 				{
-- 					name = "Debug Love",
-- 					type = "local-lua",
-- 					request = "launch",
-- 					cwd = "${workspaceFolder}",
-- 					program = {
-- 						command = "love",
-- 					},
-- 					args = { "." },
-- 					scriptRoots = { "." },
-- 				},
-- 			}
-- 		end,
-- 	},
-- 	{ "nvim-neotest/nvim-nio" }, -- async io
-- 	{
-- 		"rcarriga/nvim-dap-ui", -- debuger ui
-- 		config = function()
-- 			require("dapui").setup({})
-- 		end,
-- 	},
-- }
