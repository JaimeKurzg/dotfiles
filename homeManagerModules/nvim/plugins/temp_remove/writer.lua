return {
	"folke/zen-mode.nvim",
	dependencies = {
		"nathanlong/vim-colors-writer",
		"junegunn/limelight.vim",
		"nvim-lualine/lualine.nvim",
	},
	opts = {
		window = {
			backdrop = 1,
			width = .80
		},
		plugins = {
			options = {
				laststatus = 2,
			},
		},
	},

	config = function()
		local function WordCount()
			return tostring(vim.fn.wordcount().words .. " words")
		end
		local function display_wc()
			local theme = require 'lualine.themes.onedark'

			require('lualine').setup {
				options = {
					theme = theme
				},

				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "hello" },
					lualine_x = { WordCount },
					lualine_y = {},
					lualine_z = {},
				}
			}
		end

		local function remove_wc()
			require('lualine').hide({
				place = { 'statusline', 'tabline', 'winbar' },
				unhide = false,
			})
		end


		local toggle_val = 0
		local default_color = vim.g.colors_name

		local function toggle()
			require("zen-mode").setup({
				window = {
					backdrop = 1,
					width = .80
				},
				plugins = {
					options = {
						laststatus = 2,
					},
				},
			})
			require("zen-mode").toggle()
			vim.api.nvim_command("Limelight!!")
			if toggle_val == 0 then
				default_color = vim.g.colors_name

				vim.cmd.colorscheme("writer")
				vim.opt.background = "light"
				display_wc()
				vim.opt.linebreak = true
				vim.opt.number = false
				vim.opt.relativenumber = false
				vim.opt.wrap = true
				toggle_val = 1
			else
				vim.cmd.colorscheme(default_color)
				vim.opt.background = "dark"
				remove_wc()
				require("config.options")

				toggle_val = 0
			end
		end
		vim.keymap.set("n", ",w", function()
			toggle()
		end)
	end
}
