local M = {}
M.current_mode = setmetatable({
	['n'] = '<NORMAL>',
	['no'] = 'N·Operator Pending',
	['v'] = '<VISUAL>',
	['V'] = '<VISUAL>',
	['^V'] = '<VISUAL>',
	['s'] = '<SELECT>',
	['S'] = 'S·Line',
	['^S'] = 'S·Block',
	['i'] = '<INSERT>',
	['ic'] = '<INSERT>',
	['ix'] = '<INSERT>',
	['R'] = '<REPLACE>',
	['Rv'] = '<V·Replace>',
	['c'] = '<C>',
	['cv'] = '<Vim Ex>',
	['ce'] = '<Ex>',
	['r'] = 'Prompt',
	['rm'] = 'More',
	['r?'] = 'Confirm',
	['!'] = 'Shell',
	['t'] = 'T',
}, {
	__index = function(_, _)
		return 'V·Block'
	end,
})
return M
