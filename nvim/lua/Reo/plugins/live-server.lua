return {
	"barrett-ruth/live-server.nvim",

	config = function()
		require("live-server").setup({
			build = "npm install -g live-server",
			cmd = { "live-server", "live-server" },
			config = true,
		})
	end,
}
