local M = {}

M.diagnostic = {
	Error = "󰅙",
	Warn = "",
	Info = "",
	Hint = "",
}

M.vim_log_level = {
	INFO = M.diagnostic.Info,
	WARN = M.diagnostic.Warn,
	ERROR = M.diagnostic.Error,
	DEBUG = M.diagnostic.Hint,
	TRACE = "T",
	OFF = "O",
}

M.icons = {
	modified = "",
	close = "",
	pin = "",
}

return M
