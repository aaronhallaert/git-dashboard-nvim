M = {}

M.create_dashboard_update_on_shell_cmd = function()
	-- create an autocommand on BufWritePost when a command is ran using :! to call the dashboard redraw from require('dashboard')
	vim.api.nvim_create_autocmd({ "ShellCmdPost" }, {
		callback = function()
			-- for users who have dashboard-nvim installed
			if package.loaded.dashboard ~= nil then
				if vim.bo.filetype ~= "dashboard" then
					return
				end

				vim.cmd("silent! Lazy reload dashboard-nvim")

				vim.bo.modifiable = true
				vim.cmd("silent! %d")
				vim.cmd("silent! Dashboard")
				vim.bo.modifiable = false
			end
		end,
	})
end

M.parse_date = function(date)
	local year, month, day = date:match("(%d+)-(%d+)-(%d+)")
	local week = os.date("%U", os.time({ year = year, month = month, day = day }))
	local day_of_week = os.date("%w", os.time({ year = year, month = month, day = day }))

	return {
		year = tonumber(year),
		month = tonumber(month),
		day = tonumber(day),
		week = tonumber(week),
		day_of_week = tonumber(day_of_week),
	}
end

return M
