return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	config = function()
		local luasnip = require("luasnip")

		-- Load custom snippets from Reo/snippets
		require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/Reo/snippets" })

		luasnip.config.set_config({
			history = true,
			updateevents = "TextChanged,TextChangedI",
			enable_autosnippets = true,
		})

		-- Keymaps for snippet navigation
		vim.keymap.set({ "i", "s" }, "<Tab>", function()
			return luasnip.expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<Tab>"
		end, { expr = true })

		vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
			return luasnip.jumpable(-1) and "<Plug>luasnip-jump-prev" or "<S-Tab>"
		end, { expr = true })
	end,
}
