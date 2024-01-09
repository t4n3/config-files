return {
	"mfussenegger/nvim-dap",

	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-telescope/telescope-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},

	keys = {
		{ "<F5>", "<cmd>DapContinue<cr>", desc = "Debugger continue" },
		{ "<S-F5>", "<cmd>DapTerminate<cr>", desc = "Debugger terminate" },
		{ "<F10>", "<cmd>DapStepOver<cr>", desc = "Debugger step over" },
		{ "<F11>", "<cmd>DapStepInto<cr>", desc = "Debugger step into" },
		{ "<S-F11>", "<cmd>DapStepOut<cr>", desc = "Debugger step out" },

		{ "<leader>bb", "<cmd>DapToggleBreakpoint<cr>", desc = "Debugger toggle breakpoint" },
		{ "<leader>bB", "<cmd>Telescope dap list_breakpoints<cr>", desc = "Debugger list breakpoints" },
		{ "<leader>bu", "<cmd>lua require('dapui').toggle()<cr>", desc = "Debugger toogle UI" },
	},

	config = function()
		require("dapui").setup()

		local dap, dapui = require("dap"), require("dapui")
        local keymap = vim.keymap

		-- TODO: Set up with gdp
		-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-gdb

		dap.adapters.lldb = {
			type = "executable",
			command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
			name = "lldb",
		}

		dap.configurations.c = {
			{
				type = "lldb",
				request = "launch",
				name = "Launch project",
				program = "${workspaceFolder}/bin/program",
				cwd = "${workspaceFolder}",
				runInTerminal = true,
				--environment = {
				--	{ name = "DYLD_LIBRARY_PATH", value = "/Users/tane/tools/VulkanSDK/1.3.268.1/macOS/lib" },
                --    { name = "VK_LAYER_PATH", value = "/Users/tane/tools/VulkanSDK/1.3.268.1/macOS/share/vulkan/explicit_layer.d"},
                --    { name = "VK_ICD_FILENAMES", value = "/Users/tane/tools/VulkanSDK/1.3.268.1/macOS/share/vulkan/icd.d" },
                --    { name = "VK_SDK_PATH", value = "/Users/tane/tools/VulkanSDK/1.3.268.1"},
				--},
			},
		}

		-- Automaticly open and close debugger UI
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- Map K to hover while session is active.
		local api = vim.api
		local keymap_restore = {}
		dap.listeners.after["event_initialized"]["me"] = function()
			for _, buf in pairs(api.nvim_list_bufs()) do
				local keymaps = api.nvim_buf_get_keymap(buf, "n")
				for _, keymap in pairs(keymaps) do
					if keymap.lhs == "K" then
						table.insert(keymap_restore, keymap)
						api.nvim_buf_del_keymap(buf, "n", "K")
					end
				end
			end
			api.nvim_set_keymap("n", "K", '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
		end

		dap.listeners.after["event_terminated"]["me"] = function()
			for _, keymap in pairs(keymap_restore) do
				api.nvim_buf_set_keymap(
					keymap.buffer,
					keymap.mode,
					keymap.lhs,
					keymap.rhs,
					{ silent = keymap.silent == 1 }
				)
			end
			keymap_restore = {}
		end

        -- Map 'q' to quit hover window
        vim.api.nvim_create_autocmd({"BufEnter", "BufAdd"} , {
            pattern = "*",  -- Match all buffers
            callback = function()
                -- Check if the buffer name includes "dap-hover"
                local bufname = vim.api.nvim_buf_get_name(0)
                if string.match(bufname, "dap%-hover") then
                    -- Your code here, e.g., print a message
                    print("Entered a dap-hover buffer: " .. bufname)
                    keymap.set("n", "q", "<cmd>q<cr>")
                end
            end
        })
        vim.api.nvim_create_autocmd("BufLeave", {
            pattern = "*",  -- Match all buffers
            callback = function()
                -- Check if the buffer name includes "dap-hover"
                local bufname = vim.api.nvim_buf_get_name(0)
                if string.match(bufname, "dap%-hover") then
                    -- Your code here, e.g., print a message
                    print("Leaved a dap-hover buffer: " .. bufname)
                    keymap.set("n", "q", "")
                end
            end
        })

	end,
}
