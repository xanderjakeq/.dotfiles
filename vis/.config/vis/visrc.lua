-- load standard vis module, providing parts of the Lua API, sets _G.vis
require("vis")

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
	-- { "erf/vis-sneak" },
	{ "https://gitlab.com/muhq/vis-lspc.git" },
	{ "Nomarian/vis-commentary" },
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
	vis:command('set theme ashen')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	vis:command('set rel')
end)

-- Fuzzy search filenames to open files

vis:command_register("skim", function(argv, force, cur_win, selection, range)
	local out = io.popen("sk"):read()
	if out then
		vis:command(string.format(argv[1] .. ' "%s"', out))
		vis:feedkeys("<vis-redraw>")
	end
end, "fuzzy file search")

vis:map(vis.modes.NORMAL, " f", function()
	vis:command("skim e")
end)
