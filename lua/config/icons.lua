local M = {}

M.diagnostic = {
	Error = "",
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

M.kind = {
	Text = "",
	Method = "",
	Function = "󰯼",
	Constructor = "",

	Field = "",
	Variable = "󰰬",
	Property = "",

	Class = "",
	Interface = "",
	Struct = "",
	Module = "",

	Unit = "",
	Value = "",
	Enum = "",
	EnumMember = "",

	Keyword = "",
	Constant = "π",

	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	Event = "",
	Operator = "",
	TypeParameter = "",

	Namespace = "",
	Package = "",
	String = "󰉾",
	Number = "",
	Boolean = "",
	Array = "",
	Object = "",
	Key = "",
	Null = "",
}

return M
