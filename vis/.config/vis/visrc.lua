-- load standard vis module, providing parts of the Lua API, sets _G.vis
require("vis")

require("plugins/vis-lspc")
require("plugins/vis-sneak")
require("plugins/vis-commentary")

local plug = (function()
	if not pcall(require, "plugins/vis-plug") then
		os.execute(
			"git clone --quiet https://github.com/erf/vis-plug "
				.. (os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config")
				.. "/vis/plugins/vis-plug"
		)
	end
	return require("plugins/vis-plug")
end)()

local plugins = {
	{ "milhnl/vis-editorconfig-options" },
	{ "jocap/vis-filetype-settings" },
	{ "milhnl/vis-format" },
	{ "jpaulogg/vis-ins-completion" },
	{ "https://repo.or.cz/vis-quickfix.git" },
	{ "https://repo.or.cz/vis-surround.git" },
}

plug.init(plugins, true)

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	vis:command('set escdelay 0')
	vis:command('set theme ashen')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	vis:command('set tabwidth 4')
	vis:command('set rel')
	vis:command('set ic')
end)

-- Fuzzy search filenames to open files

vis:command_register("skim", function(argv, force, cur_win, selection, range)
	local out = io.popen("sk"):read()
	if out then
		vis:command(string.format(argv[1] .. ' "%s"', out))
		vis:feedkeys("<vis-redraw>")
	end
end, "fuzzy file search")

function str_split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end

  return t
end

vis:command_register("rg", function(argv, force, cur_win, selection, range)
	local out = io.popen("sk --ansi -i -c 'rg --color=always --line-number {q}'"):read()
	local out_split = str_split(out, ":")
	local file_name = out_split[1]
	local line_number = out_split[2]
	
	if out then
		vis:command(string.format(argv[1] .. ' "%s"', file_name))
		vis:feedkeys("<vis-redraw>")
		vis:feedkeys(string.format(':%s<Enter>', line_number))
	end
end, "fuzzy text search")

vis:map(vis.modes.NORMAL, " f", function()
	vis:command("skim e")
end)

vis:map(vis.modes.NORMAL, " /", function()
	vis:command("rg e")
end)

vis:map(vis.modes.NORMAL, "<M-l>", "<vis-window-next>")
vis:map(vis.modes.NORMAL, "<M-h>", "<vis-window-prev>")

local copy = vis:action_register("main_clipboard_yank", function()
	vis:feedkeys('"+y')
end, "Yank selection to system clipboard")

local paste = vis:action_register("main_clipboard_paste", function()
	vis:feedkeys('"+p')
end, "Yank selection to system clipboard")

vis:map(vis.modes.VISUAL, "<C-y>", copy)
vis:map(vis.modes.NORMAL, "<C-p>", paste)
vis:map(vis.modes.VISUAL, "<C-p>", paste)

