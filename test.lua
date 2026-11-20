local function perf(fn, n, total)
	local count = n or 1000
	local start_time = vim.uv.hrtime()
	for _ = 0, count do
		fn()
	end
	local time = (vim.uv.hrtime() - start_time) / 1000000 / (total and 1 or count)
	vim.print('The function run with ' .. count .. ' times in ' .. time .. 'ms')
	return time
end

perf(function()
	vim.cmd([[
		setlocal nolist
		setlocal nowrap
		setlocal nonumber
		setlocal norelativenumber
		setlocal signcolumn=no
		setlocal foldcolumn=0
	]])
end)
