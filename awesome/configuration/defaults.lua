local gfs = require("gears.filesystem")
local config_dir = gfs.get_configuration_dir()

return {
	--- default apps
	apps = {
		term = "kitty",
		browser = "firefox",
		editor = "vim",
		launcher = "rofi -show run",
	},
}